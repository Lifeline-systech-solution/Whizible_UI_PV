<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TaskStatusManagement.aspx.vb" Inherits="Whizible.TaskStatusManagement" %>


<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Task Status Management")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Task Status Management</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">-->
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!-- custom style -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_project.css?v=3.1">--%>
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <!--<link rel="stylesheet" href="../../../Whizible2.0/dist/css/whiz20_theme.css">-->
    <script src="Common.js"></script>

    <%-- <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
</head>

    <style>
        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px
        }

        .filterpanelbody {
            padding: 30px 0
        }

        /*Task Management table start*/
        .btn-condensed.btn-condensed {
            padding: 0 5px;
            box-shadow: none
        }

        .hide-col {
            width: 0 !important;
            height: 0 !important;
            display: block !important;
            overflow: hidden !important;
            margin: 0 !important;
            padding: 0 !important;
            border: none !important
        }

        .tdCurrent, tdbaseline, tdactual {
            display: table-cell
        }

        td.hidecol, th.hidecol {
            display: table-cell;
            font-size: 0;
            width: 20px !important;
            min-width: auto !important;
            border: none !important;
            border-bottom: 1px solid #ddd !important;
            text-align: center !important;
            padding: 5px !important
        }
        /*Task Management table end*/

        .TMtbl th {
            vertical-align: middle !important
        }
        
        /* Added by Vyankat B. on 23-Mar-2026 to minimize row height */
        .TMtbl tbody td {
            padding-top: 4px !important;
            padding-bottom: 4px !important;
            line-height: 1.15 !important;
        }
        /* End of Added by Vyankat B. on 23-Mar-2026 to minimize row height */

            .TMtbl th:nth-child(7), .TMtbl td:nth-child(7) {
                border-right: 1px solid #ddd !important
            }

            .TMtbl td .fa-minus, .TMtbl th .fa-minus {
                display: block
            }

            .TMtbl td .fa-plus, .TMtbl th .fa-plus {
                display: none
            }

            .TMtbl td.hidecol .fa-minus, .TMtbl th.hidecol .fa-minus {
                display: none
            }

            .TMtbl td.hidecol .fa-plus, .TMtbl th.hidecol .fa-plus {
                display: block;
                font-size: 14px;
                color: #1359a6
            }

        .hide-column {
            background: none;
            border: none;
            outline: none
        }

            .hide-column:hover, .hide-column:focus {
                background: none;
                border: none;
                outline: none
            }

        .hidecol .custom_chckbox {
            display: none
        }

        .table thead tr th:nth-child(2) {
            min-width: 150px;
            text-align: center
        }

        .table thead tr th:first-child {
            min-width: 10px !important
        }

        .table thead tr th:last-child {
            min-width: 20px !important
        }

        .table tbody tr td:first-child {
            text-align: left
        }

        .container-fluid ul.statustext {
            margin: 0;
            padding: 0
        }

        /* Added by Vyankat B. on 23-Mar-2026 - PM_AssignedTasks style pagination block */
        #taskStatusPaginationControls .buttons {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        #taskStatusPaginationControls .spntotal {
            color: #1f2937;
            font-size: 14px;
        }

        #taskStatusPaginationControls .page-item.disabled .page-link,
        #taskStatusPaginationControls .page-link.disabled {
            color: #9ca3af !important;
            background: #f9fafb !important;
            border-color: #e5e7eb !important;
            pointer-events: none !important;
            cursor: not-allowed !important;
        }
        /* End of Added by Vyankat B. on 23-Mar-2026 - PM_AssignedTasks style pagination block */

        .custom_chckbox label:before {
            margin-right: 0
        }

        .toplinks {
            border-top: 1px solid #eee
        }

        .custmodal .custom_chckbox label:before {
            border-color: #464a4c
        }

        .filterpanel .filterpanelheader {
            border-top: 1px solid #eee
        }

        .toplinks .row {
            display: flex;
            align-items: center
        }

        a.clearalllink {
            font-weight: 700;
            margin: 7px 10px 0;
            display: none
        }

        .filter.float-end {
            margin: 6px 0 0
        }

        .perceinput {
            width: 80px;
            margin: 0 auto;
            text-align: center
        }

        .shwbaselinetbl tr th {
            min-width: 100px
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important
        }

        /*collapsibleinfopanel*/
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
        /*collapsibleinfopanel-end*/

        .statustext li.bluestatuslbl a span.statustextno {
            background: #41aae0
        }

        .statustext li.lightgraystatuslbl a span.statustextno {
            background: #6495ed
        }

        .alltask {
            color: #eb1c24
        }

        .selperiodTsk {
            color: #6495ed
        }

        .assignTsk {
            color: #9dd824
        }

        .MPPTsk {
            color: #868686
        }

        .generalTsk {
            color: #f4cd0f
        }

        .issueTsk {
            color: orangered
        }

        .reviewTsk {
            color: #fbb03b
        }

        .helpDeskTsk {
            color: lightblue
        }

        .showallTsk {
            color: blue
        }

        .statustext li a {
            border: 1px solid #1359ac;
            padding: 4px 10px
        }

        .statustext li {
            display: inline-block;
            margin-right: 10px;
            list-style-type: none
        }

            .statustext li.showallTsk span {
                background: blue
            }

                .statustext li.showallTsk span:hover {
                    background: blue
                }

        .IcnGridlegend {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .note {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .d-inline-block {
            display: inline-block
        }

        .legend ul {
            display: inline-block;
            padding: 0;
            margin: 10px 0 0;
            vertical-align: top
        }

        .legend label {
            margin-bottom: 0
        }

        .legend ul li {
            display: inline-block; margin:0px 1px;
        }

        .TMtbl {
            width: 100% !important
        }

        .custom_radio input[type="radio"] + label span {
            margin: 0 8px 0 12px
        }

        .shocollinks a {
            cursor: pointer;
            border-right: 1px solid #ccc;
            padding: 0 10px
        }

            .shocollinks a:last-child {
                border-right: none
            }

        th[colspan='2'] {
            border: 1px solid #ddd !important
        }
        /*.colapsibleinfopanel .panel-body{ background:#f5f5f5;}*/

        .dataTables_scrollHeadInner table {
            width: 100% !important;
        }

        .input-sm + span button.btn.btncalendar {
            height: 30px;
        }

        .selactionDrop {
            /*border-left: 1px solid #ccc;*/
            background: #e7edf0;
            padding: 10px 10px;
        }
.ui-datepicker td span, .ui-datepicker td a {padding: 0.66em;font-size: 13px!important;font-weight: 500!important;}

        @media screen and (max-width:1024px) {
            .colapsibleinfopanel {
                font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            }
        }
.btnyellow {
    background: #fbb03b;
    color: #fff;
}

 .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;            
            border-radius: 15px;
            background: #ddd; 
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

 .clsShowHide {
            display: none !important;
        }
        
        /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        .panel-default > .panel-heading a {
            display: block;
        }
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        
        /* Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze */
        .statckmainheader {
            position: sticky !important;
            top: 0 !important;
            z-index: 1000 !important;
            background-color: #f5f5f5 !important;
        }
        
        .filterpanelheader {
            position: sticky !important;
            top: 0 !important;
            z-index: 999 !important;
            background-color: #f8f9fa !important;
        }
        
        /* When filter panel is visible, adjust top position for filter panel header */
        .filterpanel:not(.collapse) .filterpanelheader {
            top: 0 !important;
        }
        
        /* Ensure DataTable scroll head is sticky */
        .dataTables_scrollHead {
            position: sticky !important;
            top: 0 !important;
            z-index: 998 !important;
        }
        
        .dataTables_scrollHeadInner {
            background-color: #fff !important;
        }
        
        .dataTables_scrollHeadInner table thead {
            background-color: #fff !important;
        }
        
        /* Ensure table wrapper allows sticky positioning */
        .TMtblwrap {
            position: relative;
        }
        
        /* Make sure thead is sticky within DataTable */
        #TMtbl thead {
            position: sticky;
            top: 0;
            z-index: 997;
            background-color: #fff;
        }
        
        /* Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Column Alignment */
        /* Ensure header and body columns are aligned */
        .dataTables_scrollHeadInner table,
        .dataTables_scrollBody table {
            width: 100% !important;
            table-layout: auto !important;
        }
        
        /* Ensure scroll head and body have same width */
        .dataTables_scrollHead {
            overflow: hidden !important;
        }
        
        .dataTables_scrollHeadInner {
            width: 100% !important;
        }
        
        /* Ensure header and body tables have matching column structure */
        .dataTables_scrollHeadInner table thead th,
        .dataTables_scrollBody table tbody td {
            box-sizing: border-box !important;
            padding-left: 8px !important;
            padding-right: 8px !important;
        }
        
        /* Prevent column width issues */
        .dataTables_scrollBody {
            overflow-x: hidden !important;
        }
        
        
        /* Force exact column width matching */
        .dataTables_scrollHeadInner table thead th,
        .dataTables_scrollBody table tbody td {
            vertical-align: top;
        }
        
        /* Ensure no border spacing differences */
        .dataTables_scrollHeadInner table,
        .dataTables_scrollBody table {
            border-collapse: collapse !important;
            border-spacing: 0 !important;
        }
        /* End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Column Alignment */
        
        /* Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix */
        /* Ensure datepicker appears above all frozen headers */
        .ui-datepicker,
        .ui-datepicker-div,
        .ui-datepicker-dialog {
            z-index: 10001 !important;
        }
        
        /* Ensure datepicker wrapper also has high z-index */
        .ui-datepicker-container {
            z-index: 10001 !important;
        }
        /* End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix */
        /* End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze */
        
        /* Added by Dipali V on 14th Nov 2025 for W26 Changes - Timeline combined view styles */
        .timeline-plan-col,
        .timeline-start-col,
        .timeline-end-col,
        .timeline-work-col {
            padding: 8px 5px;
            vertical-align: top;
        }
        .timeline-plan-col div,
        .timeline-start-col div,
        .timeline-end-col div,
        .timeline-work-col div {
            padding: 4px 0;
            min-height: 20px;
        }
        .timeline-plan-col div:last-child,
        .timeline-start-col div:last-child,
        .timeline-end-col div:last-child,
        .timeline-work-col div:last-child {
            border-bottom: none;
        }
        .timeline-plan-label {
            font-weight: 600;
            text-align: left;
        }
        .timeline-plan-label.current {
            color: #0066cc;
        }
        .timeline-plan-label.baseline {
            color: #ff6600;
        }
        .timeline-plan-label.actual {
            color: #00aa00;
        }
        .timeline-start-col div,
        .timeline-end-col div,
        .timeline-work-col div {
            text-align: center;
        }
        /* End of Added by Dipali V on 14th Nov 2025 for W26 Changes */
        /*Added By Dipali V On 20th Jan 2026 For W26 Changes*/
        .bgwhite {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size:11.5px!important;
        }
        .form-control, .btn, a, p, input, select.form-select
        {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size:11.5px!important;
        }
                 .btn-primary-action {
    background: #fef3c7;
    color: #d97706;
    border: none;
    padding: 0.3rem 0.78rem;
    font-weight: 400;
    font-size: 0.8125rem;
    border-radius: 6px;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    box-shadow: none;
}
        .btn-primary-action:hover {
    background: #fde68a;
    color: #b45309;
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}
          /*End of Added By Dipali V On 20th Jan 2026 For W26 Changes*/
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed" id="tbody">
     <div id="tbody1"> </div>
    <% If m_blnViewAccess = True Then %>
    <div class="bgwhite">

       <%-- <div class="graybg container-fluid pt-1 pb-1 statckmainheader">
         
             <h5 class="pgtitle">Task Status Management</h5>
        </div>--%>


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
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproOne" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproOne" data-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="task" class="radiotextsty">Task and milestones</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproTwo" type="checkbox" name="">
                                            <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproTwo" data-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-original-title="" title="">
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-original-title="Set Default filter"></span>
                                    </label>
                                    <label class="">
                                        <span for="groupcompany" class="radiotextsty">For group company</span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproThree" type="checkbox" name="">
                                            <label data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" for="IssueselproThree" data-original-title="Apply filter"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-original-title="Edit filter"></span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-original-title="Delete filter"></i></span>
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
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal">Save and Apply</button>
                                    <button class="btn btnyellow">Apply</button>
                                </div>
                                <br />

                                <div class="row">

                                    <div class="col-sm-4">
                                        <label class="control-label">From Date</label>
                                        <div class="input-group datefielddiv">
                                            <input id="TSMFfromdate" type="text" name="" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <label class="control-label">To Date</label>
                                        <div class="input-group datefielddiv">
                                            <input id="TSMFtodate" type="text" name="" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>

                                    </div>
                                    <div class="col-sm-4">
                                        <label class="control-label">Resource</label>
                                        <select class="form-control">
                                        </select>

                                    </div>


                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <!--end filter panel-->

        <div class="pt-1 text-end col-sm-12">
            <%If (m_blnAddAccess = True Or m_blnEditAccess = True) Then %>
            <%--Commented & Added By Dipali V On 20th Jan 2026 For Save button generic--%>
            <%--<a href="javascript:Save_OnClick();" id="btnsave" class="btn btnyellow">Save</a>--%>
            <a href="javascript:Save_OnClick();" id="btnsave" class="btn btn-primary-action"><i class="fas fa-save"></i> Save</a>
            <%--End of Commented & Added By Dipali V On 20th Jan 2026 For Save button generic--%>
            <%End If %>
            <a href="javascript:PreviousWeek_OnClick();" class="btn borderbtn">Previous Week</a>
            <a href="javascript:NextWeek_OnClick();" class="btn borderbtn">Next Week</a>
        </div>
        <div class="col-sm-12">
            <div class="panel-group colapsibleinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                <div class="panel panel-default panel-horizontal lightgraybg">
                    <div class="panel-heading" role="tab" id="TMinfoHeadingOne">
                        <h4 class="panel-title">
                            <!-- Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#TMinfoCollapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Perform Action
                            
                            <span class="infoToggler togglerup float-end">
                                <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                            </span>
                        </a>
                            <!-- End of Added By Gauri On 21th Aug 2024 For Alignment Issue -->
                        </h4>
                    </div>

                    <div id="TMinfoCollapseOne" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="TMinfoHeadingOne">
                        <div class="panel-body clearfix">
                            <div class="clearfix"></div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-4 text-start" style="padding-top: 5px;">
                                        <label class="" style="margin-top: 5px;"><%=MyBase.GetResourceString("LABEL_SELECT_PROJECT") %></label>
                                        <div class="p-0">
                                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQLQuery, , CType(m_intProjectID, String), "onchange=LoadEmployees()",, True, "form-select input-sm") %>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 text-start" style="padding-top: 5px;">
                                        <label class="" style="margin-top: 5px;">Select Resource</label>
                                        <div class="p-0">
                                            <%-- Commented and updated by Vyankat B. on 1st April 2026 for changing the SP name to fix placeholder issue --%>
