<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_AddTimesheet.aspx.vb" Inherits="PbNIT.PM_AddTimesheet" %>

<!DOCTYPE html>
<html>

<head>
      <!-- Commented by Madhuri.K On 14-08-2024 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css" />--%>

    <!-- Font Awesome -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.min.css?v=2">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/calendar-gc.min.css">--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=0.2">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>


</head>
        <style type="text/css">
        #project_timeperiod {
            font-size: 15px;
            font-weight: 600 !important;
        }

        .gc-calendar table.calendar td {
            text-align: center;
        }

        .borderbtn {
            border-color: #1359a6;
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

        .h5, h5 {
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

            .colapsibleinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus {
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

        th.text-start, td.text-start {
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

        .toolactions > div, .toolactions > a {
            display: inline-block;
            vertical-align: top;
        }

        .custom_chckbox.chckbox-hide label:before {
            margin-right: 0;
            border: 1px solid #464a4c;
            margin: 0 4px;
            vertical-align: top;
        }
    
        .td.toolactionsTD, .edit_row_open td {
            pointer-events: auto;
        }

        .edit_row_open .no-edit {
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

        .form-control:focus, .form-select:focus {
            border-color: #3c8dbc;
            box-shadow: none;
        }

        .offcanvas {
            width: 90% !important;
        }


        label {
            font-weight: 600;
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

        .main-menu li:hover > a, nav.main-menu li.active > a, .dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus, .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus, .no-touch .dashboard-page nav.dashboard-menu ul li:hover a, .dashboard-page nav.dashboard-menu ul li.active a {
            color: #656363;
            background: none;
        }

        .ui-datepicker {
            width: 20em;
        }

        .clsNote {
            color: red;
            /* float: right; */
            margin-left: 14px;
            font-size: 11px;
        }

        .offcanvas {
            width: 85% !important;
        }

        #Applicable_monthly_rate {
            background-color: #f5f5f5;
        }
         #txtInvoiceDate ,#TxtFromDate,#TxtToDate {
           font-size:12px!important;
       }

        .text_color {
            color: #4263c1;
            font-size:10px;
        }
       #txtOU, #txtDiscount,#txtBufferPercent,#txtMonthlyHr,#txtEffortToConsider {
            width: 97px;
            text-align: center !important;
           /* font-size:10px!important;*/
        }

        #ValidateConversionDate {
            font-size: 10px;
            color: red;
            animation: blinker 1s linear infinite;
            font-weight: 500;
        }

        @keyframes blinker {
            60% {
                opacity: 0;
            }
        }

        .MoreInformation {
            font-size: 10px;
            color: blue;
        }

        .EmpNoTSList li {
            list-style-type: none;
        }

        .empImg {
            width: 20px;
            border-radius: 50%;
        }

        .TS_acordian_panel .accordion-button {
            font-weight: 400;
            font-size: 14px;
        }

        .weekend {
            background-image: repeating-linear-gradient(45deg, #fff, #e9e9e9 1px, #fff 3px, #fff 4px);
        }
        .ExtraNormal {
            font-size: 11px;
            text-align: right;
            padding-right: 5px;
        }

         .tooltip-inner {
           font-size: 10px;
       }
         /*Added By Dipali V On 24th Oct 2023 For UI Changes*/
          #txtDiscount {
           width:95px;
       }
        ::placeholder {
            color: lightgray!important;
            opacity: 1; /* Firefox */
        }

        :-ms-input-placeholder { /* Edge 12-18 */
            color: lightgray!important;
        }
        #SelectedDate {
           font-weight: 600;
    color: #b158e9;
        }

        input::placeholder {
            font-size: 10px;
        }
        #cboOnSiteFull::placeholder {
            font-size: 10px;
        }
            /*End of Added By Dipali V On 24th Oct 2023 For UI Changes*/
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
    </style>
