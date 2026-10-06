<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TaskManagement.aspx.vb" Inherits="Whizible.TaskManagement" %>


<!DOCTYPE html>
<html>

     <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Task Management")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Task Management</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">--%>
    <!--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">-->
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <!-- Font Awesome -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
</head>

    <style>
            .dataTables_empty {
    text-align: center!important;
    
    }
        body {
            padding: 0px 0px 0px;
            overflow: hidden;
        }
/*        CSS added by Madhuri.K Start here*/
        .panel-default > .panel-heading a {
            color: #1359a6;
            display:block;
        }
/*        CSS added by Madhuri.K End here*/
        .filterpanelbody {
            padding: 30px 0;
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

        /* Modified: Removed hidecol functionality - Current, Baseline, Actual now combined in single TD */
        .tdCurrent, tdbaseline, tdactual {
            display: table-cell
        }

        /* Commented out hidecol styles as hide/expand functionality removed */
        /*td.hidecol, th.hidecol {
            display: table-cell;
            font-size: 0;
            width: 20px !important;
            min-width: auto !important;
            border: none !important;
            border-bottom: 1px solid #ddd !important;
            text-align: center !important;
            padding: 5px !important;
        }
        /*Task Management table end*/
        .TMtbl th {
            min-width: 100px;
            vertical-align: middle !important
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

        .tdCurrent.hidecol + .tdCurrent.hidecol + .tdCurrent.hidecol + .tdCurrent.hidecol {
            border-right: 1px solid #ddd !important
        }

        .tdbaseline.hidecol + .tdbaseline.hidecol + .tdbaseline.hidecol + .tdbaseline.hidecol {
            border-right: 1px solid #ddd !important
        }

        .tdactual.hidecol + .tdactual.hidecol + .tdactual.hidecol + .tdactual.hidecol {
            border-right: 1px solid #ddd !important
        }

        .tdCurrent[colspan="4"], .tdbaseline[colspan="4"], .tdactual[colspan="4"] {
            border-right: 1px solid #ddd !important
        }

        /* Added by Dipali V on 14th Nov 2025 for W26 changes - Timeline combined view styles */
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
            /*border-bottom: 1px solid #e0e0e0;*/
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
        /* End of Added by Dipali V on 14th Nov 2025 for W26 changes */

        /* Added by Dipali V on 14th Nov 2025 for W26 changes - Sticky header for Task Management table */
        section.content {
            position: relative;
        }
        /* Added by Dipali V on 14th Nov 2025 for W26 changes - 1px rounded border for divMain */
        .TMtblwrap {
            position: relative;
            border: 1px solid #dee2e6 !important;
            border-radius: 8px !important;
            overflow: hidden !important;
        }
        /* End of Added by Dipali V on 14th Nov 2025 for W26 changes */
        #TskMngmentTblID_wrapper {
            position: relative;
        }
        /* Sticky header for DataTables scroll head */
        #TskMngmentTblID_wrapper .dataTables_scrollHead {
            position: sticky !important;
            top: 0 !important;
            z-index: 1000 !important;
            background-color: #fff !important;
        }
        #TskMngmentTblID_wrapper .dataTables_scrollHeadInner {
            background-color: #fff !important;
        }
        #TskMngmentTblID_wrapper .dataTables_scrollHeadInner table {
            margin-bottom: 0 !important;
        }
        /* Ensure scrollHead thead is visible and properly styled */
        .dataTables_scrollHead thead {
            display: table-header-group !important;
        }
        .dataTables_scrollHead thead tr {
            display: table-row !important;
        }
        .dataTables_scrollHead thead th {
            display: table-cell !important;
        }
        /* Sticky header for regular table thead - entire thead sticks together */
        .TMtbl thead {
            position: sticky !important;
            top: 0 !important;
            z-index: 1000 !important;
            background-color: #fff !important;
        }
        .TMtbl thead tr {
            background-color: #fff !important;
        }
        .TMtbl thead th {
            background-color: #f8f9fa !important;
            border-bottom: 2px solid #dee2e6 !important;
        }
        .dataTables_scrollHead thead th {
            background-color: #f8f9fa !important;
            border-bottom: 2px solid #dee2e6 !important;
            position: sticky !important;
            top: 0 !important;
        }
        /* Added by Dipali V on 14th Nov 2025 for W26 changes - Scroller for tblTasks table body */
        .dataTables_scrollBody {
            overflow-y: auto !important;
            max-height: 47vh !important;
            position: relative;
        }
        #TskMngmentTblID_wrapper .dataTables_scrollBody {
            border-bottom-left-radius: 8px !important;
            border-bottom-right-radius: 8px !important;
        }
        /* Hide blank header rows inside scrollBody - keep structure for column alignment but make invisible */
        .dataTables_scrollBody thead {
            display: table-header-group !important;
        }
        .dataTables_scrollBody thead tr {
            display: table-row !important;
            height: 1px !important;
            line-height: 1px !important;
        }
        .dataTables_scrollBody thead th {
            display: table-cell !important;
            height: 1px !important;
            line-height: 1px !important;
            padding: 0 !important;
            margin: 0 !important;
            border: none !important;
            font-size: 0 !important;
            overflow: hidden !important;
        }
        .dataTables_scrollBody thead th > * {
            display: none !important;
        }
        /* Ensure scrollBody table matches header width and column alignment */
        .dataTables_scrollBody table {
            width: 100% !important;
            margin-top: 0 !important;
        }
        .dataTables_scrollHead table {
            width: 100% !important;
        }
        /* Ensure column widths match between scrollHead and scrollBody */
        .dataTables_scrollHead th,
        .dataTables_scrollBody td {
            box-sizing: border-box !important;
        }
        /* End of Added by Dipali V on 14th Nov 2025 for W26 changes */
        /* Fix for two-row header structure - both rows stick together */
        .TMtbl thead tr:first-child th {
            top: 0 !important;
        }
        .TMtbl thead tr:last-child th {
            top: 0 !important;
        }
        /* Ensure parent containers don't prevent sticky */
        /*body, html {
            overflow-x: hidden;
        }*/
        .content-wrapper, .wrapper {
            overflow: visible !important;
        }
        /* Added by Dipali V on 14th Nov 2025 for W26 changes - Table rounded corners and header styling (borders kept as existing) */
        #TskMngmentTblID_wrapper {
            border-radius: 8px !important;
            overflow: hidden !important;
        }
        .TMtbl {
            border-radius: 8px !important;
            overflow: hidden !important;
        }
        .TMtbl thead {
            background-color: #f8f9fa !important;
        }
        .TMtbl thead tr:first-child {
            background-color: #f8f9fa !important;
        }
        .TMtbl thead tr:first-child th {
            background-color: #f8f9fa !important;
            padding: 12px 8px !important;
            font-weight: 600 !important;
            color: #495057 !important;
        }
        /* Only Timeline header (colspan 4) should have visible bottom border */
        .TMtbl thead tr:first-child th[colspan="4"] {
            border-bottom: 1px solid #dee2e6 !important;
        }
        .TMtbl thead tr:last-child {
            background-color: #f8f9fa !important;
        }
        .TMtbl thead tr:last-child th {
            background-color: #f8f9fa !important;
            padding: 10px 8px !important;
            font-weight: 500 !important;
            color: #495057 !important;
            text-align: center !important;
        }
        .TMtbl thead tr:last-child th:first-child,
        .TMtbl thead tr:last-child th:nth-child(2),
        .TMtbl thead tr:last-child th:nth-child(3) {
            text-align: left !important;
        }
        .TMtbl tbody td {
            padding: 10px 8px !important;
        }
        /* Added by Dipali V on 14th Nov 2025 for W26 changes - Center align Billable and Void checkboxes */
        .TMtbl tbody td .taskBillableChecks,
        .TMtbl tbody td .taskVoidChecks {
            margin: 0 auto;
            display: block;
        }
        /* Center align table cells - Billable is 3rd to last, Void is 2nd to last (before Show Baseline) */
        .TMtbl tbody tr td:nth-last-child(3),
        .TMtbl tbody tr td:nth-last-child(2) {
            text-align: center !important;
        }
        /* Also center align header for Billable and Void columns */
        .TMtbl thead tr:last-child th:nth-last-child(3),
        .TMtbl thead tr:last-child th:nth-last-child(2) {
            text-align: center !important;
        }
        /* End of Added by Dipali V on 14th Nov 2025 for W26 changes */
        /* Rounded corners for first and last cells */
        .TMtbl thead tr:first-child th:first-child {
            border-top-left-radius: 8px !important;
        }
        .TMtbl thead tr:first-child th:last-child {
            border-top-right-radius: 8px !important;
        }
        /* End of Added by Dipali V on 14th Nov 2025 for W26 changes */

        .table thead tr th:first-child {
            min-width: 250px;
            text-align: left
        }

        .table tbody tr td:first-child {
            text-align: left
        }

        .container-fluid ul.statustext {
            margin: 0;
            padding: 0
        }

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

       /* .colapsibleinfopanel .panel-default > .panel-heading {
            padding-right: 15px;
            background: #e7edf0
        }*/

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

        .d-inline-block {
            display: inline-block
        }

        .custom_radio input[type="radio"] + label span {
            margin: 0 5px
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px
        }

        #TskMngmentTblID_wrapper .dataTables_scrollFootInner {
            width: 100% !important
        }

        div.dataTables_scrollHead table.dataTable, .dataTables_scrollBody table {
            width: 100% !important
        }

        td.relativeTD {
            position: relative
        }

        td span.storyLbl {
            position: absolute;
            top: 5px;
            right: 5px;
            font-size: 10px;
            font-weight: 400;
            background-color: #17a2b8
        }

        .table tfoot tr td {
            text-align: center
        }

        table.TMtbl tfoot tr td:first-child {
            text-align: left
        }

        #TMOthertaskmodal .dataTables_scrollBody {
            height: 55vh !important;
            max-height: unset !important;
        }

        #TMOthertaskmodal .modal-dialog {
            margin-top: 40px;
        }

        /*#TskMngmentTblID_wrapper {
            overflow: auto;
        }*/
