<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectTimesheetlist.aspx.vb" Inherits="Whizible.PM_ProjectTimesheetlist" %>

<!DOCTYPE html>
<html>

     <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_PageCaption") %></title>
    <!-- Tell the browser to be responsive to screen width -->
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=0.2">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

</head>

   <style type="text/css">
       /*Added By Dipali V On 10th Nov 2023 CSS changes*/
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
           /*            width: 20px !important;*/
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
           font-size: 14px;
           color: #1359a6
       }


       .hidecol .custom_chckbox {
           display: none
       }


       .billing_info_task_Grid td.hidecol .fa-plus, .billing_info_task_Grid th.hidecol .fa-plus {
           display: block;
           font-size: 14px;
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
           font-size: 14px;
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
           font-size: 12px !important;
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

       /*collapsibleinfopanel-end*/

       .custmodal .modal-content .modal-body {
           padding: 30px;
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

       /*.no-edit {
            width: 100%;
            text-align: center; border:none; background:none; box-shadow:none; resize:none;}*/
       /*.edit-row td{ pointer-events:none;}*/
       .edit-row td.toolactionsTD,
       .edit-row.edit_row_open td {
           pointer-events: auto;
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
           font-size: 15px;
           font-weight: 600 !important;
       }

       .pmtID {
           font-weight: 700 !important;
           font-size: 16px;
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
           /* float: right; */
           margin-left: 14px;
           /* margin-top: -14px; */
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
           font-size: 15px;
       }

       .save_row {
           font-size: 17px;
       }

       .method {
           font-weight: 600;
       }
       /*Commented command added ruby Vishal Mane on 09/10/2024 stop fix Highlight issue*/
       /*.added_IR {
           background-color: #faf8b6!important;
       }*/
       .added_IR td {
           background-color: #faf8b6!important;
       }
       /*End of Commented command added ruby Vishal Mane on 09/10/2024 stop fix Highlight issue*/

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
           left: 10px;
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
       /*Added By Dipali V On 24th Oct 2023 For UI Changes*/
       #txtDiscount {
           width:80px;
       }

       .HolidayClass {
           background-color: #9999ff!important;
       }
       .lgdHoliday {
           background-image: repeating-linear-gradient(45deg, #fff, yellow 1px, #fff 3px, #fff 4px)!important;
           border-left: 1px solid red !important;
           /* width: 90%; */
       }
     /**Textbox aligment*/
       .sumtxtEditAmount .txtEditAmount {
           width: 100px;
         
       }

       .txtEditAmount {
           border: none!important;
             /*background-color: white!important;*/
           width: 94px!important;
       }
       .settingOffcanvas, .helpOffcanvas {
            --bs-offcanvas-width: 70%;
        }
         .validationLabel{
            /* font-weight: 500; */
            font-size: 15px;
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
            font-size: 18px;
        }
        .IR_setting{
            border: 2px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            width: 95%;
        }
      /* .topicList li {
           list-style-type: disc;
           font-weight: 500;
           width: 290px;
       }*/
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
           /* background-image: repeating-linear-gradient(45deg,#fff,#ddd 1px,#ddd 1px,#fff 5px); */
           background-size: 50px 50px;
           /* background-color: lightgrey; */
           /* border: 1px solid; */
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
       /*End of Added By Dipali V On 24th Oct 2023 For UI Changes*/

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
     /*  Added ruby Dipali var content 2nd Jan 2023 for apply css*/
       .graytotalrow {
           background-color: #e9ecef;
           font-size: 12px;
       }
       #tbl_billing_info tr td a {
           white-space: pre-line;
       }
       /*Added By Dipali V On 11th Jan 2024 For CSS Changes for Slider*/
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
         /*End of Added By Dipali V On 11th Jan 2024 For CSS Changes for Slider*/

         /* Added by Gauri on 3rd Oct 2024 for Loader Issue */
         .loadingoverlay_progress_bar {
             left: 0 !important;
             right: 0 !important;
        }

         /*Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/
       .img-fluid_Updated {
         
           height: 20px;
       }
       /*End of Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/

        /* End of Added by Gauri on 3rd Oct 2024 for Loader Issue */
   </style>
   <!-- Added and Commented by Gauri on 3rd Oct 2024 for UI Issue -->   
   <!-- <body class="hold-transition skin-blue-light " id="bodyPreloader"> -->
   <body class="hold-transition bgwhite" id="bodyPreloader">
    <%If m_ViewAccess = True %>
    <div class="wrapper">
        <div class="bgwhite">
            <div class="graybg container-fluid pt-1 pb-2 statckmainheader">
                <div class="row">
                    <div class="col-sm-3">
                        <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_PageCaption") %></h5>
                    </div>
                    <div class="col-sm-9 form-inline text-end pt-1">
                        <a href="javascript:;" class="clearalllink" style="display:none" onclick="ClearAll()" id="PMProjectReviewClearAllFilter"  data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><span data-bs-toggle="collapse" data-bs-target="#filterpanel">Clear All</span></a>
                        
                        <div class="filter inline float-end">
                            <!-- <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Advanced Filter" autocomplete="off"><i class="fas fa-filter"></i></button> -->
                             <!-- Modified and commented by Gauri on 01st Oct 2024 for Tooltip Issue -->
                            <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" id="AdvanceFilterIcon" autocomplete="off"><span data-bs-toggle="tooltip" title="Advanced Filter"><i class="fas fa-filter"></i></span></button>
                        </div>
                    </div>

                </div>
            </div>




            <div class="content pt-0">
                <!--ps_list_table_start-->
                <div class="tab-pane pstbl_timesheet pt-0 in active" id="pstbl_timesheet">
                    <!--filter panel-->
                    <div id="filterpanel" class="filterpanel collapse">
                        <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                            <div class="cust_tabpanel mt-3">
                                <ul class="nav nav-tabs">
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" id="myfilter" href="#" data-bs-toggle="dropdown" aria-expanded="false"  onclick="AllMyFilters()"><%= MyBase.GetResourceString("C_MyFilters") %></a>
                                        <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                           
                                        </ul>
                                    </li>
                                    <li class="">
                                        <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true"><%= MyBase.GetResourceString("C_BasicFilters") %></a>
                                    </li>


                                </ul>
                            </div>

                            <div class="Fwrapper">
                                <div class="tab-content">
                                    <div id="basicfilters" class="tab-pane">
                                        <div class="filterpanelbody">
                                            <div class="text-center hidden-xs centerbtn">
                                                <button class="btn btnyellow" id="svfilterbtn" onclick="btnSaveAndApplyFilter_Onclick()"><%= MyBase.GetResourceString("C_SaveAndApply") %></button>
                                                <button class="btn btnyellow" onclick="ApplyFilter()"><%= MyBase.GetResourceString("C_Apply") %></button>
                                            </div>
                                            <br />

                                            <div class="row form-group">
                                                <div class="col-sm-3">
                                                    <label><%= MyBase.GetResourceString("C_FromDate") %></label>
                                                    <div class="input-group datefielddiv">
                                                       
                                                         <% CommonFunctions.HTMLControls.DrawTextBox("txtfromDateFilter", "txtfromDateFilter", "form-control input-sm",, 100,,, "height:38px", ,,, , "style='height:38px' onkeypress='return restrictAlphabets(event)' autocomplete='off'", ,, True,,,,) %>
                                           
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <label><%= MyBase.GetResourceString("C_ToDate") %></label>
                                                    <div class="input-group datefielddiv">
                                                       
                                                         <% CommonFunctions.HTMLControls.DrawTextBox("txttoDateFilter", "txttoDateFilter", "form-control input-sm",, 100,,, "height:38px", ,,, , "style='height:38px' onkeypress='return restrictAlphabets(event)' autocomplete='off'", ,, True,,,,) %>
                                           
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <%--<label><%= MyBase.GetResourceString("C_ActualWork") %></label>--%>
                                                    <label><%= MyBase.GetResourceString("C_TimesheetEfforts") %></label>
                                                    <%--<input type="text" name="" class="form-control">--%>
                                                       <% CommonFunctions.HTMLControls.DrawTextBox("txtAW", "txtAW", "form-control input-sm", 160, 100,,,, ,,,, " autocomplete='off'", ,, True,,,,) %>
                                           
                                                </div>
                                            </div>
                                            <div class="row form-group mt-3">
                                                <div class="col-sm-3">
                                                    <label>Status</label>
                                                    <div class="custom_dropdown">
                                                       
                                                         <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_Sel_Status",,, "data-live-search='true' class='selectpicker'", False,, ) %>
                               
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <label><%= MyBase.GetResourceString("C_TimesheetID") %></label>
                                                   
                                                     <% CommonFunctions.HTMLControls.DrawTextBox("txtTimesheetID", "txtTimesheetID", "form-control input-sm", 160, 100,,,, ,,,, "autocomplete='off'", ,, True,,,,) %>
                                           
                                                </div>
                                                <div class="col-sm-3">
                                                    <label><%= MyBase.GetResourceString("C_ProjectName") %></label>
                                                    
                                                         <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectFilter", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ",'" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "data-live-search='true' class='selectpicker'", False,, ) %>
                               
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                    <!--end filter panel-->
                    <div class="row">
                        <div class="col-sm-3 pt-2 text-start">
                            
                              <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ",'" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "Onchange=GetProjectTimesheet('Main') data-live-search='true' class='selectpicker form-control'", False,, ) %>
                                                        
                        </div>
                        <div class=" col-sm-9  pt-1 pb-1 text-end">
                             <%If m_AddAccess = True Then%>
                            <a onclick="Add_NewTimesheet(0)" class="btn borderbtn mr-5" id="addbtn"><i class="fa fa-plus mr-5 plus-icon" aria-hidden="true"></i> <%= MyBase.GetResourceString("C_Add") %></a>
                            <%End If %>
                          
                             <%If m_DeleteAccess = True Then%>
                            <a  class="btn borderbtn" id="delbtn" onclick="DeleteDetails()"><%= MyBase.GetResourceString("C_Delete") %></a>
                         <%End If %>
                              <a href="javascript:;" data-bs-toggle="offcanvas" onclick="Setting_onclick()">
                                  <%-- /*Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/--%>
                                <%--<img src="../../../Whizible2.0-new/dist/img/Setting-icon.svg" alt="Settings" class="img-fluid imgIcon ms-2" data-bs-toggle="tooltip" aria-label="Settings" data-bs-original-title="Additional IR Settings">--%>
                                <img src="../../../Whizible2.0-new/dist/img/Setting-icon.svg" alt="Settings" class="img-fluid img-fluid_Updated imgIcon ms-2" data-bs-toggle="tooltip" aria-label="Settings" data-bs-original-title="Additional IR Settings">
                                 <%-- /*End of Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/--%>
                                  </a> 
                            <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Help">
                                  <%-- /*Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/--%>
                                <%--<img src="../../../Whizible2.0-new/dist/img/help.svg" alt="Help" class="img-fluid imgIcon ms-2" data-bs-toggle="tooltip" aria-label="Help" data-bs-original-title="Help">--%>
                                <img src="../../../Whizible2.0-new/dist/img/help.svg" alt="Help" class="img-fluid img-fluid_Updated  imgIcon ms-2" data-bs-toggle="tooltip" aria-label="Help" data-bs-original-title="Help">
                              <%-- /*End of Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/--%>
                            </a>
                        </div>
                    </div>
                    <div class="notebox graybg">
                        <strong><%= MyBase.GetResourceString("C_TS") %></strong> <%= MyBase.GetResourceString("C_Summation") %> <strong><%= MyBase.GetResourceString("C_AW") %></strong> <%= MyBase.GetResourceString("C_Period") %> <strong>invoice</strong> <%= MyBase.GetResourceString("C_Generated") %><br>
                        <strong><%= MyBase.GetResourceString("C_NOTE_New") %>:</strong> <%= MyBase.GetResourceString("C_OT") %>  <strong> <%= MyBase.GetResourceString("C_BT") %> </strong> <%= MyBase.GetResourceString("C_TG") %><br>
                        <span class="ProjectGenNote"><%= MyBase.GetResourceString("C_ProjectGenNote") %> </span>
                    </div>
                    <table id="PTtbl" class="table table-stripped table-bordered timesheet-tbl" style="width:100%;">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_ID")%></th>
                                <th><%= MyBase.GetResourceString("C_WSR")%></th>
                                <th><%= MyBase.GetResourceString("C_Date")%> </th>
                                <th><%= MyBase.GetResourceString("C_FromDate")%></th>
                                <th><%= MyBase.GetResourceString("C_ToDate")%></th>
                                <th><%= MyBase.GetResourceString("C_TimesheetEfforts")%></th>
                                <th><%= MyBase.GetResourceString("C_BillableHours")%></th>
                                <th><%= MyBase.GetResourceString("C_Status")%></th>
                                <th><%= MyBase.GetResourceString("C_BillingInformation")%></th>
                                <th><%= MyBase.GetResourceString("C_PrintReport")%></th>
                                <th><%= MyBase.GetResourceString("C_ViewComment")%></th>
                                <th class="sm-wid">
                                    <div class="custom_chckbox">
                                        <input id="dltAllTimsheet" class="chckHead" type="checkbox">
                                        <label for="dltAllTimsheet"></label>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody id="TSBody">
                            
                          
                        </tbody>
                    </table>

                    <!--Page modal start here-->

                
                    <!--Save and apply modal start here-->
                    <div class="modal custmodal  fade" id="saveAndApplyFilter" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="false"  data-bs-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SaveFilterAs")%> </h5>
                                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="box-panel">
                                        <div class="box-body graybg">
                                            <div class="form-group mb-0">
                                                <div class="row">
                                                    <div class="col-md-12 row">
                                                        <label class="control-label col-md-4 p-0 text-end required"><%= MyBase.GetResourceString("C_FilterName")%> :</label>
                                                        <span class="col-md-8">
                                                            <input type="hidden" name="FilterID" id="FilterID" value="0">
                                                            <input type="hidden" name="QueryID" id="QueryID" value="0">
                                                               
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",,,,,, ,,,, "PlaceHolder = 'Enter Filter Name (Maxlength 100 Char)' autocomplete='Off' maxlength='100' ",,, True,,,,) %>
                                                            <br/>
                                                            <div class="btnrow">
                                                                <button class="btn btnyellow float-start savefilter" id="btnSaveBasicFilter"  onclick="SaveFilterValidation()"><%= MyBase.GetResourceString("C_Save")%></button>
                                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end"><%= MyBase.GetResourceString("C_Cancel")%></button>
                                                            </div>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Save and apply modal end here-->
                
                    <!--Page modal end here-->

                    <div id="deleteinfomodal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modalsmall">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title" style="text-align:center;"><%=MyBase.GetResourceString("C_Delete") %></h4>
                        </div>

                        <div class="modal-body">
                         
                            <p align="center"><%=MyBase.GetResourceString("C_DeleteConfirmationAlert") %></p>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                      
                                        <button class="btn borderbtn ml-1"  data-bs-dismiss="modal" onclick="DeleteData(0)"><%=MyBase.GetResourceString("C_No") %></button>
                                       
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="DeleteData(1)" style="float:right"  data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Yes") %></button>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                    <div class="clearfix"></div>
                    </div>

                </div>

                 <!--Billing Information Details offcanvas Section Start Here-->
                <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
                     id="offcanvas_BillingInfo" aria-labelledby="offcanvas_offcanvas_BillingInfo">
                    <div class="offcanvas-body">

                        <div id="BillingInfo_Details" class="NOI_Details">
                            <div class="BillingInfo_Details_Header d-flex justify-content-between">
                                <div class="Overlay-title"></div>
                                <div class="BillingInfo_HeaderBtns">
                                </div>
                            </div>
                            <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_BillingInformation") %> </h5>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2 project_timeperiod">
                                <div class="col-sm-12 ">
                                    <div class="row">
                                        <div class="col-sm-12 text-end">
                                             <%If m_AddAccess = True or m_EditAccess = True  Then%>
                                            <a href="javascript:;" class="btn btnyellow mr-5"
                                               id="btnGenerateTimesheet" style="display:none;"  data-bs-toggle="tooltip" title="Re-Generate Timesheet"><span><%=MyBase.GetResourceString("C_ReGenerateTimesheet") %> </span></a>
                                              <%End if%>
                                              <%If m_AddAccess = True or m_EditAccess = True  Then%>
                                            <a href="#" class="btn btnyellow mr-5 collapsed"
                                               id="generate_IR" data-bs-toggle="collapse"
                                               title="Generate IR"><span onclick="AddiniworkorderDetails();"><%=MyBase.GetResourceString("C_GenerateIR") %> </span></a>
                                             <%End if%>
                                             <%If m_AddAccess = True or m_EditAccess = True  Then%>
                                            <a href="javascript:;" class="btn btnyellow mr-5" id="btnSFA"
                                               data-bs-toggle="tooltip" data-bs-container="body"
                                               data-bs-placement="top" title="Send For Approval">
                                               <%=MyBase.GetResourceString("C_SFA") %>
                                            </a>
                                            <%End if%>
                                             <%If m_EditAccess = True  Then%>
                                            <a href="javascript:;" onclick="SaveTimesheet()" class="btn btnyellow " id="btnSave"
                                               data-bs-toggle="tooltip" data-bs-container="body"
                                               data-bs-placement="top" title="Save"> <%=MyBase.GetResourceString("C_Save") %> </a>
                                             <%End if%>
                                            <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                                    onclick="closeBillingDetails()" data-bs-toggle="tooltip"
                                                    data-bs-container="body" data-bs-placement="top" title="Close"
                                                    data-bs-dismiss="offcanvas">
                                                <%=MyBase.GetResourceString("C_Close") %>  
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="notebox graybg mt-2">
                                <div class="row">
                                    <div class="col-sm-6 text-start">
                                        <strong>
                                             <%=MyBase.GetResourceString("C_ProjectName") %>  : <span class="current_project_name" id="project_current"></span>
                                        </strong>
                                    </div>
                                    <div class="col-sm-6 text-end">
                                        <strong class="mx-1"> <%=MyBase.GetResourceString("C_TimesheetPeriod") %> : </strong><span id="billingfromdate"></span><strong> To  </strong> <span id="billingTodate"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="accordion collapse Init_acordian_panel mb-3 mt-3 show"
                                     id="Input_details_accordion">
                                    <div class="accordion-item ">
                                        <h2 class="accordion-header" id="Input_details_heading">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#Input_details_Info" aria-expanded="true" aria-controls="collapseOne">
                                                <%=MyBase.GetResourceString("C_InputDetails") %> 
                                            </button>
                                        </h2>
                                        <div id="Input_details_Info" class="accordion-collapse collapse "
                                             aria-labelledby="Input_details_heading" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="row">
                                                    <div class="col-sm-12 text-end">

                                                    </div>
                                                </div>
                                                <%-- Added By Dipali V On 25th Oct 2023 For Position Change --%>
                                                <div class="row form-group mt-3">
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end mt-2">
                                                                <label class=""> <%=MyBase.GetResourceString("C_ProjectName") %>  </label>
                                                            </div>
                                                            <div class="col-sm-6 mt-2 text-start">
                                                                <label class="" id="input_project"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end mt-2">
                                                                <label class="" id=""><%=MyBase.GetResourceString("C_CommercialType") %> </label>
                                                            </div>
                                                            <div class="col-sm-6 mt-2 text-start">
                                                                <span class="" id="input_Commercial"></span>
                                                               
                                                            </div>
                                                            <span class="MoreInformation" id="SpanCommercialTypeNote" style="margin-left: 48px;"></span>
                                                        </div>
                                                    </div>
                                                      <div class="col-sm-4">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-6 text-end  mt-2">
                                                                    <label class=" lb_ouWorking"><%=MyBase.GetResourceString("C_POU") %> </label>
                                                                </div>
                                                                <div class="col-sm-6 mt-2 text-start">
                                                                     <span class="lb_Commercial_type" id="SpanProjectOU"></span>
                                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtOU", "txtOU", "form-control",,,,,,,,,, "onkeypress='return isOnlyNumberKey(event)' autocomplete='off' maxlength='100'",,, True,, ,, True) %>--%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                  </div>
                                                   <%-- End of Added By Dipali V On 25th Oct 2023 For Position Change --%>
                                                <div class="row form-group mt-3">
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end mt-2">
                                                                <label class="required " id="input_FromDate"><%=MyBase.GetResourceString("C_FromDate") %> </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                <div class="input-group">
                                                                    
                                                                 <% CommonFunctions.HTMLControls.DrawTextBox("TxtFromDate", "TxtFromDate", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100' disabled",,, True,, ,, True) %>
                                       
                                                                    
                                                                    <span class="input-group-btn" style="width:13px">
                                                                        <button class="btn btncalendar" type="button">
                                                                            <i class="fas fa-calendar-alt"></i>
                                                                        </button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end  mt-2">
                                                                <label class="required" id="input_ToDate"><%=MyBase.GetResourceString("C_ToDate") %> </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                <div class="input-group">
                                                                      <% CommonFunctions.HTMLControls.DrawTextBox("TxtToDate", "TxtToDate", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100'",,, True,, ,, True) %>
                                      
                                                                    <span class="input-group-btn" style="width:13px">
                                                                        <button class="btn btncalendar" type="button">
                                                                            <i class="fas fa-calendar-alt"></i>
                                                                        </button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                       <%-- Commented By Dipali V On 25th Oct 2023 For Position Change --%>
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end  mt-2">
                                                                <label class="required"><%=MyBase.GetResourceString("C_OUWorking") %>  </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtOU", "txtOU", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100' disabled",,, True,, ,, True) %>
                                   
                                                            </div>
                                                        </div>
                                                    </div>
                                                      <%-- End of Commented By Dipali V On 25th Oct 2023 For Position Change --%>
                                                </div>

                                                <div class="row form-group mt-3">
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end mt-2">
                                                                <label class="required "><%=MyBase.GetResourceString("C_Working_Day") %>  </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                  <% CommonFunctions.HTMLControls.DrawTextBox("txtHRPerDay", "txtHRPerDay", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100' disabled",,, True,, ,, True) %>
                                  
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end  mt-2">
                                                                <label class=""><%=MyBase.GetResourceString("C_Discount") %>  %</label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtDiscount", "txtDiscount", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100' disabled",,, True,, ,, True) %>
                                  
                                                            </div>
                                                            <span class="MoreInformation" style="margin-left: 58px;"><%=MyBase.GetResourceString("C_NoteDiscount") %> </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end  mt-2">
                                                                <%--<label class="required"><%=MyBase.GetResourceString("C_ProjectCurrency") %> </label>--%>
                                                                <label class="required"><%=MyBase.GetResourceString("C_CBillingCurrency") %> </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                              <% CommonFunctions.HTMLControls.DrawTextBox("txtProjectCurrency", "txtProjectCurrency", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100' disabled",,, True,, ,, True) %>
                                  
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row form-group mt-3">
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end mt-2">
                                                                <label class="required "> <%=MyBase.GetResourceString("C_RateMethod") %> </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                
                                                                       <%CommonFunctions.HTMLControls.DrawComboBox("cboRateMethod", "usp_Whizible2_Sel_RateMethods",,, "onchange='RateMethodOnChange()' data-live-search='true' class='selectpicker' disabled", False,, ) %>    
                        
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end  mt-2">
                                                                <label class=""><%=MyBase.GetResourceString("C_SiteValidation") %> </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                     <%CommonFunctions.HTMLControls.DrawComboBox("cboSiteValidation", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, " data-live-search='true' class='selectpicker' disabled", False,, ) %>    
                             
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end  mt-2">
                                                                <label class="required">
                                                                   <%=MyBase.GetResourceString("C_InvoiceConversionDate") %> 
                                                                </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                                                <div class="input-group">
                                                                      <%CommonFunctions.HTMLControls.DrawTextBox("txtInvoiceDate", "txtInvoiceDate", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100' disabled",,, True,, ,, True) %>
                                  
                                                                    <span class="input-group-btn" style="width:23px">
                                                                        <button class="btn btncalendar"
                                                                                type="button">
                                                                            <i class="fas fa-calendar-alt"></i>
                                                                        </button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                   </div>

                                                <div class="row form-group mt-3" id="DivCapHoliday">
                                                      <div class="col-sm-4">
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end mt-2">
                                                                <label class="lb_ratemethod"> <%=MyBase.GetResourceString("C_CapConsider") %> </label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                 
                                                                 <%CommonFunctions.HTMLControls.DrawComboBox("cboCapConsider", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, " data-live-search='true' class='selectpicker' disabled", False,, ) %>    
                                                            </div>
                                                            <span class="MoreInformation" style="margin-left: 30PX;"><%=MyBase.GetResourceString("C_CapInformation") %> </span>
                                                        </div>
                                                    </div>
                                                      <div class="col-sm-4" >
                                                        <div class="row mb-1">
                                                            <div class="col-sm-6 text-end  mt-2">
                                                                <label class="lb_Site_Validation"><%=MyBase.GetResourceString("C_CapHoliday") %></label>
                                                            </div>
                                                            <div class="col-sm-6 text-start">
                                 

                                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboCapHoliday", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, " data-live-search='true' class='selectpicker' disabled", False,, ) %>    
                                                            </div>
                                                            <span class="MoreInformation"><%=MyBase.GetResourceString("C_HolidayInformation") %> </span>
                                                        </div>
                                                    </div>
                  
                                                 </div>

                                                 <div class="accordion collapse Init_acordian_panel mb-3 mt-3 highlitedpanel show" id="MonthlyMoreDetails" style="display:none">
                            <div class="accordion-item ">

                                <div id="DivMonthlyMoreDetails" class="accordion-collapse collapse  show"
                                     aria-labelledby="Edit_fiter_heading" data-bs-parent="#accordionExample">
                                    <div class="accordion-body" id="Applicable_monthly_rate">

                                        <div class="tab-pane pstbl_timesheet pt-0 in active"
                                             id="">
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
                                                              <%CommonFunctions.HTMLControls.DrawComboBox("cboActualDayBilling", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, " data-live-search='true' class='selectpicker'  onchange='ActualDayBillingRateOnchange()'", False,, ) %>    
                              
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
                                                                      <% CommonFunctions.HTMLControls.DrawTextBox("txtMonthlyHr", "txtMonthlyHr", "form-control", , 200,,,, ,,, , "autocomplete='off' onkeypress='return restrictAlphabets(event)'",,, True,,,, True) %>
                          
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                            </div>


                                            <div class="bordr-dotted">
                                                <div class="row form-group mt-2">
                                            <%--    <div class="col-sm-4">
                                                    <div class="row">
                                                        <div class="col-sm-12">

                                                            <div class="row mb-1">
                                                                <div class="col-sm-6 text-end">
                                                                    <label class=""><%=MyBase.GetResourceString("C_MonthlyHR") %> </label>
                                                                </div>
                                                                <div class="col-sm-6 pr-0">
                                                                      <% CommonFunctions.HTMLControls.DrawTextBox("txtMonthlyHr", "txtMonthlyHr", "form-control", , 200,,,, ,,, , "autocomplete='off' onkeypress='return restrictAlphabets(event)'",,, True,,,, True) %>
                          
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>--%>

                                                  
                                               
                                                <div class="col-sm-4">
                                                    <div class="row mb-1">
                                                        <div class="col-sm-6 text-end mt-2">
                                                            <label class="lb_Fixed_monthly"><%=MyBase.GetResourceString("C_FixedMonthly") %></label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                                 <% CommonFunctions.HTMLControls.DrawComboBox("cboFixedMonthlyRate", "EXEC usp_Whizible2_Sel_YesNoValue",,, " data-live-search='true'  class='selectpicker' onchange='FixedMonthlyRateOnchange()'") %>
                        
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
                                                                     <% CommonFunctions.HTMLControls.DrawTextBox("txtBufferPercent", "txtBufferPercent", "form-control", , 200,,,, ,,, , "placeholder='Threshold [0-100]' autocomplete='off' onkeyup='calculateEffortToConsider()'",,, True,,,, True) %>
                         
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
                                                                   <% CommonFunctions.HTMLControls.DrawTextBox("txtEffortToConsider", "txtEffortToConsider", "form-control", , 200,,,, True,,, , "autocomplete='off' onkeypress='return restrictAlphabets(event)'",,, True,,,, True) %>
                         
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
                                                                 <%CommonFunctions.HTMLControls.DrawComboBox("cboOnSiteFull", "usp_Whizible2_Sel_YesNoValue 1",,, "data-live-search='true' class='selectpicker'", False,, ) %>    
                              
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

                                                    <span class="clsNote">
                                                       <%=MyBase.GetResourceString("C_NoteCaption") %> :- <br>
                                                        <span class="clsNote">
                                                         <%=MyBase.GetResourceString("T_Note1") %> 
                                                        </span><br>
                                                        <span class="clsNote">
                                                           <%=MyBase.GetResourceString("T_Note2") %> 
                                                        </span><br>
                                                          <span class="clsNote" id="T_Note4">
                                                           <%=MyBase.GetResourceString("T_Note4") %> 
                                                        </span><br>
                                                        <span class="clsNote" id="T_Note3">
                                                           <%=MyBase.GetResourceString("T_Note3") %> 
                                                        </span><br>
                                                       
                                                        <!--<span class="clsNote" id="T_Note4" style="display: block;">4) View task list will display only parent project, if Parent Project  task available for selected period</span>-->
                                                       
                                                    </span>

                                                <%--</div>--%>




                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Generate IR accordion Start here-->
                            <div class="workorderdetailpanel form-group">
                                <div class="accordion collapse Init_acordian_panel mb-3 mt-3 "
                                     id="Generate_IR_accordion">
                                    <div class="accordion-item " style="border:2px solid black">
                                        <h2 class="accordion-header" id="Generate_IR_heading">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#Generate_IR_Project" aria-expanded="true" aria-controls="collapseOne">
                                               <%=MyBase.GetResourceString("T_GenerateIR") %>   
                                            </button>
                                        </h2>
                                        <div id="Generate_IR_Project" class="accordion-collapse collapse show "
                                             aria-labelledby="Generate_IR_heading" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="tab-pane pstbl_timesheet pt-0 in active" id="p_timesheet_add">
                                                    <div class="row ">
                                                        <div class="col-sm-12 text-end">
                                                            <a href="javascript:;" class="btn btnyellow "
                                                               id="Create_IR" data-bs-toggle="tooltip"
                                                               data-bs-container="body" data-bs-placement="top"
                                                               title="Submit IR/PIR"><%=MyBase.GetResourceString("C_SubmitIRPIR") %></a>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-sm-12 text-end">
                                                            <label class="form-label ">
                                                                (<font color="red">*</font>
                                                                <%=MyBase.GetResourceString("C_Mandatory") %> )
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-1 ">
                                                        <div class="col-sm-6">
                                                            <input type="radio" id="chckInvoice_Request" name="checked" value="Invoice">
                                                            <label for="IR"><%=MyBase.GetResourceString("C_IR") %> (<%=MyBase.GetResourceString("C_InvoiceRequest") %> )</label><br>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <input type="radio" id="chckProforma_Invoice_Request" name="checked"
                                                                   value="PIR">
                                                            <label for="IR_PIR">
                                                               <%=MyBase.GetResourceString("C_PIR") %> ( <%=MyBase.GetResourceString("C_ProformaInvoiceRequest") %> 
                                                                )
                                                            </label><br>
                                                        </div>
                                                    </div>
                                                    <div class="row form-group mt-3">
                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label class="required lb_projectname"><%=MyBase.GetResourceString("C_Type") %> </label>
                                                                </div>
                                                                <div class="col-sm-8  text-start">
                                                                   
                                                                     <%CommonFunctions.HTMLControls.DrawComboBox("cboType", "select 1",,, "data-live-search='true' class='selectpicker'", False,, ) %>
                
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end mt-2">
                                                                    <label class="lb_Commercial"><%=MyBase.GetResourceString("C_Creditdays") %> </label>
                                                                </div>
                                                                <div class="col-sm-8 text-start">
                                                                   
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("input_Credit", "input_Credit", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                         
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row form-group mt-3">
                                                        <div class="col-sm-6">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <div class="row mb-1">
                                                                        <div class="col-sm-4 text-end">
                                                                            <label class=" required "><%=MyBase.GetResourceString("C_Customer") %> </label>
                                                                        </div>
                                                                        <div class="col-sm-8 pr-0">
                                                                          
                                                                             <%CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "select 1",,, "data-live-search='true' class='selectpicker' disabled", False,, ) %>
                
                                                                            <a href="javascript:;" id="linkCustomerAddress" class="text_size" onclick="GetCustomerAddress()" data-bs-toggle="modal" data-bs-target="#Select_Customer_Address">
                                                                                <%=MyBase.GetResourceString("C_SelectCustomerAddress") %> 
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end  mt-2">
                                                                   <%-- Commented & Added By Dipali V On 28th Dec 2023 For Change Caption Currency to Billing Currency--%>
                                                                    <%--<label class="required"><%=MyBase.GetResourceString("C_Currency") %>  </label>--%>
                                                                    <label class="required"><%=MyBase.GetResourceString("C_CBillingCurrency") %>  </label>
                                                                    <%-- End of Commented & Added By Dipali V On 28th Dec 2023 For Change Caption Currency to Billing Currency--%>
                                                                </div>
                                                                <div class="col-sm-8 text-start mt-2">
                                                                    <label class=""><span id="IRProjectCurrency"></span><span id="IRProjectCurrencyCode"></span></label>
                                                                    <input type="hidden" id="IRCurrency"/>
                                                                </div>
                                                                 <%--<a href="javascript:;" id="linkMoreDetails" class="text_size"  data-bs-toggle="modal" data-bs-target="#Select_MoreDetails">
                                                                          <%=MyBase.GetResourceString("C_MoreDetails") %> 
                                                                   </a>--%>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="row form-group mt-3">
                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end  mt-2">
                                                                    <label class="required lb_ouWorking">
                                                                        <%=MyBase.GetResourceString("C_ContactPerson") %> 
                                                                    </label>
                                                                </div>
                                                                <div class="col-sm-8 text-start">
                                                                   
                                                                     <%CommonFunctions.HTMLControls.DrawComboBox("cboContactPerson", "select 1",,, "data-live-search='true' class='selectpicker' onchange='SelectContactPerson()'", False,, ) %>
                
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 mt-1 text-end">
                                                                    <label class="required control-label"> <%=MyBase.GetResourceString("C_SalesPeriod") %>  </label>
                                                                </div>
                                                                <div class="col-sm-7 pr-0">
                                                                   
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSalesPeriod", "txtSalesPeriod", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                                                          <input type="hidden" id="TexthiddenSalesPeriod" value="0"/>
                                                                </div>
                                                                <div class="col-sm-1 mt-1">
                                                                    <a href="javascript:;"  onclick="GetSalesPeriodDetails()" data-bs-toggle="tooltip" title="Select Sales Period">
                                                                        <i class="fa fa-link" aria-hidden="true"
                                                                           style=" margin: 5px -17px 0;"></i>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row form-group mt-3">
                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end  mt-2">
                                                                    <label class=""><%=MyBase.GetResourceString("C_Emailconfirm") %>  </label>
                                                                </div>
                                                                <div class="col-sm-8 text-start">
                                                                    
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtinput_Email", "txtinput_Email", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                         
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">

                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 mt-1 text-end">
                                                                    <label class="control-label"><%=MyBase.GetResourceString("C_SalesPerson") %> </label>
                                                                </div>
                                                                <div class="col-sm-7 pr-0">
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSalesPerson", "txtSalesPerson", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                         <input type="hidden" id="TexthiddenSalesPerson"  value="0"/>
                                                                </div>
                                                                <div class="col-sm-1 mt-1">
                                                                    <a href="javascript:;"  onclick="Getsales_personDetails()">
                                                                        <i class="fa fa-link" aria-hidden="true"
                                                                           style=" margin: 5px -17px 0;" data-bs-toggle="tooltip" title="Select Sale Person"></i>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row form-group mt-3">
                                                        <div class="col-sm-6">
                                                      
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 mt-1 text-end">
                                                                    <label class="required control-label"><%=MyBase.GetResourceString("C_Contract") %> </label>
                                                                </div>
                                                                <div class="col-sm-7 pr-0">
                                                                    
                                                                      <% CommonFunctions.HTMLControls.DrawTextBox("txtContract", "txtContract", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                          <input type="hidden" id="TexthiddenContract" />
                                          <%--<input type="hidden" id="TexthiddenContractCurrencySymbol" />--%>
                                                                    <a href="javascript:;"  id="linkContractDetails" class="text_size" onclick="GetContractDetails()">
                                                                        <%=MyBase.GetResourceString("C_ShowDetails") %> 
                                                                    </a>
                                                                </div>
                                                                <div class="col-sm-1 mt-1">
                                                                    <a href="javascript:;" onclick="GetContract()">
                                                                        <i class="fa fa-link" aria-hidden="true" style=" margin: 5px -17px 0;" data-bs-toggle="tooltip" title="Select Contract"></i>
                                                                    </a>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end  mt-2">
                                                                    <label class="required lb_Site_Validation">
                                                                         <%=MyBase.GetResourceString("C_IRItemsHeader") %>  
                                                                        
                                                                    </label>
                                                                </div>
                                                                <div class="col-sm-8 text-start">
                                                                    
                                                                       <% CommonFunctions.HTMLControls.DrawTextArea("IRItemsHeader", "IRItemsHeader", "Enter IR Items Header", "form-control",,,,,, 100, 2000,,,,,,,, "Maxlength=2000",,,,,,,,,,) %>
                                      
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="row form-group mt-3">
                                                        <div class="col-sm-6">
                                                            <div class="row mb-1">
                                                                <div class="col-sm-4 text-end  mt-2">
                                                                    <label class=" lb_invoice">
                                                                        <%=MyBase.GetResourceString("C_InvoiceConversionDate") %>   
                                                                        
                                                                    </label>
                                                                </div>
                                                                <div class="col-sm-8 text-start">
                                                                    <div class="input-group datefielddiv" style="width: 70%;">
                                                                        <%--<input id="toDateFilter" type="text"
                                                                               class="form-control">--%>
                                                                             <% CommonFunctions.HTMLControls.DrawTextBox("txtIRConversionDate", "txtIRConversionDate", "form-control",,,,,, True,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                         
                                                                        <span class="input-group-btn">
                                                                            <button class="btn btncalendar"
                                                                                    type="button">
                                                                                <i class="fas fa-calendar-alt icon_style"></i>
                                                                            </button>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-1"></div>
                                                        <div class="col-sm-5 lgdapproved text-end">
                                                           
                                                            <table class="lgdapproved border-none" width="100%">
                                                                <thead>
                                                                    <tr>
                                                                        <th colspan="4" class="text-start"><%=MyBase.GetResourceString("C_SelectedIRItems") %>    </th>
                                                                    </tr>
                                                                    <tr>
                                                                        <th><%=MyBase.GetResourceString("C_Description") %> </th>
                                                                        <th><%=MyBase.GetResourceString("C_FinalAmount") %> </th>
                                                                        <th><%=MyBase.GetResourceString("C_PMEditedAmount") %> </th>
                                                                        <th></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="TbodySelectedItems">
                                                                   
                                                                    
                                                                </tbody>
                                                            </table>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                            </div>
                            <!--Generate IR accordion End here-->
                            <!--Legends section Start here-->
                            <div class=" row mt-1 mb-1">
                                <div class="col-sm-12 text-end">
                                    <div class="">
                                        <ul class="list-unstyled main-box">

                                            <li class="d-flex gap-1 ms-3">
                                                <%--<div class="span-clrs mx-2"><strong><%= MyBase.GetResourceString("C_Legends") %>  :</strong></div>--%>
                                                <%--Added By Dipali V On 2nd Jan 2024 For Caption Changes--%>
                                                <div class="span-clrs mx-2" ><span id="DivProjectCurrency" style="float:left"><%=MyBase.GetResourceString("C_BillingCurrenyCaption")%> <span id="ProjectCurrencyNote" class="Curncy iconBlue"></span>.</span> &nbsp;&nbsp;&nbsp;   <%=MyBase.GetResourceString("C_PCurrency")%> <span id="PCurrency"></span> <span id="PCurrencyNote" class="Curncy iconBlue"></span>. &nbsp;&nbsp;&nbsp; <span id="BCurrencyDiv"><%=MyBase.GetResourceString("C_BCurrency")%> <span id="BCurrency"></span> <span id="BCurrencyNote" class="Curncy iconBlue"></span></span>.</div>
                                                <%--<div class="span-clrs mx-2" id="DivPCurrency">All Values in Project Currency <span id="PCurrencyNote" class="Curncy iconBlue"></span></div>--%>
                                                <div class="d-flex">
                                                <div class="StageboxDiv added_IR" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_MapIR") %>"></div>
                                                <div class="span-clrs ps-2"> <%= MyBase.GetResourceString("C_MapIR") %></div>
                                                    </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!--Legends section End here-->
                                                        <!--Billing Information Table section Start here-->
                            <div class="NOI_Details_content">
                                <div class="tab-content detailsmenutab">
                                    <!--<%-- First Tab - Billing Content --%>-->
                                    <div class="tab-pane active" id="Billing_Info_Tab">
                                        <div class="BasicDetailsContent">
                                            <div id="tbl_billing_info" class="init_grid_panel">
                                                <table class="table table-bordered table-stripped highlight-tbl stickytable billing_info_task_Grid"
                                                       style="width:100%;">
                                                    <thead>
                                                        <tr>
                                                           <%-- <th><%= MyBase.GetResourceString("C_ID") %></th>--%>
                                                            <th style="min-width: 144px;"><%= MyBase.GetResourceString("C_EmployeeCode") %> - <%= MyBase.GetResourceString("C_ResourceName") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Location") %> </th>
                                                            <th><%= MyBase.GetResourceString("C_ProjectRole") %> </th>
                                                            <th><%= MyBase.GetResourceString("C_Details") %> </th>
                                                            <th><%= MyBase.GetResourceString("C_BillingRate") %> </th>
                                                            <!--<th class="">-->
                                                            <th width="10%"><%= MyBase.GetResourceString("C_ActualHrs") %> </th>
                                                            <th class="tdCurrent tdcurrentshow" id="Show_curret">
                                                                <button id="click-me-current" class="float-end hide-column">
                                                                    <i class="fas fa-minus" id="minus_Current" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" data-bs-original-title="Hide More Details"></i>
                                                                    <i class="fas fa-plus" id="plus_Current" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" data-bs-original-title="Show More Details"></i>
                                                                </button>
                                                            </th>
                                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_WorkingDay") %> </th>
                                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_Noofdayworked") %> </th>
                                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_DailyRate") %> </th>
                                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_InvoiceAmount") %> </th>
                                                            <th class="tdCurrent "><%= MyBase.GetResourceString("C_Discount") %>  </th>
                                                            <th><%= MyBase.GetResourceString("C_FinalAmount") %></th>
                                                            <th width="7%"><%= MyBase.GetResourceString("C_PMEditedAmount") %></th>
                                                            <th width="7%"><%= MyBase.GetResourceString("C_Difference") %> <br><span class="text_size"><%= MyBase.GetResourceString("C_FinalPM") %> </span></th>
                                                            <th><%= MyBase.GetResourceString("C_IRID") %></th>
                                                            <th width="10%"><%= MyBase.GetResourceString("C_Remarks") %></th>
                                                            <th width="7%"><%= MyBase.GetResourceString("C_Actions") %> </th>
                                                        </tr>
                                                    </thead>

                                                    <tbody class="tbody_billing_info" id="tbodyTMDetail">
                                                        
                                                       

                                                    </tbody>

                                                     <tfoot>
                                                    <tr class="graytotalrow">
                                                        <%--<td>&nbsp;</td>--%>
                                                        <td><b><%= MyBase.GetResourceString("C_TotalBCurrency") %></b></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td class="text-right">&nbsp;</td>
                                                        <td class="text-right">&nbsp;</td>
                                                        <td class="tdCurrent">&nbsp;</td>
                                                        <td class="tdCurrent">&nbsp;</td>
                                                        <td class="tdCurrent">&nbsp;</td>
                                                        <td class="tdCurrent">&nbsp;</td>
                                                       <%-- <td class="tdCurrent">&nbsp;</td>--%>
                                                        <td class="tdCurrent" id=""><span id="SumInvoice"></span><span id="SumInvoicebillingCurrency" class="Curncy iconBlue" style="display:none"></span></td>
                                                        <td class="tdCurrent" id=""><span id="SumDiscount"></span><span id="SumDiscountbillingCurrency" class="Curncy iconBlue" style="display:none"></span></td>
                                                        <td><span id="SumFinalAmount"></span><span id="billingCurrency" class="Curncy iconBlue"></span></td>
                                                        <td class="text-right" id="SumDiffFinalAmount">
                                                            <input type="text" value="" class="form-control input-sm txtEditAmount"  disabled/></td>
                                                        <td class="text-right"></td>
                                                        <td class="text-right"></td>
                                                        <td class="text-right">&nbsp;</td>
                                                        <td class="text-right">&nbsp;</td>
                                                    </tr>
                                                  </tfoot>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Billing Information Table section End here-->
                        </div>
                    </div>
                </div>
                <!--Billing Information Details offcanvas Section End Here-->
                <!--Print Report offcanvas Section Start Here-->
                <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
                     id="offcanvas_Print_report" aria-labelledby="offcanvas_Print_reportLabel">
                    <div class="offcanvas-body">
                        <div id="Print_Report_Details" class="Print_Report_Details">
                            <div class="Print_Report_Details_Header d-flex justify-content-between">
                                <div class="Overlay-title"></div>
                                <div class="Print_Report_Details_HeaderBtns">
                                </div>
                            </div>
                            <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_PrintReport")%></h5>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2 project_timeperiod">
                                <div class="col-sm-12 ">
                                    <div class="row">
                                        <div class="col-sm-8">
                                        </div>
                                        <div class="col-sm-4 text-end">
                                            <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                                    onclick="closeNOIDetails()" data-bs-dismiss="offcanvas">
                                                <%= MyBase.GetResourceString("C_Close")%>
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="Print_Report_Details_content">
                                <div class="tab-content detailsmenutab">
                                    <!--<%--Print_Report - Details --%>-->
                                    <div class="tab-pane active" id="Print_Report_Tab">
                                        <div class="BasicDetailsContent">
                                            <div class="notebox graybg mt-2">
                                                <div class="row">
                                                    <div class="col-sm-6 text-start">
                                                        <strong>  <%= MyBase.GetResourceString("C_ReportNote")%> </strong>
                                                    </div>

                                                    <div class="col-sm-6 text-end ">
                                                        <!--<i data-bs-toggle="tooltip" data-bs-placement="bottom" data-title="Click here to download" class="fas fa-download" data-original-title="" title="" aria-describedby=""></i>-->
                                                        <div class="dropdown filedownload float-end">
                                                            <button class="" style="border:none" data-bs-toggle="dropdown" aria-expanded="false">
                                                                <i data-bs-toggle="tooltip" data-title="Click here to Export" class="fas fa-download"></i>
                                                            </button>
                                                            <ul class="dropdown-menu" data-popper-placement="bottom-start" style="position: absolute; inset: 0px auto auto 0px; margin: 10px;">
                                                                <li>
                                                                    <a href="#" onclick="Export_PDFClick('PDF')">
                                                                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px"> <%= MyBase.GetResourceString("C_PDF")%>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <%--cOMMENTED & aDDED BY DIPALI V ON 23RD SEP 2025 FOR EXCEL DONWLOAD ISSUE --%>
                                                                    <%--<a href="#"  onclick="Export_PDFClick('XLSX')">--%>
                                                                    <a href="#"  onclick="Export_PDFClick('EXCEL')">
                                                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px"><%= MyBase.GetResourceString("C_Xlsx")%> 
                                                                    </a>
                                                                    <%--cOMMENTED & aDDED BY DIPALI V ON 23RD SEP 2025 FOR EXCEL DONWLOAD ISSUE--%> 
                                                                </li>
                                                                <li>
                                                                    <a href="#"  onclick="Export_PDFClick('XML')">
                                                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px"><%= MyBase.GetResourceString("C_Xml")%>  
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a href="#"  onclick="Export_PDFClick('TEXT')">
                                                                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px"><%= MyBase.GetResourceString("C_DOC")%>  
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>


                                            <div class="row mt-2">
                                                <div class="col-sm-12 text-end">
                                                    <label class="form-label ">
                                                        (<font color="red">*</font>
                                                        <%= MyBase.GetResourceString("C_Mandatory")%>)
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                        <label class="required"><%= MyBase.GetResourceString("C_Timesheet")%></label>
                                                        <div class="custom_dropdown actual-wrk-menu">
                                                          
                                                                 <%CommonFunctions.HTMLControls.DrawComboBox("cboTimesheet", "select '1'",200,, "data-live-search='true' class='selectpicker form-control'", False,, ) %>
                       
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label><%= MyBase.GetResourceString("C_Site")%></label>
                                                        <div class="custom_dropdown actual-wrk-menu">
                                                           
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboSite", "select '1'",,, "data-live-search='true' class='selectpicker form-control'", False,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label><%= MyBase.GetResourceString("C_Employee")%></label>
                                                        <div class="custom_dropdown actual-wrk-menu">
                                                          
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "select '1'",,, "data-live-search='true' class='selectpicker form-control'", False,, ) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="container-fluid py-1 graybg clearfix bottom-note">
                                                <div class="float-start" id="IM_Program_Report_Footer">
                                                    <span class="note-title"><%= MyBase.GetResourceString("C_NOTE_New")%>:</span> <%= MyBase.GetResourceString("C_Configure")%>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <!--Print Report offcanvas Section End Here-->
                <!--View Comment offcanvas Section Start Here-->
                <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
                     id="offcanvas_viewcomment" aria-labelledby="offcanvas_viewcomment">
                    <div class="offcanvas-body">

                        <div id="NOI_Details_Sec" class="NOI_Details">
                            <div class="NOI_Details_Header d-flex justify-content-between">
                                <div class="Overlay-title"></div>
                                <div class="NOI_HeaderBtns">
                                </div>
                            </div>
                            <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ViewComment")%></h5>
                                    </div>

                                </div>
                            </div>
                            <div class="row mt-2 mb-2 project_timeperiod">
                                <div class="col-sm-12 ">
                                    <div class="row">
                                        <div class="col-sm-8">
                                        </div>
                                        <div class="col-sm-4 text-end">
                                            <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                                    onclick="closeNOIDetails()" data-bs-dismiss="offcanvas">
                                                <%= MyBase.GetResourceString("C_Close")%>
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="NOI_Details_content">
                                <div class="tab-content detailsmenutab">
                                    <!--<%-- First Tab - Basic Details --%>-->
                                    <div class="tab-pane active" id="BasicDetailsTab">
                                        <div class="BasicDetailsContent">
                                            <div class=" mt-2">
                                                <div class="">
                                                    <div class="form-group mb-0">
                                                      
                                                        <div class="clearfix"></div>
                                                        <div class="row">
                                                            <div class="col-sm-12 row">
                                                                <label class="control-label col-sm-2 text-end "> <%= MyBase.GetResourceString("C_Comment")%> : </label>
                                                                    <span class="col-sm-9 pe-2 border rounded-3" style=" width: 55%; height:127px;">
                                                                   
                                                                    <label class="control-label  text-end " id="txtViewComments"></label>
                                                                </span>
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
                <!--View Comment offcanvas Section End Here-->

                    <!--ps_list_table_end-->
                </div>
            <div class="clearfix"></div>
        </div>
    </div>

     <!-- Timesheet Setting Section starts -->
                <div class="offcanvas offcanvas-end settingOffcanvas" data-bs-scroll="false" tabindex="-1"
                    id="offcanvas_Setting" aria-labelledby="offcanvas_setting">
                    <div class="offcanvas-body">
                        <div id="setting_Details" class="setting_Details">
                            <div class="setting_Details_Header d-flex justify-content-between">
                                <div class="Overlay-title"></div>
                                <div class="setting_Details_HeaderBtns">
                                </div>
                            </div>
                            <div class="graybg container-fluid pt-1 pb-1 mb-2">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h5 class="pgtitle"><%= MyBase.GetResourceString("C_Settings")%> </h5>
                                    </div>
                                </div>
                            </div>
                            <div class="row my-2">
                                <div class="col-sm-12 ">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            &nbsp;
                                        </div>
                                        <div class="col-sm-6 text-end">
                                            <button class="btn btnyellow" id="saveSettingBtn" data-bs-toggle="tooltip" title="Save" onclick="SaveProjectLevelSettings()"><%= MyBase.GetResourceString("C_Save")%> </button>
                                            <button type="button" class="btn borderbtn closebtn text-end" data-bs-toggle="tooltip" title="Close"
                                                data-bs-dismiss="offcanvas" data-bs-container="body" data-bs-placement="top">
                                              <%= MyBase.GetResourceString("C_Close")%>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="noteSec py-1 graybg mb-2">
                                            <div class="noteContent px-2">
                                                <%--<i class="far fa-lightbulb noteIcon me-1"></i>--%>
                                                <span class="font-weight-600">Note:</span><br />
                                                <ol class="reportList mb-0">
                                                    <li><%= MyBase.GetResourceString("C_STNote1")%> </li>
                                                    <li><%= MyBase.GetResourceString("C_STNote2")%> </li>
                                                </ol>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="TS_SettingScreen mt-4">
                                <!-- Flag 1 -->
                                <div class="settingSec mb-4 ms-3">
                                    <div class="row">
                                        <div class="col-sm-11">
                                            <div class="form-group">
                                              
                                                <div class="row">
                                                    <div class="col-sm-9">
                                                        <label class="validationLabel">1&#10089; <%= MyBase.GetResourceString("C_Doyouwanttoconsider")%>  <span class="font-weight-500">"Rate"</span> from the organization level ?</label><%--<span class="font-weight-500">"<%= MyBase.GetResourceString("C_ProjectSite")%>"</span>--%>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label class="switch">
                                                            <input type="checkbox" class="chckSlider" id="slider1">
                                                            <span class="slider"></span>
                                                        </label> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="toggleIconDesc shadowBox mt-2" id="settingDesc1">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <div class="descTxt">
                                                        <p>This configuration setting will only have an impact when the "Site Validation" is set to "No," as it determines how rates and hours are factored into billing.</p>
                                                        <ul class="outerList">
                                                            <li>If this option is activated:</li>
                                                            <p>Billing rates will be determined based on the employee's master rate, defined on the resource details page, or the corporate role rate, defined on the role details page, depending on the commercial type of the project. For Time and Materials (T&M) resources, the employee rate will be utilized, while for T&M roles, the role rate will be applied.</p>
                                                        </ul>
                                                        <ul class="outerList">
                                                            <li>If this option is deactivated:</li>
                                                            <p class="mb-1">Billing rates will be calculated as per the project site ,the average of the Normal rate, Extra rate, and Holiday rate from the project site.</p>
                                                            <p>Regardless of whether the setting is enabled or disabled, hours for billing will be derived from the Project Operational Unit's (OU) working hours per day. For instance, if the OU's daily working hours are 8, and a resource logs 9 hours in a day, only 8 hours will be considered for billing.</p>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Flag 2 -->
                                <div class="settingSec mb-4 ms-3">
                                    <div class="row">
                                        <div class="col-sm-11">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-9">
                                                         <%-- Commented & Added By Dipali V On 11th Jan 2024 For Note Changes--%>
                                                        <%--<label class="validationLabel">2&#10089; Do you want to consider no. of <span class="font-weight-500">"working days"</span> from <span class="font-weight-500">"project location"</span> or the input given while generating the project timesheet?</label>--%>
                                                        <label class="validationLabel">2&#10089; Do you want to consider no. of <span class="font-weight-500">"working days"</span> from <span class="font-weight-500">"project location"</span>?</label>
                                                     <%-- End of Commented & Added By Dipali V On 11th Jan 2024 For Note Changes--%>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label class="switch">
                                                            <input type="checkbox" class="chckSlider" id="slider2">
                                                            <span class="slider"></span>
                                                        </label> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="toggleIconDesc shadowBox mt-2" id="settingDesc2">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <div class="descTxt">
                                                        <!-- "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." -->
                                                        <p>This setting will be applicable under both conditions, whether Site Validation is set to Yes or No, to determine the working days to be considered.</p>
                                                        <ul class="outerList">
                                                            <li>If Site Validation is set to Yes and this option is activated:</li>
                                                            <p>The number of working days will be determined according to the project location, i.e., as per the Project Organizaton Unit (OU). The selected period days will be automatically populated in the Timesheet (TS) details section and will be considered directly. If this value is modified, the modified value will be taken into account.</p>
                                                        </ul>
                                                        <ul class="outerList">
                                                            <li>If Site Validation is set to Yes, and this option is deactivated:</li>
                                                            <p>Working days will be considered based on the resource assignment dates on site.</p>
                                                        </ul>
                                                        <ul class="outerList">
                                                            <li>If Site Validation is set to No, and this option is activated or deactivated:</li>
                                                            <p>The number of working days will be determined as per the project location, i.e., according to the Project OU. The selected period days will be automatically populated in the TS details section and will be considered directly.</p>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Flag 3 -->
                                <div class="settingSec mb-4 ms-3">
                                    <div class="row">
                                        <div class="col-sm-11">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-9">
                                                       <%-- Commented & Added By Dipali V On 11th Jan 2024 For Note Changes--%>
                                                        <label class="validationLabel">3&#10089; Do you want to consider modified IR value?</label>
                                                        <%--<label class="validationLabel">3&#10089; Do you want to consider modified IR value or system generated IR value?</label>--%>
                                                    <%-- End of Commented & Added By Dipali V On 11th Jan 2024 For Note Changes--%>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label class="switch">
                                                            <input type="checkbox" class="chckSlider" id="slider3">
                                                            <span class="slider"></span>
                                                        </label> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                   <div class="toggleIconDesc shadowBox mt-2" id="settingDesc3">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <div class="descTxt">
                                                        <ul class="innerList mb-0">
                                                            <li>This option is enabled then PM Edited Value will be considered as amount in IR</li>
                                                            <li>This option is disabled then Invoice Amount will be considered as amount in IR</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Flag 4 -->
                                <div class="settingSec mb-4 ms-3">
                                    <div class="row">
                                        <div class="col-sm-11">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-9">
                                                        <label class="validationLabel">4&#10089; Do you want to Enable Smart Edit for timesheet?</label>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label class="switch">
                                                            <input type="checkbox" class="chckSlider" id="slider4">
                                                            <span class="slider"></span>
                                                        </label> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                   <div class="toggleIconDesc shadowBox mt-2" id="settingDesc4">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <div class="descTxt">
                                                        <ul class="innerList mb-0">
                                                            <li>This option  is enable then "Smart Edit" option will be availble on "Easy Edit" page</li>
                                                            <li>This option is disabed then "Smart Edit" option will not be availble on "Easy Edit" page</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                 <!-- Flag 4 -->
                                <div class="settingSec mb-4 ms-3">
                                    <div class="row">
                                        <div class="col-sm-11">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-9">
                                                        <label class="validationLabel">5&#10089; Do you want invoice amount into Site Currency?</label>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label class="switch">
                                                            <input type="checkbox" class="chckSlider" id="slider7">
                                                            <span class="slider"></span>
                                                        </label> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                   <div class="toggleIconDesc shadowBox mt-2" id="settingDesc7">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <div class="descTxt">
                                                        <ul class="innerList mb-0">
                                                            <li>This option  is enable then invoice amount will consider in Site Currency on Billing Information Page</li>
                                                            <li>This option is disabed then invoice amount will consider in Billing Currency  on Billing Information Page</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Flag 5 -->
                                <div class="settingSec mb-4 ms-3">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="row">
                                              
                                                <label class="validationLabel mb-2">6&#10089; <%= MyBase.GetResourceString("C_PTApprover")%> </label>
                                                <div class="col-sm-10 col-lg-7 col-8">

                                                    <%CommonFunctions.HTMLControls.DrawComboBox("CboProjectTimesheetApprover", "select '1'",,, "data-live-search='true' class='selectpicker form-control'", False,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                   
                                </div>

                                <!-- Flag 6 -->
                                <div class="settingSec IR_SettingSec ms-1">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="IR_setting">
                                                <p class="noteDesc mt-2 mb-0 text-end"><i class="far fa-sticky-note me-2"></i>
                                                    <small>To configure multiple IR Approver/IR Generator refer IR related setting in Practice Setting of project.</small>
                                                </p>
                                                <div class="row">
                                                    <div class="col-sm-6 mb-4">
                                                        <div class="row">
                                                            <label class="validationLabel mb-2">7&#10089; <%= MyBase.GetResourceString("C_IRApprover")%></label>
                                                            <div class="col-sm-10 col-lg-7 col-8">
                                                               
                                                               <%CommonFunctions.HTMLControls.DrawComboBox("CboProjectIRApprover", "select '1'",,, "data-live-search='true' class='selectpicker form-control'", False,, ) %>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6 mb-2">
                                                        <div class="row">
                                                            <label class="validationLabel mb-2">8&#10089; <%= MyBase.GetResourceString("C_IRGenerator")%></label>
                                                            <div class="col-sm-10 col-lg-7 col-8">
                                                               
                                                                 <%CommonFunctions.HTMLControls.DrawComboBox("CboProjectIRGenerator", "select '1'",,, "data-live-search='true' class='selectpicker form-control'", False,, ) %>
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
                <!-- Timesheet Setting Section ends -->
             

                 <!-- Timesheet Help Section starts -->
                <div class="offcanvas offcanvas-end helpOffcanvas" data-bs-scroll="false" tabindex="-1"
                    id="offcanvas_Help" aria-labelledby="offcanvas_help">
                    <div class="offcanvas-body">
                        <div id="help_Details" class="help_Details">
                            <div class="help_Details_Header d-flex justify-content-between">
                                <div class="Overlay-title"></div>
                                <div class="help_Details_HeaderBtns">
                                </div>
                            </div>
                            <div class="graybg container-fluid pt-1 pb-1 mb-2">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h5 class="pgtitle"><%= MyBase.GetResourceString("C_HelpTS")%></h5>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-sm-12 ">
                                    <div class="row">
                                        <div class="col-sm-6">
                                        </div>
                                        <div class="col-sm-6 text-end">

                                            <button type="button" class="btn borderbtn closebtn text-end" data-bs-toggle="tooltip" title="Close"
                                                data-bs-dismiss="offcanvas" data-bs-container="body" data-bs-placement="top">
                                                <%= MyBase.GetResourceString("C_Close")%>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                           

                            <div class="TS_HelpScreen px-3">
                                <div class="TS_Info mb-3">
                                    <h5 class="reportHeading mb-2">Introduction -</h5>
                                    <ul class="topicList">
                                        <li>Creating and managing project timesheets involves several crucial steps, including configuring commercial types, defining project sites, site details, role configurations, and site calendars. Additionally, it's important to manage resource site details, employee transfers between sites, and billing information.</li>
                                        <li>Once these initial setups are complete, you can add project timesheets, which require details such as project name, commercial type, date range, working days, rates, and currency. After generating a timesheet, it may need further actions like easy edit, multi-edit, smart edit, and regenerating.</li>
                                        <li>Billing information is  configured based on various criteria such as rate method and location, ensuring accurate invoicing. The timesheet can be sent for approval, where a configured approver can review and either approve or reject it.</li>
                                        <li>Upon approval, the project timesheet can be attached to an invoice request as an item, marking it as billable. This streamlined process ensures accurate billing for project work.</li>
                                        <li>This document will help you to guide the overall flow of a project timesheet, providing detailed information and instructions for each step in the process.</li>
                                    </ul>
                                </div>

                                <hr />

                                <div class="PrerequiInfo pt-2" id="PrerequisitesInfo">
                                    <div class="reportHeading mb-2">Prerequisites -</div>
                                    <ul class="outerList">
                                        <li>Project Creation, Resource allocation and tasks creation :</li>
                                        <ul class="innerList mb-2">
                                            <li>Understand the details of the project, including its name, scope, objectives, and other relevant project information.</li>
                                            <li>Define the commercial type for the project (e.g., T&M by Resource, T&M by Role) based on the project's nature and billing requirements.</li>
                                            <li>Project Should be billable.</li>
                                            <li>Resources should be allocated on project.</li>
                                            <li>Billable tasks should get created for resources and DA should get filled.</li>
                                        </ul>
                                        
                                        <li>Site Configuration:</li>
                                        <ul class="innerList mb-2">
                                            <li>Identify the default site for the project and any other sites where the project is being executed simultaneously.</li>
                                            <li>Gather site-specific information such as site name, short name, currency, rate method, working days, working hours, etc.</li>
                                            <li>Specify the starting day of the work week for the site.</li>
                                            <li>Determine if the site is an offshore site and configure</li>
                                        </ul>

                                        <li>Role Configuration on site:</li>
                                        <ul class="innerList mb-2">
                                            <li>Define the roles and associated resource rates for the project site.</li>
                                            <li>Gather information on normal rates, extra rates, and holiday rates for each role.</li>
                                        </ul>

                                        <li>Site Calendar:</li>
                                        <ul class="innerList mb-2">
                                            <li>Identify project holidays, including official holidays and non-working days for the site.</li>
                                            <li>Understand the impact of filling Daily Activities (DA) on project holidays and how it affects actual
                                                Hours.</li>
                                        </ul>

                                        <li>Resource Site Details:</li>
                                        <ul class="innerList mb-2">
                                            <li>Capture and manage employee-related information for project sites.</li>
                                            <li>Ensure you have employee names, roles, transfer dates, and site transfer details.</li>
                                        </ul>

                                        <li>Employee Billing Rate History:</li>
                                        <ul class="innerList mb-2">
                                            <li>Track changes in billing rates for resources.</li>
                                            <li>Collect data on site, role, effective date, normal rate, extra rate, holiday rate.</li>
                                        </ul>

                                        <li>Employee Site History:</li>
                                        <ul class="innerList mb-2">
                                            <li>Maintain records of employee site history, including names, roles, and transfer dates.</li>
                                            <li>Ensure you can edit this information when needed.</li>
                                        </ul>

                                        <li>Site transfers for employees:</li>
                                        <ul class="innerList mb-2">
                                            <li>Collect site-specific information, such as the site name, role, and effective date for each transfer.</li>
                                            <li>Ensure that resources are not transferred twice on the same effective date.</li>
                                            <li>Be prepared to transfer more than one resource at a time when necessary.</li>
                                        </ul>
                                    </ul>
                                </div>

                                <hr />

                                <div class="configSteps pt-2" id="configStepsInfo">
                                    <p>Once you have configured all the prerequisites, you can follow these steps to explore the project timesheet or understand the flow of the project timesheet process.</p>
                                    <p>This steps will give you a detailed view as below-</p>

                                    <div class="accordion Off_acordian_panel mb-3 mt-3 " id="configStepsAcc">
                                        <!-- Step 1 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading1">
                                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab1" aria-expanded="true"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">1. Create Project</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab1" class="accordion-collapse collapse show"
                                                aria-labelledby="configStepsHeading1" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <p>Creating a project and defining its mandatory details is an essential step in setting up a for project Timesheet.</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Step 2 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading2">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab2" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">2. Configure commercial Type [T&M  Commercial Type]</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab2" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading2" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <p>A contract providing for the procurement of services on the basis of direct work hours at specified fixed rates and material at cost. </p>
                                                        <ul class="outerList">
                                                            <li>T&M by Resource (Time and Materials):</li>
                                                            <ul class="innerList">
                                                                <li>In a Time and Materials engagement, the client is billed for the actual time worked by each resource on the project, plus the cost of materials.</li>
                                                                <li>In T&M by Resource Engagement  you can specify the rate for each of the resources working .
                                                                    on the project.</li>
                                                                <li>In this case, two resources with same role can be working on different rates.</li>
                                                            </ul>
                                                        </ul>
                                                        <p>[This billing structure considers the work hours spent by the resources working on the project and the expenses associated with the materials used during the project's execution.]</p>

                                                        <ul class="outerList">
                                                            <li>T&M by Resource with CAP: </li>
                                                            <ul class="innerList">
                                                                <li>This is a Time and Materials arrangement with a cap  on the total cost. </li>
                                                                <p>[Includes cap work hours i.e we can give configure max limit extra work hours for resources to allow .Configured extra work hours will considered for billing .]</p>
                                                                <li>In T&M by Resource Engagement  you can specify the rate for each of the resources working .</li>
                                                                <li>On the project. In this case, two resources with same role can be working on different rates.</li>
                                                            </ul>
                                                        </ul>

                                                        <ul class="outerList">
                                                            <li>T&M by Role: </li>
                                                            <ul class="innerList">
                                                                <li>In a T&M by Role engagement, the billing is based on the roles or positions of the resources involved in the project. Different roles may have different hourly rates.</li>
                                                                <li>In T&M by Role Engagement  you can specify the rate for the roles of resources working on the project. In this case, all resources of a role have same rates. </li>
                                                            </ul>
                                                        </ul>

                                                        <ul class="outerList">
                                                            <li>T&M by Role With CAP:</li>
                                                            <ul class="innerList">
                                                                <li>Similar to T&M by Role, this approach includes a maximum cost (cap) for each role or position. </li>
                                                                <p> [Includes cap work hours i.e. we can give configure max limit extra work hours for role to allow .Configured extra work hours will considered for billing .]</p>
                                                                <li>In T&M by Role CAP Engagement you can specify the rate for the roles of resources working on the project. In this case, all resources of a role have same rates. </li>
                                                            </ul>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Step 3 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading3">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab3" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">3. Project Site </p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab3" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading3" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>Whizible allows the users to define the default site, known as the default offshore site for the project, along with the other sites, where the project is in progress, simultaneously.</li>
                                                            <li>User can define multiple sites on the project.</li>
                                                            <p>[Path - Project >> Project information >> Commercials >> ADD New Site]</p>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>User can configure site details as- </li>
                                                            <ul class="innerList"> 
                                                                <li>Name:  Name of the site.</li>
                                                                <li>Short Name: An abbreviated name  for the site.</li>
                                                                <li>Currency: The currency used for billing purposes at this site.</li>
                                                                <li>Rate Method: Determines how billing rates are calculated (e.g., Person Hours for hourly billing,Person Month for monthly billing ,Person day for daily billing).</li>
                                                                <li>Starting Day of the Week: Specifies the first day of the workweek for the site.</li>
                                                                <li>Working Days as per Week: The number of working days in a week for this site (e.g., 5 days).</li>
                                                                <li>Working Hour(s) Per Day: The number of working hours per day at this site.(e.g., 8 Hr/day).</li>
                                                                <li>Extra Hour(s) Cap Per Day: Limits the number of additional work hours that can be billed in a day (e.g., 2 hours).</li>
                                                                <li>Working Hours Per Month: The total working hours for this site in a month.</li>
                                                                <li>Offshore Site: Indicates whether this site is the offshore default site for the project.</li>
                                                                <li>Address Details: Information about the physical location of the site, which can include the site's address.</li>
                                                            </ul>
                                                        </ul>
                                                        
            
                                                        <ul class="outerList mt-3">
                                                            <li>Also can add project site from-</li>
                                                            <p>(Project >> Plan >> Project sites)</p>
            
                                                            <li>Adding A Project Site </li>
                                                            <ol class="innerList">
                                                                <li>On the Project listing page select a project to work with. </li>
                                                                <li>On the Projects menu, click on Plan . From Plan menu, select Project 
                                                                    Sites </li>
                                                                <li>Project Sites details display the project site details under the headings Name, Short 
                                                                    Name, Offshore Site, Currency, Working Hours. </li>
                                                                <li>Click on the Add link on Project Sites. A new page opens which lets you to populate the 
                                                                    details of the project site. </li>
                                                                <li>Enter appropriate name of the project site in Name box. </li>
                                                                <li>Enter an appropriate abbreviation for the project site in Short Name box. </li>
                                                                <li>Narrate the contact details in Address1, Address2, City, Zip, and State box. </li>
                                                                <li>Select the name of the Country, from the list, where the project site lies. </li>
                                                                <li>Enter the other contact details such as Phone no, Email ID, Fax in the respective 
                                                                    boxes.</li>
                                                                <li>Usually enter the landmarks nearby, in the Remarks box. </li>
                                                                <li>Select a currency applicable for the site from the Currency list. </li>
                                                                <li>Mark the Offshore Site box if you wish to set the site as your default site. </li>
                                                                <li>Enter the working hours for the resources for the particular site in the Working Hours 
                                                                    box.</li>
                                                                <li>Enter the permissible extra hours cap in the Extra Hours Cap box. </li>
                                                                <li>Enter the duration of the week in Week Days box.</li>
                                                                <li>Select a starting day of the week from the list. </li>
                                                                <li>Click Save to save information of Project Site </li>
                                                                <li>Freeze Site Details link appears on Page.</li>
                                                            </ol>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Step 4 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading4">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab4" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">4. Role details Configuration on a site</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab4" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading4" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <p>Under Roles  tab the role wise resource rates for the project site under consideration 
                                                            are displayed.</p>
                                                        <p>
                                                            Path - <br /> ( I. Project >> Project information >> Commercials >>Edit site >> Role tab <br />
                                                            II.Project >> Project sites >> Edit Project site >> Add New Role )
                                                        </p>
            
                                                        <ul class="innerList">
                                                            <li>Role Rate tab displays details under the heads Normal Rate, Extra Rate, Holiday 
                                                                Rate. </li>
                                                                <li>Click on the Role to edit role.</li>
                                                                <li>Enter the required normal rate for the role rate applicable to the particular Project Site 
                                                                    in Normal Rate box. </li>
                                                                <li>Enter the extra rate for the role applicable for the particular Project Site in Extra Rate 
                                                                    box. </li>
                                                                <li>Enter the rate applicable for working on the holidays in Holiday Rate box. </li>
                                                                <li>Enter the cost incurred by the company for the resources of the particular role in  
                                                                    box.</li>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Option to add role details from Project >> Plan >> Project sites -</li>
                                                            <ul class="innerList">
                                                                <li>A new option, 'Add New Role,' will be added to the project site, allowing users to enter and save role details, including  'Normal rate,' 'Extra rate,' 'Holiday rate,' and 'Currency.' </li>
                                                                <li>This option will function similarly to the 'Add New Role' feature found in <br /> 'Project >> Project Information >> Commercials >> Edit Site >> Role >> Add New Role.</li>
                                                            </ul>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Step 5 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading5">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab5" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">5. Site Calender </p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab5" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading5" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>Whizible  provides for the viewing and setting site calendar.</li>
                                                            <li>Access the site calendar for the specific site where you want to configure project holidays.</li>
                                                            <li>Identify and mark the dates that are considered project holidays. These could be official holidays or non-working days for the site.</li>
                                                            <li>Site details Should be freezed after configuration of Holiday</li>
                                                        </ul>
            
                                                        <ul class="innerList">
                                                            <li>Click site calendar link. Calendar for the current month opens when clicked on the 
                                                                link.</li>
                                                            <li>Previous Month and Next Month allows the transit from current month to next or 
                                                                previous month. </li>
                                                            <li>Click on the date link in order to open the Site Calendar Details window. </li>
                                                            <li>All the fields in this window are editable. </li>
                                                            <li>Enter Normal Working hours in the Normal hours box. </li>
                                                            <li>Enter Extra hours in Extra hours box. </li>
                                                            <li>Mark the Is This a Holiday box if the particular day is set to be a holiday. <br />
                                                                (Holidays configured at OU and project holiday both will display.)</li>
                                                            <li>Click on Save to save the record. </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Step 6 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading6">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab6" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">6. Resource Site Details</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab6" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading6" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>Resource Site Details feature, as the name suggests, captures and manages the 
                                                                employee related information of a project site. </li>
                                                            <li>Very often, work orders related to projects are required to be carried out at more than one site, which calls for transfer of resources to sites other than the offshore site as onsite resources. </li>
                                                            <li>In such cases some of the employees may be required to be transferred as onsite resources. </li>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Viewing Employee Details <br /> (Project >> Plan >> Resource site Details)</li>
            
                                                            <ul class="innerList">
                                                                <li>Resource Site Details page displays the Employee Name, Role, Site, Transfer Date, 
                                                                    and Site Transfer. </li>
                                                                <li>You can streamline view by using Site filter. </li>
                                                                <li>To add Employee Site Details, click on the employee name link. Employee Site Details </li>
                                                                <li>Page opens with two sections, viz. Employee Current Site Details. </li>
                                                                <li>The name of the employee appears in read only form appears in the Employee Name 
                                                                    box. </li>
                                                                <li>Name of the site to which the employee belongs is displayed in Site box. </li>
                                                                <li>The date on which the employee was transferred to the site is displayed in Transfer Date box. </li>
                                                                <li>The role of the resource at the current site is displayed in Role box. </li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Adding Employee Billing Rate History </li>
                                                            <ul class="innerList">
                                                                <p>Under Employee Billing Rate History tab, the Details section enlists the details of 
                                                                    changes in the billing rate of the resource till date </p>
                                                                <li>The details are displayed under the titles...Site, Role, Effective Date From, Normal Rate, 
                                                                    Extra Rate, Holiday Rate.</li>
                                                                <li>Click Effective From Date link. </li>
                                                                <li>On the Employee Billing Rate History page, Project Ste and Role and Effective Form 
                                                                    Date details displayed. These are non-editable fields. </li>
                                                                <li>Select a date from the calendar that pops up on clicking the icon beside the Effective 
                                                                    Date From box. </li>
                                                                <li>Enter the normal rate applicable for the resource depending on the role in Normal Rate 
                                                                    box. </li>
                                                                <li>Enter the rate applicable for the extra work hours in Extra Rate box. </li>
                                                                <li>Enter the rate applicable for working on holidays in Holiday Rate box.</li>
                                                                <li>Save the record in order to view it in the list on the initial screen. </li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Employee Site History </li>
                                                            <p>Under Employee Site History tab, the details of employee sites till date are listed under 
                                                                this tab </p>
                                                            <ul class="innerList">
                                                                <li>Under the headings...Name, Role and Transfer Date </li>
                                                                <li>In order to edit the Employee Site History, click on the Name link. </li>
                                                                <li>In the edit mode, the Name field is in the read only format.</li>
                                                                <li>Select a role from the Role list. </li>
                                                                <li>Select the date of transfer from the calendar that pops up on clicking on the calendar 
                                                                    icon next to the field in Transfer Date list.</li>
                                                            </ul>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 7 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading7">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab7" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">7. Site Transfer </p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab7" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading7" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="outerList">
                                                            <li>Whizible provides option to transfer a resource from one site to another site with different rate and Role.</li>
                                                            <ul class="innerList">
                                                                <li>Select the Site from the Site list. </li>
                                                                <li>Select the Role from the Role list. </li>
                                                                <p>(In order to display a particular role in the role dropdown menu, you need to configure the resources associated with that role on the project. )</p>
                                                                <li>Select the date of transfer from the calendar that pops up on clicking on the calendar 
                                                                    icon next to the Effective Date field. </li>
                                                                <li>The Site Transfer Link is available on the Default page as well as on the edit 
                                                                    mode screen. </li>
                                                                <li>When transferring a resource from the default screen, mark the Site Transfer box and 
                                                                    click on the link. The window that opens is similar to the one opening on clicking the Site 
                                                                    Transfer link on the Edit screen.</li>
                                                                <li>A Resource cannot be transferred twice on the same Effective From Date.</li>
                                                                <li>More than one resource can be transferred at a time.</li>
                                                            </ul>                    
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Scenario I -</li>
                                                            <p>(In the given scenario, when a resource is scheduled to work at an offshore site (Pune) from September 1, 2023, to September 15, 2023, and is then required to transfer to an onsite location from September 16, 2023, to December 1, 2023, the "site transfer" feature can be employed to facilitate this transition.
                                                                <br />
                                                                Using the site transfer feature, you can smoothly manage and record the resource's move from the offshore site to the onsite location on the specified dates.)</p>
            
                                                            <p class="text-danger">[Billable tasks should be created and DA should get filled by Resources ]</p>
                                                            <p>Above all setup should be done before adding project Timesheet on Project - </p>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 8 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading8">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab8" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">8. Add Project Timesheet</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab8" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading8" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <P>On click  of  add timesheet user has to submit below details and generate timesheet.</P>
                                                        <P>To generate timesheet requires details as-</P>

                                                        <ul class="innerList">
                                                            <li><span class="font-weight-500">Project Name-</span> Name of session project will be reflected here.</li>
                                                            <li><span class="font-weight-500">Commercial Type-</span> Engagement configured on project should be reflcted here (non editable)</li>
                                                            <li><span class="font-weight-500">From date-</span> By default from date will reflect depending on rate method also user can also select a date.</li>
                                                            <li><span class="font-weight-500">To date-</span> It can be selectable and also reflect by default on the selection of from date.- </li>
                                                            <li><span class="font-weight-500">OU working days-</span> It will get updated from the selected start date and end date.</li>
                                                            <li><span class="font-weight-500">Working Hr/Day-</span> Working Hr /day configured for site will get reflected here .</li>
                                                            <li><span class="font-weight-500">Discount %-</span> User should able to define Discount percentage in range of 0-100 .</li>
                                                            <li><span class="font-weight-500">Project Currency-</span> Currency which is mapped on Project information >> Currency will reflect here (Non editable).</li>
                                                            <li><span class="font-weight-500">Rate method-</span>  only Rate method configured on site will be displayed here .(Suppose there are two sites with rate methods person Hour  and month then both rate methods will get displayed in rate method dropdown.) </li>
                                                            <li><span class="font-weight-500">Site validation-</span> User should able to select site validation as Yes or No.</li>
                                                            <li><span class="font-weight-500">Invoice conversion Date-</span>
                                                                <ul class="numList">
                                                                    <li>Invoice Conversion date should be any date less than future date .</li>
                                                                    <li>Conversion should be defined for the selected date and if not defined note will get displayed as <span class="font-weight-500">“currency conversion rate for project currency to base currency is  not defined please contract administration.”</span></li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 9 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading9">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab9" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">9. Generate Timesheet</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab9" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading9" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>After adding a timesheet and clicking on the "Generate" link, the system will display a list of employees who have filled out timesheets between the selected "From" date and "To" date. </li>
                                                            <li>The grid data will provide details such as the employee's name, the timesheet submission date, the start date, end date, and the status of the timesheet.</li>
                                                            <li>Additionally, the system will also display a list of employees who have not filled out timesheets within the selected time duration.</li>
                                                            <li>If you have different sites with different rate methods and generate timesheets, 
                                                                timesheet will be consider only one rate method at a time .</li>
                                                            <li>User should create multiple timesheet if there are multiple rate method.</li>
                                                            <li>In the 'Working Options' section, you can find the 'Project Timesheet Overlap Validation' option under the 'Timesheet Settings' tab.When the checkbox is enabled, project timesheets will not be generated for overlapping dates.</li>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Scenario II-</li>
                                                            <p>(For example, if you have two sites, such as Kochi_Offshore, which uses a rate method of 'Person Day,'  and Mumbai_Onsite, which uses a rate method of 'Person Month,' 
                                                                and both sites resources fill timesheets for the period from  1st September 2023 to 15th September 2023, the generated timesheet for same period, User should create different timesheet for different rate method)</p>
                                                            <p>If you click on the "Generate Timesheet" option, it will provide you with various actions in a dropdown menu.</p>
                                                            <p>These actions can include:</p>
                                                            <ul class="innerList">
                                                                <li>Easy Edit: This option allows for quick and easy edits to the timesheet data.</li>
                                                                <li>Update WSR: This action lets you update the Work Status Report (WSR) associated with the timesheet.</li>
                                                                <li>Regenerate: You can use this option to regenerate the timesheet.</li>
                                                                <li>Send for Approval: This action initiates the approval process for the timesheet , can send to the approval.</li>
                                                                <li>Billing Information : All calculative details will displays here as- <br />
                                                                    Billing Rate, Actual Hours, Working Day’s, No of day’s worked, Daily Rate, Invoice Amount, Discount, Expense, Final Amount, PM Edited Value.</li>
                                                                <li>Generate WSR: This action generates a Work Status Report based on the timesheet data.</li>
                                                                <li>Show History: This option provides a history of changes and actions related to the timesheet.</li>
                                                            </ul>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 10 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading10">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab10" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">10. Easy Edit</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab10" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading10" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>Easy edit allow users to modify efforts for billing purpose without changing actual resource efforts.</li>
                                                            <li>It will help project manager for modify efforts as per business requirement.</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 11 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading11">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab11" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">11. Multi Edit</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab11" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading11" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>Multi edit facility is provided using which you can edit the project timesheet of the 
                                                                resources who enter daily activity for the selected period. </li>
                                                            <li>In Multi-Edit, users can edit details such as Description and Actual Hours for multiple resources simultaneously.</li>
                                                            <li>Individual resource details can be edited with a save and edit option. </li>
                                                            <li>A checkbox has been provided to select a resource for deletion.</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 12 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading12">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab12" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">12. Smart Edit</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab12" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading12" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>Smart edit is a configurable feature  can be configured  through backend if it is enabled user can utilize it.</li>
                                                            <li>The introduction of a new feature, 'Smart Edit,' empowers project managers to modify the Actual Hours  for specific resources.</li>
                                                            <li>After making the necessary changes, users can save and apply these changes. </li>
                                                            <li>The system will also present a proposed total hours calculation before finalizing the updates.</li>
                                                            <li>Proposed total hours displayed in a green color. </li>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Scenario III-</li>
                                                            <p>(When you've generated a timesheet for a 30-day period, the 'Easy Edit' feature requires you to edit resource efforts one day by one for  30 days. In contrast, with 'Smart Edit,' project managers have the convenience of making bulk updates for  resource efforts.Additionally, they can preview the proposed total hours before executing the actual updates.)</p>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Holiday Consideration - </li>
                                                            <ul class="innerList">
                                                                <li>Users now have the flexibility to configure 'Consider Cap (Hrs)' and 'Holiday Full (Hrs)' directly with the help of  the user interface when adding a timesheet. </li>
                                                                <li>The 'Consider Cap (Hrs)' option allows users to determine whether or not to consider extra hours. </li>
                                                                <li>On the other hand, the 'Holiday Full (Hrs)' option provides the choice to treat holiday hours as either full or capped, according to the defined site settings.</li>
                                                            </ul>
            
                                                            <ul class="outerList">
                                                                <li>A new flags called "Cap Consider" and "Holiday cap "has been introduced. </li>
                                                                <ul class="innerList">
                                                                    <li>If "Cap Consider" is set to "Yes" (i.e., set to 1), it will factor in cap hours (extra hours) as Actual Hours. </li>
                                                                    <li>If "Cap Consider" is set to "No" (i.e., set to 0), it will not include cap hours (extra hours) in the calculation of Actual Hours.</li>
                                                                </ul>
                                                            </ul>
            
                                                            <ul class="outerList">
                                                                <li>For the consideration of holiday caps or full holiday hours, the "Cap Hours" flag should be set to "Yes" (i.e., 1). </li>
                                                                <ul class="innerList">
                                                                    <li>If "Holiday Cap" is set to "Yes" (i.e., 1), it will only take the cap hours allowed during holidays. </li>
                                                                    <li>If "Holiday Cap" is set to "No" (i.e., 0), it will consider the actual hours filled on holidays.</li>
                                                                </ul>
                                                            </ul>
            
                                                            <ul class="outerList">
                                                                <li>In other words, if the "Cap Hours" flag is set to "Yes," you can use the "Cap Holiday" flag to decide whether you want to include only the cap hours on holidays (by setting it to "Yes") or if you want to consider the actual hours worked on holidays (by setting it to "No").</li>
                                                            </ul>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Step 13 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading13">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab13" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">13. Billing Information</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab13" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading13" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>The billing information page provides a comprehensive overview of the resource-wise and day-wise efforts on the site.</li>
                                                            <li>As well as detailed information about the resources for whom timesheets have been generated. </li>
                                                            <li>This feature is designed to facilitate precise billing according to the location of resources, distinguishing between onsite and offshore work.</li>
                                                            <li>The billing information page provides a comprehensive bird's-eye view of the project's timesheet resource-wise billing information.</li>
                                                            <li>Here's a breakdown of the key elements displayed on the billing information page:</li>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Billing Rate: </li>
                                                            <ul class="innerList">
                                                                <li>This is the agreed-upon rate at which each resource is billed .</li>
                                                                <li>Billing rate of employee will get reflect here. <br />
                                                                    (Billing rate will vary as site validation is set to yes or no)</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Actual Hours: </li>
                                                            <ul class="innerList">
                                                                <li>This figure represents the number of hours worked by each resource during the billing period.</li>
                                                                <li>DA Filled by Resource will be considered as Actual hours and get reflect here.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Working Days: </li>
                                                            <ul class="innerList">
                                                                <li>It indicates the total number of days that each resource was actively engaged in their tasks.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>No Days Worked: </li>
                                                            <ul class="innerList">
                                                                <li>In duration how many days resource has worked should get reflect here.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Daily Rate: </li>
                                                            <ul class="innerList">
                                                                <li>The daily rate is derived from the billing rate and is used to calculate the invoice amount for each working day.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Invoice Amount: </li>
                                                            <ul class="innerList">
                                                                <li>The total amount to be invoiced for each resource, calculated by multiplying the daily rate by the number of working days.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Discount: </li>
                                                            <ul class="innerList">
                                                                <li>If any discounts are applicable, they are factored in to reduce the overall invoice amount.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Expense: </li>
                                                            <ul class="innerList">
                                                                <li>This section accounts for any additional expenses incurred during the project, which are included in the billing.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>Final Amount: </li>
                                                            <ul class="innerList">
                                                                <li>The final amount is the sum of the invoice amount and any expenses, minus any applicable discounts. It represents the total cost for each resource.</li>
                                                            </ul>
                                                        </ul>
            
                                                        <ul class="outerList">
                                                            <li>PM Edited Value: </li>
                                                            <ul class="innerList">
                                                                <li>If there were any modifications or adjustments made by the project manager, these changes are reflected here.</li>
                                                            </ul>
                                                        </ul>
            
            
                                                        <ul class="outerList">
                                                            <li>Billing information Details-</li>
                                                            <ul class="innerList">
                                                                <li>[Rate Method - Person Hour >> High-level view]-</li>
                                                                <li>[Rate Method - Person Day >> High-level view]-</li>
                                                                <li>[Rate Method - Person Month >> High-level view]-</li>
                                                            </ul>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 14 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading14">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab14" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">14. Regenerate Timesheet</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab14" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading14" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <p>This feature enables you to regenerate a timesheet. After the timesheet is regenerated, the status of the timesheet will be updated to "Regenerated."</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 15 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading15">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab15" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">15. Send for Approval</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab15" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading15" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <p>[Project Timesheet Approval's configuration- <br /> Project >> Project Information >> Practice Setting >> configuration setting >>General setting >> Project timesheet Approver]</p>

                                                    <ul class="innerList"> 
                                                        <li>After the generation of the timesheet, it will be ready for  approval.</li>
                                                        <li>It will then progress through the approval process. </li>
                                                        <li>iii.When timehseet will be send for the approval it will navigate to the Approval's 
                                                            Side. <br /> (Invoicing >> Project Timesheet Approval) </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 16 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading16">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab16" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">16. Approve Project Timesheet</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab16" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading16" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>The configured project timesheet approver has the authority to approve a project timesheet.</li>
                                                            <li>Only after the approval of the project timesheet can it be attached to the IR as an IR item. </li>
                                                            <li>The approver can either approve or reject the timesheet.</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Step 17 -->
                                        <div class="accordion-item mb-3">
                                            <h2 class="accordion-header" id="configStepsHeading17">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#configStepsTab17" aria-expanded="false"
                                                    aria-controls="EditReqDetailsTab">
                                                    <p class="numTitle">17. Add Project Timesheet to IR as  IR Item</p>
                                                </button>
                                            </h2>
                
                                            <div id="configStepsTab17" class="accordion-collapse collapse"
                                                aria-labelledby="configStepsHeading17" data-bs-parent="#configStepsAcc">
                                                <div class="accordion-body">
                                                    <div class="configStepsHelpScreen">
                                                        <ul class="innerList">
                                                            <li>When a project timesheet is approved, it can be mapped to an IR-PIR (Invoice Request - Purchase Invoice Request) as an IR (Invoice Request) item.</li>
                                                            <li>A new feature has been added to the project timesheet. If the timesheet is mapped to an IR and is in an approved state, it can now be directly raised to the IR from project timesheet page only.</li>
                                                            <li>When a project timesheet is added to an IR-PIR, the calculative details and the total displayed on the billing information page will automatically reflect the changes after the project timesheet is added as an IR item.</li>
                                                        </ul>
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
                <!-- Timesheet Help Section ends -->

      <!--Submit IR modal start here-->
    <div class="modal custmodal fade" id="SubmitIRModal" aria-hidden="true"  data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="lblSubmit"><%= MyBase.GetResourceString("C_Checklist")%> </h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"  onclick="CancelFrom_BillingPage()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="DivChecklist">
                    <table class="table table-bordered" style="width:100%;" id="submitIRTbl">
                        <thead>
                            <tr>
                                <th class="col-sm-1"><%= MyBase.GetResourceString("C_SrNo")%> </th>
                                <th class="col-sm-6"><%= MyBase.GetResourceString("C_ChecklistItem")%> </th>
                                <th class="col-sm-1"><%= MyBase.GetResourceString("C_Yes")%></th>
                                <th class="col-sm-4"><%= MyBase.GetResourceString("C_Comments")%> </th>
                            </tr>
                        </thead>
                        <tbody id="TbodySubmiteIR">
                            
                    
                        </tbody>
                    </table>
                    <br />
                    <div class="clearfix"></div>
                    <div class="text-center" >
                        <button class="btn btnyellow" id="submitIRSaveBtn" onclick="SaveChecklistItems()" ><%= MyBase.GetResourceString("C_Save")%></button>
                        <button class="btn borderbtn" id="submitIRCancelBtn" data-bs-dismiss="modal" onclick="CancelFrom_BillingPage()"><%= MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                   </div>
                     <div id="DivSubmitIR" style="display:none">
                         <div class="row">
                        <div class="col-sm-12">
                            <div class="row form-group mb-3">
                                <div class="col-sm-4 d-flex justify-content-end">
                                    <label  class="required"><%= MyBase.GetResourceString("C_Status")%> : </label>
                                </div>
                                <div class="col-sm-3">
                                    <%--<select class="selectpicker" data-live-search="true" id="modifiedHisField">
                                        <option>Select Status</option>
                                        <option>Submitted</option>
                                    </select>--%>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboIRStatus", "usp_Whizible2_Sel_StatusIR",,, " data-live-search='true' class='selectpicker'", False,, ) %>
              
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row form-group mb-3">
                                <div class="col-sm-4 d-flex justify-content-end">
                                    <label class="required"><%= MyBase.GetResourceString("C_Comment")%> : </label>
                                </div>
                                <div class="col-sm-8">
                                    <textarea rows="3" class="form-control required" id="IRCommets"></textarea>
                                </div>
                            </div>
                            
                            <label class=""></label>
                        </div>
                    </div>
                    <div class="text-center mt-2 mb-2">
                        <a href="javascript:;" class="btn borderbtn"  onclick="SubmitIR()"><%= MyBase.GetResourceString("C_Submit")%></a>
                        <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" onclick="CancelFrom_BillingPage()"><%= MyBase.GetResourceString("C_Cancel")%></a>
                    </div>

                   
                      </div>
                </div>
            </div>
        </div>
    </div>
    <!--Submit IR modal end here -->

   

    <%Else %>
    <div id="NotAccess" class="tab-pane" style="height: 448px">
                        <div style="text-align: center" class="box box-solid">
                            <p><%= MyBase.GetResourceString("C_NotAccess")%>. </p>
                        </div>
                    </div>
    <%End If %>
  <!--Page modal start here-->
    <!--Timesheet Details modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="billine_info_details" tabindex="-1" role="dialog" data-bs-backdrop="static" data-keyboard="false"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_TimesheetDetails")%> </h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                   <div class="row mb-2">
                       <div class="col-sm-7">
                           <div class="timesheet_details_rate">
                                <span class=" method mx-2"><%= MyBase.GetResourceString("C_RateMethodPerDay")%> </span>
                                <span id="GRateMethod"></span> [ Calculated as per <span id="GCRateMethod"></span> ]
                            </div>
                       </div>
                       <div class="col-sm-5 text-end">
                                                    <div class="legend float-end">
                                                        <ul class="">
                                                            <%--<li>
                                                                <label class="mx-1"><%=MyBase.GetResourceString("C_Legends") %>:</label></li>--%>
                                                           
                                                            <li>
                                                                <span class="lgdHoliday" data-bs-toggle="tooltip"
                                                                    data-bs-container="body" aria-label="Holiday"
                                                                    data-bs-original-title="Holiday Effort"></span>
                                                            </li>
                                                           
                                                        </ul>
                                                    </div>
                                                </div>
                   </div>
                    
                     
                    <div id="tbl_Employee" class="init_grid_panel">
                        <table class="table table-bordered table-stripped highlight-tbl stickytable"
                               style="width:120%;">
                            <thead>
                                <tr>
                                    <th width="5%"><%= MyBase.GetResourceString("C_SiteCaption")%> </th>
                                    <th width="5%"><%= MyBase.GetResourceString("C_Resource")%>  </th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_Date")%> </th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_NormalHours")%> </th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_NormalRate")%> </th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_NormalBillingTotal")%> </th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_ExtraHours")%></th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_ExtraRate")%> </th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_ExtraBillingTotal")%> </th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_BillableHours")%></th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_BillableTotal")%> </th>
                                    <th width="8%"><%= MyBase.GetResourceString("C_NonBillableHours")%></th>
                                    <th width="6%"><%= MyBase.GetResourceString("C_NonBillableRate")%></th>
                                    <th width="7%"><%= MyBase.GetResourceString("C_NonBillableTotal")%> </th>
                                </tr>
                            </thead>
                            <tbody id="bodyTimesheet">
                                
                            </tbody>
                        </table>
                    </div>
                    <div class="text-center">
                        <a href="javascript:;" class="btn borderbtn" data-bs-dismiss="modal"> <%= MyBase.GetResourceString("C_Close")%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Timesheet Details modal end here-->

    <!--WSR modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="wsrModal" tabindex="-1" role="dialog" data-bs-backdrop="static" data-keyboard="false"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_WeeklyStatusReport")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_To")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span><strong><span id="spncustomername"></span></strong></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_CreatedDate")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span id="CreatedDate"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_ProjectName")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span id="ProjectName"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_FromDate")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span id="FromDate"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_ToDate")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span id="ToDate"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_From")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span id="From"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_Subject")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span id="Subject"></span>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="highlight-wrap form-group">
                        <h5><strong><%= MyBase.GetResourceString("C_HighLights")%> :</strong><span id="WSRHighLights""></span></h5>
                        <p><strong><%= MyBase.GetResourceString("C_StatusActivities")%></strong></p>
                        <table class="table table-bordered highlight-tbl">
                            <thead>
                                <tr>
                                    <th class="text-start"><%= MyBase.GetResourceString("C_Taskname")%></th>
                                    <th><%= MyBase.GetResourceString("C_TimeSheetWork")%></th>
                                    <th><%= MyBase.GetResourceString("C_Status")%></th>
                                </tr>
                            </thead>
                            <tbody id="TbodyWSRTasKDetails">
                               
                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_Slippage")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                 <span class="mr-10" id="WSRSlippage"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_IssuesandConcerns")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                  <span class="mr-10" id="WSRIssues"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_Suggestions")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span class="mr-10" id="WSRSuggestions"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_Thenextperiod")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span class="mr-10" id="WSRFromDate"></span>  <%= MyBase.GetResourceString("C_To")%>  <span class="mlr-1" id="WSRToDate"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 text-end pr-0">
                                <label><%= MyBase.GetResourceString("C_Notesforthenextperiod")%> :</label>
                            </div>
                            <div class="col-sm-8 colon-class">
                                <span class="mr-10" id="WSRNextWeek"></span>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <a href="javascript:;" class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close")%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--WSR modal end here-->
    <!--Select Customer Address modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Select_Customer_Address" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">
                       <%= MyBase.GetResourceString("C_CustomerAddress")%> 
                    </h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-3">
                                            <div class="col-sm-6 text-end">
                                                <label><%= MyBase.GetResourceString("C_CusName")%> :</label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label class="custname" id="CustomerNameDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-3">
                                            <div class="col-sm-6 text-end">
                                                <label><%= MyBase.GetResourceString("CustomerAddress")%> :</label>
                                            </div>
                                            <div class="col-sm-6 text-start mb-3">
                                                  <%CommonFunctions.HTMLControls.DrawComboBox("CboCustomerAddressDetails", "select '1'",,, " class='selectpicker' data-live-search='true'", False,, ,,, False) %>
                                            <input type="hidden" id="TexthiddenCustomerAddressID" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row graybg">
                        <div class="col-sm-12">
                            <label class="pt-1 pb-1">
                               <label><%= MyBase.GetResourceString("C_AddressDetails")%> :</label>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-3">
                                            <div class="col-sm-2 text-end">
                                                <label><%= MyBase.GetResourceString("C_Address")%> :</label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="CustomerAddressDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%= MyBase.GetResourceString("C_City")%> :</label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="CustomerCityDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%= MyBase.GetResourceString("C_State")%> :</label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="CustomerStateDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%= MyBase.GetResourceString("C_Country")%>  :</label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="CustomerCountryDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%= MyBase.GetResourceString("C_ZIPCode")%> :</label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="CustomerZIPCodeDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%= MyBase.GetResourceString("C_FaxNo")%> :</label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="CustomerFaxNoDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row mt-1">
                                            <div class="col-sm-2 text-end">
                                                <label><%= MyBase.GetResourceString("C_TelephoneNo")%>  :</label>
                                            </div>
                                            <div class="col-sm-10 text-start">
                                                <label id="CustomerTelephoneNoDetails"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-3">
                        <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" id="btnclose"><%= MyBase.GetResourceString("C_Close")%></a>
                        <a href="javascript:;" class="btn btnyellow"  id="btnsave" onclick="SaveCustomerAddressDetails()"><%= MyBase.GetResourceString("C_Save")%></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <div class="modal custmodal Issuesave_filter fade" id="Select_MoreDetails" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">
                       <%= MyBase.GetResourceString("C_MoreDetails")%> 
                    </h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                 
                    <div class="text-center mt-3">
                        <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" id="btnclose"><%= MyBase.GetResourceString("C_Close")%></a>
                       
                    </div>
                </div>
            </div>
        </div>
    </div>

       <div class="modal custmodal fade" id="RMmodal" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false" >
                    <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                    <div class="modal-header">
                    <h5 class="modal-title" id="" ><%= MyBase.GetResourceString("C_NotificationAlert")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    </div>
                    <div class="modal-body">
                    <p class="text-center" id="spnalert"></p>
                    <div class="clearfix"></div>

                    <br />
                <%--    <div class="text-center">
                    <button class="btn btnyellow" onclick="Regenrate_OnClick()" data-dismiss="modal"><%= MyBase.GetResourceString("C_Ok")%></button>
                    </div>--%>
                           <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                      
                                        <button class="btn borderbtn ml-1"  data-bs-dismiss="modal" onclick="Regenrate_OnClick(0)"><%=MyBase.GetResourceString("C_No") %></button>
                                       
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="Regenrate_OnClick(1)" style="float:right"  data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Yes") %></button>
                                    </div>
                                </div>
                            </div>
                    </div>
                    </div>

                    </div>
                    </div>

        <div id="deleteinfomodal_List" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog modalsmall">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title" style="text-align: center;"><%=MyBase.GetResourceString("C_Delete") %></h4>
                        </div>

                        <div class="modal-body">

                            <p align="center"><%=MyBase.GetResourceString("C_DeleteConfirmationAlert") %></p>

                            <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">

                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="DeleteTSData_Biiling(0)"><%=MyBase.GetResourceString("C_No") %></button>

                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="DeleteTSData_Biiling(1)" style="float: right" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Yes") %></button>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

    <!--Send for approval modal end here-->
    <!--Show Details Modal start here-->
    <div class="modal custmodal fade" id="ShowDetailsModal" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_ShowDetails") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="accordion Init_acordian_panel mb-3 mt-3 " id="contractMasterAcc">
                        <div class="accordion-item mb-3">
                            <h2 class="accordion-header" id="contractMasterHeading">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#contractMasterTab" aria-expanded="true"
                                        aria-controls="collapseOne">
                                    <%=MyBase.GetResourceString("C_ContractMaster") %> 
                                </button>
                            </h2>
                            <div id="contractMasterTab" class="accordion-collapse collapse show "
                                 aria-labelledby="contractMasterHeading" data-bs-parent="#contractMasterAcc">
                                <div class="accordion-body">
                                    <div class="contractMasterDiv">
                                        <div class="form-group mb-3">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=""><%=MyBase.GetResourceString("C_ContractSummary") %>:</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="" id="lblContractSummary"></label>
                                                          
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end ">
                                                            <label class=""><%=MyBase.GetResourceString("C_ContractDetails") %> :</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=""  id="lblContractDetails"></label>
                                                            
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
                                                            <label class=" "><%=MyBase.GetResourceString("C_CustomerContract") %> :</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=" " id="lblCustomerContract"></label>
                                                          
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_ContractType") %> :</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=" " id="lblContractType"> </label>
                                                           
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
                                                            <label class=" "><%=MyBase.GetResourceString("C_CommencementDate") %> :</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=""  id="lblCommencementDate"></label>
                                                           
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_ContractSigningDate") %> :</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="" id="lblContractSigningDate"></label>
                                                           
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
                                                            <label class=""><%=MyBase.GetResourceString("C_ContractExpiryDate") %>:</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class=""  id="lblContractExpiry"></label>

                                                           
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end ">
                                                            <label class=""><%=MyBase.GetResourceString("C_POSOWNumber") %>:</label>
                                                        </div>
                                                        <div class="col-sm-6">

                                                            <label class="" id="lblPOSOWNumber"> </label>

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
                                                            <label class=" "><%=MyBase.GetResourceString("C_POSOWValue") %>:</label>
                                                        </div>
                                                        <div class="col-sm-6">

                                                            <label class=" " id="lblPOSOWValue"></label>
                                                           
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class=" "><%=MyBase.GetResourceString("C_Currency") %>:</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                           
                                                             <label class=" " id="lblContractCurrency"></label>
                                                             <%--<span id="lblContractCurrenySymbol" style="display:none"></span>--%>
                                                          
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
                                                            <label class="">  <%=MyBase.GetResourceString("C_CRMRef") %>:</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                          <label class=" " id="lblContractCRMRef"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <div class="col-sm-6 text-end">
                                                            <label class="">  <%=MyBase.GetResourceString("C_RemainingPOvalue") %>:</label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                          <label class=" " id="lblContractRemainingPOvalue"></label>
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
                            <h2 class="accordion-header" id="Edit_fiter_heading">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#ContractAttachmentsTab" aria-expanded="false"
                                        aria-controls="collapseTwo">
                                    <%=MyBase.GetResourceString("C_ContractAttachments") %>
                                </button>
                            </h2>
                            <div id="ContractAttachmentsTab" class="accordion-collapse collapse "
                                 aria-labelledby="Edit_fiter_heading" data-bs-parent="#contractMasterAcc">
                                <div class="accordion-body">
                                    <div class="ContractAttachmentsDiv">
                                        <div class="row">
                                            <table class="table table-stripped modalDTtabl table-bordered completiontbl" id="TblContractAttachment">
                                                <thead>
                                                    <tr>
                                                        <th><%=MyBase.GetResourceString("C_SrNo") %></th>
                                                        <th><%=MyBase.GetResourceString("C_FileName") %> </th>
                                                        <%--<th><%=MyBase.GetResourceString("C_FileSize") %> </th>--%>
                                                        <th><%=MyBase.GetResourceString("C_AttachedBy") %> </th>
                                                        <th><%=MyBase.GetResourceString("C_AttachedDate") %> </th>
                                                        <th><%=MyBase.GetResourceString("C_Description") %> </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="TbodyContractAttachment">
                                                  
                                                   
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group text-center mt-3">

                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Show Details modal end here-->
    <!--Save and apply modal start here-->
    <div class="modal custmodal  fade" id="saveAndApplyFilter" tabindex="-1" role="dialog"
         aria-labelledby="taskeditorlabel" aria-hidden="false" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As </h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="box-panel">
                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end">Filter Name :</label>
                                        <span class="col-md-8">
                                            <input type="hidden" name="FilterID" id="FilterID" value="0">
                                            <input type="hidden" name="QueryID" id="QueryID" value="0">
                                            <input type="Textbox" name="filterName" id="txtFilterName"
                                                   class="form-control" style="text-align:Left" maxlength="500" value=""
                                                   autocomplete="off"><br>
                                            <div class="btnrow">
                                                <button class="btn btnyellow float-start savefilter"
                                                        id="btnSaveBasicFilter">
                                                    Save
                                                </button>
                                                <button data-bs-dismiss="modal"
                                                        class="btn canclesaveasbtn borderbtn float-end">
                                                    Cancel
                                                </button>
                                            </div>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Save and apply modal end here-->

        <!--Sales Period Modal start here-->
    <div class="modal custmodal fade" id="SalesPeriodModal" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_IRSalesPeriod")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="CancelModal_Onclick()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="salesPersonFilter mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%= MyBase.GetResourceString("C_IsOpen")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                      
                                           <%CommonFunctions.HTMLControls.DrawComboBox("salesPeriodIsOpen", "Exec usp_Whizible2_Sel_YesNoValue NULL",,, " data-live-search='true' class='selectpicker' disabled", False,, ) %>    
                             
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%= MyBase.GetResourceString("C_SPSD")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="input-group">
                                           
                                              <% CommonFunctions.HTMLControls.DrawTextBox("salesPeriodStartDate", "salesPeriodStartDate", "form-control",,,,,,,, "white",, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                        
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button">
                                                    <i class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%= MyBase.GetResourceString("C_SPED")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="input-group">
                                           <%-- <input id="salesPeriodEndDate" class="form-control">--%>
                                              <% CommonFunctions.HTMLControls.DrawTextBox("salesPeriodEndDate", "salesPeriodEndDate", "form-control",,,,,,,, "white",, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                        
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button">
                                                    <i class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%= MyBase.GetResourceString("C_SPM")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                       
                                              <% CommonFunctions.HTMLControls.DrawTextBox("salesPeriodMonth", "salesPeriodMonth", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-2">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label class="text-end"><%= MyBase.GetResourceString("C_SPY")%></label>
                                    </div>
                                    <div class="col-sm-7">
                                      
                                         <% CommonFunctions.HTMLControls.DrawTextBox("salesPeriodYear", "salesPeriodYear", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <a href="javascript:;" id="SP_FilterBtn" onclick="showSP_FilterBtn('FromFilter')" class="textUndrln"><%= MyBase.GetResourceString("C_ShowFilter")%></a>
                            </div>
                        </div>
                    </div>

                    <div class="notebox graybg">
                        <strong>Note: </strong><span><%= MyBase.GetResourceString("C_SalePeriodNote")%>.</span>
                    </div>

                    <div class="row mb-2">
                        <table class="table table-stripped table-bordered completiontbl modalDTtabl mb-2">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_SPM")%></th>
                                    <th><%= MyBase.GetResourceString("C_SPY")%></th>
                                    <th><%= MyBase.GetResourceString("C_SPSD")%></th>
                                    <th><%= MyBase.GetResourceString("C_SPED")%></th>
                                    <th><%= MyBase.GetResourceString("C_IsOpen")%></th>
                                    <th><%= MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="TbodySales">
                                
                              
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>

                    <div class="form-group text-center ">
                        <%--<button class="btn btnyellow" onclick="savesalesperiod()"><%= MyBase.GetResourceString("C_Save")%></button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal" onclick="CancelModal_Onclick()"><%= MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Sales Period modal end here-->

    <!--Sales Person Modal start here-->
    <div class="modal custmodal fade" id="sales_person_modal" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""> <%= MyBase.GetResourceString("C_ASalesPerson")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="CancelModal_Onclick()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="salesPersonFilter mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-5">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label><%= MyBase.GetResourceString("C_SalePersonName")%>  </label>
                                    </div>
                                    <div class="col-sm-7">
                                     
                                          <% CommonFunctions.HTMLControls.DrawTextBox("salesPersonInput", "salesPersonInput", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                       
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <div class="row form-group">
                                    <div class="col-sm-5 pe-0 d-flex justify-content-end">
                                        <label><%= MyBase.GetResourceString("C_SalesCommission")%> &nbsp;%  </label>
                                    </div>
                                    <div class="col-sm-7">
                                      
                                          <% CommonFunctions.HTMLControls.DrawTextBox("salesComissionInput", "salesComissionInput", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                       
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <a href="javascript:;" id="showSP_FilterBtn"  onclick="showSPerson_FilterBtn('FromFilter')" class="textUndrln"><%= MyBase.GetResourceString("C_ShowFilter")%></a>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <table class="table table-stripped modalDTtabl table-bordered completiontbl mb-2">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_SalePersonName")%> </th>
                                    <th><%= MyBase.GetResourceString("C_SalesCommission")%>%</th>
                                    <th><%= MyBase.GetResourceString("C_Select")%></th>
                                </tr>
                            </thead>
                            <tbody id="TbodySalesCommission">
                              
                            
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix"></div>
                    <div class="form-group text-center ">
                        <button type="button" class="btn btnyellow" onclick="savesales()"><%= MyBase.GetResourceString("C_Save")%></button>
                        <button  type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="CancelModal_Onclick()"><%= MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Sales Person modal end here-->
    <!--Sales Person Modal start here-->
  
    <!--Sales Person modal end here-->
    <!--Sales Person Modal start here-->
    <div class="modal custmodal fade" id="Contract_Details_modal" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ContractDetails")%> </h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="CancelModal_Onclick()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row mt-3">
                                        <div class="col-sm-5 text-end">
                                            <label><%= MyBase.GetResourceString("C_ContractType")%> :</label>
                                        </div>
                                        <div class="col-sm-7 text-start mb-3">
                                         
                                             <%CommonFunctions.HTMLControls.DrawComboBox("CboContractType", "select '1'",,, " data-live-search='true' class='selectpicker' onchange='SelectContractType()'", False,, ) %>    
                             
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mx-1 mb-2">
                        <div class="table-responsive init_grid_panel">
                        <table class="table table-stripped modalDTtabl table-bordered completiontbl">
                            <thead>
                                <tr>
                                    <th>  <%= MyBase.GetResourceString("C_CustomerName")%> </th>
                                    <th>  <%= MyBase.GetResourceString("C_ContractSummary")%> </th>
                                    <th>  <%= MyBase.GetResourceString("C_ContractTypeName")%> </th>
                                    <th>  <%= MyBase.GetResourceString("C_CommencementDate")%> </th>
                                    <th>  <%= MyBase.GetResourceString("C_ContractSigningDate")%> </th>
                                    <th>  <%= MyBase.GetResourceString("C_ContractExpiryDate")%> </th>
                                    <th>  <%= MyBase.GetResourceString("C_POSOWNumber")%> </th>
                                    <th>  <%= MyBase.GetResourceString("C_POSOWValue")%> </th>
                                    <th> <%= MyBase.GetResourceString("C_Currency")%>  </th>
                                    <th>  <%= MyBase.GetResourceString("C_Select")%> </th>
                                </tr>
                            </thead>
                            <tbody id="tbodyContract">
                               
                            </tbody>
                        </table>
                            </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="form-group text-center ">

                        <button class="btn borderbtn mt-3 ml-1" data-bs-dismiss="modal" id="close_Contract_Details" onclick="CancelModal_Onclick()"><%= MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Sales Person modal end here-->
    <!--Page modal end here-->
    <!-- ./wrapper -->


     <div class="modal custmodal fade" id="DiffCurrencyConfirmation" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false" >
                    <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                    <div class="modal-header">
                    <h5 class="modal-title" id="" ><%= MyBase.GetResourceString("CConfirmationAlert")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    </div>
                    <div class="modal-body">
                    <p class="text-center" id="SpnDiffCurrencyConfirmation"></p>
                    <div class="clearfix"></div>

                    <br />
                           <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                      
                                        <button class="btn borderbtn ml-1"  data-bs-dismiss="modal" onclick="AllowToIRCreate(0)"><%=MyBase.GetResourceString("C_No") %></button>
                                       
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="AllowToIRCreate(1)" style="float:right"  data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Yes") %></button>
                                    </div>
                                </div>
                            </div>
                    </div>
                    </div>

                    </div>
                    </div>

      <div class="modal custmodal fade" id="DiffSiteCurrencyConfirmation" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false" >
                    <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                    <div class="modal-header">
                    <h5 class="modal-title" id="" ><%= MyBase.GetResourceString("CConfirmationAlert")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    </div>
                    <div class="modal-body">
                    <p class="text-center" id="SpnSiteDiffCurrencyConfirmation"></p>
                    <div class="clearfix"></div>

                    <br />
                           <div class="form-group mt-4">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 text-left">
                                      
                                        <button class="btn borderbtn ml-1"  data-bs-dismiss="modal" onclick="AllowToIRCreateWithSiteValidation(0)"><%=MyBase.GetResourceString("C_No") %></button>
                                       
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="AllowToIRCreateWithSiteValidation(1)" style="float:right"  data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Yes") %></button>
                                    </div>
                                </div>
                            </div>
                    </div>
                    </div>

                    </div>
                    </div>

   
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>


    <script>
         //Page Name : PM_ProjectTimesheetList
        //Created By : Dipali V
        //Created Date : 12th Sep 2023

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>'
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var ProjectID;
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        ProjectID = '<%= Session("intProjectID") %>';
        alertify.set('notifier', 'position', 'top-right');
        var SelectedID = [];
        var GlobalApplyID = "";
        var GlobalQueryText = "";
        var savedFilterName = "";
        var GlobalFilterID = "0";
        var GlobalFilterName = "";
        var FilterID = "";
        var Flag = "";
        var GlobalFilterFlag = "0";
        var tbl_New;
        var IsFilterApply = 0;
        var FilterProjectID;
        var Flag = "";
        var ReadyToAuthenticate = "";
        var Authenticated = "";
        var GFromWhereProject = "";
        var SelectedCurrentdate = "";
        var RestrictByMinHours = true;
        var MinHoursForDAEntry = "";
        var IsAllowToCreateIR = 0;
        var GTotalGeneratedTSCount = 0;
        var IsCreateIRItems = 0;
        $(document).ready(function () {
            StartLoader('#bodyPreloader')
            //if (document.getElementById('cboProject') != null) {
            //    document.getElementById('cboProject').insertBefore(new Option("Select Project", '0'), document.getElementById('cboProject').firstChild)
            //}
            //if (document.getElementById('cboProjectFilter') != null) {
            //    document.getElementById('cboProjectFilter').insertBefore(new Option("Select Project", '0'), document.getElementById('cboProjectFilter').firstChild)
            //}
            if ("<%= Request.QueryString("ProjectID")%>" != "") {
                
                ProjectID = "<%= Request.QueryString("ProjectID")%>";
            }


            GetMINDAValidation();
            Date.prototype.toShortFormat = function () {
                var month_names = ["Jan", "Feb", "Mar",
                    "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep",
                    "Oct", "Nov", "Dec"];

                var day = this.getDate();
                var month_index = this.getMonth();
                var year = this.getFullYear();

                return "" + day + " " + month_names[month_index] + " " + year;
            }
            SelectedCurrentdate = new Date();

            $("#cboProjectFilter").selectpicker({
                noneSelectedText: 'Select Project' // by this default 'Nothing selected' -->will change to Select Task Category
            });

            $("#cboProject").selectpicker({
                noneSelectedText: 'Select Project' // by this default 'Nothing selected' -->will change to Select Task Category
            });


            $("#cboStatus").selectpicker({
                noneSelectedText: 'Select Status' // by this default 'Nothing selected' -->will change to Select Task Category
            });

            $("#CboProjectTimesheetApprover").selectpicker({
                noneSelectedText: 'Select Project Timesheet Approver' // by this default 'Nothing selected' -->will change to Select Task Category
            });

         //   debugger;
            if (ProjectID != "") {
                $("#cboProject").val(ProjectID);
                //Added By Dipali V On 27th Oct 2023 For Clear Filter
                $("#cboProjectFilter").val(0);
                //if ($("#cboProjectFilter").val() == null) {
                //    $("#cboProjectFilter").val(0);
                //}
            } else {
                $("#cboProject").val(0);
                $("#cboProjectFilter").val(0);
            }
            //debugger;
            GetDefaultFilter();
            $('table').resize();
            $('#genTimsheetTbl, #viewTaskTbl, #editTaskName, .clr-filter-btn').hide();
            $(".selectpicker").selectpicker('refresh');
            StopAjaxLoader('#bodyPreloader')
        });

        //For Project onchange
        function GetProjectTimesheet(Flag) {
            StartLoader('#bodyPreloader')
            GFromWhereProject = Flag;
            GTotalGeneratedTSCount = 0;
            if (Flag == 'Main') {
                ProjectID = $("#cboProject").val();
            } else {
                ProjectID = $("#cboProjectFilter").val();
            }
            $("#dltAllTimsheet").prop("checked", false);
            GetProjectTimesheetList(null, $("#cboProject").val());
            $('table').resize();
            StopAjaxLoader('#bodyPreloader')
        }

        //For Datepicker
        $(function () {
            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
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
            $('#txtfromDateFilter, #txttoDateFilter').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy',
                onSelect: function (dateText) {
                    $(this).attr("title", dateText);
                }
            });

        });

        //For Apply Tooltip
        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip()
        })

        // For Modal pop up
        $('.modal').on('hidden.bs.modal', function () {
            $('.custmodal').load('.modal');
        });

        $("#AdvanceFilterIcon").on('click', function () {
            $('table').resize();
        });

        /*Added By Dipali V On 19th Aug 2023 For Project Timesheet List*/
       
        function GetProjectTimesheetList(QueryText, ProjectID) {
            GTotalGeneratedTSCount = 0;
            IsAllValuesInSiteCurrency = "";
            var StrHTML = "";
            var Parameter = "";
            ClearMainFilter();
            if (QueryText == undefined || QueryText == '' || QueryText == null) {
                QueryText = "";
                $("#ClearAllFilter").hide();
                $(".filterpanel").removeClass('in');
                $(".filterpanel").removeClass('show');
                //ClearBasicFilter("Version");
                GlobalApplyID = ''

                var FromDate = $("#txtfromDateFilter").val().trim();
                var ToDate = $("#txttoDateFilter").val().trim();
                var ActualWork = $("#txtAW").val().trim();
                var TimesheetID = $("#txtTimesheetID").val().trim();

                //var Status = $("#cboStatus").val();
                if ($("#cboStatus option:selected").text() == "Select Status") {
                    var Status = '';
                }
                else {
                    var Status = $("#cboStatus option:selected").text().replace("'", "''");
                }
                //debugger;
                //if (GFromWhereProject == 'Main') {
                //    ProjectID = $("#cboProject").val();
                //} else {
                //    if ($("#cboProjectFilter option:selected").text() == "Select Project") {
                //       ProjectID = '';
                //    }
                //    else {
                //      ProjectID = $("#cboProjectFilter").val();
                //    }
                //}
                if (IsFilterApply == 1 && $("#cboProjectFilter").val() != null) {
                    FilterProjectID = $('#cboProjectFilter').val()
                } else {
                    FilterProjectID = $("#cboProject").val();
                }


                var Parameters = {
                    ProjectID: encodeURI(FilterProjectID),
                    FromDate: encodeURI(FromDate),
                    ToDate: encodeURI(ToDate),
                    ActualWork: encodeURI(ActualWork),
                    TimesheetID: encodeURI(TimesheetID),
                    Status: encodeURI(Status)
                }
                var param = JSON.stringify(Parameters);

            } else {
                Parameter = QueryText.replace(new RegExp(/\"?\s*\+\s*form\s*\"?\s*\"?/g), '');
                var param = Parameter;
            }


            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/PM_ProjectTimesheetList", param, false);
            SelectedID = [];
            var Authenticated = "";
            $("#PTtbl").dataTable().fnDestroy();
            $("#TSBody").html('');


            for (var i = 0; i < strResult.length; i++) {
              //debugger
                GTotalGeneratedTSCount = strResult.length;
                Authenticated = strResult[i].Authenticated;
                TimesheetStatus = strResult[i].TimesheetStatus;
                IsAllValuesInSiteCurrency = strResult[i].IsAllValuesInSiteCurrency;
                IsAllowToCreateIR = strResult[i].IsAllowToCreateIR; // Added By Dipali V On 2nd Nov 2023 
                var EffortsCSS = "";
                if (parseInt(strResult[i].TSGeneratedEffortsDecimal) == parseInt(strResult[i].BillableHoursDecimal)) {
                    EffortsCSS = "";
                } else if (parseInt(strResult[i].TSGeneratedEffortsDecimal) > parseInt(strResult[i].BillableHoursDecimal)) {
                    EffortsCSS = "EffortsRed";
                }
                else if (parseInt(strResult[i].TSGeneratedEffortsDecimal) < parseInt(strResult[i].BillableHoursDecimal)) {
                    EffortsCSS = "EffortsGreen";
                }
                StrHTML += '<tr>';
                StrHTML += '<td><a href="#" onclick="Edit_Timesheet(' + strResult[i].TimeSheetNo + ',&quot; ' + strResult[i].FromDate + '&quot;,&quot;' + strResult[i].ToDate + '&quot;,&quot;' + strResult[i].TimesheetStatus + '&quot;,&quot;' + strResult[i].ProjectID + '&quot;)">' + strResult[i].TimeSheetNo + '</a></td>';
                // StrHTML += '<td><a href="#" onclick="WSR_OnClick(' + strResult[i].TimeSheetNo +')">' + strResult[i].WSR + '</a></td>';
                StrHTML += '<td><a data-bs-toggle="modal" data-bs-target="#wsrModal" href="#" onclick="WSR_OnClick(' + strResult[i].TimeSheetNo + ')">' + strResult[i].WSR + '</a></td>';
                StrHTML += ' <td>' + strResult[i].CreatedDate + '</td>';
                StrHTML += ' <td>' + strResult[i].FromDate + '</td>';
                StrHTML += ' <td>' + strResult[i].ToDate + '</td>';
                StrHTML += '<td>' + strResult[i].TSGeneratedEfforts + '</td>';
                //StrHTML += ' <td>';
                //StrHTML += '<a href="javascript:;" class="actualHrsLink" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="Timesheet Hours(Actual) : ' + strResult[i].TotalTimeSheetHours + ' <br /> Billed Hours :' + strResult[i].BillableHours + '">' + strResult[i].TotalTimeSheetHours + '';
                //StrHTML += '<img src="../../../Whizible2.0-new/dist/img/info-circle.svg" alt="" class="ms-2">';
                //StrHTML += '</a>';
               // StrHTML += '</td>';
                StrHTML += '<td class="' + EffortsCSS +'">' + strResult[i].BillableHours + '</td>';
                StrHTML += '<td>' + strResult[i].TimesheetStatus + '</td>';

                if (TimesheetStatus != "Generated" && TimesheetStatus != "Re-Generated") {
                    if (Authenticated == "Y" || Authenticated == "R") {
                        StrHTML += '<td><a href="javascript:void(0);" class="text_underline" Onclick="Billing_Information(' + strResult[i].TimeSheetNo + ',&quot; ' + strResult[i].FromDate + '&quot;,&quot;' + strResult[i].ToDate + '&quot;,&quot;' + strResult[i].TimesheetStatus + '&quot;,&quot;' + strResult[i].ProjectID + '&quot;,&quot;' + strResult[i].IsAllValuesInSiteCurrency + '&quot;)">' + strResult[i].BillingInformation + '</a></td>';
                        StrHTML += '<td><a href="javascript:void(0);" onclick="Print_Onclick(' + strResult[i].TimeSheetNo + ')" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Print_report" aria-controls="offcanvas_Print_report" class="text_underline">' + strResult[i].PrintReport + '</a></td>';
                        StrHTML += '<td><a href="#" Onclick=GetProjectTimesheetComments(' + strResult[i].TimeSheetNo + ') class="text_underline" data-bs-toggle="offcanvas"data-bs-target="#offcanvas_viewcomment" aria-controls="offcanvas_viewcomment">' + strResult[i].ViewComment + '</a></td>';
                    }
                    else if (Authenticated == "N") {
                        StrHTML += '<td><a href="javascript:void(0);" class="text_underline"  Onclick="Billing_Information(' + strResult[i].TimeSheetNo + ',&quot; ' + strResult[i].FromDate + '&quot;,&quot;' + strResult[i].ToDate + '&quot;,&quot;' + strResult[i].TimesheetStatus + '&quot;,&quot;' + strResult[i].ProjectID + '&quot;,&quot;' + strResult[i].IsAllValuesInSiteCurrency + '&quot;)">' + strResult[i].BillingInformation + '</a></td>';
                        StrHTML += '<td><a href="javascript:void(0);" onclick="Print_Onclick(' + strResult[i].TimeSheetNo + ')" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Print_report" aria-controls="offcanvas_Print_report" class="text_underline">' + strResult[i].PrintReport + '</a></td>';
                        StrHTML += '<td><a href="#">-</a></td>';
                    }
                    else {
                        StrHTML += '<td><a href="#">-</a></td>';
                        StrHTML += '<td><a href="#">-</a></td>';
                        StrHTML += '<td><a href="#" Onclick=GetProjectTimesheetComments(' + strResult[i].TimeSheetNo + ') class="text_underline" data-bs-toggle="offcanvas"data-bs-target="#offcanvas_viewcomment" aria-controls="offcanvas_viewcomment">' + strResult[i].ViewComment + '</a></td>';
                    }
                } else {
                    //StrHTML += '<td><a href="#">-</a></td>';
                    StrHTML += '<td><a href="javascript:void(0);" class="text_underline"  Onclick="Billing_Information(' + strResult[i].TimeSheetNo + ',&quot; ' + strResult[i].FromDate + '&quot;,&quot;' + strResult[i].ToDate + '&quot;,&quot;' + strResult[i].TimesheetStatus + '&quot;,&quot;' + strResult[i].ProjectID + '&quot;,&quot;' + strResult[i].IsAllValuesInSiteCurrency + '&quot;)">' + strResult[i].BillingInformation + '</a></td>';

                    StrHTML += '<td><a href="#">-</a></td>';
                    StrHTML += '<td><a href="#">-</a></td>';
                }

                StrHTML += "<td><div class='custom_chckbox' style='float:right;margin-right: -9px;'><input type='hidden' name='hdn_ParameterID' id='hdn_ParameterID' value= '" + strResult[i].TimeSheetNo + "'/><input id='" + strResult[i].TimeSheetNo + "' value='" + strResult[i].TimeSheetNo + "' onclick='checkUncheck();GetSelect(this);' name='ProjectTimesheet' class='chcktbl' type='checkbox'><label for='" + strResult[i].TimeSheetNo + "'></label></div></td>";
                StrHTML += '</tr>';

            }

            // 
            $("#TSBody").html(StrHTML);

            $.fn.DataTable.ext.pager.numbers_length = 5;
            tbl_New = $('#PTtbl').dataTable({
                "sScrollXInner": "100%",
                "sScrollY": (0.5 * $(window).height()),
                "scrollY": true,
                "scrollX": true,
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                // "destroy": false,
                "bFilter": false,
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] }]
            });

            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);

            $('table').resize();
            //var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
            //var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            //    return new bootstrap.Popover(popoverTriggerEl);
            //});
        }


        //For Get WSR Report
        function WSR_OnClick(intTimesheetNo) {
            var Parameters = {
                TimesheetNo: encodeURI(intTimesheetNo)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetWSRDetails", param, false);
            var WSRDetails = strResult.WSRDetails
            var OtherAttributes = strResult.OtherAttributes
            var WSR_Activities = strResult.WSR_Activities
            for (var i = 0; i < WSRDetails.length; i++) {
                 //debugger;
                $("#spncustomername").text(WSRDetails[i].CustomerName);
                $("#CreatedDate").text(WSRDetails[i].CreatedDate);
                $("#ProjectName").text(WSRDetails[i].ProjectName);
                $("#FromDate").text(WSRDetails[i].FromDate);
                $("#ToDate").text(WSRDetails[i].ToDate);
                $("#From").text(WSRDetails[i].CompanyID);
                $("#Subject").text(WSRDetails[i].Subject);
                $("#WSRFromDate").text(WSRDetails[i].ToDate);
                $("#WSRToDate").text(WSRDetails[i].NextPeriodToDate); // Add Date Diff of From Date & To Date in to ToDate
                $("#WSRSlippage").text(WSRDetails[i].Sleepage);
                $("#WSRIssues").text(WSRDetails[i].Issues);
                $("#WSRSuggestions").text(WSRDetails[i].Suggetion);
                $("#WSRNextWeek").text(WSRDetails[i].Activities);
            }

            //For WSR Details
            for (var i = 0; i < OtherAttributes.length; i++) {
                $("#WSRSlippage").text(OtherAttributes[i].Sleepage);
                $("#WSRIssues").text(OtherAttributes[i].Issues);
                $("#WSRSuggestions").text(OtherAttributes[i].Suggetion);
                $("#WSRNextWeek").text(OtherAttributes[i].Activities);
                $("#WSRHighLights").text(OtherAttributes[i].HighLights);
            }


            //For Task Details
            $("#TbodyWSRTasKDetails").html('');
            var TbodyWSRTasKDetails = "";
            var SumDuration = "";
            for (var i = 0; i < WSR_Activities.length; i++) {
                //debugger;
                SumDuration = WSR_Activities[i].SumDuration;
                TbodyWSRTasKDetails += "<tr>";
                TbodyWSRTasKDetails += "<td class='text - start'>" + WSR_Activities[i].Task + "</td>";
                TbodyWSRTasKDetails += "<td> " + WSR_Activities[i].WorkHrs + "</td>";
                TbodyWSRTasKDetails += "<td>" + WSR_Activities[i].Status + "</td>";
                TbodyWSRTasKDetails += "</tr>";

            }
            TbodyWSRTasKDetails += "<tr class='total-row'><td class='text - start'><strong>Grand Total</strong></td><td><strong>" + SumDuration + "</strong></td> <td><strong></strong></td></tr>";
            $("#TbodyWSRTasKDetails").html(TbodyWSRTasKDetails);



            //window.open("../../PM/PM_WeeklyStatusReport.aspx?FromWhere=Timesheet&TimeSheetNo=" + intTimesheetNo.toString(), "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=750,height=610");
        }

        //For Get Add TS
        function Add_NewTimesheet() {
            
            ProjectID = $("#cboProject").val();
            var Token = generatetoken();
            //window.location.href = "../../PM/PM_Timesheet.aspx?Mode=ADD_NEW&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&PKToken=" + Token.toString() + "";
            //TimesheetID = 0;

            //Added by Aditya J. on 21-08-2026 for continuous loader is coming on add button
            if (ProjectID == null || ProjectID === "" || ProjectID === "null") {
                ProjectID = 0;
            }
            //End of Added by Aditya J. on 21-08-2026 for continuous loader is coming on add button
            window.location.href = "../PM/PM_AddTimesheet.aspx?ProjectID=" + ProjectID + "&PKToken=" + Token, "", "resizable=no,scrollbars=yes,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 550) / 2 + ",width=800,height=550";


        }
        //For Get Edit TS
        function Edit_Timesheet(intTimesheetNo, Fromdate, ToDate, CurrentStatus, ProjectID) {
            var Token = generatetoken();
            //window.location.href = "../../PM/PM_Timesheet.aspx?TimeSheetNo=" + intTimesheetNo.toString() + "&PKToken=" + Token.toString() + "&MasterTagID=1049&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
            window.location.href = "../PM/PM_ProjectTimesheetDetails.aspx?ProjectID=" + ProjectID.toString() + "&TimeSheetNo=" + intTimesheetNo.toString() + "&FromDate=" + Fromdate.toString() + "&ToDate=" + ToDate.toString() + "&CurrentStatus=" + CurrentStatus.toString() + "&PKToken=" + Token.toString() + "&MasterTagID=1049&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
        }

        //For Added By Dipali V On 10th Oct for Billing Information
        var GlobalSelectedintTimesheetNo = "";
        function Billing_Information(intTimesheetNo, Fromdate, ToDate, CurrentStatus, ProjectID, IsAllValuesInSiteCurrency) {
            
            GlobalSelectedintTimesheetNo = intTimesheetNo;
            ProjectTimesheetID = intTimesheetNo;
            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_BillingInfo'));
            myOffcanvas.show();
            //debugger;
            GetProjectRateMethod();
            GetTimesheetReadyToAuthenticateFlag(intTimesheetNo);
            GetProjectDetails(intTimesheetNo, ProjectID, Fromdate, ToDate);

            GetTimesheetBillingDetails(intTimesheetNo, InvoiceTimesheetID);
            closeBillingDetails();//Hide Currency Icon
            if (IsAllValuesInSiteCurrency == "false") {
                $("#DivProjectCurrency").css("display", 'block');
                $("#BCurrencyDiv").css("display", 'none');
                //$("#DivPCurrency").css("display", 'block');
            } else {
                $("#DivProjectCurrency").css("display", 'none');
                $("#BCurrencyDiv").css("display", 'inline-block');
                //$("#DivPCurrency").css("display", 'none');
            }
            $("#Input_details_Info").removeClass('show');
            $("#Generate_IR_accordion").css('display','none');
        }


        //For Added By Dipali V On 10th Oct for Get Ratemethod
        function GetProjectRateMethod() {
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                TimesheetID: encodeURI(ProjectTimesheetID)
            }
            var param = JSON.stringify(Parameters);
            //var strResult = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectRateMethod", param, false);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetProjectRateMethod", param, false);

            if (strResult.length > 0) {
                $("#cboRateMethod option").empty();
                var objCbo1 = document.getElementById("cboRateMethod");
                $("#cboRateMethod option").remove();
                for (var i = 0; i < strResult.length; i++) {
                    var ObjData = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjData.RateMethod;
                    objOption.value = ObjData.RateMethodID;
                }
            }
            $(".selectpicker").selectpicker('refresh');
        }


        //Added By Dipali V On 3rd Oct 2023 For Get Project Details
        function GetProjectDetails(intTimesheetNo, ProjectID, Fromdate, ToDate) {
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                TimesheetID: encodeURI(intTimesheetNo)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetProjectTimesheetDetails", param, false);
            var GetProjectDetail = strResult;
            BindProjectDetails(GetProjectDetail);
           // debugger;
            if (ContractTypeID == "5") {
                $('#DivCapHoliday').css('display', 'none');
                $('#MonthlyMoreDetails').css('display', 'none');
            }
            $("#TxtFromDate").val(Fromdate);
            $("#billingfromdate").text(Fromdate);
            $("#TxtToDate").val(ToDate);
            $("#billingTodate").text(ToDate);

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
        //Added By Dipali V On 10th Oct 2023 For Bind Project Details
        function BindProjectDetails(GetProjectDetail) {
            if (GetProjectDetail != undefined) {
                for (var i = 0; i < GetProjectDetail.length; i++) {
                   //  debugger;
                    var ProjectName = GetProjectDetail[i]["ProjectName"];
                    GProjectName = GetProjectDetail[i]["ProjectName"];
                    var ContractType = GetProjectDetail[i]["ContractType"];
                    var CurrencyCode = GetProjectDetail[i]["CurrencyCode"];
                    GCurrencyCode = GetProjectDetail[i]["CurrencyCode"];
                    GCurrencySymbol = GetProjectDetail[i]["CurrencySymbol"];
                    GBillingCurrencyID = GetProjectDetail[i]["BillingCurrencyID"];
                    GBillingCurrencySymbol = GetProjectDetail[i]["BillingCurrencySymbol"];
                    GBillingCurrencyCode = GetProjectDetail[i]["BillingCurrencyCode"];
                    var RateMethod = GetProjectDetail[i]["RateMethod"];
                    var SiteValidation = GetProjectDetail[i]["SiteValidation"];
                    GlobalWorkHrs = GetProjectDetail[i]["WorkHrs"];
                    var HoursPerMonth = GetProjectDetail[i]["HoursPerMonth"];
                    GlobalWorkHrsperday = GetProjectDetail[i]["WorkHrsperday"];
                    OrganizationUnit = GetProjectDetail[i]["LocationID"];
                    GlobalMonthlyHr = GetProjectDetail[i]["MonthlyHr"];
                    ContractTypeID = GetProjectDetail[i]["ContractTypeID"];
                    CurrencyID = GetProjectDetail[i]["CurrencyID"];
                    GCurrencyID = GetProjectDetail[i]["CurrencyID"];
                    InvoiceTimesheetID = GetProjectDetail[i]["InvoiceTimesheetId"];
                    GCustomerID = GetProjectDetail[i]["CustomerID"];
                    CreditPeriod = GetProjectDetail[i]["CreditPeriod"];
                    GBLMonthlyHr = GetProjectDetail[i]["MonthlyHr"];
                    GProjectOrProduct = GetProjectDetail[i]["ProjectOrProduct"];
                    var ProjectOrganizationUnit = GetProjectDetail[i]["ProjectOrganizationUnit"];
                    var BufferPercentage = GetProjectDetail[i]["BufferPercentage"];
                    $("#input_project").text(ProjectName);
                    $("#input_Commercial").text(ContractType);
                    $("#SpanProjectOU").text(ProjectOrganizationUnit);
                    $("#project_current").text(ProjectName);
                    //Added By Dipali V On 27th Dec 2023 If Billing Currency not set then should consider IR currency
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
                    //End of Added By Dipali V On 27th Dec 2023 If Billing Currency not set then should consider IR currency
                    globalcontracttype = ContractType;
                    globalcontracttypeID = ContractTypeID;
                    if (ContractTypeID == 5) {
                        $("#SpanCommercialTypeNote").text("Billing rate will be Avg. Normal Rate defined at the site depending upon site duration");
                    } else {
                        $("#SpanCommercialTypeNote").text("");
                    }
                    $("#txtHRPerDay").val(GlobalWorkHrs);
                    $("#txtMonthlyHr").val(HoursPerMonth);
                    $("#cboRateMethod").val(RateMethod);
                    GRateMethod = $("#cboRateMethod option:selected").text()
                    $("#txtProjectCurrency").val(CurrencyCode);
                    $("#txtProjectCurrency").text(CurrencyCode);

                    if (SiteValidation == true) {
                        SiteValidation = "Yes";
                        $("#cboSiteValidation").val(SiteValidation);
                    } else {
                        SiteValidation = "No";
                    }
                    $("#cboSiteValidation").val(SiteValidation);
                    $("#txtBufferPercent").val(BufferPercentage);
                   
                    var OnsiteFull = GetProjectDetail[i]["OnsiteFull"];

                    if (OnsiteFull == null) {
                        OnsiteFull = '';
                    }
                    else if (OnsiteFull == false) {
                        OnsiteFull = 0;
                    }
                    else if (OnsiteFull == true) {
                        OnsiteFull = 1;
                    }


                    GlobalRateMethod = RateMethod;
                    if (RateMethod == 3) { //RATE METHOD MONTHLY
                        OnloadRateMethodOnChange();
                        $(".highlitedpanel").css("display", "block");
                        //$('.highlitedpanel').addClass('highlitedbox');
                        $("#cboActualDayBilling").val('Yes');
                        if (GetProjectDetail[i]["ActualDayBilling"] == "Yes") {
                            OnloadActualDayBillingRateOnchange();
                            //$("#cboActualDayBilling").prop('disabled', false);
                            $("#cboActualDayBilling").prop('disabled', true);
                            $("#cboFixedMonthlyRate").val('No');
                        }
                        else {
                            $("#cboActualDayBilling").prop('disabled', true);
                            $("#cboFixedMonthlyRate").val('Yes');
                        }

                        if (GetProjectDetail[i]["FixedMonthlyRate"] == "Yes") {
                            OnloadFixedMonthlyRateOnchange();
                            //$("#cboFixedMonthlyRate").prop('disabled', false);
                            $("#cboFixedMonthlyRate").prop('disabled', true);
                            $("#cboActualDayBilling").val('No');
                        }
                        else {
                            $("#cboFixedMonthlyRate").prop('disabled', true);
                            $("#cboActualDayBilling").val('Yes');
                        }

                    }
                    else {
                        RateMethodOnChange();

                    }

                    $("#txtDiscount").val(GetProjectDetail[i]["DiscountPercentage"]);
                    $("#txtInvoiceDate").val(GetProjectDetail[i]["InvoiceDate"]);
                    $("#cboActualDayBilling").val(GetProjectDetail[i]["ActualDayBilling"]);
                    $("#cboFixedMonthlyRate").val(GetProjectDetail[i]["FixedMonthlyRate"]);
                    $("#txtEffortToConsider").val(GetProjectDetail[i]["EffortToConsider"]);
                    $("#cboOnSiteFull").val(OnsiteFull);
                    $("#cboOnSiteFull").prop('disabled', true);
                    $("#TxtFromDate").val(FromDate);
                    $("#TxtToDate").val(ToDate);
                    $("#txtOU").val(GetProjectDetail[i]["OUWorkingDays"]);

                    // if (globalcontracttype == "Fixed Fee") {
                    if (ContractTypeID == "5") {
                        $(".FixedFee").css("display", "none");
                        $("#Generate_IR_accordion").css("display", "none");
                        $("#T_Note3").css("display", "none");
                    }

                    // if (globalcontracttype != "Fixed Fee") {
                    if (ContractTypeID != "5") {
                        if (RateMethod == 3) {
                            $("#TxtToDate").prop('disabled', true);
                        }
                    }
                    //debugger;
                    var CapConsider = GetProjectDetail[i]["CapConsider"];
                    var CapHoliday = GetProjectDetail[i]["CapHoliday"];
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

                    //if (globalcontracttype != "T&M by Resource with CAP" || globalcontracttype != "T&M by Role with CAP") {
                    if (ContractTypeID == 6) {
                        $("#cboCapConsider").val("Yes");
                        $("#cboCapHoliday").val("No");

                    }
                    else if (ContractTypeID == 7) {
                        $("#cboCapConsider").val("Yes");
                        $("#cboCapHoliday").val("No");
                    }

                    else {
                        $("#cboCapConsider").val("No");
                        $("#cboCapHoliday").val("No");
                    }

                    $("#cboCapConsider").val(CapConsider);
                    $("#cboCapHoliday").val(CapHoliday);

                }
            }
            $("#txtBufferPercent").prop('disabled', true);
            $(".selectpicker").selectpicker('refresh');
        }


        //Added By Dipali V On 11th Oct 2023 For On load Rate Method OnChange
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
                ///$("#cboActualDayBilling").val('Yes');
                $('.highlitedpanel').removeClass('highlitedbox');
                OnloadActualDayBillingRateOnchange();
                OnloadFixedMonthlyRateOnchange();
            }
        }

        //Added By Dipali V On 11th Oct 2023 For On load Fixed Monthly Rate On change
        function OnloadFixedMonthlyRateOnchange() {
            var FixedMonthlyRate = $("#cboFixedMonthlyRate").val();
            var RateMethod = $("#cboRateMethod option:selected").html();
            if (RateMethod == "Monthly") {
                if (FixedMonthlyRate == 'Yes') {
                    $("#txtBufferPercent").prop("disabled", false);
                    $("#cboOnSiteFull").prop("disabled", false);
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#cboActualDayBilling").prop("disabled", true);
                    //$("#cboActualDayBilling").val("No");  
                }
                else if (FixedMonthlyRate == 'No') {
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboActualDayBilling").prop("disabled", false);
                    $("#cboOnSiteFull").prop("disabled", true);
                    //$("#cboActualDayBilling").val("Yes"); 
                }
                else if (FixedMonthlyRate == 'NA') {
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#cboActualDayBilling").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                }

            }
        }
        //Added By Dipali V On 11th Oct 2023 For On load Actual Day Billing Rate Onchange
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
                }
                else if (ActualDayBilling == 'No') {
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboFixedMonthlyRate").prop("disabled", false);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#cboFixedMonthlyRate").val('Yes');
                    $("#cboActualDayBilling").prop("disabled", true);
                }
                else if (ActualDayBilling == 'NA') {
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboFixedMonthlyRate").prop("disabled", true);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                }
            }
        }


        //Added By Dipali V On 11th Oct 2023 For On Rate Method On Change
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
                //$('.highlitedpanel').addClass('highlitedbox');

                // $("#btnGenerateTimesheet").hide();
                $(".clsActualHr").prop("disabled", true);
            } else {

                $("#cboActualDayBilling").prop("disabled", false);
                $("#txtBufferPercent").prop("disabled", false);
                $("#txtMonthlyHr").prop("disabled", false);
                $("#cboFixedMonthlyRate").prop("disabled", true);
                $("#cboOnSiteFull").prop("disabled", false);
                $("#cboActualDayBilling").val('Yes');
                //$('.highlitedpanel').addClass('highlitedbox');
                $(".highlitedpanel").css("display", "block");
                ActualDayBillingRateOnchange();
                $(".clsActualHr").prop("disabled", false);
            }

        }

        //Added By Dipali V On 11th Oct 2023 For Actual Day Billing Rate On change
        function ActualDayBillingRateOnchange() {
            //debugger;
            $("#txtBufferPercent").val('');
            $("#txtEffortToConsider").val('');
            $("#cboOnSiteFull").val('');
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

                }
                else if (ActualDayBilling == 'No') {
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboFixedMonthlyRate").prop("disabled", false);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#cboActualDayBilling").prop("disabled", true);
                    $("#cboFixedMonthlyRate").val('Yes');
                    OnloadFixedMonthlyRateOnchange();

                }
                else if (ActualDayBilling == 'NA') {
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboFixedMonthlyRate").prop("disabled", true);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                }
            }
        }

        //Added By Dipali V On 10th Oct 2023 For Bind OU Details
        //function BindOUWorkingDays(OUWorkingDays) {
        //    $("#txtOU").val(OUWorkingDays);
        //}


        //Added By Dipali V For Print Report
        function Print_Onclick(intTimesheetNo) {
            GetEmployeeSiteDetails(intTimesheetNo)
            //window.open("../../CRW/CRW_ReportUIBuilder.aspx?ReportID=1889&UniqueID=" + intTimesheetNo.toString() + "&MasterTagID=1049", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 150) / 2 + ",top=" + (window.screen.height - 300) / 2 + ",width=400,height=300");
        }

        //Remove Duplicate From Array 
        function unique(array) {
            return array.filter(function (el, index, arr) {
                return index == arr.indexOf(el);
            });
        }
        //Added By Dipali V For Get Employee Site Details 
        function GetEmployeeSiteDetails(intTimesheetNo) {
            var Parameters = {
                TimesheetNo: encodeURI(intTimesheetNo)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/PrintReport", param, false);
            var TimesheetLists = strResult.TimesheetLists
            var EmployeeLists = strResult.EmployeeLists
            var SiteLists = strResult.SiteLists

            //debugger;
            for (var i = 0; i < TimesheetLists.length; i++) {
                var objCbo1 = document.getElementById("cboTimesheet");
                $("#cboTimesheet option").remove();
                //$("#cboTimesheet").append('<option value="0">Select Organization Unit</option>');
                for (var i = 0; i < TimesheetLists.length; i++) {
                    var ObjStatus = TimesheetLists[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjStatus.TimeSheetText;
                    objOption.value = ObjStatus.TimeSheetID;
                }
            }


            for (var i = 0; i < EmployeeLists.length; i++) {
                var objCbo1 = document.getElementById("cboEmployee");
                $("#cboEmployee option").remove();
                //$("#cboTimesheet").append('<option value="0">Select Organization Unit</option>');
                for (var i = 0; i < EmployeeLists.length; i++) {
                    var ObjStatus = EmployeeLists[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjStatus.EmployeeName;
                    objOption.value = ObjStatus.EmployeeID;
                }
            }

            for (var i = 0; i < SiteLists.length; i++) {
                var objCbo1 = document.getElementById("cboSite");
                $("#cboSite option").remove();
                //$("#cboTimesheet").append('<option value="0">Select Organization Unit</option>');
                for (var i = 0; i < SiteLists.length; i++) {
                    var ObjStatus = SiteLists[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjStatus.SiteName;
                    objOption.value = ObjStatus.SiteID;
                }
            }
            $(".selectpicker").selectpicker('refresh');
        }

        //Added By Dipali V For Create Token
        function generatetoken() {
            try {

                if (ProjectID != undefined) {
                    var generatedtoken = ajaxCall("PM_ProjectTimesheetlist.aspx/GeneratePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: '<%= Session("intProjectID") %>', EmployeeID: UserID }));
                    if (generatedtoken != undefined) {
                        m_CurrentToken = generatedtoken.d;

                    }
                }
                return m_CurrentToken
            }
            catch (ex) { }
        }

        //Added By Dipali V For Ajax Call Function
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
                    //alert(sessionStorage.getItem("access_token_Invoice"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                    //StopAjaxLoader("#WBSBody");
                    ajaxResult = data;
                },
                error: function (err) {
                    //StopAjaxLoader("#WBSBody");
                    console.log(err);
                    //alert(err.responseText);
                    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
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


        //Added By Dipali V For Loader Start
        function StartLoader(bodyID) {
            var progress2 = new LoadingOverlayProgress({
                bar: {
                    // Modified css by Gauri on 3rd Oct 2024 for loader issue
                    "background": "#ddd",
                    "top": "50px",
                    "left": "0px",
                    "right": "0px",
                    "height": "90px",
                    "width": "90px",                    
                    "margin": "auto",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
                    // Modified css by Gauri on 3rd Oct 2024 for loader issue
                },

            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }

        //Added By Dipali V For Loader Stop
        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {

            });

        }

        //Added By Dipali V for restrict Alphabets
        function restrictAlphabets(e) {
            var x = e.which || e.keycode;
            if ((x >= 48 && x <= 57) || x == 8 ||
                (x >= 35 && x <= 40) || x == 46)
                return true;
            else
                return false;
        }



        //Added By Dipali V For Select All Checkbox of Grid
        $(".chckHead").change(function () {
            var allPages = tbl_New.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#PTtbl").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedID.push(parseInt($(rows[i]).find("#hdn_ParameterID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedID = [];
                }
            }
        });

        //Added By Dipali V For Select CheckBox
        function GetSelect(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedID.push(parseInt(row.find('#hdn_ParameterID').val()));
            }
            else {
                if (SelectedID != 'undefined' && SelectedID.length > 0) {
                    var removeIns = row.find('#hdn_ParameterID').val();
                    SelectedID.remove(parseInt(removeIns));
                }
            }

        }
        Array.prototype.remove = function () {
            var what, a = arguments, L = a.length, ax;
            while (L && this.length) {
                what = a[--L];
                while ((ax = this.indexOf(what)) !== -1) {
                    this.splice(ax, 1);
                }
            }
            return this;
        };

        //Added By Dipali V For Check Select All check or unchecked
        function checkUncheck() {
            if (tbl_New.$('input:checked').length == tbl_New.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").prop("checked", false);
            }
        }

        //Added By Dipali V For Delete Timesheet
        function DeleteDetails() {
            //debugger;
            if (tbl_New.$('input:checked').length == 0) {
                alertify.error('<%= MyBase.GetResourceString("C_AtLeastRecord")%>');
                return false;
            } else {
                $("#deleteinfomodal").modal('show');
            }
        }

        //Added By Dipali V For Get Project Timesheet Comments
        function GetProjectTimesheetComments(TimesheetNo) {
            var Parameters = {
                TimesheetNo: encodeURI(TimesheetNo)
            }
            var param = JSON.stringify(Parameters)
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetProjectTimesheetComments", param, false);
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    $("#viewcomment").modal('show');
                    $("#txtViewComments").text(strResult[i].comments);
                    //$("#txtComments").val(strResult[i].comments);
                }

            }
        }


        //Added By Dipali V For Check SpecialCharacter
        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
                var isSpecialCharacter = 0;
                for (var i = 0; i < regularExpression.length; i++) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1
                    }
                }
                if (isSpecialCharacter == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }
        }

        //Added By Dipali V For Delete Action
        function DeleteData(DeleteAction) {
            //debugger;
            if (DeleteAction == "1") { /*--Action Yes*/
                var isSelectedID = SelectedID.toString();
                if (isSelectedID.length > 0) {
                    var Parameters = {
                        UniqueIDs: encodeURI(isSelectedID),
                        ProjectID: encodeURI(ProjectID)
                    }

                    var param = JSON.stringify(Parameters)
                    var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/DeleteProjectTimesheetDetails", param, false);
                    if (strResult.length != 0) {
                        if (strResult[0].ack == "success") {
                            if (strResult[0].strResult.indexOf("deleted successfully") != -1) {
                                alertify.success(strResult[0].strResult);
                                if (IsFilterApply == 1 && $("#cboProjectFilter").val() != null) {
                                    FilterProjectID = $('#cboProjectFilter').val()
                                } else {
                                    FilterProjectID = $("#cboProject").val();
                                }
                                GetProjectTimesheetList(null, FilterProjectID);
                                $(".chckHead").prop("checked", false);
                            } else {
                                alertify.error(strResult[0].strResult);

                            }

                        }
                    }
                    $(".chckHead").prop("checked", false);
                    $(".chcktbl").prop("checked", false);
                    //To Clear Filter
                    var allPages = tbl.fnGetNodes();
                    if (allPages.length > 0) {
                        $('input[type="checkbox"]', allPages).prop('checked', false);
                    }
                }
            } else {
                /*--Action No*/
                $(".chckHead").prop("checked", false);
                $(".chcktbl").prop("checked", false);
                //To Clear Filter
                var allPages = tbl.fnGetNodes();
                if (allPages.length > 0) {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                }

            }
            SelectedID = [];
            isSelectedID = "";
            // GetDetails();
        }


        //Added By Dipali V For Apply Filter
        function ApplyFilter() {
            //debugger;
            var QueryText = "";
            if ($('#cboProjectFilter').val() == null && $('#txtfromDateFilter').val().trim() == "" && $('#txttoDateFilter').val().trim() == "" && $('#txtAW').val().trim() == "" && $('#txtTimesheetID').val().trim() == "" && $('#cboStatus').val() == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SelectFilter")%>", 'error');
                $('#cboProjectFilter').focus();
                return;
            }
            else {
                StartLoader("#bodyPreloader");
                IsFilterApply = 1;
                if (IsFilterApply == 1 && $("#cboProjectFilter").val() != null) {
                    FilterProjectID = $('#cboProjectFilter').val()
                    $("#cboProject").val(0);
                    $(".selectpicker").selectpicker('refresh');
                } else {
                    FilterProjectID = $("#cboProject").val();
                }
                GetProjectTimesheetList(null, FilterProjectID);
                // $("#filterpanel").removeClass("in");
                $("#AdvanceFilterIcon").addClass("activefilter");
                $(".clearalllink").css("display", "inline-block");
                $(".filter .fa-filter").css("color", "#1359a6");
                $(".filter button").css("background", "#1359a6");
                $(".fa-filter").css("color", "#FFFFFF");
                $(".filterpanel").removeClass('show');

                StopAjaxLoader("#bodyPreloader");
                alertify.success("<%= MyBase.GetResourceString("A_FilterApplied") %>");
            }
        }

        //Added By Dipali V For Saved Filter
        function btnSaveAndApplyFilter_Onclick() {
            if ($('#cboProjectFilter').val() == null && $('#txtfromDateFilter').val().trim() == "" && $('#txttoDateFilter').val().trim() == "" && $('#txtAW').val().trim() == "" && $('#txtTimesheetID').val().trim() == "" && $('#cboStatus').val() == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_SelectFilter")%>', 'error');
                $('#cboProjectFilter').focus();
                return;
            }
            else {
                $("#saveAndApplyFilter").modal('show');
                $(".canclesaveasbtn").click(function () {
                    $("#txtFilterName").val('');
                });
            }
        }

        //Added By Dipali V For Duplicated Filter
        function checkDuplicateFilter(Flag, FilterID, filtername, TagID) {
            var isFilterExists = 0;
            if (FilterID == "" || Flag == 0) {
                FilterID = "0";
                Flag = "0";
            }
            var Parameters = {
                Flag: encodeURI(Flag),
                FilterID: encodeURI(FilterID),
                FilterName: encodeURI(filtername),
                TagID: encodeURI(1049),
                UserID: UserID
            }
            var param = JSON.stringify(Parameters);
            var data = AJAXCallWithResult("/api/PM_ProjectTimesheet/chkFilterExists", param, false);
            if (data != "") {
                if (data == 0) {
                    isFilterExists = 0;
                }
                else if (data == 1) {
                    //alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<%= MyBase.GetResourceString("A_FNameAlredyExist") %>");
                    $("#txtFilterName").focus();
                    isFilterExists = 1;
                }
            } else {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
            }
            return isFilterExists;
        }

        //Added By Dipali V For Function to save the filter and Apply the filter
        function SaveFilterValidation() {
            //debugger;
            var FilterName = $("#txtFilterName").val().trim();
            FilterID = GlobalFilterID;
            if (FilterName != GlobalFilterName) {
                FilterID = 0;
                FilterId = 0;
            }
            FilterName = FilterName.replace(/'/g, "''");
            if (FilterName != "" && FilterName != null) {
                if (checkSpecialCharacter(FilterName, WebConfigSpecialCharacters) == true) {
                    //alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Filter name should not contain any of these ' + WebConfigSpecialCharacters + ' characters.');
                    $("#txtFilterName").focus();
                }
                else {
                    var filterExists = 0;
                    if (savedFilterName == "") {
                        filterExists = checkDuplicateFilter(GlobalFilterFlag, GlobalFilterID, FilterName, 1049);
                    }
                    if (filterExists == 0) {
                        StartLoader("#bodyPreloader");
                        SavedFilters(FilterName);
                        IsFilterApply = 1;
                        $("#txtFilterName").val("");
                        $("#saveAndApplyFilter").modal('hide');
                        StopAjaxLoader("#bodyPreloader");
                    }
                }
            }
            else {
                //alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_FilterNameBlank") %>");
                $("#txtFilterName").focus();
            }
        }

        //Added By Dipali V For Save And Apply Filter Functionality
        function SavedFilters(FilterName) {
            //debugger;
            if (FilterName != GlobalFilterName && FilterID == "0") {
                Flag = 0;
            }
            else {
                Flag = 1;
            }

            var FromDate = $("#txtfromDateFilter").val().trim();
            var ToDate = $("#txttoDateFilter").val().trim();
            var ActualWork = $("#txtAW").val().replace("'", "''").trim();
            var TimesheetID = $("#txtTimesheetID").val().trim();
            var FilterProjectID = $("#cboProjectFilter").val();

            if ($("#cboStatus option:selected").text() == "Select Status") {
                var Status = '';
            }
            else {
                var Status = $("#cboStatus option:selected").text().replace("'", "''");
            }


            var Parameter = {
                ProjectID: FilterProjectID,
                FromDate: FromDate,
                ToDate: ToDate,
                ActualWork: ActualWork,
                TimesheetID: TimesheetID,
                Status: Status
            }
            var param = JSON.stringify(Parameter);
            var QueryText = param;
            if (QueryText != '') {
                Parameter = {
                    TagID: 1049,
                    UserID: encodeURI(UserID),
                    FilterName: encodeURI(FilterName),
                    LoginType: encodeURI(LoginType),
                    QueryText: encodeURI(QueryText),
                    UserName: encodeURI(UserName),
                    Flag: encodeURI(Flag),
                    FilterID: encodeURI(FilterID)
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/SavedFilters", param, false);
                if (strResult != null || strResult != "") {
                    GlobalFilterID = strResult;
                    GlobalApplyID = strResult;
                    GlobalApplyID = "Apply" + GlobalApplyID
                    $('.filterpanel').removeClass('show');
                    ApplyCheckFilter(GlobalApplyID);
                    alertify.success("<%= MyBase.GetResourceString("A_FilterApplied") %>");
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter .fa-filter").css("color", "#1359a6");
                    $(".filter button").css("background", "#1359a6");
                    $(".fa-filter").css("color", "#FFFFFF");
                    $("#filterpanel").removeClass("in");
                    $("#AdvanceFilterIcon").removeClass("activefilter");
                    $(".filterpanel").removeClass('show');
                } else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
        }

        //Added By Dipali V For Clear Project Main Filter
        function ClearMainFilter() {
            if (IsFilterApply == 1 && $("#cboProjectFilter").val() != null) {
                $("#cboProject").val("0");
            } else {
                $("#cboProject").val(ProjectID);
            }


            $(".selectpicker").selectpicker('refresh');
        }

        // Added By Dipali V For Getting QueryText From Perticular FilterID
        function ApplyCheckFilter(ApplyID) {
            //debugger;
            if (GlobalApplyID == "") {
                GlobalApplyID = ApplyID;
            }
            else if (GlobalApplyID != ApplyID) {
                GlobalApplyID = ApplyID;
            }
            else {
                ApplyID = GlobalApplyID;
            }
            var FilterID = ApplyID.replace("Apply", "");
            GlobalFilterID = FilterID;
            if (FilterID != undefined) {
                StartLoader("#bodyPreloader");
                var Parameter = {
                    FilterID: encodeURI(FilterID),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameter);
                var result = AJAXCallWithResult("/api/PM_ProjectTimesheet/EditFilterData", param, false);
                if (result != "") {
                    for (var i = 0; i < result.length; i++) {
                        var QueryText = result[i]["WhereClause"];
                        //var NewQueryText = result[i]["WhereClause"];
                        GlobalFilterName = result[i]["FilterName"];
                        //if (removeDefault == 0 && IsFilterApply==1) {
                          IsFilterApply = 1;
                        //}
                    }
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                        $("#txtFilterName").val(GlobalFilterName);
                        var filterValues = jQuery.parseJSON(QueryText);
                    }
                    /*  alert(GlobalFilterName);*/
                    //alert(IsFilterApply);
                    GlobalQueryText = QueryText;
                    //if (filterValues.ProjectID != 0) {
                    //    $("#cboProject").val(0);
                    //}
                    if (IsFilterApply == 1 && filterValues.ProjectID != 0) {
                        //debugger;
                        //alert(filterValues.TimesheetID);
                        $("#cboProject").val(0);
                        $('#cboProjectFilter').val(filterValues.ProjectID);
                        $('#txtTimesheetID').val(filterValues.TimesheetID);
                        $('#cboStatus').val(filterValues.Status);
                        $('#txtAW').val(filterValues.ActualWork);
                        $('#txttoDateFilter').val(filterValues.ToDate);
                        $('#txtfromDateFilter').val(filterValues.FromDate);
                        FilterProjectID = $('#cboProjectFilter').val()
                    } else {
                        FilterProjectID = $("#cboProject").val();

                    }
                    GetProjectTimesheetList(QueryText, FilterProjectID)
                    var sibling = $('label[id^="Apply"]')
                    if ($("#" + ApplyID).parent().find("input").prop("checked") == true) {
                        $("#" + ApplyID).parent().find("input").prop("checked", true);
                        // Added By Dipali V On 26th Dec 2023 For Get Correct  Tooltip
                        $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                        $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                         // Added By Dipali V On 26th Dec 2023 For Get Correct  Tooltip
                    }
                    else if ($("#" + ApplyID).parent().find("input").prop("checked") == false) {
                        $(sibling).each(function () {
                            var IsApplyFilter = 0;
                            var id = this.id;
                            if (ApplyID == this.id) {
                                IsApplyFilter = 1;
                                $("#" + id).parent().find("input").prop("checked", true);
                                 // Added By Dipali V On 26th Dec 2023 For Get Correct  Tooltip
                                $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                                $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                            }

                            else if ("Default" + ApplyID == this.id) {
                                if (IsApplyFilter != 1) {
                                    $("#" + id).parent().find("input").prop("checked", true);
                                    $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                                     // Added By Dipali V On 26th Dec 2023 For Get Correct  Tooltip
                                    $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                                }
                            }
                            else {
                                $("#" + id).parent().find("input").prop("checked", false);
                                $("#" + ApplyID).removeAttr("data-bs-original-title", "");
                                 // Added By Dipali V On 26th Dec 2023 For Get Correct  Tooltip
                                $("#" + ApplyID).attr("data-bs-original-title", "Applied Filter");
                            }
                        });
                    }
                    $(".filter button[aria-expanded='true'] .fa-filter").css("color", "#1359a6");
                    $(".filter .fa-filter").css("color", "#1359a6");

                    //$("#AdvanceFilterIcon").addClass("activefilter");
                    //$(".clearalllink").css("display", "inline-block");
                    //$(".filter button").css("background", "#1359ac");
                    //$(".fa-filter").css("color", "#ffffff");
                    //$(".filterpanel").removeClass('show');


                    //$(".filter button[aria-expanded='true'] .fa-filter").css("color", "#1359a6");
                    //$(".filter .fa-filter").css("color", "#1359a6");

                    $("#AdvanceFilterIcon").addClass("activefilter");
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter button").css("background", "#1359ac");
                    $(".fa-filter").css("color", "#ffffff");
                    StopAjaxLoader("#bodyPreloader");
                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
        }


        //Added By Dipali V For Edit Filter
        function EditFilter(EditID) {
            StartLoader("#bodyPreloader");
            Flag = 1;
            FilterID = EditID.replace("Edit", "");
            if (FilterID != "") {
                GlobalFilterID = FilterID;
                GlobalFilterFlag = 1;
                var Parameter = {
                    FilterID: encodeURI(FilterID),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameter);
                var result = AJAXCallWithResult("/api/PM_ProjectTimesheet/EditFilterData", param, false);
                if (result != "") {
                    //debugger;
                    for (var i = 0; i < result.length; i++) {
                        var QueryText = result[i].WhereClause;
                        GlobalFilterName = result[i].FilterName;
                    }
                    //BindBasicFilters(QueryText, "Filter");

                    var filterValues = jQuery.parseJSON(QueryText);
                    $("#txtFilterName").val(GlobalFilterName);
                    $("#txtfromDateFilter").val(filterValues.FromDate);
                    $("#txttoDateFilter").val(filterValues.ToDate);
                    $("#txtAW").val(filterValues.ActualWork);
                    $("#cboStatus").val(filterValues.Status);
                    $("#txtTimesheetID").val(filterValues.TimesheetID);
                    $("#cboProjectFilter").val(filterValues.ProjectID);
                    $(".filterpanel").addClass("in");
                    $(".filterpanelbody").addClass("active");
                    $('.nav-tabs li:last-child').addClass('active');
                    $('#basicfilters').addClass('active');
                    $(".selectpicker").selectpicker('refresh');

                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
            StopAjaxLoader("#bodyPreloader");
        }

        //Added By Dipali V For List Of All Saved Filters
        function AllMyFilters() {
            $(".tooltip").remove();
            Parameter = {
                TagID: 1049,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/AllMyFilters", param, false);
            if (strResult.Error != "") {
                MyFiltersList(strResult);
            }
            else {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
            }
        }

        // Added By Dipali V For Plotting Filter In My Filter DropDown
        function MyFiltersList(result) {
            var strHTML = "";
            for (var i = 0; i < result.length; i++) {
                var FilterID = result[i]["FilterId"];
                var FilterName = result[i]["FilterName"];
                var QueryText = result[i]["QueryText"];

                strHTML += ' <li>'
                if (result[i].SetDefault == true) {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-toggle="tooltip" data-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" checked="checked" onclick="SetDefaultFilter(this.id,&quot;default&quot;)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="Default' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                else {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onclick="SetDefaultFilter(this.id)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply Filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                strHTML += '</div>'
                strHTML += '</li>'
            }
            $("#MyFiltersdropdown").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();
            if (GlobalApplyID != null && GlobalApplyID != "") {
                ApplyCheckFilter(GlobalApplyID);
            }
            else {
                ClearFilterApplied();
            }
        }

        //Added By Dipali V For To clear the applied filter arrow after click on clear filter button
        function ClearFilterApplied() {
            $('table').resize();
            var sibling = $('label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($("#" + id).parent().find("input").prop("checked") == true) {
                    $("#" + id).parent().find("input").prop("checked", false);
                    $("#" + id).removeAttr("data-bs-original-title", "");
                    $("#" + id).attr("data-bs-original-title", "Apply Filter");
                }
            });
        }



        //Added By Dipali V For Delete Filter
        function DefaultDeleteFilter(DefaultID) {
            StartLoader("#bodyPreloader");
            //debugger;
            var NewDeleteFilterID = DefaultID.replace("Default", "");
            NewDeleteFilterID = DefaultID.replace("Apply", "");

            if (NewDeleteFilterID == DefaultID) {
                GlobalApplyID = '';
                // Added by Gauri on 4th Oct 2024 for loader issue when deleted default filter
                StopAjaxLoader("#bodyPreloader");
                // Added by Gauri on 4th Oct 2024 for loader issue when deleted default filter
            }
            GlobalQueryText = null;
            if (DefaultID.indexOf("Default") > -1) {
                var FilterID = DefaultID.replace("Default", "");
                DeleteFilter(FilterID);
                if (IsFilterApply == 1 && $("#cboProjectFilter").val() != null) {
                    FilterProjectID = $('#cboProjectFilter').val()
                } else {
                    FilterProjectID = $("#cboProject").val();
                }
                GetProjectTimesheetList(null, FilterProjectID);
                $(".filterpanel").removeClass('show');
            }
            else {
                DeleteFilter(DefaultID);
                GetDefaultFilter();
            }
            StopAjaxLoader("#bodyPreloader");
        }
        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        //Added By Dipali V For Delete Filter
        function DeleteFilter(FilterID) {
            if (FilterID != undefined) {
                Parameter = {
                    FilterID: encodeURI(FilterID),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/DeleteFilter", param, false);
                if (strResult == "0" || strResult == 0) {
                    alertify.success("<%= MyBase.GetResourceString("A_FilterDelete") %>");

                    ClearBasicFilter();
                    AllMyFilters();
                    $("#txtFilterName").val('');
                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
                $("button.filter").css("background", "none");
                $(".fa-filter").css("color", "#464a4c");
            }
        }

        //Added By Dipali V For Get the default filter
        function GetDefaultFilter() {
            var Parameter = {
                TagID: 1049,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
            }
            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetDefaultFilter", param, false);
            if (strResult.Error != "Error") {
                // debugger;
                FilterID = strResult.FilterID;
                var QueryText = strResult.QueryText;
                var filterValues = jQuery.parseJSON(QueryText);
                if (QueryText != null) {
                    IsFilterApply = 1;
                    GlobalApplyID = "Apply" + FilterID;
                    QueryText = QueryText.toString().replace(/'/g, "''");
                    GlobalQueryText = QueryText;
                    $(".filterpanel").removeClass('in');
                    $(".filterpanel").removeClass('show');
                    $(".filter").css("color", "transperent");
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter .fa-filter").css("color", "#1359a6");
                    $(".filter button").css("background", "#1359a6");
                    $(".fa-filter").css("color", "#FFFFFF");
                    //$(".filter button").css("background", "#1359a6");
                    $(".fa-filter").css("color", "#FFFFFF");
                    $(".filter button").addClass("activfltr");

                }
                else {
                    $(".clearalllink").css({ "display": "none" });
                    $(".filter").css("color", "transperent");
                    $(".filter .fa-filter").css("color", "#464a4c");
                    $(".filter button").css("background", "none");
                }
                if (IsFilterApply == 1 && filterValues.ProjectID != 0) {
                    $("#cboProjectFilter").val(filterValues.ProjectID);
                    $("#cboProject").val(0);
                }
                if (IsFilterApply == 1 && $("#cboProjectFilter").val() != null) {
                    FilterProjectID = $('#cboProjectFilter').val()
                } else {
                    FilterProjectID = $("#cboProject").val();
                }
                GetProjectTimesheetList(QueryText, FilterProjectID);
            }
            else {
                window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
            }
        }

        var AllFields = ["txtfromDateFilter", "txttoDateFilter", "txtAW", "cboStatus", "txtTimesheetID", "cboProjectFilter"];

        //Added By Dipali V For Clear All 
        function ClearAll() {
            StartLoader("#bodyPreloader");
            IsFilterApply = 0;
            ClearBasicFilter();
            ClearMainFilter();
            // $("#cboProjectFilter").val(ProjectID);
            $("#cboProjectFilter").val(0);
            GetProjectTimesheetList(null, ProjectID);
            GlobalApplyID = "";
            GlobalQueryText = "";
            savedFilterName = "";
            GlobalFilterID = "0";
            GlobalFilterName = "";
            FilterID = "";
            $('table').resize();
            $(".clearalllink").css({ "display": "none" });
            $(".filter").css("color", "transperent");
            $(".filter .fa-filter").css("color", "#464a4c");
            $(".filter button").css("background", "none");
            $("#filterpanel").removeClass('show');
            //$("#filterpanel").removeClass('show');
            // $("#filterpanel").css({ "display": "none" });
            $(".selectpicker").selectpicker('refresh');
            StopAjaxLoader("#bodyPreloader");
        }

        //Added By Dipali V For Clear Applied Filter
        function ClearBasicFilter() {
            for (var i = 0; i < AllFields.length; i++) {
                if (AllFields[i].indexOf('cbo') != -1) {
                    $('#' + AllFields[i]).val('0');
                }
                else {
                    $('#' + AllFields[i]).val('');
                }
                $("#cboProjectFilter").val('<%= Session("intProjectID") %>');
                $(".tooltip").remove();
            }
        }

        //Added By Dipali V For Set Default Filter
        var flag = 0;
        //var removeDefault = 0;
        function SetDefaultFilter(DefaultFilterID, flag) {
            //debugger;
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var FilterID = DefaultFilterID.replace("Default", "");
            if (FilterID != undefined) {
                Parameter = {
                    LoginType: encodeURI(LoginType),
                    UserID: encodeURI(UserID),
                    TagID: 1049,
                    FilterID: encodeURI(FilterID),
                    Flag: removeDefault
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/SetDefaultFilter", param, false);
                if (strResult == 0) {
                    if (removeDefault == 0) {
                        IsFilterApply = 1;
                        FilterID = "Apply" + FilterID;
                        ApplyCheckFilter(FilterID);
                        alertify.success("<%= MyBase.GetResourceString("A_SetdefaultFilter") %>");
                        $(".clearalllink").css("display", "inline-block");
                        $(".filter button").css("background", "#1359ac");
                        $(".fa-filter").css("color", "#ffffff");
                    } else {
                        FilterID = "Apply" + FilterID;
                        IsFilterApply = 0;
                        ApplyCheckFilter(FilterID);
                        ClearBasicFilter();
                        GlobalQueryText = null;

                        //if (IsFilterApply == 1 && $("#cboProjectFilter").val() != 0) {
                        //    FilterProjectID = $('#cboProjectFilter').val()
                        //} else {
                        //    FilterProjectID = $("#cboProject").val();
                        //}
                       // $('#cboProjectFilter').val('<%= Session("intProjectID") %>')
                        $('#cboProjectFilter').val(0)
                        GetProjectTimesheetList(null, $("#cboProject").val());
                        alertify.success("<%= MyBase.GetResourceString("A_RemovedDefaultFilter") %>");
                        $(".clearalllink").css({ "display": "none" });
                        $(".filter button").css("background", "none");
                        $(".fa-filter").css("color", "#464a4c");
                    }
                }
                else {
                    window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                }
            }
        }

        //Added By Dipali V For Download Report
        function Export_PDFClick(ReportFormat) {
            var TimesheetID = $("#cboTimesheet").val();
            var EmployeeID = $("#cboEmployee").val();
            var SiteID = $("#cboSite").val();

            if (TimesheetID == 0) {
                alertify.error('<%= MyBase.GetResourceString("C_TimsheetReportblank")%>');
                $("#cboTimesheet").focus();
                return false;
            }

            if (EmployeeID == 0) {
                EmployeeID = "NULL";
            }

            if (SiteID == 0) {
                SiteID = "NULL";
            }
            Parameter =
            {
                TimesheetID: encodeURI(TimesheetID),
                SiteID: encodeURI(SiteID),
                EmployeeID: encodeURI(EmployeeID),
                ReportFormat: encodeURI(ReportFormat)

            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectTimesheet/ExportToReport',
                method: 'Post',
                data: JSON.stringify(Parameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (result) {
                    if (result != "0") {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });

        }

        function countDecimals(value) {
            if (Math.floor(value) === value) return 0;
            return value.toString().split(".")[1].length || 0;
        }

        function GetChangeFormat(value) {

           //debugger
            if (value != "") {
                var decimalCount;
                var Currentvalue = value.toString();
                if (Currentvalue.indexOf('.') > -1) {
                    decimalCount = countDecimals(Currentvalue);
                } else {
                    decimalCount = 0;
                }
                  //Added By Dipali V On 11th Jan 2024 For Decimal upto 3
                //if (decimalCount.length > 1) {
                if (decimalCount == 4) {
                      //End of Added By Dipali V On 11th Jan 2024 For Decimal upto 3
                    Currentvalue = Currentvalue.slice(0, -1);
                }

                var components = Currentvalue.toString().split(".");
                //var components = Currentvalue.split(".");

                if (components.length == 1) {
                    components[0] = Currentvalue;
                }
                components[0] = components[0].replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                  //Commented By Dipali V On 11th Jan 2024 For Decimal upto 3
                //if (components.length == 2) {
                //    components[1] = components[1].replace(/\D/g, '').replace(/^\d{3}$/, '');
                //}
                  //End of Commented By Dipali V On 11th Jan 2024 For Decimal upto 3
                if (components.join('.') != '')
                    return components.join('.');
                else
                    return '';
                //return components
            }
        }
        var GetBillingCurrencyvalues = "";
        function GetValueIntoBillingCurrency(TimesheetID, ProjectID, InvoiceDate) {
            var Parameters = {
                TimesheetNo: encodeURI(TimesheetID),
                ProjectID: encodeURI(ProjectID),
                InvoiceDate: InvoiceDate
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetValueIntoBillingCurrency", param, false);
            //debugger;
            GetBillingCurrencyvalues = strResult;
            return GetBillingCurrencyvalues;
        }


        //Added By Dipali V On 12nd Oct 2023 For Get Billing Information Details
        var BillingTotalRecordCount = 0;
        var GIsIRGenerator = 0;
        var IsAllValuesInSiteCurrency = "";
        var GSelectedSiteCurrencyID = "";
        var GSelectedSiteCurrencyCode = "";
        function GetTimesheetBillingDetails(intTimesheetNo, InvoiceTimesheetID) {
            //debugger;
           // alert('<%=m_DeleteAccess%>');
            var Parameters = {
                TimesheetID: encodeURI(intTimesheetNo),
                InvoiceTimesheetID: encodeURI(InvoiceTimesheetID),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetTimesheetBillingDetails", param, false);
            $(".tbody_billing_info").html('');
            var IsData = "0";
            var strHTML = '';
            var TimesheetID = intTimesheetNo;
            for (var i = 0; i < strResult.length; i++) {
                //debugger;
                BillingTotalRecordCount = strResult.length;
                GIsIRGenerator = strResult[i].IsIRGeneratorID;
                IsAllValuesInSiteCurrency = strResult[i].IsAllValuesInSiteCurrency;
                GSelectedSiteCurrencyID = strResult[i].SiteCurrencyID;
                GSelectedSiteCurrencyCode = strResult[i].SiteCurrencyCode;
                SiteId = strResult[i].SiteId; // Added By Dipali V On 28th dec 2023 For Check Sites have Diff or same
                IsData = "1";
                var added_IRClass = '';
                if (strResult[i].IRId != 0 || strResult[i].IRId != "") {
                    added_IRClass = 'added_IR';
                    actionClass = 'disabled';
                } else {
                    added_IRClass = '';
                    actionClass = '';

                }

                //var Discount = strResult[i].Discount.toFixed(2);
                //var InvoiceAmount = strResult[i].InvoiceAmount.toFixed(2);
                //var FinaLAmount = strResult[i].FinaLAmount.toFixed(2);

                var Discount = strResult[i].Discount.toFixed(3);
                var InvoiceAmount = strResult[i].InvoiceAmount.toFixed(3);
                var FinaLAmount = strResult[i].FinaLAmount.toFixed(3);
                // console.log(strResult[i].InvoiceAmount);
                strHTML += '<tr class="tr_add ' + added_IRClass + '" id="row_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">';
                 /*   strHTML += ' <td><span class="idlabel">' + strResult[i].AdviseId + '</span></td>';*/
                strHTML += '<td><input type="hidden" value="' + strResult[i].EmployeeCode + ' - ' + strResult[i].Employee + '" id="EmpName_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" /><input type="hidden" value="' + strResult[i].SystemFilename + '" id="ImgEmpName_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" />';
                strHTML += '<a href="javascript:;">';
                strHTML += strResult[i].EmployeeCode + ' - ' + strResult[i].Employee;
                 //---+ '[';
                //--strHTML += GProjectName + ']';
                strHTML += '</a>';
                strHTML += '</td>';
                strHTML += '<td>' + strResult[i].Location + '</td>';
                strHTML += '<td>' + strResult[i].ProjectRole + '</td>';
                strHTML += '<td data-bs-toggle="modal"';
                strHTML += 'data-bs-target="" onclick="GetTimesheetDetails(' + strResult[i].EmployeeId + ',' + strResult[i].SiteId + ' ,' + strResult[i].TimesheetId + ',' + strResult[i].AdviseId + ',' + strResult[i].ProjectRoleId + ')">';
                strHTML += '<a href="javascript:;" class="text_size hypertext"><i class="fas fa-info" style="color:#ff8000" data-bs-toggle="tooltip" data-bs-placement="top" title="Timesheet Details" ></i></a>';
                strHTML += '</td>';
                //strHTML += '<td id="BillingRate_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + (strResult[i].BillingRate).toFixed(2) + '</td>';
                if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                    strHTML += '<td><span id="BillingRate_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"> ' + (strResult[i].BillingRate).toFixed(3) + ' </span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="SiteCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue">(' + strResult[i].SiteCurrency +')</span></td>';
                } else {
                    strHTML += '<td><span id="BillingRate_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"> ' + (strResult[i].BillingRate).toFixed(3) + ' </span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="SiteCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue"></span></td>';
                }
                strHTML += '<td class="tdCurrent current_opendiv">';
                if (ReadyToAuthenticate != "Y") {
                    strHTML += '<input type="text" id="txtActualHr_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" onkeyup="ChangeActualHr(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + ',' + strResult[i].EmployeeId + ',' + strResult[i].MonthlyThresholdvalue + ',' + strResult[i].SiteMonthlyHours + ',' + strResult[i].isoffshore + ')" value="' + strResult[i].ActualHr + '" class="form-control text-center clsActualHr"  onkeypress="return restrictAlphabets(event)" dataValue="' + strResult[i].ActualHr + '" />';
                } else {
                    strHTML += '<input type="text" id="txtActualHr_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" onkeyup="ChangeActualHr(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + ',' + strResult[i].EmployeeId + ',' + strResult[i].MonthlyThresholdvalue + ',' + strResult[i].SiteMonthlyHours + ',' + strResult[i].isoffshore + ')" value="' + strResult[i].ActualHr + '" class="form-control text-center clsActualHr" disabled onkeypress="return restrictAlphabets(event)" dataValue="' + strResult[i].ActualHr + '" />';

                }
                strHTML += '<input type="hidden" id="txtFloatActualHr_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].FloatActualHr + '" dataValue="' + strResult[i].FloatActualHr + '"></input>'
                strHTML += '</td>';
                strHTML += '<td class="border-right-0"></td>';
                strHTML += '<td class="tdCurrent ClsWorkingDay" id="WorkingDay_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + strResult[i].WorkingDay + ' </td>';
                strHTML += '<td class="tdCurrent" id="NoDayWorked_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" dataValue="' + strResult[i].DayWorked.toFixed(3) + '">' + strResult[i].DayWorked.toFixed(3) + '</td>';
                strHTML += '<td class="tdCurrent" id="DailyRate_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + strResult[i].DailyRate.toFixed(3) + '</td>';
                //strHTML += '<td class="tdCurrent" id="DailyRate_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + GetChangeFormat(strResult[i].DailyRate) + '</td>';
                //strHTML += '<td class="tdCurrent SumInvoice" id="InvoiceAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" dataValue="' + strResult[i].InvoiceAmount.toFixed(2) + '">' + strResult[i].InvoiceAmount.toFixed(2) + '</td>';
                //strHTML += '<td class="tdCurrent SumInvoice" id="InvoiceAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" dataValue="' + strResult[i].InvoiceAmount.toFixed(2) + '">' + GetChangeFormat(InvoiceAmount) + '</td>';
                if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                    strHTML += '<td class="tdCurrent"><span class="SumInvoice" id="InvoiceAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" dataValue="' + strResult[i].InvoiceAmount.toFixed(3) + '">' + GetChangeFormat(InvoiceAmount) + '</span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="InvoiceAmountSiteCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue hidecolumn">(' + strResult[i].SiteCurrency + ')</span></td>';
                } else {
                    strHTML += '<td class="tdCurrent"><span class="SumInvoice" id="InvoiceAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" dataValue="' + strResult[i].InvoiceAmount.toFixed(3) + '">' + GetChangeFormat(InvoiceAmount) + '</span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="InvoiceAmountSiteCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue hidecolumn"></span></td>';

                }
                strHTML += '<input type="hidden" class="text-right hiddenSumInvoice" id="InvoiceAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].InvoiceAmount + '">'
                //strHTML += '<td class="tdCurrent SumDiscount" id="Discount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + strResult[i].Discount.toFixed(2) + '</td>';
                //strHTML += '<td class="tdCurrent SumDiscount" id="Discount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + GetChangeFormat(Discount) + '</td>';
                if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                    strHTML += '<td class="tdCurrent"><span class="SumDiscount" id="Discount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + GetChangeFormat(Discount) + '</span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="DiscountSiteCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue hidecolumn">(' + strResult[i].SiteCurrency + ')</span></td>';
                } else {
                    strHTML += '<td class="tdCurrent"><span class="SumDiscount" id="Discount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + GetChangeFormat(Discount) + '</span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="DiscountSiteCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue hidecolumn"></span></td>';

                }
                    strHTML += '<input type="hidden" class="text-right hiddenSumDiscount clsDiscount' + strResult[i].AdviseId + '" id="Discount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].Discount + '">'
                //strHTML += '<td Class="SumFinalAmount clsFinalAmount" id="txtFinalAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + strResult[i].FinaLAmount.toFixed(2) + '</td>'; //<span class="INRCurncy"></span>
                //strHTML += '<td Class="SumFinalAmount clsFinalAmount" id="txtFinalAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + GetChangeFormat(FinaLAmount) + '</td>'; //<span class="INRCurncy"></span>
                if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                    strHTML += '<td Class="clsFinalAmount"><span  class="SumFinalAmount" id="txtFinalAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + GetChangeFormat(FinaLAmount) + '</span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="FinalAmountCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue">(' + strResult[i].SiteCurrency + ')</span></td>'; //<span class="INRCurncy"></span>
                } else {
                    strHTML += '<td Class="clsFinalAmount"><span  class="SumFinalAmount" id="txtFinalAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '">' + GetChangeFormat(FinaLAmount) + '</span><span data-bs-toggle="tooltip" data-bs-placement="top" title="Site Currency" id ="FinalAmountCurrency_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"  class="Curncy iconBlue"></span></td>'; //<span class="INRCurncy"></span>

                }
                    strHTML += '<input type="hidden" class="text-rightn b hiddenSumFinalAmount clsFinalAmount' + strResult[i].AdviseId + '" id="txtFinalAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].FinaLAmount.toFixed(3) + '">'
                strHTML += '<input type="hidden" class="text-rightn b' + strResult[i].AdviseId + '" id="SiteCurrency' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + GSelectedSiteCurrencyID + '">'
                strHTML += '<input type="hidden" class="text-rightn b' + strResult[i].AdviseId + '" id="SiteCurrencyCode' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + GSelectedSiteCurrencyCode + '">'
                strHTML += '<td>';
                //strHTML += '<span class="' + GCurrencyCode + 'Curncy iconBlue">' + GCurrencySymbol + '</span>';
                if (ReadyToAuthenticate != "Y") {
                    var FinalAmountPmEdit = strResult[i].FinalAmountPmEdit.toFixed(3);
                    //strHTML += '<input type="text" id="txtEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].FinalAmountPmEdit.toFixed(2) + '" class="form-control text-center sumtxtEditAmount"   maxlength="13" onchange="PM_EditValue(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')"/>';
                    strHTML += '<input type="text" id="txtEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + GetChangeFormat(FinalAmountPmEdit) + '" class="form-control text-center sumtxtEditAmount"   maxlength="13" onchange="PM_EditValue(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')"/>';
                }
                else {
                    var FinalAmountPmEdit = strResult[i].FinalAmountPmEdit.toFixed(3);
                   // strHTML += '<input type="text" id="txtEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].FinalAmountPmEdit.toFixed(2) + '" class="form-control text-center sumtxtEditAmount" disabled   maxlength="13" onchange="PM_EditValue(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')/>';
                    strHTML += '<input type="text" id="txtEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + GetChangeFormat(FinalAmountPmEdit) + '" class="form-control text-center sumtxtEditAmount" disabled   maxlength="13" onchange="PM_EditValue(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')/>';
                    strHTML += '<input type="hidden" class="form-control input-sm hiddensumtxtEditAmount edit clsFinaleditAmount' + strResult[i].AdviseId + '" id="txtEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].FinalAmountPmEdit + '">'
                   // strHTML += '<input type="hidden" class="form-control input-sm hiddensumtxtEditAmount edit clsFinaleditAmount' + strResult[i].AdviseId + '" id="EditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].FinalAmountPmEdit + '">'
                }
                strHTML += '</td>';
                strHTML += '<td>';
                //strHTML += '<span class="' + GCurrencyCode + 'Curncy iconBlue">' + GCurrencySymbol + '</span>';
                if (strResult[i].PMEditDiffAmount == "" || strResult[i].PMEditDiffAmount == null) {
                    //strHTML += '<input type="text" id="txtPMEdiffEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="00.00" class="form-control text-center" disabled/>';
                    strHTML += '<input type="text" id="txtPMEdiffEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="00.00" class="form-control text-center" disabled/>';
                } else {
                    var PMEditDiffAmount = strResult[i].PMEditDiffAmount.toFixed(3);
                   // strHTML += '<input type="text" id="txtPMEdiffEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + strResult[i].PMEditDiffAmount + '" class="form-control text-center" disabled/>';
                    strHTML += '<input type="text" id="txtPMEdiffEditAmount_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" value="' + GetChangeFormat(PMEditDiffAmount)  + '" class="form-control text-center" disabled/>';
                }
                strHTML += '</td>';
                if (strResult[i].IRId != 0) {
                    strHTML += '<td><a href="#" class="hypertext" onclick="IROnClick()">' + strResult[i].IRId + ' </a></td>';
                } else {
                    strHTML += '<td><a>-</a></td>';
                }


                if (strResult[i].Remarks == null) {
                    strHTML += '<td class="text-right"><textarea id="txttextarea_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" class="form-control edit textAreaRemark" value="' + strResult[i].Remarks + '" maxlength="500" onkeypress="validateremarks(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')"></textarea></td>'
                }
                else {
                    strHTML += '<td class="text-right"><textarea id="txttextarea_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" class="form-control edit textAreaRemark" value="' + strResult[i].Remarks + '" maxlength="500" onkeypress="validateremarks(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')"> ' + strResult[i].Remarks.trim() + '</textarea></td>'

                }
                strHTML += '<td>';
                strHTML += '<div class="d-flex">';
                strHTML += '<div class="custom_chckbox chckbox-hide ">';
                if (strResult[i].IRId != 0 || strResult[i].IRId != "") {
                    strHTML += '<input id="' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" class="chckHead" type="checkbox" checked name="" value="' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" onchange="GetSelectedIRItems()" disabled>';
                } else {
                    strHTML += '<input id="' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" class="chckHead" type="checkbox" name="BillingchckHead" value="' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '_' + strResult[i].SiteId + '" onchange="GetSelectedIRItems()">';
                }
                strHTML += '<label for="' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '"></label>';
                strHTML += '</div>';
                if (ReadyToAuthenticate != "Y") {
                    if ('<%=m_EditAccess%>' == true || '<%=m_EditAccess%>' == 'True') {
                        strHTML += '<i class="far fa-save save_row" data-bs-toggle="tooltip" data-bs-placement="top" title="save" id="sv_row_1" onclick="Save_InvoiceData(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')" style="display: inline;" ' + actionClass +'></i>&nbsp;';
                    }
                    if ('<%=m_DeleteAccess%>' == true || '<%=m_DeleteAccess%>' == 'True') {
                        strHTML += '<i class="far fa-trash-alt remove_row" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" id="del_row_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" onclick="Delete_Onclick(' + strResult[i].AdviseId + ',' + TimesheetID + ',' + strResult[i].ProjectRoleId + "," + strResult[i].EmployeeId + ')" ' + actionClass +'></i>&nbsp;';
                    }
                }
                else {
                    if ('<%=m_EditAccess%>' == true || '<%=m_EditAccess%>' == 'True') {
                        strHTML += '<i class="far fa-save save_row" data-bs-toggle="tooltip" data-bs-placement="top" title="You Do not have Access.Timesheet is Sent For Approval/Approved " ' + actionClass +'></i > '
                    }
                    if ('<%=m_DeleteAccess%>' == true || '<%=m_DeleteAccess%>' == 'True') {
                        strHTML += '<i class="far fa-trash-alt remove_row" data-bs-toggle="tooltip" data-bs-placement="top" title="You Do not have Access.Timesheet is Sent For Approval/Approved"  id="del_row_' + strResult[i].AdviseId + '_' + TimesheetID + '_' + strResult[i].ProjectRoleId + '_' + strResult[i].EmployeeId + '" ' + actionClass +'></i>&nbsp;';
                    }
                }

                strHTML += '</div>';
                strHTML += '</td>';
                strHTML += '</tr>';

            }
            $(".tbody_billing_info").html(strHTML);
            //Commented & Added By Dipali V On 27th Dec 2023 For Showing All Values in Billing Currency
            //$("#billingCurrency").text("(" + GCurrencySymbol + ")");
            //$("#SumDiscountbillingCurrency").text("(" + GCurrencySymbol + ")");
            //$("#SumInvoicebillingCurrency").text("(" + GCurrencySymbol + ")");
            $("#PCurrency").text(GCurrencyCode);
            $("#PCurrencyNote").text("(" + GCurrencySymbol + ")");
            //Added By Dipali V On 2nd Jan 2023 For Showing Billing Currency
            $("#BCurrency").text(GBillingCurrencyCode);
            $("#BCurrencyNote").text("(" + GBillingCurrencySymbol + ")");
            //End of Added By Dipali V On 2nd Jan 2023 For Showing Billing Currency
            $("#billingCurrency").text("(" + GBillingCurrencySymbol + ")");
            $("#SumDiscountbillingCurrency").text("(" + GBillingCurrencySymbol + ")");
            $("#SumInvoicebillingCurrency").text("(" + GBillingCurrencySymbol + ")");
            $("#ProjectCurrencyNote").text("(" + GBillingCurrencySymbol + ")");

            // $("#ProjectCurrency").text("(" + GBillingCurrencySymbol + ")");
           //End of Commented & Added By Dipali V On 27th Dec 2023 For Showing All Values in Billing Currency
            //debugger;
            var TotalRIRItemsChecked = $('input[class="chckHead"]:checked').length;
            $('[data-bs-toggle="tooltip"]').tooltip()
            if (IsData == "1") {
                $("#cboRateMethod").prop('disabled', true);
                $("#btnGenerateTimesheet").show();
            } else {
                $("#btnGenerateTimesheet").hide();
            }
            //console.log(ReadyToAuthenticate);
            //console.log(Authenticated);
           // debugger;
            if (ReadyToAuthenticate != "Y")
            {
                $("#btnGenerateTimesheet").show();
                $("#btnSFA").show();
                $("#btnSave").show();
                $("#generate_IR").hide();
            }
            else if (ReadyToAuthenticate == "Y" && Authenticated == "Y") 
            {
                $("#generate_IR").show();
                $("#btnGenerateTimesheet").hide();
                $("#btnSFA").hide();
                $("#btnSave").hide();
            }
            else {
                $("#btnGenerateTimesheet").hide();
                $("#btnSFA").hide();
                $("#btnSave").hide();
                $("#generate_IR").hide();

            }
           //All IR Items Added Then Button hide
            if (TotalRIRItemsChecked == BillingTotalRecordCount) {
                $("#generate_IR").hide();
            } else if (GIsIRGenerator == 0) {
                $("#generate_IR").hide();
            }
            //alert(ContractTypeID);
            if (GIsIRGenerator == 1 && (IsAllowToCreateIR == 1 || IsAllowToCreateIR == true)) {
                $("#generate_IR").show();
            }
            if (ContractTypeID == "1") {
                $("#generate_IR").hide(); // If Fixed Bid then IR Generate Button Hide
            }
            $(".table .tdCurrent").addClass("hidecol", "");
            $(".hidecolumn").css("display", "none");
           // debugger;
            //$(".SumInvoicebillingCurrency").hide();
            //$(".SumDiscountbillingCurrency").hide();

            var SumAmount = 0, SumDiscount = 0, SumFinalAmount = 0; sumColtxtEditAmount = 0, SumFinalAmountConverted = 0, SumDiscountConvertedDiscount = 0;
            var ConvertedInvoiceAomunt = 0, ConvertedDiscount = 0, ConvertedFinalAmount = 0, SumAmountConvertedInvoiceAomunt = 0;
            //Added By Dipali V On 28th Dec 2023 For Get Converted Values if Site Currency Flag Enabled
            if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                var InvoiceDate = $("#txtInvoiceDate").val();
                GetBillingCurrencyvalues = GetValueIntoBillingCurrency(TimesheetID, ProjectID, InvoiceDate);
                for (var i = 0; i < GetBillingCurrencyvalues.length; i++) {
                    ConvertedInvoiceAomunt =  GetBillingCurrencyvalues[i].ConvertedInvoiceAomunt;
                    ConvertedDiscount = GetBillingCurrencyvalues[i].ConvertedDiscount;
                    ConvertedFinalAmount = GetBillingCurrencyvalues[i].ConvertedFinalAmount;
                }
            }
             //End of Added By Dipali V On 28th Dec 2023 For Get Converted Values if Site Currency Flag Enabled
            var column2 = $('.SumInvoice')
            jQuery.each(column2, function (number) {
                if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                    //SumAmount += parseFloat($(this).text());
                    if ($(this).text().indexOf(',') > -1) {
                        SumAmount += parseFloat($(this).text().replaceAll(',', ''));
                    } else {
                        SumAmount += parseFloat($(this).text());
                    }
                } else {
                    var SiteID = this.id.replace("InvoiceAmount_", "SiteCurrency_");
                    var SiteCurrency = $("#" + SiteID).text();
                    if (SiteCurrency.replace("(", "").replace(")", "").trim() == GBillingCurrencySymbol.trim()) {
                        if ($(this).text().indexOf(',') > -1) {
                            SumAmount += parseFloat($(this).text().replaceAll(',', ''));
                        } else {
                            SumAmount += parseFloat($(this).text());
                        }
                       
                      //  console.log(SumAmount);
                    } else {
                       /// SumAmount += ConvertedInvoiceAomunt;
                        SumAmountConvertedInvoiceAomunt = ConvertedInvoiceAomunt;
                        //console.log(ConvertedInvoiceAomunt);
                       // console.log(SumAmount);
                    }

                }

            });
            var SumAmount_N = SumAmount + SumAmountConvertedInvoiceAomunt;
            SumAmount_N = SumAmount_N.toFixed(3);
            $('#SumInvoice').text(GetChangeFormat(SumAmount_N));

            var SumColDiscount = $('.SumDiscount')
            jQuery.each(SumColDiscount, function (number) {
                if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                    //SumDiscount += parseFloat($(this).text());
                    if ($(this).text().indexOf(',') > -1) {
                        SumDiscount += parseFloat($(this).text().replaceAll(',', ''));
                    } else {
                        SumDiscount += parseFloat($(this).text());
                    }
                } else {
                    var SiteID = this.id.replace("Discount_", "SiteCurrency_");
                    var SiteCurrency = $("#" + SiteID).text();
                    if (SiteCurrency.replace("(", "").replace(")", "").trim() == GBillingCurrencySymbol.trim()) {
                        if ($(this).text().indexOf(',') > -1) {
                            SumDiscount += parseFloat($(this).text().replaceAll(',', ''));
                        } else {
                            SumDiscount += parseFloat($(this).text());
                        }
                       // console.log(SumFinalAmount);
                    } else {
                        SumDiscountConvertedDiscount = ConvertedDiscount;

                    }

                }
            });
            //SumDiscount = SumDiscount.toFixed(2);
            //$('#SumDiscount').text(GetChangeFormat(SumDiscount));

            var SumDiscount_N = SumDiscount + SumDiscountConvertedDiscount
            SumDiscount_N = SumDiscount_N.toFixed(3);
            $('#SumDiscount').text(GetChangeFormat(SumDiscount_N));

            var SumColInvoice = $('.SumFinalAmount')
            var ArrInvoiceAmount = [];
            jQuery.each(SumColInvoice, function (number) {
                ////SumFinalAmount += parseFloat($(this).text());
                //debugger;
                if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                    if ($(this).text().indexOf(',') > -1) {
                        SumFinalAmount += parseFloat($(this).text().replaceAll(',', ''));
                    } else {
                        SumFinalAmount += parseFloat($(this).text());
                    }
                } else {
                   // debugger;
                    var SiteID = this.id.replace("txtFinalAmount_", "SiteCurrency_");
                    var SiteCurrency = $("#" + SiteID).text();
                    if (SiteCurrency.replace("(", "").replace(")", "").trim() == GBillingCurrencySymbol.trim())
                    {
                        console.log(1);
                        if ($(this).text().indexOf(',') > -1) {
                            SumFinalAmount += parseFloat($(this).text().replaceAll(',', ''));
                        } else {
                            SumFinalAmount += parseFloat($(this).text());
                        }
                       // console.log(SumFinalAmount);
                       // console.log("billing");
                       // console.log("finalamount");
                    }
                    else
                    {
                        SumFinalAmountConverted =  ConvertedFinalAmount;

                    }
                }
            });
            var SumFinalAmount_N = SumFinalAmount + SumFinalAmountConverted
            SumFinalAmount_N = SumFinalAmount_N.toFixed(3);
            $('#SumFinalAmount').text(GetChangeFormat(SumFinalAmount_N));

            var sumtxtEditAmount = $('.sumtxtEditAmount')
            jQuery.each(sumtxtEditAmount, function (number) {
                if ($(this).text().indexOf(',') > -1) {
                    sumColtxtEditAmount += parseFloat($(this).text().replaceAll(',', ''));
                } else {
                    sumColtxtEditAmount += parseFloat($(this).text());
                }
                //sumColtxtEditAmount += parseFloat($(this).val());
            });
            sumColtxtEditAmount = sumColtxtEditAmount.toFixed(3);
            $('.txtEditAmount').text(GetChangeFormat(sumColtxtEditAmount));
           // $('.txtEditAmount').val(sumColtxtEditAmount.toFixed(2));

        }

        //For Toggle Details of billing informations
        $("#click-me-current").click(function () {
            $(".table .tdCurrent").toggleClass("hidecol", "");
            
           // $(".table .SumDiscountbillingCurrency").toggleClass("hidecol", "");
           // $(".table .SumInvoicebillingCurrency").toggleClass("hidecol", "");
           // debugger;

            if ($(".hidecolumn").css('display') == 'none') {
                $(".hidecolumn").show();
            } else {
                $(".hidecolumn").hide();
            }

            if ($("#SumInvoicebillingCurrency").css('display') == 'none') {
                $("#SumInvoicebillingCurrency").show();
            } else {
                $("#SumInvoicebillingCurrency").hide();
            }

            if ($("#SumDiscountbillingCurrency").css('display') == 'none') {
                $("#SumDiscountbillingCurrency").show();
            } else {
                $("#SumDiscountbillingCurrency").hide();
            }

            $(".current_opendiv").toggleClass("bg_current");
            $('table').resize();
        });
        //Added By Dipali V On 13rd Oct 2023 For PM Edit Value
        function PM_EditValue(AdviceId, TimesheetID, RoleID, EmployeeID) {
            //debugger;
            var PMEditValue = $("#txtEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();
            var PMFinalValue = $("#txtFinalAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
            //var PMFinalValue = $("#txtFinalAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();


         
            if (PMEditValue == "") {
                PMEditValue = "00.00";
               // $("#txtEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val(PMEditValue);
                $("#txtEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val(GetChangeFormat(PMEditValue));
            }

            if (PMEditValue.indexOf(',') > -1) {
                PMEditValue = PMEditValue.replaceAll(',', '');
            } else {
                PMEditValue = PMEditValue;
            }

            if (PMFinalValue.indexOf(',') > -1) {
                PMFinalValue = PMFinalValue.replaceAll(',', '');
            } else {
                PMFinalValue = PMFinalValue;
            }
            if (parseFloat(PMEditValue) > parseFloat(PMFinalValue)) {
                var DiffPMEdit = parseFloat(PMEditValue) - parseFloat(PMFinalValue);
                DiffPMEdit = DiffPMEdit.toFixed(3);
                //$("#txtPMEdiffEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val("+" + DiffPMEdit.toFixed(2));
                $("#txtPMEdiffEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val("+" + GetChangeFormat(DiffPMEdit));

            } else {

                var DiffPMEdit = parseFloat(PMFinalValue) - parseFloat(PMEditValue);
                DiffPMEdit = DiffPMEdit.toFixed(3);
                $("#txtPMEdiffEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val("-" + GetChangeFormat(DiffPMEdit));

            }
         
            //Added By Dipali V on 22nd Nov 2023 if change Edited Value then Remark Highlight
            if ($("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val().trim() == "") {
                $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).css("border-color", 'red');

            }
            else {
                $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).css("border-color", 'lightgrey');
            }
            //End of Added By Dipali V on 22nd Nov 2023 if change Edited Value then Remark Highlight
        }
        //End of Added By Dipali V On 13rd Oct 2023 For PM Edit Value

        //Added By Dipali V On 13rd Oct 2023 For PM Edit Value
        function validateremarks(AdviceId, TimesheetID, RoleID, EmployeeID) {

            if ($("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val().trim() == "") {
                $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).css("border-color", 'red');
                $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).focus();

            } else {
                $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).css("border-color", 'lightgrey');
                //$("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).focus();
            }

        }
        //End of Added By Dipali V On 13rd Oct 2023 For PM Edit Value

        //Added By Dipali V On 3rd Oct 2023 For change date format
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        //Added By Dipali V On 3rd Oct 2023  For  Get Project StartDate EndDate Date
        function GetProjectStartDateEndDate(ProjectID) {
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectStartDateEndDate", param, false);
            if (result != undefined) {
                return result;
            }
        }

        //Added By Dipali V On 3rd Oct 2023 For RestrictNonNumeric
        function RestrictNonNumeric(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }

            var dofocus = (arguments.length > 1) ? arguments[1] : true;
            if (!isNumeric(getInputValue(obj))) {
                if (dofocus) {
                    setFocus(obj);
                }

                return true;
            }
            return false;
        }
        //strResult[i].EmployeeId + ',' + strResult[i].SiteId + ' ,' + strResult[i].TimesheetId + ',' + strResult[i].AdviseId

        //Added By Dipali V On 3rd Oct 2023 For Get Timesheet Details
        function GetTimesheetDetails(EmployeeID, SiteID, TimesheetID, AdviseId, RoleID) {
            $("#billine_info_details").modal('show');
            $("#GRateMethod").text(GRateMethod);
            $("#GCRateMethod").text(GRateMethod);
            var Parameters = {
                EmployeeID: encodeURI(EmployeeID),
                ProjectSiteID: encodeURI(SiteID),
                TimesheetNo: encodeURI(TimesheetID),
                TimesheetAdvisedID: encodeURI(AdviseId),
                RoleID: encodeURI(RoleID),
            }
            var EmployeeName = "", GEmployeeID = "";
            var EmployeeCode = "";
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetTimesheetInformation", param, false);
            var strhtml = "";
            //debugger;
            /*Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
            var added_HolidayClass = '';
            
            if (strResult != "") {
                for (var i = 0; i < strResult.length; i++) {
                    /*Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                    if (strResult[i].Holiday != 0 || strResult[i].Holiday != "") {
                        added_HolidayClass = 'lgdHoliday';

                    } else {
                        added_HolidayClass = '';

                    }
                    /*End of Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                    if (EmployeeName == "") {
                        strhtml += '<tr class="total-row">';
                        strhtml += ' <td colspan="14" class="text-start">';
                        strhtml += strResult[i].SiteName;
                        //strhtml += ' Currency(&nbsp;<a href="javascript:;"><i class="fas fa-rupee-sign"></i>&nbsp;</a>)';
                        strhtml += ' </td>';
                        strhtml += '</tr>';
                        strhtml += '<tr>';
                        strhtml += '<td></td>';
                        strhtml += '<td colspan="13" class="text-start">' + strResult[i].EmployeeName + '</td>';
                        strhtml += '</tr>';
                        /*Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                        strhtml += '<tr class=' + added_HolidayClass + '>';
                        /*End of Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                        strhtml += '<td colspan="2"></td>';
                        strhtml += '<td>' + strResult[i].Date + '</td>';
                        strhtml += '<td>' + strResult[i].NormalHoursHHMM + '</td>';
                        strhtml += ' <td>' + strResult[i].NormalRate + '</td>';
                        //strhtml += ' <td>' + strResult[i].NormalBillingTotal.toFixed(2) + '</td>';
                        strhtml += ' <td>' + strResult[i].NormalBillingTotal + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraHoursHHMM + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraRate + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraBillingTotal + '</td>';
                        strhtml += '  <td>' + strResult[i].BillableHoursHHMM + '</td>';

                        strhtml += '  <td>' + strResult[i].BillableTotal + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableHoursHHMM + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableRate + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableTotal + '</td>';
                        strhtml += '</tr>';
                        //if (i == strResult.length - 1) {
                        //    strhtml += '<tr class="total-row text-end" style=" background-color: #c7d0d0;">';
                        //    strhtml += '<td colspan="3" class="text-start">';
                        //    strhtml += 'Total for Resource ' + strResult[i].EmployeeName + '';
                        //    strhtml += '</td>';
                        //    /*Added By Dipali V On 24th Oct 2023 For Change Variables*/
                        //    strhtml += '<td>' + strResult[i].SUMNormalHoursTotal + '</td>';
                        //    strhtml += '<td></td>';
                        //    strhtml += ' <td>' + strResult[i].SUMNormalBillingTotal.toFixed(2) + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMExtraHoursTotal + '</td>';
                        //    strhtml += '<td></td>';
                        //    strhtml += '<td>' + strResult[i].SUMExtraBillingTotal + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMBillableHours + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMBillableTotal + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMNonBillableHours + '</td>';
                        //    strhtml += '<td></td>';
                        //    strhtml += '<td>' + strResult[i].SUMNonBillableTotal + '</td>';
                        //    /*End of Added By Dipali V On 24th Oct 2023 For Change Variables*/
                        //    strhtml += '</tr>';
                        //}
                    }
                    else if (EmployeeName == strResult[i].EmployeeName) {
                        /*Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                        strhtml += '<tr class=' + added_HolidayClass + '>';
                        /*End of Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                        strhtml += '<td colspan="2"></td>';
                        strhtml += '<td>' + strResult[i].Date + '</td>';
                        strhtml += '<td>' + strResult[i].NormalHoursHHMM + '</td>';
                        strhtml += ' <td>' + strResult[i].NormalRate + '</td>';
                        //strhtml += ' <td>' + strResult[i].NormalBillingTotal.toFixed(2) + '</td>';
                        strhtml += ' <td>' + strResult[i].NormalBillingTotal + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraHoursHHMM + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraRate + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraBillingTotal + '</td>';
                        strhtml += '  <td>' + strResult[i].BillableHoursHHMM + '</td>';

                        strhtml += '  <td>' + strResult[i].BillableTotal + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableHoursHHMM + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableRate + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableTotal + '</td>';
                        strhtml += '</tr>';
                        //if (i == strResult.length - 1) {
                        //    strhtml += '<tr class="total-row text-end" style=" background-color: #c7d0d0;">';
                        //    strhtml += '<td colspan="3" class="text-start">';
                        //    strhtml += 'Total for Resource ' + strResult[i].EmployeeName + '';
                        //    strhtml += '</td>';
                        //    /*Added By Dipali V On 24th Oct 2023 For Change Variables*/
                        //    strhtml += '<td>' + strResult[i].SUMNormalHoursTotal + '</td>';
                        //    strhtml += '<td></td>';
                        //    strhtml += ' <td>' + strResult[i].SUMNormalBillingTotal.toFixed(2) + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMExtraHoursTotal + '</td>';
                        //    strhtml += '<td></td>';
                        //    strhtml += '<td>' + strResult[i].SUMExtraBillingTotal + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMBillableHours + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMBillableTotal + '</td>';
                        //    strhtml += '<td>' + strResult[i].SUMNonBillableHours + '</td>';
                        //    strhtml += '<td></td>';
                        //    strhtml += '<td>' + strResult[i].SUMNonBillableTotal + '</td>';
                        //    /*End of Added By Dipali V On 24th Oct 2023 For Change Variables*/
                        //    strhtml += '</tr>';
                        //}
                    }
                    else if (EmployeeName != strResult[i].EmployeeName) {
                        //strhtml += '<tr class="total-row text-end" style=" background-color: #c7d0d0;">';
                        //strhtml += '<td colspan="3" class="text-start">';
                        //strhtml += 'Total for Resource ' + EmployeeName + '';
                        //strhtml += '</td>';
                        ///*Added By Dipali V On 24th Oct 2023 For Change Variables*/
                        //strhtml += '<td>' + strResult[i].SUMNormalHoursTotal + '</td>';
                        //strhtml += '<td></td>';
                        //strhtml += ' <td>' + strResult[i].SUMNormalBillingTotal.toFixed(2) + '</td>';
                        //strhtml += '<td>' + strResult[i].SUMExtraHoursTotal + '</td>';
                        //strhtml += '<td></td>';
                        //strhtml += '<td>' + strResult[i].SUMExtraBillingTotal + '</td>';
                        //strhtml += '<td>' + strResult[i].SUMBillableHours + '</td>';
                        //strhtml += '<td>' + strResult[i].SUMBillableTotal + '</td>';
                        //strhtml += '<td>' + strResult[i].SUMNonBillableHours + '</td>';
                        //strhtml += '<td></td>';
                        //strhtml += '<td>' + strResult[i].SUMNonBillableTotal + '</td>';
                        ///*End of Added By Dipali V On 24th Oct 2023 For Change Variables*/
                        //strhtml += '</tr>';


                        strhtml += '<tr class="total-row">';
                        strhtml += ' <td colspan="14" class="text-start">';
                        strhtml += strResult[i].SiteName;
                        //strhtml += ' Currency(&nbsp;<a href="javascript:;"><i class="fas fa-rupee-sign"></i>&nbsp;</a>)';
                        strhtml += ' </td>';
                        strhtml += '</tr>';
                        strhtml += '<tr>';
                        strhtml += '<td></td>';
                        strhtml += '<td colspan="13" class="text-start">' + strResult[i].EmployeeName + '</td>';
                        strhtml += '</tr>';
                        /*Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                        strhtml += '<tr class=' + added_HolidayClass + '>';
                        /*End of Added By Dipali V On 24th Oct 2023 For Apply Holiday Class*/
                        strhtml += '<td colspan="2"></td>';
                        strhtml += '<td>' + strResult[i].Date + '</td>';
                        strhtml += '<td>' + strResult[i].NormalHoursHHMM + '</td>';
                        strhtml += ' <td>' + strResult[i].NormalRate + '</td>';
                        strhtml += ' <td>' + strResult[i].NormalBillingTotal.toFixed(3) + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraHoursHHMM + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraRate + '</td>';
                        strhtml += ' <td>' + strResult[i].ExtraBillingTotal + '</td>';
                        strhtml += '  <td>' + strResult[i].BillableHoursHHMM + '</td>';

                        strhtml += '  <td>' + strResult[i].BillableTotal + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableHoursHHMM + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableRate + '</td>';
                        strhtml += '  <td>' + strResult[i].NonBillableTotal + '</td>';


                    }
                    EmployeeName = strResult[i].EmployeeName;
                    GEmployeeID = strResult[i].EmployeeID;
                }

                $("#bodyTimesheet").html(strhtml);
            }


        }


        //Added By Dipali V On 13th May 2021 For Validate Generate Timesheet
        function ValidateGenerateTimesheet() {
            //debugger;
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_AddTimesheet/OnFromDateToDateValidationsCall", param, false);
            var strOverlapValidation = strResult.OverlapValidation;
            var intDAExceedStatusFlag = strResult.EntryFound;
            var TimeSheetInvoiceDates = strResult.TimeSheetInvoiceDates;
            var InvoiceDate = $("#txtInvoiceDate").val();
            var FromDate = $("#TxtFromDate").val();
            var ToDate = $("#TxtToDate").val();
            FromDate = FromDate.replace(/ /g, "-");
            ToDate = ToDate.replace(/ /g, "-");
            var StrFromDate = new Date(FromDate);
            var StrToDate = new Date(ToDate);

            var millisecondsPerDay = 1000 * 60 * 60 * 24;

            var millisBetween = StrToDate.getTime() - StrFromDate.getTime();
            var diffDate = millisBetween / millisecondsPerDay;
            var days = Math.round(diffDate) + 1;

            StrFromDate = months[StrFromDate.getMonth()];
            StrToDate = months[StrToDate.getMonth()];

            var OUWorkingDays = $("#txtOU").val();
            var WorkHours = $("#txtHRPerDay").val();
            var MonthlyHr = $("#txtMonthlyHr").val();
            var Discount = $("#txtDiscount").val();
            var Buffer = $("#txtBufferPercent").val();
            var RateMethodValue = $("#cboRateMethod").val();
            var RateMethod = $("#cboRateMethod option:selected").html();
            var HoursPerDay = ConvertDecimalToHourViceVersa(WorkHours, 2);
            var InvoiceDate = $("#txtInvoiceDate").val();
            //SelectedCurrentdate = InvoiceDate;
            if (intDAExceedStatusFlag == 0) {
                if (OUWorkingDays == "") {
                    alertify.error("<%= MyBase.GetResourceString("A_OUWorkingDaysValidation") %>")
                    $("#txtOU").focus();
                    return false;
                }

                if (WorkHours == "") {
                    alertify.error("<%= MyBase.GetResourceString("A_Workinghr") %>")
                    $("#txtHRPerDay").focus();
                    return false;
                }

                var result = GetProjectStartDateEndDate(ProjectID);
                for (var i = 0; i < result.length; i++) {
                    var ObjDate = result[i];

                    if (Date.parse(ObjDate.expectedStartdate) > Date.parse(FromDate) && Date.parse(ObjDate.expectedenddate) < Date.parse(ToDate)) {
                        alertify.error("<%= MyBase.GetResourceString("C_ProjectStartDateBetween") %> " + result[i].expectedStartdate + " and 'Project End Date' " + result[i].expectedenddate + "");
                        $("#TxtFromDate").focus();
                        return false;
                    }
                    else if (Date.parse(ObjDate.expectedenddate) < Date.parse(FromDate)) {
                        alertify.error("<%= MyBase.GetResourceString("C_ProjectStartDateGreater") %>  " + result[i].expectedenddate + "");
                        $("#TxtFromDate").focus();
                        return false;
                    }
                    else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(FromDate)) {
                        alertify.error("<%= MyBase.GetResourceString("C_ProjectStartDateLess") %>  " + result[i].expectedStartdate + "");
                        $("#TxtFromDate").focus();
                        return false;
                    }
                    else if (Date.parse(ObjDate.expectedenddate) < Date.parse(ToDate)) {
                        alertify.error("<%= MyBase.GetResourceString("C_ProjectEndDateGreater") %>  " + result[i].expectedenddate + "");
                        $("#TxtToDate").focus();
                        return false;
                    }

                    else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(ToDate)) {
                        alertify.error("<%= MyBase.GetResourceString("C_ProjectEndDateLess") %>  " + result[i].expectedStartdate + "");
                        $("#TxtToDate").focus();
                        return false;
                    }
                }

                //Check for FromDate>ToDate
                if (compareDates(FromDate, ToDate) == 1) {
                    alertify.error("<%= MyBase.GetResourceString("A_TodateGreaterFromDate") %>")
                    //$("#TxtFromDate").focus();
                    $("#TxtToDate").focus();
                    return false;
                }

                //Check for future date
                if (compareDates(FromDate, getDate1(1)) == 1) {
                    alertify.error("<%= MyBase.GetResourceString("A_FUTUREFROMDATE") %>")
                    $("#TxtFromDate").focus();
                    return false;
                }


                if (InvoiceDate == "") {
                    alertify.error("<%= MyBase.GetResourceString("C_InvoiceConversionDate") %>");
                    $("#txtInvoiceDate").focus();
                    return false;
                }

                if (Date.parse(SelectedCurrentdate.toShortFormat()) < Date.parse(InvoiceDate)) {
                    alertify.error("<%= MyBase.GetResourceString("C_InvoiceConversionDateFuture") %>  " + InvoiceDate + "");
                    $("#txtInvoiceDate").focus();
                    return false;
                }



                //if (globalcontracttype != "Fixed Fee") {
                if (ContractTypeID != "5") {
                    if (RateMethod == 'Monthly') {
                        if (days > 31) {
                            alertify.error("<%= MyBase.GetResourceString("A_SelFromDateToDate") %>")
                            return false;
                        }
                        if (StrFromDate != StrToDate) {
                            alertify.error("<%= MyBase.GetResourceString("A_SelFromDateToDate") %>")
                            return false;
                        }
                    }
                }
                if (strOverlapValidation != false) {
                    for (var i = 0; i < TimeSheetInvoiceDates.length; i++) {
                        var strFromDateValList = TimeSheetInvoiceDates[i]["FromDate"];
                        var strToDateValList = TimeSheetInvoiceDates[i]["ToDate"];
                        var strFromDateValNew = getDate(FromDate);
                        var strToDateValNew = getDate(ToDate);
                        var strFromDateVal = getDate(strFromDateValList);
                        var strToDateVal = getDate(strToDateValList);
                        if (strFromDateValNew <= strToDateVal && strToDateValNew >= strFromDateVal) {
                            alertify.error("<%= MyBase.GetResourceString("A_PMTimeSheetAlreadyExist") %>");
                            return false;
                        }
                    }
                }
                if (RestrictNonNumeric(document.getElementById("txtOU")) == true) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveNumeric") %>")
                    $("#txtOU").focus();
                    return false;
                }

                if (OUWorkingDays == 0 || OUWorkingDays > days) {
                    alertify.error("<%= MyBase.GetResourceString("A_OUgreaterthanOU") %> " + days);
                    $("#txtOU").focus();
                    return false;
                }


                var value = WorkHoursValidation("txtHRPerDay");
                if (value == true) {
                    if (RateMethod == 'Day') {
                        if (HoursPerDay > 24) {
                            alertify.error("<%= MyBase.GetResourceString("A_WorkingHoursPerDay") %>" + " 24:00 Hour");
                            $("#txtHRPerDay").focus();
                            return false;
                        }
                    }
                    if (ContractTypeID != "5") {
                        if (RateMethod == 'Monthly') {
                            if (GlobalMonthlyHr == '0') {
                                alertify.error("<%= MyBase.GetResourceString("A_WorkingPerMonthlyValidation") %>");
                                $("#txtMonthlyHr").focus();
                                return false;
                            }
                            if (HoursPerDay > GlobalMonthlyHr) {
                                alertify.error("<%= MyBase.GetResourceString("A_WorkingHoursPerDay") %>" + " Monthly Hr");
                                $("#txtHRPerDay").focus();
                                return false;
                            }
                        }
                    }

                    if (RateMethod == 'Hours') {
                        if (GlobalWorkHrsperday == '0') {
                            alertify.error("<%= MyBase.GetResourceString("A_workingperdayValidation") %>");
                            $("#txtMonthlyHr").focus();
                            return false;
                        }
                        if (HoursPerDay > GlobalWorkHrsperday) {

                            alertify.error("<%= MyBase.GetResourceString("A_WorkingHoursPerDay") %>" + " <%= MyBase.GetResourceString("C_ProjectLevel") %> ");
                            $("#txtHRPerDay").focus();
                            return false;
                        }
                    }

                    if (RestrictNonNumeric(document.getElementById("txtDiscount")) == true) {
                        alertify.error("<%= MyBase.GetResourceString("A_PositiveNumeric") %>");
                        $("#txtDiscount").focus();
                        return false;
                    }

                    if (Discount < 0 || Discount > 100) {
                        alertify.error("<%= MyBase.GetResourceString("A_DiscountPercentageValidation") %>");
                        $("#txtDiscount").focus();
                        return false;
                    }
                    if (ContractTypeID != "5") {
                        if (RateMethodValue == "0") {
                            alertify.error("<%= MyBase.GetResourceString("A_RateMethod") %>")
                            $("#cboRateMethod").focus();
                            return false;
                        }
                    }
                    if (ContractTypeID != "5") {
                        if (RestrictNonNumeric(document.getElementById("txtBufferPercent")) == true) {
                            alertify.error("<%= MyBase.GetResourceString("A_PositiveNumeric") %>");
                            $("#txtBufferPercent").focus();
                            return false;
                        }

                        if (Buffer < 0 || Buffer > 100) {
                            alertify.error("<%= MyBase.GetResourceString("A_BufferPercentageValidation") %>");
                            $("#txtBufferPercent").focus();
                            return false;
                        }
                    }

                    for (var i = 0; i < result.length; i++) {
                        var ObjDate = result[i];
                        if (Date.parse(ObjDate.expectedStartdate) > Date.parse(InvoiceDate)) {
                            alertify.error("<%= MyBase.GetResourceString("C_InvoicedatewithProject") %>" + result[i].expectedStartdate + "");
                            $("#txtInvoiceDate").focus();
                            return false;
                        }
                    }

                } else {
                    return false;
                }

            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_EmpPeriod") %>");
                return false;
            }
            return true;
        }


        //Added By Dipali V On 13th May 2021 For Save Data
        function SaveTimesheet() {
            // debugger;
            var Validate = 0;
            var Flag = 0;
            if (ValidateGenerateTimesheet() == true) {
                $('#tbodyTMDetail .edit').each(function (index, tr) {

                    var Control = this.id;
                    var P = Control.split("_");
                    if ($("#txtPMEdiffEditAmount_" + P[1] + "_" + P[2] + "_" + P[3] + "_" + P[4]).val() != "00.00") {
                        if ($("#txtPMEdiffEditAmount_" + P[1] + "_" + P[2] + "_" + P[3] + "_" + P[4]).val() != "00.00" && $("#txttextarea_" + P[1] + "_" + P[2] + "_" + P[3] + "_" + P[4]).val().trim() == "") {
                            Flag = 1;
                        }
                    }

                    if (Flag == 1) {
                        return;
                    }
                });
                if (Flag == 1) {
                    alertify.error("<%= MyBase.GetResourceString("A_ModifiedRecords") %> ");
                    Validate = 1;
                    return;
                }

                //var save = 0;
                var save = 1;

                if (Validate == 0) {
                    // save = 1;
                    $('#tbodyTMDetail tr').each(function (index, tr) {
                       // debugger;
                        var Result = false;
                        var Control = this.id;
                        var P = Control.split("_");
                        var AdviceId = P[1];
                        var TimesheetID = P[2];
                        var RoleID = P[3];
                        var EmployeeID = P[4];
                        var ControlID = ("txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID);
                        var txtWorkHrs = $("#txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();
                        if (save == 1) {
                            //Result = WorkHoursValidation(ControlID);
                            if (txtWorkHrs == "" || txtWorkHrs == undefined) {
                                alertify.error('<%= MyBase.GetResourceString("C_ActulaHrsBlank") %>');
                                $("#txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).focus();
                                return;
                            }
                            else {
                                Result = WorkHoursValidation(ControlID);
                            }

                        }

                        if (Result == true) {

                        }
                        else {
                            save = 0;
                        }

                    });

                }

                if (save == 1) {

                    SaveGrid("Saved");
                    save = 0;

                }

            }
        } var WhereFlag = "";
        function SaveGrid(WhereFlag) {
            $('#tbodyTMDetail tr').each(function (index, tr) {
                //debugger;
                var Control = this.id;
                var P = Control.split("_");
                var AdviceId = P[1];
                var TimesheetID = P[2];
                var RoleID = P[3];
                var EmployeeID = P[4];

                var BillingRate = $("#BillingRate_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();

                //alert(RateMethod)
                //return;
                var RateMethod = $("#cboRateMethod option:selected").html();


                var EditedActualHrs = $("#txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();
                if (EditedActualHrs.indexOf('.') > -1) {
                    EditedActualHrs = ConvertDecimalToHourViceVersa(EditedActualHrs, 1);
                }
                var WorkingDays = $("#WorkingDay_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text().trim();
                console.log(WorkingDays);
                var NoDayWorked = $("#NoDayWorked_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
                var DailyRate = $("#DailyRate_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
                //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                if (DailyRate.indexOf(',') > -1) {
                    DailyRate = DailyRate.replaceAll(',', '');
                } else {
                    DailyRate = DailyRate;
                }
               
                var InvoiceAmount = $("#InvoiceAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
                if (InvoiceAmount.indexOf(',') > -1) {
                    InvoiceAmount = InvoiceAmount.replaceAll(',', '');
                } else {
                    InvoiceAmount = InvoiceAmount;
                }
                  //End of Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                var OldNoDayWorked = $("#NoDayWorked_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).attr("dataValue");
                var OldInvoiceAmount = $("#InvoiceAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).attr("dataValue");
                var OldActualHrs = $("#txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).attr("dataValue");
                if (OldActualHrs.indexOf('.') > -1) {
                    OldActualHrs = ConvertDecimalToHourViceVersa(OldActualHrs, 1);
                }
                var fltDiscount = $("#Discount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
                 //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                if (fltDiscount.indexOf(',') > -1) {
                    fltDiscount = fltDiscount.replaceAll(',', '');
                } else {
                    fltDiscount = InvoiceAmount;
                }
                var FinalAmount = $("#txtFinalAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
                if (FinalAmount.indexOf(',') > -1) {
                    FinalAmount = FinalAmount.replaceAll(',', '');
                } else {
                    FinalAmount = FinalAmount;
                }
                var EditAmount = $("#txtEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();
                if (EditAmount.indexOf(',') > -1) {
                    EditAmount = EditAmount.replaceAll(',', '');
                } else {
                    EditAmount = EditAmount;
                }
                var PMFinalEditDiffValue = $("#txtPMEdiffEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();
                if (PMFinalEditDiffValue.indexOf(',') > -1) {
                    PMFinalEditDiffValue = PMFinalEditDiffValue.replaceAll(',', '');
                } else {
                    PMFinalEditDiffValue = PMFinalEditDiffValue;
                }
                 //End of Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                var Remarks = $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();
                var FromDate = $("#TxtFromDate").val();
                var ToDate = $("#TxtToDate").val();
                var OUWorkingDays = $("#txtOU").val();
                var WorkingHrsPerDay = $("#txtHRPerDay").val();
                var BufferPercentage = $("#txtBufferPercent").val();
                var MonthlyHr = $("#txtMonthlyHr").val();
                var Discount = $("#txtDiscount").val();
                var ActualDayBilling = $("#cboActualDayBilling").val();
                var EffortToConsider = $("#txtEffortToConsider").val();
                var FixedMonthlyRate = $("#cboFixedMonthlyRate").val();
                var OnsiteFull = $("#cboOnSiteFull").val();
                var RateMethod = $("#cboRateMethod").val();
                var InvoiceDate = $("#txtInvoiceDate").val();
                //var CurrencyID=
                if (Discount == '') {
                    Discount = "NULL";
                }
                if (BufferPercentage == '' || BufferPercentage == 0) {
                    BufferPercentage = "NULL";
                }

                //if (BufferPercentage == '') {
                //    BufferPercentage = 0;
                //}
                //if (InvoiceDate == '') {
                //    InvoiceDate = "0";
                //}
                //if (EffortToConsider == '') {
                //    EffortToConsider = "0"
                //} else {
                //    EffortToConsider = ConvertDecimalToHourViceVersa(EffortToConsider, 2);
                //}
                //if (OnsiteFull == '') {
                //    OnsiteFull = "0"
                //}

                if (ActualDayBilling == '') {
                    ActualDayBilling = "0"
                }
                if (FixedMonthlyRate == '') {
                    FixedMonthlyRate = "0"
                }
                //if (InvoiceDate == '') {
                //    InvoiceDate = "NULL";
                //}
                if (EffortToConsider == '' || EffortToConsider == 0) {
                    EffortToConsider = "NULL"
                } else {
                    EffortToConsider = ConvertDecimalToHourViceVersa(EffortToConsider, 2);
                }
                if (OnsiteFull == '') {
                    OnsiteFull = "NULL"
                }

                var SiteValidation = $("#cboSiteValidation").val();
                if (SiteValidation == "Yes") {
                    SiteValidation = 1;
                }
                else {
                    SiteValidation = 0;
                }

                var CapConsider = $("#cboCapConsider").val();
                if (CapConsider == "Yes") {
                    CapConsider = 1;
                }
                else {
                    CapConsider = 0;
                }

                if (CapConsider == "Yes") {
                    var FullCapHoliday = $("#cboCapHoliday").val();
                    if (FullCapHoliday == "Yes") {
                        FullCapHoliday = 1;
                    }
                    else {
                        FullCapHoliday = 0;
                    }
                } else {
                    FullCapHoliday = 0;
                }



                var Parameters = {
                    AdviceID: encodeURI(AdviceId),
                    TimesheetID: encodeURI(TimesheetID),
                    EmployeeID: encodeURI(EmployeeID),
                    ProjectID: encodeURI(ProjectID),
                    RoleID: encodeURI(RoleID),
                    BillingRate: encodeURI(BillingRate),
                    ActualRate: encodeURI(OldActualHrs),
                    WorkingDays: encodeURI(WorkingDays),
                    NoDayWorked: encodeURI(NoDayWorked),
                    DailyRate: encodeURI(DailyRate),
                    InvoiceAmount: encodeURI(InvoiceAmount),
                    fltDiscount: encodeURI(fltDiscount),
                    FinalAmount: encodeURI(FinalAmount),
                    EditAmount: encodeURI(EditAmount),
                    PMEditDifference: encodeURI(PMFinalEditDiffValue),
                    Remarks: encodeURI(Remarks),
                    FromDate: encodeURI(FromDate),
                    ToDate: encodeURI(ToDate),
                    OUWorkingDays: encodeURI(OUWorkingDays),
                    WorkingHrsPerDay: encodeURI(WorkingHrsPerDay),
                    BufferPercentage: encodeURI(BufferPercentage),
                    MonthlyHr: encodeURI(MonthlyHr),
                    Discount: encodeURI(Discount),
                    ActualDayBilling: encodeURI(ActualDayBilling),
                    EffortToConsider: encodeURI(EffortToConsider),
                    FixedMonthlyRate: encodeURI(FixedMonthlyRate),
                    OnsiteFull: encodeURI(OnsiteFull),
                    //RateMethod:encodeURI(RateMethod),
                    SiteValidation: encodeURI(SiteValidation),
                    CapConsider: encodeURI(CapConsider),
                    CapHoliday: encodeURI(FullCapHoliday),
                    InvoiceDate: encodeURI(InvoiceDate),
                    OldNoDayWorked: encodeURI(OldNoDayWorked),
                    OldInvoiceAmount: encodeURI(OldInvoiceAmount),
                    EditedActualHrs: encodeURI(EditedActualHrs)
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/SaveGridDetails", param, false);
                if (strResult != undefined) {
                    StartLoader("#bodyPreloader");
                    if (WhereFlag == "Saved") {

                    }
                    StopAjaxLoader("#bodyPreloader");
                }

            });
            if (WhereFlag == "Saved") {
                alertify.success('<%= MyBase.GetResourceString("C_DataSaved1")%>');
                GetDefaultFilter();
                GetTimesheetBillingDetails(ProjectTimesheetID, InvoiceTimesheetID);
                closeBillingDetails();//Hide Currency Icon
            }
        }


        //Added By Dipali V On 13rd Oct 2023 Hours Converted into Decimal
        function ConvertDecimalToHourViceVersa(WorkHrs, Flag) {

            var Parameters = {
                WorkHrs: encodeURI(WorkHrs),
                Flag: encodeURI(Flag),
            }
            var param = JSON.stringify(Parameters);
            var Hours = AJAXCallWithResult("/api/PM_ProjectTimesheet/ConvertDecimalToHourViceVersa", param, false);
            if (Hours != undefined) {
                return Hours;
            }
        }
        //Added By Dipali V On 13rd Oct 2023 For Change Others value when Actual Value change
        function ChangeActualHr(AdvisedID, TimsheetID, RoleID, EmployyeeID, MonthlyThresholdvalue, SiteMonthlyHours, IsOffShore) {
            if ($("#txtActualHr_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val() != "") {
                var txtActualHr = $("#txtActualHr_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val();
                var value = checkSpecialCharacter(txtActualHr);
                if (value == true) {
                    txtActualHr = "00:00";
                }
                else {
                    txtActualHr = txtActualHr;
                }
                if (txtActualHr.indexOf(':') > -1) {
                    txtActualHr = ConvertDecimalToHourViceVersa(txtActualHr, 2);
                }
                else {
                    txtActualHr = txtActualHr;
                }

                var WorkHrsPerday = $("#txtHRPerDay").val();
                WorkHrsPerday = ConvertDecimalToHourViceVersa(WorkHrsPerday, 2);

                var NODays = txtActualHr / WorkHrsPerday;

                $("#NoDayWorked_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(NODays.toFixed(3));

                var OnsiteFull = $('#cboOnSiteFull').val();
                var Sitevalidation = $('#cboSiteValidation').val();
                var strRateMethod = $('#cboRateMethod').val();
                var IsFixedmonthly = $('#cboFixedMonthlyRate').val();
                //var Workingdays = $('#txtOU').val();
                var Workingdays = $("#WorkingDay_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();// WorkingDay_7396_118_1087_4247
                //var Workingdays = $('#txtOU').val();
                //debugger;
                if (strRateMethod == "3") {
                    if (IsFixedmonthly == "Yes") {

                        if (OnsiteFull == "1") {
                            if (Sitevalidation == "Yes") {
                                if (IsOffShore == true) { // Offshore with Monthly
                                    if (parseInt($("#txtActualHr_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val()) <= parseInt(MonthlyThresholdvalue)) {
                                        //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                                        var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / (SiteMonthlyHours) * txtActualHr;
                                        invoiceamount = invoiceamount.toFixed(3);
                                        //$("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(invoiceamount.toFixed(2));
                                        $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));


                                        if ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().indexOf(',') > -1) {
                                            invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().replaceAll(',', '');
                                        } else {
                                            invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                        }
                                        var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                                        discount = discount.toFixed(3);
                                        $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));

                                        if (discount.indexOf(',') > -1) {
                                            discount = discount.replaceAll(',', '');
                                        } else {
                                            discount = discount;
                                        }
                                        var FinalAmount = invoiceamount - discount;
                                        FinalAmount = FinalAmount.toFixed(3);
                                        $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                                        $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                                    }
                                    else {
                                        var billingamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                        billingamount = billingamount.toFixed(3);
                                        $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(billingamount));

                                        if ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().indexOf(',') > -1) {
                                           var invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().replaceAll(',', '');
                                        } else {
                                           var invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                        }

                                        var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                                        discount = discount.toFixed(3);
                                        //$("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(discount.toFixed(2));
                                        $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                                        if (discount.indexOf(',') > -1) {
                                            discount = discount.replaceAll(',', '');
                                        } else {
                                            discount = discount;
                                        }
                                        //var FinalAmount = billingamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                        if (billingamount.indexOf(',') > -1) {
                                            billingamount = billingamount.replaceAll(',', '');
                                        } else {
                                            billingamount = billingamount;
                                        }

                                        var FinalAmount = billingamount - discount;
                                        FinalAmount = FinalAmount.toFixed(3);
                                        //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                                        $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                                        //$("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                                        $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                                    }
                                }
                                else {// Onsite with Monthly
                                    var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / (SiteMonthlyHours) * txtActualHr;
                                    invoiceamount = invoiceamount.toFixed(3);
                                    $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));
                                    if ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().indexOf(',') > -1) {
                                        invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().replaceAll(',', '');
                                    } else {
                                        invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                    }
                                    //var discount = ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / 100) * $("#txtDiscount").val();
                                    var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                                    discount = discount.toFixed(3);
                                    $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                                    if (discount.indexOf(',') > -1) {
                                        discount = discount.replaceAll(',', '');
                                    } else {
                                        discount = discount;
                                    }
                                    //var FinalAmount = invoiceamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                    var FinalAmount = invoiceamount - discount;
                                    FinalAmount = FinalAmount.toFixed(3);
                                    //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                                    $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                                   // $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                                    $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));

                                }
                            }
                            else {
                                if (IsOffShore == true) {// Onsite with Monthly
                                    if (parseInt($("#txtActualHr_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val()) <= parseInt(MonthlyThresholdvalue)) {
                                        var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / (SiteMonthlyHours) * txtActualHr;
                                        invoiceamount = invoiceamount.toFixed(3);
                                        //$("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(invoiceamount.toFixed(2));
                                        $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));
                                        //var discount = ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / 100) * $("#txtDiscount").val();
                                        if (invoiceamount.indexOf(',') > -1) {
                                            invoiceamount = invoiceamount.replaceAll(',', '');
                                        } else {
                                            invoiceamount = invoiceamount;
                                        }
                                        var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                                        discount = discount.toFixed(3);
                                        //$("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(discount.toFixed(2));
                                        $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                                        if (discount.indexOf(',') > -1) {
                                            discount = discount.replaceAll(',', '');
                                        } else {
                                            discount = discount;
                                        }
                                        //var FinalAmount = invoiceamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                        var FinalAmount = invoiceamount - discount;
                                        FinalAmount = FinalAmount.toFixed(3);
                                        //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                                        $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                                       // $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                                        $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                                    }
                                    else {
                                        var billingamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                        billingamount = billingamount.toFixed(3)
                                        $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(billingamount));
                                        if (billingamount.indexOf(',') > -1) {
                                            billingamount = billingamount.replaceAll(',', '');
                                        } else {
                                            billingamount = billingamount;
                                        }

                                        var discount = (billingamount / 100) * $("#txtDiscount").val();
                                        discount = discount.toFixed(3);
                                        $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                                        if (discount.indexOf(',') > -1) {
                                            discount = discount.replaceAll(',', '');
                                        } else {
                                            discount = discount;
                                        }
                                        //var FinalAmount = billingamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                        var FinalAmount = billingamount - discount;
                                        FinalAmount = FinalAmount.toFixed(3);
                                        //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                                        $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                                        //$("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                                        $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                                    }
                                }
                                else {
                                    var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / (GBLMonthlyHr) * txtActualHr;
                                    invoiceamount = invoiceamount.toFixed(3)
                                    $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));
                                    if (invoiceamount.indexOf(',') > -1) {
                                        invoiceamount = invoiceamount.replaceAll(',', '');
                                    } else {
                                        invoiceamount = invoiceamount;
                                    }
                                    //var discount = ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / 100) * $("#txtDiscount").val();
                                    var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                                    discount = discount.toFixed(3);
                                    //$("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(discount.toFixed(2));
                                    $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                                    if (discount.indexOf(',') > -1) {
                                        discount = discount.replaceAll(',', '');
                                    } else {
                                        discount = discount;
                                    }
                                    //var FinalAmount = invoiceamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                    var FinalAmount = invoiceamount - discount;
                                    FinalAmount = FinalAmount.toFixed(3);
                                    //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                                    $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                                    //$("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                                    $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                                    //End of Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                                }
                            }
                        }
                        else {
                            if (parseInt($("#txtActualHr_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val()) <= parseInt(MonthlyThresholdvalue)) {
                                // Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                                var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / (SiteMonthlyHours) * txtActualHr;
                                invoiceamount = invoiceamount.toFixed(3)
                                $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));
                                if (invoiceamount.indexOf(',') > -1) {
                                    invoiceamount = invoiceamount.replaceAll(',', '');
                                } else {
                                    invoiceamount = invoiceamount;
                                }
                                //var discount = ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / 100) * $("#txtDiscount").val();
                                var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                                discount = discount.toFixed(3);
                                //$("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(discount.toFixed(2));
                                $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                                if (discount.indexOf(',') > -1) {
                                    discount = discount.replaceAll(',', '');
                                } else {
                                    discount = discount;
                                }
                                //var FinalAmount = invoiceamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                var FinalAmount = invoiceamount - discount;
                                FinalAmount = FinalAmount.toFixed(3);
                                //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                                $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                                //$("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                                $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                                //End of Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                            }
                            else {
                                var billingamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                                billingamount = billingamount.toFixed(3)
                                $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(billingamount));

                                if (billingamount.indexOf(',') > -1) {
                                    billingamount = billingamount.replaceAll(',', '');
                                } else {
                                    billingamount = billingamount;
                                }

                                var discount = (billingamount / 100) * $("#txtDiscount").val();
                                discount = discount.toFixed(3);
                                $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));

                                if (discount.indexOf(',') > -1) {
                                    discount = discount.replaceAll(',', '');
                                } else {
                                    discount = discount;
                                }
                                //var FinalAmount = billingamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                                var FinalAmount = billingamount - discount;
                                FinalAmount = FinalAmount.toFixed(3);
                                //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                                $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                               // $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                                $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                                //End of Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                            }
                        }
                    }
                    else {
                        //debugger;
                        //Actual Day Billing
                        //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                        //var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / (Workingdays) * $("#NoDayWorked_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                        var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / (Workingdays) * NODays;
                        //$("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(invoiceamount.toFixed(2));
                        invoiceamount = invoiceamount.toFixed(3);
                        $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));
                        //var discount = ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() / 100) * $("#txtDiscount").val();
                       
                        if ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().indexOf(',') > -1) {
                            invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().replaceAll(',', '');
                        } else {
                            invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                        }
                        var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                        discount = discount.toFixed(3);
                        //$("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(discount.toFixed(2));
                        $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                        if (discount.indexOf(',') > -1) {
                            discount = discount.replaceAll(',', '');
                        } else {
                            discount = discount;
                        }
                        //var FinalAmount = invoiceamount - $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                        var FinalAmount = invoiceamount - discount;
                        FinalAmount = FinalAmount.toFixed(3);
                        //$("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                        $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                        //$("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                        $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                    }
                }
                else if (strRateMethod == "2") { // Daily
                     //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                    var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() * NODays;
                    invoiceamount = invoiceamount.toFixed(3);
                    $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));
                    if ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().indexOf(',') > -1) {
                        invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().replaceAll(',', '');
                    } else {
                        invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                    }
                    var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                    discount = discount.toFixed(3);
                    $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                    if (discount.indexOf(',') > -1) {
                        discount = discount.replaceAll(',', '');
                    } else {
                        discount = discount;
                    }
                    var FinalAmount = invoiceamount - discount;
                    FinalAmount = FinalAmount.toFixed(3);
                   // $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                    $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                    //$("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                    $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                }
                else { // Hourly
                    //debugger;
                     //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                    var invoiceamount = $("#BillingRate_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text() * txtActualHr;
                    //$("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(invoiceamount.toFixed(2));
                    $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(invoiceamount));
                    if ($("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().indexOf(',') > -1) {
                        invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text().replaceAll(',', '');
                    } else {
                        invoiceamount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                    }
                    var discount = (invoiceamount / 100) * $("#txtDiscount").val();
                    discount = discount.toFixed(3);
                    $("#Discount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(discount));
                    if (discount.indexOf(',') > -1) {
                        discount = discount.replaceAll(',', '');
                    } else {
                        discount = discount;
                    }
                    var FinalAmount = invoiceamount - discount;
                    FinalAmount = FinalAmount.toFixed(3);
                   // $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(FinalAmount.toFixed(2));
                    $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text(GetChangeFormat(FinalAmount));
                    //$("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(FinalAmount.toFixed(2));
                    $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val(GetChangeFormat(FinalAmount));
                }


                var NewInvoiceAmount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                var OldInvoiceAmount = $("#InvoiceAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).attr("datavalue");
               //Added &  Commented By Dipali V On 26th Dec 2023 For Get Correct Edited Value
                //if (parseFloat(NewInvoiceAmount) > parseFloat(OldInvoiceAmount)) {
                //    var DiffInvoiceAmount = parseFloat(NewInvoiceAmount) - parseFloat(OldInvoiceAmount);
                //    DiffInvoiceAmount = DiffInvoiceAmount.toFixed(2)
                //    //$("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("+" + DiffInvoiceAmount.toFixed(2));
                //    $("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("+" + GetChangeFormat(DiffInvoiceAmount));

                //} else {

                //    var DiffInvoiceAmount = parseFloat(OldInvoiceAmount) - parseFloat(NewInvoiceAmount);
                //    DiffInvoiceAmount = DiffInvoiceAmount.toFixed(2)
                //    //$("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("-" + DiffInvoiceAmount.toFixed(2));
                //    $("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("-" + GetChangeFormat(DiffInvoiceAmount));

                //}
                 //Added By Dipali V On 26th Dec 2023 For Get Proper Values in Money Format
                var FinalCAmount = $("#txtFinalAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).text();
                var EditAmount = $("#txtEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val();
                if (FinalCAmount.indexOf(',') > -1) {
                    FinalCAmount = FinalCAmount.replaceAll(',', '');
                } else {
                    FinalCAmount = FinalCAmount;
                }

                if (EditAmount.indexOf(',') > -1) {
                    EditAmount = EditAmount.replaceAll(',', '');
                } else {
                    EditAmount = EditAmount;
                }
                //debugger;
                if (parseFloat(EditAmount) > parseFloat(FinalCAmount)) {
                    var DiffInvoiceAmount = parseFloat(EditAmount) - parseFloat(FinalCAmount);
                    DiffInvoiceAmount = DiffInvoiceAmount.toFixed(3)
                    //$("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("+" + DiffInvoiceAmount.toFixed(2));
                    $("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("+" + GetChangeFormat(DiffInvoiceAmount));

                } else {

                    var DiffInvoiceAmount = parseFloat(FinalCAmount) - parseFloat(EditAmount);
                    DiffInvoiceAmount = DiffInvoiceAmount.toFixed(3)
                    //$("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("-" + DiffInvoiceAmount.toFixed(2));
                    $("#txtPMEdiffEditAmount_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val("-" + GetChangeFormat(DiffInvoiceAmount));

                }

                 //End of Added &  Commented By Dipali V On 26th Dec 2023 For Get Correct Edited Value
                if ($("#txttextarea_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).val().trim() == "") {
                    $("#txttextarea_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).css("border-color", 'red');

                }
                else {
                    $("#txttextarea_" + AdvisedID + "_" + TimsheetID + "_" + RoleID + "_" + EmployyeeID).css("border-color", 'lightgrey');
                }


            }
            var SumAmount = 0, SumDiscount = 0, SumFinalAmount = 0; sumColtxtEditAmount = 0, SumDiscountConvertedDiscount = 0, SumConvertedFinalAmount = 0;
            var ConvertedInvoiceAomunt = 0, ConvertedDiscount = 0, ConvertedFinalAmount = 0, SumAmountConvertedInvoiceAomunt = 0;
            //Added By Dipali V On 28th Dec 2023 For Get Converted Values if Site Currency Flag Enabled
            if (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == "true") {
                var InvoiceDate = $("#txtInvoiceDate").val();
                GetBillingCurrencyvalues = GetValueIntoBillingCurrency(TimesheetID, ProjectID, InvoiceDate);
                for (var i = 0; i < GetBillingCurrencyvalues.length; i++) {
                    ConvertedInvoiceAomunt = GetBillingCurrencyvalues[i].ConvertedInvoiceAomunt;
                    ConvertedDiscount = GetBillingCurrencyvalues[i].ConvertedDiscount;
                    ConvertedFinalAmount = GetBillingCurrencyvalues[i].ConvertedFinalAmount;
                }
            }
             //End of Added By Dipali V On 28th Dec 2023 For Get Converted Values if Site Currency Flag Enabled
            var column2 = $('.SumInvoice')
            jQuery.each(column2, function (number) {
                //debugger;
                if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                    if ($(this).text().indexOf(',') > -1) {
                        SumAmount += parseFloat($(this).text().replaceAll(',', ''));
                    } else {
                        SumAmount += parseFloat($(this).text());
                    }
                }
                else {
                    var SiteID = this.id.replace("InvoiceAmount_", "SiteCurrency_");
                    var SiteCurrency = $("#" + SiteID).text();
                    if (SiteCurrency.replace("(", "").replace(")", "").trim() == GBillingCurrencySymbol.trim()) {
                        if ($(this).text().indexOf(',') > -1) {
                            SumAmount += parseFloat($(this).text().replaceAll(',', ''));
                        } else {
                            SumAmount += parseFloat($(this).text());
                        }
                        console.log(SumFinalAmount);
                    } else {
                        //SumAmount += ConvertedInvoiceAomunt;
                        SumAmountConvertedInvoiceAomunt = ConvertedInvoiceAomunt;

                    }

                }
            });
            var SumAmount_N = SumAmount + SumAmountConvertedInvoiceAomunt;
            SumAmount_N = SumAmount_N.toFixed(3);
            $('#SumInvoice').text(GetChangeFormat(SumAmount_N));

            var SumColDiscount = $('.SumDiscount')
            jQuery.each(SumColDiscount, function (number) {
                //console.log('SumDiscount');
                //console.log(parseFloat($(this).text()));
                //SumDiscount += parseFloat($(this).text());
                if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                    if ($(this).text().indexOf(',') > -1) {
                        SumDiscount += parseFloat($(this).text().replaceAll(',', ''));
                    } else {
                        SumDiscount += parseFloat($(this).text());
                    }
                } else {
                    var SiteID = this.id.replace("Discount_", "SiteCurrency_");
                    var SiteCurrency = $("#" + SiteID).text();
                    if (SiteCurrency.replace("(", "").replace(")", "").trim() == GBillingCurrencySymbol.trim()) {
                        if ($(this).text().indexOf(',') > -1) {
                            SumDiscount += parseFloat($(this).text().replaceAll(',', ''));
                        } else {
                            SumDiscount += parseFloat($(this).text());
                        }
                        console.log(SumDiscount);
                    } else {
                        //SumDiscount += ConvertedDiscount;
                        SumDiscountConvertedDiscount = ConvertedDiscount;

                    }

                }
            });
            var SumDiscount_N = SumDiscount + SumDiscountConvertedDiscount;
            SumDiscount_N = SumDiscount_N.toFixed(3);
            $('#SumDiscount').text(GetChangeFormat(SumDiscount_N));


            var SumColInvoice = $('.SumFinalAmount')
            jQuery.each(SumColInvoice, function (number) {
                //debugger;
                if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                    if ($(this).text().indexOf(',') > -1) {
                        SumFinalAmount += parseFloat($(this).text().replaceAll(',', ''));
                    } else {
                        SumFinalAmount += parseFloat($(this).text());
                    }
                } else {
                    var SiteID = this.id.replace("txtFinalAmount_", "SiteCurrency_");
                    var SiteCurrency = $("#" + SiteID).text();
                    if (SiteCurrency.replace("(", "").replace(")", "").trim() == GBillingCurrencySymbol.trim()) {
                        if ($(this).text().indexOf(',') > -1) {
                            SumFinalAmount += parseFloat($(this).text().replaceAll(',', ''));
                        } else {
                            SumFinalAmount += parseFloat($(this).text());
                        }
                        console.log(SumFinalAmount);
                    } else {
                        //SumFinalAmount += ConvertedFinalAmount;
                        SumConvertedFinalAmount= ConvertedFinalAmount;

                    }
                }
               
            });

            var SumFinalAmount_N = SumConvertedFinalAmount + SumFinalAmount;
            SumFinalAmount_N = SumFinalAmount_N.toFixed(3);
            $('#SumFinalAmount').text(GetChangeFormat(SumFinalAmount_N));
          

            var sumtxtEditAmount = $('.sumtxtEditAmount')
            jQuery.each(sumtxtEditAmount, function (number) {
                //console.log('sumtxtEditAmount');
                //console.log(parseFloat($(this).text()));
               // sumColtxtEditAmount += parseFloat($(this).val());
                if ($(this).text().indexOf(',') > -1) {
                    sumColtxtEditAmount += parseFloat($(this).text().replaceAll(',', ''));
                } else {
                    sumColtxtEditAmount += parseFloat($(this).text());
                }
            });
            sumColtxtEditAmount = sumColtxtEditAmount.toFixed(3);
            $('.txtEditAmount').val(GetChangeFormat(sumColtxtEditAmount));


        }
        //End of Added By Dipali V On 13rd Oct 2023 For Get Actual Value

        //Added By Dipali V On 13rd Oct 2023 For Check TS Status
        var IsInvoicedatediatble = 0;
        function GetTimesheetReadyToAuthenticateFlag(intTimesheetNo) {
            var Parameters = {
                TimesheetID: encodeURI(intTimesheetNo)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetTimesheetReadyToAuthenticateFlag", param, false);

            if (strResult.length != 0) {

                ReadyToAuthenticate = strResult[0].ReadyToAuthenticate;
                Authenticated = strResult[0].Authenticated;
                if (ReadyToAuthenticate != "Y") {
                    $(".txtEditAmount,.sumtxtEditAmount").prop("disabled", true);
                    $("#txtInvoiceDate").prop("disabled", false);
                    $("#btnGenerateTimesheet").prop("disabled", false);
                    $("#btnSFA").prop("disabled", false);
                    $("#btnSave").prop("disabled", false);


                    if (GlobalRateMethod == 3) {
                        $(".clsActualHr").prop("disabled", false);
                    }

                }
                else {
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

        //For Resize Window
        function resizeSection() {
            var listviewTreeHeight = $(window).height();
            $('.init_grid_panel').css({
                'height': listviewTreeHeight - 150,
                "overflow-y": "auto",
                "overflow-x": "auto"
            });

        }
        //Added By Dipali V On 13rd Oct 2023 For Resize Window On load of page
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
        //Added By Dipali V On 13rd Oct 2023 For Resize Window On load of page

        //Added By Dipali V On 3rd Oct 2023 For Get Get MIN DA Validation
        function GetMINDAValidation() {
            var Parameters = {

            }
            var param = JSON.stringify(Parameters);
            strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetRestrictByMinHours_MinHoursForDAEntry", param, false);
            if (strResult != undefined) {
                RestrictByMinHours = strResult.RestrictByMinHours;
                MinHoursForDAEntry = strResult.MinHoursForDAEntry;
            }
        }

        //Added By Dipali V On 13rd Oct 2023 For Validat work hrs
        function WorkHoursValidation(ControlID) {

            var objHMEffort = document.getElementById(ControlID);

            var objVal = objHMEffort.value;

            var objOldVal = objHMEffort.value;

            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                //alert(objHMEffort.value);
                var isdigit = jQuery.isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;

                if (isdigit == false) {
                    alertify.error('<%= MyBase.GetResourceString("C_ActualHHMMVal")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                    alertify.error('<%= MyBase.GetResourceString("C_ActualHHMMVal")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    alertify.error('<%= MyBase.GetResourceString("C_ActualHHMMVal")%>');
                    setFocus(objHMEffort);
                    return false;
                }
                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error('<%= MyBase.GetResourceString("C_ActualHHMMVal")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");
                //Please enter Work (hrs) in H:M format.
                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error('<%= MyBase.GetResourceString("C_ActualHHMMVal")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                objHMEffort.value = objHMEffort.value.replace('.', ':');

                var WorkHour = objHMEffort.value;

                WorkHour = WorkHour.trim();
                var idxColon = WorkHour.indexOf(':');

                var hrs = WorkHour.substring(0, idxColon);
                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (hrs.indexOf("-") != -1) {
                    alertify.error('<%= MyBase.GetResourceString("C_HoursZero")%>');
                    setFocus(objHMEffort);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                    alertify.error('<%= MyBase.GetResourceString("C_HoursZero")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                if (mins.length > 2) {
                    //alert("Please enter Work (hrs) in H:M format.");
                    alertify.error('<%= MyBase.GetResourceString("C_HoursDecimal")%>');

                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {

                    alertify.error('<%= MyBase.GetResourceString("C_MinVali")%>');


                    setFocus(objHMEffort);

                    return false;
                }
                //var param = JSON.stringify();
                //var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetRestrictByMinHours_MinHoursForDAEntry", param, false);

                //if (strResult != undefined) {
                //    RestrictByMinHours = strResult.RestrictByMinHours;
                //    MinHoursForDAEntry = strResult.MinHoursForDAEntry;
                //}


                var MinDAENtryDisplay = "";
                var objMinWorkHrs = MinHoursForDAEntry;

                var MinDAEntry = objMinWorkHrs;

                var objRestrictByMinHours = RestrictByMinHours;


                if (MinDAEntry == 0.25) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:15"
                }
                else if (MinDAEntry == 0.50) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:30"
                }
                else if (MinDAEntry == 0.75) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:45"
                }
                if (objRestrictByMinHours == true) {
                    if (MinDAEntry == 0.016) {
                    }
                    else {
                        var minutes = WorkHour.split(':');

                        var p = minutes[0];
                        var dec = minutes[1];

                        if (dec.length > 2) {
                            dec = dec.substring(0, 2);
                        }
                        if (dec.length == 1) {
                            dec = dec + "0";
                        }
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            alertify.error("'<%= MyBase.GetResourceString("C_MultiplicationHours")%>' (" + MinDAENtryDisplay + ") min");
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }

            }
            return true;
        }
        //End of  By Dipali V On 13rd Oct 2023 For Saving Billing Information Details

        //Added By Dipali V On 13rd Oct 2023 For Saving Billing Information Details
        function Save_InvoiceData(AdviceId, TimesheetID, RoleID, EmployeeID) {

            var PMEditValue = $("#txtEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();

            var PMFinalEditDiffValue = $("#txtPMEdiffEditAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();

            var Remarks = $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();

            var InvoiceAmount = $("#InvoiceAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();

            var Discount = $("#Discount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();

            var NoDayWorked = $("#NoDayWorked_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
            var FinalAmount = $("#txtFinalAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).text();
    
            var OldNoDayWorked = $("#NoDayWorked_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).attr("dataValue");

            var OldInvoiceAmount = $("#InvoiceAmount_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).attr("dataValue");

            var oldActualHrs = $("#txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).attr("dataValue");
            var fltoldActualHrs = ConvertDecimalToHourViceVersa(oldActualHrs, 2);
            if (oldActualHrs.indexOf('.') > -1) {
                oldActualHrs = ConvertDecimalToHourViceVersa(oldActualHrs, 1);
            }

            var EditActualHr = $("#txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val();
            var fltEditActualHr = ConvertDecimalToHourViceVersa(EditActualHr, 2);
            if (EditActualHr.indexOf('.') > -1) {
                var EditActualHr = ConvertDecimalToHourViceVersa(EditActualHr, 1);
            }

            var ControlID = ("txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID);
            //debugger;
            var Result = WorkHoursValidation(ControlID);
            if (Result == true) {
                if ((parseFloat(fltoldActualHrs) != parseFloat(fltEditActualHr)) || PMFinalEditDiffValue != "00.00") {
                    if (parseFloat(fltEditActualHr) == 0) {
                        alertify.error('<%= MyBase.GetResourceString("C_ActulaHrsBlank")%>');
                        $("#txtActualHr_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).focus();
                        return;
                    }

                    if ($("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).val().trim() == "") {
                        $("#txttextarea_" + AdviceId + "_" + TimesheetID + "_" + RoleID + "_" + EmployeeID).focus();
                        alertify.error('<%= MyBase.GetResourceString("C_RemarkBlank")%>');
                        return;
                    }
                    //debugger;
                    // Added By Dipali V On 26th Dec 2023 For Save FinalAmount
                    if (PMEditValue.indexOf(',') > -1) {
                        PMEditValue = PMEditValue.replaceAll(',', '');
                    } else {
                        PMEditValue = PMEditValue;
                    }

                    if (PMFinalEditDiffValue.indexOf(',') > -1) {
                        PMFinalEditDiffValue = PMFinalEditDiffValue.replaceAll(',', '');
                    } else {
                        PMFinalEditDiffValue = PMFinalEditDiffValue;
                    }

                    if (InvoiceAmount.indexOf(',') > -1) {
                        InvoiceAmount = InvoiceAmount.replaceAll(',', '');
                    } else {
                        InvoiceAmount = InvoiceAmount;
                    }

                    if (OldInvoiceAmount.indexOf(',') > -1) {
                        OldInvoiceAmount = OldInvoiceAmount.replaceAll(',', '');
                    } else {
                        OldInvoiceAmount = OldInvoiceAmount;
                    }

                    if (Discount.indexOf(',') > -1) {
                        Discount = Discount.replaceAll(',', '');
                    } else {
                        Discount = Discount;
                    }


                    if (FinalAmount.indexOf(',') > -1) {
                        FinalAmount = FinalAmount.replaceAll(',', '');
                    } else {
                        FinalAmount = FinalAmount;
                    }
                    // End of Added By Dipali V On 26th Dec 2023 For Save FinalAmount
                    var Parameters = {
                        AdviceID: encodeURI(AdviceId),
                        TimesheetID: encodeURI(TimesheetID),
                        EmployeeID: encodeURI(EmployeeID),
                        ProjectID: encodeURI(ProjectID),
                        RoleID: encodeURI(RoleID),
                        PMEditValue: encodeURI(PMEditValue),
                        PMFinalEditDiffValue: encodeURI(PMFinalEditDiffValue),
                        Remarks: encodeURI(Remarks),
                        InvoiceAmount: encodeURI(InvoiceAmount),
                        OldInvoiceAmount: encodeURI(OldInvoiceAmount),
                        Discount: encodeURI(Discount),
                        NoDayWorked: encodeURI(NoDayWorked),
                        OldNoDayWorked: encodeURI(OldNoDayWorked),
                        ActualRate: encodeURI(oldActualHrs),
                        EditedActualHrs: encodeURI(EditActualHr),
                        FinalAmount: encodeURI(FinalAmount)// Added By Dipali V On 26th Dec 2023 For Save FinalAmount

                    }
                    console.log(Parameters);

                    var param = JSON.stringify(Parameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/SaveUpdateAdviceDetails", param, false);
                    if (strResult != undefined) {
                        alertify.success('<%= MyBase.GetResourceString("C_DataSaved1")%>');
                        GetDefaultFilter();
                        GetTimesheetBillingDetails(TimesheetID, InvoiceTimesheetID);
                    }
                }
            }

        }
        //End of Added By Dipali V On 13rd Oct 2023 For Saving Billing Information Details

        //Added By Dipali V On 13rd Oct 2023 For Delete Details of advice table
        var GAdviceId = 0;
        var GTimesheetID = 0;
        function Delete_Onclick(AdviceId, TimesheetID, RoleID, EmployeeID) {
            $("#deleteinfomodal_List").modal('show');
            GAdviceId = AdviceId;
            GTimesheetID = TimesheetID;
           <%-- var Parameters = {
                AdviceID: encodeURI(AdviceId),
                TimesheetID: encodeURI(TimesheetID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/DeleteAdvice", param, false);
            if (strResult != undefined) {
                alertify.success('<%= MyBase.GetResourceString("C_DataDelete")%>');
                GetDefaultFilter();
                GetTimesheetBillingDetails(TimesheetID, InvoiceTimesheetID);
            }--%>
        }

        function DeleteTSData_Biiling(flag) {
           
            if (flag == "1")
            {
                var Parameters = {
                    AdviceID: encodeURI(GAdviceId),
                    TimesheetID: encodeURI(GTimesheetID)
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/DeleteAdvice", param, false);
                if (strResult != undefined) {
                    alertify.success('<%= MyBase.GetResourceString("C_DataDelete")%>');
                    GetDefaultFilter();
                    GetTimesheetBillingDetails(GTimesheetID, InvoiceTimesheetID);
                }

            }
            else {
                $("#deleteinfomodal_List").modal('hide');
            }

        }


        //Added By Dipali V On 16th Oct 2023 For Timesheet Generate Count
        function GetTimesheetGenerateCount(ProjectTimesheetID) {
            
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetTimesheetGenerateCount", param, false);
            if (strResult != undefined) {
              //  return strResult;
                //debugger;
                for (var i = 0; i < strResult.length; i++) {
                    TotalCountTS = strResult[i].TotalCountTS
                    TotalModifiedTSCount = strResult[i].TotalModifiedTSCount
                }
            }
            return TotalCountTS + "&&&&" + TotalModifiedTSCount
        }

        ////Added By Dipali V On 16th Oct 2023 For Timesheet Generate Count
        //function GetTimesheetGenerateCount(ProjectTimesheetID) {
        //    var Parameters = {
        //        TimesheetNo: encodeURI(ProjectTimesheetID),

        //    }
        //    var param = JSON.stringify(Parameters);
        //    var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetTimesheetGenerateCount", param, false);
        //    if (strResult != undefined) {
        //        return strResult;
        //    }
        //}

        //Added By Dipali V On 16th Oct 2023 For Generate Timesheet
        $("#btnGenerateTimesheet").on("click", function () {
            var TimesheetNo = "";
            var ExtraTask = 0;
           // var Isvalidate = validateSFA();
            //if (Isvalidate == 0) {
           
            //Modified By Dipali V On 1st Nov 2023 For Regenerated
            //var GenerateCount = GetTimesheetGenerateCount(ProjectTimesheetID)
            var GenerateCount = GetTimesheetGenerateCount(ProjectTimesheetID);
            GetGenerateCount = GenerateCount.split("&&&&");
            TotalCountTS = GetGenerateCount[0];
            TotalModifiedTSCount = GetGenerateCount[1];
            //End of Modified By Dipali V On 1st Nov 2023 For Regenerated

                <%--var FromDate = $("#ProjectFromdate").text();
                var ToDate = $("#ProjectTodate").text();
                var Parameters = {
                    TimesheetNo: encodeURI(GlobalSelectedintTimesheetNo),
                    ProjectID: encodeURI(ProjectID),
                    UserID: encodeURI(UserID),
                    FromDate: encodeURI(FromDate.trim()),
                    ToDate: encodeURI(ToDate.trim())
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/RegenrateTimesheet", param, false);
                if (strResult != undefined) {
                    TimesheetNo = strResult;
                }
                var RegenrateCount = GetTimesheetGenerateCount(TimesheetNo);
                ExtraTask = parseInt(RegenrateCount) - parseInt(GenerateCount);
                if (ExtraTask > 0) {
                    $("#RMmodal").modal('show');
                    $("#spnalert").text("'" + ExtraTask + "' <%= MyBase.GetResourceString("C_MoreTask")%> ");

                }
                else {
                    SaveBillingInformation();
                }--%>
            //}
             //End of Modified By Dipali V On 1st Nov 2023 For Regenerated

            if (TotalModifiedTSCount > 0) {
                $("#RMmodal").modal('show');
               // $("#spnalert").text("'Re-Generate' will undo any modifications made through 'EASY EDIT' or 'SMART EDIT'.Do you want to continue?");
                $("#spnalert").html("'Re-Generate' will undo all <b> modifications </b> made by you .Do you want to continue?");
             }
             else {
                 //SaveBillingInformation();
                 RegenerateTimesheet();
             }

        });

        //Added By Dipali V On 16st Oct 2023 after Regenrate Update Billing Details
        function Regenrate_OnClick(Flag) {
            //SaveBillingInformation();
            //$("#RMmodal").modal('hide');
            if (Flag == 1) {
                //SaveBillingInformation();
                RegenerateTimesheet();
                $("#RMmodal").modal('hide');
            } else {
                $("#RMmodal").modal('hide');
            }

        }
        //Added By Dipali V On 1st Nov 2023 after Regenrate Update Billing Details
        function RegenerateTimesheet() {
           
            var FromDate = $("#TxtFromDate").val();
            var ToDate = $("#TxtToDate").val();
            var Parameters = {
                TimesheetNo: encodeURI(GlobalSelectedintTimesheetNo),
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID),
                FromDate: FromDate.trim(),
                ToDate: ToDate.trim()
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/RegenrateTimesheet", param, false);
            if (strResult != undefined) {
                GlobalSelectedintTimesheetNo = strResult;
                ProjectTimesheetID = strResult;
                //GetTimesheetBillingDetails(GlobalSelectedintTimesheetNo, InvoiceTimesheetID);
                //GetDefaultFilter();
                GetTimesheetReadyToAuthenticateFlag(ProjectTimesheetID);
                GetProjectDetails(ProjectTimesheetID, ProjectID, $("#TxtFromDate").val(), $("#TxtToDate").val());
                GetTimesheetBillingDetails(ProjectTimesheetID, InvoiceTimesheetID);
                
                GetDefaultFilter();
                alertify.success('<%= MyBase.GetResourceString("C_PTRG")%>');
            }
        }
        //End of Added By Dipali V On 1st Nov 2023 after Regenrate Update Billing Details


        //Added By Dipali V On 16st Oct 2023 after Regenrate Update Billing Details
        function SaveBillingInformation() {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID)

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/SaveBillingInformation", param, false);
            if (strResult != undefined) {
                GetTimesheetBillingDetails(ProjectTimesheetID, InvoiceTimesheetID);
                GetDefaultFilter();

                alertify.success('<%= MyBase.GetResourceString("C_PTRG")%>');
            }

        }

        //Added By Dipali V On 16th Oct 2023 For SFA Timesheet
        $("#btnSFA").on("click", function () {
            var Isvalidate = validateSFA();
            if (Isvalidate == 0) {
                var Parameters = {
                    TimesheetNo: encodeURI(ProjectTimesheetID),
                    ProjectID: encodeURI(ProjectID),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/SendForApproval", param, false);
                const myArray = strResult.split("&&");
                GetTimesheetBillingDetails(ProjectTimesheetID, InvoiceTimesheetID);
                GetDefaultFilter();
                if (myArray[0] == "True") {
                    window.open('../Email/SendEmail.aspx?MessageID=3&TimeSheetID=' + ProjectTimesheetID + '&ProjectID=' + ProjectID + '&UserID=' + UserID, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500');
                }
                $("#btnGenerateTimesheet").css('display', 'none');
                $("#btnSFA").css('display', 'none');
                $("#btnSave").css('display', 'none');
                alertify.success('<%= MyBase.GetResourceString("C_PTSFA")%>');
            }

        });


        //Added By Dipali V On 16th Oct 2023 For Validation Send for approval
        var Validate = 0;
        function validateSFA() {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/validateSFA", param, false);
            if (strResult != "") {
                const myArray = strResult.split("&&");
                if (myArray[0] == "C") {
                     //Added By Dipali V On 25th Oct 2023 For Remove Space and Get Proper alert
                    var NoResource = myArray[0].trim().split(":")
                    //End of Added By Dipali V On 25th Oct 2023 For Remove Space and Get Proper alert
                    if (NoResource[1] == "") {
                        alertify.error('<%= MyBase.GetResourceString("C_NoResource")%>');
                        Validate = 1;
                        StopAjaxLoader("#bodyPreloader");
                    }
                }
                else {
                    if (myArray[1] != "") {
                        //Added By Dipali V On 25th Oct 2023 For Remove Space and Get Proper alert
                        var ApproverName = myArray[1].trim().split(":")
                        //End of Added By Dipali V On 25th Oct 2023 For Remove Space and Get Proper alert
                        if (ApproverName[1] == "") {
                            alertify.error('<%= MyBase.GetResourceString("C_NoApprover")%>');
                            Validate = 1;
                            StopAjaxLoader("#bodyPreloader");
                        }
                    }
                }
            }
            return Validate;
        }



        //function IROnClick() {
        //    var browser = navigator.appName;
        //    if (browser == "Microsoft Internet Explorer") {
        //        window.opener = self;
        //    }
        //    //window.open('Initialtive_details.aspx', 'null', 'width = 900, height = 350,toolbar = no, scrollbars = no, location = no, resizable = yes');
        //    window.open('Edit_IR-PIR.html', 'null', 'width = 1000, height = 650,toolbar = no, scrollbars = no, location = no, resizable = yes');
        //    window.moveTo(0, 0);
        //    window.resizeTo(screen.width, screen.height - 100);
        //    self.close();

        //}

        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip()
        });

        $(document).on("click", function () {
            $(".tooltip").remove();
        });


       

        $(function () {

            //change date format
            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
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
            $('#fromDate, #toDate, #easyEditFromDate, #easyEditToDate, #fromDateFilter, #toDateFilter, #input_FromDate, #salesPeriodStartDate, #salesPeriodEndDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy'
            });


            //start bootstrap datepicker css
            $(document).on('click', '.browse', function () {
                var file = $(this).parent().parent().parent().find('.file');
                file.trigger('click');
            });
            $(document).on('change', '.file', function () {
                $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
            });


            $(".modal").scroll(function () {
                $('#ui-datepicker-div').hide();
            });

        });
        //Added By Dipali V On 1st Nov 2023 For Setting
        function GetProjectSetting(DivID,InfoDivID) {
            //$("#" + InfoDivID).toggleClass('d-none');
        }
        //Added By Dipali V On 1st Nov 2023 For Setting
        function Setting_onclick() {
           // debugger;
            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_Setting'));
            myOffcanvas.show();
           // GetProjectTimesheetList(null, $("#cboProject").val()); // For Refresh Issue
            GetProjectSettingDetails();
            if (GTotalGeneratedTSCount > 0) {
                $("#slider1").prop("disabled", true);
                $("#slider2").prop("disabled", true);
                $("#slider3").prop("disabled", true);
                $("#slider7").prop("disabled", true);//Added by dipali v on 28th dec 2023 for check currency related configuration
            } else {
                $("#slider1").prop("disabled", false);
                $("#slider2").prop("disabled", false);
                $("#slider3").prop("disabled", false);
                $("#slider7").prop("disabled", false);//Added by dipali v on 28th dec 2023 for check currency related configuration
            }
        }

        function GetProjectSettingDetails() {
            var IsData = 0;
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetProjectSettingDetails", param, false);
            if (strResult != "") {
               //debugger;
                for (var i = 0; i < strResult.length; i++)
                {
                    IsData = 1;
                    var IsIR_Approved = strResult[i].IsIR_Approved
                    var IsIR_FinalValue = strResult[i].IsIR_FinalValue
                    var IsRate_CorporateValidation = strResult[i].IsRate_CorporateValidation
                    var IsIR_TimesheetExpense = strResult[i].IsIR_TimesheetExpense
                    var IsIR_Rejected = strResult[i].IsIR_Rejected
                    var IsAllowSmartEdit = strResult[i].IsAllowSmartEdit
                    var IsTS_WorkingDayCorporateValidation = strResult[i].IsTS_WorkingDayCorporateValidation
                    var IsAllValuesInSiteCurrency = strResult[i].IsAllValuesInSiteCurrency // Added By Dipali V On 29th Dec 2023 For Cofiguration For Currency

                    $("#slider1").prop("checked", IsRate_CorporateValidation); 
                    //if (IsRate_CorporateValidation == true || IsRate_CorporateValidation == 1) {
                    //    GetProjectSetting("slider1", "settingDesc1")
                    //}

                    $("#slider2").prop("checked", IsTS_WorkingDayCorporateValidation);
                    //if (IsTS_WorkingDayCorporateValidation == true || IsTS_WorkingDayCorporateValidation == 1) {
                    //    GetProjectSetting("slider2", "settingDesc2")
                    // }

                    $("#slider3").prop("checked", IsIR_FinalValue);
                    //if (IsIR_FinalValue == true || IsIR_FinalValue == 1) {
                    //    GetProjectSetting("slider3", "settingDesc3")
                    //}

                    $("#slider4").prop("checked", IsAllowSmartEdit);
                    $("#slider4").prop("checked", IsAllowSmartEdit);
                    $("#slider7").prop("checked", IsAllValuesInSiteCurrency); // Added By Dipali V On 29th Dec 2023 For Cofiguration For Currency
                    //if (IsAllowSmartEdit == true || IsAllowSmartEdit == 1) {
                    //    GetProjectSetting("slider4", "settingDesc4")
                    //}

                    
                    BindProjectTimesheetApprover();
                    BindIRTimesheetApprover();
                    BindIRTimesheetGenerator();
                    if (strResult[i].ProjectTimesheetApprover != null) { // For Apply Placeholder
                        $("#CboProjectTimesheetApprover").val(strResult[i].ProjectTimesheetApprover);
                    }
                    if (strResult[i].ProjectIRApprover != null) {// For Apply Placeholder
                        $("#CboProjectIRApprover").val(strResult[i].ProjectIRApprover);
                    }
                    if (strResult[i].ProjectIRGenerator != null) {// For Apply Placeholder
                        $("#CboProjectIRGenerator").val(strResult[i].ProjectIRGenerator);
                    }
                    $(".selectpicker").selectpicker('refresh');
                }
            }
            if (IsData == 0) {
                BindProjectTimesheetApprover();
                BindIRTimesheetApprover();
                BindIRTimesheetGenerator();
            }


        }

        function SaveProjectLevelSettings()
        {
            //debugger;
            var IsRate_CorporateValidation = 0;
            var IsTS_WorkingDayCorporateValidation = 0;
            var IsIR_FinalValue = 0;
            var IsAllowSmartEdit = 0;
            var IsIR_Approved = 0;
            var IsIR_Rejected = 0;
            var IsAllValuesInSiteCurrency = 0;
            if ($("#slider1").prop("checked") == true)
            {
                IsRate_CorporateValidation = 1;
            }
            if ($("#slider2").prop("checked") == true) {
                IsTS_WorkingDayCorporateValidation = 1;
            }
            if ($("#slider3").prop("checked") == true) {
                IsIR_FinalValue = 1;
            }
            if ($("#slider4").prop("checked") == true) {
                IsAllowSmartEdit = 1;
            }

            if ($("#slider7").prop("checked") == true) {
                IsAllValuesInSiteCurrency = 1;
            }

            
            ProjectTimesheetApprover = $("#CboProjectTimesheetApprover").val();
            ProjectIRApprover = $("#CboProjectIRApprover").val();
            ProjectIRGenerator = $("#CboProjectIRGenerator").val();
            if (ProjectTimesheetApprover == null || ProjectTimesheetApprover =="") {
                ProjectTimesheetApprover = 0;
            }

            if (ProjectIRApprover == null || ProjectIRApprover == "") {
                ProjectIRApprover = 0;
            }

            if (ProjectIRGenerator == null || ProjectIRGenerator == "") {
                ProjectIRGenerator = 0;
            }

            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                UserName: encodeURI(UserName),
                IsRate_CorporateValidation: encodeURI(IsRate_CorporateValidation),
                IsTS_WorkingDayCorporateValidation: encodeURI(IsTS_WorkingDayCorporateValidation),
                //IsIR_TimesheetExpense: encodeURI(IsIR_TimesheetExpense),
                IsIR_FinalValue: encodeURI(IsIR_FinalValue),
                IsAllowSmartEdit: encodeURI(IsAllowSmartEdit),
                IsIR_Approved: encodeURI(IsIR_Approved),
                IsIR_Rejected: encodeURI(IsIR_Rejected),
                IsAllValuesInSiteCurrency: encodeURI(IsAllValuesInSiteCurrency),//Added By Dipali V On 27th Dec 2023 For Which Currency Consider for Calculation on billing Information Page
                ProjectTimesheetApprover: encodeURI(ProjectTimesheetApprover),
                ProjectIRApprover: encodeURI(ProjectIRApprover),
                ProjectIRGenerator: encodeURI(ProjectIRGenerator)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/SaveProjectLevelSettings", param, false);
            if (strResult != "") {
               // debugger;
                alertify.success('<%= MyBase.GetResourceString("C_ProjectSettingSaved")%>');
                GetProjectSettingDetails();

            }
        }

     
        var selectedTimesheetBlockingEmployeeid = "";
        function BindProjectTimesheetApprover()
        {
            var Parameters = {
                ProjectID: encodeURI(ProjectID)

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetProjectTimesheetApprover", param, false);
            if (strResult != "") {
               // $("#CboProjectTimesheetApprover").append('<option value="0">Select Project Timesheet Approver</option>');
                var v1 = "";
                if (strResult.length > 0) {
                    for (var i = 0; i < strResult.length; i++) {
                        var objCbo1 = document.getElementById("CboProjectTimesheetApprover");
                        $("#CboProjectTimesheetApprover option").remove();
                        $("#CboProjectTimesheetApprover").append('<option value="0">Select Project Timesheet Approver</option>');
                        for (var i = 0; i < strResult.length; i++) {
                            var ObjStatus = strResult[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.text = ObjStatus.UserName;
                            objOption.value = ObjStatus.EmployeeID;
                        }
                    }
                }

               
                $(".selectpicker").selectpicker('refresh');
            }
        }

        function BindIRTimesheetApprover()
        {
            var Parameters = {
                ProjectID: encodeURI(ProjectID)

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetProjectIRApprover", param, false);
            if (strResult != "") {
                //debugger;
                var v1 = "";
                if (strResult.length > 0) {
                    for (var i = 0; i < strResult.length; i++) {
                        var objCbo1 = document.getElementById("CboProjectIRApprover");
                        $("#CboProjectIRApprover option").remove();
                        $("#CboProjectIRApprover").append('<option value="0">Select IR Approver</option>');
                        for (var i = 0; i < strResult.length; i++) {
                            var ObjStatus = strResult[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.text = ObjStatus.UserName;
                            objOption.value = ObjStatus.EmployeeID;
                        }
                    }
                }


                $(".selectpicker").selectpicker('refresh');
            }
        }

        function BindIRTimesheetGenerator() {
            var Parameters = {
                ProjectID: encodeURI(ProjectID)

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetProjectIRGenerator", param, false);
            if (strResult != "") {

                var v1 = "";
                if (strResult.length > 0) {
                    for (var i = 0; i < strResult.length; i++) {
                        var objCbo1 = document.getElementById("CboProjectIRGenerator");
                        $("#CboProjectIRGenerator option").remove();
                        $("#CboProjectIRGenerator").append('<option value="0">Select  IR Generator</option>');
                        for (var i = 0; i < strResult.length; i++) {
                            var ObjStatus = strResult[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.text = ObjStatus.USERNAME;
                            objOption.value = ObjStatus.EMPLOYEEID;
                        }
                    }
                }
                $(".selectpicker").selectpicker('refresh');
            }
        }

        function AddiniworkorderDetails() {
            GFromwhere = "";
            GetSelectedIRItems();
            var Validate = CheckIRGenerationValidation();
            GetAllDropdown();
            if (Validate == true) {
                //debugger;
                //if ($.inArray(GBillingCurrencyID, ArrSiteId) > -1) {
                if (GBillingCurrencyID != SelectedSiteCurrencyID && (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == 'true')) {
                    //$("#SubmitIRModal").modal('show');
                    $("#DiffCurrencyConfirmation").modal('show');
                    $("#SpnDiffCurrencyConfirmation").text('IR of selected record  will be generate in Site Currency ' + SelectedSiteCurrency + ', Project Billing Currency is (' + GBillingCurrencySymbol + '). Do you want to continue?');
                } else {
                    $("#DivChecklist").show();
                    $("#DivSubmitIR").hide();
                    $("#Generate_IR_accordion").show();
                    $(".workorderdetailpanel").show();
                    $(".offcanvas-body").animate(
                        {
                            scrollTop: $(".workorderdetailpanel").offset().top - 60,
                        },
                        "slow"
                    );
                    $(".table").resize();

                }
            }
        }

        //Added By Dipali V On 29th Dec 2023 For Check Respective Configuration allow to create IR Item
        function AllowToIRCreate(flag)
        {
            if (flag == 1 && IsCreateIRItems == 0)
            {
                $("#DivChecklist").show();
                $("#DivSubmitIR").hide();
                $("#Generate_IR_accordion").show();
                $(".workorderdetailpanel").show();
                $(".offcanvas-body").animate(
                    {
                        scrollTop: $(".workorderdetailpanel").offset().top - 60,
                    },
                    "slow"
                );
                $(".table").resize();

            }
            if (flag == 1 && IsCreateIRItems == 1) {
                CreateIR();
            }
            else {
                $("#DiffCurrencyConfirmation").modal('hide');
            }
        }


        function AllowToIRCreateWithSiteValidation(flag) {
            if (flag == 1 && IsCreateIRItems == 0) {
                $("#DivChecklist").show();
                $("#DivSubmitIR").hide();
                $("#Generate_IR_accordion").show();
                $(".workorderdetailpanel").show();
                $(".offcanvas-body").animate(
                    {
                        scrollTop: $(".workorderdetailpanel").offset().top - 60,
                    },
                    "slow"
                );
                $(".table").resize();

            }
            if (flag == 1 && IsCreateIRItems == 1) {
                CreateIR();
            }
            else {
                $("#DiffSiteCurrencyConfirmation").modal('hide');
            }

        }
        //End of Added By Dipali V On 29th Dec 2023 For Check Respective Configuration allow to create IR Item
        function CheckIRGenerationRateValidation() {
            var Validate = "";

            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                TimesheetNo: encodeURI(ProjectTimesheetID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/CheckIRGenerationRateValidation", param, false);
            if (strResult != "") {
                Validate = strResult;
            }
            return Validate;
        }
        //For Validate All Configuration Related to IR
        var IsProjectOrBillingCurrencyCheck = 0;
        var BillingCurrencyID = 0;
        var BaseCurrencyID = 0;
        var LocalCurrencyID = 0;
        var InvoiceResponsiblePerson = 0;
        var IsValidateContractValue = 0;//added by dipali v on 3rd jan 2024 for check contract value
        var IRApprover = 0;
        function CheckIRGenerationValidation() {
            var Validate = true;
            var BillingCurrencyID = "";
            var Parameters = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/ValidateIRConfiguration", param, false);
            if (strResult != "")
            {
                for (var i = 0; i < strResult.length; i++) {
                    //debugger;
                    BillingCurrencyID = strResult[i].BillingCurrencyID
                    BaseCurrencyID = strResult[i].BaseCurrencyID
                    LocalCurrencyID = strResult[i].LocalCurrencyID
                    CompanyBaseCurrencyID = strResult[i].CompanyBaseCurrencyID
                    InvoiceResponsiblePerson = strResult[i].InvoiceResponsiblePerson
                    IRApprover = strResult[i].IRApprover
                    CORPORATE_BASE_CONVERSRIONRATE = strResult[i].CORPORATE_BASE_CONVERSRIONRATE
                    IRCOMPANY_BASE_CONVERSRIONRATE = strResult[i].IRCOMPANY_BASE_CONVERSRIONRATE
                    IsProjectOrBillingCurrencyCheck = strResult[i].IsProjectOrBillingCurrencyCheck
                    IsValidateContractValue = strResult[i].IsValidateContractValue
                }

            }
            //debugger;
            var RateVal = CheckIRGenerationRateValidation();
           
            if (IRApprover == 0 || IRApprover == null) {
                IRApprover = "";
            }

            if (InvoiceResponsiblePerson == 0 || InvoiceResponsiblePerson == null) {
                InvoiceResponsiblePerson = "";
            }
            
            if (BillingCurrencyID == 0 || BillingCurrencyID == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_BILLING")%>');
                Validate = false;
                return false
            }

            else if (BaseCurrencyID == 0 || BaseCurrencyID == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_BASECODE")%>');
                Validate = false;
                return false

            }
            else if (CompanyBaseCurrencyID == 0 || CompanyBaseCurrencyID == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_COMPANYBASECODE")%>');
                Validate = false;
                return false

            }
            else if (IRApprover == 0 || IRApprover == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_IR_APPROVER")%>');
                Validate = false;
                return false

            }
            else if (InvoiceResponsiblePerson == 0 || InvoiceResponsiblePerson == "") {
                alertify.error('<%= MyBase.GetResourceString("MSG_NO_RESP_PERSON")%>');
                Validate = false;
                return false

            }
            else if (CORPORATE_BASE_CONVERSRIONRATE == "NO_CORPORATE_BASE_CONVERSRIONRATE") {
                alertify.error('<%= MyBase.GetResourceString("CORPORATE_BASE_CONVERSRIONRATE")%>');
                Validate = false;
                return false

            }
            else if (IRCOMPANY_BASE_CONVERSRIONRATE == "NO_IRCOMPANY_BASE_CONVERSRIONRATE") {
                alertify.error('<%= MyBase.GetResourceString("IRCOMPANY_BASE_CONVERSRIONRATE")%>');
                Validate = false;
                return false

            }
            else if (ArrAdviseId.length == 0 || ArrAdviseId.length == "") {
                alertify.error('<%= MyBase.GetResourceString("C_IRItems")%>');
                Validate = false;
                return false
            }
            //Added By Dipali V on 28th Dec 2023 For Check Selected IR Items have Diff Currencies or not
            else if (CheckDiffSites(ArrSiteId) == false && IsAllValuesInSiteCurrency == true) {
                alertify.error('<%= MyBase.GetResourceString("C_SingleIRItemAllow")%>');
                Validate = false;
                return false
            }
             //End of Added By Dipali V on 28th Dec 2023 For Check Selected IR Items have Diff Currencies or not
           <%-- else if (RateVal[0].Column1 == "RATE_NOT_DEFINED" && RateVal != "") {
                alertify.error('<%= MyBase.GetResourceString("CResourceNotDefined")%>');
                Validate = false;
                return false
            }
            else if (RateVal[0].Column1 == "NO_IRCOMPANY_BASE_CONVERSRIONRATE" && RateVal != "") {
                alertify.error('<%= MyBase.GetResourceString("C_NoSiteCurrency")%>');
                Validate = false;
                return false
            }
            else if (RateVal[0].Column1 == "NO_CORPORATE_BASE_CONVERSRIONRATE" && RateVal != "") {
                alertify.error('<%= MyBase.GetResourceString("C_NoSiteToBase")%>');
                Validate = false;
                return false
            }--%>
           return Validate;
        }
      
        var IsValidate =true;
        var IsValidateWithSiteCurrency = false;
        //for validate While IR creation
        function ValidateIR() {
            IsCreateIRItems = 0;
            //alert(IsAllValuesInSiteCurrency);
            IsValidate = true;
            if ($("#cboType").val() == 0) {
                alertify.error('<%= MyBase.GetResourceString("C_TypeBlank")%>');
                $("#cboType").focus();
                IsValidate = false;
                return false
            }
             if ($("#cboCustomer").val() == 0) {
                alertify.error('<%= MyBase.GetResourceString("C_CustomerBlank")%>');
                $("#cboCustomer").focus();
                IsValidate = false;
                return false
            }

             if ($("#cboContactPerson").val() == 0) {
                alertify.error('<%= MyBase.GetResourceString("C_ContactPersonBlank")%>');
                $("#cboContactPerson").focus();
                IsValidate = false;
                return false
            }
             if ($("#txtinput_Email").val() != "") {
                if (ValidateEmailID($("#txtinput_Email").val()) == false) {
                    alert("<%=MyBase.GetResourceString("MSG_EMAIL_BLANK")%>")
                    $("#txtinput_Email").focus();
                    IsValidate = false;
                    return false

                }
            }

             if ($("#txtContract").val() == "") {
                alertify.error('<%= MyBase.GetResourceString("C_ContractBlank")%>');
                $("#txtContract").focus();
                 IsValidate = false;
                return false
            }

            if ($("#txtSalesPeriod").val().trim() == "") {
                alertify.error('<%= MyBase.GetResourceString("C_SalesPeriodBlank")%>');
                $("#txtSalesPeriod").focus();
                  IsValidate = false;
                  return false
              }
            
           
            if ($("#IRItemsHeader").val().trim() == "") {
                alertify.error('<%= MyBase.GetResourceString("C_IRItemsHeaderBlank")%>');
                $("#IRItemsHeader").focus();
                IsValidate = false;
                return false
            }
            if (ArrAdviseId.length == 0 || ArrAdviseId.length == "") {
                alertify.error('<%= MyBase.GetResourceString("C_IRItems")%>');
                IsValidate = false;
                return false
            }
            //Added By Dipali V on 28th Dec 2023 For Check Selected IR Items have Diff Currencies or not
            if (CheckDiffSites(ArrSiteId) == false && IsAllValuesInSiteCurrency == true) {
                alertify.error('<%= MyBase.GetResourceString("C_SingleIRItemAllow")%>');
                IsValidate = false;
                return false
            }
            ////Added By Dipali V On 3rd Jan 2024 For ValidateContractValues
           //debugger;
            var IsAlertContractValue = ValidateContractValue();
            if (IsAlertContractValue != "" && (IsValidateContractValue == true || IsValidateContractValue == 1))
            {
                alertify.error(IsAlertContractValue);
                IsValidate = false;
                return false
            }
           
            ////End of Added By Dipali V On 3rd Jan 2024 For ValidateContractValues

            //var ContractCurrenySymbol = $("#lblContractCurrenySymbol").text();
            //End Added By Dipali V on 28th Dec 2023 For Check Selected IR Items have Diff Currencies or not
            //For Project Currency
            if (IsProjectOrBillingCurrencyCheck == true || IsProjectOrBillingCurrencyCheck == 1) { // Project Currency;
                if (GSelectedCurrencyID != GCurrencyID) {
                    IsCreateIRItems = 0;
                   // IsValidateWithSiteCurrency = false;
                    alertify.error('<%= MyBase.GetResourceString("C_ContractCurrency")%>');
                    $("#txtContract").focus();
                    IsValidate = false;
                    return false
                }
                //Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
                else if ((GSelectedCurrencyID == GCurrencyID) && (GCurrencyID != parseInt($("#IRCurrency").val())) && (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == 'true'))//IRCurrency
                {
                    IsCreateIRItems = 1;
                    IsValidateWithSiteCurrency = true;
                    $("#DiffSiteCurrencyConfirmation").modal('show');
                    console.log(1)
                    $("#SpnSiteDiffCurrencyConfirmation").text('');
                    $("#SpnSiteDiffCurrencyConfirmation").text('Project Currency is (' + GCurrencySymbol + '), Contract Currency is (' + SelectedContractCurrencySym + '), IR of selected record  will be generate in Site Currency ' + SelectedSiteCurrency + '. Do you want to continue?');
                    IsValidate = false;
                    return false

                }
                 //End of Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
            }
            //For Billing Currency
            if (IsProjectOrBillingCurrencyCheck == false || IsProjectOrBillingCurrencyCheck == 0)
            { 
                if (GSelectedCurrencyID != GBillingCurrencyID)//IRCurrency
                {

                    IsCreateIRItems = 0;
                   // IsValidateWithSiteCurrency = false;
                    alertify.error('<%= MyBase.GetResourceString("C_BillingCurrency")%>');
                    $("#txtContract").focus();
                    IsValidate = false;
                    return false;
                }
                 //Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
                else if ((GSelectedCurrencyID == GBillingCurrencyID) && (GBillingCurrencyID != parseInt($("#IRCurrency").val())) && (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == 'true'))//IRCurrency
                {
                    IsCreateIRItems = 1;
                    IsValidateWithSiteCurrency = true;
                    $("#DiffSiteCurrencyConfirmation").modal('show');
                    $("#SpnSiteDiffCurrencyConfirmation").text('');
                    $("#SpnSiteDiffCurrencyConfirmation").text('Billing Currency is (' + GBillingCurrencySymbol + '), Contract Currency is (' + SelectedContractCurrencySym + '), IR of selected record  will be generate in Site Currency ' + SelectedSiteCurrency + '. Do you want to continue?');
                    IsValidate = false;
                    return false
                }
                 //End of Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
            }
            

            return IsValidate;

        }

        function CreateIR()
        {
            //var ProjectID = ProjectID;
            if ($("#chckInvoice_Request").prop('checked') == true) {
                var IsProforma = 0;
            } else {
                var IsProforma = 1;
            }
            var strAdvisedIDs = unique(ArrAdviseId);
            var RFITypeID = $("#cboType").val();
            var RFID = 0;
            //var ProjectID = 0;
            var CustomerID = $("#cboCustomer").val();
            var CustomerContactID = $("#cboContactPerson").val();
            var CustomerAddressID = $("#CboCustomerAddressDetails").val();
            //Added By Dipali V On 3rd Jan 2023 For Get Curreny
            // var BillingCurrencyID = GCurrencyID
            //var BillingCurrencyID = GBillingCurrencyID
            var BillingCurrencyID = $("#IRCurrency").val();
            //End of Added By Dipali V On 3rd Jan 2023 For Get Curreny
            var CreditDays = $("#input_Credit").val();
            var ConfirmEmailID = $("#txtinput_Email").val();
            var LOC = 0;
            var MilestoneID = 0;
            var ContractID = $("#TexthiddenContract").val();
            var RFIHeader = $("#IRItemsHeader").val().trim().replace(/'/g, "''");
            var SalesPeriodID = $("#TexthiddenSalesPeriod").val();
            var CreatorOrModifier = UserName
            var InvoiceDate = $("#txtInvoiceDate").val();
            //var InvoiceDate = $("#txtInvoiceDate").val();
            var SalesPersonIDs = $("#TexthiddenSalesPerson").val();
            if (SalesPersonIDs == "") {
                SalesPersonIDs = ",";
            } else {
                SalesPersonIDs = SalesPersonIDs;
            }
            //var SalesPersonIDs = $("#TexthiddenSalesPerson").val();
            //if (SalesPersonIDs != "") {
            //    SalesPersonIDs = SalesPersonIDs + "," + SalesPersonIDs;
            //} else {
            //    SalesPersonIDs = ",";
            //}

            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                RFID: encodeURI(RFID),
                IsProforma: encodeURI(IsProforma),
                RFITypeID: encodeURI(RFITypeID),
                CustomerID: encodeURI(CustomerID),
                CustomerContactID: encodeURI(CustomerContactID),
                CustomerAddressID: encodeURI(CustomerAddressID),
                BillingCurrencyID: encodeURI(BillingCurrencyID),
                CreditDays: encodeURI(CreditDays),
                ConfirmEmailID: encodeURI(ConfirmEmailID),
                LOC: encodeURI(LOC),
                MilestoneID: encodeURI(MilestoneID),
                ContractID: encodeURI(ContractID),
                RFIHeader: encodeURI(RFIHeader),
                SalesPeriodID: encodeURI(SalesPeriodID),
                CreatorOrModifier: encodeURI(CreatorOrModifier),
                InvoiceDate: encodeURI(InvoiceDate),
                TimeSheetNo: encodeURI(ProjectTimesheetID),
                strAdvisedIDs: encodeURI(strAdvisedIDs.toString()),
                SalesPersonIDs: encodeURI(SalesPersonIDs.toString())
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/CreateIRItem", param, false);
            if (strResult != "") {
                alertify.success('<%= MyBase.GetResourceString("C_SavedIRPIR")%>');
                GetProjectRateMethod();
                GetTimesheetReadyToAuthenticateFlag(ProjectTimesheetID);
                GetProjectDetails(ProjectTimesheetID, ProjectID, $("#TxtFromDate").val(), $("#TxtToDate").val());
                GetTimesheetBillingDetails(ProjectTimesheetID, InvoiceTimesheetID);
                ArrAdviseId = [];
                if (strResult != undefined) {
                    var m_intChecklistInstanceID = strResult.m_intChecklistInstanceID;
                    var m_intChecklistID = strResult.m_intChecklistID;
                    var m_RFID = strResult.RFID;
                }
                GetCheckListItemsDetails(m_intChecklistID, m_RFID);
                $("#SubmitIRModal").modal('show');

            }
        }

        ////Added By Dipali V On 3rd Jan 2024 For ValidateContractValues
        var IsAlertContractValue = "";
        function ValidateContractValue() {
            var ContractTypeID = $("#TexthiddenContract").val();
            var strAdvisedIDs = unique(ArrAdviseId);
            var Parameters = {
                ContractTypeID: encodeURI(ContractTypeID),
                strAdvisedIDs: encodeURI(strAdvisedIDs.toString())
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/ValidateContractValues", param, false);
            IsAlertContractValue = strResult;
            return IsAlertContractValue;
        }
        ////End of Added By Dipali V On 3rd Jan 2024 For ValidateContractValues
         //For Validation While Create IR
        
        $("#Create_IR").on("click", function () {
            //debugger;
            var Validate = ValidateIR();
            if (Validate == true) {
                IsCreateIRItems = 1;
                 //Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
                if ((GBillingCurrencyID != SelectedSiteCurrencyID) && (IsAllValuesInSiteCurrency == true || IsAllValuesInSiteCurrency == 'true') && IsValidateWithSiteCurrency == false)
                {
                    //$("#SubmitIRModal").modal('show');
                    $("#DiffCurrencyConfirmation").modal('show');
                    $("#SpnDiffCurrencyConfirmation").text('IR of selected record  will be generate in Site Currency ' + SelectedSiteCurrency + ' , Project Billing Currency is (' + GBillingCurrencySymbol + '). Do you want to continue?');
                }
                else
                {

                    //var ProjectID = ProjectID;
                    if ($("#chckInvoice_Request").prop('checked') == true) {
                        var IsProforma = 0;
                    } else {
                        var IsProforma = 1;
                    }
                    var strAdvisedIDs = unique(ArrAdviseId);
                    var RFITypeID = $("#cboType").val();
                    var RFID = 0;
                    //var ProjectID = 0;
                    var CustomerID = $("#cboCustomer").val();
                    var CustomerContactID = $("#cboContactPerson").val();
                    var CustomerAddressID = $("#CboCustomerAddressDetails").val();
                    //Added By Dipali V On 3rd Jan 2023 For Get Curreny
                    // var BillingCurrencyID = GCurrencyID
                    //var BillingCurrencyID = GBillingCurrencyID
                    var BillingCurrencyID = $("#IRCurrency").val();
                    //End of Added By Dipali V On 3rd Jan 2023 For Get Curreny
                    var CreditDays = $("#input_Credit").val();
                    var ConfirmEmailID = $("#txtinput_Email").val();
                    var LOC = 0;
                    var MilestoneID = 0;
                    var ContractID = $("#TexthiddenContract").val();
                    var RFIHeader = $("#IRItemsHeader").val().trim().replace(/'/g, "''");
                    var SalesPeriodID = $("#TexthiddenSalesPeriod").val();
                    var CreatorOrModifier = UserName
                    var InvoiceDate = $("#txtInvoiceDate").val();
                    //var InvoiceDate = $("#txtInvoiceDate").val();
                    var SalesPersonIDs = $("#TexthiddenSalesPerson").val();
                    if (SalesPersonIDs == "") {
                        SalesPersonIDs = ",";
                    } else {
                        SalesPersonIDs = SalesPersonIDs;
                    }
                    //var SalesPersonIDs = $("#TexthiddenSalesPerson").val();
                    //if (SalesPersonIDs != "") {
                    //    SalesPersonIDs = SalesPersonIDs + "," + SalesPersonIDs;
                    //} else {
                    //    SalesPersonIDs = ",";
                    //}

                    var Parameters = {
                        ProjectID: encodeURI(ProjectID),
                        RFID: encodeURI(RFID),
                        IsProforma: encodeURI(IsProforma),
                        RFITypeID: encodeURI(RFITypeID),
                        CustomerID: encodeURI(CustomerID),
                        CustomerContactID: encodeURI(CustomerContactID),
                        CustomerAddressID: encodeURI(CustomerAddressID),
                        BillingCurrencyID: encodeURI(BillingCurrencyID),
                        CreditDays: encodeURI(CreditDays),
                        ConfirmEmailID: encodeURI(ConfirmEmailID),
                        LOC: encodeURI(LOC),
                        MilestoneID: encodeURI(MilestoneID),
                        ContractID: encodeURI(ContractID),
                        RFIHeader: encodeURI(RFIHeader),
                        SalesPeriodID: encodeURI(SalesPeriodID),
                        CreatorOrModifier: encodeURI(CreatorOrModifier),
                        InvoiceDate: encodeURI(InvoiceDate),
                        TimeSheetNo: encodeURI(ProjectTimesheetID),
                        strAdvisedIDs: encodeURI(strAdvisedIDs.toString()),
                        SalesPersonIDs: encodeURI(SalesPersonIDs.toString())
                    }
                    var param = JSON.stringify(Parameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/CreateIRItem", param, false);
                    if (strResult != "") {
                        alertify.success('<%= MyBase.GetResourceString("C_SavedIRPIR")%>');
                        GetProjectRateMethod();
                        GetTimesheetReadyToAuthenticateFlag(ProjectTimesheetID);
                        GetProjectDetails(ProjectTimesheetID, ProjectID, $("#TxtFromDate").val(), $("#TxtToDate").val());
                        GetTimesheetBillingDetails(ProjectTimesheetID, InvoiceTimesheetID);
                        ArrAdviseId = [];
                        if (strResult != undefined) {
                            var m_intChecklistInstanceID = strResult.m_intChecklistInstanceID;
                            var m_intChecklistID = strResult.m_intChecklistID;
                            var m_RFID = strResult.RFID;
                        }
                        GetCheckListItemsDetails(m_intChecklistID, m_RFID);
                        $("#SubmitIRModal").modal('show');

                    }

                }
            }
          
        });

        //Download File
        function DownloadFile(OriginalFileName, SystemFileName) {
            if (SystemFileName == null) {
                SystemFileName = '';
            }
            var strTemp = '../../General/ViewAttachment.aspx?FromWhere=Contracts&FileName=' + OriginalFileName + '&SystemFileName=' + SystemFileName;
            window.open(strTemp);
        }
         //Get RFI Contract Document
        function GetRFIContractDocument(SelectedContractID) {
            //debugger;
            var strHTML = "";
            //var SelectedContractID = $("#TexthiddenContract").val();
            var ProjectID = ProjectID;
            var RequestParameters = {
                ContractID: SelectedContractID
            }
            $("#TblContractAttachment").dataTable().fnDestroy();
            $("#TbodyContractAttachment").html('');
            var param = JSON.stringify(RequestParameters);
            var Result = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetRFIContractDocument", param, false);
            if (Result.length > 0 && Result.length != null && Result != undefined) {
                for (var i = 0; i < Result.length; i++) {
                    // debugger;
                    var ContractAttachmentID = Result[i]["ContractAttachmentID"];
                    var ContractID = Result[i]["ContractID"];
                    var OriginalFileName = Result[i]["OriginalFileName"];
                    var FileSize = Result[i]["FileSize"];
                    var AttachedBy = Result[i]["AttachedBy"];
                    var AttachedOn = Result[i]["AttachedOn"];
                    var Description = Result[i]["Description"];
                    var SystemFileName = Result[i]["SystemFileName"];
                    //if (FileSize == "") {
                    //    FileSize = "-";
                    //} else {
                    //    FileSize = FileSize;
                    //}
                    strHTML += '<tr>'
                    strHTML += '<td> ' + (i + 1) + '</td>'
                    strHTML += '<td> <a href="javascript:;" class="textUndrln" onclick="DownloadFile(\'' + OriginalFileName + '\',\'' + SystemFileName + '\') ">' + OriginalFileName + '</a></td>'
                    //strHTML += '<td>' + FileSize + '</td>' // Commented By Dipali V On 22nd Nov 2023 For Hide column 
                    strHTML += '<td>' + AttachedBy + '</td>'
                    strHTML += '<td>' + AttachedOn + '</td>'
                    strHTML += '<td>' + Description + '</td>'
                    strHTML += '</tr>'
                }
            } else {
                strHTML += '<tr><td colspan="5">No data available in table</td></tr>'
            }
          
           // $('#TblContractAttachment').dataTable().fnDestroy();
            $("#TbodyContractAttachment").html(strHTML);
            $('#TblContractAttachment').dataTable({
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "destroy": true,
                "bFilter": false,
                /*  "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] }]*/
            });
            $(".table").resize();
            $("#TblContractAttachment").removeAttr("style");
        }

        //Added By DipaliV On 7th Nov 2023 For Get CheckList Items
        var arrRFIChecklistItemID = [];
        var arrRFIChecklistComments = [];
        var arrRFIChecklistResponse = [];
        var GChecklistID = "";
        var GRFID = "";
        function GetCheckListItemsDetails(ChecklistID, RFID) {
            GChecklistID = ChecklistID;
            GRFID = RFID;
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                RFID: encodeURI(RFID),
                ChecklistID: encodeURI(ChecklistID)

            }
            var param = JSON.stringify(Parameters);
            var checklistIR = "";
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetCheckListItemsDetails", param, false);
            if (strResult != "") {
                for (var i = 0; i < strResult.length; i++) {
                    var Comments = strResult[i].Comments
                    if (Comments == null) {
                        Comments = "";
                    } else {
                        Comments = strResult[i].Comments;
                    }
                    arrRFIChecklistItemID.push(strResult[i].RFIChecklistItemID);
                    checklistIR += '<tr>';
                    checklistIR += '<td>' + strResult[i].RFIChecklistItemID + '</td>';
                    checklistIR += '<td>' + strResult[i].RFIChecklistItem + '</td>';
                    checklistIR += '<td>';
                    checklistIR += '<div class="custom_chckbox">';
                    checklistIR += '<input type="checkbox" id="submitYes_' + strResult[i].RFIChecklistItemID + '" class="chcktbl">';
                    checklistIR += '<label for="submitYes_' + strResult[i].RFIChecklistItemID + '"></label>';
                    checklistIR += '</div>';
                    checklistIR += '</td>';
                    checklistIR += '<td><textarea class="form-control submitComments" id="checklistDes_' + strResult[i].RFIChecklistItemID + '">' + Comments + ' </textarea></td>';
                    checklistIR += '</tr>';
                }

            }
            $("#TbodySubmiteIR").html(checklistIR);
        }

        //For Save Checklist Items
        function SaveChecklistItems() {
           // debugger;
            if (ValidCheckList() == true) {
                for (var i = 0; i < arrRFIChecklistItemID.length; i++) {
                    if ($("#submitYes_" + arrRFIChecklistItemID[i]).prop('checked') == true) {
                       var ChecklistResponse = 1;
                    } else {
                        var ChecklistResponse = 0;
                    }
                    arrRFIChecklistComments.push($("#checklistDes_" + arrRFIChecklistItemID[i]).val().trim().replace(/'/g, "''"));
                    arrRFIChecklistResponse.push(ChecklistResponse);
                }
                var Parameters = {
                    ProjectID: encodeURI(ProjectID),
                    RFID: encodeURI(GRFID),
                    ChecklistID: encodeURI(GChecklistID),
                    ChecklistItemID: encodeURI(arrRFIChecklistItemID.toString()),
                    RFIChecklistComments: encodeURI(arrRFIChecklistComments.toString()),
                    RFIChecklistResponse: encodeURI(arrRFIChecklistResponse.toString()),
                    CreatorOrModifier: encodeURI(UserName)
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/SaveChecklistItems", param, false);
                if (strResult != "") {
                    alertify.success('<%= MyBase.GetResourceString("C_SavedChecklistItems")%>');
                    arrRFIChecklistItemID = [];
                    arrRFIChecklistComments = [];
                    arrRFIChecklistResponse = [];
                    $("#DivChecklist").hide();
                    $("#DivSubmitIR").show();
                    $("#lblSubmit").text('');
                    $("#lblSubmit").text('Submit IR');
                }
            }
        }

        //For Validate Check list Comments
        function ValidCheckList() {
            var IsValid = true;
            if (arrRFIChecklistItemID != "") {
                for (var i = 0; i < arrRFIChecklistItemID.length; i++)
                {
                    if ($("#submitYes_" + arrRFIChecklistItemID[i]).prop('checked') == false) {
                        if ($("#checklistDes_" + arrRFIChecklistItemID[i]).val().trim() == "") {
                            alertify.error('<%= MyBase.GetResourceString("C_CheckListCommentblank")%>');
                            $("#checklistDes_" + arrRFIChecklistItemID[i]).focus();
                            IsValid = false
                            return false;
                        }
                    } else {
                        IsValid = true
                        //return false;
                    }
                }
            }
            return IsValid;

        }


        //For Validate EmailID
        function ValidateEmailID(strEmailList) {
            var strEmailArray;
            var intCtr

            if (strEmailList == "") {
                return false;
            }

            objRegularExp = new RegExp("[\\,,\\ ,\\;]")
            strEmailArray = strEmailList.split(objRegularExp);

            if (strEmailArray.length == 0)
                return false;

            for (intCtr = 0; intCtr < strEmailArray.length; intCtr++) {
                if (isEmail(strEmailArray[intCtr]) == false) {
                    //alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
                    return false;
                }
            }
            return true;
        }

        //For Validate EmailID
        function isEmail(str) {
            var supported = 0;
            if (window.RegExp) {
                var tempStr = "a";
                var tempReg = new RegExp(tempStr);
                if (tempReg.test(tempStr)) supported = 1;
            }

            if (!supported)
                return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);

            var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
            var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");

            return (!r1.test(str) && r2.test(str));

        }
        //Added By Dipali V on 2nd Nov 2023
        var ContactPersonEmailID = "";
        var GetAllContractType = "";
        function GetAllDropdown() {
            $("#input_Credit").val(CreditPeriod);
            //debugger;
            if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                $("#IRProjectCurrency").text(GBillingCurrencyCode);
                $("#IRProjectCurrencyCode").text( "(" + GBillingCurrencySymbol + ")");
                //$("#linkMoreDetails").text("");
                $("#IRCurrency").val(GBillingCurrencyID);
            } else {
                $("#IRProjectCurrency").text(SelectedSiteCurrencyCode); 
                $("#IRProjectCurrencyCode").text(SelectedSiteCurrency);
                $("#IRCurrency").val(GSelectedSiteCurrencyID);
                //$("#linkMoreDetails").text("Billing Currency consider Site Currency.More details");
            }
            $("#chckInvoice_Request").prop("checked",true);
            
            
            $("#txtIRConversionDate").val($("#txtInvoiceDate").val());
            
            if (ProjectOrProduct == "") {
                var ProjectOrProduct = "Project";
            } else {
                var ProjectOrProduct = GProjectOrProduct;
            }
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                CustomerID: encodeURI(GCustomerID),
                ProjectOrProduct: encodeURI(ProjectOrProduct)

            }
            var param = JSON.stringify(Parameters);
            var Type = "", Customer = "", ContactPerson = ""; ContactPersonEmailID = "";
            var GetDropdown = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetAllDropdown", param, false);
            //debugger;
            var Type = GetDropdown.Table1;
            var Customer  = GetDropdown.Table3;
            var ContactPerson = GetDropdown.Table2;
             ContactPersonEmailID = GetDropdown.Table4;
            var GetAddress = GetDropdown.Table5;
             GetAllContractType = GetDropdown.Table6;
            if (Type != "") {
                for (var i = 0; i < Type.length; i++) {
                    var objCbo1 = document.getElementById("cboType");
                    $("#cboType option").remove();
                    $("#cboType").append('<option value="0">Select Type</option>');
                    for (var i = 0; i < Type.length; i++) {
                        var ObjStatus = Type[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.RFITypeName;
                        objOption.value = ObjStatus.RFITypeID;
                    }
                }
                $(".selectpicker").selectpicker('refresh');
            }

            if (Customer != "") {
                for (var i = 0; i < Customer.length; i++) {
                    var objCbo1 = document.getElementById("cboCustomer");
                    $("#cboCustomer option").remove();
                    $("#cboCustomer").append('<option value="0">Select Customer</option>');
                    for (var i = 0; i < Customer.length; i++) {
                        var ObjStatus = Customer[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.CustomerName;
                        objOption.value = ObjStatus.Customer;
                    }
                }
                
            }
            $("#cboCustomer").val(GCustomerID);
            if (GProjectOrProduct == "Product") {
                $("#cboCustomer").prop('disabled', false);
            } else {
                $("#cboCustomer").prop('disabled', true);
            }
            $(".selectpicker").selectpicker('refresh');

            if (ContactPerson != "") {
                for (var i = 0; i < ContactPerson.length; i++) {
                    var objCbo1 = document.getElementById("cboContactPerson");
                    $("#cboContactPerson option").remove();
                    $("#cboContactPerson").append('<option value="0">Select Contact Person</option>');
                    for (var i = 0; i < ContactPerson.length; i++) {
                        var ObjStatus = ContactPerson[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.ContactPerson;
                        objOption.value = ObjStatus.CustomerContactID;
                    }
                }
               
            }
            $(".selectpicker").selectpicker('refresh');

            if (GetAddress != "") {
                for (var i = 0; i < GetAddress.length; i++) {
                    var objCbo1 = document.getElementById("CboCustomerAddressDetails");
                    $("#CboCustomerAddressDetails option").remove();
                    //$("#CboCustomerAddressDetails").append('<option value="0">Select Customer Address</option>');
                    for (var i = 0; i < GetAddress.length; i++) {
                        var ObjStatus = GetAddress[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.AddressCode;
                        objOption.value = ObjStatus.CustomerAddressID;
                    }
                }
                $(".selectpicker").selectpicker('refresh');
            }

        }

        //Added By Dipali V on 3rd Nov 2023 For Get Customer Address Details
        var CustomerAddrId = 0;
        function GetCustomerAddress() {
            //debugger;
            if ($("#TexthiddenCustomerAddressID").val() != "") {
                CustomerAddrId = $("#TexthiddenCustomerAddressID").val();
            } else {
                CustomerAddrId = $("#CboCustomerAddressDetails").val();
            }
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                CustomerID: encodeURI(GCustomerID),
                CustomerAddrId: encodeURI(CustomerAddrId)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetCustomerAddress", param, false);
            if (strResult != "") {
                for (var i = 0; i < strResult.length; i++) {
                    $("#CustomerNameDetails").text(strResult[i].AddressCode);
                    $("#CustomerAddressDetails").text(strResult[i].Address);
                    $("#CustomerCountryDetails").text(strResult[i].Country);
                    $("#CustomerStateDetails").text(strResult[i].State);
                    $("#CustomerCityDetails").text(strResult[i].City);
                    $("#CustomerTelephoneNoDetails").text(strResult[i].TelephoneNumber);
                    $("#CustomerFaxNoDetails").text(strResult[i].FaxNumber);
                    $("#CustomerZIPCodeDetails").text(strResult[i].PinCode);

                }
            }
            $(".selectpicker").selectpicker('refresh');
        }
        //Added By Dipali V on 3rd Nov 2023 For Onchange of Customer get Details
        $("#CboCustomerAddressDetails").on('change', function () {
            CustomerAddrId = $("#CboCustomerAddressDetails").val();
            GetCustomerAddress();
        });

        //Added By Dipali V on 3rd Nov 2023 For Save Customer Address
        function SaveCustomerAddressDetails() {
            if ($("#CboCustomerAddressDetails").val() != "0")
            {
                CustomerAddrId = $("#CboCustomerAddressDetails").val();
                $("#TexthiddenCustomerAddressID").val(CustomerAddrId);
                $("#Select_Customer_Address").modal('hide');
            } else {
                alertify.error('<%= MyBase.GetResourceString("C_CustomerAddressDetailsBlank")%>');
                $("#CboCustomerAddressDetails").focus();
                return false
            }

        }

        //Added By Dipali V on 3rd Nov 2023 Get Contact Person Email Id on change
        //$("#cboContactPerson").on('change', function () {
        //    $("#txtinput_Email").text(ContactPersonEmailID);
        //});

         //////////////////////////////////////////// Email ID Of Customer
        function SelectContactPerson() {
            //if ($("#cboContactPerson").val() != 0) {
            //    $("#txtinput_Email").val(ContactPersonEmailID[0].EmailID);
            //} else {
            //    $("#txtinput_Email").val("");
            //}
            if ($("#cboContactPerson").val() != 0) {
                var CustomerContactID = $("#cboContactPerson").val()
               // var GCustomerID = GCustomerID
                var Parameters = {
                    CustomerContactID: encodeURI(CustomerContactID),
                    CustomerID: encodeURI(GCustomerID)
                }
               
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetContactPersonEmail", param, false);
                //debugger;
                if (strResult != "")
                {
                    $("#txtinput_Email").val(strResult);
                }
            } else {
                $("#txtinput_Email").val("");
            }
        }

        //////////////////////////////////////////// Sale Period
        // //Added By Dipali V on 3rd Nov 2023 Get Sales Period
        var GFromwhere = "";
        function GetSalesPeriodDetails() {
          //  debugger;
            if (GFromwhere == '') {
                $("#SalesPeriodModal").modal('show');
                $("#salesPeriodStartDate").val("");
                $("#salesPeriodEndDate").val("");
                $("#salesPeriodYear").val("");
                $("#salesPeriodMonth").val("");
            }
            var IsOpen = $("#salesPeriodIsOpen").val();
            var salesPeriodStartDate = $("#salesPeriodStartDate").val();
            var salesPeriodYear = $("#salesPeriodYear").val();
            var salesPeriodEndDate = $("#salesPeriodEndDate").val();
            var salesPeriodMonth = $("#salesPeriodMonth").val();
            if (IsOpen == "Yes") {
                IsOpen = 1;
            } else {
                IsOpen = 0;
            }

           
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                IsOpen: encodeURI(IsOpen),
                salesPeriodStartDate: encodeURI(salesPeriodStartDate),
                salesPeriodYear: encodeURI(salesPeriodYear),
                salesPeriodEndDate: encodeURI(salesPeriodEndDate),
                salesPeriodMonth: encodeURI(salesPeriodMonth)
            }
            var StrHTML = "";
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetSalesPeriodDetails", param, false);
            if (strResult != "") {
                //debugger;
                $("#TbodySales").html('');
                for (var i = 0; i < strResult.length; i++) {
                    var IsOpen;
                    if (strResult[i].IsOpen == true) {
                        IsOpen = "Yes";
                    } else {
                        IsOpen = "No";
                    }
                    StrHTML += '<tr>';
                    StrHTML += '<td><a href="javascript:;">' + strResult[i].SalesPeriodMonth + '</a></td >';
                    StrHTML += '<td>' + strResult[i].SalesPeriodYear + '</td>';
                    StrHTML += '<td>' + strResult[i].SalesPeriodStartDate + '</td>';
                    StrHTML += '<td>' + strResult[i].SalesPeriodEndDate + '</td>';
                    StrHTML += ' <td>' + IsOpen + '</td>';
                    StrHTML += '<td>';
                    StrHTML += '<div class="custom_chckbox">';
                    StrHTML += '<input id="salesperiod_' + strResult[i].SalesPeriodID + '" class="chckSalesPeriod" type="checkbox" data-bs-dismiss="modal" onchange="selectSalesperiod(' + strResult[i].SalesPeriodID + ',' + strResult[i].SalesPeriodMonth + ',' + strResult[i].SalesPeriodYear + ')">';
                    StrHTML += '<label for="salesperiod_' + strResult[i].SalesPeriodID + '"></label>';
                    StrHTML += '<input type="hidden" id="salesperiodMonths_' + strResult[i].SalesPeriodID + '" value="' + strResult[i].SalesPeriodMonth + '" />';
                    StrHTML += '</div>';
                    StrHTML += '</td>';
                    StrHTML += '</tr>'
                }

            } else {

                StrHTML = '<tr><td colspan="5">No data available in table</td></tr>';
            }
            $("#TbodySales").html(StrHTML);
            $(".chckSalesPeriod").prop('checked', false);
            var SalesPeriodID = $("#TexthiddenSalesPeriod").val();
            $("#salesperiod_" + SalesPeriodID).prop('checked', true);

        }
        //Added By Dipali V on 3rd Nov 2023 Get Selected Sales Period
        function selectSalesperiod(SalesPeriodID, SalesPeriodMonth, SalesPeriodYear) {
         
            $("#TexthiddenSalesPeriod").val(SalesPeriodID);

            //For Get Correct Month
            SalesPeriodMonth = $("#salesperiodMonths_" + SalesPeriodID).val();
          
            //$("#txtSalesPeriod").val(SalesPeriodMonth + '/' + SalesPeriodYear );
            $("#txtSalesPeriod").val(SalesPeriodYear + '/' + SalesPeriodMonth );
        }

         //Added By Dipali V on 3rd Nov 2023 Filters on Sales Period
        var FromWhere = "";
        function showSP_FilterBtn(FromWhere) {
           // debugger;
            GFromwhere = FromWhere
            GetSalesPeriodDetails();
        }

        //////////////////////////////////////////// Sale Person

         //Added By Dipali V on 3rd Nov 2023 get sales_person Filter
        var FromWhere = "";
        function showSPerson_FilterBtn(FromWhere) {
            // debugger;
            GFromwhere = FromWhere
            Getsales_personDetails();
        }

        
      
        //Added By Dipali V on 3rd Nov 2023 get sales_person Details
        function Getsales_personDetails() {
            var SalesPersonName = $("#salesPersonInput").val();
            var SaleCommision = $("#salesComissionInput").val();
            if (GFromwhere == '') {
                $("#sales_person_modal").modal('show');
            }
            
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                SalesPersonName: encodeURI(SalesPersonName),
                SaleCommision: encodeURI(SaleCommision)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetSalesPersonDetails", param, false);
            var StrHTML = "";
            if (strResult != "") {
                //debugger;
                $("#TbodySalesCommission").html('');
                for (var i = 0; i < strResult.length; i++) {

                    StrHTML += ' <tr>';
                    StrHTML += '<td><a href="javascript:;">' + strResult[i].employeename +'</a></td>';
                    StrHTML += '<td>' + strResult[i].SalesCommissionPercentage +'%</td>';
                    StrHTML += '<td>';
                    StrHTML += '<div class="custom_chckbox">';
                    StrHTML += '<input type="checkbox" id="salesperson_' + strResult[i].SalesPersonID + '" class="SalesPersonchck" name="SalesPerson" data="' + strResult[i].employeename + '" value="' + strResult[i].SalesPersonID + '" />';
                    StrHTML += '<label for="salesperson_' + strResult[i].SalesPersonID +'"></label>';
                    StrHTML += '</div>';
                    StrHTML += '<input type="hidden" id="Selectedsalesperson' + strResult[i].SalesPersonID + '" value="' + strResult[i].employeename + '" />';

                    StrHTML += '</td>';
                    StrHTML += '</tr>';
                   
                }

            } else {

                StrHTML = '<tr><td colspan="2">No data available in table</td></tr>';
            }
            $("#TbodySalesCommission").html(StrHTML);
            $(".SalesPersonchck").prop('checked', false);
            var SalesPersonID = $("#TexthiddenSalesPerson").val();
            var arrSalesPerson = SalesPersonID.split(",");
            for (var i = 0; i < arrSalesPerson.length; i++) {
                $("#salesperson_" + arrSalesPerson[i]).prop('checked', true);

            }
        }

        //Added By Dipali V on 3rd Nov 2023 Get Selected Sales Period
        //var strSalesPersonID = "";
        //var strSalesPersonName = "";
        //function selectSalesPerson(SalesPersonID) {

        //    //debugger;
        //    //if (strSalesPersonID != "") {
        //    //    strSalesPersonID += "," + SalesPersonID;

        //    //} else {
        //    //    strSalesPersonID = SalesPersonID;
        //    //}

        //    //SalesPersonName = $("#Selectedsalesperson" + SalesPersonID).val()
        //    ////$("#txtSalesPerson").val(SalesPersonName);
           
        //}

        
        function savesales()
        {
            var StrArrSalesName = [];
            var SalesPerson = $('input[name="SalesPerson"]:checked').map(function ()
            {
                return this.value;
            }).get().join(",");

            var arrSalesPerson = SalesPerson.split(",");
            if (SalesPerson != "") {
                for (var i = 0; i < arrSalesPerson.length; i++) {
                    var SalesPersonName = $("#Selectedsalesperson" + arrSalesPerson[i]).val();
                    StrArrSalesName.push(SalesPersonName);
                   
                }
            }
            
            $("#txtSalesPerson").val(StrArrSalesName);
            $("#TexthiddenSalesPerson").val(SalesPerson);
            $("#sales_person_modal").modal('hide');
           
           
        }

        //////////////////////////////////////////// Contract

        //For Get All Contract
        function GetAllContractTypeofProject() {

            if (GetAllContractType != "") {
                for (var i = 0; i < GetAllContractType.length; i++) {
                    var objCbo1 = document.getElementById("CboContractType");
                    $("#CboContractType option").remove();
                    //$("#CboContractType").append('<option value="0">Select Contract Type</option>');
                    for (var i = 0; i < GetAllContractType.length; i++) {
                        var ObjStatus = GetAllContractType[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.text = ObjStatus.contracttypename ;
                        objOption.value = ObjStatus.Contracttypeid;
                    }
                }
                
            }
            $(".selectpicker").selectpicker('refresh');
        }

        // For Filter Contract Type
        var FromWhere = "";
        function SelectContractType(FromWhere) {
            GFromwhere = FromWhere
            GetContract();
           
        }

        //Added By Dipali V on 3rd Nov 2023 get Contract
        var ContractDetails = "";
        function GetContract() {
            //debugger;
            if (GFromwhere == "")
            {
                $("#CboContractType").val("0");
                GetAllContractTypeofProject();
                $("#Contract_Details_modal").modal('show');
            }
            var CustomerContractTypeID = $("#CboContractType").val();
            //$("#TexthiddenContract").val(ContractID);
             //Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes
            var BillingCurrencyID = GBillingCurrencyID;
            var IRConversionDate = $("#txtIRConversionDate").val();
             //End of Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes
            var Parameters = {
                CustomerID: encodeURI(GCustomerID),
                ContractTypeID: encodeURI(CustomerContractTypeID),
                 //Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes
                BillingCurrencyID: encodeURI(BillingCurrencyID),
                IRConversionDate: encodeURI(IRConversionDate)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetContract", param, false);
            //ContractDetails = strResult;
            var StrHTML = "";
            var CustomerID = "";
            var GSelectedCurrencyID = "";
            if (strResult != "") {
                //debugger;
                $("#tbodyContract").html('');
                for (var i = 0; i < strResult.length; i++) {
                    //GSelectedCurrencyID = strResult[i].CurrencyID
                    if (CustomerID == "") {
                        StrHTML += '<tr class="clsTRSectionHeader">';
                        StrHTML += '<td colspan="11" class="footable-last-column footable-first-column text-start">';
                        StrHTML += '<span class="footable-toggle"></span>' + strResult[i].CustomerName;
                        StrHTML += '</td>';
                        StrHTML += '</tr>';
                        StrHTML += '<tr class="clsTROdd">';
                        StrHTML += ' <td class="footable-first-column">';
                        StrHTML += '<span class="footable-toggle"></span>';
                        StrHTML += ' </td>';
                        StrHTML += '<td title="' + strResult[i].ContractSummary + '">';
                        StrHTML += '<a href="JavaScript:;">' + strResult[i].ContractSummary + '</a>';
                        StrHTML += ' </td>';
                        StrHTML += '<td>' + strResult[i].ContractTypeName + '</td>';
                        StrHTML += '<td>' + strResult[i].ContractStartDate + '</td>';
                        StrHTML += '<td>' + strResult[i].ContractSummaryDate + '</td>';
                        StrHTML += '<td>' + strResult[i].ContractEndDate + '</td>';
                        //Commented & Added By Dipali V On 27th Dec 2023 For showing contract details
                        StrHTML += '<td>' + strResult[i].PONumber + '</td>';
                        StrHTML += '<td>' + strResult[i].POValue + '</td>';
                        StrHTML += '<td class="footable-last-column">' + strResult[i].CurrencyCode + '</td>';
                        //End of Commented & Added By Dipali V On 27th Dec 2023 For showing contract details
                        StrHTML += '<td>';
                        StrHTML += '<div class="custom_chckbox">';
                        StrHTML += '<input type="hidden" id="Contract' + strResult[i].ContractID + '" value="' + strResult[i].ContractSummary + '" />';
                         //Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
                        StrHTML += '<input type="hidden" id="ContractCurrency' + strResult[i].ContractID + '" value="' + strResult[i].CurrenySymbol + '" />';
                         //End of Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
                        StrHTML += '<input id="ContractCheck_' + strResult[i].ContractID + '" class="chcktbl" type="checkbox" data-bs-dismiss="modal" value="' + strResult[i].ContractID + '" onclick="selectContract(' + strResult[i].ContractID + ',' + strResult[i].CurrencyID + ')">';
                        StrHTML += '<label for="ContractCheck_' + strResult[i].ContractID + '"></label>';
                        StrHTML += '</div>';
                        StrHTML += '</td>';
                        StrHTML += '</tr>';
                    } else if (CustomerID == strResult[i].CustomerID) {
                        StrHTML += ' <tr class="clsTROdd">';
                        StrHTML += ' <td class="footable-first-column">';
                        StrHTML += '<span class="footable-toggle"></span>';
                        StrHTML += ' </td>';
                        StrHTML += '<td title="' + strResult[i].ContractSummary + '">';
                        StrHTML += '<a href="JavaScript:;">' + strResult[i].ContractSummary + '</a>';
                        StrHTML += ' </td>';
                        StrHTML += '<td>' + strResult[i].ContractTypeName + '</td>';
                        StrHTML += ' <td>' + strResult[i].ContractStartDate + '</td>';
                        StrHTML += '<td>' + strResult[i].ContractSummaryDate + '</td>';
                        StrHTML += ' <td>' + strResult[i].ContractEndDate + '</td>';
                        //Commented & Added By Dipali V On 27th Dec 2023 For showing contract details
                        StrHTML += '<td>' + strResult[i].PONumber + '</td>';
                        StrHTML += '<td>' + strResult[i].POValue + '</td>';
                        StrHTML += '<td class="footable-last-column">' + strResult[i].CurrencyCode + '</td>';
                        //End of Commented & Added By Dipali V On 27th Dec 2023 For showing contract details
                        StrHTML += ' <td>';
                        StrHTML += '<div class="custom_chckbox">';
                        StrHTML += '<input type="hidden" id="Contract' + strResult[i].ContractID + '" value="' + strResult[i].ContractSummary + '" />';
                         //Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
                        StrHTML += '<input type="hidden" id="ContractCurrency' + strResult[i].ContractID + '" value="' + strResult[i].CurrenySymbol + '" />';
                         //End of Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
                        StrHTML += '<input id="ContractCheck_' + strResult[i].ContractID + '" class="Contractchcktbl" type="checkbox" data-bs-dismiss="modal" value="' + strResult[i].ContractID + '" onclick="selectContract(' + strResult[i].ContractID + ',' + strResult[i].CurrencyID + ')">';
                        StrHTML += ' <label for="ContractCheck_' + strResult[i].ContractID + '"></label>';
                        StrHTML += ' </div>';
                        StrHTML += '</td>';
                        StrHTML += '</tr>';

                    }
                    CustomerID = strResult[i].CustomerID;
                    
                }
            } else {

                StrHTML = '<tr><td colspan="9">No data available in table</td></tr>';
            }
            $("#tbodyContract").html(StrHTML);
            $(".Contractchcktbl").prop("checked", false);
            var ContractID =  $("#TexthiddenContract").val();
            $("#ContractCheck_" + ContractID).prop("checked", true);
            
            
            

        }
        //Added By Dipali V on 3rd Jan 2024 get remaining PO values w.r.t.selected contract
        var SelectedContractCurrencySym = "";
        function GetContractValidationDetails() {
            SelectedContractCurrencySym = "";
            var SelectedContractID = $("#TexthiddenContract").val();
             //Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
            SelectedContractCurrencySym = $("#ContractCurrency" + SelectedContractID).val();
             //End of Added By Dipali V On 10th Jan 2023 For Currency Conversion Changes
             //Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes
            var BillingCurrencyID = GBillingCurrencyID;
            var IRConversionDate = $("#txtIRConversionDate").val();
             //End of Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes
            var Parameters = {
                CustomerID: encodeURI(GCustomerID),
                ContractTypeID: encodeURI(SelectedContractID),
                 //Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes
                BillingCurrencyID: BillingCurrencyID,
                IRConversionDate: IRConversionDate
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetContract", param, false);
            ContractDetails = strResult;

        }
         //End of Added By Dipali V on 3rd Jan 2024 get remaining PO values w.r.t.selected contract
        //Get Contract
        function selectContract(ContractID, CurrencyID) {
            GSelectedCurrencyID = CurrencyID;
            $("#TexthiddenContract").val(ContractID);
            var ContractName = $("#Contract" + ContractID).val()
            $("#txtContract").val(ContractName);
            //debugger;
            GetContractValidationDetails();
           
        }

        //Get Contract Details
        function GetContractDetails() {
            //debugger;
            if ($("#txtContract").val().trim() == "") {
                alertify.error('<%= MyBase.GetResourceString("C_ContractSelectionalert")%>');
                $("#txtContract").focus();
                return false;
            } else {
                $("#ShowDetailsModal").modal('show');
                if (ContractDetails != "") {
                    for (var i = 0; i < ContractDetails.length; i++) {
                        var SelectedContractID = $("#TexthiddenContract").val();
                        if (SelectedContractID == ContractDetails[i].ContractID) {
                            $("#lblContractSummary").text(ContractDetails[i].ContractSummary);
                            $("#lblCustomerContract").text(ContractDetails[i].CustomerContract);
                            $("#lblCommencementDate").text(ContractDetails[i].ContractStartDate);
                            $("#lblContractType").text(ContractDetails[i].ContractTypeName);
                            $("#lblContractSigningDate").text(ContractDetails[i].ContractSummaryDate);
                            $("#lblContractExpiry").text(ContractDetails[i].ContractEndDate);
                            $("#lblCustomerContract").text(ContractDetails[i].CustomerName);
                            $("#lblContractDetails").text(ContractDetails[i].ContractSummary);
                            //Commented & Added By Dipali V On 27th Dec 2023 For showing contract details
                            //$("#lblPOSOWNumber").text("NA");
                            //$("#lblPOSOWValue").text("NA");
                            $("#lblPOSOWNumber").text(ContractDetails[i].PONumber);
                            $("#lblPOSOWValue").text(ContractDetails[i].POValue);
                            $("#lblContractCurrency").text(ContractDetails[i].CurrencyCode);
                            //$("#TexthiddenContractCurrencySymbol").text(ContractDetails[i].CurrenySymbol);
                            $("#lblContractCRMRef").text(ContractDetails[i].CRMNO);
                            $("#lblContractRemainingPOvalue").text(ContractDetails[i].RemainingPOWVal);
                            if (ContractDetails[i].RemainingPOWVal >= 0) {
                                $("#lblContractRemainingPOvalue").css('color', 'green');
                            } else {
                                $("#lblContractRemainingPOvalue").css('color', 'red');
                            }
                            //End of Commented & Added By Dipali V On 27th Dec 2023 For showing contract details
                        }
                    }
                }
                GetRFIContractDocument(SelectedContractID);
            }

        }
        //Added By Dipali V On 28th Dec 2023 For Check Array Contain Same value of different
        function CheckDiffSites(arr) {
            var x = arr[0];
            return arr.every(function (item) {
                return item === x;
            });
        }
        //var GArrAdviseId = [];
        var ArrAdviseId = [];
        var ArrSiteId = [];
        var SelectedSiteCurrency = "";
        var SelectedSiteCurrencyID = "";
        var SelectedSiteCurrencyCode = "";
        function GetSelectedIRItems()
        {
            ArrAdviseId = [];
            ArrSiteId = [];
            SelectedSiteCurrency = "";
            SelectedSiteCurrencyID = "";
            SelectedSiteCurrencyCode = "";
            //debugger;
            $("#TbodySelectedItems").html();
            var BillingchckHeadIRItems = $('input[name="BillingchckHead"]:checked').map(function ()
            {
                return this.value;
            }).get().join(",");
            var StrHTML = "";
            if (BillingchckHeadIRItems != "") {
                var arrBillingchckHeadIRItems = BillingchckHeadIRItems.split(",");
                for (var i = 0; i < arrBillingchckHeadIRItems.length; i++) {
                    // debugger;

                    var Result = arrBillingchckHeadIRItems[i].split("_");
                    var AdviseId = Result[0];
                    var TimesheetID = Result[1];
                    var ProjectRoleId = Result[2];
                    var EmployeeId = Result[3];
                    var SiteId = Result[4];
                    ArrAdviseId.push(AdviseId);
                    ArrSiteId.push(SiteId);
                    var FinalAmount = $("#txtFinalAmount_" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").text();
                    var EditAmount = $("#txtEditAmount_" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").val();
                    var EmpName = $("#EmpName_" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").val();
                    var EmpNameImg = $("#ImgEmpName_" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").val();
                    //Added By Dipali V On 29th Dec 2023 For Get Selected Site Currency
                    SelectedSiteCurrency = $("#FinalAmountCurrency_" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").text();
                    SelectedSiteCurrencyID = $("#SiteCurrency" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").val();
                    SelectedSiteCurrencyCode = $("#SiteCurrencyCode" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").val();
                      //End of Added By Dipali V On 29th Dec 2023 For Get Selected Site Currency
                    StrHTML += '<tr id="TRIRItems_' + AdviseId + '_' + TimesheetID + '_' + ProjectRoleId + '_' + EmployeeId + '">';
                    StrHTML += '<td>';
                   // StrHTML += '<i class="fas fa-user-circle"></i>';
                   
                    if (EmpNameImg == "") {
                        StrHTML += '<i class="fas fa-user-circle"></i> ';
                    } else {
                          <%-- /*Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/--%>
                        //StrHTML += '<img src=' + EmpNameImg + ' alt="" class="img-fluid empImg mx-2" style="width:20px;"> ';
                        StrHTML += '<img src=' + EmpNameImg + ' alt="" class="img-fluid img-fluid_Updated  empImg mx-2" style="width:20px;"> ';
                          <%-- /*End of Added By Dipali V On 19th Feb 2025 For Icon Format Changes*/--%>
                    }
                    StrHTML += EmpName;
                    StrHTML += '</td>';
                    StrHTML += '<td class="approcedate" id="input_final_amount_1">' + FinalAmount + '</td>';
                    StrHTML += '<td class="approcedate" id="input_pm_edited_value_1">' + EditAmount + '</td>';
                    StrHTML += '<td><i class="fas fa-times" style="cursor:pointer" data-bs-toggle="tooltip" data-bs-placement="top" title="Remove Form IR" id="DeslectIRItems_' + AdviseId + '_' + TimesheetID + '_' + ProjectRoleId + '_' + EmployeeId + '" onclick="DeselectIRItems(' + AdviseId + ',' + TimesheetID + ',' + ProjectRoleId + ',' + EmployeeId + ',' + SiteId + ')"></i></td>';
                    StrHTML += '</tr>';


                }
            } else {
                StrHTML='<tr><td colspan="4">No Data</td></tr>'
            }
           // console.log(BillingchckHeadIRItems);
            $("#TbodySelectedItems").html(StrHTML);
            $('[data-bs-toggle="tooltip"]').tooltip()

            if (IsAllValuesInSiteCurrency == false || IsAllValuesInSiteCurrency == "false") {
                $("#IRProjectCurrency").text("");
                $("#IRProjectCurrencyCode").text("");
                $("#IRProjectCurrency").text(GBillingCurrencyCode);
                $("#IRProjectCurrencyCode").text(GBillingCurrencySymbol);
                //$("#linkMoreDetails").text("");
            } else {
                $("#IRProjectCurrency").text("");
                $("#IRProjectCurrencyCode").text("");
                $("#IRProjectCurrency").text(SelectedSiteCurrencyCode);
                $("#IRProjectCurrencyCode").text(SelectedSiteCurrency);
                //$("#linkMoreDetails").text("Billing Currency consider Site Currency.More details");
            }

        }


        function DeselectIRItems(AdviseId , TimesheetID , ProjectRoleId , EmployeeId,siteid) {
            //debugger;
            SelectedSiteCurrencyID = "";
            SelectedSiteCurrencyCode = "";
            var ClosedTR = $("#TRIRItems_" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId);
            //SelectedSiteCurrencyID = $("#SiteCurrency" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId + "").val();
            $("#" + AdviseId + "_" + TimesheetID + "_" + ProjectRoleId + "_" + EmployeeId).prop('checked', false);
            ClosedTR.remove();
           // debugger;
            const index = ArrAdviseId.indexOf(AdviseId.toString());
            const Sindex = ArrSiteId.indexOf(siteid.toString());
            if (index > -1) { // only splice array when item is found
                ArrAdviseId.splice(index, 1); // 2nd parameter means remove one item only
            }

            if (Sindex > -1) { // only splice array when item is found
                ArrSiteId.splice(Sindex, 1); // 2nd parameter means remove one item only
            }
            if (("#TbodySelectedItems tr").length() == 0) {
                StrHTML = '<tr><td colspan="4">No Data</td></tr>';
                $("#TbodySelectedItems").html(StrHTML);
            }

            console.log(ArrAdviseId);
            console.log(ArrSiteId);
           
        }
        //Added By Dipali V On 7th Nov 2023 For save IR Comments 
        function SubmitIR() {
            if ($("#IRCommets").val().trim() == "") {
                alertify.error('<%= MyBase.GetResourceString("C_CheckListCommentblank")%>');
                $("#IRCommets").focus();
                return false;
            }
            else if ($("#cboIRStatus").val() == "") {
                alertify.error('<%= MyBase.GetResourceString("C_Statusblank")%>');
                $("#cboIRStatus").focus();
            } else {
                var IRCommets = $("#IRCommets").val().trim().replace(/'/g, "''");;
                var IRStatus = $("#cboIRStatus").val();


                var Parameters = {
                    IRCommets: encodeURI(IRCommets),
                    IRStatus: encodeURI(IRStatus),
                    ProjectID: encodeURI(ProjectID),
                    RFID: encodeURI(GRFID),
                    UserName: encodeURI(UserName),
                    UserID: encodeURI(UserID)
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/SubmitIR", param, false);
                
                if (strResult != "") {
                   
                    alertify.success('<%= MyBase.GetResourceString("C_SubmitSuccessfully")%>');
                    $("#SubmitIRModal").modal('hide');
                    var RFID = GRFID
                     // Added By Dipali On 7th Nov 2023 For Submit IR
                    if (strResult == "True") {
                        window.open('../Email/SendEmail.aspx?MessageID=51&RFID=' + RFID + '&ProjectID=' + ProjectID + '&UserID=' + UserID, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500');
                    }
                    //var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_BillingInfo'));
                    //myOffcanvas.hide();
                   // $("#offcanvas_BillingInfo").click(function () {
                    $('#offcanvas_BillingInfo').offcanvas('hide');
                    $("#Generate_IR_accordion").css("display", "none");
                    clearAllValues();
                   // });
                }
            }
        }

        function clearAllValues() {
            //GetSelectedIRItems();
            //debugger;
            $("#TexthiddenCustomerAddressID").val(0);
            $("#TexthiddenSalesPeriod").val(0);
            $("#txtinput_Email").val("");
            $("#txtSalesPeriod").val("");
            $("#txtSalesPerson").val("");
            $("#IRItemsHeader").val("");
            $("#txtContract").val("");
            $(".SalesPersonchck").prop('checked', false);
            $("#TexthiddenSalesPerson").val(0);
            $("#TexthiddenContract").val(0);
            $(".Contractchcktbl").prop("checked", false);
            $("#TbodySelectedItems").html('');
          
            var StrHTML = '<tr><td colspan="4">No Data</td></tr>';
            $("#TbodySelectedItems").html(StrHTML);
        }

        $(".closeWindowBtn").on('click', function () {

            clearAllValues();

        });

        $("#cboCustomer").on('change', function () {
            if ($("#cboCustomer").val() == 0) {
                $("#linkCustomerAddress").css("display", "none");
                $("#linkContractDetails").css("display", "none");

            } else {
                $("#linkCustomerAddress").css("display", "block");
                $("#linkContractDetails").css("display", "block");
            }
           

        });

        //Refresh Page after closing Billing Information Page
        function CancelFrom_BillingPage() {
            $("#SubmitIRModal").modal('hide');
            $('#offcanvas_BillingInfo').offcanvas('hide');
            $("#Generate_IR_accordion").css("display", "none");
            clearAllValues();
            $(".paginate_button, .addbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "pointer");
            $(".table").resize();
        }

        //Refresh Page after closing Billing Information Page
        function closeBillingDetails() {
            $("#SumDiscountbillingCurrency").css("display", "none");
            $("#SumInvoicebillingCurrency").css("display", "none");
        }
        //Refresh Page after closing Any Modal Pop up
        function CancelModal_Onclick() {
            GFromwhere = "";

        }

        //});
    </script>

</body>

</html>