<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="wbs.aspx.vb" Inherits="PbNIT.wbs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Project Scheduling: Whizible</title>

    <link rel="stylesheet" href="../../../Whizible2.0-new/WhizibleGantt/platform.css" type="text/css"/>
    <link rel="stylesheet" href="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/dateField/jquery.dateField.css" type="text/css"/>


    <link rel="stylesheet" href="../../../Whizible2.0-new/WhizibleGantt/ganttPrint.css" type="text/css" media="print"/>
    <link rel="stylesheet" href="../../../Whizible2.0-new/WhizibleGantt/gantt.css" type="text/css"/>

    <!--- Customize CSS      --->
    <link rel="stylesheet" href="../../../Whizible2.0-new/WhizibleGantt/customize.css" type="text/css"/>


    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/WhizibleGantt/libs/css/bootstrap.min.css" />

    <!-- <script src="libs/jquery/jquery-3.1.1.min.js"></script>-->
    <%--<script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/jquery.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/jquery-ui.min.js"></script>
    <!-- <script src="libs/jquery/jquery-3.2.1.min.js"></script>-->

    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/jquery.livequery.1.1.1.min.js"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/jquery.timers.js"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/bootstrap.tooltip.js"></script>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.min.js"></script>--%>
    <script src="../../../WhizibleGanttAPI/Scripts/bootstrap.min.js"></script>
    <script>
        var sessionUserID = '<%= Session("intUserID") %>';
        var sessionProjectID = '<%= Session("intProjectID")%>';
        if (sessionProjectID == "") {
            sessionProjectID = 0;

        }


        var baseURL = '<%=System.Configuration.ConfigurationManager.AppSettings("WhizibleGanttAPI").ToString%>';
        //var  baseURL = 'http://192.168.2.43/WhizibleGanttChart/';
        var ApiURL = {
            GetWBSForProject: baseURL + 'api/ProjectGanChat/GetWBSForProject?EmployeeId=' + sessionUserID,
            GetAssignedTasks: baseURL + 'api/ProjectGanChat/GetAssignedTasks?EmployeeId=' + sessionUserID,
            GetAssignedProjects: baseURL + 'api/ProjectGanChat/GetAssignedProjects?ProjectId=' + sessionProjectID + '&EmployeeID=' + sessionUserID,
            SaveProject: baseURL + 'api/ProjectGanChat/SaveTasks',
            importTasks: baseURL + '/api/ProjectGanChat/importTask',
            confirmImportTask: baseURL + '/api/ProjectGanChat/confirmImportTask',
            checkTaskActualDates: baseURL + '/api/ProjectGanChat/CheckTaskActualDates',
        };
        //Added for tooltip issue
        $(document).click(function () {
            $(".tooltip").removeClass("in");
            
        });
        //Added By Pradip P On 19.05.2021 For button alignment issue
        $(document).ready(function () {
            setTimeout(function () {
                $('.ganttButtonBar .buttons').each(function () {
                    $(this).html($(this).html().replace(/&nbsp;/gi, ''));
                });
            }, 3000);
        });
        //End Of Added By Pradip P On 19.05.2021 For button alignment issue
        function OpenModalForPrerequisites() {

            $.getJSON("Prerequisites.json", function (data) {
                var strHTML = "";
                strHTML += "<tr><td style='font-weight:bold'>Notes : </td></tr>"
                for (var i = 0; i < data.Notes.length; i++) {
                    strHTML += "<tr><td style='padding:5px;'>" + data.Notes[i] + "</td></tr>";
                }
                //strHTML += "<tr><td style='font-weight:bold'>Dont's : </td></tr>"
                //for (var i = 0; i < data.Donts.length; i++) {
                //    strHTML += "<tr><td style='padding:5px;'>" + data.Donts[i] + "</td></tr>";
                //}
                $("#tblPrerequisites").html(strHTML);
            });

            $("#divPrerequisites").modal("show");
        }
    </script>
    <script type="text/javascript">
        var STATUS_ACTIVE = 'A';
        var STATUS_INACTIVE = 'I';
        var STATUS_VOID = 'V';
        var STATUS_NOT_VOID = 'NV';
        var STATUS_HOLD = 'H';
        var STATUS_UN_HOLD = 'R';
        var STATUS_COMPLETED = 'C';

        //Gantt Statuses 
        var STATUS_DONE = STATUS_COMPLETED;
        var STATUS_FAILED = STATUS_VOID;
        var STATUS_UNDEFINED = STATUS_UN_HOLD;
        var STATUS_WAITING = STATUS_INACTIVE;
        var STATUS_SUSPENDED = STATUS_HOLD
    </script>

    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/utilities.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/forms.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/date.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/dialogs.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/layout.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/i18nJs.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/dateField/jquery.dateField.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/JST/jquery.JST.js?date=<%=DateTime.Now %>"></script>

    <script type="text/javascript" src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/svg/jquery.svg.min.js"></script>
    <script type="text/javascript" src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/svg/jquery.svgdom.1.8.js"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/jquery.table2excel.min.js"></script>

    <script src="../../../Whizible2.0-new/WhizibleGantt/ganttUtilities.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/ganttTask.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/ganttDrawerSVG.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/ganttZoom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/ganttGridEditor.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/WhizibleGantt/ganttMaster.js?date=<%=DateTime.Now %>"></script>

    <script src="../../../Whizible2.0-new/WhizibleGantt/customizePartA.js?date=<%=DateTime.Now %>"></script>
    <script type="text/javascript" src="../../../Whizible2.0-new/WhizibleGantt/libs/jquery/xlsx.full.min.js"></script>

    <!--<script src="libs/profiling.js"></script>-->
    <!--<script type="text/javascript" src="ganttTestSuite.js"></script>-->
    <style>
        .legends {
            font-size: 12px !important;
        }

            .legends fieldset {
                float: left;
            }

        .legend {
            display: block;
            /*float: right;*/
            margin: auto;
            height: 15px;
            width: 15px;
            /*border-radius: 50%;*/
            /*margin: 10px;*/
        }

        legend {
            font-size: 12px !important;
            margin-bottom:0px;
        }

        .orange {
            background-color: orange;
        }

        .red1 {
            background-color: red !important;
            /*opacity: 0.4;*/
        }

        .green {
            background-color: #00ff30 !important;
            opacity: 0.4;
        }
        /*Added By Dipali V On 24th Dec 2020 For Alignment issue */
        #custom_toggle_progress {
            width:  249px
        }
        #custom_toggle_tasktype {
            width:158px
        }
                #workSpace,#TWGanttArea {
            overflow: initial !important;
            font-size: 12PX !IMPORTANT;
        }
        .gdfTable td, .gdfTable th {
            font-size: 12PX !IMPORTANT;
        }
        #panel_basic.task-I, #panel_basic.task-C, #panel_basic.task-V, #panel_basic.task-H, .taskEditRow.task-C input, .taskEditRow.task-I input, .taskEditRow.task-V input, .taskEditRow.task-H input, .taskBoxSVG.task-C, .taskBoxSVG.task-H, .taskBoxSVG.task-V, .taskBoxSVG.task-I, #workSpace.msp .taskBoxSVG {
            font-size: 12PX !IMPORTANT;
        }
        .taskEditRow input, .columnWidthTest{
            font-size: 12PX !IMPORTANT;
        }
               .tooltip-inner {
            font-size: 11px;
            max-width: 220px;
            padding: 6px 8px;
}
        fieldset {
            padding: auto !important;
        }
        .btn,.form-control  {
            font-size: 12px;
        }
        
        .tab-slider--trigger  {
            font-size: 11px;
        }
         /*End of Added By Dipali V On 24th Dec 2020 For Alignment issue */
    </style>
