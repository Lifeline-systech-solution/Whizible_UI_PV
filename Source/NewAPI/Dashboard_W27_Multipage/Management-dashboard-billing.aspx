<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Management-dashboard-billing.aspx.vb" Inherits="Whizible.Management_dashboard_billing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- <script type="text/javascript">
      window.location.replace('../PM/PM_UnderConstruction.aspx');
    </script> -->
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
        body {
            background-color: #ffffff;
            background: #ffffff;
        }

        .form-inline{
            display: flex;
            flex-wrap: wrap;
            align-items: center;
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

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        tr.rowhiglight {
            background: #c3dbff;
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

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
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



        /*New css end here*/

        .lightgraybg {
            background: #f5f5f5;
        }

        /*Information table start here*/
        .informationtbl {
            margin-bottom: 15px
        }

            .informationtbl tr th {
                text-align: right;
                font-weight: 400;
                color: #6a9bff;
            }

        body .informationtbl tr td {
            text-align: left
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px
        }

        body .informationtbl tr td.pr-3 {
            padding-right: 3em
        }

        table.informationtbl {
            width: 100%
        }

        td.Agpm {
            color: #eb1c24
        }

        .togglerup .collapseup {
            display: block;
        }
        .togglerup .collapsedown {
            display: none;
        }
        .togglerdown .collapsedown {
            display: block;
        }
        .togglerdown .collapseup {
            display: none;
        }
        .infoToggler { margin: 5px 0 0; }
        .hideprofitabilityinfo { position: absolute; right: 10px; top: 50%; transform: translateY(-50%); margin: 0; }
        .profitabilityinfopanel { margin-bottom: 16px; }
        .profitabilityinfopanel .panel.panel-default { padding: 0; position: relative; }
        .profitabilityinfopanel .panel.lightgraybg { background: transparent; }
        .profitabilityinfopanel .panel-collapse,
        .profitabilityinfopanel .panel-body {
            background: #ffffff !important;
        }
        .profitabilityinfopanel .panel-default > .panel-heading {
            padding: 0;
            background: #e7edf0;
            cursor: pointer;
        }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title { margin: 0; font-size: 14px; }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title > a {
            display: block;
            width: 100%;
            padding: 10px 40px 10px 12px;
            color: #464a4c;
            text-decoration: none;
            position: relative;
        }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title > a:hover,
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title > a:focus {
            color: #464a4c;
            text-decoration: none;
        }
        .profitabilityinfopanel .panel-default > .panel-heading a span img { opacity: 0.5; }
        .profitabilityinfopanel .panel-default > .panel-heading a span img:hover { opacity: 1; }
        #TabGrossProfit > .table-responsive,
        #invoicesubdashdetail > .offcanvas-body > .table-responsive {
            margin-bottom: 12px;
        }
        /*Information table End here*/
        .informationtbl td, .informationtbl th {
            vertical-align: top !important;
            font-size: 11.5px;
            line-height: normal
        }

        .informationtbl tr th {
            min-width: 120px
        }

        tr.totalrow {
            background: #ccc
        }
    
        .management-dashboard-page {
            background: #ffffff;
            min-height: auto;
        }

        .management-dashboard-header {
            align-items: center;
            background: #fff;
            border-bottom: 1px solid #eef2f7;
            box-shadow: rgba(0, 0, 0, 0.06) 0 5px 5px -3px, rgba(0, 0, 0, 0.043) 0 8px 10px 1px, rgba(0, 0, 0, 0.035) 0 3px 14px 2px;
            display: flex;
            justify-content: space-between;
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

        .management-dashboard-actions {
            align-items: center;
            display: flex;
            gap: 0.75rem;
        }

        .management-dashboard-actions .clearalllink {
            margin: 0;
        }

        .management-dashboard-filter-btn {
            background: #fff;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            color: #1359a6;
            padding: 6px 10px;
        }
    
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

        /* Project Billing grid alignment + narrow currency dropdown */
        .billing-grid-wrap {
            width: 100%;
            overflow-x: auto;
        }
        #dashBillingTbl.dashbillingTbllist {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        #dashBillingTbl.dashbillingTbllist th,
        #dashBillingTbl.dashbillingTbllist td {
            vertical-align: middle !important;
            padding: 8px 6px;
            border: 1px solid #dee2e6;
        }
        #dashBillingTbl.dashbillingTbllist thead th {
            text-align: center;
            background: #f8f9fa;
            font-weight: 600;
            white-space: normal;
            line-height: 1.25;
        }
        #dashBillingTbl.dashbillingTbllist thead th.th-company {
            text-align: left;
            width: 160px;
        }
        #dashBillingTbl.dashbillingTbllist thead th.th-currency {
            text-align: center;
            width: 92px;
        }
        #dashBillingTbl.dashbillingTbllist thead th.th-no {
            width: 42px;
            text-align: center;
        }
        #dashBillingTbl.dashbillingTbllist thead th.th-amt {
            width: 100px;
            text-align: center;
        }
        #dashBillingTbl.dashbillingTbllist td.compname {
            text-align: left;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 160px;
        }
        #dashBillingTbl.dashbillingTbllist td.currency-cell {
            text-align: center !important;
            vertical-align: middle !important;
            width: 92px !important;
        }
        #dashBillingTbl.dashbillingTbllist td.currency-cell .currency-wrap {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
        }
        #dashBillingTbl.dashbillingTbllist td.currency-cell .bootstrap-select,
        #dashBillingTbl.dashbillingTbllist td.currency-cell select.billing-currency {
            width: 100% !important;
            max-width: 78px !important;
            min-width: 0 !important;
            display: inline-block !important;
            float: none !important;
            margin: 0 !important;
        }
        #dashBillingTbl.dashbillingTbllist td.col-no {
            text-align: center !important;
            width: 42px;
            white-space: nowrap;
        }
        /* Large values wrap inside the cell instead of spilling over the border */
        #dashBillingTbl.dashbillingTbllist td.col-amt {
            text-align: right !important;
            width: 100px;
            white-space: normal;
            overflow-wrap: anywhere;
        }
        #dashBillingTbl.dashbillingTbllist td.col-amt .amt-val {
            overflow-wrap: anywhere;
        }
        #dashBillingTbl.dashbillingTbllist td.col-amt .amt-cur {
            white-space: nowrap;
        }
        .billing-currency-combo,
        .billing-currency-combo + .dropdown-toggle,
        .bootstrap-select.billing-currency-combo {
            width: 100% !important;
            max-width: 78px !important;
            min-width: 0 !important;
        }
        #dashBillingTbl .bootstrap-select.billing-currency-combo .dropdown-toggle {
            padding: 4px 18px 4px 6px;
            font-size: 12px;
            height: 30px;
            line-height: 1.2;
        }
        a.billing-metric-link,
        a.billing-customer-link {
            color: #0d6efd;
            text-decoration: underline !important;
            cursor: pointer;
        }
        a.billing-metric-link:hover,
        a.billing-customer-link:hover {
            color: #0a58ca;
            text-decoration: underline !important;
        }
        a.billing-metric-link.oc-link-active,
        a.billing-customer-link.oc-link-active {
            color: #084298;
            text-decoration: underline !important;
            font-weight: 700;
        }

        /* Project Health Sheet-style paging for billing drill-down tables */
        .billing-detail-footer {
            margin: 10px 0 0;
            align-items: center;
        }
        .billing-detail-footer .spntotal {
            font-size: 12px;
            font-weight: 600;
            color: #374151;
            white-space: nowrap;
        }
        .billing-detail-footer .pagination {
            margin: 0;
        }
        .billing-detail-footer .page-link {
            cursor: pointer;
            color: #1359a6;
            border: 1px solid #dee2e6;
            padding: 0.25rem 0.55rem;
            font-size: 12px;
        }
        .billing-detail-footer .page-item.disabled .page-link {
            color: #9ca3af;
            pointer-events: none;
            background: #f9fafb;
        }

        /* MyAlerts-style near full-page offcanvas */
        #invoicedashdetail {
            --bs-offcanvas-width: 85% !important;
            width: 85% !important;
            max-width: 1200px !important;
        }
        /* When 2nd offcanvas is open, 1st behaves like main screen (dimmed) */
        #invoicedashdetail.offcanvas-as-main {
            pointer-events: none;
        }
        #invoicedashdetail .billing-parent-scrim {
            display: none;
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 30;
            cursor: pointer;
            pointer-events: auto;
        }
        #invoicedashdetail.offcanvas-as-main .billing-parent-scrim {
            display: block;
        }
        body.offcanvas-nested .offcanvas-backdrop.show {
            opacity: 0.5;
            cursor: pointer;
        }
        #invoicesubdashdetail {
            --bs-offcanvas-width: 70% !important;
            width: 70% !important;
            max-width: 900px !important;
            z-index: 1055 !important;
        }
        #invoicedashdetail .offcanvas-body,
        #invoicesubdashdetail .offcanvas-body {
            padding: 0 1rem 1rem;
            background-color: #fff;
        }
        #invoicedashdetail .pgtitle,
        #invoicesubdashdetail .pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }
        @media (max-width: 768px) {
            #invoicedashdetail {
                --bs-offcanvas-width: 95% !important;
                width: 95% !important;
                max-width: 100% !important;
            }
            #invoicesubdashdetail {
                --bs-offcanvas-width: 92% !important;
                width: 92% !important;
                max-width: 100% !important;
            }
        }

        /* Plan vs Actual / Project Profit By Customer filter format */
        .billing-filter-bar {
            overflow: visible;
            margin-bottom: 16px;
        }
        .billing-filter-wrap {
            display: flex;
            flex-wrap: nowrap;
            align-items: flex-end;
            gap: 16px;
            width: 100%;
        }
        .billing-filter-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
            margin: 0;
            min-width: 0;
            flex: 1 1 0;
            width: 33.333%;
        }
        .billing-filter-group > label {
            display: block;
            font-size: 11px;
            letter-spacing: .4px;
            color: #4b5563;
            font-weight: 600;
            margin: 0;
            white-space: nowrap;
            line-height: 1.2;
        }
        .billing-filter-group .msel {
            position: relative;
            width: 100%;
            min-width: 0;
        }
        .billing-filter-group .msel-panel {
            width: 100%;
            min-width: 220px;
            z-index: 2055;
        }
        .msel { position: relative; }
        .msel-btn {
            width: 100%;
             /* <!-- Added By Madhuri.K on 24-08-2026 --> */
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            padding: 6px 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            color: #1a2536;
            font-size: 11.5px;
            text-align: left;
            cursor: pointer;
            white-space: nowrap;
            overflow: hidden;
            box-sizing: border-box;
            outline: none;
            box-shadow: none;
        }
        .msel-btn:hover,
        .msel-btn:focus {
            border-color: #1359a6;
            outline: none;
        }
        .msel-btn > span:first-child {
            min-width: 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .msel-btn .count {
            flex: 0 0 auto;
            padding: 1px 7px;
            border-radius: 10px;
            background: #1359a6;
            color: #fff;
            font-size: 10px;
            font-weight: 600;
        }
        .msel-btn .chev {
            flex: 0 0 auto;
            color: #6b7280;
            font-size: 10px;
            line-height: 1;
        }
        .msel-btn .chev i { font-size: 10px; }
        .msel-panel {
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            z-index: 2055;
            display: none;
            width: 100%;
            min-width: 220px;
            max-height: 260px;
            padding: 8px;
            overflow-y: auto;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            background: #fff;
            box-shadow: 0 8px 24px rgba(20,30,50,.14);
        }
        .msel-panel.open { display: block; }
        .msel-search {
            position: sticky;
            top: -8px;
            z-index: 2;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 6px;
            padding: 6px 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            font-size: 11.5px;
        }
        .msel-search:focus {
            border-color: #1359a6;
            outline: none;
        }
        .msel-empty {
            padding: 10px 8px;
            font-size: 11.5px;
            color: #6b7280;
            text-align: center;
        }
        .msel-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0;
            padding: 6px 8px;
            border-radius: 4px;
            color: #374151;
            font-size: 11.5px;
            font-weight: 400;
            cursor: pointer;
        }
        .msel-row:hover { background: #f1f5f9; }
        .msel-row input { margin: 0; }
        .msel-actions {
            position: sticky;
            bottom: -8px;
            display: flex;
            justify-content: space-between;
            margin-top: 6px;
            padding: 4px 6px 2px;
            border-top: 1px solid #e5e7eb;
            background: #fff;
        }
        .msel-actions button {
            padding: 4px;
            border: 0;
            background: none;
            color: #1359a6;
            font-size: 11.5px;
            font-weight: 600;
            cursor: pointer;
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
    <%'If m_blnViewAccess = True Then%>
        <div id="BillingPagePreloader" class="preloader" aria-label="Loading"></div>
        <div class="loader-overlay" id="loaderOverlay" style="display:none;"><div class="loader"></div></div>
       
    <div id="BillingPageWrapper" class="bgwhite management-dashboard-page" style="display:none;">

            <div class="management-dashboard-current-page">
                <div>
                    <h3 class="management-dashboard-current-title">
                        <i class="fas fa-file-invoice-dollar" data-bs-toggle="tooltip" title="Project Billing"></i>
                        Project Billing
                    </h3>
                    <p class="management-dashboard-current-note">Monitor billing, invoice details, and financial dashboard summaries.</p>
                </div>
            </div>



     
            <div class="innerpgiframe">
                <!--filter panel-->
                <div id="filterpanel" class="filterpanel collapse">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                                    <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-bs-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproOne" type="checkbox" name="">
                                                    <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproOne" data-bs-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-bs-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="task" class="radiotextsty">Task and milestones</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproTwo" type="checkbox" name="">
                                                    <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproTwo" data-bs-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-bs-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="groupcompany" class="radiotextsty">For group company</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproThree" type="checkbox" name="">
                                                    <label data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" for="IssueselproThree" data-bs-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="">
                                    <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                                </li>


                            </ul>
                        </div>

                        <div class="Fwrapper">
                            <div class="tab-content">
                                <div id="basicfilters" class="tab-pane">
                                    <div class="filterpanelbody">
                                        <div class="text-center hidden-xs centerbtn">
                                            <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="offcanvas" data-bs-target="#Issuesavefilter">Save and Apply</button>
                                            <button class="btn btnyellow">Apply</button>
                                        </div>
                                        <br />

                                        <div class="row">
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Group</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>=</option>
                                                            <option><></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>&nbsp;</option>
                                                            <option>Work Profile</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Value</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input class="form-control input-sm" type="text" id="Fparavalue" />
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Order Number</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>=</option>
                                                            <option><=</option>
                                                            <option><></option>
                                                            <option>></option>
                                                            <option>>=</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input id="FOrdrNo" type="text" class="form-control" />
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-sm-4 form-group">
                                                <label>Description</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <textarea class="form-control">&nbsp;</textarea>
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
                </div>
                <!--end filter panel-->
                <!--<div class="container-fluid pt-1 pb-1 text-end">
                <button class="btn borderbtn addbtn mr-5" id="" onclick="addWp()"><i class="fa fa-plus" aria-hidden="true"></i> Add</button>
                <a href="resource-plan-index.html" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Back to Resource Configuration">Back</a>
                <button class="btn borderbtn deletebtn" id="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete">Delete</button>
            </div>-->
                <div class="clearfix"></div>
                <div class=" container-fluid pt-1 pb-1 borderbox billing-filter-bar">
                    <div class="row">
                        <div class="col-sm-12">
                            <div id="billingFilterBar" class="billing-filter-wrap"></div>
                        </div>
                    </div>
                </div>

                <div class="content pt-3">

                    <div class="billing-grid-wrap">
                    <table id="dashBillingTbl" class="table table-bordered dashbillingTbllist">
                        <thead>
                            <tr>
                                <th class="th-company" rowspan="2">Company</th>
                                <th class="th-currency" rowspan="2">Rotate Currencies</th>
                                <th colspan="2">IRs Made</th>
                                <th colspan="2">Invoices Made</th>
                                <th colspan="2">PDF Files Sent</th>
                                <th colspan="2">Physical Invoice Dispatched</th>
                                <th colspan="2">Softex Forms Required</th>
                                <th colspan="2">Softex Forms Sent</th>
                            </tr>
                            <tr>
                                <th class="th-no">No</th>
                                <th class="th-amt">Amount</th>
                                <th class="th-no">No</th>
                                <th class="th-amt">Amount</th>
                                <th class="th-no">No</th>
                                <th class="th-amt">Amount</th>
                                <th class="th-no">No</th>
                                <th class="th-amt">Amount</th>
                                <th class="th-no">No</th>
                                <th class="th-amt">Amount</th>
                                <th class="th-no">No</th>
                                <th class="th-amt">Amount</th>
                            </tr>
                        </thead>
                        <tbody id="dashBillingTblBody">
                            <tr>
                                <td colspan="14" class="text-center text-muted">Loading...</td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
                    <div class="row footer-row billing-detail-footer" id="billingPager">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6 d-flex justify-content-end align-items-center">
                            <span class="spntotal me-3" id="billingPagerInfo">Total Records: 0</span>
                            <nav aria-label="Pagination">
                                <ul class="pagination mb-0">
                                    <li class="page-item disabled" id="billingPrevPageItem">
                                        <a class="page-link" id="billingPrevPage" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="page-item disabled" id="billingNextPageItem">
                                        <a class="page-link" id="billingNextPage" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="clearfix"></div>



                </div>

            </div>
     

        <!-- Save filter Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="Issuesavefilter" aria-labelledby="IssuesavefilterLabel">
    <div class="graybg container-fluid py-1 mb-2">
        <div class="row align-items-center">
            <div class="col-sm-10"><h5 class="pgtitle mb-0" id="IssuesavefilterLabel">Save Filter As</h5></div>
            <div class="col-sm-2 text-end">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" title="Close" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <div class="offcanvas-body">
<div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end">Filter Name :</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                    <button data-bs-dismiss="offcanvas" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
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
        <!-- Save filter Modal End here-->
        <!-- Invoice dashboard details Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="invoicedashdetail" aria-labelledby="invoicedashdetailLabel" style="width: 85%; max-width: 1200px;">
            <div class="offcanvas-body">
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-10"><h5 class="pgtitle mb-0" id="invoicedashdetailLabel">Invoice Dashboard Details</h5></div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" title="Close" aria-label="Close"></button>
                        </div>
                    </div>
                </div>
                <div id="TabGrossProfit" class="tab-pane">
                            <!--Information table start here-->
                            <div class="panel-group profitabilityinfopanel" id="billingCustAccordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default panel-horizontal lightgraybg">
                                    <div class="panel-heading" role="tab" id="billingCustHeading">
                                        <h4 class="panel-title">
                                            <a role="button" data-bs-toggle="collapse" data-bs-parent="#billingCustAccordion" href="#billingCustCollapse" aria-expanded="true" aria-controls="billingCustCollapse">
                                                <span class="hideprofitabilityinfo infoToggler togglerup pull-right ml-1">
                                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-bs-original-title="Expand">
                                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Collapse">
                                                </span>
                                                <span id="billingCustSectionTitle">IRs made</span>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="billingCustCollapse" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="billingCustHeading">
                                        <div class="panel-body">
                                            <table class="informationtbl mb-0">
                                                <tbody>
                                                    <tr>
                                                        <th>Company</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3"><span class="lmtname" id="billingCustCompany">-</span></td>
                                                        <th>Business Group</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="billingCustBG">-</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Organization Unit</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="billingCustOU">-</td>
                                                        <th>Posting Period</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3" id="billingCustPeriod">-</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--Information table End here-->

                            <div class="table-responsive">
                                <table class="table table-bordered Irsmadetbl" id="billingCustomerTbl">
                                    <thead>
                                        <tr class="">
                                            <th align="left">Customer</th>
                                            <th class="text-center" id="billingCustCountHeader">No.Of IRs</th>
                                            <th class="text-center">Equiv. INR value</th>
                                        </tr>
                                    </thead>
                                    <tbody id="billingCustomerTblBody">
                                        <tr>
                                            <td colspan="3" class="text-center text-muted">Select a metric to view customer details.</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>


                        </div>

                    
    </div>
</div>
        <!-- Invoice dashboard details Modal End here-->
        <!-- Invoice sub dashboard details Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="invoicesubdashdetail" aria-labelledby="invoicesubdashdetailLabel" style="width: 70%; max-width: 900px;">
            <div class="offcanvas-body">
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-10"><h5 class="pgtitle mb-0" id="invoicesubdashdetailLabel">Invoice Dashboard Details</h5></div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" title="Close" aria-label="Close"></button>
                        </div>
                    </div>
                </div>
                <!--Information table start here-->
                        <div class="panel-group profitabilityinfopanel" id="billingInvAccordion" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default panel-horizontal lightgraybg">
                                <div class="panel-heading" role="tab" id="billingInvHeading">
                                    <h4 class="panel-title">
                                        <a role="button" data-bs-toggle="collapse" data-bs-parent="#billingInvAccordion" href="#invoicesubdetailscollapse" aria-expanded="true" aria-controls="invoicesubdetailscollapse">
                                            <span class="hideprofitabilityinfo infoToggler togglerup pull-right ml-1">
                                                <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-bs-original-title="Expand">
                                                <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Collapse">
                                            </span>
                                            <span id="billingInvSectionTitle">IRs made</span>
                                        </a>
                                    </h4>
                                </div>
                                <div id="invoicesubdetailscollapse" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="billingInvHeading">
                                    <div class="panel-body">
                                        <table class="informationtbl mb-0">
                                            <tbody>
                                                <tr>
                                                    <th>Customer</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3"><span class="lmtname" id="billingInvCustomer">-</span></td>
                                                    <th>Company</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3"><span class="lmtname" id="billingInvCompany">-</span></td>
                                                </tr>
                                                <tr>
                                                    <th>Business Group</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3" id="billingInvBG">-</td>
                                                    <th>Organization Unit</th>
                                                    <td class="colan">:</td>
                                                    <td class="pr-3" id="billingInvOU">-</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--Information table End here-->

                        <div class="table-responsive">
                            <table class="table table-bordered Irsmadetbl" id="billingInvoiceTbl">
                                <thead>
                                    <tr class="">
                                        <th class="text-center">IR ID</th>
                                        <th class="text-center">IR Raised On</th>
                                        <th class="text-start">Description</th>
                                        <th>Currency</th>
                                        <th>Amount</th>
                                        <th>Equiv. INR value</th>
                                    </tr>
                                </thead>
                                <tbody id="billingInvoiceTblBody">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">Select a customer to view invoice details.</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>



                    
    </div>
</div>
        <!-- Invoice sub dashboard details Modal End here-->


        <div class="clearfix"></div>
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
    <!-- Bootstrap 5.3.2 -->
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>

    <script>

        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function editPHSDetail() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'slow');
            //used for disable grid
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });

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
            try {
                document.querySelectorAll('.offcanvas .btn-close[title], .offcanvas .btn-close[data-bs-title]').forEach(function (el) {
                    if (window.bootstrap && bootstrap.Tooltip) {
                        bootstrap.Tooltip.getOrCreateInstance(el, { placement: 'bottom', trigger: 'hover focus' });
                    } else if ($.fn.tooltip) {
                        $(el).tooltip({ placement: 'bottom' });
                    }
                });
            } catch (e) { }
        });


        // DataTable init deferred to billing API bind (see ProjectBilling script below)
        // $('#dashBillingTbl').dataTable(...);

        setTimeout(function () {
            if ($.fn.dataTable && $.fn.DataTable.isDataTable('#dashBillingTbl')) {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }
        }, 0);

        $(".collapse").on('show.bs.collapse', function (e) {
            var $toggler = $(e.target).closest('.panel').find('.infoToggler');
            $toggler.removeClass('togglerdown').addClass('togglerup');
            $(".table").resize();
        });
        $(".collapse").on('hide.bs.collapse', function (e) {
            var $toggler = $(e.target).closest('.panel').find('.infoToggler');
            $toggler.removeClass('togglerup').addClass('togglerdown');
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $(document).on('click', '.profitabilityinfopanel .panel-heading', function (e) {
            if ($(e.target).closest('a[data-bs-toggle="collapse"]').length) return;
            var $toggle = $(this).find('a[data-bs-toggle="collapse"]').first();
            if ($toggle.length) $toggle.trigger('click');
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('#healthshetprojectList_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 450, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }

        });



        //Graph script start Frome Here

        //Total Task vs Completion Status
        var ctx1 = document.getElementById("CompletionstatusGraph");
        var myChart = new Chart(ctx1, {
            type: 'doughnut',
            data: {
                labels: ["10%", "20%", "30%", "40%", "50%"],
                datasets: [{
                    label: '# 1',
                    data: [8, 7, 10, 15, 12],
                    backgroundColor: [
                        'rgba(235, 28, 36, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        '#afd037',
                        '#4bc0c0',

                    ],
                    borderColor: [
                        '#fff',
                        '#fff',
                        '#fff',
                        '#fff',
                        '#fff',

                    ],
                    borderWidth: 0
                }]
            },
            options: {
                cutoutPercentage: 60,
                responsive: false,
                segmentShowStroke: true,
                legend: {
                    display: true,
                    position: 'right',
                    labels: {
                        fontColor: "#000080",
                    }
                },

            }
        });
        //End Graph

        //Delay in days graph start
        var ctx = document.getElementById("DelayinDayschart").getContext("2d");

        var data = {
            labels: ["1Day", "3Day", "5Day", "7Day", "9Day"],
            datasets: [{
                label: "Delay Count",
                text: "label",
                backgroundColor: "#fbb03b",
                data: [2, 3, 6, 0, 1]
            }]
        };

        var tooltipsLabel = ['1Day', '3Day', '5Day', '7Day', '9Day']
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                title: {
                    display: true,
                    responsive: true,
                    //text: ''
                },
                barValueSpacing: 20,
                scales: {
                    xAxes: [{
                        maxBarThickness: 50,
                        barPercentage: 0.6,
                    }],
                    yAxes: [{
                        maxBarThickness: 20,
                        ticks: {
                            max: 10,
                            min: 0
                        }
                    }]
                },
                responsive: true,


                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        //backgroundColor: function (context) {
                        //    return context.dataset.backgroundColor;
                        //},
                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }
            }
        });

        //delay in days graph end

        //Monthly Resource Cost graph start
        var ctx = document.getElementById("MonthlyResourceCostChart").getContext("2d");

        var data = {
            labels: ["Feb19", "Nov20", "Dec21"],
            datasets: [{
                label: "Resource Cost",
                text: "label",
                backgroundColor: "#fbb03b",
                data: [1100, 2100, 250]
            }]
        };

        var tooltipsLabel = ['Dhaka', 'Rajshahi', 'NewYork', 'London']
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                title: {
                    display: true,
                    responsive: true,
                    //text: ''
                },
                barValueSpacing: 20,
                scales: {
                    xAxes: [{
                        maxBarThickness: 50,
                        barPercentage: 0.6,
                    }],
                    yAxes: [{
                        maxBarThickness: 20,
                        ticks: {
                            max: 500,
                            min: 0
                        }
                    }]
                },
                responsive: true,


                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        //backgroundColor: function (context) {
                        //    return context.dataset.backgroundColor;
                        //},
                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }

            }
        });
    </script>

    <script type="text/javascript">
      /* Added By Madhuri.K - Project Billing APIs: /api/ProjectBilling/* */
      (function () {
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
        if (strUrl && strUrl.endsWith('/')) strUrl = strUrl.slice(0, -1);
        var defaultEmployeeID = <%=If(Session("intUserID") Is Nothing, 61, Session("intUserID"))%>;
        var defaultLoginType = '<%=If(Session("LoginType") Is Nothing, "E", Session("LoginType").ToString())%>';
        var accessibleProjectIds = [];
        var currencyCache = {};
        var pageState = { pageNumber: 1, pageSize: 5, totalPages: 0, totalRecords: 0 };
        var customerDetailPager = { page: 1, size: 5, rows: [] };
        var invoiceDetailPager = { page: 1, size: 5, rows: [] };
        var detailContext = {
          companyId: 0,
          companyName: '',
          type: 1,
          currencyId: 0,
          currencyCode: '',
          customerId: 0,
          customerName: ''
        };

        var TYPE_META = {
          1: { title: 'IRs made', countHeader: 'No.Of IRs', countField: 'totalRFI', amountField: 'rfiAmount' },
          2: { title: 'Invoices Made', countHeader: 'No.Of Invoices', countField: 'invoiceCount', amountField: 'invoiceAmount' },
          3: { title: 'PDF Files Sent', countHeader: 'No.Of PDFs', countField: 'pdfFilesSent', amountField: 'pdfFilesSentAmount' },
          4: { title: 'Physical Invoice Dispatched', countHeader: 'No.Of Invoices', countField: 'physicalInvoicesCount', amountField: 'physicalInvoicesAmount' },
          5: { title: 'Softex Forms Required', countHeader: 'No.Of Forms', countField: 'softexFormsRequired', amountField: 'softexFormsAmount' },
          6: { title: 'Softex Forms Sent', countHeader: 'No.Of Forms', countField: 'softexFormsSent', amountField: 'softexFormsSentAmount' }
        };

        var salesPeriodOptions = [];
        var businessGroupOptions = [];
        var orgUnitOptions = [];
        var billingFilters = {
          salesPeriod: new Set(),
          businessGroup: new Set(),
          organizationUnit: new Set()
        };
        var billingOpenFilterKey = null;
        var billingFilterSearchTerms = {};
        var BILLING_FILTER_DEFS = [
          { key: 'salesPeriod', label: 'Sales Period', optionsKey: 'salesPeriodOptions' },
          { key: 'businessGroup', label: 'Business Group', optionsKey: 'businessGroupOptions' },
          { key: 'organizationUnit', label: 'Organization Unit', optionsKey: 'orgUnitOptions' }
        ];

        function toQuery(params) {
          var parts = [];
          Object.keys(params || {}).forEach(function (k) {
            var v = params[k];
            if (v == null || v === '') return;
            parts.push(encodeURIComponent(k) + '=' + encodeURIComponent(v));
          });
          return parts.length ? ('?' + parts.join('&')) : '';
        }

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

        function apiGet(path, payload) {
          return fetch(encodeURI(strUrl) + path + toQuery(payload || {}), {
            method: 'GET',
            headers: apiHeaders(payload || {}, false)
          });
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
            if (Object.prototype.hasOwnProperty.call(obj, k) && obj[k] != null) return obj[k];
            var found = Object.keys(obj).find(function (ok) { return ok.toLowerCase() === String(k).toLowerCase(); });
            if (found != null && obj[found] != null) return obj[found];
          }
          return undefined;
        }

        function apiNum(obj) {
          var v = apiVal.apply(null, arguments);
          var n = Number(v);
          return isNaN(n) ? 0 : n;
        }

        function unwrapPayload(json) {
          if (!json) return {};
          var d = json.data != null ? json.data : (json.Data != null ? json.Data : json);
          if (!d || typeof d !== 'object' || Array.isArray(d)) return d || {};
          var inner = d.data != null ? d.data : d.Data;
          if (inner && typeof inner === 'object' && !Array.isArray(inner) &&
              (inner.ProjectBillingSalesPeriodModel != null || inner.ProjectBillingBusinessGroupModel != null ||
               inner.ProjectBillingLocationModel != null || inner.ProjectBillingModel != null ||
               inner.ProjectBillingCustomerDetailModel != null || inner.ProjectBillingInvoiceDetailModel != null ||
               inner.ProjectBillingCompanyBaseCurrencyModel != null ||
               inner.ProjectProfitByCustomerAccessFilterModel != null ||
               apiVal(inner, 'ProjectBillingSalesPeriodModel', 'ProjectBillingBusinessGroupModel',
                 'ProjectBillingLocationModel', 'ProjectBillingModel', 'ProjectBillingCustomerDetailModel',
                 'ProjectBillingInvoiceDetailModel', 'ProjectBillingCompanyBaseCurrencyModel',
                 'ProjectProfitByCustomerAccessFilterModel'))) {
            return inner;
          }
          return d;
        }

        function esc(s) {
          return String(s == null ? '' : s)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        function fmtNum(v) {
          var n = Number(v);
          if (isNaN(n)) return '0.00';
          return n.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        function fmtInt(v) {
          var n = Number(v);
          if (isNaN(n)) return '0';
          return String(Math.round(n));
        }

        function fmtDate(v) {
          if (v == null || v === '') return '';
          var d = new Date(v);
          if (isNaN(d.getTime())) return String(v);
          var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          return d.getDate() + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
        }

        function refreshSelect($el) {
          if (!$el || !$el.length || !$.fn.selectpicker) return;
          var isBillingCurrency = $el.hasClass('billing-currency');
          if (isBillingCurrency) {
            $el.removeClass('fixed-width-combo').addClass('selectpicker form-control billing-currency-combo');
          } else {
            $el.addClass('selectpicker form-control fixed-width-combo');
          }
          $el.attr('data-live-search', 'true');
          try {
            if ($el.data('selectpicker')) $el.selectpicker('destroy');
          } catch (e) { }
          $el.selectpicker({
            liveSearch: false,
            container: 'body',
            dropupAuto: true,
            width: isBillingCurrency ? '78px' : '100%',
            //Added by Aditya J. on 26-08-2026 for keeping Rotate Currencies blank on page load
            noneSelectedText: isBillingCurrency ? '' : 'Nothing selected'
            //End of Added by Aditya J. on 26-08-2026 for keeping Rotate Currencies blank on page load
          });
          if (isBillingCurrency) {
            var $bs = $el.closest('.bootstrap-select');
            $bs.css({ width: '78px', maxWidth: '78px', display: 'inline-block', float: 'none', margin: '0' });
            $bs.find('> .dropdown-toggle').css({ width: '78px', maxWidth: '78px' });
          }
        }

        function extractModelList(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var keys = [
            'ProjectBillingSalesPeriodModel', 'ProjectBillingBusinessGroupModel', 'ProjectBillingLocationModel',
            'ProjectBillingModel', 'ProjectBillingCustomerDetailModel', 'ProjectBillingInvoiceDetailModel',
            'ProjectBillingCompanyBaseCurrencyModel', 'ProjectBillingCompanyBaseCurrencyAmountModel',
            'ProjectProfitByCustomerAccessFilterModel', 'RoleLevelAccessFilterModel'
          ];
          for (var i = 0; i < keys.length; i++) {
            var rows = apiVal(data, keys[i], keys[i].charAt(0).toLowerCase() + keys[i].slice(1));
            if (Array.isArray(rows)) return rows;
            if (rows && typeof rows === 'object') return [rows];
          }
          // nested rows envelope from GetProjectBilling
          var nested = apiVal(data, 'rows', 'Rows');
          if (nested) {
            var m = apiVal(nested, 'ProjectBillingModel', 'projectBillingModel');
            if (Array.isArray(m)) return m;
            if (m && typeof m === 'object') return [m];
          }
          return [];
        }

        function projectIdsCsv() {
          return (accessibleProjectIds || []).join(',');
        }

        function billingOptionsFor(key) {
          if (key === 'salesPeriod') return salesPeriodOptions;
          if (key === 'businessGroup') return businessGroupOptions;
          if (key === 'organizationUnit') return orgUnitOptions;
          return [];
        }

        function pruneBillingOrgUnits() {
          var validIds = new Set((orgUnitOptions || []).map(function (o) { return String(o.id); }));
          billingFilters.organizationUnit.forEach(function (id) {
            if (!validIds.has(id)) billingFilters.organizationUnit.delete(id);
          });
        }

        function onBillingFilterChanged(changedKey) {
          pageState.pageNumber = 1;
          if (changedKey === 'businessGroup') {
            loadOrganizationUnits().then(function () {
              loadProjectBilling();
            });
          } else {
            loadProjectBilling();
          }
        }

        function renderBillingFilterBar() {
          var bar = document.getElementById('billingFilterBar');
          if (!bar) return;
          bar.innerHTML = '';

          BILLING_FILTER_DEFS.forEach(function (def) {
            var opts = billingOptionsFor(def.key);
            var group = document.createElement('div');
            group.className = 'billing-filter-group';
            var label = document.createElement('label');
            label.textContent = def.label;
            group.appendChild(label);

            var selected = billingFilters[def.key];
            var msel = document.createElement('div');
            msel.className = 'msel';
            var btn = document.createElement('button');
            btn.className = 'msel-btn';
            btn.type = 'button';
            var btnLabel = 'Select ' + def.label;
            if (selected.size === 1) {
              var onlyId = [].concat(Array.from(selected))[0];
              var onlyOpt = opts.find(function (o) { return String(o.id) === String(onlyId); });
              btnLabel = onlyOpt ? onlyOpt.name : btnLabel;
            } else if (selected.size > 1) {
              btnLabel = 'Selected';
            }
            btn.innerHTML = '<span>' + btnLabel + '</span>' +
            //   <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
            (selected.size > 1
                ? '<span class="count">' + selected.size + '</span>'
                : '<span class="chev"><i class="fas fa-chevron-down"></i></span>');

            var panel = document.createElement('div');
            panel.className = 'msel-panel';
            if (billingOpenFilterKey === def.key) panel.classList.add('open');
            panel.addEventListener('click', function (e) { e.stopPropagation(); });

            var searchInput = document.createElement('input');
            searchInput.type = 'text';
            searchInput.className = 'msel-search';
            searchInput.placeholder = 'Search ' + def.label + '...';
            searchInput.value = billingFilterSearchTerms[def.key] || '';
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
                var match = !term || row.dataset.label.indexOf(term) > -1;
                row.style.display = match ? '' : 'none';
                if (match) anyVisible = true;
              });
              emptyMsg.style.display = anyVisible ? 'none' : 'block';
            }

            searchInput.addEventListener('input', function () {
              billingFilterSearchTerms[def.key] = searchInput.value;
              applySearchFilter();
            });

            opts.forEach(function (opt) {
              var row = document.createElement('label');
              row.className = 'msel-row';
              row.dataset.label = String(opt.name || '').toLowerCase();
              var cb = document.createElement('input');
              cb.type = 'checkbox';
              cb.checked = selected.has(String(opt.id));
              cb.addEventListener('change', function () {
                if (cb.checked) selected.add(String(opt.id));
                else selected.delete(String(opt.id));
                if (def.key === 'businessGroup') pruneBillingOrgUnits();
                renderBillingFilterBar();
                onBillingFilterChanged(def.key);
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
              selected.clear();
              if (def.key === 'businessGroup') pruneBillingOrgUnits();
              renderBillingFilterBar();
              onBillingFilterChanged(def.key);
            });
            var closeOne = document.createElement('button');
            closeOne.type = 'button';
            closeOne.textContent = 'Close';
            closeOne.addEventListener('click', function () {
              billingOpenFilterKey = null;
              panel.classList.remove('open');
            });
            actions.appendChild(clearOne);
            actions.appendChild(closeOne);
            panel.appendChild(actions);

            btn.addEventListener('click', function (e) {
              e.stopPropagation();
              if (billingOpenFilterKey === def.key) {
                billingOpenFilterKey = null;
                panel.classList.remove('open');
              } else {
                billingOpenFilterKey = def.key;
                document.querySelectorAll('#billingFilterBar .msel-panel.open').forEach(function (p) {
                  if (p !== panel) p.classList.remove('open');
                });
                panel.classList.add('open');
                searchInput.focus();
              }
            });

            msel.appendChild(btn);
            msel.appendChild(panel);
            group.appendChild(msel);
            bar.appendChild(group);
          });
        }

        function selectedFilterLabel(selectedSet, options) {
          if (!selectedSet || !selectedSet.size) return '-';
          if (selectedSet.size === 1) {
            var id = [].concat(Array.from(selectedSet))[0];
            var opt = (options || []).find(function (o) { return String(o.id) === String(id); });
            return opt ? opt.name : '-';
          }
          return 'Selected (' + selectedSet.size + ')';
        }

        function selectedIdsCsv(selectedSet) {
          if (!selectedSet || !selectedSet.size) return null;
          return [].concat(Array.from(selectedSet)).join(',');
        }

        function hasSalesPeriodSelection() {
          return billingFilters.salesPeriod.size > 0;
        }

        function selectedSalesPeriodIdsCsv() {
          return selectedIdsCsv(billingFilters.salesPeriod);
        }

        function selectedBusinessGroupIdsCsv() {
          return selectedIdsCsv(billingFilters.businessGroup);
        }

        function selectedLocationIdsCsv() {
          return selectedIdsCsv(billingFilters.organizationUnit);
        }

        function selectedSalesPeriodId() {
          var csv = selectedSalesPeriodIdsCsv();
          if (!csv) return null;
          var first = csv.split(',')[0];
          return parseInt(first, 10);
        }

        function selectedBusinessGroupId() {
          var csv = selectedBusinessGroupIdsCsv();
          if (!csv) return null;
          if (billingFilters.businessGroup.size === 1) return parseInt(csv, 10);
          return csv;
        }

        function selectedLocationId() {
          var csv = selectedLocationIdsCsv();
          if (!csv) return null;
          if (billingFilters.organizationUnit.size === 1) return parseInt(csv, 10);
          return csv;
        }

        function selectedSalesPeriodText() {
          return selectedFilterLabel(billingFilters.salesPeriod, salesPeriodOptions);
        }

        function selectedBusinessGroupText() {
          return selectedFilterLabel(billingFilters.businessGroup, businessGroupOptions);
        }

        function selectedOrganizationUnitText() {
          return selectedFilterLabel(billingFilters.organizationUnit, orgUnitOptions);
        }

        function applyBillingFilterPayload(payload) {
          // Always send as string (single or multi) so API receives quoted values, e.g. "12" or "12,15"
          var spCsv = selectedSalesPeriodIdsCsv();
          if (spCsv) payload.SalesPeriodID = String(spCsv);
          var bgCsv = selectedBusinessGroupIdsCsv();
          if (bgCsv) payload.BusinessGroupID = String(bgCsv);
          var locCsv = selectedLocationIdsCsv();
          if (locCsv) payload.LocationID = String(locCsv);
          return payload;
        }

        function destroyBillingTable() {
          if ($.fn.DataTable && $.fn.DataTable.isDataTable('#dashBillingTbl')) {
            try { $('#dashBillingTbl').DataTable().clear().destroy(); } catch (e) { }
            // unwrap if DataTables left wrapper markup
            if ($('#dashBillingTbl').parent().hasClass('dataTables_scrollBody')) {
              var $tbl = $('#dashBillingTbl').detach();
              $('.billing-grid-wrap').find('.dataTables_wrapper').remove();
              $('.billing-grid-wrap').prepend($tbl);
            }
          }
        }

        function initBillingTable() {
          // Custom pager used — avoid DataTables so header/currency columns stay aligned
          destroyBillingTable();
        }

        function renderBillingDetailPager(tableSelector, state, renderFn) {
          var $table = $(tableSelector);
          if (!$table.length) return;
          var total = state.rows.length;
          var totalPages = total ? Math.ceil(total / state.size) : 1;
          state.page = Math.max(1, Math.min(state.page, totalPages));
          var pagerFor = $table.attr('id');
          var $anchor = $table.parent().hasClass('table-responsive') ? $table.parent() : $table;
          var $pager = $anchor.next('.billing-detail-footer[data-pager-for="' + pagerFor + '"]');
          if (!$pager.length) {
            $pager = $('<div class="row footer-row billing-detail-footer" data-pager-for="' + pagerFor + '">' +
              '<div class="col-sm-6"></div>' +
              '<div class="col-sm-6 d-flex justify-content-end align-items-center">' +
              '<span class="spntotal me-3">Total Records: 0</span>' +
              '<nav aria-label="Pagination"><ul class="pagination mb-0">' +
              '<li class="page-item disabled"><a class="page-link detail-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>' +
              '<li class="page-item disabled"><a class="page-link detail-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>' +
              '</ul></nav></div></div>');
            $anchor.after($pager);
          }
          $pager.find('.spntotal').text('Total Records: ' + total);
          $pager.find('.detail-page-prev').closest('.page-item').toggleClass('disabled', state.page <= 1);
          $pager.find('.detail-page-next').closest('.page-item').toggleClass('disabled', !total || state.page >= totalPages);
          $pager.find('.detail-page-prev').off('click.billingDetailPager').on('click.billingDetailPager', function (e) {
            e.preventDefault();
            if (state.page <= 1) return;
            state.page -= 1;
            renderFn();
          });
          $pager.find('.detail-page-next').off('click.billingDetailPager').on('click.billingDetailPager', function (e) {
            e.preventDefault();
            if (!total || state.page >= totalPages) return;
            state.page += 1;
            renderFn();
          });
        }

        function bindSalesPeriodDropdown(rows) {
          var prev = new Set(billingFilters.salesPeriod);
          salesPeriodOptions = (rows || []).map(function (r) {
            var id = apiVal(r, 'salesPeriodID', 'SalesPeriodID');
            return {
              id: String(id),
              name: apiVal(r, 'salesPeriod', 'SalesPeriod') || ''
            };
          }).filter(function (o) {
            return o.id && o.id !== 'null' && o.id !== 'undefined';
          });
          billingFilters.salesPeriod.clear();
          prev.forEach(function (id) {
            if (salesPeriodOptions.some(function (o) { return o.id === id; })) {
              billingFilters.salesPeriod.add(id);
            }
          });
          if (!billingFilters.salesPeriod.size && salesPeriodOptions.length) {
            billingFilters.salesPeriod.add(salesPeriodOptions[0].id);
          }
          renderBillingFilterBar();
        }

        function bindBusinessGroupDropdown(rows) {
          var prev = new Set(billingFilters.businessGroup);
          businessGroupOptions = (rows || []).map(function (r) {
            var id = apiVal(r, 'businessGroupID', 'BusinessGroupID');
            return {
              id: String(id),
              name: apiVal(r, 'businessGroup', 'BusinessGroup') || ''
            };
          }).filter(function (o) {
            return o.id && o.id !== 'null' && o.id !== 'undefined';
          });
          billingFilters.businessGroup.clear();
          prev.forEach(function (id) {
            if (businessGroupOptions.some(function (o) { return o.id === id; })) {
              billingFilters.businessGroup.add(id);
            }
          });
          renderBillingFilterBar();
        }

        function bindOrganizationUnitDropdown(rows) {
          var prev = new Set(billingFilters.organizationUnit);
          orgUnitOptions = (rows || []).map(function (r) {
            var id = apiVal(r, 'locationID', 'LocationID');
            return {
              id: String(id),
              name: apiVal(r, 'location', 'Location') || ''
            };
          }).filter(function (o) {
            return o.id && o.id !== 'null' && o.id !== 'undefined';
          });
          billingFilters.organizationUnit.clear();
          prev.forEach(function (id) {
            if (orgUnitOptions.some(function (o) { return o.id === id; })) {
              billingFilters.organizationUnit.add(id);
            }
          });
          pruneBillingOrgUnits();
          renderBillingFilterBar();
        }

        function loadRoleLevelAccessFilter() {
          var payload = {
            AccessParameter: 'ProjectID',
            UserID: defaultEmployeeID,
            LoginType: defaultLoginType || 'E',
            RoleLevel: 2,
            ShowReleasedProjects: true
          };
          return apiPost('/api/ProjectBilling/GetRoleLevelAccessFilter', payload)
            .then(function (res) {
              if (!res.ok) throw new Error('GetRoleLevelAccessFilter failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              var rows = extractModelList(unwrapPayload(json));
              accessibleProjectIds = [];
              (rows || []).forEach(function (r) {
                var id = apiVal(r, 'projectID', 'ProjectID');
                if (id != null && id !== '') accessibleProjectIds.push(id);
              });
            })
            .catch(function (err) {
              console.error(err);
              accessibleProjectIds = [];
            });
        }

        function loadSalesPeriods() {
          return apiPost('/api/ProjectBilling/GetSalesPeriods', {})
            .then(function (res) {
              if (!res.ok) throw new Error('GetSalesPeriods failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              bindSalesPeriodDropdown(extractModelList(unwrapPayload(json)));
            })
            .catch(function (err) {
              console.error(err);
              bindSalesPeriodDropdown([]);
            });
        }

        function loadBusinessGroups() {
          return apiPost('/api/ProjectBilling/GetBusinessGroups', {})
            .then(function (res) {
              if (!res.ok) throw new Error('GetBusinessGroups failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              bindBusinessGroupDropdown(extractModelList(unwrapPayload(json)));
            })
            .catch(function (err) {
              console.error(err);
              bindBusinessGroupDropdown([]);
            });
        }

        function loadOrganizationUnits() {
          var payload = {};
          var bgCsv = selectedBusinessGroupIdsCsv();
          if (bgCsv) payload.BusinessGroupID = bgCsv;
          return apiPost('/api/ProjectBilling/GetLocationsForBusinessGroup', payload)
            .then(function (res) {
              if (!res.ok) throw new Error('GetLocationsForBusinessGroup failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              bindOrganizationUnitDropdown(extractModelList(unwrapPayload(json)));
            })
            .catch(function (err) {
              console.error(err);
              bindOrganizationUnitDropdown([]);
            });
        }

        function loadCompanyCurrencies(companyId) {
          var cid = parseInt(companyId, 10) || 0;
          if (currencyCache[cid]) return currencyCache[cid];
          currencyCache[cid] = apiPost('/api/ProjectBilling/GetCompanyBaseCurrencies', cid ? { CompanyID: cid } : {})
            .then(function (res) {
              if (!res.ok) throw new Error('GetCompanyBaseCurrencies failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              return extractModelList(unwrapPayload(json));
            })
            .catch(function (err) {
              console.error(err);
              return [];
            });
          return currencyCache[cid];
        }

        function metricLink(count, type, companyId, companyName) {
          return '<a href="javascript:;" class="billing-metric-link" data-type="' + type +
            '" data-company-id="' + esc(companyId) + '" data-company-name="' + esc(companyName) + '">' +
            esc(fmtInt(count)) + '</a>';
        }

        // Type values match legacy usp_Get_CompanyBaseCurrencyAmount_Details field names
        var AMOUNT_TYPE_FIELDS = [
          'RFIAMOUNT',
          'INVOICEAMOUNT',
          'PDFFILESSENTAMOUNT',
          'PHYSICALINVOICESAMOUNT',
          'SOFTEXFORMSAMOUNT',
          'SOFTEXFORMSSENTAMOUNT'
        ];

        var COMPANY_NAME_MAX = 19;

        function truncateText(s, max) {
          s = (s === null || s === undefined) ? '' : String(s);
          return s.length > max ? (s.substring(0, max) + '...') : s;
        }

        function amountHtml(v, currencyCode) {
          var html = '<span class="amt-val">' + esc(fmtNum(v)) + '</span>';
          if (currencyCode) html += ' <span class="amt-cur">' + esc(currencyCode) + '</span>';
          return html;
        }

        function amountCell(v, currencyCode, amountType) {
          return '<td class="col-amt text-end billing-amt" data-amt-type="' + esc(amountType || '') + '">' +
            amountHtml(v, currencyCode) + '</td>';
        }

        /* Amounts render before the row currency list resolves, so the code is stamped in afterwards. */
        function setRowAmountCurrencyLabel($row, code) {
          if (!$row || !$row.length) return;
          $row.find('td.billing-amt').each(function () {
            var $td = $(this);
            var $cur = $td.find('.amt-cur');
            if (!code) {
              $cur.remove();
              return;
            }
            if ($cur.length) {
              $cur.text(code);
              return;
            }
            var $val = $td.find('.amt-val');
            if ($val.length) $val.after(' <span class="amt-cur">' + esc(code) + '</span>');
          });
        }

        function parseAmountFromCurrencyResponse(json) {
          var data = unwrapPayload(json);
          var rows = extractModelList(data);
          if (rows && rows.length) {
            return apiNum(rows[0], 'amount', 'Amount');
          }
          return apiNum(data, 'amount', 'Amount');
        }

        function loadCompanyBaseCurrencyAmount(companyId, currencyId, type) {
          var payload = applyBillingFilterPayload({
            CompanyID: parseInt(companyId, 10) || 0,
            CompanyBaseCurrencyID: parseInt(currencyId, 10) || 0,
            Type: String(type || '')
          });
          var pids = projectIdsCsv();
          if (pids) payload.ProjectIDs = pids;

          return apiPost('/api/ProjectBilling/GetCompanyBaseCurrencyAmount', payload)
            .then(function (res) {
              if (!res.ok) throw new Error('GetCompanyBaseCurrencyAmount failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              return parseAmountFromCurrencyResponse(json);
            });
        }

        function refreshRowAmountsForCurrency($row, currencyId, currencyCode) {
          if (!$row || !$row.length) return Promise.resolve();
          var companyId = parseInt($row.attr('data-company-id'), 10) || 0;
          if (!companyId || !currencyId) return Promise.resolve();

          $row.find('td.billing-amt').each(function () {
            $(this).addClass('text-muted').text('...');
          });

          var tasks = AMOUNT_TYPE_FIELDS.map(function (type) {
            return loadCompanyBaseCurrencyAmount(companyId, currencyId, type)
              .then(function (amt) {
                $row.find('td.billing-amt[data-amt-type="' + type + '"]')
                  .removeClass('text-muted')
                  .html(amountHtml(amt, currencyCode));
              })
              .catch(function (err) {
                console.error(err);
                $row.find('td.billing-amt[data-amt-type="' + type + '"]')
                  .removeClass('text-muted')
                  .text('-');
              });
          });
          return Promise.all(tasks);
        }

        function updatePager() {
          var total = pageState.totalRecords || 0;
          var pageSize = pageState.pageSize || 5;
          var totalPages = pageState.totalPages || (total > 0 ? Math.ceil(total / pageSize) : 1);
          pageState.totalPages = totalPages;
          $('#billingPagerInfo').text('Total Records: ' + total);
          $('#billingPrevPageItem').toggleClass('disabled', pageState.pageNumber <= 1);
          $('#billingNextPageItem').toggleClass('disabled', total <= 0 || pageState.pageNumber >= totalPages);
        }

        function renderBillingGrid(rows) {
          destroyBillingTable();
          var $body = $('#dashBillingTblBody');
          if (!rows || !rows.length) {
            $body.html('<tr><td colspan="14" class="text-center text-muted">No billing data found.</td></tr>');
            updatePager();
            initBillingTable();
            return;
          }

          var html = '';
          rows.forEach(function (r, idx) {
            var companyId = apiVal(r, 'companyId', 'CompanyId', 'companyID', 'CompanyID') || 0;
            var company = apiVal(r, 'company', 'Company') || '';
            var selId = 'billingCurrency_' + companyId + '_' + idx;
            //Added by Aditya J. on 26-08-2026 for binding baseCurrencyCode in Amount column
            var rowCur = apiVal(r, 'baseCurrencyCode', 'BaseCurrencyCode') || '';
            //End of Added by Aditya J. on 26-08-2026 for binding baseCurrencyCode in Amount column
            html += '<tr data-company-id="' + esc(companyId) + '" data-company-name="' + esc(company) + '" data-base-currency="' + esc(rowCur) + '">';
            html += '<td class="compname" title="' + esc(company) + '">' + esc(truncateText(company, COMPANY_NAME_MAX)) + '</td>';
            //Added by Aditya J. on 26-08-2026 for keeping Rotate Currencies blank on page load
            html += '<td class="currency-cell"><div class="currency-wrap"><select id="' + selId + '" class="form-control input-sm selectpicker billing-currency-combo billing-currency" data-company-id="' + esc(companyId) + '" data-live-search="true" title=""><option value=""></option></select></div></td>';
            //End of Added by Aditya J. on 26-08-2026 for keeping Rotate Currencies blank on page load
            html += '<td class="col-no">' + metricLink(apiNum(r, 'totalRFI', 'TotalRFI'), 1, companyId, company) + '</td>';
            html += amountCell(apiNum(r, 'rfiAmount', 'RfiAmount'), rowCur, 'RFIAMOUNT');
            html += '<td class="col-no">' + metricLink(apiNum(r, 'invoiceCount', 'InvoiceCount'), 2, companyId, company) + '</td>';
            html += amountCell(apiNum(r, 'invoiceAmount', 'InvoiceAmount'), rowCur, 'INVOICEAMOUNT');
            html += '<td class="col-no">' + metricLink(apiNum(r, 'pdfFilesSent', 'PdfFilesSent'), 3, companyId, company) + '</td>';
            html += amountCell(apiNum(r, 'pdfFilesSentAmount', 'PdfFilesSentAmount'), rowCur, 'PDFFILESSENTAMOUNT');
            html += '<td class="col-no">' + metricLink(apiNum(r, 'physicalInvoicesCount', 'PhysicalInvoicesCount'), 4, companyId, company) + '</td>';
            html += amountCell(apiNum(r, 'physicalInvoicesAmount', 'PhysicalInvoicesAmount'), rowCur, 'PHYSICALINVOICESAMOUNT');
            html += '<td class="col-no">' + metricLink(apiNum(r, 'softexFormsRequired', 'SoftexFormsRequired'), 5, companyId, company) + '</td>';
            html += amountCell(apiNum(r, 'softexFormsAmount', 'SoftexFormsAmount'), rowCur, 'SOFTEXFORMSAMOUNT');
            html += '<td class="col-no">' + metricLink(apiNum(r, 'softexFormsSent', 'SoftexFormsSent'), 6, companyId, company) + '</td>';
            html += amountCell(apiNum(r, 'softexFormsSentAmount', 'SoftexFormsSentAmount'), rowCur, 'SOFTEXFORMSSENTAMOUNT');
            html += '</tr>';
          });
          $body.html(html);
          updatePager();
          initBillingTable();

          rows.forEach(function (r, idx) {
            var companyId = apiVal(r, 'companyId', 'CompanyId', 'companyID', 'CompanyID') || 0;
            var $sel = $('#billingCurrency_' + companyId + '_' + idx);
            loadCompanyCurrencies(companyId).then(function (currencies) {
              //Added by Aditya J. on 26-08-2026 for keeping Rotate Currencies blank on page load
              var opts = '<option value=""></option>';
              (currencies || []).forEach(function (c) {
                var id = apiVal(c, 'currencyID', 'CurrencyID');
                var code = apiVal(c, 'currencyCode', 'CurrencyCode') || '';
                if (id == null) return;
                opts += '<option value="' + esc(id) + '">' + esc(code) + '</option>';
              });
              $sel.data('skip-currency-change', true);
              $sel.html(opts);
              $sel.val('');
              refreshSelect($sel);
              try { $sel.selectpicker('val', ''); } catch (e) { }
              setTimeout(function () { $sel.removeData('skip-currency-change'); }, 0);
              //End of Added by Aditya J. on 26-08-2026 for keeping Rotate Currencies blank on page load
            });
          });
        }

        function loadProjectBilling() {
          var $body = $('#dashBillingTblBody');
          if (!hasSalesPeriodSelection()) {
            destroyBillingTable();
            $body.html('<tr><td colspan="14" class="text-center text-muted">Select a Sales Period.</td></tr>');
            pageState.totalPages = 0;
            pageState.totalRecords = 0;
            updatePager();
            initBillingTable();
            return Promise.resolve();
          }

          destroyBillingTable();
          $body.html('<tr><td colspan="14" class="text-center text-muted">Loading...</td></tr>');

          var payload = applyBillingFilterPayload({
            PageNumber: pageState.pageNumber,
            PageSize: pageState.pageSize
          });
          var pids = projectIdsCsv();
          if (pids) payload.ProjectIDs = pids;

          return apiPost('/api/ProjectBilling/GetProjectBilling', payload)
            .then(function (res) {
              if (!res.ok) throw new Error('GetProjectBilling failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              var data = unwrapPayload(json);
              var rows = extractModelList(data);
              pageState.pageNumber = Number(apiVal(data, 'pageNumber', 'PageNumber') || pageState.pageNumber) || 1;
              pageState.pageSize = 5;
              pageState.totalRecords = Number(apiVal(data, 'totalRecords', 'TotalRecords') || 0) || 0;
              pageState.totalPages = Number(apiVal(data, 'totalPages', 'TotalPages') || 0) || 0;
              if (!pageState.totalPages && pageState.totalRecords && pageState.pageSize) {
                pageState.totalPages = Math.ceil(pageState.totalRecords / pageState.pageSize);
              }
              // fallback totalRecords from first row when API returns 0 at root
              if (!pageState.totalRecords && rows.length) {
                var tr = apiNum(rows[0], 'totalRecords', 'TotalRecords');
                if (tr) {
                  pageState.totalRecords = tr;
                  pageState.totalPages = Math.ceil(tr / pageState.pageSize) || 1;
                }
              }
              renderBillingGrid(rows);
            })
            .catch(function (err) {
              console.error(err);
              destroyBillingTable();
              $body.html('<tr><td colspan="14" class="text-center text-danger">Unable to load billing data.</td></tr>');
              updatePager();
              initBillingTable();
            });
        }

        function closeSecondOffcanvas() {
          var subEl = document.getElementById('invoicesubdashdetail');
          if (!subEl || !$(subEl).hasClass('show')) return;
          if (window.bootstrap && bootstrap.Offcanvas) {
            var inst = bootstrap.Offcanvas.getInstance(subEl);
            if (inst) inst.hide();
            else bootstrap.Offcanvas.getOrCreateInstance(subEl).hide();
          } else {
            $(subEl).offcanvas('hide');
          }
        }

        function openOffcanvas(id) {
          var el = document.getElementById(id);
          if (!el) return;
          $('body').addClass('offcanvas-open');
          if (id === 'invoicesubdashdetail') {
            var $parent = $('#invoicedashdetail');
            $parent.addClass('offcanvas-as-main');
            if (!$parent.find('.billing-parent-scrim').length) {
              $parent.append('<div class="billing-parent-scrim" title="Close"></div>');
            }
            $('body').addClass('offcanvas-nested');
          }
          if (window.bootstrap && bootstrap.Offcanvas) {
            bootstrap.Offcanvas.getOrCreateInstance(el, { backdrop: true, keyboard: true }).show();
          } else {
            $(el).offcanvas('show');
          }
        }

        function renderCustomerDetails(rows) {
          var $body = $('#billingCustomerTblBody');
          if (Array.isArray(rows)) customerDetailPager.rows = rows;
          var allRows = customerDetailPager.rows;
          renderBillingDetailPager('#billingCustomerTbl', customerDetailPager, function () { renderCustomerDetails(); });
          if (!allRows.length) {
            $body.html('<tr><td colspan="3" class="text-center text-muted">No customer details found.</td></tr>');
            return;
          }
          var html = '';
          var totalDocs = 0;
          var totalAmt = 0;
          allRows.forEach(function (r) {
            totalDocs += apiNum(r, 'noOfDocuments', 'NoOfDocuments');
            totalAmt += apiNum(r, 'amount', 'Amount');
          });
          var start = (customerDetailPager.page - 1) * customerDetailPager.size;
          allRows.slice(start, start + customerDetailPager.size).forEach(function (r) {
            var custId = apiVal(r, 'customer', 'Customer', 'customerID', 'CustomerID') || 0;
            var custName = apiVal(r, 'customerName', 'CustomerName') || '';
            var docs = apiNum(r, 'noOfDocuments', 'NoOfDocuments');
            var amt = apiNum(r, 'amount', 'Amount');
            html += '<tr>';
            html += '<td align="left"><a href="javascript:;" class="billing-customer-link" data-customer-id="' + esc(custId) + '" data-customer-name="' + esc(custName) + '">' + esc(custName) + '</a></td>';
            html += '<td align="right">' + esc(fmtInt(docs)) + '</td>';
            html += '<td align="right">' + esc(fmtNum(amt)) + '</td>';
            html += '</tr>';
          });
          html += '<tr class="totalrow"><td align="left"><strong>Total</strong></td><td align="right">' + esc(fmtInt(totalDocs)) + '</td><td align="right">' + esc(fmtNum(totalAmt)) + '</td></tr>';
          $body.html(html);
        }

        function expandBillingAccordion($collapse) {
          if (!$collapse || !$collapse.length) return;
          $collapse.addClass('show');
          $collapse.closest('.panel').find('.infoToggler').removeClass('togglerdown').addClass('togglerup');
          $collapse.closest('.panel').find('[data-bs-toggle="collapse"]').attr('aria-expanded', 'true');
        }

        function loadCustomerDetails() {
          customerDetailPager.page = 1;
          customerDetailPager.rows = [];
          var meta = TYPE_META[detailContext.type] || TYPE_META[1];
          $('#billingCustSectionTitle').text(meta.title);
          $('#billingCustCountHeader').text(meta.countHeader);
          $('#billingCustCompany').text(detailContext.companyName || '-');
          $('#billingCustBG').text(selectedBusinessGroupText());
          $('#billingCustOU').text(selectedOrganizationUnitText());
          $('#billingCustPeriod').text(selectedSalesPeriodText());
          $('#billingCustomerTblBody').html('<tr><td colspan="3" class="text-center text-muted">Loading...</td></tr>');
          renderBillingDetailPager('#billingCustomerTbl', customerDetailPager, function () { renderCustomerDetails(); });
          expandBillingAccordion($('#billingCustCollapse'));

          var payload = applyBillingFilterPayload({
            CompanyID: detailContext.companyId,
            Type: detailContext.type,
            CompanyBaseCurrencyID: detailContext.currencyId || 0
          });
          var pids = projectIdsCsv();
          if (pids) payload.ProjectIDs = pids;

          return apiPost('/api/ProjectBilling/GetCustomerDetails', payload)
            .then(function (res) {
              if (!res.ok) throw new Error('GetCustomerDetails failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              renderCustomerDetails(extractModelList(unwrapPayload(json)));
            })
            .catch(function (err) {
              console.error(err);
              customerDetailPager.rows = [];
              renderBillingDetailPager('#billingCustomerTbl', customerDetailPager, function () { renderCustomerDetails(); });
              $('#billingCustomerTblBody').html('<tr><td colspan="3" class="text-center text-danger">Unable to load customer details.</td></tr>');
            });
        }

        function renderInvoiceDetails(rows) {
          var $body = $('#billingInvoiceTblBody');
          if (Array.isArray(rows)) invoiceDetailPager.rows = rows;
          var allRows = invoiceDetailPager.rows;
          renderBillingDetailPager('#billingInvoiceTbl', invoiceDetailPager, function () { renderInvoiceDetails(); });
          if (!allRows.length) {
            $body.html('<tr><td colspan="6" class="text-center text-muted">No invoice details found.</td></tr>');
            return;
          }
          var html = '';
          var totalBase = 0;
          allRows.forEach(function (r) {
            totalBase += apiNum(r, 'baseAmount', 'BaseAmount');
          });
          var start = (invoiceDetailPager.page - 1) * invoiceDetailPager.size;
          allRows.slice(start, start + invoiceDetailPager.size).forEach(function (r) {
            var amt = apiNum(r, 'amount', 'Amount');
            var baseAmt = apiNum(r, 'baseAmount', 'BaseAmount');
            html += '<tr>';
            html += '<td>' + esc(apiVal(r, 'invoiceNumber', 'InvoiceNumber') || '') + '</td>';
            html += '<td>' + esc(fmtDate(apiVal(r, 'invoiceDate', 'InvoiceDate'))) + '</td>';
            html += '<td class="text-start">' + esc(apiVal(r, 'rfiTypeName', 'RfiTypeName') || '') + '</td>';
            html += '<td>' + esc(apiVal(r, 'currencyCode', 'CurrencyCode') || '') + '</td>';
            html += '<td class="text-end">' + esc(fmtNum(amt)) + '</td>';
            html += '<td class="text-end">' + esc(fmtNum(baseAmt)) + '</td>';
            html += '</tr>';
          });
          html += '<tr class="totalrow"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td class="text-end">Total Amount</td><td class="text-end">' + esc(fmtNum(totalBase)) + '</td></tr>';
          $body.html(html);
        }

        function loadInvoiceDetails() {
          invoiceDetailPager.page = 1;
          invoiceDetailPager.rows = [];
          var meta = TYPE_META[detailContext.type] || TYPE_META[1];
          $('#billingInvSectionTitle').text(meta.title);
          $('#billingInvCustomer').text(detailContext.customerName || '-');
          $('#billingInvCompany').text(detailContext.companyName || '-');
          $('#billingInvBG').text(selectedBusinessGroupText());
          $('#billingInvOU').text(selectedOrganizationUnitText());
          $('#billingInvoiceTblBody').html('<tr><td colspan="6" class="text-center text-muted">Loading...</td></tr>');
          renderBillingDetailPager('#billingInvoiceTbl', invoiceDetailPager, function () { renderInvoiceDetails(); });
          expandBillingAccordion($('#invoicesubdetailscollapse'));

          var payload = applyBillingFilterPayload({
            CustomerID: detailContext.customerId,
            CompanyID: detailContext.companyId,
            Type: detailContext.type,
            CompanyBaseCurrencyID: detailContext.currencyId || 0
          });
          var pids = projectIdsCsv();
          if (pids) payload.ProjectIDs = pids;

          return apiPost('/api/ProjectBilling/GetInvoiceDetails', payload)
            .then(function (res) {
              if (!res.ok) throw new Error('GetInvoiceDetails failed: ' + res.status);
              return res.json();
            })
            .then(function (json) {
              renderInvoiceDetails(extractModelList(unwrapPayload(json)));
            })
            .catch(function (err) {
              console.error(err);
              invoiceDetailPager.rows = [];
              renderBillingDetailPager('#billingInvoiceTbl', invoiceDetailPager, function () { renderInvoiceDetails(); });
              $('#billingInvoiceTblBody').html('<tr><td colspan="6" class="text-center text-danger">Unable to load invoice details.</td></tr>');
            });
        }

        function hidePagePreloader() {
          $('#BillingPagePreloader').hide();
          $('#BillingPageWrapper').show();
        }

        $(document).ready(function () {
          renderBillingDetailPager('#billingCustomerTbl', customerDetailPager, function () { renderCustomerDetails(); });
          renderBillingDetailPager('#billingInvoiceTbl', invoiceDetailPager, function () { renderInvoiceDetails(); });
          Promise.all([loadRoleLevelAccessFilter(), loadSalesPeriods(), loadBusinessGroups()])
            .then(function () { return loadOrganizationUnits(); })
            .then(function () { return loadProjectBilling(); })
            .then(function () {
              hidePagePreloader();
            })
            .catch(function () {
              hidePagePreloader();
            });
          setTimeout(hidePagePreloader, 8000);

          document.addEventListener('click', function () {
            billingOpenFilterKey = null;
            document.querySelectorAll('#billingFilterBar .msel-panel.open').forEach(function (p) {
              p.classList.remove('open');
            });
          });

          $('#billingPrevPage').on('click', function (e) {
            e.preventDefault();
            if ($(this).closest('.page-item').hasClass('disabled')) return;
            if (pageState.pageNumber <= 1) return;
            pageState.pageNumber -= 1;
            loadProjectBilling();
          });
          $('#billingNextPage').on('click', function (e) {
            e.preventDefault();
            if ($(this).closest('.page-item').hasClass('disabled')) return;
            if (pageState.totalPages && pageState.pageNumber >= pageState.totalPages) return;
            pageState.pageNumber += 1;
            loadProjectBilling();
          });

          $('#dashBillingTblBody').on('click', '.billing-metric-link', function (e) {
            e.preventDefault();
            var $a = $(this);
            $('.billing-metric-link').removeClass('oc-link-active');
            $('.billing-customer-link').removeClass('oc-link-active');
            $a.addClass('oc-link-active');
            var $row = $a.closest('tr');
            var $curr = $row.find('select.billing-currency');
            detailContext.type = parseInt($a.attr('data-type'), 10) || 1;
            detailContext.companyId = parseInt($a.attr('data-company-id'), 10) || 0;
            detailContext.companyName = $a.attr('data-company-name') || '';
            detailContext.currencyId = parseInt($curr.val(), 10) || 0;
            detailContext.currencyCode = $curr.find('option:selected').text() || '';
            openOffcanvas('invoicedashdetail');
            loadCustomerDetails();
          });

          $('#dashBillingTblBody').on('changed.bs.select', 'select.billing-currency', function () {
            var $sel = $(this);
            if ($sel.data('skip-currency-change')) return;
            var currencyId = parseInt($sel.val(), 10) || 0;
            var currencyCode = $.trim($sel.find('option:selected').text() || '');
            if (!currencyId) return;
            var $row = $sel.closest('tr');
            refreshRowAmountsForCurrency($row, currencyId, currencyCode);
          });

          $('#billingCustomerTblBody').on('click', '.billing-customer-link', function (e) {
            e.preventDefault();
            var $a = $(this);
            $('.billing-customer-link').removeClass('oc-link-active');
            $a.addClass('oc-link-active');
            detailContext.customerId = parseInt($a.attr('data-customer-id'), 10) || 0;
            detailContext.customerName = $a.attr('data-customer-name') || '';
            openOffcanvas('invoicesubdashdetail');
            loadInvoiceDetails();
          });

          $('#invoicesubdashdetail').on('shown.bs.offcanvas', function () {
            var $parent = $('#invoicedashdetail');
            $parent.addClass('offcanvas-as-main');
            if (!$parent.find('.billing-parent-scrim').length) {
              $parent.append('<div class="billing-parent-scrim" title="Close"></div>');
            }
            $('body').addClass('offcanvas-nested offcanvas-open');
          });

          // Click dimmed 1st offcanvas → close 2nd
          $(document).on('click', '#invoicedashdetail .billing-parent-scrim', function (e) {
            e.preventDefault();
            e.stopPropagation();
            closeSecondOffcanvas();
          });

          // Click main-section backdrop while nested → close 2nd only
          $(document).on('mousedown', 'body.offcanvas-nested .offcanvas-backdrop', function (e) {
            e.preventDefault();
            e.stopPropagation();
            closeSecondOffcanvas();
          });

          $('#invoicesubdashdetail').on('hidden.bs.offcanvas', function () {
            $('.billing-customer-link').removeClass('oc-link-active');
            $('#invoicedashdetail').removeClass('offcanvas-as-main');
            $('#invoicedashdetail .billing-parent-scrim').remove();
            $('body').removeClass('offcanvas-nested');
            if ($('#invoicedashdetail').hasClass('show')) {
              $('body').addClass('offcanvas-open');
            } else if (!$('.offcanvas.show').length) {
              $('body').removeClass('offcanvas-open');
            }
          });

          $('#invoicedashdetail').on('hide.bs.offcanvas', function (e) {
            // While 2nd is open, clicking parent should close child instead of parent
            if ($('#invoicesubdashdetail').hasClass('show')) {
              e.preventDefault();
              closeSecondOffcanvas();
            }
          });

          $('#invoicedashdetail').on('hidden.bs.offcanvas', function () {
            $('.billing-metric-link, .billing-customer-link').removeClass('oc-link-active');
            $('#invoicedashdetail').removeClass('offcanvas-as-main');
            $('#invoicedashdetail .billing-parent-scrim').remove();
            $('body').removeClass('offcanvas-nested');
            if ($('#invoicesubdashdetail').hasClass('show')) {
              closeSecondOffcanvas();
            }
            if (!$('.offcanvas.show').length) {
              $('body').removeClass('offcanvas-open');
            }
          });
        });
      })();
    </script>

<%--    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;">You are not authorize to view this page .</p>
        </div>
    </div>
    <%End If%>--%>

    </form>
</body>
</html>

