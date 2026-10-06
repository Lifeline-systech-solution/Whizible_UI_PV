<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TimesheetListing_new.aspx.vb" Inherits="Whizible.PM_TimesheetListing_new" %>

<%--Code added by Vaibhav K on 04-03-26--%>

<!DOCTYPE html>
<html>
<% CommonFunctions.General.PlotPageHeadTag("Project_Timesheet_Approval") %>
<head >
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><%=MyBase.GetResourceString("C_PageCaption")%></title>
    <meta content="width=device-width, initial-scale=1" name="viewport" />

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css">

    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>

    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/alertify.min.css" />

    <style>
        /* --- Page Specific Styling --- */
        .dropdown-menu {
        font-size:11.5px!important;
        
        }
        #pageLoader.loader-overlay {
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
        #pageLoader.loader-overlay .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
        .main-content-wrapper {
            opacity: 0;
            transition: opacity 0.25s ease-in;
        }
        .main-content-wrapper.loaded {
            opacity: 1;
        }
        #billine_info_details {
            width:75%!important
        }
        #offcanvas_BillingInfo.billing-layer-dimmed {
            /*opacity: 0.45;*/
            filter: grayscale(20%);
            transition: opacity 0.2s ease;
        }
        /* Stacked offcanvas: Timesheet Details above its backdrop; backdrop above dimmed Billing so outside-click closes */
        #billine_info_details.offcanvas.show {
            z-index: 1065 !important;
        }
        #offcanvas_BillingInfo.billing-layer-dimmed.offcanvas.show {
            z-index: 1045 !important;
        }
        #TimesheetTbl{
            font-size: 11.5px;
        }
        table tr th, table tr td {
            text-align: center !important;
            white-space: normal !important; 
            vertical-align: middle;
        }
        .dataTables_scrollHead {
            position: sticky;
            top: 0;
            z-index: 100;
            background: #fff;
        }
        .dataTables_scrollBody {
            max-height: calc(100vh - 280px);
            overflow-y: auto;
        }
        .pagination-container {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: #fff;
            padding: 0.75rem 1rem;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 1rem;
            z-index: 1000;
        }
        body {
            padding-bottom: 80px;
        }
        .billing-table th,
        .billing-table td {
            min-width: 120px;
            text-align: center;
        }
        .billing-table th:nth-child(1),
        .billing-table td:nth-child(1) {
            min-width: 200px; /* Site */
        }
        .billing-table th:nth-child(2),
        .billing-table td:nth-child(2) {
            min-width: 220px; /* Resource */
        }
        .billing-table th:nth-child(3),
        .billing-table td:nth-child(3) {
            min-width: 120px; /* Date */
        }
        #TimesheetTbl.hide-checkbox-column th:last-child,
        #TimesheetTbl.hide-checkbox-column tbody tr td:last-child:not([colspan]) {
            display: none;
        }
        #BulkPreviewModal {
            z-index: 1060 !important;
        }
        #BulkPreviewModal .modal-dialog {
            z-index: 1061 !important;
        }
        .modal-backdrop {
            z-index: 1055 !important;
        }
        .sidebar,          /* adjust to your actual sidebar class */
.nav-sidebar,
#sidebar {
    z-index: 1000 !important;  /* Must be lower than backdrop (1055) */
}
        .custmodal .modal-content .modal-header .close {
        font-size:12px!important;
        top: 14px !important;
        
        }
        .text-muted {
        
        font-size:11.5px!important;
        }
        #Input_details_accordion {
            display:block;
        }

    </style>

    <%--project timesheet code--%>

    <style type="text/css">
        .bootstrap-select>.dropdown-toggle {
            height: 30px;
        }
        /* Project Name: cap inner list height so menu fits viewport; bootstrap-select inline max-height can exceed window and hide last items */
        #ddlProject ~ .dropdown-menu .inner {
            max-height: min(320px, calc(100vh - 220px)) !important;
        }
        #SalesPeriodModal .modal-xl{
            --bs-modal-width: 950px;
        }
        #TbodySubmiteIR > tr td:nth-child(2) {
            text-align: left;
        }
        #TbodySubmiteIR > tr td:nth-child(3) {
            text-align: center;
        }
        .tbody_billing_info > tr > td > .form-control {
            padding: 0px;
            width: 80px;
            margin: 0px;
            height: 31px;
        }
        .tdCurrent[colspan="6"] {
            border-right: 1px solid #ddd !important;
            background-color: #e7edf0 !important;
        }
        .hide-col {
            width: 0 !important;
            height: 0 !important;
            display: block !important;
            overflow: hidden !important;
            margin: 0 !important;
            padding: 0 !important;
            border: #808080 !important
        }
        td.hidecol, th.hidecol {
            display: table-cell;
            font-size: 0;
            min-width: auto !important;
            border: #808080 !important;
            border-bottom: 1px solid #ddd !important;
            text-align: center !important;
            padding: 5px !important
        }
        .billing_info_task_Grid td.hidecol .fa-minus, .billing_info_task_Grid th.hidecol .fa-minus {
            display: none
        }
        .billing_info_task_Grid td.hidecol .fa-plus, .billing_info_task_Grid th.hidecol .fa-plus {
            display: block;
            font-size: 13px;
            color: #1359a6
        }
        .hidecol .custom_chckbox {
            display: none
        }
        .billing_info_task_Grid td.hidecol .fa-plus, .billing_info_task_Grid th.hidecol .fa-plus {
            display: block;
            font-size: 13px;
            color: #1359a6;
        }
        .billing_info_task_Grid td .fa-minus, .billing_info_task_Grid th .fa-minus {
            display: block
        }
        .billing_info_task_Grid td .fa-plus, .billing_info_task_Grid th .fa-plus {
            display: none
        }
        .billing_info_task_Grid td.hidecol .fa-minus, .billing_info_task_Grid th.hidecol .fa-minus {
            display: none
        }
        .billing_info_task_Grid td.hidecol .fa-plus, .billing_info_task_Grid th.hidecol .fa-plus {
            display: block;
            font-size: 13px;
            color: #1359a6
        }
        .hide-column {
            background: none;
            border: #808080;
            outline: none
        }
        .hide-column:hover, .hide-column:focus {
            background: none;
            border: none;
            outline: none
        }
      /*  .fa-times {
            color: red;
        }*/
        .hypertext {
            text-decoration: underline;
        }
        .text_size {
            font-size: 11px !important;
        }
        .StageboxDiv {
            width: 20px;
            height: 20px;
            border: 1px solid #999;
            border-radius: 3px;
        }
        #Generate_IR_Project {
            background-color: #dddada63;
        }
        .accordion-button {
            background: #F8FAFC !important;
        }
        .mandatoryfield {
            margin-top: -25px !important;
        }
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }
        a.clearalllink {
            font-weight: bold;
            margin: 7px 10px 0;
            display: none;
        }
        .h5,
        h5 {
            font-size: 1.15rem;
        }
        .togglerup .collapseup {
            display: block
        }
        .togglerup .collapsedown {
            display: none
        }
        .togglerdown .collapsedown {
            display: block
        }
        .togglerdown .collapseup {
            display: none
        }
        .infoToggler {
            margin: 5px 0 0
        }
        .hideinfoicon {
            position: absolute;
            right: 10px
        }
        .colapsibleinfopanel .panel.panel-default {
            padding: 0;
            position: relative
        }
        .colapsibleinfopanel .panel-default > .panel-heading {
            padding-right: 15px;
            background: #e7edf0
        }
        .colapsibleinfopanel .panel-default > .panel-heading a:hover,
        .profitabilityinfopanel .panel-default > .panel-heading a:focus {
            color: #464a4c
        }
        .colapsibleinfopanel .panel-default > .panel-heading a span img {
            opacity: .5
        }
        .colapsibleinfopanel .panel-default > .panel-heading a span img:hover {
            opacity: 1
        }
        .panel.panel-default {
            padding: 10px
        }
        .colapsibleinfopanel {
            margin: 10px 0
        }
        .custmodal .modal-content .modal-body {
            padding: 30px;
        }
        .custmodal .modal-content .modal-header {
/*            top: 20px;
*/            background-color: #4263c1;
             /*padding: 20px;*/

        }
        #SendTimesheetEmailModal .modal-dialog {
            max-width: 90%;
            margin: 1.75rem auto;
            
        }
        #SendTimesheetEmailModal .modal-body {
            max-height: calc(100vh - 180px);
            overflow-y: auto;
            margin-top:45px;
        }
        .notebox {
            padding: 10px;
            margin: 0 0 10px;
        }
        #offcanvas_BillingInfo .notebox {
            position: relative;
            z-index: 2;
            background: #fff;
        }
        #offcanvas_BillingInfo #Input_details_accordion {
            position: relative;
            z-index: 2;
            background: #fff;
        }
        .filterpanelbody {
            padding: 15px;
        }
        button.btn.btncalendar {
            border: 1px solid #ddd;
            border-left: none;
        }
        .ui-widget.ui-widget-content {
            z-index: 9999 !important;
        }
        th.text-start,
        td.text-start {
            text-align: left;
        }
        .total-row {
            background: #f5f5f5;
        }
        .col-sm-9.colon-class {
            padding-left: 0;
        }
        .dropdownlinks {
            margin-left: 10px;
            margin-top: 0;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background: transparent;
            line-height: 29px;
            text-align: center;
        }
        .dropdownlinks:hover {
            background: #f5f5f5;
        }
        .sm-wid .custom_chckbox label:before {
            margin-right: 0;
            border: 1px solid #464a4c;
        }
        .dropdownlinks ul li a {
            text-align: left;
        }
        .custmodal .custom_chckbox label:before {
            border-color: #464a4c;
        }
        .toolactions > div,
        .toolactions > a {
            display: inline-block;
            vertical-align: top;
        }
        .custom_chckbox.chckbox-hide label:before {
            margin-right: 0;
            border: 1px solid #464a4c;
            margin: 0 4px;
            vertical-align: top;
        }
        .edit-row.edit_row_open .no-edit {
            border: 1px solid #ddd;
            resize: auto;
            background: #ffffff;
        }
        #editTaskName {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 15px;
            margin: 0 0 15px;
            background: #f5f5f5;
        }
        a {
            color: #337ab7;
            text-decoration: none;
        }
        .text_underline {
            text-decoration: underline;
        }
        .btn {
            display: inline-block;
            padding: 3px 16px;
            margin-bottom: 0;
        }
        .input-group-btn button.btn.btncalendar {
            margin: 0;
            height: 39px;
        }
        #filterpanel .cust_tabpanel .nav-tabs > li > a {
            padding: 6px 15px;
        }
        .form-control:focus,
        .form-select:focus {
            border-color: #3c8dbc;
            box-shadow: none;
        }
        .offcanvas {
            width: 90% !important;
        }
        .project_timeperiod {
            font-size: 14px;
            font-weight: 600 !important;
        }
        .pmtID {
            font-weight: 700 !important;
            font-size: 14px;
        }
        .total-row {
            background: #f5f5f5 !important;
        }
        .stickytable thead {
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .bottom-note {
            position: absolute;
            bottom: 0;
            margin-bottom: 10px;
        }
        .dropdown-menu > li:hover {
            background-color: #e1e3e9;
            color: #333;
            width: 100% !important;
        }
        .main-menu li:hover > a,
        nav.main-menu li.active > a,
        .dropdown-menu > li > a:hover,
        .dropdown-menu > li > a:focus,
        .dropdown-menu > .active > a,
        .dropdown-menu > .active > a:hover,
        .dropdown-menu > .active > a:focus,
        .no-touch .dashboard-page nav.dashboard-menu ul li:hover a,
        .dashboard-page nav.dashboard-menu ul li.active a {
            color: #656363;
            background: none;
        }
        .bootstrap-select .dropdown-menu.inner li.selected > a,
        .bootstrap-select .dropdown-menu.inner li.selected > a:hover,
        .bootstrap-select .dropdown-menu.inner li.selected > a:focus,
        .bootstrap-select .dropdown-menu.inner li.active > a,
        .bootstrap-select .dropdown-menu.inner li.active > a:hover,
        .bootstrap-select .dropdown-menu.inner li.active > a:focus {
            background: #e9ecef !important;
            color: #333 !important;
        }
        .clsNote {
            color: red;
            margin-left: 14px;
            font-size: 11px;
        }
        #tbl_billing_info tr td {
            vertical-align: middle;
        }
        span.idlabel {
            background: #ccc;
            padding: 3px 10px 2px;
            font-size: 12px;
            font-weight: 400;
            width: 80px;
            display: block;
        }
        .remove_row {
            color: red;
            font-size: 14px;
        }
        .save_row {
            font-size: 16px;
        }
        .method {
            font-weight: 600;
        }
        .added_IR td {
            background-color: #faf8b6!important;
        }
        .completiontbl tr td:first-child {
            text-align: center;
        }
        .alertify-notifier {
            z-index: 9999;
        }
        .MoreInformation {
            font-size: 10px;
            color: blue;
        }
        table.dataTable thead > tr > th.sorting:after, table.dataTable thead > tr > th.sorting_asc:after, table.dataTable thead > tr > th.sorting_desc:after, table.dataTable thead > tr > th.sorting_asc_disabled:after, table.dataTable thead > tr > th.sorting_desc_disabled:after, table.dataTable thead > tr > td.sorting:after, table.dataTable thead > tr > td.sorting_asc:after, table.dataTable thead > tr > td.sorting_desc:after, table.dataTable thead > tr > td.sorting_asc_disabled:after, table.dataTable thead > tr > td.sorting_desc_disabled:after {
            top: 50%;
            content: "";
        }
        table.dataTable thead > tr > th.sorting:before, table.dataTable thead > tr > th.sorting_asc:before, table.dataTable thead > tr > th.sorting_desc:before, table.dataTable thead > tr > th.sorting_asc_disabled:after, table.dataTable thead > tr > th.sorting_desc_disabled:before, table.dataTable thead > tr > td.sorting:after, table.dataTable thead > tr > td.sorting_asc:before, table.dataTable thead > tr > td.sorting_desc:before, table.dataTable thead > tr > td.sorting_asc_disabled:before, table.dataTable thead > tr > td.sorting_desc_disabled:before {
            top: 50%;
            content: "";
        }
        .tbody_billing_info .custom_chckbox input:checked + label:after {
            top: 1px;
            left: 6px;
        }
        .table-responsive, .table-responsive:hover {
            scrollbar-width: thin;
            scrollbar-color: #a8c4e8 #f1f1f1;
        }
        .textAreaRemark {
            resize: none;
        }
        .tbody_billing_info .table-fixed-header tbody tr th, .table tbody tr td {
            text-align: center;
            text-wrap: nowrap !important;
        }
        #tbl_billing_info::-webkit-scrollbar-track {
            border-radius: 2px
        }
        #tbl_billing_info::-webkit-scrollbar {
            width: 5px;
            background-color: #F7F7F7
        }
        #tbl_billing_info::-webkit-scrollbar-thumb {
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #BFBFBF
        }
        .tooltip-inner {
            font-size: 10px;
        }
        .black-tooltip .tooltip-inner {
            background: #000;
            color: #fff;
        }
        .black-tooltip.bs-tooltip-top .tooltip-arrow::before,
        .black-tooltip.bs-tooltip-auto[data-popper-placement^="top"] .tooltip-arrow::before {
            border-top-color: #000;
        }
        #txtDiscount {
            width:80px;
        }
        .HolidayClass {
            background-color: #9999ff!important;
        }
        .lgdHoliday {
            background-image: repeating-linear-gradient(45deg, #fff, yellow 1px, #fff 3px, #fff 4px)!important;
            border-left: 1px solid red !important;
        }
        .sumtxtEditAmount .txtEditAmount {
            width: 100px;
        }
        .txtEditAmount {
            border: none!important;
            width: 94px!important;
        }
        .settingOffcanvas, .helpOffcanvas {
            --bs-offcanvas-width: 70%;
        }
        .validationLabel{
            font-size: 14px;
            color: #bb0c0c;
        }
        .toggleIconDesc{
            width: 95%;
            border: 3px solid #eee;
            border-radius: 5px;
        }
        .descTxt {
            padding: 10px;
            text-align: justify;
            border-radius: 5px;
        }
        .yellowHeading{
            color: #e7c800;
            font-weight: 600;
            font-size: 17px;
        }
        .IR_setting{
            border: 2px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            width: 95%;
        }
        .EffortsGreen {
            color:green;
        }
        .EffortsRed {
            color:red;
        }
        .approcedate {
            text-align:center;
        }
        .lgdapproved {
            background-size: 50px 50px;
        }
        .lgdapproved tbody, .lgdapproved td, .lgdapproved tfoot, .lgdapproved th, .lgdapproved thead, .lgdapproved tr {
            border-color: inherit;
            border-style: solid;
            border-width: 0;
            border: 1px solid lightgrey;
            text-align: center;
            width: 20px;
        }

        /* -- Timesheet Detail Offcanvas — flex column layout for proper scroll -- */
        #offcanvas_TimesheetDetail {
            width: 90% !important;
            display: flex !important;
            flex-direction: column !important;
            min-height: 0;
            max-height: 100vh;
            /* Override Bootstrap's offcanvas-body padding — we manage it ourselves */
        }
        /* Bootstrap sets offcanvas-body to flex:1 overflow-y:auto — we don't use it,
           so neutralise it completely and use our own inner divs */
        #offcanvas_TimesheetDetail > .offcanvas-body {
            display: none !important;    /* not used */
        }
        /* Chrome above scroll body so bootstrap-select dropdown is not covered by sticky thead (body paints later in DOM). */
        #offcanvas_TimesheetDetail .oc-ts-header {
            flex-shrink: 0;
            position: relative;
            z-index: 20;
        }
        #offcanvas_TimesheetDetail .oc-ts-actionbar {
            flex-shrink: 0;
            position: relative;
            z-index: 20;
        }
        #offcanvas_TimesheetDetail .oc-ts-actionbar .bootstrap-select.open,
        #offcanvas_TimesheetDetail .oc-ts-actionbar .bootstrap-select.show {
            z-index: 21;
        }
        #offcanvas_TimesheetDetail .oc-ts-actionbar .bootstrap-select .dropdown-menu {
            z-index: 22 !important;
        }
        /* Single scroll container: sticky thead only works when vertical scroll is NOT on .table-responsive
           (Bootstrap sets overflow-x:auto; CSS then forces overflow-y:auto on that wrapper, breaking sticky). */
        #offcanvas_TimesheetDetail .oc-ts-body {
            flex: 1 1 auto;
            min-height: 0;
            overflow: auto;
            -webkit-overflow-scrolling: touch;
            position: relative;
            z-index: 1;
        }
        #offcanvas_TimesheetDetail .oc-ts-table-host {
            max-width: 100%;
            min-width: 0;
        }
        #offcanvas_TimesheetDetail .oc-ts-body table.highlight-tbl {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        /* Frozen header: scroll ancestor must be .oc-ts-body */
        #offcanvas_TimesheetDetail .oc-ts-body table thead.oc-table-thead th {
            position: sticky;
            top: 0;
            background: #e7edf0 !important;
            font-size: 11.5px;
            white-space: nowrap;
            z-index: 13;
            box-shadow: 0 1px 0 rgba(0, 0, 0, 0.12);
        }
        #offcanvas_TimesheetDetail .oc-ts-body table tbody tr td {
            font-size: 11.5px;
            vertical-align: middle;
        }
        #offcanvas_TimesheetDetail .oc-ts-body .total-row td {
            background: #f5f5f5 !important;
            font-weight: 500;
        }
        /* × close button — identical to PM_ProjectSites */
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
            font-size: 13px;
            line-height: 1;
            cursor: pointer;
            opacity: 0.6;
            transition: opacity 0.15s ease, background 0.15s ease;
            flex-shrink: 0;
        }
        .offcanvas-close-btn:hover {
            opacity: 1;
            background: rgba(0,0,0,0.08);
        }
        .offcanvas-close-btn:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(19,89,166,0.25);
        }
        /* z-index: modals sit above the offcanvas backdrop */
        #OC_ViewCommentModal,
        #OC_ActionModal {
            z-index: 1070 !important;
        }
        .modal-backdrop {
            z-index: 1060 !important;
        }

        /*Added by Aditya J. on 26-03-2026*/
        .modal-backdrop.show {
            opacity: 0 !important;
        }
        /*End of Added by Aditya J. on 26-03-2026*/

        #TbodySubmiteIR tbody tr th, #TbodySubmiteIR tbody tr td {
            text-align: center;
            text-wrap: wrap!important; 
        }
        #TbodySubmiteIR.custom_chckbox label:before {
            margin-right: 0;
        }
        .ProjectGenNote {
            color: #cc0099;
        }
        #salesPeriodStartDate {
            font-size:12px!important;
        }
        #salesPeriodEndDate {
            font-size:12px!important;
        }
        #txtInvoiceDate ,#TxtFromDate,#TxtToDate {
            font-size:12px!important;
        }
        /* Billing grid sticky header / footer / col1: scoped to offcanvas wrap only (avoid affecting other pages using .billing_info_task_Grid). */
        /* Single scroll for billing grid: avoid nested .table-responsive (extra overflow breaks sticky + clips). */
        #offcanvas_BillingInfo #Billing_Info_Tab.billing-info-tab-pane {
            overflow: visible !important;
            max-width: 100%;
        }
        #offcanvas_BillingInfo .billing-info-details-inner {
            position: relative;
            z-index: 1;
            background: #fff;
        }
        /* Bounded scroll area so thead sticky is relative to this box (not the whole offcanvas). */
        #offcanvas_BillingInfo .billing-info-table-wrap {
            flex: 1 1 auto;
            max-height: min(70vh, calc(100vh - 280px));
            overflow: auto;
            min-height: 0;
            position: relative;
            background: #fff;
            -webkit-overflow-scrolling: touch;
        }
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid {
            border-collapse: separate;
            border-spacing: 0;
        }
        /* Sticky header row (vertical scroll) */
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid thead th {
            position: sticky;
            top: 0;
            z-index: 18;
            background: #F8FAFC !important;
            box-shadow: 0 1px 0 rgba(0, 0, 0, 0.08);
        }
        /* Top-left: freeze column 1 + header together */
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid thead th:first-child {
            left: 0;
            /*z-index: 22;*/
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.08), 0 1px 0 rgba(0, 0, 0, 0.08);
        }
        /* Body: middle cells stay normal; first column freezes on horizontal scroll */
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid tbody tr td {
            position: relative;
            z-index: 0;
        }
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid tbody tr td:first-child {
            position: sticky;
            left: 0;
            /*z-index: 12;*/
            background: #fff;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
        }
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid tbody tr.added_IR td:first-child {
            background: #faf8b6 !important;
        }
        /* Footer: pin full total row to bottom on vertical scroll — all tds use same sticky bottom + z-index band */
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid tfoot tr.graytotalrow td {
            position: -webkit-sticky;
            position: sticky;
            top: auto;
            right: auto;
            bottom: 0;
            left: auto;
            z-index: 24;
            vertical-align: middle;
            background-color: #e9ecef !important;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.08);
        }
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid tfoot tr.graytotalrow td:not(:first-child) {
            left: auto !important;
        }
        /* First cell: same bottom as siblings + left for horizontal freeze (corner must keep both insets) */
        #offcanvas_BillingInfo .billing-info-table-wrap .billing_info_task_Grid tfoot tr.graytotalrow td:first-child {
            left: 0;
            bottom: 0;
            top: auto;
            right: auto;
            /*z-index: 25;*/
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1), 0 -1px 0 rgba(0, 0, 0, 0.08);
        }
        .billing-grid-legend {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 11.5px;
        }
        .billing-grid-legend-box {
            width: 14px;
            height: 14px;
            display: inline-block;
            border: 1px solid #e2d47a;
            background: #fff9c4;
            border-radius: 2px;
            cursor: pointer;
        }
        .text_color {
            color: #4263c1;
            font-size:11.5px;
        }
        .fw-bold {
    font-weight: 700 !important;
    font-size: 11.5px!important;
}
        #Applicable_monthly_rate {
            background-color: #f5f5f5;
        }
        #txtOU, #txtDiscount,#txtBufferPercent,#txtMonthlyHr,#txtEffortToConsider {
            width: 70px;
            text-align: center !important;
        }
        input::placeholder {
            font-size: 10px;
        }
        .form-control, .form-select {
            padding: 0.35rem 0.75rem;
            height: auto;
            min-height: 32px;
            font-size: 11.5px;
        }
        .input-group-btn button.btn.btncalendar {
            height: 32px !important;
            padding: 0.35rem 0.75rem;
        }
        .bordr-dotted{
            border: 1px dotted #414042;
        }
        #txtEffortToConsider {
            border: none !important;
            text-align: left !important;
            font-size: 14px !important;
            font-weight: 500;
            color: darkmagenta;
            background:none!important;
        }
        .hidecolumn {
            display:none;
        }
        #linkMoreDetails {
            float: right;
            margin-left: 159px;
        }
        .graytotalrow {
            background-color: #e9ecef;
            font-size: 11.5px;
        }
        #tbl_billing_info tr td a {
            white-space: pre-line;
        }
        .slider:before {
            position: absolute;
            content: "";
            width: 71%;
            height: 100%;
            background: #fff;
            border-radius: 30px;
            transform: translateX(-30px);
            transition: .4s;
            margin-left: -9px;
        }
        .slider {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            border-radius: 30px;
            border: 1px solid #ddd;
            cursor: pointer;
            border: 4px solid transparent;
            overflow: hidden;
            transition: .4s;
            background: #ddd;
            width: 53px;
        }
        .loadingoverlay_progress_bar {
            left: 0 !important;
            right: 0 !important;
        }
        .img-fluid_Updated {
            height: 20px;
        }
        .page-title {
            color: #1e40af;
            font-size: 16px;
            font-weight: 600;
            margin: 0;
            line-height: 1.2;
        }
        .page-subtitle {
            color: #6B7280;
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 4px;
        }
        .card-header{
            background: #f0f0f0;
            color: #5361d9;
            padding: 2px;
            font-size: 12px;
        }
        .date_txt{
            color: #527cf8;
        }
        .total_hours{
            color: #0b9d49;
            background-color: #beffd2;
            padding: 3px;
            border-radius: 4px;
            display: inline-flex;
            gap: 5px;
            align-items: center;
            justify-content: center;
        }
        .accordion-button {
            font-weight: 500;
            font-size: 13px;
        }
        .Input_body_1{
            font-size: 11.5px;
            background: #f2fcff;
        }
        .init_filtersList li {
            border: 1px solid #b3b3b3;
            border-radius: 5px;
        }
        .init_filtersList li:first-child a span.fltrcount {
            background: #81cf09;
        }
        span.fltrcount {
            background: #b3b3b3;
            color: #fff;
            display: inline-block;
            height: 34px;
            padding: 6px 8px;
            width: 36px;
        }
        span.fltrtitle {
            padding: 10px;
        }
        .init_filtersList li:nth-child(3) a span.fltrcount {
            background: #f55d30;
        }
        .filter-card {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 8px 16px;
            border-radius: 6px;
            border: 1px solid #ddd;
            background-color: #fff;
            transition: all 0.3s ease;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        .filter-card:hover {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }
        .filter-count {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 20px;
            height: 20px;
            padding: 0 10px;
            font-size: 12px;
            font-weight: 500;
            color: #fff;
            border-radius: 4px;
        }
        .inbox-count {
            background-color: #81cf09;
        }
        .watchlist-count {
            background-color: #3b5bdb;
        }
        .filter-label-text {
            font-size: 11.5px;
            font-weight:400;
            color: #333;
            white-space: normal;
            overflow-wrap: anywhere;
            word-break: break-word;
            line-height: 1.25;
            flex: 1 1 auto;
            min-width: 0;
        }
        .clear-filter-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 6px 10px;
            background: #fff;
            border: 2px solid #ced4da;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            color: #6c757d;
            text-decoration: none;
            transition: all 0.25s ease;
        }
        .clear-filter-btn:hover {
            border-color: #adb5bd;
            color: #495057;
            text-decoration: none;
        }
        .clear-filter-btn img {
            width: 18px;
            height: 18px;
            filter: brightness(0) saturate(100%) invert(50%) sepia(0%) saturate(0%) hue-rotate(0deg) brightness(90%) contrast(90%);
            transition: filter 0.25s ease;
        }
        /* Blue state — when any filter is applied */
        .clear-filter-btn.filter-active {
            background: #1e40af;
            border-color: #1e40af;
            color: #fff;
        }
        .clear-filter-btn.filter-active img {
            filter: brightness(0) invert(1);
        }
        .clear-filter-btn.filter-active:hover {
            background: #1a37a0;
            border-color: #1a37a0;
            color: #fff;
        }
        #ImFltr-Inbox{
            background: #ffe7e7;
        }
        #FltrCountInbox{
            background-color: #ffb8b8;
            color: #ee2424;
        }
        .pending_text{
            color: #ee2424;
        }
        .ageing_text{
            color: #1e40af;
        }
        #ImFltr-Watchlist{
            background: #e3e9ff;
        }
        .watchlist-count {
            background-color: #99acff;
            color: #1d46f6;
            padding: 0px 17px;
        }
        .inbox-count {
            padding: 0px 17px;
        }
        .w_sm_txt{
            font-size: 9px;
        }
        .status-dot-inline{
            display:inline-block;
            width:10px;
            height:10px;
            border-radius:50%;
            margin-right:6px;
            vertical-align:middle;
        }
        body.billing-info-open #ddlStatus,
        body.billing-info-open #ddlStatus + .bootstrap-select {
            visibility: hidden;
        }

        #billine_info_details .offcanvas-body {
            overflow-y:hidden!important;
        }
        /*Added by Aditya J. on 26-03-2026 for freezing table header*/
            #tbl_Employee {
                max-height: 595px; /* adjust as per UI */
                overflow: auto;
            }

            #tbl_Employee thead th {
                position: sticky;
                top: 0;
                background: #f8f9fa;
                z-index: 10;
            }

            #tbl_Employee td {
            white-space: normal !important;
            word-break: break-word;
        }

        #offcanvas_BillingInfo .offcanvas-body {
            overflow-y:auto!important;
            overflow-x:hidden!important;
            display: flex;
            flex-direction: column;
            height: 100%;
            min-height: 0;
            padding: 0 !important; /* remove bootstrap offcanvas default 1rem gap (top/left/right) */
        }
        #offcanvas_BillingInfo #BillingInfo_Details {
            margin: 0;
        }
        /* Keep header edge-to-edge, but give content (accordion + table area) side breathing space */
        #offcanvas_BillingInfo #Input_details_accordion,
        #offcanvas_BillingInfo .NOI_Details_content {
            margin-left: 10px;
            margin-right: 10px;
        }
        /* Keep Approve/Reject button row stable while table scroller is used */
        #offcanvas_BillingInfo .project_timeperiod {
            position: sticky;
            top: 56px; /* below .statckmainheader */
            z-index: 9;
            background: #fff;
        }
        /* Billing offcanvas header should stay visible when nested offcanvas opens */
        #offcanvas_BillingInfo .statckmainheader {
            position: sticky;
            top: 0;
            z-index: 10;
            /*background: #e7edf0;*/ /* matches existing sticky header palette */
        }
        /*End of Added by Aditya J. on 26-03-2026 for freezing table header*/

        /*Added by Aditya J. on 26-03-2026 for clear all filter button ui getting disturbed*/
        #id_clr_fltr {
            white-space: nowrap;
            min-width: fit-content;
            flex-shrink: 0;
        }
        /*End of Added by Aditya J. on 26-03-2026 for clear all filter button ui getting disturbed*/
        #BulkPreviewModal {
    z-index: 1065 !important;
}