.custmodal .modal-content .modal-header{ display:block;}
.btnyellow {
    background: #fbb03b;
    color: #fff;
}
div#TskMngmentTblID_wrapper .row.dt-row {overflow: auto;margin: 0 0px;}
div#TskMngmentTblID_wrapper .row.dt-row>.col-sm-12 {padding: 0;}
 /*Added By Dipali V On 20th Jan 2026 For W26 Changes*/
 .bgwhite {
     /* Modified By Madhuri.K On 26-03-2026 */
     font-size:11.5px!important;
 }
#divMain {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
 }
 .form-control, .btn, a, p, input, select.form-select
 {
     /* Modified By Madhuri.K On 26-03-2026 */
     font-size:11.5px!important;
 }
 .custmodal {
     /* Modified By Madhuri.K On 26-03-2026 */
     font-size: 11.5px !important;
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

        .table tr th {
            border-bottom: 1px solid #dee2e6 !important;
        }
   /*End of Added By Dipali V On 20th Jan 2026 For W26 Changes*/
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <% If m_blnViewAccess = True Then %>
    <div class="bgwhite">
    <%--    <div class="graybg container-fluid pt-1 pb-1 statckmainheader">
            <div class="row">
                <div class="col-sm-3">
                   
                    <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("TaskManagement_New") %></h5>
                   
                </div>
                <div class="col-sm-9 form-inline text-end">
                </div>

            </div>
        </div>--%>


        <div class="d-flex">
            <div class="col-sm-6">
                <p class="mb-0" style="margin-top: 13px;"><%=MyBase.GetResourceString("title1") %></p>
            </div>
            <div class="col-sm-6">
                <div class="pt-1 text-end">
                    <a href="javascript:GetTaskListForSelectMore();" class="btn borderbtn" id="Selectmore">Select More</a>
                    <a href="javascript:ShowAllTasks();" class="btn borderbtn" id="ShowAllTasks">Show All Tasks</a>
                    <a href="javascript:GotoMapping();" class="btn borderbtn"><%=MyBase.GetResourceString("TaskMapping") %></a>
                    <%If (m_blnAddAccess = True Or m_blnEditAccess = True) Then %>
                    <%--Commented & Added By Dipali V On 20th Jan 2026 For Save button generic--%>
                    <%--<a href="javascript:SaveTasks();"id="btnsave" class="btn "><%=MyBase.GetResourceString("Save") %></a>--%>
                    <a href="javascript:SaveTasks();"id="btnsave" class="btn btn-primary-action"><i class="fas fa-save"></i><%=MyBase.GetResourceString("Save") %></a>
                    <%--End of Commented & Added By Dipali V On 20th Jan 2026 For Save button generic--%>
                    <%End If %>
                </div>
            </div>
        </div>

        <div class="px-3">
            <div class="panel-group colapsibleinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                <div class="panel panel-default panel-horizontal lightgraybg">
                    <div class="panel-heading" role="tab" id="TMinfoHeadingOne">
                        <!-- Added/Commented By Madhuri.K On 27-Aug-2024 For Alignment Issue Start here-->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#TMinfoCollapseOne" aria-expanded="true" aria-controls="collapseOne">                       
                                <%=MyBase.GetResourceString("TaskManagementDetails") %>
                            
                             <span class="infoToggler togglerup float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                            </span>
                                </a>
                        </h4>
                         <!-- Added/Commented By Madhuri.K On 27-Aug-2024 For Alignment Issue End here-->
                    </div>

                    <div id="TMinfoCollapseOne" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="TMinfoHeadingOne">
                        <div class="panel-body">
                            <div class="pb-1">
                                <div class="GPMfiltr mr-1">
                                    <div class="d-inline-block">
                                        <div class="custom_radio" data-bs-toggle="tooltip" data-title="Positive GPM" data-bs-container="body">
                                            <input id="TMfltrRadiochk1" name="Rgroup1" value="TM1" type="radio" class="radioD" checked="checked" onchange="GetTaskList('D')">
                                            <label for="TMfltrRadiochk1"><span></span><%=MyBase.GetResourceString("GeneralTask") %></label>
                                        </div>
                                    </div>
                                    <div class="d-inline-block  ml-1">
                                        <div class="custom_radio" data-bs-toggle="tooltip" data-title="Negative GPM" data-bs-container="body">
                                            <input id="TMfltrRadiochk2" name="Rgroup1" value="TM2" type="radio"  class="radioM" onchange="GetTaskList('M')">
                                            <label for="TMfltrRadiochk2"><span></span><%=MyBase.GetResourceString("MPPTask") %></label>
                                        </div>
                                    </div>
                                    <div class="d-inline-block  ml-1">
                                        <div class="custom_radio" data-bs-toggle="tooltip" data-title="All GPM" data-bs-container="body">
                                            <input id="TMfltrRadiochk3" name="Rgroup1" value="TM3" type="radio"  class="radioO" onchange="GetTaskList('O')">
                                            <label for="TMfltrRadiochk3"><span></span><%=MyBase.GetResourceString("AssignedTask") %></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="pt-1 pb-1 col-sm-12 text-end toplinks bg-gray-light">
                                <div class="row">
                                    <div class="col-sm-6 text-start row">
                                        <label class="col-sm-4" style="margin-top: 5px;"><%=MyBase.GetResourceString("SelectResource") %> :</label>
                                        <div class="col-sm-6 p-0">
                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboResource", "Select ''", cssClass:="form-select", ToBeInserted:="onchange=LoadTaskList()") %>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>

                        </div>
                    </div>


                </div>
            </div>
        </div>


        <div class="clearfix"></div>
    </div>


    <div class="clearfix"></div>
    <section class="content pt-0">
        <div class="TMtblwrap" id="divMain">
            <!--Task management table start here-->
            <div class="clearfix"></div>
            <table id="TskMngmentTblID" class="table table-stripped table-bordered TMtbl table-hideable">
            </table>
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
                        <table class="table table-stripped table-bordered tmselectTaskModaltbl" style="width: 100%;" id="tblSelectMore">
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
                        <%If (m_blnAddAccess = True Or m_blnEditAccess = True) Then %>
                        <button class="btn btnyellow" onclick="SaveTaskListForSelectMore()">Save</button>
                        <%End If %>
                    </div>

                </div>
                <!-- /.content -->
                <div class="clearfix"></div>
            </div>

        </div>
    </div>
    <div class="clearfix"></div>


    <!--taskmapping modal popup-->
    <div class="modal custmodal Issuesave_filter fade" id="TaskMapingmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("TaskMapping") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("TaskName") %> :</label>
                            <div class="col-sm-8" id="taskNameEdit">Conduct/Attend Training</div>
                            <input type="hidden" id="taskIdEdit" value="" />
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="form-group mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("TaskType") %> :</label>
                            <div class="col-sm-8">
                                <%CommonFunctions.HTMLControls.DrawComboBox("taskTypeDdl", "Select ''", cssClass:="form-select") %>
                                <%--<%CommonFunctions.HTMLControls.DrawComboBox("taskTypeDdl", "Select ''",,,,,, "form-control form-select selectpicker") %>--%>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>

                    <div class="form-group assignedTask mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("Phase") %> :</label>
                            <div class="col-sm-8">
                                <%CommonFunctions.HTMLControls.DrawComboBox("PhaseDdl", "Select ''", cssClass:="form-select") %>
                            </div>
                        </div>
                    </div>
                    <div class="form-group assignedTask mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("Module") %> :</label>
                            <div class="col-sm-8">

                                <%CommonFunctions.HTMLControls.DrawComboBox("ModuleDdl", "Select ''", cssClass:="form-select") %>
                            </div>
                        </div>
                    </div>
                    <div class="form-group assignedTask mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("SubProject") %> :</label>
                            <div class="col-sm-8">

                                <%CommonFunctions.HTMLControls.DrawComboBox("SubProjectDdl", "Select ''", cssClass:="form-select") %>
                            </div>
                        </div>
                    </div>
                    <div class="form-group assignedTask mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("Milestone") %> :</label>
                            <div class="col-sm-8">

                                <%CommonFunctions.HTMLControls.DrawComboBox("MilestoneDdl", "Select ''", cssClass:="form-select") %>
                            </div>
                        </div>
                    </div>
                    <div class="form-group assignedTask mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("ProjectFeature") %> :</label>
                            <div class="col-sm-8">

                                <%CommonFunctions.HTMLControls.DrawComboBox("FeatureDdl", "Select ''", cssClass:="form-select") %>
                            </div>
                        </div>
                    </div>
                    <div class="form-group assignedTask mb-3">
                        <div class="row">
                            <label class="control-label col-sm-4 text-end"><%=MyBase.GetResourceString("Deliverable") %> :</label>
                            <div class="col-sm-8">
                                <%CommonFunctions.HTMLControls.DrawComboBox("DeliverableDdl", "Select ''", cssClass:="form-select") %>
                            </div>
                        </div>
                    </div>

                    <div class="row modal-footer">
                        <label class="control-label col-sm-4 text-end">&nbsp;</label>
                        <div class="col-sm-8">
                            <button class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("Cancel") %></button>
                            <%If (m_blnAddAccess = True Or m_blnEditAccess = True) Then %>
                            <button class="btn btnyellow" onclick="SaveTaskInformation()"><%=MyBase.GetResourceString("Save") %></button>
                            <%End If %>
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
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("ShowBaseline") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="clearfix"></div>
                <div class="modal-body">
                    <p id="taskName"><strong>Baseline History For Task :</strong> Conduct/Attend Training</p>
                    <div class="table-responsive">
                        <table class="table table-bordered shwbaselinetbl">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("ChangeDate") %></th>
                                    <th><%=MyBase.GetResourceString("CurrentStartDate") %></th>
                                    <th><%=MyBase.GetResourceString("CurrentEndDate") %></th>
                                    <th><%=MyBase.GetResourceString("BaselineEndDate") %></th>
                                    <th><%=MyBase.GetResourceString("BaselineWork") %></th>
                                    <th><%=MyBase.GetResourceString("BaselineDuration") %></th>
                                </tr>
                            </thead>
                            <tbody id="tblTaskBaseline">
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

    </div>
    <%End If %>

    <!-- Show Baseline Modal End here-->
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 3.6.1 -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <!--customepagination-->
    <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>
    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script>
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
        var Activeflag = "Active"
        var commonProperty = { ProjectId: ProjectId, RoleId: RoleID, EmployeeId: UserId, LoginType: LoginType, LoginId: LoginID, IssueID: 0, strMode: '' };
        var alertifyTimer = 5;
        $("[data-bs-toggle='tooltip']").tooltip();
        let GetTaskListAPI = "/api/TaskManagement/GetTaskList";
        let GetEmployees = "/api/TaskManagement/GetEmployees";
        let GetTaskBaseline = "/api/TaskManagement/GetTaskBaseline";
        let SaveTaskActualCompletion = "/api/TaskManagement/SaveTaskActualCompletion";
        let SaveTaskBillableActive = "/api/TaskManagement/SaveTaskBillableActive"
        let GetTaskReferences = "/api/TaskManagement/GetTaskReferences";
        let GetTaskDetails = "/api/TaskManagement/GetTaskDetails";
        let UpdateTaskType = "/api/TaskManagement/UpdateTaskType";
        let GetTaskListForSelectMoreVar = "/api/TaskManagement/GetTaskListForSelectMore";
        let SaveTaskListForSelectMoreVar = "/api/TaskManagement/SaveTaskListForSelectMore";
        var whichTask = "D";
        //Added By Dipali V On 12th April 2023 For Back Persist ISsue
        function getParams() {
            var params = {},
                pairs = document.URL.split('?')
                    .pop()
                    .split('&');
            for (var i = 0, p; i < pairs.length; i++) {
                p = pairs[i].split('=');
                params[p[0]] = p[1];
            }
            return params;
        }
        params = getParams();
        var WhichTask = unescape(params["WhichTask"]);
      
        if (WhichTask == "undefined") {
            WhichTask = "D";
        }
        else {
            whichTask = WhichTask;
            $(".radioD").removeAttr("checked");
        }
       
       
        $(".radio" + whichTask).prop("checked", true);
         //End of Added By Dipali V On 12th April 2023 For Back Persist ISsue
        $(document).ready(function () {
            alertify.set('notifier', 'position', 'top-right');
            GetTaskList(whichTask);
            DisableEnableShowBtn();
        });
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
        function ShowAllTasks() {

            if (Activeflag == 'Active') {
                $("#ShowAllTasks").html("Show Active Tasks");
                Activeflag = "All"
            }
            else {
                $("#ShowAllTasks").html("Show All Tasks");
                Activeflag = "Active"
            }
            LoadTaskList();
        }

        function GetTaskList(flag) {
            if (flag != 'D') {
                $("#ShowAllTasks").css("display", "none");
                $("#Selectmore").css("display", "none");
                $("#cboResource").prop("disabled", false);
            }
            else {
                $("#ShowAllTasks").css("display", "");
                $("#Selectmore").css("display", "");
                $("#cboResource").prop("disabled", true);
            }
            whichTask = flag;
            $("#cboResource").html('');
            if (flag != "D") {
                LoadEmployees();
            }
            LoadTaskList();
        }

        function GotoMapping() {
            window.location.href = "TaskMapping.aspx?MasterTagId=406&TaskType=" + whichTask;
        }
        function AJAXCallWithResult(url, param, async, type, callback) {
            var ajaxResult;
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: type,
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                    callback(ajaxResult);
                },
                error: function (jqXHR) {
                    console.log(jqXHR);
                }
            });
            return ajaxResult;
        }

        function GetTaskListForSelectMore() {
            var result;
            var param = JSON.stringify(projectId = ProjectId);
            AJAXCallWithResult(GetTaskListForSelectMoreVar, param, true, "POST", function (result) {
                var strhtml = `<thead>
                                    <tr>
                                        <th>Task Name</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheckhead" value="" class="chckHead chkHeadSelectMore">
                                                <label name="TMbillablechk1" for="SOTcheckhead"></label>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>`;
                for (var i = 0; i < result.length; i++) {
                    strhtml += `<tr>
                                        <th>${result[i].TaskName}</th>
                                        <th>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" name="" id="SOTcheck${result[i].TaskID}" value="${result[i].TaskID}" class="chkSelectMore chcktbl">
                                                <label name="TMbillablechk1" for="SOTcheck${result[i].TaskID}"></label>
                                            </div>
                                        </th>
                                    </tr>`
                }
                if (result.length == 0) {
                    strhtml += `<tr>
                                        <td colspan=2 style='text-align:center'>There are no items to show in this view.</td>
                                        <td style="display:none">
                                           
                                        </td>
                                    </tr>`
                }
                strhtml += `</tbody>`
                $("#tblSelectMore").html(strhtml);
                $("#TMOthertaskmodal").modal('show');
                $(".chkHeadSelectMore").unbind("change").change(function () {
                    $(".chkSelectMore").prop("checked", $(this).prop("checked"));                    
                })
            });

        }

        function SaveTaskListForSelectMore() {
            var taskIds = "";

            $(".chkSelectMore").each(function () {
                if ($(this).prop("checked") == true) {
                    if (taskIds == "") {
                        taskIds = $(this).val()
                    }
                    else {
                        taskIds += ',' + $(this).val();
                    }
                }
            })
            if (taskIds == "") {
                alert("Please select atleast one task.");
            }
            var saveSelectMoreParameter = { projectId: ProjectId, taskIds: taskIds }
            var param = JSON.stringify(saveSelectMoreParameter);
            AJAXCallWithResult(SaveTaskListForSelectMoreVar, param, true, "POST", function (result) {
                $("#TMOthertaskmodal").modal('hide');
                alertify.notify("<%=MyBase.GetResourceString("SavedSuccessfully") %>", 'success', alertifyTimer);
                GetTaskList(whichTask);
            });
        }

        function LoadEmployees() {
            var result;
            var param = JSON.stringify(projectId = ProjectId);
            AJAXCallWithResult(GetEmployees, param, true, "POST", function (result) {
                $("#cboResource").append("<option value='0'><%=MyBase.GetResourceString("SelectResource") %></option>")
                for (var i = 0; i < result.length; i++) {
                    $("#cboResource").append("<option value='" + result[i].EmployeeId + "'>" + result[i].EmployeeName + "</option>")
                }
            });
        }
        function SaveTaskInformation() {
            var updateTaskInput = {
                DeliverableId: $("#DeliverableDdl option:selected").val() ? $("#DeliverableDdl option:selected").val() : "NULL",
                TaskTypeId: $("#taskTypeDdl option:selected").val() ? $("#taskTypeDdl option:selected").val() : "NULL",
                TaskType: $("#taskTypeDdl option:selected").val() ? $("#taskTypeDdl option:selected").text() : "NULL",
                PhaseId: $("#PhaseDdl option:selected").val() ? $("#PhaseDdl option:selected").val() : "NULL",
                Phase: $("#PhaseDdl option:selected").val() ? $("#PhaseDdl option:selected").text() : "NULL",
                ModuleId: $("#ModuleDdl option:selected").val() ? $("#ModuleDdl option:selected").val() : "NULL",
                SubProjectId: $("#SubProjectDdl option:selected").val() ? $("#SubProjectDdl option:selected").val() : "NULL",
                SubProject: $("#SubProjectDdl option:selected").val() ? $("#SubProjectDdl option:selected").text() : "NULL",
                Module: $("#ModuleDdl option:selected").val() ? $("#ModuleDdl option:selected").text() : "NULL",
                MilestoneId: $("#MilestoneDdl option:selected").val() ? $("#MilestoneDdl option:selected").val() : "NULL",
                Milestone: $("#MilestoneDdl option:selected").val() ? $("#MilestoneDdl option:selected").text() : "NULL",
                FeatureId: $("#FeatureDdl option:selected").val() ? $("#FeatureDdl option:selected").val() : "NULL",
                TaskId: $("#taskIdEdit").val()
            }
            var param = JSON.stringify(updateTaskInput);
            AJAXCallWithResult(UpdateTaskType, param, true, "POST", function (result) {
                alertify.notify("Saved Successfully.", 'success', alertifyTimer);
                GetTaskList(whichTask);
                $("#TaskMapingmodal").modal('hide');
            });
        }

        function LoadTaskReferences(taskId) {

            var filterParameters = {
                TaskId: taskId,
                ProjectId: ProjectId
            }
            if (whichTask == 'D') {
                $(".assignedTask").css("display", "none");
            }
            else {
                $(".assignedTask").css("display", "");
            }
            var param = JSON.stringify(filterParameters);
            AJAXCallWithResult(GetTaskReferences, param, true, "POST", function (result) {
                console.log(result);
                $("#taskTypeDdl").html('<option value=0><%=MyBase.GetResourceString("SelectTaskType") %></option>');
                $("#PhaseDdl").html('<option value=0><%=MyBase.GetResourceString("SelectPhase") %></option>');
                $("#ModuleDdl").html('<option value=0><%=MyBase.GetResourceString("SelectModule") %></option>');
                $("#SubProjectDdl").html('<option value=0><%=MyBase.GetResourceString("SelectSubProject") %></option>');
                $("#MilestoneDdl").html('<option value=0><%=MyBase.GetResourceString("SelectMilestone") %></option>');
                $("#DeliverableDdl").html('<option value=0><%=MyBase.GetResourceString("SelectDeliverable") %></option>');
                $("#FeatureDdl").html('<option value=0><%=MyBase.GetResourceString("SelectProjectFeature") %></option>');
                for (var i = 0; i < result.TaskTypes.length; i++) {
                    $("#taskTypeDdl").append('<option value=' + result.TaskTypes[i].Id + '>' + result.TaskTypes[i].Name + '</option>');
                }
                for (var i = 0; i < result.Phases.length; i++) {
                    $("#PhaseDdl").append('<option value=' + result.Phases[i].Id + '>' + result.Phases[i].Name + '</option>');
                }
                for (var i = 0; i < result.Modules.length; i++) {
                    $("#ModuleDdl").append('<option value=' + result.Modules[i].Id + '>' + result.Modules[i].Name + '</option>');
                }
                for (var i = 0; i < result.SubProjects.length; i++) {
                    $("#SubProjectDdl").append('<option value=' + result.SubProjects[i].Id + '>' + result.SubProjects[i].Name + '</option>');
                }
                for (var i = 0; i < result.Milestones.length; i++) {
                    $("#MilestoneDdl").append('<option value=' + result.Milestones[i].Id + '>' + result.Milestones[i].Name + '</option>');
                }
                for (var i = 0; i < result.Features.length; i++) {
                    $("#FeatureDdl").append('<option value=' + result.Features[i].Id + '>' + result.Features[i].Name + '</option>');
                }
                for (var i = 0; i < result.Deliverables.length; i++) {
                    $("#DeliverableDdl").append('<option value=' + result.Deliverables[i].Id + '>' + result.Deliverables[i].Name + '</option>');
                }
                var param1 = JSON.stringify(taskId = taskId);
                AJAXCallWithResult(GetTaskDetails, param1, true, "POST", function (result1) {
                    $("#taskNameEdit").html(result1.TaskName);
                    $("#taskTypeDdl").val(result1.TaskTypeId);
                    $("#PhaseDdl").val(result1.PhaseId);
                    $("#ModuleDdl").val(result1.ModuleId);
                    $("#SubProjectDdl").val(result1.SubProjectId);
                    $("#MilestoneDdl").val(result1.MilestoneId);
                    $("#FeatureDdl").val(result1.ProjectFeatureId);
                    $("#DeliverableDdl").val(result1.DeliverableId);
                    $("#taskIdEdit").val(taskId);
                    $("#TaskMapingmodal").modal('show');
                });
            });
        }

        function LoadTaskBaseline(TaskId) {
            var result;
            var param = JSON.stringify(taskId = TaskId);
            AJAXCallWithResult(GetTaskBaseline, param, true, "POST", function (result) {
                var strHTML = '';
                for (var i = 0; i < result.length; i++) {
                    strHTML += `<tr>
                                    <td class="">${result[i].BaselineChangeDate}</td>
                                    <td class="">${result[i].StartDate}</td>
                                    <td class="">${result[i].EndDate}</td>
                                    <td class="">${result[i].BaselineEndDate}</td>
                                    <td class="">${result[i].Work}</td>
                                    <td class="">${result[i].Duration}</td>
                                </tr>`
                }
                $("#taskName").html("<strong><%=MyBase.GetResourceString("BaselineHistoryForTask") %> :</strong> " + $("#taskLabel_" + TaskId).html());
                $("#tblTaskBaseline").html(strHTML);
                $("#showBaslineModal").modal('show');
            });
        }

        function SaveTasks() {
            if (whichTask != "D") {
                SaveTaskActuals();
            }
            else {
                SaveBillable();
            }
        }

        function SaveBillable() {
            var taskBillableActiveList = []

            $(".taskBillableChecks").each(function () {
                if ($(this).prop("checked") == true) {
                    var task = {
                        TaskId: parseInt($(this).attr("taskId")),
                        Billable: document.getElementById("billable_" + parseInt($(this).attr("taskId"))).checked,
                        Active: document.getElementById("void_" + parseInt($(this).attr("taskId"))).checked,
                        m_lngProjectId: parseInt(ProjectId)
                    }
                    taskBillableActiveList.push(task)
                }
            })
            var param = JSON.stringify({ 'taskBillableActives': taskBillableActiveList });
            AJAXCallWithResult(SaveTaskBillableActive, param, true, "POST", function (result) {
                alertify.notify("<%=MyBase.GetResourceString("SavedSuccessfully") %>", 'success', alertifyTimer);
            });
        }

        function SaveTaskActuals() {
            var taskActualPercentageList = []

            $(".perceinput").each(function () {
                if ($(this).prop("checked") == true) {
                    var task = {
                        TaskId: parseInt($(this).attr("taskId")),
                        ActualPercentage: $(this).val(),
                        PrevActualPercentage: $("#actualComplete_temp_" + $(this).attr("taskId")).val(),
                        m_strTaskType: whichTask
                    }
                    taskActualPercentageList.push(task)
                }
            })
            var param = JSON.stringify({ 'taskActualPercentages': taskActualPercentageList });
            AJAXCallWithResult(SaveTaskActualCompletion, param, true, "POST", function (result) {
                alertify.notify("<%=MyBase.GetResourceString("SavedSuccessfully") %>", 'success', alertifyTimer);
            });
        }

        function LoadTaskList() {
            var result;
           
            var taskInput = {
                Flag: whichTask,
                ProjectId: ProjectId,
                PageNumber: "-1",
                EmployeeId: $("#cboResource").val() ? $("#cboResource").val() : "NULL",
                SortBy: "",
                ActiveAll: Activeflag
            }
            var param = JSON.stringify(taskInput);
            var strHTML = '';
            AJAXCallWithResult(GetTaskListAPI, param, true, "POST", function (result) {
                var TotalActualDecimalWorkHHMM = "";
                var TotalBaseLineDecimalWorkHHMM = "";
                var TotalCurrentDecimalWorkHHMM = "";
                // Updated by Dipali V on 14th Nov 2025 for W26 changes - Combined Current, Baseline, Actual into single Timeline TD
                if (whichTask != 'D') {
                    strHTML += `<table id="TskMngmentTblID" class="table table-stripped table-bordered TMtbl table-hideable"><thead>
                        <tr>
                            <th colspan="3">&nbsp;</th>
                            <th colspan="4" style="text-align: center;">
                                Timeline
                            </th>
                            <th colspan="2">&nbsp;</th>
                        </tr>
                        <tr>
                            <th><%=MyBase.GetResourceString("TaskName") %> </th>
                            <th><%=MyBase.GetResourceString("Priority") %> </th>
                            <th><%=MyBase.GetResourceString("TaskType") %> </th>

                            <th>Plan</th>
                            <th><%=MyBase.GetResourceString("StartDate") %> </th>
                            <th><%=MyBase.GetResourceString("EndDate") %> </th>
                            <th>Work (hours)</th>
                            <th><strong>% Completion</strong></th>
                            <th>Show Baseline</th>

                        </tr>
                    </thead>
                    <tbody id="tblTasks">`
                    // Updated by Dipali V on 14th Nov 2025 for W26 changes - Renamed "Actual % Complete" to "% Completion"
                    // Updated by Dipali V on 14th Nov 2025 for W26 changes - Loop through tasks to build data rows
                    for (var i = 0; i < result.length; i++) {
                        if (i == 0) {
                            TotalActualDecimalWorkHHMM = result[i].TotalActualDecimalWorkHHMM;
                            TotalBaseLineDecimalWorkHHMM = result[i].TotalBaseLineDecimalWorkHHMM;
                            TotalCurrentDecimalWorkHHMM = result[i].TotalCurrentDecimalWorkHHMM;
                        }
                        var StartDate = result[i].CurrentStart;
                        var EndDate = result[i].CurrentEnd;
                        var BaselineStart = result[i].BaseLineStart;
                        var BaselineEnd = result[i].BaseLineEnd;
                        var ActualStartDate = result[i].ActualStart;
                        var ActualEndDate = result[i].ActualEnd;
                        var fromDateRequest = StartDate
                        var toDateRequest = EndDate
                        var BaselineStartRequest = BaselineStart
                        var BaselineEndRequest = BaselineEnd
                        var ActualStartDateRequest = ActualStartDate
                        var ActualEndDateRequest = ActualEndDate


                        // Updated by Dipali V on 14th Nov 2025 for W26 changes - Combined Current, Baseline, Actual into single Timeline TD
                        strHTML += `<tr>
                            <td class="relativeTD">
                                `
                        
                        if (result[i].IsUserStoryTask == true) {
                            strHTML += `<span class="badge badge-info storyLbl">Story</span>`
                        }

                        strHTML += `<a href="javascript:LoadTaskReferences(${result[i].TaskID});" id="taskLabel_${result[i].TaskID}">${result[i].TaskName}</a>
                            </td>
                            <td>${result[i].Priority}</td>
                            <td>${result[i].ModuleName}</td>

                            <td class="timeline-plan-col">
                                <div class="timeline-plan-label current">Current</div>
                                <div class="timeline-plan-label baseline">Baseline</div>
                                <div class="timeline-plan-label actual">Actual</div>
                            </td>
                            <td class="timeline-start-col">
                                <div>${fromDateRequest}</div>
                                <div>${BaselineStartRequest}</div>
                                <div>${ActualStartDateRequest}</div>
                            </td>
                            <td class="timeline-end-col">
                                <div>${toDateRequest}</div>
                                <div>${BaselineEndRequest}</div>
                                <div>${ActualEndDateRequest}</div>
                            </td>
                            <td class="timeline-work-col">
                                <div>${result[i].CurrentDecimalWorkHHMM}</div>
                                <div>${result[i].BaseLineDecimalWorkHHMM}</div>
                                <div>${result[i].ActualDecimalWorkHHMM}</div>
                            </td>
                            <td>
                                <input type="text" placeholder="00.00" class="perceinput" disabled id="actualComplete_${result[i].TaskID}" taskId="${result[i].TaskID}" value="${result[i].ActualPercentComplete}"/>
                                 <input type="hidden" placeholder="00.00" class="perceinputtemp" id="actualComplete_temp_${result[i].TaskID}" taskId="${result[i].TaskID}" value="${result[i].ActualPercentComplete}" />
                              </td>
                            <td><a href="javascript:LoadTaskBaseline(${result[i].TaskID});" >Show Baseline</a></td>
                        </tr>`
                    }
                    // Updated by Dipali V on 14th Nov 2025 for W26 changes - Updated Sum row for combined Timeline view
                    if (result.length != 0)  {
                        strHTML += `
                            <tr>
                            <td>Sum of All Task</td>
                            <td></td>
                            <td></td>

                            <td class="timeline-plan-col">
                                <div class="timeline-plan-label current">Current</div>
                                <div class="timeline-plan-label baseline">Baseline</div>
                                <div class="timeline-plan-label actual">Actual</div>
                            </td>
                            <td class="timeline-start-col">
                                <div></div>
                                <div></div>
                                <div></div>
                            </td>
                            <td class="timeline-end-col">
                                <div></div>
                                <div></div>
                                <div></div>
                            </td>
                            <td class="timeline-work-col">
                                <div>${TotalCurrentDecimalWorkHHMM}</div>
                                <div>${TotalBaseLineDecimalWorkHHMM}</div>
                                <div>${TotalActualDecimalWorkHHMM}</div>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                       `
                    }
                    strHTML += `</tbody></table>`
                }
                // Updated by Dipali V on 14th Nov 2025 for W26 changes - Combined Current, Baseline, Actual into single Timeline TD for General Task view
                else {
                    strHTML += `<table id="TskMngmentTblID" class="table table-stripped table-bordered TMtbl table-hideable"><thead>
                        <tr>
                            <th colspan="3">&nbsp;</th>
                            <th colspan="4" style="text-align: center;">
                                Timeline
                            </th>
                            <th colspan="3">&nbsp;</th>
                        </tr>
                        <tr>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("TaskName") %> </th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("Priority") %> </th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("TaskType") %> </th>

                            <th class="col-sm-1">Plan</th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("StartDate") %> </th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("EndDate") %> </th>
                            <th class="col-sm-1">Work (hours)</th>
                            <th class="col-sm-1">Billable</th>
                            <th class="col-sm-1"><strong>Void</strong></th>
                            <th class="col-sm-1">Show Baseline</th>

                        </tr>
                    </thead>
                    <tbody id="tblTasks">`
                    // Updated by Dipali V on 14th Nov 2025 for W26 changes - Loop through tasks to build data rows for General Task view
                    for (var i = 0; i < result.length; i++) {
                        if (i == 0) {
                            TotalActualDecimalWorkHHMM = result[i].TotalActualDecimalWorkHHMM;
                            TotalBaseLineDecimalWorkHHMM = result[i].TotalBaseLineDecimalWorkHHMM;
                            TotalCurrentDecimalWorkHHMM = result[i].TotalCurrentDecimalWorkHHMM;
                        }
                        var StartDate = result[i].CurrentStart;
                        var EndDate = result[i].CurrentEnd;
                        var BaselineStart = result[i].BaseLineStart;
                        var BaselineEnd = result[i].BaseLineEnd;
                        var ActualStartDate = result[i].ActualStart;
                        var ActualEndDate = result[i].ActualEnd;
                        var startDateArray = StartDate != "" ? StartDate.split(" ") : null;
                        var startDateArraySplit = startDateArray != null ? startDateArray[0].split("-") : null;
                        var fromDateRequestD = startDateArraySplit != null ? new Date(startDateArraySplit[2], parseInt(startDateArraySplit[1]) - 1, startDateArraySplit[0]) : null;
                        var fromDateRequest = fromDateRequestD != null ? fromDateRequestD.getDate() + "-" + months[fromDateRequestD.getMonth()] + "-" + String(fromDateRequestD.getFullYear()).slice(-2) : "";

                        var toDateArray = EndDate != "" ? EndDate.split(" ") : null;
                        var toDateArraySplit = toDateArray != null ? toDateArray[0].split("-") : null;
                        var toDateRequestD = toDateArraySplit != null ? new Date(toDateArraySplit[2], parseInt(toDateArraySplit[1]) - 1, toDateArraySplit[0]) : null;
                        var toDateRequest = toDateRequestD ? toDateRequestD.getDate() + "-" + months[toDateRequestD.getMonth()] + "-" + String(toDateRequestD.getFullYear()).slice(-2) : "";

                        var BaselineStartArray = BaselineStart != "" ? BaselineStart.split(" ") : null;
                        var BaselineStartArraySplit = BaselineStartArray != null ? BaselineStartArray[0].split("-") : null;
                        var BaselineStartRequestD = BaselineStartArraySplit != null ? new Date(BaselineStartArraySplit[2], parseInt(BaselineStartArraySplit[1]) - 1, BaselineStartArraySplit[0]) : null;
                        var BaselineStartRequest = BaselineStartRequestD ? BaselineStartRequestD.getDate() + "-" + months[BaselineStartRequestD.getMonth()] + "-" + String(BaselineStartRequestD.getFullYear()).slice(-2) : "";

                        var BaselineEndArray = BaselineEnd != "" ? BaselineEnd.split(" ") : null;
                        var BaselineEndArraySplit = BaselineEndArray != null ? BaselineEndArray[0].split("-") : null;
                        var BaselineEndRequestD = BaselineEndArraySplit != null ? new Date(BaselineEndArraySplit[2], parseInt(BaselineEndArraySplit[1]) - 1, BaselineEndArraySplit[0]) : null;
                        var BaselineEndRequest = BaselineEndRequestD ? BaselineEndRequestD.getDate() + "-" + months[BaselineEndRequestD.getMonth()] + "-" + String(BaselineEndRequestD.getFullYear()).slice(-2) : "";

                        var ActualStartDateArray = ActualStartDate != "" ? ActualStartDate.split(" ") : null;
                        var ActualStartDateArraySplit = ActualStartDateArray != null ? ActualStartDateArray[0].split("-") : null;
                        var ActualStartDateRequestD = ActualStartDateArraySplit != null ? new Date(ActualStartDateArraySplit[2], parseInt(ActualStartDateArraySplit[1]) - 1, ActualStartDateArraySplit[0]) : null;
                        //var ActualStartDateRequest = ActualStartDateRequestD != null ? ActualStartDateRequestD.getDate() + "-" + months[ActualStartDateRequestD.getMonth()] + "-" + String(ActualStartDateRequestD.getFullYear()).slice(-2) : "";

                        var ActualEndDateArray = ActualEndDate != "" ? ActualEndDate.split(" ") : null;
                        var ActualEndDateArraySplit = ActualEndDateArray != null ? ActualEndDateArray[0].split("-") : null;
                        var ActualEndDateRequestD = ActualEndDateArraySplit != null ? new Date(ActualEndDateArraySplit[2], parseInt(ActualEndDateArraySplit[1]) - 1, ActualEndDateArraySplit[0]) : null;
                        //var ActualEndDateRequest = ActualEndDateRequestD != null ? ActualEndDateRequestD.getDate() + "-" + months[ActualEndDateRequestD.getMonth()] + "-" + String(ActualEndDateRequestD.getFullYear()).slice(-2) : "";

                        // Updated by Dipali V on 14th Nov 2025 for W26 changes - Combined Current, Baseline, Actual into single Timeline TD for General Task view
                        strHTML += `<tr>
                            <td class="relativeTD">`

                        if (result[i].IsUserStoryTask == true) {
                            strHTML += `<span class="badge badge-info storyLbl">Story</span>`
                        }

                        strHTML += `
                                <a href="javascript:LoadTaskReferences(${result[i].TaskID});" id="taskLabel_${result[i].TaskID}">${result[i].TaskName}</a>
                            </td>
                            <td>${result[i].Priority}</td>
                            <td>${result[i].ModuleName}</td>

                            <td class="timeline-plan-col">
                                <div class="timeline-plan-label current">Current</div>
                                <div class="timeline-plan-label baseline">Baseline</div>
                                <div class="timeline-plan-label actual">Actual</div>
                            </td>
                            <td class="timeline-start-col">
                                <div>${fromDateRequest}</div>
                                <div>${BaselineStartRequest}</div>
                                <div>${ActualStartDate}</div>
                            </td>
                            <td class="timeline-end-col">
                                <div>${toDateRequest}</div>
                                <div>${BaselineEndRequest}</div>
                                <div>${ActualEndDate}</div>
                            </td>
                            <td class="timeline-work-col">
                                <div>${result[i].CurrentDecimalWorkHHMM}</div>
                                <div>${result[i].BaseLineDecimalWorkHHMM}</div>
                                <div>${result[i].ActualDecimalWorkHHMM}</div>
                            </td>
                            <td>
                                <input type="checkbox" class='taskBillableChecks' id="billable_${result[i].TaskID}" taskId="${result[i].TaskID}" ${(result[i].BillableYN ? "checked" : "")}/>
                            </td>
                            <td>
                                <input type="checkbox" class='taskVoidChecks' id="void_${result[i].TaskID}" taskId="${result[i].TaskID}" ${(!result[i].IsActive ? "checked" : "")}/>
                            </td>
                            <td><a href="javascript:LoadTaskBaseline(${result[i].TaskID});" >Show Baseline</a></td>
                        </tr>`
                    }
                    // Updated by Dipali V on 14th Nov 2025 for W26 changes - Updated Sum row for combined Timeline view in General Task
                    if (result.length != 0) {
                        strHTML += `
                            <tr>
                            <td>Sum of All Task</td>
                            <td></td>
                            <td></td>

                            <td class="timeline-plan-col">
                                <div class="timeline-plan-label current">Current</div>
                                <div class="timeline-plan-label baseline">Baseline</div>
                                <div class="timeline-plan-label actual">Actual</div>
                            </td>
                            <td class="timeline-start-col">
                                <div></div>
                                <div></div>
                                <div></div>
                            </td>
                            <td class="timeline-end-col">
                                <div></div>
                                <div></div>
                                <div></div>
                            </td>
                            <td class="timeline-work-col">
                                <div>${TotalCurrentDecimalWorkHHMM}</div>
                                <div>${TotalBaseLineDecimalWorkHHMM}</div>
                                <div>${TotalActualDecimalWorkHHMM}</div>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                       `
                    }
                    strHTML += `</tbody></table>`
                }
                // Updated by Dipali V on 14th Nov 2025 for W26 changes - Removed hide/show button logic as all values are always visible
                $("#divMain").html(strHTML);
                // Updated by Dipali V on 14th Nov 2025 for W26 changes - Initialize DataTable with pagination support and scroller
                $('.TMtbl').DataTable({
                    //"ajax": '/api/data',
                    "scrollY": "60vh",
                    "scrollX": true,
                    "scrollCollapse": false,
                    "pageLength": 20,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "paging": true,
                    "bLengthChange": false,

                });
                // Added by Dipali V on 14th Nov 2025 for W26 changes - Ensure sticky header and scroller work after DataTable initialization
                setTimeout(function() {
                    var $thead = $('.TMtbl thead');
                    var $scrollHead = $('#TskMngmentTblID_wrapper .dataTables_scrollHead');
                    var $scrollBody = $('#TskMngmentTblID_wrapper .dataTables_scrollBody');
                    
                    if ($thead.length) {
                        // Make entire thead sticky - both rows will stick together
                        $thead.css({
                            'position': 'sticky',
                            'top': '0',
                            'z-index': '1000',
                            'background-color': '#fff'
                        });
                        
                        // Ensure all header cells have background
                        $thead.find('th').css({
                            'background-color': '#f8f9fa'
                        });
                    }
                    
                    if ($scrollHead.length) {
                        $scrollHead.css({
                            'position': 'sticky',
                            'top': '0',
                            'z-index': '1000',
                            'background-color': '#fff'
                        });
                    }
                    
                    // Ensure scrollBody is properly configured
                    if ($scrollBody.length) {
                        $scrollBody.css({
                            'max-height': '60vh',
                            'overflow-y': 'auto'
                        });
                    }
                    
                    // Added by Dipali V on 14th Nov 2025 for W26 changes - Adjust column widths to ensure alignment
                    var table = $('.TMtbl').DataTable();
                    if (table) {
                        // Use DataTables API to adjust columns
                        table.columns.adjust();
                        // Force a redraw to ensure alignment
                        setTimeout(function() {
                            table.columns.adjust().draw(false);
                        }, 50);
                    }
                    
                    // Force reflow to ensure styles are applied
                    if ($thead.length && $thead[0]) {
                        $thead[0].offsetHeight;
                    }
                }, 200);
                //$(".TMtbl").resize();

            });
        }

        function isJson(str) {
            try {
                JSON.parse(str);
            } catch (e) {
                return false;
            }
            return true;
        }

        function encryptString(value) {
            var intStrArr;
            intStrArr = [];
            var strEncryptedString = "";
            var intEncryptNum = 1;
            var i;
            if (String(value).length > 0) {
                for (i = 0; i <= value.length - 1; i++) {
                    intStrArr[i] = String(String(String(value[i])).charCodeAt(0) + intEncryptNum);
                    intEncryptNum = intEncryptNum + 2;
                }
                strEncryptedString = intStrArr.join("-");
                if (String(strEncryptedString).substring(0, 1) == "-") {
                    strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1)
                }
            }
            return strEncryptedString;
        }
        //datatable
        //$('.TMtbl').dataTable({
        //    //"ajax": '/api/data',
        //    "scrollY": true,
        //    "scrollX": true,
        //    //"scroller": true,
        //    "pageLength": 5,
        //    "lengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "responsive": true
        //});

        //$('.tmselectTaskModaltbl').dataTable({
        //    "scrollY": 200,
        //    "scrollX": true,
        //    //"scroller": true,
        //    //"pageLength": 5,
        //    "paging": false,
        //    "info": false,
        //    "lengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "responsive": true

        //});


        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        $(document).on('draw.dt', function () {
            $('table').resize();
        });
        $('table').on('page.dt', function () {
            $(".TMtbl").resize();
        });

        $('#TMOthertaskmodal').on('shown.bs.modal', function () {
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        })


        function resizeSection() {
            if ($(this).height() <= 800) {
                $('.dataTables_scrollBody').css('max-height', '190px'); //set max height
            } else {
                $('.dataTables_scrollBody').css('max-height', ''); //delete attribute
            }
        }
        $(window).on("load resize", function (e) {
            resizeSection(this);
            //dtalign(this);
            $(".TMtbl").resize();

        });

        //hide profitability information
        //$(".hideinfoicon").click(function () {
        //    $(".colapsibleinfopanel").fadeOut('fast');
        //});

        $('.statustext li a').click(function () {
            //$("#TMinfoCollapseOne").collapse('hide');

            $('html, body').animate({
                scrollTop: $(".TMtbl").offset().top -= 200
            }, 500);
        });

        //$('.statustext li a').on("click", function () {
        //    $('html, body').animate({ scrollTop: -500 }, 'slow', function () {
        //        alert("reached top");
        //    });
        //});


        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
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
        //$('#TskinfoModalSD, #TskinfoModalSD, #statuschangedate1').datepicker({
        //    autoclose: true,
        //    changeMonth: true,
        //    changeYear: true,
        //    dateFormat: 'dd MM yy'
        //});


        $(".table .tdCurrent").toggleClass("hidecol", "");
        $(".table .tdbaseline").toggleClass("hidecol", "");
        $(".table .tdactual ").toggleClass("hidecol", "");

        $('body').tooltip({
            selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
        });

        //Start script for Task Management table


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

        function toggleIcon(e) {
            $(e.target)
                .prev('.panel-heading')
                .find(".infoToggler")
                .toggleClass('togglerdown togglerup');

        }
        $('.panel-group').on('hidden.bs.collapse', toggleIcon);
        $('.panel-group').on('shown.bs.collapse', toggleIcon);
    </script>
</body>
</html>
