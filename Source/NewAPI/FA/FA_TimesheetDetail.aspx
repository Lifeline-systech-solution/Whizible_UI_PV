<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FA_TimesheetDetail.aspx.vb" Inherits="Whizible.FA_TimesheetDetail" %>
<!DOCTYPE html>
<html>

    <%--<%CommonFunctions.General.PlotPageHeadTag("Project Timessheet Detail")%>--%>
<% CommonFunctions.General.PlotPageHeadTag("Project_Timesheet_Approval") %>


    <%--code added by Vaibhav K on 04-03-26--%> 
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
        .bgwhite {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .text_size {
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
            color: red;
        }

        .text_bg {
            color: #4263c1;
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
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

         .custmodal .modal-content .modal-header .close {
            top: 5px;
            background-color: #4263c1;
        }
        #SendTimesheetEmailModal .modal-dialog { max-width: 90%; margin: 1.75rem auto; }
        #SendTimesheetEmailModal .modal-body { max-height: calc(100vh - 180px); overflow-y: auto; }


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
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
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
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
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
.text_blue {
    color: #4263c1;
    
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
        .page-title {
 color: #1e40af;
 font-size: 16px;
 font-weight: 600;
 margin: 0;
line-height: 1.2;

}
.page-subtitle
{
color: #6B7280;
font-size: 14px;
 font-weight: 400;
 margin: 0;
line-height: 1.4;
 margin-top: 4px;
}
    </style>
<body class="hold-transition bgwhite" id="bodyPreloader">
    <%If m_ViewAccess = True %>
    <div class="wrapper">
        <div class="bgwhite">
            <!-- <div class="graybg container-fluid pt-1 pb-2 mb-2 statckmainheader ">
                <div class="row">
                    <div class="col-sm-3 pt-2 pb-2">
                        <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_PageCaption")%></h5>
                    </div>
                    <div class="col-sm-9">
                    </div>
                </div>
            </div> -->
                <!-- ================= HEADER ================= -->
    <div class="graybg px-3 py-2">
        <h2 class="page-title mb-0">
            <i class="fas fa-clock me-2"></i>
           <%= MyBase.GetResourceString("C_ProjectTimesheetSimple") %>
        </h2>
        <p class="page-subtitle">
            <%--Log, manage, and track project-wise work hours efficiently.--%>

<%= MyBase.GetResourceString("C_TimesheetDetailSubtitle") %>
        </p>
    </div>
            <div class="row container-fluid ">
                <div class="pmtID float-start"><strong><%= MyBase.GetResourceString("C_TimesheetID")%> : <span class="projectID" id="SpnProjectTimesheetID"></span></strong></div>
            </div>
            <div class="container-fluid mt-3">
                <div class="float-start">
                    <%CommonFunctions.HTMLControls.DrawComboBox("select_emp", "select 1",,, "onchange='EmployeeName_onChange()' data-live-search='true' class='selectpicker'", False,, ) %>
                </div>
                <div class="d-flex justify-content-end">

                   <%-- <div class="dropdown mx-1">
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
                        <%End If %>--%>

                    <%--To do later change into our Authenticate, Reject and view comment btn--%>
                        <%If m_EditAccess = True Then%>
                        <%--<a href="javascript:;" class="btn borderbtn" id="delete_btn" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Delete"><%= MyBase.GetResourceString("C_Delete")%> </a>--%>
                 
                   <%-- Authenticate Button --%>
<button class="btn btn-success mx-1" id="btn_authenticate" style="display:none;" onclick="OpenActionModal('Authenticate'); return false;">
        Approve
    </button>

<%-- Reject Button --%>
<button class="btn btn-danger mx-1" id="btn_reject" style="display:none;" onclick="OpenActionModal('Reject'); return false;">
        Reject
    </button>
                
                    
                    <%End If %>
                   <button class="btn borderbtn mx-1" id="btn_view_comment" style="display:none;" onclick="ViewComment_OnClick(); return false;">
        View Comment
    </button>

                        <a href="javascript:;" class="btn borderbtn" id="back_btn" onclick="back_Onclick();" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Back"><%= MyBase.GetResourceString("C_Back")%> </a>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="content pt-0">
                <div class="row mt-2 mb-2 project_timeperiod">
                    <div class="col-sm-12 ">
                        <span class="text_blue"><%= MyBase.GetResourceString("C_ProjectTimesheet")%>  &nbsp;-&nbsp;</span>
                        <span class="text_blue"><%= MyBase.GetResourceString("C_FromDate")%> :</span>
                        <span class="project_fromdate" id="ProjectFromdate"></span>&nbsp;&nbsp;
                        <span class="text_blue"><%= MyBase.GetResourceString("C_ToDate")%> :</span>
                        <span class="project_todate" id="ProjectTodate"></span>
                        <span class="float-end push"> <span class="text_blue"><strong><%= MyBase.GetResourceString("C_Status")%> </strong></span> :<span class="current_status" id="ProjectTimesheetCurrentStatus"></span></span>
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
                                            <div class="custom_dropdown actual-wrk-menu" id="divfilter_actual_work_Text" style="display: none">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("filter_actual_work_Text", "filter_actual_work_Text", "form-control",,,,,,,,,, "autocomplete='off' maxlength='100'",,, True,, False,, True) %>
                                            </div>
                                            <div class="custom_dropdown actual-wrk-menu" id="divfilter_actual_work_Drop" style="display: none">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("filter_actual_work_Drop", "usp_Whizible2_sel_GetActualHours",,, " class='selectpicker' data-live-search='true'", False,, ,,, False) %>
                                            </div>
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
                             <%--   <th><%= MyBase.GetResourceString("C_WSR")%></th>
                                <th><%= MyBase.GetResourceString("C_Delete")%></th>--%>

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
                                                        <th width="13%"><%=MyBase.GetResourceString("C_TaskName")%> </th>
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
                                    <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_Description")%> </h5>
                                </div>

                            </div>
                        </div>
                        <div class="row mt-2 mb-2 project_timeperiod">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-sm-8">
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <button type="button" class="btn btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas"><%= MyBase.GetResourceString("C_Actual_Work")%> </button>

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
                                                    <th><%= MyBase.GetResourceString("C_HHMM")%> </th>
                                                    <th><%= MyBase.GetResourceString("C_WSR")%> </th>
                                                    <th><%= MyBase.GetResourceString("C_TaskName")%></th>
                                                    <th><%= MyBase.GetResourceString("C_Description")%></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_Work")%> </th>
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
                                    <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_HHMM")%></h5>
                                </div>

                            </div>
                        </div>
                        <div class="row mt-2 mb-2 project_timeperiod">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-sm-8">
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <button type="button" class="btn  btnyellow closeWindowBtn closebtn text-end" id="weekly_status_sv_btn"><%= MyBase.GetResourceString("C_WSR")%></button>
                                        <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas"><%= MyBase.GetResourceString("C_EditDelete")%></button>

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
                                                    <label><%= MyBase.GetResourceString("C_ShowHistory")%></label>

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


        
    </div>
    <%Else %>
    <div id="NotAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center" class="box box-solid">
            <p><%= MyBase.GetResourceString("C_NotAccess")%>. </p>
        </div>
    </div>
    <%End If %>
    
    <div class="modal custmodal fade" id="ViewCommentModal" aria-hidden="true">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                   
                    <%= MyBase.GetResourceString("C_TimesheetComments") %>

                </h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Comments:</label>
                    <textarea id="txtViewCommentArea" class="form-control" rows="5" readonly style="background-color: #f5f5f5;"></textarea>
                </div>
                <br />
                <div class="text-center">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

    <%--Authenticate-Reject madal popup--%>
  
    <div class="modal fade custmodal" id="ActionModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            
            <div class="modal-header graybg">
                <h5 class="modal-title fw-bold" id="actionModalTitle">
                    Action
                </h5>
               <%-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>

            <div class="modal-body p-0">
                <div class="table-responsive">
                    <table class="table mb-0" style="width:100%">
                        <thead class="bg-light">
                            <tr>
                                <th style="width: 15%; background-color: #f8f9fa;">Timesheet No</th>
                                <th style="width: 20%; background-color: #f8f9fa;">From Date</th>
                                <th style="width: 20%; background-color: #f8f9fa;">To Date</th>
                                <th style="width: 45%; background-color: #f8f9fa;">
                                    Comments <span id="lblMandatory" class="text-danger" style="display:none;">(* Mandatory)</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="align-middle text-center fw-bold text-primary">
                                    <span id="mdl_TsID"></span>
                                </td>
                                <td class="align-middle text-center">
                                    <span id="mdl_From"></span>
                                </td>
                                <td class="align-middle text-center">
                                    <span id="mdl_To"></span>
                                </td>
                                <td class="p-2">
                                    <textarea id="mdl_Comment" class="form-control" rows="3" placeholder="Enter comments here..."></textarea>
                                    <div id="mdl_Error" class="text-danger mt-1 small" style="display:none;">
                                        <i class="fas fa-exclamation-circle"></i> Please enter a comment.
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal-footer bg-light">
                <button type="button" class="btn" id="btn_ModalSubmit" onclick="SubmitAction()">Submit</button>
                <button type="button" class="btn borderbtn" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%--Authenticate-Reject madal popup end here--%>
    

        <!-- ================= SEND EMAIL MODAL (Timesheet Detail) - Same as Listing ================= -->
    <div class="modal custmodal fade" id="SendTimesheetEmailModal" data-bs-backdrop="static" aria-hidden="true" style="overflow-y:hidden;">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="margin-top:40px;">
                <div class="modal-header p-3">
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
                        <div class="form-group col-sm-2 text-end"><b><%=MyBase.GetResourceString("c_Note")%></b></div>
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
                            <button type="button" id="sendTimesheetEmailBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Send")%>" class="btn btnyellow" onclick="sendTimesheetEmailFromModalDetail()"><%=MyBase.GetResourceString("C_Send")%></button>
                            <button type="button" class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- ================= SEND EMAIL MODAL (Timesheet Detail) Ends here ================= -->

   




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
        //var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'

        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //var ProjectID;
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';

        var AddAccess = '<%=m_AddAccess%>';
        var EditAccess = '<%=m_EditAccess%>';
        var m_DeleteAccess = '<%=m_DeleteAccess%>';
        //alert(AddAccess);
        ProjectID = '<%= Session("intProjectID") %>';
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






            //PlotActionLinkConditionally();
            //$("#dltAllTimsheet").click(function () {
            //    $(".mainchck").prop('checked', $(this).prop('checked'));
            //});
            //$(".mainchck").change(function () {
            //    var rowCount = $(".timesheet-tbl > tr").length;
            //    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", ".timesheet-tbl");
            //    if (rowCount == CheckedcheckedBoxes.length) {
            //        $("#dltAllTimsheet").prop('checked', true);
            //    }
            //    if (!$(this).prop("checked")) {
            //        $("#dltAllTimsheet").prop("checked", false);
            //    }
            //})

            //$('.filter-wrap').click(function () {
            //    $(this).toggleClass('active');
            //});


            //$('.close-all').click(function () {
            //    $('.edit-row').find('.form-control').addClass('no-edit');
            //    $('textarea.no-edit').hide();
            //    $(this).hide();
            //    $('.close-row').hide();
            //});


            //$(function () {
            //    $('[data-bs-toggle="tooltip"]').tooltip()
            //})

            //$('.multi-edit').click(function () {
            //    $('textarea.no-edit , .saverow').show();
            //    $('.edit').hide();
            //    $('.edit-row, .edit, .cancelval').find('.form-control').removeClass('no-edit');
            //    $('.close-row, .saverow,').show();
            //});

            //$('.modal').on('hidden.bs.modal', function () {
            //    $('.custmodal').load('.modal');
            //});

            //Button Visibility Logic 
            // 1. If Rejected: Hide Approve & Reject (Show View Comment only)
            // 2. If Approved: Show Reject only (and View Comment)
            // 3. Else (Pending/Submitted): Show Both (Hide View Comment)

            $("#btn_authenticate").hide();
            $("#btn_reject").hide();
            $("#btn_view_comment").hide();

            //  Logic to show View Comment button only if Approved or Rejected
            // Note: Ensure ProjectTimesheetStatus variable is populated correctly from QueryString
            //if (ProjectTimesheetStatus == "Approved" || ProjectTimesheetStatus == "Rejected") {
            //    $("#btn_view_comment").show();
            //} else {
            //    $("#btn_view_comment").hide();
            //}

            if (ProjectTimesheetStatus == "Rejected") {
                // Case 1: Already Rejected
                $("#btn_view_comment").show();
            }
            else if (ProjectTimesheetStatus == "Approved") {
                // Case 2: Already Approved
                $("#btn_reject").show();
                $("#btn_view_comment").show();
            }
            else {
                // Case 3: Pending/Submitted
                $("#btn_authenticate").show();
                $("#btn_reject").show();
            }

            //GetMINDAValidation();
            GetEmployeeDetails();

            ViewProjectTimesheet();


            StopAjaxLoader('#bodyPreloader')


        });

        // Corrected for New API (camelCase)
        function GetEmployeeDetails() {
            var Parameters = {
                TimesheetNo: encodeURI(ProjectTimesheetID)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetEmployeeDetails", param, false);

            var EmployeeDetails = strResult.employeeDetails;

            // Clear existing options
            $("#select_emp option").remove();
            $("#select_Update_EMP option").remove();


            if (EmployeeDetails) {
                for (var i = 0; i < EmployeeDetails.length; i++) {
                    var objCbo1 = document.getElementById("select_emp");
                    var objCbo2 = document.getElementById("select_Update_EMP");

                    var ObjStatus = EmployeeDetails[i];
                    var objOption = document.createElement("OPTION");
                    var objOption1 = document.createElement("OPTION");

                    objCbo1.options.add(objOption);
                    objCbo2.options.add(objOption1);


                    objOption.text = ObjStatus.employeeName;
                    objOption.value = ObjStatus.employeeID;

                    objOption1.text = ObjStatus.employeeName;
                    objOption1.value = ObjStatus.employeeID;
                }
            }

            $(".selectpicker").selectpicker('refresh');
        }


        // Get Project Timesheet Details
        var IsOnchange = 0;
        function EmployeeName_onChange() {
            IsOnchange = 1;
            ViewProjectTimesheet();
        }



        var arrEmployeeID = [];
        var GReadyToAuthenticate = "";
        var GAuthenticated = "";

        function ViewProjectTimesheet() {
            // debugger;
            var EmployeeID = $("#select_emp").val();
            if (EmployeeID == "undefined" || EmployeeID < 0) {
                EmployeeID = 0
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

            // API Call
            var EmployeeDetails = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetViewProjectTimesheet", param, false);

            // Check if data exists
            if (EmployeeDetails && EmployeeDetails.length > 0) {
                for (var i = 0; i < EmployeeDetails.length; i++) {
                    var IsDelete = "";
                    var IsWSRcheckbox = "";

                    // NEW API CHANGE: camelCase properties
                    arrEmployeeID.push(parseInt(EmployeeDetails[i].employeeID));
                    GReadyToAuthenticate = EmployeeDetails[i].readyToAuthenticate;
                    GAuthenticated = EmployeeDetails[i].authenticated;

                    var Description = "";
                    // NEW API CHANGE: camelCase 'description'
                    // Added check to ensure description is not null before checking length
                    var descText = EmployeeDetails[i].description || "";

                    if (descText.length > 30) {
                        Description = descText.slice(0, 30) + "...";
                    } else {
                        Description = descText;
                    }

                    // NEW API CHANGE: camelCase 'timsheetStatus'
                    SelectedTSStatus = EmployeeDetails[i].timsheetStatus;

                    // NEW API CHANGE: camelCase 'readyToAuthenticate' and 'weeklyStatusEntry'
                    if (!EmployeeDetails[i].readyToAuthenticate) {
                        IsDelete = "";
                        if (EmployeeDetails[i].weeklyStatusEntry == 1 || EmployeeDetails[i].weeklyStatusEntry == true) {
                            IsWSRcheckbox = "checked";
                        } else {
                            IsWSRcheckbox = "";
                        }
                    }
                    else if (EmployeeDetails[i].readyToAuthenticate == "Y") {
                        IsDelete = "disabled";
                        if (EmployeeDetails[i].weeklyStatusEntry == 1 || EmployeeDetails[i].weeklyStatusEntry == true) {
                            IsWSRcheckbox = "checked disabled";
                        } else {
                            IsWSRcheckbox = "disabled";
                        }
                    }

                    // Grouping logic (Employee Header)
                    // NEW API CHANGE: camelCase 'employeeName'
                    if (EmployeeName == "") {
                        if (IsOnchange == 1) {
                            // Logic for change
                        }
                        // NEW API CHANGE: camelCase 'employeeCode' and 'employeeName'
                        ProjectTimesheetDetails += '<tr><td><strong>[' + EmployeeDetails[i].employeeCode + '] - ' + EmployeeDetails[i].employeeName + '</strong></td><td colspan="6"></td></tr>';
                        ProjectTimesheetDetails += '<tr><td></td>';

                        // NEW API CHANGE: camelCase 'entryDate' and 'timeSheetID'
                        if (EntryDate != EmployeeDetails[i].entryDate) {
                            ProjectTimesheetDetails += '<td id="EntryDate_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].entryDate + '</td>';
                        } else {
                            ProjectTimesheetDetails += '<td><span id="EntryDate_' + EmployeeDetails[i].timeSheetID + '" style="display:none">' + EmployeeDetails[i].entryDate + '</span></td>';
                        }

                        ProjectTimesheetDetails += '<td class="text-start">';
                        ProjectTimesheetDetails += ' <div class="d-flex">';

                        // NEW API CHANGE: camelCase 'task', 'timeSheetID'
                        if (!EmployeeDetails[i].readyToAuthenticate) {
                            ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id ="TaskName_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].task + '</a>';
                            ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" >&nbsp;&nbsp;<i class="fas fa-pencil-alt icon_style" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Edit" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')"></i></a>';
                        }
                        else if (EmployeeDetails[i].readyToAuthenticate == "Y") {
                            ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id="TaskName_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].task + '</a>';
                            ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id="TaskName_' + EmployeeDetails[i].timeSheetID + '" >&nbsp;&nbsp;</a>';
                        }
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';

                        if (descText.trim() != "") {
                            ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + descText + '" id="Description_' + EmployeeDetails[i].timeSheetID + '">' + Description + '</td >';
                        } else {
                            ProjectTimesheetDetails += '<td id="Description_' + EmployeeDetails[i].timeSheetID + '">' + Description + '</td >';
                        }

                        // NEW API CHANGE: camelCase 'duration', 'durationHHMM'
                        ProjectTimesheetDetails += '<td  id="ActualHours_' + EmployeeDetails[i].timeSheetID + '" value="' + EmployeeDetails[i].duration + '">' + EmployeeDetails[i].durationHHMM + '<span id="ActualHoursDecimal_' + EmployeeDetails[i].timeSheetID + '" style="display:none">' + EmployeeDetails[i].duration + '</span><span id = "ActualHoursHHMM_' + EmployeeDetails[i].timeSheetID + '" style = "display:none" > ' + EmployeeDetails[i].durationHHMM + '</span></td>';

                        //ProjectTimesheetDetails += '<td class="sm-wid">';
                        //ProjectTimesheetDetails += '<div class="custom_chckbox">';
                        //// NEW API CHANGE: camelCase 'employeeID', 'timeSheetID'
                        //ProjectTimesheetDetails += '<input id="taskwsr_' + EmployeeDetails[i].timeSheetID + '" name="WSRCheckbox" onchange="WSR_Checkbox(' + EmployeeDetails[i].employeeID + ',' + EmployeeDetails[i].timeSheetID + ')" class="chckHead mainchck WSRCheckbox_' + EmployeeDetails[i].employeeID + '" type="checkbox"  ' + IsWSRcheckbox + ' value="' + EmployeeDetails[i].timeSheetID + '">';
                        //ProjectTimesheetDetails += '<label for="taskwsr_' + EmployeeDetails[i].timeSheetID + '"></label>';
                        //ProjectTimesheetDetails += '</div>';
                        //ProjectTimesheetDetails += '</td>';

                        //ProjectTimesheetDetails += '<td class="sm-wid">';
                        //ProjectTimesheetDetails += '<div class="custom_chckbox">';
                        //ProjectTimesheetDetails += '<input id="taskdlt_' + EmployeeDetails[i].timeSheetID + '" class="chckHead" name="DeleteCheckbox" type="checkbox" ' + IsDelete + ' value="' + EmployeeDetails[i].timeSheetID + '">';
                        //ProjectTimesheetDetails += '<label for="taskdlt_' + EmployeeDetails[i].timeSheetID + '"></label>';
                        //ProjectTimesheetDetails += '</div>';
                        //ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '</tr> ';

                        // Footer for the very first group if logic required (matches your old logic)
                        if (i == EmployeeDetails.length - 1) {
                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="3" class="text-start">';
                            ProjectTimesheetDetails += '<label>Total Actual Work (HH:MM) for <strong> [ ' + EmployeeDetails[i].employeeCode + '] - ' + EmployeeDetails[i].employeeName + ' [WSR Status]</strong></label>';
                            //ProjectTimesheetDetails += '<div class="custom_chckbox d-inline-blockpl-10">';
                            //ProjectTimesheetDetails += '<input id="totalChcked_' + EmployeeDetails[i].employeeID + '" class="chckHead" type="checkbox" checked="checked" ' + IsWSRcheckbox + ' onclick="checkwsr(' + EmployeeDetails[i].employeeID + ')">';
                            //ProjectTimesheetDetails += '<label for="totalChcked_' + EmployeeDetails[i].employeeID + '"></label>';
                            //ProjectTimesheetDetails += '</div>';
                            ProjectTimesheetDetails += '</td>';
                            ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Total</strong></span></td>';
                            // NEW API CHANGE: camelCase 'resourceTotalHHMM', 'resourceTotal'
                            ProjectTimesheetDetails += '<td><strong><span id="Total_' + EmployeeDetails[i].employeeID + '"> ' + EmployeeDetails[i].resourceTotalHHMM + '</span></strong><span id="Totalhidden_' + EmployeeDetails[i].employeeID + '" style="display:none"> ' + EmployeeDetails[i].resourceTotal + '</span></td>';
                            //ProjectTimesheetDetails += '<td style="border- left: none;">&nbsp;</td>';
                            //ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                            ProjectTimesheetDetails += '</tr>';

                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="3">';
                            ProjectTimesheetDetails += '</td>';
                            ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Grand Total </strong></span></td>';
                            // NEW API CHANGE: camelCase 'grandTotalHHMM'
                            ProjectTimesheetDetails += '<td > <strong><span class="fl-right" id="GrandTotal"><span> ' + EmployeeDetails[i].grandTotalHHMM + '  </strong></td>';
                            //ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                            //ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                            ProjectTimesheetDetails += '</tr>';
                        }
                    }
                    // Same employee row
                    else if (EmployeeName == EmployeeDetails[i].employeeName) {
                        ProjectTimesheetDetails += '<tr><td></td>';
                        if (EntryDate != EmployeeDetails[i].entryDate) {
                            ProjectTimesheetDetails += '<td id="EntryDate_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].entryDate + '</td>';
                        } else {
                            ProjectTimesheetDetails += '<td><span id="EntryDate_' + EmployeeDetails[i].timeSheetID + '" style="display:none">' + EmployeeDetails[i].entryDate + '</span></td>';
                        }

                        ProjectTimesheetDetails += '<td class="text-start">';
                        ProjectTimesheetDetails += ' <div class="d-flex">';
                        if (!EmployeeDetails[i].readyToAuthenticate) {
                            ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id ="TaskName_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].task + '</a>';
                            ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" >&nbsp;&nbsp;<i class="fas fa-pencil-alt icon_style" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Edit" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')"></i></a>';
                        }
                        else if (EmployeeDetails[i].readyToAuthenticate == "Y") {
                            ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id="TaskName_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].task + '</a>';
                            ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id="TaskName_' + EmployeeDetails[i].timeSheetID + '" >&nbsp;&nbsp;</a>';
                        }
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';

                        if (descText.trim() != "") {
                            ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + descText + '" id="Description_' + EmployeeDetails[i].timeSheetID + '">' + Description + '</td >';
                        } else {
                            ProjectTimesheetDetails += '<td id="Description_' + EmployeeDetails[i].timeSheetID + '">' + Description + '</td >';
                        }

                        ProjectTimesheetDetails += '<td  id="ActualHours_' + EmployeeDetails[i].timeSheetID + '" value="' + EmployeeDetails[i].duration + '">' + EmployeeDetails[i].durationHHMM + '<span id="ActualHoursDecimal_' + EmployeeDetails[i].timeSheetID + '" style="display:none">' + EmployeeDetails[i].duration + '</span><span id = "ActualHoursHHMM_' + EmployeeDetails[i].timeSheetID + '" style = "display:none" > ' + EmployeeDetails[i].durationHHMM + '</span></td>';

                        ProjectTimesheetDetails += '</tr> ';

                        if (i == EmployeeDetails.length - 1) {
                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="3" class="text-start">';
                            ProjectTimesheetDetails += '<label>Total Actual Work (HH:MM) for <strong> [ ' + EmployeeDetails[i].employeeCode + '] - ' + EmployeeDetails[i].employeeName + ' [WSR Status]</strong></label>';
                            //ProjectTimesheetDetails += '<div class="custom_chckbox d-inline-blockpl-10">';
                            //ProjectTimesheetDetails += '<input id="totalChcked_' + EmployeeDetails[i].employeeID + '" class="chckHead" type="checkbox" checked="checked" ' + IsWSRcheckbox + ' onclick="checkwsr(' + EmployeeDetails[i].employeeID + ')">';
                            //ProjectTimesheetDetails += '<label for="totalChcked_' + EmployeeDetails[i].employeeID + '"></label>';
                            //ProjectTimesheetDetails += '</div>';
                            ProjectTimesheetDetails += '</td>';
                            ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Total</strong></span></td>';
                            ProjectTimesheetDetails += '<td><strong><span id="Total_' + EmployeeDetails[i].employeeID + '"> ' + EmployeeDetails[i].resourceTotalHHMM + '</span></strong><span id="Totalhidden_' + EmployeeDetails[i].employeeID + '" style="display:none"> ' + EmployeeDetails[i].resourceTotal + '</span></td>';
                            ProjectTimesheetDetails += '</tr>';

                            ProjectTimesheetDetails += '<tr class="total-row">';
                            ProjectTimesheetDetails += '<td colspan="3">';
                            ProjectTimesheetDetails += '</td>';
                            ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Grand Total </strong></span></td>';
                            ProjectTimesheetDetails += '<td > <strong><span class="fl-right" id="GrandTotal"><span> ' + EmployeeDetails[i].grandTotalHHMM + '  </strong></td>';
                            //ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                            //ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                            ProjectTimesheetDetails += '</tr>';
                        }
                    }
                    // New Employee group
                    else if (EmployeeName != EmployeeDetails[i].employeeName) {
                        ProjectTimesheetDetails += '<tr class="total-row">';
                        ProjectTimesheetDetails += '<td colspan="3" class="text-start">';
                        ProjectTimesheetDetails += '<label>Total Actual Work (HH:MM) for <strong> [ ' + EmployeeCode + '] - ' + EmployeeName + ' [WSR Status]</strong></label>';
                        //ProjectTimesheetDetails += '<div class="custom_chckbox d-inline-blockpl-10">';
                        //ProjectTimesheetDetails += '<input id="totalChcked_' + EmployeeID + '" class="chckHead" type="checkbox" checked="checked" ' + IsWSRcheckbox + ' onclick="checkwsr(' + EmployeeID + ')">';
                        //ProjectTimesheetDetails += '<label for="totalChcked_' + EmployeeID + '"></label>';
                        //ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '<td> <span class="fl-right"><strong>Total</strong></span></td>';
                        ProjectTimesheetDetails += '<td><strong><span id="Total_' + EmployeeID + '"> ' + ResourceTotalHHMM + '</span></strong><span id="Totalhidden_' + EmployeeID + '" style="display:none"> ' + ResourceTotal + '</span></td>';
                        //ProjectTimesheetDetails += '<td style="border- left: none;">&nbsp;</td>';
                        //ProjectTimesheetDetails += '<td style="border-left: none;">&nbsp;</td>';
                        ProjectTimesheetDetails += '</tr>';

                        ProjectTimesheetDetails += '<tr><td><strong>[' + EmployeeDetails[i].employeeCode + '] - ' + EmployeeDetails[i].employeeName + '</strong></td><td colspan="6"></td></tr>';
                        ProjectTimesheetDetails += '<tr><td></td>';

                        if (EntryDate != EmployeeDetails[i].entryDate) {
                            ProjectTimesheetDetails += '<td id="EntryDate_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].entryDate + '</td>';
                        } else {
                            ProjectTimesheetDetails += '<td><span id="EntryDate_' + EmployeeDetails[i].timeSheetID + '" style="display:none">' + EmployeeDetails[i].entryDate + '</span></td>';
                        }

                        ProjectTimesheetDetails += '<td class="text-start">';
                        ProjectTimesheetDetails += ' <div class="d-flex">';
                        if (!EmployeeDetails[i].readyToAuthenticate) {
                            ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id ="TaskName_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].task + '</a>';
                            ProjectTimesheetDetails += '<a href="#Edit_task_description" class="text-start" data-bs-toggle="collapse" >&nbsp;&nbsp;<i class="fas fa-pencil-alt icon_style" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="Edit" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')"></i></a>';
                        }
                        else if (EmployeeDetails[i].readyToAuthenticate == "Y") {
                            ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id="TaskName_' + EmployeeDetails[i].timeSheetID + '">' + EmployeeDetails[i].task + '</a>';
                            ProjectTimesheetDetails += '<a href="" class="text-start" data-bs-toggle="collapse" Onclick="GetTaskDetails(' + EmployeeDetails[i].timeSheetID + ')" id="TaskName_' + EmployeeDetails[i].timeSheetID + '" >&nbsp;&nbsp;</a>';
                        }
                        ProjectTimesheetDetails += '</div>';
                        ProjectTimesheetDetails += '</td>';

                        if (descText.trim() != "") {
                            ProjectTimesheetDetails += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + descText + '" id="Description_' + EmployeeDetails[i].timeSheetID + '">' + Description + '</td >';
                        } else {
                            ProjectTimesheetDetails += '<td id="Description_' + EmployeeDetails[i].timeSheetID + '">' + Description + '</td >';
                        }

                        ProjectTimesheetDetails += '<td  id="ActualHours_' + EmployeeDetails[i].timeSheetID + '" value="' + EmployeeDetails[i].duration + '">' + EmployeeDetails[i].durationHHMM + '<span id="ActualHoursDecimal_' + EmployeeDetails[i].timeSheetID + '" style="display:none">' + EmployeeDetails[i].duration + '</span><span id = "ActualHoursHHMM_' + EmployeeDetails[i].timeSheetID + '" style = "display:none" > ' + EmployeeDetails[i].durationHHMM + '</span></td>';

                        //ProjectTimesheetDetails += '<td class="sm-wid">';
                        //ProjectTimesheetDetails += '<div class="custom_chckbox">';
                        //ProjectTimesheetDetails += '<input id="taskwsr_' + EmployeeDetails[i].timeSheetID + '" name="WSRCheckbox" onchange="WSR_Checkbox(' + EmployeeDetails[i].employeeID + ',' + EmployeeDetails[i].timeSheetID + ')" class="chckHead mainchck WSRCheckbox_' + EmployeeDetails[i].employeeID + '" type="checkbox"  ' + IsWSRcheckbox + ' value="' + EmployeeDetails[i].timeSheetID + '">';
                        //ProjectTimesheetDetails += '<label for="taskwsr_' + EmployeeDetails[i].timeSheetID + '"></label>';
                        //ProjectTimesheetDetails += '</div>';
                        //ProjectTimesheetDetails += '</td>';

                        //ProjectTimesheetDetails += '<td class="sm-wid">';
                        //ProjectTimesheetDetails += '<div class="custom_chckbox">';
                        //ProjectTimesheetDetails += '<input id="taskdlt_' + EmployeeDetails[i].timeSheetID + '" class="chckHead" name="DeleteCheckbox" type="checkbox" ' + IsDelete + ' value="' + EmployeeDetails[i].timeSheetID + '">';
                        //ProjectTimesheetDetails += '<label for="taskdlt_' + EmployeeDetails[i].timeSheetID + '"></label>';
                        //ProjectTimesheetDetails += '</div>';
                        //ProjectTimesheetDetails += '</td>';
                        ProjectTimesheetDetails += '</tr> ';
                    }

                    // Update trackers
                    EmployeeName = EmployeeDetails[i].employeeName;
                    EmployeeCode = EmployeeDetails[i].employeeCode;
                    EmployeeID = EmployeeDetails[i].employeeID;
                    ResourceTotalHHMM = EmployeeDetails[i].resourceTotalHHMM;
                    ResourceTotal = EmployeeDetails[i].resourceTotal;
                    EntryDate = EmployeeDetails[i].entryDate;
                }
            }

            $("#ProjectTimesheetDetails").html(ProjectTimesheetDetails);
            $("#ProjectTimesheetCurrentStatus").text("");
            $("#ProjectTimesheetStatus").text("");

            // Update button visibility based on the new status
            UpdateButtonVisibility(SelectedTSStatus);

            if (SelectedTSStatus == "") {
                SelectedTSStatus = ProjectTimesheetStatus;
            }

            $("#ProjectTimesheetCurrentStatus").text(SelectedTSStatus);
            $("#ProjectTimesheetStatus").text(SelectedTSStatus);

            if (SelectedTSStatus === "Rejected") {
                $("#ProjectTimesheetCurrentStatus").css("color", "red");
            } else if (SelectedTSStatus === "Approved") {
                $("#ProjectTimesheetCurrentStatus").css("color", "Green");
            } else {
                $("#ProjectTimesheetCurrentStatus").css("color", "black");
            }

            $('[data-bs-toggle="tooltip"]').tooltip();
        }



        function GetMINDAValidation() {
            var Parameters = {

            }
            var param = JSON.stringify(Parameters);
            //alert("min hour validation");

            strResult = AJAXCallWithResult("/api/PM_ProjectTimesheet/GetRestrictByMinHours_MinHoursForDAEntry", param, false);
            if (strResult != undefined) {
                RestrictByMinHours = strResult.RestrictByMinHours;
                MinHoursForDAEntry = strResult.MinHoursForDAEntry;
            }
            if (MinHoursForDAEntry == "0.016") {
                $("#divfilter_actual_work_Text").show();
                $("#divfilter_actual_work_Drop").hide();
            } else {
                $("#divfilter_actual_work_Drop").show();
                $("#divfilter_actual_work_Text").hide();
            }
            //return MinHoursForDAEntry;
        }



        // For Stop Loader
        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {

            });

        }

        // For Ajax Call 
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
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



        // For Navigate to Project List Page
        function back_Onclick() {
            window.location.href = "../FA/FA_TimesheetListing_new.aspx?MasterTagId=42&ProjectID=" + ProjectID + "";


        }


        // Function to Fetch Comments and Show Modal
        function ViewComment_OnClick() {
            try {
                StartLoader('#bodyPreloader'); // Optional: Show loader

                // 1. Prepare Parameters
                var Parameters = {
                    TimeSheetNo: parseInt(ProjectTimesheetID)
                };
                var param = JSON.stringify(Parameters);

                // 2. Call API
                // Ensure the Controller Name matches what we created: 'ProjectTimesheetApproval'
                var strResult = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetTimesheetComments", param, false);



                // 3. Bind Data
                if (strResult && strResult.comments) {
                    // Depending on how ResponseEntity is structured, accessing data.comments
                    // If the API returns { comments: "..." } inside 'data', use strResult.data.comments
                    var commentText = strResult.comments || "No comments found.";
                    $("#txtViewCommentArea").val(commentText);
                } else {
                    $("#txtViewCommentArea").val("");
                }

                // 4. Show Modal (Bootstrap 5 syntax)
                var myModal = new bootstrap.Modal(document.getElementById('ViewCommentModal'));
                myModal.show();

            } catch (e) {
                console.log(e);
                alertify.error("Error fetching comments.");
            } finally {
                StopAjaxLoader('#bodyPreloader'); // Stop loader
            }
        }
        //Function to Fetch Comments and Show Modal ends here





        // Global variable to track current action context
        var g_CurrentAction = "";

        // 1. Open Modal and Setup UI
        function OpenActionModal(actionType) {
            g_CurrentAction = actionType;

            // Reset Fields
            $("#mdl_Comment").val("");
            $("#mdl_Error").hide();

            // Populate Data from Global Variables (Available in your page)
            $("#mdl_TsID").text(ProjectTimesheetID);
            $("#mdl_From").text(ProjectFromDate);
            $("#mdl_To").text(ProjectToDate);

            // Setup UI based on Action Type
            var btnSubmit = $("#btn_ModalSubmit");
            var lblMandatory = $("#lblMandatory");
            var title = $("#actionModalTitle");

            if (actionType === "Authenticate") {
                title.html('Authenticate Timesheet');
                btnSubmit.text('<%=MyBase.GetResourceString("C_Approve")%>').removeClass("btn-danger").addClass("btnyellow");
                var today = new Date();
                var day = ("0" + today.getDate()).slice(-2);
                var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                var formattedDate = day + "-" + months[today.getMonth()] + "-" + today.getFullYear();
                $("#mdl_Comment").val("Approved On " + formattedDate);

                lblMandatory.hide(); // Optional comment
            }
            else if (actionType === "Reject") {
                title.html('Reject Timesheet');
                btnSubmit.text( '<%=MyBase.GetResourceString("C_Reject")%>').removeClass("btnyellow").addClass("btn-danger");
                lblMandatory.show(); // Mandatory comment
            }

            // Show Modal
            var myModal = new bootstrap.Modal(document.getElementById('ActionModal'));
            myModal.show();
        }

        // 2. Submit Logic
        function SubmitAction() {
            //debugger;
            var comment = $("#mdl_Comment").val().trim();

            // Validation for Reject
            if (g_CurrentAction === "Reject" && comment === "") {
                $("#mdl_Error").show();
                $("#mdl_Comment").focus();
                return;
            }

            try {
                StartLoader('#bodyPreloader');

                var url = "";
                var requestObj = {};

                if (g_CurrentAction === "Authenticate") {
                    url = "/api/ProjectTimesheetApproval/AuthenticateTimesheet";
                    requestObj = {
                        TimeSheetNos: ProjectTimesheetID.toString(), // API expects String
                        Comments: comment,
                        UserName: UserName
                    };
                }
                else {
                    url = "/api/ProjectTimesheetApproval/RejectTimesheet";
                    requestObj = {
                        TimesheetNo: parseInt(ProjectTimesheetID), // API expects Int
                        Comment: comment,
                        UserName: UserName
                    };
                }

                // Call API
                var strResult = AJAXCallWithResult(url, JSON.stringify(requestObj), false);

                // Hide Modal
                var modalEl = document.getElementById('ActionModal');
                var modal = bootstrap.Modal.getInstance(modalEl);
                modal.hide();



                // Check Success
                //if (strResult && (strResult.status == "SUCCESS" || strResult[0].result == "Updated successfully")) { // Check against your API response structure
                //    var msg = (g_CurrentAction === "Authenticate") ? "Authenticated Successfully." : "Rejected Successfully.";


                // Check Success (handle object or array e.g. [{"result":"Update successfully"}])
                var isSuccess = false;
                if (strResult) {
                    var res = Array.isArray(strResult) && strResult.length > 0 ? strResult[0] : strResult;
                    var status = res.status;
                    var msgVal = (res.result || res.Result || res.message || "").toString();
                    isSuccess = (status === "SUCCESS" || status === true) ||
                        (msgVal && (msgVal.toLowerCase().indexOf("success") !== -1 || msgVal === "Update successfully" || msgVal === "Updated Successfully" || msgVal === "Operation completed"));
                }
                if (isSuccess) {
                    var msg = (g_CurrentAction === "Authenticate") ? "Authenticated successfully." : "Rejected successfully.";


                    alertify.success(msg);



                    // Reload to update status
                    //setTimeout(function () { location.reload(); }, 1000);


                    // Show success first, then start email flow after short delay
                    //setTimeout(function () {
                    //    StartEmailFlowForDetail(comment, g_CurrentAction);
                    //}, 600);


                    // --- DYNAMIC UI UPDATE (no reload) ---
                    var newStatus = (g_CurrentAction === "Authenticate") ? "Approved" : "Rejected";

                    // Update status text in both spans
                    $("#ProjectTimesheetCurrentStatus").text(newStatus);
                    $("#ProjectTimesheetStatus").text(newStatus);

                    // Update status color
                    if (newStatus === "Rejected") {
                        $("#ProjectTimesheetCurrentStatus").css("color", "red");
                    } else if (newStatus === "Approved") {
                        $("#ProjectTimesheetCurrentStatus").css("color", "Green");
                    }

                    // Update buttons immediately (before email flow)
                    UpdateButtonVisibility(newStatus);

                    // Start email flow AFTER UI is already updated

                    //StartEmailFlowForDetail(comment, g_CurrentAction);



                    setTimeout(function () {
                        StartEmailFlowForDetail(comment, g_CurrentAction);
                    }, 2000);

                    // Update button visibility (redundant but safe)
                    //UpdateButtonVisibility();

                    //if (g_CurrentAction == "Authenticate")
                    //    $("#btn_authenticate").hide();

                    //else
                    //    UpdateButtonVisibility();




                    StopAjaxLoader('#bodyPreloader')

                } else {
                    var errMsg = (strResult && strResult[0].result) ? strResult.data.message : "Operation Failed.";
                    alertify.error(errMsg || "Update failed");
                }

            } catch (e) {
                console.error(e);
                alertify.error("An error occurred.");
            } finally {
                StopAjaxLoader('#bodyPreloader');
            }
        }

        // ==========================================
        // AUTHENTICATE LOGIC ENDS HERE
        // ==========================================



        // ==========================================
        // EMAIL FLOW AFTER APPROVE/REJECT (Timesheet Detail - single timesheet)
        // ==========================================
        function StartEmailFlowForDetail(comment, actionType) {
            //debugger;

            var messageID = (actionType === "Authenticate") ? 6 : 442;
            var param = JSON.stringify({
                employeeID: parseInt(UserID),
                timeSheetNo: parseInt(ProjectTimesheetID),
                projectID: parseInt(ProjectID) || 0,
                messageID: messageID
            });
            var result = AJAXCallWithResult("/api/ProjectTimesheetApproval/GetDataForEmail", param, false);
            if (result && result.data) result = result.data;
            var emailMsgArr = result && (result.emailMessageEntity || result.EmailMessageEntity);
            if (!result || !emailMsgArr || !emailMsgArr[0]) {
                //setTimeout(function () { location.reload(); }, 800);
                return;
            }
            var emailMsg = emailMsgArr[0];
            var sendMail = emailMsg.sendMail === true || emailMsg.SendMail === true;
            if (!sendMail) {
                //setTimeout(function () { location.reload(); }, 800);
                return;
            }
            var recipientArr = result.timesheetRecipientInfoResponse || result.TimesheetRecipientInfoResponse;
            var recipientInfo = (recipientArr && recipientArr[0]) ? recipientArr[0] : {};
            var employeeList = result.employeeEmailEntity || result.EmployeeEmailEntity || [];
            var toEmails = [];
            var firstEmployeeName = "";
            for (var i = 0; i < employeeList.length; i++) {
                var em = employeeList[i].emailID || employeeList[i].EmailID;
                if (em && em.trim()) toEmails.push(em.trim());
            }
            if (employeeList.length > 0) firstEmployeeName = employeeList[0].employeeName || employeeList[0].EmployeeName || "";
            var toEmail = toEmails.join(", ");
            var fromEmail = (recipientInfo.fromEmail || recipientInfo.FromEmail || result.fromEmail || result.FromEmail) || "";
            var subject = emailMsg.subject || emailMsg.Subject || "";
            var body = emailMsg.body || emailMsg.Body || "";
            var projectName = recipientInfo.projectName || recipientInfo.ProjectName || "";
            var fromDateStr = formatDateForEmailDetail(recipientInfo.fromDate || recipientInfo.FromDate);
            var toDateStr = formatDateForEmailDetail(recipientInfo.toDate || recipientInfo.ToDate);
            subject = subject.replace(/<PROJECT_NAME>/g, projectName);
            body = body.replace(/<PROJECT_NAME>/g, projectName);
            body = body.replace(/<START_DATE>/g, fromDateStr);
            body = body.replace(/<END_DATE>/g, toDateStr);
            body = body.replace(/<COMMENTS>/g, comment || "");
            body = body.replace(/<SENDER_NAME>/g, UserName || "");
            body = body.replace(/<NAME>/g, firstEmployeeName);
            var showPopup = emailMsg.showPopup === true || emailMsg.ShowPopup === true;
            var emailData = {
                timesheetNo: ProjectTimesheetID,
                fromEmail: fromEmail,
                toEmail: toEmail,
                ccEmail: fromEmail,
                subject: subject,
                body: body
            };

            
            if (!sendMail) {
                // sendMail false: skip sending, move to next
              
                return;
            }
            //if (showPopup) {
            //    showTimesheetEmailModalDetail(emailData);
            //} else {
            //    sendTimesheetEmailDirectDetail(emailData, false);
            //    setTimeout(function () { location.reload(); }, 800);
            //}
            if (!sendMail) {
                // sendMail false: skip sending, move to next
             
                return;
            }
            if (showPopup) {
                showTimesheetEmailModal(emailData);
            } else {
                // sendMail true, showPopup false: send directly without popup, silently
                sendTimesheetEmailDirect(emailData, false);
                
            }

        }
        function formatDateForEmailDetail(dateString) {
            if (!dateString) return "";
            var d = new Date(dateString);
            if (isNaN(d.getTime())) return dateString;
            var day = ("0" + d.getDate()).slice(-2);
            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            return day + "-" + months[d.getMonth()] + "-" + d.getFullYear();
        }
        function showTimesheetEmailModalDetail(emailData) {
            $("#sendTimesheetEmailFrom").val(emailData.fromEmail);
            $("#sendTimesheetEmailTo").val(emailData.toEmail);
            $("#sendTimesheetEmailCC").val(emailData.ccEmail);
            $("#sendTimesheetEmailSubject").val(emailData.subject);
            $("#sendTimesheetEmailBody").val(emailData.body);
            $("#sendTimesheetEmailBtn").data("emailData", emailData);
            var modal = new bootstrap.Modal(document.getElementById('SendTimesheetEmailModal'));
            modal.show();
            //$('#SendTimesheetEmailModal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
            //    setTimeout(function () { location.reload(); }, 300);
            //});
            // No reload on close — UI already updated before email flow
            $('#SendTimesheetEmailModal').off('hidden.bs.modal');
        }
        function sendTimesheetEmailFromModalDetail() {
            var emailData = $("#sendTimesheetEmailBtn").data("emailData");
            if (!emailData) return;
            emailData.toEmail = $("#sendTimesheetEmailTo").val().trim();
            emailData.ccEmail = $("#sendTimesheetEmailCC").val().trim();
            emailData.subject = $("#sendTimesheetEmailSubject").val().trim();
            emailData.body = $("#sendTimesheetEmailBody").val().trim();
            if (!emailData.toEmail || !emailData.subject || !emailData.body) {
                alertify.error("Please fill all mandatory fields (To, Subject, Message).");
                return;
            }
            var success = sendTimesheetEmailDirectDetail(emailData, true);
            var modal = bootstrap.Modal.getInstance(document.getElementById('SendTimesheetEmailModal'));
            if (modal) modal.hide();
            if (success) alertify.success("Email sent successfully.");
            else alertify.error("Failed to send email.");
            //setTimeout(function () { location.reload(); }, 800);
        }
        function sendTimesheetEmailDirectDetail(emailData, showAlert) {
            //debugger;

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
            // Use the same SendEmail endpoint as listing page
            var result = AJAXCallWithResult("/api/ProjectTimesheetApproval/SendTimesheetEmail", JSON.stringify(payload), false);
            var success = !!(result && (result.status === true || result.status === "true"));
            if (showAlert) {
                if (success) alertify.success("Email sent successfully.");
                else alertify.error((result && (result.message || result.Message)) || "Failed to send email.");
            }
            return success;
        }


        // ==========================================
        // EMAIL FLOW AFTER APPROVE/REJECT (Timesheet Detail - single timesheet) ENDS HERE
        // ==========================================



        // ==========================================
        // Send  Email Directly
        // ==========================================

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
            // Only treat as success when API explicitly returns status === true (not on error or undefined)
            var success = !!(result && (result.status === true || result.status === "true"));
            if (showAlert) {
                if (success) {
                    alertify.success("Email sent successfully.");
                } else {
                    var errMsg = (result && (result.message || result.Message)) ? (result.message || result.Message) : "Unknown error";
                    alertify.error("Failed to send email for Timesheet No. " + emailData.timesheetNo + ": " + errMsg + ". Next row will be processed.");
                }
            }
            return success;
        }
        // ==========================================
        // Send  Email Directly Ends here
        // ==========================================


        // ==========================================
        // Update button vissiblility
        // ==========================================


        function UpdateButtonVisibility(currentStatus) {
            // If status not provided, read it from the status span (updated by ViewProjectTimesheet)
            if (!currentStatus) {
                currentStatus = $("#ProjectTimesheetCurrentStatus").text().trim();
            }

            $("#btn_authenticate").hide();
            $("#btn_reject").hide();
            $("#btn_view_comment").hide();

            // If timesheet is already invoiced, never show Approve/Reject
            if (GInvoiceExists) {
                // Optionally show a message or just hide both
                return;
            }


            if (currentStatus === "Rejected") {
                $("#btn_view_comment").show();
            } else if (currentStatus === "Approved") {
                $("#btn_reject").show();
                $("#btn_view_comment").show();
            } else {
                // Pending / Submitted
                $("#btn_authenticate").show();
                $("#btn_reject").show();
            }
        }


        // ==========================================
        // Update button vissiblility ends here
        // ==========================================


        // Global flag for invoice existence
        var GInvoiceExists = false;

        // Check if this timesheet is already invoiced (so cannot approve/reject)
        function CheckInvoiceExists() {
            var Parameters = {
                TimesheetID: parseInt(ProjectTimesheetID)
            };
            var param = JSON.stringify(Parameters);
            var result = AJAXCallWithResult("/api/ProjectTimesheetApproval/IsInvoiceExistsForProjectTimesheet", param, false);

            if (result && result.isExist !== undefined) {
                GInvoiceExists = (result.isExist == 1); // true if exists
            } else {
                GInvoiceExists = false;
            }

            // Refresh button visibility based on new flag and current status
            UpdateButtonVisibility();
        }

       

    </script>


</body>

</html>
    <%--End of code added by Vaibhav K on 04-03-26--%> 