<%--                                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "EXEC usp_Sel_teammembers " & CType(m_intProjectID, String), , CType(m_intEmployeeID, String), "", True, True, "form-select input-sm")%>--%>
                                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "EXEC usp_Whizible2_Sel_TeamMembers " & CType(m_intProjectID, String), , CType(m_intEmployeeID, String), "", False, True, "form-select input-sm")%>
                                            <%-- End of commented and updated by Vyankat B. on 1st April 2026 --%>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 text-start" style="border-left: 1px dashed #ccc;">
                                        <div class="selactionDrop">
                                            <label class="required" style="margin-top: 5px;">Select Action</label>
                                            <div class="p-0">
                                                <%=CommonFunctions.HTMLControls.DrawComboBox("cboOperation", "usp_sel_operation_forTaskStatusManagement", , "1", "", True, True, "form-select input-sm") %>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-sm-4" style="margin-top: 5px;">
                                    <div class="d-inline-block">
                                        <%=CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optAllTasks", , , CStr("1"), , " language=Javascript OnClick=optTasks_OnClick('ShowALL') ", True) %>
                                        <label for="PAfltrechecklistID1"><span></span><%=MyBase.GetResourceString("SHOW_ALL_TASKS") %></label>
                                    </div>
                                    <div class="d-inline-block">
                                        <%=CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optTasksForTheWeek", , True, CStr("2"), , " language=JavaScript OnClick=optTasks_OnClick('ShowWeekly') ", True) %>
                                        <label for="PAfltrechecklistID2"><span></span><%=MyBase.GetResourceString("SHOW_TASKS_FOR_PERIOD") %></label>
                                    </div>

                                </div>


                                <div class="col-sm-4 text-start">
                                    <label class="" style="margin-top: 5px;"><%=MyBase.GetResourceString("LABEL_FROM_DATE") %></label>
                                    <div class="col-sm-10 p-0">
                                        <div class="input-group datefielddiv">
                                            <%=CommonFunctions.HTMLControls.DrawTextBox("txtFromDate", "txtFromDate", "form-control input-sm", , , DateTime.Now.ToString("d-MMM-y"), , returnHTML:=True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4 text-start">
                                    <label class="" style="margin-top: 5px;"><%=MyBase.GetResourceString("LABEL_TO_DATE") %></label>
                                    <div class="col-sm-10 p-0">
                                        <div class="input-group datefielddiv">
                                            <%=CommonFunctions.HTMLControls.DrawTextBox("txtToDate", "txtToDate", "form-control input-sm", , , DateTime.Now.AddDays(6).ToString("d-MMM-y"), , returnHTML:=True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <br />
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <div class="d-inline-block">
                                            <%=CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , True, TASK_TYPE_ASSIGNED, , "", True) %>
                                            <label for="PAfltrechecklistID3"><span></span><%=MyBase.GetResourceString("OPT_ASSIGNED_TASKS") %></label>
                                        </div>
                                        <div class="d-inline-block">
                                            <%=CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , , TASK_TYPE_MPP, , "", True) %>
                                            <label for="PAfltrechecklistID3"><span></span><%=MyBase.GetResourceString("OPT_MPP_TASKS") %></label>
                                        </div>
                                        <div class="d-inline-block">
                                            <%=CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , , TASK_TYPE_ISSUE, , "", True) %>
                                            <label for="PAfltrechecklistID3"><span></span><%=MyBase.GetResourceString("OPT_ISSUE_TASKS") %></label>
                                        </div>
                                        <div class="d-inline-block">
                                            <%=CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , , TASK_TYPE_REVIEW, , "", True) %>
                                            <label for="PAfltrechecklistID3"><span></span><%=MyBase.GetResourceString("OPT_REVIEW_TASKS") %></label>
                                        </div>
                                        <div class="d-inline-block">
                                            <%=CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optTaskType", , , TASK_TYPE_HELPDESK, , "", True) %>
                                            <label for="PAfltrechecklistID3"><span></span><%=MyBase.GetResourceString("OPT_HELP_TASKS") %></label>
                                        </div>
                                    </div>
                                    <div class="col-sm-3 text-start">
                                        <button class="btn btnyellow" onclick="Show_OnClick()">Show</button>
                                    </div>
                                </div>
                            </div>

                            <div class="note text-start float-start"><em><strong>Note :</strong> Tasks which do not have status selected in the 'Action' combobox are displayed</em></div>
                            <div class="legend mr-1 float-end">
                                <ul class="">
                                    <li>
                                        <label>Legends:&nbsp;</label></li>
                                    <!--<li><i class="fas fa-square IcnGridlegend selperiodTsk" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="" data-original-title="Show Task For Selected Period"></i></li>-->
                                    <li><i class="fas fa-square IcnGridlegend assignTsk" title="Assigned Task" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Assigned Tasks"></i></li>
                                    <li><i class="fas fa-square IcnGridlegend MPPTsk" title="MPP Task" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body"  data-original-title="MPP Tasks"></i></li>
                                    <li><i class="fas fa-square IcnGridlegend issueTsk" title="Issue Task" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Issue Tasks"></i></li>
                                    <li><i class="fas fa-square IcnGridlegend reviewTsk" title="Review Task" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Review Tasks"></i></li>
                                    <li><i class="fas fa-square IcnGridlegend helpDeskTsk" title="Helpdesk Task" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Help-Desk Tasks"></i></li>
                                </ul>
                            </div>
                        </div>
                    </div>


                </div>
            </div>

        </div>

        <div class="clearfix"></div>
        <section class="content pt-0">
            <div class="TMtblwrap" id="divMain">
                <!--Task management table start here-->
                <div class="clearfix"></div>
                <!--<div class="shocollinks">
                        Show <a class="colbaseline">Baseline</a> <a class="colactual">Actual</a>
                    </div>-->

                <!-- Added by Dipali V on 14th Nov 2025 for W26 Changes - Updated table header: Task Name, Resource Name, Start Date, End Date, then Timeline -->
                <!-- Static table hidden initially to prevent DataTables initialization error, will be replaced by LoadTaskList() -->
                <table id="TMtbl" class="table table-stripped table-bordered TMtbl table-hideable" style="display:none;">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th colspan="3" style="text-align: center;">
                                Timeline
                            </th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                        </tr>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Task Name</th>
                            <th>Resource Name</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Plan</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Work (hours)</th>
                            <th>Actual Work (hours)</th>
                            <th><strong>% Completion</strong></th>
                            <th>Select</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Added by Dipali V on 14th Nov 2025 for W26 Changes - Placeholder row with correct column count to prevent DataTables error -->
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <!-- End of Added by Dipali V on 14th Nov 2025 for W26 Changes -->
                    </tbody>
                </table>
                <!-- End of Added by Dipali V on 14th Nov 2025 for W26 Changes -->

            </div>

            <div class="d-flex justify-content-end w-100 mt-2" id="taskStatusPaginationControls" style="display:none;">
                <div class="buttons">
                    <span class="spntotal">Total Records:</span>
                    <span class="spntotal" id="TotalRecords">0</span>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-end" style="margin: 0px!important">
                            <li class="page-item disabled" id="btnprevious">
                                <a class="page-link disabled" aria-label="Previous" id="LinkPrevious" onclick="PrevList(); return false;">
                                    <i class="fas fa-angle-double-left"></i>
                                </a>
                            </li>
                            <li class="page-item disabled" id="btnnext">
                                <a class="page-link disabled" aria-label="Next" id="LinkNext" onclick="NextList(); return false;">
                                    <i class="fas fa-angle-double-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>


        </section>

        <div class="modal custmodal  fade" id="TMOthertaskmodal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Select Other Task</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-stripped table-bordered tmselectTaskModaltbl" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>Task Name</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheckhead" value="" class="chckHead">
                                                <label name="TMbillablechk1" for="SOTcheckhead"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Assignment</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck1" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck1"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Automation General</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck2" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck2"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>ChckGen</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck3" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck3"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Complaint Calls</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck4" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck4"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Conduct Interview</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck5" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck5"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Customer Meeting</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck6" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck6"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Customer Support</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck7" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck7"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Data Creation</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck8" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck8"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Discussion</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck9" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck9"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Feedback Calls</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck10" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck10"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Generic Task</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck11" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck11"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>GHFG</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck12" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck12"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Internal Meeting</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck13" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck13"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Interview Process</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck14" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck14"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Introduction Calls</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck15" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck15"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Mass Mailing</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck16" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck16"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>New Registration Calls</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck17" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck17"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Recruitment Handling</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck18" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck18"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>SRS Understanding</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck19" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck19"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Testing</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck20" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck20"></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>unplanned</td>
                                        <td>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck21" value="" class="chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck21"></label>
                                            </div>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                        <br />

                        <div class="text-center">
                            <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                            <button class="btn btnyellow" data-bs-dismiss="modal">Save</button>
                        </div>

                    </div>
                    <!-- /.content -->
                    <div class="clearfix"></div>
                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Save filter Modal End here-->
    <!--taskmapping modal popup-->
    <div class="modal custmodal Issuesave_filter fade" id="TaskMapingmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Task Mapping</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="control-label col-sm-4 text-end">Task Name :</label>
                            <div class="col-sm-8">Conduct/Attend Training</div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="control-label col-sm-4 text-end">Task Type :</label>
                            <div class="col-sm-8">
                                <select class="form-select">
                                    <option>Select Task Type</option>
                                    <option title="Analysis" value="">Analysis</option>
                                    <option title="Customer Support" value="">Customer Support</option>
                                    <option title="Design" value="">Design</option>
                                    <option title="Development" value="">Development</option>
                                    <option title="Estimation" value="">Estimation</option>
                                    <option title="Meeting" value="">Meeting</option>
                                    <option title="Project Management" value="">Project Management</option>
                                    <option title="Release" value="">Release</option>
                                    <option title="Requirement Gathering" value="">Requirement Gathering</option>
                                    <option title="Review" value="">Review</option>
                                    <option title="Rework" value="">Rework</option>
                                    <option title="Study or Research" value="">Study or Research</option>
                                    <option title="Tech Documentation" value="">Tech Documentation</option>
                                    <option title="Testing" value="">Testing</option>
                                    <option title="Training" selected="" value="">Training</option>
                                    <option title="User Acceptance Test" value="">User Acceptance Test</option>
                                </select>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end">Phase :</label>
                            <div class="col-sm-8">
                                <select class="form-select">
                                    <option>Select Phase</option>
                                    <option value="">Deployment</option>
                                    <option value="">Design</option>
                                    <option value="">Development</option>
                                    <option value="">Planning &amp; Estimation</option>
                                    <option value="">Product Conceptualization</option>
                                    <option value="">Requirement Analysis</option>
                                    <option value="">Requirement Gathering</option>
                                    <option value="">Testing</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end">Module :</label>
                            <div class="col-sm-8">
                                <select class="form-select">
                                    <option value="">Select Module</option>
                                    <option value=""></option>
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end">Sub Project :</label>
                            <div class="col-sm-8">
                                <select class="form-select">
                                    <option value="">Select Sub Projct</option>
                                    <option value=""></option>
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end">Milestone :</label>
                            <div class="col-sm-8">
                                <select class="form-select">
                                    <option value="">Select Milestone</option>
                                    <option value=""></option>
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end">Deliverable :</label>
                            <div class="col-sm-8">
                                <select class="form-select">
                                    <option value="">Select Deliverable</option>
                                    <option value="">Test Deliverable 1</option>
                                    <option value="">Test Deliverable 2</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <label class="control-label col-sm-4 text-end">&nbsp;</label>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <button class="btn borderbtn" data-bs-dismiss="modal">Cancel</button>
                                <button class="btn btnyellow" data-bs-dismiss="modal">Save</button>
                            </div>
                        </div>
                    </div>


                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!--taskmapping modal popup end-->
    <!-- Show Baseline Modal start here-->
    <div class="modal custmodal fade" id="showBaslineModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Show Baseline</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="clearfix"></div>
                <div class="modal-body">
                    <p><strong>Baseline History For Task :</strong> Conduct/Attend Training</p>
                    <div class="table-responsive">
                        <table class="table table-bordered shwbaselinetbl">
                            <thead>
                                <tr>
                                    <th>Change Date</th>
                                    <th>Current Start Date</th>
                                    <th>Current End Date</th>
                                    <th>Baseline End Date</th>
                                    <th>Baseline Work</th>
                                    <th>Baseline Duration</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class=""></td>
                                    <td class=""></td>
                                    <td class=""></td>
                                    <td class=""></td>
                                    <td class=""></td>
                                    <td class=""></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <% Else %>
    <div id="NotAuthorized">
        <div style="text-align: center; overflow: auto; width: 100%; background-color: white; margin-top: 3%;">
            <b style="margin-top: 6%; text-align: center;">You are not Authorized to view this record.</b>
        </div>
    </div>
    <%End If %>
    </div>
    <!-- Show Baseline Modal End here-->
    <!-- REQUIRED JS SCRIPTS -->
     <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
   
    <script>
        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Suppress DataTables warnings to prevent error popup on page load
        if (typeof $.fn.dataTable !== 'undefined') {
            $.fn.dataTable.ext.errMode = 'none';
        }
        // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
        
        //Added By Rehan C to get respective checkbox values on 22nd Feb 2023
        var AddAccess = '<%= m_blnAddAccess %>';
        var EditAccess = '<%= m_blnEditAccess %>';
        var DeleteAccess = '<%= m_blnDeleteAccess %>';
        var ViewAccess = '<%= m_blnViewAccess %>';
        //End Of Comment Added By Rehan C to get respective checkbox values on 22nd Feb 2023
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
        var LoginType = '<%=Session("LoginType").ToString%>';
        var LoginID = '<%=Session("intLoginID").ToString%>';
        var UserId = '<%= Session("intUserID") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var ProjectId = '<%= Session("intProjectID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var CProjectName = '<%=CommonFunctions.General.CheckIsNothing(Session("strProjectName"), "") %>';
        var TokenAuthenticate = '<%=CommonFunctions.General.CheckIsNothing(Session("strProjectName"), "")%>';

        var commonProperty = { ProjectId: ProjectId, RoleId: RoleID, EmployeeId: UserId, LoginType: LoginType, LoginId: LoginID, IssueID: 0, strMode: '' };
        var alertifyTimer = 5;
        alertify.set('notifier', 'position', 'top-right', 'color', 'white');
        $("[data-bs-toggle='tooltip']").tooltip();
        let GetTaskListAPI = "/api/TaskStatusManagement/GetTaskList";
        let SaveTasks = "/api/TaskStatusManagement/SaveTasks";
        let GetEmployees = "/api/TaskManagement/GetEmployees";
        let Getweekdates = "/api/TaskManagement/GetEmployees";

        // Added by DipalI v On 4th sep 2026 - Purpose: SHA256 hex for slim Params PayloadHash (must match ValidateHeaders generic hash)
        function sha256HexForSaveTasks(plainText) {
            if (!(window.crypto && window.crypto.subtle && typeof TextEncoder !== 'undefined')) {
                return Promise.reject(new Error('SHA-256 is not available in this browser context'));
            }
            return window.crypto.subtle.digest('SHA-256', new TextEncoder().encode(plainText || '')).then(function (buffer) {
                return Array.from(new Uint8Array(buffer)).map(function (b) {
                    return ('0' + b.toString(16)).slice(-2);
                }).join('');
            });
        }

        // Added by DipalI v On 4th sep 2026 - Purpose: SaveTasks field list for generic HashFields contract (page-specific; ActionFilter stays generic)
        var SAVE_TASKS_HASH_FIELDS = [
            'TaskId', 'ParentTaskId', 'ProjectId', 'm_intOperation', 'TaskType',
            'strActualPercentComplete', 'strTaskActualStartDate', 'strTaskActualEndDate', 'm_intMSPIntegrationMethod'
        ];

        // Added by DipalI v On 4th sep 2026 - Purpose: canonical row string using HashFields order (incl. ParentTaskId) for PayloadHash
        function buildSaveTasksHashPayload(taskList, hashFields) {
            var fields = hashFields || SAVE_TASKS_HASH_FIELDS;
            var list = (taskList || []).slice();
            list.sort(function (a, b) {
                return (parseInt(a.TaskId, 10) || 0) - (parseInt(b.TaskId, 10) || 0);
            });
            return list.map(function (t) {
                return fields.map(function (f) {
                    var v = t[f];
                    if (v == null) return '';
                    if (f === 'TaskId' || f === 'ParentTaskId' || f === 'ProjectId' || f === 'm_intOperation' || f === 'm_intMSPIntegrationMethod') {
                        return String(parseInt(v, 10) || 0);
                    }
                    return String(v);
                }).join('|');
            }).join('\n');
        }

        // Added by DipalI v On 4th sep 2026 - Purpose: SaveTasks-only AJAX — full body + slim generic Hash Params; other page APIs still use AJAXCallWithResult
        function AJAXCallWithResultSaveTasks(url, param, taskList, callback) {
            var list = taskList || [];
            var projectId = list.length ? parseInt(list[0].ProjectId, 10) : 0;
            var operation = list.length ? parseInt(list[0].m_intOperation, 10) : 0;
            var hashFields = SAVE_TASKS_HASH_FIELDS;
            var hashPayload = buildSaveTasksHashPayload(list, hashFields);

            sha256HexForSaveTasks(hashPayload).then(function (payloadHash) {
                var headerParam = JSON.stringify({
                    taskStatusManagementSaveParameters: {
                        ValidationMode: 'Hash',
                        ItemCount: list.length,
                        SortField: 'TaskId',
                        HashFields: hashFields,
                        MatchFields: {
                            ProjectId: projectId,
                            m_intOperation: operation
                        },
                        PayloadHash: payloadHash
                    }
                });
                $.ajax({
                    url: encodeURI(strUrl) + url,
                    type: 'POST',
                    data: param,
                    async: true,
                    dataType: 'json',
                    contentType: 'application/json;charset-utf=8',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem('access_token_project'));
                        xhr.setRequestHeader('Params', encryptString(headerParam));
                    },
                    success: function (data) {
                        if (typeof callback === 'function') {
                            callback(data);
                        }
                    },
                    error: function (jqXHR) {
                        console.log(jqXHR);
                        alertify.error('Save failed. Please try again.');
                    }
                });
            }).catch(function (err) {
                console.log(err);
                alertify.error('Save failed while preparing request.');
            });
        }
        //collappse row
        $(".UpDowncollapseArrow").click(function () {

            $(this).toggleClass("in");
            $('tr').removeClass('highlightrow');
            $(this).parents('tr').addClass('highlightrow');

        });

        function Show_OnClick() {
           // debugger
            StartLoader("#tbody1");
            //return;
            if (IsValidInput() == true) {
                LoadTaskList();
               // StopAjaxLoader("#tbody1");
            }
           
        }

        function LoadEmployees() {
            var selectedProjectId = $("#cboProject").val();
            var param = JSON.stringify(selectedProjectId ? parseInt(selectedProjectId, 10) : 0);

            AJAXCallWithResult(GetEmployees, param, true, "POST", function (result) {
                var employees = [];
                if (Array.isArray(result)) {
                    employees = result;
                } else if (result && Array.isArray(result.data)) {
                    employees = result.data;
                } else if (result && result.data && Array.isArray(result.data.data)) {
                    employees = result.data.data;
                }

                var $employee = $("#cboEmployee");
                $employee.html('');
                $employee.append("<option value=''></option>");
                for (var i = 0; i < employees.length; i++) {
                    var empId = employees[i].EmployeeId || employees[i].employeeId || "";
                    var empName = employees[i].EmployeeName || employees[i].employeeName || "";
                    if (empId !== "" && empName !== "") {
                        $employee.append("<option value='" + empId + "'>" + empName + "</option>");
                    }
                }
            });
        }
        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Suppress DataTables warnings globally to prevent error popup on page load
        if (typeof $.fn !== 'undefined' && typeof $.fn.dataTable !== 'undefined') {
            $.fn.dataTable.ext.errMode = 'none';
        }
        // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
        
        $(document).ready(function () {
           
            //$('.TMtbl tr th:nth-child(6), .TMtbl tr th:nth-child(7)').hide();            
            //$('.TMtbl tr td:nth-child(6), .TMtbl tr td:nth-child(7)').hide();

            //$('.TMtbl tr th:nth-child(8), .TMtbl tr th:nth-child(9)').hide();
            //$('.TMtbl tr td:nth-child(8), .TMtbl tr td:nth-child(9)').hide();
            //LoadTaskList();
            //cleartooltip
            // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
            $('#txtFromDate, #txtToDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:c+100',
                dateFormat: 'd-M-y',
                beforeShow: function(input, inst) {
                    // Ensure datepicker appears above frozen headers
                    setTimeout(function() {
                        $('.ui-datepicker').css('z-index', '10001');
                    }, 1);
                }
            });
            // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
            $(document).on("mouseout", 'th span, .ui-corner-all', function () {
                $(".tooltip").remove();
            });
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });

            // Added by Dipali V on 14th Nov 2025 for W26 Changes - Removed DataTables column adjustment on page load to prevent initialization on static table
            // setTimeout(function () {
            //     $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            // }, 0);
            // var tblheight = $(window).height();
            // $('.dataTables_scrollBody').css({ 'height': tblheight - 495, "overflow-y": "auto" });
            // End of Added by Dipali V on 14th Nov 2025 for W26 Changes

            $("[name=optTaskType]").change(function () {
                m_strTaskType = $(this).val()
            })
            DisableEnableShowBtn();
            Getweekdates1();//Added By Dipali V On 9th May 2023 For Get week start Date & end Date
            // LoadEmployees();//Commented by Dipali V On 7th July 2026 for Avoid multiple API call on page load
            Show_OnClick();
        });
        //Added By Dipali V On 9th May 2023 For Get week start Date & end Date
        function startOfWeek(date) {
            var diff = date.getDate() - date.getDay() + (date.getDay() === 0 ? -6 : 1);
            return new Date(date.setDate(diff));

        }
        //End of Added By Dipali V On 9th May 2023 For Get week start Date & end Date
        function Getweekdates1() {
            //Added By Dipali V On 9th May 2023 For Get week start Date & end Date
            const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            //debugger;
            const today = startOfWeek(new Date());
            today.setDate(today.getDate());
            const yyyy = today.getFullYear();
            let mm = month[today.getMonth()]; // Months start at 0!
            let dd = today.getDate();

            if (dd < 10) dd = '0' + dd;
            if (mm < 10) mm = '0' + mm;
            const Fromdate = dd + '-' + mm + '-' + yyyy;
 
            const Todate = startOfWeek(new Date());
            Todate.setDate(Todate.getDate() + 6);
            const To_yyyy = Todate.getFullYear();
            let To_mm = month[Todate.getMonth()]; // Months start at 0!
            let To_dd = Todate.getDate();

            if (To_dd < 10) To_dd = '0' + To_dd;
            if (To_mm < 10) To_mm = '0' + To_mm;
            const Todate_New = To_dd + '-' + To_mm + '-' + To_yyyy;

            $("#txtFromDate").val(Fromdate);
            $("#txtToDate").val(Todate_New);
               //End of Added By Dipali V On 9th May 2023 For Get week start Date & end Date
        }



        //Added By Rehan C for Disable Save Button Issue on 22nd Feb 2023
        function DisableEnableShowBtn() {

            if (EditAccess == "False") {
                $("#btnsave").hide();
                $("#btnsave").addClass("lblcrsr");
            }
            else {
                $("#btnsave").show();
             }
        }
        //End of Comment By Rehan C for Disable Save Button Issue on 22nd Feb 2023
        var m_strTaskType = '<%=TASK_TYPE_ASSIGNED%>'
        var m_CheckboxIDs = "";
        var m_intMSPIntegrationMethod = <%=m_intMSPIntegrationMethod%>;
        var taskStatusTotalRecordsFromApi = 0;
        var TaskStatusTable = null;
        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Global object to track checked task IDs across all pagination pages
        var globalCheckedTaskIds = {}; // Object to store checked state: { taskId: true/false }
        // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
        function LoadTaskList() {
            //debugger
            var result;
            var m_btRestrictDurationChange_M = '<%=m_btRestrictDurationChange_M%>'
            var taskInput = {
                m_intEmployeeID: $("#cboEmployee").val() == "" ? "0" : $("#cboEmployee").val(),
                m_intProjectID: $("#cboProject").val() == "" ? "NULL" : $("#cboProject").val(),
                m_dtFromDate: $("#txtFromDate").val(),
                m_dtToDate: $("#txtToDate").val(),
                m_intOperation: $("#cboOperation").val(),
                strTaskFilter: strTaskFilter,
                m_strTaskType: m_strTaskType
            }
            var param = JSON.stringify(taskInput);
            var strHTML = '';
            m_CheckboxIDs = "";
            taskStatusTotalRecordsFromApi = 0;
            $('#taskStatusPaginationControls #TotalRecords').text('0');
            // Added by Dipali V on 14th Nov 2025 for W26 Changes - Clear global checkbox tracker when table is reloaded
            globalCheckedTaskIds = {};
            // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
            AJAXCallWithResult(GetTaskListAPI, param, true, "POST", function (result) {
                console.log(result);
                var taskRows = [];
                if (Array.isArray(result)) {
                    taskRows = result;
                } else if (result && Array.isArray(result.data)) {
                    taskRows = result.data;
                }
                taskStatusTotalRecordsFromApi = taskRows.length;
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Updated table header: Task Name, Resource Name, Start Date, End Date, then Timeline
                strHTML += `<table id="TMtbl" class="table table-stripped table-bordered TMtbl table-hideable"><thead>
                        <tr>
                            <th rowspan="2">&nbsp;</th>
                            <th rowspan="2">Task Name</th>
                            <th rowspan="2">Resource Name</th>
                            <th rowspan="2">Start Date</th>
                            <th rowspan="2">End Date</th>
                            <th colspan="3" style="text-align: center;">Timeline</th>
                            <th rowspan="2">Work (hours)</th>
                            <th rowspan="2">Actual Work (hours)</th>
                            <th rowspan="2"><strong>% Completion</strong></th>
                            <th rowspan="2">Select</th>
                        </tr>
                        <tr>
                            <th>Plan</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                        </tr>
                    </thead>
                    <tbody>`;
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                var m_intCount = 0;
                var m_intOperation = $("#cboOperation").val();
                for (var i = 0; i < taskRows.length; i++) {
                    
                    var ParentTask_UID = taskRows[i].ParentTask_UID;
                    var TaskId = taskRows[i].TaskId;
                    var UniqueID = taskRows[i].UniqueID;
                    var DepartmentId = taskRows[i].DepartmentId;
                    var TaskName = taskRows[i].TaskName;
                    var EmployeeId = taskRows[i].EmployeeId;
                    var EmployeeName = taskRows[i].EmployeeName;
                    var SubTaskTypes = taskRows[i].SubTaskTypes;
                    var PlannedWork = taskRows[i].PlannedWork;
                    var ActualWork = taskRows[i].ActualWork;
                    var StartDate = taskRows[i].StartDate;
                    var EndDate = taskRows[i].EndDate;
                    var BaselineStart = taskRows[i].BaselineStart;
                    var BaselineEnd = taskRows[i].BaselineEnd;
                    var ActualStartDate = taskRows[i].ActualStartDate;
                    var ActualEndDate = taskRows[i].ActualEndDate;
                    var HasChildTasks = taskRows[i].HasChildTasks;
                    var CreatedDate = taskRows[i].CreatedDate;
                    var IsTaskComplete = taskRows[i].IsTaskComplete;
                    var ActualPercentComplete = taskRows[i].ActualPercentComplete;
                    var TaskStatus = taskRows[i].TaskStatus;
                    var Parenttaskwork = taskRows[i].Parenttaskwork;
                    var childworkhrs = taskRows[i].childworkhrs;
                    var strtotalworkhrs = taskRows[i].strtotalworkhrs;
                    var PStartDate = taskRows[i].PStartDate;
                    var PEndDate = taskRows[i].PEndDate;
                    var IsUserStoryTask = taskRows[i].IsUserStoryTask;
                    strHTML += `<tr>
                            <td>`

                    var strClass = ""
                    var strDisabled = "";
                    var strName = "";
                    var strTooltip = "";
                    if (m_strTaskType == "<%=TASK_TYPE_ASSIGNED%>") {
                        strClass = "assignTsk"
                        strTooltip = "Assigned Task"
                    }
                    else if (m_strTaskType == "<%=TASK_TYPE_MPP%>") {
                        strClass = "MPPTsk"
                        strTooltip = "MPP Task"
                    }
                    else if (m_strTaskType == "<%=TASK_TYPE_ISSUE%>") {
                        strClass = "issueTsk"
                        strTooltip = "Issue Task"
                    }
                    else if (m_strTaskType == "<%=TASK_TYPE_REVIEW%>") {
                        strClass = "reviewTsk"
                        strTooltip = "Review Task"
                    }
                    else if (m_strTaskType == "<%=TASK_TYPE_HELPDESK%>") {
                        strClass = "helpDeskTsk"
                        strTooltip = "Helpdesk Task"
                    }


                    strHTML += `<i class="fas fa-square IcnGridlegend ${strClass}" title=${strTooltip} data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="" data-original-title="Help-Desk Task"></i>`
                    var fromDateRequest = StartDate
                    var toDateRequest = EndDate
                    var BaselineStartRequest = BaselineStart
                    var BaselineEndRequest = BaselineEnd
                    var ActualStartDateRequest = ActualStartDate
                    var ActualEndDateRequest = ActualEndDate

                    // Added by Dipali V on 14th Nov 2025 for W26 Changes - Column order: Task Name, Resource Name, Start Date, End Date, then Timeline (Plan, Start Date, End Date), Work hours
                    strHTML += `</td>
                            <td>${($("#cboOperation").val() != 8 ? (ParentTask_UID != 0 ? "-->" + TaskName : (IsUserStoryTask ? "<IMG src='../../../Images/Scrum/UserStory.gif'>" + TaskName : TaskName)) : TaskName)}</td>
                            <td>${EmployeeName}</td>
                            <td class="">${fromDateRequest}</td>
                            <td class="">${toDateRequest}</td>
                            <td class="timeline-plan-col">
                                <div class="timeline-plan-label baseline">Baseline</div>
                                <div class="timeline-plan-label actual">Actual</div>
                            </td>
                            <td class="timeline-start-col">
                                <div>${BaselineStartRequest}</div>
                                <div>`
                    // Handle Actual Start Date with input field for MPP tasks
                    if (m_intMSPIntegrationMethod = 2 && m_strTaskType == "<%=TASK_TYPE_MPP%>") {
                        var strActStartDate = "ActStartDate_" + TaskId;
                        strHTML += `<input type='hidden' id='ActStartDate_${TaskId}' name='ActStartDate_${TaskId}' class='form-control input-sm datetimepicker' > ${ActualStartDateRequest}`
                        if (m_btRestrictDurationChange_M == 'True') {
                            strHTML += `<input type='hidden' id='txtTaskStartDate_${TaskId}' name='txtTaskStartDate_${TaskId}' value='${fromDateRequest}'>`
                        }
                    }
                    else {
                        strHTML += ActualStartDateRequest
                    }
                    strHTML += `</div>
                            </td>
                            <td class="timeline-end-col">
                                <div>${BaselineEndRequest}</div>
                                <div>`
                    // Handle Actual End Date with input field for MPP tasks
                    if (m_intOperation == 8) {
                        strHTML += ``
                    }
                    else {
                        if (m_intMSPIntegrationMethod = 2 && m_strTaskType == "<%=TASK_TYPE_MPP%>") {
                            var strActEndDate = "ActEndDate_" + TaskId;
                            strHTML += `<input type='textbox' id='ActEndDate_${TaskId}' name='ActEndDate_${TaskId}' class='form-control input-sm datetimepicker' > ${ActualEndDateRequest}`
                            if (m_btRestrictDurationChange_M == 'True') {
                                strHTML += `<input type='hidden' id='txtTaskEndDate_${TaskId}' name='txtTaskEndDate_${TaskId}' value='${toDateRequest}'>`
                            }
                        }
                        else {
                            strHTML += ActualEndDateRequest
                        }
                    }
                    strHTML += `</div>
                            </td>
                            <td class="">${PlannedWork}</td>
                            <td class="">${ActualWork}</td>
                            <td class="">`
                    // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                    if (m_intOperation == 1 || m_intOperation == 2 || m_intOperation == 3 || m_intOperation == 4 || m_intOperation == 5 || m_intOperation == 6 || m_intOperation == 7 || m_intOperation == 9 || m_intOperation == 10 || m_intOperation == 11 || m_intOperation == 12) {
                        strHTML += ActualPercentComplete
                    }
                    else if (m_intOperation == 13) {
                        if ($("#cboOperation").val() == '<%=OPERATION_SAVE_PERCENTCOMPLETE%>' && ActualPercentComplete == 100) {
                            strDisabled = " disabled";
                        }
                        strTxtActualPercent = "txtActPer_" + TaskId;
                        if (ParentTask_UID != 0) {
                            strHTML += `<input type='Textbox' id='${strTxtActualPercent}' name='${strTxtActualPercent}' value='${ActualPercentComplete}' ${strDisabled} class='clsTextBox' style='width:40px  ; text-align:right' onblur='ActualPercentChange(${TaskId}")'>`
                        } else {//ADDED BY DIPALI V ON 10TH MAY
                            strHTML += ActualPercentComplete

                        }
                    }
                    strHTML += `</td>
                            <td class="">
                            <input type='hidden' id='hid_txttotalworkhrs _${TaskId}' value='${Parenttaskwork}'/>
                            <input type='hidden' id='hid_txtchildworkhrs _${TaskId}' value='${childworkhrs}'/>
                            <input type='hidden' id='hid_txtchildwork _${TaskId}' value='${strtotalworkhrs}'/>
                            <input type='hidden' id='hid_txtTaskStartDate_${TaskId}' value='${fromDateRequest}'/>
                            <input type='hidden' id='hid_txtTaskEndDate_${TaskId}' value='${toDateRequest}'/>
                            <input type='hidden' id='hid_txtPTaskStartDate_${TaskId}' value='${PStartDate}'/>
                            <input type='hidden' id='hid_txtPTaskEndDate_${TaskId}' value='${PEndDate}'/>
                            <input type='hidden' id='hid_txtParenttaskID_${TaskId}' value='${ParentTask_UID}'/>`
                    if (m_strTaskType == "<%=TASK_TYPE_ASSIGNED%>" || m_strTaskType == "<%=TASK_TYPE_REVIEW%>") {
                        if (TaskStatus)
                            strDisabled = " disabled";
                        if ($("#cboOperation").val() == '<%=OPERATION_VOID_TASKS%>' && ParentTask_UID == 0 && EmployeeId != 0) {
                            strDisabled = " disabled";
                        }
                        if ($("#cboOperation").val() == '<%=OPERATION_SAVE_PERCENTCOMPLETE%>' && ActualPercentComplete == 100) {
                            strDisabled = " disabled";
                        }

                        if (ParentTask_UID == 0) {
                            m_intCount = 0
                            strName = "chk" + TaskId + "_" + m_intCount;
                            var strTxtName = "txt" + TaskId + "_" + m_intCount;
                            if (m_intOperation == '<%=OPERATION_VOID_TASKS%>' || m_intOperation == '<%=OPERATION_VALID_TASKS%>'
                                || m_intOperation == '<%=OPERATION_REOPEN_TASKS%>' || m_intOperation == '<%=OPERATION_ACCRUAL_PRORATA%>'
                                || m_intOperation == '<%=OPERATION_ACCRUAL_ONCOMPLETION%>' || m_intOperation == '<%=OPERATION_SET_BASELINE%>'
                                || m_intOperation == '<%=OPERATION_CLEAR_BASELINE%>' || m_intOperation == '<%=OPERATION_SAVE_PERCENTCOMPLETE%>' || m_intOperation == 8) {
                                strHTML += `<div class="">
                                            <input type='checkbox' id='${strName}' name='${strName}' class='taskBillableChecks' value='${TaskId}' ${strDisabled} onclick='javascript:CheckChildTasks(${TaskId},${HasChildTasks})'><input type=hidden name='${strTxtName}' value='${TaskStatus}'>
                                            <label name="${strName}" for="${strName}"></label>
                                        </div>`
                            }
                            else {
                                strHTML += `<div class="">
                                            <input type='checkbox' id='${strName}' name='${strName}' class='taskBillableChecks' value='${TaskId}' onclick='javascript:CheckTask(${ParentTask_UID},${m_intCount})'><input type=hidden name='${strTxtName}' value='${TaskStatus}'>
                                            <label name="${strName}" for="${strName}"></label>
                                        </div>`
                            }
                        }
                        else {
                            if (m_intOperation == '<%=OPERATION_VOID_TASKS%>' || m_intOperation == '<%=OPERATION_VALID_TASKS%>'
                                || m_intOperation == '<%=OPERATION_REOPEN_TASKS%>' || m_intOperation == '<%=OPERATION_ACCRUAL_PRORATA%>'
                                || m_intOperation == '<%=OPERATION_ACCRUAL_ONCOMPLETION%>' || m_intOperation == '<%=OPERATION_SET_BASELINE%>'
                                || m_intOperation == '<%=OPERATION_CLEAR_BASELINE%>' || m_intOperation == '<%=OPERATION_SAVE_PERCENTCOMPLETE%>' || m_intOperation == 8) {
                                m_intCount = m_intCount + 1
                                strName = "chk" + ParentTask_UID + "_" + m_intCount;
                                var strTxtName = "txt" + ParentTask_UID + "_" + m_intCount;
                                if (m_intOperation == '<%=OPERATION_SET_BASELINE%>' || m_intOperation == '<%=OPERATION_CLEAR_BASELINE%>') {
                                    strHTML += `<div class="">
                                            <input type='checkbox' id='${strName}' name='${strName}' class='taskBillableChecks' value='${TaskId}' disabled ${strDisabled} onclick='javascript:CheckTask(${ParentTask_UID},${m_intCount})'><input type=hidden name='${strTxtName}' value='${TaskStatus}'>
                                            <label name="${strName}" for="${strName}"></label>
                                        </div>`
                                }
                                else {//Added by Dipali V on 10th May 1544
                                    //strName = "chk" + TaskId + "_" + m_intCount;
                                    strHTML += `<div class="">
                                            
                                            <input type='checkbox' id='${strName}' name='${strName}' class='taskBillableChecks' value='${TaskId}' ${strDisabled} onclick='javascript:CheckTask(${ParentTask_UID},${m_intCount})'><input type=hidden name='${strTxtName}' value='${TaskStatus}'>
                                            <label name="${strName}" for="${strName}"></label>
                                        </div>`
                                }
                            }
                        }
                    }
                    else {
                        if ($("#cboOperation").val() == '<%=OPERATION_SAVE_PERCENTCOMPLETE%>' && ActualPercentComplete == 100) {
                            strDisabled = " disabled";
                        }
                        m_intCount = m_intCount + 1
                        strName = "chk0_" + m_intCount;
                        
                        strHTML += `<div class="">
                                            <input type='checkbox' id='${strName}' class='taskBillableChecks' name='${strName}' value='${TaskId}' ${strDisabled} onclick='javascript:CheckTask(${ParentTask_UID},${m_intCount})'><input type=hidden name='${strTxtName}' value='${TaskStatus}'>
                                            <label name="${strName}" for="${strName}"></label>
                                        </div>`
                    }
                    if (m_CheckboxIDs == "") {
                        m_CheckboxIDs = strName;
                    }
                    else {
                        m_CheckboxIDs += "," + strName;
                    }
                    strHTML += `</td></tr>`
                }
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Updated colspan for new table structure (12 columns: Icon, Task Name, Resource Name, Start Date, End Date, Timeline(3), Work, Actual Work, % Completion, Select)
                if (taskRows.length == 0) {
                    strHTML += `
                            <tr>
                                <td colspan=12 style='text-align:center'>There is no items to show in view.</td>
                            </tr>
                       `
                }
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                
                strHTML += `</tbody></table>`

                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Removed hide/show button logic as all Timeline values are always visible
                $('#divMain').html(strHTML);
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Show table after data loads
                $('#TMtbl').css('display', '');
                // Added by Vyankat B. on 23-Mar-2026 - bind total record count directly from API result
                $('#taskStatusPaginationControls #TotalRecords').text(taskStatusTotalRecordsFromApi);
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
                $(".datetimepicker").datepicker({
                    autoclose: true,
                    changeMonth: true,
                    changeYear: true,
                    yearRange: 'c-100:c+100',
                    dateFormat: 'd-M-y',
                    beforeShow: function(input, inst) {
                        // Ensure datepicker appears above frozen headers
                        setTimeout(function() {
                            $('.ui-datepicker').css('z-index', '10001');
                        }, 1);
                    }
                });
                // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
                var tblheight = $(window).height();
                // Calculate scroll height accounting for headers and other elements
                var headerHeight = $('.statckmainheader').outerHeight() || 50;
                var filterPanelHeight = $('#filterpanel').hasClass('collapse') ? 0 : $('.filterpanelheader').outerHeight() || 0;
                var actionPanelHeight = $('#TMinfoCollapseOne').hasClass('show') ? $('#TMinfoCollapseOne').outerHeight() || 0 : 0;
                var buttonBarHeight = $('.pt-1.text-end.col-sm-12').outerHeight() || 40;
                var scrollHeight = tblheight - headerHeight - filterPanelHeight - actionPanelHeight - buttonBarHeight - 100;
                if (scrollHeight < 200) scrollHeight = 200; // Minimum height
                // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
                
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Destroy existing DataTable instance to prevent column count mismatch error
                if ($.fn.DataTable.isDataTable('#TMtbl')) {
                    $('#TMtbl').DataTable().destroy();
                }
                TaskStatusTable = null;
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                
                TaskStatusTable = $('#TMtbl').DataTable({
                    //"ajax": '/api/data',
                    // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze

                    // Commented by Vyankat B. on 23-Mar-2026 to remove body scroller
                    //"scrollY": scrollHeight + "px",
                    "scrollY": "",
                    // End of Commented by Vyankat B. on 23-Mar-2026 to remove body scroller

                    "scrollCollapse": false,
                    "scrollX": false,
                    "autoWidth": false,
                    // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
                    //"scroller": true,
                    "pageLength": 5,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    // Commented by Vyankat B. on 23-Mar-2026 for Task Status table alignment issue
                    "responsive": false,
                    // End of Commented by Vyankat B. on 23-Mar-2026 for Task Status table alignment issue
                    "paging": true,
                    "dom": 't',
                    "destroy": true,
                    "retrieve": false,
                    // Added by Dipali V on 14th Nov 2025 for W26 Changes - Restore checkbox states after pagination
                    "drawCallback": function(settings) {
                        // Restore checkbox states from global tracker after table is redrawn
                        $('input.taskBillableChecks').each(function() {
                            var taskId = $(this).val();
                            if (taskId && globalCheckedTaskIds.hasOwnProperty(taskId) && globalCheckedTaskIds[taskId] === true) {
                                $(this).prop('checked', true);
                            } else if (taskId && globalCheckedTaskIds.hasOwnProperty(taskId) && globalCheckedTaskIds[taskId] === false) {
                                $(this).prop('checked', false);
                            }
                        });
                        updateTaskStatusPaginationControls();
                    }
                    // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                });
                updateTaskStatusPaginationControls();
                
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Track checkbox changes directly (delegated event for pagination support)
                $(document).on('change', 'input.taskBillableChecks', function() {
                    var taskId = $(this).val();
                    if (taskId) {
                        globalCheckedTaskIds[taskId] = $(this).is(':checked');
                    }
                });
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                
                // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
                // Ensure DataTable header stays sticky and columns are aligned after initialization
                setTimeout(function() {
                    var table = $('.TMtbl').DataTable();
                    // Force column width synchronization - comprehensive approach
                    function syncColumnWidths() {
                        var headerTable = $('.dataTables_scrollHeadInner table');
                        var bodyTable = $('.dataTables_scrollBody table');
                        
                        if (headerTable.length && bodyTable.length) {
                            // First, adjust columns using DataTables API
                            table.columns.adjust();
                            
                            // Then manually sync each column width
                            var leafHeaderCells = headerTable.find('thead tr:last th');
                            var firstBodyRow = bodyTable.find('tbody tr:first');

                            if (firstBodyRow.length) {
                                firstBodyRow.find('td').each(function(colIndex) {
                                    var bodyWidth = $(this).outerWidth();

                                    var headerCell = leafHeaderCells.eq(colIndex);
                                    if (headerCell.length) {
                                        headerCell.css({
                                            'width': bodyWidth + 'px',
                                            'min-width': bodyWidth + 'px',
                                            'max-width': bodyWidth + 'px'
                                        });
                                    }

                                    bodyTable.find('tbody tr').each(function() {
                                        var bodyColCell = $(this).find('td').eq(colIndex);
                                        if (bodyColCell.length) {
                                            bodyColCell.css({
                                                'width': bodyWidth + 'px',
                                                'min-width': bodyWidth + 'px',
                                                'max-width': bodyWidth + 'px'
                                            });
                                        }
                                    });
                                });
                            }
                            
                            // Final adjustment
                            table.columns.adjust();
                        }
                    }
                    
                    // Force column width synchronization
                    $('.dataTables_scrollHead').css({
                        'position': 'sticky',
                        'top': '0',
                        'z-index': '998'
                    });
                    
                    // Sync widths multiple times to ensure alignment
                    syncColumnWidths();
                    setTimeout(syncColumnWidths, 100);
                    setTimeout(syncColumnWidths, 300);
                }, 200);
                // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
            });
            //Added By Dipali V On 15th May 2023 for Loader Missing
            setTimeout(function () {
                StopAjaxLoader("#tbody1");
            }, 1000);
            //End of Added By Dipali V On 15th May 2023 for Loader Missing
           
        }

        // Added by Vyankat B. on 23-Mar-2026 for PM_AssignedTasks-like custom pagination
        function setTaskStatusPagerState(prevDisabled, nextDisabled) {
            if (prevDisabled) {
                $('#btnprevious').addClass('disabled');
                $('#LinkPrevious').addClass('disabled').attr('aria-disabled', 'true').attr('tabindex', '-1');
            } else {
                $('#btnprevious').removeClass('disabled');
                $('#LinkPrevious').removeClass('disabled').removeAttr('aria-disabled').removeAttr('tabindex');
            }

            if (nextDisabled) {
                $('#btnnext').addClass('disabled');
                $('#LinkNext').addClass('disabled').attr('aria-disabled', 'true').attr('tabindex', '-1');
            } else {
                $('#btnnext').removeClass('disabled');
                $('#LinkNext').removeClass('disabled').removeAttr('aria-disabled').removeAttr('tabindex');
            }
        }

        function getTaskStatusTableInstance() {
            if (TaskStatusTable) return TaskStatusTable;
            if ($.fn.DataTable.isDataTable('#TMtbl')) {
                TaskStatusTable = $('#TMtbl').DataTable();
                return TaskStatusTable;
            }
            return null;
        }

        function updateTaskStatusPaginationControls() {
            var dt = getTaskStatusTableInstance();
            if (!dt) return;

            var pageInfo = dt.page.info();
            if (!pageInfo) return;

            $('#taskStatusPaginationControls').show();

            // Prefer API count, fallback to rendered row count when API value is stale/zero
            var domRowCount = $('#TMtbl tbody tr').filter(function() {
                var rowText = ($(this).text() || '').trim();
                return rowText !== '' && rowText.indexOf('There is no items to show in view.') === -1;
            }).length;

            var total = parseInt(taskStatusTotalRecordsFromApi, 10) || 0;
            if (total === 0 && domRowCount > 0) {
                total = domRowCount;
                taskStatusTotalRecordsFromApi = total;
            }

            $('#taskStatusPaginationControls #TotalRecords').text(total);

            var pageSize = dt.page.len() || 10;
            var expectedPages = Math.max(1, Math.ceil(total / pageSize));
            var currentPage = (typeof pageInfo.page !== 'undefined' && pageInfo.page !== null) ? pageInfo.page : 0;

            if (total <= pageSize) {
                setTaskStatusPagerState(true, true);
                return;
            }

            setTaskStatusPagerState(currentPage <= 0, currentPage >= expectedPages - 1);
        }

        function PrevList() {
            var dt = getTaskStatusTableInstance();
            if (!dt) return;
            if ($('#LinkPrevious').hasClass('disabled')) return;
            dt.page('previous').draw('page');
        }

        function NextList() {
            var dt = getTaskStatusTableInstance();
            if (!dt) return;
            if ($('#LinkNext').hasClass('disabled')) return;
            dt.page('next').draw('page');
        }
        // End of Added by Vyankat B. on 23-Mar-2026 for PM_AssignedTasks-like custom pagination

        //datatable


        $('#TMOthertaskmodal').on('shown.bs.modal', function () {

        });

        function showcountfltr() {
            $(".showallTsk .statustextno").css('display', 'inline-block');
        }

        //function resizeSection() {
        //    var tblheight = $(window).height();
        //    $('.dataTables_scrollBody').css({ 'height': tblheight - 480, "overflow-y": "auto" });
        //}

        $(window).on("load resize scroll", function (e) {
            $('table').resize();
            
            // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
            // Recalculate scroll height on window resize and maintain column alignment
            if ($('.TMtbl').length && $.fn.DataTable.isDataTable('.TMtbl')) {
                var tblheight = $(window).height();
                var headerHeight = $('.statckmainheader').outerHeight() || 50;
                var filterPanelHeight = $('#filterpanel').hasClass('collapse') ? 0 : $('.filterpanelheader').outerHeight() || 0;
                var actionPanelHeight = $('#TMinfoCollapseOne').hasClass('show') ? $('#TMinfoCollapseOne').outerHeight() || 0 : 0;
                var buttonBarHeight = $('.pt-1.text-end.col-sm-12').outerHeight() || 40;
                var scrollHeight = tblheight - headerHeight - filterPanelHeight - actionPanelHeight - buttonBarHeight - 100;
                if (scrollHeight < 200) scrollHeight = 200;
                
                var table = $('.TMtbl').DataTable();
                if (table.settings()[0].oScroll) {
                    table.settings()[0].oScroll.sY = scrollHeight + "px";
                    table.columns.adjust();
                }
                // Ensure sticky positioning is maintained
                $('.dataTables_scrollHead').css({
                    'position': 'sticky',
                    'top': '0',
                    'z-index': '998'
                });
                // Sync column widths after resize - comprehensive approach
                setTimeout(function() {
                    function syncColumnWidths() {
                        var headerTable = $('.dataTables_scrollHeadInner table');
                        var bodyTable = $('.dataTables_scrollBody table');
                        
                        if (headerTable.length && bodyTable.length) {
                            table.columns.adjust();
                            
                            var leafHeaderCells = headerTable.find('thead tr:last th');
                            var firstBodyRow = bodyTable.find('tbody tr:first');

                            if (firstBodyRow.length) {
                                firstBodyRow.find('td').each(function(colIndex) {
                                    var bodyWidth = $(this).outerWidth();

                                    var headerCell = leafHeaderCells.eq(colIndex);
                                    if (headerCell.length) {
                                        headerCell.css({
                                            'width': bodyWidth + 'px',
                                            'min-width': bodyWidth + 'px',
                                            'max-width': bodyWidth + 'px'
                                        });
                                    }

                                    bodyTable.find('tbody tr').each(function() {
                                        var bodyColCell = $(this).find('td').eq(colIndex);
                                        if (bodyColCell.length) {
                                            bodyColCell.css({
                                                'width': bodyWidth + 'px',
                                                'min-width': bodyWidth + 'px',
                                                'max-width': bodyWidth + 'px'
                                            });
                                        }
                                    });
                                });
                            }
                            
                            table.columns.adjust();
                        }
                    }
                    syncColumnWidths();
                    setTimeout(syncColumnWidths, 50);
                }, 100);
            }
            // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze

        });
        $(document).on('show.bs.collapse', function (e) {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 500, "overflow-y": "auto" });
            // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
            // Update DataTable scroll height when filter panel is shown and maintain column alignment
            if ($('.TMtbl').length && $.fn.DataTable.isDataTable('.TMtbl')) {
                var headerHeight = $('.statckmainheader').outerHeight() || 50;
                var filterPanelHeight = $('.filterpanelheader').outerHeight() || 0;
                var actionPanelHeight = $('#TMinfoCollapseOne').hasClass('show') ? $('#TMinfoCollapseOne').outerHeight() || 0 : 0;
                var buttonBarHeight = $('.pt-1.text-end.col-sm-12').outerHeight() || 40;
                var scrollHeight = tblheight - headerHeight - filterPanelHeight - actionPanelHeight - buttonBarHeight - 100;
                if (scrollHeight < 200) scrollHeight = 200;
                
                var table = $('.TMtbl').DataTable();
                if (table.settings()[0].oScroll) {
                    table.settings()[0].oScroll.sY = scrollHeight + "px";
                    table.columns.adjust();
                }
                // Ensure sticky positioning is maintained
                $('.dataTables_scrollHead').css({
                    'position': 'sticky',
                    'top': '0',
                    'z-index': '998'
                });
                // Sync column widths after panel show - comprehensive approach
                setTimeout(function() {
                    function syncColumnWidths() {
                        var headerTable = $('.dataTables_scrollHeadInner table');
                        var bodyTable = $('.dataTables_scrollBody table');
                        
                        if (headerTable.length && bodyTable.length) {
                            table.columns.adjust();
                            
                            var leafHeaderCells = headerTable.find('thead tr:last th');
                            var firstBodyRow = bodyTable.find('tbody tr:first');

                            if (firstBodyRow.length) {
                                firstBodyRow.find('td').each(function(colIndex) {
                                    var bodyWidth = $(this).outerWidth();

                                    var headerCell = leafHeaderCells.eq(colIndex);
                                    if (headerCell.length) {
                                        headerCell.css({
                                            'width': bodyWidth + 'px',
                                            'min-width': bodyWidth + 'px',
                                            'max-width': bodyWidth + 'px'
                                        });
                                    }

                                    bodyTable.find('tbody tr').each(function() {
                                        var bodyColCell = $(this).find('td').eq(colIndex);
                                        if (bodyColCell.length) {
                                            bodyColCell.css({
                                                'width': bodyWidth + 'px',
                                                'min-width': bodyWidth + 'px',
                                                'max-width': bodyWidth + 'px'
                                            });
                                        }
                                    });
                                });
                            }
                            
                            table.columns.adjust();
                        }
                    }
                    syncColumnWidths();
                    setTimeout(syncColumnWidths, 50);
                }, 100);
            }
            // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
        })
        $(document).on('hide.bs.collapse', function (e) {

            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 300, "overflow-y": "auto" });
            // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
            // Update DataTable scroll height when filter panel is hidden and maintain column alignment
            if ($('.TMtbl').length && $.fn.DataTable.isDataTable('.TMtbl')) {
                var headerHeight = $('.statckmainheader').outerHeight() || 50;
                var filterPanelHeight = 0; // Panel is hidden
                var actionPanelHeight = $('#TMinfoCollapseOne').hasClass('show') ? $('#TMinfoCollapseOne').outerHeight() || 0 : 0;
                var buttonBarHeight = $('.pt-1.text-end.col-sm-12').outerHeight() || 40;
                var scrollHeight = tblheight - headerHeight - filterPanelHeight - actionPanelHeight - buttonBarHeight - 100;
                if (scrollHeight < 200) scrollHeight = 200;
                
                var table = $('.TMtbl').DataTable();
                if (table.settings()[0].oScroll) {
                    table.settings()[0].oScroll.sY = scrollHeight + "px";
                    table.columns.adjust();
                }
                // Ensure sticky positioning is maintained
                $('.dataTables_scrollHead').css({
                    'position': 'sticky',
                    'top': '0',
                    'z-index': '998'
                });
                // Sync column widths after panel hide - comprehensive approach
                setTimeout(function() {
                    function syncColumnWidths() {
                        var headerTable = $('.dataTables_scrollHeadInner table');
                        var bodyTable = $('.dataTables_scrollBody table');
                        
                        if (headerTable.length && bodyTable.length) {
                            table.columns.adjust();
                            
                            var leafHeaderCells = headerTable.find('thead tr:last th');
                            var firstBodyRow = bodyTable.find('tbody tr:first');

                            if (firstBodyRow.length) {
                                firstBodyRow.find('td').each(function(colIndex) {
                                    var bodyWidth = $(this).outerWidth();

                                    var headerCell = leafHeaderCells.eq(colIndex);
                                    if (headerCell.length) {
                                        headerCell.css({
                                            'width': bodyWidth + 'px',
                                            'min-width': bodyWidth + 'px',
                                            'max-width': bodyWidth + 'px'
                                        });
                                    }

                                    bodyTable.find('tbody tr').each(function() {
                                        var bodyColCell = $(this).find('td').eq(colIndex);
                                        if (bodyColCell.length) {
                                            bodyColCell.css({
                                                'width': bodyWidth + 'px',
                                                'min-width': bodyWidth + 'px',
                                                'max-width': bodyWidth + 'px'
                                            });
                                        }
                                    });
                                });
                            }
                            
                            table.columns.adjust();
                        }
                    }
                    syncColumnWidths();
                    setTimeout(syncColumnWidths, 50);
                }, 100);
            }
            // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze

        });
        $(document).on('draw.dt', function () {
            $('table').resize();
            // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
            // Maintain column alignment after table redraw - comprehensive approach
            if ($('.TMtbl').length && $.fn.DataTable.isDataTable('.TMtbl')) {
                var table = $('.TMtbl').DataTable();
                setTimeout(function() {
                    function syncColumnWidths() {
                        var headerTable = $('.dataTables_scrollHeadInner table');
                        var bodyTable = $('.dataTables_scrollBody table');
                        
                        if (headerTable.length && bodyTable.length) {
                            table.columns.adjust();
                            
                            var leafHeaderCells = headerTable.find('thead tr:last th');
                            var firstBodyRow = bodyTable.find('tbody tr:first');

                            if (firstBodyRow.length) {
                                firstBodyRow.find('td').each(function(colIndex) {
                                    var bodyWidth = $(this).outerWidth();

                                    var headerCell = leafHeaderCells.eq(colIndex);
                                    if (headerCell.length) {
                                        headerCell.css({
                                            'width': bodyWidth + 'px',
                                            'min-width': bodyWidth + 'px',
                                            'max-width': bodyWidth + 'px'
                                        });
                                    }

                                    bodyTable.find('tbody tr').each(function() {
                                        var bodyColCell = $(this).find('td').eq(colIndex);
                                        if (bodyColCell.length) {
                                            bodyColCell.css({
                                                'width': bodyWidth + 'px',
                                                'min-width': bodyWidth + 'px',
                                                'max-width': bodyWidth + 'px'
                                            });
                                        }
                                    });
                                });
                            }
                            
                            table.columns.adjust();
                        }
                    }
                    syncColumnWidths();
                    setTimeout(syncColumnWidths, 50);
                }, 50);
            }
            // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze
        });

        function toggleIcon(e) {
            $(e.target)
                .prev('.panel-heading')
                .find(".infoToggler")
                .toggleClass('togglerdown togglerup');
        }
        $('.panel-group').on('hidden.bs.collapse', toggleIcon);
        $('.panel-group').on('shown.bs.collapse', toggleIcon);


        $('.statustext li a').click(function () {
            //$("#TMinfoCollapseOne").collapse('hide');

            $('html, body').animate({
                scrollTop: $(".TMtbl").offset().top -= 200
            }, 500);
        });

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
            // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
            // Ensure datepicker appears above frozen headers
            setTimeout(function() {
                $('.ui-datepicker').css('z-index', '10001');
            }, 1);
            // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
            return ret;
        };
        
        // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
        // Global handler to ensure all datepickers have correct z-index
        $(document).on('focus', 'input[type="text"].datepicker, input.datefielddiv input, .datetimepicker', function() {
            setTimeout(function() {
                $('.ui-datepicker').css('z-index', '10001');
            }, 10);
        });
        // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix


        //datepicker
        // Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix
        $('#TskinfoModalSD, #TskinfoModalSD, #TskSMfromdate, #TskSMenddate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'd-M-y',
            beforeShow: function(input, inst) {
                // Ensure datepicker appears above frozen headers
                setTimeout(function() {
                    $('.ui-datepicker').css('z-index', '10001');
                }, 1);
            }
        });
        // End of Added By Dipali V On 13rd Nov 2025 For W26 Changes Header should Freeze - Datepicker z-index fix




        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Removed hidecol toggle as all Timeline values are always visible

        $('body').tooltip({
            selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
        });

        //Start script for Task Management table
        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Removed hide/show button handlers as all Timeline values are always visible

        //End script for Task Management table

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



        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();

        });


        $(".collapse").on('hide.bs.collapse', function (e) {

        })

        var strTaskFilter = "2";
        function optTasks_OnClick(Show) {
            var txtToDate = document.getElementById('txtToDate');
            var txtFromDate = document.getElementById('txtFromDate');
            if (Show == "ShowALL") {
                txtToDate.disabled = true;
                txtFromDate.disabled = true;
                strTaskFilter = "1"
            }
            if (Show == "ShowWeekly") {
                txtToDate.disabled = false;
                txtFromDate.disabled = false;
                strTaskFilter = "2"
            }
        }
        $(document).click(function () {
            $(".tooltip").removeClass("show");
        })

        function CheckChildTasks(intTaskID, intChildCount) {
            var strCheckBox, objCheckbox, intIndex, blnChecked, objTaskType, strTaskType, i;
            var strTextBox, objTextBox;
            var objOperation;
            objOperation = document.getElementById('cboOperation');

            objTaskType = document.getElementsByName('optTaskType',);
            for (intCnt = 0; intCnt < objTaskType.length; intCnt++) {
                if (objTaskType[intCnt].checked)
                    strTaskType = objTaskType[intCnt].value;
            }

            strCheckBox = 'chk' + intTaskID + '_0';
            objCheckbox = document.getElementById(strCheckBox);
                    if (objCheckbox != null) {
                        if (strTaskType == 'O' || strTaskType == 'R') {
                            if (objCheckbox.checked == true) {
                                blnChecked = true;
                                if (strTaskIDs.indexOf(',' + intTaskID + ',') == -1) {
                                    strTaskIDs = strTaskIDs + intTaskID + ',';
                                }
                                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                                globalCheckedTaskIds[intTaskID] = true;
                                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                            }
                            else {
                                blnChecked = false;
                                if (strTaskIDs.indexOf(',' + intTaskID + ',') != -1) {
                                    strTaskIDs = strTaskIDs.replace(intTaskID + ',', '');
                                }
                                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                                globalCheckedTaskIds[intTaskID] = false;
                                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                            }

                            for (i = 1; i <= intChildCount; i++) {

                                strCheckBox = 'chk' + intTaskID + '_' + i;
                                objCheckbox = document.getElementById(strCheckBox);

                                strTextBox = 'txt' + intTaskID + '_' + i;
                                objTextbox = document.getElementById(strTextBox);

                                if (objCheckbox != null) {
                                    if (blnChecked == true) {
                                        if (objOperation.value == 2) {
                                            if (objCheckbox.disabled == false)
                                                objCheckbox.checked = true;
                                        }
                                        else {
                                            objCheckbox.checked = true;
                                            objCheckbox.disabled = true;
                                        }

                                        if (strTaskIDs.indexOf(',' + objCheckbox.value + ',') == -1) {
                                            if (objOperation.value == 2) {
                                                if (objCheckbox.disabled == false)
                                                    strTaskIDs = strTaskIDs + objCheckbox.value + ',';
                                            }
                                            else {
                                                strTaskIDs = strTaskIDs + objCheckbox.value + ',';
                                            }
                                        }
                                        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                                        if (objOperation.value == 2) {
                                            if (objCheckbox.disabled == false)
                                                globalCheckedTaskIds[objCheckbox.value] = true;
                                        }
                                        else {
                                            globalCheckedTaskIds[objCheckbox.value] = true;
                                        }
                                        // End of Added by Dipali V on 14th Nov 2025 for W26 Changes

                                    }
                                    else {

                                        if (strTaskIDs.indexOf(',' + objCheckbox.value + ',') != -1) {
                                            strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',', '');
                                        }
                                        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                                        globalCheckedTaskIds[objCheckbox.value] = false;
                                        // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                                        if (objTextbox != null) {
                                            if (objTextbox.value == 'False') {
                                                objCheckbox.checked = false;
                                               if (objOperation.value == 11 || objOperation.value == 12)
                                                    objCheckbox.disabled = true;
                                                else
                                                    objCheckbox.disabled = false;
                                            }
                                        }
                                    }
                                }				
                    }
                }

                if (strTaskType == 'M' || strTaskType == 'B') {
                    if (objCheckbox.checked == true) {
                        blnChecked = true;
                        if (strTaskIDs.indexOf(',' + intTaskID + ',') == -1) {
                            strTaskIDs = strTaskIDs + intTaskID + ',';
                        }
                        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                        globalCheckedTaskIds[intTaskID] = true;
                        // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                    }
                    else {
                        blnChecked = true;
                        if (strTaskIDs.indexOf(',' + intTaskID + ',') > -1) {
                            strTaskIDs = strTaskIDs.replace(intTaskID + ',', '');
                        }
                        // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                        globalCheckedTaskIds[intTaskID] = false;
                        // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                    }
                }
            }
        }

        function CheckTask(intTaskID, intCount) {
            var strCheckBox, objCheckbox, intIndex, blnChecked;
            strCheckBox = "chk" + intTaskID + "_" + intCount;
            objCheckbox = document.getElementById(strCheckBox);
            if (objCheckbox.checked == true) {
                blnChecked = true;			
                if (strTaskIDs.indexOf(',' + objCheckbox.value + ',') == -1) {
                    strTaskIDs = strTaskIDs + objCheckbox.value + ',';
                }
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                globalCheckedTaskIds[objCheckbox.value] = true;
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
            }
            else {
                blnChecked = false;
                if (strTaskIDs.indexOf(',' + objCheckbox.value + ',') > -1) {
                    strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',', '');
                }
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Update global checkbox tracker for pagination support
                globalCheckedTaskIds[objCheckbox.value] = false;
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
            }


        }
        var strTaskIDs = ',';
        function SelectAll_OnClick() {

            var strCheckboxIDs, objCheckbox, intItems, intCtr = 0;

            if (m_CheckboxIDs != "") {
                strCheckboxIDs = m_CheckboxIDs.split(",");
			 intItems = strCheckboxIDs.length;
		    		if(intItems > 1) 
					{
						
						for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
						{		       
                            objCheckbox = document.getElementById(strCheckboxIDs[intCtr]);
							if (objCheckbox!=null)
							{
								objCheckbox.checked = true;	
								if ( strTaskIDs.indexOf( ',' + objCheckbox.value + ',') == -1) 
								{
									strTaskIDs = strTaskIDs + objCheckbox.value + ',';
								}
							}	
						}
					}
					else if(intItems == 1)
							{
                        objCheckbox = document.getElementById(strCheckboxIDs[0]);
								if (objCheckbox.disabled == false)
							    {
									objCheckbox.checked = true;		        		
									if (strTaskIDs.indexOf(objCheckbox.value + ',') == -1)
									{
										strTaskIDs = strTaskIDs + objCheckbox.value + ',';
									}	
								}	
							}					
			}
	     } 
		function ClearAll_OnClick()
		{		  	  	
   		  var strCheckboxIDs,objCheckbox,intItems,intCtr; 
		 		  
            if (m_CheckboxIDs != "")
			{		  
                strCheckboxIDs = m_CheckboxIDs.split(",");
                intItems = strCheckboxIDs.length;

                if (intItems > 1) {
                    for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                        objCheckbox = document.getElementById(strCheckboxIDs[intCtr]);
                        if (objCheckbox != null) {
                            objCheckbox.checked = false;
                            if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1) {
                                strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',', '');
                            }
                        }
                    }
                }
                else if (intItems == 1) {
                    objCheckbox = document.getElementById(strCheckboxIDs[0]);
                    objCheckbox.checked = false;
                    if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1) {
                        strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',', '');
                    }
                }
            }
        }

        function ActualPercentChange(TaskID) {
            //debugger;
            objActualPercent = document.getElementById('txtActPer_' + TaskID);
            objActualStartDate = document.getElementById('ActStartDate_' + TaskID);
            objActualEndDate = document.getElementById('ActEndDate_' + TaskID);

            objTaskType = document.getElementsByName('optTaskType');


            if (<%=m_intMSPIntegrationMethod%> ==1)
	        {
                if (disallowBlank(objActualPercent, "Please enter the &#39;% Completion&#39; !!"))
			        return;
		        //if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true))
                if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;% Completion&#39; !!\nThe value of &#39;% Completion&#39; must be in the range [0-100]", true))
			        return;

		        return;
	        }
	{
                if (disallowBlank(objActualPercent, "Please enter the &#39;% Completion&#39; !!"))
			return;
                if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;% Completion&#39; !!\nThe value of &#39;% Completion&#39; must be in the range [0-100]", true))
		return;

                if (objActualPercent != null && strTaskType == 'M') {
                    if (objActualPercent.value == 100.00) {
                        if (objActualStartDate.value == '' && objActualEndDate.value == '') {
                            alertify.error("Please enter task's 'Actual Start Date' & 'Actual End Date'.");
                            setFocus(objActualEndDate);
                        }
                        if (objActualStartDate.value != '' && objActualEndDate.value == '') {
                            alertify.error("Please enter task's 'Actual End Date'.");
                            setFocus(objActualEndDate);
                        }
                        if (objActualStartDate.value == '' && objActualEndDate.value != '') {
                            alertify.error("Please enter task's 'Actual Start Date'.");
                            setFocus(objActualEndDate);
                        }
                    }
                    else {
                        if (objActualStartDate.value == '') {
                            if (objActualPercent.value > 0) {
                                alertify.error("Please enter Task's 'Actual Start Date'.");
                                setFocus(objActualStartDate);
                            }
                        }
                    }
                }
            }
        }

        function ValidateMppTask() { 
            strCheckboxIDs = strTaskIDs.split(",");
            intItems = strCheckboxIDs.length;

            var strProjctStartDate, strProjectEndDate;
            objtxtProjectStartDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtProjectStartDate');
            objtxtProjectEndDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtProjectEndDate');

            if (intItems > 1) {
                if (<%=m_intMSPIntegrationMethod%> != 2) {
                for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                    TaskID = strCheckboxIDs[intCtr];
                    objActualPercent = GetObjectReference('frmPM_TaskStatusManagement', 'txtActPer_' + TaskID);

                    if (disallowBlank(objActualPercent, "Please enter the &#39;actual % complete&#39; !!")) {
                        return false;
                        break;
                    }
                    if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true)) {
                        return false;
                        break;
                    }
                }
            }
            else {
                for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                    TaskID = strCheckboxIDs[intCtr];

                    objActualPercent = GetObjectReference('frmPM_TaskStatusManagement', 'txtActPer_' + TaskID);
                    objActualStartDate = GetObjectReference('frmPM_TaskStatusManagement', 'ActStartDate_' + TaskID);
                    objActualEndDate = GetObjectReference('frmPM_TaskStatusManagement', 'ActEndDate_' + TaskID);
                    objPreActualStartDate = GetObjectReference('frmPM_TaskStatusManagement', 'ActStartDate_' + TaskID);
                    objPreActualEndDate = GetObjectReference('frmPM_TaskStatusManagement', 'ActEndDate_' + TaskID);

                    if (objActualPercent != null) {
                        if (disallowBlank(objActualPercent, "Please enter the &#39;actual % complete&#39; !!")) {
                            return false;
                            break;
                        }
                        if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true)) {
                            return false;
                            break;
                        }
                        if (strTaskType == 'M')
					    {
						if (objPreActualStartDate.value =='' && objPreActualEndDate.value == '' && objActualPercent.value == 100.00)
							{if(disallowDate1GreaterThanDate2(objPreActualStartDate,objPreActualEndDate,"Task's 'Actual Start Date' should be less than  or equal to 'Actual End Date'",true))
								{
									setFocus(objActualStartDate);
									return false;
								}
							}
						
						if (objActualPercent.value == 100.00 )
						{
							if (objActualStartDate.value == '' &&  objActualEndDate.value =='')
							{
                                alertify.error("Please enter task's 'Actual Start Date' & 'Actual End Date'");
								setFocus(objActualStartDate);
								return false;
								break;
							}
							if (objActualStartDate.value != '' &&  objActualEndDate.value =='')
							{
                                alertify.error("Please enter task's 'Actual End Date'");
								setFocus(objActualEndDate);
								return false;
								break;
							}
							if (objActualStartDate.value == '' &&  objActualEndDate.value !='')
							{
                                alertify.error("Please enter task's 'Actual Start Date'");
								setFocus(objActualStartDate);
								return false;
								break;
							}
							if('<%=m_btRestrictDurationChange_M%>' == 'True')
							{
								objtxtTaskStartDate = GetObjectReference('frmPM_TaskStatusManagement','txtTaskStartDate_' + TaskID );
								objtxtTaskEndDate = GetObjectReference('frmPM_TaskStatusManagement','txtTaskEndDate_' + TaskID );

								if( disallowDate1GreaterThanDate2(objtxtTaskStartDate,objPreActualStartDate,"Task's 'Actual Start Date' should be greater than or equal to Task's 'Start Date'.",true))
								{
									setFocus(objActualStartDate);
									return false;
								}
								if( disallowDate1GreaterThanDate2(objPreActualEndDate,objtxtTaskEndDate,"Task's 'Actual End Date' should be less than or equal to Task's 'End Date'.",true))
								{
									setFocus(objActualEndDate);
									return false;
								}
							}
							if( disallowDate1GreaterThanDate2(objtxtProjectStartDate,objPreActualStartDate,"Task's 'Actual Start Date' should be greater than or equal to Project's 'Start Date'.",true))
							{
								setFocus(objActualStartDate);
								return false;
							}
							if( disallowDate1GreaterThanDate2(objPreActualEndDate,objtxtProjectEndDate,"Task's 'Actual End Date' should be less than or equal to Project's 'End Date'.",true))
							{
								setFocus(objActualEndDate);
								return false;
							}
						}
						else if (objActualPercent.value < 100.00 && objActualPercent.value > 0)
						{
							if (objActualStartDate.value == '' )
							{
                                alertify.error("Please enter task's 'Actual Start Date'");
								setFocus(objActualStartDate);
								return false;
								break;
							}
							if (objActualEndDate.value != '' )
							{
                                alertify.error("Please do not enter task's 'Actual End Date'");
								setFocus(objActualEndDate);
								return false;
								break;
							}
                                    if ('<%=m_btRestrictDurationChange_M%>' == 'True') {
                                        objtxtTaskStartDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtTaskStartDate_' + TaskID);
                                        objtxtTaskEndDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtTaskEndDate_' + TaskID);

                                        if (disallowDate1GreaterThanDate2(objtxtTaskStartDate, objPreActualStartDate, "Task's 'Actual Start Date' should be greater than or equal to Task's 'Start Date'.", true)) {
                                            setFocus(objActualStartDate);
                                            return false;
                                        }
                                    }
                                    if (disallowDate1GreaterThanDate2(objtxtProjectStartDate, objPreActualStartDate, "Task's 'Actual Start Date' should be greater than or equal to Project's 'Start Date'.", true)) {
                                        setFocus(objActualEndDate);
                                        return false;
                                    }
                                }
                            }
                        } 
                    }
                }
            } 

            return true;
        }
        function IsValidInput() {
            var objFromDate, objToDate, objOperation, objTaskType, objPrevFromDate, objPrevToDate;

            var isDateEditable = '<%=CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")%>';

                    objPrevFromDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtFromDate');
                    objPrevToDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtToDate');

                    var objAllTasks;
                    objAllTasks = GetObjectReference('frmPM_TaskStatusManagement', 'optAllTasks');

                    //if (navigator.appName != 'Netscape') {
                        //objFromDate = GetObjectReference('frmPM_TaskUpdation', 'FFE29587WHIZ_txtFromDate');
                        //objToDate = GetObjectReference('frmPM_TaskUpdation', 'FFE29587WHIZ_txtToDate');

                        //if (isDateEditable == 'False') {
                            objFromDate = objPrevFromDate;
                            objToDate = objPrevToDate;
                        //}
                    //}

                    objOperation = GetObjectReference('frmPM_TaskStatusManagement', 'cboOperation');
                    objTaskType = GetObjectReference('frmPM_TaskStatusManagement', 'optTaskType', true);

                    for (intCnt = 0; intCnt < objTaskType.length; intCnt++) {
                        if (objTaskType[intCnt].checked)
                            strTaskType = objTaskType[intCnt].value;
                    }

                    if ((strTaskType == 'M') && (objOperation.value == 1)) {
                        alertify.error("MPP Tasks cannot be marked as 'Void (Inactive)'")
                        return false;
                    }		
                    if ((strTaskType == 'M') && (objOperation.value == 7)) {
                        alertify.error("MPP Tasks cannot be marked as 'Re-opened' from PMLifeLine ,please go to MSP to 'Re-open' MPP Tasks")
                        return false;
                    }

                    if ((strTaskType == 'M') && (objOperation.value == 2)) {
                        alertify.error("MPP Tasks cannot be marked as 'Valid (Active)'")
                        return false;
                    }

                    if ((strTaskType == 'M') && (objOperation.value == 11)) {
                        alertify.error("You cannot set baseline for MPP Tasks.")
                        return false;
                    }
                    if ((strTaskType == 'M') && (objOperation.value == 12)) {
                        alertify.error("You cannot clear baseline for MPP Tasks.")
                        return false;
                    }
                    if (((strTaskType == 'B') || (strTaskType == 'H') || (strTaskType == 'R')) && (objOperation.value == 13)) {
                        alertify.error("You can save Actual Percent Complete for MPP and Assign Tasks only.");
                        return false;
                    }

                    if (objAllTasks.checked == false) {
                    //    if (navigator.appName == 'Netscape') {
                    //        if (objPrevFromDate.value == '') {
                    //            alertify.error("From Date Should not be Blank")
                    //            return false;
                    //        }
                    //    }
                    //    else {
                            if (objFromDate.value == '') {
                                alertify.error("From Date Should not be Blank")
                                objFromDate.focus();
                                return false;
                            }
                    //    }
                    }

                    //Added by ManishK on 23th Feb 06 For IssueID 2445
                    if (objAllTasks.checked == false) {
                        //End of Added by ManishK on 23th Feb 06 For IssueID 2445

                        //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                        //if (navigator.appName == 'Netscape') {
                        //    if (objPrevToDate.value == '') {
                        //        alertify.error("To Date Should not be Blank");
                        //        return false;
                        //    }
                        //}
                        //else {
                            if (objToDate.value == '') {
                                alertify.error("To Date Should not be Blank");
                                objToDate.focus();
                                return false;
                            }
                    //    }
                    }
                    //Added By MrugajaB on 24th May 2005 for PMLifeLine Issue ID.18507
                    if (objOperation.value == '') {
                        var objOperation = GetObjectReference('frmPM_TaskStatusManagement', 'cboOperation');
                        objOperation.focus()
                        alertify.error("'Action' should not be blank")
                        return false;
                    }
                    var objAllTasks;
                    var objFromDate, objToDate, objPrevFromDate, objPrevToDate;
                    if (objAllTasks.checked == false) {
                        if (disallowDate1GreaterThanDate2(objPrevFromDate, objPrevToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true)) {
                            var dtFromfocus = GetObjectReference('frmPM_TaskStatusManagement', 'txtFromDate');
                        dtFromfocus.focus();
                            return false;
                        }
                    }

                    if (<%=m_intMSPIntegrationMethod%> == 2) {
                if (!ValidateMppTask()) {
                    return false;
                }
            }

            return true;
        }
        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-");
        }


        function PreviousWeek_OnClick() {

            var intProjectID, strTaskType, intCnt, objTaskType, intOperation, intEmployeeID;
            var objTaskFilter = GetObjectReference('frmPM_TaskStatusManagement', 'optMainTaskFilter', true);
            var msg = replaceSubstring("<%=MyBase.GetResourceString("PERVIOUS_WEEK_ALERT")%>", "&#39;", "'");

                    var objFromDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtFromDate')
                    var objToDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtToDate')
                    if (navigator.appName != 'Netscape') {
                        objFromDate.style.display = 'none';
                        objToDate.style.display = 'none';
                    }


                    if ((objTaskFilter[1].checked) == false) {
                        alertify.error(msg);
                        return;
                    }
                    intProjectID = GetObjectReference('frmPM_TaskStatusManagement', 'cboProject').value;
                    intOperation = GetObjectReference('frmPM_TaskStatusManagement', 'cboOperation').value;
                    objTaskType = GetObjectReference('frmPM_TaskStatusManagement', 'optTaskType', true);

                    for (intCnt = 0; intCnt < objTaskType.length; intCnt++) {
                        if (objTaskType[intCnt].checked)
                            strTaskType = objTaskType[intCnt].value;
                    }
                    intEmployeeID = GetObjectReference('frmPM_TaskStatusManagement', 'cboEmployee').value;
                    if (IsValidInput() == true) {
                        var newDate = new Date(objFromDate.value);
                        var toDate = new Date(objToDate.value);
                        var newFromDate = new Date(newDate.setDate(newDate.getDate() - 7))
                        var newToDate = new Date(toDate.setDate(toDate.getDate() - 7))
                        objFromDate.value = newFromDate.getDate() + "-" + months[newFromDate.getMonth()] + "-" + String(newFromDate.getFullYear()).match(/\d{2}$/);
                        objToDate.value = newToDate.getDate() + "-" + months[newToDate.getMonth()] + "-" + String(newToDate.getFullYear()).match(/\d{2}$/);
                        LoadTaskList()
			        }			
			//End Intigrated by harshk for sp4 issueid 190: Purpose-To pass EmployeeID into Querystring 
		}
		
		function NextWeek_OnClick()
		{
			var intProjectID, strTaskType, objTaskType, intCnt,intOperation, intEmployeeID;
			var objTaskFilter=GetObjectReference('frmPM_TaskStatusManagement','optMainTaskFilter',true);
			var msg=replaceSubstring("<%=MyBase.GetResourceString("NEXT_WEEK_ALERT")%>","&#39;","'");
			 if((objTaskFilter[1].checked)==false)
			 {
				alertify.error(msg);
				return ;			 
			 }
            var objFromDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtFromDate')
            var objToDate = GetObjectReference('frmPM_TaskStatusManagement', 'txtToDate')
			intProjectID = GetObjectReference('frmPM_TaskStatusManagement','cboProject').value;
			intOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation').value;
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			intEmployeeID = GetObjectReference('frmPM_TaskStatusManagement','cboEmployee').value;
			
			if (IsValidInput() == true)
			{
                var newDate = new Date(objFromDate.value);
                var toDate = new Date(objToDate.value);
                var newFromDate = new Date(newDate.setDate(newDate.getDate() + 7))
                var newToDate = new Date(toDate.setDate(toDate.getDate() + 7))
                objFromDate.value = newFromDate.getDate() + "-" + months[newFromDate.getMonth()] + "-" + String(newFromDate.getFullYear()).match(/\d{2}$/);
                objToDate.value = newToDate.getDate() + "-" + months[newToDate.getMonth()] + "-" + String(newToDate.getFullYear()).match(/\d{2}$/);
                LoadTaskList()
			}
			//End Intigrated by harshk for sp4 issueid 190
		}
        var objform = "";
		    function Save_OnClick()
            
		    {
		       

			var objFromDate, objToDate, intProjectID, strTaskType, objTaskIDs, objTaskType,intOperation, intEmployeeID;
			var strCheckboxIDs,objCheckbox,intItems,intCtr,blnSelected; 
			var objActualPercent;
			
			// Intigrated by harshk for sp4 issueid 190
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Check if any task is checked using global tracker (works across all pagination pages)
                blnSelected = false;
                // Check global tracker first
                for (var taskId in globalCheckedTaskIds) {
                    if (globalCheckedTaskIds.hasOwnProperty(taskId) && globalCheckedTaskIds[taskId] === true) {
                        blnSelected = true;
                        break;
                    }
                }
                // Fallback: if no checked tasks in global tracker, check current page DOM
                if (!blnSelected && m_CheckboxIDs != "") {
                    strCheckboxIDs = m_CheckboxIDs.split(",");
                    intItems = strCheckboxIDs.length;
                    for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                        objCheckbox = GetObjectReference(objform, strCheckboxIDs[intCtr]);
                        if (objCheckbox != null) {
                            if (objCheckbox.disabled == false) {
                                if (objCheckbox.checked == true) {
                                    blnSelected = true;
                                    break;
                                }
                            }
                        }
                    }
                }
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                
                if (blnSelected == false) {
                    alertify.error("Select at least one Task.");
                    return;
                }
                
                if (m_CheckboxIDs != "") {
                    // Purpose - To search that any task is checked (keeping for backward compatibility)
                    strCheckboxIDs = m_CheckboxIDs.split(",");
                    intItems = strCheckboxIDs.length;	
            //added By PurvaJ on 8 OCt 2008
            // validation for special characters.				
		    var arrstrTaskIDs=new Array(Math.ceil(strTaskIDs.length/4000));
			var arrstrTaskIDs=strTaskIDs;
			var blnInvalidData=false;
			arrstrTaskIDs=arrstrTaskIDs.split(",");
			for (intCtr = 0;intCtr <= arrstrTaskIDs.length - 1; intCtr++)
				{		          
					objActualPercent = GetObjectReference(objform,'txtActPer_'+arrstrTaskIDs[intCtr]);
				    if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true))
				    {
				        blnInvalidData=true;
				        break;
				    }
			            
				}
				
			if(blnInvalidData == true)
				{
					return;
                }
			var arrstrTaskIDs1=new Array(Math.ceil(strTaskIDs.length/4000));
			var arrstrTaskIDs1=strTaskIDs;
			var ParentTask, ParentTaskTotal; 
			ParentTask = 0; ParentTaskTotal = 0 ; 
			arrstrTaskIDs1=arrstrTaskIDs1.split(",");
			for (intCtr = 0;intCtr <= arrstrTaskIDs.length - 1; intCtr++)
			{
				
				var objTotalWorkhours=GetObjectReference(objform,'hid_txttotalworkhrs _'+arrstrTaskIDs[intCtr]);
				var objchildwork=GetObjectReference(objform,'hid_txtchildworkhrs _'+arrstrTaskIDs[intCtr]);
				var objparenttaskid=GetObjectReference(objform,'hid_txtParenttaskID _'+arrstrTaskIDs[intCtr]);
				var objchildworkhrs=GetObjectReference(objform,'hid_txtchildwork _'+arrstrTaskIDs[intCtr]); 
				
				var objStartDate=GetObjectReference(objform,'hid_txtTaskStartDate_'+arrstrTaskIDs[intCtr]);
				var objEndDate=GetObjectReference(objform,'hid_txtTaskEndDate_'+arrstrTaskIDs[intCtr]);
				var objPStartDate=GetObjectReference(objform,'hid_txtPTaskStartDate_'+arrstrTaskIDs[intCtr]);
				var objPEndDate=GetObjectReference(objform,'hid_txtPTaskEndDate_'+arrstrTaskIDs[intCtr]);
				
				
						
										
				if (objparenttaskid != null)
				{
					if (ParentTask != objparenttaskid.value)
					{
						
						ParentTask = objparenttaskid.value;
						ParentTaskTotal = 0;
					}
					
						if (objchildwork!=null)
							
							
							ParentTaskTotal = parseFloat(ParentTaskTotal) + parseFloat(objchildwork.value);
													
					
					
					if(objTotalWorkhours!=null)
					{
						var ParentTaskTotal1=parseFloat(ParentTaskTotal)+ parseFloat(objchildworkhrs.value);
						
						if(parseFloat(objTotalWorkhours.value) < parseFloat(ParentTaskTotal1))
						{
								blnInvalidData=true;
                            alertify.error('You can not mark this task as active, as the child task work hours are exceeding the parent task work hours('+objTotalWorkhours.value+')');
								break;
						}
					
					}
						if (objPStartDate.value!='')
						{
							if (disallowDate1GreaterThanDate2(objPStartDate,objStartDate)) 
							{
							    blnInvalidData=true;
                                alertify.error('You can not mark as active this task as start Date of child task is less than ('+objPStartDate.value+')');
								break;
							}
								
						}
					    if (objPEndDate.value!='')
						{
							if (disallowDate1GreaterThanDate2(objEndDate,objPEndDate)) 
							{
							    blnInvalidData=true;
                                alertify.error('You can not mark this task as active as End Date of child task is greater than ('+objPEndDate.value+')');
								break;
							}
							
							
						}
					
				}	
			}
			

			
			if(blnInvalidData == true)
				{
					return;
				}
			objFromDate = GetObjectReference('frmPM_TaskStatusManagement','txtFromDate').value;
			objToDate = GetObjectReference('frmPM_TaskStatusManagement','txtToDate').value;
			intProjectID = GetObjectReference('frmPM_TaskStatusManagement','cboProject').value;
			intOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation').value;
			intEmployeeID = GetObjectReference('frmPM_TaskStatusManagement','cboEmployee').value;
									
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
				
			if (IsValidInput() == true)
			{
			var arrCount=Math.ceil(strTaskIDs.length/4000);
			
			var arr_strTaskIDs=new Array(arrCount);
			var strTaskID;
			var arr_TaskList=strTaskIDs;
			arr_TaskList=arr_TaskList.split(",");
			strTaskID=arr_TaskList[0];
			strTaskIDs = strTaskIDs.substring(1,strTaskIDs.length);
			var TaskIDBreaks=strTaskIDs.length/4000;
			var count=0;
			while(count<TaskIDBreaks)
				{
			
					arr_strTaskIDs[count]=strTaskIDs.substring(0,4000);		
					strTaskIDs=strTaskIDs.substring(4000,strTaskIDs.length);
					var selectedTasks_hiddenCont=document.createElement("input");
					selectedTasks_hiddenCont.id="strTaskIDs"+count;
					selectedTasks_hiddenCont.name="strTaskIDs"+count;
					selectedTasks_hiddenCont.type="hidden";
					selectedTasks_hiddenCont.value=arr_strTaskIDs[count]
					document.body.appendChild(selectedTasks_hiddenCont); 
					count++;

			}
                // Added by Dipali V on 14th Nov 2025 for W26 Changes - Collect checked checkboxes from all pages using global tracker
                var taskStatusManagementSaveParameterList = []
                var checkedTaskIds = []; // Array to store all checked task IDs from all pages
                
                // Get all checked task IDs from global tracker (works across all pagination pages)
                for (var taskId in globalCheckedTaskIds) {
                    if (globalCheckedTaskIds.hasOwnProperty(taskId) && globalCheckedTaskIds[taskId] === true) {
                        checkedTaskIds.push(taskId);
                    }
                }
                
                // If no checked tasks found in global tracker, fallback to current page checkboxes
                if (checkedTaskIds.length === 0) {
                    $('input.taskBillableChecks:checked').each(function() {
                        var taskIdchk = $(this).val();
                        if (taskIdchk && checkedTaskIds.indexOf(taskIdchk) === -1) {
                            checkedTaskIds.push(taskIdchk);
                        }
                    });
                }
                
                // Build task list from all checked task IDs
                for (var i = 0; i < checkedTaskIds.length; i++) {
                    var taskIdchk = checkedTaskIds[i];
                    var task = {
                        m_intOperation: parseInt(intOperation),
                        ProjectId: parseInt(intProjectID),
                        TaskId: parseInt(taskIdchk),
                        ParentTaskId: parseInt($("#hid_txtParenttaskID_" + taskIdchk).val() || 0),
                        TaskType: strTaskType,
                        strActualPercentComplete: ($("#txtActPer_" + taskIdchk).length > 0 ? $("#txtActPer_" + taskIdchk).val() : ""),
                        strTaskActualStartDate: ($("#ActStartDate_" + taskIdchk).length > 0 ? $("#ActStartDate_" + taskIdchk).val() : ""),
                        strTaskActualEndDate: ($("#ActEndDate_" + taskIdchk).length > 0 ? $("#ActEndDate_" + taskIdchk).val() : ""),
                        m_intMSPIntegrationMethod: parseInt(<%=m_intMSPIntegrationMethod%>)
                    }
                    taskStatusManagementSaveParameterList.push(task)
                }
                // End of Added by Dipali V on 14th Nov 2025 for W26 Changes
                // Commented by DipalI v On 4th sep 2026 - Purpose: full Params in header caused request header size failure for large SaveTasks lists
                //var param = JSON.stringify({ 'taskStatusManagementSaveParameters': taskStatusManagementSaveParameterList });
                //AJAXCallWithResult(SaveTasks, param, true, "POST", function (result) {
                //    alertify.notify("Saved Successfully", 'success', alertifyTimer);
                //    LoadTaskList();
                //    Show_OnClick();
                //});
                // Added by DipalI v On 4th sep 2026 - Purpose: max 1000 tasks per save to protect UI/API performance
                if (taskStatusManagementSaveParameterList.length > 1000) {
                    alertify.error('Only 1,000 tasks can be saved at a time. Please reduce the number of tasks and try again');
                    return;
                }
                // Added by DipalI v On 4th sep 2026 - Purpose: full body + slim hashed Params; ValidateHeaders(AllowHashParams) still validates without large header
                var param = JSON.stringify({ 'taskStatusManagementSaveParameters': taskStatusManagementSaveParameterList });
                AJAXCallWithResultSaveTasks(SaveTasks, param, taskStatusManagementSaveParameterList, function (result) {
                    alertify.notify("Saved Successfully", 'success', alertifyTimer);
                    LoadTaskList();
                    Show_OnClick();
                });
                }
            }
                else {
                    alertify.error("Select at least one Task.");
                return;
            }

        }
    </script>


</body>
</html>
