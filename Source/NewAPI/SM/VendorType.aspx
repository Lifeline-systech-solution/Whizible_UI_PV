<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VendorType.aspx.vb" Inherits="PbNIT.VendorType" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Vendor Type")%>
<head runat="server">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <style type="text/css">
        body,
        .table,
        h5.pgtitle,
        .vendor-page {
            font-family: 'Roboto', sans-serif;
            /*background: #f8fafc;*/ /*Comneted  By Dipali to make UI consistency*/
            color: #111827;
        }

        .vendor-page {
            padding: 0;
        }

        .vendor-active-checkbox {
            width: 12px;
            height: 12px;
            margin-top: -14px;
            cursor: pointer;
        }
        h5.pgtitle {
            margin: 0;
            font-weight: 600;
            color: #2563eb;
            font-size: 16px;
            line-height: 1.2;
            font-family: arial !important;
           
        }

         h5.pgtitleView {
            margin: 0;
            font-weight: 400;
            color: #2a2d2e;
            font-size: 14px;
            line-height: 1.2;
            font-family: arial !important;
            text-align: center;
            margin-top: 224px;
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

        .vendor-content {
            padding: 12px 12px 0;
        }

       /* .vendor-master-header {
            background: #e9ecef;
        }*/

        .panel-box {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 4px;
            margin-bottom: 12px;
        }

        .vendor-list-panel {
            border: none;
            box-shadow: none;
        }

        .section-head {
            padding-top: 8px !important;
            padding-bottom: 8px !important;
            padding-left: 12px;
            padding-right: 12px;
            border-bottom: 1px solid #eef2f7;
            color: #2563eb;
            font-size: 14px !important;
            font-weight: 600 !important;
            display: flex;
            align-items: center;
            gap: 8px;
        }


        .section-body {
            padding: 14px 14px 10px;
        }

        .vendor-accordion .accordion-item {
            border: 1px solid #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
            background: #ffffff;
        }

        /* Details block in offcanvas should be borderless */
        #vendorTypeDetailsAccordion .accordion-item {
            border: none !important;
            box-shadow: none !important;
        }

        .vendor-accordion .accordion-button {
            font-size: 14px !important;
            font-weight: 600 !important;
            color: #2563eb !important;
            padding-top: 8px !important;
            padding-bottom: 8px !important;
            padding-left: 12px;
            padding-right: 12px;
            background: #ffffff;
            box-shadow: none;
        }

        .vendor-accordion .accordion-button:not(.collapsed) {
            color: #2563eb !important;
            background: #ffffff;
            box-shadow: none;
        }

        .vendor-accordion .accordion-button i {
            margin-right: 8px;
            color: #2563eb !important;
        }

        .form-row-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .field-group label {
            font-size: 11.5px !important;
            font-weight: 400;
            margin-bottom: 8px;
            display: inline-block;
            color: #111827;
        }

        .required-mark {
            color: #ef4444;
            margin-left: 2px;
        }

        .field-group .form-control {
            height: 42px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            font-size: 17px;
        }

        .vendor-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            align-items: center;
            margin-top: 12px;
        }

        .vendor-actions .btn {
            font-size: 11.5px !important;
            padding: 4px 14px;
            line-height: normal;
            border-radius: 4px;
            white-space: nowrap;
            min-height: 30px;
        }

        .btn-brand,
        .btn-cancel {
            border-radius: 4px;
            min-width: 90px;
            height: 38px;
            font-size: 14px;
            font-weight: 500;
        }

        .btn-brand {
            background: #f97316;
            color: #ffffff;
            border: 1px solid #f97316;
        }

        .btn-cancel {
            background: #ffffff;
            color: #f97316;
            border: 1px solid #f97316;
        }

        .list-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            gap: 12px;
        }

        .search-wrap {
            display: flex;
            align-items: center;
            /* background: #ffffff; */
            border-radius: 0.25rem;
            border: 1px solid #d1d5db;
            overflow: hidden;
            height: 2rem;
            /* box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); */
            /* width: 340px; */
            width: 290px;
            max-width: 100%;
        }

        .search-wrap .form-control {
            border: none;
            outline: none;
            padding: 0.25rem 0.5rem;
            flex: 1;
            background: transparent;
            height: 100%;
            font-size: 11.5px;
            box-shadow: none;
        }

        .search-btn {
            /* background: #f3f4f6; */
            border: none;
            padding: 0.25rem 0.5rem;
            color: #374151;
            cursor: pointer;
            height: 100%;
            display: flex;
            align-items: center;
            border-left: 1px solid #d1d5db;
            width: 39px;
        }

        .search-btn i {
            font-size: 11.5px;
        }

        .refresh-btn {
            width: 34px;
            height: 34px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            color: #2563eb;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .vendor-table {
            width: 100%;
            border-collapse: collapse;
            border: none;
            table-layout: fixed;
        }

        .vendor-table-scroll {
            /*height: 580px;*/
            overflow-y: auto;
            overflow-x: hidden;
            border: none;
            background: #fff;
        }

        .vendor-table th,
        .vendor-table td {
            border: none;
            border-bottom: 1px solid #e5e7eb;
            padding: 10px 10px;
            /*font-size: 13px;*//**Comment By Dipali V on 16th may 2026 for UI consistency*/*/
            font-size: 11.5px;
            vertical-align: middle;
        }

        .vendor-table thead th {
            /*color: #6b7280;*//*Comment By Dipali V on 16th may 2026 for UI consistency*/
            background-color: #f8fafc;
            font-weight: 600;
            font-size: 11.5px;
            /*padding: 12px 20px;*//*Comment By Dipali V on 16th may 2026 for UI consistency*/
            border-bottom: 1px solid #e5e7eb;
            text-align: left;
            position: sticky;
            top: 0;
            z-index: 2;
        }

        .col-index {
            width: 52px;
            text-align: center;
        }

        .col-action {
            width: 90px;
            text-align: center;
        }

        /* Is Active (3rd) and Action (4th) columns — center header and values */
        .vendor-table thead th:nth-child(3),
        .vendor-table thead th:nth-child(4),
        .vendor-table tbody td:nth-child(3),
        .vendor-table tbody td:nth-child(4) {
            text-align: center;
        }

        .col-check {
            width: 70px;
            text-align: center;
        }

        .edit-btn {
            width: 22px;
            height: 22px;
            border: 1px solid #bfdbfe;
            border-radius: 4px;
            color: #3b82f6;
            background: #eff6ff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
        }

        .vendor-table .action-icon {
            cursor: pointer;
            color: #ef4444;
        }

        .vendor-action-wrap {
            display: inline-flex;
            align-items: center;
            gap: 12px;
        }

        .vendor-action-more {
            cursor: pointer;
            /*color: #3b82f6;*/
            font-size: 15px;
            line-height: 1;
        }

        .vendor-action-check {
            width: 14px;
            height: 14px;
            cursor: pointer;
        }

        @media (max-width: 992px) {
            .form-row-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }
        }

        .offcanvas-85 {
            --bs-offcanvas-width: 85%;
        }

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
        }

        .offcanvas-close-btn:hover {
            opacity: 1;
            background: rgba(0, 0, 0, 0.08);
        }

        #vendorTypeHistoryTable th,
        #vendorTypeHistoryTable td {
            font-size: 11.5px;
            border: none !important;
            border-bottom: 1px solid #e5e7eb !important;
            vertical-align: middle;
        }

        #vendorTypeHistoryTable {
            table-layout: fixed;
            width: 100%;
        }

        #vendorTypeHistoryTable th:nth-child(1),
        #vendorTypeHistoryTable td:nth-child(1) {
            width: 24%;
        }

        #vendorTypeHistoryTable th:nth-child(2),
        #vendorTypeHistoryTable td:nth-child(2) {
            width: 22%;
        }

        #vendorTypeHistoryTable th:nth-child(3),
        #vendorTypeHistoryTable td:nth-child(3) {
            width: 22%;
        }

        #vendorTypeHistoryTable th:nth-child(4),
        #vendorTypeHistoryTable td:nth-child(4) {
            width: 16%;
        }

        #vendorTypeHistoryTable th:nth-child(5),
        #vendorTypeHistoryTable td:nth-child(5) {
            width: 16%;
        }

        .vendor-history-pagination {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .vendor-history-pagination .vendor-history-info {
            color: #111827;
            font-size: 11.5px;
            white-space: nowrap;
        }

        .vendor-history-pagination .vendor-history-buttons {
            display: flex;
            gap: 6px;
        }

        .vendor-history-page-btn {
            width: 38px;
            height: 30px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #f8fafc;
            color: #60a5fa;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0;
        }

        .vendor-history-page-btn:disabled {
            opacity: 0.85;
            cursor: not-allowed;
            color: #9ca3af;
            background: #f3f4f6;
            border-color: #d1d5db;
        }

        .vendor-list-pagination {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .vendor-list-pagination .vendor-list-info {
            color: #111827;
            font-size: 11.5px;
            white-space: nowrap;
        }

        .vendor-list-pagination .vendor-list-buttons {
            display: flex;
            gap: 6px;
        }

        .vendor-list-page-btn {
            width: 38px;
            height: 30px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #f8fafc;
            color: #60a5fa;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0;
        }

        .vendor-list-page-btn:disabled {
            opacity: 0.85;
            cursor: not-allowed;
            color: #9ca3af;
            background: #f3f4f6;
            border-color: #d1d5db;
        }

        .vendor-list-table-wrap {
            display: flex;
            flex-direction: column;
            min-height: 320px;
        }

        .vendor-list-table-wrap .vendor-table {
            margin-bottom: 0;
            border: 1px solid #ebe7e7; /*Added By Dipali to make UI consistency*/
        }

        .vendor-list-table-wrap .vendor-list-pagination {
            margin-top: auto;
            padding-top: 26px;
        }

        .vendor-top-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            padding-left: 14px;
            padding-right: 14px;
        }

        .vendor-top-actions-right {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .offcanvas-70 {
            --bs-offcanvas-width: 70%;
        }

        #vendorTypeHistoryOffcanvas {
            z-index: 1070;
        }

        body.vendor-history-open .offcanvas-backdrop.show {
            z-index: 1065;
            opacity: 0.35;
        }

        .vendor-delete-modal .modal-dialog {
            max-width: 420px;
            margin: 30px auto;
        }

        .vendor-delete-modal .modal-content {
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #d1d5db;
        }

        .vendor-delete-modal .modal-header {
            background: #4564bd;
            color: #ffffff;
            padding: 8px 14px;
            border-bottom: none;
        }

        .vendor-delete-modal .modal-title {
            color: #ffffff !important;
            font-size: 14px;
            font-weight: 400;
            margin: 0 auto;
        }

        .vendor-delete-modal .modal-body {
            text-align: center;
            font-size: 11.5px;
            padding: 22px 16px 14px;
        }

        .vendor-delete-modal .modal-footer {
            border-top: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: nowrap;
            gap: 0;
            width: 100%;
            padding: 0 18px 16px;
        }

        .vendor-delete-modal .offcanvas-close-btn {
            color: #ffffff;
            opacity: 1;
            FONT-SIZE: 11.5PX;
            FONT-WEIGHT: 800;
        }

        /* Keep alert notifications above delete modal/backdrop */
        .alertify-notifier {
            z-index: 20000 !important;
        }

        .alertify-notifier .ajs-message {
            z-index: 20001 !important;
        }

        /* Unified tooltip style for close/view/delete/history actions */
        .tooltip .tooltip-inner {
            background-color: #0e0f11 !important;
            color: #ffffff !important;
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 11.5px;
            line-height: 1.2;
        }

        .bs-tooltip-top .tooltip-arrow::before {
            border-top-color: #111827 !important;
        }

        .bs-tooltip-bottom .tooltip-arrow::before {
            border-bottom-color: #111827 !important;
        }

        .bs-tooltip-start .tooltip-arrow::before {
            border-left-color: #111827 !important;
        }

        .bs-tooltip-end .tooltip-arrow::before {
            border-right-color: #111827 !important;
        }

        .vendor-history-content-wrap {
            display: flex;
            flex-direction: column;
            min-height: 420px;
        }

        .vendor-history-content-wrap #vendorTypeHistoryTable {
            margin-bottom: 0;
        }

        .vendor-history-content-wrap .vendor-history-pagination {
            margin-top: auto;
            padding-top: 10px;
        }
        /*Added By Dipali to make UI consistency*/
        .page-title {
    color: #1e40af;
    font-size: 18px;
    font-weight: 600;
    margin: 0;
    line-height: 1.2;
}

        .page-subtitle {
            color: #6B7280;
            font-size: 11.5px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 4px;
            margin-left: -42px;
        }

        .header-icon {
            width: 26px;
            height: 26px;
            background-color: #1e40af;
            border-radius: 6px;
            margin-top: -20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 18px;
            flex-shrink: 0;
        }
        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #1e40af;
            font-size: 16px;
        }

        body {
            background: white;
        }

        /*Added By Dipali to make UI consistency*/
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <%If m_blnViewAccess = True Then%>
        <div class="vendor-page">
            <%If m_blnViewAccess = True Then%><span id="canViewVendorTypeFlag" style="display:none;"></span><%End If%>
            <%If m_blnDeleteAccess = True Then%><span id="canDeleteVendorTypeFlag" style="display:none;"></span><%End If%>
            <%If m_blnAddAccess = True Then%><span id="canAddVendorTypeFlag" style="display:none;"></span><%End If%>
            <%If m_blnEditAccess = True Then%><span id="canEditVendorTypeFlag" style="display:none;"></span><%End If%>
            <div class="container-fluid py-2 graybg vendor-master-header d-flex align-items-center justify-content-between" style="border-bottom:1px solid #e5e7eb;">
                <div class="d-flex align-items-center">
                    <%--<span class="pgheader-icon-wrap">--%>
                    <span class="header-icon">
                        <i class="fas fa-user-tag pgheader-icon" aria-hidden="true" title="Vendor type"></i>
                    </span>
                    <div class="pgheader-title-block">
                        <%--<h5 class="pgtitle"><%=MyBase.GetResourceString("C_VendorTitle")%></h5>--%>
                        <h5 class="page-title"><%=MyBase.GetResourceString("C_VendorTitle")%></h5>
                        <%--<div class="pgsubtitle"><%=MyBase.GetResourceString("C_VNote")%></div>--%>
                        <div class="page-subtitle"><%=MyBase.GetResourceString("C_VNote")%></div>
                    </div>
                </div>
            </div>
            <div class="vendor-content">
                <div class="vendor-top-actions">
                    <div class="search-wrap">
                        <input type="text" id="txtSearchVendorType" class="form-control" placeholder="<%=MyBase.GetResourceString("C_SerachType")%>"/>
                        <button id="searchBtn" type="button" class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                    <%-- Added by Dipali V on 13th May 2026 - Purpose:-Group Add and Delete on the right (near each other). --%>
                    <div class="vendor-top-actions-right">
                        <%If m_blnAddAccess = True Then%>
                        <a href="javascript:;" class="btn borderbtn addbtn" id="btnAddVendorTypeFromList" onclick="openAddVendorTypeOffcanvas()"><i class="fas fa-plus"></i><%=MyBase.GetResourceString("C_Add")%></a>
                        <%End If %>
                        <%If m_blnDeleteAccess = True Then%>
                        <button class="btn borderbtn" id="DeleteProjectBtn" onclick="deleteSelectedVendorTypes(); return false;">Delete</button>
                        <%End If %>
                    </div>
                </div>

                <div class="panel-box vendor-list-panel">
                    <div class="section-body">
                        <div class="vendor-list-table-wrap">
                            <div class="vendor-table-scroll">
                                <table class="vendor-table">
                                    <thead>
                                        <tr class="graybg">
                                            <th><%=MyBase.GetResourceString("C_TypeName")%></th>
                                            <th><%=MyBase.GetResourceString("C_Desc")%></th>
                                            <th>Active</th>
                                            <th class="col-action">Action</th>
                                            <th class="col-check text-center">
                                                <input type="checkbox" class="vendor-action-check" id="chkSelectAllVendor" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="vendorTypeListBody"></tbody>
                                </table>
                            </div>
                            <div class="vendor-list-pagination">
                                <div class="vendor-list-info">
                                    <span id="vendorListTotalRecordsText"><%=MyBase.GetResourceString("C_TotalRec")%></span>
                                </div>
                                <div class="vendor-list-buttons">
                                    <button type="button" class="vendor-list-page-btn" id="vendorListPrevPageBtn" title="Previous Page" onclick="goToVendorListPreviousPage()" disabled>
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button type="button" class="vendor-list-page-btn" id="vendorListNextPageBtn" title="Next Page" onclick="goToVendorListNextPage()" disabled>
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="vendorTypeDetailsOffcanvas" aria-labelledby="vendorTypeDetailsTitle">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center justify-content-between">
                                <h5 class="pgtitle" id="vendorTypeDetailsTitle"><%=MyBase.GetResourceString("C_VenDetail")%></h5>
                                <div class="d-flex align-items-center">
                                    <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="Close" data-bs-toggle="tooltip" data-bs-placement="left"> &#x2715;</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                  <%--Commented & Added By Dipali V On 13th May 2026 For Remove background color of save button make UI consistency--%>
  <%--<div class="container-fluid py-2 graybg mb-2">--%>
  <div class="container-fluid py-2 mb-2">
      <%--End of Commented & Added By Dipali V On 13th May 2026 For Remove background color of save button make UI consistency--%>
                    <div class="row">
                        <div class="col-sm-12 text-end">
                            <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                            <button type="button" class="btn btnyellow me-2" id="btnVendorTypeUpdate" style="display:none;" onclick="saveVendorTypeUpdate()" data-bs-toggle="tooltip" title="Save"><%=MyBase.GetResourceString("C_Save")%></button>
                            <%End If %>
                            <button type="button" class="btn borderbtn" id="btnVendorTypeShowHistory" onclick="openVendorTypeHistory()" title="Show History" data-bs-toggle="tooltip" data-bs-placement="top"><%=MyBase.GetResourceString("C_Hist")%></button>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-sm-12 text-end">
                            <label class="form-label mb-0">(<span class="text-danger"><%=MyBase.GetResourceString("C_str")%></span> <%=MyBase.GetResourceString("C_Mand")%> </label>
                        </div>
                    </div>
                </div>

                <div class="accordion Off_acordian_panel my-3" id="vendorTypeDetailsAccordion">
                    <div class="accordion-item mb-3">
                          <%--Commented & Added By Dipali V On 13th May 2026 For Remove Details Header make UI consistency--%>
                        <%--<h2 class="accordion-header">
                            <div class="section-head graybg"><%=MyBase.GetResourceString("C_Detail")%></div>

                        </h2>--%>
                          <%--End of Commented & Added By Dipali V On 13th May 2026 For Remove Details Header make UI consistency--%>
                        <div id="vendorTypeDetailTab" class="accordion-collapse show">
                            <div class="accordion-body">
                                <input type="hidden" id="offVendorTypeId" value="" />
                                <div class="row form-group mt-3">
                                    <div class="col-sm-6 mb-2">
                                        <div class="row">
                                            <div class="col-sm-4 text-end">
                                                <label><%=MyBase.GetResourceString("C_TypeName")%> : <span class="text-danger"><%=MyBase.GetResourceString("C_str")%></span></label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input type="text" id="offVendorTypeName" class="form-control" value="IT Vendor" maxlength="50" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-2">
                                        <div class="row">
                                            <div class="col-sm-4 text-end">
                                                <label>Active : <span class="text-danger">
<%--                                                    <%=MyBase.GetResourceString("C_str")%>--%>

                                                                </span></label>
                                            </div>
                                            <div class="col-sm-8 d-flex align-items-center" style="padding-left:4px;">
                                                <input type="hidden" id="offVendorTypeStatus" value="1" />
                                                <div class="form-check d-inline-flex align-items-center" style="min-height:32px; margin:0;">
                                                    <input class="vendor-active-checkbox" type="checkbox" id="offVendorTypeStatusActive" value="1" checked />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-2">
                                        <div class="row">
                                            <div class="col-sm-4 text-end">
                                                <label><%=MyBase.GetResourceString("C_Desc")%>:</label>
                                            </div>
                                            <div class="col-sm-8">
                                             <%--   Commented & Added By Dipali V On 13th May 2026 For maxlength issue--%>
                                                <%--<textarea id="offVendorTypeDescription" class="form-control" rows="3" maxlength="2000">Vendors providing IT related services and resources</textarea>--%>
                                                <textarea id="offVendorTypeDescription" class="form-control" rows="3" maxlength="500">Vendors providing IT related services and resources</textarea>
                                                
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

        <div class="modal fade vendor-delete-modal" id="vendorTypeDeleteModal" tabindex="-1" aria-labelledby="vendorTypeDeleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="vendorTypeDeleteModalLabel"><%=MyBase.GetResourceString("C_CfrmDel")%></h5>
                        <button type="button" class="offcanvas-close-btn" data-bs-dismiss="modal" aria-label="Close" title="Close" data-bs-toggle="tooltip" data-bs-placement="left">&#x2715;</button>
                    </div>
                    <div class="modal-body">
                      <%=MyBase.GetResourceString("C_ConfDel")%> 
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_No")%></button>
                        <button type="button" class="btn btnyellow" id="confirmVendorTypeDeleteBtn" onclick="deleteVendorTypeRow()"><%=MyBase.GetResourceString("C_Yes")%></button>
                    </div>
                </div>
            </div>
        </div>

        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" data-bs-backdrop="true" tabindex="-1" id="vendorTypeHistoryOffcanvas" aria-labelledby="vendorTypeHistoryTitle">
            <div class="offcanvas-header graybg">
                <h5 class="offcanvas-title pgtitle" id="vendorTypeHistoryTitle"><%=MyBase.GetResourceString("C_Hist")%></h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close" title="Close" data-bs-toggle="tooltip" data-bs-placement="left"></button>
            </div>
            <div class="offcanvas-body">
                <div class="py-1 form-inline hstryfltr">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <div class="col-sm-6 d-flex justify-content-end">
                                    <label for="vendorHistoryModifiedField"><%=MyBase.GetResourceString("C_MF")%> :</label>
                                </div>
                                <div class="col-sm-6">
                                    <select class="selectpicker" data-live-search="true" id="vendorHistoryModifiedField" onchange="applyVendorHistoryFilters()">
                                        <option value=""><%=MyBase.GetResourceString("C_SelMF")%></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <div class="col-sm-6 d-flex justify-content-end">
                                    <label for="vendorHistoryModifiedBy"><%=MyBase.GetResourceString("C_MBy")%> :</label>
                                </div>
                                <div class="col-sm-6">
                                    <select class="selectpicker" data-live-search="true" id="vendorHistoryModifiedBy" onchange="applyVendorHistoryFilters()">
                                        <option value=""><%=MyBase.GetResourceString("C_SelMBy")%></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex justify-content-between">
                               <%-- <span><%=MyBase.GetResourceString("C_VT")%></span>
                                <span><%=MyBase.GetResourceString("C_AuT")%></span>--%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="vendor-history-content-wrap">
                    <table id="vendorTypeHistoryTable" class="table table-bordered table-sm" style="width: 100%;">
                        <thead>
                            <tr>
                                <th><%=MyBase.GetResourceString("C_MF")%> </th>
                                <th><%=MyBase.GetResourceString("C_OV")%></th>
                                <th><%=MyBase.GetResourceString("C_NV")%></th>
                                <th><%=MyBase.GetResourceString("C_MD")%></th>
                                <th><%=MyBase.GetResourceString("C_MBy")%></th>
                            </tr>
                        </thead>
                        <tbody id="vendorTypeHistoryBody"></tbody>
                    </table>

                    <div class="vendor-history-pagination">
                        <div class="vendor-history-info">
                            <span id="vendorHistoryTotalRecordsText"><%=MyBase.GetResourceString("C_TotalRec")%></span>
                        </div>
                        <div class="vendor-history-buttons">
                            <button type="button" class="vendor-history-page-btn" id="vendorHistoryPrevPageBtn" title="Previous Page" onclick="goToVendorHistoryPreviousPage()" disabled>
                                <i class="fas fa-angle-double-left"></i>
                            </button>
                            <button type="button" class="vendor-history-page-btn" id="vendorHistoryNextPageBtn" title="Next Page" onclick="goToVendorHistoryNextPage()" disabled>
                                <i class="fas fa-angle-double-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%Else%>
        <div class="vendor-page">
            <div class="container-fluid py-2 graybg">
                <h5 class="pgtitleView"><%=MyBase.GetResourceString("C_ViewAccess")%></h5>
            </div>
        </div>
        <%End If %>
    </form>

    <script type="text/javascript">

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';


        var LoginType = '<%= Session("LoginType") %>';
        var UserId = '<%= If(Session("intUserID") Is Nothing, 0, Session("intUserID")) %>';
        var UserName = '<%= Session("strUserName") %>';

        var canAddAccess = !!document.getElementById('canAddVendorTypeFlag');
        var canEditAccess = !!document.getElementById('canEditVendorTypeFlag');
        var canDeleteAccess = !!document.getElementById('canDeleteVendorTypeFlag');
        var canViewAccess = !!document.getElementById('canViewVendorTypeFlag');
        var currentVendorTypeRow = null;
        var vendorTypeDeleteRow = null;
        var vendorTypeDeleteId = 0;
        var vendorTypeDeleteQueue = [];
        var vendorSelectAllMode = false;
        var vendorSelectedIds = [];
        var vendorExcludedIds = [];
        var isAddVendorTypeMode = false;
        var vendorTypeIdCounter = 160;
        var vendorTypeHistoryData = [];
        var vendorTypeHistoryApiRows = [];
        var vendorHistoryCurrentPage = 1;
        var vendorHistoryPageSize = 5;
        var vendorHistoryTotalPages = 1;
        var vendorHistoryTotalRecords = 0;
        var vendorListPageSize = 5;
        var vendorListCurrentPage = 1;
        var vendorListTotalPages = 1;
        var vendorListTotalRecords = 0;
        var vendorListTotalSelectableRecords = 0;
        var vendorSearchDebounceTimer = null;

        // Added by Dipali V on 13th May 2026 - Purpose:-Vendor Type Active checkbox disabled on Add; enabled when editing existing record.
        function setVendorTypeActiveCheckboxEnabled(isEnabled) {
            var chk = document.getElementById('offVendorTypeStatusActive');
            if (!chk) return;
            chk.disabled = !isEnabled;
        }

        function setVendorTypeDetailsFieldsEditable(isEditable) {
            var nameInput = document.getElementById('offVendorTypeName');
            var descInput = document.getElementById('offVendorTypeDescription');
            if (nameInput) nameInput.disabled = !isEditable;
            if (descInput) descInput.disabled = !isEditable;
        }

        function setVendorTypeOffcanvasSaveVisible(isVisible) {
            var saveBtn = document.getElementById('btnVendorTypeUpdate');
            if (saveBtn) saveBtn.style.display = isVisible ? '' : 'none';
        }

        // Add offcanvas: Save + name/description only when Add access; Active checkbox stays disabled on add.
        function applyVendorTypeOffcanvasAddMode() {
            setVendorTypeOffcanvasSaveVisible(canAddAccess);
            setVendorTypeDetailsFieldsEditable(canAddAccess);
            setVendorTypeActiveCheckboxEnabled(false);
        }

        // View/Edit offcanvas: Save + editable fields only when Edit access; otherwise read-only, no Save.
        function applyVendorTypeOffcanvasEditViewMode() {
            setVendorTypeOffcanvasSaveVisible(canEditAccess);
            setVendorTypeDetailsFieldsEditable(canEditAccess);
            setVendorTypeActiveCheckboxEnabled(canEditAccess);
        }

        function openOffcanvas(trigger, offcanvasId, vendorTypeId) {
            
            try {
                isAddVendorTypeMode = false;
                var titleEl = document.getElementById('vendorTypeDetailsTitle');
                var historyBtn = document.getElementById('btnVendorTypeShowHistory');
                if (titleEl) titleEl.textContent = 'Vendor Type Details';
                if (historyBtn) historyBtn.style.display = 'none';
                applyVendorTypeOffcanvasEditViewMode();
                if (trigger) {
                    var row = trigger.closest('tr');
                    if (row) {
                        currentVendorTypeRow = row;
                        var nameCell = row.children[0];
                        var descCell = row.children[1];
                        if (nameCell) document.getElementById('offVendorTypeName').value = nameCell.textContent.trim();
                        if (descCell) document.getElementById('offVendorTypeDescription').value = descCell.textContent.trim();
                    }
                }
                document.getElementById('offVendorTypeId').value = vendorTypeId || '';
                document.getElementById('offVendorTypeStatus').value = '1';
                document.getElementById('offVendorTypeStatusActive').checked = true;

                // Fetch selected VendorType full details for edit mode
                var detailPayload = JSON.stringify({
                    VendorTypeID: parseInt(vendorTypeId, 10) || null,
                   
                    Search: null,
                    PageNumber: 1,
                    PageSize: 1
                });
                var detailResult = AJAXCallWithResult('api/SM_VendorType/GetVendorTypeMaster', detailPayload, false);
                var detailObj = detailResult || {};
                var detailRows = detailObj.vendorResult || [];
                if (detailRows.length > 0) {
                    var d = detailRows[0];
                    document.getElementById('offVendorTypeId').value = (d.vendorTypeID !== undefined ? d.vendorTypeID : d.VendorTypeID) || vendorTypeId || '';
                    document.getElementById('offVendorTypeName').value = (d.vendorTypeName !== undefined ? d.vendorTypeName : d.VendorTypeName) || '';
                    document.getElementById('offVendorTypeDescription').value = (d.description !== undefined ? d.description : d.Description) || '';
                    var isActiveVal = (d.isActive !== undefined ? d.isActive : d.IsActive);
                    var statusValue = (isActiveVal === true || String(isActiveVal) === 'true' || String(isActiveVal) === '1') ? '1' : '0';
                    document.getElementById('offVendorTypeStatus').value = statusValue;
                    document.getElementById('offVendorTypeStatusActive').checked = (statusValue === '1');
                }

                // Show History button only when history records exist for selected Vendor Type
                var selectedVendorTypeId = parseInt((document.getElementById('offVendorTypeId') || {}).value || '0', 10) || null;
                toggleVendorTypeHistoryButton(selectedVendorTypeId);

                if (typeof bootstrap !== 'undefined') {
                    var panel = document.getElementById(offcanvasId);
                    if (panel) bootstrap.Offcanvas.getOrCreateInstance(panel).show();
                }
            } catch (e) { }
        }

        function openAddVendorTypeOffcanvas() {
            try {
                if (!canAddAccess) return;
                isAddVendorTypeMode = true;
                currentVendorTypeRow = null;
                var titleEl = document.getElementById('vendorTypeDetailsTitle');
                var historyBtn = document.getElementById('btnVendorTypeShowHistory');
                // Added By  May 2026 For Remove Details Header make UI consistency-- %>
               // if (titleEl) titleEl.textContent = 'Add Vendor Type';
                if (titleEl) titleEl.textContent = 'Vendor Type Details';
               //End of Added By Dipali V 13th May 2026 For Remove Details Header make UI consistency-- %>
                if (historyBtn) historyBtn.style.display = 'none';
                vendorTypeIdCounter += 1;
                document.getElementById('offVendorTypeId').value = '';
                document.getElementById('offVendorTypeStatus').value = '1';
                document.getElementById('offVendorTypeStatusActive').checked = true;
                document.getElementById('offVendorTypeName').value = '';
                document.getElementById('offVendorTypeDescription').value = '';
                applyVendorTypeOffcanvasAddMode();

                if (typeof bootstrap !== 'undefined') {
                    var panel = document.getElementById('vendorTypeDetailsOffcanvas');
                    if (panel) bootstrap.Offcanvas.getOrCreateInstance(panel).show();
                }
            } catch (e) { }
        }

        function toggleVendorTypeHistoryButton(vendorTypeId) {
            var historyBtn = document.getElementById('btnVendorTypeShowHistory');
            if (!historyBtn) return;
            historyBtn.style.display = 'none';

            var id = parseInt(vendorTypeId, 10) || 0;
            if (id <= 0) return;

            var payload = JSON.stringify({
                VendorTypeID: id,
                ModifiedField: null,
                ModifiedBy: null,
                PageNumber: 1,
                PageSize: 1
            });

            var result = AJAXCallWithResult('api/SM_VendorType/GetVendorTypeHistory', payload, false);
            var historyObj = result && (result.data !== undefined ? result.data : (result.Data !== undefined ? result.Data : result));
            var rows = (historyObj && historyObj.vendorResult) ? historyObj.vendorResult : [];
            if (rows && rows.length > 0) {
                historyBtn.style.display = '';
            }
        }

        function saveVendorTypeUpdate() {
            
            try {
                var updatedName = document.getElementById('offVendorTypeName').value || '';
                var updatedDesc = document.getElementById('offVendorTypeDescription').value || '';
                var currentId = document.getElementById('offVendorTypeId').value || '';
                var currentStatus = document.getElementById('offVendorTypeStatusActive').checked ? '1' : '0';
                document.getElementById('offVendorTypeStatus').value = currentStatus;
                var isAddMode = isAddVendorTypeMode;

                if (isAddMode) {
                    if (!canAddAccess) {
                        return;
                    }
                    var isActiveBool = (parseInt(currentStatus, 10) === 1);
                  

                    // Start of Added by Vyankat B. on 23-04-2026 - Add Vendor Type API integration using AJAXCallWithResult
                    var addParam = {
                        VendorTypeName: updatedName.trim(),
                        IsActive: isActiveBool,
                        Description: updatedDesc.trim(),
                        CreatedBy: UserName
                    };
                    var addResult = AJAXCallWithResult('api/SM_VendorType/AddVendorType', JSON.stringify(addParam), false);
                    var addStatus = 0;
                    var addMessage = '';
                    var addedVendorTypeId = currentId;

                    if (addResult && addResult.vendorResult && addResult.vendorResult.AddVendorTypeResponse.length > 0) {

                        var response = addResult.vendorResult.AddVendorTypeResponse[0];

                        addStatus = response.status || 0;
                        addMessage = response.message || '';
                        addedVendorTypeId = response.vendorTypeID || addedVendorTypeId;
                    }

                    if (addStatus !== 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(addMessage || '<%=MyBase.GetResourceString("C_UnableAdd")%> ', 'error', 5);
                        return;
                    }
                    // End of Added by Vyankat B. on 23-04-2026 - Add Vendor Type API integration using AJAXCallWithResult

                    var tbody = document.querySelector('.vendor-table tbody');
                    if (!tbody) return;
                    var newRow = document.createElement('tr');
                    newRow.innerHTML =
                        formatVendorListTextCell(updatedName.trim(), 70) +
                        formatVendorListTextCell(updatedDesc.trim(), 70) +
                        '<td class="text-center">' +
                        (canViewAccess ? '<i class="fas fa-ellipsis-v vendor-action-more" onclick="openOffcanvas(this, \'vendorTypeDetailsOffcanvas\', ' + addedVendorTypeId + ')" data-bs-title="View Details" data-bs-toggle="tooltip" data-bs-placement="top"></i>' : '') +
                        '</td>' +
                        buildDeleteCheckboxCell(addedVendorTypeId, updatedName.trim(), false);
                    tbody.appendChild(newRow);
                    isAddVendorTypeMode = false;
                    addVendorTypeHistory('Vendor Type Name', '-', updatedName.trim());
                    addVendorTypeHistory('Description', '-', updatedDesc.trim());
                    renderVendorListTablePage(vendorListCurrentPage);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(addMessage || '<%=MyBase.GetResourceString("C_VendorAdd")%> ', 'success', 5);

                    // Close details panel only for Add mode after successful save
                    if (typeof bootstrap !== 'undefined') {
                        var addPanel = document.getElementById('vendorTypeDetailsOffcanvas');
                        if (addPanel) {
                            bootstrap.Offcanvas.getOrCreateInstance(addPanel).hide();
                        }
                    }
                } else {
                    if (!canEditAccess) {
                        return;
                    }
                    // Edit mode - call API update using same AddVendorType endpoint (SP handles update when VendorTypeID is passed)
                    var vendorTypeIdToUpdate = parseInt(currentId, 10) || 0;
                    if (vendorTypeIdToUpdate <= 0) return;
                    var isActiveEdit = (parseInt(currentStatus, 10) === 1);

                    var updateParam = {
                        VendorTypeID: vendorTypeIdToUpdate,
                        VendorTypeName: updatedName.trim(),
                        IsActive: isActiveEdit,
                        Description: updatedDesc.trim(),
                        ModifiedBy: UserName
                    };

                    var updateResult = AJAXCallWithResult('api/SM_VendorType/AddVendorType', JSON.stringify(updateParam), false);
                    var updStatus = 0;
                    var updMessage = '';
                    if (updateResult && updateResult.vendorResult.AddVendorTypeResponse[0] && updateResult.vendorResult.AddVendorTypeResponse.length > 0) {
                        updStatus = parseInt(updateResult.vendorResult.AddVendorTypeResponse[0].status !== undefined ? updateResult.vendorResult.AddVendorTypeResponse[0].status : updateResult.vendorResult.AddVendorTypeResponse[0].Status, 10) || 0;
                        updMessage = (updateResult.vendorResult.AddVendorTypeResponse[0].message !== undefined ? updateResult.vendorResult.AddVendorTypeResponse[0].message : updateResult.vendorResult.AddVendorTypeResponse[0].Message) || '';
                    }


                    if (updStatus !== 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(updMessage || '<%=MyBase.GetResourceString("C_UnableUpd")%> ', 'error', 5);
                        return;
                    }
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(updMessage || '<%=MyBase.GetResourceString("C_VendorUpd")%>', 'success', 5);

                    // Refresh Show History button immediately after update
                    toggleVendorTypeHistoryButton(vendorTypeIdToUpdate);

                    renderVendorListTablePage(vendorListCurrentPage);
                }
            } catch (e) { }
        }

        function ConfirmDelete(trigger, vendorTypeId) {
            try {
                vendorTypeDeleteQueue = [];
                vendorTypeDeleteRow = trigger ? trigger.closest('tr') : null;
                vendorTypeDeleteId = parseInt(vendorTypeId, 10) || 0;
                var modalEl = document.getElementById('vendorTypeDeleteModal');
                if (modalEl && typeof bootstrap !== 'undefined') {
                    bootstrap.Modal.getOrCreateInstance(modalEl).show();
                }
            } catch (e) { }
        }

        // Added by Dipali V on 15th May 2026 - Purpose:-Iterate all paginated Vendor Type list rows (current search) for cross-page select/delete.
        function forEachVendorTypeListRow(rowCallback) {
            var searchText = (document.getElementById('txtSearchVendorType') || {}).value || '';
            for (var p = 1; p <= vendorListTotalPages; p++) {
                var payloadAll = JSON.stringify({
                    VendorTypeID: null,
                    Search: searchText,
                    PageNumber: p,
                    PageSize: vendorListPageSize
                });
                var allResult = AJAXCallWithResult('api/SM_VendorType/GetVendorTypeMaster', payloadAll, false);
                var allRows = (allResult && allResult.vendorResult) ? allResult.vendorResult : [];
                for (var a = 0; a < allRows.length; a++) {
                    rowCallback(allRows[a] || {});
                }
            }
        }
        function getVendorTypeRowIdFromRow(r) {
            return parseInt(r.vendorTypeID !== undefined ? r.vendorTypeID : r.VendorTypeID, 10) || 0;
        }
        function isVendorTypeRowInUse(r) {
            var inUseVal = r.inUse !== undefined ? r.inUse : r.InUse;
            return (inUseVal === true || String(inUseVal).toLowerCase() === 'true' || String(inUseVal) === '1');
        }
        function refreshVendorListTotalSelectableRecords() {
            var count = 0;
            if (vendorListTotalPages < 1 || vendorListTotalRecords < 1) {
                vendorListTotalSelectableRecords = 0;
                return;
            }
            forEachVendorTypeListRow(function (rr) {
                if (!isVendorTypeRowInUse(rr)) {
                    count++;
                }
            });
            vendorListTotalSelectableRecords = count;
        }
        function getVendorTypeGlobalSelectedCount() {
            if (vendorSelectAllMode) {
                return Math.max(0, vendorListTotalSelectableRecords - vendorExcludedIds.length);
            }
            return vendorSelectedIds.length;
        }
        function resetVendorTypeSelectionState() {
            vendorSelectAllMode = false;
            vendorSelectedIds = [];
            vendorExcludedIds = [];
        }

        function deleteSelectedVendorTypes() {
            try {
                if (!canDeleteAccess) return;
                if (vendorSelectAllMode) {
                    vendorTypeDeleteQueue = [];
                    forEachVendorTypeListRow(function (rr) {
                        var idNum = getVendorTypeRowIdFromRow(rr);
                        if (idNum > 0 && !isVendorTypeRowInUse(rr) && vendorExcludedIds.indexOf(idNum) === -1) {
                            vendorTypeDeleteQueue.push(idNum);
                        }
                    });
                } else {
                    vendorTypeDeleteQueue = vendorSelectedIds.slice();
                }

                if (!vendorTypeDeleteQueue || vendorTypeDeleteQueue.length === 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please select at least one record.', 'error', 5);
                    return;
                }

                if (vendorTypeDeleteQueue.length === 0) return;
                vendorTypeDeleteId = vendorTypeDeleteQueue.shift();

                var modalEl = document.getElementById('vendorTypeDeleteModal');
                if (modalEl && typeof bootstrap !== 'undefined') {
                    bootstrap.Modal.getOrCreateInstance(modalEl).show();
                }
            } catch (e) { }
        }

        function deleteVendorTypeRow() {
            
            try {
                var ids = [];
                if (vendorTypeDeleteId > 0) {
                    ids.push(vendorTypeDeleteId);
                }
                if (vendorTypeDeleteQueue && vendorTypeDeleteQueue.length > 0) {
                    for (var q = 0; q < vendorTypeDeleteQueue.length; q++) {
                        if (parseInt(vendorTypeDeleteQueue[q], 10) > 0) {
                            ids.push(parseInt(vendorTypeDeleteQueue[q], 10));
                        }
                    }
                }

                // Make unique CSV for SP @VendorTypeIDs
                var uniqueIds = Array.from(new Set(ids));
                var idCsv = uniqueIds.join(',');
                var payload = JSON.stringify({ VendorTypeIDs: idCsv });
                var result = AJAXCallWithResult('api/SM_VendorType/DeleteVendorType', payload, false);
                var status = 0;
                var message = '';
                if (result && result.vendorResult.DeleteVendorTypeResponse && result.vendorResult.DeleteVendorTypeResponse.length > 0) {
                    status = parseInt(result.vendorResult.DeleteVendorTypeResponse[0].status !== undefined ? result.vendorResult.DeleteVendorTypeResponse[0].status : result.vendorResult.DeleteVendorTypeResponse[0].Status, 10) || 0;
                    message = (result.vendorResult.DeleteVendorTypeResponse[0].message !== undefined ? result.vendorResult.DeleteVendorTypeResponse[0].message : result.vendorResult.DeleteVendorTypeResponse[0].Message) || '';
                }
                if (status !== 1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(message || '<%=MyBase.GetResourceString("C_UnableDel")%>', 'error', 5);
                    return;
                }
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(message || '<%=MyBase.GetResourceString("C_VendorDel")%>', 'success', 5);
                vendorTypeDeleteRow = null;
                vendorTypeDeleteQueue = [];
                vendorTypeDeleteId = 0;
                vendorSelectAllMode = false;
                vendorSelectedIds = [];
                vendorExcludedIds = [];
                // Added By Dipali V On 15th May 2026 - Purpose:-After delete from page 2+, show first page (e.g. select all on page 2 then delete).
                var pageAfterDelete = vendorListCurrentPage > 1 ? 1 : vendorListCurrentPage;
                renderVendorListTablePage(pageAfterDelete);
                var modalEl = document.getElementById('vendorTypeDeleteModal');
                if (modalEl && typeof bootstrap !== 'undefined') {
                    bootstrap.Modal.getOrCreateInstance(modalEl).hide();
                }
            } catch (e) { }
        }

        function addVendorTypeHistory(modifiedField, oldValue, newValue) {
            vendorTypeHistoryData.unshift({
                modifiedField: modifiedField,
                oldValue: oldValue,
                newValue: newValue,
                modifiedDate: new Date(),
                modifiedBy: 'Admin'
            });
        }

        function renderVendorTypeHistory(rows) {
            var $body = document.getElementById('vendorTypeHistoryBody');
            if (!$body) return;
            if (!rows || rows.length === 0) {
                $body.innerHTML = '<tr><td colspan="5" class="text-center"><%=MyBase.GetResourceString("C_NoHis")%></td></tr>';
                document.getElementById('vendorHistoryTotalRecordsText').textContent = 'Total Records: 0';
                return;
            }
            var html = '';
            for (var i = 0; i < rows.length; i++) {
                var r = rows[i];
                var modifiedFieldValue = (r.modifiedField || r.ModifiedField || '');
                var oldValue = (r.oldValue || r.OldValue || '');
                var newValue = (r.newValue || r.NewValue || '');
                // Added by Dipali V on 13th May 2026 - Purpose:-Is Active: 1/0 -> Yes/No; match "Is Active" and "IsActive".
                if (isVendorTypeActiveHistoryField(modifiedFieldValue)) {
                    oldValue = mapVendorActiveYesNo(oldValue);
                    newValue = mapVendorActiveYesNo(newValue);
                }
                html += '<tr>' +
                    formatVendorHistoryTextCell(modifiedFieldValue, 40) +
                    formatVendorHistoryTextCell(oldValue, 40) +
                    formatVendorHistoryTextCell(newValue, 40) +
                    formatVendorHistoryTextCell(formatVendorHistoryDate((r.modifiedDate || r.ModifiedDate || '')), 40) +
                    formatVendorHistoryTextCell((r.modifiedBy || r.ModifiedBy || ''), 40) +
                    '</tr>';
            }
            $body.innerHTML = html;
            document.getElementById('vendorHistoryTotalRecordsText').textContent = 'Total Records: ' + vendorHistoryTotalRecords;
            initializeVendorTooltips();
        }

        function bindVendorHistoryFilters() {
            
            var modifiedFieldDd = document.getElementById('vendorHistoryModifiedField');
            var modifiedByDd = document.getElementById('vendorHistoryModifiedBy');
            if (!modifiedFieldDd || !modifiedByDd) return;

            var fieldOptions = '<option value="">Select Modified Field</option>';
            var byOptions = '<option value="">Select Modified By</option>';
            var vendorTypeId = parseInt((document.getElementById('offVendorTypeId') || {}).value || '0', 10) || null;

            var fieldResult = AJAXCallWithResult('api/SM_VendorType/GetVendorTypeModifiedField', JSON.stringify({ VendorTypeID: vendorTypeId }), false);
            var fieldObj = fieldResult && (fieldResult.data !== undefined ? fieldResult.data : (fieldResult.Data !== undefined ? fieldResult.Data : fieldResult));
            var fieldData = (fieldObj && fieldObj.vendorResult.VendorTypeModifiedFieldResponse) ? fieldObj.vendorResult.VendorTypeModifiedFieldResponse : [];
            for (var i = 0; i < fieldData.length; i++) {
                var f = fieldData[i].modifiedField !== undefined ? fieldData[i].modifiedField : fieldData[i].ModifiedField;
                if (f) {
                    fieldOptions += '<option value="' + f + '">' + f + '</option>';
                }
            }

            var byResult = AJAXCallWithResult('api/SM_VendorType/GetVendorTypeModifiedBy', JSON.stringify({ VendorTypeID: vendorTypeId }), false);
            var byObj = byResult && (byResult.data !== undefined ? byResult.data : (byResult.Data !== undefined ? byResult.Data : byResult));
            var byData = (byObj && byObj.vendorResult.VendorTypeModifiedByResponse) ? byObj.vendorResult.VendorTypeModifiedByResponse : [];
            for (var j = 0; j < byData.length; j++) {
                var b = byData[j].modifiedBy !== undefined ? byData[j].modifiedBy : byData[j].ModifiedBy;
                if (b) {
                    byOptions += '<option value="' + b + '">' + b + '</option>';
                }
            }
            modifiedFieldDd.innerHTML = fieldOptions;
            modifiedByDd.innerHTML = byOptions;
            if (window.jQuery && jQuery.fn.selectpicker) {
                jQuery('#vendorHistoryModifiedField').selectpicker('refresh');
                jQuery('#vendorHistoryModifiedBy').selectpicker('refresh');
            }
        }

        function applyVendorHistoryFilters() {
            vendorHistoryCurrentPage = 1;
            loadVendorTypeHistory(vendorHistoryCurrentPage);
        }

        function updateVendorHistoryPaginationUI() {
            var totalText = document.getElementById('vendorHistoryTotalRecordsText');
            if (totalText) totalText.textContent = 'Total Records: ' + vendorHistoryTotalRecords;
            var prevBtn = document.getElementById('vendorHistoryPrevPageBtn');
            var nextBtn = document.getElementById('vendorHistoryNextPageBtn');
            if (prevBtn) prevBtn.disabled = vendorHistoryCurrentPage <= 1;
            if (nextBtn) nextBtn.disabled = vendorHistoryCurrentPage >= vendorHistoryTotalPages;
        }

        function loadVendorTypeHistory(pageNo) {
            var vendorTypeId = parseInt((document.getElementById('offVendorTypeId') || {}).value || '0', 10) || null;
            var modifiedField = (document.getElementById('vendorHistoryModifiedField') || {}).value || '';
            var modifiedBy = (document.getElementById('vendorHistoryModifiedBy') || {}).value || '';
            var payload = JSON.stringify({
                VendorTypeID: vendorTypeId,
                ModifiedField: modifiedField || null,
                ModifiedBy: modifiedBy || null,
                PageNumber: pageNo || 1,
                PageSize: vendorHistoryPageSize
            });
            var result = AJAXCallWithResult('api/SM_VendorType/GetVendorTypeHistory', payload, false);
            var historyObj = result && (result.data !== undefined ? result.data : (result.Data !== undefined ? result.Data : result));
            var rows = (historyObj && historyObj.vendorResult) ? historyObj.vendorResult : [];
            var pagination = (historyObj && historyObj.paginationResult && historyObj.paginationResult.length > 0) ? historyObj.paginationResult[0] : null;
            vendorHistoryTotalRecords = pagination ? (pagination.totalRecords !== undefined ? pagination.totalRecords : pagination.TotalRecords || rows.length) : rows.length;
            vendorHistoryTotalPages = pagination ? (pagination.totalPages !== undefined ? pagination.totalPages : pagination.TotalPages || 1) : 1;
            vendorHistoryCurrentPage = pagination ? (pagination.currentPage !== undefined ? pagination.currentPage : pagination.CurrentPage || pageNo || 1) : (pageNo || 1);
            vendorHistoryTotalPages = Math.max(1, parseInt(vendorHistoryTotalPages, 10) || 1);
            vendorHistoryCurrentPage = Math.max(1, parseInt(vendorHistoryCurrentPage, 10) || 1);
            renderVendorTypeHistory(rows);
            updateVendorHistoryPaginationUI();
        }

        function openVendorTypeHistory() {
            try {
                bindVendorHistoryFilters();
                loadVendorTypeHistory(1);

                var panel = document.getElementById('vendorTypeHistoryOffcanvas');
                if (panel && typeof bootstrap !== 'undefined') {
                    bootstrap.Offcanvas.getOrCreateInstance(panel).show();
                }
            } catch (e) {
                renderVendorTypeHistory([]);
                updateVendorHistoryPaginationUI();
                var panelFallback = document.getElementById('vendorTypeHistoryOffcanvas');
                if (panelFallback && typeof bootstrap !== 'undefined') {
                    bootstrap.Offcanvas.getOrCreateInstance(panelFallback).show();
                }
            }
        }

        function goToVendorHistoryPreviousPage() {
            if (vendorHistoryCurrentPage > 1) {
                loadVendorTypeHistory(vendorHistoryCurrentPage - 1);
            }
        }

        function goToVendorHistoryNextPage() {
            if (vendorHistoryCurrentPage < vendorHistoryTotalPages) {
                loadVendorTypeHistory(vendorHistoryCurrentPage + 1);
            }
        }

        function renderVendorListTablePage(pageNo) {
            loadVendorTypeMasterList(pageNo);
        }

        function goToVendorListPreviousPage() {
            if (vendorListCurrentPage > 1) {
                renderVendorListTablePage(vendorListCurrentPage - 1);
            }
        }

        function goToVendorListNextPage() {
            if (vendorListCurrentPage < vendorListTotalPages) {
                renderVendorListTablePage(vendorListCurrentPage + 1);
            }
        }

        function updateVendorListPaginationUI() {
            var totalText = document.getElementById('vendorListTotalRecordsText');
            if (totalText) totalText.textContent = 'Total Records: ' + vendorListTotalRecords;

            var prevBtn = document.getElementById('vendorListPrevPageBtn');
            var nextBtn = document.getElementById('vendorListNextPageBtn');
            if (prevBtn) prevBtn.disabled = vendorListCurrentPage <= 1;
            if (nextBtn) nextBtn.disabled = vendorListCurrentPage >= vendorListTotalPages;
        }

        function escapeVendorListText(value) {
            return String(value || '')
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        function formatVendorListTextCell(value, maxLength) {
            var text = String(value || '');
            var escapedFull = escapeVendorListText(text);
            if (text.length > maxLength) {
                var shortText = escapeVendorListText(text.substring(0, maxLength) + '...');
                return '<td title="' + escapedFull + '" data-bs-toggle="tooltip" data-bs-placement="top">' + shortText + '</td>';
            }
            return '<td>' + escapedFull + '</td>';
        }

        function formatVendorHistoryTextCell(value, maxLength) {
            var text = String(value || '');
            var escapedFull = escapeVendorListText(text);
            if (text.length > maxLength) {
                var shortText = escapeVendorListText(text.substring(0, maxLength) + '...');
                return '<td title="' + escapedFull + '" data-bs-toggle="tooltip" data-bs-placement="top">' + shortText + '</td>';
            }
            return '<td>' + escapedFull + '</td>';
        }

        // Added by Dipali V on 13th May 2026 - Purpose:-Display history Modified Date as dd mmm yyyy (e.g. 13 May 2026).
        function formatVendorHistoryDate(value) {
            if (!value) return '';
            var dt = new Date(value);
            if (isNaN(dt.getTime())) {
                var s = String(value).trim();
                var dmY = s.match(/^(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})/);
                if (dmY) {
                    dt = new Date(parseInt(dmY[3], 10), parseInt(dmY[2], 10) - 1, parseInt(dmY[1], 10));
                }
            }
            if (isNaN(dt.getTime())) {
                return String(value);
            }
            var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var dd = String(dt.getDate()).padStart(2, '0');
            var mmm = monthNames[dt.getMonth()];
            var yyyy = dt.getFullYear();
            return dd + ' ' + mmm + ' ' + yyyy;
        }

        function isVendorTypeActiveHistoryField(fieldName) {
            var n = String(fieldName || '').toLowerCase().replace(/\s+/g, '');
            return n === 'isactive' || n === 'active';
        }

        // Added by Dipali V on 13th May 2026 - Purpose:-Is Active history: 1 -> Yes, 0 -> No.
        function mapVendorActiveYesNo(value) {
            var normalized = String(value || '').trim().toLowerCase();
            if (normalized === '1' || normalized === 'true' || normalized === 'yes' || normalized === 'active') {
                return 'Yes';
            }
            if (normalized === '0' || normalized === 'false' || normalized === 'no' || normalized === 'inactive') {
                return 'No';
            }
            return String(value || '');
        }

        function onVendorRowCheckChanged(chk, rowId) {
            var id = parseInt(rowId, 10) || 0;
            if (id <= 0) return;
            if (vendorSelectAllMode) {
                if (chk.checked) {
                    var exIdx = vendorExcludedIds.indexOf(id);
                    if (exIdx > -1) vendorExcludedIds.splice(exIdx, 1);
                } else if (vendorExcludedIds.indexOf(id) === -1) {
                    vendorExcludedIds.push(id);
                }
            } else {
                if (chk.checked) {
                    if (vendorSelectedIds.indexOf(id) === -1) vendorSelectedIds.push(id);
                } else {
                    var idx = vendorSelectedIds.indexOf(id);
                    if (idx > -1) vendorSelectedIds.splice(idx, 1);
                }
            }
            updateVendorSelectAllHeaderState();
        }

        // Added by Dipali V on 15th May 2026 - Purpose:-Header Select All checked only when every deletable record on all pages is selected (not on partial/single row select).
        function updateVendorSelectAllHeaderState() {
            var selectAllChk = document.getElementById('chkSelectAllVendor');
            if (!selectAllChk) return;
            if (vendorListTotalSelectableRecords <= 0 && vendorListTotalRecords > 0 && vendorListTotalPages > 0) {
                refreshVendorListTotalSelectableRecords();
            }
            var total = vendorListTotalSelectableRecords;
            var selected = getVendorTypeGlobalSelectedCount();
            selectAllChk.indeterminate = false;
            selectAllChk.checked = (total > 0 && selected === total);
        }

        function buildDeleteCheckboxCell(rowId, rowName, inUse) {
            if (!canDeleteAccess) return '<td class="text-center"></td>';
            var name = String(rowName || '');
            var isInUse = (inUse === true || String(inUse).toLowerCase() === 'true' || String(inUse) === '1');
            var idNum = parseInt(rowId, 10) || 0;
            var isChecked = false;
            if (!isInUse) {
                if (vendorSelectAllMode) {
                    isChecked = vendorExcludedIds.indexOf(idNum) === -1;
                } else {
                    isChecked = vendorSelectedIds.indexOf(idNum) > -1;
                }
            }
            if (isInUse) {
                var msg = "'" + name + "' Vendor Type is in use, so it cannot be deleted";
                return '<td class="text-center"><span data-bs-toggle="tooltip" data-bs-placement="top" title="' + escapeVendorListText(msg) + '"><input type="checkbox" class="vendor-action-check vendor-row-check" data-id="' + rowId + '" disabled /></span></td>';
            }
            return '<td class="text-center"><input type="checkbox" class="vendor-action-check vendor-row-check" data-id="' + rowId + '"' + (isChecked ? ' checked' : '') + ' onchange="onVendorRowCheckChanged(this,' + rowId + ')" data-bs-title="Delete" data-bs-toggle="tooltip" data-bs-placement="top" /></td>';
        }

        function renderVendorTypeListRows(rows) {
            //debugger
            var tbody = document.getElementById('vendorTypeListBody');
            if (!tbody) return;
            if (!rows || rows.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" class="text-center">There are no records to view</td></tr>';
                return;
            }
            var html = '';
            for (var i = 0; i < rows.length; i++) {
                var r = rows[i] || {};
                var rowId = r.vendorTypeID !== undefined ? r.vendorTypeID : r.VendorTypeID;
                var rowName = r.vendorTypeName !== undefined ? r.vendorTypeName : (r.VendorTypeName || '');
                var rowDesc = r.description !== undefined ? r.description : (r.Description || '');
                var rowInUse = r.inUse !== undefined ? r.inUse : r.InUse;
                //var rowisactive = r.isactive !== undefined ? r.isactive : r.isactive;
                //if (rowisactive == 1) {
                //    rowisactive = "Yes"
                //} else {
                //    rowisactive = "No"
                //}
                var rowisactive = (
                    r.isActive === true ||
                    r.isActive === 1 ||
                    r.IsActive === true ||
                    r.IsActive === 1 ||
                    String(r.isActive).toLowerCase() === "true" ||
                    String(r.IsActive).toLowerCase() === "true"
                ) ? "Yes" : "No";
                html += '<tr>' +
                    formatVendorListTextCell(rowName || '', 65) +
                    formatVendorListTextCell(rowDesc || '', 65) +
                    formatVendorListTextCell(rowisactive || '', 65) +
                    '<td class="text-center">' +
                    (canViewAccess ? '<i class="fas fa-ellipsis-v vendor-action-more" onclick="openOffcanvas(this, \'vendorTypeDetailsOffcanvas\', ' + rowId + ')" data-bs-title="View Details" data-bs-toggle="tooltip" data-bs-placement="top"></i>' : '') +
                    '</td>' +
                    buildDeleteCheckboxCell(rowId, rowName, rowInUse) +
                    '</tr>';
            }
            tbody.innerHTML = html;
            initializeVendorTooltips();
        }

        function loadVendorTypeMasterList(pageNo) {
            
            try {
                vendorListCurrentPage = pageNo || 1;
                var searchText = (document.getElementById('txtSearchVendorType') || {}).value || '';
                var payload = JSON.stringify({
                    VendorTypeID: null,
                 
                    Search: searchText,
                    PageNumber: vendorListCurrentPage,
                    PageSize: vendorListPageSize
                });
                var result = AJAXCallWithResult('api/SM_VendorType/GetVendorTypeMaster', payload, false);
                var dataObj = result;
                var rows = (dataObj && dataObj.vendorResult) ? dataObj.vendorResult : [];
                var pagination = (dataObj && dataObj.paginationResult && dataObj.paginationResult.length > 0) ? dataObj.paginationResult[0] : null;

                vendorListTotalRecords = pagination ? (pagination.totalRecords !== undefined ? pagination.totalRecords : pagination.TotalRecords || rows.length) : rows.length;
                vendorListTotalPages = pagination ? (pagination.totalPages !== undefined ? pagination.totalPages : pagination.TotalPages || 1) : 1;
                vendorListTotalPages = Math.max(1, parseInt(vendorListTotalPages, 10) || 1);
                vendorListCurrentPage = pagination ? (pagination.currentPage !== undefined ? pagination.currentPage : pagination.CurrentPage || vendorListCurrentPage) : vendorListCurrentPage;
                vendorListCurrentPage = Math.max(1, parseInt(vendorListCurrentPage, 10) || 1);
                if (vendorListCurrentPage > vendorListTotalPages) {
                    loadVendorTypeMasterList(vendorListTotalPages);
                    return;
                }

                refreshVendorListTotalSelectableRecords();
                renderVendorTypeListRows(rows || []);
                updateVendorSelectAllHeaderState();
                updateVendorListPaginationUI();
            } catch (e) {
                renderVendorTypeListRows([]);
                vendorListTotalRecords = 0;
                vendorListTotalPages = 1;
                vendorListCurrentPage = 1;
                vendorListTotalSelectableRecords = 0;
                updateVendorSelectAllHeaderState();
                updateVendorListPaginationUI();
            }
        }

        (function initVendorHistoryBackdropState() {
            try {
                var historyPanel = document.getElementById('vendorTypeHistoryOffcanvas');
                if (!historyPanel) return;
                historyPanel.addEventListener('shown.bs.offcanvas', function () {
                    document.body.classList.add('vendor-history-open');
                });
                historyPanel.addEventListener('hidden.bs.offcanvas', function () {
                    document.body.classList.remove('vendor-history-open');
                });
            } catch (e) { }
        })();

        document.addEventListener('DOMContentLoaded', function () {
            loadVendorTypeMasterList(1);
            initializeVendorTooltips();
            var selectAllChk = document.getElementById('chkSelectAllVendor');
            if (selectAllChk) {
                selectAllChk.addEventListener('change', function () {
                    var wantSelectAll = !!selectAllChk.checked;
                    if (wantSelectAll) {
                        if (vendorListTotalSelectableRecords <= 0) {
                            refreshVendorListTotalSelectableRecords();
                        }
                        vendorSelectAllMode = true;
                        vendorSelectedIds = [];
                        vendorExcludedIds = [];
                    } else {
                        resetVendorTypeSelectionState();
                    }
                    var rowChecks = document.querySelectorAll('.vendor-row-check:not(:disabled)');
                    rowChecks.forEach(function (chk) {
                        chk.checked = wantSelectAll;
                    });
                    selectAllChk.indeterminate = false;
                    selectAllChk.checked = wantSelectAll && vendorListTotalSelectableRecords > 0;
                });
            }
            var searchBtn = document.getElementById('searchBtn');
            var searchInput = document.getElementById('txtSearchVendorType');
            if (searchBtn) {
                searchBtn.addEventListener('click', function () {
                    resetVendorTypeSelectionState();
                    loadVendorTypeMasterList(1);
                });
            }
            if (searchInput) {
                searchInput.addEventListener('keydown', function (e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        resetVendorTypeSelectionState();
                        loadVendorTypeMasterList(1);
                    }
                });
                searchInput.addEventListener('input', function () {
                    if (vendorSearchDebounceTimer) {
                        clearTimeout(vendorSearchDebounceTimer);
                    }
                    vendorSearchDebounceTimer = setTimeout(function () {
                        resetVendorTypeSelectionState();
                        loadVendorTypeMasterList(1);
                    }, 300);
                });
            }
        });

        function initializeVendorTooltips() {
            if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
            var triggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
            triggerList.forEach(function (el) {
                try {
                    var existing = bootstrap.Tooltip.getInstance(el);
                    if (existing) existing.dispose();
                } catch (e) { }

                var tip = new bootstrap.Tooltip(el, {
                    trigger: 'hover',
                    container: 'body'
                });

                // Ensure tooltip never "sticks" after click/focus
                if (!el.dataset.tooltipBound) {
                    el.addEventListener('mouseleave', function () { try { tip.hide(); } catch (e) { } });
                    el.addEventListener('blur', function () { try { tip.hide(); } catch (e) { } });
                    el.addEventListener('click', function () { try { tip.hide(); } catch (e) { } });
                    el.dataset.tooltipBound = '1';
                }
            });
        }

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
    </script>
</body>
</html>
