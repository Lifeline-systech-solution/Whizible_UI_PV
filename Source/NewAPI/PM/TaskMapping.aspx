<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TaskMapping.aspx.vb" Inherits="Whizible.TaskMapping" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Task Mapping")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="robots" content="noindex">
    <title>Task Mapping</title>
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
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css"/>--%>

</head>

    <style>
        /*        CSS added by Madhuri.K Start here*/
        .btn {
            padding: 5px 13px;
        }

        .panel-default > .panel-heading a {
    color: #1359a6;
    display:block;
}
/*        CSS added by Madhuri.K End here*/
        .filterpanelbody {padding:30px 0;}
        .btn-condensed.btn-condensed {
            padding: 0 5px;
            box-shadow: none;
        }
        /* use class to have a little animation */
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
            min-width: 100px;
            vertical-align: middle !important
        }

            .TMtbl td .fa-eye-slash, .TMtbl th .fa-eye-slash {
                display: block
            }

            .TMtbl td .fa-eye, .TMtbl th .fa-eye {
                display: none
            }

            .TMtbl td.hidecol .fa-eye-slash, .TMtbl th.hidecol .fa-eye-slash {
                display: none
            }

            .TMtbl td.hidecol .fa-eye, .TMtbl th.hidecol .fa-eye {
                display: block;
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

        .hidecol:nth-child(4n) {
            border-right: 1px solid #ddd !important
        }

        .tdCurrent[colspan="4"], .tdbaseline[colspan="4"], .tdactual[colspan="4"] {
            border-right: 1px solid #ddd !important
        }

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

        #TMOthertaskmodal .table-responsive {
            max-height: 400px
        }

        .custmodal .custom_chckbox label:before {
            border-color: #464a4c
        }

        .filterpanel .filterpanelheader {
            border-top: 1px solid #eee
        }

        .toplinks {
            border-top: 1px solid #eee;
            background: #fafafa;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            margin-bottom: 20px
        }

        .clearfieldlink {
            cursor: pointer;
            background: #f5f5f5
        }

            .clearfieldlink .far {
                font-size: 16px
            }

        h5.headertopp {
            margin: 4px 0 0;
            font-size: 16px;
            font-weight: 500
        }

        .push {
            margin-left: auto
        }

        .input-group .input-group-addon {
            background: #f5f5f5
        }

        /*.graybg.container-fluid.pt-1.pb-1.statckmainheader {
            background: #4263c1;
            color: #fff
        }*/

        span.badge.tskcount {
            font-weight: 400
        }

        #Qtext {
            margin-bottom: 10px
        }
        /*Task Maping css end here*/
        .ajs-message {
            color: #fff
        }

        .requiredfield {
            border-color: red
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
        .tskcount{
            cursor:pointer;
        }
label.control-label {
    font-weight: 500;
}
/*collapsibleinfopanel-end*/
.ui-datepicker td span, .ui-datepicker td a {padding: 0.55em;}
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
#divMain {
            /* Modified By Madhuri.K On 26-03-2026 */
                font-size: 11.5px !important;
 }
        .pgtitle {
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
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <div class="graybg container-fluid pt-1 pb-1 statckmainheader">
            <div class="row">
                <div class="col-sm-3">
                    <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("WINDOW_TITLE") %></h5>
                </div>
                <div class="col-sm-9 form-inline text-end">
                </div>

            </div>
        </div>
    <form id="frmTaskDetails">
        <div class="bgwhite">
            <section class="content pt-0 clearfix">
                <div class="row">
                    <div class="pt-1 pb-1 text-end col-sm-12">
                        <div class="push">
                            <a  class="btn borderbtn" onclick="Back_onclick()">Back</a>
                            <a href="javascript:ClearAll_OnClick();" class="btn borderbtn">Clear All</a>
                            <a href="javascript:SelectAll_OnClick();" class="btn borderbtn">Select All</a>
                            <%--<a href="javascript:Save_OnClick();" class="btn btnyellow">Save</a>--%>
                            <a href="javascript:Save_OnClick();" class="btn btn-primary-action"><i class="fas fa-save"></i> Save</a>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>

                <!--build query start here-->
                <div class="panel-group colapsibleinfopanel mt-0" id="accordion1" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default panel-horizontal lightgraybg">
                        <div class="panel-heading" role="tab" id="TMappinginfoHeadingOne">
                              <!-- Added/Commented By Madhuri.K On 27-Aug-2024 For Alignment Issue Start here-->
                        <h4 class="panel-title">
                                <a role="button" data-bs-toggle="collapse" data-bs-parent="#accordion1" href="#TMappinginfoCollapseOne" aria-expanded="true" aria-controls="collapseOne">

                                    Build Query
                                
                                    <span class="infoToggler togglerup float-end">
                                        <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                        <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                    </span>
                                    </a>
                            </h4>
                            <!-- Added/Commented By Madhuri.K On 27-Aug-2024 For Alignment Issue End here-->
                        </div>

                        <div id="TMappinginfoCollapseOne" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="TMappinginfoHeadingOne">
                            <div class="panel-body">

                                <div class="bqueryform">
                                    <div class="form-group mb-3">
                                        <div class="row">
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label class="control-label">Field</label>
                                                <select id="cboFieldName" name="cboFieldName" class="form-select" onchange="Field_OnChange()">
                                                    <option value=""></option>
                                                    <option title="Task Name" value="TaskName">Task Name</option>
                                                    <option title="Start Date" value="StartDate">Start Date</option>
                                                    <option title="End Date" value="EndDate">End Date</option>
                                                    <option title="Which Task" value="WhichTask">Which Task</option>
                                                    <option title="Task Type" value="TaskType">Task Type</option>
                                                    <option title="Phase" value="Phase">Phase</option>
                                                    <option title="Module" value="Module">Module</option>
                                                    <option title="Sub Project" value="SubProject">Sub Project</option>
                                                    <option title="Milestone" value="Milestone">Milestone</option>
                                                    <option title="Deliverable" value="DeliverableName">Deliverable</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label class="control-label">Operator</label>
                                                <select id="cboOperator" name="cboOperator" class="form-select">
                                                    <option value=""></option>
                                                    <option title="=" value="=">=</option>
                                                    <option title="<" value="<">&lt;</option>
                                                    <option title=">" value=">">&gt;</option>
                                                    <option title="<>" value="<>">&lt;&gt;</option>
                                                    <option title="<=" value="<=">&lt;=</option>
                                                    <option title=">=" value=">=">&gt;=</option>
                                                    <option title="NOT LIKE" value="NOT LIKE">NOT LIKE</option>
                                                    <option title="LIKE" value="LIKE">LIKE</option>
                                                    <option title="IS" value="IS">IS</option>
                                                    <option title="IS NOT" value="IS NOT">IS NOT</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <div class="form-group" id="TDFieldValue">
                                                <label class="control-label">Value</label>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtValue", "txtValue", "form-control", , 100, , , , , , , , , , EnableHTMLEncode:=True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPhase", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboSubproject", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboMilestone", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboResources", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboFeature", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboDeliverable", "Select ''", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboWhichTask", "Exec usp_sel_ProjectTasks_TaskTypes 1", , , , True, , "form-control", , , True) %>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control", , 100, , , , , , , , , , , , , True, EnableHTMLEncode:=True) %>
                                                <%CommonFunctions.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", "form-control", , 12, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
                                                    CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 12, , , , , , , , , , , , , True, EnableHTMLEncode:=True)%>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="clearfix">
                                                    <div class="btn-group btn-group-sm" role="group">
                                                        <button type="button" class="btn btn-default" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Append the current condition" onclick="Append_OnClick()">Append</button>
                                                        <button type="button" class="btn btn-default AppendbracketLeft" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Appends (" onclick="Bracket_OnClick('(')">(</button>
                                                        <button type="button" class="btn btn-default AppendbracketRight" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Appends )" onclick="Bracket_OnClick(')')">)</button>
                                                        <button type="button" class="btn btn-default AppendAndText" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Appends AND" onclick="Operator_OnClick('AND')">AND</button>
                                                        <button type="button" class="btn btn-default AppendOrText" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Appends OR" onclick="Operator_OnClick('OR')">OR</button>
                                                        <!--<button type="button" class="btn btn-default"><i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="body" data-original-title="Click here to Clear"></i></button>-->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                                                                
                                        <div class="clearfix"></div>
                                    </div>

                                    </div>
                                    

                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-12">
                                            <label class="control-label">Query Text</label>
                                            <textarea id="txtQueryText" style="min-height: 100px;" class="form-control mb-2" disabled></textarea>
                                            <div class="btn-group btn-group-sm float-end" role="group">
                                                <button type="button" class="btn btn-default" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Execute" onclick="Execute_OnClick()">Execute</button>
                                                <button id="btRndo" type="button" class="btn btn-default" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Redo" onclick="Redo_OnClick()">Redo</button>
                                                <button id="btUndo" type="button" class="btn btn-default" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-title="Undo" onclick="Undo_OnClick()">Undo</button>
                                                <button type="button" class="btn btn-default" onclick="Clear_OnClick()"><i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i></button>
                                            </div>
                                        </div>
                                        </div>
                                    </div>


                                </div>


                            </div>
                        </div>


                    </div>
                </div>
                <!--build query end here-->


                <!--map selected task start from here-->
                <div class="panel-group colapsibleinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default panel-horizontal lightgraybg">
                        <div class="panel-heading" role="tab" id="TMappinginfoHeadingTwo">
                           <!-- Added/Commented By Madhuri.K On 27-Aug-2024 For Alignment Issue Start here-->
                           <h4 class="panel-title">
                                <a role="button" data-bs-toggle="collapse" data-bs-parent="#accordion" href="#TMappinginfoCollapseTwo" aria-expanded="true" aria-controls="collapseOne">
                                    Map for the selected tasks
                               <span class="infoToggler togglerup float-end">
                                        <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                        <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                               </span>
                                </a>
                            </h4>
                             <!-- Added/Commented By Madhuri.K On 27-Aug-2024 For Alignment Issue End here-->
                        </div>

                        <div id="TMappinginfoCollapseTwo" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="TMappinginfoHeadingTwo">
                            <div class="panel-body">

                                <div class="">

                                    <div class="row mb-3">
                                        <div class="col-sm-4">
                                            <label class="control-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("LINK_COUNT_TASKTYPE_TOOLTIP")%>"><%=MyBase.GetResourceString("CAP_TASK_TYPE") %> <span class="badge bg-secondary tskcount" id="taskTypeCount" onclick="Count_OnClick('MODULENAME')" >05</span>&nbsp;<a id="taskTypeClear" href="Javascript:ClearOnClick('MODULENAME')" >Clear</a></label>
                                            <div class="input-group form-group" >
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboTaskType1", "Select ''", , , , , , "form-select selectpicker", , , ) %>
                                                <span class="input-group-addon clearfieldlink" style="visibility:hidden">
                                                    <i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="col-sm-4" id="divModule">
                                            <label class="control-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("LINK_COUNT_MODULE_TOOLTIP")%>"><%=MyBase.GetResourceString("CAP_MODULE") %> <span class="badge bg-secondary tskcount" id="moduleCount" onclick="Count_OnClick('MODULE')">15</span>&nbsp;<a id="moduleClear" href="Javascript:ClearOnClick('MODULE')" >Clear</a></label>
                                            <div class="input-group form-group">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboModule1", "Select ''", , , , , , "form-select selectpicker", , , ) %>
                                                <span class="input-group-addon clearfieldlink" style="visibility:hidden">
                                                    <i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="col-sm-4"  id="divMilestone">
                                            <label class="control-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("LINK_COUNT_MILESTONE_TOOLTIP")%>"><%=MyBase.GetResourceString("CAP_MILESTONE") %>  <span class="badge bg-secondary tskcount" id="milestoneCount" onclick="Count_OnClick('MILESTONE')">25</span>&nbsp;<a id="milestoneClear" href="Javascript:ClearOnClick('MILESTONE')" >Clear</a></label>
                                            <div class="input-group form-group">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboMilestone1", "Select ''", , , , , , "form-select selectpicker", , , ) %>
                                                <span class="input-group-addon clearfieldlink" style="visibility:hidden">
                                                    <i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i>
                                                </span>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-sm-4"  id="divPhase">
                                            <label class="control-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("LINK_COUNT_PHASE_TOOLTIP")%>"><%=MyBase.GetResourceString("CAP_PHASE") %>  <span class="badge bg-secondary tskcount" id="phaseCount" onclick="Count_OnClick('PHASE')">31</span>&nbsp;<a id="phaseClear" href="Javascript:ClearOnClick('PHASE')" >Clear</a></label>
                                            <div class="input-group form-group">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboPhase1", "Select ''", , , , , , "form-select selectpicker", , , ) %>
                                                <span class="input-group-addon clearfieldlink" style="visibility:hidden">
                                                    <i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="col-sm-4" id="divSubProject">
                                            <label class="control-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("LINK_COUNT_SUBPROJECT_TOOLTIP")%>"><%=MyBase.GetResourceString("CAP_SUBPROJECT") %> <span class="badge bg-secondary tskcount" id="subProjectCount" onclick="Count_OnClick('SUBPROJECT')">34</span>&nbsp;<a id="subProjectClear" href="Javascript:ClearOnClick('SUBPROJECT')" >Clear</a></label>
                                            <div class="input-group form-group">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboSubproject1", "Select ''", , , , , , "form-select selectpicker", , , ) %>
                                                <span class="input-group-addon clearfieldlink" style="visibility:hidden">
                                                    <i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="col-sm-4"  id="divFeature">
                                            <label class="control-label"  data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("LINK_COUNT_FEATURE_TOOLTIP")%>"><%=MyBase.GetResourceString("CAP_FEATURES") %> <span class="badge bg-secondary tskcount" id="featureCount" onclick="Count_OnClick('PROJECTFEATUREID')">21</span>&nbsp;<a id="featureClear" href="Javascript:ClearOnClick('PROJECTFEATUREID')" >Clear</a></label>
                                            <div class="input-group form-group">
                                                 <%CommonFunctions.HTMLControls.DrawComboBox("cboFeature1", "Select ''", , , , , , "form-select selectpicker", , , ) %>
                                                <span class="input-group-addon clearfieldlink" style="visibility:hidden">
                                                    <i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="col-sm-4">
                                            <label class="control-label"  data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("LINK_COUNT_DELIVERABLE_TOOLTIP")%>"><%=MyBase.GetResourceString("CAP_DELIVERABLES") %> <span class="badge bg-secondary tskcount" id="deliverableCount" onclick="Count_OnClick('DELIVERABLEID')">21</span>&nbsp;<a id="deliverableClear" href="Javascript:ClearOnClick('DELIVERABLEID')" >Clear</a></label>
                                            <div class="input-group form-group">
                                                 <%CommonFunctions.HTMLControls.DrawComboBox("cboDeliverable1", "Select ''", , , , , , "form-select selectpicker", , , ) %>
                                                <span class="input-group-addon clearfieldlink" style="visibility:hidden">
                                                    <i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Clear"></i>
                                                </span>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                            </div>
                        </div>


                    </div>
                </div>
                <hr />

                <div class="table-responsive" id="divMain">
                    <table class="table table-stripped table-bordered taskmappingtbl" style="width: 100%;" id="tblTask"><thead>
                            <tr>
                                <th>Task Name</th>
                                <th><%=MyBase.GetResourceString("CAP_TASK_TYPE") %></th>
                                <th><%=MyBase.GetResourceString("CAP_PHASE") %> </th>
                                <th><%=MyBase.GetResourceString("CAP_MODULE") %></th>
                                <th><%=MyBase.GetResourceString("CAP_SUBPROJECT") %></th>
                                <th><%=MyBase.GetResourceString("CAP_MILESTONE") %></th>
                                <th><%=MyBase.GetResourceString("CAP_DELIVERABLES") %></th>
                                <th>Apply</th>
                            </tr>
                        </thead><tbody>
                            </tbody>
                    </table>
                </div>

                <div class="modal custmodal  fade" id="ClearModal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Confirm</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive" >
                    <label class="label" id="lblClear"></label>
                    </div>
                    <br />

                    <div class="text-center">
                        <button class="btn btnyellow" type="button" onclick="ClearSave_OnClick()">Ok</button>
                        <button class="btn borderbtn" type="button" data-bs-dismiss="modal">Cancel</button>
                    </div>

                </div>
                <!-- /.content -->
                <div class="clearfix"></div>
            </div>

        </div>
    </div>
            </section>
        </div>
    </form>
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
    <script src="Common.js"></script>
    <script>
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
        let GetTaskReferences = "/api/TaskMapping/GetTaskReferences";
        let ExecuteTaskMapping = "/api/TaskMapping/ExecuteTaskMapping";
        let SaveTaskDetails = "/api/TaskMapping/SaveTaskDetails";
        $("[data-bs-toggle='tooltip']").tooltip();
        var objValue = document.getElementById('txtValue')
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

        $(document).ready(function () {
            LoadTaskReferences();
            $('#txtStartDate, #txtEndDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:c+100',
                dateFormat: 'dd M yy'
            });
        })

        function toggleIcon(e) {
            $(e.target)
                .prev('.panel-heading')
                .find(".infoToggler")
                .toggleClass('togglerdown togglerup');
        }
        $('.panel-group').on('hidden.bs.collapse', toggleIcon);
        $('.panel-group').on('shown.bs.collapse', toggleIcon);


        //datepicker
        $('#TskinfoModalSD, #TskinfoModalSD, #statuschangedate1').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });


        //Start script for Task Management table
        $("#click-me-current").click(function () {
            $(".table .tdCurrent").toggleClass("hidecol");
        });

        $("#click-me-baseline").click(function () {
            $(".table .tdbaseline").toggleClass("hidecol");
        });
        $("#click-me-actual").click(function () {
            $(".table .tdactual ").toggleClass("hidecol");
        });

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

        //script for Clear value in query text
        function clearquerytext() {
            $('#Qtext').text('');

        }
        var strMode = "RUN"
        var intBracketCount = 0;
        function ExecuteTaskMappingFun(mode, SelectedValue, Execute, ColumnName) {
            strMode = mode;
            var executeInputParameters = {
                Mode: mode,
                ProjectID: ProjectId,
                SelectedValue: SelectedValue,
                Execute: Execute,
                WhereClause: $("#txtQueryText").val(),
                Alphabet: "-1",
                ColumnName: ColumnName,
                OrderBy: "TaskName",
                SortOrder:"ASC"
            }
            var param = JSON.stringify(executeInputParameters);
            //Commented and added by Riddhesh Patil on 15 May 2023
            //AJAXCallWithResult(ExecuteTaskMapping, param, true, "POST", function (result) {
            AJAXCallWithResult1(ExecuteTaskMapping, param, true, "POST", function (result) {
            //End of Commented and added by Riddhesh Patil on 15 May 2023
                console.log(result);
                var strHTML = (mode == "RUN" ? `<table class="table table-stripped table-bordered taskmappingtbl" style="width: 100%;" id="tblTask"><thead>
                            <tr>
                                <th>Task Name</th>
                                <th><%=MyBase.GetResourceString("CAP_TASK_TYPE") %></th>
                                <th><%=MyBase.GetResourceString("CAP_PHASE") %> </th>
                                <th><%=MyBase.GetResourceString("CAP_MODULE") %></th>
                                <th><%=MyBase.GetResourceString("CAP_SUBPROJECT") %></th>
                                <th><%=MyBase.GetResourceString("CAP_MILESTONE") %></th>
                                <th><%=MyBase.GetResourceString("CAP_DELIVERABLES") %></th>
                                <th>Apply</th>
                            </tr>
                        </thead><tbody>
                        ` : `<table class="table table-stripped table-bordered taskmappingtbl" style="width: 100%;" id="tblTask"><thead>
                            <tr>
                                <th>Task Name</th>
                                <th>Apply</th>
                            </tr>
                        </thead><tbody>`)

                for (var i = 0; i < result.length; i++) {
                    strHTML += (mode == "RUN" ? `
                            <tr>
                                <td>${result[i].TaskName}</td>
                                <td>${(result[i].ModuleName ? result[i].ModuleName : "")}</td>
                                <td>${(result[i].PhaseId && result[i].Phase ? result[i].Phase : "")}</td>
                                <td>${(result[i].ModuleId && result[i].Module? result[i].Module : "")}</td>
                                <td>${(result[i].SubProjectId && result[i].SubProject? result[i].SubProject : "")}</td>
                                <td>${(result[i].MileStoneId && result[i].Milestone? result[i].Milestone : "")}</td>
                                <td>${(result[i].DeliverableID && result[i].DeliverableName ? result[i].DeliverableName : "")}</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input type="checkbox" name="chkApply" id="TPcheck${result[i].TaskID}" value="${result[i].TaskID}">
                                        <label name="TMbillablechk1" for="TPcheck${result[i].TaskID}"></label>
                                    </div>
                                </td>
                            </tr>
                        `: `
                            <tr>
                                <td>${result[i].TaskName}</td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input type="checkbox" name="chkApply" id="TPcheck${result[i].TaskID}" value="${result[i].TaskID}" >
                                        <label name="TMbillablechk1" for="TPcheck${result[i].TaskID}"></label>
                                    </div>
                                </td>
                            </tr>
                        `);
                }
                if (result.length == 0) {
                    strHTML += (mode == "RUN" ? `
                            <tr>
                                <td colspan=8 style='text-align:center'>No Records.</td>
                                <td style='display:none'></td>
                                <td style='display:none'></td>
                                <td style='display:none'></td>
                                <td style='display:none'></td>
                                <td style='display:none'></td>
                                <td style='display:none'></td>
                                <td style='display:none'></td>
                            </tr>
                        `: `
                            <tr>
                                <td colspan=2 style='text-align:center'>No Records.</td>
<td style='display:none'></td>
                            </tr>
                        `)
                }
                strHTML += `</tbody></table>`

                
                $("#divMain").html(strHTML);
                $('.taskmappingtbl').DataTable({
                    //"scrollY": true,
                    //"scrollX": true,
                    "pageLength": 20,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "responsive": true

                });
            });
        }

        //Added By Riddhesh Patil on 15 May 2023 for Invalid Query Alert
        function AJAXCallWithResult1(url, param, async, type, callback) {
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
                   
                    if (jqXHR.responseText.indexOf("Incorrect") > -1)
                    {
                        alertify.error("Invalid Query");
                    }
                    
                }
            });
            return ajaxResult;
        }
        //End of Added By Riddhesh Patil on 15 May 2023 for Invalid Query Alert
        function SelectAll_OnClick() {
            var objChk, objTxt;
            var intCnt, i;

            objChk = document.getElementsByName("chkApply")
            for (i = 0; i < objChk.length; i++)
                objChk[i].checked = true;
        }
        function ClearAll_OnClick() {
            var objChk, objTxt;
            var intCnt, i;

            objChk = document.getElementsByName("chkApply")
            for (i = 0; i < objChk.length; i++)
                objChk[i].checked = false;
        }

        function AppendQueryText() {

            var valid = true,
                message = '';

            $('form input, form select').each(function () {
                var $this = $(this);

                if (!$this.val()) {
                    var inputName = $this.attr('name');
                    valid = false;
                    message += 'Please enter your ' + inputName + '<br/>';
                    //alertify.error('Please enter your');

                }
            });

            if (!valid) {
                //alert(message);
                //$('#fieldname, #operator, #value').addClass("requiredfield");
                alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                alertify.error(message);
            }
            if (valid) {
                //$('#fieldname, #operator, #value').removeClass("requiredfield");
                //alert('Successful');
                alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                alertify.success('Successful');

                //$("#Qtext").text("");
                var selectfield = $("#fieldname").val();
                var operator = $("#operator").val();
                var txtValue = $("#value").val();


                $("#Qtext").append("" + selectfield + ' ' + operator + ' ' + txtValue + "");

            }

        }




        //AppendbracketLeft and AppendbracketRight
        function AppendbracketLeft() {

            $('#Qtext').append($(".AppendbracketLeft").text());
            $('#Qtext:contains("(")').append("&nbsp;&nbsp;");
        }
        function AppendbracketRight() {
            $('#Qtext').append($(".AppendbracketRight").text());
            //$('#Qtext').append("&nbsp;");
            $('#Qtext:contains(")")').append("&nbsp;&nbsp;");
        }

        function AppendAnd() {
            $('#Qtext').append($(".AppendAndText").text());
            $('#Qtext:contains("AND")').append("&nbsp;&nbsp;");
        }
        function AppendOR() {
            $('#Qtext').append($(".AppendOrText").text());
            $('#Qtext:contains("OR")').append("&nbsp;&nbsp;");
        }



        //$('.taskmappingtbl').DataTable({
        //    "scrollY": true,
        //    "scrollX": true,
        //    "pageLength": 5,
        //    "lengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "responsive": true

        //});




        function dtalign() {
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        }

        function resizeSection() {
            if ($(this).height() <= 800) {
                $('.dataTables_scrollBody').css('max-height', '250px'); //set max height
            } else {
                $('.dataTables_scrollBody').css('max-height', ''); //delete attribute
            }
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            dtalign(this);
        });
        
        function Field_OnChange() {
            //debugger;
            var objCbo;
            var strField;
            try {
                objCbo = document.getElementById('cboFieldName');
                strField = new String(objCbo.value);

                objValue.style.display = 'none';

                objValue = null;

                if (strField.toUpperCase() == 'USERNAME')
                    objValue = document.getElementById('cboResources');
                else if (strField.toUpperCase() == 'WHICHTASK')
                    objValue = document.getElementById('cboWhichTask');
                else if (strField.toUpperCase() == 'TASKTYPE')
                    objValue = document.getElementById('cboTaskType');
                else if (strField.toUpperCase() == 'PHASE')
                    objValue = document.getElementById('cboPhase');
                else if (strField.toUpperCase() == 'MODULE')
                    objValue = document.getElementById('cboModule');
                else if (strField.toUpperCase() == 'SUBPROJECT')
                    objValue = document.getElementById('cboSubproject');
                else if (strField.toUpperCase() == 'MILESTONE')
                    objValue = document.getElementById('cboMilestone');
                else if (strField.toUpperCase() == 'PROJECTFEATUREID')
                    objValue = document.getElementById('cboFeature');
                else if (strField.toUpperCase() == 'STARTDATE') {

                    objValue = document.getElementById('txtStartDate');
                }
                else if (strField.toUpperCase() == 'ENDDATE') {
                    objValue = document.getElementById('txtEndDate');
                }
                else if (strField.toUpperCase() == 'TASKNAME')
                    objValue = document.getElementById('txtTaskName');
                //Added by HarshK for sp4 issueid 200
                else if (strField.toUpperCase() == 'DELIVERABLENAME')
                    objValue = document.getElementById('cboDeliverable');
                //End Added by HarshK for sp4 issueid 200
                else
                    objValue = document.getElementById('txtValue');
                objValue.style.display = '';
                var objTD;
                objTD = document.getElementById('TDFieldValue');
                //objTD.innerHTML="";
                objTD.appendChild(objValue);
                /* End Modification By NitinVS on  3 Dec 2005 for Editable Date Control Problem IssueID 672 */
            }
            catch (e) { }
        }

        function GetObjectReference(frm, obj,flag) {
            return (flag == true ? document.getElementById(obj) : document.getElementsByName(obj));
        }
        function disallowBlank(obj, msg) {
            if (obj.value == "") {
                alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                alertify.error(msg);
                return true;
            }
            return false;
        }
        function disallowBlankCombo(obj, msg) {
            if (!obj.find("option:selected").val() || obj.find("option:selected").val() == 0) {
                if (msg != "") {
                    alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                    alertify.error(msg);
                }
                return true;
            }
            return false;
        }
        var blnAndOrSelected = true;
        function Append_OnClick() {
            var obj, flag, strField;
            var strValue, strQuery, objTxt;
            obj = document.getElementById('cboFieldName');
            flag = disallowBlank(obj, '<%=MyBase.GetResourceString("MSG_FIELD_EMPTY")%>', true);
            if (flag == true)
                return;

            strField = obj.value;

            obj = document.getElementById('cboOperator');
            flag = disallowBlank(obj, '<%=MyBase.GetResourceString("MSG_OPERATOR_EMPTY")%>', true);
            if (flag == true)
                return;

            strValue = new String(objValue.value);
            //if(strValue.indexOf("'")>=0)
            strValue = String(strValue).replace("'", "''");
            //Added By Usha Pandit On 19.02.2021 For correct query execution
            if (strField == "StartDate") {
                strValue = $("#txtStartDate").val();
            }
            if (strField == "EndDate") {
                strValue = $("#txtEndDate").val();
            }
            //End Of Added By Usha Pandit On 19.02.2021 For correct query execution
            if (obj.value == 'LIKE' || obj.value == 'NOT LIKE')
                strValue = '%' + strValue + '%';

            if (objValue.value == "NULL")
                strValue = "NULL";
            else
                strValue = "'" + strValue + "'";

            strQuery = strField + ' ' + obj.value + ' ' + strValue;

            if (blnAndOrSelected == false) {
                alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                alertify.error('<%=MyBase.GetResourceString("MSG_JOIN_CONDITION")%>');
                return;
            }

            blnAndOrSelected = false;
            intBracketCount = 0;

            objTxt = document.getElementById('txtQueryText');
            //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
            //strUnDoValue = objTxt.innerHTML;
            //objTxt.innerHTML += strQuery; 
            strUnDoValue = objTxt.innerHTML;
            objTxt.innerHTML += strQuery;
            //End Modification

        }
        function Bracket_OnClick(strBkt) {
            if (strBkt == '(') {
                if (blnAndOrSelected == false) {
                    alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                    alertify.error('<%=MyBase.GetResourceString("MSG_JOIN_CONDITION")%>');
                    return;
                }

                intBracketCount += 1;
            }
            else if (strBkt == ')') { intBracketCount -= 1; }

            var objTxt;
            objTxt = document.getElementById('txtQueryText');
            //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
            //strUnDoValue = objTxt.innerHTML;
            //objTxt.innerHTML += ' ' + strBkt + ' ';				
            strUnDoValue = objTxt.innerHTML;
            objTxt.innerHTML += ' ' + strBkt + ' ';
            //End Modification

        }
        function Operator_OnClick(strOp) {
            var objTxt;
            objTxt = document.getElementById('txtQueryText');
            //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
            //strUnDoValue = objTxt.innerHTML;
            //objTxt.innerHTML += ' ' + strOp + ' ';

            strUnDoValue = objTxt.innerHTML;
            objTxt.innerHTML += ' ' + strOp + ' ';
            //End Modification
            blnAndOrSelected = true;
        }

        function Clear_OnClick() {
            var objTxt;
            objTxt = document.getElementById('txtQueryText');
            //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
            //strUnDoValue = objTxt.innerHTML;
            //objTxt.innerHTML = '';
            strUnDoValue = objTxt.innerHTML;
            objTxt.innerHTML = '';
            //End modification	
            blnAndOrSelected = true;
            intBracketCount = 0;
            strReDoValue = '';
        }
        var strReDoValue = '';
        function Redo_OnClick() {
            var objTxt;

            if (blnReDoFlag == true) {
                objTxt = document.getElementById('txtQueryText');
                //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                //strUnDoValue=objTxt.innerHTML;
                //objTxt.innerHTML = strReDoValue;
                strUnDoValue = objTxt.innerHTML;
                objTxt.innerHTML = strReDoValue;
                //End Modification
                blnReDoFlag = false;
            }
        }
        function Undo_OnClick() {
            var objTxt;
            objTxt = document.getElementById('txtQueryText');

            //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
            //if(Trim(objTxt.innerHTML)!='')
            if (String(objTxt.innerHTML).trim() != '') {
                //strReDoValue = objTxt.innerHTML;
                strReDoValue = objTxt.innerHTML;
                //End Modification
                blnReDoFlag = true;
                //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                //objTxt.innerHTML = strUnDoValue;
                objTxt.innerHTML = strUnDoValue;
                //End Modification
                strUnDoValue = '';
                blnAndOrSelected = true;
                intBracketCount = 0;
            }
        }

        function Execute_OnClick() {
            var objTxt, flag;
            if (intBracketCount > 0) {
                alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                alertify.error('<%=MyBase.GetResourceString("MSG_BRACKET_OPEN")%>');
                return;
            }
            //if (m_blnIsValidQuery == "false") {
            //    alertify.set('notifier', 'position', 'top-right', 'color', 'white');
            //    alertify.error('invalid');
            //    return;
            //}

            objTxt = document.getElementById('txtQueryText');
            flag = disallowMaxlengthViolation(objTxt, 7000, '<%=MyBase.GetResourceString("MSG_QUERY_MAX_LENGTH")%>')
            if (flag == true) {
                objValue.focus();
                return;
            }

            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
            //setFrameLoader();
            //End of Addition by Dhanashri S on 12 Oct 2016
            ExecuteTaskMappingFun("RUN", "", "EXECUTE", "");
                        <%--objform.action = "PM_TaskDetails.aspx?MasterTagID=406&Mode=<%=CONST_MODE_QUERY%>&Execute=<%=CONST_ACTION_EXECUTE%>&Alphabet=<%=m_strAlphabet%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>";
                        objform.submit();--%>
        }
        function disallowMaxlengthViolation(obj, num, msg) {
            if (String(obj.value).length > num) {
                alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                alertify.error(msg);
                return true;
            }
            return false;
        }

        var ShowPhases = false;
        var ShowModules = false;
        var ShowSubProjects = false;
        var ShowMilestones = false;
        var ShowFeatures = false;

        function LoadTaskReferences() {

            var filterParameters = {
                TaskId: 0,
                ProjectId: ProjectId
            }
            var param = JSON.stringify(filterParameters);
            AJAXCallWithResult(GetTaskReferences, param, true, "POST", function (result) {
                $("#cboTaskType1").html('<option value=0><%=MyBase.GetResourceString("SelectTaskType") %></option>');
                $("#cboTaskType").html('<option value=0><%=MyBase.GetResourceString("SelectTaskType") %></option>');

                $("#cboPhase1").html('<option value=0><%=MyBase.GetResourceString("SelectPhase") %></option>');
                $("#cboPhase").html('<option value=0><%=MyBase.GetResourceString("SelectPhase") %></option>');

                $("#cboModule1").html('<option value=0><%=MyBase.GetResourceString("SelectModule") %></option>');
                $("#cboModule").html('<option value=0><%=MyBase.GetResourceString("SelectModule") %></option>');

                $("#cboSubproject1").html('<option value=0><%=MyBase.GetResourceString("SelectSubProject") %></option>');
                $("#cboSubproject").html('<option value=0><%=MyBase.GetResourceString("SelectSubProject") %></option>');

                $("#cboMilestone1").html('<option value=0><%=MyBase.GetResourceString("SelectMilestone") %></option>');
                $("#cboMilestone").html('<option value=0><%=MyBase.GetResourceString("SelectMilestone") %></option>');

                $("#cboDeliverable1").html('<option value=0><%=MyBase.GetResourceString("SelectDeliverable") %></option>');
                $("#cboDeliverable").html('<option value=0><%=MyBase.GetResourceString("SelectDeliverable") %></option>');

                $("#cboFeature1").html('<option value=0><%=MyBase.GetResourceString("SelectProjectFeature") %></option>');
                $("#cboFeature").html('<option value=0><%=MyBase.GetResourceString("SelectProjectFeature") %></option>');

                for (var i = 0; i < result.TaskTypes.length; i++) {
                    $("#cboTaskType1").append('<option value=' + result.TaskTypes[i].Id + '>' + result.TaskTypes[i].Name + '</option>');
                    $("#cboTaskType").append('<option value="' + result.TaskTypes[i].Name + '">' + result.TaskTypes[i].Name + '</option>');
                }
                for (var i = 0; i < result.Phases.length; i++) {
                    $("#cboPhase1").append('<option value=' + result.Phases[i].Id + '>' + result.Phases[i].Name + '</option>');
                    $("#cboPhase").append('<option value="' + result.Phases[i].Name + '">' + result.Phases[i].Name + '</option>');
                }
                for (var i = 0; i < result.Modules.length; i++) {
                    $("#cboModule1").append('<option value=' + result.Modules[i].Id + '>' + result.Modules[i].Name + '</option>');
                    $("#cboModule").append('<option value="' + result.Modules[i].Name + '">' + result.Modules[i].Name + '</option>');
                }
                for (var i = 0; i < result.SubProjects.length; i++) {
                    $("#cboSubproject1").append('<option value=' + result.SubProjects[i].Id + '>' + result.SubProjects[i].Name + '</option>');
                    $("#cboSubproject").append('<option value="' + result.SubProjects[i].Name + '">' + result.SubProjects[i].Name + '</option>');
                }
                for (var i = 0; i < result.Milestones.length; i++) {
                    $("#cboMilestone1").append('<option value=' + result.Milestones[i].Id + '>' + result.Milestones[i].Name + '</option>');
                    $("#cboMilestone").append('<option value="' + result.Milestones[i].Name + '">' + result.Milestones[i].Name + '</option>');
                }
                for (var i = 0; i < result.Features.length; i++) {
                    $("#cboFeature1").append('<option value=' + result.Features[i].Id + '>' + result.Features[i].Name + '</option>');
                    $("#cboFeature").append('<option value="' + result.Features[i].Name + '">' + result.Features[i].Name + '</option>');
                }
                for (var i = 0; i < result.Deliverables.length; i++) {
                    $("#cboDeliverable1").append('<option value=' + result.Deliverables[i].Id + '>' + result.Deliverables[i].Name + '</option>');
                    $("#cboDeliverable").append('<option value="' + result.Deliverables[i].Name + '">' + result.Deliverables[i].Name + '</option>');
                }
                ShowPhases = result.ShowPhases;
                ShowModules = result.ShowModules;
                ShowSubProjects = result.ShowSubProjects;
                ShowMilestones = result.ShowMilestones;
                ShowFeatures = result.ShowFeatures;
                if (!result.ShowPhases) {
                    $("#divPhase").css("display", "none");
                }
                else {
                    $("#divPhase").css("display", "");
                }
                if (!result.ShowModules) {
                    $("#divModule").css("display", "none");
                }
                else {
                    $("#divModule").css("display", "");
                }
                if (!result.ShowSubProjects) {
                    $("#divSubProject").css("display", "none");
                }
                else {
                    $("#divSubProject").css("display", "");
                }
                if (!result.ShowMilestones) {
                    $("#divMilestone").css("display", "none");
                }
                else {
                    $("#divMilestone").css("display", "");
                }
                if (!result.ShowFeatures) {
                    $("#divFeature").css("display", "none");
                }
                else {
                    $("#divFeature").css("display", "");
                }

                $("#taskTypeCount").html(result.CountOfTaskInTaskTypes);
                $("#moduleCount").html(result.CountOfTaskInModules);
                $("#phaseCount").html(result.CountOfTaskInPhases);
                $("#milestoneCount").html(result.CountOfTaskInMilestones);
                $("#subProjectCount").html(result.CountOfTaskInSubProjects);
                $("#deliverableCount").html(result.CountOfTaskInDeliverables);
                $("#featureCount").html(result.CountOfTaskInFeatures);
            });
        }

        var strColumnName = "";
        function Count_OnClick(strCol) {
            strColumnName = strCol;
            ExecuteTaskMappingFun("COUNT", "", "", strCol);
        }

        function ClearOnClick(strCol) {
            var intRowCount, intLen, i;
            var objTxt, objChk;
            var blnSelected;
            blnSelected = false;
            strColumnName = strCol;
            objChk = document.getElementsByName('chkApply');
            intLen = objChk.length;
            if (intLen > 0) {
                for (i = 0; i < intLen; i++)
                    if (objChk[i].checked == true) {
                        blnSelected = true;
                        break;
                    }
            }

            if (blnSelected == true) {
                var str;
                str = new String(strCol);

                if (str.toUpperCase() == 'MODULENAME')
                    strCol = "Task Type";
                else if (str.toUpperCase() == 'SUBPROJECT')
                    strCol = "Sub Project";
                else if (str.toUpperCase() == 'PROJECTFEATUREID')
                    strCol = "Feature";
                //Intigrated by Harshk for sp4 issueid 200
                //Purpose to 
                else if (str.toUpperCase() == 'DELIVERABLEID')
                    strCol = "Deliverable";
                //End Intigrated by Harshk for sp4 issueid 200	
                <%--var ans;
                ans = window.confirm('<%=MyBase.GetResourceString("SelectModule")%>' + strCol + ' ' + '<%=MyBase.GetResourceString("SelectSubProject")%>');
                    if (ans == true) {
                        Save_OnClick()
                        }--%>
                $("#lblClear").html('<%=MyBase.GetResourceString("MSG_COLUMN_CLEAR_1")%>' + strCol + ' ' + '<%=MyBase.GetResourceString("MSG_COLUMN_CLEAR_2")%>')
                $("#ClearModal").modal("show");
                    }
                    else {
                alertify.error('<%=MyBase.GetResourceString("MSG_TASK_NOT_SELECTED")%>');
                }
            
        }
