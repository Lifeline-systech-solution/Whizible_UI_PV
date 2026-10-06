<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectTimesheetDetails.aspx.vb" Inherits="Whizible.PM_ProjectTimesheetDetails" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_PageCaption")%></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/calendar-gc.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=0.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=0.2">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
</head>

    <style type="text/css">
        .text_size {
            font-size: 11px !important;
            color: red;
        }

        .text_bg {
            color: #4263c1;
            font-size: 11px !important;
        }

        .gc-calendar table.calendar td {
            text-align: center;
        }

        .gc-calendar table.calendar th {
            text-align: center;
        }

        #pnlStyleContainer > table > thead > tr > th {
            padding-left: 55px !important;
        }

        .accordion-button {
            background: #e7edf0 !important;
        }

        .stickytable thead {
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .form-control:focus, .form-select:focus {
            border-color: #3c8dbc;
            box-shadow: none;
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
            font-size: 14px !important;
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
            background: #f5f5f5 !important;
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

        .edit-row td.toolactionsTD, .edit-row.edit_row_open td {
            pointer-events: auto;
        }

        .edit-row.edit_row_open .no-edit {
            border: 1px solid #ddd;
            resize: auto;
            background: #ffffff;
        }

        .pglinks ul li a {
            text-align: left;
        }

        .description-inner {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 15px;
            margin: 0 0 15px;
            background: #f5f5f5;
        }

        .dropdown-menu > li > a:hover {
            background-color: #e1e3e9;
            color: #333;
            width: 100% !important;
        }

        .dropdown-menu > li > a {
            transition: 0.4s ease-in-out 0s;
            padding: 4px 16px;
            line-height: inherit;
        }

        .accordion-item {
            color: var(--bs-accordion-color);
            background: #f5f5f5;
            border: 1px solid #cfcece;
        }


        .pmtID {
            color: #4263c1;
            font-size: 16px;
        }

        .flex_row {
            margin: 15px 0 0;
            padding: 0;
            vertical-align: middle;
            display: flex;
            align-items: center;
        }

        .push {
            margin-left: auto;
        }

        .btn-group.pglinks button {
            padding: 6px 12px;
            background: #fff !important;
        }

            .btn-group.pglinks button:first-child {
                min-width: 150px;
                text-align: left;
            }

        .project_timeperiod {
            font-size: 15px;
            font-weight: 600 !important;
        }

        .offcanvas {
            width: 80% !important;
        }

        .toolactions {
            vertical-align: middle;
        }

        .toolactionsTD {
            vertical-align: middle;
        }

        .far {
            font-size: 14px !important;
        }

        .fas {
            font-size: 14px !important;
        }

        .accordion-button {
            background: #e7edf0 !important;
        }

        .icon_style {
            font-weight: 600 !important;
            color: #918b8b;
        }
        /*        .fa, .fas, .far {
            font-weight: 600 !important;
            color: #918b8b;
        }*/
        .projectID {
            font-size: 20px !important;
            color: #bc20d2;
        }

        .fa-pencil-alt {
            vertical-align: 2px;
        }

        .Total_Entry {
            text-decoration: underline;
            color: #4263c1;
            font-weight: 900;
            font-size: 17px;
        }

        .duration_hr {
            font-size: 12px;
        }

        .alertify-notifier {
            z-index: 9999;
        }

        .notebox ul li {
            list-style-type: disc;
            list-style-position: unset !important;
        }

        #TBODYEasyEdit .custom_chckbox input:checked + label:after {
            top: 1px;
            left: 10px;
        }

        .smart_note {
            font-size: 10px;
            color: red;
            animation: blinker 1s linear infinite;
            font-weight: 500;
        }

        /* @keyframes blinker {
            90% {
                opacity: 0;
            }
        }*/

        @keyframes animate-stripes {
            0% {
                background-position: 0 0;
            }

            100% {
                background-position: 60px 0;
            }
        }

        @keyframes auto-progress {
            0% {
                width: 0%;
            }

            100% {
                width: 100%;
            }
        }

        .text_bg {
            color: #4263c1;
            font-size: 11px !important;
        }

        /*.progress-bar {
    background-color: #1a1a1a;
    height: 45px;
    width: 450px;
    margin: 50px auto;
    border-radius: 5px;
    box-shadow: 0 1px 5px #000 inset, 0 1px 0 #444;
}

.stripes {
    background-size: 30px 30px;
    background-image: linear-gradient(
        135deg,
        rgba(255, 255, 255, .15) 25%,
        transparent 25%,
        transparent 50%,
        rgba(255, 255, 255, .15) 50%,
        rgba(255, 255, 255, .15) 75%,
        transparent 75%,
        transparent
    );
}

.stripes.animated {
  animation: animate-stripes 0.6s linear infinite;
}

.stripes.animated.slower {
  animation-duration: 1.75s;
}

.stripes.reverse {
  animation-direction: reverse;
}

.progress-bar-inner {
  display: block;
  height: 45px;
  width: 0%;
  background-color: #34c2e3;
  border-radius: 3px;
  box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset;
  position: relative;
  animation: auto-progress 10s infinite linear;
}
*/

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

        /*#ProjectTimesheetDetails .tooltip-inner {
           font-size: 10px;
           width:100px;
       }*/
        /*Added by Dipali V On 26th Oct 2023 For CSS for Generate CSS*/
        .OutterNoteRegenreate {
            color: red;
            font-size: 10px;
        }

        .InnerNoteRegenreate {
            color: red;
            font-size: 10px;
        }

        .Inner2NoteRegenreate {
            color: #6c5ee1;
            font-size: 10px;
        }
        /*End of Added by Dipali V On 26th Oct 2023 For CSS for Generate CSS*/
        .settingOffcanvas, .helpOffcanvas {
            --bs-offcanvas-width: 70%;
        }

        .validationLabel {
            font-weight: 500;
        }

        .toggleIconDesc {
            width: 95%;
            border: 3px solid #eee;
            border-radius: 5px;
        }

        .descTxt {
            padding: 10px;
            text-align: justify;
            border-radius: 5px;
        }

        #SelectedDate {
            font-weight: 600;
            color: #b158e9;
        }
        .progress-bar-container {
            width: 100%; 
          /*  / border-right: 1px solid #ccc; /*/
            position: relative;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-bar {
            background-color: #e7edf0;
            height: 45px;
            width: max-content;
           /* / margin: 50px auto; /*/
            border-radius: 5px;
            color: #FFF;
            font-weight: 600;
            border: 1px solid #ddd;
           /* / box-shadow: 0 1px 5px #e7edf0 inset, 0 1px 0 #444; /*/
        }
        .progress-bar-inner {
            display: block;
            height: 100%;
            width: 0%;

          background-color: #f8ff94eb;
            border-radius: 3px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset;
            position: relative;
            animation: auto-progress 20s infinite linear;
        }
        .progress-text {
            line-height: 1.3;
            width: 685px;
            margin: auto;
           /* / align-items: center; /*/
            display: flex;
            white-space: break-spaces;
           /* / flex-direction: row; /
            / flex-wrap: wrap; /
            / justify-content: flex-start; /*/
        }
    </style>
<body class="hold-transition bgwhite" id="bodyPreloader">
    <%If m_ViewAccess = True %>
    <div class="wrapper">
        <div class="bgwhite">
            <div class="graybg container-fluid pt-1 pb-2 mb-2 statckmainheader ">
                <div class="row">
                    <div class="col-sm-3 pt-2 pb-2">
                        <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_PageCaption")%></h5>
                    </div>
                    <div class="col-sm-9">
                    </div>
                </div>
            </div>
            <div class="row container-fluid ">
                <div class="pmtID float-start"><strong><%= MyBase.GetResourceString("C_TimesheetID")%> : <span class="projectID" id="SpnProjectTimesheetID"></span></strong></div>
            </div>
            <div class="container-fluid mt-3">
                <div class="float-start">
                    <%CommonFunctions.HTMLControls.DrawComboBox("select_emp", "select 1",,, "onchange='EmployeeName_onChange()' data-live-search='true' class='selectpicker'", False,, ) %>
                </div>
                <div class="d-flex justify-content-end">

                    <div class="dropdown mx-1">
                        <button class="btn btn-default dropdown-toggle mx-0 form-select" type="button" data-bs-toggle="dropdown" aria-expanded="false" id="select_action">
                            <%= MyBase.GetResourceString("C_SelectAction")%>
                        </button>
                        <ul class="dropdown-menu">
                            <%If m_EditAccess = True Then%>
                                <%If m_blnTimeSheetAuthenticated = False And  m_blnTimeSheetAuthenticated = False %>
                                    <li class="OutterNoteRegenreate ps-3"><span class="InnerNoteRegenreate">Note:-</span><span class="Inner2NoteRegenreate">'Regenerate' will undo any modifications made through 'Easy Edit' or 'Smart Edit'.</span></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions" id="easy_edit_tab"><i class="fas fa-external-link-alt mx-1 pe-2 icon_style"></i><%= MyBase.GetResourceString("C_EasyEdit")%></a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" id="update_wsr" ><i class="far fa-upload mx-1 pe-2 icon_style"></i><%= MyBase.GetResourceString("C_UpdateWSR")%> </a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" id="re_generate"><i class="fas fa-redo mx-1 pe-2 icon_style"></i><%= MyBase.GetResourceString("C_Re-Generate")%> </a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" id="send_For_approval" onclick="send_For_approval()"><i class="fas fa-share-square mx-1 pe-2 icon_style"></i><%= MyBase.GetResourceString("C_SendForApproval")%> </a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" id="generate_wsr" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Weekly_Status_report" aria-controls="offcanvas_Weekly_Status_report"><i class="fas fa-chart-line mx-1 pe-2 icon_style"></i><%= MyBase.GetResourceString("C_GenerateWSR")%> </a></li>
                                <%End If%>
                            <%End If%>
                            

                            <li><a class="dropdown-item" href="javascript:void(0);" id="site_calender" onclick="ShowSiteCalender()" data-bs-toggle="offcanvas" data-bs-target="offcanvas_sitecalendarModal" aria-controls="offcanvashistory"><i class="far fa-calendar-alt mx-1 pe-2 icon_style"></i><%= MyBase.GetResourceString("C_ViewSiteCalendar")%> </a></li>
                            <li><a class="dropdown-item" href="javascript:void(0);" id="History_tab" data-bs-toggle="offcanvas" data-bs-target="#offcanvashistory" aria-controls="offcanvashistory"><i class="fas fa-history mx-1 pe-2 icon_style"></i><%= MyBase.GetResourceString("C_ShowHistory")%> </a></li>

                        </ul>
                    </div>
                    <div class="">
                        <%If m_EditAccess = True Then%>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="select_all_wsr" onclick="wsrcheckall();" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Select All"><%= MyBase.GetResourceString("C_SelectAll")%> </a>
                        <a href="javascript:;" class="btn borderbtn" id="clear_all_wsr" onclick="wsruncheckall();" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Clear All"><%= MyBase.GetResourceString("C_ClearAll")%></a>
                        <%End If %>
                        <%If m_EditAccess = True Or m_DeleteAccess = True Then%>
                        <a href="javascript:;" class="btn borderbtn" id="delete_btn" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Delete"><%= MyBase.GetResourceString("C_Delete")%> </a>
                        <%End If %>
                        <a href="javascript:;" class="btn borderbtn" id="back_btn" onclick="back_Onclick();" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Back"><%= MyBase.GetResourceString("C_Back")%> </a>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="content pt-0">
                <div class="row mt-2 mb-2 project_timeperiod">
                    <div class="col-sm-12 ">
                        <span><%= MyBase.GetResourceString("C_ProjectTimesheet")%>  &nbsp;-&nbsp;</span>
                        <span><%= MyBase.GetResourceString("C_FromDate")%> :</span>
                        <span class="project_fromdate" id="ProjectFromdate"></span>&nbsp;&nbsp;
                        <span><%= MyBase.GetResourceString("C_ToDate")%> :</span>
                        <span class="project_todate" id="ProjectTodate"></span>
                        <span class="float-end push"><strong><%= MyBase.GetResourceString("C_Status")%> : <span class="current_status" id="ProjectTimesheetCurrentStatus"></span></strong></span>
                    </div>
                </div>


                <div class="clearfix"></div>

                <!--Easy edit Filter-->
                <div class="accordion collapse Init_acordian_panel container-fluid mb-3 mt-3" id="Edit_task_description">
                    <div class="accordion-item mx-0">
                        <div id="Adv_filter_div" class="accordion-collapse collapse show " aria-labelledby="AdvSearch_InitDetails" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <div class="row">
                                    <div class="col-sm-12 text-end">
                                        <label class="form-label ">(<font color="red">*</font> <%= MyBase.GetResourceString("C_Mandatory")%> )</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row mb-2">
                                        <div class="col-sm-12">
                                            <strong>
                                                <lable id="EachTaskDetails">
                                                </lable>
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6 ">
                                            <label class="required"><%= MyBase.GetResourceString("C_Description")%> </label>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("edit_description_filter", "edit_description_filter", "Enter Description", "form-control",,,,, 400, 100, 8000,,,,,,,, "Maxlength=500",,,,,,,,,,) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="required"><%= MyBase.GetResourceString("C_ActualWork(HH:MM)")%> </label>
                                            <%--  //Added By Dipali V On 25th Oct 2023 For Aligment Issue--%>
                                            <div class="custom_dropdown actual-wrk-menu" id="divfilter_actual_work_Text" style="display: none">
                                                <%--  //End of Added By Dipali V On 25th Oct 2023 For Aligment Issue--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("filter_actual_work_Text", "filter_actual_work_Text", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                            </div>
                                            <%--  //Added By Dipali V On 25th Oct 2023 For Aligment Issue--%>
                                            <div class="custom_dropdown actual-wrk-menu" id="divfilter_actual_work_Drop" style="display: none">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("filter_actual_work_Drop", "usp_Whizible2_sel_GetActualHours",,, " class='selectpicker' data-live-search='true'", False,, ,,, False) %>
                                            </div>
                                            <%--  //End of Added By Dipali V On 25th Oct 2023 For Aligment Issue--%>
                                        </div>
                                        <div class="col-sm-4 ">
                                        </div>
                                    </div>
                                </div>

                                <div class="text-center mt-3">
                                    <a href="javascript:;" class="btn borderbtn mr-5 mx-2" data-bs-toggle="collapse" data-bs-target="#Edit_task_description" id="closeDescBox"><span id="close_edited_des" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Close"><%= MyBase.GetResourceString("C_Close")%> </span></a>
                                    <a href="javascript:;" onclick="SaveDescription()" class="btn btnyellow" id="sv_filter"><span data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Save"><%= MyBase.GetResourceString("C_Save")%>  </span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--End Easy edit Filter-->
                <div id="tbl_Employee" class="table-responsive init_grid_panel ">
                    <table class="table table-bordered table-stripped highlight-tbl stickytable">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_EmployeeName")%></th>
                                <th style="min-width: 100px;"><%= MyBase.GetResourceString("C_Date")%></th>
                                <th class="text-start"><%= MyBase.GetResourceString("C_TaskName")%></th>
                                <th><%= MyBase.GetResourceString("C_Description")%> </th>
                                <th><%= MyBase.GetResourceString("C_ActualWork(HH:MM)")%> </th>
                                <th><%= MyBase.GetResourceString("C_WSR")%></th>
                                <th><%= MyBase.GetResourceString("C_Delete")%></th>

                            </tr>
                        </thead>
                        <tbody id="ProjectTimesheetDetails">
                        </tbody>
                    </table>
                </div>
                <!--NEW DESIGN START HERE-->
                <!--NEW DESIGN END HERE-->

            </div>
            <div class="clearfix"></div>
            <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
                <div class="offcanvas-body">
                    <div id="NOI_Details_Sec" class="NOI_Details">
                        <div class="NOI_Details_Header d-flex justify-content-between">
                            <div class="Overlay-title"></div>
                            <div class="NOI_HeaderBtns">
                            </div>
                        </div>
                        <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_TimesheetID")%> : <span id="timesheet_ID">/span></h5>
                                </div>
                                <div class="col-sm-9 text-end">
                                    <span class=" push"><strong><%= MyBase.GetResourceString("C_Status")%>  : <span id="ProjectTimesheetStatus"></span></strong></span>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2 mb-2 project_timeperiod">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("select_Update_EMP", "select 1",,, " data-live-search='true' class='selectpicker' onchange='EmployeeFilter_onchange()'", False,, ) %>
                                    </div>
                                    <div class="col-sm-5"></div>
                                    <div class="col-sm-4 text-end">
                                        <button class="btn btnyellow" id="sv_easy_edit" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Save"><%= MyBase.GetResourceString("C_Save")%></button>
                                        <a href="javascript:;" class="btn borderbtn" id="del_edit_btn" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Delete"><%= MyBase.GetResourceString("C_Delete")%></a>
                                        <button type="button" class="btn btn borderbtn closeWindowBtn closebtn text-end" id="close_edit_btn" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Close"><%= MyBase.GetResourceString("C_Close")%></button>

                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <div class="col-sm-12 mt-2">
                                        <span><%= MyBase.GetResourceString("C_ProjectTimesheet")%>  &nbsp;-&nbsp;</span>

                                        <%= MyBase.GetResourceString("C_FromDate")%>  : <span><span id="EasyEditFromdate"></span></span>&nbsp;&nbsp;
                                        <%= MyBase.GetResourceString("C_ToDate")%>  : <span><span id="EasyEditTodate"></span></span>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="NOI_Details_content">


                            <div class="tab-content detailsmenutab">
                                <div class="tab-pane active" id="BasicDetailsTab">
                                    <div class="BasicDetailsContent">
                                        <div class="accordion collapse Init_acordian_panel mb-3 mt-3 show" id="Edit_fiter_accordion">
                                            <div class="accordion-item mx-0">
                                                <h2 class="accordion-header" id="Edit_fiter_heading">
                                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#Intcollapse_Project" aria-expanded="true" aria-controls="collapseOne">
                                                        <%= MyBase.GetResourceString("C_Filter")%>
                                                    </button>
                                                </h2>
                                                <div id="Intcollapse_Project" class="accordion-collapse collapse " aria-labelledby="Edit_fiter_heading" data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <div class="form-group row mb-3">
                                                            <div class="col-sm-6 form-group required">
                                                                <label for="AddBasicDetailsCode" class="form-label text-end IM_label">
                                                                    <%=MyBase.GetResourceString("C_Role")%>
                                                                </label>

                                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboRole", "select 1",,, " data-live-search='true' class='selectpicker'", False,, ) %>
                                                            </div>
                                                            <div class="col-sm-6 form-group required">
                                                                <label for="BasicDetailsNOI" class="form-label text-end IM_label">
                                                                    <%= MyBase.GetResourceString("C_EmployeeName")%>
                                                                </label>

                                                                <%CommonFunctions.HTMLControls.DrawComboBox("CboEasyEdit", "select 1",,, " data-live-search='true' class='selectpicker'", False,, ) %>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row mb-3">
                                                            <div class="col-sm-4 form-group">
                                                                <label for="BasicDetailsRevNo" class="form-label text-end IM_label">
                                                                    <%= MyBase.GetResourceString("C_FromDate")%>
                                                                </label>
                                                                <div class="input-group datefielddiv">

                                                                    <%CommonFunctions.HTMLControls.DrawTextBox("fromDateFilter", "fromDateFilter", "form-control",,,,,,, True, "White",, "autocomplete='off' maxlength='100'",,, True,,,, True) %>

                                                                    <span class="input-group-btn">
                                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt icon_style"></i></button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-2 form-group">&nbsp;</div>
                                                            <div class="col-sm-4 form-group">
                                                                <label for="BasicDetailsRevNo" class="form-label text-end IM_label">
                                                                    <%= MyBase.GetResourceString("C_ToDate")%>
                                                                </label>
                                                                <div class="input-group datefielddiv">

                                                                    <%CommonFunctions.HTMLControls.DrawTextBox("toDateFilter", "toDateFilter", "form-control",,,,,,, True, "White",, "autocomplete='off' maxlength='100'", ,, True,,,, True) %>

                                                                    <span class="input-group-btn">
                                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt icon_style"></i></button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-2 form-group text-end mt-4 pt-0">
                                                                <label>&nbsp;</label>
                                                                <button class="btn btnyellow" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Show" onclick="ApplyFilterEasyEdit()"><%= MyBase.GetResourceString("C_show")%></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="accordion collapse Init_acordian_panel mb-3 mt-3 show" id="Edit_Note_accordion" style="display: none">
                                            <div class="accordion-item mx-0">
                                                <h2 class="accordion-header" id="Edit_fiter_heading">
                                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#Edit_Note" aria-expanded="true" aria-controls="collapseOne">
                                                        <strong><%= MyBase.GetResourceString("C_SmartEdit")%> (Bulk Update)</strong>
                                                    </button>
                                                </h2>
                                                <div id="Edit_Note" class="accordion-collapse collapse show" aria-labelledby="Edit_fiter_heading" data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <div class="row notebox mb-0 p-0">
                                                            <div class="col-sm-12">
                                                                <div class="row">
                                                                    <div class="col-sm-1 mt-2" style="margin-right: -11px;">
                                                                        <%= MyBase.GetResourceString("c_Update")%>
                                                                    </div>
                                                                    <div class="col-sm-3">


                                                                        <%CommonFunctions.HTMLControls.DrawComboBox("CboEasyEditEmployeeName", "select 1",,, " data-live-search='true' class='selectpicker'", False,, ) %>
                                                                    </div>
                                                                    <div class="col-sm-1 mt-2" style="margin-right: -40px; margin-left: -16px;">
                                                                        <%= MyBase.GetResourceString("C_Min")%>
                                                                    </div>
                                                                    <div class="col-sm-2">
                                                                        <% CommonFunctions.HTMLControls.DrawTextBox("FilterHrs", "FilterHrs", "form-control text-center",,,,,,, ,,, "placeholder='00:00' autocomplete='off' maxlength='100' onblur=GetResourceDuration()", ,, True,,,, True) %>
                                                                    </div>
                                                                    <div class="col-sm-5 mt-2" style="margin-left: -25px;">
                                                                        <%= MyBase.GetResourceString("C_HrDay")%> : <span class="Total_Entry mx-1">00:00</span><%= MyBase.GetResourceString("C_HHMM")%>.
                                                                    </div>
                                                                    <div class="col-sm-1 text-end">
                                                                        <a href="#" class="btn btnyellow mr-5" id="apply_btn" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Apply" onclick="ApplyDuration()"><%= MyBase.GetResourceString("C_Apply")%> </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <div class="noteAnimated mt-2">
                                                            <div class="progress-bar-container">
                                                                <div class="progress-bar animated slower">
                                                                    <div class="progress-bar-inner px-2">
                                                                        <div class="progress-text text_bg text-start pt-2">
                                                                            <span class="text_size me-2"><%= MyBase.GetResourceString("C_NoteCaption")%>:</span>  <%= MyBase.GetResourceString("C_EasyEditNote")%>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>




                                        <div id="Edit_grid_panel" class="init_grid_panel ">
                                            <table class="table table-bordered table-stripped highlight-tbl stickytable">
                                                <thead>
                                                    <tr>
                                                        <th width="13%"><%= MyBase.GetResourceString("C_EmployeeName")%></th>
                                                        <th width="10%"><%= MyBase.GetResourceString("C_ProjectTimesheetDate")%></th>
                                                        <th class="text-start" width="20%"><%=MyBase.GetResourceString("C_TaskName")%></th>
                                                        <th width="21%"><%=MyBase.GetResourceString("C_Description")%> </th>
                                                        <th><%=MyBase.GetResourceString("C_Actual_Work")%><br>
                                                            <span class="duration_hr">(<%=MyBase.GetResourceString("C_HHMM")%>)</span></th>
                                                        <th><%=MyBase.GetResourceString("C_WSR")%></th>
                                                        <th width="13%"><%=MyBase.GetResourceString("C_EditDelete")%> </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="TBODYEasyEdit">
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


            <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1" id="offcanvashistory" aria-labelledby="offcanvashistoryLabel">
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
                                    <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ShowHistory")%> </h5>
                                </div>

                            </div>
                        </div>
                        <div class="row mt-2 mb-2 project_timeperiod">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-sm-8">
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <button type="button" class="btn btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas"><%= MyBase.GetResourceString("C_Close")%> </button>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="NOI_Details_content">


                            <div class="tab-content detailsmenutab">
                                <!--<%-- First Tab - Basic Details --%>-->
                                <div class="tab-pane active" id="BasicDetailsTab">

                                    <div class="BasicDetailsContent">
                                        <table class="table table-stripped table-bordered " id="Show_History_Tbl" width="100%">
                                            <thead>
                                                <tr>
                                                    <th><%= MyBase.GetResourceString("C_ModifiedField")%> </th>
                                                    <th><%= MyBase.GetResourceString("C_ModifiedDate")%> </th>
                                                    <th><%= MyBase.GetResourceString("C_OldValue")%></th>
                                                    <th><%= MyBase.GetResourceString("C_NewValue")%></th>
                                                    <th><%= MyBase.GetResourceString("C_ModifiedBy")%> </th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodyhistory">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>



            <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1" id="offcanvas_Weekly_Status_report" aria-labelledby="offcanvas_Weekly_Status_reportLabel">
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
                                    <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_WeeklyStatusReportEntry")%></h5>
                                </div>

                            </div>
                        </div>
                        <div class="row mt-2 mb-2 project_timeperiod">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-sm-8">
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <button type="button" class="btn  btnyellow closeWindowBtn closebtn text-end" id="weekly_status_sv_btn"><%= MyBase.GetResourceString("C_Save")%></button>
                                        <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas"><%= MyBase.GetResourceString("C_Close")%></button>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="NOI_Details_content">


                            <div class="tab-content detailsmenutab">
                                <!--<%-- First Tab - Basic Details --%>-->
                                <div class="tab-pane active" id="BasicDetailsTab">
                                    <div class="BasicDetailsContent">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label><%= MyBase.GetResourceString("C_HighLights")%></label>

                                                    <% CommonFunctions.HTMLControls.DrawTextArea("TextHighlights", "TextHighlights", "Enter HighLights", "form-control",,,,, 400, 100, 200,,,,,,,,,,,,,,,,,,) %>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label><%= MyBase.GetResourceString("C_Slippage")%></label>
                                                    <% CommonFunctions.HTMLControls.DrawTextArea("TextSlippage", "TextSlippage", "Enter Slippage", "form-control",,,,, 400, 100, 200,,,,,,,,,,,,,,,,,,) %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label><%= MyBase.GetResourceString("C_Issues")%></label>
                                                    <% CommonFunctions.HTMLControls.DrawTextArea("TextIssues", "TextIssues", "Enter Issues", "form-control",,,,, 400, 100, 200,,,,,,,,,,,,,,,,,,) %>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label><%= MyBase.GetResourceString("C_Suggestions")%></label>
                                                    <% CommonFunctions.HTMLControls.DrawTextArea("TextSuggestions", "TextSuggestions", "Enter Suggestions", "form-control",,,,, 400, 100, 200,,,,,,,,,,,,,,,,,,) %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label><%= MyBase.GetResourceString("C_NextWeekActivites")%> </label>
                                                    <% CommonFunctions.HTMLControls.DrawTextArea("TextNextWeekActivites", "TextNextWeekActivites", "Enter Next Week Activites", "form-control",,,,, 400, 100, 200,,,,,,,,,,,,,,,,,,) %>
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





            <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1" id="offcanvas_sitecalendarModal" aria-labelledby="offcanvas_MonthlyBillingInfo">
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
                                            <div class="col-sm-6 text-end">
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
                                            <div class="col-sm-2 pe-4">
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

            <!--site calendar modal start here-->
            <div class="modal custmodal fade" id="SCDetailsModal" aria-hidden="true">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="site_details"><%=MyBase.GetResourceString("C_SiteCalendarDetails") %></h5>
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
                                    <input type="text" class="form-control" id="NormalHours" />
                                </div>
                            </div>
                            <div class="form-group row pt-1 mb-2">
                                <label class="control-label col-sm-4" style="margin-top: 5px;"><%=MyBase.GetResourceString("C_ExtraHours") %> </label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="ExtraHours" />
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
                            <!--<div id="pnlStyleContainer" style="width:100%;"></div>-->

                            <br />
                            <div class="text-center">
                                <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel") %> </a>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--site calendar modal end here-->


            <div class="modal custmodal fade" id="RMmodal" aria-hidden="true">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_NotificationAlert")%></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p class="text-center" id="spnalert"></p>
                            <div class="clearfix"></div>

                            <br />
                           <%-- <div class="text-center">
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


            <div id="deleteinfomodal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
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

                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="DeleteTSData(0)"><%=MyBase.GetResourceString("C_No") %></button>

                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <button class="btn btnyellow ml-1 pull-right" onclick="DeleteTSData(1)" style="float: right" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Yes") %></button>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>


        </div>


    </div>
    <%Else %>
    <div id="NotAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center" class="box box-solid">
            <p><%= MyBase.GetResourceString("C_NotAccess")%>. </p>
        </div>
    </div>
    <%End If %>
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <!-- jqueryUI js -->

    <script src="../../../Whizible2.0-new/dist/js/jquery.calendar.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/dist/js/calendar-gc.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>

    <!--site calendar-->

    <script>

        //Page Name : PM_ProjectTimesheetDetails
        //Created By : Dipali V
        //Created Date : 23th Sep 2023
        var ProjectTimesheetID = '<%= Request.QueryString("TimeSheetNo")%>';
        var ProjectFromDate = '<%= Request.QueryString("FromDate")%>';
        var ProjectToDate = '<%= Request.QueryString("ToDate")%>';
        var ProjectID = '<%= Request.QueryString("ProjectID")%>';
        var ProjectTimesheetStatus = '<%= Request.QueryString("CurrentStatus")%>';
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>'
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //var ProjectID;
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';

        var AddAccess = '<%=m_AddAccess%>';
        var EditAccess = '<%=m_EditAccess%>';
        var m_DeleteAccess = '<%=m_DeleteAccess%>';
        //alert(AddAccess);
       // ProjectID = '<%= Session("intProjectID") %>';
        alertify.set('notifier', 'position', 'top-right');
        var GTimsheetID = 0;
        var MinHoursForDAEntry = "0.016";
        var RestrictByMinHours = "0.016";
        var TotalModifiedTSCount = 0;
        var TotalCountTS = 0;
        // alert(ProjectID);
        $(document).ready(function () {
            StartLoader('#bodyPreloader')

            $("#SpnProjectTimesheetID").text(ProjectTimesheetID);
            $("#timesheet_ID").text(ProjectTimesheetID);
            $("#ProjectFromdate").text(ProjectFromDate);
            $("#ProjectTodate").text(ProjectToDate);
            $("#EasyEditFromdate").text(ProjectFromDate);
            $("#EasyEditTodate").text(ProjectToDate);
            $("#ProjectTimesheetCurrentStatus").text(ProjectTimesheetStatus);
            $("#ProjectTimesheetStatus").text(ProjectTimesheetStatus);
            if (ProjectTimesheetStatus == "Rejected") {
                $("#ProjectTimesheetCurrentStatus").css("color", "red");
            } else if (ProjectTimesheetStatus == "Approved") {
                $("#ProjectTimesheetCurrentStatus").css("color", "Green");
            }
            else {
                $("#ProjectTimesheetCurrentStatus").css("color", "black");
            }
            GetMINDAValidation();
            GetEmployeeDetails();
            ViewProjectTimesheet();
            PlotActionLinkConditionally();
            $("#dltAllTimsheet").click(function () {
                $(".mainchck").prop('checked', $(this).prop('checked'));
            });
            $(".mainchck").change(function () {
                var rowCount = $(".timesheet-tbl > tr").length;
                var CheckedcheckedBoxes = $("input[type=checkbox]:checked", ".timesheet-tbl");
                if (rowCount == CheckedcheckedBoxes.length) {
                    $("#dltAllTimsheet").prop('checked', true);
                }
                if (!$(this).prop("checked")) {
                    $("#dltAllTimsheet").prop("checked", false);
                }
            })

            $('.filter-wrap').click(function () {
                $(this).toggleClass('active');
            });


            $('.close-all').click(function () {
                $('.edit-row').find('.form-control').addClass('no-edit');
                $('textarea.no-edit').hide();
                $(this).hide();
                $('.close-row').hide();
            });


            $(function () {
                $('[data-bs-toggle="tooltip"]').tooltip()
            })

            $('.multi-edit').click(function () {
                $('textarea.no-edit , .saverow').show();
                $('.edit').hide();
                $('.edit-row, .edit, .cancelval').find('.form-control').removeClass('no-edit');
                $('.close-row, .saverow,').show();
            });

            $('.modal').on('hidden.bs.modal', function () {
                $('.custmodal').load('.modal');
            });
            StopAjaxLoader('#bodyPreloader')
        });

        //Added By Dipali V On 26th Sep 2023 For Get Generated Timesheet employee
        function GetEmployeeDetails() {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetEmployeeDetails", param, false);
            var EmployeeDetails = strResult.EmployeeDetails

            for (var i = 0; i < EmployeeDetails.length; i++) {
                var objCbo1 = document.getElementById("select_emp");
                var objCbo2 = document.getElementById("select_Update_EMP");
                // var objCbo3 = document.getElementById("CboEasyEdit");
                $("#select_emp option").remove();
                $("#select_Update_EMP option").remove();
                // $("#CboEasyEdit option").remove();
                //$("#cboTimesheet").append('<option value="0">Select Organization Unit</option>');
                for (var i = 0; i < EmployeeDetails.length; i++) {
                    var ObjStatus = EmployeeDetails[i];
                    var objOption = document.createElement("OPTION");
                    var objOption1 = document.createElement("OPTION");

                    objCbo1.options.add(objOption);
                    objCbo2.options.add(objOption1);

                    objOption.text = ObjStatus.EmployeeName;
                    objOption.value = ObjStatus.EmployeeID;

                    objOption1.text = ObjStatus.EmployeeName;
                    objOption1.value = ObjStatus.EmployeeID;


                }
            }

            $(".selectpicker").selectpicker('refresh');
        }
        //Added By Dipali V On 26th Sep 2023 For Get Project Timesheet Details
        var IsOnchange = 0;
        function EmployeeName_onChange() {
            IsOnchange = 1;
            ViewProjectTimesheet();
        }


        //Added By Dipali V On 26th Sep 2023 For Get Project Timesheet Details
        var arrEmployeeID = [];
        var GReadyToAuthenticate = "";
        var GAuthenticated = "";
        function ViewProjectTimesheet() {
            var EmployeeID = $("#select_emp").val();
            if (EmployeeID == 0) {
                EmployeeID = "NULL"
            }
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                EmployeeID: EmployeeID
            }
            var param = JSON.stringify(Parameters);
            $("#ProjectTimesheetDetails").html('');
            var ProjectTimesheetDetails = "";
            var EmployeeName = "", EmployeeID = "";
            var EmployeeCode = "";
            var SelectedTSStatus = "";
            var ResourceTotal = "";
            var ResourceTotalHHMM = "";
            var EntryDate = "";
            //let EmployeeToltal = 0;
            //let OneResource = 0;
            var EmployeeDetails = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetViewProjectTimsheet", param, false);
            for (var i = 0; i < EmployeeDetails.length; i++) {
                var IsDelete = "";
                var IsWSRcheckbox = "";
                arrEmployeeID.push(parseInt(EmployeeDetails[i].EmployeeID));
                GReadyToAuthenticate = EmployeeDetails[i].ReadyToAuthenticate;
                GAuthenticated = EmployeeDetails[i].Authenticated;
                var Description = "";
                //alert(EmployeeDetails[i].Description);
                if (EmployeeDetails[i].Description.length > 30) {
                    Description = EmployeeDetails[i].Description.slice(0, 30) + "...";
                } else {
                    Description = EmployeeDetails[i].Description;
                }
                SelectedTSStatus = EmployeeDetails[i].TimsheetStatus;

                if (EmployeeDetails[i].ReadyToAuthenticate == "") {
                    IsDelete = "";
                    // IsWSRcheckbox = "checked";
                    if (EmployeeDetails[i].WeeklyStatusEntry == 1) {
                        IsWSRcheckbox = "checked";
                    }
                    else {
                        IsWSRcheckbox = "";
                    }
                }
                else if (EmployeeDetails[i].ReadyToAuthenticate == "Y") {
                    IsDelete = "disabled";
                    //IsWSRcheckbox = "disabled";
                    if (EmployeeDetails[i].WeeklyStatusEntry == 1) {
                        IsWSRcheckbox = "checked disabled";
                    } else {
                        IsWSRcheckbox = "disabled";
                    }
                }


                if (EmployeeName == "") {
                    console.log("one");
                    // OneResource = parseFloat(EmployeeDetails[i].Duration);
                    if (IsOnchange == 1) {
                        // OneResource = 0;
                        //EmployeeToltal = parseFloat(EmployeeToltal) + parseFloat(EmployeeDetails[i].Duration);
                    }
                    ProjectTimesheetDetails += '<tr><td><strong>[' + EmployeeDetails[i].EmployeeCode + '] - ' + EmployeeDetails[i].EmployeeName + '</strong></td><td colspan="6"></td></tr>';
                    ProjectTimesheetDetails += '<tr><td></td>';
                    //ProjectTimesheetDetails += "<td id='EntryDate_" + EmployeeDetails[i].TimeSheetID +"'>" + EmployeeDetails[i].EntryDate + "</td>";
                    if (EntryDate != EmployeeDetails[i].EntryDate) {
                        ProjectTimesheetDetails += '<td id="EntryDate_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].EntryDate + '</td>';
                    } else {
                        ProjectTimesheetDetails += '<td><span id="EntryDate_' + EmployeeDetails[i].TimeSheetID + '" style="display:none">' + EmployeeDetails[i].EntryDate + '</span></td>';
                    }
                    ProjectTimesheetDetails += '<td class="text-start">';
                    ProjectTimesheetDetails += ' <div class="d-flex">';
                    if (EmployeeDetails[i].ReadyToAuthenticate == "") {
                        ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id ="TaskName_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].Task + '</a>';
                        ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" >&nbsp;&nbsp;<i class="fas fa-pencil-alt icon_style" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Edit" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID +')"></i></a>';
                    }
                    else if (EmployeeDetails[i].ReadyToAuthenticate == "Y") {
                        ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id="TaskName_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].Task + '</a>';
                        ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id="TaskName_' + EmployeeDetails[i].TimeSheetID + '" >&nbsp;&nbsp;</a>';
                    }
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    if (EmployeeDetails[i].Description.trim() != "") {
                        ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + EmployeeDetails[i].Description + '" id="Description_' + EmployeeDetails[i].TimeSheetID + '">' + Description + '</td >';
                    } else {
                        ProjectTimesheetDetails += '<td id="Description_' + EmployeeDetails[i].TimeSheetID + '">' + Description + '</td >';
                    }
                    ProjectTimesheetDetails += '<td  id="ActualHours_' + EmployeeDetails[i].TimeSheetID + '" value="' + EmployeeDetails[i].Duration + '">' + EmployeeDetails[i].DurationHHMM + '<span id="ActualHoursDecimal_' + EmployeeDetails[i].TimeSheetID + '" style="display:none">' + EmployeeDetails[i].Duration + '</span><span id = "ActualHoursHHMM_' + EmployeeDetails[i].TimeSheetID + '" style = "display:none" > ' + EmployeeDetails[i].DurationHHMM + '</span></td>';
                    ProjectTimesheetDetails += '<td class="sm-wid">';
                    ProjectTimesheetDetails += '<div class="custom_chckbox">';
                    ProjectTimesheetDetails += '<input id="taskwsr_' + EmployeeDetails[i].TimeSheetID + '" name="WSRCheckbox" onchange="WSR_Checkbox(' + EmployeeDetails[i].EmployeeID + ',' + EmployeeDetails[i].TimeSheetID + ')" class="chckHead mainchck WSRCheckbox_' + EmployeeDetails[i].EmployeeID + '" type="checkbox"  ' + IsWSRcheckbox + ' value="' + EmployeeDetails[i].TimeSheetID + '">';
                    ProjectTimesheetDetails += '<label for="taskwsr_' + EmployeeDetails[i].TimeSheetID + '"></label>';
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    ProjectTimesheetDetails += '<td class="sm-wid">';
                    ProjectTimesheetDetails += '<div class="custom_chckbox">';
                    ProjectTimesheetDetails += '<input id="taskdlt_' + EmployeeDetails[i].TimeSheetID + '" class="chckHead" name="DeleteCheckbox" type="checkbox" ' + IsDelete + ' value="' + EmployeeDetails[i].TimeSheetID + '">';
                    ProjectTimesheetDetails += '<label for="taskdlt_' + EmployeeDetails[i].TimeSheetID + '"></label>';
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    ProjectTimesheetDetails += '</tr> ';
                    if (i == EmployeeDetails.length - 1) { // Only On Resource TS Generated for one Day
                        //console.log("one Last");
                        // EmployeeToltal = parseFloat(EmployeeToltal) + parseFloat(EmployeeDetails[i].Duration);
                        ProjectTimesheetDetails += '<tr class="total-row">';
                        ProjectTimesheetDetails += '<td colspan="3" class="text-start">';
                        ProjectTimesheetDetails += '<label>Total Actual Work (HH:MM) for <strong> [ ' + EmployeeDetails[i].EmployeeCode + '] - ' + EmployeeDetails[i].EmployeeName + ' [WSR Status]</strong></label>';
                        ProjectTimesheetDetails += '<div class="custom_chckbox d-inline-blockpl-10">';
                        ProjectTimesheetDetails += '<input id="totalChcked_' + EmployeeDetails[i].EmployeeID + '" class="chckHead" type="checkbox" checked="checked" ' + IsWSRcheckbox + ' onclick="checkwsr(' + EmployeeDetails[i].EmployeeID + ')">';
                        ProjectTimesheetDetails += '<label for="totalChcked_' + EmployeeDetails[i].EmployeeID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Total</strong></span></td>';
                        ProjectTimesheetDetails += '<td><strong><span id="Total_' + EmployeeDetails[i].EmployeeID + '"> ' + EmployeeDetails[i].ResourceTotalHHMM + '</span></strong><span id="Totalhidden_' + EmployeeDetails[i].EmployeeID + '" style="display:none"> ' + ResourceTotal + '</span></td>';
                        ProjectTimesheetDetails +='<td style="border- left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '</tr>';

                        ProjectTimesheetDetails += '<tr class="total-row">';
                        ProjectTimesheetDetails += '<td colspan="3">';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Grand Total	</strong></span></td>';
                        ProjectTimesheetDetails += '<td > <strong><span class="fl-right" id="GrandTotal"><span> ' + EmployeeDetails[i].GrandTotalHHMM + '  </strong></td>';
                        ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '</tr>';
                    }

                }
                else if (EmployeeName == EmployeeDetails[i].EmployeeName) {


                    ProjectTimesheetDetails += '<tr><td></td>';
                    if (EntryDate != EmployeeDetails[i].EntryDate) {
                        ProjectTimesheetDetails += '<td id="EntryDate_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].EntryDate + '</td>';
                    } else {
                        ProjectTimesheetDetails += '<td><span id="EntryDate_' + EmployeeDetails[i].TimeSheetID + '" style="display:none">' + EmployeeDetails[i].EntryDate + '</span></td>';
                    }

                    ProjectTimesheetDetails += '<td class="text-start">';
                    ProjectTimesheetDetails += ' <div class="d-flex">';
                    if (EmployeeDetails[i].ReadyToAuthenticate == "") {
                        ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id ="TaskName_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].Task + '</a>';
                        ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" >&nbsp;&nbsp;<i class="fas fa-pencil-alt icon_style" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Edit" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')"></i></a>';
                    }
                    else if (EmployeeDetails[i].ReadyToAuthenticate == "Y") {
                        ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id="TaskName_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].Task + '</a>';
                        ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id="TaskName_' + EmployeeDetails[i].TimeSheetID + '" >&nbsp;&nbsp;</a>';
                    }
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    if (EmployeeDetails[i].Description.trim() != "") {
                        ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + EmployeeDetails[i].Description + '" id="Description_' + EmployeeDetails[i].TimeSheetID + '">' + Description + '</td >';
                    } else {
                        ProjectTimesheetDetails += '<td id="Description_' + EmployeeDetails[i].TimeSheetID + '">' + Description + '</td >';
                    }
                    ProjectTimesheetDetails += '<td  id="ActualHours_' + EmployeeDetails[i].TimeSheetID + '" value="' + EmployeeDetails[i].Duration + '">' + EmployeeDetails[i].DurationHHMM + '<span id="ActualHoursDecimal_' + EmployeeDetails[i].TimeSheetID + '" style="display:none">' + EmployeeDetails[i].Duration + '</span><span id = "ActualHoursHHMM_' + EmployeeDetails[i].TimeSheetID + '" style = "display:none" > ' + EmployeeDetails[i].DurationHHMM + '</span></td>';
                    ProjectTimesheetDetails += '<td class="sm-wid">';
                    ProjectTimesheetDetails += '<div class="custom_chckbox">';
                    ProjectTimesheetDetails += '<input id="taskwsr_' + EmployeeDetails[i].TimeSheetID + '" name="WSRCheckbox" onchange="WSR_Checkbox(' + EmployeeDetails[i].EmployeeID + ',' + EmployeeDetails[i].TimeSheetID + ')" class="chckHead mainchck WSRCheckbox_' + EmployeeDetails[i].EmployeeID + '" type="checkbox"  ' + IsWSRcheckbox + ' value="' + EmployeeDetails[i].TimeSheetID + '">';
                    ProjectTimesheetDetails += '<label for="taskwsr_' + EmployeeDetails[i].TimeSheetID + '"></label>';
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    ProjectTimesheetDetails += '<td class="sm-wid">';
                    ProjectTimesheetDetails += '<div class="custom_chckbox">';
                    ProjectTimesheetDetails += '<input id="taskdlt_' + EmployeeDetails[i].TimeSheetID + '" class="chckHead" name="DeleteCheckbox" type="checkbox" ' + IsDelete + ' value="' + EmployeeDetails[i].TimeSheetID + '">';
                    ProjectTimesheetDetails += '<label for="taskdlt_' + EmployeeDetails[i].TimeSheetID + '"></label>';
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    ProjectTimesheetDetails += '</tr> ';
                    if (i == EmployeeDetails.length - 1) {
                      
                        ProjectTimesheetDetails += '<tr class="total-row">';
                        ProjectTimesheetDetails += '<td colspan="3" class="text-start">';
                        ProjectTimesheetDetails += '<label>Total Actual Work (HH:MM) for <strong> [ ' + EmployeeDetails[i].EmployeeCode + '] - ' + EmployeeDetails[i].EmployeeName + ' [WSR Status]</strong></label>';
                        ProjectTimesheetDetails += '<div class="custom_chckbox d-inline-blockpl-10">';
                        ProjectTimesheetDetails += '<input id="totalChcked_' + EmployeeDetails[i].EmployeeID + '" class="chckHead" type="checkbox" checked="checked" ' + IsWSRcheckbox + ' onclick="checkwsr(' + EmployeeDetails[i].EmployeeID + ')">';
                        ProjectTimesheetDetails += '<label for="totalChcked_' + EmployeeDetails[i].EmployeeID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Total</strong></span></td>';
                        ProjectTimesheetDetails += '<td><strong><span id="Total_' + EmployeeDetails[i].EmployeeID + '"> ' + EmployeeDetails[i].ResourceTotalHHMM + '</span></strong><span id="Totalhidden_' + EmployeeDetails[i].EmployeeID + '" style="display:none"> ' + ResourceTotal + '</span></td>';
                        ProjectTimesheetDetails += '<td style="border- left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '</tr>';

                        ProjectTimesheetDetails += '<tr class="total-row">';
                        ProjectTimesheetDetails += '<td colspan="3">';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Grand Total	</strong></span></td>';
                        ProjectTimesheetDetails += '<td > <strong><span class="fl-right" id="GrandTotal"><span> ' + EmployeeDetails[i].GrandTotalHHMM + '  </strong></td>';
                        ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '</tr>';
                    }

                }
                else if (EmployeeName != EmployeeDetails[i].EmployeeName) {

                    //ProjectTimesheetDetails += "<tr class='total-row'> ";
                    //ProjectTimesheetDetails += " <td colspan='3' class='text-start'> ";
                    //ProjectTimesheetDetails += "<label>Total Actual Work (HH:MM) for <strong> [ " + EmployeeCode + "] - " + EmployeeName + " [WSR Status]</strong></label> ";
                    //ProjectTimesheetDetails += "<div class='custom_chckbox d-inline-blockpl-10'> ";
                    //ProjectTimesheetDetails += "<input id='totalChcked_" + EmployeeID + "' class='chckHead' type='checkbox' checked='checked' " + IsWSRcheckbox + " onclick='checkwsr(" + EmployeeID + ")'> ";
                    //ProjectTimesheetDetails += "<label for='totalChcked_" + EmployeeID + "'></label> ";
                    //ProjectTimesheetDetails += "</div>";
                    //ProjectTimesheetDetails += "</td>";
                    //ProjectTimesheetDetails += "<td> <span class='fl-right'><strong>Total</strong></span></td> ";
                    //ProjectTimesheetDetails += "<td ><strong><span id='Total_" + EmployeeID + "'> " + ResourceTotalHHMM + "</span></strong><span id='Totalhidden_" + EmployeeID + "'  style='display:none'> " + ResourceTotal + "</span></td> ";
                    //ProjectTimesheetDetails += "<td style='border- left: none; '>&nbsp;</td> ";
                    //ProjectTimesheetDetails += "<td style='border-left: none; '>&nbsp;</td> ";
                    //ProjectTimesheetDetails += " </tr>";

                    ProjectTimesheetDetails += '<tr class="total-row">';
                    ProjectTimesheetDetails += '<td colspan="3" class="text-start">';
                    ProjectTimesheetDetails += '<label>Total Actual Work (HH:MM) for <strong> [ ' + EmployeeCode + '] - ' + EmployeeName + ' [WSR Status]</strong></label>';
                    ProjectTimesheetDetails += '<div class="custom_chckbox d-inline-blockpl-10">';
                    ProjectTimesheetDetails += '<input id="totalChcked_' + EmployeeID + '" class="chckHead" type="checkbox" checked="checked" ' + IsWSRcheckbox + ' onclick="checkwsr(' + EmployeeID + ')">';
                    ProjectTimesheetDetails += '<label for="totalChcked_' + EmployeeID + '"></label>';
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Total</strong></span></td>';
                    ProjectTimesheetDetails += '<td><strong><span id="Total_' + EmployeeID + '"> ' + ResourceTotalHHMM + '</span></strong><span id="Totalhidden_' + EmployeeID + '" style="display:none"> ' + ResourceTotal + '</span></td>';
                    ProjectTimesheetDetails += '<td style="border- left: none;">&nbsp;</td>';
                    ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                    ProjectTimesheetDetails += '</tr>';


                    ProjectTimesheetDetails += '<tr><td><strong>[' + EmployeeDetails[i].EmployeeCode + '] - ' + EmployeeDetails[i].EmployeeName + '</strong></td><td colspan="6"></td></tr>';
                    ProjectTimesheetDetails += '<tr><td></td>';


                    //ProjectTimesheetDetails += "<td id='EntryDate_" + EmployeeDetails[i].TimeSheetID + "'>" + EmployeeDetails[i].EntryDate + "</td>";
                    if (EntryDate != EmployeeDetails[i].EntryDate) {
                        ProjectTimesheetDetails += '<td id="EntryDate_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].EntryDate + '</td>';
                    } else {
                        ProjectTimesheetDetails += '<td><span id="EntryDate_' + EmployeeDetails[i].TimeSheetID + '" style="display:none">' + EmployeeDetails[i].EntryDate + '</span></td>';
                    }

                    ProjectTimesheetDetails += '<td class="text-start">';
                    ProjectTimesheetDetails += ' <div class="d-flex">';
                    if (EmployeeDetails[i].ReadyToAuthenticate == "") {
                        ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id ="TaskName_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].Task + '</a>';
                        ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" >&nbsp;&nbsp;<i class="fas fa-pencil-alt icon_style" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Edit" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')"></i></a>';
                    }
                    else if (EmployeeDetails[i].ReadyToAuthenticate == "Y") {
                        ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id="TaskName_' + EmployeeDetails[i].TimeSheetID + '">' + EmployeeDetails[i].Task + '</a>';
                        ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].TimeSheetID + ')" id="TaskName_' + EmployeeDetails[i].TimeSheetID + '" >&nbsp;&nbsp;</a>';
                    }
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    if (EmployeeDetails[i].Description.trim() != "") {
                        ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + EmployeeDetails[i].Description + '" id="Description_' + EmployeeDetails[i].TimeSheetID + '">' + Description + '</td >';
                    } else {
                        ProjectTimesheetDetails += '<td id="Description_' + EmployeeDetails[i].TimeSheetID + '">' + Description + '</td >';
                    }
                    ProjectTimesheetDetails += '<td  id="ActualHours_' + EmployeeDetails[i].TimeSheetID + '" value="' + EmployeeDetails[i].Duration + '">' + EmployeeDetails[i].DurationHHMM + '<span id="ActualHoursDecimal_' + EmployeeDetails[i].TimeSheetID + '" style="display:none">' + EmployeeDetails[i].Duration + '</span><span id = "ActualHoursHHMM_' + EmployeeDetails[i].TimeSheetID + '" style = "display:none" > ' + EmployeeDetails[i].DurationHHMM + '</span></td>';
                    ProjectTimesheetDetails += '<td class="sm-wid">';
                    ProjectTimesheetDetails += '<div class="custom_chckbox">';
                    ProjectTimesheetDetails += '<input id="taskwsr_' + EmployeeDetails[i].TimeSheetID + '" name="WSRCheckbox" onchange="WSR_Checkbox(' + EmployeeDetails[i].EmployeeID + ',' + EmployeeDetails[i].TimeSheetID + ')" class="chckHead mainchck WSRCheckbox_' + EmployeeDetails[i].EmployeeID + '" type="checkbox"  ' + IsWSRcheckbox + ' value="' + EmployeeDetails[i].TimeSheetID + '">';
                    ProjectTimesheetDetails += '<label for="taskwsr_' + EmployeeDetails[i].TimeSheetID + '"></label>';
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    ProjectTimesheetDetails += '<td class="sm-wid">';
                    ProjectTimesheetDetails += '<div class="custom_chckbox">';
                    ProjectTimesheetDetails += '<input id="taskdlt_' + EmployeeDetails[i].TimeSheetID + '" class="chckHead" name="DeleteCheckbox" type="checkbox" ' + IsDelete + ' value="' + EmployeeDetails[i].TimeSheetID + '">';
                    ProjectTimesheetDetails += '<label for="taskdlt_' + EmployeeDetails[i].TimeSheetID + '"></label>';
                    ProjectTimesheetDetails += '</div>';
                    ProjectTimesheetDetails += '</td>';
                    ProjectTimesheetDetails += '</tr> ';
                    // EmployeeToltal = parseFloat(EmployeeDetails[i].Duration) ;
                }

                EmployeeName = EmployeeDetails[i].EmployeeName;
                EmployeeCode = EmployeeDetails[i].EmployeeCode;
                EmployeeID = EmployeeDetails[i].EmployeeID;
                ResourceTotalHHMM = EmployeeDetails[i].ResourceTotalHHMM;
                ResourceTotal = EmployeeDetails[i].ResourceTotal;
                EntryDate = EmployeeDetails[i].EntryDate;

            }

            // arrEmployeeID = unique(arrEmployeeID);
            // let  GrandTotal = 0;
            $("#ProjectTimesheetDetails").html(ProjectTimesheetDetails);
            $("#ProjectTimesheetCurrentStatus").text("");
            $("#ProjectTimesheetStatus").text("");
            //Added by Dipali V On 26th Oct 2023 After PageRefresh Status 
            if (SelectedTSStatus == "") {
                SelectedTSStatus = ProjectTimesheetStatus;
            }
            //End of Added by Dipali V On 26th Oct 2023 After PageRefresh Status 
            $("#ProjectTimesheetCurrentStatus").text(SelectedTSStatus);
            $("#ProjectTimesheetStatus").text(SelectedTSStatus);
            // for (var i = 0; i < arrEmployeeID.length; i++) {
            //    // console.log(parseFloat($("#Total_" + parseFloat(arrEmployeeID[i])).text()));
            //     GrandTotal += parseFloat($("#Totalhidden_" + parseFloat(arrEmployeeID[i])).text());
            // }
            //// alert(GrandTotal);
            // GetHoursHHMM(GrandTotal);
            $('[data-bs-toggle="tooltip"]').tooltip();

        }

        //Added By Dipali V On 29th Sep 2023 For Check Min DA Configuration
        function GetMINDAValidation() {
            var Parameters = {

            }
            var param = JSON.stringify(Parameters);
            strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetRestrictByMinHours_MinHoursForDAEntry", param, false);
            if (strResult != undefined) {
                RestrictByMinHours = strResult.RestrictByMinHours;
                MinHoursForDAEntry = strResult.MinHoursForDAEntry;
            }
            if (MinHoursForDAEntry == "0.016") {
                //Added By Dipali V On 25th Oct 2023 For Show hide div
                $("#divfilter_actual_work_Text").show();
                $("#divfilter_actual_work_Drop").hide();
                //End of Added By Dipali V On 25th Oct 2023 For Show hide div
            } else {
                //Added By Dipali V On 25th Oct 2023 For Show hide div
                $("#divfilter_actual_work_Drop").show();
                $("#divfilter_actual_work_Text").hide();
                //End of Added By Dipali V On 25th Oct 2023 For Show hide div
            }
            //return MinHoursForDAEntry;
        }


        //Added By Dipali V On 29th Sep 2023 For Check Min DA Configuration
        var GintSumDurationOld;
        var GintTaskDuration;
        var GActualHoursDecimal;
        var GstrEmployeeName;
        function GetTimesheetDurationDetails(TimesheetID) {
            // debugger;
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                TimesheetID: TimesheetID
            }
            var param = JSON.stringify(Parameters);
            GetTimesheetDetails = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetTimesheetDurationDetails", param, false);
            if (GetTimesheetDetails != "") {
                const myArray = GetTimesheetDetails.split("&&&&");
                GintSumDurationOld = myArray[0].intSumDurationOld;
                GintTaskDuration = myArray[1].intTaskDuration;
                GstrEmployeeName = myArray[2].strEmployeeName;
                GstrEntryDateName = myArray[3].strEntryDateName;
            }

        }

        //Added By Dipali V On 27th Sep 2023 For Task Details while Description Updatation
        function GetTaskDetails(TimsheetID) {
            //debugger;
            //MinHoursForDAEntry = GetMINDAValidation();
            GetMINDAValidation();
            GetTimesheetDurationDetails(TimsheetID);
            GTimsheetID = TimsheetID;
            var TaskName = $("#TaskName_" + TimsheetID).text();
            var EntryDate = $("#EntryDate_" + TimsheetID).text();
            var Description = $("#Description_" + TimsheetID).attr('data-bs-original-title');
            //debugger;
            if (MinHoursForDAEntry == "0.016") {
                var ActualHoursDecimal = $("#ActualHoursHHMM_" + TimsheetID).text();
            }
            else {
                var ActualHoursDecimal = $("#ActualHoursDecimal_" + TimsheetID).text();
            }

            $("#EachTaskDetails").text(EntryDate + "-" + TaskName);
            $("#edit_description_filter").val(Description);
            if (ActualHoursDecimal != "") {
                GActualHoursDecimal = ActualHoursDecimal;
            }
            if (MinHoursForDAEntry == "0.016") {
                $("#filter_actual_work_Text").val(ActualHoursDecimal);
            } else {
                //$("#filter_actual_work_Drop:option:selected").val(ActualHours);
                $("#filter_actual_work_Drop").val(ActualHoursDecimal);
                $(".selectpicker").selectpicker('refresh');
            }


        }

        //Added By Dipali V On 27th Sep 2023 For Action LInk plot Conditionally
        function PlotActionLinkConditionally() {
            if (GReadyToAuthenticate == "Y") {
                $("#select_all_wsr").hide();
                $("#clear_all_wsr").hide();
                $("#delete_btn").hide();
                $("#update_wsr").hide();
                $("#easy_edit_tab").hide();
                $("#re_generate").hide();
                $("#send_For_approval").hide();

            } else if (GReadyToAuthenticate != "Y" && GAuthenticated != "R") {
                //$("#send_For_approval").hide();
            }

        }
        //Added By Dipali V On 27th Sep 2023 For Save Task Description
        function SaveDescription() {
            //  debugger;
            // EachTaskDetails
            var intsumDurationNew = parseFloat(GintSumDurationOld) - parseFloat(GintTaskDuration);
            var intsumDuration = parseFloat(intsumDurationNew) + parseFloat(GActualHoursDecimal);
            if (MinHoursForDAEntry == "0.016") {
                var ControlID = ("filter_actual_work_Text");
            } else {
                var ControlID = ("filter_actual_work_Drop");
            }
            if ($("#edit_description_filter").val().trim() == "") {
                alertify.error('<%= MyBase.GetResourceString("C_descriptionNotBlank")%>');
                $("#edit_description_filter").focus()
                return false;
            }
            else if (checkSpecialCharacter($("#edit_description_filter").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#edit_description_filter").focus();
                return false;
            }
            else if ($("#filter_actual_work_Text").val().trim() == "" && MinHoursForDAEntry == "0.016") {
                alertify.error('<%= MyBase.GetResourceString("C_actual_workNotBlank")%>');
                $("#filter_actual_work_Text").focus()
                return false;
            }

            else if ($("#filter_actual_work_Drop").val() == "0" && MinHoursForDAEntry != "0.016") {
                alertify.error('<%= MyBase.GetResourceString("C_actual_workNotBlank")%>');
                $("#filter_actual_work_Drop").focus()
                return false;
            }
            else if (MinHoursForDAEntry == "0.016" && WorkHoursValidation(ControlID) == false) {
                // ControlID.focus();
                return false;
            }
            else if (intsumDuration > 24) {
                alert("<%= MyBase.GetResourceString("C_WorkHrsValidation")%> '" + GstrEmployeeName + "'<%= MyBase.GetResourceString("C_Date")%>  '" + GstrEntryDateName + "'.");
                if (MinHoursForDAEntry == "0.016") {
                    $("#filter_actual_work_Text").focus();
                } else {
                    $("#filter_actual_work_Drop").focus();
                }
                return false;
            }
            else {

                var Description = $("#edit_description_filter").val().trim().replace(/'/g, "''");
                if (MinHoursForDAEntry == "0.016") {
                    var ActualHours = $("#filter_actual_work_Text").val().trim();
                    ActualHours = ConvertDecimalToHourViceVersa(ActualHours, 2);
                } else {
                    var ActualHours = $("#filter_actual_work_Drop").val();
                }

                var Parameters = {
                    TimesheetID: encodeURI(GTimsheetID),
                    TimesheetNo: encodeURI(ProjectTimesheetID),
                    ActualWork: ActualHours,
                    Description: Description,
                    UserID: UserID,
                    ProjectID: ProjectID
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/SaveDescription", param, false);
                if (strResult != "") {
                    alertify.success('<%= MyBase.GetResourceString("C_DataSaved")%>');
                    ViewProjectTimesheet();

                }
            }
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

        var IsWSRDetails = 0;
        $("#generate_wsr").on("click", function () {
            GetWSRActivitiesDetails(ProjectTimesheetID);
        });
        //Added By Dipali V On 27th Sep 2023 For Get Generated WSR Details
        function GetWSRActivitiesDetails(ProjectTimesheetID) {
            StartLoader('#bodyPreloader')
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetWSRActivitiesDetails", param, false);
            StopAjaxLoader('#bodyPreloader')
            if (strResult != "") {
                for (var i = 0; i < strResult.length; i++) {
                    IsWSRDetails = 1;
                    $("#TextHighlights").text(strResult[i].HighLights);
                    $("#TextSlippage").text(strResult[i].Sleepage);
                    $("#TextIssues").text(strResult[i].Issues);
                    $("#TextSuggestions").text(strResult[i].Suggetion);
                    $("#TextNextWeekActivites").text(strResult[i].Activities);
                }
            }

        }

        //Added By Dipali V On 27th Sep 2023 For Saved WSR Details
        $("#weekly_status_sv_btn").on("click", function () {

            if (checkSpecialCharacter($("#TextHighlights").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("C_HighLights")%> <%= MyBase.GetResourceString("C_NotContain")%> "' + WebConfigSpecialCharacters + '" <%= MyBase.GetResourceString("C_characters")%>');
                $("#TextHighlights").focus();
                return false;
            }
            else if (checkSpecialCharacter($("#TextSlippage").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("C_Slippage")%> <%= MyBase.GetResourceString("C_NotContain")%> "' + WebConfigSpecialCharacters + '" <%= MyBase.GetResourceString("C_characters")%>');
                $("#TextSlippage").focus();
                return false;
            }

            else if (checkSpecialCharacter($("#TextIssues").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("C_Issues")%> <%= MyBase.GetResourceString("C_NotContain")%> "' + WebConfigSpecialCharacters + '" <%= MyBase.GetResourceString("C_characters")%>');
                $("#TextIssues").focus();
                return false;
            }
            else if (checkSpecialCharacter($("#TextSuggestions").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("C_Suggestions")%> <%= MyBase.GetResourceString("C_NotContain")%> "' + WebConfigSpecialCharacters + '" <%= MyBase.GetResourceString("C_characters")%>');
                $("#TextSuggestions").focus();
                return false;
            }
            else if (checkSpecialCharacter($("#TextNextWeekActivites").val().trim(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("C_NextWeekActivites")%> <%= MyBase.GetResourceString("C_NotContain")%> "' + WebConfigSpecialCharacters + '" <%= MyBase.GetResourceString("C_characters")%>');
                $("#TextNextWeekActivites").focus();
                return false;
            }
            else {

                var Highlights = $("#TextHighlights").val().trim().replace(/'/g, "''");
                var Slippage = $("#TextSlippage").val().trim().replace(/'/g, "''");
                var Issues = $("#TextIssues").val().trim().replace(/'/g, "''");
                var Suggestions = $("#TextSuggestions").val().trim().replace(/'/g, "''");
                var NextWeekActivites = $("#TextNextWeekActivites").val().trim().replace(/'/g, "''");
                var Parameters = {
                    TimesheetNo: encodeURI(ProjectTimesheetID),
                    ProjectID: encodeURI(ProjectID),
                    Highlights: Highlights,
                    Slippage: Slippage,
                    Suggestions: Suggestions,
                    Issues: Issues,
                    NextWeekActivites: NextWeekActivites,
                }
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GenerateWSR", param, false);
                if (strResult != "") {
                    if (IsWSRDetails == 1) {
                        alertify.success('<%= MyBase.GetResourceString("C_WSRDataUpdated")%>');
                    } else {
                        alertify.success('<%= MyBase.GetResourceString("C_WSRDataSaved")%>');
                    }
                    GetWSRActivitiesDetails(ProjectTimesheetID);
                }

            }
        });

        //Added By Dipali V On 29th Sep 2023 For Send for approval
        function send_For_approval() {
            // debugger;
            StartLoader('#bodyPreloader')
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
                if (myArray[0] == "True") {
                    window.open('../Email/SendEmail.aspx?MessageID=3&TimeSheetID=' + ProjectTimesheetID + '&ProjectID=' + ProjectID + '&UserID=' + UserID, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500');
                }
                //debugger;
                ViewProjectTimesheet();
                PlotActionLinkConditionally();
                StopAjaxLoader('#bodyPreloader')
                $("#ProjectTimesheetCurrentStatus").text("");
                $("#ProjectTimesheetCurrentStatus").text(myArray[1].trim());
                $("#ProjectTimesheetStatus").text(myArray[1].trim());
                if (myArray[1].trim() == "Rejected") {
                    $("#ProjectTimesheetCurrentStatus").css("color", "red");
                    $("#ProjectTimesheetStatus").css("color", "black");
                } else if (myArray[1].trim() == "Approved") {
                    $("#ProjectTimesheetCurrentStatus").css("color", "Green");
                    $("#ProjectTimesheetStatus").css("color", "black");
                }
                else {
                    $("#ProjectTimesheetCurrentStatus").css("color", "black");
                    $("#ProjectTimesheetStatus").css("color", "black");
                }
                alertify.success('<%= MyBase.GetResourceString("C_PTSFA")%>');
            }

        }

        //Added By Dipali V On 2nd Oct 2023 For Validation Send for approval
        var Validate = 0;
        function validateSFA() {
            //debugger;
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
                    // if (myArray[1] == "") {
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
                        //End  of Added By Dipali V On 25th Oct 2023 For Remove Space and Get Proper alert
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
        //Added By Dipali V On 2nd Oct 2023 For ReGenrate
        //function ReGenerateTimesheet() {
        $("#re_generate").on("click", function () {
            //debugger;
            var TimesheetNo = "";
            var ExtraTask = 0;
            //var Isvalidate = validateSFA();
            // var Isvalidate = 0;
            //if (Isvalidate == 0) {
            //Modified By Dipali V On 1st Nov 2023 For Regenerated
            //var GenerateCount = GetTimesheetGenerateCount(ProjectTimesheetID)
            var GenerateCount = GetTimesheetGenerateCount(ProjectTimesheetID);
            GetGenerateCount = GenerateCount.split("&&&&");
            TotalCountTS = GetGenerateCount[0];
            TotalModifiedTSCount = GetGenerateCount[1];
            //End of Modified By Dipali V On 1st Nov 2023 For Regenerated
              //Modified By Dipali V On 1st Nov 2023 For Regenerated

            //var FromDate = $("#ProjectFromdate").text();
            //var ToDate = $("#ProjectTodate").text();
            //var Parameters = {
            //    TimesheetNo: encodeURI(ProjectTimesheetID),
            //    ProjectID: encodeURI(ProjectID),
            //    UserID: encodeURI(UserID),
            //    FromDate: encodeURI(FromDate.trim()),
            //    ToDate: encodeURI(ToDate.trim())
            //}
            //var param = JSON.stringify(Parameters);
            //var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/RegenrateTimesheet", param, false);
          
            ////debugger;
            //if (strResult != undefined) {
            //    TimesheetNo = strResult;
            //}
            //var RegenrateCount = GetTimesheetGenerateCount(TimesheetNo);

            //ExtraTask = parseInt(RegenrateCount) - parseInt(GenerateCount);
            //if (ExtraTask > 0) {
            //End of Modified By Dipali V On 1st Nov 2023 For Regenerated

            if (TotalModifiedTSCount > 0) {
                $("#RMmodal").modal('show');
               // $("#spnalert").text('<%= MyBase.GetResourceString("C_RegenrateNote")%>');
                //$("#spnalert").text("'Re-Generate' will undo any modifications made through 'EASY EDIT' or 'SMART EDIT'.Do you want to continue?");
                $("#spnalert").html("'Re-Generate' will undo all <b> modifications </b> made by you .Do you want to continue?");
            }
            else
            {
                //SaveBillingInformation();
                RegenerateTimesheet();
            }
            //}

        });

        function RegenerateTimesheet()
        {
            var FromDate = $("#ProjectFromdate").text();
            var ToDate = $("#ProjectTodate").text();
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID),
                FromDate: FromDate.trim(),
                ToDate: ToDate.trim()
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/RegenrateTimesheet", param, false);
            //debugger;
            if (strResult != undefined) {
                ProjectTimesheetID = strResult;
                $("#SpnProjectTimesheetID").text("")
                $("#SpnProjectTimesheetID").text(ProjectTimesheetID)
                ViewProjectTimesheet();
                PlotActionLinkConditionally();
                alertify.success('<%= MyBase.GetResourceString("C_PTRG")%>');
            }
        }

        //Added By Dipali V On 2nd Oct 2023 For Regenrate
        function Regenrate_OnClick(Flag) {
            if (Flag == 1) {
                //SaveBillingInformation();
                RegenerateTimesheet();
                $("#RMmodal").modal('hide');
            } else {
                $("#RMmodal").modal('hide');
            }
        }




        //Added By Dipali V On 11st Oct 2023 after Regenrate Update Billing Details
        function SaveBillingInformation() {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                ProjectID: encodeURI(ProjectID),
                UserID: encodeURI(UserID)

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/SaveBillingInformation", param, false);
            if (strResult != undefined) {
                ViewProjectTimesheet();
                PlotActionLinkConditionally();
                alertify.success('<%= MyBase.GetResourceString("C_PTRG")%>');
            }

        }

        //Added By Dipali V On 2nd Oct 2023 For Regenrate
        $("#update_wsr").on("click", function () {
            var WSRCheckedCheckbox = $('input[name="WSRCheckbox"]:checked').map(function () {
                return this.value;
            }).get().join(",");
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                WSRCheckedCheckbox: encodeURI(WSRCheckedCheckbox)

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/UpdateWSR", param, false);
            if (strResult != undefined) {
                if (strResult == "1") {
                    alertify.success('<%= MyBase.GetResourceString("C_PTUpdateWSR")%>');
                    ViewProjectTimesheet();
                    PlotActionLinkConditionally();
                }
            }

        });
        //Added By Dipali V On 2nd Oct 2023 For Easy Edit
        //Added By Dipali V On 25th Oct 2023 For Clear Filter
        var FromWhereEmployeeFilter = "";
        //End of Added By Dipali V On 25th Oct 2023 For Clear Filter
        $("#easy_edit_tab").on("click", function () {
            //Added By Dipali V On 25th Oct 2023 For Clear Filter
            $("#select_Update_EMP").val(0);
            //End of Added By Dipali V On 25th Oct 2023 For Clear Filter
            GetRoleEmployeeNameFilter();
            GetEasyEditTaskDetails();
        });
        //Added By Dipali V On 25th Oct 2023 For Apply Filter
        function EmployeeFilter_onchange() {
            FromWhereEmployeeFilter = "FromPage"
            if ($("#CboEasyEdit").val() != 0) {
                $("#CboEasyEdit").val(0);
            }
            if ($("#CboEasyEditEmployeeName").val() != 0) {
                $("#CboEasyEditEmployeeName").val(0);
            }
            if ($("#cboRole").val() != 0) {
                $("#cboRole").val(0);
            }
            $("#fromDateFilter").val('');
            $("#toDateFilter").val('');
            $(".selectpicker").selectpicker('refresh');
            GetEasyEditTaskDetails();

        }
        //End of Added By Dipali V On 25th Oct 2023 For Apply Filter
        var arrTimesheetID = [];
        //Added By Dipali V On 11th Oct 2023 For Get Easy Edit Task Details
        function GetEasyEditTaskDetails() {
           // debugger;
            
            var RoleID = $("#cboRole").val();
            var FromDate = $("#fromDateFilter").val();
            var ToDate = $("#toDateFilter").val();
            //Added By Dipali V On 25th Oct 2023 For Apply Filter
            if (FromWhereEmployeeFilter == "FromPage") {
                var EmployeeID = $("#select_Update_EMP").val();
            }
            else if (FromWhereEmployeeFilter == "FromSmartEdit") {
                var EmployeeID = $("#CboEasyEditEmployeeName").val();
            }
            else {
                var EmployeeID = $("#CboEasyEdit").val();

            }

            //var RoleID = $("#cboRole").val();
            //var FromDate = $("#fromDateFilter").val();
            //var ToDate = $("#toDateFilter").val();
            //End of Added By Dipali V On 25th Oct 2023 For Apply Filter
            //if (RoleID == 0) {
            //    RoleID =""
            //}
            //if (EmployeeID == 0) {
            //    EmployeeID = 0
            //}
            if (FromDate == "") {
                FromDate = $("#EasyEditFromdate").text();
            } else {
                FromDate = FromDate;
            }
            if (ToDate == "") {
                ToDate = $("#EasyEditTodate").text();
            } else {
                ToDate = ToDate;
            }
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                RoleID: encodeURI(RoleID),
                EmployeeID: encodeURI(EmployeeID),
                FromDate: encodeURI(FromDate),
                ToDate: encodeURI(ToDate),

            }
            //debugger;
            var EmployeeName = "", EmployeeCode = "", EmployeeID = "";
            var ResourceTotal = "";
            var EntryDate = "";
            var PlannedWorkHHMM = "";
            var IsAllowSmartEdit = 0;
            var ResourceTotalHHMM = "";
            var WeeklyStatusEntrycheckbox = "";
            var ProjectTimesheetDetails = "";
            var param = JSON.stringify(Parameters);
            var StrResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetEasyEditTaskDetails", param, false);
            if (StrResult != undefined) {
                for (var i = 0; i < StrResult.length; i++) {
                    //  for (var i = 0; i < 10; i++) {
                    arrTimesheetID.push(parseInt(StrResult[i].TimeSheetID));
                    // }
                    IsAllowSmartEdit = StrResult[i].IsAllowSmartEdit;
                    if (StrResult[i].Description.length > 50) {
                        Description = StrResult[i].Description.slice(0, 50) + "...";
                    } else {
                        Description = StrResult[i].Description;
                    }

                    if (StrResult[i].WeeklyStatusEntry == "Yes") {
                        WeeklyStatusEntrycheckbox = "checked";
                    } else {
                        WeeklyStatusEntrycheckbox = "";
                    }

                    if (EmployeeName == "") {
                        ProjectTimesheetDetails += '<tr>';
                        ProjectTimesheetDetails += '<td colspan="7" class="text-start">';
                        ProjectTimesheetDetails += '<span class="float-start"><strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></span>';
                        ProjectTimesheetDetails += '<div class="float-end">';
                        ProjectTimesheetDetails += '<a href="javascript:;" class="text-end multi-edit" id="multi_edit" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Multi Edit" onclick="editAll_onClick(1)"><i class="fas fa-pencil-alt icon_style"></i> Multi Edit</a>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '</tr> ';

                        ProjectTimesheetDetails += '<tr class="edit-row" id="Tr' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<td class="noneditable">&nbsp;</td>';

                        /// if (EntryDate != StrResult[i].EntryDate) {
                        ProjectTimesheetDetails += '<td class="noneditable" id="TDEntryDate' + StrResult[i].TimeSheetID + '">' + StrResult[i].EntryDate + '</td>';
                        //}
                        //else {
                        //    ProjectTimesheetDetails += '<td>&nbsp;</td>';
                        //}
                        ProjectTimesheetDetails += '<td class="text-start noneditable" id="TDTask' + StrResult[i].TimeSheetID + '">' + StrResult[i].Task + '</td>';
                        ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + StrResult[i].Description + '"  id="TDDes' + StrResult[i].TimeSheetID + '" class="textarea">' + Description + '</td>';
                        ProjectTimesheetDetails += '<td id="TDAct' + StrResult[i].TimeSheetID + '">' + StrResult[i].DurationHHMM + '</td><input type="hidden" id="hiddenAct' + StrResult[i].TimeSheetID + '" value="' + StrResult[i].Duration + '"/><input type="hidden" id="hiddenHHMMAct' + StrResult[i].TimeSheetID + '" value="' + StrResult[i].DurationHHMM + '"/>';
                        ProjectTimesheetDetails += '<td class="toolactions noneditable"  id="TDWsr' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<div class="custom_chckbox chckbox-hide toolactions">';
                        ProjectTimesheetDetails += '<input id="CtrWsr' + StrResult[i].TimeSheetID + '" class="chckHead" type="checkbox" ' + WeeklyStatusEntrycheckbox + '> ';
                        ProjectTimesheetDetails += '<label for="CtrWsr' + StrResult[i].TimeSheetID + '" id="lblWsr' + StrResult[i].TimeSheetID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';

                        ProjectTimesheetDetails += '<td class="toolactionsTD noneditable" id="TDDel' + StrResult[i].TimeSheetID + '" > ';
                        ProjectTimesheetDetails += '<div class="toolactions noneditable">';
                        //Added By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<a href="javascript:;" class="edit" onclick="SingleEdit(' + StrResult[i].TimeSheetID + ')" id="CtrEdit' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Edit" data-bs-original-title="Edit"><i class="fas fa-pencil-alt icon_style"></i></a>';
                        //End of Added By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<div class="custom_chckbox chckbox-hide" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" aria-label="Delete" data-bs-original-title="Delete">';

                        ProjectTimesheetDetails += '<input id="CtrDel' + StrResult[i].TimeSheetID + '" class="chckHead" type="checkbox" name="EasyDeleteCheckbox" value="' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<label for="CtrDel' + StrResult[i].TimeSheetID + '" id="lblDel' + StrResult[i].TimeSheetID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '<a data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Close" href="javascript:;" class="cancelval me-2" id="CtrClose' + StrResult[i].TimeSheetID + '" style="display: none;" aria-label="Close" data-bs-original-title="Close"><i class="fas fa-times icon_style"></i></a>';
                        //Commented By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        // ProjectTimesheetDetails += '<a href="javascript:;" class="edit" onclick="SingleEdit(' + StrResult[i].TimeSheetID +')" id="CtrEdit' + StrResult[i].TimeSheetID +'" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Edit" data-bs-original-title="Edit"><i class="fas fa-pencil-alt icon_style"></i></a>';
                        //End of Commented By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<a href="javascript:;" class="saverow" onclick="SingleEditSave(' + StrResult[i].TimeSheetID + ')" id="CtrSave' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save" style="display: none;" aria-label="Save" data-bs-original-title="Save">';
                        ProjectTimesheetDetails += '<i class="far fa-save icon_style"></i>';
                        ProjectTimesheetDetails += '</a>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';


                        ProjectTimesheetDetails += '</tr>';

                        if (i == StrResult.length - 1) { // Only On Resource TS Generated for one Day
                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end">Total Actual Work (HH:MM) for <strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></td>';
                            ProjectTimesheetDetails += '<td class="pl-20"><strong>' + StrResult[i].ResourceTotalHHMM + '</strong></td>';
                            ProjectTimesheetDetails += '<td>&nbsp;</td><td>&nbsp;</td>';
                            ProjectTimesheetDetails += '</tr>';

                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end"><strong>Daily Activity Efforts(Billable & Non billable) / Timesheet Efforts(Billable) </strong></td>';//Added By Dipali V On 30th Oct 2023 to show actual
                            ProjectTimesheetDetails += '<td class="pl-20 text-center"><strong>' + StrResult[i].ActualTotalHHMM + ' / ' + StrResult[i].TotalHHMM + '  </strong></td>';
                            //Commented and added by Vishal Mane on 09/10/2024 to fix Filter Issue on Easy Edit tab
                            /*rojectTimesheetDetails += '<td>&nbsp;</td><td>&nbsp;</td>';*/
                            ProjectTimesheetDetails += '<td>&nbsp;</td><td>&nbsp;</td>';
                            //End of Commented and added by Vishal Mane on 09/10/2024 to fix Filter Issue on Easy Edit tab
                            ProjectTimesheetDetails += '</tr>';
                        }
                    }
                    else if (EmployeeName == StrResult[i].EmployeeName) {
                        ProjectTimesheetDetails += '<tr class="edit-row" id="task2Edit">';
                        ProjectTimesheetDetails += '<td class="noneditable">&nbsp;</td>';
                        /// if (EntryDate != StrResult[i].EntryDate) {
                        ProjectTimesheetDetails += '<td class="noneditable">' + StrResult[i].EntryDate + '</td>';
                        //}
                        //else {
                        //    ProjectTimesheetDetails += '<td>&nbsp;</td>';
                        //}
                        ProjectTimesheetDetails += '<td class="text-start noneditable" id="TDTask' + StrResult[i].TimeSheetID + '">' + StrResult[i].Task + '</td>';
                        ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + StrResult[i].Description + '"  id="TDDes' + StrResult[i].TimeSheetID + '">' + Description + '</td>';
                        ProjectTimesheetDetails += '<td id="TDAct' + StrResult[i].TimeSheetID + '">' + StrResult[i].DurationHHMM + '</td><input type="hidden" id="hiddenAct' + StrResult[i].TimeSheetID + '" value="' + StrResult[i].Duration + '"/><input type="hidden" id="hiddenHHMMAct' + StrResult[i].TimeSheetID + '" value="' + StrResult[i].DurationHHMM + '"/>';
                        ProjectTimesheetDetails += '<td class="toolactions noneditable"  id="TDWsr' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<div class="custom_chckbox chckbox-hide toolactions">';
                        ProjectTimesheetDetails += '<input id="CtrWsr' + StrResult[i].TimeSheetID + '" class="chckHead" type="checkbox" ' + WeeklyStatusEntrycheckbox + '>';
                        ProjectTimesheetDetails += '<label for="CtrWsr' + StrResult[i].TimeSheetID + '" id="lblWsr' + StrResult[i].TimeSheetID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';

                        ProjectTimesheetDetails += '<td class="toolactionsTD noneditable" id="TDDel' + StrResult[i].TimeSheetID + '" > ';
                        ProjectTimesheetDetails += '<div class="toolactions noneditable">';
                        //Added By By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<a href="javascript:;" class="edit" onclick="SingleEdit(' + StrResult[i].TimeSheetID + ')" id="CtrEdit' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Edit" data-bs-original-title="Edit"><i class="fas fa-pencil-alt icon_style"></i></a>';
                        //End of Added By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<div class="custom_chckbox chckbox-hide" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" aria-label="Delete" data-bs-original-title="Delete">';
                        ProjectTimesheetDetails += '<input id="CtrDel' + StrResult[i].TimeSheetID + '" class="chckHead" type="checkbox" name="EasyDeleteCheckbox" value="' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<label for="CtrDel' + StrResult[i].TimeSheetID + '" id="lblDel' + StrResult[i].TimeSheetID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '<a data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Close" href="javascript:;" class="cancelval me-2" id="CtrClose' + StrResult[i].TimeSheetID + '" style="display: none;" aria-label="Close" data-bs-original-title="Close"><i class="fas fa-times icon_style"></i></a>';
                        //Commented By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        //ProjectTimesheetDetails += '<a href="javascript:;" class="edit" onclick="SingleEdit(' + StrResult[i].TimeSheetID +')" id="CtrEdit' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Edit" data-bs-original-title="Edit"><i class="fas fa-pencil-alt icon_style"></i></a>';
                        //End of Commented By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<a href="javascript:;" class="saverow" onclick="SingleEditSave(' + StrResult[i].TimeSheetID + ')" id="CtrSave' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save" style="display: none;" aria-label="Save" data-bs-original-title="Save">';

                        ProjectTimesheetDetails += '<i class="far fa-save icon_style"></i>';
                        ProjectTimesheetDetails += '</a>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';


                        ProjectTimesheetDetails += '</tr>';
                        if (i == StrResult.length - 1) {
                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end">Total Actual Work (HH:MM) for <strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></td>';
                            ProjectTimesheetDetails += '<td class="pl-20"><strong>' + StrResult[i].ResourceTotalHHMM + '</strong></td>';
                            ProjectTimesheetDetails += '<td>&nbsp;</td><td>&nbsp;</td>';
                            ProjectTimesheetDetails += '</tr>';

                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="4" class="text-end"><strong>Daily Activity Efforts(Billable & Non billable) / Timesheet Efforts(Billable)</strong></td>';//Added By Dipali V On 30th Oct 2023 to show actual
                            ProjectTimesheetDetails += '<td class="pl-20 text-center"><strong>' + StrResult[i].ActualTotalHHMM + ' / ' + StrResult[i].TotalHHMM + ' </strong></td>';
                            ProjectTimesheetDetails += '<td>&nbsp;</td><td>&nbsp;</td>';
                            ProjectTimesheetDetails += '</tr>';
                        }
                    }
                    else if (EmployeeName != StrResult[i].EmployeeName) {
                        ProjectTimesheetDetails += '<tr class="total-row">';
                        ProjectTimesheetDetails += '<td colspan="4" class="text-end">Total Actual Work (HH:MM) for <strong>[' + EmployeeCode + '] - ' + EmployeeName + '</strong></td>';
                        ProjectTimesheetDetails += '<td class="pl-20"><strong>' + ResourceTotalHHMM + '</strong></td>';
                        ProjectTimesheetDetails += '<td>&nbsp;</td><td>&nbsp;</td>';
                        ProjectTimesheetDetails += '</tr>';
                        ProjectTimesheetDetails += '<tr>';
                        ProjectTimesheetDetails += '<td colspan="4" class="text-start">';
                        ProjectTimesheetDetails += '<span class="float-start"><strong>[' + StrResult[i].EmployeeCode + '] - ' + StrResult[i].EmployeeName + '</strong></span>';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '<td>&nbsp;</td><td>&nbsp;</td>';
                        ProjectTimesheetDetails += '</tr>';
                        ProjectTimesheetDetails += '<tr class="edit-row" id="Tr' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<td class="noneditable">&nbsp;</td>';

                        /// if (EntryDate != StrResult[i].EntryDate) {
                        ProjectTimesheetDetails += '<td class="noneditable" id="TDEntryDate' + StrResult[i].TimeSheetID + '">' + StrResult[i].EntryDate + '</td>';
                        //}
                        //else {
                        //    ProjectTimesheetDetails += '<td>&nbsp;</td>';
                        //}
                        ProjectTimesheetDetails += '<td class="text-start noneditable" id="TDTask' + StrResult[i].TimeSheetID + '">' + StrResult[i].Task + '</td>';
                        ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + StrResult[i].Description + '"  id="TDDes' + StrResult[i].TimeSheetID + '">' + Description + '</td>';
                        ProjectTimesheetDetails += '<td id="TDAct' + StrResult[i].TimeSheetID + '">' + StrResult[i].DurationHHMM + '</td><input type="hidden" id="hiddenAct' + StrResult[i].TimeSheetID + '" value="' + StrResult[i].Duration + '"/><input type="hidden" id="hiddenHHMMAct' + StrResult[i].TimeSheetID + '" value="' + StrResult[i].DurationHHMM + '"/>';
                        ProjectTimesheetDetails += '<td class="toolactions noneditable"  id="TDWsr' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<div class="custom_chckbox chckbox-hide toolactions">';
                        ProjectTimesheetDetails += '<input id="CtrWsr' + StrResult[i].TimeSheetID + '" class="chckHead" type="checkbox" ' + WeeklyStatusEntrycheckbox + '>';
                        ProjectTimesheetDetails += '<label for="CtrWsr' + StrResult[i].TimeSheetID + '" id="lblWsr' + StrResult[i].TimeSheetID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';

                        ProjectTimesheetDetails += '<td class="toolactionsTD noneditable" id="TDDel' + StrResult[i].TimeSheetID + '" > ';
                        ProjectTimesheetDetails += '<div class="toolactions noneditable">';
                        //Added By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<a href="javascript:;" class="edit" onclick="SingleEdit(' + StrResult[i].TimeSheetID + ')" id="CtrEdit' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Edit" data-bs-original-title="Edit"><i class="fas fa-pencil-alt icon_style"></i></a>';
                        //End of Added By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<div class="custom_chckbox chckbox-hide" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" aria-label="Delete" data-bs-original-title="Delete">';
                        ProjectTimesheetDetails += '<input id="CtrDel' + StrResult[i].TimeSheetID + '" class="chckHead" type="checkbox" name="EasyDeleteCheckbox" value="' + StrResult[i].TimeSheetID + '">';
                        ProjectTimesheetDetails += '<label for="CtrDel' + StrResult[i].TimeSheetID + '" id="lblDel' + StrResult[i].TimeSheetID + '"></label>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '<a data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Close" href="javascript:;" class="cancelval me-2" id="CtrClose' + StrResult[i].TimeSheetID + '" style="display: none;" aria-label="Close" data-bs-original-title="Close"><i class="fas fa-times icon_style"></i></a>';
                        //Commented By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        //ProjectTimesheetDetails += '<a href="javascript:;" class="edit" onclick="SingleEdit(' + StrResult[i].TimeSheetID +')" id="CtrEdit' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Edit" data-bs-original-title="Edit"><i class="fas fa-pencil-alt icon_style"></i></a>';
                        //End of Commented By Dipali V On 30th Oct 2023 For Change positon of Edit Button
                        ProjectTimesheetDetails += '<a href="javascript:;" class="saverow" onclick="SingleEditSave(' + StrResult[i].TimeSheetID + ')" id="CtrSave' + StrResult[i].TimeSheetID + '" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save" style="display: none;" aria-label="Save" data-bs-original-title="Save">';
                        ProjectTimesheetDetails += '<i class="far fa-save icon_style"></i>';
                        ProjectTimesheetDetails += '</a>';
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';


                        ProjectTimesheetDetails += '</tr>';
                    }
                    EmployeeName = StrResult[i].EmployeeName;
                    EmployeeCode = StrResult[i].EmployeeCode;
                    EmployeeID = StrResult[i].EmployeeID;
                    PlannedWorkHHMM = StrResult[i].PlannedWorkHHMM;
                    ResourceTotalHHMM = StrResult[i].ResourceTotalHHMM;
                    EntryDate = StrResult[i].EntryDate;
                }

            }

            $("#TBODYEasyEdit").html(ProjectTimesheetDetails);
            $('[data-bs-toggle="tooltip"]').tooltip()
            if (IsAllowSmartEdit == true) {
                $("#Edit_Note_accordion").show();
            } else {
                $("#Edit_Note_accordion").hide();
            }
        }


        //Added By Dipali V On 3rd Oct 2023 For Get EmployeeName & Role Filter
        function GetRoleEmployeeNameFilter() {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetRoleEmployeeNameFilter", param, false);
            var EmployeeDetails = strResult.EmployeeDetails
            var RoleDetails = strResult.RoleList

            for (var i = 0; i < EmployeeDetails.length; i++) {
                var objCbo1 = document.getElementById("CboEasyEditEmployeeName");
                var objCbo2 = document.getElementById("CboEasyEdit");

                $("#CboEasyEditEmployeeName option").remove();
                $("#CboEasyEdit option").remove();
                $("#CboEasyEdit option").remove();
                $("#CboEasyEditEmployeeName").append('<option value="0">Select  Employee Name</option>');
                $("#CboEasyEdit").append('<option value="0">Select  Employee Name</option>');
                for (var i = 0; i < EmployeeDetails.length; i++) {
                    var ObjStatus = EmployeeDetails[i];
                    var objOption = document.createElement("OPTION");
                    var objOption1 = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objCbo2.options.add(objOption1);
                    objOption.text = ObjStatus.EmployeeName;
                    objOption.value = ObjStatus.EmployeeID;

                    objOption1.text = ObjStatus.EmployeeName;
                    objOption1.value = ObjStatus.EmployeeID;
                }
            }

            for (var i = 0; i < RoleDetails.length; i++) {
                var objCbo1 = document.getElementById("cboRole");
                $("#cboRole option").remove();
                $("#cboRole").append('<option value="0">Select Role</option>');
                for (var i = 0; i < RoleDetails.length; i++) {
                    var ObjStatus = RoleDetails[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = ObjStatus.RoleDescription;
                    objOption.value = ObjStatus.RoleID;
                }
            }

            $(".selectpicker").selectpicker('refresh');
        }

        //Added By Dipali V On 3rd Oct 2023 For Checked ALL respective WSR checkbox
        function checkwsr(EmployeeID) {
            if ($("#totalChcked_" + EmployeeID).prop("checked") == true) {
                $(".WSRCheckbox_" + EmployeeID).prop("checked", true);
            } else {
                $(".WSRCheckbox_" + EmployeeID).prop("checked", false);
            }
        }

        function WSR_Checkbox(EmployeeID, TimeSheetID) {

            var LenghtChecked = $('input.WSRCheckbox_' + EmployeeID).length;
            var checked_boxes = $('input.WSRCheckbox_' + EmployeeID + ':checked').length
            if (LenghtChecked == checked_boxes) {
                $("#totalChcked_" + EmployeeID).prop("checked", true);
            } else {
                $("#totalChcked_" + EmployeeID).prop("checked", false);
            }

        }
        //Added By Dipali V On 3rd Oct 2023 For Delete Timesheet
        var DeletecheckedCheckbox = "";
        var DeleteFromWhere;
        $("#delete_btn").on("click", function () {

            DeletecheckedCheckbox = $('input[name="DeleteCheckbox"]:checked').map(function () {
                return this.value;
            }).get().join(",");

            if (DeletecheckedCheckbox.length == 0) {
                alertify.error('<%= MyBase.GetResourceString("C_AtLeastRecord")%>');
                return false;
            } else {
                DeleteFromWhere = "FromDetails"
                $("#deleteinfomodal").modal('show');
            }

        });

        //Added By Dipali V On 12nd Oct 2023 For Delete through  Easy Edit
        var DeleteEasycheckedCheckbox = "";
        $("#del_edit_btn").on('click', function () {

            DeleteEasycheckedCheckbox = $('input[name="EasyDeleteCheckbox"]:checked').map(function () {
                return this.value;
            }).get().join(",");

            if (DeleteEasycheckedCheckbox.length == 0) {
                //DeleteFromWhere == "FromEasyEdit"
                alertify.error('<%= MyBase.GetResourceString("C_AtLeastRecord")%>');
                return false;
            } else {
                DeleteFromWhere = "FromEasyEdit"
                $("#deleteinfomodal").modal('show');
            }

        });

        //Added By Dipali V On 3rd Oct 2023 For Delete Timesheet
        function DeleteTSData(Flag) {
            //debugger;
            if (DeleteFromWhere == "FromDetails") {
                if (Flag == 1) {
                    var Parameters = {
                        TimesheetNo: encodeURI(ProjectTimesheetID),
                        TimsheetIDs: encodeURI(DeletecheckedCheckbox),
                        ProjectID: encodeURI(ProjectID)

                    }
                    var param = JSON.stringify(Parameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/DeleteProjectTimesheetTask", param, false);
                    if (strResult != "") {
                        alertify.success(strResult[0].strResult);
                        ViewProjectTimesheet();
                        PlotActionLinkConditionally();
                        $('input[name="EasyDeleteCheckbox"]').prop('checked', false);
                        $('input[name="DeleteCheckbox"]').prop('checked', false);
                    }

                } else {
                    $("#deleteinfomodal").modal('hide');
                    $('input[name="EasyDeleteCheckbox"]').prop('checked', false);
                    $('input[name="DeleteCheckbox"]').prop('checked', false);
                    DeletecheckedCheckbox = "";
                    DeleteFromWhere = "";

                }
            } else {
                if (Flag == 1) {
                    var Parameters = {
                        TimesheetNo: encodeURI(ProjectTimesheetID),
                        TimsheetIDs: encodeURI(DeleteEasycheckedCheckbox),
                        ProjectID: encodeURI(ProjectID)

                    }
                    var param = JSON.stringify(Parameters);
                    var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/DeleteProjectTimesheetTask", param, false);
                    if (strResult != "") {
                        alertify.success(strResult[0].strResult);
                        //debugger;
                        ViewProjectTimesheet();
                        PlotActionLinkConditionally();
                        GetEasyEditTaskDetails();
                        $('input[name="EasyDeleteCheckbox"]').prop('checked', false);
                        $('input[name="DeleteCheckbox"]').prop('checked', false);
                    }

                } else {
                    $('input[name="EasyDeleteCheckbox"]').prop('checked', false);
                    $('input[name="DeleteCheckbox"]').prop('checked', false);
                    $("#deleteinfomodal").modal('hide');
                    DeleteEasycheckedCheckbox = "";
                    DeleteFromWhere = "";

                }
            }

        }


        //Added By Dipali V On 2nd Oct 2023 For Validation Send for approval
        function GetTimesheetGenerateCount(ProjectTimesheetID) {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),

            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetTimesheetGenerateCount", param, false);
            if (strResult != undefined) {
                //debugger;
                for (var i = 0; i < strResult.length; i++) {
                    TotalCountTS = strResult[i].TotalCountTS
                    TotalModifiedTSCount = strResult[i].TotalModifiedTSCount
                }
            }
            return TotalCountTS + "&&&&" + TotalModifiedTSCount
        }


        //Added By Dipali V On 27th Sep 2023 For  Special characters 
        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                //regularExpression += '"';
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

        //Remove Duplicate From Array 
        function unique(array) {
            return array.filter(function (el, index, arr) {
                return index == arr.indexOf(el);
            });
        }

        //Added By Dipali V On 27th Sep 2023 For  Get History 
        $("#History_tab").on("click", function () {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID),
                TagID: 1049
            }
            var param = JSON.stringify(Parameters);
            $("#tbodyhistory").html('');
            var HistoryHTML = "";
            var HistoryDetails = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetShowHistory", param, false);
            for (var i = 0; i < HistoryDetails.length; i++) {
                HistoryHTML += "<tr><td> " + HistoryDetails[i].FieldName + " </td><td>" + HistoryDetails[i].Date + "</td><td>" + HistoryDetails[i].OldValue + "</td><td>" + HistoryDetails[i].NewValue + "</td><td>" + HistoryDetails[i].ModifiedBy + "</td></tr>";
            }

            $("#tbodyhistory").html(HistoryHTML);
            $('#Show_History_Tbl').dataTable({
                "scroller": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true
            });
        });



        ////$("#site_calender").on("click", function () {
        ////    GetProjectSites();
        ////    var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_sitecalendarModal'));
        ////    myOffcanvas.show();

        ////    var calendar = $("#siteCalendarView").calendarGC({
        ////        dayBegin: 1,
        ////        nextIcon: '&gt;',
        ////        prevIcon: '&lt;',
        ////        events: getHoliday(),
        ////        onclickDate: function (e, data) {
        ////            $('#SCDetailsModal').modal('show');
        ////        }

        ////    });

        ////});


        //Added By Dipali V On 17th Oct 2023  For Project Site
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
        }
        //End of Added By Dipali V On 10th Oct 2023  For Project Site


        //datepicker
        $('#fromDateFilter, #toDateFilter').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });

        //Added By Dipali V On 26th Sep 2023 For Select All
        function wsrcheckall() {
            $(".mainchck").prop('checked', true);
            $(".chckHead").prop('checked', true);//Added By Dipali V on 31st Oct 2023 For Check box clear issue
        }

        //Added By Dipali V On 26th Sep 2023 For Clear All
        function wsruncheckall() {
            $(".mainchck").prop('checked', false);
            $(".chckHead").prop('checked', false);//Added By Dipali V on 31st Oct 2023 For Check box clear issue
        }

        //Added By Dipali V On 26th Sep 2023 For Navigate to Project List Page
        function back_Onclick() {
            window.location.href = "../PM/PM_ProjectTimesheetlist.aspx?MasterTagId=36081&ProjectID=" + ProjectID + "";


        }

        $(".saverow, .cancelval").hide();
        //Start end add edit delete
        //$(document).on("click", ".saverow", function () {
        //    var empty = false;
        //    var input = $(this).parents("tr").find('input[type="text"]');
        //    var select = $(this).parents("tr").find('select');
        //    var textarea = $(this).parents("tr").find('textArea');
        //    input.each(function () {
        //        if (!$(this).val()) {
        //            $(this).addClass("error");
        //            empty = true;
        //        } else {
        //            $(this).removeClass("error");
        //        }
        //    });
        //    textarea.each(function () {
        //        if (!$(this).val()) {
        //            $(this).addClass("error");
        //            empty2 = true;
        //        } else {
        //            $(this).removeClass("error");
        //        }
        //    });
        //    $(this).parents("tr").find(".error").first().focus();
        //    if (!empty) {
        //        input.each(function () {
        //            $(this).parent("td").html($(this).val());
        //        });
        //        textarea.each(function () {
        //            $(this).parent("td").html($(this).val());
        //        });
        //        $(this).parents("tr").find(".saverow, .edit").toggle();
        //        $(this).parents("tr").find(".cancelval, .chckbox-hide").toggle();
        //        // $(this).parents("tr").find(".chckbox-hide").show();

        //        //$(".add-new").removeAttr("disabled");
        //    }
        //});
        // Edit row on edit button click
        $(document).on("click", ".edit", function () {
            //debugger;
            //var cnt = 1;
            //$(this).parents("tr").find("td:not(.noneditable)").each(function () {
            //    if (cnt == 1) {
            //        $(this).html('<textarea class="form-control">' + $(this).text() + '</textarea>');
            //        cnt++;
            //    }

            //    else if (cnt == 1) {
            //        $(this).html('<div class="custom_chckbox"><input id ="wsrChck" class="chckHead" type = "checkbox"><label for="wsrChck"></label></div>');
            //        cnt++;
            //    }

            //    else {
            //        $(this).html('<input type="text" class="form-control" value="' + $(this).text() + '">');
            //        cnt++;
            //    }
            //});

            $(this).parents("tr").find(".saverow, .edit").toggle();
            $(this).parents("tr").find(".cancelval, .chckbox-hide").toggle();
            // $(".add-new").attr("disabled", "disabled");
        });

        //Commented & Added By Dipali V On 12nd Oct 2023 For Easy Edit Multi Update
        //$(document).on("click", ".multi-edit", function () {
        //    var cnt = 5;
        //    $(".edit-row").find("td:not(.noneditable)").each(function ()
        //    {
        //        debugger;
        //        if (cnt == 5) {
        //            $(this).html('<textarea class="form-control">' + $(this).text() + '</textarea>');
        //            cnt++;
        //        }
        //        else if (cnt == 1) {
        //            $(this).html('<div class="custom_chckbox"><input id ="wsrChck" class="chckHead" type = "checkbox"><label for="wsrChck"></label></div>');
        //            cnt++;
        //        }
        //        else {
        //            $(this).html('<input type="text" class="form-control" value="' + $(this).val() + '">');
        //            cnt++;
        //        }
        //    });

        //    $(this).parents("tr").find(".saverow, .cancelval, .multi-edit").toggle();

        //    $(this).parents("tr").find(".cancelval, .multi-edit").toggle();
        //});


        var FromWhereFlagEasyEditAll = 0;
        function editAll_onClick(Flag) {
            FromWhereFlagEasyEditAll = 1;
            var TimeSheetIDs = unique(arrTimesheetID);
            var count = 0;
            while (count < TimeSheetIDs.length) {
                appendControl("Des" + TimeSheetIDs[count], "textArea", "Des");
                appendControl("Act" + TimeSheetIDs[count], "text", "Act");
                //appendControl("Wsr" + TimeSheetIDs[count], "checkbox", "Wsr");
                //appendControl("Del" + TimeSheetIDs[count], "checkbox", "Del");
                count++;
            }
        }



        function appendControl(args, ctrlType, shortCtrlName) {
            // debugger;
            var lblValue;
            var lblCtrl;
            //var objTD = GetObjectReference('frmTimeSheetEasyEntry', "TD" + args)
            var objTD = $("#TD" + args);

            if (objTD) {
                objTD.align = "center";
                lblCtrl = $("#TD" + args);
                lblValue = "";
                if (lblCtrl) {
                    if (navigator.appName == 'Microsoft Internet Explorer') {
                        lblValue = lblCtrl.val();

                        if (ctrlType == "text") {
                            if (lblCtrl.text() != "") {
                                lblValue = lblCtrl.text();
                            } else {
                                lblValue = $("#ctr" + args).val();
                            }
                        }
                        else if (ctrlType == "textArea") {
                            var Text = lblCtrl.attr("data-bs-original-title");
                            if (lblCtrl.text() != "") {
                                //lblValue = lblCtrl.text();
                                lblValue = Text
                            } else {
                                lblValue = $("#ctr" + args).val();
                            }

                        }
                    }
                    else {
                        // lblValue = lblCtrl.textContent;
                        if (ctrlType == "text") {
                            if (lblCtrl.text() != "") {
                                lblValue = lblCtrl.text();
                            } else {
                                lblValue = $("#ctr" + args).val();
                            }
                        }
                        else if (ctrlType == "textArea") {
                            var Text = lblCtrl.attr("data-bs-original-title");
                            if (lblCtrl.text() != "") {
                                //lblValue = lblCtrl.text();
                                lblValue = Text
                            } else {
                                lblValue = $("#ctr" + args).val();
                            }

                        }
                    }
                }
                var control;
                var objControl;
                if (ctrlType == "textArea") {
                    //debugger;
                    control = document.createElement("TEXTAREA")
                    control.id = "ctr" + args;
                    control.name = "ctr" + args;
                    if (lblValue == undefined || lblValue == "undefined") {
                        control.value = "";
                    } else {
                        control.value = lblValue;
                    }

                    //control.wrap="hard";
                }

                if (ctrlType == "text") {
                    control = document.createElement("INPUT");
                    control.type = ctrlType;
                    control.id = "ctr" + args;
                    control.name = "ctr" + args;
                    //control.onblur = function () {

                    //    validateWorkHours(this.id.val());
                    //    $(this.id).focus();
                    //    $(this.id).focus();
                    //};
                    if (isBlank(lblValue.substring(lblValue.lastIndexOf(" ")))) {
                        lblValue = lblValue.substring(0, lblValue.lastIndexOf(" "))
                        control.value = lblValue;
                    }

                }
                //if (ctrlType == "checkbox") {
                //    control = document.createElement("INPUT");
                //    control.type = ctrlType;
                //    control.id = "ctr" + args;
                //    control.name = "ctr" + args;
                //    if (lblValue.search("Yes") == 0)
                //        lblValue = 1;
                //    else
                //        lblValue = 0;
                //    control.value = lblValue;
                //}
                // objTD.html = "";
                $(objTD).html("");
                objTD.append(control);
                objControl = document.getElementById(control.id);
                if (shortCtrlName == "Des") {
                    objControl.cols = 30;
                    objControl.rows = 3;
                    //objControl.ma = 500;
                    objControl.className = "form-control";
                    document.getElementById(control.id).maxLength = "500";

                }

                if (shortCtrlName == "Act") {
                    objControl.value = lblValue;
                    objControl.className = "form-control";
                }

                //if (shortCtrlName == "Wsr") {
                //    if (lblValue == 1) {
                //        objControl.checked = true;
                //    }

                //}
            }

        }

        //End of Commented & Added By Dipali V On 12nd Oct 2023 For Easy Edit Multi Update

        //Added By Dipali V On 12nd Oct 2023 For Save Multiple Easy Edit
        $("#sv_easy_edit").on('click', function () {
            var TimeSheetIDs = unique(arrTimesheetID);
            var count = 0;
            //debugger;
            var IsValidated = 0;
            var WSRCheckedCheckbox = 0;
            //StartLoader('#bodyPreloader');
            while (count < TimeSheetIDs.length) {
                //if (FromWhereFlagEasyEditAll == 1) {
                //var ActualWork = $("#ctrAct" + TimeSheetIDs[count]).val();
                //var Ctrl = $("#ctrAct" + TimeSheetIDs[count]);
                /* var ControlID = ("ctrAct" + TimeSheetIDs[count]);*/
                //if (validateWorkHours(ActualWork, Ctrl) == false)
                //{
                //    $("#ctrAct" + TimeSheetIDs[count]).focus();
                //    IsValidated = 1;
                //    return false;
                //}
                if (FromWhereFlagEasyEditAll == 1) {
                    var ControlID = ("ctrAct" + TimeSheetIDs[count]);
                    if (WorkHoursValidation(ControlID) == false) {
                        $("#ctrAct" + TimeSheetIDs[count]).focus();
                        IsValidated = 1;
                        return false;
                    }
                    else {
                        if (FromWhereFlagEasyEditAll == 1) {
                            var Description = $("#ctrDes" + TimeSheetIDs[count]).val();
                            var ActualWork = $("#ctrAct" + TimeSheetIDs[count]).val();
                        } else {
                            var Description = $("#TDDes" + TimeSheetIDs[count]).text();
                            var ActualWork = $("#hiddenAct" + TimeSheetIDs[count]).val();
                        }


                        if ($("#CtrWsr" + TimeSheetIDs[count]).is(':checked')) {
                            WSRCheckedCheckbox = 1;
                        } else {
                            WSRCheckedCheckbox = 0;
                        }
                        //console.log(WSRCheckedCheckbox);
                        //console.log(ProjectID);
                        var Parameters = {
                            TimesheetID: encodeURI(TimeSheetIDs[count]),
                            TimesheetNo: encodeURI(ProjectTimesheetID),
                            Description: Description,
                            ActualWork: ActualWork,
                            ProjectID: ProjectID,
                            WSRCheckedCheckbox: encodeURI(WSRCheckedCheckbox)

                        }
                        var param = JSON.stringify(Parameters);
                        var StrResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/SaveEasyEdit", param, false);
                        if (StrResult != "") {

                        }

                    }
                }
                else {
                    if (IsValidated == 0) {
                        //debugger;
                        if (FromWhereFlagEasyEditAll == 1) {
                            var Description = $("#ctrDes" + TimeSheetIDs[count]).val();
                            var ActualWork = $("#ctrAct" + TimeSheetIDs[count]).val();
                        } else {
                            var Description = $("#TDDes" + TimeSheetIDs[count]).text();
                            var ActualWork = $("#hiddenAct" + TimeSheetIDs[count]).val();
                        }


                        if ($("#CtrWsr" + TimeSheetIDs[count]).is(':checked')) {
                            WSRCheckedCheckbox = 1;
                        } else {
                            WSRCheckedCheckbox = 0;
                        }
                        var Parameters = {
                            TimesheetID: encodeURI(TimeSheetIDs[count]),
                            TimesheetNo: encodeURI(ProjectTimesheetID),
                            Description: Description,
                            ActualWork: ActualWork,
                            ProjectID: ProjectID,
                            WSRCheckedCheckbox: encodeURI(WSRCheckedCheckbox)

                        }
                        var param = JSON.stringify(Parameters);
                        var StrResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/SaveEasyEdit", param, false);
                        if (StrResult != "") {
                        }
                    }
                }
                count++;
            }

            if (IsValidated == 0) {
                alertify.success('<%= MyBase.GetResourceString("C_DataSaved")%>');
                ViewProjectTimesheet();
                GetEasyEditTaskDetails();
                PlotActionLinkConditionally();
                FromWhereFlagEasyEditAll = 0;
            }

        });
        //End of Added By Dipali V On 12nd Oct 2023 For Save Multiple Easy Edit

        $("#CboEasyEditEmployeeName").on("change", function () {
            FromWhereEmployeeFilter = "FromSmartEdit"
            GetEasyEditTaskDetails();
            GetResourceDuration();
            $("#CboEasyEdit").val("0");
            $("#select_Update_EMP").val("0");
            $(".selectpicker").selectpicker('refresh');

        });

        //Added By Dipali V On 12nd Oct 2023 For Get Duration of selected resource
        function GetResourceDuration() {
            // debugger;
            var EmployeeID = $("#CboEasyEditEmployeeName").val();
            var ActualWork = $("#FilterHrs").val();
            // var Ctrl = $("#FilterHrs");
            var ControlID = ("FilterHrs");
            if (ActualWork != "") {
                //if (validateWorkHours(ActualWork, Ctrl) == false) {
                //    //$("#FilterHrs").focus();
                //    return false;
                //}
                if (WorkHoursValidation(ControlID) == false) {
                    $("#FilterHrs").focus();
                    return false;
                }
                else {
                    if (EmployeeID != "0" && ActualWork != "") {
                        var Parameters =
                        {
                            TimesheetNo: encodeURI(ProjectTimesheetID),
                            EmployeeID: EmployeeID,
                            ProjectID: ProjectID,
                            ActualWork: ActualWork,
                        }
                        var param = JSON.stringify(Parameters);
                        var StrResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/GetResourceDuration", param, false);
                        if (StrResult != "") {

                            $(".Total_Entry").text(StrResult);
                        }
                    }
                }
            }
        }
        //End of Added By Dipali V On 12nd Oct 2023 For Get Duration of selected resource



        function validateWorkHours(ActualWork, CtrlID) {

            var checkFlag = true;
            var blnHMFormat = true;
            var objVal = ActualWork;
            ActualWork = ActualWork.replace(":", ".");
            var isdigit = isNumeric(ActualWork);

            if (isdigit == false) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("C_ActualHHMM")%>', 'error', 5);
                checkFlag = false;
                return checkFlag;
            }

            ActualWork = objVal;
            if (ActualWork.indexOf(":") == -1) {
                ActualWork = objVal + ':00';
                CtrlID.val(ActualWork);
            }
            ActualWork = objVal;
            var WorkHour = ActualWork;
            WorkHour = WorkHour.trim();
            var idxColon = WorkHour.indexOf(':');
            var hrs = WorkHour.substring(0, idxColon);
            var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

            if (mins.length == 1 && mins > 5) {
                mins = mins + "0";
            }
            if (ActualWork == 0 && checkFlag == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("C_HrsGreaterThanZero")%>');
                blnHMFormat = false;
                checkFlag = false;
            }

            if (blnHMFormat == true && checkFlag == true) {
                if (mins == "") {
                    alertify.error('<%= MyBase.GetResourceString("C_ActualHHMM")%>');
                    blnHMFormat = false;
                    checkFlag = false;
                    return checkFlag;
                }

                if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                    alertify.error('<%= MyBase.GetResourceString("CHoursGreaterZero")%>');
                    blnHMFormat = false;
                    checkFlag = false;
                    return checkFlag;
                }

                if (blnHMFormat == true) {
                    if (mins.length > 2) {
                        alertify.error('<%= MyBase.GetResourceString("C_MinValidation")%>');
                        blnHMFormat = false;
                        checkFlag = false;
                        return checkFlag;
                    }
                }

                if (blnHMFormat == true) {
                    if (mins > 59 || mins < 0) {
                        alertify.error('<%= MyBase.GetResourceString("C_Minrange")%>');
                        blnHMFormat = false;
                        checkFlag = false;
                        return checkFlag;
                    }
                }

            }
            if (ActualWork > 24 && checkFlag == true) {
                alertify.error('<%= MyBase.GetResourceString("C_EasyActuallessequalto24")%>');
                checkFlag = false;
                return checkFlag;
            }
            if (checkSpecialCharacter(ActualWork, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("C_SpecialChar")%> ' + WebConfigSpecialCharacters + ' characters');
                checkFlag = false;
                return checkFlag;
            }
            if (ActualWork.indexOf(':') > 0 && checkFlag == true) {
                var minHrsForDAEntryDec = GetMINDAValidation();
                var minHrsForDAEntry = 60 * minHrsForDAEntryDec;
                var workhrminPart = ActualWork.substring(ActualWork.indexOf(':') + 1);
                if (workhrminPart % minHrsForDAEntry != 0 || workhrminPart > 59) {
                    alertify.error('<%= MyBase.GetResourceString("C_Multiplication")%> ' + minHrsForDAEntry);
                    checkFlag = false;
                    return checkFlag;
                }
            }
            return checkFlag;
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

                if (objHMEffort.value > 24) {
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActuallessequalto24")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                if (isdigit == false) {
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];

                if (mm == "") {
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                    setFocus(objHMEffort);
                    return false;
                }
                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort, "");

                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort, "");
                //Please enter Work (hrs) in H:M format.
                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
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

                //alert(MinHoursForDAEntry);
                //alert(RestrictByMinHours);
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
                            alertify.error("<%= MyBase.GetResourceString("C_MultiplicationHours")%> (" + MinDAENtryDisplay + ") min");
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }

            }
            return true;
        }
        //End of  By Dipali V On 13rd Oct 2023 For Saving Billing Information Details


        function SingleEdit(TimesheetID) {
            FromWhereFlagEasyEditAll = 0;
            appendControl("Des" + TimesheetID, "textArea", "Des");
            appendControl("Act" + TimesheetID, "text", "Act");
        }

        function SingleEditSave(TimesheetID) {
            //debugger;
            var IsValidated = 0;
            var Oldvalue = $("#hiddenHHMMAct" + TimesheetID).val();
            var ControlID = ("ctrAct" + TimesheetID);
            if (WorkHoursValidation(ControlID) == false) {
                $("#ctrAct" + TimesheetID).focus();
                IsValidated = 1;
                $("#ctrAct" + TimesheetID).val(Oldvalue);
                $(this).parents("tr").find(".saverow, .edit").toggle();
                $(this).parents("tr").find(".cancelval, .chckbox-hide").toggle();
                return false;
            }
            else {
                var WSRCheckedCheckbox = 1;
                var Description = $("#ctrDes" + TimesheetID).val();
                var ActualWork = $("#ctrAct" + TimesheetID).val();
                var Parameters = {
                    TimesheetID: encodeURI(TimesheetID),
                    TimesheetNo: encodeURI(ProjectTimesheetID),
                    Description: Description,
                    ActualWork: ActualWork,
                    ProjectID: ProjectID,
                    WSRCheckedCheckbox: encodeURI(WSRCheckedCheckbox)

                }
                var param = JSON.stringify(Parameters);
                var StrResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/SaveEasyEdit", param, false);
                if (StrResult != "") {
                    alertify.success('<%= MyBase.GetResourceString("C_DataSaved")%>');
                    ViewProjectTimesheet();
                    GetEasyEditTaskDetails();
                    PlotActionLinkConditionally();
                    FromWhereFlagEasyEditAll = 0;
                }
            }

        }
        //Added By Dipali V On 12nd Oct 2023 For Apply Duration to selected resource
        function ApplyDuration() {
            //debugger;
            var EmployeeID = $("#CboEasyEditEmployeeName").val();
            var EasyEditEmployeeName = $("#CboEasyEditEmployeeName option:selected").text()
            var ActualWork = $("#FilterHrs").val().trim();
            var ControlID = ("FilterHrs");
            // var Ctrl = $("#FilterHrs");
            if (EmployeeID == "0") {
                alertify.error('<%= MyBase.GetResourceString("C_EasyEmplyeeName")%>');
                $("#CboEasyEditEmployeeName").focus();
                return false;
            }
            else if (ActualWork == "") {
                alertify.error('<%= MyBase.GetResourceString("C_EasyActualBlank")%>');
                $("#FilterHrs").focus();
                return false;
            }
            //else if (validateWorkHours(ActualWork, Ctrl) == false) {
            //    $("#FilterHrs").focus();
            //    return false;
            //}

            else if (WorkHoursValidation(ControlID) == false) {
                $("#FilterHrs").focus();
                return false;
            }
            else {

                if (EmployeeID != "0" && ActualWork != "") {
                    var Parameters =
                    {
                        TimesheetNo: encodeURI(ProjectTimesheetID),
                        EmployeeID: EmployeeID,
                        ProjectID: ProjectID,
                        ActualWork: ActualWork,
                    }
                    var param = JSON.stringify(Parameters);
                    var StrResult = AJAXCallWithResult("/api/PM_ProjectTimesheetDetails/ApplyDurationResource", param, false);
                    if (StrResult != "") {
                        alertify.success('<%= MyBase.GetResourceString("C_ActualHoursUpdatedSuccessfully")%> ' + EasyEditEmployeeName);
                        GetEasyEditTaskDetails();
                        ViewProjectTimesheet();
                        PlotActionLinkConditionally();
                        GetEmployeeDetails();
                        $("#FilterHrs").val('');
                        //Added By Dipali V On 26th Oct 2023 For Clear Textbox
                        $(".Total_Entry").text('00:00');
                        $("#CboEasyEditEmployeeName").val(0);
                        //End of Added By Dipali V On 26th Oct 2023 For Clear Textbox
                    }
                }
            }
        }


        //End of Added By Dipali V On 12nd Oct 2023 For Delete through Easy Edit
        //Added By Dipali V On 12nd Oct 2023 For Apply Filter On  Easy Edit
        function ApplyFilterEasyEdit() {
            FromWhereEmployeeFilter = "FromGrid"
            if ($("#select_Update_EMP").val() != 0) {
                $("#select_Update_EMP").val(0);
            }

            if ($("#CboEasyEditEmployeeName").val() != 0) {
                $("#CboEasyEditEmployeeName").val(0);
            }
            $(".selectpicker").selectpicker('refresh');
            GetEasyEditTaskDetails();
        }
        //End of Added By Dipali V On 12nd Oct 2023 For Apply Filter On  Easy Edit

        //Cancel row value
        $(document).on("click", ".cancelval ", function () {
            //debugger;
            var empty = false;
            var input = $(this).parents("tr").find('input[type="text"]');
            var textarea = $(this).parents("tr").find('textarea');
            var select = $(this).parents("tr").find('select');

            input.each(function () {
                $(this).parent("td").html($(this).val());
                $(this).parent("td").html();
            });
            select.each(function () {
                $(this).parent("td").html($(this).val());
            });
            textarea.each(function () {
                $(this).parent("td").html($(this).val());
            });

            $(this).parents("tr").find(".chckbox-hide, .cancelval").toggle();
            $(this).parents("tr").find(".edit").toggle();
            $(this).parents("tr").find(".saverow").toggle();
            $(this).parents("tr").find(".cancelval").css('width', '10px');

        });



        //end add edit delete

        // tbody height
        function resizeSection() {
            var listviewTreeHeight = $(window).height();
            $('.init_grid_panel').css({
                'height': listviewTreeHeight - 250,
                "overflow-y": "auto"
            });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
        //end script


        //function stageEdit() {
        //    var browser = navigator.appName;
        //    if (browser == "Microsoft Internet Explorer") {
        //        window.opener = self;
        //    }
        //    //window.open('Initialtive_details.aspx', 'null', 'width = 900, height = 350,toolbar = no, scrollbars = no, location = no, resizable = yes');
        //    window.open('email_template.html', 'null', 'width = 800, height = 550,toolbar = no, scrollbars = no, location = no, resizable = yes');
        //    window.moveTo(0, 0);
        //    window.resizeTo(screen.width, screen.height - 100);
        //    self.close();

        //}



        //Added By Dipali V On 26th Sep 2023 For Loader
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

        //Added By Dipali V On 26th Sep 2023 For Stop Loader
        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {

            });

        }

        //Added By Dipali V On 26th Sep 2023 For Ajax Call 
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


        //Added By Dipali V On 10th Oct 2023  For Site Calender

        var CMonth, CYear;
        var PMonth, PYear;
        var NMonth, NYear;
        var WeekDays, StartingDayOfWeek;
        var ExtraHoursCap, WorkHrs;
        var selecteddate;
        var Month, TodaysDate;
        var TodaysDate_Cur = "";
        var TodaysDate_Month = "";
        var ProjectSiteID = "";
        var StrMonthName;
        var GStrMonthName;
        var intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours
        function ShowSiteCalender() {
            //debugger;
            GetProjectSites();
            const date = new Date();
            let day = date.getDate();
            TodaysDate_Cur = day;
            //TodaysDate_Cur = TodaysDate[0];
            const date_M = new Date(Date.now());
            TodaysDate_Month = date_M.toLocaleString('en-US', { month: 'short' }); // {month:'long'}

            Month = date.getMonth() + 1;
            Year = date.getFullYear();
            StrMonthName = GetMonthName(Month);
            GStrMonthName = StrMonthName;//Added By Dipali V On 26th Dec 2023 For Get selected Month Name
            $("#selectDefaultSite").val(IsOffShoreSiteID);
            $(".selectpicker").selectpicker('refresh');
            if ($("#selectDefaultSite").val() != "0") {
                ProjectSiteID = $("#selectDefaultSite").val();
            } else {
                ProjectSiteID = IsOffShoreSiteID;

            }
            initializeSiteCalenderDetails(Month, Year, ProjectSiteID);
            strProjectName = $('#SpanProjectName').text();
            GenerateCalendarTable(Month, Year, ProjectID, intIndex, strProjectName, intTotalBookedHours, intTotalAllocatedHours, intWorkingHours);
            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_sitecalendarModal'));
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
                GStrMonthName = StrMonthName;//Added By Dipali V On 26th Dec 2023 For Get selected Month Name
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
                GStrMonthName = StrMonthName;//Added By Dipali V On 26th Dec 2023 For Get selected Month Name
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
            //debugger;
            if (Isholiday == 1) {
                $("#scdcheck1").prop("checked", true);
                $("#NormalHours").val(0);
                $("#ExtraHours").val(0);
            } else {
                $("#scdcheck1").prop("checked", false);
                $("#NormalHours").val(NormalHours);
                $("#ExtraHours").val(ExtraHours);
            }
            $('#SCDetailsModal').modal('show');
            $("#SelectedDate").text(Date + "-" + Month + "-" + Year);
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
            normaldays = "," + normaldaysLists + ",";
            strTable = strTable + " ";
            intDay = 1;
            for (intCount = startDay; intCount < 7; intCount++) {
                strTable = strTable + " ";
                strDate = new Date(intYear, intMonth - 1, intDay);
                strTable = strTable + " ";
                if (weekends.lastIndexOf(column) != -1) {
                    if (TodaysDate_Cur != "") {
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 14px; background:red bgcolor=#1359ac class=clsTRSectionWeekend " + TodayDateClass + ">";//
                    strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)' style='color:#38385c;'> " + intDay + "</A>";
                    strTable = strTable + "</td>";
                    strTable = strTable + " ";
                }
                else if (holidays.lastIndexOf("," + intDay + ",") != -1) {
                    //debugger;
                    if (TodaysDate_Cur != "") {
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt;background:red bgcolor=#dbeaf5 class=lgdHoliday " + TodayDateClass + ">";
                    strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)'> <font color='#F00'>" + intDay + "</font></A>";
                    strTable = strTable + "</td>";
                    strTable = strTable + " ";
                }
                else {
                    var strColor = "";
                    if (normaldays.lastIndexOf("," + intDay + ",") != -1)
                        strColor = "";

                    if (TodaysDate_Cur != "") {
                       // debugger;
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 14pt; " + strColor + " class= " + TodayDateClass + ">";
                    //strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0, ' + &quot;,&quot;&quot;&quot; " + strResult[i].WorkHrs + "&quot;,&quot;" + strResult[i].ExtraHoursCap + ")'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
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
                strDate = new Date(intYear, intMonth - 1, intDay);
                strTable = strTable + " ";
                if (weekends.lastIndexOf(column) != -1 || holidays.lastIndexOf(intDay) != -1 || normaldays.lastIndexOf(intDay) != -1) {
                    if (weekends.lastIndexOf(column) != -1) {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 14px;background:red bgcolor=#1359ac class=clsTRSectionWeekend " + TodayDateClass + ">";//
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)' style='color:#38385c;'> " + intDay + "</A>";
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    else if (holidays.lastIndexOf("," + intDay + ",") != -1) {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 12pt;background:red bgcolor=#dbeaf5 class=lgdHoliday " + TodayDateClass + ">";
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",1)'> <font color='#F00'>" + intDay + "</font></A>";
                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    else if (normaldays.lastIndexOf("," + intDay + ",") != -1) {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt;background:red class=" + TodayDateClass + ">";
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0,&quot;" + WorkHrs + "&quot;,&quot;" + ExtraHoursCap + "&quot;)'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
                        //strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0, ' + &quot;,&quot;&quot;&quot; " + strResult[i].WorkHrs + "&quot;,&quot;" + strResult[i].ExtraHoursCap + ")'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";

                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                    else {
                        if (TodaysDate_Cur != "") {
                            if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                                TodayDateClass = "lgdPlannedday";
                            } else {
                                TodayDateClass = "";
                            }
                        } else {
                            TodayDateClass = "";
                        }
                        strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt; class=" + TodayDateClass + ">";
                        strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0,&quot;" + WorkHrs + "&quot;,&quot;" + ExtraHoursCap + "&quot;)'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
                        //strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0, ' + &quot;,&quot;&quot;&quot; " + strResult[i].WorkHrs + "&quot;,&quot;" + strResult[i].ExtraHoursCap + ")'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";

                        strTable = strTable + "</td>";
                        strTable = strTable + " ";
                    }
                }
                else {
                    if (TodaysDate_Cur != "") {
                        if (TodaysDate_Cur == intDay && GStrMonthName == TodaysDate_Month) {
                            TodayDateClass = "lgdPlannedday";
                        } else {
                            TodayDateClass = "";
                        }
                    } else {
                        TodayDateClass = "";
                    }
                    strTable = strTable + " <td height=50px width=14% valign=top style=font-family: Verdana; font-size: 8pt; class=" + TodayDateClass + ">";
                    strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0,&quot;" + WorkHrs + "&quot;,&quot;" + ExtraHoursCap + "&quot;)'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";
                    //strTable = strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ",0, ' + &quot;,&quot;&quot;&quot; " + strResult[i].WorkHrs + "&quot;,&quot;" + strResult[i].ExtraHoursCap + ")'> " + intDay + "</A> <div class='ExtraNormal'>[<span class='text-info' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip' title='Normal Hours'> " + WorkHrs + " </span>][<span class='text-warning' data-bs-container='body' data-bs-placement='bottom' data-bs-toggle='tooltip'  data-bs-toggle='tooltip' title='Extra Hours'> " + ExtraHoursCap + " </span>]</div>";

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


        //Added By Dipali V For Site Calendar
        var intTotalWeekEnds = "";
        var StartingDayOfWeek = "";
        var m_strWeekEnds = "";
        var holidaysLists = "";
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
            //debugger;
            var m_strFromTimeSheet = "1";
            //var TimesheetNo = 0;
            var Parameters = {
                ProjectID: encodeURI(ProjectID),
                ProjectSiteID: encodeURI(ProjectSiteID),
                Year: encodeURI(Year),
                Month: encodeURI(Month),
                TimesheetNo: encodeURI(ProjectTimesheetID),
                m_strFromTimeSheet: encodeURI(m_strFromTimeSheet)

            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/PM_AddTimesheet/GetProjectSiteCalDetails", param, false);
            if (Result != "") {
                //debugger;
                var GetProjectSiteCalendar_Day = Result.SiteCalenderList;
                //var GetOULevelHolidays = Result.SiteOULevelHolidaysList;
                var NormalDayslist = "", Holidayslist = "";
                var GetOULevelHolidays = GetProjectSiteCalenderDetails(Month, Year, ProjectSiteID, m_strFromTimeSheet, ProjectTimesheetID)
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


    </script>

</body>

</html>