/* Ensure backdrop stays behind modal */
.modal-backdrop.show {
    z-index: 1055 !important; /* revert to Bootstrap default */
}
/*.alignmt {
    float: left !important;
}*/
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed page-loading">

<% If m_blnViewAccess = True Then %>

<div id="pageLoader" class="loader-overlay">
    <div class="loader"></div>
</div>

<div class="bgwhite main-content-wrapper">

    <!-- ================= HEADER ================= -->
    <div class="graybg px-3 py-2">
        <h2 class="page-title mb-0">
            <i class="fas fa-clock me-2"></i>
            <%=MyBase.GetResourceString("C_PageCaption")%>
        </h2>
        <p class="page-subtitle">
            <%=MyBase.GetResourceString("C_PageSubtitle")%>
        </p>
    </div>

    <div class="bgwhite">
        <div style="padding:0.5rem 1rem;">
            <div class="row align-items-end gx-2">
                <div class="col-sm-9 mb-1">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="text mb-2" style="font-size: 12px;">
                               
                                 <b class="alignmt">Note :</b> 
                                 <span class="alignmt">Default filter is set to <strong> "Ready for Approval" </strong>.</span> 
                                   
                            </div>
                            <div class="row mt-1">
                                <div class="col-sm-6">                                    
                                    <label class="filter-label"><%=MyBase.GetResourceString("C_TimesheetStatus")%></label>
                                    <% 
                                        CommonFunctions.HTMLControls.DrawComboBox(
                                            "ddlStatus",
                                            "usp_Whizible2_Sel_TimeSheetStatus_Dropdown",
                                            , ,
                                            "class='selectpicker form-control' data-live-search='true'",
                                            ,,
                                        )
                                    %>
                                </div>
                                <div class="col-sm-6">
                                    <label class="filter-label"><%=MyBase.GetResourceString("C_ProjectName")%></label>
                                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("ddlProject", "usp_Whizible2_Sel_FA_ProjectForTimeSheetListing " & Session("intUserId"), , , "class='selectpicker form-control' data-live-search='true'", ,,) %>--%>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("ddlProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'", , , "class='selectpicker form-control' data-live-search='true'", ,,) %>
                                </div>
                                <div class="col-sm-6 mt-1">
                                    <label class="filter-label"><%=MyBase.GetResourceString("C_FromDate")%></label>
                                    <div class="input-group">
                                        <input type="text" id="txtFromDate" class="form-control"  placeholder="Select From Date" readonly="readonly"> 
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button">
                                                <i class="fas fa-calendar-alt"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-6 mt-1">
                                    <label class="filter-label"><%=MyBase.GetResourceString("C_ToDate")%></label>
                                    <div class="input-group">
                                        <input type="text" id="txtToDate" class="form-control" placeholder="Select To Date" readonly="readonly">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button">
                                                <i class="fas fa-calendar-alt"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 mt-2" style="display: flex;flex-direction: row;flex-wrap: nowrap;align-content: center;justify-content: center;align-items: center; gap:9px;">
                            <%--commented and added by Aditya J. on 26-03-2026 for button color consistency--%>
                            <%--<button type="button" class="btn btn-primary" onclick="SearchTimesheets()">
                                <%=MyBase.GetResourceString("C_Show")%>
                            </button>--%>
                            <button type="button" class="btn btnyellow" onclick="SearchTimesheets()">
                                <%=MyBase.GetResourceString("C_Show")%>
                            </button>
                            <%--end of commented and added by Aditya J. on 26-03-2026 for button color consistency--%>

                            <%--commented and added by Aditya J. on 26-03-2026 for removing clear filter icon and giving clear filter button--%>
                            <%--<span type="button" class="clear-filter-btn" onclick="ClearFilters()" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_ClearFilters")%>">
                                <img src="../../../Whizible2.0-new/dist/img/filter-remove.svg" alt="<%=MyBase.GetResourceString("C_ClearFilters")%>" />
                            </span>--%>
                            <button class="btn borderbtn" id="id_clr_fltr" 
                                            onclick="ClearFilters(); return false;" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" title="<%=MyBase.GetResourceString("C_ClearFilters")%>">
                            <%=MyBase.GetResourceString("C_ClearFilters")%>
                            </button>
                            <%--End of commented and added by Aditya J. on 26-03-2026 for removing clear filter icon and giving clear filter button--%>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="col-sm-12 text-center mt-0 pe-2">
                        <div class="mb-1" style="display: flex; flex-direction: column;">
                            <div id="ImFltr-Watchlist" class="filter-card mb-2" data-bs-toggle="tooltip" data-bs-original-title="<%=MyBase.GetResourceString("C_Pending")%>">
                                <span id="FltrCountWatchlist" class="filter-count inbox-count">0</span>
                                <%--<span class="filter-label-text pending_text"><%=MyBase.GetResourceString("C_Pending")%></span>--%>
                                <span class="filter-label-text ageing_text"><%=MyBase.GetResourceString("C_Pending")%></span>
                            </div>
                            <div id="ImFltr-Inbox" class="filter-card" data-bs-toggle="tooltip" data-bs-original-title="<%=MyBase.GetResourceString("C_AgeingMoreThan10Days")%>">
                                <span id="FltrCountInbox" class="filter-count watchlist-count">0</span>
                                <%--<span class="filter-label-text ageing_text"><%=MyBase.GetResourceString("C_AgeingMoreThan10Days")%></span>--%>
                                <span class="filter-label-text pending_text"><%=MyBase.GetResourceString("C_AgeingMoreThan10Days")%></span>
                            </div>
                        </div>
                    </div>
                    <div class="mx-1 ps-3 pe-0" style="text-align:center">
                        <%If m_blnEditAccess = True Then%>
                        <%--commented and added by Aditya J. on 26-03-2026 for button color consistency--%>
                            <%--<button class="btn btn-success" onclick="OpenBulkPreview(1); return false;">
                                <%=MyBase.GetResourceString("C_Approve")%>
                            </button>--%>
                            <%--Added by Aditya J. on 26-03-2026 for status-based button visibility--%>
                            <button id="btnApprove" class="btn btnyellow" onclick="OpenBulkPreview(1); return false;">
                                <%=MyBase.GetResourceString("C_Approve")%>
                            </button>
                        <%--End of commented and added by Aditya J. on 26-03-2026 for button color consistency--%>
                            <button id="btnReject" class="btn btn-danger" onclick="OpenBulkPreview(2); return false;">
                                <%=MyBase.GetResourceString("C_Reject")%>
                            </button>
                            <%--End of Added by Aditya J. on 26-03-2026 for status-based button visibility--%>
                        <% End If %>
                    </div>
                </div>
            </div> 
        </div>
    </div>

    <!-- ================= TABLE ================= -->
    <div class="content px-0 mt-0 p-1">
        <table id="TimesheetTbl" class="table table-responsive newTblStyle">
            <thead>
                <tr>
                    <th><%=MyBase.GetResourceString("C_TimesheetNo")%></th>
                    <th><%=MyBase.GetResourceString("C_SubmittedDate")%></th>
                    <th><%=MyBase.GetResourceString("C_ProjectName")%></th>
                    <th><%=MyBase.GetResourceString("C_FromDate")%></th>
                    <th><%=MyBase.GetResourceString("C_ToDate")%></th>
                    <th><%=MyBase.GetResourceString("C_AgeingDays")%></th>
                    <th><%=MyBase.GetResourceString("C_TimesheetHours")%></th>
                    <th><%=MyBase.GetResourceString("C_Status")%></th>
                    <th><%=MyBase.GetResourceString("C_BillingInformation")%></th>
                    <th><%=MyBase.GetResourceString("C_PrintReport")%></th>
                    <th>Action</th>
                    <th>
                        <input type="checkbox" id="chkSelectAll" />
                    </th>
                </tr>
            </thead>
            <tbody>
                <!-- Data will be bound later -->
            </tbody>
        </table>
    </div>

    <!-- ================= PAGINATION ================= -->
    <div class="pagination-container">
        <span id="lblTotalRecords"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
        <button class="btn borderbtn" id="btnPrev">
            <i class="fas fa-angle-double-left"></i>
        </button>
        <button class="btn borderbtn" id="btnNext">
            <i class="fas fa-angle-double-right"></i>
        </button>
    </div>

</div>

<!-- ================= OFFCANVAS : TIMESHEET DETAIL (replaces separate detail page) ================= -->
<div class="offcanvas offcanvas-end" data-bs-scroll="true" tabindex="-1"
     id="offcanvas_TimesheetDetail" aria-labelledby="offcanvasTimesheetDetailLabel"
     style="width:90% !important; display:flex; flex-direction:column;">

    <!-- -- FIXED HEADER (only title + × close, like PM_ProjectSites) ---------- -->
    <div class="oc-ts-header graybg px-3 py-2 d-flex align-items-center justify-content-between"
         style="flex-shrink:0; border-bottom:1px solid #dee2e6;">
        <div>
            <h2 class="page-title mb-0">
                <i class="fas fa-clock me-2"></i>
                <%=MyBase.GetResourceString("C_ProjectTimesheetSimple")%>
                &nbsp;&mdash;&nbsp;
                <span class="text-primary fw-bold" id="oc_SpnTimesheetID" style="font-size:13px!important"></span>
            </h2>
            <p class="page-subtitle mb-0 mt-1">
                <span class="text_color"><%=MyBase.GetResourceString("C_FromDate")%>:</span>
                <span id="oc_ProjectFromdate" class="fw-bold"></span>
                &nbsp;&nbsp;
                <span class="text_color"><%=MyBase.GetResourceString("C_ToDate")%>:</span>
                <span id="oc_ProjectTodate" class="fw-bold"></span>
                &nbsp;&nbsp;
                <span class="text_color fw-bold"><%=MyBase.GetResourceString("C_Status")%>:</span>
                <span id="oc_ProjectTimesheetStatus" class="fw-bold"></span>
            </p>
        </div>
        <!-- Only the × close button in the header — matching PM_ProjectSites -->
        <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas"
                aria-label="Close" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip"
                data-bs-placement="top" title="Close">&#x2715;</button>
    </div>

    <!-- -- ACTION BAR (Approve / Reject / View Comment — outside header) ------- -->
    <div class="oc-ts-actionbar px-3 py-2 d-flex align-items-center gap-2"
         style="flex-shrink:0; background:#fff; border-bottom:1px solid #dee2e6;">
       

        <div style="min-width:240px; max-width:240px;">
            <select id="oc_select_emp" class="selectpicker form-control" data-live-search="true"
                    onchange="OC_EmployeeName_onChange()">
            </select>
        </div>
        <div class="ms-auto"></div>
         <%If m_blnEditAccess = True Then%>
         <%--commented and added by Aditya J. on 26-03-2026 for button consistency--%>
         <%--<button class="btn btn-success" id="oc_btn_authenticate" style="display:none;"
                 onclick="OC_OpenActionModal('Authenticate'); return false;">
             <%=MyBase.GetResourceString("C_Approve")%>
         </button>--%>
         <button class="btn btnyellow" id="oc_btn_authenticate" style="display:none;"
                 onclick="OC_OpenActionModal('Authenticate'); return false;">
             <%=MyBase.GetResourceString("C_Approve")%>
         </button>
         <%--End of commented and added by Aditya J. on 26-03-2026 for button consistency--%>
         <button class="btn btn-danger" id="oc_btn_reject" style="display:none;"
                 onclick="OC_OpenActionModal('Reject'); return false;">
             <%=MyBase.GetResourceString("C_Reject")%>
         </button>
         <%End If%>
         <button class="btn borderbtn" id="oc_btn_view_comment" style="display:none;"
                 onclick="OC_ViewComment_OnClick(); return false;">
             <%=MyBase.GetResourceString("C_ViewComment")%>
         </button>
    </div>

    <!-- -- SCROLLABLE CONTENT AREA --------------------------------------------- -->
    <div class="oc-ts-body" style="flex:1; min-height:0; overflow:auto;">
        <div class="container-fluid px-3 pt-2">
            <div id="oc_tbl_Employee" class="oc-ts-table-host">
                <table class="table table-bordered table-stripped highlight-tbl" style="font-size:12px;">
                    <thead class="oc-table-thead">
                        <tr>
                            <th><%=MyBase.GetResourceString("C_EmployeeName")%></th>
                            <th style="min-width:100px;"><%=MyBase.GetResourceString("C_Date")%></th>
                            <th class="text-start"><%=MyBase.GetResourceString("C_TaskName")%></th>
                            <th><%=MyBase.GetResourceString("C_Description")%></th>
                            <th><%=MyBase.GetResourceString("C_ActualWork(HH:MM)")%></th>
                        </tr>
                    </thead>
                    <tbody id="oc_ProjectTimesheetDetails">
                        <tr>
                            <td colspan="5" class="text-center text-muted py-4">
                                <%--<i class="fas fa-spinner fa-spin me-2"></i>Loading...--%>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<!-- ================= MODALS FOR TIMESHEET DETAIL OFFCANVAS ================= -->

<!-- View Comment Modal -->
<div class="modal custmodal fade" id="OC_ViewCommentModal" aria-hidden="true" style="z-index:1070;">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><%=MyBase.GetResourceString("C_TimesheetComments")%></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" data-bs-toggle="tooltip" data-bs-title="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label><%=MyBase.GetResourceString("C_Comments")%>:</label>
                    <textarea id="oc_txtViewCommentArea" class="form-control" rows="5" readonly
                              style="background-color:#f5f5f5;"></textarea>
                </div>
                <br />
                <%--commented by Aditya J. on 26-03-2026 for removing the close button--%>
                <%--<div class="text-center">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal">
                        <%=MyBase.GetResourceString("C_Close")%>
                    </button>
                </div>--%>
                <%--End of commented by Aditya J. on 26-03-2026 for removing the close button--%>
            </div>
        </div>
    </div>
</div>

<!-- Approve / Reject Action Modal -->
<div class="modal fade custmodal" id="OC_ActionModal" tabindex="-1" aria-hidden="true"
     data-bs-backdrop="static" data-bs-keyboard="false" style="z-index:1070;">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header graybg">
                <h5 class="modal-title fw-bold" id="oc_actionModalTitle">Action</h5>
                <button type="button" class="close" data-bs-dismiss="modal" data-bs-toggle="tooltip" data-bs-original-title="Close"  aria-label="Close">
                    <span aria-hidden="true">&#x2715;</span>
                </button>
            </div>
            <div class="modal-body p-0">
                <div class="table-responsive">
                    <table class="table mb-0" style="width:100%;">
                        <thead class="bg-light">
                            <tr>
                                <th style="width:15%;background-color:#f8f9fa;"><%=MyBase.GetResourceString("C_TimesheetNo")%></th>
                                <th style="width:20%;background-color:#f8f9fa;"><%=MyBase.GetResourceString("C_FromDate")%></th>
                                <th style="width:20%;background-color:#f8f9fa;"><%=MyBase.GetResourceString("C_ToDate")%></th>
                                <th style="width:45%;background-color:#f8f9fa;">
                                    <%=MyBase.GetResourceString("C_Comments")%>
                                    <span id="oc_lblMandatory" class="text-danger" style="display:none;">(* <%=MyBase.GetResourceString("C_Mandatory")%>)</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="align-middle text-center fw-bold text-primary">
                                    <span id="oc_mdl_TsID"></span>
                                </td>
                                <td class="align-middle text-center"><span id="oc_mdl_From"></span></td>
                                <td class="align-middle text-center"><span id="oc_mdl_To"></span></td>
                                <td class="p-2">
                                    <textarea id="oc_mdl_Comment" class="form-control" rows="3"
                                              placeholder="<%=MyBase.GetResourceString("C_EnterComment")%>" maxlength="500"></textarea>
                                    <div id="oc_mdl_Error" class="text-danger mt-1 small" style="display:none;">
                                        <i class="fas fa-exclamation-circle"></i>
                                        <%=MyBase.GetResourceString("A_CommentRequired")%>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn" id="oc_btn_ModalSubmit" onclick="OC_SubmitAction()">
                    <%=MyBase.GetResourceString("C_Submit")%>
                </button>
                <%--commented by Aditya J. on 27-03-2026 for removing the close button--%>
                <%--<button type="button" class="btn borderbtn" data-bs-dismiss="modal">
                    <%=MyBase.GetResourceString("C_Close")%>
                </button>--%>
                <%--End of commented by Aditya J. on 27-03-2026 for removing the close button--%>
            </div>
        </div>
    </div>