//Added By Dipali V On 17th Jun 2026 For Task mapping Saving Issue and refresh issue
        function SaveTaskDetailsInChunks(taskParameters, onComplete) {
            var chunkSize = 5;
            var currentIndex = 0;

            function saveNextChunk() {
                var chunk = taskParameters.slice(currentIndex, currentIndex + chunkSize);
                if (chunk.length === 0) {
                    onComplete();
                    return;
                }

                var param = JSON.stringify({ 'taskParameters': chunk });
                AJAXCallWithResult(SaveTaskDetails, param, true, "POST", function () {
                    currentIndex += chunkSize;
                    saveNextChunk();
                });
            }

            saveNextChunk();
        }
//End of Added By Dipali V On 17th Jun 2026 For Task mapping Saving Issue and refresh issue
        function ClearSave_OnClick() {
            var objTxt, strCol;
            var flag = false;
            strCol = new String(strColumnName);

                if (flag == false) {
                    var blnSelected = false;
                    var objChk = document.getElementsByName("chkApply")
                    var intLen = objChk.length;
                    flag = true;
                    if (intLen > 0) {
                        var i;
                        for (i = 0; i < intLen; i++)
                            if (objChk[i].checked == true) {
                                blnSelected = true;
                                break;
                            }
                    }

                    if (blnSelected == false) {
                        alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                    alertify.error('<%=MyBase.GetResourceString("MSG_TASK_NOT_SELECTED")%>');
                    return;
                }
                else
                    flag = false;
            }
            
            //End of Modification by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]           	
            //End of Integratition by GokulP on 10 May 2010 for SP1           
            var strURL;
            var fmt = 'MMM dd,yyyy';
            var IsValidTask = 1;
            if (flag == false) {
                var taskParameters = []

                $("[name=chkApply]").each(function () {
                    if ($(this).prop("checked") == true) {
                        var task = {
                            TaskId: parseInt($(this).val()),
                            ColumnName: String(strCol),
                            ColumnValueString: "",
                            ColumnValueInt: 0,
                            Mode: "CLEAR",
                            Action: "CLEAR",
                            ProjectId: parseInt(ProjectId),
                            PhaseId: 0,
                            Phase: "",
                            TaskTypeId: 0,
                            TaskType: "",
                            ModuleId: 0,
                            Module: "",
                            SubProjectId: 0,
                            SubProject: "",
                            MilestoneId: 0,
                            Milestone: "",
                            FeatureId: 0,
                            DeliverableId: 0,
                        }
                        taskParameters.push(task)
                    }
                })
                //var param = JSON.stringify({ 'taskParameters': taskParameters });
                console.log(taskParameters);
                SaveTaskDetailsInChunks(taskParameters, function () {
                    $("#ClearModal").modal("hide");
                    if (strMode == "RUN") {
                        Execute_OnClick();
                    }
                    else {
                        Count_OnClick(strCol);
                    }
                    // Added by dipali v on 17th Jun 2026 for calling LoadTaskReferences only after successful save completion
                    LoadTaskReferences();
                    alertify.notify("Saved Successfully.", 'success', alertifyTimer);
                });
            }
        }

        function Save_OnClick() {
            var objTxt, strCol;
            var flag=false;
            if (strMode == 'COUNT') {
                strCol = new String(strColumnName);

                if (strCol.toUpperCase() == 'PHASE') {
                    objTxt = $('#cboPhase1');
                    flag = disallowBlankCombo(objTxt, '<%=MyBase.GetResourceString("MSG_PHASE_EMPTY")%>', true);
                        if (flag == true)
                            return;
                    }
                    if (strCol.toUpperCase() == 'MODULENAME') {
                        objTxt = $('#cboTaskType1');
                        flag = disallowBlankCombo(objTxt, '<%=MyBase.GetResourceString("MSG_TAKSTYPE_EMPTY")%>', true);
                        if (flag == true)
                            return;
                    }
                    if (strCol.toUpperCase() == 'MODULE') {
                        objTxt = $('#cboModule1');
                        flag = disallowBlankCombo(objTxt, '<%=MyBase.GetResourceString("MSG_MODULE_EMPTY")%>', true);
                        if (flag == true)
                            return;
                    }
                    if (strCol.toUpperCase() == 'SUBPROJECT') {
                        objTxt = $('#cboSubproject1');
                        flag = disallowBlankCombo(objTxt, '<%=MyBase.GetResourceString("MSG_SUBPROJECT_EMPTY")%>', true);
                        if (flag == true)
                            return;
                    }
                    if (strCol.toUpperCase() == 'MILESTONE') {
                        objTxt = $('#cboMilestone1');
                        flag = disallowBlankCombo(objTxt, '<%=MyBase.GetResourceString("MSG_MILESTONE_EMPTY")%>', true);
                        if (flag == true)
                            return;
                    }
                    if (strCol.toUpperCase() == 'PROJECTFEATUREID') {
                        objTxt = $('#cboFeature1');
                        flag = disallowBlankCombo(objTxt, '<%=MyBase.GetResourceString("MSG_FEATURES_EMPTY")%>', true);
                        if (flag == true)
                            return;
                    }
                    //Intigrated by HarshK for sp4 issueid 200
                    if (strCol.toUpperCase() == 'DELIVERABLEID') {
                        objTxt = $('#cboDeliverable1');
                        flag = disallowBlankCombo(objTxt, '<%=MyBase.GetResourceString("MSG_DELIVERABLES_EMPTY")%>', true);
                        if (flag == true)
                            return;
                    }
                    //End Intigrated by HarshK for sp4 issueid 200
            }
            else if (strMode == 'COUNT') {
                flag = false
            }
            else {
                objTxt = $('#cboTaskType1');
                    flag = disallowBlankCombo(objTxt, '', false);

                    if (flag == true && ShowPhases == true) {
                        objTxt = $('#cboPhase1');
                        flag = disallowBlankCombo(objTxt, '', true);
                    }
                    if (flag == true && ShowModules == true) {
                        objTxt = $('#cboModule1');
                        flag = disallowBlankCombo(objTxt, '', true);
				    }
				    if (flag == true && ShowSubProjects == true) {
                        objTxt = $('#cboSubproject1');
                        flag = disallowBlankCombo(objTxt, '', true);
				    }
				    if (flag == true && ShowMilestones == true) {
                        objTxt = $('#cboMilestone1');
                        flag = disallowBlankCombo(objTxt, '', true);
				    }
				    if (flag == true && ShowFeatures == true) {
                        objTxt = $('#cboFeature1');
                        flag = disallowBlankCombo(objTxt, '', true);
				    }
				    //Modified By VidyaJ - issueid 200 - 2p4
				    if (flag == true) {
                        objTxt = $('#cboDeliverable1');
                        flag = disallowBlankCombo(objTxt, '', true);
				    }

				    if (flag == true) {
                        alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                        alertify.error('<%=MyBase.GetResourceString("MSG_ALL_EMPTY")%>');
					    return;
					}
                }

                if (flag == false) {
                    var blnSelected = false;
                    var objChk = document.getElementsByName("chkApply")
                    var intLen = objChk.length;
                    flag = true;
                    if (intLen > 0) {
                        var i;
                        for (i = 0; i < intLen; i++)
                            if (objChk[i].checked == true) {
                                blnSelected = true;
                                break;
                            }
                    }

                    if (blnSelected == false) {
                        alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                        alertify.error('<%=MyBase.GetResourceString("MSG_TASK_NOT_SELECTED")%>');
					    return;
					}
					else
					    flag = false;
                }
            var objModuleID = $('#cboModule1 option:selected');
            var objSubProjectID = $('#cboSubproject1 option:selected');
            var objMilestoneID = $('#cboMilestone1 option:selected');
            var objDeliverableID = $('#cboDeliverable1 option:selected');

			    //Integrated by GokulP on 10 May 2010 for SP1   
			    //Modified by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]
                var intSelectedModuleID = 0;
                var intSelectedSubProjectID = 0;
                var intSelectedMilestoneID = 0;
                var intSelectedDeliverableID = 0;

                if (objModuleID) {
                    var strSelectedModule = objModuleID.val();
                    //var intSelectedModuleID = strSelectedModule.substring(0,strSelectedModule.indexOf("|"));
                    intSelectedModuleID = objModuleID.val();
                }
                if (objSubProjectID) {
                    var strSelectedSubProject = objSubProjectID.val();
                    //var intSelectedSubProjectID = strSelectedSubProject.substring(0,strSelectedSubProject.indexOf("|")); 
                    intSelectedSubProjectID = objSubProjectID.val();
                }
                if (objMilestoneID) {
                    var strSelectedMilestone = objMilestoneID.val();
                    //var intSelectedMilestoneID = strSelectedMilestone.substring(0,strSelectedMilestone.indexOf("|"));
                    intSelectedMilestoneID = objMilestoneID.val();
                }
                if (objDeliverableID) {
                    intSelectedDeliverableID = objDeliverableID.val();
                }
			    //End of Modification by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]           	
			    //End of Integratition by GokulP on 10 May 2010 for SP1           
                var strURL;
                var fmt = 'MMM dd,yyyy';
                var IsValidTask = 1;

                if (flag == false) {
                    var blnSelected = false;
                    var objChk = document.getElementsByName("chkApply")
                    var intLen = objChk.length;

                    if (intLen > 0) {
                        var i;
                        for (i = 0; i < intLen; i++)
                            if (objChk[i].checked == true) {
                                blnSelected = true;
                                //Integrated by GokulP on 10 May 2010 for SP1
                                //Modified by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]           																						
                                //strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&FromWhichPage=TaskMapping&TaskId="+objChk[i].value+"&StartDate=&EndDate=&DeliverableID="+objDeliverableID.value+"&ModuleID="+String(intSelectedModuleID)+"&SubProjectID="+String(intSelectedSubProjectID)+"&MilestoneID="+String(intSelectedMilestoneID)+"&Work=";
                                var strUrl1 = "../../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&FromWhichPage=TaskMapping&TaskId=" + objChk[i].value + "&StartDate=&EndDate=&DeliverableID=" + intSelectedDeliverableID + "&ModuleID=" + String(intSelectedModuleID) + "&SubProjectID=" + String(intSelectedSubProjectID) + "&MilestoneID=" + String(intSelectedMilestoneID) + "&Work=";
                                //End of Modification by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]           	
                                //End of Integration by GokulP on 10 May 2010 for SP1
                                //ValidateTask_Baseline(strUrl1);
                                var strResult;
                                $.ajax({
                                    url: strUrl1,
                                    type: "GET",
                                    data: {},
                                    async: false,
                                    dataType: "json",
                                    contentType: "application/json;charset-utf=8",
                                    success: function (data) {
                                        strResult = data;
                                    },
                                    error: function (jqXHR) {
                                        console.log(jqXHR);
                                    }
                                });
                                if (strResult != null && strResult != "") {
                                    alertify.set('notifier', 'position', 'top-right', 'color', 'white');
                                    alertify.error(strResult);
                                    IsValidTask = 0;
                                }
                                break;
                            }
                    }
                }
                if (IsValidTask == 0) {
                    return false;
                }
                if (flag == false) {				
                    var taskParameters = []

                    $("[name=chkApply]").each(function () {
                        if ($(this).prop("checked") == true) { 
                        var task = {
                            TaskId: parseInt($(this).val()),
                            ColumnName: String(strCol),
                            ColumnValueString: objTxt.find("option:selected").text(),
                            ColumnValueInt: parseInt(objTxt.find("option:selected").val()),
                            Mode: strMode,
                            Action: "SAVE",
                            ProjectId: parseInt(ProjectId),
                            PhaseId: parseInt($("#cboPhase1 option:selected").val()),
                            Phase: $("#cboPhase1 option:selected").text(),
                            TaskTypeId: parseInt($("#cboTaskType1 option:selected").val()),
                            TaskType: $("#cboTaskType1 option:selected").text(),
                            ModuleId: parseInt($("#cboModule1 option:selected").val()),
                            Module: $("#cboModule1 option:selected").text(),
                            SubProjectId: parseInt($("#cboSubproject1 option:selected").val()),
                            SubProject: $("#cboSubproject1 option:selected").text(),
                            MilestoneId: parseInt($("#cboMilestone1 option:selected").val()),
                            Milestone: $("#cboMilestone1 option:selected").text(),
                            FeatureId: parseInt($("#cboFeature1 option:selected").val()),
                            DeliverableId: parseInt($("#cboDeliverable1 option:selected").val()),
                        }
                            taskParameters.push(task)
                        }
                    })
                    console.log(taskParameters);
                    SaveTaskDetailsInChunks(taskParameters, function () {
                        if (strMode == "RUN") {
                            Execute_OnClick();
                        }
                        else {
                            Count_OnClick(strCol);
                        }
                        // Added by dipali v on 17th Jun 2026 for calling LoadTaskReferences only after successful save completion
                        LoadTaskReferences();
                        alertify.notify("Saved Successfully.", 'success', alertifyTimer);
                    });
            }
        }

        function ValidateTask_Baseline(url) {
            // TO SEE IF WE ARE RUNNING IN IE 
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();

            //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
            //if (strNavigator == 'MICROSOFT INTERNET EXPLORER')
            if (brw == "IE") {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
            else {

                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send(null);

                if (g_objXHttp.responseText != null) {
                    xmlDoc = document.implementation.createDocument("", "", null);
                    xmlDoc.async = false;
                    //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
                    if (brw == "FF")
                        xmlDoc.load(g_objXHttp.responseXML);
                    strResult = g_objXHttp.responseText;
                }

            }
            return strResult;
        }
        var brw = isIE();
        function isIE() {
            var brwser = '';
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                //return 'IE '+(tem[1] || '');
                return 'IE';
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'CR';
            }
            else if (M[1] === 'Firefox') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'FF';
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            //return M.join(' ');
            return brwser;
        }
        function TaskValidation_state_change() {

            if (g_objXHttp.readyState == 4) {

                // Make sure request came back OK 
                if (g_objXHttp.status == 200) {
                    //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
                    //if (window.ActiveXObject)
                    if (brw == "IE") {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async = false;
                        xmlDoc.loadXML(g_objXHttp.responseText);

                    }
                    // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                        //added by Nilesh g on 10/12/2015 for issue id 2721
                        if (brw == "FF")
                            xmlDoc.load(g_objXHttp.responseXML);
                    }

                    //Save the Result in a Global variable
                    strResult = g_objXHttp.responseText;

                }
            }
        }

         //Added By Dipali V On 12th April 2023 For Back Persist ISsue
        params = getParams();
        var TaskType = unescape(params["TaskType"]);

        function Back_onclick() {
            window.location.href = "TaskManagement.aspx?MasterTagId=406&WhichTask=" + TaskType;

        }
         
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
        //End of Added By Dipali V On 12th April 2023 For Back Persist ISsue
    </script>


</body>
</html>
