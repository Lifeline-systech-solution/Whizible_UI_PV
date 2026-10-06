<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Project_health_sheet.aspx.vb" Inherits="Whizible.Project_health_sheet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <!-- Bootstrap 5.3.2 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">

    <style type="text/css">
        html, body {
            height: 100%;
            margin: 0;
            overflow: auto;
            background-color: #ffffff;
        }

        form#form1 {
            min-height: 100%;
            margin: 0;
        }

        .management-dashboard-page {
            background: #ffffff;
            min-height: 100%;
        }

        .management-dashboard-header {
            background: #fff;
            border-bottom: 1px solid #eef2f7;
            box-shadow: rgba(0, 0, 0, 0.06) 0 5px 5px -3px, rgba(0, 0, 0, 0.043) 0 8px 10px 1px, rgba(0, 0, 0, 0.035) 0 3px 14px 2px;
            padding: 1rem 1.25rem;
        }

        .management-dashboard-title {
            align-items: center;
            color: #1e40af;
            display: flex;
            font-size: 18px;
            font-weight: 600;
            gap: 0.75rem;
            margin: 0 0 0.25rem;
        }

        .management-dashboard-title i {
            color: #1e40af;
            font-size: 1.5rem;
        }

        .management-dashboard-subtitle {
            color: #6b7280;
            font-size: 0.72rem;
            margin: 0;
        }

        .management-dashboard-tabs-wrapper {
            background: #fff;
            border-bottom: 1px solid #e0e0e0;
            margin: 0 2px 15px;
            padding: 0 15px;
        }

        .management-dashboard-tabs {
            border-bottom: 0;
            gap: 5px;
            margin-bottom: 0;
            overflow: hidden;
            white-space: normal;
        }

        .management-dashboard-tabs .nav-link {
            align-items: center;
            background: transparent;
            border: 0;
            border-bottom: 2px solid transparent;
            color: #666;
            display: flex;
            font-weight: 400;
            gap: 0.4rem;
            padding: 8px 10px;
        }

        .management-dashboard-tabs .nav-link:hover {
            background: #f8fbff;
            color: #1359a6;
        }

        .management-dashboard-tabs .nav-link.active {
            background: #f0f7ff;
            border-bottom-color: #1359a6;
            color: #1359a6;
        }

        .dashboard-content {
            padding: 0 15px 16px;
        }

        .phs-section-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
            margin-bottom: 14px;
            padding: 14px;
        }

        .phs-section-card p {
            color: #1f2937;
            margin-bottom: 10px;
        }
         /* <!-- Added By Madhuri.K on 24-08-2026 --> */
        .pagination {
    margin-bottom: 6px !important;
}
        .phs-table-toolbar {
            align-items: flex-start;
            display: flex;
            flex-wrap: wrap;
            gap: 10px 16px;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .phs-table-toolbar-text p {
            margin-bottom: 2px;
        }

        .phs-sqert-toolbar,
        .phs-unlocked-toolbar {
            align-items: flex-start;
            flex-direction: column;
            gap: 8px;
        }

        .phs-sqert-title-line {
            align-items: baseline;
            display: flex;
            flex-wrap: nowrap;
            gap: 12px;
            justify-content: space-between;
            width: 100%;
            white-space: nowrap;
        }

        .phs-sqert-title-line strong {
            margin: 0;
        }

        .phs-sqert-slippage-note {
            color: red;
            font-size: 12px;
            font-weight: 500;
            margin-left: auto;
        }

        .phs-project-search {
            align-items: center;
            display: flex;
            gap: 8px;
            min-width: 260px;
        }

        .phs-project-search label {
            color: #374151;
            font-size: 11px;
            font-weight: 600;
            margin: 0;
            white-space: nowrap;
        }

        .phs-project-search .msel {
            min-width: 260px;
            max-width: 360px;
            width: 260px;
            position: relative;
        }

        .phs-project-search .msel-btn {
            width: 100%;
            text-align: left;
            background: #fff;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            padding: 6px 8px;
            font-size: 11.5px;
            cursor: pointer;
            color: #1a2536;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 8px;
            height: 34px;
            white-space: nowrap;
            overflow: hidden;
        }

        .phs-project-search .msel-btn > span:first-child {
            min-width: 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .phs-project-search .msel-btn:hover { border-color: #1359a6; }

        .phs-project-search .msel-btn .count {
            background: #1359a6;
            color: #fff;
            border-radius: 10px;
            font-size: 10px;
            padding: 1px 7px;
            font-weight: 600;
        }

        .phs-project-search .msel-btn .chev {
            color: #6b7280;
            font-size: 10px;
            line-height: 1;
        }

        .phs-project-search .msel-btn .chev i { font-size: 10px; }

        .phs-project-search .msel-panel {
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            min-width: 260px;
            max-height: 260px;
            overflow-y: auto;
            background: #fff;
            border: 1px solid #e3e8ef;
            border-radius: 6px;
            box-shadow: 0 8px 24px rgba(20, 30, 50, .14);
            padding: 8px;
            z-index: 1060;
            display: none;
        }

        .phs-project-search .msel-panel.open { display: block; }

        .phs-project-search .msel-search {
            width: 100%;
            box-sizing: border-box;
            border: 1px solid #e3e8ef;
            border-radius: 4px;
            padding: 6px 8px;
            font-size: 11.5px;
            margin-bottom: 6px;
            position: sticky;
            top: -8px;
            background: #fff;
            z-index: 2;
        }

        .phs-project-search .msel-search:focus {
            outline: none;
            border-color: #1359a6;
        }

        .phs-project-search .msel-empty {
            padding: 10px 8px;
            font-size: 11.5px;
            color: #6b7280;
            text-align: center;
        }

        .phs-project-search .msel-row {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 8px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 11.5px;
            margin: 0;
            font-weight: 400;
        }

        .phs-project-search .msel-row:hover { background: #f1f5f9; }

        .phs-project-search .msel-actions {
            display: flex;
            justify-content: space-between;
            padding: 4px 6px 2px;
            border-top: 1px solid #e3e8ef;
            margin-top: 6px;
        }

        .phs-project-search .msel-actions button {
            background: none;
            border: none;
            color: #1359a6;
            font-size: 11.5px;
            cursor: pointer;
            font-weight: 600;
            padding: 4px;
        }
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        /*Detailpanel - full-page style like MyAlerts.aspx */
        .Resourcedetailpanel {
            border: 0;
        }

        #projectHealthDetailsOffcanvas.offcanvas,
        #projectHealthDetailsOffcanvas.Resourcedetailpanel {
            --bs-offcanvas-width: 85% !important;
            background: #fff !important;
            bottom: 0 !important;
            display: flex !important;
            flex-direction: column !important;
            height: 100vh !important;
            margin: 0 !important;
            max-width: 1200px;
            position: fixed !important;
            right: 0 !important;
            top: 0 !important;
            transform: translateX(100%);
            visibility: hidden;
            width: 85% !important;
            z-index: 1060 !important;
        }

        @media (max-width: 768px) {
            #projectHealthDetailsOffcanvas.offcanvas,
            #projectHealthDetailsOffcanvas.Resourcedetailpanel {
                --bs-offcanvas-width: 95% !important;
                width: 95% !important;
                max-width: none;
            }
        }

        #projectHealthDetailsOffcanvas.offcanvas.show,
        #projectHealthDetailsOffcanvas.offcanvas.phs-offcanvas-open,
        #projectHealthDetailsOffcanvas.showing {
            transform: none !important;
            visibility: visible !important;
        }

        .phs-offcanvas-backdrop {
            background: rgba(0, 0, 0, 0.5);
            bottom: 0;
            left: 0;
            margin: 0 !important;
            position: fixed;
            right: 0;
            top: 0 !important;
            z-index: 1055;
        }

        #projectHealthDetailsOffcanvas .offcanvas-body {
            flex: 1 1 auto;
            height: auto !important;
            max-height: 100vh;
            overflow: auto;
            padding: 0.75rem 1rem 1rem;
            background: #fff;
        }

        #projectHealthDetailsOffcanvas .Edit_Details {
            min-height: 100%;
        }

        #projectHealthDetailsOffcanvas .graybg {
            background: #e7edf0;
            border-radius: 4px;
        }

        #projectHealthDetailsOffcanvas .pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1 !important;
            font-size: 14px;
        }

        #projectHealthDetailsOffcanvas .phs-modern-tab-container {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            padding: 0;
            margin: 0.5rem 0 0;
            overflow: hidden;
        }

        #projectHealthDetailsOffcanvas .modern-tabs {
            border-bottom: none;
            margin: 0;
            padding: 0;
            display: flex;
            flex-wrap: wrap;
            background: white;
            width: 100%;
            overflow: hidden;
        }

        #projectHealthDetailsOffcanvas .phs-modern-tab-container::-webkit-scrollbar,
        #projectHealthDetailsOffcanvas .modern-tabs::-webkit-scrollbar {
            display: none;
            width: 0;
            height: 0;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-item {
            margin-bottom: 0;
            flex-shrink: 0;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-link {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 10px 18px;
            border: none;
            border-radius: 8px 8px 0 0;
            background-color: #ffffff;
            color: #6b7280;
            font-size: 12px;
            font-weight: 500;
            white-space: nowrap;
            transition: all 0.2s ease;
            margin-right: 2px;
            position: relative;
            cursor: pointer;
            min-height: 42px;
            text-decoration: none;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-link i {
            font-size: 11.5px;
            color: #6b7280;
            line-height: 1;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-link:hover {
            background-color: #f9fafb;
            color: #374151;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-link:hover i {
            color: #374151;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-link.active {
            background-color: #dbeafe;
            color: #1e40af;
            font-weight: 600;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.05);
            z-index: 10;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-link.active i {
            color: #1e40af;
        }

        #projectHealthDetailsOffcanvas .modern-tabs .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: #dbeafe;
        }

        #projectHealthDetailsOffcanvas .tab-content {
            padding-top: 12px;
        }

        #projectHealthDetailsOffcanvas .tab-pane {
            padding: 8px 0 16px;
        }

        #projectHealthDetailsOffcanvas .phs-tab-section-title {
            color: #6b9bd1;
            font-size: 13px;
            font-weight: 600;
            margin: 0 0 10px;
        }

        /* Labels lighter than offcanvas header (#4263c1) */
        #projectHealthDetailsOffcanvas .informationtbl tr th,
        #projectHealthDetailsOffcanvas .informationtbl th,
        #projectHealthDetailsOffcanvas label,
        #projectHealthDetailsOffcanvas .form-label {
            color: #6b9bd1 !important;
            font-weight: 500;
        }

        tr.rowhiglight {
            background: #c3dbff;
        }

        /* Project name / detail hyperlinks — always look like clickable links */
        #sqertListTbl a.phs-detail-link,
        a.phs-detail-link,
        a[data-bs-toggle="offcanvas"],
        a[data-bs-toggle="modal"] {
            color: #1359a6 !important;
            text-decoration: underline !important;
            cursor: pointer !important;
            font-weight: 500;
        }

        #sqertListTbl a.phs-detail-link:hover,
        a.phs-detail-link:hover,
        a[data-bs-toggle="offcanvas"]:hover,
        a[data-bs-toggle="modal"]:hover {
            color: #0d47a1 !important;
            text-decoration: underline !important;
        }

        /* Stronger underline while offcanvas/modal is open for that link */
        a.phs-detail-link.phs-link-active,
        a.phs-link-active,
        a[data-bs-toggle="offcanvas"].phs-link-active,
        a[data-bs-toggle="modal"].phs-link-active {
            color: #0b3d91 !important;
            text-decoration: underline !important;
            text-decoration-thickness: 2px !important;
            font-weight: 700;
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

            .DisableContent:hover {
                cursor: no-drop;
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }

        /*New css start here*/
        .ciYellow {
            color: #f4cd0f;
        }

        .ciGreen {
            color: #81cf09;
        }

        .ciRed {
            color: #eb1c24;
        }

        /* Single-table layout (no DataTables scrollY) so header/body columns stay aligned */
        #healthshetprojectList {
            table-layout: fixed !important;
            width: 100% !important;
            margin: 0 !important;
            border-collapse: collapse !important;
        }

        #healthshetprojectList_wrapper {
            width: 100%;
            overflow: visible;
        }

        /* Guard: if any leftover scroll wrappers appear, force full width (no scrollbar gap) */
        #healthshetprojectList_wrapper .dataTables_scroll,
        #healthshetprojectList_wrapper .dataTables_scrollHead,
        #healthshetprojectList_wrapper .dataTables_scrollHeadInner,
        #healthshetprojectList_wrapper .dataTables_scrollHeadInner table,
        #healthshetprojectList_wrapper .dataTables_scrollBody,
        #healthshetprojectList_wrapper .dataTables_scrollBody table {
            width: 100% !important;
        }

        #healthshetprojectList_wrapper .dataTables_scrollBody {
            overflow: visible !important;
            max-height: none !important;
            height: auto !important;
        }

        #healthshetprojectList col.phs-col-name { width: 50%; }
        #healthshetprojectList col.phs-col-start,
        #healthshetprojectList col.phs-col-end { width: 25%; }

        #healthshetprojectList thead th,
        #healthshetprojectList tbody td {
            box-sizing: border-box !important;
            vertical-align: middle !important;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding: 10px 12px !important;
            line-height: 1.4 !important;
            border: 1px solid #dee2e6 !important;
        }

        #healthshetprojectList thead th:nth-child(1),
        #healthshetprojectList tbody td:nth-child(1) {
            text-align: left !important;
        }

        #healthshetprojectList thead th:nth-child(2),
        #healthshetprojectList tbody td:nth-child(2),
        #healthshetprojectList thead th:nth-child(3),
        #healthshetprojectList tbody td:nth-child(3) {
            text-align: center !important;
        }

        .phs-unlocked-projects-card .phs-unlocked-table-wrap {
            width: 100%;
            overflow: visible;
        }

        .phs-unlocked-projects-card #healthshetprojectList_wrapper .row {
            margin: 0;
        }

        #healthshetprojectList_wrapper .dataTables_info,
        #healthshetprojectList_wrapper .dataTables_paginate {
            display: none !important;
        }

        /* Pagination UI same as PM_Bulk_Extension.aspx */
        .phs-footer-row {
            margin: 10px 0 0;
            align-items: center;
        }

        .phs-footer-row .spntotal {
            font-size: 12px;
            font-weight: 600;
            color: #374151;
            white-space: nowrap;
        }

        .phs-footer-row .pagination {
            margin: 0;
        }

        .phs-footer-row .page-link {
            cursor: pointer;
            color: #1359a6;
            border: 1px solid #dee2e6;
            padding: 0.25rem 0.55rem;
            font-size: 12px;
        }

        .phs-footer-row .page-item.disabled .page-link {
            color: #9ca3af;
            pointer-events: none;
            background: #f9fafb;
        }

        #projectHealthDetailsOffcanvas .phs-footer-row {
            padding: 0 2px 6px;
        }

        .informationtbl tr th {
            text-align: right;
            font-weight: 500;
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px;
        }

            .informationtbl td.colan {
                padding: 0px;
            }

        .borderbox {
            padding: 15px 10px 10px;
            border: 1px solid #ddd;
            min-height: 91px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5;
        }
        /*chartbox css start here*/
        #projectHealthDetailsOffcanvas .graphwrapper {
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;
            gap: 12px;
            width: 100%;
        }

        #projectHealthDetailsOffcanvas .graphwrapper .chartbox {
            flex: 0 0 340px;
            width: 340px;
            max-width: 340px;
            margin-bottom: 0;
            float: none;
        }

        #projectHealthDetailsOffcanvas .graphwrapper .chartbox .box {
            height: 100%;
        }

        #projectHealthDetailsOffcanvas .graphwrapper .chartbox .box-body {
            height: 280px;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        #projectHealthDetailsOffcanvas .graphwrapper .chartbox .box-body canvas {
            width: 300px !important;
            height: 240px !important;
            max-width: 300px !important;
            max-height: 240px !important;
        }

        .chartbox {
            position: relative;
            border-radius: 4px;
            background: #fff;
            margin-bottom: 20px
        }

            .chartbox .box-body {
                border: 1px solid #d2d6de;
                box-shadow: 0 1px 1px rgba(0,0,0,0.1);
                padding: 15px
            }

            .chartbox .box-header {
                background: #4263c1;
                color: #fff;
                padding: 10px
            }

                .chartbox .box-header h3 {
                    margin: 0;
                    color: #fff;
                    font-size: 16px
                }

        .bluehighlight {
            background: #0d95d3
        }

        .bluelight {
            background: #87c9eb
        }
        /*chartbox css end here*/


        /*New css end here*/

    
        .management-dashboard-current-page {
            align-items: center;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
            display: flex;
            justify-content: space-between;
            margin: 12px 15px 14px;
            padding: 14px 16px;
        }

        .management-dashboard-current-title {
            align-items: center;
            color: #1e40af;
            display: flex;
            font-size: 16px;
            font-weight: 600;
            gap: 0.65rem;
            margin: 0 0 0.25rem;
        }

        .management-dashboard-current-title i {
            color: #1e40af;
            font-size: 1.2rem;
        }

        .management-dashboard-current-note {
            color: #6b7280;
            font-size: 0.72rem;
            margin: 0;
        }

        .phs-summary-cards {
            display: grid;
            gap: 12px;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            margin: 0 15px 14px;
        }

        .phs-summary-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
            border-top: 3px solid #2563eb;
            min-height: 90px;
            padding: 10px 14px;
            position: relative;
        }

        .phs-summary-card .summary-label {
            color: #7f8ea3;
            display: block;
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 0.03em;
            margin-bottom: 3px;
            padding-right: 18px;
            text-transform: uppercase;
        }

        .phs-summary-card .summary-value {
            color: #111827;
            display: block;
            font-size: 16px;
            font-weight: 700;
            line-height: 1;
            margin-bottom: 5px;
        }

        .phs-summary-card .summary-note {
            color: #7b8797;
            display: block;
            font-size: 10px;
            line-height: 1.25;
             /* <!-- Added By Madhuri.K on 24-08-2026 --> */
            overflow: hidden;
            padding-right: 8px;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .phs-summary-card .summary-note.has-tip {
            cursor: help;
        }

        .phs-summary-card .summary-info-icon {
            background: none;
            border: 0;
            bottom: auto;
            color: #9ca3af;
            cursor: pointer;
            font-size: 12px;
            line-height: 1;
            padding: 0;
            position: absolute;
            right: 10px;
            top: 10px;
        }
 /* <!-- Added By Madhuri.K on 24-08-2026 --> */
        .phs-summary-card .summary-info-icon:hover,
        .phs-summary-card .summary-info-icon:focus {
            color: #4b5563;
            outline: none;
        }

        .phs-summary-tooltip .tooltip-inner {
            max-width: 320px;
            text-align: left;
            font-size: 12px;
            white-space: pre-line;
        }

        .phs-kpi-tip {
            position: absolute;
            z-index: 2200;
            min-width: 220px;
            max-width: 360px;
            border-radius: 6px;
            overflow: hidden;
            display: none;
            box-shadow: 0 8px 20px rgba(20, 30, 50, .2);
            font-size: 12px;
            line-height: 1.35;
        }

        .phs-kpi-tip.open { display: block; }

        .phs-kpi-tip .tip-head {
            background: #1e40af;
            color: #fff;
            font-weight: 700;
            padding: 8px 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            position: relative;
            z-index: 2;
        }

        .phs-kpi-tip .tip-body {
            background: #fff;
            max-height: 220px;
            overflow-y: auto;
            padding: 4px 12px 8px;
        }

        .phs-kpi-tip .tip-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 18px;
            padding: 6px 0;
            border-bottom: 1px solid #f0f2f5;
        }

        .phs-kpi-tip .tip-row:last-child { border-bottom: 0; }

        .phs-kpi-tip .tip-lbl {
            color: #1a2536;
            font-weight: 500;
            white-space: normal;
            word-break: break-word;
            flex: 1 1 auto;
            min-width: 0;
        }

        .phs-kpi-tip .tip-val {
            font-weight: 700;
            color: #2a78d6;
            flex: 0 0 auto;
        }

        .phs-kpi-tip .tip-val.ontrack { color: #2f9e44; }
        .phs-kpi-tip .tip-val.unlocked { color: #d9a324; }

        .phs-kpi-tip .tip-overview {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            min-width: 18px;
        }

        .phs-kpi-tip .circleIndicator {
            font-size: 11px;
        }

        .phs-kpi-tip .tip-empty {
            color: #6b7280;
            padding: 10px 0;
            text-align: center;
        }

        .phs-summary-card.card-blue {
            border-top-color: #2b6cb0;
        }

        .phs-summary-card.card-green {
            border-top-color: #2f9e44;
        }

        .phs-summary-card.card-red {
            border-top-color: #d94841;
        }

        .phs-summary-card.card-yellow {
            border-top-color: #d9a324;
        }

        @media (max-width: 767px) {
            .management-dashboard-current-page {
                align-items: flex-start;
                flex-direction: column;
                gap: 0.75rem;
            }
        }
    
        /* MyProfile-style bootstrap-select */
        .fixed-width-combo {
            width: 250px !important;
        }
        .bootstrap-select.form-control:not([class*="col-"]) {
            width: 100%;
        }
        .fixed-width-combo + .dropdown-toggle {
            width: 250px !important;
            max-width: 100%;
        }

        .fixed-width-combo + .dropdown-toggle,
        .bootstrap-select.fixed-width-combo {
            width: 250px !important;
            max-width: 100%;
        }
        .bootstrap-select .dropdown-menu {
            z-index: 2000;
        }
        .bootstrap-select .dropdown-menu.show {
            display: block;
        }
        .form-inline .bootstrap-select {
            margin-right: 8px;
        }

        /* Page-load loader (same pattern as MyAlerts.aspx) */
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

    </style>

</head>
<body>
    <form id="form1" runat="server">
    <%If m_blnViewAccess = True Then%>
        <div id="PHSPreloader" class="preloader" aria-label="Loading"></div>
        <div class="loader-overlay" id="loaderOverlay" style="display: none;">
            <div class="loader"></div>
        </div>

        <div id="phsPageWrapper" style="display: none;">
        <div class="innerpgiframe management-dashboard-page">
            <div class="management-dashboard-current-page">
                <div>
                    <h3 class="management-dashboard-current-title">
                        <i class="fas fa-heartbeat" data-bs-toggle="tooltip" title="Project Health Sheet"></i>
                        Project Health Sheet
                    </h3>
                    <p class="management-dashboard-current-note">Track SQERT health, project status, milestones, risks, and resource indicators.</p>
                </div>
            </div>
            <div class="phs-summary-cards" id="phsSummaryCards">
                <div class="phs-summary-card card-blue">
                    <span class="summary-label">Total Projects</span>
                    <button type="button" class="summary-info-icon" id="phsTotalInfo" aria-label="Total Projects details">
                        <i class="fas fa-info-circle" aria-hidden="true"></i>
                    </button>
                    <span class="summary-value" id="phsTotalProjects">0</span>
                    <span class="summary-note">Active as of <span id="phsAsOfDate">-</span></span>
                </div>
                <div class="phs-summary-card card-green">
                    <span class="summary-label">On Track</span>
                    <button type="button" class="summary-info-icon" id="phsOnTrackInfo" aria-label="On Track details">
                        <i class="fas fa-info-circle" aria-hidden="true"></i>
                    </button>
                    <span class="summary-value" id="phsOnTrackProjects">0</span>
                    <span class="summary-note" id="phsOnTrackProjectName" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="phs-summary-tooltip" title="">No project found</span>
                </div>
                <div class="phs-summary-card card-red">
                    <span class="summary-label">Needs Attention</span>
                    <button type="button" class="summary-info-icon" id="phsAtRiskInfo" aria-label="Needs Attention details">
                        <i class="fas fa-info-circle" aria-hidden="true"></i>
                    </button>
                    <span class="summary-value" id="phsAtRiskProjects">0</span>
                    <span class="summary-note" id="phsAtRiskNote">Scope / Overview issues</span>
                </div>
                <div class="phs-summary-card card-yellow">
                    <span class="summary-label">Not Locked</span>
                    <button type="button" class="summary-info-icon" id="phsUnlockedInfo" aria-label="Not Locked details">
                        <i class="fas fa-info-circle" aria-hidden="true"></i>
                    </button>
                    <span class="summary-value" id="phsUnlockedProjects">0</span>
                    <span class="summary-note">Projects pending lock</span>
                </div>
            </div>


            <div class="content dashboard-content pt-2">
                <div class="phs-section-card">
                <div class="phs-table-toolbar phs-sqert-toolbar">
                    <div class="phs-sqert-title-line">
                        <strong id="sqertDetailsTitle">SQERT Details till </strong>
                        <span class="phs-sqert-slippage-note">(Activities in Red Indicates Slippage Overdue)</span>
                    </div>
                    <div class="phs-project-search">
                        <label>Project</label>
                        <div id="sqertProjectMselHost"></div>
                    </div>
                </div>
                <table id="sqertListTbl" class="table table-bordered profiencyTbllist" style="width:100%;">
                    <thead>
                        <tr>
                            <th class="text-start">Project Name</th>
                            <th>Reporting Date</th>
                            <th>Scope</th>
                            <th>Quality</th>
                            <th>Effort</th>
                            <th>Risk</th>
                            <th>Time</th>
                            <th>Project Overview</th>
                        </tr>
                    </thead>
                    <tbody id="tblsqert">
                    </tbody>
                </table>
                <div class="row footer-row phs-footer-row" id="phsPagerSqert">
                    <div class="col-sm-6"></div>
                    <div class="col-sm-6 d-flex justify-content-end align-items-center">
                        <span class="spntotal me-3 phs-total-records">Total Records: 0</span>
                        <nav>
                            <ul class="pagination mb-0">
                                <li class="page-item disabled"><a class="page-link phs-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>
                                <li class="page-item disabled"><a class="page-link phs-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="clearfix"></div>
                </div>
                <div class="phs-section-card phs-unlocked-projects-card">
                <div class="phs-table-toolbar phs-unlocked-toolbar">
                    <div class="phs-sqert-title-line">
                        <strong id="unlockedProjectsTitle">List of Projects which were not locked</strong>
                    </div>
                    <div class="phs-project-search">
                        <label>Project</label>
                        <div id="unlockedProjectMselHost"></div>
                    </div>
                </div>

                <div class="phs-unlocked-table-wrap">
                <table id="healthshetprojectList" class="table table-bordered table-striped" style="width:100%;">
                    <colgroup>
                        <col class="phs-col-name" />
                        <col class="phs-col-start" />
                        <col class="phs-col-end" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="text-start">Project Name</th>
                            <th class="text-center">Project Start Date</th>
                            <th class="text-center">Project End Date</th>
                        </tr>
                    </thead>
                    <tbody id="tblAllProjectHealthSheetData">
                    </tbody>
                </table>
                </div>
                <div class="row footer-row phs-footer-row" id="phsPagerUnlocked">
                    <div class="col-sm-6"></div>
                    <div class="col-sm-6 d-flex justify-content-end align-items-center">
                        <span class="spntotal me-3 phs-total-records">Total Records: 0</span>
                        <nav>
                            <ul class="pagination mb-0">
                                <li class="page-item disabled"><a class="page-link phs-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>
                                <li class="page-item disabled"><a class="page-link phs-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                </div>
            </div>

            <div class="offcanvas offcanvas-end Resourcedetailpanel" data-bs-scroll="false" tabindex="-1" id="projectHealthDetailsOffcanvas" aria-labelledby="projectHealthDetailsOffcanvasLabel">
                <div class="offcanvas-body">
                    <div class="Edit_Details">
                        <div class="graybg container-fluid py-1 mb-2">
                            <div class="row align-items-center">
                                <div class="col-sm-10">
                                    <h5 class="pgtitle" id="projectHealthDetailsOffcanvasLabel">Project Health Details</h5>
                                </div>
                                <div class="col-sm-2 text-end">
                                    <button type="button" class="btn-close canceldetailpanel" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Close" aria-label="Close" onclick="$('body').removeClass('offcanvas-open');"></button>
                                </div>
                            </div>
                        </div>

                        <div class="phs-modern-tab-container">
                            <ul class="nav nav-tabs modern-tabs" id="phsDetailTabs" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link active" id="phs-tab-info" data-bs-toggle="tab" href="#PHSInfo" role="tab" aria-controls="PHSInfo" aria-selected="true" data-phs-tab="info">
                                        <i class="fas fa-info-circle"></i><span>PHS Report Info</span>
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="phs-tab-achievement" data-bs-toggle="tab" href="#PHSDetailtabTwo" role="tab" aria-controls="PHSDetailtabTwo" aria-selected="false" data-phs-tab="achievement">
                                        <i class="fas fa-trophy"></i><span>Key Achievements</span>
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="phs-tab-issue" data-bs-toggle="tab" href="#PHSDetailtab3" role="tab" aria-controls="PHSDetailtab3" aria-selected="false" data-phs-tab="issue">
                                        <i class="fas fa-exclamation-circle"></i><span>Issue Details</span>
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="phs-tab-sqert" data-bs-toggle="tab" href="#PHSDetailtab4" role="tab" aria-controls="PHSDetailtab4" aria-selected="false" data-phs-tab="sqert">
                                        <i class="fas fa-heartbeat"></i><span>SQERT</span>
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="phs-tab-milestone" data-bs-toggle="tab" href="#PHSDetailtab5" role="tab" aria-controls="PHSDetailtab5" aria-selected="false" data-phs-tab="milestone">
                                        <i class="fas fa-flag-checkered"></i><span>Milestone</span>
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="phs-tab-resource" data-bs-toggle="tab" href="#PHSDetailtab6" role="tab" aria-controls="PHSDetailtab6" aria-selected="false" data-phs-tab="resource">
                                        <i class="fas fa-users"></i><span>Active Resource</span>
                                    </a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="phs-tab-graph" data-bs-toggle="tab" href="#PHSDetailtab7" role="tab" aria-controls="PHSDetailtab7" aria-selected="false" data-phs-tab="graph">
                                        <i class="fas fa-chart-bar"></i><span>Graph</span>
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <div class="tab-content" id="phsDetailTabContent">
                            <div id="PHSInfo" class="tab-pane fade show active" role="tabpanel" aria-labelledby="phs-tab-info">
                                <table class="informationtbl" id="phsInfo" style="width:100%; text-align:center;">
                                    <tbody>
                                        <tr>
                                            <th>Project</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start" id="phsInfoProject">-</td>
                                            <th>Role</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start" id="phsInfoRole">-</td>
                                        </tr>
                                        <tr>
                                            <th>Business Group</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start" id="phsInfoBusinessGroup">-</td>
                                            <th>From Date</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start" id="phsInfoFromDate">-</td>
                                        </tr>
                                        <tr>
                                            <th>Organization Unit</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start" id="phsInfoOrganizationUnit">-</td>
                                            <th>Workhours Percent</th>
                                            <td class="colan">:</td>
                                            <td class="pr-3 text-start" id="phsInfoWorkhoursPercent">-</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div id="PHSDetailtabTwo" class="tab-pane fade" role="tabpanel" aria-labelledby="phs-tab-achievement">
                                <h5 class="pull-left phs-tab-section-title">Key Achievement in the Reporting Period</h5>
                                <div class="clearfix"></div>
                                <table id="tblKeyAchievement" class="table table-bordered" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th>Task</th>
                                            <th>Total Planned</th>
                                            <th>completed</th>
                                            <th>To be Completed in Next Month reporting Period</th>
                                            <th>Task Slipping</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblkeyachievementbody">
                                    </tbody>
                                </table>
                                <div class="row footer-row phs-footer-row" id="phsPagerAchievement">
                                    <div class="col-sm-6"></div>
                                    <div class="col-sm-6 d-flex justify-content-end align-items-center">
                                        <span class="spntotal me-3 phs-total-records">Total Records: 0</span>
                                        <nav>
                                            <ul class="pagination mb-0">
                                                <li class="page-item disabled"><a class="page-link phs-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>
                                                <li class="page-item disabled"><a class="page-link phs-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>

                            <div id="PHSDetailtab3" class="tab-pane fade" role="tabpanel" aria-labelledby="phs-tab-issue">
                                <table id="tblIssueDetails" class="table table-bordered" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th colspan="5">Issue details</th>
                                            <th colspan="3">Aging Analysis(Only Open Issues)</th>
                                            <th>Shown To Customer</th>
                                            <th>Total Overdue Issues</th>
                                        </tr>
                                        <tr>
                                            <th>Issue Type</th>
                                            <th>Open</th>
                                            <th>Closed</th>
                                            <th>Others</th>
                                            <th>Total</th>
                                            <th>Up To 5 Days</th>
                                            <th>5 To 10 Days</th>
                                            <th>More than 10 Days</th>
                                            <th>&nbsp;</th>
                                            <th>&nbsp;</th>
                                        </tr>
                                    </thead>
                                    <tbody id="issuedetailbody">
                                    </tbody>
                                </table>
                                <div class="row footer-row phs-footer-row" id="phsPagerIssue">
                                    <div class="col-sm-6"></div>
                                    <div class="col-sm-6 d-flex justify-content-end align-items-center">
                                        <span class="spntotal me-3 phs-total-records">Total Records: 0</span>
                                        <nav>
                                            <ul class="pagination mb-0">
                                                <li class="page-item disabled"><a class="page-link phs-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>
                                                <li class="page-item disabled"><a class="page-link phs-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>

                            <div id="PHSDetailtab4" class="tab-pane fade" role="tabpanel" aria-labelledby="phs-tab-sqert">
                                <table class="table table-bordered" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th width="100">Title</th>
                                            <th width="100">Value</th>
                                            <th width="100">Rating</th>
                                            <th width="100">Trend</th>
                                            <th class="text-start">Description</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblSQERTSection">
                                    </tbody>
                                </table>
                            </div>

                            <div id="PHSDetailtab5" class="tab-pane fade" role="tabpanel" aria-labelledby="phs-tab-milestone">
                                <table id="tblMilestoneDetails" class="table table-bordered" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th>Milestone Name</th>
                                            <th>Ready For Billing</th>
                                            <th>Amount</th>
                                            <th>planned Start Date</th>
                                            <th>planned Completion Date</th>
                                            <th>Actual Start Date</th>
                                            <th>Actual End Date</th>
                                            <th>Slippage(In Days)</th>
                                            <th>Milestone Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="MileStoneBinding">
                                    </tbody>
                                </table>
                                <div class="row footer-row phs-footer-row" id="phsPagerMilestone">
                                    <div class="col-sm-6"></div>
                                    <div class="col-sm-6 d-flex justify-content-end align-items-center">
                                        <span class="spntotal me-3 phs-total-records">Total Records: 0</span>
                                        <nav>
                                            <ul class="pagination mb-0">
                                                <li class="page-item disabled"><a class="page-link phs-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>
                                                <li class="page-item disabled"><a class="page-link phs-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>

                            <div id="PHSDetailtab6" class="tab-pane fade" role="tabpanel" aria-labelledby="phs-tab-resource">
                                <table id="tblActiveResourceList" class="table table-bordered" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th width="400">Resource</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Work(Hrs)</th>
                                            <th>Actual work(hrs)</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblActiveResource">
                                    </tbody>
                                </table>
                                <div class="row footer-row phs-footer-row" id="phsPagerResource">
                                    <div class="col-sm-6"></div>
                                    <div class="col-sm-6 d-flex justify-content-end align-items-center">
                                        <span class="spntotal me-3 phs-total-records">Total Records: 0</span>
                                        <nav>
                                            <ul class="pagination mb-0">
                                                <li class="page-item disabled"><a class="page-link phs-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>
                                                <li class="page-item disabled"><a class="page-link phs-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>

                            <div id="PHSDetailtab7" class="tab-pane fade" role="tabpanel" aria-labelledby="phs-tab-graph">
                                <div class="graphwrapper">
                                    <div class="chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3>Total Tasks V/s Completion Status</h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="CompletionstatusGraph" width="300" height="240"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3>Total Tasks V/s Delay in Days(By Project)</h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="DelayinDayschart" width="300" height="240"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3>Monthly Resource Cost</h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="MonthlyResourceCostChart" width="300" height="240"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>

        </div>
        </div>

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 3.7.1 -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <!-- Bootstrap 5.3.2 -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!-- bootstrap-select (after Bootstrap) -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script>
        function initDashboardSelectPicker() {
            if (!$.fn.selectpicker) return;
            $('select').each(function () {
                var $select = $(this);
                if ($select.data('selectpicker')) {
                    try { $select.selectpicker('refresh'); } catch (e) { }
                    return;
                }
                $select.addClass('selectpicker form-control fixed-width-combo');
                $select.attr('data-live-search', 'true');
                $select.selectpicker({
                    liveSearch: true,
                    container: 'body',
                    dropupAuto: true,
                    width: '100%'
                });
            });
        }

        $(document).ready(function () {
            initDashboardSelectPicker();
            if ($.fn.tooltip) {
                $('#projectHealthDetailsOffcanvas [data-bs-toggle="tooltip"]').tooltip({ container: 'body' });
            }
        });

    </script>
    <!-- Bootstrap 5.3.2 -->
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>

    <script>

        var phsLoaderShown = false;
        var phsLoaderStartTime = 0;

        function showPhsLoader() {
            var el = document.getElementById('loaderOverlay');
            if (el) {
                el.style.display = 'block';
                phsLoaderShown = true;
                phsLoaderStartTime = Date.now();
            }
        }

        function hidePhsLoader() {
            if (!phsLoaderShown) return;
            var elapsedTime = Date.now() - phsLoaderStartTime;
            var minDisplayTime = 800;
            var el = document.getElementById('loaderOverlay');
            if (!el) return;
            if (elapsedTime < minDisplayTime) {
                setTimeout(function () {
                    el.style.display = 'none';
                    phsLoaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                el.style.display = 'none';
                phsLoaderShown = false;
            }
        }

        function hidePhsPreloader() {
            $('#PHSPreloader').hide();
            $('#loaderOverlay').hide();
            $('#phsPageWrapper').show();
        }

        // Safety: never leave user stuck on loader if script fails later
        setTimeout(function () {
            if ($('#phsPageWrapper').is(':hidden')) {
                hidePhsPreloader();
            }
        }, 3000);

        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function forceShowProjectHealthDetails(detailOffcanvas) {
            var $panel = $(detailOffcanvas);
            // Keep panel under body so parent overflow/transform cannot clip it
            if ($panel.parent()[0] !== document.body) {
                $panel.appendTo(document.body);
            }

            $panel.addClass('show phs-offcanvas-open').css({
                display: 'flex',
                visibility: 'visible',
                transform: 'none',
                position: 'fixed',
                top: '0',
                right: '0',
                bottom: '0',
                height: '100vh',
                zIndex: 1060
            }).attr('aria-modal', 'true').attr('role', 'dialog');

            $('.offcanvas-backdrop').remove();
            if (!$('.phs-offcanvas-backdrop').length) {
                $('body').append('<div class="phs-offcanvas-backdrop"></div>');
            }

            $('body').addClass('offcanvas-open').css('overflow', 'hidden');

            if ($.fn.tooltip) {
                $panel.find('[data-bs-toggle="tooltip"]').tooltip('dispose').tooltip({ container: 'body' });
            }
        }

        function closeProjectHealthDetails() {
            var $panel = $('#projectHealthDetailsOffcanvas');
            if (window.bootstrap && bootstrap.Offcanvas) {
                var inst = bootstrap.Offcanvas.getInstance($panel[0]);
                if (inst) {
                    try { inst.hide(); } catch (e) { }
                }
            }

            $panel.removeClass('show phs-offcanvas-open showing').css({
                display: '',
                visibility: '',
                transform: '',
                position: '',
                top: '',
                right: '',
                bottom: '',
                height: '',
                zIndex: ''
            }).removeAttr('aria-modal').removeAttr('role');

            $('.phs-offcanvas-backdrop, .offcanvas-backdrop').remove();
            $('body').removeClass('offcanvas-open').css('overflow', '');
            $('table tr').removeClass('rowhiglight');
            $('a.phs-link-active, a.phs-detail-link.phs-link-active').removeClass('phs-link-active');
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
        }

        function editPHSDetail(e) {
            if (e) {
                e.preventDefault();
            }

            var detailOffcanvas = document.getElementById('projectHealthDetailsOffcanvas');
            if (!detailOffcanvas) {
                return;
            }

            // Manual show is more reliable inside iframe/dashboard pages
            forceShowProjectHealthDetails(detailOffcanvas);
        }
        function markActiveDetailLink(linkEl) {
            $('a.phs-link-active').removeClass('phs-link-active');
            $('table tr').removeClass('rowhiglight');
            if (!linkEl) return;
            var $link = $(linkEl);
            $link.addClass('phs-link-active');
            $link.closest('tr').addClass('rowhiglight');
        }

        $(document).on('click', 'a.phs-detail-link, a[data-bs-toggle="offcanvas"], a[data-bs-toggle="modal"]', function () {
            markActiveDetailLink(this);
        });

        $(document).on('hidden.bs.modal', '.modal', function () {
            $('a.phs-link-active').removeClass('phs-link-active');
            $('table tr').removeClass('rowhiglight');
        });

        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
            if ($(this).is('a')) {
                markActiveDetailLink(this);
            }
        });


        $('#projectHealthDetailsOffcanvas').on('hidden.bs.offcanvas', function () {
            closeProjectHealthDetails();
        });

        $('.canceldetailpanel').on('click', function () {
            closeProjectHealthDetails();
        });

        $(document).on('click', '.phs-offcanvas-backdrop', function () {
            closeProjectHealthDetails();
        });


        // Keep unlocked projects as a plain HTML table (server-side pager like PM_Bulk_Extension)
        function destroyUnlockedProjectsDataTable() {
            var $table = $('#healthshetprojectList');
            if (!$table.length) {
                $table = $('.phs-unlocked-table-wrap table').first();
                if ($table.length) $table.attr('id', 'healthshetprojectList');
            }
            if (!$table.length) return $();

            if ($.fn.DataTable && $.fn.DataTable.isDataTable($table)) {
                $table.DataTable().destroy(false);
            }

            $table = $('#healthshetprojectList');
            var $scroll = $table.closest('.dataTables_scroll');
            if ($scroll.length) {
                var $host = $scroll.parent();
                $scroll.before($table);
                $scroll.remove();
                if ($host.hasClass('dataTables_wrapper')) {
                    $host.replaceWith($table);
                }
            }

            var $orphanWrapper = $('.phs-unlocked-table-wrap .dataTables_wrapper');
            if ($orphanWrapper.length && !$orphanWrapper.find('#healthshetprojectList').length) {
                $orphanWrapper.remove();
            }

            $table = $('#healthshetprojectList');
            if ($table.length && !$table.closest('.phs-unlocked-table-wrap').length) {
                $('.phs-unlocked-table-wrap').append($table);
            }

            $table = $('#healthshetprojectList');
            $table.removeAttr('style').css('width', '100%');
            return $table;
        }

        function initUnlockedProjectsDataTable() {
            // No DataTables paging — use custom Bulk Extension-style pager only
            destroyUnlockedProjectsDataTable();
        }

    </script>

    <script type="text/javascript">
        window.PHS_API_BASE = '<%= System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard") %>';
        window.PHS_TAG_ID = 3068;
        window.PHS_USER_ID = '<%= Session("intUserID") %>';
        window.PHS_LOGIN_TYPE = '<%= Session("LoginType") %>';
        window.PHS_PROJECT_ID = '<%= Session("intProjectID") %>';
    </script>
    <script type="text/javascript">
/* Project Health Sheet - section-wise API bindings for /api/ProjectHealthDashboard/* */
(function () {
    var strUrl = window.PHS_API_BASE || '';
    if (strUrl && strUrl.endsWith('/')) strUrl = strUrl.slice(0, -1);

    var PageTagID = window.PHS_TAG_ID || 3068;
    var UserID = parseInt(window.PHS_USER_ID, 10) || 0;
    var LoginType = window.PHS_LOGIN_TYPE || '';
    var EmployeeID = UserID || null;
    var CreatedBy = UserID;
    var selectedProjectID = parseInt(window.PHS_PROJECT_ID, 10) || 0;
    var reportingDate = '';
    var phsWhereClause = '';
    var phsEditFilterID = 0;
    var phsGlobalFilterName = '';
    var sqertRanges = {};
    var chartCompletion = null;
    var chartDelay = null;
    var chartCost = null;
    var detailsProjectId = 0;
    var phsTabLoaded = {};

    // Pager State — page size 5 across Project Health Sheet (same UI as PM_Bulk_Extension)
    var pagerState = {
        sqert: { page: 1, size: 5 },
        unlocked: { page: 1, size: 5 },
        achievement: { page: 1, size: 5 },
        issue: { page: 1, size: 5 },
        milestone: { page: 1, size: 5 },
        resource: { page: 1, size: 5 }
    };

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
            if (String(strEncryptedString).substring(0, 1) === '-') {
                strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1);
            }
        }
        return strEncryptedString;
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

    function unwrapPayload(json) {
        if (!json) return {};
        var d = json.data != null ? json.data : (json.Data != null ? json.Data : json);
        if (d && typeof d === 'object' && !Array.isArray(d) && (d.data != null || d.Data != null) &&
            typeof (d.data || d.Data) === 'object') {
            return d.data != null ? d.data : d.Data;
        }
        return d || {};
    }

    function extractList(data, preferredNames) {
        if (!data) return [];
        if (Array.isArray(data)) return data;
        var names = preferredNames || [];
        var i;
        for (i = 0; i < names.length; i++) {
            var v = apiVal(data, names[i]);
            if (Array.isArray(v)) return v;
        }
        var keys = Object.keys(data);
        for (i = 0; i < keys.length; i++) {
            if (Array.isArray(data[keys[i]])) return data[keys[i]];
        }
        return [];
    }

    // Safely parse paginated response { totalRecords: X, data: [...] }
    // Supports: ResponseEntity { data: { totalRecords, data: [] } } and flat { totalRecords, data: [] }
    function getPaginatedData(json, defaultKey) {
        var raw = unwrapPayload(json);
        if (raw && typeof raw === 'object' && !Array.isArray(raw) &&
            (Array.isArray(raw.data) || Array.isArray(raw.Data))) {
            var nestedList = Array.isArray(raw.data) ? raw.data : raw.Data;
            var nestedTotal = apiVal(raw, 'totalRecords', 'TotalRecords', 'TotalCount', 'RecordCount', 'total');
            if (nestedTotal == null && nestedList.length > 0) {
                nestedTotal = apiVal(nestedList[0], 'totalRecords', 'TotalRecords', 'TotalCount') || nestedList.length;
            }
            return { list: nestedList, total: toInt(nestedTotal, nestedList.length) };
        }

        var arr = extractList(raw, [defaultKey, 'data']);
        var total = apiVal(raw, 'totalRecords', 'TotalRecords', 'TotalCount', 'RecordCount', 'total');
        if (total == null && arr.length > 0) total = apiVal(arr[0], 'totalRecords', 'TotalRecords', 'TotalCount') || arr.length;
        return { list: arr, total: toInt(total, 0) };
    }

    function toInt(v, fallback) {
        var n = parseInt(v, 10);
        return isNaN(n) ? (fallback == null ? 0 : fallback) : n;
    }

    function dash(v) {
        return (v == null || v === '') ? '-' : v;
    }

    function esc(v) {
        return $('<div/>').text(v == null ? '' : String(v)).html();
    }

    function refreshSelect($el) {
        if (!$el || !$el.length || !$.fn.selectpicker) return;
        if ($el.data('selectpicker')) $el.selectpicker('refresh');
        else $el.selectpicker({ liveSearch: true, container: 'body', dropupAuto: true, width: '100%' });
    }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
    var phsTableProjects = [];
    var phsSqertSelectedIds = [];
    var phsUnlockedSelectedIds = [];
    var phsMselState = {
        sqert: { open: false, search: '', scroll: 0 },
        unlocked: { open: false, search: '', scroll: 0 }
    };

    function getPhsSelectedList(kind) {
        return kind === 'unlocked' ? phsUnlockedSelectedIds : phsSqertSelectedIds;
    }

    function setPhsSelectedList(kind, ids) {
        if (kind === 'unlocked') phsUnlockedSelectedIds = ids;
        else phsSqertSelectedIds = ids;
    }

    function prunePhsSelected(kind) {
        var available = {};
        phsTableProjects.forEach(function (p) { available[String(p.id)] = true; });
        setPhsSelectedList(kind, getPhsSelectedList(kind).filter(function (id) { return available[String(id)]; }));
    }

    function fillPhsTableProjectSelects(rows) {
        phsTableProjects = [];
        (rows || []).forEach(function (r) {
            var id = apiVal(r, 'ProjectID', 'projectID', 'id');
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'ProjectName', 'projectName', 'name') || id;
            phsTableProjects.push({ id: String(id), name: String(name) });
        });
        prunePhsSelected('sqert');
        prunePhsSelected('unlocked');
        renderPhsProjectMsel('sqert');
        renderPhsProjectMsel('unlocked');
    }

    function getSqertSelectedProjectIds() {
        return phsSqertSelectedIds.slice();
    }

    function getUnlockedSelectedProjectIds() {
        return phsUnlockedSelectedIds.slice();
    }

    function filterRowsBySelectedProjects(list, selectedIds) {
        if (!selectedIds || !selectedIds.length) return list || [];
        var idSet = {};
        (selectedIds || []).forEach(function (id) { idSet[String(id)] = true; });
        var nameSet = {};
        phsTableProjects.forEach(function (p) {
            if (idSet[String(p.id)]) nameSet[String(p.name).toLowerCase()] = true;
        });
        return (list || []).filter(function (obj) {
            var name = apiVal(obj, 'ProjectName', 'projectName') || '';
            if (String(name).toUpperCase() === 'OVERVIEW') return false;
            var pid = String(apiVal(obj, 'ProjectID', 'projectID', 'id') || '');
            if (pid && idSet[pid]) return true;
            return !!(name && nameSet[String(name).toLowerCase()]);
        });
    }

    function paginateClientList(list, pager) {
        var rows = list || [];
        var total = rows.length;
        var size = Math.max(toInt(pager.size, 5), 1);
        var pages = Math.max(Math.ceil(total / size) || 1, 1);
        if (toInt(pager.page, 1) > pages) pager.page = pages;
        if (toInt(pager.page, 1) < 1) pager.page = 1;
        var start = (pager.page - 1) * size;
        return { list: rows.slice(start, start + size), total: total };
    }

    function closePhsProjectMsels(exceptKind) {
        ['sqert', 'unlocked'].forEach(function (kind) {
            if (kind === exceptKind) return;
            phsMselState[kind].open = false;
            var hostId = kind === 'unlocked' ? 'unlockedProjectMselHost' : 'sqertProjectMselHost';
            var panel = document.querySelector('#' + hostId + ' .msel-panel');
            if (panel) panel.classList.remove('open');
        });
    }

    function renderPhsProjectMsel(kind) {
        var hostId = kind === 'unlocked' ? 'unlockedProjectMselHost' : 'sqertProjectMselHost';
        var host = document.getElementById(hostId);
        if (!host) return;
        var state = phsMselState[kind];
        var selected = getPhsSelectedList(kind);
        var selectedSet = {};
        selected.forEach(function (id) { selectedSet[String(id)] = true; });

        host.innerHTML = '';
        var msel = document.createElement('div');
        msel.className = 'msel';

        var btn = document.createElement('button');
        btn.className = 'msel-btn';
        btn.type = 'button';
        var btnLabel = 'Select Project';
        if (selected.length === 1) {
            var only = phsTableProjects.filter(function (p) { return String(p.id) === String(selected[0]); })[0];
            btnLabel = only ? only.name : 'Select Project';
        } else if (selected.length > 1) {
            btnLabel = 'Selected';
        }
        btn.innerHTML = '<span>' + esc(btnLabel) + '</span>' +
            (selected.length > 1
                ? '<span class="count">' + selected.length + '</span>'
                : '<span class="chev"><i class="fas fa-chevron-down"></i></span>');

        var panel = document.createElement('div');
        panel.className = 'msel-panel' + (state.open ? ' open' : '');
        panel.addEventListener('click', function (e) { e.stopPropagation(); });
        panel.addEventListener('scroll', function () { state.scroll = panel.scrollTop; });

        var searchInput = document.createElement('input');
        searchInput.type = 'text';
        searchInput.className = 'msel-search';
        searchInput.placeholder = 'Search Project...';
        searchInput.value = state.search || '';
        panel.appendChild(searchInput);

        var rowsWrap = document.createElement('div');
        panel.appendChild(rowsWrap);

        var emptyMsg = document.createElement('div');
        emptyMsg.className = 'msel-empty';
        emptyMsg.textContent = 'No matches';
        emptyMsg.style.display = 'none';
        panel.appendChild(emptyMsg);

        function applySearchFilter() {
            var term = searchInput.value.trim().toLowerCase();
            var anyVisible = false;
            rowsWrap.querySelectorAll('.msel-row').forEach(function (row) {
                var match = !term || (row.getAttribute('data-label') || '').indexOf(term) > -1;
                row.style.display = match ? '' : 'none';
                if (match) anyVisible = true;
            });
            emptyMsg.style.display = anyVisible ? 'none' : 'block';
        }

        searchInput.addEventListener('input', function () {
            state.search = searchInput.value;
            applySearchFilter();
        });

        phsTableProjects.forEach(function (opt) {
            var row = document.createElement('label');
            row.className = 'msel-row';
            row.setAttribute('data-label', String(opt.name).toLowerCase());
            var cb = document.createElement('input');
            cb.type = 'checkbox';
            cb.checked = !!selectedSet[String(opt.id)];
            cb.addEventListener('change', function () {
                state.scroll = panel.scrollTop;
                var next = getPhsSelectedList(kind).slice();
                var id = String(opt.id);
                var idx = next.indexOf(id);
                if (cb.checked) {
                    if (idx < 0) next.push(id);
                } else if (idx >= 0) {
                    next.splice(idx, 1);
                }
                setPhsSelectedList(kind, next);
                state.open = true;
                renderPhsProjectMsel(kind);
                if (kind === 'unlocked') {
                    pagerState.unlocked.page = 1;
                    loadProjectsPendingLock();
                } else {
                    pagerState.sqert.page = 1;
                    loadSQERTList();
                }
            });
            row.appendChild(cb);
            var txt = document.createElement('span');
            txt.textContent = opt.name;
            row.appendChild(txt);
            row.addEventListener('click', function (e) {
                if (e.target !== cb) {
                    cb.checked = !cb.checked;
                    cb.dispatchEvent(new Event('change'));
                }
            });
            rowsWrap.appendChild(row);
        });
        applySearchFilter();

        var actions = document.createElement('div');
        actions.className = 'msel-actions';
        var clearOne = document.createElement('button');
        clearOne.type = 'button';
        clearOne.textContent = 'Clear';
        clearOne.addEventListener('click', function () {
            setPhsSelectedList(kind, []);
            state.search = '';
            state.open = true;
            renderPhsProjectMsel(kind);
            if (kind === 'unlocked') {
                pagerState.unlocked.page = 1;
                loadProjectsPendingLock();
            } else {
                pagerState.sqert.page = 1;
                loadSQERTList();
            }
        });
        var closeOne = document.createElement('button');
        closeOne.type = 'button';
        closeOne.textContent = 'Close';
        closeOne.addEventListener('click', function () {
            state.open = false;
            panel.classList.remove('open');
        });
        actions.appendChild(clearOne);
        actions.appendChild(closeOne);
        panel.appendChild(actions);

        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            if (state.open) {
                state.open = false;
                panel.classList.remove('open');
            } else {
                closePhsProjectMsels(kind);
                state.open = true;
                panel.classList.add('open');
                searchInput.focus();
            }
        });

        msel.appendChild(btn);
        msel.appendChild(panel);
        host.appendChild(msel);

        if (state.open && state.scroll) {
            requestAnimationFrame(function () { panel.scrollTop = state.scroll; });
        }
    }

    function fillSelect($el, rows, idKeys, nameKeys, placeholder) {
        var html = '<option value="0">' + esc(placeholder) + '</option>';
        (rows || []).forEach(function (r) {
            var id = apiVal.apply(null, [r].concat(idKeys));
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal.apply(null, [r].concat(nameKeys)) || id;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
        });
        $el.html(html);
        refreshSelect($el);
    }

    function ajaxPost(path, payload) {
        return $.ajax({
            url: encodeURI(strUrl) + path,
            type: 'POST',
            data: JSON.stringify(payload || {}),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || ''));
                if (payload) {
                    xhr.setRequestHeader('Params', encryptString(JSON.stringify(payload)));
                }
            }
        });
    }

    function getSelectedProjectId() {
        return toInt($('#txtPHSFilterProjectName').val() || $('#CboProject').val() || selectedProjectID);
    }

    function getReportingDate() {
        var dt = ($('#txtPHSFilterReportingDate').val() || reportingDate || '').trim();
        if (!dt && typeof formatToday === 'function') dt = formatToday();
        if (!dt) {
            var d = new Date();
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            dt = ('0' + d.getDate()).slice(-2) + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
        }
        reportingDate = dt;
        return dt;
    }

    function getMasterFilterPayload() {
        return {
            PracticeID: toInt($('#txtPHSFilterProjectType').val()) || null,
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            OrganizationUnitID: toInt($('#txtPHSFilterLocation').val()) || null,
            ProjectGroupID: toInt($('#txtPHSFilterProjectGroupName').val()) || 0,
            UserID: UserID,
            LoginType: LoginType
        };
    }

    function getKpiFilterPayload() {
        return {
            PracticeID: toInt($('#txtPHSFilterProjectType').val()) || null,
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            OrganizationUnitID: toInt($('#txtPHSFilterLocation').val()) || null,
            ProjectGroupID: toInt($('#txtPHSFilterProjectGroupName').val()) || null,
            ReportingDate: getReportingDate() || null,
            UserID: UserID,
            LoginType: LoginType
        };
    }

    function buildPHSWhereClause() {
        var parts = [];
        function add(name, val) {
            if (val && String(val) !== '0') parts.push(name + ' = ' + val);
        }
        add('PracticeID', $('#txtPHSFilterProjectType').val());
        add('BusinessGroupID', $('#txtPHSFilterBusinessGroup').val());
        add('OrganizationUnitID', $('#txtPHSFilterLocation').val());
        add('ProjectGroupID', $('#txtPHSFilterProjectGroupName').val());
        add('ProjectID', $('#txtPHSFilterProjectName').val());
        var dt = getReportingDate();
        if (dt) parts.push("ReportingDate = ''" + dt.replace(/'/g, "''") + "''");
        return parts.join(' AND ');
    }

    function sqertColorClass(metric, value) {
        if (value == null || value === '') return '';
        var s = String(value).toLowerCase();
        if (s.indexOf('red') >= 0 || s === 'olred' || s === 'cired') return 'ciRed';
        if (s.indexOf('yellow') >= 0 || s === 'olyellow' || s === 'ciyellow') return 'ciYellow';
        if (s.indexOf('green') >= 0 || s === 'olgreen' || s === 'cigreen') return 'ciGreen';
        var n = parseFloat(value);
        if (isNaN(n)) return '';
        var r = sqertRanges[metric] || sqertRanges[metric.toLowerCase()] || {};
        if (r.lowerLow != null && n >= r.lowerLow && n <= r.lowerHigh) return 'ciGreen';
        if (r.middleLow != null && n >= r.middleLow && n <= r.middleHigh) return 'ciYellow';
        if (r.upperLow != null && n >= r.upperLow && n <= r.upperHigh) return 'ciRed';
        if (n < 0) return 'ciRed';
        if (n === 0) return 'ciYellow';
        return 'ciGreen';
    }

    function sqertDot(metric, value) {
        var cls = sqertColorClass(metric, value);
        if (!cls) return '&nbsp;';
        return '<i class="fas fa-circle circleIndicator ' + cls + '"></i>';
    }

    function emptyRow(colspan, message) {
        return '<tr><td class="text-center" colspan="' + colspan + '">' + (message || 'No data available in table') + '</td></tr>';
    }

    // Dedicated Bulk Extension–style footers for detail tabs
    var phsPagerMap = {
        sqertListTbl: '#phsPagerSqert',
        healthshetprojectList: '#phsPagerUnlocked',
        tblKeyAchievement: '#phsPagerAchievement',
        tblIssueDetails: '#phsPagerIssue',
        tblMilestoneDetails: '#phsPagerMilestone',
        tblActiveResourceList: '#phsPagerResource'
    };

    // Pagination UI matching PM_Bulk_Extension.aspx (Total Records + Prev/Next icons)
    function renderCustomPager($table, stateObj, totalRecords, fetchFn) {
        if (!$table || !$table.length) return;
        if ($table.is('tbody')) $table = $table.closest('table');
        if (!$table.length) return;

        var total = toInt(totalRecords, 0);
        var pageSize = toInt(stateObj.size, 5) || 5;
        var totalPages = total > 0 ? Math.ceil(total / pageSize) : 1;
        if (stateObj.page < 1) stateObj.page = 1;
        if (stateObj.page > totalPages) stateObj.page = totalPages;

        var prevDisabled = stateObj.page <= 1;
        var nextDisabled = stateObj.page >= totalPages || total <= 0;
        var tableId = $table.attr('id') || '';
        var $pager = tableId && phsPagerMap[tableId] ? $(phsPagerMap[tableId]) : $();

        // Fall back: create/replace dynamic footer under table (SQERT / Unlocked lists)
        if (!$pager.length) {
            var $anchor = $table;
            if ($table.parent().hasClass('table-responsive') || $table.parent().hasClass('phs-unlocked-table-wrap')) {
                $anchor = $table.parent();
            }
            $anchor.next('.phs-footer-row').remove();
            $table.closest('.tab-pane, .phs-section-card').find('> .phs-footer-row').filter(function () {
                return $(this).data('phs-pager-for') === tableId;
            }).remove();

            var html = '';
            html += '<div class="row footer-row phs-footer-row" data-phs-pager-for="' + esc(tableId || 'phsTbl') + '">';
            html += '  <div class="col-sm-6"></div>';
            html += '  <div class="col-sm-6 d-flex justify-content-end align-items-center">';
            html += '    <span class="spntotal me-3 phs-total-records">Total Records: 0</span>';
            html += '    <nav aria-label="Pagination">';
            html += '      <ul class="pagination mb-0">';
            html += '        <li class="page-item disabled"><a class="page-link phs-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>';
            html += '        <li class="page-item disabled"><a class="page-link phs-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>';
            html += '      </ul>';
            html += '    </nav>';
            html += '  </div>';
            html += '</div>';
            $pager = $(html);
            $anchor.after($pager);
        }

        $pager.find('.phs-total-records, .spntotal').first().text('Total Records: ' + total);
        $pager.find('.phs-page-prev').closest('.page-item').toggleClass('disabled', prevDisabled);
        $pager.find('.phs-page-next').closest('.page-item').toggleClass('disabled', nextDisabled);

        $pager.find('.phs-page-prev').off('click.phsPager').on('click.phsPager', function (e) {
            e.preventDefault();
            if ($(this).closest('.page-item').hasClass('disabled')) return;
            if (stateObj.page > 1) {
                stateObj.page -= 1;
                if (typeof fetchFn === 'function') fetchFn();
            }
        });
        $pager.find('.phs-page-next').off('click.phsPager').on('click.phsPager', function (e) {
            e.preventDefault();
            if ($(this).closest('.page-item').hasClass('disabled')) return;
            if (stateObj.page < totalPages) {
                stateObj.page += 1;
                if (typeof fetchFn === 'function') fetchFn();
            }
        });
    }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
    /* ---------- KPI Summary ---------- */
    function initPhsSummaryTooltips() {
        $('#phsSummaryCards [data-bs-toggle="tooltip"]').not('#phsTotalInfo').each(function () {
            if (window.bootstrap && bootstrap.Tooltip) {
                if (!bootstrap.Tooltip.getInstance(this)) {
                    new bootstrap.Tooltip(this, { container: 'body', placement: 'top', customClass: 'phs-summary-tooltip' });
                }
            } else if ($.fn.tooltip) {
                $(this).tooltip({ container: 'body', placement: 'top' });
            }
        });
        bindPhsKpiTips();
    }

    var phsKpiActiveProjects = [];
    var phsOnTrackTipNames = [];
    var phsNeedsAttentionRows = [];
    var phsNeedsAttentionFromKpi = false;
    var phsNeedsAttentionCount = 0;
    var phsUnlockedTipRows = [];
    var phsUnlockedCount = 0;
    var phsKpiTipHideTimer = null;
    var phsKpiTipKind = 'total';

    function collectActiveProjectRows(data) {
        var rows = [];
        if (!data) return rows;
        var keys = ['ActiveProjectList', 'ActiveProjectNames', 'TotalProjectNames', 'ActiveProjectName'];
        var list = null;
        var i;
        for (i = 0; i < keys.length; i++) {
            var v = apiVal(data, keys[i]);
            if (Array.isArray(v)) { list = v; break; }
            if (typeof v === 'string' && v && isNaN(Number(v))) { list = splitOnTrackProjectNames(v, 99); break; }
        }
        if (!list) return rows;
        list.forEach(function (item) {
            if (item == null || typeof item === 'number') return;
            var n = typeof item === 'string' ? item : (apiVal(item, 'ProjectName', 'projectName', 'Name', 'name') || '');
            if (!n || String(n).toUpperCase() === 'OVERVIEW') return;
            var status = typeof item === 'object'
                ? (apiVal(item, 'Status', 'status', 'ProjectStatus') || 'Active')
                : 'Active';
            rows.push({ name: String(n).trim(), status: String(status) });
        });
        return rows;
    }

    function collectUnlockedProjectRows(data) {
        var rows = [];
        if (!data) return rows;
        var keys = ['UnlockedProjectList', 'UnlockedProjectNames', 'NotLockedProjectNames', 'PendingLockProjects', 'UnlockedProjectName'];
        var list = null;
        var i;
        for (i = 0; i < keys.length; i++) {
            var v = apiVal(data, keys[i]);
            if (Array.isArray(v)) { list = v; break; }
            if (typeof v === 'string' && v && isNaN(Number(v))) { list = splitOnTrackProjectNames(v, 99); break; }
        }
        if (!list) return rows;
        list.forEach(function (item) {
            if (item == null || typeof item === 'number') return;
            var n = typeof item === 'string' ? item : (apiVal(item, 'ProjectName', 'projectName', 'Name', 'name') || '');
            if (!n || String(n).toUpperCase() === 'OVERVIEW') return;
            rows.push({ name: String(n).trim(), status: 'Not Locked' });
        });
        return rows;
    }

    function uniqueUnlockedRowsFromList(list, maxCount) {
        var rows = [];
        var seen = {};
        (list || []).forEach(function (obj) {
            var name = typeof obj === 'string' ? obj : (apiVal(obj, 'ProjectName', 'projectName', 'Name', 'name') || '');
            if (!name || String(name).toUpperCase() === 'OVERVIEW') return;
            var key = String(name).toLowerCase();
            if (seen[key]) return;
            seen[key] = true;
            rows.push({ name: String(name).trim(), status: 'Not Locked' });
        });
        maxCount = toInt(maxCount, 0);
        if (maxCount > 0 && rows.length > maxCount) rows = rows.slice(0, maxCount);
        return rows;
    }

    function collectNeedsAttentionRows(data) {
        var rows = [];
        if (!data) return rows;
        var keys = ['AtRiskProjectList', 'NeedsAttentionProjects', 'AtRiskProjectsList', 'atRiskProjectList', 'AtRiskProjectNames', 'NeedsAttentionProjectNames'];
        var list = [];
        var i;
        for (i = 0; i < keys.length; i++) {
            var v = apiVal(data, keys[i]);
            if (Array.isArray(v)) {
                list = v;
                break;
            }
            if (typeof v === 'string' && v) {
                list = splitOnTrackProjectNames(v, 99);
                break;
            }
        }
        list.forEach(function (item) {
            if (item == null || typeof item === 'number') return;
            var n = typeof item === 'string' ? item : (apiVal(item, 'ProjectName', 'projectName', 'Name', 'name') || '');
            if (!n || String(n).toUpperCase() === 'OVERVIEW') return;
            var overview = typeof item === 'object'
                ? apiVal(item, 'ProjectOverview', 'Overview', 'projectOverview', 'overview')
                : '';
            rows.push({ name: String(n).trim(), overview: overview });
        });
        return rows;
    }

    function sqertMetricValue(obj, metric) {
        if (!obj || !metric) return '';
        if (metric === 'Overview') return apiVal(obj, 'ProjectOverview', 'Overview', 'projectOverview', 'overview');
        return apiVal(obj, metric, metric.toLowerCase());
    }

    function sqertMetricWarnClass(obj, metric) {
        var cls = sqertColorClass(metric, sqertMetricValue(obj, metric));
        return (cls === 'ciRed' || cls === 'ciYellow') ? cls : '';
    }

    function preferredNeedsAttentionMetric() {
        var note = String($('#phsAtRiskNote').text() || '').toLowerCase();
        var metrics = ['Quality', 'Scope', 'Effort', 'Risk', 'Time', 'Overview'];
        var i;
        for (i = 0; i < metrics.length; i++) {
            if (note.indexOf(metrics[i].toLowerCase()) >= 0) return metrics[i];
        }
        return 'Overview';
    }

    function uniqueNeedsAttentionFromSqert(list, maxCount) {
        var preferred = preferredNeedsAttentionMetric();
        var metrics = ['Overview', 'Quality', 'Scope', 'Effort', 'Risk', 'Time'];
        var byName = {};
        var order = [];
        (list || []).forEach(function (obj) {
            var name = apiVal(obj, 'ProjectName', 'projectName') || '';
            if (!name || String(name).toUpperCase() === 'OVERVIEW') return;
            var key = String(name).toLowerCase();
            if (byName[key]) return;
            var prefCls = sqertMetricWarnClass(obj, preferred);
            var anyRed = prefCls === 'ciRed';
            var anyYellow = prefCls === 'ciYellow';
            metrics.forEach(function (m) {
                var cls = sqertMetricWarnClass(obj, m);
                if (cls === 'ciRed') anyRed = true;
                if (cls === 'ciYellow') anyYellow = true;
            });
            var rank = prefCls === 'ciRed' ? 0 : (prefCls === 'ciYellow' ? 1 : (anyRed ? 2 : (anyYellow ? 3 : 4)));
            var rec = {
                name: String(name).trim(),
                overview: sqertMetricValue(obj, 'Overview'),
                rank: rank
            };
            byName[key] = rec;
            order.push(rec);
        });
        var rows = order.filter(function (r) { return !isOnTrackProjectName(r.name); });
        if (!rows.length) rows = order.slice();
        rows.sort(function (a, b) { return a.rank - b.rank; });
        maxCount = toInt(maxCount, 0);
        if (maxCount > 0) rows = rows.slice(0, maxCount);
        return rows.map(function (r) { return { name: r.name, overview: r.overview }; });
    }

    function upsertNeedsAttentionRow(name, overview) {
        if (!name || String(name).toUpperCase() === 'OVERVIEW') return;
        var key = String(name).toLowerCase();
        var found = null;
        for (var i = 0; i < phsNeedsAttentionRows.length; i++) {
            if (String(phsNeedsAttentionRows[i].name).toLowerCase() === key) {
                found = phsNeedsAttentionRows[i];
                break;
            }
        }
        if (found) {
            if (overview != null && overview !== '') found.overview = overview;
            return;
        }
        if (phsNeedsAttentionFromKpi) return;
        phsNeedsAttentionRows.push({ name: String(name).trim(), overview: overview });
    }

    function isOnTrackProjectName(name) {
        var key = String(name || '').toLowerCase();
        if (!key) return false;
        for (var i = 0; i < (phsOnTrackTipNames || []).length; i++) {
            if (String(phsOnTrackTipNames[i]).toLowerCase() === key) return true;
        }
        return false;
    }

    function trimNeedsAttentionRows() {
        var count = toInt(phsNeedsAttentionCount, 0);
        var rows = (phsNeedsAttentionRows || []).filter(function (r) {
            return r && r.name && String(r.name).toUpperCase() !== 'OVERVIEW' && !isOnTrackProjectName(r.name);
        });
        if (count <= 0) {
            phsNeedsAttentionRows = [];
            return;
        }
        if (rows.length > count) {
            var red = [];
            var other = [];
            rows.forEach(function (r) {
                if (sqertColorClass('Overview', r.overview) === 'ciRed') red.push(r);
                else other.push(r);
            });
            rows = red.concat(other).slice(0, count);
        }
        phsNeedsAttentionRows = rows;
    }

    function mergeNeedsAttentionFromSqert(list) {
        if (phsNeedsAttentionCount > 0 && phsNeedsAttentionRows.length === phsNeedsAttentionCount) {
            (list || []).forEach(function (obj) {
                var name = apiVal(obj, 'ProjectName', 'projectName') || '';
                var overview = apiVal(obj, 'ProjectOverview', 'Overview', 'projectOverview');
                upsertNeedsAttentionRow(name, overview);
            });
            refreshOpenPhsKpiTip();
            return;
        }
        (list || []).forEach(function (obj) {
            var name = apiVal(obj, 'ProjectName', 'projectName') || '';
            var overview = apiVal(obj, 'ProjectOverview', 'Overview', 'projectOverview');
            var cls = sqertColorClass('Overview', overview);
            var qualityCls = sqertColorClass('Quality', apiVal(obj, 'Quality', 'quality'));
            if (cls === 'ciRed' || cls === 'ciYellow' || qualityCls === 'ciRed' || qualityCls === 'ciYellow') {
                upsertNeedsAttentionRow(name, overview);
            }
        });
        trimNeedsAttentionRows();
        refreshOpenPhsKpiTip();
    }

    function getPhsKpiTipRows(kind) {
        if (kind === 'ontrack') {
            return (phsOnTrackTipNames || []).map(function (n) {
                return { name: n, status: 'On Track' };
            });
        }
        if (kind === 'attention') {
            var rows = phsNeedsAttentionRows || [];
            var count = toInt(phsNeedsAttentionCount, 0);
            if (count > 0 && rows.length > count) return rows.slice(0, count);
            return rows;
        }
        if (kind === 'unlocked') {
            var unlocked = phsUnlockedTipRows || [];
            var unlockedCount = toInt(phsUnlockedCount, 0);
            if (unlockedCount > 0 && unlocked.length > unlockedCount) return unlocked.slice(0, unlockedCount);
            return unlocked;
        }
        return phsKpiActiveProjects || [];
    }

    function getPhsKpiTipEl() {
        var el = document.getElementById('phsKpiTip');
        if (!el) {
            el = document.createElement('div');
            el.id = 'phsKpiTip';
            el.className = 'phs-kpi-tip';
            document.body.appendChild(el);
            el.addEventListener('mouseenter', function () {
                if (phsKpiTipHideTimer) clearTimeout(phsKpiTipHideTimer);
            });
            el.addEventListener('mouseleave', hidePhsKpiTip);
        }
        return el;
    }

    function renderPhsKpiTip(kind) {
        var el = getPhsKpiTipEl();
        var rows = getPhsKpiTipRows(kind);
        var isAttention = kind === 'attention';
        var emptyText = kind === 'ontrack' ? 'No on track projects'
            : (isAttention ? 'No projects need attention'
                : (kind === 'unlocked' ? 'No projects pending lock' : 'No active projects'));
        var rightHead = isAttention ? 'Project Overview' : 'Status';
        var html = '<div class="tip-head"><span>Project Name</span><span>' + rightHead + '</span></div><div class="tip-body">';
        if (!rows.length) {
            html += '<div class="tip-empty">' + emptyText + '</div>';
        } else {
            rows.forEach(function (r) {
                html += '<div class="tip-row"><span class="tip-lbl">' + esc(r.name) + '</span>';
                if (isAttention) {
                    html += '<span class="tip-overview">' + sqertDot('Overview', r.overview) + '</span>';
                } else {
                    var st = String(r.status || '');
                    var stCls = st.toLowerCase().indexOf('track') >= 0 ? ' ontrack' : (st.toLowerCase().indexOf('lock') >= 0 ? ' unlocked' : '');
                    html += '<span class="tip-val' + stCls + '">' + esc(st) + '</span>';
                }
                html += '</div>';
            });
        }
        html += '</div>';
        el.innerHTML = html;
        return el;
    }

    function positionPhsKpiTip(anchor) {
        var el = getPhsKpiTipEl();
        var rect = anchor.getBoundingClientRect();
        var tw = el.offsetWidth || 260;
        var th = el.offsetHeight || 120;
        var left = rect.left + window.pageXOffset;
        var top = rect.bottom + window.pageYOffset + 8;
        if (left + tw > window.pageXOffset + window.innerWidth - 8) {
            left = rect.right + window.pageXOffset - tw;
        }
        if (left < window.pageXOffset + 8) left = window.pageXOffset + 8;
        if (top + th > window.pageYOffset + window.innerHeight - 8) {
            top = rect.top + window.pageYOffset - th - 8;
        }
        el.style.left = left + 'px';
        el.style.top = top + 'px';
    }

    function showPhsKpiTip(kind, btnId) {
        if (phsKpiTipHideTimer) clearTimeout(phsKpiTipHideTimer);
        var btn = document.getElementById(btnId);
        if (!btn) return;
        phsKpiTipKind = kind;
        var el = renderPhsKpiTip(kind);
        el.classList.add('open');
        positionPhsKpiTip(btn);
    }

    function hidePhsKpiTip() {
        if (phsKpiTipHideTimer) clearTimeout(phsKpiTipHideTimer);
        phsKpiTipHideTimer = setTimeout(function () {
            var el = document.getElementById('phsKpiTip');
            if (el) el.classList.remove('open');
        }, 180);
    }

    function bindPhsKpiTipButton(btnId, kind) {
        var $btn = $('#' + btnId);
        if (!$btn.length || $btn.data('phsTipBound')) return;
        $btn.data('phsTipBound', true);
        $btn.on('mouseenter focus', function () { showPhsKpiTip(kind, btnId); });
        $btn.on('mouseleave blur', hidePhsKpiTip);
    }

    function bindPhsKpiTips() {
        bindPhsKpiTipButton('phsTotalInfo', 'total');
        bindPhsKpiTipButton('phsOnTrackInfo', 'ontrack');
        bindPhsKpiTipButton('phsAtRiskInfo', 'attention');
        bindPhsKpiTipButton('phsUnlockedInfo', 'unlocked');
    }

    function setPhsCardTooltip(selector, text) {
        var el = document.querySelector(selector);
        if (!el) return;
        el.setAttribute('title', text);
        el.setAttribute('data-bs-original-title', text);
        if (window.bootstrap && bootstrap.Tooltip) {
            var inst = bootstrap.Tooltip.getInstance(el);
            if (inst && typeof inst.setContent === 'function') {
                inst.setContent({ '.tooltip-inner': text });
            } else if (!inst) {
                new bootstrap.Tooltip(el, { container: 'body', placement: 'top', customClass: 'phs-summary-tooltip' });
            }
        } else if ($.fn.tooltip) {
            $(el).attr('data-original-title', text);
        }
    }

    function splitOnTrackProjectNames(text, count) {
        if (!text) return [];
        var s = String(text).trim();
        if (!s || /^no project found$/i.test(s)) return [];
        var parts;
        if (s.indexOf('\n') >= 0) parts = s.split(/\n+/);
        else if (s.indexOf('|') >= 0) parts = s.split('|');
        else if (s.indexOf(';') >= 0) parts = s.split(';');
        else if (s.indexOf(',') >= 0 && toInt(count, 0) > 1) parts = s.split(',');
        else return [s];
        return parts.map(function (p) { return String(p || '').trim(); }).filter(Boolean);
    }

    function collectOnTrackProjectNames(data, count) {
        var names = [];
        var list = apiVal(data, 'OnTrackProjectNames', 'OnTrackProjectsList', 'onTrackProjectNames', 'OnTrackProjectList');
        if (Array.isArray(list)) {
            list.forEach(function (item) {
                var n = typeof item === 'string' ? item : (apiVal(item, 'ProjectName', 'projectName', 'Name', 'name') || '');
                if (n) names.push(String(n).trim());
            });
        } else if (list) {
            names = splitOnTrackProjectNames(list, count);
        }
        if (!names.length) {
            names = splitOnTrackProjectNames(apiVal(data, 'OnTrackProjectName', 'onTrackProjectName') || '', count);
        }
        var seen = {};
        return names.filter(function (n) {
            var key = n.toLowerCase();
            if (!n || seen[key]) return false;
            seen[key] = true;
            return true;
        });
    }

    function formatOnTrackTooltip(names, count) {
        count = toInt(count, 0);
        if (count <= 0 && !names.length) return 'No project found';
        if (!names.length) {
            return count > 1 ? (count + ' projects ...') : 'No project found';
        }
        if (count <= 1 && names.length === 1) return names[0];
        var lines = [names[0] + ' ...'];
        names.slice(1).forEach(function (n) { lines.push(n); });
        var extra = count > names.length ? (count - names.length) : 0;
        if (extra > 0) lines.push('+' + extra + ' more');
        return lines.join('\n');
    }

    function formatOnTrackCardNote(names, count) {
        count = toInt(count, 0);
        if (count <= 0 && !names.length) return 'No project found';
        if (!names.length) return count > 1 ? (count + ' projects ... more') : 'No project found';
        if (count > 1 || names.length > 1) return names[0] + ' ... more';
        return names[0];
    }

    function formatOnTrackNoteTooltip(names, count) {
        count = toInt(count, 0);
        if (count > 1 || (names && names.length > 1)) {
            return 'To see all details click on above info icon';
        }
        if (!names || !names.length) return '';
        return names[0];
    }

    function setOnTrackCardNote(names, count) {
        var $note = $('#phsOnTrackProjectName');
        $note.text(formatOnTrackCardNote(names, count));
        var tip = formatOnTrackNoteTooltip(names, count);
        $note.toggleClass('has-tip', !!tip);
        setPhsCardTooltip('#phsOnTrackProjectName', tip);
    }

    function isPhsInactiveProjectStatus(status) {
        if (status == null || status === '') return false;
        var s = String(status).toLowerCase();
        return s === '0' || s === 'false' || s === 'inactive' || s === 'closed' ||
            s === 'completed' || s === 'complete' || s === 'on hold' || s === 'hold';
    }

    function uniqueActiveRowsFromSqert(list, maxCount) {
        var rows = [];
        var seen = {};
        (list || []).forEach(function (obj) {
            var name = apiVal(obj, 'ProjectName', 'projectName') || '';
            if (!name || String(name).toUpperCase() === 'OVERVIEW') return;
            if (isPhsInactiveProjectStatus(apiVal(obj, 'Status', 'status', 'ProjectStatus', 'CurrentStatus'))) return;
            var key = String(name).toLowerCase();
            if (seen[key]) return;
            seen[key] = true;
            rows.push({ name: String(name).trim(), status: 'Active' });
        });
        maxCount = toInt(maxCount, 0);
        if (maxCount > 0 && rows.length > maxCount) rows = rows.slice(0, maxCount);
        return rows;
    }

    function refreshOpenPhsKpiTip() {
        var el = document.getElementById('phsKpiTip');
        if (!el || !el.classList.contains('open')) return;
        var btnMap = { ontrack: 'phsOnTrackInfo', attention: 'phsAtRiskInfo', unlocked: 'phsUnlockedInfo', total: 'phsTotalInfo' };
        var btnId = btnMap[phsKpiTipKind] || 'phsTotalInfo';
        var btn = document.getElementById(btnId);
        renderPhsKpiTip(phsKpiTipKind);
        if (btn) positionPhsKpiTip(btn);
    }

    function loadActiveProjectsForTip(totalCount) {
        var want = Math.max(toInt(totalCount, 0), 1);
        var payload = {
            ProgramID: toInt($('#txtPHSFilterProjectGroupName').val()) || null,
            ProjectID: 0,
            ProjectIDs: '',
            ProjectTypeID: toInt($('#txtPHSFilterProjectType').val()) || null,
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            OrganizationUnitID: toInt($('#txtPHSFilterLocation').val()) || null,
            ReportingDate: getReportingDate() || null,
            UserID: UserID,
            LoginType: LoginType,
            TagID: PageTagID,
            PageNumber: 1,
            PageSize: Math.max(want + 20, 100)
        };

        function applyRows(json) {
            var pData = getPaginatedData(json, 'sqertList');
            phsKpiActiveProjects = uniqueActiveRowsFromSqert(pData.list, want);
            refreshOpenPhsKpiTip();
            return pData;
        }

        return ajaxPost('/api/ProjectHealthDashboard/GetSQERTList', payload)
            .then(function (json) {
                var pData = applyRows(json);
                var totalRec = toInt(pData.total, (pData.list || []).length);
                if (totalRec > (pData.list || []).length && phsKpiActiveProjects.length < want) {
                    payload.PageSize = totalRec;
                    return ajaxPost('/api/ProjectHealthDashboard/GetSQERTList', payload).done(applyRows);
                }
            })
            .fail(function (err) { console.error('GetSQERTList (active tip) failed', err); });
    }

    function loadUnlockedProjectsForTip(unlockedCount) {
        var want = Math.max(toInt(unlockedCount, 0), 1);
        var payload = {
            ProgramID: toInt($('#txtPHSFilterProjectGroupName').val()) || null,
            ProjectID: 0,
            ProjectIDs: '',
            ProjectTypeID: toInt($('#txtPHSFilterProjectType').val()) || null,
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            OrganizationUnitID: toInt($('#txtPHSFilterLocation').val()) || null,
            ReportingStartDate: null,
            ReportingEndDate: getReportingDate() || null,
            Flag: 0,
            LoginType: LoginType,
            EmployeeID: EmployeeID,
            PageNumber: 1,
            PageSize: Math.max(want + 20, 100)
        };

        function applyRows(json) {
            var pData = getPaginatedData(json, 'projects');
            phsUnlockedTipRows = uniqueUnlockedRowsFromList(pData.list, want);
            refreshOpenPhsKpiTip();
            return pData;
        }

        return ajaxPost('/api/ProjectHealthDashboard/GetProjectsPendingLock', payload)
            .then(function (json) {
                var pData = applyRows(json);
                var totalRec = toInt(pData.total, (pData.list || []).length);
                if (totalRec > (pData.list || []).length && phsUnlockedTipRows.length < want) {
                    payload.PageSize = totalRec;
                    return ajaxPost('/api/ProjectHealthDashboard/GetProjectsPendingLock', payload).done(applyRows);
                }
            })
            .fail(function (err) { console.error('GetProjectsPendingLock (unlocked tip) failed', err); });
    }

    function loadNeedsAttentionForTip(attentionCount) {
        var want = Math.max(toInt(attentionCount, 0), 1);
        var payload = {
            ProgramID: toInt($('#txtPHSFilterProjectGroupName').val()) || null,
            ProjectID: 0,
            ProjectIDs: '',
            ProjectTypeID: toInt($('#txtPHSFilterProjectType').val()) || null,
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            OrganizationUnitID: toInt($('#txtPHSFilterLocation').val()) || null,
            ReportingDate: getReportingDate() || null,
            UserID: UserID,
            LoginType: LoginType,
            TagID: PageTagID,
            PageNumber: 1,
            PageSize: Math.max(want + 20, 100)
        };

        function applyRows(json) {
            var pData = getPaginatedData(json, 'sqertList');
            phsNeedsAttentionRows = uniqueNeedsAttentionFromSqert(pData.list, want);
            refreshOpenPhsKpiTip();
            return pData;
        }

        return ajaxPost('/api/ProjectHealthDashboard/GetSQERTList', payload)
            .then(function (json) {
                var pData = applyRows(json);
                var totalRec = toInt(pData.total, (pData.list || []).length);
                if (totalRec > (pData.list || []).length && phsNeedsAttentionRows.length < want) {
                    payload.PageSize = totalRec;
                    return ajaxPost('/api/ProjectHealthDashboard/GetSQERTList', payload).done(applyRows);
                }
            })
            .fail(function (err) { console.error('GetSQERTList (attention tip) failed', err); });
    }

    function loadKPISummary() {
        var payload = getKpiFilterPayload();
        if (!strUrl) return;
        
        $.ajax({
            url: encodeURI(strUrl + '/api/ProjectHealthDashboard/GetKPISummary'),
            type: 'POST',
            data: JSON.stringify(payload),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || ''));
                xhr.setRequestHeader('Params', encryptString(JSON.stringify(payload)));
            },
            success: function (json) {
                //  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
                var data = unwrapPayload(json);
                var asOf = apiVal(data, 'AsOfDate') || '-';
                var onTrackCount = apiVal(data, 'OnTrackProjects') != null ? apiVal(data, 'OnTrackProjects') : 0;
                var onTrackNames = collectOnTrackProjectNames(data, onTrackCount);
                phsOnTrackTipNames = onTrackNames.slice();
                var kpiAttention = collectNeedsAttentionRows(data);
                var atRiskCount = apiVal(data, 'AtRiskProjects') != null ? apiVal(data, 'AtRiskProjects') : 0;
                phsNeedsAttentionCount = toInt(atRiskCount, 0);
                if (kpiAttention.length) {
                    phsNeedsAttentionRows = kpiAttention;
                    phsNeedsAttentionFromKpi = true;
                    trimNeedsAttentionRows();
                } else {
                    phsNeedsAttentionFromKpi = false;
                }
                var atRiskNote = apiVal(data, 'AtRiskNote', 'atRiskMetrics') || 'Scope / Overview issues';
                var totalProjects = apiVal(data, 'TotalProjects') != null ? apiVal(data, 'TotalProjects') : 0;
                phsKpiActiveProjects = collectActiveProjectRows(data);
                phsUnlockedCount = toInt(apiVal(data, 'UnlockedProjects'), 0);
                phsUnlockedTipRows = collectUnlockedProjectRows(data);
                if (phsUnlockedCount <= 0) {
                    phsUnlockedTipRows = [];
                } else if (phsUnlockedTipRows.length > phsUnlockedCount) {
                    phsUnlockedTipRows = phsUnlockedTipRows.slice(0, phsUnlockedCount);
                }
                $('#phsTotalProjects').text(totalProjects);
                $('#phsOnTrackProjects').text(onTrackCount);
                $('#phsAtRiskProjects').text(phsNeedsAttentionCount);
                $('#phsUnlockedProjects').text(phsUnlockedCount);
                $('#phsAsOfDate').text(asOf);
                setOnTrackCardNote(onTrackNames, onTrackCount);
                $('#phsAtRiskNote').text(atRiskNote);
                var totalCount = toInt(totalProjects, 0);
                if (totalCount > 0 && phsKpiActiveProjects.length !== totalCount) {
                    loadActiveProjectsForTip(totalCount);
                }
                if (phsUnlockedCount > 0 && phsUnlockedTipRows.length !== phsUnlockedCount) {
                    loadUnlockedProjectsForTip(phsUnlockedCount);
                }
                if (phsNeedsAttentionCount > 0 && phsNeedsAttentionRows.length !== phsNeedsAttentionCount) {
                    loadNeedsAttentionForTip(phsNeedsAttentionCount);
                } else if (phsNeedsAttentionCount <= 0) {
                    phsNeedsAttentionRows = [];
                }
            },
            error: function (err) { console.error('GetKPISummary failed', err); }
        });
    }

    /* ---------- Filter masters ---------- */
    function loadFilterMasters() {
        var payload = { UserID: UserID, LoginType: LoginType };
        return ajaxPost('/api/ProjectHealthDashboard/GetFilterMasters', payload)
            .done(function (json) {
                var data = unwrapPayload(json);
                fillSelect($('#txtPHSFilterProjectType'), extractList(data, ['PracticeMasterModel', 'Practices', 'practiceList']),
                    ['TypeId', 'PracticeID', 'practiceID', 'id'], ['ProjectType', 'PracticeName', 'practiceName', 'name'], 'Select Practice');
                fillSelect($('#txtPHSFilterBusinessGroup'), extractList(data, ['BusinessGroupMasterModel', 'BusinessGroups', 'businessGroupList']),
                    ['BusinessGroupID', 'businessGroupID', 'id'], ['BusinessGroup', 'businessGroupName', 'name'], 'Select Business Group');
                fillSelect($('#txtPHSFilterProjectGroupName'), extractList(data, ['ProjectGroupMasterModel', 'ProjectGroups', 'projectGroupList']),
                    ['ProjectGroupID', 'projectGroupID', 'id'], ['ProjectGroupName', 'projectGroupName', 'name'], 'Select Project Group');
            })
            .fail(function (err) { console.error('GetFilterMasters failed', err); });
    }

    function loadOrganizationUnits() {
        var payload = {
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            UserID: UserID,
            LoginType: LoginType
        };
        return ajaxPost('/api/ProjectHealthDashboard/GetOrganizationUnits', payload)
            .done(function (json) {
                fillSelect($('#txtPHSFilterLocation'), extractList(unwrapPayload(json), ['OrganizationUnitMasterModel', 'Locations', 'organizationUnits']),
                    ['LocationID', 'OrganizationUnitID', 'organizationUnitID', 'id'], ['Location', 'organizationUnitName', 'name'], 'Select Organization Unit');
            })
            .fail(function (err) { console.error('GetOrganizationUnits failed', err); });
    }

    function loadFilteredProjects() {
        var payload = getMasterFilterPayload();
        return ajaxPost('/api/ProjectHealthDashboard/GetFilteredProjects', payload)
            .done(function (json) {
                fillSelect($('#txtPHSFilterProjectName'), extractList(unwrapPayload(json), ['ProjectMasterModel', 'Projects', 'projects']),
                    ['ProjectID', 'projectID', 'id'], ['ProjectName', 'projectName', 'name'], 'Select Project');
                fillPhsTableProjectSelects(extractList(unwrapPayload(json), ['ProjectMasterModel', 'Projects', 'projects']));
                if (selectedProjectID) {
                    $('#txtPHSFilterProjectName').val(String(selectedProjectID));
                    refreshSelect($('#txtPHSFilterProjectName'));
                }
            })
            .fail(function (err) { console.error('GetFilteredProjects failed', err); });
    }

    function loadProjectList() {
        var payload = { UserID: UserID, LoginType: LoginType };
        return ajaxPost('/api/ProjectHealthDashboard/GetProjectList', payload)
            .done(function (json) {
                var rows = extractList(unwrapPayload(json), ['ProjectMasterModel', 'Projects', 'projects']);
                fillSelect($('#CboProject'), rows,
                    ['ProjectID', 'projectID', 'id'], ['ProjectName', 'projectName', 'name'], 'Select Project');
                fillPhsTableProjectSelects(rows);
                if (selectedProjectID) {
                    $('#CboProject').val(String(selectedProjectID));
                    refreshSelect($('#CboProject'));
                }
            })
            .fail(function (err) { console.error('GetProjectList failed', err); });
    }

    function loadReportingFrequency() {
        return ajaxPost('/api/ProjectHealthDashboard/GetReportingFrequency', {})
            .done(function (json) {
                var data = unwrapPayload(json);
                var label = apiVal(data, 'ReportingPeriod', 'reportingPeriod', 'Frequency', 'frequency', 'message') ||
                    (typeof data === 'string' ? data : '');
                if (!label && Array.isArray(data) && data[0]) {
                    label = apiVal(data[0], 'ReportingPeriod', 'Frequency', 'Name') || '';
                }
                $('#lblReportingPeriod').text(label || '-');
            })
            .fail(function (err) { console.error('GetReportingFrequency failed', err); });
    }

    /* ---------- SQERT ---------- */
    function loadSQERTRange() {
        return ajaxPost('/api/ProjectHealthDashboard/GetSQERTRange', {})
            .done(function (json) {
                var rows = extractList(unwrapPayload(json), ['SQERTRangeModel', 'ranges']);
                sqertRanges = {};
                rows.forEach(function (obj) {
                    var rangeid = toInt(apiVal(obj, 'RangeID', 'rangeID'));
                    var rec = {
                        lowerLow: parseFloat(apiVal(obj, 'LowerLow', 'lowerLow')),
                        lowerHigh: parseFloat(apiVal(obj, 'LowerHigh', 'lowerHigh')),
                        middleLow: parseFloat(apiVal(obj, 'MiddleLow', 'middleLow')),
                        middleHigh: parseFloat(apiVal(obj, 'MiddleHigh', 'middleHigh')),
                        upperLow: parseFloat(apiVal(obj, 'UpperLow', 'upperLow')),
                        upperHigh: parseFloat(apiVal(obj, 'UpperHigh', 'upperHigh'))
                    };
                    var map = { 1: 'Scope', 2: 'Quality', 3: 'Effort', 4: 'Risk', 5: 'Time' };
                    var name = apiVal(obj, 'Title', 'Metric', 'Name') || map[rangeid];
                    if (name) sqertRanges[name] = rec;
                });
            })
            .fail(function (err) { console.error('GetSQERTRange failed', err); });
    }

    function loadSQERTList() {
        var selectedIds = getSqertSelectedProjectIds();
        var useClientFilter = selectedIds.length > 1;
        var payload = {
            ProgramID: toInt($('#txtPHSFilterProjectGroupName').val()) || null,
            ProjectID: selectedIds.length === 1 ? toInt(selectedIds[0]) : 0,
            ProjectIDs: selectedIds.join(','),
            ProjectTypeID: toInt($('#txtPHSFilterProjectType').val()) || null,
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            OrganizationUnitID: toInt($('#txtPHSFilterLocation').val()) || null,
            ReportingDate: getReportingDate() || null,
            UserID: UserID,
            LoginType: LoginType,
            TagID: PageTagID,
            PageNumber: useClientFilter ? 1 : pagerState.sqert.page,
            PageSize: useClientFilter ? Math.max(pagerState.sqert.size, 200) : pagerState.sqert.size
        };
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        function renderSqert(pData) {
            var list = pData.list || [];
            var total = pData.total;
            if (useClientFilter) {
                var paged = paginateClientList(filterRowsBySelectedProjects(list, selectedIds), pagerState.sqert);
                list = paged.list;
                total = paged.total;
            }
            var html = '';
            list.forEach(function (obj) {
                var pid = apiVal(obj, 'ProjectID', 'projectID') || 0;
                var name = apiVal(obj, 'ProjectName', 'projectName') || '';
                var rdate = apiVal(obj, 'ReportingDate', 'reportingDate') || '';
                var overview = apiVal(obj, 'ProjectOverview', 'Overview', 'projectOverview');
                var isOverview = String(name).toUpperCase() === 'OVERVIEW';
                html += '<tr' + (isOverview ? ' class="overviewrow graybglight"' : '') + '>';
                if (isOverview) {
                    html += '<td class="text-start"><strong>' + esc(name) + '</strong></td>';
                } else {
                    html += '<td class="text-start"><a href="javascript:;" class="phs-detail-link" data-project-id="' + toInt(pid) + '" onclick="openPHSProjectDetails(' + toInt(pid) + ', this)">' + esc(name) + '</a></td>';
                }
                html += '<td>' + esc(rdate) + '</td>';
                html += '<td>' + sqertDot('Scope', apiVal(obj, 'Scope', 'scope')) + '</td>';
                html += '<td>' + sqertDot('Quality', apiVal(obj, 'Quality', 'quality')) + '</td>';
                html += '<td>' + sqertDot('Effort', apiVal(obj, 'Effort', 'effort')) + '</td>';
                html += '<td>' + sqertDot('Risk', apiVal(obj, 'Risk', 'risk')) + '</td>';
                html += '<td>' + sqertDot('Time', apiVal(obj, 'Time', 'time')) + '</td>';
                html += '<td>' + sqertDot('Overview', overview) + '</td>';
                html += '</tr>';
            });
            mergeNeedsAttentionFromSqert(pData.list);
            $('#tblsqert').html(html || emptyRow(8));
            setSqertDetailsTitle();
            renderCustomPager($('#sqertListTbl'), pagerState.sqert, total, loadSQERTList);
        }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        return ajaxPost('/api/ProjectHealthDashboard/GetSQERTList', payload)
            .then(function (json) {
                var pData = getPaginatedData(json, 'sqertList');
                if (useClientFilter) {
                    var rawLen = (pData.list || []).length;
                    var totalRec = toInt(pData.total, rawLen);
                    if (totalRec > rawLen) {
                        payload.PageSize = totalRec;
                        return ajaxPost('/api/ProjectHealthDashboard/GetSQERTList', payload).done(function (json2) {
                            renderSqert(getPaginatedData(json2, 'sqertList'));
                        });
                    }
                }
                renderSqert(pData);
            })
            .fail(function (err) {
                console.error('GetSQERTList failed', err);
                $('#tblsqert').html(emptyRow(8));
                setSqertDetailsTitle();
                renderCustomPager($('#sqertListTbl'), pagerState.sqert, 0, loadSQERTList);
            });
    }

    function loadProjectsPendingLock() {
        var selectedIds = getUnlockedSelectedProjectIds();
        var useClientFilter = selectedIds.length > 1;
        var payload = {
            ProgramID: toInt($('#txtPHSFilterProjectGroupName').val()) || null,
            ProjectID: selectedIds.length === 1 ? toInt(selectedIds[0]) : 0,
            ProjectIDs: selectedIds.join(','),
            ProjectTypeID: toInt($('#txtPHSFilterProjectType').val()) || null,
            BusinessGroupID: toInt($('#txtPHSFilterBusinessGroup').val()) || null,
            OrganizationUnitID: toInt($('#txtPHSFilterLocation').val()) || null,
            ReportingStartDate: null,
            ReportingEndDate: getReportingDate() || null,
            Flag: 0,
            LoginType: LoginType,
            EmployeeID: EmployeeID,
            PageNumber: useClientFilter ? 1 : pagerState.unlocked.page,
            PageSize: useClientFilter ? Math.max(pagerState.unlocked.size, 200) : pagerState.unlocked.size
        };

        function renderUnlocked(pData) {
            var list = pData.list || [];
            var total = pData.total;
            if (useClientFilter) {
                var paged = paginateClientList(filterRowsBySelectedProjects(list, selectedIds), pagerState.unlocked);
                list = paged.list;
                total = paged.total;
            }

            if (typeof destroyUnlockedProjectsDataTable === 'function') {
                destroyUnlockedProjectsDataTable();
            } else if ($.fn.DataTable && $.fn.DataTable.isDataTable('#healthshetprojectList')) {
                $('#healthshetprojectList').DataTable().destroy(false);
            }

            var html = '';
            list.forEach(function (obj) {
                var projectName = apiVal(obj, 'ProjectName', 'projectName') || '';
                var startDate = apiVal(obj, 'ExpectedStartDate', 'ProjectStartDate', 'StartDate', 'projectStartDate', 'startDate') || '';
                var endDate = apiVal(obj, 'ExpectedEndDate', 'ProjectEndDate', 'EndDate', 'projectEndDate', 'endDate') || '';
                html += '<tr>';
                html += '<td class="text-start">' + esc(projectName) + '</td>';
                html += '<td class="text-center">' + esc(startDate) + '</td>';
                html += '<td class="text-center">' + esc(endDate) + '</td>';
                html += '</tr>';
            });

            var $tbody = $('#healthshetprojectList tbody');
            if (!$tbody.length) {
                $('#healthshetprojectList').append('<tbody id="tblAllProjectHealthSheetData"></tbody>');
                $tbody = $('#healthshetprojectList tbody');
            }
            $tbody.attr('id', 'tblAllProjectHealthSheetData').html(html || '');

            var asOf = getReportingDate();
            $('#unlockedProjectsTitle').text(asOf ? ('List of Projects which were not locked till ' + asOf) : 'List of Projects which were not locked');

            if (typeof initUnlockedProjectsDataTable === 'function') {
                initUnlockedProjectsDataTable();
            }

            renderCustomPager($('#healthshetprojectList'), pagerState.unlocked, total, loadProjectsPendingLock);
        }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        return ajaxPost('/api/ProjectHealthDashboard/GetProjectsPendingLock', payload)
            .then(function (json) {
                var pData = getPaginatedData(json, 'projects');
                if (useClientFilter) {
                    var rawLen = (pData.list || []).length;
                    var totalRec = toInt(pData.total, rawLen);
                    if (totalRec > rawLen) {
                        payload.PageSize = totalRec;
                        return ajaxPost('/api/ProjectHealthDashboard/GetProjectsPendingLock', payload).done(function (json2) {
                            renderUnlocked(getPaginatedData(json2, 'projects'));
                        });
                    }
                }
                renderUnlocked(pData);
            })
            .fail(function (err) {
                console.error('GetProjectsPendingLock failed', err);
                var $tbody = $('#healthshetprojectList tbody');
                if ($tbody.length) $tbody.html('');
                renderCustomPager($('#healthshetprojectList'), pagerState.unlocked, 0, loadProjectsPendingLock);
            });
    }

    /* ---------- Detail offcanvas ---------- */
    function loadPHSInformation(projectId) {
        var payload = {
            UserID: UserID,
            LoginType: LoginType,
            ProjectID: projectId,
            ReportingDate: getReportingDate() || null
        };
        return ajaxPost('/api/ProjectHealthDashboard/GetPHSInformation', payload)
            .done(function (json) {
                var data = unwrapPayload(json);
                if (Array.isArray(data)) data = data[0] || {};
                $('#phsInfoProject').text(dash(apiVal(data, 'ProjectName', 'Project', 'projectName')));
                $('#phsInfoRole').text(dash(apiVal(data, 'Role', 'role', 'ProjectType')));
                $('#phsInfoBusinessGroup').text(dash(apiVal(data, 'BusinessGroup', 'businessGroup')));
                $('#phsInfoFromDate').text(dash(apiVal(data, 'FromDate', 'fromDate')));
                $('#phsInfoOrganizationUnit').text(dash(apiVal(data, 'Location', 'OrganizationUnit', 'organizationUnit')));
                $('#phsInfoWorkhoursPercent').text(dash(apiVal(data, 'WorkhoursPercent', 'workhoursPercent')));
            })
            .fail(function (err) { console.error('GetPHSInformation failed', err); });
    }

    function getProjectScopePayload(projectId, page, size) {
        return {
            ProjectID: toInt(projectId),
            ReportingEndDate: getReportingDate() || null,
            EmployeeID: EmployeeID,
            LoginType: LoginType,
            PageNumber: page || 1,
            PageSize: size || 5
        };
    }

    function loadKeyAchievement(projectId) {
        var pid = toInt(projectId || detailsProjectId);
        if (pid <= 0) {
            $('#tblkeyachievementbody').html(emptyRow(5, 'ProjectID is required.'));
            return $.Deferred().reject('ProjectID is required.').promise();
        }

        var payload = getProjectScopePayload(pid, pagerState.achievement.page, pagerState.achievement.size);
        $('#tblkeyachievementbody').html('<tr><td class="text-center" colspan="5">Loading...</td></tr>');

        return ajaxPost('/api/ProjectHealthDashboard/GetKeyAchievement', payload)
            .done(function (json) {
                // API: { message, data: { totalRecords, data: [...] } }
                var pData = getPaginatedData(json, 'data');
                var rows = pData.list || [];
                var html = '';

                if (rows.length && (apiVal(rows[0], 'Task', 'task') != null || apiVal(rows[0], 'TotalPlanned', 'totalPlanned') != null)) {
                    rows.forEach(function (r) {
                        html += '<tr>';
                        html += '<td>' + esc(apiVal(r, 'Task', 'task') || '') + '</td>';
                        html += '<td class="text-center">' + dash(apiVal(r, 'TotalPlanned', 'totalPlanned', 'TotalPlannedTasks')) + '</td>';
                        html += '<td class="text-center">' + dash(apiVal(r, 'completed', 'Completed', 'CompletedTasks')) + '</td>';
                        html += '<td class="text-center">' + dash(apiVal(r, 'ToBeCompleted', 'toBeCompleted', 'TobeCompletedTasks')) + '</td>';
                        html += '<td class="text-center">' + dash(apiVal(r, 'TaskSlipping', 'taskSlipping', 'SlippingTasks')) + '</td>';
                        html += '</tr>';
                    });
                } else if (rows.length) {
                    // Aggregate single-row shape (Task + Deliverables counts)
                    var row = rows[0] || {};
                    html += '<tr><td>Task</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'TotalPlannedTasks', 'totalPlanned', 'TotalPlanned')) + '</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'CompletedTasks', 'completed', 'Completed')) + '</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'TobeCompletedTasks', 'toBeCompleted', 'ToBeCompleted')) + '</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'SlippingTasks', 'taskSlipping', 'TaskSlipping')) + '</td></tr>';
                    html += '<tr><td>Deliverables</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'TotalPlannedDeliverables')) + '</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'CompletedDeliverables')) + '</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'TobeCompletedDeliverables')) + '</td>';
                    html += '<td class="text-center">' + dash(apiVal(row, 'SlippingDeliverables')) + '</td></tr>';
                }

                $('#tblkeyachievementbody').html(html || emptyRow(5));
                renderCustomPager($('#tblKeyAchievement'), pagerState.achievement, pData.total, function () {
                    loadKeyAchievement(pid);
                });
            })
            .fail(function (err) {
                console.error('GetKeyAchievement failed', err);
                $('#tblkeyachievementbody').html(emptyRow(5));
                renderCustomPager($('#tblKeyAchievement'), pagerState.achievement, 0, function () {
                    loadKeyAchievement(pid);
                });
            });
    }

    function loadIssueDetails(projectId) {
        var pid = toInt(projectId || detailsProjectId);
        if (pid <= 0) {
            $('#issuedetailbody').html(emptyRow(10, 'ProjectID is required.'));
            return $.Deferred().reject('ProjectID is required.').promise();
        }

        var payload = getProjectScopePayload(pid, pagerState.issue.page, pagerState.issue.size);
        $('#issuedetailbody').html('<tr><td class="text-center" colspan="10">Loading...</td></tr>');

        return ajaxPost('/api/ProjectHealthDashboard/GetIssueDetails', payload)
            .done(function (json) {
                // API: { message, data: { totalRecords, data: [...] } }
                var pData = getPaginatedData(json, 'data');
                var rows = pData.list || [];
                var html = '';
                var sums = [0, 0, 0, 0, 0, 0, 0, 0, 0];

                rows.forEach(function (obj) {
                    var vals = [
                        toInt(apiVal(obj, 'openissues', 'OpenIssues', 'Open')),
                        toInt(apiVal(obj, 'closeissues', 'CloseIssues', 'Closed')),
                        toInt(apiVal(obj, 'othersissues', 'OTHERSissues', 'Others')),
                        toInt(apiVal(obj, 'totalissues', 'TotalIssues', 'Total')),
                        toInt(apiVal(obj, 'lessThanFive', 'LessThanFive', 'UpTo5Days')),
                        toInt(apiVal(obj, 'betweenFiveAndTen', 'BetweenFiveAndTen', 'FiveTo10Days')),
                        toInt(apiVal(obj, 'moreThanTen', 'MoreThanTen', 'MoreThan10Days')),
                        toInt(apiVal(obj, 'shownToCustomer', 'ShownToCustomer')),
                        toInt(apiVal(obj, 'overDueIssues', 'OverDueIssues', 'TotalOverdueIssues'))
                    ];
                    vals.forEach(function (n, i) { sums[i] += n; });
                    html += '<tr>';
                    html += '<td>' + esc(apiVal(obj, 'type', 'Type', 'IssueType') || '') + '</td>';
                    vals.forEach(function (n) { html += '<td class="text-center">' + n + '</td>'; });
                    html += '</tr>';
                });

                if (rows.length) {
                    html += '<tr class="graybglight"><td><strong>Total</strong></td>';
                    sums.forEach(function (n) { html += '<td class="text-center">' + n + '</td>'; });
                    html += '</tr>';
                }

                $('#issuedetailbody').html(html || emptyRow(10));
                renderCustomPager($('#tblIssueDetails'), pagerState.issue, pData.total, function () {
                    loadIssueDetails(pid);
                });
            })
            .fail(function (err) {
                console.error('GetIssueDetails failed', err);
                $('#issuedetailbody').html(emptyRow(10));
                renderCustomPager($('#tblIssueDetails'), pagerState.issue, 0, function () {
                    loadIssueDetails(pid);
                });
            });
    }

    function pickSQERTField(row, camel, pascal) {
        if (!row) return null;
        if (row[camel] !== undefined && row[camel] !== null) return row[camel];
        if (row[pascal] !== undefined && row[pascal] !== null) return row[pascal];
        var key;
        for (key in row) {
            if (!Object.prototype.hasOwnProperty.call(row, key)) continue;
            if (String(key).toLowerCase() === String(camel).toLowerCase()) return row[key];
        }
        return null;
    }

    function bindSQERTSectionUI(json, targetSelector) {
        var $target = $(targetSelector || '#tblSQERTSection');
        var raw = json;
        if (typeof raw === 'string') {
            try { raw = JSON.parse(raw); } catch (e) { raw = {}; }
        }

        var list = [];
        if (raw && Array.isArray(raw.data)) list = raw.data;
        else if (raw && Array.isArray(raw.Data)) list = raw.Data;
        else if (Array.isArray(raw)) list = raw;
        else {
            var unwrapped = unwrapPayload(raw);
            if (Array.isArray(unwrapped)) list = unwrapped;
            else if (unwrapped && typeof unwrapped === 'object') list = [unwrapped];
        }

        var row = list[0] || null;
        if (!row) {
            $target.html(emptyRow(5));
            return;
        }

        var metrics = [
            { title: 'Scope', val: pickSQERTField(row, 'scope', 'Scope'), desc: pickSQERTField(row, 'scopeDesc', 'ScopeDesc') },
            { title: 'Quality', val: pickSQERTField(row, 'quality', 'Quality'), desc: pickSQERTField(row, 'qualityDesc', 'QualityDesc') },
            { title: 'Effort', val: pickSQERTField(row, 'effort', 'Effort'), desc: pickSQERTField(row, 'effortDesc', 'EffortDesc') },
            { title: 'Risk', val: pickSQERTField(row, 'risk', 'Risk'), desc: pickSQERTField(row, 'riskDesc', 'RiskDesc') },
            { title: 'Time', val: pickSQERTField(row, 'time', 'Time'), desc: pickSQERTField(row, 'timeDesc', 'TimeDesc') }
        ];

        var html = '';
        metrics.forEach(function (m) {
            var displayVal = (m.val === null || m.val === undefined || m.val === '') ? '-' : String(m.val);
            var desc = (m.desc === null || m.desc === undefined) ? '' : String(m.desc);
            html += '<tr>';
            html += '<td>' + esc(m.title) + '</td>';
            html += '<td class="text-center">' + esc(displayVal) + '</td>';
            html += '<td class="text-center">' + sqertDot(m.title, m.val) + '</td>';
            html += '<td class="text-center"><i class="fas fa-arrows-alt-h"></i></td>';
            html += '<td class="text-start">' + esc(desc) + '</td>';
            html += '</tr>';
        });
        $target.html(html);
    }

    function loadSQERTSection(projectId) {
        var payload = {
            ProjectID: toInt(projectId),
            ReportingDate: getReportingDate() || null,
            UserID: UserID,
            LoginType: LoginType
        };
        $('#tblSQERTSection').html('<tr><td class="text-center" colspan="5">Loading...</td></tr>');
        return ajaxPost('/api/ProjectHealthDashboard/GetSQERTSection', payload)
            .done(function (json) {
                bindSQERTSectionUI(json, '#tblSQERTSection');
            })
            .fail(function (err) {
                console.error('GetSQERTSection failed', err);
                $('#tblSQERTSection').html(emptyRow(5));
            });
    }

    function loadMilestoneDetails(projectId) {
        var pid = toInt(projectId || detailsProjectId);
        var payload = {
            ProjectID: pid,
            ReportingEndDate: getReportingDate() || null,
            EmployeeID: EmployeeID,
            LoginType: LoginType,
            PageNumber: pagerState.milestone.page,
            PageSize: pagerState.milestone.size
        };
        $('#MileStoneBinding').html('<tr><td class="text-center" colspan="9">Loading...</td></tr>');
        return ajaxPost('/api/ProjectHealthDashboard/GetMilestoneDetails', payload)
            .done(function (json) {
                var pData = getPaginatedData(json, 'milestones');
                var html = '';
                pData.list.forEach(function (obj) {
                    html += '<tr>';
                    html += '<td>' + esc(apiVal(obj, 'milestone', 'Milestone', 'MilestoneName', 'milestoneName')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'isReadyForBilling', 'IsReadyForBilling', 'ReadyForBilling', 'readyForBilling')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'billAmount', 'BillAmount', 'Amount', 'amount')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'PlannedStartDate', 'plannedStartDate')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'plannedEndDate', 'PlannedEndDate', 'PlannedCompletionDate', 'plannedCompletionDate')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'ActualStartDate', 'actualStartDate')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'ActualEndDate', 'actualEndDate')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'Slippage', 'slippage')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'MilestoneStatus', 'milestoneStatus')) + '</td>';
                    html += '</tr>';
                });
                $('#MileStoneBinding').html(html || emptyRow(9));
                renderCustomPager($('#tblMilestoneDetails'), pagerState.milestone, pData.total, function () {
                    loadMilestoneDetails(pid);
                });
            })
            .fail(function (err) {
                console.error('GetMilestoneDetails failed', err);
                $('#MileStoneBinding').html(emptyRow(9));
                renderCustomPager($('#tblMilestoneDetails'), pagerState.milestone, 0, function () {
                    loadMilestoneDetails(pid);
                });
            });
    }

    function loadActiveResources(projectId) {
        var pid = toInt(projectId || detailsProjectId);
        var payload = {
            ProjectID: pid,
            PageNumber: pagerState.resource.page,
            PageSize: pagerState.resource.size
        };
        $('#tblActiveResource').html('<tr><td class="text-center" colspan="5">Loading...</td></tr>');
        return ajaxPost('/api/ProjectHealthDashboard/GetActiveResources', payload)
            .done(function (json) {
                var pData = getPaginatedData(json, 'resources');
                var html = '';
                pData.list.forEach(function (obj) {
                    html += '<tr>';
                    html += '<td>' + esc(apiVal(obj, 'Resource', 'ResourceName', 'resource')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'StartDate', 'startDate')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'EndDate', 'endDate')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'WorkHrs', 'Work', 'workHrs')) + '</td>';
                    html += '<td>' + dash(apiVal(obj, 'ActualWorkHrs', 'ActualWork', 'actualWorkHrs')) + '</td>';
                    html += '</tr>';
                });
                $('#tblActiveResource').html(html || emptyRow(5));
                renderCustomPager($('#tblActiveResourceList'), pagerState.resource, pData.total, function () {
                    loadActiveResources(pid);
                });
            })
            .fail(function (err) {
                console.error('GetActiveResources failed', err);
                $('#tblActiveResource').html(emptyRow(5));
                renderCustomPager($('#tblActiveResourceList'), pagerState.resource, 0, function () {
                    loadActiveResources(pid);
                });
            });
    }

    function destroyChart(chart) {
        if (chart && typeof chart.destroy === 'function') chart.destroy();
        return null;
    }

    function loadTaskVsCompletionGraph(projectId) {
        var payload = { ProjectID: projectId, CurrentDate: getReportingDate() || null };
        return ajaxPost('/api/ProjectHealthDashboard/GetTaskVsCompletionGraph', payload)
            .done(function (json) {
                var rows = extractList(unwrapPayload(json), ['TaskVsCompletionModel']);
                var labels = [];
                var values = [];
                rows.forEach(function (r) {
                    labels.push(apiVal(r, 'ActualPercentComplete', 'label', 'Label') || '');
                    values.push(toInt(apiVal(r, 'TotalTasks', 'value', 'Value', 'count')));
                });
                chartCompletion = destroyChart(chartCompletion);
                var ctx = document.getElementById('CompletionstatusGraph');
                if (!ctx) return;
                ctx.width = 300;
                ctx.height = 240;
                chartCompletion = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: values,
                            backgroundColor: ['#afd037', '#ffce56', '#36a2eb', '#eb1c24', '#4bc0c0', '#87c9eb'],
                            borderColor: ['#fff', '#fff', '#fff', '#fff', '#fff', '#fff'],
                            borderWidth: 0
                        }]
                    },
                    options: {
                        cutoutPercentage: 60,
                        responsive: false,
                        maintainAspectRatio: false,
                        legend: { display: true, position: 'right' }
                    }
                });
            })
            .fail(function (err) { console.error('GetTaskVsCompletionGraph failed', err); });
    }

    function loadDelayInDaysGraph(projectId) {
        var payload = { ProjectID: projectId, CurrentDate: getReportingDate() || null };
        return ajaxPost('/api/ProjectHealthDashboard/GetDelayInDaysGraph', payload)
            .done(function (json) {
                var rows = extractList(unwrapPayload(json), ['DelayInDaysModel']);
                var labels = [];
                var values = [];
                rows.forEach(function (r) {
                    labels.push(apiVal(r, 'DelayInterval', 'label', 'Label') || '');
                    values.push(toInt(apiVal(r, 'DelayCount', 'value', 'Value', 'count')));
                });
                chartDelay = destroyChart(chartDelay);
                var ctx = document.getElementById('DelayinDayschart');
                if (!ctx) return;
                ctx.width = 300;
                ctx.height = 240;
                chartDelay = new Chart(ctx.getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{ label: 'Delay Count', backgroundColor: '#fbb03b', data: values }]
                    },
                    options: {
                        responsive: false,
                        maintainAspectRatio: false,
                        scales: {
                            xAxes: [{ maxBarThickness: 50, barPercentage: 0.6 }],
                            yAxes: [{ ticks: { min: 0 } }]
                        }
                    }
                });
            })
            .fail(function (err) { console.error('GetDelayInDaysGraph failed', err); });
    }

    function loadMonthlyResourceCostGraph(projectId) {
        var payload = { ProjectID: projectId, CurrentDate: getReportingDate() || null };
        return ajaxPost('/api/ProjectHealthDashboard/GetMonthlyResourceCostGraph', payload)
            .done(function (json) {
                var rows = extractList(unwrapPayload(json), ['MonthlyResourceCostModel']);
                var labels = [];
                var values = [];
                rows.forEach(function (r) {
                    labels.push(apiVal(r, 'Month', 'label', 'Label') || '');
                    values.push(toInt(apiVal(r, 'ResourceCost', 'value', 'Value')));
                });
                chartCost = destroyChart(chartCost);
                var ctx = document.getElementById('MonthlyResourceCostChart');
                if (!ctx) return;
                ctx.width = 300;
                ctx.height = 240;
                chartCost = new Chart(ctx.getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{ label: 'Resource Cost', backgroundColor: '#fbb03b', data: values }]
                    },
                    options: {
                        responsive: false,
                        maintainAspectRatio: false,
                        scales: {
                            xAxes: [{ maxBarThickness: 50, barPercentage: 0.6 }],
                            yAxes: [{ ticks: { min: 0 } }]
                        }
                    }
                });
            })
            .fail(function (err) { console.error('GetMonthlyResourceCostGraph failed', err); });
    }

    function resetPhsDetailTabs() {
        phsTabLoaded = {};
        pagerState.achievement.page = 1;
        pagerState.issue.page = 1;
        pagerState.milestone.page = 1;
        pagerState.resource.page = 1;
        $('#phsPagerAchievement, #phsPagerIssue, #phsPagerMilestone, #phsPagerResource')
            .find('.phs-total-records, .spntotal').text('Total Records: 0');
        $('#phsPagerAchievement, #phsPagerIssue, #phsPagerMilestone, #phsPagerResource')
            .find('.page-item').addClass('disabled');
        $('#phsDetailTabs a.nav-link').removeClass('active').attr('aria-selected', 'false');
        $('#phsDetailTabContent .tab-pane').removeClass('show active');
        $('#phs-tab-info').addClass('active').attr('aria-selected', 'true');
        $('#PHSInfo').addClass('show active');
    }

    function loadPhsTabByKey(tabKey, force) {
        var projectId = detailsProjectId;
        if (!projectId) return;
        if (!force && phsTabLoaded[tabKey]) return;
        phsTabLoaded[tabKey] = true;

        switch (tabKey) {
            case 'info':
                loadPHSInformation(projectId);
                break;
            case 'achievement':
                pagerState.achievement.page = 1;
                loadKeyAchievement(projectId);
                break;
            case 'issue':
                pagerState.issue.page = 1;
                loadIssueDetails(projectId);
                break;
            case 'sqert':
                loadSQERTSection(projectId);
                break;
            case 'milestone':
                pagerState.milestone.page = 1;
                loadMilestoneDetails(projectId);
                break;
            case 'resource':
                pagerState.resource.page = 1;
                loadActiveResources(projectId);
                break;
            case 'graph':
                loadTaskVsCompletionGraph(projectId);
                loadDelayInDaysGraph(projectId);
                loadMonthlyResourceCostGraph(projectId);
                break;
        }
    }

    function loadProjectDetails(projectId) {
        detailsProjectId = toInt(projectId);
        if (!detailsProjectId) return;
        resetPhsDetailTabs();
        loadPhsTabByKey('info', true);
    }

    window.openPHSProjectDetails = function (projectId, linkEl) {
        selectedProjectID = toInt(projectId);
        $('a.phs-link-active').removeClass('phs-link-active');
        $('table tr').removeClass('rowhiglight');
        var $link = linkEl ? $(linkEl) : $('a.phs-detail-link[data-project-id="' + toInt(projectId) + '"]').first();
        if ($link && $link.length) {
            $link.addClass('phs-link-active');
            $link.closest('tr').addClass('rowhiglight');
        }
        if (typeof editPHSDetail === 'function') editPHSDetail();
        loadProjectDetails(selectedProjectID);
    };

    $(document).on('shown.bs.tab', '#phsDetailTabs a[data-bs-toggle="tab"]', function (e) {
        var tabKey = $(e.target).attr('data-phs-tab') || 'info';
        loadPhsTabByKey(tabKey, false);
    });

    function applyDashboardData() {
        selectedProjectID = getSelectedProjectId();
        pagerState.sqert.page = 1;
        pagerState.unlocked.page = 1;
        loadKPISummary();
        loadSQERTList();
        loadProjectsPendingLock();
    }

    function clearAllFilters() {
        $('#txtPHSFilterProjectType, #txtPHSFilterBusinessGroup, #txtPHSFilterLocation, #txtPHSFilterProjectGroupName, #txtPHSFilterProjectName').val('0');
        refreshSelect($('#txtPHSFilterProjectType'));
        refreshSelect($('#txtPHSFilterBusinessGroup'));
        refreshSelect($('#txtPHSFilterLocation'));
        refreshSelect($('#txtPHSFilterProjectGroupName'));
        refreshSelect($('#txtPHSFilterProjectName'));
        //  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        phsSqertSelectedIds = [];
        phsUnlockedSelectedIds = [];
        phsMselState.sqert.search = '';
        phsMselState.unlocked.search = '';
        phsMselState.sqert.open = false;
        phsMselState.unlocked.open = false;
        renderPhsProjectMsel('sqert');
        renderPhsProjectMsel('unlocked');
        $('#txtPHSFilterReportingDate').datepicker('setDate', new Date());
        phsEditFilterID = 0;
        phsGlobalFilterName = '';
        phsWhereClause = '';
        applyDashboardData();
    }

    /* ---------- My Filters ---------- */
    function loadMyFilterList() {
        var payload = {
            ProjectID: getSelectedProjectId(),
            TagID: PageTagID,
            LoginType: LoginType,
            EmployeeID: EmployeeID
        };
        return ajaxPost('/api/ProjectHealthDashboard/GetMyFilterList', payload)
            .done(function (json) {
                var rows = extractList(unwrapPayload(json), ['MyFilterModel', 'filters']);
                var html = '';
                rows.forEach(function (item) {
                    var fid = apiVal(item, 'FilterId', 'FilterID', 'filterId');
                    var fname = apiVal(item, 'FilterName', 'filterName') || '';
                    var isDefault = apiVal(item, 'SetDefault', 'setDefault') === true || apiVal(item, 'SetDefault') === 'true';
                    html += '<li>';
                    html += '<label class="customradio">';
                    html += '<input class="myfilter_selectprocheckbox myfilter_setdefaultcheckbox" type="radio" name="phsDefaultFilter" data-filterid="' + esc(fid) + '"' + (isDefault ? ' checked' : '') + '>';
                    html += '<span class="checkmark" title="Set Default filter"></span></label>';
                    html += '<label><span class="radiotextsty filtername">' + esc(fname) + '</span></label>';
                    html += '<div class="issfilter_actiondropdown">';
                    html += '<div class="custom_chckbox_markblue"><input type="checkbox" class="phs-apply-filter"' + (isDefault ? ' checked' : '') + '>';
                    html += '<label title="Apply filter" data-filterid="' + esc(fid) + '" class="phs-apply-filter-lbl"></label></div>';
                    html += '<span class="edit_filter" data-filterid="' + esc(fid) + '" data-filtername="' + esc(fname) + '"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" title="Edit filter"></span>';
                    html += '<span class="phs-delete-filter" data-filterid="' + esc(fid) + '"><i class="far fa-trash-alt" title="Delete filter"></i></span>';
                    html += '</div></li>';
                });
                $('#MyFiltersdropdown').html(html || '<li class="px-3 py-2">No saved filters</li>');
            })
            .fail(function (err) { console.error('GetMyFilterList failed', err); });
    }

    function applyFilterById(filterId) {
        var payload = { FilterID: toInt(filterId) };
        return ajaxPost('/api/ProjectHealthDashboard/GetFilterByID', payload)
            .done(function (json) {
                var data = unwrapPayload(json);
                if (Array.isArray(data)) data = data[0] || {};
                phsWhereClause = apiVal(data, 'WhereClause', 'QueryText', 'whereClause') || '';
                phsEditFilterID = toInt(apiVal(data, 'FilterID', 'FilterId', 'filterId'));
                phsGlobalFilterName = apiVal(data, 'FilterName', 'filterName') || '';
                applyDashboardData();
            })
            .fail(function (err) { console.error('GetFilterByID failed', err); });
    }

    function setDefaultFilter(filterId) {
        var payload = {
            ProjectID: String(getSelectedProjectId()),
            TagID: String(PageTagID),
            LoginType: LoginType,
            UserID: String(UserID),
            ChangeDefaultFilterID: String(filterId),
            Flag: 0
        };
        ajaxPost('/api/ProjectHealthDashboard/SetDefaultFilter', payload)
            .done(function () { loadMyFilterList(); })
            .fail(function (err) { console.error('SetDefaultFilter failed', err); });
    }

    function deleteFilter(filterId) {
        if (!confirm('Delete this filter?')) return;
        ajaxPost('/api/ProjectHealthDashboard/DeleteFilter', { FilterID: toInt(filterId) })
            .done(function () { loadMyFilterList(); })
            .fail(function (err) { console.error('DeleteFilter failed', err); });
    }

    function checkDefaultFilterSetOrNot() {
        var payload = {
            TagID: PageTagID,
            LoginType: LoginType,
            ProjectID: getSelectedProjectId(),
            UserID: UserID
        };
        return ajaxPost('/api/ProjectHealthDashboard/CheckDefaultFilterSetOrNot', payload)
            .fail(function (err) { console.error('CheckDefaultFilterSetOrNot failed', err); });
    }

    function loadPHSDefaultFilter() {
        var payload = {
            TagID: PageTagID,
            LoginType: LoginType,
            ProjectID: getSelectedProjectId(),
            EmployeeID: EmployeeID
        };
        return ajaxPost('/api/ProjectHealthDashboard/GetPHSDefaultFilter', payload)
            .done(function (json) {
                var data = unwrapPayload(json);
                if (Array.isArray(data)) data = data[0] || {};
                var fid = apiVal(data, 'FilterID', 'FilterId', 'filterId');
                if (fid) {
                    phsEditFilterID = toInt(fid);
                    phsWhereClause = apiVal(data, 'WhereClause', 'QueryText') || '';
                    $('.clearalllink').css('display', 'inline-block');
                }
            })
            .fail(function (err) { console.error('GetPHSDefaultFilter failed', err); });
    }

    function checkFilterNameExists(filterName) {
        var payload = {
            TagID: PageTagID,
            LoginType: LoginType,
            ProjectID: getSelectedProjectId(),
            EmployeeID: EmployeeID,
            FilterName: filterName
        };
        return ajaxPost('/api/ProjectHealthDashboard/CheckFilterNameExists', payload);
    }

    function closeSaveFilterOffcanvas() {
        var offcanvasEl = document.getElementById('Issuesavefilter');
        if (!offcanvasEl || !window.bootstrap || !bootstrap.Offcanvas) return;
        var instance = bootstrap.Offcanvas.getInstance(offcanvasEl);
        if (instance) instance.hide();
    }

    function savePHSFilter() {
        var filterName = $('#txtFilterName').val().trim();
        if (!filterName) {
            alert('Please enter filter name.');
            $('#txtFilterName').focus();
            return;
        }
        phsWhereClause = buildPHSWhereClause();
        var flag = (phsGlobalFilterName && filterName === phsGlobalFilterName) ? 1 : 0;
        var filterId = flag === 1 ? (phsEditFilterID || 0) : 0;

        function postSave() {
            var payload = {
                TagID: PageTagID,
                ProjectID: getSelectedProjectId(),
                EmployeeID: EmployeeID,
                FilterName: filterName,
                LoginType: LoginType,
                WhereClause: phsWhereClause,
                CreatedBy: String(CreatedBy),
                Flag: flag,
                FilterID: filterId
            };
            ajaxPost('/api/ProjectHealthDashboard/SaveFilter', payload)
                .done(function (json) {
                    var data = unwrapPayload(json);
                    phsEditFilterID = toInt(apiVal(data, 'filterId', 'FilterID', 'FilterId'));
                    phsGlobalFilterName = filterName;
                    alert((json && json.message) || 'Filter saved successfully');
                    closeSaveFilterOffcanvas();
                    $('.clearalllink').css('display', 'inline-block');
                    loadMyFilterList();
                    applyDashboardData();
                })
                .fail(function (err) {
                    console.error('SaveFilter failed', err);
                    alert('Unable to save filter. Please try again.');
                });
        }

        if (flag === 0) {
            checkFilterNameExists(filterName)
                .done(function (json) {
                    var data = unwrapPayload(json);
                    var exists = apiVal(data, 'exists', 'Exists', 'isExists') === true || data === 1 || data === true;
                    if (exists) {
                        alert('Filter name already exists.');
                        return;
                    }
                    postSave();
                })
                .fail(function () { postSave(); });
        } else {
            postSave();
        }
    }

    function formatToday() {
        var d = new Date();
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        var day = ('0' + d.getDate()).slice(-2);
        return day + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
    }

    function formatSqertTillDate(value) {
        var d = null;
        if (value instanceof Date && !isNaN(value.getTime())) {
            d = value;
        } else if (value) {
            var parsed = Date.parse(value);
            if (!isNaN(parsed)) d = new Date(parsed);
        }
        if (!d) d = new Date();
        if ($.datepicker && typeof $.datepicker.formatDate === 'function') {
            return $.datepicker.formatDate('dd-mm-yy', d);
        }
        var dd = ('0' + d.getDate()).slice(-2);
        var mm = ('0' + (d.getMonth() + 1)).slice(-2);
        return dd + '-' + mm + '-' + d.getFullYear();
    }

    function setSqertDetailsTitle() {
        $('#sqertDetailsTitle').text('SQERT Details till ' + formatSqertTillDate(new Date()));
    }

    function resolveConfig() {
        strUrl = String(window.PHS_API_BASE || '').trim();
        if (strUrl && strUrl.charAt(strUrl.length - 1) === '/') {
            strUrl = strUrl.slice(0, -1);
        }
        PageTagID = parseInt(window.PHS_TAG_ID, 10) || 3068;
        UserID = parseInt(window.PHS_USER_ID, 10) || 0;
        LoginType = window.PHS_LOGIN_TYPE || '';
        EmployeeID = UserID || null;
        CreatedBy = UserID;
        selectedProjectID = parseInt(window.PHS_PROJECT_ID, 10) || 0;
        if (!reportingDate) reportingDate = formatToday();
    }

    function finishPhsPageLoad() {
        if (typeof hidePhsLoader === 'function') hidePhsLoader();
        if (typeof hidePhsPreloader === 'function') hidePhsPreloader();
        else {
            $('#PHSPreloader').hide();
            $('#phsPageWrapper').show();
        }
    }

    $(document).ready(function () {
        resolveConfig();
        initPhsSummaryTooltips();
        setSqertDetailsTitle();
        console.log('PHS init', { apiBase: strUrl, userId: UserID, loginType: LoginType, projectId: selectedProjectID });

        if (!strUrl) {
            console.error('Project Health Sheet: WebAPIUrl-W27_Dashboard / PHS_API_BASE is empty. APIs will not be called.');
            finishPhsPageLoad();
            return;
        }

        if (typeof showPhsLoader === 'function') showPhsLoader();

        if ($.fn.datepicker) {
            $('#txtPHSFilterReportingDate').datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy'
            });
            $('#txtPHSFilterReportingDate').datepicker('setDate', new Date());
        }

        $('#txtPHSFilterBusinessGroup').on('change', function () {
            loadOrganizationUnits().always(function () { loadFilteredProjects(); });
        });
        $('#txtPHSFilterProjectType, #txtPHSFilterLocation, #txtPHSFilterProjectGroupName').on('change', function () {
            loadFilteredProjects();
        });
        $('#txtPHSFilterProjectName').on('change', function () {
            selectedProjectID = toInt($(this).val());
            $('#CboProject').val(String(selectedProjectID));
            refreshSelect($('#CboProject'));
        });
        $('#CboProject').on('change', function () {
            selectedProjectID = toInt($(this).val());
            $('#txtPHSFilterProjectName').val(String(selectedProjectID));
            refreshSelect($('#txtPHSFilterProjectName'));
            applyDashboardData();
        });
        $(document).on('click.phsMsel', function () {
            closePhsProjectMsels();
        });
        renderPhsProjectMsel('sqert');
        renderPhsProjectMsel('unlocked');

        $('#btnApplyFilter').on('click', function () {
            applyDashboardData();
            $('.clearalllink').css('display', 'inline-block');
        });
        $('#svfilterbtn').on('click', function () {
            phsWhereClause = buildPHSWhereClause();
            $('#txtFilterName').val(phsGlobalFilterName || '');
            var offcanvasEl = document.getElementById('Issuesavefilter');
            if (offcanvasEl && window.bootstrap && bootstrap.Offcanvas) {
                bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).show();
            }
        });
        $('#savefilterbtn').on('click', function (e) {
            e.preventDefault();
            savePHSFilter();
        });
        $('#PHSClearAllFilter').on('click', function () { clearAllFilters(); });

        $(document).on('click', '.myfilter_setdefaultcheckbox', function () {
            setDefaultFilter($(this).data('filterid'));
        });
        $(document).on('click', '.phs-apply-filter-lbl', function () {
            applyFilterById($(this).data('filterid'));
        });
        $(document).on('click', '.phs-delete-filter', function () {
            deleteFilter($(this).data('filterid'));
        });
        $(document).on('click', '.edit_filter', function () {
            phsEditFilterID = toInt($(this).data('filterid'));
            phsGlobalFilterName = $(this).data('filtername') || '';
            $('#txtFilterName').val(phsGlobalFilterName);
            applyFilterById(phsEditFilterID);
            var offcanvasEl = document.getElementById('Issuesavefilter');
            if (offcanvasEl && window.bootstrap && bootstrap.Offcanvas) {
                bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).show();
            }
        });
        $('a[href="#basicfilters"]').on('shown.bs.tab', function () { });
        $('#MyFilter').on('click', function () {
            loadMyFilterList();
        });

        $.when(
            loadSQERTRange() || $.Deferred().resolve().promise(),
            loadReportingFrequency() || $.Deferred().resolve().promise(),
            loadFilterMasters() || $.Deferred().resolve().promise(),
            loadProjectList() || $.Deferred().resolve().promise()
        )
            .always(function () {
                try { loadOrganizationUnits(); } catch (e1) { console.error(e1); }
                try { loadFilteredProjects(); } catch (e2) { console.error(e2); }
                try { loadMyFilterList(); } catch (e3) { console.error(e3); }
                try { checkDefaultFilterSetOrNot(); } catch (e4) { console.error(e4); }

                var defaultFilterPromise;
                try {
                    defaultFilterPromise = loadPHSDefaultFilter();
                } catch (e5) {
                    console.error(e5);
                    defaultFilterPromise = null;
                }

                $.when(defaultFilterPromise || $.Deferred().resolve().promise())
                    .always(function () {
                        try { applyDashboardData(); } catch (e6) { console.error(e6); }
                        finishPhsPageLoad();
                    });
            });
    });

    setTimeout(finishPhsPageLoad, 8000);
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