</div>

<!-- ================= BILLING PANEL ================= -->
<div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="false" tabindex="-1"
     id="offcanvas_BillingInfo" aria-labelledby="offcanvas_offcanvas_BillingInfo">
    <div class="offcanvas-body">
        <div id="BillingInfo_Details" class="NOI_Details">
            <div class="BillingInfo_Details_Header d-flex justify-content-between">
                <div class="Overlay-title"></div>
                <div class="BillingInfo_HeaderBtns"></div>
            </div>
            <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
                <div class="row">
                    <%--commented by Aditya J. on 26-03-2026 for removing close button and give cross icon--%> 
                    <%--<div class="col-sm-12">
                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_BillingInformation") %></h5>                       
                    </div> --%>
                    <div class="col-sm-12 d-flex justify-content-between align-items-center">
                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_BillingInformation") %></h5>
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-original-title="Close" aria-label="<%=MyBase.GetResourceString("C_Close")%>" ></button>
                    </div>  
                    <%--End of commented by Aditya J. on 26-03-2026 for removing close button and give cross icon--%>
                </div>
            </div>
            <div class="row mt-2 mb-2 project_timeperiod">
                <div class="col-sm-12 ">
                    <div class="row">
                        <div class="col-sm-12 text-end">
                            <%--commented and added by Aditya J. on 26-03-2026 for button color consistency--%>
                            <%--<button class="btn btn-success mx-1" id="btn_authenticate" onclick="BillingOffcanvas_Action(1); return false;">
                                <%=MyBase.GetResourceString("C_Approve")%>
                            </button>--%>
                              <%If m_blnEditAccess = True Then%>
                            <button class="btn btnyellow mx-1" id="btn_authenticate" onclick="BillingOffcanvas_Action(1); return false;">
                                <%=MyBase.GetResourceString("C_Approve")%>
                            </button>
                            <%--End of commented and added by Aditya J. on 26-03-2026 for button color consistency--%>
                            <button class="btn btn-danger mx-1" id="btn_reject" onclick="BillingOffcanvas_Action(2); return false;">
                                <%=MyBase.GetResourceString("C_Reject")%>
                            </button>
                            <%End If %>
                            <%--commented by Aditya J. on 26-03-2026 for removing close button and give cross icon--%>
                            <%--<button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                    onclick="closeBillingDetails()" data-bs-toggle="tooltip"
                                    data-bs-container="body" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_Close")%>"
                                    data-bs-dismiss="offcanvas">
                                <%=MyBase.GetResourceString("C_Close") %>
                            </button>--%>
                            <%--End of commented by Aditya J. on 26-03-2026 for removing close button and give cross icon--%>
                        </div>
                    </div>
                </div>
            </div>

            <div class="notebox mt-2">
                <div class="row">
                    <div class="col-sm-6 text-start">
                        <span class="date_txt">
                            <strong><%=MyBase.GetResourceString("C_ProjectName")%> : </span><span class="current_project_name" id="project_current"></span>
                        </strong>
                    </div>
                    <div class="col-sm-6 text-end ">
                        <span class="date_txt"><strong class="mx-1"> <%=MyBase.GetResourceString("C_TimesheetPeriod") %> : </strong></span><span id="billingfromdate"></span><strong> To  </strong> <span id="billingTodate"></span>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="accordion collapse Init_acordian_panel mb-3 mt-3" id="Input_details_accordion">
                    <div class="accordion-item ">
                        <h2 class="accordion-header" id="Input_details_heading">
                            <button class="accordion-button p-1" type="button" data-bs-toggle="collapse" data-bs-target="#Input_details_Info" aria-expanded="true" aria-controls="collapseOne">
                                <%=MyBase.GetResourceString("C_InputDetails") %>
                            </button>
                        </h2>
                        <div id="Input_details_Info" class="accordion-collapse collapse "
                             aria-labelledby="Input_details_heading" data-bs-parent="#accordionExample">
                            <div class="accordion-body Input_body_1 p-1">
                                <div class="row">
                                    <div class="col-sm-12 text-end"></div>
                                </div>
                                <div class="row form-group mt-3">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt"> <%=MyBase.GetResourceString("C_ProjectName") %> :</label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="input_project"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt" id=""><%=MyBase.GetResourceString("C_CommercialType") %>: </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <span class="" id="input_Commercial"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="lb_ouWorking date_txt"><%=MyBase.GetResourceString("C_POU") %>: </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <span class="lb_Commercial_type" id="SpanProjectOU"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt" id="input_FromDate"><%=MyBase.GetResourceString("C_FromDate") %>: </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lblTxtFromDate" ></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row ">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt" id="input_ToDate"><%=MyBase.GetResourceString("C_ToDate") %>: </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lblTxtToDate" ></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt"><%=MyBase.GetResourceString("C_OUWorking") %>:  </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lbltxtOU" ></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt"><%=MyBase.GetResourceString("C_Working_Day") %>:  </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lbltxtHRPerDay" ></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row ">
                                            <div class="col-sm-6 text-end ">
                                                <label class="date_txt"><%=MyBase.GetResourceString("C_Discount") %>  % :</label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lbltxtDiscount" ></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end ">
                                                <label class="date_txt"><%=MyBase.GetResourceString("C_CBillingCurrency") %> :</label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lbltxtProjectCurrency" ></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row form-group">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt"> <%=MyBase.GetResourceString("C_RateMethod") %> :</label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lblcboRateMethod" ></label>
                                                <select id="cboRateMethod" style="display:none;"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row ">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt"><%=MyBase.GetResourceString("C_SiteValidation") %>: </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lblcboSiteValidation" ></label>
                                                <select id="cboSiteValidation" style="display:none;"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="date_txt">
                                                    <%=MyBase.GetResourceString("C_InvoiceConversionDate") %>:
                                                </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lbltxtInvoiceDate" ></label>
                                                <input type="text" id="txtInvoiceDate" style="display:none;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row form-group" id="DivCapHoliday">
                                    <div class="col-sm-4">
                                        <div class="row">
                                            <div class="col-sm-6 text-end ">
                                                <label class="lb_ratemethod date_txt"> <%=MyBase.GetResourceString("C_CapConsider") %>: </label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lblcboCapConsider" ></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4" >
                                        <div class="row">
                                            <div class="col-sm-6 text-end">
                                                <label class="lb_Site_Validation date_txt"><%=MyBase.GetResourceString("C_CapHoliday") %> :</label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="" id="lblcboCapHoliday" ></label>
                                                <select id="cboCapHoliday" style="display:none;"></select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion collapse Init_acordian_panel mb-3 mt-3 highlitedpanel show" id="MonthlyMoreDetails" style="display:none">
                                    <div class="accordion-item ">
                                        <div id="DivMonthlyMoreDetails" class="accordion-collapse collapse  show"
                                             aria-labelledby="Edit_fiter_heading" data-bs-parent="#accordionExample">
                                            <div class="accordion-body" id="Applicable_monthly_rate">
                                                <div class="tab-pane pstbl_timesheet pt-0 in active" id="">
                                                    <div class="text_color">
                                                        <%=MyBase.GetResourceString("C_ApplicableMonthly") %> 
                                                    </div>
                                                    <div class="row form-group mt-2">
                                                        <div class="col-sm-4">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-6 text-end mt-2">
                                                                    <label class=" lb_Actual_Day"> <%=MyBase.GetResourceString("C_ActualDayBiling") %>  </label>
                                                                </div>
                                                                <div class="col-sm-6  text-start">
                                                                    <label class="form-control" id="lblcboActualDayBilling" ></label>
                                                                    <select id="cboActualDayBilling" style="display:none;"></select>
                                                                </div>
                                                                <span class="MoreInformation" style="text-wrap: nowrap;"><%=MyBase.GetResourceString("C_ActualBilling") %> </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <div class="row mb-1">
                                                                        <div class="col-sm-6 text-end">
                                                                            <label class=""><%=MyBase.GetResourceString("C_MonthlyHR") %> </label>
                                                                        </div>
                                                                        <div class="col-sm-6 pr-0">
                                                                            <label class="form-control" id="lbltxtMonthlyHr" ></label>
                                                                            <input type="text" id="txtMonthlyHr" style="display:none;" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="bordr-dotted">
                                                        <div class="row form-group mt-2">
                                                            <div class="col-sm-4">
                                                                <div class="row mb-1">
                                                                    <div class="col-sm-6 text-end mt-2">
                                                                        <label class="lb_Fixed_monthly"><%=MyBase.GetResourceString("C_FixedMonthly") %></label>
                                                                    </div>
                                                                    <div class="col-sm-6 text-start">
                                                                        <label class="form-control" id="lblcboFixedMonthlyRate" ></label>
                                                                        <select id="cboFixedMonthlyRate" style="display:none;"></select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row form-group mt-2">
                                                            <div class="col-sm-4">
                                                                <div class="row mb-1">
                                                                    <div class="col-sm-6 text-end  mt-2">
                                                                        <label class=""><%=MyBase.GetResourceString("C_BuffePer") %>  </label>
                                                                    </div>
                                                                    <div class="col-sm-6 text-start mt-2">
                                                                        <label class="form-control" id="lbltxtBufferPercent" ></label>
                                                                        <input type="text" id="txtBufferPercent" style="display:none;" />
                                                                    </div>
                                                                    <span class="MoreInformation" style="text-wrap: nowrap;margin-left:47px"><%=MyBase.GetResourceString("C_NoteThreshold") %> </span>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <div class="row mb-1">
                                                                    <div class="col-sm-8 text-end  mt-2">
                                                                        <label class=""><%=MyBase.GetResourceString("C_EffortToConsider") %> </label>
                                                                    </div>
                                                                    <div class="col-sm-2 text-start mt-2">
                                                                        <label class="form-control" id="lbltxtEffortToConsider" ></label>
                                                                        <input type="text" id="txtEffortToConsider" style="display:none;" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row form-group mt-2">
                                                            <div class="col-sm-4">
                                                                <div class="row mb-1">
                                                                    <div class="col-sm-6 text-end  mt-2">
                                                                        <label class=" lb_ouWorking">
                                                                            <%=MyBase.GetResourceString("C_OnsiteFull") %>
                                                                        </label>
                                                                    </div>
                                                                    <div class="col-sm-6 text-start">
                                                                        <label class="form-control" id="lblcboOnSiteFull" ></label>
                                                                        <select id="cboOnSiteFull" style="display:none;"></select>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="NOI_Details_content">
                <div class="tab-content detailsmenutab">
                    <div class="tab-pane active billing-info-tab-pane" id="Billing_Info_Tab">
                        <div class="BasicDetailsContent billing-info-details-inner">
                            <div class="text-end mb-2">
                                <span class="billing-grid-legend">
                                    <span class="billing-grid-legend-box"
                                          data-bs-toggle="tooltip"
                                          data-bs-container="body"
                                          data-bs-placement="top"
                                          title="Already mapped to IR"></span>
                                </span>
                            </div>
                            <div class="init_grid_panel billing-info-table-wrap">
                                <table class="table table-bordered table-stripped highlight-tbl stickytable billing_info_task_Grid"
                                       style="width:100%; font-size: 11.5px;">
                                    <thead>
                                        <tr>
                                            <th style="min-width: 144px;"><%= MyBase.GetResourceString("C_EmployeeCode") %> - <%= MyBase.GetResourceString("C_ResourceName") %></th>
                                            <th><%= MyBase.GetResourceString("C_Location") %></th>
                                            <th><%= MyBase.GetResourceString("C_ProjectRole") %></th>
                                            <th><%= MyBase.GetResourceString("C_Details") %></th>
                                            <th><%= MyBase.GetResourceString("C_BillingRate") %></th>
                                            <th><%= MyBase.GetResourceString("C_ActualHrs") %></th>
                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_WorkingDay") %></th>
                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_Noofdayworked") %></th>
                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_DailyRate") %></th>
                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_InvoiceAmount") %></th>
                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_Discount") %></th>
                                            <th><%= MyBase.GetResourceString("C_FinalAmount") %></th>
                                        </tr>
                                    </thead>
                                    <tbody class="tbody_billing_info" id="tbodyTMDetail"></tbody>
                                    <tfoot>
                                        <tr class="graytotalrow">
                                            <td><b><%= MyBase.GetResourceString("C_TotalBCurrency") %></b></td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td class="tdCurrent">&nbsp;</td>
                                            <td class="tdCurrent">&nbsp;</td>
                                            <td class="tdCurrent">&nbsp;</td>
                                            <td class="tdCurrent" id=""><span id="SumInvoice"></span><span id="SumInvoicebillingCurrency" class="Curncy iconBlue" style="display:none"></span></td>
                                            <td class="tdCurrent" id=""><span id="SumDiscount"></span><span id="SumDiscountbillingCurrency" class="Curncy iconBlue" style="display:none"></span></td>
                                            <td><span id="SumFinalAmount"></span><span id="billingCurrency" class="Curncy iconBlue"></span></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ================= VIEW COMMENT MODAL ================= -->
<div id="ViewCommentModal"
     class="modal fade custmodal"
     tabindex="-1"
     role="dialog"
     data-bs-backdrop="static"
     data-keyboard="false">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header graybg">
                <h4 class="modal-title">
                    <%=MyBase.GetResourceString("C_ViewComments")%>
                </h4>
                <button type="button"
                        class="close"
                        data-bs-dismiss="modal">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="row form-group">
                    <div class="col-sm-12">
                        <label class="control-label fw-bold">
                            <%=MyBase.GetResourceString("C_Comments")%>
                        </label>
                        <textarea id="txtViewComment"
                                  class="form-control"
                                  rows="3"
                                  readonly>ok</textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn borderbtn"
                        data-bs-dismiss="modal">
                    <%=MyBase.GetResourceString("C_Close")%>
                </button>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<!-- ================= PRINT REPORT offcanvas ================= -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvas_PrintReport" aria-labelledby="offcanvasPrintLabel" style="width: 500px;">
    <div class="offcanvas-header graybg border-bottom">
        <h5 class="offcanvas-title pgtitle mb-0" id="offcanvasPrintLabel" style="font-size: 1.1rem;">
            <%=MyBase.GetResourceString("C_PrintReportTitle")%>
        </h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-original-title="Close" aria-label="<%=MyBase.GetResourceString("C_Close")%>"></button>
    </div>
    <div class="offcanvas-body">
        <div class="row">
            <div class="col-sm-6"></div>
            <div class="col-sm-6 text-end">
                <div class="mt-auto pt-3 text-end">
                    <button class="btn borderbtn" id="btnOffPrintPdf">
                        <i class="fas fa-file-pdf me-1 text-danger"></i> PDF
                    </button>
                    <button class="btn borderbtn" id="btnOffPrintExcel">
                        <i class="fas fa-file-excel me-1 text-success"></i> <%=MyBase.GetResourceString("C_Excel")%>
                    </button>
                </div>
            </div>
        </div>
        <div class="flex-grow-1">
            <div class="row">
                <div class="col-sm-6">
                    <div class="row mb-3 align-items-center">
                        <div class="col-sm-4">
                            <label class="control-label fw-bold mb-0"><%=MyBase.GetResourceString("C_TimesheetID")%></label>
                        </div>
                        <div class="col-sm-8">
                            <input type="text" id="off_txtPrintTimesheet" class="form-control" value="118" readonly />
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-sm-4">
                            <label class="control-label fw-bold mb-0"><%=MyBase.GetResourceString("C_Site")%></label>
                        </div>
                        <div class="col-sm-8">
                            <select id="off_ddlPrintSite" class="form-control selectpicker" data-live-search="true">
                                <%--<option value="0">All</option>--%>
                                <option value="0">Select Site</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-sm-4">
                            <label class="control-label fw-bold mb-0"><%=MyBase.GetResourceString("C_Employee")%></label>
                        </div>
                        <div class="col-sm-8">
                            <select id="off_ddlPrintEmployee" class="form-control selectpicker" data-live-search="true">
                                <%--<option value="0">All</option>--%>
                                <option value="0">Select Employee</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="alert alert-light border mt-4 p-3 bg-light" role="alert" style="position: fixed; bottom: 2px;">
                <small class="text-muted">
                    <i class="fas fa-info-circle me-1"></i> <strong><%=MyBase.GetResourceString("C_Note")%>:</strong>
                    <%=MyBase.GetResourceString("C_PrintReportNote")%>
                </small>
            </div>
        </div>
    </div>
</div>

<% Else %>
    <div class="text-center mt-5">
        <p class="fw-bold"><%=MyBase.GetResourceString("C_NotAuthorizedPage")%></p>
    </div>
<% End If %>

<!-- Bulk Preview Modal -->
<div class="modal fade custmodal" id="BulkPreviewModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header graybg">
                <h5 class="modal-title" id="bulkModalTitle"><%=MyBase.GetResourceString("C_BulkActionPreview")%></h5>
                <button type="button" class="close" data-bs-dismiss="modal" data-bs-toggle="tooltip" data-bs-original-title="Close" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                    <span aria-hidden="true">&#x2715;</span>
                </button>
            </div>
            <div class="modal-body p-0">
              <%--  <div class="alert alert-info m-2" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                    <span id="bulkModalSummary"><%=MyBase.GetResourceString("A_FetchingList")%></span>
                </div>--%>
                <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                    <table class="table mb-0" style="width:100%" id="tblBulkList">
                        <thead class="bg-light" style="position: sticky; top: 0; z-index: 1;">
                            <tr>
                                <th style="width: 15%;"><%=MyBase.GetResourceString("C_TimesheetNo")%></th>
                                <th style="width: 20%;"><%=MyBase.GetResourceString("C_FromDate")%></th>
                                <th style="width: 20%;"><%=MyBase.GetResourceString("C_ToDate")%></th>
                                <th style="width: 45%;">
                                    <%=MyBase.GetResourceString("C_Comments")%> <span id="lblBulkMandatory" class="text-danger" style="display:none;"><%=MyBase.GetResourceString("C_MandatoryIndicator")%></span>
                                </th>
                            </tr>
                        </thead>
                        <tbody id="bulkListBody"></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <input type="hidden" id="hdnBulkIds" />
                <button type="button" class="btn" id="btn_BulkSubmit" onclick="SubmitBulkAction()"><%=MyBase.GetResourceString("C_Confirm")%></button>
                <%--<button type="button" class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>--%>
            </div>
        </div>
    </div>
</div>

<!-- Billing Timesheet Details offcanvas -->
<div class="offcanvas offcanvas-end fade" id="billine_info_details" tabindex="-1" data-bs-scroll="true"
     aria-labelledby="billine_info_details_label" style="width:90%;">
    <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
        <div class="row">
            <div class="col-sm-12 d-flex justify-content-between align-items-center">
                <h5 class="pgtitle float-start mb-0" id="billine_info_details_label"><%= MyBase.GetResourceString("C_TimesheetDetails")%></h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-original-title="Close" aria-label="<%=MyBase.GetResourceString("C_Close")%>">   </button>
            </div>
        </div>
    </div>
    <div class="offcanvas-body pt-0">
                <div class="row mb-2">


                <%--    <div class="col-sm-7">
                           <div class="timesheet_details_rate">
                                <span class=" method mx-2"><%= MyBase.GetResourceString("C_RateMethodPerDay")%> </span>
                                <span id="GRateMethod"></span> [ Calculated as per <span id="GCRateMethod"></span> ]
                            </div>
                       </div>--%>
                    <div class="col-sm-5 text-end">
                        <div class="legend float-end">
                            <ul class=""></ul>
                        </div>
                    </div>
                </div>
                <div id="tbl_Employee" class="init_grid_panel table-responsive">
                    <table class="table table-bordered table-stripped highlight-tbl stickytable" style="width:120%;">
                        <thead>
                            <tr>
                                <th width="5%"><%= MyBase.GetResourceString("C_SiteCaption")%></th>
                                <th width="5%"><%= MyBase.GetResourceString("C_Resource")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_Date")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_NormalHours")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_NormalRate")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_NormalBillingTotal")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_ExtraHours")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_ExtraRate")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_ExtraBillingTotal")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_BillableHours")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_BillableTotal")%></th>
                                <th width="8%"><%= MyBase.GetResourceString("C_NonBillableHours")%></th>
                                <th width="6%"><%= MyBase.GetResourceString("C_NonBillableRate")%></th>
                                <th width="7%"><%= MyBase.GetResourceString("C_NonBillableTotal")%></th>
                            </tr>
                        </thead>
                        <tbody id="bodyTimesheet"></tbody>
                    </table>
                </div>
                <%--commented by Aditya J. on 26-03-2026 for removing the close button--%>
                <%--<div class="text-center">
                    <a href="javascript:;" class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close")%></a>
                </div>--%>
                <%--End of commented by Aditya J. on 26-03-2026 for removing the close button--%>
    </div>
</div>

