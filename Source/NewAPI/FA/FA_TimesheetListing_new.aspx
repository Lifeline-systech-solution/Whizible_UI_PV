<%@ Page Language="vb"
    AutoEventWireup="false"
    CodeBehind="FA_TimesheetListing_new.aspx.vb"
    Inherits="Whizible.FA_TimesheetListing_new" %>

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
        #TimesheetTbl{
            font-size: 11px;
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
        #TimesheetTbl.hide-checkbox-column td:last-child {
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
    </style>

    <%--project timesheet code--%>

    <style type="text/css">
        .bootstrap-select>.dropdown-toggle {
            height: 30px;
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
        .fa-times {
            color: red;
        }
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
            background: #e7edf0 !important;
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
             padding: 20px;

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
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
            font-weight: 400;
            width: 80px;
            display: block;
        }
        .remove_row {
            color: red;
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
        }
        .save_row {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
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
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
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
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
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
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
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
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 12.5px;
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
            font-size:11.5px!important;
        }
        #salesPeriodEndDate {
            font-size:11.5px!important;
        }
        #txtInvoiceDate ,#TxtFromDate,#TxtToDate {
            font-size:11.5px!important;
        }
        .billing_info_task_Grid tbody tr td:first-child,
        .billing_info_task_Grid thead tr th:first-child {
            position: sticky;
            left: 0;
            z-index: 10;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
        }
        .billing_info_task_Grid tfoot tr td:first-child {
            position: sticky;
            left: 0;
            background-color: #f9f9f9;
            z-index: 10;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
        }
        .text_color {
            color: #4263c1;
            font-size:10px;
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
            /* Modified By Madhuri.K On 26-03-2026 */
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
            font-size: 12px;
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
            display: flex;
            gap: 5px;
            align-items: center;
            justify-content: flex-start;
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
            display: inline-flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px;
            border-radius: 6px;
            border: 1px solid #ddd;
            background-color: #fff;
            transition: all 0.3s ease;
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
            font-size: 11px;
            font-weight:400;
            color: #333;
            white-space: nowrap;
        }
        .clear-filter-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 12px;
            color: #f51212;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .clear-filter-btn:hover {
            color: #f51212;
            text-decoration: underline;
        }
        .clear-filter-btn img {
            width: 18px;
            height: 18px;
            filter: brightness(0) saturate(100%) invert(23%) sepia(75%) saturate(1516%) hue-rotate(358deg) brightness(102%) contrast(97%);
        }
        .clear-filter-btn:hover img {
            filter: brightness(0) saturate(100%) invert(10%) sepia(70%) saturate(1500%) hue-rotate(359deg) brightness(98%) contrast(101%);
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
        .w_sm_txt{
            font-size: 9px;
        }
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">

<% If m_blnViewAccess = True Then %>

<div class="bgwhite">

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
                            <div class="row">
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
                                    <% CommonFunctions.HTMLControls.DrawComboBox("ddlProject", "usp_Whizible2_Sel_FA_ProjectForTimeSheetListing " & Session("intUserId"), , , "class='selectpicker form-control' data-live-search='true'", ,,) %>
                                </div>
                                <div class="col-sm-6 mt-1">
                                    <label class="filter-label"><%=MyBase.GetResourceString("C_FromDate")%></label>
                                    <div class="input-group">
                                        <input type="text" id="txtFromDate" class="form-control" >
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
                                        <input type="text" id="txtToDate" class="form-control" >
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
                            <button type="button" class="btn btn-primary" onclick="SearchTimesheets()">
                                <%=MyBase.GetResourceString("C_Show")%>
                            </button>
                            <span type="button" class="clear-filter-btn" onclick="ClearFilters()" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_ClearFilters")%>">
                                <img src="../../../Whizible2.0-new/dist/img/filter-remove.svg" alt="<%=MyBase.GetResourceString("C_ClearFilters")%>" />
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="col-sm-12 text-center mt-0 pe-2">
                        <div class="mb-1" style="display: flex; flex-direction: column;">
                            <div id="ImFltr-Inbox" class="filter-card mb-2" data-bs-toggle="tooltip" data-bs-original-title="<%=MyBase.GetResourceString("C_Pending")%>">
                                <span id="FltrCountInbox" class="filter-count inbox-count">0</span>
                                <span class="filter-label-text pending_text"><%=MyBase.GetResourceString("C_Pending")%></span>
                            </div>
                            <div id="ImFltr-Watchlist" class="filter-card" data-bs-toggle="tooltip" data-bs-original-title="<%=MyBase.GetResourceString("C_AgeingMoreThan10Days")%>">
                                <span id="FltrCountWatchlist" class="filter-count watchlist-count">0</span>
                                <span class="filter-label-text ageing_text"><%=MyBase.GetResourceString("C_AgeingMoreThan10Days")%></span>
                            </div>
                        </div>
                    </div>
                    <div class="mx-1 ps-3 pe-0">
                        <%If m_blnEditAccess = True Then%>
                            <button class="btn btn-success" onclick="OpenBulkPreview(1); return false;">
                                <%=MyBase.GetResourceString("C_Approve")%>
                            </button>
                            <button class="btn btn-danger" onclick="OpenBulkPreview(2); return false;">
                                <%=MyBase.GetResourceString("C_Reject")%>
                            </button>
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
                    <th><%=MyBase.GetResourceString("C_TimesheetHours")%></th>
                    <th><%=MyBase.GetResourceString("C_Status")%></th>
                    <th><%=MyBase.GetResourceString("C_BillingInformation")%></th>
                    <th><%=MyBase.GetResourceString("C_PrintReport")%></th>
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

<!-- ================= OFFCANVAS : TIMESHEET / BILLING ================= -->
<div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="offcanvas_Timesheet">
    <div class="offcanvas-body">
        <div class="graybg py-2 mb-2 d-flex justify-content-between align-items-center">
            <h5 class="pgtitle mb-0 ms-2" id="offcanvasTitle">
                <%=MyBase.GetResourceString("C_TimesheetDetails")%>
            </h5>
            <button class="btn borderbtn me-2" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Back")%></button>
        </div>

        <div id="timesheetPanel">
            <div class="text-end m-2">
                <button class="btn btnyellow"><%=MyBase.GetResourceString("C_Approve")%></button>
                <button class="btn btn-danger"><%=MyBase.GetResourceString("C_Reject")%></button>
                <button class="btn borderbtn" id="btnViewComment">
                    <%=MyBase.GetResourceString("C_ViewComment")%>
                </button>
            </div>

            <table class="table table-bordered table-sm mb-3">
                <tr>
                    <th><%=MyBase.GetResourceString("C_ID")%></th>
                    <th><%=MyBase.GetResourceString("C_ProjectName")%></th>
                    <th><%=MyBase.GetResourceString("C_From")%></th>
                    <th><%=MyBase.GetResourceString("C_To")%></th>
                    <th><%=MyBase.GetResourceString("C_Today")%></th>
                    <th><%=MyBase.GetResourceString("C_Status")%></th>
                </tr>
                <tr>
                    <td>2</td>
                    <td>MS-Dynamics</td>
                    <td>09/01/2025</td>
                    <td>10/05/2025</td>
                    <td>01/01/2026</td>
                    <td><span class="text-success fw-bold"><%=MyBase.GetResourceString("C_Approved")%></span></td>
                </tr>
            </table>

            <table class="table table-bordered table-sm newTblStyle">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_EmployeeDate")%></th>
                        <th><%=MyBase.GetResourceString("C_Taskname")%></th>
                        <th><%=MyBase.GetResourceString("C_Description")%></th>
                        <th><%=MyBase.GetResourceString("C_Hours")%></th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="table-secondary">
                        <td colspan="4"><strong>ADMIN</strong></td>
                    </tr>
                    <tr>
                        <td>09/01/2025</td>
                        <td><%=MyBase.GetResourceString("C_ProfitabilityTask")%></td>
                        <td></td>
                        <td>08:00</td>
                    </tr>
                    <tr>
                        <td>09/02/2025</td>
                        <td><%=MyBase.GetResourceString("C_ProfitabilityTask")%></td>
                        <td></td>
                        <td>08:00</td>
                    </tr>
                    <tr class="table-secondary">
                        <td colspan="3"><strong><%=MyBase.GetResourceString("C_TotalFor")%> ADMIN</strong></td>
                        <td><strong>40:00</strong></td>
                    </tr>
                    <tr class="table-secondary">
                        <td colspan="3"><strong><%=MyBase.GetResourceString("C_GrandTotal")%></strong></td>
                        <td><strong>80:00</strong></td>
                    </tr>
                </tbody>
            </table>
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
                    <div class="col-sm-12">
                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_BillingInformation") %></h5>
                    </div>
                </div>
            </div>
            <div class="row mt-2 mb-2 project_timeperiod">
                <div class="col-sm-12 ">
                    <div class="row">
                        <div class="col-sm-12 text-end">
                            <button class="btn btn-success mx-1" id="btn_authenticate" onclick="BillingOffcanvas_Action(1); return false;">
                                <%=MyBase.GetResourceString("C_Approve")%>
                            </button>
                            <button class="btn btn-danger mx-1" id="btn_reject" onclick="BillingOffcanvas_Action(2); return false;">
                                <%=MyBase.GetResourceString("C_Reject")%>
                            </button>
                            <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                    onclick="closeBillingDetails()" data-bs-toggle="tooltip"
                                    data-bs-container="body" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_Close")%>"
                                    data-bs-dismiss="offcanvas">
                                <%=MyBase.GetResourceString("C_Close") %>
                            </button>
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
                <div class="accordion collapse Init_acordian_panel mb-3 mt-3 show" id="Input_details_accordion">
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
                    <div class="tab-pane active table-responsive" id="Billing_Info_Tab">
                        <div class="BasicDetailsContent">
                            <div id="tbl_billing_info table-responsive" class="init_grid_panel">
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
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>"></button>
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
                            <label class="control-label fw-bold mb-0"><%=MyBase.GetResourceString("C_Timesheet")%></label>
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
                                <option value="0">All</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                        <div class="col-sm-4">
                            <label class="control-label fw-bold mb-0"><%=MyBase.GetResourceString("C_Employee")%></label>
                        </div>
                        <div class="col-sm-8">
                            <select id="off_ddlPrintEmployee" class="form-control selectpicker" data-live-search="true">
                                <option value="0">All</option>
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
                <h5 class="modal-title fw-bold" id="bulkModalTitle"><%=MyBase.GetResourceString("C_BulkActionPreview")%></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body p-0">
                <div class="alert alert-info m-2" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                    <span id="bulkModalSummary"><%=MyBase.GetResourceString("A_FetchingList")%></span>
                </div>
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
                <button type="button" class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
            </div>
        </div>
    </div>
</div>

<!-- Billing Timesheet Details modal -->
<div class="modal custmodal Issuesave_filter fade" id="billine_info_details" tabindex="-1" role="dialog" data-bs-backdrop="static" data-keyboard="false"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl table-responsive" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_TimesheetDetails")%></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
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
                <div class="text-center">
                    <a href="javascript:;" class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close")%></a>
                </div>
            </div>
        </div>
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
    $(document).ready(function () {
        $(document).on('hidden.bs.offcanvas', function () {
            if ($('.offcanvas.show').length === 0) {
                $('.offcanvas-backdrop').remove();
                $('body').removeClass('offcanvas-open');
                if ($('.modal.show').length === 0) {
                    $('body').removeClass('modal-open').css({ 'overflow': '', 'padding-right': '' });
                }
            }
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

        $("#chkSelectAll").on('change', function () {
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


            SearchTimesheets();
            g_CurrentPage = 1;
            g_SelectAllActive = false;
            g_ExplicitlySelected = [];
            g_ExplicitlyDeselected = [];
            $("#ImFltr-ReadyForApproval, #ImFltr-Inbox, #ImFltr-Watchlist").removeClass('active');
            $(this).addClass('active');
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
            SearchTimesheets();
        }, 200);
    });

    // ==========================================
    // DATA RETRIEVAL
    // ==========================================
    function SearchTimesheets() {
        if (!ValidateDateRange('All')) return;
        g_CurrentPage = 1;
        g_SelectAllActive = false;
        g_ExplicitlySelected = [];
        g_ExplicitlyDeselected = [];
        GetTimesheetList();
    }

    function ClearFilters() {
        var firstStatus = $("#ddlStatus option").first().val() || "";
        $("#ddlStatus").val(firstStatus);
        if ($.fn.selectpicker) $("#ddlStatus").selectpicker('refresh');
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
        GetTimesheetList();
    }

    function GetTimesheetList() {
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
                    <td colspan="10" class="text-center">
                        <div class="col-12 text-center py-5">
                            <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                            <h4 class="text-muted">${resourceKeys.NoRecordFound}</h4>
                            <p class="text-muted">${resourceKeys.NoPendingApprovals}</p>
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

    function RenderTimesheetTable(data) {
        var tbody = $('#TimesheetTbl tbody');
        tbody.empty();
        if (!data || data.length === 0) {
            tbody.append(`
                <tr>
                    <td colspan="10" class="text-center">
                        <div class="col-12 text-center py-5">
                            <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                            <h4 class="text-muted">${resourceKeys.NoRecordFound}</h4>
                            <p class="text-muted">${resourceKeys.NoPendingApprovals}</p>
                        </div>
                    </td>
                </tr>
            `);
            return;
        }
        $.each(data, function (index, item) {
            var statusClass = (item.timesheetStatus === "Approved") ? "text-success fw-bold" :
                (item.timesheetStatus === "Rejected") ? "text-danger fw-bold" :
                    (item.timesheetStatus === "Ready For Approval") ? "text-warning fw-bold" : "";
            var disabledAttr = (item.isDisabled === true) ? "disabled" : "";
            var tsId = String(item.timeSheetNo);
            var row = `
                <tr>
                    <td><a href="javascript:void(0);" class="text_underline" onclick="Edit_Timesheet(${item.timeSheetNo}, '${formatDate(item.fromDate)}', '${formatDate(item.toDate)}', '${item.timesheetStatus}', '${item.projectID}')">${item.timeSheetNo}</a></td>
                    <td><span class="date_txt"><div style="display: flex; gap:5px; "><i class="far fa-calendar-alt"></i>${item.createdDate1}</span></div></td>
                    <td class="text-start">${item.projectName}</td>
                    <td><span class="date_txt"><i class="far fa-calendar-alt"></i> ${formatDate(item.fromDate)}</span></td>
                    <td><span class="date_txt"><i class="far fa-calendar-alt"></i> ${formatDate(item.toDate)}</span></td>
                    <td><span class="total_hours"><i class="far fa-clock"></i>${item.totalTimeSheetHours}</span></td>
                    <td class="${statusClass}">${item.timesheetStatus}</td>
                    <td><a href="javascript:void(0);" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_BillingInformation")%>" class="text_underline" onclick="Billing_Information(${item.timeSheetNo}, '${formatDate(item.fromDate)}', '${formatDate(item.toDate)}', '${item.timesheetStatus}', '${item.projectID}', false, ${item.isDisabled === true})"><%=MyBase.GetResourceString("C_BillingInformation")%> <i class="fas fa-info-circle"></i></a></td>
                    <td><a href="javascript:void(0);" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_PrintReport")%>" class="text_underline" onclick="OpenPrintOffcanvas(${item.timeSheetNo}, '${item.projectName}')"><i class="fas fa-print"></i></a></td>
                    <td>
                        <input type="checkbox" class="ts-checkbox form-check-input" value="${tsId}" ${disabledAttr} />
                    </td>
                </tr>`;
            tbody.append(row);
        });
        RenderCheckboxState();
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
        $("#lblTotalRecords").text("<%=MyBase.GetResourceString("C_TotalRecords")%>: " + g_TotalRecords + " | Page: " + g_CurrentPage + " of " + (g_TotalPages || 1));
        $("#btnPrev").prop('disabled', (g_CurrentPage <= 1));
        $("#btnNext").prop('disabled', (g_CurrentPage >= g_TotalPages));
    }

    function ToggleRejectedUI() {
        var selectedStatus = $("#ddlStatus option:selected").text().toLowerCase();
        var isRejected = selectedStatus.indexOf("rejected") > -1;
        if (isRejected) {
            $("#TimesheetTbl").addClass("hide-checkbox-column");
            $(".btn-success[onclick*='OpenBulkPreview(1)']").hide();
            $(".btn-danger[onclick*='OpenBulkPreview(2)']").hide();
        } else {
            $("#TimesheetTbl").removeClass("hide-checkbox-column");
            $(".btn-success[onclick*='OpenBulkPreview(1)']").show();
            $(".btn-danger[onclick*='OpenBulkPreview(2)']").show();
        }
    }

    function ValidateDateRange(triggerSource) {
        var fromDateStr = $("#txtFromDate").val();
        var toDateStr = $("#txtToDate").val();
        var isValid = true;
        if (fromDateStr !== "") {
            try { $.datepicker.parseDate('dd M yy', fromDateStr); }
            catch (e) { alertify.error(resourceKeys.InvalidDateFormat); $("#txtFromDate").val(''); return false; }
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
        $("#off_ddlPrintSite").empty().append('<option value="0">All</option>');
        $("#off_ddlPrintEmployee").empty().append('<option value="0">All</option>');
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

    var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'
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
        $.ajax({
            url: encodeURI(strUrl) + url,
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
        var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_BillingInfo'));
        myOffcanvas.show();
        g_BillingCurrentStatus = CurrentStatus || '';
        g_BillingIsDisabled = isDisabled === true;
        var status = g_BillingCurrentStatus.toLowerCase();
        var $btnApprove = $("#btn_authenticate");
        var $btnReject = $("#btn_reject");
        if (g_BillingIsDisabled || status === 'rejected') {
            $btnApprove.hide();
            $btnReject.hide();
        } else if (status === 'approved') {
            $btnApprove.hide();
            $btnReject.show();
        } else {
            $btnApprove.show();
            $btnReject.show();
        }
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
                strHTML += ' <span class="Curncy iconBlue">(' + (strResult[i].siteCurrency || '') + ')</span>';
            }
            strHTML += '</td>';
            strHTML += '<td class="tdCurrent">';
            strHTML += '<span class="SumDiscount">' + GetChangeFormat(Discount) + '</span>';
            strHTML += '</td>';
            strHTML += '<td><span class="SumFinalAmount">' + GetChangeFormat(FinaLAmount) + '</span></td>';
            strHTML += '</tr>';
        }
        $(".tbody_billing_info").html(strHTML);
        var displayCurrency = strResult.length > 0 ? (strResult[0].siteCurrency || strResult[0].siteCurrencyCode || "") : "";
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
                $("#lblcboRateMethod").text(RateMethod);
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

    function GetTimesheetDetails(EmployeeID, SiteID, TimesheetID, AdviseId, RoleID) {
        var myModalEl = document.getElementById('billine_info_details');
        if (myModalEl) {
            var modal = bootstrap.Modal.getInstance(myModalEl);
            if (!modal) {
                modal = new bootstrap.Modal(myModalEl);
            }
            modal.show();
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
                    var NormalBillingTotal = strResult[i].normalBillingTotal;
                    strhtml += '<tr class="' + added_HolidayClass + '">';
                    strhtml += '<td colspan="2"></td>';
                    strhtml += '<td>' + strResult[i].date + '</td>';
                    strhtml += '<td>' + strResult[i].normalHoursHHMM + '</td>';
                    strhtml += '<td>' + (strResult[i].normalRate || 0) + '</td>';
                    strhtml += '<td>' + NormalBillingTotal + '</td>';
                    strhtml += '<td>' + strResult[i].extraHoursHHMM + '</td>';
                    strhtml += '<td>' + (strResult[i].extraRate || 0) + '</td>';
                    strhtml += '<td>' + (strResult[i].extraBillingTotal || 0) + '</td>';
                    strhtml += '<td>' + strResult[i].billableHoursHHMM + '</td>';
                    strhtml += '<td>' + (strResult[i].billableTotal || 0) + '</td>';
                    strhtml += '<td>' + strResult[i].nonBillableHoursHHMM + '</td>';
                    strhtml += '<td>' + (strResult[i].nonBillableRate || 0) + '</td>';
                    strhtml += '<td>' + (strResult[i].nonBillableTotal || 0) + '</td>';
                    strhtml += '</tr>';
                }
                EmployeeName = strResult[i].employeeName;
            }
            $("#bodyTimesheet").html(strhtml);
        } else {
            $("#bodyTimesheet").html('<tr><td colspan="14" class="text-center"><%=MyBase.GetResourceString("A_NoDataAvailable")%></td></tr>');
        }
    }

    function Edit_Timesheet(intTimesheetNo, Fromdate, ToDate, CurrentStatus, ProjectID) {
        var Token = generatetoken();
        window.location.href = "../FA/FA_TimesheetDetail.aspx?ProjectID=" + ProjectID.toString() + "&TimeSheetNo=" + intTimesheetNo.toString() + "&FromDate=" + Fromdate.toString() + "&ToDate=" + ToDate.toString() + "&CurrentStatus=" + CurrentStatus.toString() + "&PKToken=" + Token.toString() + "&MasterTagID=42&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
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
        var timeSheetID = $("#off_txtPrintTimesheet").val();
        var siteID = $("#off_ddlPrintSite").val();
        var empID = $("#off_ddlPrintEmployee").val();
        siteID = (siteID === "All" || siteID === null) ? 0 : siteID;
        empID = (empID === "All" || empID === null) ? 0 : empID;
        var payload = {
            timeSheetID: parseInt(timeSheetID),
            siteID: isNaN(parseInt(siteID)) ? 0 : parseInt(siteID),
            employeeID: isNaN(parseInt(empID)) ? 0 : parseInt(empID)
        };
        DownloadExcelFile("/api/ProjectTimesheetApproval/export-resource-wise-excel", payload);
    });

    function DownloadExcelFile(url, payload) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", strUrl + url, true);
        xhr.responseType = "blob";
        xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
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
        var timeSheetID = $("#off_txtPrintTimesheet").val();
        var siteID = $("#off_ddlPrintSite").val();
        var empID = $("#off_ddlPrintEmployee").val();
        siteID = (siteID === "All" || siteID === null) ? 0 : siteID;
        empID = (empID === "All" || empID === null) ? 0 : empID;
        var payload = {
            timeSheetID: parseInt(timeSheetID),
            siteID: isNaN(parseInt(siteID)) ? 0 : parseInt(siteID),
            employeeID: isNaN(parseInt(empID)) ? 0 : parseInt(empID)
        };
        DownloadPdfFile("/api/ProjectTimesheetApproval/export-resource-wise-pdf", payload);
    });

    function DownloadPdfFile(url, payload) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", strUrl + url, true);
        xhr.responseType = "blob";
        xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
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

    function OpenBulkPreview(actionFlag) {
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
                        var fDate = item.fromDate ? new Date(item.fromDate).toLocaleDateString() : "";
                        var tDate = item.toDate ? new Date(item.toDate).toLocaleDateString() : "";
                        var rowProjectID = item.projectID || item.ProjectID || projectID || 0;
                        html += "<tr data-tsid='" + item.timeSheetNo + "' data-projectid='" + rowProjectID + "'>";
                        html += "<td class='text-center align-middle fw-bold text-primary'>" + item.timeSheetNo + "</td>";
                        html += "<td class='text-center align-middle'>" + fDate + "</td>";
                        html += "<td class='text-center align-middle'>" + tDate + "</td>";
                        html += "<td class='p-2'>";
                        html += "<textarea class='form-control row-comment' data-tsid='" + item.timeSheetNo + "' rows='2' placeholder='<%=MyBase.GetResourceString("C_EnterComment")%>'>"+ defaultComment +"</textarea>";
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
                $errorDiv.show();
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
                if (successCount > 0) {
                    alertify.success(successCount + " " + (g_BulkActionFlag === 1 ? "<%=MyBase.GetResourceString("A_TimesheetsApproved")%>" : "<%=MyBase.GetResourceString("A_TimesheetsRejected")%>"));
                    setTimeout(function () {
                        startEmailQueue(successfulItems, g_BulkActionFlag);
                    }, 600);
                } else {
                    setTimeout(function () { location.reload(); }, 1000);
                }
                if (failCount > 0) {
                    alertify.error(successCount + " <%=MyBase.GetResourceString("A_Succeeded")%>, " + failCount + " <%=MyBase.GetResourceString("A_Failed")%>. <%=MyBase.GetResourceString("A_CheckIndividualTimesheets")%>");
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
            setTimeout(function () { location.reload(); }, 1500);
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
        html += "<textarea class='form-control row-comment' data-tsid='" + tsId + "' rows='2' placeholder='<%=MyBase.GetResourceString("C_EnterComment")%>'>" + defaultComment +"</textarea>";
        html += "<div class='text-danger small comment-error' style='display:none;'><i class='fas fa-exclamation-circle'></i> <%=MyBase.GetResourceString("A_CommentRequired")%></div>";
        html += "</td>";
        html += "</tr>";
        $("#bulkListBody").html(html);
        $("#hdnBulkIds").val(tsId.toString());
        $("#bulkModalSummary").text("<%=MyBase.GetResourceString("C_TimesheetNo")%>: " + tsId);
        $("#btn_BulkSubmit").prop("disabled", false);
        var billingOffcanvasEl = document.getElementById('offcanvas_BillingInfo');
        var billingOffcanvas = bootstrap.Offcanvas.getInstance(billingOffcanvasEl);
        if (billingOffcanvas) {
            billingOffcanvas.hide();
        }
        setTimeout(function () {
            var myModal = new bootstrap.Modal(document.getElementById('BulkPreviewModal'));
            myModal.show();
        }, 350);
    }

    function LoadPendingAgeingCount() {
        var url = "/api/ProjectTimesheetApproval/GetPendingAgeingCount";
        var param = null;
        var result = AJAXCallWithResult(url, param, false);
        if (result && result.data && result.data.PendingAgeingCountEntity.length > 0) {
            var data = result.data.PendingAgeingCountEntity[0];
            $("#FltrCountInbox").text(data.pendingCount);
            $("#FltrCountWatchlist").text(data.ageingCount);
        }
    }
</script>
</body>
</html>
<%--End of code added by Vaibhav K on 04-03-26--%>