</head>
<body style="background-color: #fff;">
    <%--<br>--%>
    <div class="content-wrapper bgwhite wbs">
        <div class="graybg resourceallocation_header container-fluid pt-1 pb-1">
            <div class="row">
                <div class="col-sm-3">
                    <select id="cmbProject" class="form-control selectpicker">
                        <option>Select Project</option>
                    </select>
                    <br />
                </div>
                <div class="col-sm-2 hideSection">
                    <div class="custom-tab-slider--tabs" id="custom_toggle_tasktype" style="white-space:nowrap">
                        <a href="javascript:void(0)" data-id="whizible" class="tab-item-whizible custom-tab-items tab-slider--trigger active">Whizible</a>
                        <a href="javascript:void(0)" data-id="msp" class="tab-item-msp custom-tab-items tab-slider--trigger ">MSP</a>

                    </div>
                </div>
                <%--<div class="col-sm-1 hideSection">--%>
                    <!-- <button type="button" id="btnImport" onclick="importFromXsl()" class="btn">Import</button> -->
                <%--</div>--%>
                <div class="col-sm-1 hideSection">
                    <button type="button" onclick="extortToXsl()" class="btn">Export</button>
                </div>
                <%--<div class="col-sm-2 hideSection">
			<div class="custom-tab-slider--tabs" id="custom_toggle_task">
				<a href="javascript:void(0)" data-id="active" class="tab-item-active custom-tab-items tab-slider--trigger active">Active</a>
				<a href="javascript:void(0)" data-id="all" class="tab-item-all custom-tab-items tab-slider--trigger">All</a>
			</div>
		<%--</div>--%>
                <div class="col-sm-3 hideSection">
                    <div class="custom-tab-slider--tabs" id="custom_toggle_progress"  style="white-space:nowrap">
                        <a id="actualefforts" class="tab-item-actualefforts custom-tab-items tab-slider--trigger" data-id="actualefforts">Actual Efforts</a>
                        <a id="actualprogress" class="tab-item-actualprogress custom-tab-items tab-slider--trigger" data-id="actualprogress">Actual %</a>

                    </div>
                </div>
                <div class="col-sm-3 hideSection">
                    <div style="float: right;" class='legends'>
                                        <fieldset>
                                            <legend>Actual Efforts > Planned Efforts</legend>
                                            <div class="legend orange">
                                            </div>
                                        </fieldset>
                                        <fieldset>
                                            <legend>Inactive/Void</legend>
                                            <div class="legend red1">
                                            </div>
                                        </fieldset>
                                    </div>
                </div>
                <div class="col-sm-4" style="display: none;">
                    <div class="weeklyanddaily">
                        <div class="tab-slider--nav pull-right">
                            <ul class="tab-slider--tabs">
                                <li class="tab-slider--trigger active" rel="actualprogress" data-toggle="tooltip" data-placement="top" title="Actual %"><span>Actual %</span></li>
                                <li data-toggle="tooltip" data-placement="top" title="Actual Efforts" class="tab-slider--trigger" rel="actualefforts">Actual Efforts</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="context-menu" id="context-menu" style="display: none; position: absolute; z-index: 99">
        <div id="checkboxes" style="list-style: none; color: #1359a6; font-weight: 600;">
            LIST OF ACTIONS
   <li>
       <input type="checkbox" onchange="hideCell( this)" data-id="taskNum" />Task Number</li>
            <li>
                <input type="checkbox" checked="checked" disabled />Task Name</li>
            <li>
                <input type="checkbox" onchange="hideCell( this)" data-id="description" />Description</li>
            <!--<li><input type="checkbox" onchange="hideCell( this)" data-id="startm"/>Start Date is MileStone</li>-->
            <li>
                <input type="checkbox" checked="checked" disabled />Start Date</li>
            <!--<li><input type="checkbox" onclick="hideCell( this )" data-id="endm"/>End Date is MileStone</li>-->
            <li>
                <input type="checkbox" checked="checked" disabled />End Date</li>
            <li>
                <input type="checkbox" checked="checked" disabled />Planned Work Hours</li>
            <li>
                <input type="checkbox" onclick="hideCell(this)" data-id="duration" />Duration</li>
            <li>
                <input type="checkbox" checked="checked" onclick="hideCell(this)" data-id="resources" />Resources</li>
        </div>
    </div>

    <div id="workSpace" style="margin: 0px; overflow-y: auto; overflow-x: hidden; border: 1px solid #e5e5e5; position: relative; margin: 0 5px"></div>
    <div id="noworkSpace" style="display: none; margin: 15px" class="text-center"></div>
    <div class="modalPopup" id="loadingImg" style="background-image: url('../../../Whizible2.0-new/WhizibleGantt/ajax-loader-preview.gif'); background-position: center; background-repeat: no-repeat; background-color: white;"></div>
    <form id="gimmeBack" style="display: none;" action="../gimmeBack.jsp" method="post" target="_blank">
        <input type="hidden" name="prj" id="gimBaPrj">
    </form>
    <div id="gantEditorTemplates" style="display: none;">
        <div class="__template__" type="GANTBUTTONS">
            <!--
  <div class="ganttButtonBar noprint">
    <div class="buttons">
      <button onclick="$('#workSpace').trigger('undo.gantt');return false;" class="button textual icon requireCanWrite" title="undo"><span class="teamworkIcon">&#39;</span></button>
      <button onclick="$('#workSpace').trigger('redo.gantt');return false;" class="button textual icon requireCanWrite" title="redo"><span class="teamworkIcon">&middot;</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanAdd"></span>
      <button onclick="$('#workSpace').trigger('addAboveCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanAdd" title="insert above"><span class="teamworkIcon">l</span></button>
      <button onclick="$('#workSpace').trigger('addBelowCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanAdd" title="insert below"><span class="teamworkIcon">X</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanInOutdent"></span>
      <button onclick="$('#workSpace').trigger('outdentCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanInOutdent" title="un-indent task"><span class="teamworkIcon">.</span></button>
      <button onclick="$('#workSpace').trigger('indentCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanInOutdent" title="indent task"><span class="teamworkIcon">:</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanMoveUpDown"></span>
      <button onclick="$('#workSpace').trigger('moveUpCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanMoveUpDown" title="move up"><span class="teamworkIcon">k</span></button>
      <button onclick="$('#workSpace').trigger('moveDownCurrentTask.gantt');return false;" class="button textual icon requireCanWrite requireCanMoveUpDown" title="move down"><span class="teamworkIcon">j</span></button>
      <span class="ganttButtonSeparator requireCanWrite requireCanDelete"></span>
      <button onclick="deleteConfirm()" id="btnDeleteTask" class="button textual icon delete requireCanWrite" title="Delete"><span class="teamworkIcon">&cent;</span></button>
      <span class="ganttButtonSeparator"></span>
      <button onclick="customExpandAllTasks();return false;" class="button textual icon " title="Expand All"><span class="teamworkIcon">6</span></button>
      <button onclick="customCollapseAllTasks(); return false;" class="button textual icon " title="Collapse All"><span class="teamworkIcon">5</span></button>

    <span class="ganttButtonSeparator"></span>
      <button onclick="$('#workSpace').trigger('zoomMinus.gantt'); return false;" class="button textual icon " title="zoom out"><span class="teamworkIcon">)</span></button>
      <button onclick="$('#workSpace').trigger('zoomPlus.gantt');return false;" class="button textual icon " title="zoom in"><span class="teamworkIcon">(</span></button>
    <span class="ganttButtonSeparator"></span>
      <button onclick="$('#workSpace').trigger('print.gantt');return false;" class="button textual icon " title="Print"><span class="teamworkIcon">p</span></button>
    <span class="ganttButtonSeparator"></span>
      <button onclick="ge.gantt.showCriticalPath=!ge.gantt.showCriticalPath; ge.redraw();return false;" class="button textual icon requireCanSeeCriticalPath" title="Critical Path"><span class="teamworkIcon">&pound;</span></button>
    <span class="ganttButtonSeparator requireCanSeeCriticalPath"></span>
      <button onclick="ge.splitter.resize(.1);return false;" class="button textual icon" title="Left Screen"><span class="teamworkIcon">F</span></button>
      <button onclick="ge.splitter.resize(50);return false;" class="button textual icon" title="Center Screen"><span class="teamworkIcon">O</span></button>
      <button onclick="ge.splitter.resize(100);return false;" class="button textual icon" title="Right Screen"><span class="teamworkIcon">R</span></button>
      <span class="ganttButtonSeparator"></span>
      <button onclick="$('#workSpace').trigger('fullScreen.gantt');return false;" class="button textual icon" style="display:none;" title="FULLSCREEN" id="fullscrbtn"><span class="teamworkIcon">@</span></button>
      <button style="display:none;" onclick="ge.element.toggleClass('colorByStatus' );return false;" class="button textual icon"><span class="teamworkIcon">&sect;</span></button>

    <button style="display:none;" onclick="editResources();" class="button textual requireWrite" title="edit resources"><span class="teamworkIcon">M</span></button>
      &nbsp; &nbsp; &nbsp; &nbsp;
    <button onclick="saveGanttOnServer();" id="save_project_btn" class="button first big requireWrite" title="Save">Save</button>
    <button onclick="OpenModalForPrerequisites();" id="save_project_btn" class="button first big requireWrite" title="Prerequisites">Prerequisites</button>
    <button class="button login" title="login/enroll" onclick="loginEnroll($(this));" style="display:none;">login/enroll</button>
    <button class="button opt collab" title="Start with Twproject" onclick="collaborate($(this));" style="display:none;"><em>collaborate</em></button>
    <span class="alert alert-danger" id="accessAlertContainer" style="display:none;">
    </span>
    </div></div>
  -->
        </div>
        <%-- <th class="gdfColHeader gdfResizable" style="width:35px;"></th>--%>
        <div class="__template__" type="TASKSEDITHEAD">
            <!--
  <table class="gdfTable" cellspacing="0" cellpadding="0"  data-role="table" id="demo" data-mode="columntoggle" class="ui-responsive table-stroke">
    <thead>
    <tr style="height:40px">
      <th class="gdfColHeader extrawidth" style="width:55px; border-right: none"></th>
      
      <th class="gdfColHeader gdfResizable taskNum hidden-column" style="width:100px;">Task Number</th>
      <th class="gdfColHeader gdfResizable" style="width:300px;">Task Name</th>
      <th class="gdfColHeader gdfResizable description" style="width:300px;">Description</th>
      <th class="gdfColHeader startm hidden-column"  align="center" style="width:17px;" title="Start date is a milestone."><span class="teamworkIcon" style="font-size: 8px;">^</span></th>
      <th class="gdfColHeader gdfResizable" style="width:80px;">Start Date</th>
      <th class="gdfColHeader endm hidden-column"  align="center" style="width:17px;" title="End date is a milestone."><span class="teamworkIcon" style="font-size: 8px;">^</span></th>
      <th class="gdfColHeader gdfResizable" style="width:80px;">End Date</th>
      <th class="gdfColHeader gdfResizable" style="width:80px;">Planned Work Hours</th>
      <th class="gdfColHeader gdfResizable hidden-column duration" style="width:80px;">Duration </th>
      <th class="gdfColHeader gdfResizable" style="width:50px;">%</th>
      <th class="gdfColHeader gdfResizable requireCanSeeDep" style="width:50px;">Dependency</th>
      <th class="gdfColHeader gdfResizable resources" style="width:1000px; text-align: left; padding-left: 10px;">Resources</th>
    </tr>
    </thead>
  </table>
  -->
        </div>

        <!--
    <td class="gdfCell noClip" align="center"><div class="taskStatus cvcColorSquare" status="(#=obj.status#)"></div></td>-->
        <%--<td class="gdfCell noClip" align="center"><div class="taskCondition cvcColorSquare" condition="(#=obj.condition#)"></div></td>--%>
        <%-- Commented and added By Vaijat K to remove 'taskOverFlow' class discussed with Saji Sir--%>
        <%--<tr id="tid_(#=obj.id#)" taskId="(#=obj.id#)" class="taskEditRow task-(#=obj.status#) (#=obj.progressOverflow?'taskOverFlow':''#) (#=obj.isParent()?'isParent':''#) (#=obj.collapsed?'collapsed':''#)" level="(#=level#)" style="color:(#=obj.subtaskcolor?obj.subtaskcolor:'black'#);" data-parent-id="(#=obj.parentTaskId#)" title="(#=obj.whiziblesubtask?obj.whiziblesubtask:''#)" >--%>
        <div class="__template__" type="TASKROW">
            <!--
  <tr id="tid_(#=obj.id#)" taskId="(#=obj.id#)" class="taskEditRow task-(#=obj.status#) (#=String(obj.status).toLowerCase() != 'i' && String(obj.status).toLowerCase() != 'v' && taskHoursToMin(obj.ActualWorkHM) > taskHoursToMin(obj.planefforts)?'orangeRow':''#) (#=obj.isParent()?'isParent':''#) (#=obj.collapsed?'collapsed':''#)" level="(#=level#)" style="color:(#=obj.subtaskcolor?obj.subtaskcolor:'black'#);" data-parent-id="(#=obj.parentTaskId#)" title="(#=obj.whiziblesubtask?obj.whiziblesubtask:''#)" >
    <th class="gdfCell edit" align="right"><span class="taskRowIndex" id="taskRowIndex(#=obj.getRow()+1#)" data-task-id="(#=obj.id#)">(#=obj.getRow()+1#)</span> <span class="teamworkIcon">e</span></th>
    
    
    <td class="gdfCell taskNum text-center"><input type="hidden" name="wbsid" value="(#=obj.wbsid?obj.wbsid:''#)" placeholder="Task Number"><input type="text" name="task_id" value="(#=obj.id?obj.id:''#)" placeholder="Task Number"></td>
    <td class="gdfCell indentCell" style="padding-left:(#=obj.level*10+18#)px;">
      <div class="exp-controller" align="center"></div>
      <input type="text" class="taskname" name="name" maxlength="200" value="(#=obj.name#)" placeholder="name" onfocus="triggerOnFocus(this)" onblur="triggerOnBlur(this)">
    </td>
    <td class="gdfCell description">(#=obj.description#)</td>
    <td class="gdfCell startm text-center" align="center"><input type="checkbox" name="startIsMilestone"></td>
    <td class="gdfCell taskstartdate1 text-center"><input type="text" name="start" id="startDate_(#=obj.id#)"  value="" class="date" onpaste="return false" onkeydown="return false" data-old-value="(#=obj.start#)"></td>
    <td class="gdfCell endm text-center" align="center"><input type="checkbox" name="endIsMilestone"></td>
    <td class="gdfCell text-center"><input type="text" name="end" id="endDate_(#=obj.id#)" value="" class="date" onpaste="return false" onkeydown="return false"  data-old-value="(#=obj.end#)"></td>
    <td class="gdfCell text-center"><input type="text" id="plan_effort_(#=obj.id#)" name="planefforts" data-parent-id="(#=obj.parentTaskId#)" class="(#=String(obj.status).toLowerCase() == 'i' || String(obj.status).toLowerCase() == 'v'?'inactiveInput':''#)" value="(#=obj.planefforts?changePlanEffort(obj.planefforts):0#)" (#=obj.parentTaskId==0?'readOnly':''#)></td>
    <td class="gdfCell duration text-center"><input type="text" name="duration" id="duration_(#=obj.id#)" maxlength="3" autocomplete="off" value="(#=obj.duration#)" disabled="disabled"></td>
    <td class="gdfCell text-center"><input type="text" name="progress" class="validated" entrytype="PERCENTILE" autocomplete="off" value="(#=obj.progress?obj.progress:''#)" (#=obj.progressByWorklog?"readOnly":""#)></td>
    <td class="gdfCell requireCanSeeDep text-center"><input type="text" id="depends_(#=obj.id#)" name="depends" data-accept="-1" autocomplete="off" value="(#=obj.depends#)" (#=obj.hasExternalDep?"readonly":""#)></td>
    <td class="gdfCell taskAssigs resources" data-parent-id="(#=obj.parentTaskId#)" id="resources_html_(#=obj.id#)" data-is-empty="(#=obj.getAssigsString()==''?1:0#)">(#=obj.getAssigsString()#)</td>
  </tr>
  -->
        </div>

        <div class="__template__" type="TASKEMPTYROW">
            <!--
  <tr class="taskEditRow emptyRow" >
    <th class="gdfCell" align="right"></th>
    <td class="gdfCell noClip" align="center"></td>
    <td class="gdfCell hidden-column"></td>
    <td class="gdfCell hidden-column" ></td>
    <td class="gdfCell hidden-column"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell"></td>
    <td class="gdfCell requireCanSeeDep"></td>
    <td class="gdfCell"></td>
  </tr>
  -->
        </div>

        <div class="__template__" type="TASKBAR">
            <!--
  <div class="taskBox taskBoxDiv" taskId="(#=obj.id#)" >
    <div class="layout (#=obj.hasExternalDep?'extDep':''#)">
      <div class="taskStatus" status="(#=obj.status#)"></div>
      <div class="taskProgress" style="width:(#=obj.progress>100?100:obj.progress#)%; background-color:(#=obj.progress>100?'red':'rgb(153,255,51);'#);"></div>
      <div class="milestone (#=obj.startIsMilestone?'active':''#)" ></div>

      <div class="taskLabel"></div>
      <div class="milestone end (#=obj.endIsMilestone?'active':''#)" ></div>
    </div>
  </div>
  -->
        </div>

        <div class="__template__" type="CHANGE_STATUS">
            <!--
    <div class="taskStatusBox">
    <div class="taskStatus cvcColorSquare" status="STATUS_A" title="Active"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_C" title="Completed"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_I" title="Inactive"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_WAITING" title="Waiting" style="display: none;"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_H" title="Hold"></div>
    </div>
  -->
        </div>

        <!--<div id="old_change_status"  style="display:none">
 
    <div class="taskStatusBox">
    <div class="taskStatus cvcColorSquare" status="STATUS_A" title="Active"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_C" title="Completed"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_V" title="Void"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_I" title="Inactive"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_WAITING" title="Waiting" style="display: none;"></div>
    <div class="taskStatus cvcColorSquare" status="STATUS_H" title="Hold"></div>
    </div>
  </div> -->

        <div class="__template__" type="TASK_EDITOR">
            <!--
<div class="ganttTaskEditor (#=obj.readOnly==1?'msp-task':''#)">
    <h2 class="taskData">Task (#=obj.readOnly==1?'Details':'Editor'#)</h2>
    <ul class="nav nav-tabs nav-justified taskNavHeader" style="display:none">
      <li role="presentation" id="tab_basic" class="active"><a data-toggle="tab" href="javascript:tabClick('basic')">Basic Info</a></li>
      <li role="presentation" id="tab_comments"><a data-toggle="tab" href="javascript:tabClick('comments')">Comments & discussion</a></li>
    </ul>
    
    <div id="editorErrorContainer" style="display:none"></div>
    <div class="tab-content">
    <br/>
    <br/>
      <div id="panel_basic" class="tab-pane task-(#=obj.status#) fade in active">
        <table id="taskDataTable"  cellspacing="1" cellpadding="5" width="100%" class="taskData table" border="0">
            <tr>
             <td colspan="4" style="display:none"  valign="top">
                <label for="code">code/short name</label><br>
                <input type="text" name="code" id="code" value="" size=15 class="formElements" autocomplete='off' maxlength=255 style='width:100%' oldvalue="1">
            </td>
            
            </tr>
                <tr>
            <td colspan="4" valign="top"><label for="name" class="required">Task Name</label><br><input type="text" name="name" id="name"class="formElements" autocomplete='off' maxlength=200 style='width:100%' value="" required="true" oldvalue="1"></td>
                </tr>


            <tr class="dateRow">
            <td nowrap="">
                <div style="position:relative">
                <label for="start">Start Date</label>&nbsp;&nbsp;&nbsp;&nbsp;
                <input class="gdfHidden" style="display:none" type="checkbox" id="startIsMilestone" name="startIsMilestone" value="yes"> &nbsp;<label for="startIsMilestone" style="display:none" class="gdfHidden">is milestone</label>&nbsp;
                <br><input type="text" name="start" id="start" size="8" class="formElements dateField validated date" autocomplete="off" maxlength="255" value="" oldvalue="1" entrytype="DATE">
                <span title="calendar"  id="starts_inputDate" class="teamworkIcon openCalendar" onclick="$(this).dateField({inputField:$(this).prevAll(':input:first'),isSearchField:false});">m</span>          </div>
            </td>
            <td nowrap="">
                <label for="end">End Date</label>&nbsp;&nbsp;&nbsp;&nbsp;
                <input class="gdfHidden" style="display:none" type="checkbox" id="endIsMilestone" name="endIsMilestone" value="yes"> &nbsp;<label for="endIsMilestone" style="display:none" class="gdfHidden">is milestone</label>&nbsp;
                <br><input type="text" name="end" id="end" onblur="changePlannedEfforts()" size="8" class="formElements dateField validated date" autocomplete="off" (#=obj.parentTaskId==0?'readOnly="readOnly"':''#) maxlength="255" value="" oldvalue="1" entrytype="DATE">
                <span title="calendar" id="ends_inputDate" class="teamworkIcon openCalendar" onclick="$(this).dateField({inputField:$(this).prevAll(':input:first'),isSearchField:false});">m</span>
            </td>
            <td nowrap="" colspan="2">
                <label for="duration" class=" ">Duration <small>(In Days) - (#=obj.defautlWorkHours#) Hrs/day</small></label><br>
                <input type="text" name="duration" id="duration" size="4" class="formElements validated durationdays" title="Duration is in working days." autocomplete="off" maxlength="255" value="" oldvalue="1" readonly entrytype="DURATIONDAYS">&nbsp;
            </td>
            </tr>

            <tr>
            <td>
                <label for="status">Status</label><br>
                <select id="status" name="status" class="taskStatus" status="(#=obj.status#)" onchange="$(this).attr('STATUS', $(this).val());MakeActiveAll(this,'(#=obj.status#)');">
                    <option value="A" class="taskStatus" selected="(#=obj.status == 'A'?'selected':''#)" status="A">Active</option>
                    <option value="C" class="taskStatus" selected="(#=obj.status == 'C'?'selected':''#)" status="C">Completed</option>
                    <option value="V" class="taskStatus" selected="(#=obj.status == 'V'?'selected':''#)" status="V">Void</option>
                    <option value="NV" class="taskStatus" selected="(#=obj.status == 'NV'?'selected':''#)" status="NV">Not Void</option>
                    <option value="I" class="taskStatus" selected="(#=obj.status == 'I'?'selected':''#)" status="I">Inactive</option>
                    <option value="H" class="taskStatus" selected="(#=obj.status == 'H'?'selected':''#)" status="H">Hold</option>
                    <option value="R" class="taskStatus" selected="(#=obj.status == 'R'?'selected':''#)" status="R">Un Hold</option>
                </select>
            </td>
            <td valign="top" nowrap>
                <label>Planned Work Hours</label><br>
                <input type="text" name="effort" id="effort" size="7" class="formElements validated percentile" autocomplete="off" maxlength="255" value="" data-is-parent="(#=obj.parentTaskId==0?1:0#)" oldvalue="1"  (#=obj.parentTaskId==0?'readOnly':''#) >
            </td>
            <td valign="top" nowrap>
                <label>Progress</label><br>
                <input type="text" name="progress" id="progress" size="7" class="formElements validated percentile" autocomplete="off" maxlength="99" value="" oldvalue="1" entrytype="PERCENTILE" readOnly>
            </td>
             <td valign="top" nowrap>
                <label for="unit" class="gdfHidden (#=obj.showUnit?'':'hidden-column'#)">Unit</label>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" name="isBillable" id="isBillable" value="(#=obj.isBillable?1:0#)" (#=obj.isBillable?'checked':''#)/> &nbsp;<label for="isBillable" class="gdfHidden">Is Billable</label>&nbsp;<br/>
                <input type="textbox" id="unit" name="unit" maxlength="4" class="gdfHidden (#=obj.showUnit?'gdfSmallInput':'hidden-column'#)"/>&nbsp;<select id="unitType" name="unitType" class="gdfHidden (#=obj.showUnit?'':'hidden-column'#)"></select>
            </td>
            </tr>  
            <tr>
              <td colspan="4">
                  <label for="description">Description</label><br>
                  <textarea rows="3" cols="30" onKeyDown="textCounter(this,499);" onKeyUp="textCounter(this,499);"  id="description" name="description" class="formElements" on style="width:100%"></textarea>
              </td>
            </tr> 
            <tr>
              <td colspan="4" id="projectDrowpDownContainer" class="(#=obj.parentTaskId == 0 ? '':'gray-out'#)" data-parent-task-id="(#=obj.parentTaskId#)">
              </td>
            </tr> 
            
                
            </table>
        
        <div id="task_custom_fields" style="display:none">
            
        </div>
        
        <h2 class="assignTableHeader">Assignments</h2>
        <table  cellspacing="1" cellpadding="0" width="100%" id="assigsTable">
        <tr>
            <th style="width:100px;">Name</th>
        </tr>
        </table>

        
      </div>
      <div id="panel_comments" class="tab-pane fade" style="display:none">
        Comments & discussion 
      </div>
      
      <div style="text-align: right; padding-top: 20px; padding-bottom:20%;">
            <input type="hidden" name="parentTaskId" value="(#=obj.parentTaskId?obj.parentTaskId:0#)" />
            <span id="saveButton" class="button first" onClick="customSaveTask(this)">Save</span>
        </div>
    </div>
</div>
-->
        </div>



        <div class="__template__" type="ASSIGNMENT_ROW">
            <!--
  <tr taskId="(#=obj.task.id#)" assId="(#=obj.assig.id#)" class="assigEditRow" >
    <td colsplan="2"><select name="resourceId" id="resourceId"  class="formElements"></select></td> 
  </tr>
  -->
        </div>



        <div class="__template__" type="RESOURCE_EDITOR">
            <!--
  <div class="resourceEditor" style="padding: 5px;">

    <h2>Project team</h2>
    <table  cellspacing="1" cellpadding="0" width="100%" id="resourcesTable">
      <tr>
        <th style="width:100px;">name</th>
        <th style="width:30px;" id="addResource"><span class="teamworkIcon hidden-column" style="cursor: pointer;">+</span></th>
      </tr>
    </table>

    <div style="text-align: right; padding-top: 20px"><button id="resSaveButton" class="button big hidden-column">Save</button></div>
  </div>
  -->
        </div>



        <div class="__template__" type="RESOURCE_ROW">
            <!--
  <tr resId="(#=obj.id#)" class="resRow" >
    <td ><input type="text" name="name" value="(#=obj.name#)" style="width:100%;" class="formElements"></td>
    <td align="center"><span class="teamworkIcon hidden-column delRes del" style="cursor: pointer">d</span></td>
  </tr>
  -->
        </div>

        <div class="__template__" id="dependConfirmation" type="DEPENDS_CONFIRMATION">
            <!--
  <div>
        <h2>Dependency Confirmation</h2>
        <label>Current Start Date</label>  : <b>(#=obj.curStartDate#)</b><br/>
        <label>New Start Date</label>  : <b>(#=obj.newStartDate#)</b><br/><br/>
        <label>Current End Date</label>  : <b>(#=obj.curEndDate#)</b><br/>
        <label>New End Date</label>  : <b>(#=obj.newEndDate#)</b><br/><br/>
        
        <div style="text-align: right; padding-top: 20px">
            <span class="button first" onClick="$('#depends_(#=obj.taskId#)').attr('accept','1');$('#depends_(#=obj.taskId#)').attr('data-accept','1').trigger('blur');reflectDependancy('(#=obj.taskId#)','(#=obj.dependTaskId#)','(#=obj.duration#)');closeBlackPopup();removeAssigns('(#=obj.taskId#)','(#=obj.delResources#)','(#=obj.status#)');">Ok & Accept</span>
            <span class="button second" onClick="$('#depends_(#=obj.taskId#)').val('');closeBlackPopup();">Cancel</span>
        </div>
  </div>
  -->
        </div>

        <%-- Commented by Vaijat K Issue Id :- 24552 --%>
        <%--<label>Current Allocated Resources</label>  : <b>(#=obj.curResources#)</b><br/>
        <label>New Allocated Resources</label>  : <b>(#=obj.newResources#)</b><br/>--%>

        <div class="__template__" type="CUSTOM_FIELD_CONTAINER">
            <!--
    <h3 class="assignTableHeader">Additional Custom Info</h3>
    <table id="tblCustomFieldContainer">
      <tr id="tblCustomFieldRow1">
          <td id="tdCustomFieldCell_1_1"></td>
          <td id="tdCustomFieldCell_1_2"></td>
          <td id="tdCustomFieldCell_1_3"></td>
      </tr>
      <tr id="tblCustomFieldRow2">
          <td id="tdCustomFieldCell_2_1"></td>
          <td id="tdCustomFieldCell_2_2"></td>
          <td id="tdCustomFieldCell_2_3"></td>
      </tr>
      <tr id="tblCustomFieldRow3">
          <td id="tdCustomFieldCell_3_1"></td>
          <td id="tdCustomFieldCell_3_2"></td>
          <td id="tdCustomFieldCell_3_3"></td>
      </tr>
      <tr id="tblCustomFieldRow4">
          <td id="tdCustomFieldCell_4_1"></td>
          <td id="tdCustomFieldCell_4_2"></td>
          <td id="tdCustomFieldCell_4_3"></td>
      </tr>
      <tr id="tblCustomFieldRow5">
          <td id="tdCustomFieldCell_5_1"></td>
          <td id="tdCustomFieldCell_5_2"></td>
          <td id="tdCustomFieldCell_5_3"></td>
      </tr>
  </table>
  -->
        </div>
        <div class="__template__" type="CUSTOM_FIELD_DATE">
            <!--
  <div  class="gdf-custom-field-column">
      <label for="(#=obj.DatabaseFieldName#)">(#=obj.NotBlank == 1?'<b>*</b>':''#)(#=obj.UserGivenCaption#)</label><br>
      <input style="(#=obj.style#)" type="text" id="(#=obj.DatabaseFieldName#)" name="(#=obj.DatabaseFieldName#)" data-caption="(#=obj.UserGivenCaption#)" class="custom-field custom-field-data" name="customDate(#=obj.UniqueId#)" id="customDate(#=obj.UniqueId#)" size="8" class="formElements dateField date custom-field custom-field-text" autocomplete="off" maxlength="255" height="(#=obj.ControlHeight#)" width="(#=obj.ControlWidth#)" value="(#=obj.valueHtml#)" oldvalue="1" entrytype="DATE"> <span title="calendar" id="starts_inputDate(#=obj.UniqueId#)" class="teamworkIcon openCalendar" onclick="$(this).dateField({inputField:$(this).prevAll(':input:first'),isSearchField:false});">m</span>
  </div>
  -->
        </div>

        <div class="__template__" type="CUSTOM_FIELD_COMBO">
            <!--
  <div class="gdf-custom-field-column">
      <label for="(#=obj.DatabaseFieldName#)">(#=obj.NotBlank == 1?'<b>*</b>':''#)(#=obj.UserGivenCaption#)</label><br>
      <select style="(#=obj.style#)" id="(#=obj.DatabaseFieldName#)" name="(#=obj.DatabaseFieldName#)" data-caption="(#=obj.UserGivenCaption#)" class="custom-field custom-field-dropdown formElements" (#=obj.NotBlank == 1?'data-valid-not-blank':''#) height="(#=obj.ControlHeight#)" width="(#=obj.ControlWidth#)">
          (#=obj.valueHtml#)
      </select>
  </div>
  -->
        </div>
        <div class="__template__" type="CUSTOM_FIELD_TEXTAREA">
            <!--
  <div class="gdf-custom-field-column">
      <label for="(#=obj.DatabaseFieldName#)">(#=obj.NotBlank == 1?'<b>*</b>':''#)(#=obj.UserGivenCaption#)</label><br>
      <textarea style="(#=obj.style#)" id="(#=obj.DatabaseFieldName#)" name="(#=obj.DatabaseFieldName#)" data-caption="(#=obj.UserGivenCaption#)" class="formElements custom-field custom-field-textarea" (#=obj.NotBlank == 1?'data-valid-not-blank':''#) (#=obj.validateMaxLength == 1?'data-valid-max-length':''#) (#=obj.NumericData == 1?'data-valid-is-numeric':''#) (#=obj.PositiveNumericData == 1?'data-valid-is-positive-number':''#) (#=obj.OnlyAlphabets == 1?'data-valid-is-only-alphabates':''#) (#=obj.RestrictSpecialCharacters == 1?'data-valid-no-spacial-chars':''#) (#=obj.MinimumValueCheck == 1?'data-valid-check-min-val':''#) (#=obj.MaximumValueCheck == 1?'data-valid-check-max-val':''#) (#=obj.MaximumValueCheck == 1?'data-valid-check-range':''#) data-max-value=(#=obj.MaxValue#) data-min-value=(#=obj.MinValue#) value="(#=obj.DefaultValue#)" height="(#=obj.ControlHeight#)" width="(#=obj.ControlWidth#)" style="(#=obj.style#)">(#=obj.valueHtml#)</textarea>
  </div>
  -->
        </div>

        <div class="__template__" type="CUSTOM_FIELD_TEXT">
            <!--
  <div class="gdf-custom-field-column">
      <label for="(#=obj.DatabaseFieldName#)">(#=obj.NotBlank == 1?'<b>*</b>':''#)(#=obj.UserGivenCaption#)</label><br>
      <input style="(#=obj.style#)" id="(#=obj.DatabaseFieldName#)" name="(#=obj.DatabaseFieldName#)" data-caption="(#=obj.UserGivenCaption#)" type="text" class="formElements custom-field custom-field-text" (#=obj.NotBlank == 1?'data-valid-not-blank':''#) (#=obj.validateMaxLength == 1?'data-valid-max-length':''#) (#=obj.NumericData == 1?'data-valid-is-numeric':''#) (#=obj.PositiveNumericData == 1?'data-valid-is-positive-number':''#) (#=obj.OnlyAlphabets == 1?'data-valid-is-only-alphabates':''#) (#=obj.RestrictSpecialCharacters == 1?'data-valid-no-spacial-chars':''#) (#=obj.MinimumValueCheck == 1?'data-valid-check-min-val':''#) (#=obj.MaximumValueCheck == 1?'data-valid-check-max-val':''#) (#=obj.MaximumValueCheck == 1?'data-valid-check-range':''#) data-max-value=(#=obj.MaxValue#) data-min-value=(#=obj.MinValue#) value="(#=obj.valueHtml#)"  (#=obj.MaximumValueCheck == 1?'data-valid-check-range':''#) data-max-value=(#=obj.MaxValue#) (#=obj.size#) />
  </div>
  -->
        </div>


        <div class="__template__" type="IMPORT_TASKTYPE_COMBO">
            <!--
    <div class="gdf-import-field-column">
      <label for="(#=obj.name#)">(#=obj.name#)</label><br>
      <select id="(#=obj.name#)" name="(#=obj.name#)" class="import-field import-field-dropdown formElements">
        (#=obj.value#)
      </select>
    </div>-->
        </div>

        <div class="__template__" type="IMPORT_TASK">
            <!--
<div class="ganttTaskEditor">
    <h2 class="taskData">Import Task From File</h2>
<ul class="gdf-breadcrumb">
  <li><a href="#" class="active" id="importEditor_step1_link">Step 1</a></li>
  <li><a href="#" id="importEditor_step2_link">Step 2</a></li>
  <li><a href="#" id="importEditor_step3_link">Step 3</a></li>
</ul>
    <div id="importEditor_step1">
        <input type="file" id="fileUpload" />
        <div class="bottom-step">
            <input type="button" class="button first" id="upload" value="Upload" onclick="excelUpload()" />
        </div> 
    </div>
    <div id="importEditor_step2" style="display:none">
        <div id="importTaskTableContainer" class="gdf-import-task-container">
            
        </div>
        <div class="bottom-step">
            <input type="button" class="button" value="Back" onclick="gotoImportStep1()" /> 
            <input type="button" class="button first" onclick="gotoImportStep3()" value="Next" /> 
        </div>
    </div>
    <div id="importEditor_step3" style="display:none">
        <table id="importEditorDetails">
            <thead></thead>
            <tbody></tbody>
        </table>
        <div class="bottom-step">
            <input type="button" class="button" value="Back" onclick="gotoImportStep2()" /> 
            <input type="button" class="button first" onclick="confirmUpload()" value="Confirm" />
        </div> 
    </div>
</div>-->
        </div>

    </div>


    <div id="tableExportContainer" style="display: none">
        <table id="tblExport">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

        <div class="modal fade" id="divPrerequisites" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="col-sm-11">
                        <h5 class="modal-title" style="color: maroon;" id="IdheaderCustom">Prerequisites</h5>
                    </div>
                    <div class="col-sm-1">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" title="Close" data-toggle='tooltip' data-placement='bottom'>
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
                <div class="modal-body" style="border:0px;">
                    <table class="table table-hover" id="tblPrerequisites">
                        <tbody>
                            <tr id="tr_0">
                                <td><span class="glyphicon glyphicon-plus addBtn" id="addBtnRemove_0" style="color: #3c8dbc!important"></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>

</html>