<body class="hold-transition skin-blue-light " id="ProjectTimeSheet">
    <div class="wrapper">
        <div class="bgwhite">
            <div class="graybg container-fluid pt-1 pb-3 statckmainheader">
                <div class="row">
                    <div class="col-sm-3">
                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_ProjectTimesheet") %></h5>
                    </div>
                    <div class="col-sm-9 form-inline text-end pt-1">
                    </div>
                </div>
            </div>

            <div class="content container-fluid  pt-0">
                <!--ps_list_table_start-->
                <div class="tab-pane pstbl_timesheet pt-0 in active" id="p_timesheet_add">
                    <div class="row">
                        <div class=" col-sm-12  pt-1 pb-1 text-end">
                            <%If m_AddAccess = True Then%>
                              <a href="javascript:;" class="btn btnyellow mr-5" id="generat_btn" onclick="SaveProjectTimeSheet()">
                                <span data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Generate TimeSheet">
                                    <%=MyBase.GetResourceString("C_GenerateTimeSheet") %>
                                </span>
                            </a>
                            <%End If %>
                            <a href="javascript:;" class="btn borderbtn" id="site_calender_btn" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="View Site Calendar" onclick="ShowSiteCalender()"><span aria-controls="offcanvas_offcanvas_site_calender"><%=MyBase.GetResourceString("C_ViewSiteCalendar") %></span></a>
                            <a href="javascript:;" class="btn borderbtn" id="btnViewTask" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="View Task List" onclick="ViewTask_Onclick()"><span id="ViewTaskList"><%=MyBase.GetResourceString("C_ViewTaskList") %> </span></a>
                            <a href="javascript:;" class="btn borderbtn" id="back_btn" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Back" onclick="Back_Onclick()"><%=MyBase.GetResourceString("C_Back") %></a>
                        </div>
                    </div>

                    <div class="row form-group mt-3">
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end mt-2">
                                    <label class="lb_projectname"><%=MyBase.GetResourceString("C_ProjectName") %></label>
                                </div>
                                <div class="col-sm-6 mt-2 text-start">
                                    <label class="lbproject" id="SpanProjectName"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end mt-2">
                                    <label class="lb_Commercial"><%=MyBase.GetResourceString("C_CommercialType") %> </label>
                                </div>
                                <div class="col-sm-6 mt-2 text-start">
                                    <span class="lb_Commercial_type" id="SpanCommercialType"></span>
                                  
                                </div>
                                 <%-- <br />--%>
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


                    <div class="row form-group mt-3">
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end mt-2">
                                    <label class="required "><%=MyBase.GetResourceString("C_FromDate") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("TxtFromDate", "TxtFromDate", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100' onchange='GetDaterange()'",,, True,, ,, True) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end  mt-2">
                                    <label class="required"><%=MyBase.GetResourceString("C_ToDate") %></label>
                                </div>
                                <div class="col-sm-6 text-start">
                                    <div class="input-group">

                                        <% CommonFunctions.HTMLControls.DrawTextBox("TxtToDate", "TxtToDate", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100' onchange='TimesheetOnChangePeriod()'",,, True,, ,, True) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end  mt-2">
                                    <label class="required lb_ouWorking"><%=MyBase.GetResourceString("C_OU") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">

                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtOU", "txtOU", "form-control",,,,,,,,,, "onkeypress='return isOnlyNumberKey(event)' autocomplete='off' maxlength='100'",,, True,, ,, True) %>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="row form-group mt-3">
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end mt-2">
                                    <label class="required "><%=MyBase.GetResourceString("C_WHD") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">

                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtHRPerDay", "txtHRPerDay", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100' onkeypress='return restrictAlphabets(event)'",,, True,, ,, True) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end  mt-2">
                                    <label class=""><%=MyBase.GetResourceString("C_Discount") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">

                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtDiscount", "txtDiscount", "form-control",,,,,,,,,, "onkeypress='return restrictAlphabets(event)' onkeyup='DiscountValidation()' placeholder='Discount %' autocomplete='off' maxlength='3'",,, True,, ,, True) %>
                                </div>
                                <span class="MoreInformation" style="margin-left: 86px;"><%=MyBase.GetResourceString("C_NoteDiscount") %> </span>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end  mt-2">
                                    <%--<label class="required"><%=MyBase.GetResourceString("C_ProjectCurrency") %> </label>--%>
                                    <label class="required"><%=MyBase.GetResourceString("C_CBillingCurrency") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtProjectCurrency", "txtProjectCurrency", "form-control",,,,,,, , ,, "placeholder='INR' autocomplete='off' maxlength='100' disabled",,, True,, ,, True) %>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="row form-group mt-3">
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end mt-2">
                                    <label class="required lb_ratemethod"><%=MyBase.GetResourceString("C_RateMethod") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">

                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboRateMethod", "usp_Whizible2_Sel_RateMethods",,, "onchange='RateMethodOnChange()' data-live-search='true' class='selectpicker'", False,, ) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end  mt-2">
                                    <label class="lb_Site_Validation"><%=MyBase.GetResourceString("C_SiteValidation") %></label>
                                </div>
                                <div class="col-sm-6 text-start">


                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboSiteValidation", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, " data-live-search='true' class='selectpicker' onchange='OnchangeSiteValidation()'", False,, ) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end  mt-2" style="padding-right:15px!important;padding-left:2px!important;">
                                    <label class="required lb_invoice"><%=MyBase.GetResourceString("C_InvoiceDate") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">
                                    <div class="input-group">

                                        <%CommonFunctions.HTMLControls.DrawTextBox("txtInvoiceDate", "txtInvoiceDate", "form-control",,,,,,, True, "white",, "autocomplete='off' maxlength='100' onchange='Validatedate()'",,, True,, ,, True) %>
                                         <%--/*Added By Dipali V On 24th Oct 2023 For UI Changes*/--%>
                                        <span class="input-group-btn">
                                             <%--/*End of Added By Dipali V On 24th Oct 2023 For UI Changes*/--%>
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                    <span id="ValidateConversionDate"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row form-group mt-3" id="DivCapHoliday">
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end mt-2">
                                    <label class="lb_ratemethod"><%=MyBase.GetResourceString("C_CapConsider") %> </label>
                                </div>
                                <div class="col-sm-6 text-start">

                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboCapConsider", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, "onchange='CapConsiderChange()' data-live-search='true' class='selectpicker'", False,, ) %>
                                </div>
                                <span class="MoreInformation" style="margin-left: 30PX;"><%=MyBase.GetResourceString("C_CapInformation") %> </span>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="row mb-1">
                                <div class="col-sm-6 text-end  mt-2">
                                    <label class="lb_Site_Validation"><%=MyBase.GetResourceString("C_CapHoliday") %></label>
                                </div>
                                <div class="col-sm-6 text-start">


                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboCapHoliday", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, "onchange='CapHolidayChange()' data-live-search='true' class='selectpicker'", False,, ) %>
                                </div>
                                <span class="MoreInformation" style="margin-left: 41px;"><%=MyBase.GetResourceString("C_HolidayInformation") %> </span>
                            </div>
                        </div>
                    </div>



                    <div class="accordion collapse Init_acordian_panel mb-3 mt-3 show" id="Generate_IR_accordion" style="display: none">
                        <div class="accordion-item ">

                            <div id="Generate_IR_Project" class="accordion-collapse collapse  show"
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
                                                        <label class=" lb_Actual_Day"><%=MyBase.GetResourceString("C_ActualDayBiling") %>  </label>
                                                    </div>
                                                    <div class="col-sm-6  text-start">
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboActualDayBilling", "Exec usp_Whizible2_Sel_YesNoValue 'YN',NULL",,, " data-live-search='true' class='selectpicker' onchange='ActualDayBillingRateOnchange()'", False,, ) %>
                                                    </div>
                                                      <span class="MoreInformation" style="text-wrap: nowrap;"><%=MyBase.GetResourceString("C_ActualBilling") %> </span>
                                                </div>
                                            </div>
                                           <%-- <div class="col-sm-4">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="lb_Fixed_monthly"><%=MyBase.GetResourceString("C_FixedMonthly") %></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboFixedMonthlyRate", "EXEC usp_Whizible2_Sel_YesNoValue",,, " data-live-search='true'  class='selectpicker' onchange='FixedMonthlyRateOnchange()'") %>
                                                    </div>
                                                </div>
                                            </div>--%>

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
                    

                                             <div class="col-sm-4">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
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
                                                    <div class="col-sm-4 text-start mt-2">
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
                        <%=MyBase.GetResourceString("C_Note") %>
                        <br>
                        <span class="clsNote"><%=MyBase.GetResourceString("T_Note1") %> </span>
                        <br>
                        <span class="clsNote"><%=MyBase.GetResourceString("T_Note2") %></span><br>
                         <span class="clsNote" id="T_Note4"><%=MyBase.GetResourceString("T_Note4") %></span><br>
                        <span class="clsNote" id="T_Note3"><%=MyBase.GetResourceString("T_Note3") %></span><br>
                       
                    </span>

                </div>


                <div class="modal custmodal fade" id="RMmodal" data-bs-dismiss="modal">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="" style="margin-left: 180px"><%=MyBase.GetResourceString("C_NotificationAlert") %>  </h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <%=MyBase.GetResourceString("C_RateMethodDiff") %>
                                <div class="clearfix"></div>

                                <br />
                                <div class="text-center">
                                    <button class="btn btnyellow" onclick="ShowGenerateTimesheetDetails('Generate')"><%=MyBase.GetResourceString("C_Ok") %>  </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1" id="offcanvas_view_tasklist" aria-labelledby="offcanvas_offcanvas_view_tasklist">
                    <div class="offcanvas-body">
                        <div id="view_tasklist_Details" class="NOI_Details">
                            <div class="graybg container-fluid pt-1 pb-1 mb-2 view_tasklist_Header">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_timesheet") %></h5>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2 project_timeperiod">
                                <div class="col-sm-12 ">
                                    <div class="row">


                                        <div class="col-sm-12 text-end">
                                            <button type="button" class="btn btn borderbtn closeWindowBtn closebtn text-end" id="close_view_tasklist_btn" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Close">Close</button>
                                        </div>
                                    </div>
                                    <div class="row mt-2 mb-2" id="project_timeperiod">
                                        <div class="col-sm-12 ">
                                            <span><%=MyBase.GetResourceString("C_ViewTaskList") %> &nbsp;-&nbsp;</span>
                                            <span><%=MyBase.GetResourceString("C_FromDate") %> :</span>
                                            <span class="project_fromdate"></span>&nbsp;&nbsp;
                                                <span><%=MyBase.GetResourceString("C_ToDate") %> :</span>
                                            <span class="project_todate"></span>

                                        </div>
                                    </div>

                                </div>
                                <div class="view_tasklist_content">
                                    <div class="tab-content detailsmenutab">
                                        <div class="tab-pane active" id="BasicDetailsTab">
                                            <div class="BasicDetailsContent">
                                                <div id="view_tasklist_panel" class="init_grid_panel">
                                                    <table class="table table-bordered table-stripped highlight-tbl stickytable">
                                                        <thead>
                                                            <tr>
                                                                <th width="13%"><%=MyBase.GetResourceString("c_EmployeeName") %></th>
                                                                <th width="10%"><%=MyBase.GetResourceString("c_Date") %></th>
                                                                <th class="text-start" width="20%"><%=MyBase.GetResourceString("c_TaskName") %></th>
                                                                <th width="21%"><%=MyBase.GetResourceString("c_Description") %> </th>
                                                                <th width="10%"><%=MyBase.GetResourceString("CC_ActualWork") %> </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tbodyViewTaskList">
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
                </div>


                <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1" id="offcanvas_site_calender" aria-labelledby="offcanvas_MonthlyBillingInfo">
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
                                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_ViewSiteCalendar") %> </h5>
                                    </div>
                                </div>
                            </div>
                            <!--Site Calendar-->
                            <div id="prositedetailTab3" class="tab-pane mt-4">
                                <div class="projDetailsContent projDetailsSiteCalendar">
                                    <div class="container-fluid">
                                        <div class="SiteCalendarContent">
                                            <div class="form-group row mt-1 mb-2">
                                                <label class="control-label col-sm-1" style="margin-top: 5px;"><%=MyBase.GetResourceString("C_Site") %></label>
                                                <div class="col-sm-3">

                                                    <%CommonFunctions.HTMLControls.DrawComboBox("selectDefaultSite", "select '1'",,, " data-live-search='true' class='selectpicker' onchange=Site_Onchange()", False,, ) %>
                                                </div>
                                                <div class="col-sm-7 text-end">
                                                    <div class="legend float-end">
                                                        <ul class="">
                                                            <li>
                                                                <label class="mx-1"><%=MyBase.GetResourceString("C_Legends") %>:</label></li>
                                                            <li>
                                                                <span class="lgdHoliday" data-bs-toggle="tooltip"
                                                                    data-bs-container="body" aria-label="Holiday"
                                                                    data-bs-original-title="Holiday"></span>
                                                            </li>
                                                            <li>
                                                                <span class="lgdPlannedday" data-bs-toggle="tooltip"
                                                                    data-bs-container="body" aria-label="Today"
                                                                    data-bs-original-title="Today"></span>
                                                            </li>
                                                            <li>
                                                                <span class="lgdPH" data-bs-toggle="tooltip"
                                                                    data-bs-container="body" aria-label="Weekend"
                                                                    data-bs-original-title="Weekend"></span>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="col-sm-1 pe-4">
                                                    <div class="detailsubtabsbtn pb-1 text-end">
                                                        <button class="btn borderbtn" type="button"
                                                            data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Close">
                                                            <%=MyBase.GetResourceString("C_Close") %>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>

                                            <%-- <div id="siteCalendarView" class="w-100"></div>--%>
                                            <table cellspacing="0" cellpadding="0" width="99.9%">
                                                <tbody>
                                                    <tr class="clsTRSectionHeader clsHeaderSec">
                                                        <td height="22" class="clsTDSelected" valign="top"></td>
                                                        <td height="22" id="tdSchedule" valign="top"></td>
                                                    </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>

                <div class="offcanvas offcanvas-end generateOffcanvas" data-bs-scroll="true" tabindex="-1"
                    id="offcanvasGenerateTimeSheet" aria-labelledby="offcanvas_MonthlyBillingInfo">
                    <div class="offcanvas-body">
                        <div id="generateTS_Sec" class="generateTimesheet">
                            <div class="generateTS_Header d-flex justify-content-between">
                                <div class="Overlay-title"></div>
                                <div class="generateTS_HeaderBtns">
                                </div>
                            </div>
                            <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_timesheet") %></h5>
                                    </div>
                                </div>
                            </div>
                            <!-- Generate TimeSheet -->
                            <div id="generateTSTab">
                                <div class="generateTSContent generateTSContent">
                                    <div class="container-fluid">
                                        <div class="row align-items-center">
                                            <div class="col-sm-6">&nbsp;</div>
                                            <div class="col-sm-6 pe-4">
                                                <div class="detailsubtabsbtn text-end">
                                                     <%If m_AddAccess = True Then%>
                                                    <a href="javascript:;" class="btn btnyellow" id="generateTSBtn"
                                                        data-bs-toggle="tooltip" data-bs-container="body" aria-label="Generate Timesheet"
                                                        data-bs-original-title="Generate Timesheet" onclick="GetAllSavingParameter()"><%=MyBase.GetResourceString("C_GenerateTimeSheet") %></a>
                                                    <%End If %>
                                                    <button class="btn borderbtn" type="button"
                                                        data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-container="body" aria-label="Weekend"
                                                        data-bs-original-title="Close">
                                                        <%=MyBase.GetResourceString("C_Close") %></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="container-fluid">
                                        <div class="accordion TS_acordian_panel mb-3 mt-3 " id="EMpTSDetailsAcc">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header" id="EMpTSHeading">
                                                    <div class="accordion-button" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#EMpTSDetailsTab" aria-expanded="true" aria-controls="EMpTSDetailsTab">
                                                        <div class="detailTabTitleDiv p-0">
                                                            <div class="detailSubtabTitle mb-0"><%=MyBase.GetResourceString("C_DAFillResourceNote") %> </div>
                                                            <div class="row">
                                                                <div class="col-sm-4">
                                                                    <div>
                                                                        <i class="fas fa-calendar-check pe-2"></i><span
                                                                            class="font-weight-500"><%=MyBase.GetResourceString("C_FromDate") %>: </span><span id="GTSFromDate"></span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-4">
                                                                    <div>
                                                                        <i class="fas fa-calendar-check pe-2"></i><span
                                                                            class="font-weight-500"><%=MyBase.GetResourceString("C_ToDate") %>: </span><span id="GTSToDate"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </h2>
                                            </div>
                                            <div id="EMpTSDetailsTab" class="accordion-collapse collapse show"
                                                aria-labelledby="EditbleDetailsHeading" data-bs-parent="#EditbleDetailsAcc">
                                                <div class="accordion-body">
                                                    <div class="table-responsive">
                                                        <table id="generateTSTbl" class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th><%=MyBase.GetResourceString("c_EmployeeName") %></th>
                                                                    <th><%=MyBase.GetResourceString("C_FromDate") %></th>
                                                                    <th><%=MyBase.GetResourceString("C_ToDate") %></th>
                                                                    <th><%=MyBase.GetResourceString("C_TimesheetEffort") %> </th>
                                                                    <th><%=MyBase.GetResourceString("C_Status") %></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tbodyTSGenerated">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="container-fluid">
                                        <div class="accordion TS_acordian_panel mb-3 mt-3 " id="EditbleDetailsNonbillableAcc">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header" id="EMpTSHeading">
                                                    <div class="accordion-button" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#EMpTSVerifiedDetailsTab" aria-expanded="true" aria-controls="EditbleDetailsNonbillableAcc">
                                                        <div class="detailTabTitleDiv p-0">
                                                            <div class="detailSubtabTitle mb-0"><%=MyBase.GetResourceString("C_DAVerifiedFillResourceNote") %> </div>
                                                            <div class="row">
                                                                <div class="col-sm-4">
                                                                    <div>
                                                                        <i class="fas fa-calendar-check pe-2"></i><span
                                                                            class="font-weight-500"><%=MyBase.GetResourceString("C_FromDate") %>: </span><span id="GTNonSFromDate"></span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-4">
                                                                    <div>
                                                                        <i class="fas fa-calendar-check pe-2"></i><span
                                                                            class="font-weight-500"><%=MyBase.GetResourceString("C_ToDate") %>: </span><span id="GTNonSToDate"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </h2>
                                            </div>
                                            <div id="EMpTSVerifiedDetailsTab" class="accordion-collapse collapse show"
                                                aria-labelledby="EditbleDetailsHeading" data-bs-parent="#EditbleDetailsNonbillableAcc">
                                                <div class="accordion-body">
                                                    <div class="table-responsive">
                                                        <table id="generateTSTblVerified" class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th><%=MyBase.GetResourceString("c_EmployeeName") %></th>
                                                                    <th><%=MyBase.GetResourceString("C_FromDate") %></th>
                                                                    <th><%=MyBase.GetResourceString("C_ToDate") %></th>
                                                                    <th><%=MyBase.GetResourceString("C_TimesheetEffortBillableNonBillabale") %> </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tbodyTSVerifiedGenerated">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="container-fluid">
                                <div class="detailTabTitleDiv my-3" id="EmpListFillTS">
                                    <div class="detailSubtabTitle mb-0"><%=MyBase.GetResourceString("C_DANotFillResourceNote") %> </div>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <div>
                                                <i class="fas fa-calendar-check pe-2"></i><span
                                                    class="font-weight-500"><%=MyBase.GetResourceString("C_FromDate") %>: </span><span id="GTSNFromDate"></span>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div>
                                                <i class="fas fa-calendar-check pe-2"></i><span
                                                    class="font-weight-500"><%=MyBase.GetResourceString("C_ToDate") %>: </span><span id="GTSNToDate"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="container-fluid EmpNoTSNames" id="EmpNotFillTSNames">
                                <div class="detailTabTitleDiv my-2">
                                    <h5 class="detailSubtabTitle mb-0"><%=MyBase.GetResourceString("c_EmployeeName") %></h5>
                                </div>

                                <ul class="EmpNoTSList" id="EmpNoTSNamesList">
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="modal custmodal fade" id="SCDetailsModal" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="site_details" style="margin-left: 155px"><%=MyBase.GetResourceString("C_SiteCalendarDetails") %></h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-12 text-end">
                                        <label class="form-label "><span id="SelectedDate"></span></label>
                                    </div>
                                </div>
                                <div class="form-group row pt-1 mb-2">
                                    <label class="control-label col-sm-4 " style="margin-top: 5px;"><%=MyBase.GetResourceString("C_NormalHours") %></label>
                                    <div class="col-sm-6">
                                        <input type="textbox" value="8" class="form-control"  id="NormalHours"/>
                                    </div>
                                </div>
                                <div class="form-group row pt-1 mb-2">
                                    <label class="control-label col-sm-4" style="margin-top: 5px;"><%=MyBase.GetResourceString("C_ExtraHours") %> </label>
                                    <div class="col-sm-6">
                                        <input type="textbox" class="form-control" id="ExtraHours" />
                                    </div>
                                </div>
                                <div class="form-group row pt-1 mb-2">
                                    <label class="control-label col-sm-4" style="margin-top: 5px;">&nbsp;</label>
                                    <div class="col-sm-6">
                                        <div class="custom_chckbox">
                                            <input id="scdcheck1" class="chcktbl" type="checkbox" disabled>
                                            <label for="scdcheck1"><%=MyBase.GetResourceString("C_IsHoliday") %>  </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <br />
                                <div class="text-center">
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Close")%> </a>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="clearfix"></div>
        </div>
    </div>





    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
       <!-- Commented by Madhuri.K On 14-08-2024 for JQuery and Bootstrap version upgrade -->

  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>
    <!--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>-->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/calendar-gc.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../General/CommonValidations.js"></script>

    <script>


        //Page Name : PM_AddTimesheet
        //Created By : Dipali V
        //Created Date : 26th Sep 2023
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>'
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        var UserID ='<%= Session("intUserID") %>'
        var LoginType = '<%= Session("LoginType") %>';
        var userName ='<%= Session("strUserName") %>';
        var ProjectID = '<%= Request.QueryString("ProjectID")%>';
        var OrganizationUnit = "";
        var ContractTypeID = "";
        var CurrencyID = "";
        var ajaxResult = "";
        var GetOUWorkingDays = "";
        var GlobalMonthlyHr = "";
        var RateMethodsCount = "";
        var GlobalWorkHrsperday = "";
        var GlobalWorkHrs = "";
        var globalcontracttype = "";
        var GetParentProject = 0;
        var RestrictByMinHours = true;
        var MinHoursForDAEntry = "";
        $(document).ready(function () {
            StartLoader("#ProjectTimeSheet");
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
            GetMINDAValidation();
            SelectedCurrentdate = new Date();
            GetProjectRateMethod();
            GetProjectDetails();

            $("#txtInvoiceDate").val(SelectedCurrentdate.toShortFormat());
            Validatedate();
            //debugger;
            if (ContractTypeID == "5" || ContractTypeID == "4") {
                // $('#CboSiteValidation').children('option[value="No"]').remove();
                $('#cboSiteValidation').val('Yes');
                $('#cboSiteValidation').prop('disabled', 'true');
            }
            if (ContractTypeID == "5") {
                $('#DivCapHoliday').css('display', 'none');
                $('#Generate_IR_accordion').css('display', 'none');
            }
            $(".selectpicker").selectpicker('refresh');
            StopAjaxLoader("#ProjectTimeSheet");
        });

        //Added By Dipali V On 1st Nov 2023 For If Site Validation No  then Cap & Holiday not applicable
        function OnchangeSiteValidation() {
            //debugger;
            if ($("#cboSiteValidation").val() == "No") {
                $("#cboCapConsider").prop('disabled', true);
                $("#cboCapHoliday").prop('disabled', true);
                $("#cboCapConsider").val("No");
                $("#cboCapHoliday").val("No");
            } else {
                $("#cboCapConsider").prop('disabled', false);
                $("#cboCapHoliday").prop('disabled', false);
            }
            $(".selectpicker").selectpicker('refresh');
        }
         //End of Added By Dipali V On 1st Nov 2023 For If Site Validation No  then Cap & Holiday not applicable
        //Added By Dipali V On 3rd Oct 2023 For Get Project Rate Method
        function GetProjectRateMethod() {
            var Parameters = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectRateMethod", param, false);

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
        function GetProjectDetails() {
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectDetails", param, false);
            //debugger;
            var GetProjectDetail = strResult.GetProjectDetail;
            var GetDatesForTimeSheet = strResult.GetDatesForTimeSheet;
            var GetOUWorkingDays = strResult.GetOUWorkingDay;
            var RateMethodsval = strResult.RateMethods;
            RateMethodsCount = RateMethodsval.length;
            BindProjectDetails(GetProjectDetail);
            BindOUWorkingDays(GetOUWorkingDays);

            if (GetDatesForTimeSheet != undefined) {
                for (var i = 0; i < GetDatesForTimeSheet.length; i++) {
                    var FromDate = GetDatesForTimeSheet[i]["FromDate"];
                    var ToDate = GetDatesForTimeSheet[i]["ToDate"];

                    $("#TxtFromDate").val(FromDate);
                    $("#TxtToDate").val(ToDate);

                }
            }
            RateMethodOnChange();
        }

        function GetDaterange() {
           // debugger;
            //Added By Dipali V On 16th Nov 2023 For Get Monthly Periods
            var RateMethod = $("#cboRateMethod option:selected").html();
            //alert(RateMethod);
            //if (globalcontracttype != "Fixed Fee")
            //{
                if (RateMethod == "Monthly")
                {
                    getmonthlyrange();
                }
            //}
            //End of Added By Dipali V On 16th Nov 2023 For Get Monthly Periods
            TimesheetOnChangePeriod();
        }
        //Added By Dipali V On 16th Nov 2023 For Get Monthly Periods
        function daysInMonth(month, year) {
            return new Date(year, month, 0).getDate();
        }

        function getmonthlyrange() {
            var someFormattedDate = "";
            var FromDate = document.getElementById('TxtFromDate').value;
            var date = new Date(FromDate);
            var newdate = new Date(date);
            var day = newdate.getDate();
            var month_index = newdate.getMonth() + 1;
            var year = newdate.getFullYear();
            newdate.setDate(newdate.getDate() + daysInMonth(month_index, year) - 1);

            var month_names = ["Jan", "Feb", "Mar",
                "Apr", "May", "Jun",
                "Jul", "Aug", "Sep",
                "Oct", "Nov", "Dec"];

            var day = newdate.getDate();
            var month_index = newdate.getMonth();
            var year = newdate.getFullYear();
            someFormattedDate = day + " " + month_names[month_index] + " " + year;

            $("#TxtToDate").val(someFormattedDate)
            $("#TxtToDate").prop("disabled", true);
        }

        // Added By Dipali V On 16th Nov 2023 for Depening Upon FromDate ToDate OUWorking Hours Calculated
        function TimesheetOnChangePeriod() {
            var FromDate = $("#TxtFromDate").val();
            var ToDate = $("#TxtToDate").val();
            var LocationID = OrganizationUnit;
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID),
                FromDate: encodeURI(FromDate),
                ToDate: encodeURI(ToDate),
                OrganizationUnit: encodeURI(LocationID),

            }
            var param = JSON.stringify(Parameters);
            var OUWorkingDays = AJAXCallWithResult("/api/PM_AddTimesheet/GetOUDuration", param, false);
            $("#txtOU").val(OUWorkingDays);
            GetMonthlyHours();//Added By Dipali V On 24th Nov 2023 For Get Monthly Hours 

          
        }
        //Added By Dipali V On 24th Nov 2023 For Get Monthly Hours 
        function GetMonthlyHours() {
           // debugger;
            var HRPerDay = ConvertDecimalToHourViceVersa($("#txtHRPerDay").val(), 2);
            var OUWorkingDays = $("#txtOU").val();
            var MonthlyHr = OUWorkingDays * HRPerDay
            var MonthlyHrHHMM = ConvertDecimalToHourViceVersa(MonthlyHr, 1)
            $("#txtMonthlyHr").val(MonthlyHrHHMM);
            if ($("#cboFixedMonthlyRate").val() == 'Yes') {
                $("#txtEffortToConsider").val(MonthlyHrHHMM);
            } else {
                $("#txtEffortToConsider").val('00:00');
            }
            calculateEffortToConsider();
        }
        //End of Added By Dipali V On 24th Nov 2023 For Get Monthly Hours 

        //Added By Dipali V On 3rd Oct 2023 For Rate OnChange 
        function RateMethodOnChange() {
            //debugger;
            var RateMethod = $("#cboRateMethod option:selected").html();
            if (RateMethod == "Hours" || RateMethod == "Day" || RateMethod == 'Select Rate Method') {
                $("#txtBufferPercent").prop("disabled", true);
                $("#TxtToDate").prop('disabled', false);// Added By Dipali V On 26th Dec 2023 For If Rate Method not Monthly then To Date Should be enabled
                $("#txtMonthlyHr").prop("disabled", true);
                $("#cboActualDayBilling").prop("disabled", true);
                $("#cboFixedMonthlyRate").prop("disabled", true);
                $("#cboOnSiteFull").prop("disabled", true);
                $("#txtBufferPercent").val('');
                //$("#txtEffortToConsider").val('00:00');
                
                //$("#txtEffortToConsider").val($("#txtMonthlyHr").val());
               
                $("#txtEffortToConsider").val('00:00');
                $("#cboActualDayBilling").val('NA');
                $("#cboFixedMonthlyRate").val('NA');
                $("#cboOnSiteFull").val('');
                $('#Generate_IR_accordion').addClass('highlitedbox');
                $("#Generate_IR_accordion").css("display", "none");
            } else {
                StartLoader("#ProjectTimeSheet");
                $("#TxtToDate").prop('disabled', true);// Added By Dipali V On 26th Dec 2023 For If Rate Method Monthly then To Date Should be Disabled
                $('#Generate_IR_accordion').addClass('highlitedbox');
                $("#Generate_IR_accordion").css("display", "block");
                $("#cboActualDayBilling").prop("disabled", false);
                $("#txtBufferPercent").prop("disabled", false);
                $("#txtMonthlyHr").prop("disabled", false);
                $("#cboFixedMonthlyRate").prop("disabled", true);
                $("#cboOnSiteFull").prop("disabled", false);
                $("#cboActualDayBilling").val('Yes');
                ActualDayBillingRateOnchange();
                $(".selectpicker").selectpicker('refresh');
                StopAjaxLoader("#ProjectTimeSheet");

            }

            // if (globalcontracttype == "Fixed Fee") {
            if (ContractTypeID == "5") {
                $(".FixedFee").css("display", "none");
                $(".highlitedpanel").css("display", "none");
            }
            
            $(".selectpicker").selectpicker('refresh');
        }

        //Added By Dipali V On 16th Nov 2023 For Actual Day Billing Rate OnChange
        function ActualDayBillingRateOnchange() {
            //debugger
            $("#txtBufferPercent").val('');
            // $("#txtEffortToConsider").val('00:00');
            $("#txtEffortToConsider").val('00:00');
            $("#cboOnSiteFull").val('');
            var ActualDayBilling = $("#cboActualDayBilling").val();
            var RateMethod = $("#cboRateMethod option:selected").html();
            if (RateMethod == "Monthly") {
                if (ActualDayBilling == 'Yes') {
                    $("#txtBufferPercent").prop("disabled", true);
                    //$("#cboFixedMonthlyRate").prop("disabled", true);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#cboFixedMonthlyRate").val('No');
                    //$("#cboActualDayBilling").prop("disabled", false);
                    $(".selectpicker").selectpicker('refresh');
                    
                }
                else if (ActualDayBilling == 'No') {
                    $("#txtBufferPercent").prop("disabled", true);
                    //$("#cboFixedMonthlyRate").prop("disabled", false);
                    //$("#cboOnSiteFull").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#cboFixedMonthlyRate").val('Yes');
                    $(".selectpicker").selectpicker('refresh');
                    FixedMonthlyRateOnchange();
                   
                   
                }
                else if (ActualDayBilling == 'NA') {
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboFixedMonthlyRate").prop("disabled", true);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                   
                }
            }
            $(".selectpicker").selectpicker('refresh');
            //$("#cboActualDayBilling .dropdown-menu").removeClass('show');
        }
        var GBillingCurrencyID;
        var GBillingCurrencySymbol;
        var GBillingCurrencyCode;
        var GIsAllValuesInSiteCurrency;
        var GCurrencyID;
        //Added By Dipali V On 16th Nov 2023 For Bind Project Details
        function BindProjectDetails(GetProjectDetail) {
            if (GetProjectDetail != undefined) {
                for (var i = 0; i < GetProjectDetail.length; i++) {
                    //debugger;
                    var ProjectName = GetProjectDetail[i]["ProjectName"];
                    var ContractType = GetProjectDetail[i]["ContractType"];
                    var CurrencyCode = GetProjectDetail[i]["CurrencyCode"];
                    var RateMethod = GetProjectDetail[i]["RateMethod"];
                    GlobalWorkHrs = GetProjectDetail[i]["WorkHrs"];
                    var HoursPerMonth = GetProjectDetail[i]["HoursPerMonth"];
                    var WorkHrsperdayHHMM = GetProjectDetail[i]["OUWorkHrsperdayHHMM"];
                    GlobalWorkHrsperday = GetProjectDetail[i]["WorkHrsperday"];
                    //GlobalWorkHrsperdayDecimal = GetProjectDetail[i]["WorkHrsperdayDecimal"];
                    OrganizationUnit = GetProjectDetail[i]["LocationID"];
                    ProjectOrganizationUnit = GetProjectDetail[i]["ProjectOrganizationUnit"];
                    GlobalMonthlyHr = GetProjectDetail[i]["MonthlyHr"];
                    ContractTypeID = GetProjectDetail[i]["ContractTypeID"];
                    CurrencyID = GetProjectDetail[i]["CurrencyID"];
                    GCurrencyCode = GetProjectDetail[i]["CurrencyCode"];
                    GCurrencySymbol = GetProjectDetail[i]["CurrencySymbol"];
                    GBillingCurrencyID = GetProjectDetail[i]["BillingCurrencyID"];
                    GBillingCurrencySymbol = GetProjectDetail[i]["BillingCurrencySymbol"];
                    GBillingCurrencyCode = GetProjectDetail[i]["BillingCurrencyCode"];
                    GIsAllValuesInSiteCurrency = GetProjectDetail[i]["IsAllValuesInSiteCurrency"];
                    $("#SpanProjectName").text(ProjectName);
                    $("#SpanProjectName").val(ProjectName);
                    $("#SpanCommercialType").text(ContractType);
                    $("#SpanProjectOU").text(ProjectOrganizationUnit);
                    $("#SpanCommercialType").val(ContractType);
                    if (ContractTypeID == 5) {
                        $("#SpanCommercialTypeNote").text("Billing rate will be Avg. Normal Rate defined at the site depending upon site duration");
                    } else {
                        $("#SpanCommercialTypeNote").text("");
                    }
                    globalcontracttype = ContractType;
                    //Commented & Added By Dipali V On 23rd Nov 2023 For Take Project Site Hours
                    $("#txtHRPerDay").val(GlobalWorkHrs);
                    //$("#txtHRPerDay").val(WorkHrsperdayHHMM);
                    //End of Commented & Added By Dipali V On 23rd Nov 2023 For Take Project Site Hours
                    //$("#txtMonthlyHr").val(HoursPerMonth);
                    //$("#txtMonthlyHr").val(HoursPerMonth);
                    $("#cboRateMethod").val(RateMethod);
                   //Added By Dipali V On 27th Dec 2023 If Billing Currency not set then should consider IR currency
                    if (GBillingCurrencyCode != GCurrencyCode) {
                        CurrencyCode = GBillingCurrencyCode;
                    } else {
                        CurrencyCode = GBillingCurrencyCode;
                    }
                    //End of Added By Dipali V On 27th Dec 2023 If Billing Currency not set then should consider IR currency
                    $("#txtProjectCurrency").val(CurrencyCode);
                    $("#txtProjectCurrency").text(CurrencyCode);
                    //alert(ContractTypeID);
                    //if (globalcontracttype == "Fixed Fee")
                    if (ContractTypeID == 5) {
                        $(".FixedFee").css("display", "none");
                        $("#Generate_IR_accordion").css("display", "none");
                        $("#T_Note3").css("display", "none");
                    }

                    
                    //if (globalcontracttype != "Fixed Fee") {
                    if (ContractTypeID != 5) {
                        if (RateMethod == 3) {
                            $("#TxtToDate").prop('disabled', true);
                        } else {
                            $("#TxtToDate").prop('disabled', false);
                        }
                    } else {
                        if (RateMethod == 3) {
                            $("#cboRateMethod").prop('disabled', true);
                        } else {
                            $("#cboRateMethod").prop('disabled', false);
                        }
                    }
                    //debugger;
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
                   //Added By Dipali V On 2nd Jan 2023 For Check if site currency enabled then site validation should be YES
                    if (GIsAllValuesInSiteCurrency == true || GIsAllValuesInSiteCurrency == 'true') {
                        $('#cboSiteValidation').val('Yes');
                        $('#cboSiteValidation').prop('disabled', 'true');
                    }
                   //End of Added By Dipali V On 2nd Jan 2023 For Check if site currency enabled then site validation should be YES
                }
            }
            $(".selectpicker").selectpicker('refresh');
        }
        //Added By Dipali V On 3rd Oct 2023 For Bind OU Details
        function BindOUWorkingDays(OUWorkingDays) {
            $("#txtOU").val(OUWorkingDays);
            //var HRPerDay = ConvertDecimalToHourViceVersa($("#txtHRPerDay").val(), 2);
            //var MonthlyHr = OUWorkingDays * HRPerDay;
            //var MonthlyHrHHMM = ConvertDecimalToHourViceVersa(MonthlyHr, 1)
            //$("#txtMonthlyHr").val(MonthlyHrHHMM);
            GetMonthlyHours();//Added By Dipali V On 24th Nov 2023 For Get Monthly Hours 
        }
        //Added By Dipali V On 24th Nov 2023 For Get Monthly Hours 
        $("#txtOU").on("change", function () {
            GetMonthlyHours();
        });

        $("#txtHRPerDay").on("change", function () {
            GetMonthlyHours();
        });
         //End of Added By Dipali V On 24th Nov 2023 For Get Monthly Hours 
        // Added By Dipali V On 3rd Oct 2023  on KeyPress Discount Validation
        function DiscountValidation() {
            var Discount = $("#txtDiscount").val();

            if (Discount < 0 || Discount > 100) {
                alertify.error("<%= MyBase.GetResourceString("A_DiscountPercentage") %>");
                $("#txtDiscount").focus();
                return false;
            }
            return true;
        }

        //Added By Dipali V On 3rd Oct 2023 For Check If Task Data Present or not
        function ShowMessagesForNodata() {
            var FromDate = $("#TxtFromDate").val();
            var ToDate = $("#TxtToDate").val();
            var RateMethod = $("#cboRateMethod").val();
            var Parameters = {
                FromDate: encodeURI(FromDate),
                ToDate: encodeURI(ToDate),
                RateMethod: encodeURI(RateMethod),
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(Parameters);
            var NoData = AJAXCallWithResult("/api/PM_AddTimesheet/ShowMessagesForNodata", param, false);
            if (NoData != undefined) {
                return NoData;
            }

        }

        //Added By Dipali V On 3rd Oct 2023  For Save Project TimeSheet
        var NoData = 0;
        function SaveProjectTimeSheet() {

            NoData = ShowMessagesForNodata();
            if (ValidateGenerateTimesheet() == true) {
                if (NoData == 1) {
                    ShowNotificationAlert('Generate');
                } else {
                    alertify.error("<%= MyBase.GetResourceString("C_NoTask") %> ");
                    return;
                }
            }

        }
        //Added By Dipali V On 4th Oct 2023  For Save Project TimeSheet
        function ShowNotificationAlert(flag) {
            // debugger;
            if (RateMethodsCount > 2) {
                $("#RMmodal").modal('show');
            }
            else {

                if (flag == "Generate") {
                    var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvasGenerateTimeSheet'));
                    myOffcanvas.show();
                    $("#GTSFromDate").text($("#TxtFromDate").val());
                    $("#GTSToDate").text($("#TxtToDate").val());
                    $("#GTSNFromDate").text($("#TxtFromDate").val());
                    $("#GTNonSFromDate").text($("#TxtFromDate").val());
                    $("#GTSNToDate").text($("#TxtToDate").val());
                    $("#GTNonSToDate").text($("#TxtToDate").val());
                    GetTSFillNotFillResource();
                    //GetAllSavingParameter();
                }
                else {
                    var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_view_tasklist'));
                    myOffcanvas.show();
                    View_Onclick();
                }
            }
        }


        function ShowGenerateTimesheetDetails(flag) {
            //debugger;
            $("#RMmodal").modal('hide');
            if (flag == "Generate") {
                var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvasGenerateTimeSheet'));
                myOffcanvas.show();
                $("#GTSFromDate").text($("#TxtFromDate").val());
                $("#GTSToDate").text($("#TxtToDate").val());
                $("#GTSNFromDate").text($("#TxtFromDate").val());
                $("#GTNonSFromDate").text($("#TxtFromDate").val());
                $("#GTSNToDate").text($("#TxtToDate").val());
                $("#GTNonSToDate").text($("#TxtToDate").val());

                GetTSFillNotFillResource();
                //GetAllSavingParameter();
            }
            else {
                var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_view_tasklist'));
                myOffcanvas.show();
                View_Onclick();
            }

        }

        //Added By Dipali V On 11th Oct 2023  For Get Resource Details whose not fill timesheet and fill timesheet
        function GetTSFillNotFillResource() {
            var FromDate = $("#TxtFromDate").val();
            var ToDate = $("#TxtToDate").val();

            var Parameters = {
                FromDate: FromDate,
                ToDate: ToDate,
                ProjectID: encodeURI(ProjectID)

            }
            var param = JSON.stringify(Parameters);
            var FillTSResourceDetailsHTML = "", NotFillTSResourceDetailsHTML = "", FillTSResourceVerifiedhtml = "";
            var FillTSResourceDetails = AJAXCallWithResult("/api/PM_AddTimesheet/GetTSFillNotFillResource", param, false);
            //debugger;
            var FillTSResource = FillTSResourceDetails.Table1;
            var NotFillTSResourceDetails = FillTSResourceDetails.Table3;
            var FillTSResourceVerified = FillTSResourceDetails.Table2;
            console.log(FillTSResourceVerified);
            if (FillTSResource != "") {
                for (var i = 0; i < FillTSResource.length; i++) {

                    FillTSResourceDetailsHTML += "<tr>";
                    if (FillTSResource[i].Originalfilename == null || FillTSResource[i].Originalfilename == "") {
                        FillTSResourceDetailsHTML += "<td><img src='../../../Whizible2.0-new/dist/img/profile-pic.jpg' alt='' class='img-fluid empImg mx-2'> " + FillTSResource[i].EmployeeName + "</td>";
                    } else {
                        FillTSResourceDetailsHTML += "<td><img src='" + FillTSResource[i].SystemFilename + "' alt='' class='img-fluid empImg mx-2'> " + FillTSResource[i].EmployeeName + "</td>";

                    }
                    FillTSResourceDetailsHTML += "<td> " + FillTSResource[i].FromDate + "</td>";
                    FillTSResourceDetailsHTML += "<td> " + FillTSResource[i].ToDate + "</td>";
                    FillTSResourceDetailsHTML += "<td> " + FillTSResource[i].Duration + " </td>";
                    FillTSResourceDetailsHTML += "<td> " + FillTSResource[i].Status + "</td>";
                    FillTSResourceDetailsHTML += "</tr>";
                }
                $("#tbodyTSGenerated").html(FillTSResourceDetailsHTML);
            }

            if (FillTSResourceVerified != "") {
                for (var i = 0; i < FillTSResourceVerified.length; i++) {

                    FillTSResourceVerifiedhtml += "<tr>";
                    //FillTSResourceVerifiedhtml += "<td><img src='../../../Whizible2.0-new/dist/img/profile-pic.jpg' alt='' class='img-fluid empImg mx-2'> " + FillTSResourceVerified[i].EmployeeName + "</td>";
                    if (FillTSResourceVerified[i].Originalfilename == null || FillTSResourceVerified[i].Originalfilename == "") {
                        FillTSResourceVerifiedhtml += "<td><img src='../../../Whizible2.0-new/dist/img/profile-pic.jpg' alt='' class='img-fluid empImg mx-2'> " + FillTSResourceVerified[i].EmployeeName + "</td>";
                    } else {
                        FillTSResourceVerifiedhtml += "<td><img src='" + FillTSResourceVerified[i].SystemFilename + "' alt='' class='img-fluid empImg mx-2'> " + FillTSResourceVerified[i].EmployeeName + "</td>";

                    }
                    FillTSResourceVerifiedhtml += "<td> " + FillTSResourceVerified[i].FromDate + "</td>";
                    FillTSResourceVerifiedhtml += "<td> " + FillTSResourceVerified[i].ToDate + "</td>";
                    FillTSResourceVerifiedhtml += "<td> " + FillTSResourceVerified[i].BillableDurationHHMM + "/" + FillTSResourceVerified[i].NonBillableDurationHHMM + " </td>";
                    //FillTSResourceVerifiedhtml += "<td> " + FillTSResourceVerified[i].Status + "</td>";
                    // FillTSResourceVerifiedhtml += "</tr>";

                }
                $("#tbodyTSVerifiedGenerated").html(FillTSResourceVerifiedhtml);
            }



            if (NotFillTSResourceDetails != "") {
                for (var i = 0; i < NotFillTSResourceDetails.length; i++) {
                    if (NotFillTSResourceDetails[i].Originalfilename == null || NotFillTSResourceDetails[i].Originalfilename == "") {
                        NotFillTSResourceDetailsHTML += "<td><img src='../../../Whizible2.0-new/dist/img/profile-pic.jpg' alt='' class='img-fluid empImg mx-2'> " + NotFillTSResourceDetails[i].EmployeeName + "</td>";
                    } else {
                        NotFillTSResourceDetailsHTML += "<td><img src='" + NotFillTSResourceDetails[i].SystemFilename + "' alt='' class='img-fluid empImg mx-2'> " + NotFillTSResourceDetails[i].EmployeeName + "</td>";

                    }
                    // NotFillTSResourceDetailsHTML += " <li><img src='../../../Whizible2.0-new/dist/img/profile-pic.jpg' alt='' class='img-fluid empImg mx-2'>" + NotFillTSResourceDetails[i].EmployeeName +"</li>";
                }
                $("#EmpNoTSNamesList").html(NotFillTSResourceDetailsHTML);
            }
        }


        //Added By Dipali V On 4th Oct 2023  For View Task List
        function View_Onclick() {
            var FromDate = $("#TxtFromDate").val();
            var ToDate = $("#TxtToDate").val();
            var RateMethod = $("#cboRateMethod").val();

            $(".project_todate").text($("#TxtToDate").val());
            $(".project_fromdate").text($("#TxtFromDate").val());

            var Parameters = {
                FromDate: FromDate,
                ToDate: ToDate,
                RateMethod: encodeURI(RateMethod),
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameters);
            var EmployeeName = "", EmployeeCode = "", EmployeeID = "";
            var ResourceTotal = "";
            var EntryDate = "";
            var ResourceTotalHHMM = "";
            var ProjectTimesheetDetails = "";
            var StrResult = AJAXCallWithResult("/api/PM_AddTimesheet/ViewTaskList", param, false);
            if (StrResult != "") {
                for (var i = 0; i < StrResult.length; i++) {
                    if (StrResult[i].Description.length > 30) {
                        Description = StrResult[i].Description.slice(0, 30) + "...";
                    } else {
                        Description = StrResult[i].Description;
                    }

                    if (EmployeeName == "") {
                        ProjectTimesheetDetails += '<tr>';
                        ProjectTimesheetDetails += '<td colspan="4" class="text-start">';
                        ProjectTimesheetDetails += '<span class="float-start"><strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></span>';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '</tr>';
                        ProjectTimesheetDetails += '<tr class="" id="task2Edit">';
                        ProjectTimesheetDetails += '<td class=""></td>';
                        // ProjectTimesheetDetails += '<td class="">' + StrResult[i].EntryDate + '</td>';
                        if (EntryDate != StrResult[i].EntryDate) {
                            ProjectTimesheetDetails += '<td class="">' + StrResult[i].EntryDate + '</td>';
                        }
                        else {
                            ProjectTimesheetDetails += "<td></td>";
                        }
                        ProjectTimesheetDetails += '<td class="text-start" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + StrResult[i].Description + '">' + Description + '</td>';
                        ProjectTimesheetDetails += '<td class="">' + StrResult[i].Task + '</td>';
                        ProjectTimesheetDetails += '<td>' + StrResult[i].Duration + '</td></tr>';

                        if (i == StrResult.length - 1) { // Only On Resource TS Generated for one Day
                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end">Total Actual Work (HH:MM) for <strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></td>';
                            ProjectTimesheetDetails += '<td class="pl-20"><strong>' + StrResult[i].ResourceTotalHHMM + '</strong></td>';
                            ProjectTimesheetDetails += '</tr>';

                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end"><strong>Grand Total</strong></td>';
                            ProjectTimesheetDetails += '<td class="pl-20 text-center"><strong>' + StrResult[i].GrandTotalHHMM + '</strong></td>';
                            ProjectTimesheetDetails += '</tr>';
                        }
                    }
                    else if (EmployeeName == StrResult[i].EmployeeName) {
                        ProjectTimesheetDetails += '<tr class="" id="task2Edit">';
                        ProjectTimesheetDetails += '<td class=""></td>';
                        if (EntryDate != StrResult[i].EntryDate) {
                            ProjectTimesheetDetails += '<td class="">' + StrResult[i].EntryDate + '</td>';
                        }
                        else {
                            ProjectTimesheetDetails += "<td></td>";
                        }
                        ProjectTimesheetDetails += '<td class="text-start" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + StrResult[i].Description + '">' + Description + '</td>';
                        ProjectTimesheetDetails += '<td class="">' + StrResult[i].Task + '</td>';
                        ProjectTimesheetDetails += '<td>' + StrResult[i].Duration + '</td></tr>';
                        if (i == StrResult.length - 1) {
                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end">Total Actual Work (HH:MM) for <strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></td>';
                            ProjectTimesheetDetails += '<td class="pl-20"><strong>' + StrResult[i].ResourceTotalHHMM + '</strong></td>';
                            ProjectTimesheetDetails += '</tr>';

                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end"><strong>Grand Total</strong></td>';
                            ProjectTimesheetDetails += '<td class="pl-20 text-center"><strong>' + StrResult[i].GrandTotalHHMM + '</strong></td>';
                            ProjectTimesheetDetails += '</tr>';
                        }
                    }
                    else if (EmployeeName != StrResult[i].EmployeeName) {
                        ProjectTimesheetDetails += '<tr class="total-row">';
                        ProjectTimesheetDetails += '<td colspan="4" class="text-end">Total Actual Work (HH:MM) for <strong>[' + EmployeeCode + '] - ' + EmployeeName + '</strong></td>';
                        ProjectTimesheetDetails += '<td class="pl-20"><strong>' + ResourceTotalHHMM + '</strong></td>';
                        ProjectTimesheetDetails += '</tr>';
                        ProjectTimesheetDetails += '<tr>';
                        ProjectTimesheetDetails += '<td colspan="4" class="text-start">';
                        ProjectTimesheetDetails += '<span class="float-start"><strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></span>';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '</tr>';
                        ProjectTimesheetDetails += '<tr class="" id="task2Edit">';
                        ProjectTimesheetDetails += '<td class=""></td>';
                        // ProjectTimesheetDetails += '<td class="">' + StrResult[i].EntryDate + '</td>';
                        if (EntryDate != StrResult[i].EntryDate) {
                            ProjectTimesheetDetails += '<td class="">' + StrResult[i].EntryDate + '</td>';
                        }
                        else {
                            ProjectTimesheetDetails += "<td></td>";
                        }
                        ProjectTimesheetDetails += '<td class="text-start" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + StrResult[i].Description + '">' + Description + '</td>';
                        ProjectTimesheetDetails += '<td class="">' + StrResult[i].Task + '</td>';
                        ProjectTimesheetDetails += '<td>' + StrResult[i].Duration + '</td></tr>';
                    }
                    EmployeeName = StrResult[i].EmployeeName;
                    EmployeeCode = StrResult[i].EmployeeCode;
                    EmployeeID = StrResult[i].EmployeeID;
                    ResourceTotalHHMM = StrResult[i].ResourceTotalHHMM;
                    ResourceTotal = StrResult[i].ResourceTotal;
                    EntryDate = StrResult[i].EntryDate;
                }

            }
            $("#tbodyViewTaskList").html(ProjectTimesheetDetails);

        }

        //Added By Dipali V On 4th Oct 2023  For Navigate to Project List Page.
        function Back_Onclick() {
            window.location.href = "../PM/PM_ProjectTimesheetlist.aspx?MasterTagId=36081&ProjectID=" + ProjectID + "";

        }


        //Added By Dipali V On 10th Oct 2023  For Site Calender
      
        var CMonth, CYear;
        var PMonth, PYear;
        var NMonth, NYear;
        var WeekDays, StartingDayOfWeek;
        var ExtraHoursCap, WorkHrs;
        var selecteddate;
        var Month, TodaysDate;
        var TodaysDate_Cur = "";
        var ProjectSiteID = "";
        var StrMonthName;
        var GStrMonthName;
        var intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours
        function ShowSiteCalender() {
            //debugger;
            GetProjectSites();
            var date = new Date();
            selecteddate = date;
            TodaysDate = selecteddate.toShortFormat().split(" ")
            TodaysDate_Cur = TodaysDate[0];
            Month = date.getMonth() + 1;
            Year = date.getFullYear();
            StrMonthName = GetMonthName(Month);
            GStrMonthName = StrMonthName;
            $("#selectDefaultSite").val(IsOffShoreSiteID);
            $(".selectpicker").selectpicker('refresh');
            if ($("#selectDefaultSite").val() != "0") {
                ProjectSiteID = $("#selectDefaultSite").val();
            } else {
                ProjectSiteID = IsOffShoreSiteID;
                
            }

           
            initializeSiteCalenderDetails(Month, Year,ProjectSiteID);
            strProjectName = $('#SpanProjectName').text();
            GenerateCalendarTable(Month, Year, ProjectID, intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours);
            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_site_calender'));
            myOffcanvas.show();

        }
        //Added By Dipali V On 20th Sep 2023 For Plotting Site Calender with rexpective Site 
        function Site_Onchange() {
            //debugger;
            intTotalWeekEnds = "";
            StartingDayOfWeek = "";
            m_strWeekEnds = "";
            holidaysLists = "";
            normaldaysLists = "";
            if ($("#selectDefaultSite").val() != "0") {
                ProjectSiteID = $("#selectDefaultSite").val();
            } else {
                ProjectSiteID = IsOffShoreSiteID;
            }
            initializeSiteCalenderDetails(Month, Year, ProjectSiteID);
            strProjectName = $('#SpanProjectName').text();
            GenerateCalendarTable(Month, Year, ProjectID, intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours);

        }
        //Added By Dipali V On 20th Sep 2023 For Pre & Next Site Calendar
        var Fromwhere = "";
        function PreNextMonth_Onclick(Fromwhere) {
            intTotalWeekEnds = "";
            StartingDayOfWeek = "";
            m_strWeekEnds = "";
            holidaysLists = "";
            normaldaysLists = "";
            if (Fromwhere == 'Pre') {
                if (Month != 1) {
                    Year = Year;
                } else {
                    Month = 12;
                    Year = Year - 1;
                }
                Month = Month - 1;
                StrMonthName = GetMonthName(Month);
                GStrMonthName = StrMonthName;//Added By Dipali V On 26th Dec 2023 Get Selected Month Name
                if ($("#selectDefaultSite").val() != "0") {
                    ProjectSiteID = $("#selectDefaultSite").val();
                } else {
                    ProjectSiteID = IsOffShoreSiteID;
                }
                initializeSiteCalenderDetails(Month, Year, ProjectSiteID);
                strProjectName = $('#SpanProjectName').text();
                GenerateCalendarTable(Month, Year, ProjectID, intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours);
            }
            else {
               
                if (Month != 12) {
                    Year = Year;
                    
                } else {
                    Month = 0;
                    Year = Year + 1;
                }
                Month = Month + 1;
                StrMonthName = GetMonthName(Month);
                GStrMonthName = StrMonthName;//Added By Dipali V On 26th Dec 2023 Get Selected Month Name
                if ($("#selectDefaultSite").val() != "0") {
                    ProjectSiteID = $("#selectDefaultSite").val();
                } else {
                    ProjectSiteID = IsOffShoreSiteID;
                }
                initializeSiteCalenderDetails(Month, Year, ProjectSiteID);
                strProjectName = $('#SpanProjectName').text();
                GenerateCalendarTable(Month, Year, ProjectID, intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours);


            }
        }
         //End of Added By Dipali V On 20th Sep 2023 For Pre & Next Site Calendar

         //Added By Dipali V On 20th Sep 2023 For Get Calender Date wise details
        function SiteCalendarDetails(Month, Date, Year, Isholiday, NormalHours, ExtraHours) {
            if (Isholiday == 1) {
                $("#scdcheck1").prop("checked", true);
                $("#NormalHours").val(0);
                $("#ExtraHours").val(0);
            } else {
                $("#scdcheck1").prop("checked", false);
                $("#NormalHours").val(NormalHours);
                $("#ExtraHours").val(ExtraHours);
            }
            $("#SelectedDate").text(Date + "-" + Month + "-" + Year);
            $('#SCDetailsModal').modal('show');
        }
         //End of Added By Dipali V On 20th Sep 2023 For Get Calender Date wise details

         //Added By Dipali V On 20th Sep 2023 For Get Month Name
        var strMonthName = "";
        function GetMonthName(MonthIndex) {
            
            if (MonthIndex == 1) {
                strMonthName = "Jan";
            } else if (MonthIndex == 2) {
                strMonthName = "Feb";
            }
            else if (MonthIndex == 3) {
                strMonthName = "Mar";
            }
            else if (MonthIndex == 4) {
                strMonthName = "Apr"
            }
            else if (MonthIndex == 5) {
                strMonthName = "May"
            }
            else if (MonthIndex == 6) {
                strMonthName = "Jun "
            }
            else if (MonthIndex == 7) {
                strMonthName = "Jul "
            }
            else if (MonthIndex == 8) {
                strMonthName = "Aug"
            }
            else if (MonthIndex == 9) {
                strMonthName = "Sep"
            }
            else if (MonthIndex == 10) {
                strMonthName = "Oct"
            }
            else if (MonthIndex == 11) {
                strMonthName = "Nov"
            }
            else if (MonthIndex == 12) {
                strMonthName = "Dec"
            }
            return strMonthName;
        }
        //End of Added By Dipali V On 20th Sep 2023 For Get Month Name

        //Added By Dipali V On 20th Sep 2023 For Get Pre Month Name
        function GetPrevisousMonthName() {
            return GetMonthName(Month - 1)
        }
        //Added By Dipali V On 20th Sep 2023 For Get Next Month Name
        function GetNextMonthName() {
            return GetMonthName(Month + 1)
        }

        //Added By Dipali V On 20th Sep 2023 For Plotting Site Calender
        // Site Calendar script start here
        var arrWeekDays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
        var TodayDateClass = "";
        function GenerateCalendarTable(intMonth, intYear, intProjectID, intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours) {
          
            var strTable;
            var intDay;
            var days;
            var firstDay;
            var startDay;
            var column;
            var intLastMonthDay;
            var intCount;
            var strDate;
            var intYear1;
            var intNextMonth;
            var lastMonth;
            var intNextDay;
            var strFileName;
            //apply class for table added by pradip on 21-4-2021
            strTable = "<table class='SCtbl' cellSpacing=1 cellPadding=0 height = 85% width=99.9% border=0 style=border:1 solid #dddddd>";
            strTable = strTable + "<tbody>";
            strTable = strTable + " <tr class=clsTRSectionHeader>";


            strTable = strTable + " <td align=center colspan=7 >";

            strTable = strTable + " <button type=button class=prev Onclick=PreNextMonth_Onclick('Pre')>&lt;</button>";
            strTable = strTable + " Site Calendar for Month - " + " " + "" + " " + StrMonthName
            strTable = strTable + " &nbsp;";
            strTable = strTable + intYear;
            strTable = strTable + " <button type=button class=next Onclick=PreNextMonth_Onclick('Next')>&gt;</button>";


            strTable = strTable + " </td>";

            strTable = strTable + " </tr>";
            // strTable = strTable + " <tr height=22><td colspan=7></td></tr>";
            // strTable = strTable + " <tr class=clsTRColumnHeader height = 100%>";


            strTable = strTable + " ";

            for (intDay = 0; intDay < 7; intDay++) {
                strTable = strTable + " <td class='dayname'> ";
                strTable = strTable + arrWeekDays[intDay];
                strTable = strTable + " </td>";
                strTable = strTable + " ";
            }
            strTable = strTable + "</tr>";

            strTable = strTable + "<tr class='clsTREven'> ";
            strTable = strTable + " ";


            days = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
            var firstDay = new Date(intYear, intMonth - 1, 1);

            startDay = firstDay.getDay();
            column = 0;
            lastMonth = intMonth - 1;
            if (lastMonth == 0) {
                lastMonth = 12;
            }
            intLastMonthDay = days[lastMonth] - (startDay - 2) - 1;


            //display previous month days

            for (intCount = 1; intCount <= (startDay); intCount++) {

                strTable = strTable + " ";
                if (intCount == 1) {
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 12pt; background:#F0F0F0 border:1 solid #dddddd>";
                    strTable = strTable + GetPrevisousMonthName();
                    strTable = strTable + "&nbsp;&nbsp;&nbsp; ";
                    strTable = strTable + intLastMonthDay;
                    strTable = strTable + " </td>";
                    strTable = strTable + " ";
                }
                else {
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 12pt; background:#F0F0F0 border:1 solid #dddddd>";
                    strTable = strTable + intLastMonthDay;
                    strTable = strTable + " </td>";
                    strTable = strTable + " ";
                }

                strTable = strTable + " ";
                column = column + 1;
                strTable = strTable + " ";
                intLastMonthDay = intLastMonthDay + 1;
                strTable = strTable + " ";
            }

            var weekends;
            var holidays;
            var normaldays;
            weekends = m_strWeekEnds;
            holidays = "," + holidaysLists + ",";
            normaldays = ","+ normaldaysLists + ",";
            //alert(weekends);
            //alert(holidays);
            //alert(normaldays);
            //alert(startDay);
            //Display current month details 
            strTable = strTable + " ";
            intDay = 1;

            for (intCount = startDay; intCount < 7; intCount++) {
                strTable = strTable + " ";
                //debugger;
                //strDate = new Date(intYear, intMonth, intDay)
                strDate = new Date(intYear, intMonth - 1, intDay);
                //dhn
                //alert(strDate);
                strTable = strTable + " ";

                //if (intCount==0 || intCount==6)
                if (weekends.lastIndexOf(column) != -1) {
                    if (TodaysDate_Cur != "") {
                        //debugger;
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 14px; background:red bgcolor=#1359ac class=clsTRSectionWeekend " + TodayDateClass +">";//
                    strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)' style='color:#38385c;'> " + intDay + "</A>";
                    strTable = strTable + "</td>";
                    strTable = strTable + " ";
                }
                // added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
                //-------------------------------------------------------
                //Added by SavitaS for Bristlecone IssueID 2355 on 13 June 2006
                else if (holidays.lastIndexOf("," + intDay + ",") != -1) {
                    if (TodaysDate_Cur != "") {
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt;background:red bgcolor=#dbeaf5 class=lgdHoliday " + TodayDateClass +">";
                    strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)'> <font color='#F00'>" + intDay + "</font></A>";
                    strTable = strTable + "</td>";
                    strTable = strTable + " ";
                }
                //End by SavitaS
                //------------------------------------------------------- 
                // end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
                else {
                    //debugger;
                    var strColor = "";
                    if (normaldays.lastIndexOf("," + intDay + ",") != -1)
                        strColor = "";

                    if (TodaysDate_Cur != "") {
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 14pt; " + strColor + " class= " + TodayDateClass +">";
                    strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0,&quot;" + WorkHrs + "&quot;,&quot;" + ExtraHoursCap + "&quot;)'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
                    strTable = strTable + "</td>";
                    strTable = strTable + " ";
                }

                strTable = strTable + " ";
                column = column + 1;
                strTable = strTable + " ";
                intDay = intDay + 1;
                strTable = strTable + " ";
            }

            strTable = strTable + " <tr class=clsTREven>";
            strTable = strTable + " ";
            column = 0;
            strTable = strTable + " ";
            intYear1 = intYear;
            strTable = strTable + " ";


            if ((((intYear1 % 4) == 0) && ((intYear1 % 100) != 0)) || ((intYear1 % 400) == 0)) {
                days[2] = 29;
            }
            else {
                days[2] = 28;
            }
            strTable = strTable + " ";


            for (intCount = intDay; intCount <= days[intMonth]; intCount++) {
                strTable = strTable + " ";
                //dhn
                //strDate = new Date(intYear, intMonth, intDay);
                strDate = new Date(intYear, intMonth - 1, intDay);
                //dhn
                strTable = strTable + " ";

                //if(column==0 || column==6 || intDay==15)

                
                if (weekends.lastIndexOf(column) != -1 || holidays.lastIndexOf(intDay) != -1 || normaldays.lastIndexOf(intDay) != -1) {
                    if (weekends.lastIndexOf(column) != -1) {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 14px;background:red bgcolor=#1359ac class=clsTRSectionWeekend " + TodayDateClass +">";//
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)' style='color:#38385c;'> " + intDay + "</A>";
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    else if (holidays.lastIndexOf("," + intDay + ",") != -1) {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 12pt;background:red bgcolor=#dbeaf5 class=lgdHoliday " + TodayDateClass +">";
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)'> <font color='#F00'>" + intDay + "</font></A>";
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    //Added by DipaliS 8 Oct 2004

                    else if (normaldays.lastIndexOf("," + intDay + ",") != -1) {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt;background:red class=" + TodayDateClass +">";
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0,&quot;" + WorkHrs + "&quot;,&quot;" + ExtraHoursCap + "&quot;)'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    else {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt; class=" + TodayDateClass +">";
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0,&quot;" + WorkHrs + "&quot;,&quot;" + ExtraHoursCap + "&quot;)'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                }
                else {
                    if (TodaysDate_Cur !="") {
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate[1]) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt; class=" + TodayDateClass +">";
                    strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0,&quot;" + WorkHrs + "&quot;,&quot;" + ExtraHoursCap + "&quot;)'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
                    strTable = strTable + "</td>";
                    strTable = strTable + " ";
                }

                strTable = strTable + " ";
                column = column + 1;
                intDay = intDay + 1;
                if (column == 7) {
                    strTable = strTable + " </tr>";
                    strTable = strTable + " <tr class=clsTREven>";
                    strTable = strTable + " ";
                    column = 0;
                }
            }
            //'Display next month days 
            intNextMonth = intMonth + 1;
            if (intNextMonth == 13) {
                intNextMonth = 1;
            }
            intNextDay = 1;
            if (column != 0) {
                for (intCount = column; intCount <= 6; intCount++) {
                    strTable = strTable + " ";
                    if (intNextDay == 1) {
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #dddddd>";
                        strTable = strTable + GetNextMonthName();
                        strTable = strTable + "&nbsp;&nbsp;&nbsp;";
                        strTable = strTable + intNextDay;
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    else {
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #dddddd>";
                        strTable = strTable + intNextDay;
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    strTable = strTable + " ";
                    intDay = intDay + 1;
                    intNextDay = intNextDay + 1;
                }
                strTable = strTable + " ";
            }

            strTable = strTable + "</tbody>";
            strTable = strTable + "</table>";

            $("#tdSchedule").html(strTable);
            $('[data-bs-toggle="tooltip"]').tooltip()
        }
        // Site Calendar script end here
        //End of Added By Dipali V On 20th Sep 2023 For Plotting Site Calender


        //Remove Duplicate From Array 
        function unique(array) {
            return array.filter(function (el, index, arr) {
                return index == arr.indexOf(el);
            });
        }

     

        //Added By Dipali V For Site Calendar
        var intTotalWeekEnds = "";
        var StartingDayOfWeek = "";
        var m_strWeekEnds="";
        var holidaysLists= "";
        var normaldaysLists = "";
        function GetProjectSiteCalenderDetails(Month, Year, ProjectSiteID, m_strFromTimeSheet, TimesheetNo) {
         
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                ProjectSiteID: encodeURI(ProjectSiteID),
                Year: encodeURI(Year),
                Month: encodeURI(Month),
                TimesheetNo: encodeURI(TimesheetNo),
                m_strFromTimeSheet: encodeURI(m_strFromTimeSheet)

            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectSiteCalenderDetails", param, false);
            if (Result != "") {
                GetOULevelHolidays = Result;
            }
            return Result;
        }

          //Added By Dipali V For initialize Site Calendar
        function initializeSiteCalenderDetails(Month, Year, ProjectSiteID, Flag) {
            var m_strFromTimeSheet = "1";
            var TimesheetNo = 0;
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                ProjectSiteID: encodeURI(ProjectSiteID),
                Year: encodeURI(Year),
                Month: encodeURI(Month),
                TimesheetNo: encodeURI(TimesheetNo),
                m_strFromTimeSheet: encodeURI(m_strFromTimeSheet)

            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectSiteCalDetails", param, false);
            if (Result != "") {
                //debugger;
                var GetProjectSiteCalendar_Day = Result.SiteCalenderList;
                //var GetOULevelHolidays = Result.SiteOULevelHolidaysList;
                var NormalDayslist = "", Holidayslist = "";
                var GetOULevelHolidays = GetProjectSiteCalenderDetails(Month, Year, ProjectSiteID, m_strFromTimeSheet, TimesheetNo)
                if (GetOULevelHolidays != "") {
                    GetOULevelHolidays = GetOULevelHolidays.split("&&&&");
                    Holidayslist = GetOULevelHolidays[0];
                    NormalDayslist = GetOULevelHolidays[1];
                }
                var GetStartingDayOfWeek_WeekDays = Result.StartingDayOfWeek;
                if (GetStartingDayOfWeek_WeekDays != "") {
                    StartingDayOfWeek = GetStartingDayOfWeek_WeekDays[0].StartingWeek;
                    ExtraHoursCap = GetStartingDayOfWeek_WeekDays[0].ExtraHoursCap;
                    WeekDays = GetStartingDayOfWeek_WeekDays[0].WeekDays;
                    WorkHrs = GetStartingDayOfWeek_WeekDays[0].WorkHrs;
                }
            }

            //debugger;
            intTotalWeekEnds = 7 - WeekDays;
            if (intTotalWeekEnds != 0) {
                for (var i = 1; i <= intTotalWeekEnds; i++) {
                    if ((StartingDayOfWeek - i) < 0) {
                        m_strWeekEnds = m_strWeekEnds + (7 + (StartingDayOfWeek - i)) + ",";
                    } else {
                        m_strWeekEnds = m_strWeekEnds + (StartingDayOfWeek - i) + ","
                    }
                }
            }
            //debugger;
            if (m_strWeekEnds != "") {
                //if (m_strWeekEnds.indexOf(",") > -1)
                //{
                //   m_strWeekEnds = m_strWeekEnds.replace(/,*$/, '');
                //}
                if (m_strWeekEnds.indexOf(',', m_strWeekEnds.length - ','.length) !== -1) {
                    m_strWeekEnds = m_strWeekEnds.substring(0, m_strWeekEnds.length - 1)
                }
            }

            if (Holidayslist != "") {
                if (Holidayslist.indexOf(',', Holidayslist.length - ','.length) !== -1) {
                    holidaysLists = Holidayslist.substring(0, Holidayslist.length - 1)
                }
            }

            if (NormalDayslist != "") {
                if (NormalDayslist.indexOf(',', NormalDayslist.length - ','.length) !== -1) {
                    normaldaysLists = NormalDayslist.substring(0, NormalDayslist.length - 1)
                }
            }

      
        }

    
        //End of Added By Dipali V On 10th Oct 2023  For Site Calender



        //Added By Dipali V On 10th Oct 2023  For Project Site
        var IsOffShoreSiteID = 0;
        function GetProjectSites() {
            var Parameters = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectSites", param, false);
            //debugger;
            if (strResult.length > 0) {
                $("#selectDefaultSite option").empty();
                var objCbo1 = document.getElementById("selectDefaultSite");
                $("#selectDefaultSite option").remove();
                for (var i = 0; i < strResult.length; i++) {
                    if (strResult[i].IsOffshore == 1) {
                        IsOffShoreSiteID = strResult[i].ProjectSiteID;
                    }
                    var ObjData = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjData.Name;
                    objOption.value = ObjData.ProjectSiteID;

                }
            }
            $(".selectpicker").selectpicker('refresh');
            // alert(IsOffShoreSiteID);
        }
        //End of Added By Dipali V On 10th Oct 2023  For Project Site


        //Added By Dipali V On 4th Oct 2023  For Get All Parameter For Saving
        function ViewTask_Onclick() {
            NoData = ShowMessagesForNodata();
            if (ValidateGenerateTimesheet() == true) {
                if (NoData == 1) {
                    ShowNotificationAlert('Task');
                } else {

                    alertify.error("<%= MyBase.GetResourceString("C_NoTask") %> ");
                    return;
                }
            }
        }

        //Added By Dipali V On 4th Oct 2023  For Get All Parameter For Saving
        function GetAllSavingParameter() {
            //debugger;
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
            if (Discount == '') {
                Discount = "0";
            }
            if (BufferPercentage == '') {
                BufferPercentage = "0";
            }
            if (InvoiceDate == '') {
                InvoiceDate = "0";
            }
            if (EffortToConsider == '') {
                EffortToConsider = "0"
            } else {
                EffortToConsider = ConvertDecimalToHourViceVersa(EffortToConsider, 2);
            }
            if (OnsiteFull == '') {
                OnsiteFull = "0"
            }

            else if (OnsiteFull == false) {
                OnsiteFull = 0;
            }
            else if (OnsiteFull == true) {
                OnsiteFull = 1;
            }

            if (ActualDayBilling == null || ActualDayBilling == '') {
                ActualDayBilling = "0"
            }


            if (FixedMonthlyRate == null || FixedMonthlyRate == '') {
                FixedMonthlyRate = "0"
            }

            var SiteValidation = $("#cboSiteValidation").val();
            if (SiteValidation == "Yes") {
                SiteValidation = 1;
            }
            else {
                SiteValidation = 0;
            }
           // debugger;
            var CapConsider = $("#cboCapConsider").val();
            if (CapConsider == "Yes") {
                CapConsider = 1;
            }
            else {
                CapConsider = 0;
            }

            if ($("#cboCapConsider").val() == "Yes")
            {
                var FullCapHoliday = $("#cboCapHoliday").val();
                if (FullCapHoliday == "Yes")
                {
                    FullCapHoliday = 1;
                }
                else {
                    FullCapHoliday = 0;
                }
            } else {
                FullCapHoliday = 0;
            }


            var Parameters = {
                FromDate: FromDate,
                ToDate: ToDate,
                RateMethod: encodeURI(RateMethod),
                OUWorkingDays: encodeURI(OUWorkingDays),
                WorkingHrsPerDay: encodeURI(WorkingHrsPerDay),
                BufferPercentage: encodeURI(BufferPercentage),
                MonthlyHr: encodeURI(MonthlyHr),
                Discount: encodeURI(Discount),
                ActualDayBilling: encodeURI(ActualDayBilling),
                EffortToConsider: encodeURI(EffortToConsider),
                FixedMonthlyRate: encodeURI(FixedMonthlyRate),
                OnsiteFull: encodeURI(OnsiteFull),
                InvoiceDate: InvoiceDate,
                ContractType: ContractTypeID,
                SiteValidation: encodeURI(SiteValidation),
                CapConsider: encodeURI(CapConsider),
                CapHoliday: encodeURI(FullCapHoliday),
                ProjectCurrency: encodeURI(CurrencyID),
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(Parameters);
            console.log(param);
            //return;
            var StrResult = AJAXCallWithResult("/api/PM_AddTimesheet/GenerateProjectTimesheet", param, false);
            if (StrResult != "") {
               // alert(StrResult);
                intTimesheetNo = StrResult;
                alertify.success("<%= MyBase.GetResourceString("C_ProjectTimesheetGenerated") %> ");
                window.location.href = "../PM/PM_ProjectTimesheetDetails.aspx?ProjectID=" + ProjectID.toString() + "&TimeSheetNo=" + intTimesheetNo.toString() + "&FromDate=" + FromDate.toString() + "&ToDate=" + ToDate.toString() + "&CurrentStatus=Generated&MasterTagID=1049&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";

            }
        }


        //Added By Dipali V On 3rd Oct 2023  For  Get Project StartDate EndDate Date
        function GetProjectStartDateEndDate(ProjectID) {
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectStartDateEndDate", param, false);
            if (result != undefined) {
                return result;
            }
        }

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

        function GetMINDAValidation() {
            var Parameters = {

            }
            var param = JSON.stringify(Parameters);
            strResult = AJAXCallWithResult("/api/PM_AddTimesheet/GetRestrictByMinHours_MinHoursForDAEntry", param, false);
            if (strResult != undefined) {
                RestrictByMinHours = strResult.RestrictByMinHours;
                MinHoursForDAEntry = strResult.MinHoursForDAEntry;
            }
        }

        //Added By Dipali V On 3rd Oct 2023 For Validation script for work hours
        function WorkHoursValidation(ControlID) {
            var objHMEffort = document.getElementById(ControlID);

            var objVal = objHMEffort.value;

            var objOldVal = objHMEffort.value;

            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                //alert(objHMEffort.value);
                var isdigit = jQuery.isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;
                if (objHMEffort.value > 24) {
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActuallessequalto24")%>');
                     setFocus(objHMEffort);
                     return false;
                 }

                if (isdigit == false) {
                    //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                    //alertify.error("Please Enter only positive numeric value For Work (hrs) in H:M format.");
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    //alertify.error("Please enter Work (hrs) in H:M format.");
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    //alertify.error("Please enter Work (hrs) in H:M format.");
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);
                    return false;
                }
                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    /*alertify.error("Please enter Work (hrs) in H:M format.");*/
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");
                //Please enter Work (hrs) in H:M format.
                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    //alertify.error("Please enter Work (hrs) in H:M format.");
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
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
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    //alertify.error("Hours should not be less than or equal to zero (0).");
                    alertify.error('<%= MyBase.GetResourceString("C_HoursZero")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    //alertify.error("Hours should not be less than or equal to zero(0).");
                    alertify.error('<%= MyBase.GetResourceString("C_HoursZero")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);
                    return false;
                }

                if (mins.length > 2) {
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    //alert("Please enter Work (hrs) in H:M format.");
                   // alertify.error("Please enter minutes in two decimal and less than 60.");
                    alertify.error('<%= MyBase.GetResourceString("C_HoursDecimal")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {
                     //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    //alertify.error("Please enter minutes between (0-59) range");
                    alertify.error('<%= MyBase.GetResourceString("C_MinVali")%>');
                     //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                    setFocus(objHMEffort);

                    return false;
                }
                //var param = JSON.stringify();
                //var strResult = AJAXCallWithResult("/api/PM_AddTimesheet/GetRestrictByMinHours_MinHoursForDAEntry", param, false);

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
                             //Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                           // alertify.error("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                            alertify.error("<%= MyBase.GetResourceString("C_MultiplicationHours")%> (" + MinDAENtryDisplay + ") min");
                             //End of Added By Dipali V On 25th Oct 2023 For Change caption with Resource file
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }

            }
            return true;
        }

        //Added By Dipali V On 3rd Oct 2023  For Validate Generate Timesheet
        function ValidateGenerateTimesheet() {
           // debugger;
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



                // if (globalcontracttype != "Fixed Fee") {
                if (ContractTypeID != 5) {
                    if (RateMethod == 'Monthly') {
                      
                        if (days > 31) {
                            alertify.error("<%= MyBase.GetResourceString("A_SelFromDateToDate") %>")
                            return false;
                        }
                       <%-- if (StrFromDate != StrToDate) {
                            alertify.error("<%= MyBase.GetResourceString("A_SelFromDateToDate") %>")
                            return false;
                        }--%>
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
                    // if (globalcontracttype != "Fixed Fee") {
                    if (ContractTypeID != 5) {
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
                    //if (globalcontracttype != "Fixed Fee") {
                    if (ContractTypeID != 5) {
                        if (RateMethodValue == "0") {
                            alertify.error("<%= MyBase.GetResourceString("A_RateMethod") %>")
                            $("#cboRateMethod").focus();
                            return false;
                        }
                    }
                    // if (globalcontracttype != "Fixed Fee") {
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


        //Added By Dipali V On 3rd Oct 2023  For Hours Converted into Decimal
        function ConvertDecimalToHourViceVersa(WorkHrs, Flag) {
            var Parameters = {
                WorkHrs: encodeURI(WorkHrs),
                Flag: encodeURI(Flag),
            }
            var param = JSON.stringify(Parameters);
            var Hours = AJAXCallWithResult("/api/PM_AddTimesheet/ConvertDecimalToHourViceVersa", param, false);
            if (Hours != undefined) {
                return Hours;
            }
        }
        //Added By Dipali V On 6th Oct 2023  For Validate Dates
        function Validatedate() {
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                InvoiceDate: $("#txtInvoiceDate").val()
            }
            var param = JSON.stringify(Parameters);
            var DateValidation = AJAXCallWithResult("/api/PM_AddTimesheet/Validatedate", param, false);
            if (DateValidation != undefined) {

                if (DateValidation != 1) {
                    $("#ValidateConversionDate").text('Currency Conversion Date is not defined, please contact to administrator.');
                    $('#generat_btn').hide();
                } else {
                    $("#ValidateConversionDate").text('');
                    $('#generat_btn').show();
                }
            }
        }

        // Added By Dipali V On 3rd Oct 2023  For Calculate Effort To Consider depending Upon Buffer % And Monthly Hours
        function calculateEffortToConsider() {
            var Buffer = $("#txtBufferPercent").val();
            //debugger;
            //var MonthlyHr = GlobalMonthlyHr;
            var MonthlyHr = ConvertDecimalToHourViceVersa($("#txtMonthlyHr").val(), 2)
            if (BufferValidation() == true) {
                if (Buffer != '') {
                    var Result = (MonthlyHr - (MonthlyHr / 100 * Buffer)).toFixed(2);
                    Result = ConvertDecimalToHourViceVersa(Result, 1);
                    $("#txtEffortToConsider").val(Result);
                } else {
                    //$("#txtEffortToConsider").val('');
                    if ($("#cboFixedMonthlyRate").val() == 'Yes') {
                        $("#txtEffortToConsider").val($("#txtMonthlyHr").val());
                    } else {
                        $("#txtEffortToConsider").val('00:00');
                    }
                }
            } else {
                return false;
            }

        }

        //Added By Dipali V On 3rd Oct 2023  For Buffer Validation
        function BufferValidation() {
            var Buffer = $("#txtBufferPercent").val();

            if (Buffer < 0 || Buffer > 100) {
                alertify.error("<%= MyBase.GetResourceString("A_BufferPercentage") %>");
                $("#txtBufferPercent").focus();
                return false;
            }
            return true;
        }

        ///Added By Dipali V On 3rd Oct 2023  For Fixed Monthly Rate OnChange
        function FixedMonthlyRateOnchange()
        {
            var FixedMonthlyRate = $("#cboFixedMonthlyRate").val();
            var RateMethod = $("#cboRateMethod option:selected").html();
            if (RateMethod == "Monthly") {
                if (FixedMonthlyRate == 'Yes') {
                    $("#txtBufferPercent").prop("disabled", false);
                    $("#cboOnSiteFull").prop("disabled", false);
                    $("#txtMonthlyHr").prop("disabled", true);
                    //$("#cboActualDayBilling").prop("disabled", true);
                    $("#cboFixedMonthlyRate").prop("disabled", false);
                    $("#cboActualDayBilling").val('No');
                    if ($("#cboFixedMonthlyRate").val() == 'Yes') {
                        $("#txtEffortToConsider").val($("#txtMonthlyHr").val());
                    } else {
                        $("#txtEffortToConsider").val('00:00');
                    }
                    $(".selectpicker").selectpicker('refresh');

                }
                else if (FixedMonthlyRate == 'No') {
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboActualDayBilling").prop("disabled", false);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#txtBufferPercent").val('');
                    //$("#txtEffortToConsider").val('00:00');
                    $("#txtEffortToConsider").val('00:00');
                    $("#cboOnSiteFull").val('');
                    $("#cboActualDayBilling").val('Yes');
                    $("#cboActualDayBilling").prop("disabled", false);
                    //$("#cboFixedMonthlyRate").prop("disabled", true);
                    $("#cboActualDayBilling").val('Yes');
                    $(".selectpicker").selectpicker('refresh');
                }
                else if (FixedMonthlyRate == 'NA') {
                    $("#txtBufferPercent").prop("disabled", true);
                    $("#cboOnSiteFull").prop("disabled", true);
                    $("#cboActualDayBilling").prop("disabled", true);
                    $("#txtMonthlyHr").prop("disabled", true);
                    $("#txtBufferPercent").val('');
                    // $("#txtEffortToConsider").val('00:00');
                    $("#txtEffortToConsider").val('00:00');
                    $("#cboOnSiteFull").val('');
                    $(".selectpicker").selectpicker('refresh');
                }

            }
            $(".selectpicker").selectpicker('refresh');
           
        }

        //Added By Dipali V On 3rd Oct 2023 For Ajax Call 
        function StartLoader(bodyID) {
            var progress2 = new LoadingOverlayProgress({
                bar: {
                    "background": "#ddd",
                    "top": "50px",
                    "height": "30px",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
                },

            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }

        //Added By Dipali V On 3rd Oct 2023 For Ajax Call 
        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {

            });

        }

        //Added By Dipali V On 3rd Oct 2023 For Allow only Integer value
        function isOnlyNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        //Added By Dipali V On 3rd Oct 2023 For  only restrict Alphabets 
        function restrictAlphabets(e) {

            var x = e.which || e.keycode;

            if ((x >= 48 && x <= 57) || x == 8 || (x >= 35 && x <= 40) || x == 46 || x == 58) {
                return true;
            }
            else {
                return false;
            }
        }

        //Added By Dipali V On 3rd Oct 2023 For Ajax Call 
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

        //Added By Dipali V On 3rd Oct 2023 For Apply Tooltip
        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip()
        })
        //End of Added By Dipali V On 3rd Oct 2023 For Apply Tooltip

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
            $('#TxtFromDate, #TxtToDate, #txtInvoiceDate, #view_tasklist_fromDate, #view_tasklist_toDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy'
            });
        });


        // tbody height
        function resizeSection() {
            var listviewTreeHeight = $(window).height();
            $('.init_grid_panel').css({
                'height': listviewTreeHeight - 250,
                "overflow-y": "auto",
                "overflow-x": "auto"
            });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
        //                                //end script


        function CapHolidayChange() {
            //debugger;
            var CapHoliday = $("#cboCapHoliday").val();
            if (CapHoliday == "Yes" && $("#cboCapConsider").val() == "No")
            {
                $("#cboCapHoliday").val("No");
            }
            $(".selectpicker").selectpicker('refresh');
        }

        function CapConsiderChange() {
            //debugger;
            var cboCapConsider = $("#cboCapConsider").val();
            if (cboCapConsider == "No" && $("#cboCapHoliday").val() == "Yes") {
                $("#cboCapHoliday").val("No");
            }
            $(".selectpicker").selectpicker('refresh');
        }
        
    </script>


</body>


</html>