<!-- Send Email Modal (Timesheet) -->
<div class="modal custmodal fade" id="SendTimesheetEmailModal" data-bs-backdrop="static" aria-hidden="true" style="overflow-y:hidden;">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" style="margin-top:40px;">
            <div class="modal-header p-4">
                <h5 class="modal-title text-center"><%=MyBase.GetResourceString("C_SendEmail")%></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="padding-top:12px; padding-bottom:15px;">
                <div class="row form-group" style="margin-bottom:9px;">
                    <div class="form-group col-sm-2 text-end">
                        <label class="control-label"><strong><%=MyBase.GetResourceString("C_From")%></strong></label>
                    </div>
                    <div class="form-group col-sm-9">
                        <input type="text" id="sendTimesheetEmailFrom" class="form-control" readonly="readonly" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                    </div>
                </div>
                <div class="row form-group" style="margin-bottom:9px;">
                    <div class="form-group col-sm-2 text-end">
                        <label class="control-label"><strong><%=MyBase.GetResourceString("C_To")%></strong> <span style="color:red;">*</span></label>
                    </div>
                    <div class="form-group col-sm-9">
                        <input type="text" id="sendTimesheetEmailTo" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                    </div>
                </div>
                <div class="row form-group" style="margin-bottom:9px;">
                    <div class="form-group col-sm-2 text-end">
                        <label class="control-label"><strong><%=MyBase.GetResourceString("C_CC")%></strong></label>
                    </div>
                    <div class="form-group col-sm-9">
                        <input type="text" id="sendTimesheetEmailCC" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                    </div>
                </div>
                <div class="row form-group" style="margin-bottom:9px;">
                    <div class="form-group col-sm-2 text-end">
                        <label class="control-label"><strong><%=MyBase.GetResourceString("C_Subject")%></strong> <span style="color:red;">*</span></label>
                    </div>
                    <div class="form-group col-sm-9">
                        <input type="text" id="sendTimesheetEmailSubject" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                    </div>
                </div>
                <div class="row form-group" style="margin-bottom:9px;">
                    <div class="form-group col-sm-9">
                        <small style="color:#666;"><%=MyBase.GetResourceString("C_EmailSeparatorInfo")%></small>
                    </div>
                </div>
                <div class="row form-group" style="margin-bottom:9px;">
                    <div class="form-group col-sm-2 text-end">
                        <label class="control-label"><strong><%=MyBase.GetResourceString("C_Message")%></strong> <span style="color:red;">*</span></label>
                    </div>
                    <div class="form-group col-sm-9">
                        <textarea id="sendTimesheetEmailBody" class="form-control" rows="10" style="width:94%; padding:6px 10px; line-height:1.5!important; resize:vertical; min-height:180px; box-sizing:border-box;" maxlength="1000"></textarea>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-sm-12 text-center">
                        <button type="button" id="sendTimesheetEmailBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Send")%>" class="btn btnyellow" onclick="sendTimesheetEmailFromModal()"><%=MyBase.GetResourceString("C_SendEmail")%></button>
                        <button type="button" class="btn borderbtn" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Cancel")%>"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<script>
    // =============================================
    // RESOURCES (Loaded from Server)
    // =============================================
    var resourceKeys = {
        SelectTimesheetsForApprove: '<%= MyBase.GetResourceString("A_SelectTimesheetsForApprove") %>',
        SelectTimesheetsForReject: '<%= MyBase.GetResourceString("A_SelectTimesheetsForReject") %>',
        CommentsRequiredForReject: '<%= MyBase.GetResourceString("A_CommentsRequiredForReject") %>',
        NoTimesheetsToProcess: '<%= MyBase.GetResourceString("A_NoTimesheetsToProcess") %>',
        NoValidTimesheets: '<%= MyBase.GetResourceString("A_NoValidTimesheets") %>',
        EmailsProcessedRefreshing: '<%= MyBase.GetResourceString("A_EmailsProcessedRefreshing") %>',
        FailedLoadEmailTemplate: '<%= MyBase.GetResourceString("A_FailedLoadEmailTemplate") %>',
        EmailMandatoryFields: '<%= MyBase.GetResourceString("A_EmailMandatoryFields") %>',
        EmailSentSuccess: '<%= MyBase.GetResourceString("A_EmailSentSuccess") %>',
        EmailSendFailed: '<%= MyBase.GetResourceString("A_EmailSendFailed") %>',
        InvalidDateFormat: '<%= MyBase.GetResourceString("A_InvalidDateFormat") %>',
        FromDateBlank: '<%= MyBase.GetResourceString("A_FromDateBlank") %>',
        ToDateBlank: '<%= MyBase.GetResourceString("A_ToDateBlank") %>',
        FromDateLessThanToDate: '<%= MyBase.GetResourceString("A_FromDateLessThanToDate") %>',
        NoPendingApprovals: '<%= MyBase.GetResourceString("A_NoPendingApprovals") %>',
        NoRecordFound: '<%= MyBase.GetResourceString("A_NoRecordFound") %>'
    };

    // Server-side view access gate: if user can't view, stop all auto-initialization to avoid alerts.
    var hasViewAccess = "<%= m_blnViewAccess.ToString().ToLower() %>" === "true";

    // ==========================================
    // GLOBAL VARIABLES
    // ==========================================
    var g_CurrentPage = 1;
    var g_PageSize = 5;
    var g_TotalRecords = 0;
    var g_TotalPages = 0;
    var g_SelectAllActive = false;
    var g_ExplicitlySelected = [];
    var g_ExplicitlyDeselected = [];

    // ==========================================
    // INITIAL LOAD & EVENTS
    // ==========================================
    function hidePageLoader() {
        setTimeout(function () {
            $('#pageLoader').fadeOut(400, function () {
                $(this).remove();
            });
            $('body').removeClass('page-loading');
            $('.main-content-wrapper').addClass('loaded');
        }, 200);
    }

    function showPageLoader() {
        if (!$('#pageLoader').length) {
            $('body').append('<div id="pageLoader" class="loader-overlay"><div class="loader"></div></div>');
        }
        $('body').addClass('page-loading');
        $('#pageLoader').show();
    }

    function getStatusDotColorByText(statusText) {
        var s = String(statusText || "").toLowerCase();
        if (s.indexOf("ready for approval") > -1) return "#f0ad4e";
        if (s.indexOf("approved") > -1) return "#28a745";
        if (s.indexOf("rejected") > -1) return "#dc3545";
        return "";
    }

    function applyStatusDotsToDropdown() {
        var $ddl = $("#ddlStatus");
        var $wrap = $ddl.closest(".bootstrap-select");
        if (!$wrap.length) return;

        // Dropdown list items
        $wrap.find("ul.dropdown-menu.inner li a .text").each(function () {
            var $txt = $(this);
            var label = $.trim($txt.text());
            var color = getStatusDotColorByText(label);
            if (color) {
                $txt.html('<span class="status-dot-inline" style="background:' + color + ';"></span>' + label);
            } else {
                $txt.text(label);
            }
        });

        // Selected caption
        var selectedText = $.trim($ddl.find("option:selected").text());
        var selectedColor = getStatusDotColorByText(selectedText);
        var $selected = $wrap.find(".filter-option-inner-inner");
        if ($selected.length) {
            if (selectedColor) {
                $selected.html('<span class="status-dot-inline" style="background:' + selectedColor + ';"></span>' + selectedText);
            } else {
                $selected.text(selectedText);
            }
        }
    }

    //function closeOpenSelectPickers() {
    //    $(".bootstrap-select.show").each(function () {
    //        var $select = $(this).find("select.selectpicker");
    //        if ($select.length && $.fn.selectpicker) {
    //            try {
    //                $select.selectpicker('toggle');
    //            } catch (e) { }
    //        }
    //    });

    //    $(".bootstrap-select.show").removeClass("show");
    //    $(".bootstrap-select.open").removeClass("open");
    //    $(".bootstrap-select.dropup").removeClass("dropup");
    //    $(".bootstrap-select .dropdown-menu.show").removeClass("show");
    //    $(".bootstrap-select .dropdown-toggle")
    //        .attr("aria-expanded", "false")
    //        .trigger("blur");
    //    $("body").removeClass("bs-select-open");
    //}

    $(document).ready(function () {
        if (!hasViewAccess) return;
        function dismissAllTooltips() {
            try {
                $('[data-bs-toggle="tooltip"]').each(function () {
                    var inst = bootstrap.Tooltip.getInstance(this);
                    if (inst) inst.hide();
                });
                $('.tooltip').remove();
            } catch (e) { }
        }
        function resetOffcanvasScroll(offcanvasEl) {
            if (!offcanvasEl) return;
            $(offcanvasEl).scrollTop(0);
            $(offcanvasEl).scrollLeft(0);
            $(offcanvasEl).find('.offcanvas-body').scrollTop(0);
            $(offcanvasEl).find('.offcanvas-body').scrollLeft(0);
            $(offcanvasEl).find('.oc-ts-body').scrollTop(0);
            $(offcanvasEl).find('.oc-ts-body').scrollLeft(0);
            $(offcanvasEl).find('.table-responsive').scrollTop(0);
            $(offcanvasEl).find('.table-responsive').scrollLeft(0);
            $(offcanvasEl).find('.billing-info-table-wrap, #tbl_Employee').scrollLeft(0);
        }

        $(document).on('hidden.bs.offcanvas', function (e) {
            resetOffcanvasScroll(e.target);
            if ($('.offcanvas.show').length === 0) {
                $('.offcanvas-backdrop').remove();
                $('body').removeClass('offcanvas-open');
                if ($('.modal.show').length === 0) {
                    $('body').removeClass('modal-open').css({ 'overflow': '', 'padding-right': '' });
                }
            }
        });
        $(document).on('shown.bs.offcanvas', function (e) {
            resetOffcanvasScroll(e.target);
        });
        $(document).on('click', '#btnApprove, #btnReject, #btn_authenticate, #btn_reject, #oc_btn_authenticate, #oc_btn_reject, #btn_BulkSubmit, #oc_btn_ModalSubmit', function () {
            dismissAllTooltips();
        });

        // When Billing "Input Details" accordion expands, ensure the grid area is reachable
        $(document).on('shown.bs.collapse', '#Input_details_Info', function () {
            setTimeout(function () {
                var $wrap = $('#offcanvas_BillingInfo .billing-info-table-wrap');
                if ($wrap.length) {
                    $wrap.scrollTop(0);
                }
            }, 50);
        });

        // Keep layered effect: fade Billing panel when Timesheet Details opens over it
        function tsDetails_fixStacking() {
            var backs = document.querySelectorAll('.offcanvas-backdrop');
            if (backs.length) backs[backs.length - 1].style.zIndex = '1060';
        }
        function tsDetails_resetStacking() {
            document.querySelectorAll('.offcanvas-backdrop').forEach(function (b) { b.style.zIndex = ''; });
        }
        $(document).on('shown.bs.offcanvas', '#billine_info_details', function () {
            $('#offcanvas_BillingInfo').addClass('billing-layer-dimmed');
            tsDetails_fixStacking();
        });
        $(document).on('hidden.bs.offcanvas', '#billine_info_details', function () {
            $('#offcanvas_BillingInfo').removeClass('billing-layer-dimmed');
            tsDetails_resetStacking();
        });
        $(document).on('hidden.bs.offcanvas', '#offcanvas_BillingInfo', function () {
            var $inputDetails = $('#Input_details_Info');
            var inputDetailsCollapse = $inputDetails.length ? bootstrap.Collapse.getOrCreateInstance($inputDetails[0], { toggle: false }) : null;
            if (inputDetailsCollapse) inputDetailsCollapse.hide();
            $('#Input_details_heading .accordion-button').addClass('collapsed').attr('aria-expanded', 'false');
            $('#Input_details_accordion').removeClass('show');
            $(window).scrollTop(0);
            $('html, body').scrollTop(0);
            $('body').removeClass('billing-info-open');
            $(this).removeClass('billing-layer-dimmed');
        });
        //$(document).on('shown.bs.offcanvas', '#offcanvas_BillingInfo', function () {
        //    closeOpenSelectPickers();
        //    $('body').addClass('billing-info-open');
        //});
        $(document).on('shown.bs.select changed.bs.select', '#ddlStatus', function () {
            setTimeout(applyStatusDotsToDropdown, 0);
        });

        if (typeof alertify !== 'undefined') {
            alertify.set('notifier', 'position', 'top-right');
        }

        if (typeof $.fn.datepicker !== 'undefined') {
            $("#txtFromDate").datepicker({ dateFormat: 'dd M yy', changeMonth: true, changeYear: true });
            $("#txtToDate").datepicker({ dateFormat: 'dd M yy', changeMonth: true, changeYear: true });
            $(".btncalendar").on("click", function () {
                $(this).closest(".input-group").find("input").datepicker("show");
            });
        }

        $("#btnPrev").click(function () {
            if (g_CurrentPage > 1) {
                g_CurrentPage--;
                GetTimesheetList();
            }
        });
        $("#btnNext").click(function () {
            if (g_CurrentPage < g_TotalPages) {
                g_CurrentPage++;
                GetTimesheetList();
            }
        });

        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        $(document).on('change', '#chkSelectAll', function () {
            g_SelectAllActive = $(this).is(':checked');
            g_ExplicitlySelected = [];
            g_ExplicitlyDeselected = [];
            RenderCheckboxState();
        });

        $(document).on('change', '.ts-checkbox', function () {
            var tsId = $(this).val();
            var isChecked = $(this).is(':checked');
            if (g_SelectAllActive) {
                if (!isChecked) {
                    if (!g_ExplicitlyDeselected.includes(tsId)) g_ExplicitlyDeselected.push(tsId);
                } else {
                    g_ExplicitlyDeselected = g_ExplicitlyDeselected.filter(id => id !== tsId);
                }
            } else {
                if (isChecked) {
                    if (!g_ExplicitlySelected.includes(tsId)) g_ExplicitlySelected.push(tsId);
                } else {
                    g_ExplicitlySelected = g_ExplicitlySelected.filter(id => id !== tsId);
                }
            }
            RenderCheckboxState();
        });

        $(".clearalllink.text-danger").click(function () {
            g_SelectAllActive = false;
            g_ExplicitlySelected = [];
            g_ExplicitlyDeselected = [];
            RenderCheckboxState();
        });
        $(".clearalllink:not(.text-danger)").click(function () {
            g_SelectAllActive = true;
            g_ExplicitlySelected = [];
            g_ExplicitlyDeselected = [];
            RenderCheckboxState();
        });

        $("#ImFltr-ReadyForApproval, #ImFltr-Inbox, #ImFltr-Watchlist").on('click', function () {
            var statusValue = 1;
            $("#ddlStatus").val(statusValue);
          
            if ($.fn.selectpicker) {
                $("#ddlStatus").selectpicker('refresh');
            }
            applyStatusDotsToDropdown();


            SearchTimesheets();
            g_CurrentPage = 1;
            g_SelectAllActive = false;
            g_ExplicitlySelected = [];
            g_ExplicitlyDeselected = [];
            $("#ImFltr-ReadyForApproval, #ImFltr-Inbox, #ImFltr-Watchlist").removeClass('active');
            $(this).addClass('active');
            UpdateFilterButtonState();
            GetTimesheetList();
        });

        LoadPendingAgeingCount();

        setTimeout(function() {
            var readyForApprovalOption = $("#ddlStatus option").filter(function () {
                return $(this).text().indexOf("Ready for Approval") > -1;
            });
            if (readyForApprovalOption.length > 0) {
                $("#ddlStatus").val(readyForApprovalOption.val());
            } else {
                $("#ddlStatus").val(1);
            }
            if ($.fn.selectpicker) {
                $("#ddlStatus").selectpicker('refresh');
            }
            $("#ImFltr-ReadyForApproval").addClass('active');
            applyStatusDotsToDropdown();
            // Button is hollow on load because this IS the default state
            UpdateFilterButtonState();
            SearchTimesheets();
            hidePageLoader();
        }, 200);
    });

    // ==========================================
    // FILTER BUTTON STATE
    // ==========================================
    function GetDefaultStatusVal() {
        var readyOption = $("#ddlStatus option").filter(function () {
            return $(this).text().toLowerCase().indexOf("ready") > -1;
        });
        if (readyOption.length > 0) return String(readyOption.val());
        return "1";
    }

    // Turns the clear-filter button blue when any filter deviates from default
    function UpdateFilterButtonState() {
        var defaultStatus = GetDefaultStatusVal();
        var currentStatus = String($("#ddlStatus").val() || "");
        var currentProject = $("#ddlProject").val() || "0";
        var fromDate = $("#txtFromDate").val() || "";
        var toDate = $("#txtToDate").val() || "";
        var isFiltered = (currentStatus !== defaultStatus)
            || (currentProject !== "0" && currentProject !== "")
            || fromDate !== ""
            || toDate !== "";
        if (isFiltered) {
            $(".clear-filter-btn").addClass("filter-active");
            $("#id_clr_fltr").show();
        } else {
            $(".clear-filter-btn").removeClass("filter-active");
            $("#id_clr_fltr").hide();
        }
    }

    // ==========================================
    // DATA RETRIEVAL
    // ==========================================
    function SearchTimesheets() {
        if (!ValidateDateRange('All')) return;
        UpdateFilterButtonState();
        g_CurrentPage = 1;
        g_SelectAllActive = false;
        g_ExplicitlySelected = [];
        g_ExplicitlyDeselected = [];
        //Added by Aditya J. on 26-03-2026 for showing approve and reject buttons only when the timesheet status is Ready For Approval
        ToggleRejectedUI();
        //End of Added by Aditya J. on 26-03-2026 for showing approve and reject buttons only when the timesheet status is Ready For Approval
        GetTimesheetList();
    }

    function RefreshTimesheetGridOnly() {
        g_SelectAllActive = false;
        g_ExplicitlySelected = [];
        g_ExplicitlyDeselected = [];
        UpdateFilterButtonState();
        ToggleRejectedUI();
        GetTimesheetList();
        LoadPendingAgeingCount();
    }

    function ClearFilters() {
        // Reset status to "Ready for Approval" (same as on load)
        var readyOption = $("#ddlStatus option").filter(function () {
            return $(this).text().toLowerCase().indexOf("ready") > -1;
        });
        if (readyOption.length > 0) {
            $("#ddlStatus").val(readyOption.val());
        } else {
            $("#ddlStatus").val(1);
        }
        if ($.fn.selectpicker) $("#ddlStatus").selectpicker('refresh');
        applyStatusDotsToDropdown();
        if ($("#ddlProject").length) {
            $("#ddlProject").val("0");
            if ($.fn.selectpicker) $("#ddlProject").selectpicker('refresh');
        }
        $("#txtFromDate, #txtToDate").val('');
        $("#ImFltr-ReadyForApproval, #ImFltr-Inbox, #ImFltr-Watchlist").removeClass('active');
        g_CurrentPage = 1;
        g_SelectAllActive = false;
        g_ExplicitlySelected = [];
        g_ExplicitlyDeselected = [];
        // Remove blue state — filters are back to default
        UpdateFilterButtonState();
        GetTimesheetList();
    }

    // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
    function getTimesheetDynamicDateColumnConfig() {
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        var selectedStatus = ($("#ddlStatus option:selected").text() || "").toLowerCase();
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        if (selectedStatus.indexOf("approved") > -1) {
            return { key: "approved", header: "Approved Date" };
        }
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        if (selectedStatus.indexOf("rejected") > -1) {
            return { key: "rejected", header: "Rejected Date" };
        }
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        return { key: "", header: "" };
    }

    // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
    function renderTimesheetTableHeader() {
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        var dynamicDateColumn = getTimesheetDynamicDateColumnConfig();
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        var dynamicHeaderHTML = dynamicDateColumn.key ? ('<th>' + dynamicDateColumn.header + '</th>') : '';
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        $("#TimesheetTbl thead").html(
            '<tr>'
            + '<th><%=MyBase.GetResourceString("C_TimesheetNo")%></th>'
            + '<th><%=MyBase.GetResourceString("C_SubmittedDate")%></th>'
            + dynamicHeaderHTML
            + '<th><%=MyBase.GetResourceString("C_ProjectName")%></th>'
            + '<th><%=MyBase.GetResourceString("C_FromDate")%></th>'
            + '<th><%=MyBase.GetResourceString("C_ToDate")%></th>'
            + '<th><%=MyBase.GetResourceString("C_AgeingDays")%></th>'
            + '<th><%=MyBase.GetResourceString("C_TimesheetHours")%></th>'
            + '<th><%=MyBase.GetResourceString("C_Status")%></th>'
            + '<th><%=MyBase.GetResourceString("C_BillingInformation")%></th>'
            + '<th><%=MyBase.GetResourceString("C_PrintReport")%></th>'
            + '<th>Action</th>'
            + '<th><input type="checkbox" id="chkSelectAll" /></th>'
            + '</tr>'
        );
    }

    // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
    function getTimesheetTableColumnCount() {
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        // Column count EXCLUDING the checkbox column (used for no-data colspan)
        // Current columns: TimesheetNo, SubmittedDate, [DynamicDate], ProjectName, FromDate, ToDate, AgeingDays, TimesheetHours, Status, BillingInformation, PrintReport, Action
        return getTimesheetDynamicDateColumnConfig().key ? 12 : 11;
    }

    // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
    function GetTimesheetList() {
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        renderTimesheetTableHeader();
        var requestObj = {
            Flag: parseInt($("#ddlStatus").val()) || 0,
            ProjectID: ($("#ddlProject").val() == "0" || $("#ddlProject").val() == "") ? null : String($("#ddlProject").val()),
            FromDate: toISODate($("#txtFromDate").val()),
            ToDate: toISODate($("#txtToDate").val()),
            PageNo: g_CurrentPage,
            PageSize: g_PageSize,
            CustomerID: null,
            EmpID: '<%= Session("intUserID") %>'
        };
        var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetTimeSheetInvoice", JSON.stringify(requestObj), false);
        if (strResult && strResult.data) {
            var listData = strResult.data.TimeSheetInvoiceEntity;
            var pageInfo = (strResult.data.TimeSheetInvoicePaginationEntity && strResult.data.TimeSheetInvoicePaginationEntity.length > 0)
                ? strResult.data.TimeSheetInvoicePaginationEntity[0]
                : { totalRecords: 0 };
            g_TotalRecords = pageInfo.totalRecords || pageInfo.TotalRecords || 0;
            g_TotalPages = Math.ceil(g_TotalRecords / g_PageSize);
            RenderTimesheetTable(listData);
            ToggleRejectedUI();
            UpdatePaginationUI();
        } else {
            $('#TimesheetTbl tbody').html(`
                <tr>
                    <td colspan="${getTimesheetTableColumnCount()}" class="text-center">
                        <div class="col-12 text-center py-5">
                            <h4 class="text-muted">There are no records to view</h4>
                        </div>
                    </td>
                </tr>
            `);
            g_TotalRecords = 0;
            g_TotalPages = 0;
            ToggleRejectedUI();
            UpdatePaginationUI();
        }
    }

    // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
    function getDynamicTimesheetDateValue(item, dateColumnKey) {
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        if (!item || !dateColumnKey) return "";
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        if (dateColumnKey === "approved") {
            // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
            return formatDate(item.approvedDate || "");
        }
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        if (dateColumnKey === "rejected") {
            // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
            return formatDate(item.rejectedDate || item.RejectedDate || item.rejectDate || item.approvedDate || "");
        }
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        return "";
    }

    function ageingDaysBetweenSubmittedAndEnd(submittedRaw, endRaw) {
        var sub = new Date(submittedRaw);
        var end = new Date(endRaw);
        if (isNaN(sub.getTime()) || isNaN(end.getTime())) return 0;
        sub.setHours(0, 0, 0, 0);
        end.setHours(0, 0, 0, 0);
        var d = Math.floor((end.getTime() - sub.getTime()) / (24 * 60 * 60 * 1000));
        return d < 0 ? 0 : d;
    }

    // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
    function RenderTimesheetTable(data) {
        // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
        var dynamicDateColumn = getTimesheetDynamicDateColumnConfig();
        var tbody = $('#TimesheetTbl tbody');
        tbody.empty();
        if (!data || data.length === 0) {
            tbody.append(`
                <tr>
                    <td colspan="${getTimesheetTableColumnCount()}" class="text-center">
                        <div class="col-12 text-center py-5">
                            <h4 class="text-muted">There are no records to view</h4>
                        </div>
                    </td>
                </tr>
            `);
            return;
        }
        $.each(data, function (index, item) {
            // added by Dipali V On 27th March 2025 For Added new column as Ageing in list view
            // Ready for Approval: Submitted → today. Approved/Rejected: Submitted → Approved/Rejected date.
            var submittedDateRaw = item.createdDate1 || item.createdDate || "";
            var ageingDays = 0;
            var st = item.timesheetStatus;
            if (st === "Approved") {
                var appr = item.approvedDate || item.ApprovedDate || "";
                ageingDays = ageingDaysBetweenSubmittedAndEnd(submittedDateRaw, appr);
            } else if (st === "Rejected") {
                var rej = item.approvedDate || item.ApprovedDate || item.rejectDate || item.RejectDate || "";
                ageingDays = ageingDaysBetweenSubmittedAndEnd(submittedDateRaw, rej);
            } else {
                var today = new Date();
                today.setHours(0, 0, 0, 0);
                ageingDays = ageingDaysBetweenSubmittedAndEnd(submittedDateRaw, today);
            }
            var ageingDotColor = (ageingDays > 1) ? '#d9534f' : '#9e9e9e';

            var projectNameFull = String(item.projectName || "");
            var projectNameEsc = projectNameFull.replace(/&/g, "&amp;").split('<').join("&lt;").split('>').join("&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;");
            var projectNameShortRaw = projectNameFull.length > 15 ? (projectNameFull.substring(0, 15) + "...") : projectNameFull;
            var projectNameShort = projectNameShortRaw.replace(/&/g, "&amp;").split('<').join("&lt;").split('>').join("&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;");
            var projectTooltipAttr = projectNameFull.length > 15 ? (' data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="' + projectNameEsc + '"') : "";

            var statusClass = (item.timesheetStatus === "Approved") ? "text-success fw-bold" :
                (item.timesheetStatus === "Rejected") ? "text-danger fw-bold" :
                    (item.timesheetStatus === "Ready For Approval") ? "text-warning fw-bold" : "";
            var statusDotColor = (item.timesheetStatus === "Approved") ? "#28a745" :
                (item.timesheetStatus === "Rejected") ? "#dc3545" :
                    (item.timesheetStatus === "Ready For Approval") ? "#f0ad4e" : "#9e9e9e";
            // Hours badge color matches status color
            var hoursStyle = (item.timesheetStatus === "Approved")
                ? "color:#0b9d49; background-color:#beffd2;"
                : (item.timesheetStatus === "Rejected")
                    ? "color:#c0392b; background-color:#ffd6d6;"
                    : (item.timesheetStatus === "Ready For Approval")
                        ? "color:#856404; background-color:#fff3cd;"
                        : "color:#0b9d49; background-color:#beffd2;";
            var disabledAttr = (item.isDisabled === true) ? "disabled" : "";
            var tsId = String(item.timeSheetNo);
            // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
            var dynamicDateValue = getDynamicTimesheetDateValue(item, dynamicDateColumn.key);
            //var dynamicDateValue = item.approvedDate;
            // Added or Modified by Vishal Mane on 26/03/2026 to implement dynamic plotting of Timesheet List
            var dynamicDateCellHTML = dynamicDateColumn.key
                ? `<td><span class="date_txt"><i class="far fa-calendar-alt"></i> ${dynamicDateValue}</span></td>`
                : "";
            var row = `
                <tr>
                    <td><a href="javascript:void(0);" class="text_underline" onclick="Edit_Timesheet(${item.timeSheetNo}, '${formatDate(item.fromDate)}', '${formatDate(item.toDate)}', '${item.timesheetStatus}', '${item.projectID}', ${item.isDisabled === true})">${item.timeSheetNo}</a></td>
                    <td><span class="date_txt"><div style="gap:5px; "><i class="far fa-calendar-alt"></i>  ${item.createdDate1}</span></div></td>
                    ${dynamicDateCellHTML}
                    <td><span${projectTooltipAttr}>${projectNameShort}</span></td>
                    <td><span class="date_txt"><i class="far fa-calendar-alt"></i> ${formatDate(item.fromDate)}</span></td>
                    <td><span class="date_txt"><i class="far fa-calendar-alt"></i> ${formatDate(item.toDate)}</span></td>
                    <td><span style="display:inline-flex;align-items:center;justify-content:center;min-width:24px;height:24px;padding:0 6px;border-radius:50%;background:${ageingDotColor};color:#fff;font-weight:600;line-height:24px;">${ageingDays}</span></td>
                    <td class="text-center"><span class="total_hours" style="${ hoursStyle }"><i class="far fa-clock"></i>${item.totalTimeSheetHours}</span></td>
                    <td class="${statusClass}"><span style="display:inline-block;width:10px;height:10px;border-radius:50%;background:${statusDotColor};margin-right:6px;vertical-align:middle;"></span>${item.timesheetStatus}</td>
                    <td><a href="javascript:void(0);" data-bs-container="body" data-bs-placement="top" class="text_underline" onclick="Billing_Information(${item.timeSheetNo}, '${formatDate(item.fromDate)}', '${formatDate(item.toDate)}', '${item.timesheetStatus}', '${item.projectID}', false, ${item.isDisabled === true})"><%=MyBase.GetResourceString("C_BillingInformation")%> <i class="fas fa-info-circle"></i></a></td>
                    <td><a href="javascript:void(0);" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_PrintReport")%>" class="text_underline" onclick="OpenPrintOffcanvas(${item.timeSheetNo}, '${item.projectName}')"><i class="fas fa-print"></i></a></td>
                    <td>
                        <a href="javascript:void(0);" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="View Details"
                           class="text_underline" onclick="Edit_Timesheet(${item.timeSheetNo}, '${formatDate(item.fromDate)}', '${formatDate(item.toDate)}', '${item.timesheetStatus}', '${item.projectID}', ${item.isDisabled === true})">
                            <i class="far fa-eye"></i>
                        </a>
                    </td>
                    <td>
                        <input type="checkbox" class="ts-checkbox" value="${tsId}" ${disabledAttr} />
                    </td>
                </tr>`;
            tbody.append(row);
        });
        RenderCheckboxState();
        $('[data-bs-toggle="tooltip"]').tooltip('dispose').tooltip();
    }

    //function RenderCheckboxState() {
    //    var isHeaderChecked = g_SelectAllActive && g_ExplicitlyDeselected.length === 0;
    //    $("#chkSelectAll").prop('indeterminate', false).prop('checked', isHeaderChecked);
    //    $(".ts-checkbox").each(function () {
    //        var tsId = $(this).val();
    //        var isDisabled = $(this).is(':disabled');
    //        var shouldBeChecked = false;
    //        if (isDisabled) {
    //            shouldBeChecked = false;
    //        } else if (g_SelectAllActive) {
    //            shouldBeChecked = !g_ExplicitlyDeselected.includes(tsId);
    //        } else {
    //            shouldBeChecked = g_ExplicitlySelected.includes(tsId);
    //        }
    //        $(this).prop('checked', shouldBeChecked);
    //    });
    //}
    function RenderCheckboxState() {
        // Determine header checked state based on current mode
        var isHeaderChecked = g_SelectAllActive && g_ExplicitlyDeselected.length === 0;

        // --- Transition from Select All to Manual if needed ---
        if (g_SelectAllActive && !isHeaderChecked) {
            // Collect IDs of rows that should remain checked (those not in excludedIDs)
            var newSelected = [];
            $(".ts-checkbox:not(:disabled)").each(function () {
                var id = $(this).val();
                if (!g_ExplicitlyDeselected.includes(id)) {
                    newSelected.push(id);
                }
            });
            // Switch to manual mode
            g_SelectAllActive = false;
            g_ExplicitlySelected = newSelected;
            g_ExplicitlyDeselected = [];

            // Recompute header state (now it should be false)
            isHeaderChecked = false;
        }

        // Apply header checkbox
        $("#chkSelectAll").prop('indeterminate', false).prop('checked', isHeaderChecked);

        // Apply row checkboxes based on current mode
        $(".ts-checkbox").each(function () {
            var tsId = $(this).val();
            var isDisabled = $(this).is(':disabled');
            var shouldBeChecked = false;

            if (isDisabled) {
                shouldBeChecked = false;
            } else if (g_SelectAllActive) {
                shouldBeChecked = !g_ExplicitlyDeselected.includes(tsId);
            } else {
                shouldBeChecked = g_ExplicitlySelected.includes(tsId);
            }
            $(this).prop('checked', shouldBeChecked);
        });
    }

    function UpdatePaginationUI() {
        ////////$("#lblTotalRecords").text("<%=MyBase.GetResourceString("C_TotalRecords")%>: " + g_TotalRecords + " | Page: " + g_CurrentPage + " of " + (g_TotalPages || 1));
        //commented and added by Aditya J. on 26-03-2026 for consistent pagination
        <%--$("#lblTotalRecords").text(((("<%=MyBase.GetResourceString("C_TotalRecords")%>" || "").trim()) ? "<%=MyBase.GetResourceString("C_TotalRecords")%>" : "Total Records") + ": " + g_TotalRecords + " | Page: " + g_CurrentPage + " of " + (g_TotalPages || 1));--%>
        $("#lblTotalRecords").text(((("<%=MyBase.GetResourceString("C_TotalRecords")%>" || "").trim()) ? "<%=MyBase.GetResourceString("C_TotalRecords")%>" : "Total Records") + ": " + g_TotalRecords);
        //End of commented and added by Aditya J.on 26 - 03 - 2026 for consistent pagination
        $("#btnPrev").prop('disabled', (g_CurrentPage <= 1));
        $("#btnNext").prop('disabled', (g_CurrentPage >= g_TotalPages));
    }

    function ToggleRejectedUI() {
        var selectedStatus = $("#ddlStatus option:selected").text().toLowerCase();
        var isRejected = selectedStatus.indexOf("rejected") > -1;
        //Added by Aditya J. on 26-03-2026 for showing approve and reject buttons only for allowed timesheet statuses
        var isReadyForApproval = selectedStatus.indexOf("ready for approval") > -1;
        var isApproved = selectedStatus.indexOf("approved") > -1 && selectedStatus.indexOf("ready for approval") === -1;
        var isSelectTimesheetStatus = selectedStatus.indexOf("select timesheet status") > -1;
        var showApproveButton = isReadyForApproval || isSelectTimesheetStatus;
        var showRejectButton = isApproved || isReadyForApproval || isSelectTimesheetStatus;
        if (isRejected) {
            $("#TimesheetTbl").addClass("hide-checkbox-column");
            ////commented by Aditya J. on 26-03-2026 for showing approve and reject buttons only for allowed timesheet statuses
            //$(".btn-success[onclick*='OpenBulkPreview(1)']").hide();
            //$(".btn-danger[onclick*='OpenBulkPreview(2)']").hide();
            $("#btnApprove").hide();
            $("#btnReject").hide();
        } else {
            $("#TimesheetTbl").removeClass("hide-checkbox-column");
            ////commented by Aditya J. on 26-03-2026 for showing approve and reject buttons only for allowed timesheet statuses
            //$(".btn-success[onclick*='OpenBulkPreview(1)']").show();
            //$(".btn-danger[onclick*='OpenBulkPreview(2)']").show();
            showApproveButton ? $("#btnApprove").show() : $("#btnApprove").hide();
            showRejectButton ? $("#btnReject").show() : $("#btnReject").hide();
        }
        //End of Added by Aditya J. on 26-03-2026 for showing approve and reject buttons only for allowed timesheet statuses
    }

    function ValidateDateRange(triggerSource) {
        var fromDateStr = $("#txtFromDate").val();
        var toDateStr = $("#txtToDate").val();
        var isValid = true;
        if (fromDateStr !== "") {
            try { $.datepicker.parseDate('dd M yy', fromDateStr); }
            catch (e) { alertify.error(resourceKeys.InvalidDateFormat); $("#txtFromDate").val(''); $("#txtToDate").val('');  return false; }
        }
        if (toDateStr !== "") {
            try { $.datepicker.parseDate('dd M yy', toDateStr); }
            catch (e) { alertify.error(resourceKeys.InvalidDateFormat); $("#txtToDate").val(''); return false; }
        }
        if ((triggerSource === 'ToDate' || triggerSource === 'All') && toDateStr !== "" && fromDateStr === "") {
            alertify.error(resourceKeys.FromDateBlank); isValid = false;
        } else if ((triggerSource === 'FromDate' || triggerSource === 'All') && fromDateStr !== "" && toDateStr === "") {
            alertify.error(resourceKeys.ToDateBlank); isValid = false;
        } else if (fromDateStr !== "" && toDateStr !== "") {
            var dFrom = $.datepicker.parseDate('dd M yy', fromDateStr);
            var dTo = $.datepicker.parseDate('dd M yy', toDateStr);
            if (dFrom > dTo) {
                alertify.error(resourceKeys.FromDateLessThanToDate);
                isValid = false;
            }
        }
        return isValid;
    }

    function formatDate(dateString) {
        if (!dateString) return "";
        var date = new Date(dateString);
        if (isNaN(date.getTime())) return dateString;
        if (date.getFullYear() === 1900 && date.getMonth() === 0 && date.getDate() === 1) return "";
        var day = ("0" + date.getDate()).slice(-2);
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var monthName = months[date.getMonth()];
        var year = date.getFullYear();
        return day + " " + monthName + " " + year;
    }

    function toISODate(dateStr) {
        if (!dateStr) return null;
        var parts = dateStr.split(' ');
        if (parts.length !== 3) return null;
        var monthMap = { Jan: "01", Feb: "02", Mar: "03", Apr: "04", May: "05", Jun: "06", Jul: "07", Aug: "08", Sep: "09", Oct: "10", Nov: "11", Dec: "12" };
        return `${parts[2]}-${monthMap[parts[1]]}-${parts[0]}`;
    }

    function OpenPrintOffcanvas(tsNo, projectName) {
        $("#off_txtPrintTimesheet").val(tsNo);
        //$("#off_ddlPrintSite").empty().append('<option value="0">All</option>');
        //$("#off_ddlPrintEmployee").empty().append('<option value="0">All</option>');
        $("#off_ddlPrintSite").empty().append('<option value="0">Select Site</option>');
        $("#off_ddlPrintEmployee").empty().append('<option value="0">Select Employee</option>');
        if ($.fn.selectpicker) {
            $("#off_ddlPrintSite, #off_ddlPrintEmployee").selectpicker('refresh');
        }
        var param = JSON.stringify({ TimeSheetID: parseInt(tsNo) });
        var siteResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetPrintSites", param, false);
        if (siteResult) {
            $.each(siteResult, function (i, item) {
                var val = item.siteID || item.SiteID;
                var txt = item.siteName || item.SiteName;
                $("#off_ddlPrintSite").append('<option value="' + val + '">' + txt + '</option>');
            });
        }
        var empResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetPrintEmployees", param, false);
        if (empResult) {
            $.each(empResult, function (i, item) {
                var val = item.employeeID || item.EmployeeID;
                var txt = item.employeeName || item.EmployeeName;
                $("#off_ddlPrintEmployee").append('<option value="' + val + '">' + txt + '</option>');
            });
        }
        if ($.fn.selectpicker) {
            $("#off_ddlPrintSite, #off_ddlPrintEmployee").selectpicker('refresh');
        }
        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_PrintReport'));
        bsOffcanvas.show();
    }

    var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
    // Normalize API base URL and route joining to avoid accidental double slashes (e.g. W26_API//api/...)
    function buildApiUrl(path) {
        var base = String(strUrl || '').replace(/\/+$/, '');
        var route = String(path || '').replace(/^\/+/, '');
        return base + '/' + route;
    }
    var UserID = '<%= Session("intUserID") %>';
    var UserName = '<%= Session("strUserName") %>';
    var LoginType = '<%= Session("LoginType") %>';
    var ProjectID = '<%= Session("intProjectID") %>';
    var InvoiceTimesheetID = 0;
    alertify.set('notifier', 'position', 'top-right');
    var ReadyToAuthenticate = "";
    var Authenticated = "";
    var ContractTypeID = "";
    var ajaxResult = "";

    function AJAXCallWithResult(url, param, async) {

        if (url.substring(0, 1) === "/") {
            url = url.substring(1);
        }

        $.ajax({
            url: encodeURI(buildApiUrl(url)),
            type: "POST",
            data: param,
            async: async,
            dataType: "json",
            contentType: "application/json;charset-utf=8",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                if (param) {
                    xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                }
            },
            success: function (data) {
                ajaxResult = data;
            },
            error: function (err) {
                console.log(err);
            }
        });
        return ajaxResult;
    }

    var g_BillingCurrentStatus = '';
    var g_BillingIsDisabled = false;

    function Billing_Information(intTimesheetNo, Fromdate, ToDate, CurrentStatus, ProjectID, IsAllValuesInSiteCurrency, isDisabled) {
        GlobalSelectedintTimesheetNo = intTimesheetNo;
        ProjectTimesheetID = intTimesheetNo;
        setTimeout(applyStatusDotsToDropdown, 0);
        //closeOpenSelectPickers();
        var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_BillingInfo'));
        myOffcanvas.show();
        g_BillingCurrentStatus = CurrentStatus || '';
        g_BillingIsDisabled = isDisabled === true;
        var status = g_BillingCurrentStatus.toLowerCase();
        var $btnApprove = $("#btn_authenticate");
        var $btnReject = $("#btn_reject");

        //commented and added by Aditya J. on 26-03-2026 for showing approve and reject button only when status is
        //Ready For Approval
        //if (g_BillingIsDisabled || status === 'rejected') {
        //    $btnApprove.hide();
        //    $btnReject.hide();
        //} else if (status === 'approved') {
        //    $btnApprove.hide();
        //    $btnReject.show();
        //} else {
        //    $btnApprove.show();
        //    $btnReject.show();
        //}

        if (status === 'rejected') {
            $btnApprove.hide();
            $btnReject.hide();
        } else if (status === 'approved') {
            $btnApprove.hide();
            isDisabled ? $btnReject.hide() : $btnReject.show();
        } else if (status === 'ready for approval' && !isDisabled) {
            $btnApprove.show();
            $btnReject.show();
        } else {
            $btnApprove.hide();
            $btnReject.hide();
        }
        //End of commented and added by Aditya J. on 26-03-2026 for showing approve and reject button only when status is
        //Ready For Approval
        
        myOffcanvas.show();
        GetProjectRateMethod();
        GetTimesheetReadyToAuthenticateFlag(intTimesheetNo);
        GetProjectDetails(intTimesheetNo, ProjectID, Fromdate, ToDate);
        setTimeout(function () {
            GetTimesheetBillingDetails(intTimesheetNo, InvoiceTimesheetID);
        }, 0);
    }

    function closeBillingDetails() {
        var el = document.getElementById('offcanvas_BillingInfo');
        if (!el) return;
        var instance = bootstrap.Offcanvas.getInstance(el);
        if (instance) {
            instance.hide();
        }
    }

    function GetProjectRateMethod() {
        var Parameters = {
            ProjectID: encodeURI(ProjectID),
            TimesheetID: encodeURI(ProjectTimesheetID)
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetProjectRateMethod", param, false);
        if (strResult.length > 0) {
            $("#cboRateMethod option").empty();
            var objCbo1 = document.getElementById("cboRateMethod");
            $("#cboRateMethod option").remove();
            for (var i = 0; i < strResult.length; i++) {
                var ObjData = strResult[i];
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = ObjData.rateMethod;
                objOption.value = ObjData.rateMethodID;
            }
        }
        $(".selectpicker").selectpicker('refresh');
    }

    function GetProjectDetails(intTimesheetNo, ProjectID, Fromdate, ToDate) {
        var Parameters = {
            ProjectID: encodeURI(ProjectID),
            TimesheetID: encodeURI(intTimesheetNo)
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetProjectTimesheetDetails", param, false);
        var GetProjectDetail = strResult;
        BindProjectDetails(GetProjectDetail);
        if (ContractTypeID == "5") {
            $('#DivCapHoliday').css('display', 'none');
            $('#MonthlyMoreDetails').css('display', 'none');
        }
        $("#lblTxtFromDate").text(Fromdate);
        $("#billingfromdate").text(Fromdate);
        $("#lblTxtToDate").text(ToDate);
        $("#billingTodate").text(ToDate);
    }

    var BillingTotalRecordCount = 0;
    var GIsIRGenerator = 0;
    var IsAllValuesInSiteCurrency = "";
    var GSelectedSiteCurrencyID = "";
    var GSelectedSiteCurrencyCode = "";

    function GetTimesheetBillingDetails(intTimesheetNo, InvoiceTimesheetID) {
        var Parameters = {
            TimesheetID: encodeURI(intTimesheetNo),
            InvoiceTimesheetID: encodeURI(InvoiceTimesheetID),
            UserID: encodeURI(UserID)
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetTimesheetBillingDetails", param, false);
        $(".tbody_billing_info").html('');
        var totalInvoice = 0;
        var totalDiscount = 0;
        var totalFinal = 0;
        var strHTML = '';
        var TimesheetID = intTimesheetNo;
        if (!strResult || strResult.length === 0) {
            return;
        }
        for (var i = 0; i < strResult.length; i++) {
           // debugger;
            BillingTotalRecordCount = strResult.length;
            GIsIRGenerator = strResult[i].isIRGeneratorID;
            IsAllValuesInSiteCurrency = strResult[i].isAllValuesInSiteCurrency;
            GSelectedSiteCurrencyID = strResult[i].siteCurrencyID;
            GSelectedSiteCurrencyCode = strResult[i].siteCurrencyCode;
            SiteId = strResult[i].siteId;
            var rawInvoice = strResult[i].invoiceAmount || 0;
            var rawDiscount = strResult[i].discount || 0;
            var rawFinal = strResult[i].finalAmount || 0;
            var rawPmEdit = strResult[i].finalAmountPmEdit || 0;
            var rawDiff = strResult[i].pmEditDiffAmount || 0;
            var InvoiceAmount = parseFloat(rawInvoice).toFixed(3);
            var Discount = parseFloat(rawDiscount).toFixed(3);
            var FinaLAmount = parseFloat(rawFinal).toFixed(3);
            var FinalAmountPmEdit = parseFloat(rawPmEdit).toFixed(3);
            var PMEditDiffAmount = parseFloat(rawDiff).toFixed(3);
            totalInvoice += parseFloat(rawInvoice);
            totalDiscount += parseFloat(rawDiscount);
            totalFinal += parseFloat(rawFinal);
            var added_IRClass = (strResult[i].irId != 0 && strResult[i].irId != "") ? 'added_IR' : '';
            strHTML += '<tr class="tr_add ' + added_IRClass + '" id="row_' + strResult[i].adviseId + '">';
            strHTML += '<td>' + strResult[i].employeeCode + ' - ' + strResult[i].employee + '</td>';
            strHTML += '<td>' + strResult[i].location + '</td>';
            strHTML += '<td>' + strResult[i].projectRole + '</td>';
            strHTML += '<td>';
            strHTML += '<a href="javascript:void(0);" class="text_size hypertext" onclick="GetTimesheetDetails(' + strResult[i].employeeId + ',' + strResult[i].siteId + ',' + strResult[i].timesheetId + ',' + strResult[i].adviseId + ',' + strResult[i].projectRoleId + ')">';
            strHTML += '<i class="fas fa-info" style="color:#ff8000" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_TimesheetDetails")%>"></i>';
            strHTML += '</a></td>';
            strHTML += '<td>' + (strResult[i].billingRate || 0).toFixed(3);
            if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                strHTML += ' <span class="Curncy iconBlue">(' + (strResult[i].siteCurrency || '') + ')</span>';
            }
            strHTML += '</td>';
            strHTML += '<td class="tdCurrent">';
            strHTML += '<span class="text-center" style=" display: block;">' + (strResult[i].actualHr || '00:00') + '</span>';
            strHTML += '</td>';
            strHTML += '<td class="tdCurrent">' + (strResult[i].workingDay || 0) + '</td>';
            strHTML += '<td class="tdCurrent">' + (strResult[i].dayWorked || 0).toFixed(3) + '</td>';
            strHTML += '<td class="tdCurrent">' + (strResult[i].dailyRate || 0).toFixed(3) + '</td>';
            strHTML += '<td class="tdCurrent">';
            strHTML += '<span class="SumInvoice" id="InvoiceAmount_' + strResult[i].adviseId + '">' + GetChangeFormat(InvoiceAmount) + '</span>';
            if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                strHTML += ' <span class="Curncy iconBlue">(' + (strResult[i].billingCurrencySymbol || '') + ')</span>';
            }
            strHTML += '</td>';
            strHTML += '<td class="tdCurrent">';
            strHTML += '<span class="SumDiscount">' + GetChangeFormat(Discount) + '</span>';
            strHTML += '</td>';
            strHTML += '<td><span class="SumFinalAmount">' + GetChangeFormat(FinaLAmount) + '</span></td>';
            strHTML += '</tr>';
        }
        $(".tbody_billing_info").html(strHTML);
        // For totals (footer), bind billing currency symbol/code, not site currency.
        // Fallback to site currency fields for backward compatibility if API doesn't return billing currency values.
        var displayCurrency = strResult.length > 0
            ? (GBillingCurrencySymbol || strResult[0].siteCurrency || strResult[0].siteCurrencyCode || "")
            : "";
        var currencyText = displayCurrency ? " (" + displayCurrency + ")" : "";
        $("#SumInvoice").text(GetChangeFormat(totalInvoice.toFixed(3)));
        $("#SumDiscount").text(GetChangeFormat(totalDiscount.toFixed(3)));
        $("#SumFinalAmount").text(GetChangeFormat(totalFinal.toFixed(3)));
        $("#SumInvoicebillingCurrency").text(currencyText).show();
        $("#SumDiscountbillingCurrency").text(currencyText).show();
        $("#billingCurrency").text(currencyText).show();
        $('[data-bs-toggle="tooltip"]').tooltip();
    }

    var GlobalRateMethod;
    var GProjectName;
    var GCurrencyCode;
    var GCurrencySymbol;
    var GRateMethod;
    var CreditPeriod;
    var GCustomerID;
    var GCurrencyID;
    var GProjectOrProduct;
    var GBillingCurrencyID;
    var GBillingCurrencySymbol;
    var GBillingCurrencyCode;
    var globalcontracttypeID;



    function BindProjectDetails(GetProjectDetail) {
        if (GetProjectDetail != undefined) {
            for (var i = 0; i < GetProjectDetail.length; i++) {
               //debugger;
                var ProjectName = GetProjectDetail[i]["projectName"];
                GProjectName = GetProjectDetail[i]["projectName"];
                var ContractType = GetProjectDetail[i]["contractType"];
                var CurrencyCode = GetProjectDetail[i]["currencyCode"];
                GCurrencyCode = GetProjectDetail[i]["currencyCode"];
                GCurrencySymbol = GetProjectDetail[i]["currencySymbol"];
                GBillingCurrencyID = GetProjectDetail[i]["billingCurrencyID"];
                GBillingCurrencySymbol = GetProjectDetail[i]["billingCurrencySymbol"];
                GBillingCurrencyCode = GetProjectDetail[i]["billingCurrencyCode"];
                var RateMethod = GetProjectDetail[i]["rateMethod"];
                var SiteValidation = GetProjectDetail[i]["siteValidation"];
                GlobalWorkHrs = GetProjectDetail[i]["workHrs"];
                var HoursPerMonth = GetProjectDetail[i]["hoursPerMonth"];
                GlobalWorkHrsperday = GetProjectDetail[i]["workHrsperday"];
                OrganizationUnit = GetProjectDetail[i]["locationID"];
                GlobalMonthlyHr = GetProjectDetail[i]["monthlyHr"];
                ContractTypeID = GetProjectDetail[i]["contractTypeID"];
                CurrencyID = GetProjectDetail[i]["currencyID"];
                GCurrencyID = GetProjectDetail[i]["currencyID"];
                InvoiceTimesheetID = GetProjectDetail[i]["invoiceTimesheetId"];
                GCustomerID = GetProjectDetail[i]["customerID"];
                CreditPeriod = GetProjectDetail[i]["creditPeriod"];
                GBLMonthlyHr = GetProjectDetail[i]["monthlyHr"];
                GProjectOrProduct = GetProjectDetail[i]["projectOrProduct"];
                var ProjectOrganizationUnit = GetProjectDetail[i]["projectOrganizationUnit"];
                var BufferPercentage = GetProjectDetail[i]["bufferPercentage"];
                var RateMethodName = GetProjectDetail[i]["rateMethodName"];
                $("#input_project").text(ProjectName);
                $("#input_Commercial").text(ContractType);
                $("#SpanProjectOU").text(ProjectOrganizationUnit);
                $("#project_current").text(ProjectName);
                if (GBillingCurrencySymbol != GCurrencySymbol) {
                    GBillingCurrencySymbol = GBillingCurrencySymbol;
                } else {
                    GBillingCurrencySymbol = GCurrencySymbol;
                }
                if (GBillingCurrencyCode != GCurrencyCode) {
                    CurrencyCode = GBillingCurrencyCode;
                } else {
                    CurrencyCode = GBillingCurrencyCode;
                }
                globalcontracttype = ContractType;
                globalcontracttypeID = ContractTypeID;
                if (ContractTypeID == 5) {
                    $("#SpanCommercialTypeNote").text("<%=MyBase.GetResourceString("C_FixFeeBillingNote")%>");
                } else {
                    $("#SpanCommercialTypeNote").text("");
                }
                $("#lbltxtHRPerDay").text(GlobalWorkHrs);
                $("#lbltxtMonthlyHr").text(HoursPerMonth);
                $("#lblcboRateMethod").text(RateMethodName);
                GRateMethod = RateMethod;
                $("#lbltxtProjectCurrency").text(CurrencyCode);
                var OUWorkingDays = GetProjectDetail[i]["ouWorkingDays"] || GetProjectDetail[i]["OUWorkingDays"] || ProjectOrganizationUnit || '';
                $("#lbltxtOU").text(OUWorkingDays);
                if (SiteValidation == true) {
                    SiteValidation = "Yes";
                } else {
                    SiteValidation = "No";
                }
                $("#lblcboSiteValidation").text(SiteValidation);
                $("#lbltxtBufferPercent").text(BufferPercentage);
                var OnsiteFull = GetProjectDetail[i]["OnsiteFull"];
                if (OnsiteFull == null) {
                    OnsiteFull = '';
                } else if (OnsiteFull == false || OnsiteFull == 0) {
                    OnsiteFull = 'No';
                } else if (OnsiteFull == true || OnsiteFull == 1) {
                    OnsiteFull = 'Yes';
                }
                GlobalRateMethod = RateMethod;
                if (RateMethod == 3) {
                    OnloadRateMethodOnChange();
                    $(".highlitedpanel").css("display", "block");
                    $("#lblcboActualDayBilling").text('Yes');
                    var actualDayBillingRaw = GetProjectDetail[i]["actualDayBilling"] || GetProjectDetail[i]["ActualDayBilling"];
                    var isActualDayBillingYes = (actualDayBillingRaw === true || actualDayBillingRaw === 1 || actualDayBillingRaw === '1' || String(actualDayBillingRaw).toLowerCase() === 'yes');
                    if (isActualDayBillingYes) {
                        OnloadActualDayBillingRateOnchange();
                        $("#lblcboActualDayBilling").text('Yes');
                        $("#lblcboFixedMonthlyRate").text('No');
                    } else {
                        $("#lblcboFixedMonthlyRate").text('Yes');
                    }
                    var fixedMonthlyRateRaw = GetProjectDetail[i]["fixedMonthlyRate"] || GetProjectDetail[i]["FixedMonthlyRate"];
                    var isFixedMonthlyRateYes = (fixedMonthlyRateRaw === true || fixedMonthlyRateRaw === 1 || fixedMonthlyRateRaw === '1' || String(fixedMonthlyRateRaw).toLowerCase() === 'yes');
                    if (isFixedMonthlyRateYes) {
                        OnloadFixedMonthlyRateOnchange();
                        $("#lblcboFixedMonthlyRate").text('Yes');
                        $("#lblcboActualDayBilling").text('No');
                    } else {
                        $("#lblcboActualDayBilling").text('Yes');
                    }
                } else {
                    RateMethodOnChange();
                }
                $("#lbltxtDiscount").text(GetProjectDetail[i]["discountPercentage"] || GetProjectDetail[i]["DiscountPercentage"] || 0);
                $("#lbltxtInvoiceDate").text(GetProjectDetail[i]["invoiceDate"] || GetProjectDetail[i]["InvoiceDate"] || '');
                var actualVal = GetProjectDetail[i]["actualDayBilling"] || GetProjectDetail[i]["ActualDayBilling"];
                var fixedVal = GetProjectDetail[i]["fixedMonthlyRate"] || GetProjectDetail[i]["FixedMonthlyRate"];
                var effortVal = GetProjectDetail[i]["effortToConsider"] || GetProjectDetail[i]["EffortToConsider"] || '';
                $("#lblcboActualDayBilling").text((actualVal === true || actualVal === 1 || actualVal === '1' || String(actualVal).toLowerCase() === 'yes') ? 'Yes' : 'No');
                $("#lblcboFixedMonthlyRate").text((fixedVal === true || fixedVal === 1 || fixedVal === '1' || String(fixedVal).toLowerCase() === 'yes') ? 'Yes' : 'No');
                $("#lbltxtEffortToConsider").text(effortVal);
                $("#lblcboOnSiteFull").text(OnsiteFull);
                if (ContractTypeID == "5") {
                    $(".FixedFee").css("display", "none");
                    $("#Generate_IR_accordion").css("display", "none");
                    $("#T_Note3").css("display", "none");
                }
                if (ContractTypeID != "5") {
                    if (RateMethod == 3) {
                        $("#TxtToDate").prop('disabled', true);
                    }
                }
                var CapConsider = GetProjectDetail[i]["capConsider"];
                var CapHoliday = GetProjectDetail[i]["capHoliday"];
                if (CapConsider == true) {
                    CapConsider = "Yes";
                } else {
                    CapConsider = "No";
                }
                if (CapHoliday == true) {
                    CapHoliday = "Yes";
                } else {
                    CapHoliday = "No";
                }
                if (ContractTypeID == 6) {
                    $("#lblcboCapConsider").text("Yes");
                    $("#lblcboCapHoliday").text("No");
                } else if (ContractTypeID == 7) {
                    $("#lblcboCapConsider").text("Yes");
                    $("#lblcboCapHoliday").text("No");
                } else {
                    $("#lblcboCapConsider").text("No");
                    $("#lblcboCapHoliday").text("No");
                }
                $("#lblcboCapConsider").text(CapConsider);
                $("#lblcboCapHoliday").text(CapHoliday);
            }
        }
        $("#txtBufferPercent").prop('disabled', true);
        $(".selectpicker").selectpicker('refresh');
    }

    function RateMethodOnChange() {
        var RateMethod = $("#cboRateMethod option:selected").html();
        if (RateMethod == "Hours" || RateMethod == "Day" || RateMethod == 'Select Rate Method') {
            $("#txtBufferPercent").prop("disabled", true);
            $("#txtMonthlyHr").prop("disabled", true);
            $("#cboActualDayBilling").prop("disabled", true);
            $("#cboFixedMonthlyRate").prop("disabled", true);
            $("#cboOnSiteFull").prop("disabled", true);
            $("#txtBufferPercent").val('');
            $("#txtEffortToConsider").val('');
            $("#cboActualDayBilling").val('NA');
            $("#cboFixedMonthlyRate").val('NA');
            $("#cboOnSiteFull").val('');
            $(".highlitedpanel").css("display", "none");
            $(".clsActualHr").prop("disabled", true);
        } else {
            $("#cboActualDayBilling").prop("disabled", false);
            $("#txtBufferPercent").prop("disabled", false);
            $("#txtMonthlyHr").prop("disabled", false);
            $("#cboFixedMonthlyRate").prop("disabled", true);
            $("#cboOnSiteFull").prop("disabled", false);
            $("#cboActualDayBilling").val('Yes');
            $(".highlitedpanel").css("display", "block");
            ActualDayBillingRateOnchange();
            $(".clsActualHr").prop("disabled", false);
        }
    }

    function OnloadRateMethodOnChange() {
        var RateMethod = $("#cboRateMethod option:selected").html();
        if (RateMethod == "Hours" || RateMethod == "Day" || RateMethod == 'Select Rate Method') {
            $("#txtBufferPercent").prop("disabled", true);
            $("#txtMonthlyHr").prop("disabled", true);
            $("#cboActualDayBilling").prop("disabled", true);
            $("#cboFixedMonthlyRate").prop("disabled", true);
            $("#cboOnSiteFull").prop("disabled", true);
            $('.highlitedpanel').addClass('highlitedbox');
        } else {
            $("#cboActualDayBilling").prop("disabled", false);
            $("#txtBufferPercent").prop("disabled", false);
            $("#txtMonthlyHr").prop("disabled", false);
            $("#cboFixedMonthlyRate").prop("disabled", false);
            $("#cboOnSiteFull").prop("disabled", false);
            $('.highlitedpanel').removeClass('highlitedbox');
            OnloadActualDayBillingRateOnchange();
            OnloadFixedMonthlyRateOnchange();
        }
    }

    function OnloadActualDayBillingRateOnchange() {
        var ActualDayBilling = $("#cboActualDayBilling").val();
        var RateMethod = $("#cboRateMethod option:selected").html();
        if (RateMethod == "Monthly") {
            if (ActualDayBilling == 'Yes') {
                $("#txtBufferPercent").prop("disabled", true);
                $("#cboFixedMonthlyRate").prop("disabled", true);
                $("#cboOnSiteFull").prop("disabled", true);
                $("#txtMonthlyHr").prop("disabled", true);
                $("#cboFixedMonthlyRate").val('No');
                $("#cboActualDayBilling").prop("disabled", false);
            } else if (ActualDayBilling == 'No') {
                $("#txtBufferPercent").prop("disabled", true);
                $("#cboFixedMonthlyRate").prop("disabled", false);
                $("#cboOnSiteFull").prop("disabled", true);
                $("#txtMonthlyHr").prop("disabled", true);
                $("#cboFixedMonthlyRate").val('Yes');
                $("#cboActualDayBilling").prop("disabled", true);
            } else if (ActualDayBilling == 'NA') {
                $("#txtBufferPercent").prop("disabled", true);
                $("#cboFixedMonthlyRate").prop("disabled", true);
                $("#cboOnSiteFull").prop("disabled", true);
                $("#txtMonthlyHr").prop("disabled", true);
            }
        }
    }

    function OnloadFixedMonthlyRateOnchange() {
        var FixedMonthlyRate = $("#cboFixedMonthlyRate").val();
        var RateMethod = $("#cboRateMethod option:selected").html();
        if (RateMethod == "Monthly") {
            if (FixedMonthlyRate == 'Yes') {
                $("#txtBufferPercent").prop("disabled", false);
                $("#cboOnSiteFull").prop("disabled", false);
                $("#txtMonthlyHr").prop("disabled", true);
                $("#cboActualDayBilling").prop("disabled", true);
            } else if (FixedMonthlyRate == 'No') {
                $("#txtMonthlyHr").prop("disabled", true);
                $("#txtBufferPercent").prop("disabled", true);
                $("#cboActualDayBilling").prop("disabled", false);
                $("#cboOnSiteFull").prop("disabled", true);
            } else if (FixedMonthlyRate == 'NA') {
                $("#txtBufferPercent").prop("disabled", true);
                $("#cboOnSiteFull").prop("disabled", true);
                $("#cboActualDayBilling").prop("disabled", true);
                $("#txtMonthlyHr").prop("disabled", true);
            }
        }
    }

    var IsInvoicedatediatble = 0;

    function GetTimesheetReadyToAuthenticateFlag(intTimesheetNo) {
        var Parameters = {
            TimesheetID: encodeURI(intTimesheetNo)
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetTimesheetReadyToAuthenticateFlag", param, false);
        if (strResult.length != 0) {
            ReadyToAuthenticate = strResult[0].readyToAuthenticate;
            Authenticated = strResult[0].authenticated;
            if (ReadyToAuthenticate != "Y") {
                $(".txtEditAmount,.sumtxtEditAmount").prop("disabled", true);
                $("#txtInvoiceDate").prop("disabled", false);
                $("#btnGenerateTimesheet").prop("disabled", false);
                $("#btnSFA").prop("disabled", false);
                $("#btnSave").prop("disabled", false);
                if (GlobalRateMethod == 3) {
                    $(".clsActualHr").prop("disabled", false);
                }
            } else {
                $("#TxtFromDate,#TxtToDate,#txtOU,#txtHRPerDay,#txtBufferPercent,#txtMonthlyHr,#txtDiscount,#cboActualDayBilling,#txtEffortToConsider,#txtProjectCurrency,#cboFixedMonthlyRate,#cboFixedMonthlyRate,#cboOnSiteFull,#cboRateMethod,#txtInvoiceDate").prop("disabled", true);
                $(".txtEditAmount,.sumtxtEditAmount").prop("disabled", true);
                $("#txtInvoiceDate").prop("disabled", true);
                $("#btnGenerateTimesheet").prop("disabled", true);
                $("#btnSFA").prop("disabled", true);
                $("#btnSave").prop("disabled", true);
                if (GlobalRateMethod != 3) {
                    $(".clsActualHr").prop("disabled", true);
                }
            }
        }
    }

    function GetChangeFormat(value) {
        if (value != "") {
            var decimalCount;
            var Currentvalue = value.toString();
            if (Currentvalue.indexOf('.') > -1) {
                decimalCount = countDecimals(Currentvalue);
            } else {
                decimalCount = 0;
            }
            if (decimalCount == 4) {
                Currentvalue = Currentvalue.slice(0, -1);
            }
            var components = Currentvalue.toString().split(".");
            if (components.length == 1) {
                components[0] = Currentvalue;
            }
            components[0] = components[0].replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            if (components.join('.') != '')
                return components.join('.');
            else
                return '';
        }
    }

    function countDecimals(value) {
        if (Math.floor(value) === value) return 0;
        return value.toString().split(".")[1].length || 0;
    }

    /** Timesheet Details offcanvas: show currency/rate/total amounts with 3 decimal places (e.g. 1000.000). */
    function formatTimesheetDetailAmount3(val) {
        if (val === null || val === undefined || val === '') return '0.000';
        var n = parseFloat(String(val).replace(/,/g, ''));
        if (isNaN(n)) return '0.000';
        return n.toFixed(3);
    }

    function GetTimesheetDetails(EmployeeID, SiteID, TimesheetID, AdviseId, RoleID) {
        var myModalEl = document.getElementById('billine_info_details');
        if (myModalEl) {
            var offcanvas = bootstrap.Offcanvas.getInstance(myModalEl);
            if (!offcanvas) {
                offcanvas = new bootstrap.Offcanvas(myModalEl);
            }
            offcanvas.show();
        }
        $("#GRateMethod").text(GRateMethod);
        $("#GCRateMethod").text(GRateMethod);
        var Parameters = {
            EmployeeID: encodeURI(EmployeeID),
            ProjectSiteID: encodeURI(SiteID),
            TimesheetNo: encodeURI(TimesheetID),
            TimesheetAdvisedID: encodeURI(AdviseId),
            RoleID: encodeURI(RoleID),
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetTimesheetInformation", param, false);
        var strhtml = "";
        var added_HolidayClass = '';
        var EmployeeName = "";
        if (strResult && strResult.length > 0) {
            for (var i = 0; i < strResult.length; i++) {
                if (strResult[i].holiday != 0 && strResult[i].holiday != "") {
                    added_HolidayClass = 'lgdHoliday';
                } else {
                    added_HolidayClass = '';
                }
                if (EmployeeName == "") {
                    strhtml += '<tr class="total-row">';
                    strhtml += ' <td colspan="14" class="text-start">' + strResult[i].siteName + '</td>';
                    strhtml += '</tr>';
                    strhtml += '<tr>';
                    strhtml += '<td></td>';
                    strhtml += '<td colspan="13" class="text-start">' + strResult[i].employeeName + '</td>';
                    strhtml += '</tr>';
                }
                if (EmployeeName == "" || EmployeeName == strResult[i].employeeName) {
                    strhtml += '<tr class="' + added_HolidayClass + '">';
                    strhtml += '<td colspan="2"></td>';
                    strhtml += '<td>' + strResult[i].date + '</td>';
                    strhtml += '<td>' + strResult[i].normalHoursHHMM + '</td>';
                    strhtml += '<td>' + formatTimesheetDetailAmount3(strResult[i].normalRate) + '</td>';
                    strhtml += '<td>' + formatTimesheetDetailAmount3(strResult[i].normalBillingTotal) + '</td>';
                    strhtml += '<td>' + strResult[i].extraHoursHHMM + '</td>';
                    strhtml += '<td>' + formatTimesheetDetailAmount3(strResult[i].extraRate) + '</td>';
                    strhtml += '<td>' + formatTimesheetDetailAmount3(strResult[i].extraBillingTotal) + '</td>';
                    strhtml += '<td>' + strResult[i].billableHoursHHMM + '</td>';
                    strhtml += '<td>' + formatTimesheetDetailAmount3(strResult[i].billableTotal) + '</td>';
                    strhtml += '<td>' + strResult[i].nonBillableHoursHHMM + '</td>';
                    strhtml += '<td>' + formatTimesheetDetailAmount3(strResult[i].nonBillableRate) + '</td>';
                    strhtml += '<td>' + formatTimesheetDetailAmount3(strResult[i].nonBillableTotal) + '</td>';
                    strhtml += '</tr>';
                }
                EmployeeName = strResult[i].employeeName;
            }
            $("#bodyTimesheet").html(strhtml);
        } else {
            $("#bodyTimesheet").html('<tr><td colspan="14" class="text-center"><%=MyBase.GetResourceString("A_NoDataAvailable")%></td></tr>');
        }
    }

    function Edit_Timesheet(intTimesheetNo, Fromdate, ToDate, CurrentStatus, ProjectID, isDisabled) {
        showPageLoader();
        OC_OpenTimesheetDetail(intTimesheetNo, Fromdate, ToDate, CurrentStatus, ProjectID, isDisabled);
    }

    function generatetoken() {
        try {
            if (ProjectID != undefined) {
                var generatedtoken = ajaxCall("FA_TimesheetListing_new.aspx/GeneratePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: '<%= Session("intProjectID") %>', EmployeeID: UserID }));
                if (generatedtoken != undefined) {
                    m_CurrentToken = generatedtoken.d;
                }
            }
            return m_CurrentToken
        } catch (ex) { }
    }

    function ajaxCall(url, type, contentType, dataType, data) {
        var ajaxResult;
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            async: false,
            dataType: "json",
            contentType: "application/json;charset-utf=8",
            success: function (data) {
                ajaxResult = data;
            },
            error: function (err) {
                console.log(err);
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
            }
        });
        return ajaxResult;
    }

    $("#btnOffPrintExcel").click(function (e) {
        e.preventDefault();
        loadCompanyLogo(function () {
            getLogo(function (logoBase64) {
                var timeSheetID = $("#off_txtPrintTimesheet").val();
                var siteID = $("#off_ddlPrintSite").val();
                var empID = $("#off_ddlPrintEmployee").val();
                siteID = (siteID === "All" || siteID === null) ? 0 : siteID;
                empID = (empID === "All" || empID === null) ? 0 : empID;
                var payload = {
                    timeSheetID: parseInt(timeSheetID),
                    siteID: isNaN(parseInt(siteID)) ? 0 : parseInt(siteID),
                    employeeID: isNaN(parseInt(empID)) ? 0 : parseInt(empID),
                    CompanyLogo: logoBase64 || ""
                };
                DownloadExcelFile("/api/ProjectTimesheetApproval/export-resource-wise-excel", payload);
            });
        });
    });

    // Virtual directory for /Images/... logo URL (same as PM_ReportUIBuilder.aspx)
    var directory = '<%=System.Configuration.ConfigurationManager.AppSettings("VirtualDirectoryName").ToString%>';
    var strCompanyLogo = "";
    function loadCompanyLogo(callback) {

        var fullUrl = buildApiUrl("/api/PM_EarnedValueReport/GetCompanyLogo") ;

        $.ajax({
            url: fullUrl,
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({}),
            beforeSend: function (xhr) {
                           // showLoader();
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                        },

            success: function (data) {

                if (data) {
                    strCompanyLogo = data.systemFileName || data.SystemFileName || "";
                }

                callback();
            },

            error: function () {

                console.log("Logo load failed");

                callback();
            }
        });
    }

    function getLogo(callback) {

        let logoName = strCompanyLogo;

        if (!logoName) {
            callback(""); // No logo
            return;
        }

        var logoUrl;
        // typeof is safe if directory were ever missing; avoids ReferenceError breaking the download flow
        if (typeof directory !== "undefined" && directory && directory !== "null") {
            logoUrl = window.location.origin + "/" + directory + "/Images/" + logoName;
        }
        else {
            logoUrl = window.location.origin + "/Images/" + logoName;
        }

        fetch(logoUrl)
            .then(res => {

                if (!res.ok) {
                    console.log("Logo not found");
                    callback("");
                    return null;
                }

                return res.blob();
            })
            .then(blob => {

                if (!blob) return;

                if (blob.size === 0) {
                    callback("");
                    return;
                }

                var reader = new FileReader();

                reader.onloadend = function () {
                    callback(reader.result || "");
                };

                reader.readAsDataURL(blob);

            })
            .catch(err => {

                console.log("Logo fetch error:", err);

                callback("");
            });
    }

    function DownloadExcelFile(url, payload) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", buildApiUrl(url), true);
        xhr.responseType = "blob";
        xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
        xhr.onload = function () {
            if (this.status === 200) {
                var blob = this.response;
                var fileName = "ResourceWise_Excel.xlsx";
                var disposition = xhr.getResponseHeader('Content-Disposition');
                if (disposition && disposition.indexOf('attachment') !== -1) {
                    var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = filenameRegex.exec(disposition);
                    if (matches != null && matches[1]) {
                        fileName = matches[1].replace(/['"]/g, '');
                    }
                }
                var downloadLink = document.createElement('a');
                var url = window.URL.createObjectURL(blob);
                downloadLink.href = url;
                downloadLink.download = fileName;
                document.body.appendChild(downloadLink);
                downloadLink.click();
                document.body.removeChild(downloadLink);
                window.URL.revokeObjectURL(url);
            } else {
                console.error("Download failed", this.status);
                alertify.error("<%=MyBase.GetResourceString("A_DownloadFailed")%>");
            }
        };
        xhr.onerror = function () {
            alertify.error("<%=MyBase.GetResourceString("A_NetworkError")%>");
        };
        xhr.send(JSON.stringify(payload));
    }

    $("#btnOffPrintPdf").click(function (e) {
        e.preventDefault();
        loadCompanyLogo(function () {
            getLogo(function (logoBase64) {
                var timeSheetID = $("#off_txtPrintTimesheet").val();
                var siteID = $("#off_ddlPrintSite").val();
                var empID = $("#off_ddlPrintEmployee").val();
                siteID = (siteID === "All" || siteID === null) ? 0 : siteID;
                empID = (empID === "All" || empID === null) ? 0 : empID;
                var payload = {
                    timeSheetID: parseInt(timeSheetID),
                    siteID: isNaN(parseInt(siteID)) ? 0 : parseInt(siteID),
                    employeeID: isNaN(parseInt(empID)) ? 0 : parseInt(empID),
                    CompanyLogo: logoBase64 || ""
                };
                DownloadPdfFile("/api/ProjectTimesheetApproval/export-resource-wise-pdf", payload);
            });
        });
    });
    //Added by Aditya J. on 02-04-2026 for company logo
    //$("#btnOffPrintPdf").click(async function (e) {
    //    e.preventDefault();

    //    var timeSheetID = $("#off_txtPrintTimesheet").val();
    //    var siteID = $("#off_ddlPrintSite").val();
    //    var empID = $("#off_ddlPrintEmployee").val();

    //    siteID = (siteID === "All" || siteID === null) ? 0 : siteID;
    //    empID = (empID === "All" || empID === null) ? 0 : empID;

    //    // Step 1: Load logo name
    //    await loadCompanyLogo();

    //    // Step 2: Get Base64 logo
    //    var logoBase64 = await getLogo();

    //    var payload = {
    //        timeSheetID: parseInt(timeSheetID),
    //        siteID: isNaN(parseInt(siteID)) ? 0 : parseInt(siteID),
    //        employeeID: isNaN(parseInt(empID)) ? 0 : parseInt(empID),
    //        CompanyLogo: logoBase64
    //    };

    //    // Step 3: Call API
    //    DownloadPdfFile("/api/ProjectTimesheetApproval/export-resource-wise-pdf", payload);
    //});
//End of Added by Aditya J. on 02-04-2026 for company logo

    //Added by Aditya J. on 02-04-2026 for company logo
    <%--let strCompanyLogo = "";

    var directory = '<%=System.Configuration.ConfigurationManager.AppSettings("VirtualDirectoryName").ToString%>';--%>

    //Added by Aditya J. on 02-04-2026 for company logo
    //function loadCompanyLogo() {
    //    alert('1');

    //    return new Promise((resolve) => {

    //        var fullUrl = strUrl + "api/ProjectTimesheetApproval/GetCompanyLogo";

    //        $.ajax({
    //            url: fullUrl,
    //            type: "POST",
    //            contentType: "application/json",
    //            data: JSON.stringify({}),
    //            beforeSend: function (xhr) {
    //                showLoader();
    //                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
    //            },
    //            success: function (data) {

    //                if (data && data.systemFileName) {
    //                    strCompanyLogo = data.systemFileName;
    //                }

    //                resolve(); // ✅ continue flow
    //            },
    //            error: function () {
    //                resolve(); // ✅ still continue
    //            }
    //        });
    //    });
    //}
//End of Added by Aditya J. on 02-04-2026 for company logo

    //Added by Aditya J. on 02-04-2026 for company logo
    //function getLogo() {
        

    //    return new Promise((resolve) => {

    //        let logoName = strCompanyLogo;

    //        if (!logoName) {
    //            resolve("");
    //            return;
    //        }

    //        var logoUrl;

    //        if (directory && directory !== "null") {
    //            logoUrl = window.location.origin + "/" + directory + "/Images/" + logoName;
    //        } else {
    //            logoUrl = window.location.origin + "/Images/" + logoName;
    //        }

    //        fetch(logoUrl)
    //            .then(res => {
    //                if (!res.ok) {
    //                    resolve("");
    //                    return null;
    //                }
    //                return res.blob();
    //            })
    //            .then(blob => {

    //                if (!blob || blob.size === 0) {
    //                    resolve("");
    //                    return;
    //                }

    //                var reader = new FileReader();

    //                reader.onloadend = function () {
    //                    resolve(reader.result || "");
    //                };

    //                reader.readAsDataURL(blob);
    //            })
    //            .catch(() => {
    //                resolve("");
    //            });
    //    });
    //}
//End of Added by Aditya J. on 02-04-2026 for company logo
    //End of added by Aditya J. on 02-04-2026 for company logo

    function DownloadPdfFile(url, payload) {
        var xhr = new XMLHttpRequest();
        if (url.endsWith("/")) {
            url = url.slice(0, -1);
        }
        xhr.open("POST", buildApiUrl(url), true);
        xhr.responseType = "blob";
        xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
        xhr.onload = function () {
            if (this.status === 200) {
                var blob = this.response;
                var fileName = "ResourceWise_Report.pdf";
                var disposition = xhr.getResponseHeader('Content-Disposition');
                if (disposition && disposition.indexOf('attachment') !== -1) {
                    var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = filenameRegex.exec(disposition);
                    if (matches != null && matches[1]) {
                        fileName = matches[1].replace(/['"]/g, '');
                    }
                }
                var downloadLink = document.createElement('a');
                var url = window.URL.createObjectURL(blob);
                downloadLink.href = url;
                downloadLink.download = fileName;
                document.body.appendChild(downloadLink);
                downloadLink.click();
                document.body.removeChild(downloadLink);
                window.URL.revokeObjectURL(url);
            } else {
                console.error("Download failed", this.status);
                alertify.error("<%=MyBase.GetResourceString("A_DownloadFailed")%>");
            }
        };
        xhr.onerror = function () {
            alertify.error("<%=MyBase.GetResourceString("A_NetworkError")%>");
        };
        xhr.send(JSON.stringify(payload));
    }

    var g_BulkActionFlag = 0;
    /** True when BulkPreviewModal was opened from Billing Information (keep offcanvas open until submit succeeds). */
    var g_BulkActionFromBilling = false;

    function OpenBulkPreview(actionFlag) {
        g_BulkActionFromBilling = false;
        if (!hasSelection()) {
            var msg = (actionFlag === 1) ? resourceKeys.SelectTimesheetsForApprove : resourceKeys.SelectTimesheetsForReject;
            alertify.error(msg);
            return;
        }


        g_BulkActionFlag = actionFlag;
        var title = (actionFlag === 1) ? "<%=MyBase.GetResourceString("C_BulkApprovePreview")%>" : "<%=MyBase.GetResourceString("C_BulkRejectPreview")%>";
        var btnClass = (actionFlag === 1) ? "btnyellow" : "btn-danger";
        var btnText = (actionFlag === 1) ? "<%=MyBase.GetResourceString("C_ConfirmApprove")%>" : "<%=MyBase.GetResourceString("C_ConfirmReject")%>";
        $("#bulkModalTitle").text(title);
        $("#btn_BulkSubmit").text(btnText).removeClass("btnyellow btn-danger").addClass(btnClass);
        $("#lblBulkMandatory").show();
        $("#bulkListBody").html("");
        $("#bulkModalSummary").text("<%=MyBase.GetResourceString("A_FetchingList")%>");
        FetchBulkList(actionFlag);
    }

    function FetchBulkList(flag) {
        if (typeof StartLoader === 'function') StartLoader('#bodyPreloader');
        try {
            var fromDate = toISODate($("#txtFromDate").val());
            var toDate = toISODate($("#txtToDate").val());
            var projectID = $("#ddlProject").val();

            // Build default comment for Approve
            var defaultComment = "";
            if (flag === 1) {
                var today = new Date();
                var day = ("0" + today.getDate()).slice(-2);
                var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                defaultComment = "Approved On " + day + "-" + months[today.getMonth()] + "-" + today.getFullYear();
            }

            if (projectID === "0" || projectID === "") projectID = 0;
            var includeTSNos = null;
            var excludeTSNos = null;
            if (g_SelectAllActive) {
                if (g_ExplicitlyDeselected.length > 0) {
                    excludeTSNos = g_ExplicitlyDeselected.join(',');
                }
            } else {
                if (g_ExplicitlySelected.length > 0) {
                    includeTSNos = g_ExplicitlySelected.join(',');
                }
            }
            if (!includeTSNos && !excludeTSNos && !g_SelectAllActive) {
                var msg = (flag === 1) ? resourceKeys.SelectTimesheetsForApprove : resourceKeys.SelectTimesheetsForReject;
                alertify.error(msg);
                return;
            }
            var requestObj = {
                bulkActionFlag: flag,
                empID: parseInt(UserID),
                fromDate: fromDate,
                toDate: toDate,
                projectID: parseInt(projectID),
                includeTSNos: includeTSNos,
                excludeTSNos: excludeTSNos,
                intFlag: parseInt($("#ddlStatus").val() || 0)
            };
            var param = JSON.stringify(requestObj);
            var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetBulkApproveRejectList", param, false);
            var list = strResult;
            if (strResult && strResult.data) list = strResult.data;
            if (!Array.isArray(list)) list = [];
            var html = "";
            var validIds = [];
            var errorMessages = [];
            if (list.length > 0) {
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var isSuccess = (item.isSuccess === 1 || item.isSuccess === true || item.isSuccess === "1" || item.isSuccess === "true");
                    if (isSuccess) {
                        validIds.push(item.timeSheetNo);
                        var fDate = item.fromDate ? formatDate(item.fromDate) : "";
                        var tDate = item.toDate ? formatDate(item.toDate) : "";
                        var rowProjectID = item.projectID || item.ProjectID || projectID || 0;
                        html += "<tr data-tsid='" + item.timeSheetNo + "' data-projectid='" + rowProjectID + "'>";
                        html += "<td class='text-center align-middle fw-bold text-primary'>" + item.timeSheetNo + "</td>";
                        html += "<td class='text-center align-middle'>" + fDate + "</td>";
                        html += "<td class='text-center align-middle'>" + tDate + "</td>";
                        html += "<td class='p-2'>";
                        html += "<textarea class='form-control row-comment' data-tsid='" + item.timeSheetNo + "' rows='2' placeholder='<%=MyBase.GetResourceString("C_EnterComment")%>' maxlength='500'>"+ defaultComment +"</textarea>";
                        html += "<div class='text-danger small comment-error' style='display:none;'><i class='fas fa-exclamation-circle'></i> <%=MyBase.GetResourceString("A_CommentRequired")%></div>";
                        html += "</td>";
                        html += "</tr>";
                    } else {
                        alertify.error(item.valMsg);
                        return;
                    }
                }
                if (errorMessages.length > 0) {
                    errorMessages.forEach(function (msg) { alertify.error(msg); });
                    return;
                }
                if (validIds.length > 0) {
                    $("#hdnBulkIds").val(validIds.join(","));
                    $("#btn_BulkSubmit").prop("disabled", false);
                    $("#bulkModalSummary").text("<%=MyBase.GetResourceString("A_FoundEligibleTimesheets")%>".replace('{0}', validIds.length));
                } else {
                    $("#hdnBulkIds").val("");
                    $("#btn_BulkSubmit").prop("disabled", true);
                    $("#bulkModalSummary").text("<%=MyBase.GetResourceString("A_NoEligibleTimesheets")%>");
                }
            } else {
                $("#bulkModalSummary").text("<%=MyBase.GetResourceString("A_NoRecordsFound")%>");
                $("#hdnBulkIds").val("");
                $("#btn_BulkSubmit").prop("disabled", true);
            }
            $("#bulkListBody").html(html || "<tr><td colspan='4' class='text-center text-muted'><%=MyBase.GetResourceString("A_NoTimesheetsToDisplay")%></td></tr>");
            var myModal = new bootstrap.Modal(document.getElementById('BulkPreviewModal'));
            myModal.show();
        } catch (e) {
            console.error("Error in FetchBulkList:", e);
            alertify.error("<%=MyBase.GetResourceString("A_ErrorFetchingBulkList")%>");
        } finally {
            if (typeof StopAjaxLoader === 'function') StopAjaxLoader('#bodyPreloader');
        }
    }

    function SubmitBulkAction() {
        try {
            $('[data-bs-toggle="tooltip"]').each(function () {
                var inst = bootstrap.Tooltip.getInstance(this);
                if (inst) inst.hide();
            });
            $('.tooltip').remove();
        } catch (e) { }
        //debugger;
        var rows = $("#bulkListBody tr");
        if (rows.length === 0) {
            alertify.error(resourceKeys.NoTimesheetsToProcess);
            return;
        }
        var submissions = [];
        var isValid = true;
        rows.each(function () {
            var $row = $(this);
            var tsId = $row.data("tsid");
            var projectID = $row.data("projectid") || 0;
            var $comment = $row.find(".row-comment");
            var comment = $comment.val().trim();
            var $errorDiv = $row.find(".comment-error");
            if (comment === "") {
                //$errorDiv.show();
                isValid = false;
            } else {
                $errorDiv.hide();
                submissions.push({ timesheetNo: tsId, comment: comment, projectID: projectID });
            }
        });
        if (!isValid) {
            alertify.error(resourceKeys.CommentsRequiredForReject);
            return;
        }
        if (submissions.length === 0) {
            alertify.error(resourceKeys.NoValidTimesheets);
            return;
        }
        $("#btn_BulkSubmit").prop("disabled", true).text("<%=MyBase.GetResourceString("C_Processing")%>");
        var successCount = 0;
        var failCount = 0;
        var total = submissions.length;
        var completed = 0;
        var successfulItems = [];
        submissions.forEach(function (item) {
            var url = "";
            var requestObj = {};
            if (g_BulkActionFlag === 1) {
                url = "/api/ProjectTimesheetApproval/AuthenticateTimesheet";
                requestObj = {
                    TimeSheetNos: item.timesheetNo.toString(),
                    Comments: item.comment,
                    UserName: UserName
                };
            } else {
                url = "/api/ProjectTimesheetApproval/RejectTimesheet";
                requestObj = {
                    TimeSheetNo: item.timesheetNo.toString(),
                    Comment: item.comment,
                    UserName: UserName
                };
            }
            var result = AJAXCallWithResult(url, JSON.stringify(requestObj), false);
            var isSuccess = false;
            if (result) {
                var res = Array.isArray(result) && result.length > 0 ? result[0] : result;
                var status = res.status;
                var msg = (res.result || res.message || "").toString();
                isSuccess = (status === "SUCCESS" || status === true) ||
                    (msg && (msg.toLowerCase().indexOf("success") !== -1 || msg === "Update successfully" || msg === "Updated Successfully"));
            }
            if (isSuccess) {
                successfulItems.push(item);
                successCount++;
            } else {
                failCount++;
            }
            completed++;
            if (completed === total) {
                $("#btn_BulkSubmit").prop("disabled", false).text(g_BulkActionFlag === 1 ? "<%=MyBase.GetResourceString("C_ConfirmApprove")%>" : "<%=MyBase.GetResourceString("C_ConfirmReject")%>");
                var modalEl = document.getElementById('BulkPreviewModal');
                var modal = bootstrap.Modal.getInstance(modalEl);
                if (modal) modal.hide();
                if (successCount > 0 && g_BulkActionFromBilling) {
                    g_BulkActionFromBilling = false;
                    try {
                        ['offcanvas_BillingInfo', 'billine_info_details'].forEach(function (id) {
                            var el = document.getElementById(id);
                            if (!el) return;
                            var inst = bootstrap.Offcanvas.getInstance(el) || bootstrap.Offcanvas.getOrCreateInstance(el);
                            if (inst) inst.hide();
                        });
                    } catch (ex) { }
                }
                if (successCount > 0) {
                    var templateMsg = (g_BulkActionFlag === 1
                        ? "<%=MyBase.GetResourceString("A_TimesheetsApproved")%>"
                        : "<%=MyBase.GetResourceString("A_TimesheetsRejected")%>");
                    var finalMsg = templateMsg || "";
                    if (finalMsg.indexOf("{0}") !== -1) {
                        finalMsg = finalMsg.replace(/\{0\}/g, "").replace(/\s{2,}/g, " ").trim();
                    }
                    alertify.success(finalMsg);
                    setTimeout(function () {
                        startEmailQueue(successfulItems, g_BulkActionFlag);
                    }, 600);
                } else {
                    setTimeout(RefreshTimesheetGridOnly, 1000);
                }
                if (failCount > 0) {
                    alertify.error("<%=MyBase.GetResourceString("A_Failed")%>. <%=MyBase.GetResourceString("A_CheckIndividualTimesheets")%>");
                }
            }
        });
    }

    //helper function to check if checkbox is selected for approve/ reject
    function hasSelection() {
        var enabledIds = [];
        $('.ts-checkbox:not(:disabled)').each(function () {
            enabledIds.push($(this).val());
        });
        if (enabledIds.length === 0) return false;
        if (g_SelectAllActive) {
            // In Select All mode, all enabled rows are considered selected
            return true;
        } else {
            return g_ExplicitlySelected.length > 0;
        }
    }

    var emailQueue = [];
    var isEmailModalOpen = false;

    function startEmailQueue(items, actionFlag) {
        emailQueue = items.map(function (item) {
            return {
                timesheetNo: item.timesheetNo,
                comment: item.comment,
                projectID: item.projectID,
                messageID: (actionFlag === 1) ? 6 : 442
            };
        });
        processNextEmail();
    }

    function processNextEmail() {
        if (emailQueue.length === 0) {
            alertify.success(resourceKeys.EmailsProcessedRefreshing);
            setTimeout(RefreshTimesheetGridOnly, 1500);
            return;
        }
        var current = emailQueue.shift();
        fetchEmailData(current);
    }

    function fetchEmailData(item) {
        var param = JSON.stringify({
            employeeID: parseInt(UserID),
            timeSheetNo: item.timesheetNo,
            projectID: item.projectID,
            messageID: item.messageID
        });
        var result = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetDataForEmail", param, false);
        if (result && result.data) {
            result = result.data;
        }
        var emailMsgArr = result && (result.emailMessageEntity || result.EmailMessageEntity);
        if (!result || !emailMsgArr || !emailMsgArr[0]) {
            alertify.error(resourceKeys.FailedLoadEmailTemplate.replace('{0}', item.timesheetNo));
            processNextEmail();
            return;
        }
        var emailMsg = emailMsgArr[0];
        var recipientArr = result.timesheetRecipientInfoResponse || result.TimesheetRecipientInfoResponse;
        var recipientInfo = (recipientArr && recipientArr[0]) ? recipientArr[0] : {};
        var employeeList = result.employeeEmailEntity || result.EmployeeEmailEntity || [];
        var toEmails = [];
        var firstEmployeeName = "";
        if (employeeList.length > 0) {
            firstEmployeeName = employeeList[0].employeeName || employeeList[0].EmployeeName || "";
            for (var i = 0; i < employeeList.length; i++) {
                var em = employeeList[i].emailID || employeeList[i].EmailID;
                if (em && em.trim()) toEmails.push(em.trim());
            }
        }
        var toEmail = toEmails.join(", ");
        var subject = emailMsg.subject || emailMsg.Subject || "";
        var body = emailMsg.body || emailMsg.Body || "";
        var projectName = recipientInfo.projectName || recipientInfo.ProjectName || "";
        var timesheetNoStr = (recipientInfo.timesheetNo != null && recipientInfo.timesheetNo !== undefined) ? String(recipientInfo.timesheetNo) : (item.timesheetNo != null ? String(item.timesheetNo) : "");
        var fromDateStr = formatDateForEmail(recipientInfo.fromDate || recipientInfo.FromDate) || "";
        var toDateStr = formatDateForEmail(recipientInfo.toDate || recipientInfo.ToDate) || "";
        subject = subject.replace(/<PROJECT_NAME>/g, projectName);
        body = body.replace(/<PROJECT_NAME>/g, projectName);
        subject = subject.replace(/<TIMESHEET_NO>/g, timesheetNoStr);
        body = body.replace(/<TIMESHEET_NO>/g, timesheetNoStr);
        body = body.replace(/<START_DATE>/g, fromDateStr);
        body = body.replace(/<END_DATE>/g, toDateStr);
        body = body.replace(/<COMMENTS>/g, item.comment || "");
        body = body.replace(/<SENDER_NAME>/g, UserName || "");
        body = body.replace(/<NAME>/g, firstEmployeeName);
        var fromEmail = (recipientInfo.fromEmail || recipientInfo.FromEmail || result.senderEmail || result.SenderEmail || result.fromEmail || result.FromEmail) || "";
        var sendMail = emailMsg.sendMail === true || emailMsg.SendMail === true;
        var showPopup = emailMsg.showPopup === true || emailMsg.ShowPopup === true;
        var emailData = {
            timesheetNo: item.timesheetNo,
            fromEmail: fromEmail,
            toEmail: toEmail,
            ccEmail: fromEmail,
            subject: subject,
            body: body,
            showPopup: showPopup
        };
        if (!sendMail) {
            processNextEmail();
            return;
        }
        if (showPopup) {
            showTimesheetEmailModal(emailData);
        } else {
            sendTimesheetEmailDirect(emailData, false);
            processNextEmail();
        }
    }

    function showTimesheetEmailModal(emailData) {
        $("#sendTimesheetEmailFrom").val(emailData.fromEmail);
        $("#sendTimesheetEmailTo").val(emailData.toEmail);
        $("#sendTimesheetEmailCC").val(emailData.ccEmail);
        $("#sendTimesheetEmailSubject").val(emailData.subject);
        $("#sendTimesheetEmailBody").val(emailData.body);
        $("#sendTimesheetEmailBtn").data("emailData", emailData);
        var modal = new bootstrap.Modal(document.getElementById('SendTimesheetEmailModal'));
        modal.show();
        isEmailModalOpen = true;
        $('#SendTimesheetEmailModal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
            if (isEmailModalOpen) {
                isEmailModalOpen = false;
                processNextEmail();
            }
        });
    }

    function sendTimesheetEmailFromModal() {
        var emailData = $("#sendTimesheetEmailBtn").data("emailData");
        if (!emailData) return;
        emailData.toEmail = $("#sendTimesheetEmailTo").val().trim();
        emailData.ccEmail = $("#sendTimesheetEmailCC").val().trim();
        emailData.subject = $("#sendTimesheetEmailSubject").val().trim();
        emailData.body = $("#sendTimesheetEmailBody").val().trim();
        if (!emailData.toEmail || !emailData.subject || !emailData.body) {
            alertify.error(resourceKeys.EmailMandatoryFields);
            return;
        }
        var success = sendTimesheetEmailDirect(emailData, false);
        if (success) {
            alertify.success(resourceKeys.EmailSentSuccess);
        } else {
            alertify.error(resourceKeys.EmailSendFailed.replace('{0}', emailData.timesheetNo));
        }
        var modal = bootstrap.Modal.getInstance(document.getElementById('SendTimesheetEmailModal'));
        if (modal) modal.hide();
        isEmailModalOpen = false;
        processNextEmail();
    }

    function sendTimesheetEmailDirect(emailData, showAlert) {
        var rawBody = emailData.body;
        var htmlBody = "<html><body style='font-family: Arial, Helvetica, sans-serif; font-size:12px; color:#000;'>" +
            rawBody.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>") +
            "</body></html>";
        var payload = {
            toEmailID: emailData.toEmail,
            ccEmailID: emailData.ccEmail || "",
            fromEmailID: emailData.fromEmail || "",
            subject: emailData.subject,
            body: htmlBody
        };
        var result = AJAXCallWithResult("/api/ProjectTimesheetApproval/SendTimesheetEmail", JSON.stringify(payload), false);
        var success = !!(result && (result.status === true || result.status === "true"));
        if (showAlert) {
            if (success) {
                alertify.success(resourceKeys.EmailSentSuccess);
            } else {
                var errMsg = (result && (result.message || result.Message)) ? (result.message || result.Message) : "<%=MyBase.GetResourceString("A_UnknownError")%>";
                alertify.error(resourceKeys.EmailSendFailed.replace('{0}', emailData.timesheetNo) + " " + errMsg);
            }
        }
        return success;
    }

    function formatDateForEmail(dateString) {
        if (!dateString) return "";
        var d = new Date(dateString);
        if (isNaN(d.getTime())) return dateString;
        var day = ("0" + d.getDate()).slice(-2);
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var month = months[d.getMonth()];
        var year = d.getFullYear();
        return day + "-" + month + "-" + year;
    }

    function BillingOffcanvas_Action(actionFlag) {
        g_BulkActionFlag = actionFlag;
        var title = (actionFlag === 1) ? "<%=MyBase.GetResourceString("C_ApproveTimesheet")%>" : "<%=MyBase.GetResourceString("C_RejectTimesheet")%>";
        var btnClass = (actionFlag === 1) ? "btnyellow" : "btn-danger";
        var btnText = (actionFlag === 1) ? "<%=MyBase.GetResourceString("C_ConfirmApprove")%>" : "<%=MyBase.GetResourceString("C_ConfirmReject")%>";
        $("#bulkModalTitle").text(title);
        $("#btn_BulkSubmit").text(btnText).removeClass("btnyellow btn-danger").addClass(btnClass);
        $("#lblBulkMandatory").show();
        $("#bulkListBody").html("");


        // Build default comment for Approve
        var defaultComment = "";
        if (actionFlag === 1) {
            var today = new Date();
            var day = ("0" + today.getDate()).slice(-2);
            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            defaultComment = "Approved On " + day + "-" + months[today.getMonth()] + "-" + today.getFullYear();
        }


        var tsId = ProjectTimesheetID;
        var projectID = ProjectID;
        var fromDate = $("#billingfromdate").text() || "";
        var toDate = $("#billingTodate").text() || "";
        var html = "";
        html += "<tr data-tsid='" + tsId + "' data-projectid='" + projectID + "'>";
        html += "<td class='text-center align-middle fw-bold text-primary'>" + tsId + "</td>";
        html += "<td class='text-center align-middle'>" + fromDate + "</td>";
        html += "<td class='text-center align-middle'>" + toDate + "</td>";
        html += "<td class='p-2'>";
        html += "<textarea class='form-control row-comment' data-tsid='" + tsId + "' rows='2' placeholder='<%=MyBase.GetResourceString("C_EnterComment")%>'  maxlength='500'>" + defaultComment +"</textarea>";
        html += "<div class='text-danger small comment-error' style='display:none;'><i class='fas fa-exclamation-circle'></i> <%=MyBase.GetResourceString("A_CommentRequired")%></div>";
        html += "</td>";
        html += "</tr>";
        $("#bulkListBody").html(html);
        $("#hdnBulkIds").val(tsId.toString());
        $("#bulkModalSummary").text("<%=MyBase.GetResourceString("C_TimesheetNo")%>: " + tsId);
        $("#btn_BulkSubmit").prop("disabled", false);
        g_BulkActionFromBilling = true;
        /* Keep Billing offcanvas visible; show preview modal on top (same pattern as Timesheet Detail + OC_ActionModal). */
        var myModal = new bootstrap.Modal(document.getElementById('BulkPreviewModal'));
        myModal.show();
    }

    function LoadPendingAgeingCount() {

        var url = "/api/ProjectTimesheetApproval/GetPendingAgeingCount";
        //var param = null;
        var param = {
            UserID: encodeURI(UserID)
        }
        var param = JSON.stringify(param);
        var result = AJAXCallWithResult(url, param, false);
        if (result && result.data && result.data.PendingAgeingCountEntity.length > 0) {
            var data = result.data.PendingAgeingCountEntity[0];
            $("#FltrCountInbox").text(data.ageingCount);
            $("#FltrCountWatchlist").text(data.pendingCount);
        }
    }

    // =====================================================
    // TIMESHEET DETAIL OFFCANVAS — all logic below
    // mirrors FA_TimesheetDetail.aspx behaviour
    // =====================================================

    // State for the currently open timesheet in the offcanvas
    var OC_TimesheetID   = 0;
    var OC_FromDate      = '';
    var OC_ToDate        = '';
    var OC_Status        = '';
    var OC_ProjectID_det = 0;
    var OC_g_CurrentAction = '';
    var OC_GInvoiceExists  = false;
    var OC_IsDisabled      = false;
    var OC_IsOnchange      = 0;

    // -- Entry point called by Edit_Timesheet() ------------------------------
    function OC_OpenTimesheetDetail(tsNo, fromDate, toDate, currentStatus, projID, isDisabled) {
        // Store state
        OC_TimesheetID   = tsNo;
        OC_FromDate      = fromDate;
        OC_ToDate        = toDate;
        OC_Status        = currentStatus;
        OC_ProjectID_det = projID;
        OC_GInvoiceExists  = false;
        OC_IsDisabled      = (isDisabled === true);
        OC_IsOnchange      = 0;

        // Reset UI to loading state
        //$('#oc_ProjectTimesheetDetails').html(
        //    '<tr><td colspan="5" class="text-center text-muted py-4"><i class="fas fa-spinner fa-spin me-2"></i>Loading...</td></tr>'
        //);
        $('#oc_SpnTimesheetID').text(tsNo);
        $('#oc_ProjectFromdate').text(fromDate);
        $('#oc_ProjectTodate').text(toDate);
        OC_SetStatusText(currentStatus);
        OC_UpdateButtonVisibility(currentStatus);

        // Destroy old selectpicker instance before clearing so it reinitialises cleanly
        try {
            if ($.fn.selectpicker) $('#oc_select_emp').selectpicker('destroy');
        } catch(e) {}
        $('#oc_select_emp').empty();

        // Open the offcanvas
        var el = document.getElementById('offcanvas_TimesheetDetail');
        var oc = bootstrap.Offcanvas.getOrCreateInstance(el);

        // Load data AFTER offcanvas is fully visible (guarantees correct selectpicker sizing)
        $(el).off('shown.bs.offcanvas.tsdetail').on('shown.bs.offcanvas.tsdetail', function () {
            OC_GetEmployeeDetails();
            OC_ViewProjectTimesheet();
            OC_CheckInvoiceExists();
        });

        oc.show();
    }

    // -- Status text + colour ------------------------------------------------
    function OC_SetStatusText(status) {
        var $el = $('#oc_ProjectTimesheetStatus');
        $el.text(status);
        if (status === 'Rejected') {
            $el.css('color', 'red');
        } else if (status === 'Approved') {
            $el.css('color', 'green');
        } else {
            $el.css('color', '#856404');   // amber for Ready For Approval / Pending
        }
    }

    // -- Button visibility (mirrors UpdateButtonVisibility in detail page) ---
    function OC_UpdateButtonVisibility(status) {
        $('#oc_btn_authenticate').hide();
        $('#oc_btn_reject').hide();
        $('#oc_btn_view_comment').hide();

        if (OC_GInvoiceExists) return;   // already invoiced — hide everything

        if (status === 'Rejected') {
            $('#oc_btn_view_comment').show();
        } else if (status === 'Approved') {
            $('#oc_btn_view_comment').show();
            if (!OC_IsDisabled) $('#oc_btn_reject').show();
        } else {
            // Pending / Ready For Approval / Submitted
            $('#oc_btn_authenticate').show();
            $('#oc_btn_reject').show();
        }
    }

    // -- Invoice existence check ---------------------------------------------
    function OC_CheckInvoiceExists() {
        var param = JSON.stringify({ TimesheetID: parseInt(OC_TimesheetID) });
        var result = AJAXCallWithResult('/api/ProjectTimesheetApproval/IsInvoiceExistsForProjectTimesheet', param, false);
        if (result && result.isExist !== undefined) {
            OC_GInvoiceExists = (result.isExist == 1);
        } else {
            OC_GInvoiceExists = false;
        }
        OC_UpdateButtonVisibility(OC_Status);
    }

    // -- Load employee list into the offcanvas dropdown ----------------------
    function OC_GetEmployeeDetails() {
        var param = JSON.stringify({ TimesheetNo: encodeURIComponent(OC_TimesheetID) });
        var result = AJAXCallWithResult('/api/ProjectTimesheetApproval/GetEmployeeDetails', param, false);
        var empList = result && result.employeeDetails;

        var $sel = $('#oc_select_emp');
        $sel.empty();

        if (empList && empList.length > 0) {
            // "All" option so the user can view all employees at once
            $.each(empList, function (i, emp) {
                $sel.append('<option value="' + emp.employeeID + '">' + emp.employeeName + '</option>');
            });
        }

        if ($.fn.selectpicker) $sel.selectpicker('refresh');
    }

    // -- Employee dropdown change --------------------------------------------
    function OC_EmployeeName_onChange() {
        OC_IsOnchange = 1;
        OC_ViewProjectTimesheet();
    }

    // -- Main data fetch + render — mirrors ViewProjectTimesheet() -----------
    function OC_ViewProjectTimesheet() {
        var empID = parseInt($('#oc_select_emp').val()) || 0;
        var param = JSON.stringify({
            TimesheetNo: encodeURIComponent(OC_TimesheetID),
            EmployeeID: empID
        });

        var EmployeeDetails = AJAXCallWithResult('/api/ProjectTimesheetApproval/GetViewProjectTimesheet', param, false);

        var html = '';
        var EmployeeName = '', EmployeeCode = '', EmployeeID = '';
        var ResourceTotal = '', ResourceTotalHHMM = '', EntryDate = '';
        var SelectedTSStatus = '';

        if (EmployeeDetails && EmployeeDetails.length > 0) {
            for (var i = 0; i < EmployeeDetails.length; i++) {
                var row = EmployeeDetails[i];
                SelectedTSStatus = row.timsheetStatus;

                var descText = row.description || '';
                var Description = descText.length > 30 ? descText.slice(0, 30) + '...' : descText;

                // -- New employee group: subtotal for previous + group label row (name in col 1 only) --
                if (EmployeeName === '' || EmployeeName !== row.employeeName) {
                    // Close previous group total row (except on very first row)
                    if (EmployeeName !== '') {
                        html += '<tr class="total-row">';
                        html += '<td colspan="3" class="text-start"><label>Total Actual Work (HH:MM) for <strong>[' + EmployeeCode + '] - ' + EmployeeName + '</strong></label></td>';
                        html += '<td><span class="fl-right"><strong>Total</strong></span></td>';
                        html += '<td><strong>' + ResourceTotalHHMM + '</strong></td>';
                        html += '</tr>';
                    }
                    var grpLabel = (row.employeeCode != null && row.employeeCode !== '')
                        ? '<strong>[' + row.employeeCode + '] - ' + row.employeeName + '</strong>'
                        : '<strong>' + (row.employeeName || '') + '</strong>';
                    html += '<tr class="emp-group-row"><td class="text-start">' + grpLabel + '</td><td></td><td></td><td></td><td></td></tr>';
                }

                // -- Data row --------------------------------------------
                html += '<tr><td></td>';
                // Date — show only when it changes
                if (EntryDate !== row.entryDate) {
                    html += '<td>' + row.entryDate + '</td>';
                } else {
                    html += '<td></td>';
                }
                // Task
                html += '<td class="text-start">' + (row.task || '') + '</td>';
                // Description with tooltip
                if (descText.trim() !== '') {
                    html += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + descText.replace(/"/g, '&quot;') + '">' + Description + '</td>';
                } else {
                    html += '<td>' + Description + '</td>';
                }
                // Hours
                html += '<td>' + row.durationHHMM + '</td>';
                html += '</tr>';

                // -- Last row of entire result — close final group -------
                if (i === EmployeeDetails.length - 1) {
                    html += '<tr class="total-row">';
                    html += '<td colspan="3" class="text-start"><label>Total Actual Work (HH:MM) for <strong>[' + row.employeeCode + '] - ' + row.employeeName + '</strong></label></td>';
                    html += '<td><span class="fl-right"><strong>Total</strong></span></td>';
                    html += '<td><strong>' + row.resourceTotalHHMM + '</strong></td>';
                    html += '</tr>';
                    html += '<tr class="total-row">';
                    html += '<td colspan="4"><span class="fl-right"><strong>Grand Total</strong></span></td>';
                    html += '<td><strong>' + row.grandTotalHHMM + '</strong></td>';
                    html += '</tr>';
                }

                // Update trackers
                EmployeeName     = row.employeeName;
                EmployeeCode     = row.employeeCode;
                EmployeeID       = row.employeeID;
                ResourceTotalHHMM = row.resourceTotalHHMM;
                ResourceTotal    = row.resourceTotal;
                EntryDate        = row.entryDate;
            }
        } else {
            html = '<tr><td colspan="5" class="text-center text-muted py-4">No records found.</td></tr>';
        }

        $('#oc_ProjectTimesheetDetails').html(html);
        $('[data-bs-toggle="tooltip"]').tooltip('dispose').tooltip();
        $('#offcanvas_TimesheetDetail .oc-ts-body').scrollTop(0);
        hidePageLoader();

        // Update status from API data (may differ from what was passed)
        if (SelectedTSStatus) {
            OC_Status = SelectedTSStatus;
            OC_SetStatusText(SelectedTSStatus);
            OC_UpdateButtonVisibility(SelectedTSStatus);
        }
    }

    // -- View Comment --------------------------------------------------------
    function OC_ViewComment_OnClick() {
        try {
            var param = JSON.stringify({ TimeSheetNo: parseInt(OC_TimesheetID) });
            var result = AJAXCallWithResult('/api/ProjectTimesheetApproval/GetTimesheetComments', param, false);
            var commentText = (result && result.comments) ? result.comments : 'No comments found.';
            $('#oc_txtViewCommentArea').val(commentText);
            var modal = new bootstrap.Modal(document.getElementById('OC_ViewCommentModal'));
            modal.show();
        } catch (e) {
            console.error(e);
            alertify.error('Error fetching comments.');
        }
    }

    // -- Open Approve / Reject modal -----------------------------------------
    function OC_OpenActionModal(actionType) {
        OC_g_CurrentAction = actionType;

        // Reset
        $('#oc_mdl_Comment').val('');
        $('#oc_mdl_Error').hide();

        // Populate header row
        $('#oc_mdl_TsID').text(OC_TimesheetID);
        $('#oc_mdl_From').text(OC_FromDate);
        $('#oc_mdl_To').text(OC_ToDate);

        var $btnSubmit = $('#oc_btn_ModalSubmit');
        var $title     = $('#oc_actionModalTitle');

        if (actionType === 'Authenticate') {
            $title.html('Authenticate Timesheet');
            $btnSubmit.text('<%=MyBase.GetResourceString("C_Approve")%>').removeClass('btn-danger').addClass('btnyellow');
            var today = new Date();
            var day   = ('0' + today.getDate()).slice(-2);
            var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            $('#oc_mdl_Comment').val('Approved On ' + day + '-' + months[today.getMonth()] + '-' + today.getFullYear());
            $('#oc_lblMandatory').hide();
        } else {
            $title.html('Reject Timesheet');
            $btnSubmit.text('<%=MyBase.GetResourceString("C_Reject")%>').removeClass('btnyellow').addClass('btn-danger');
            $('#oc_lblMandatory').show();
        }

        var modal = new bootstrap.Modal(document.getElementById('OC_ActionModal'));
        modal.show();
    }

    // -- Submit Approve / Reject ---------------------------------------------
    function OC_SubmitAction() {
        try {
            $('[data-bs-toggle="tooltip"]').each(function () {
                var inst = bootstrap.Tooltip.getInstance(this);
                if (inst) inst.hide();
            });
            $('.tooltip').remove();
        } catch (e) { }
        var comment = $('#oc_mdl_Comment').val().trim();

        if (OC_g_CurrentAction === 'Reject' && comment === '') {
            $('#oc_mdl_Error').show();
            $('#oc_mdl_Comment').focus();
            return;
        }

        try {
            var url, requestObj;

            if (OC_g_CurrentAction === 'Authenticate') {
                url = '/api/ProjectTimesheetApproval/AuthenticateTimesheet';
                requestObj = {
                    TimeSheetNos: OC_TimesheetID.toString(),
                    Comments: comment,
                    UserName: UserName
                };
            } else {
                url = '/api/ProjectTimesheetApproval/RejectTimesheet';
                requestObj = {
                    TimesheetNo: parseInt(OC_TimesheetID),
                    Comment: comment,
                    UserName: UserName
                };
            }

            var strResult = AJAXCallWithResult(url, JSON.stringify(requestObj), false);

            // Close modal
            var modalEl = document.getElementById('OC_ActionModal');
            var modalInst = bootstrap.Modal.getInstance(modalEl);
            if (modalInst) modalInst.hide();

            // Check success
            var isSuccess = false;
            if (strResult) {
                var res = Array.isArray(strResult) && strResult.length > 0 ? strResult[0] : strResult;
                var status = res.status;
                var msgVal = (res.result || res.Result || res.message || '').toString();
                isSuccess = (status === 'SUCCESS' || status === true)
                    || (msgVal && (msgVal.toLowerCase().indexOf('success') !== -1
                        || msgVal === 'Update successfully'
                        || msgVal === 'Updated Successfully'
                        || msgVal === 'Operation completed'));
            }

            if (isSuccess) {
                var newStatus = (OC_g_CurrentAction === 'Authenticate') ? 'Approved' : 'Rejected';
                var msg = (OC_g_CurrentAction === 'Authenticate') ? 'Selected Timesheet(s) Approved Successfully.' : 'Selected Timesheet(s) Rejected Successfully.';
                alertify.success(msg);

                // Update offcanvas UI immediately (no page reload)
                OC_Status = newStatus;
                OC_SetStatusText(newStatus);
                OC_UpdateButtonVisibility(newStatus);

                // Refresh the listing table row status so it stays in sync
                RefreshTimesheetGridOnly();

                // Same email flow as SubmitBulkAction (GetDataForEmail + modal or direct send)
                var ocEmailActionFlag = (OC_g_CurrentAction === 'Authenticate') ? 1 : 2;
                setTimeout(function () {
                    startEmailQueue([{
                        timesheetNo: OC_TimesheetID,
                        comment: comment,
                        projectID: parseInt(OC_ProjectID_det, 10) || 0
                    }], ocEmailActionFlag);
                }, 600);

                // Close edit/billing offcanvas after approve/reject confirmation
                try {
                    ['offcanvas_TimesheetDetail', 'offcanvas_BillingInfo', 'billine_info_details'].forEach(function (id) {
                        var el = document.getElementById(id);
                        if (!el) return;
                        var inst = bootstrap.Offcanvas.getInstance(el) || bootstrap.Offcanvas.getOrCreateInstance(el);
                        if (inst) inst.hide();
                    });
                } catch (e) { }

            } else {
                var errMsg = (strResult && (strResult[0] && strResult[0].result)) ? strResult[0].result : 'Operation Failed.';
                alertify.error(errMsg || 'Update failed.');
            }

        } catch (e) {
            console.error(e);
            alertify.error('An error occurred.');
        }
    }

    // -- Ensure modal backdrops don't block when both offcanvas + modal open -
    $(document).on('show.bs.modal', '#OC_ViewCommentModal, #OC_ActionModal, #BulkPreviewModal', function () {
        // Move modals to body level so z-index stacking works correctly
        $(this).appendTo('body');
    });
</script>
</body>
</html>
<%--End of code added by Vaibhav K on 04-03-26--%>