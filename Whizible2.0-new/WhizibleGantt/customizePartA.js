// ***************** Second Part *********************
var ge;
var taskProgress;
var taskType = true;
var taskStatus = true;
var currentAssigns = []
var sprintData = {}
var userStoryData = {}
var minHoursForDAEntry = ''; // for Hour:Minute format
var currentProjectSprintId = 0
var projectStartDate;
var projectEndDate;
var projectHours = 0;
var taskHours = 0;
var hiddenColumns = {};
var projectResources = {};
var ganttResourceList = {};
var taskRowMapArr = {};

hiddenColumns['taskNum'] = hiddenColumns['taskNum'] || 1;
hiddenColumns['duration'] = hiddenColumns['duration'] || 1;
hiddenColumns['description'] = hiddenColumns['description'] || 1;
hiddenColumns['resources'] = hiddenColumns['resources'] || 0;
hiddenColumns['startm'] = hiddenColumns['startm'] || 1;
hiddenColumns['endm'] = hiddenColumns['endm'] || 1;

var listTaskType = {}
listTaskType['TaskName'] = "Task Name";
listTaskType['EmployeeName'] = "Employee Name";
listTaskType['StartDate'] = "Start Date";
listTaskType['EndDate'] = "End Date";
listTaskType['Effort'] = "Work (H:M)";
listTaskType['TaskType'] = "Task Type";
listTaskType['Priority'] = "Priority";
listTaskType['Phase'] = "Phase";
listTaskType['Module'] = "Module";
listTaskType['SubProject'] = "Sub Project";
listTaskType['Deliverable'] = "Deliverable";
listTaskType['Milestone'] = "Milestone";
listTaskType['SubTaskTypes'] = "Sub Task Types";
listTaskType['IsBillable'] = "Billable";

var intendedTaskList = {}
var dependencyTaskList = {}
function updateIndent(taskId, currLevel, newLevel, parentTaskId) {
    var taskKey = 'change_task_' + taskId.toString()
    var boolIsExisting = (taskKey in intendedTaskList)
    var indentObj = {
        'orig': boolIsExisting ? intendedTaskList[taskKey]['orig'] : currLevel,
        'old': currLevel,
        'new': newLevel
    }

    if (newLevel == 0) {
        $('#plan_effort_' + taskId).attr('readOnly', 'true')
        $('#plan_effort_' + taskId).attr('data-parent-id', 0)
        $('#resources_html_' + taskId).attr('data-parent-id', 0)
    } else {
        $('#plan_effort_' + taskId).removeAttr('readOnly')
        $('#plan_effort_' + taskId).attr('data-parent-id', parentTaskId)
        $('#resources_html_' + taskId).attr('data-parent-id', parentTaskId)
    }
    reCalculateParentWorkHours(parentTaskId)
    intendedTaskList[taskKey] = indentObj
}

function getParentTaskHours(parentTaskId) {

    var parentTaskMin = 0
    //Commented And Added By Vaijat K For excluding inactive task work hours
    //$('input[name="planefforts"][data-parent-id="' + parentTaskId + '"]').each(function (index, item) {
    $('input[name="planefforts"][data-parent-id="' + parentTaskId + '"]:not(.inactiveInput)').each(function (index, item) {
        //end Commented And Added By Vaijat K For excluding inactive task work hours
        //console.log($(item).val());
        parentTaskMin += taskHoursToMin($(item).val())
    })
    //console.log(  parentTaskMin  )
    return minToHHMM(parentTaskMin);
}

function reCalculateParentWorkHours(parentTaskId) {
    if (parentTaskId != 0) {

        $('#plan_effort_' + parentTaskId).val(getParentTaskHours(parentTaskId))
    }

    windowTaskHours = 0
    $('input[name="planefforts"][data-parent-id="0"]').each(function (index, item) {
        windowTaskHours += taskHoursToMin($(item).val())
    })
    window.taskHours = minToHHMM(windowTaskHours)

    //Added By Vaijat K
    return getParentTaskHours(parentTaskId)
}

function deleteConfirm() {
    //Added By Vaijat K For Delete Task Issue
    if ($('.taskEditRow.rowSelected input.taskname').length == 0) return false;
    //End Added By Vaijat K For Delete Task Issue
    if ($('.taskEditRow.rowSelected input.taskname').val() == '') return false;
    if (false == window.projectList[$('#cmbProject').val()].projectCanDelete) {
        alert('You does not have permission to delete task.');
        return false
    }
    if ($('.taskEditRow:not(.emptyRow)').length == 0) {
        alert('Project Does not having any task to delete.');
        return false;
    }
    window.deleteConfirmClicked = true
    var boolResponse = confirm("Are you sure to delete the task?");
    if (boolResponse == true) { $('#workSpace').trigger('deleteFocused.gantt'); } else { window.deleteConfirmClicked = false; }
    return false;
}

// ************* Part 3rd *****************
function hideColumns() {
    $('.hidden-column').removeClass('hidden-column');
    for (let [key, value] of Object.entries(window.hiddenColumns)) {
        if (value == 1) {
            $('.' + key).addClass('hidden-column');
        }
    }
    reCalculateParentWorkHours(0)
}

function hideCell(elemChk) {
    window.hiddenColumns[$(elemChk).data('id')] = ($(elemChk).prop("checked") == true) ? 0 : 1;
    hideColumns()
}
//************ Export To Excel ****************8
function extortToXsl() {
    if ($('.taskEditRow:not(.emptyRow)').length == 0) {
        alert('Project Does not have any task to Export.');
        return false;
    }
    // $('.taskEditRow:not(.emptyRow)').each(function (index, value) {
    //     console.log(index + ": " + value);
    // });
    var boolshowNum = (parseInt(hiddenColumns['taskNum']) == 0);
    var boolshowDesc = (parseInt(hiddenColumns['description']) == 0);
    var boolshowDur = (parseInt(hiddenColumns['duration']) == 0);

    var htmlExpHead = '<tr>';
    htmlExpHead += boolshowNum ? '<th class="diff-num">Task Number</th>' : '';
    htmlExpHead += '<th>Task Name</th>';
    htmlExpHead += boolshowDesc ? '<th class="diff-desc">Task Description</th>' : '';
    htmlExpHead += '<th>Start Date</th>';
    htmlExpHead += '<th>End Date</th>';
    htmlExpHead += '<th>Planned Work Hours</th>';
    htmlExpHead += boolshowDur ? '<th class="diff-dur">Duration</th>' : '';
    htmlExpHead += '<th>%</th>';
    //Commented And Added By Vaijat K For spelling mistake
    //htmlExpHead += '<th>Dependancy</th>';
    htmlExpHead += '<th>Dependency</th>';
    //End Commented And Added By Vaijat K For spelling mistake
    htmlExpHead += '<th>Resource Name</th>';
    htmlExpHead += '</tr>';

    var htmlExp = ''
    $('.taskEditRow:not(.emptyRow)').each(function (index, value) {

        var taskAssigs = $(value).find('.taskAssigs').html()
        var arrAssign = taskAssigs.split(',')
        var parentStr = $(this).hasClass('isParent') ? '' : '--';
        for (i in arrAssign) {
            htmlExp += '<tr>';
            htmlExp += boolshowNum ? ('<td>' + $(value).find('input[name="task_id"]').val() + '</td>') : '';
            htmlExp += '<td>' + parentStr + $(value).find('input[name="name"]').val() + '</td>';
            htmlExp += boolshowDesc ? ('<td>' + $(value).find('.description').html() + '</td>') : '';
            htmlExp += '<td>' + $(value).find('input[name="start"]').val() + '</td>';
            htmlExp += '<td>' + $(value).find('input[name="end"]').val() + '</td>';
            htmlExp += '<td>' + $(value).find('input[name="planefforts"]').val() + '(HH:MM)</td>';
            htmlExp += boolshowDur ? ('<td>' + $(value).find('input[name="duration"]').val() + '</td>') : '';
            htmlExp += '<td>' + $(value).find('input[name="progress"]').val() + '</td>';
            htmlExp += '<td>' + $(value).find('input[name="depends"]').val() + '</td>';
            htmlExp += '<td>' + arrAssign[i] + '</td>';
            htmlExp += '</tr>';
        }
    });

    $('#tableExportContainer #tblExport thead').html(htmlExpHead).trigger('refresh')
    $('#tableExportContainer #tblExport tbody').html(htmlExp).trigger('refresh')

    var vFileName = $('#cmbProject option:selected').text().replace(/ /g, "_") + '.xls'

    $("#tblExport").table2excel({
        //exclude: ".gdfExclude",
        filename: vFileName, // do include extension
        preserveColors: false // set to true if you want background colors and font colors preserved
    });
}

var mouseX;
var mouseY;
$(document).mousemove(function (e) {
    mouseX = e.pageX;
    mouseY = e.pageY;
});
$(document).bind("mousedown", function (e) {
    // If the clicked element is not the menu
    if (!$(e.target).parents(".context-menu").length > 0) {
        // Hide it
        $(".context-menu").hide(100);
    }
});

window.ge = null
$(function () {
    var canWrite = true; //this is the default for test purposes

    // here starts gantt initialization
    window.ge = new GanttMaster();
    ge.set100OnClose = true;

    ge.shrinkParent = true;

    ge.init($("#workSpace"));
    loadI18n(); //overwrite with localized ones

    //in order to force compute the best-fitting zoom level
    delete ge.gantt.zoom;

    //var project=loadFromLocalStorage();

    //if (!project.canWrite)
    //$(".ganttButtonBar button.requireWrite").attr("disabled","true");

    //ge.loadProject(project);
    //ge.checkpoint(); //empty the undo stack
    //******* Custome *********//
    var currentUserId = sessionUserID;
    loadProject(currentUserId)
    $('#cmbProject').on('change', function () {
        if (this.value) {
            $("#noworkSpace").hide();
            var currProj = window.projectList[this.value]
            window.projectHours = currProj.projectHours;
            window.projectStartDate = currProj.startDate;
            window.projectEndDate = currProj.endDate;
            window.projectWorkHours = currProj.projectWorkHours;
            window.projectCanAdd = currProj.projectCanAdd;
            window.projectCanDelete = currProj.projectCanDelete;
            window.projectCanEdit = currProj.projectCanEdit;
            window.isPassedProject = currProj.isPassedProject;
            window.originalAddAccess = currProj.originalAddAccess;
            window.currentProjectSprintId = currProj.CurrentSprintId;
            window.isOver = currProj.isOver;
            manageProjectAccess(currProj);
            window.minHoursForDAEntry = currProj.MinHoursForDAEntry; // for HH:MM
            getProjectDetail(this.value, currentUserId)
            $('#save_project_btn').removeAttr('disabled')
            if (currProj.isOver) $('#save_project_btn').attr('disabled', 'disabled')

        } else {
            error_msg = "<strong> Hello User !</strong> Please select project to view task.";
            $("#workSpace").hide();
            $("#noworkSpace").show();
            $('#noworkSpace').html(error_msg);
            $("#noworkSpace").addClass("alert alert-info");

            $(".hideSection").hide();
        }

    })

    $('.gdfTable.table.ganttFixHead').find('th').contextmenu(function (e) {
        event.preventDefault();
        $('#context-menu').show();
        $('#context-menu').offset({ 'top': mouseY, 'left': mouseX })
    })


    $('#custom_toggle_task > a.custom-tab-items').on('click', function () {
        if ($(this).data("id") == "all") {
            $('#custom_toggle_task').addClass('slide');
            window.taskIsStatus = false;
            toggleResponse()
        } else {
            $('#custom_toggle_task').removeClass('slide');
            window.taskIsStatus = false;
            toggleResponse()
        }
        $('#custom_toggle_task .custom-tab-items').removeClass('active');
        $('.tab-item-' + $(this).data('id')).addClass('active')
    });

    function toggleProjects(isMSP) {
        var tdGdfCells = $('.gdfTable:not(.table)').find('.gdfCell')
        var tdGdfCellEditIcons = tdGdfCells.find('span.teamworkIcon')
        // var tdGdfCellTaskStatus = tdGdfCells.find('div.taskStatus')
        var tdGdfCellInputs = tdGdfCells.find('input')
        $('div.buttons button.requireCanWrite').show();
        $('#workSpace').removeClass('msp')
        if (false == window.taskType) {
            $('#workSpace').addClass('msp')
            tdGdfCellInputs.attr('disabled', 'disabled')
            $('div.buttons button, #btnImport').attr('disabled', 'disabled')
            //         tdGdfCellTaskStatus.addClass('disabled-link')
            tdGdfCells.attr('disabled', 'disabled')
            //Commented By Vaijat K For issue id :- 26040
            //tdGdfCellEditIcons.hide()
            //End Commetned
            if ($('input.taskname').val() == "Add New Task") $('#tid_-1').hide()
            return false;
        }
        tdGdfCells.removeClass('disabled-link')
        tdGdfCellEditIcons.show()
        $('div.buttons button, #btnImport').removeAttr('disabled')
        // tdGdfCellTaskStatus.removeClass('disabled-link')
        tdGdfCellInputs.removeAttr('disabled')

    }

    $('#custom_toggle_tasktype > a.custom-tab-items').on('click', function () {
        if ($(this).data("id") == "whizible") {
            $('#custom_toggle_tasktype').removeClass('slide');
            window.taskType = true;
            toggleResponse()
            toggleProjects()
        } else {
            $('#custom_toggle_tasktype').addClass('slide');
            window.taskType = false;
            toggleResponse()
            toggleProjects()
        }
        $('#custom_toggle_tasktype .custom-tab-items').removeClass('active');
        $('.tab-item-' + $(this).data('id')).addClass('active')
    });

    // Actual Progress & Actual Efforts
    $('#custom_toggle_progress > a.custom-tab-items').on('click', function () {
        if ($(this).data("id") == "actualprogress") {
            var boolProgress = $('#custom_toggle_task').find('.active').data('id') == 'actualefforts' ? false : true
            if (boolProgress) {
                $('#custom_toggle_progress').addClass('slide');
                $('#custom_toggle_progress .custom-tab-items').removeClass('active');
                $('.tab-item-' + $(this).data('id')).addClass('active')
                window.taskProgress = true;
                toggleResponse()
            }
        } else {
            var boolEfforts = $('#custom_toggle_task').find('.active').data('id') == 'actualprogress' ? false : true
            if (boolEfforts) {
                $('#custom_toggle_progress').removeClass('slide');
                $('#custom_toggle_progress .custom-tab-items').removeClass('active');
                $('.tab-item-' + $(this).data('id')).addClass('active')
                window.taskProgress = false;
                toggleResponse()
            }
        }
    });

    //End Actual Progress & Actual Efforts

    $('[title]').tooltip();

});



function getDemoProject() {
    //console.debug("getDemoProject")
    ret = {
        "tasks": [
            { "id": -1, "name": "Gantt editor", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 0, "status": "STATUS_ACTIVE", "depends": "", "canWrite": true, "start": 1396994400000, "duration": 20, "end": 1399586399999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": true },
            { "id": -2, "name": "coding", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 1, "status": "STATUS_ACTIVE", "depends": "", "canWrite": true, "start": 1396994400000, "duration": 10, "end": 1398203999999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": true },
            { "id": -3, "name": "gantt part", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_ACTIVE", "depends": "", "canWrite": true, "start": 1396994400000, "duration": 2, "end": 1397167199999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },
            { "id": -4, "name": "editor part", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "3", "canWrite": true, "start": 1397167200000, "duration": 4, "end": 1397685599999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },
            { "id": -5, "name": "testing", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 1, "status": "STATUS_SUSPENDED", "depends": "2:5", "canWrite": true, "start": 1398981600000, "duration": 5, "end": 1399586399999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": true },
            { "id": -6, "name": "test on safari", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "", "canWrite": true, "start": 1398981600000, "duration": 2, "end": 1399327199999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },
            { "id": -7, "name": "test on ie", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "6", "canWrite": true, "start": 1399327200000, "duration": 3, "end": 1399586399999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false },
            { "id": -8, "name": "test on chrome", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 2, "status": "STATUS_SUSPENDED", "depends": "6", "canWrite": true, "start": 1399327200000, "duration": 2, "end": 1399499999999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false }
        ], "selectedRow": 2, "deletedTaskIds": [],
        "resources": [
            { "id": "tmp_1", "name": "Resource 1" },
            { "id": "tmp_2", "name": "Resource 2" },
            { "id": "tmp_3", "name": "Resource 3" },
            { "id": "tmp_4", "name": "Resource 4" }
        ],
        "roles": [
            { "id": "tmp_1", "name": "Project Manager" },
            { "id": "tmp_2", "name": "Worker" },
            { "id": "tmp_3", "name": "Stakeholder" },
            { "id": "tmp_4", "name": "Customer" }
        ], "canWrite": true, "canDelete": true, "canWriteOnParent": true, canAdd: true
    }


    //actualize data
    var offset = new Date().getTime() - ret.tasks[0].start;
    for (var i = 0; i < ret.tasks.length; i++) {
        ret.tasks[i].start = ret.tasks[i].start + offset;
    }
    return ret;
}



function loadGanttFromServer(taskId, callback) {

    //this is a simulation: load data from the local storage if you have already played with the demo or a textarea with starting demo data
    var ret = loadFromLocalStorage();

    //this is the real implementation
    /*
    //var taskId = $("#taskSelector").val();
    var prof = new Profiler("loadServerSide");
    prof.reset();
  
    $.getJSON("ganttAjaxController.jsp", {CM:"LOADPROJECT",taskId:taskId}, function(response) {
      //console.debug(response);
      if (response.ok) {
        prof.stop();
  
        ge.loadProject(response.project);
        ge.checkpoint(); //empty the undo stack
  
        if (typeof(callback)=="function") {
          callback(response);
        }
      } else {
        jsonErrorHandling(response);
      }
    });
    */

    return ret;
}


function saveGanttOnServer() {

    $('#save_project_btn').attr('disabled', 'disabled')

    //this is a simulation: save data to the local storage or to the textarea
    saveInLocalStorage();

    /*
    var prj = ge.saveProject();
  
    delete prj.resources;
    delete prj.roles;
  
    var prof = new Profiler("saveServerSide");
    prof.reset();
  
    if (ge.deletedTaskIds.length>0) {
      if (!confirm("TASK_THAT_WILL_BE_REMOVED\n"+ge.deletedTaskIds.length)) {
        return;
      }
    }
  
    $.ajax("ganttAjaxController.jsp", {
      dataType:"json",
      data: {CM:"SVPROJECT",prj:JSON.stringify(prj)},
      type:"POST",
  
      success: function(response) {
        if (response.ok) {
          prof.stop();
          if (response.project) {
            ge.loadProject(response.project); //must reload as "tmp_" ids are now the good ones
          } else {
            ge.reset();
          }
        } else {
          var errMsg="Errors saving project\n";
          if (response.message) {
            errMsg=errMsg+response.message+"\n";
          }
  
          if (response.errorMessages.length) {
            errMsg += response.errorMessages.join("\n");
          }
  
          alert(errMsg);
        }
      }
  
    });
    */
}

function newProject() {
    clearGantt();
}


function clearGantt() {
    ge.reset();
}

//-------------------------------------------  Get project file as JSON (used for migrate project from gantt to Teamwork) ------------------------------------------------------
function getFile() {
    $("#gimBaPrj").val(JSON.stringify(ge.saveProject()));
    $("#gimmeBack").submit();
    $("#gimBaPrj").val("");

    /*  var uriContent = "data:text/html;charset=utf-8," + encodeURIComponent(JSON.stringify(prj));
     neww=window.open(uriContent,"dl");*/
}


function loadFromLocalStorage() {
    var ret;
    if (localStorage) {
        if (localStorage.getObject("teamworkGantDemo")) {
            ret = localStorage.getObject("teamworkGantDemo");
        }
    }

    //if not found create a new example task
    if (!ret || !ret.tasks || ret.tasks.length == 0) {
        ret = getDemoProject();
    }
    return ret;
}

function validateTasks(tasks) {
    // console.log("task validate",task)
    var invalidRowsCount = 0;
    var newPushTask = []
    $('tr.invalidTaskRow').removeClass('invalidTaskRow').trigger('refresh');
    var boolIsAgile = currentProject.isAgile;
    //Commented and Added By Vaijat K For Issue ID :- 
    //var fields = ['effort', 'TaskType', 'Priority', 'Phases', 'Module', 'SubProject', 'Deliverable', 'Milestone', 'SubTaskTypes', 'isBillable'];
    var fields = ['effort', 'TaskType', 'Priority', 'Phases', 'Module', 'Subproject', 'Deliverable', 'Milestone', 'SubTaskTypes', 'isBillable', 'EstimationType', 'ProjectFeature'];
    boolIsAgile && fields.push('Release', 'UserStory', 'Sprint')
    fields.push('ChangeRequest');
    //var fields = ['Priority', 'DeliverableID', 'PhaseId', 'ModuleId', 'SubProjectID', 'MileStoneId', 'ChangeRequestID', 'ProjectFeatureID', 'ProjectEstimationTypeID', 'isBillable'];
    //boolIsAgile && fields.push('NextGen_ReleaseID', 'NextGen_IterationID', 'UserStoryID')

    var indexCount = 0;
    var msgErr = '';
    var currentSprintId = 0;
    for (taskIndex in tasks) {
        var task = tasks[taskIndex]
        task['IsTaskBillable'] = task['isBillable'] ? '1' : '0'
        task['typeId'] = parseInt(task['typeId'])
        task['type'] = task['TaskTypeName']
        task['relevance'] = parseInt(task['relevance'])
        task['duration'] = task['duration'].toString()
        task['taskid'] = task['id'];
        // task['roleId'] = task['roleId'] )
        task['DeliverableID'] = parseInt(task['DeliverableID'])
        task['PhaseID'] = parseInt(task['PhaseID'])
        task['ModuleId'] = parseInt(task['ModuleId'])
        task['SubProjectID'] = parseInt(task['SubProjectID'])
        task['MileStoneId'] = parseInt(task['MileStoneId'])
        task['ChangeRequestID'] = parseInt(task['ChangeRequestID'])
        task['ProjectFeatureID'] = parseInt(task['ProjectFeatureID'])
        task['ProjectEstimationTypeID'] = parseInt(task['ProjectEstimationTypeID'])
        task['NextGen_ReleaseID'] = parseInt(task['NextGen_ReleaseID'])
        task['NextGen_IterationID'] = parseInt(task['NextGen_IterationID'])
        task['UserStoryID'] = parseInt(task['UserStoryID'])
        task['WrokHM'] = task['planefforts']
        task['collapsed'] = task['collapsed'] ? task['collapsed'] : false
        task['wbsid'] = parseInt(task['wbsid'])
        task['taskOrder'] = parseInt(task['wbsid'])//parseInt(task['taskOrder'])
        task['effort'] = task['planefforts']
        task['Unit'] = parseInt(task['Unit'])
        var invalidFieldCount = 0
        //Added By Vaijat K For Validation 
        let current_datetime_1 = new Date()
        current_datetime_1.setTime(task['start'])
        let formatted_date_1 = new Date(current_datetime_1.getFullYear() + "/" + (current_datetime_1.getMonth() + 1) + "/" + current_datetime_1.getDate()).getTime();
        task['start'] = formatted_date_1

        let current_datetime2_1 = new Date()
        current_datetime2_1.setTime(task['end'])
        let formatted_date1_1 = new Date(current_datetime2_1.getFullYear() + "/" + (current_datetime2_1.getMonth() + 1) + "/" + current_datetime2_1.getDate()).getTime();
        task['end'] = formatted_date1_1

        //var actualEfforts = taskHoursToMin(task.actualEfforts)
        //if (actualEfforts != 0 && task.status == 'A') {
        //    var taskParameters = {
        //        TaskId: task.id,
        //        StartDate: new Date(current_datetime_1.getFullYear() + "/" + (current_datetime_1.getMonth() + 1) + "/" + current_datetime_1.getDate()).toLocaleDateString("en-US"),
        //        EndDate: new Date(current_datetime2_1.getFullYear() + "/" + (current_datetime2_1.getMonth() + 1) + "/" + current_datetime2_1.getDate()).toLocaleDateString("en-US")
        //    }

        //    jQuery.ajax({
        //        url: ApiURL['checkTaskActualDates'],
        //        data: JSON.stringify(taskParameters),
        //        dataType: "json",
        //        contentType: "application/json",
        //        type: 'POST',
        //        async: false,
        //        success: function (data) {
        //            if (data != "0") {
        //                invalidRowsCount++
        //                msgErr += "\nDA is already filled for date(s) :- " + data;
        //                $('tr#tid_' + task.id).addClass('invalidTaskRow')
        //            }
        //        },
        //        error: function (xhr, status, error) {
        //            //getTextHtml();
        //            console.log(xhr, status, error)
        //        }
        //    });
        //}
        //EndAdded By Vaijat K For Validation

        //Added By Vaijat K For Validating only active tasks
        if (tasks[taskIndex].level == 1) {
            if (tasks[taskIndex]['assigs'][0].resourceId == 0) {
                msgErr += "\nPlease select resource.";
            }
        }
        if (task['status'] != 'A') {
            let current_datetime = new Date()
            current_datetime.setTime(task['start'])
            let formatted_date = current_datetime.getFullYear() + "/" + (current_datetime.getMonth() + 1) + "/" + current_datetime.getDate()
            task['start'] = formatted_date

            let current_datetime2 = new Date()
            current_datetime2.setTime(task['end'])
            let formatted_date1 = current_datetime2.getFullYear() + "/" + (current_datetime2.getMonth() + 1) + "/" + current_datetime2.getDate()
            task['end'] = formatted_date1

            if (task.level != 0) {
                task['depends'] = getTaskDependancy(task.id, task.parentTaskId)
                delete tasks[taskIndex]['effort'];
                if (tasks[taskIndex]['assigs'] && tasks[taskIndex]['assigs'][0]) {
                    tasks[taskIndex]['assigs'][0]['effort'] = task.planefforts
                    task['resourceId'] = (tasks[taskIndex]['assigs'][0]['resourceId'] != 0) ? parseInt(tasks[taskIndex]['assigs'][0]['resourceId']) : 0
                }

                pushChangedResourceTask(task, newPushTask)
                if (invalidFieldCount != 0) {
                    invalidRowsCount++
                    $('tr#tid_' + task.id).addClass('invalidTaskRow')
                } else {
                    //delete tasks[taskIndex]['effort'];
                    //delete tasks[taskIndex]['assigs']
                }
            }

            task['wbsid'] = indexCount++;
            task['taskOrder'] = parseInt(task['wbsid'])

            continue;
        }

        //End Added By Vaijat K For Validating only active tasks
        var currentSprint = { 'start': 0, 'end': 0, 'efforts': 0 }
        //if (boolIsAgile && !isNaN(task['UserStoryID']) && Object.keys(window.userStoryData).length > 0 && Object.keys(window.sprintData).length > 0 && !window.userStoryData[task['UserStoryID']]) {
        if (boolIsAgile && !isNaN(task['UserStoryID'])) {
            var userstoryData = window.userStoryData[task['UserStoryID']]
            if (userstoryData && Object.keys(userstoryData).length > 0) {
                var taskSprintData = window.sprintData[task['NextGen_IterationID']];
                currentSprintId = window.currentProjectSprintId;//task['NextGen_IterationID'];
                currentSprint['start'] = getTimeInInt(taskSprintData.SprintStDate)
                currentSprint['end'] = getTimeInInt(taskSprintData.SprintEndDate)
                currentSprint.efforts = taskSprintData.SprintEfforts;

            } else {
                //Commented By Vaijat K -- This we need to fix 
                //msgErr += "\n'" + task.name + "' has invalid UserStoryId(" + task['UserStoryID'] + ")!"
                //invalidFieldCount++
            }

        }



        if (parseInt(task['start']) > getTimeInInt(window.projectEndDate)) {
            msgErr += "\n'" + task.name + "' Task start date should not be after Project end date (" + new Date(window.projectEndDate).format('MM/dd/yyyy') + ")!"
            invalidFieldCount++
        } else if (boolIsAgile && currentSprint.start > 0 && currentSprint.end > 0 && (parseInt(task['start']) < parseInt(currentSprint.start))) {
            invalidFieldCount++
            msgErr += "\n'" + task.name + "' Task start date should be within or equal to Sprint start date (" + new Date(parseInt(currentSprint.start)).format('MM/dd/yyyy') + ")!"
        } else if (parseInt(task['start']) < getTimeInInt(window.projectStartDate)) {
            msgErr += "\n'" + task.name + "' Task start date should be within or equal to Project start date (" + new Date(window.projectStartDate).format('MM/dd/yyyy') + ")!"
            invalidFieldCount++
        }

        if (parseInt(task['end']) < getTimeInInt(window.projectStartDate)) {
            msgErr += "\n'" + task.name + "' Task end date should not be before Project start date (" + new Date(window.projectStartDate).format('MM/dd/yyyy') + ")!"
            invalidFieldCount++
        } else if (boolIsAgile && currentSprint.start > 0 && currentSprint.end > 0 && (parseInt(task['end']) > parseInt(currentSprint.end))) {
            msgErr += "\n'" + task.name + "' Task end date should be within or equal to Sprint end date (" + new Date(parseInt(currentSprint.end)).format('MM/dd/yyyy') + ")!"
            invalidFieldCount++
        } else if (parseInt(task['end']) > getTimeInInt(window.projectEndDate, true)) {
            msgErr += "\n'" + task.name + "' Task end date should be within or equal to Project end date (" + new Date(window.projectEndDate).format('MM/dd/yyyy') + ")!"
            invalidFieldCount++
        }
        if (task.level == 1) {
            var taskValidationMsg = isValidWorkHours(task['effort'], task['duration'], $('#plan_effort_' + task['taskid']).attr('data-is-parent'));
            if (taskValidationMsg != "") {
                msgErr += "\n" + taskValidationMsg;
                invalidFieldCount++
            }
        }

        if (boolIsAgile) {
            if (currentSprintId == task['NextGen_IterationID']) {
                if (getCurrentSprintTasksEfforts(task['NextGen_IterationID']) > taskHoursToMin(currentSprint.efforts)) {
                    msgErr += "\nWork Hours should not be greater than Sprint Work Hours[" + currentSprint.efforts + "]. Total work hours entered [" + minToHHMM(getCurrentSprintTasksEfforts(task['NextGen_IterationID'])) + "]";
                }
            }
        }


        let current_datetime = new Date()
        current_datetime.setTime(task['start'])
        let formatted_date = current_datetime.getFullYear() + "/" + (current_datetime.getMonth() + 1) + "/" + current_datetime.getDate()
        task['start'] = formatted_date

        let current_datetime2 = new Date()
        current_datetime2.setTime(task['end'])
        let formatted_date1 = current_datetime2.getFullYear() + "/" + (current_datetime2.getMonth() + 1) + "/" + current_datetime2.getDate()
        task['end'] = formatted_date1

        //task['depends'] = '' //  task['depends_new']?task['depends_new']:'';
        task['wbsid'] = indexCount++;
        task['taskOrder'] = parseInt(task['wbsid'])
        //delete task['depends_new'];

        if (task.level != 0) {
            task['depends'] = getTaskDependancy(task.id, task.parentTaskId)
            delete tasks[taskIndex]['effort'];
            if (tasks[taskIndex]['assigs'] && tasks[taskIndex]['assigs'][0]) {
                tasks[taskIndex]['assigs'][0]['effort'] = task.planefforts
                task['resourceId'] = (tasks[taskIndex]['assigs'][0]['resourceId'] != 0) ? parseInt(tasks[taskIndex]['assigs'][0]['resourceId']) : 0
            }

            pushChangedResourceTask(task, newPushTask)
            if (invalidFieldCount != 0) {
                invalidRowsCount++
                $('tr#tid_' + task.id).addClass('invalidTaskRow')
            } else {
                //delete tasks[taskIndex]['effort'];
                //delete tasks[taskIndex]['assigs']
            }
            continue
        }
        task['planefforts'] = getParentTaskHours(task['id'])
        task['WrokHM'] = task['planefforts']
        var curMandatoryDropdown = ['effortMandatoryInAT']
        for (i in currentProject.mandatoryDropDown) {
            curMandatoryDropdown.push(currentProject.mandatoryDropDown[i])
        }

        //Added By Vaijat K For Issue Id :- 26021
        if (!boolIsAgile) {
            var releaseIndex = curMandatoryDropdown.indexOf('ReleaseMandatoryInAT');
            if (releaseIndex != -1)
                curMandatoryDropdown.splice(releaseIndex, 1);
            var usIndex = curMandatoryDropdown.indexOf('UserStoryMandatoryInAT');
            if (usIndex != -1)
                curMandatoryDropdown.splice(usIndex, 1)
            var sIndex = curMandatoryDropdown.indexOf('SprintMandatoryInAT');
            if (sIndex != -1)
                curMandatoryDropdown.splice(sIndex, 1)
        }
        //End Added By Vaijat K For Issue Id :- 26021
        
        for (i in fields) {

            var field = fields[i]
            var keyField = field + "MandatoryInAT"
            var keyIndex = curMandatoryDropdown.indexOf(keyField)
            //Added By Vaijat K For Issue Id :- 26021
            if (keyIndex == -1) {
                continue;
            }
            //End Added By Vaijat K For Issue Id :- 26021
            if (keyIndex == -1 & (field == 'Priority' || field == 'Phases')) {
                keyField = field + "MandatoryInAT"
                keyIndex = curMandatoryDropdown.indexOf(keyField)
            }

            if (!task[field] && (field == 'Priority' || field == 'Phases' || field == 'EstimationType' || field == 'ProjectFeature')) {
                if (field == 'Priority') field = 'PriorityID'
                if (field == 'Phases') field = 'PhaseID'
                if (field == 'EstimationType') field = 'ProjectEstimationTypeID'
                if (field == 'ProjectFeature') field = 'ProjectFeatureID'
            }

            //Added By Vaijat K For Validation Issue
            if (field == 'Module') field = 'ModuleId'
            if (field == 'Subproject') field = 'SubProjectID'
            if (field == 'Deliverable') field = 'DeliverableID'
            if (field == 'Milestone') field = 'MileStoneId'
            if (field == 'Release') field = 'NextGen_ReleaseID'
            if (field == 'UserStory') field = 'UserStoryID'
            if (field == 'Sprint') field = 'NextGen_IterationID'
            if (field == 'ChangeRequest') { curMandatoryDropdown.splice(keyIndex, 1); continue; }
            //End Added By Vaijat K For Validation Issue
            
            if (task[field] && (task[field] != 0 && task[field] != '') && keyIndex > -1) {
                
                curMandatoryDropdown.splice(keyIndex, 1)
            }
        }
        
        invalidFieldCount = invalidFieldCount + curMandatoryDropdown.length;
        for (var i = 0; i < curMandatoryDropdown.length; i++) {
            msgErr += "\n Field is mandatory ['" + curMandatoryDropdown[i].replace("MandatoryInAT", "") + "'] For Task :-" + task.name;
        }
        var t = window.ge.getTask(task.id);

        if ($('td.gdfCell.taskAssigs.resources[data-parent-id="' + task.id + '"][data-is-empty="1"]').length > 0) {
            msgErr += "\nPlease check  under the parent task '" + t.name + "'";
            invalidFieldCount++
        }

        if (t.getChildren().length == 0) {
            msgErr += "\nPlease add child under the parent task '" + t.name + "'";
            invalidFieldCount++
        }

        if (invalidFieldCount != 0) {
            invalidRowsCount++
            $('tr#tid_' + task.id).addClass('invalidTaskRow')
        } else {
            //delete tasks[taskIndex]['effort'];
            //delete tasks[taskIndex]['assigs']
        }
    }

    //Added By Vaijat K For Project and Sprint Efforts
    if (getTasksEfforts(tasks) > taskHoursToMin(window.projectHours)) {
        msgErr += "\nWork Hours should not be greater than Project Work Hours[" + window.projectHours + "]. Total work hours entered [" + minToHHMM(getTasksEfforts(tasks)) + "]";
        //alert("\nWork Hours should not be greater than Project Work Hours.");
    }

    //End Added By Vaijat K For Project and Sprint Efforts   
    if (msgErr != "") {
        return msgErr;
    }

    for (intIndex in newPushTask) {
        tasks.push(newPushTask[intIndex])
    }
    return tasks
}

function saveInLocalStorage() {
    var prj = ge.saveProject();

    //if (prj['tasks'].length == 0) {
    //    //alert("Please add task before publish.");
    //    return;
    //}

    var prjTask = validateTasks(prj['tasks'])

    if (typeof prjTask != 'object') {
        strMix = 'Please, check the tasks' + prjTask;
        alert(strMix);
        $('#save_project_btn').removeAttr('disabled')
        return false;
    }
    // for(x in prj['tasks']){

    //   let current_datetime = new Date()
    //   current_datetime.setTime(prj['tasks'][x].start )
    //   // let formatted_date = current_datetime.getDate() + "-" + (current_datetime.getMonth() + 1) + "-" + current_datetime.getFullYear()
    //   //     prj['tasks'][x].start = formatted_date

    //   let formatted_date = current_datetime.getFullYear() + "/" + (current_datetime.getMonth() + 1) + "/" + current_datetime.getDate()
    //   prj['tasks'][x].start = formatted_date


    //   let current_datetime2 = new Date()
    //   current_datetime2.setTime(prj['tasks'][x].end )
    //   // let formatted_date1 = current_datetime2.getDate() + "-" + (current_datetime2.getMonth() + 1) + "-" + current_datetime2.getFullYear()
    //   let formatted_date1 = current_datetime2.getFullYear() + "/" + (current_datetime2.getMonth() + 1) + "/" + current_datetime2.getDate()
    //     prj['tasks'][x].end = formatted_date1

    //     prj['tasks'][x].depends=prj['tasks'][x].depends_new?prj['tasks'][x].depends_new:0;
    //     delete prj['tasks'][x].depends_new

    // }

    if (localStorage) {
        localStorage.setObject("teamworkGantDemo", prj);
        var data = new FormData();
        data['projectId'] = currentProject.id
        data['tasks'] = prjTask;
        data['deletedTaskIds'] = prj['deletedTaskIds'];
        data['dependantTasks'] = []
        var intendedTasks = {}
        for (changeTask in window.intendedTaskList) {
            var taskIndex = changeTask.replace('change_task_', '')
            if (taskIndex && window.intendedTaskList[changeTask]['orig'] != window.intendedTaskList[changeTask]['new']) {
                intendedTasks[taskIndex] = window.intendedTaskList[changeTask]['new']
            }
        }

        data['intendedTasks'] = []//intendedTasks;

        jQuery.ajax({
            url: ApiURL['SaveProject'],
            data: JSON.stringify(data),
            cache: false,
            contentType: 'application/json',
            crossDomain: true,
            processData: false,
            type: 'POST',
            complete: function () {
                $('#save_project_btn').removeAttr('disabled')
            },
            success: function (data) {
                getTextHtml();
                // alert(data);
                if (data == 'Success') {
                    alert("All Tasks are published Successfully");
                }

                getProjectDetail(currentProject.id, sessionUserID);
                $('#custom_toggle_tasktype .custom-tab-items').removeClass('active');
                $('.tab-item-active').addClass('active');
                //console.log(data);

            },
            error: function (xhr, status, error) {
                getTextHtml();
                console.log(xhr, status, error)
            }
        });
    } else {
        alert('Cant Save the Data');
    }

}


//-------------------------------------------  Open a black popup for managing resources. This is only an axample of implementation (usually resources come from server) ------------------------------------------------------
function editResources() {

    //make resource editor
    var resourceEditor = $.JST.createFromTemplate({}, "RESOURCE_EDITOR");
    var resTbl = resourceEditor.find("#resourcesTable");

    for (var i = 0; i < ge.resources.length; i++) {
        var res = ge.resources[i];
        resTbl.append($.JST.createFromTemplate(res, "RESOURCE_ROW"))
    }


    //bind add resource
    resourceEditor.find("#addResource").click(function () {
        resTbl.append($.JST.createFromTemplate({ id: "new", name: "resource" }, "RESOURCE_ROW"))
    });

    //bind save event
    resourceEditor.find("#resSaveButton").click(function () {
        var newRes = [];
        //find for deleted res
        for (var i = 0; i < ge.resources.length; i++) {
            var res = ge.resources[i];
            var row = resourceEditor.find("[resId=" + res.id + "]");
            if (row.length > 0) {
                //if still there save it
                var name = row.find("input[name]").val();
                if (name && name != "")
                    res.name = name;
                newRes.push(res);
            } else {
                //remove assignments
                for (var j = 0; j < ge.tasks.length; j++) {
                    var task = ge.tasks[j];
                    var newAss = [];
                    for (var k = 0; k < task.assigs.length; k++) {
                        var ass = task.assigs[k];
                        if (ass.resourceId != res.id)
                            newAss.push(ass);
                    }
                    task.assigs = newAss;
                }
            }
        }

        //loop on new rows
        var cnt = 0
        resourceEditor.find("[resId=new]").each(function () {
            cnt++;
            var row = $(this);
            var name = row.find("input[name]").val();
            if (name && name != "")
                newRes.push(new Resource("tmp_" + new Date().getTime() + "_" + cnt, name));
        });

        ge.resources = newRes;

        closeBlackPopup();
        ge.redraw();
    });


    var ndo = createModalPopup(400, 500).append(resourceEditor);
}

function initializeHistoryManagement() {

    //si chiede al server se c'è della hisory per la root
    $.getJSON(contextPath + "/applications/teamwork/task/taskAjaxController.jsp", { CM: "GETGANTTHISTPOINTS", OBJID: 10236 }, function (response) {

        //se c'è
        if (response.ok == true && response.historyPoints && response.historyPoints.length > 0) {

            //si crea il bottone sulla bottoniera
            var histBtn = $("<button>").addClass("button textual icon lreq30 lreqLabel").attr("title", "SHOW_HISTORY").append("<span class=\"teamworkIcon\">&#x60;</span>");

            //al click
            histBtn.click(function () {
                var el = $(this);
                var ganttButtons = $(".ganttButtonBar .buttons");
                if (!ge.element.is(".historyOn")) {
                    ge.element.addClass("historyOn");
                    ganttButtons.find(".requireCanWrite").hide();

                    //si carica la history server side
                    if (false) return;
                    showSavingMessage();
                    $.getJSON(contextPath + "/applications/teamwork/task/taskAjaxController.jsp", { CM: "GETGANTTHISTPOINTS", OBJID: ge.tasks[0].id }, function (response) {
                        jsonResponseHandling(response);
                        hideSavingMessage();
                        if (response.ok == true) {
                            var dh = response.historyPoints;
                            //ge.historyPoints=response.historyPoints;
                            if (dh && dh.length > 0) {
                                //si crea il div per lo slider
                                var sliderDiv = $("<div>").prop("id", "slider").addClass("lreq30 lreqHide").css({ "display": "inline-block", "width": "500px" });
                                ganttButtons.append(sliderDiv);

                                var minVal = 0;
                                var maxVal = dh.length - 1;

                                $("#slider").show().mbSlider({
                                    rangeColor: '#2f97c6',
                                    minVal: minVal,
                                    maxVal: maxVal,
                                    startAt: maxVal,
                                    showVal: false,
                                    grid: 1,
                                    formatValue: function (val) {
                                        return new Date(dh[val]).format();
                                    },
                                    onSlideLoad: function (obj) {
                                        this.onStop(obj);

                                    },
                                    onStart: function (obj) { },
                                    onStop: function (obj) {
                                        var val = $(obj).mbgetVal();
                                        showSavingMessage();
                                        $.getJSON(contextPath + "/applications/teamwork/task/taskAjaxController.jsp", { CM: "GETGANTTHISTORYAT", OBJID: ge.tasks[0].id, millis: dh[val] }, function (response) {
                                            jsonResponseHandling(response);
                                            hideSavingMessage();
                                            if (response.ok) {
                                                ge.baselines = response.baselines;
                                                ge.showBaselines = true;
                                                ge.baselineMillis = dh[val];
                                                ge.redraw();
                                            }
                                        })

                                    },
                                    onSlide: function (obj) {
                                        clearTimeout(obj.renderHistory);
                                        var self = this;
                                        obj.renderHistory = setTimeout(function () {
                                            self.onStop(obj);
                                        }, 200)

                                    }
                                });
                            }
                        }
                    });


                    // quando si spenge
                } else {
                    //si cancella lo slider
                    $("#slider").remove();
                    ge.element.removeClass("historyOn");
                    if (ge.permissions.canWrite)
                        ganttButtons.find(".requireCanWrite").show();

                    ge.showBaselines = false;
                    ge.baselineMillis = undefined;
                    ge.redraw();
                }

            });
            $("#saveGanttButton").before(histBtn);
        }
    })
}

function showBaselineInfo(event, element) {
    //alert(element.attr("data-label"));
    $(element).showBalloon(event, $(element).attr("data-label"));
    ge.splitter.secondBox.one("scroll", function () {
        $(element).hideBalloon();
    })
}

// ***************** Section Part 2*********************
$.JST.loadDecorator("RESOURCE_ROW", function (resTr, res) {
    resTr.find(".delRes").click(function () { $(this).closest("tr").remove() });
});

$.JST.loadDecorator("ASSIGNMENT_ROW", function (assigTr, taskAssig) {
    var task = taskAssig.task
    if (task.level == 0 && task.msptask == 0) return false;
    var taskResources = taskAssig.task.master.resources
    var allowedResources = (taskAssig && taskAssig.assig && taskAssig.assig.resourceId) ? [taskAssig.assig.resourceId] : []
    
    var prjResource = Object.values(window.projectResources);
    let current_datetime_1 = new Date()
    if (fromDateChange == 0)
        current_datetime_1.setTime(task['start'])
    else
        current_datetime_1 = new Date($("#start").val())
    let formatted_date_1 = new Date(current_datetime_1.getFullYear() + "/" + (current_datetime_1.getMonth() + 1) + "/" + current_datetime_1.getDate());
    
    let current_datetime2_1 = new Date()
    if (fromDateChange == 0)
        current_datetime2_1.setTime(task['end'])
    else
        current_datetime2_1 = new Date($("#end").val())
    let formatted_date1_1 = new Date(current_datetime2_1.getFullYear() + "/" + (current_datetime2_1.getMonth() + 1) + "/" + current_datetime2_1.getDate());
    
    

    for (i in prjResource) {
        var dRStart = new Date();
        var dREnd = new Date();
        dRStart.setTime(prjResource[i].resourceStart);
        dREnd.setTime(prjResource[i].resourceEnd);
        let rstart = new Date(dRStart.getFullYear() + "/" + (dRStart.getMonth() + 1) + "/" + dRStart.getDate());
        let rend = new Date(dREnd.getFullYear() + "/" + (dREnd.getMonth() + 1) + "/" + dREnd.getDate());
        //if ((rend >= (formatted_date_1)) && rstart <= (formatted_date1_1)) {
        if (rstart <= formatted_date_1 && rend >= formatted_date1_1) {
            //Commetned and added by Vaijat K For showing resource in edit mode if released
            //allowedResources.push(parseInt(prjResource[i].id))
            if (String(task.id).indexOf("tmp") == -1 && task.assigs.length > 0) {
                if (task.assigs[0].resourceId != 0)
                    allowedResources.push(parseInt(prjResource[i].id))
            }
            else {
                if (prjResource[i].actualEnd == "")
                    allowedResources.push(parseInt(prjResource[i].id))
            }
            //End Commetned and added by Vaijat K For showing resource in edit mode if released
        }
    }
    window.currentRowNow = assigTr
    var resEl = assigTr.find("[name=resourceId]");
    var opt = $("<option>");
    resEl.append(opt);
    for (var i = 0; i < taskResources.length; i++) {
        if (allowedResources.indexOf(taskResources[i].id) == -1) continue;
        var res = taskResources[i];
        if (taskAssig.assig && taskAssig.assig.resourceId != res.id && window.currentAssigns.indexOf(taskResources[i].id) != -1) continue;

        opt = $("<option>");
        opt.val(res.id).html(res.name);
        if (taskAssig.assig && taskAssig.assig.resourceId == res.id) {
            opt.attr("selected", "true");
            window.currentAssigns.push(res.id)
        }
        resEl.append(opt);
    }
    var roleEl = assigTr.find("[name=roleId]");
    for (var i = 0; i < taskAssig.task.master.roles.length; i++) {
        var role = taskAssig.task.master.roles[i];
        var optr = $("<option>");
        optr.val(role.id).html(role.name);
        if (taskAssig.assig && taskAssig.assig.roleId == role.id)
            optr.attr("selected", "true");
        roleEl.append(optr);
    }

    if (taskAssig.task.master.permissions.canWrite && taskAssig.task.canWrite) {
        assigTr.find(".delAssig").click(function () {
            var tr = $(this).closest("[assId]").fadeOut(200, function () { $(this).remove() });
        });
    }

});

function loadI18n() {
    GanttMaster.messages = {
        "CANNOT_WRITE": "No permission to change the following task:",
        "CHANGE_OUT_OF_SCOPE": "Project update not possible as you lack rights for updating a parent project.",
        "START_IS_MILESTONE": "Start date is a milestone.",
        "END_IS_MILESTONE": "End date is a milestone.",
        "TASK_HAS_CONSTRAINTS": "Task has constraints.",
        "GANTT_ERROR_DEPENDS_ON_OPEN_TASK": "There is a dependency on an open task.",
        "GANTT_ERROR_DESCENDANT_OF_CLOSED_TASK": "Due to a descendant of a closed task.",
        "TASK_HAS_EXTERNAL_DEPS": "This task has external dependencies.",
        "GANNT_ERROR_LOADING_DATA_TASK_REMOVED": "GANNT_ERROR_LOADING_DATA_TASK_REMOVED",
        "CIRCULAR_REFERENCE": "Circular reference.",
        "CANNOT_DEPENDS_ON_ANCESTORS": "Cannot depend on ancestors.",
        "INVALID_DATE_FORMAT": "The data inserted are invalid for the field format.",
        "GANTT_ERROR_LOADING_DATA_TASK_REMOVED": "An error has occurred while loading the data. A task has been trashed.",
        "CANNOT_CLOSE_TASK_IF_OPEN_ISSUE": "Cannot close a task with open issues",
        "TASK_MOVE_INCONSISTENT_LEVEL": "You cannot exchange tasks of different depth.",
        "CANNOT_MOVE_TASK": "CANNOT_MOVE_TASK",
        "PLEASE_SAVE_PROJECT": "PLEASE_SAVE_PROJECT",
        "GANTT_SEMESTER": "Semester",
        "GANTT_SEMESTER_SHORT": "s.",
        "GANTT_QUARTER": "Quarter",
        "GANTT_QUARTER_SHORT": "q.",
        "GANTT_WEEK": "Week",
        "GANTT_WEEK_SHORT": "w."
    };
}

function createNewResource(el) {
    var row = el.closest("tr[taskid]");
    var name = row.find("[name=resourceId_txt]").val();
    var url = contextPath + "/applications/teamwork/resource/resourceNew.jsp?CM=ADD&name=" + encodeURI(name);

    openBlackPopup(url, 700, 320, function (response) {
        //fillare lo smart combo
        if (response && response.resId && response.resName) {
            //fillare lo smart combo e chiudere l'editor
            row.find("[name=resourceId]").val(response.resId);
            row.find("[name=resourceId_txt]").val(response.resName).focus().blur();
        }

    });
}
//*************** Section Part *********************//

window.currentResponse = [];
window.projectList = {};

function buildDropDown(hiddenDropDown, mandatoryDropDown) {

    currentProject = window.projectList[$('#cmbProject').val()]
    strHtml = '';

    Object.keys(window.wbsData).forEach(dropDown => {
        //Added By Vaijat K For Disabling Sprint and Release Dropdown
        var disabled = ""
        if (dropDown == 'Release' || dropDown == 'Sprint') { disabled = "disabled" } else { disabled = "" }
        let mandatoryField = dropDown + 'MandatoryInAT'
        let dropDownField = 'Show' + dropDown + 'InAT'
        strHtml += '<div class="gdf-custom-column' + ((hiddenDropDown && hiddenDropDown.indexOf(dropDownField) != -1) ? ' hidden-column' : '') + '">';

        var strTitle = dropDown == 'Delivarable' ? 'Deliverable' : dropDown == 'Subproject' ? 'Sub Project' : dropDown
        strTitle = strTitle.replace(/([A-Z])/g, ' $1').trim()
        strHtml += '<label for="' + dropDown + '">' + strTitle + ((mandatoryDropDown && mandatoryDropDown.indexOf(mandatoryField) != -1) ? ' <b>*</b>' : '') + '</label><br>';
        strHtml += '<select onChange="changeDependantCombo(this)" id="cmb' + dropDown + '" ' + disabled + ' class="formElements ' + ((mandatoryDropDown && mandatoryDropDown.indexOf(mandatoryField) != -1) ? 'gdf-required' : '') + '" name="' + dropDown + '"></select>';
        strHtml += '</div>'
    })
    return strHtml
}

function generateDropdownHtml(dropDown, selValue, boolIsParent) {
    selValue = selValue || 0
    strDropDownName = dropDown + 'Name';
    strDropDownId = dropDown + 'ID';
    var strExtraHtml = ''

    var strTitle = dropDown == 'Delivarable' ? 'Deliverable' : dropDown == 'Subproject' ? 'Sub Project' : dropDown
    strTitle = strTitle.replace(/([A-Z])/g, ' $1').trim()
    dropDownData = window.wbsData[dropDown]
    if (dropDown != "TaskType")
        strHtml = '<option value="" ' + (selValue == 0 ? 'selected' : (boolIsParent ? '' : 'disabled')) + '> Select ' + strTitle + ' </option>'
    else
        strHtml = '<option value="" ' + (selValue == 0 ? '' : (boolIsParent ? '' : 'disabled')) + '> Select ' + strTitle + ' </option>'
    for (k in dropDownData) {

        x = dropDownData[k]
        if (!x[strDropDownName] || !x[strDropDownId]) continue;

        strExtraHtml = ''
        if (dropDown == 'UserStory') {
            strExtraHtml += ' data-item-sprint-value="' + x['SprintID'] + '"'
            strExtraHtml += ' data-item-release-value="' + x['ReleaseID'] + '"'
        } else if (dropDown == 'Sprint') {
            strExtraHtml += ' data-item-sprint-status="' + x['SprintStatus'] + '"'
            strExtraHtml += ' data-item-sprint-start="' + new Date(x['SprintStDate']).getTime() + '"'
            strExtraHtml += ' data-item-sprint-end="' + new Date(x['SprintEndDate']).getTime() + '"'
            strExtraHtml += ' data-item-sprint-effort="' + x['SprintEfforts'] + '"'
        }

        selectedValueHtml = parseInt(x[strDropDownId]) == parseInt(selValue) ? 'selected' : (boolIsParent ? '' : 'disabled');
        if (dropDown == 'UserStory') {
            //Added By Vaijat K For Issue Id :- 26044
            if (window.currentProjectSprintId == x.SprintID || x[strDropDownId] == selValue)
                strHtml += '<option ' + strExtraHtml + ' value="' + x[strDropDownId] + '" data-item-value="' + selValue + '" ' + selectedValueHtml + '>' + x[strDropDownName] + '</option>'
            //End Added By Vaijat K For Issue Id :- 26044
        }
        else if (dropDown == "TaskType") {
            if (selValue != 0) {
                strHtml += '<option ' + strExtraHtml + ' value="' + x[strDropDownId] + '" data-item-value="' + selValue + '" ' + selectedValueHtml + '>' + x[strDropDownName] + '</option>'
            }
            else {
                strHtml += '<option ' + strExtraHtml + ' value="' + x[strDropDownId] + '" ' + (x.DefaultTaskType == 1 ? "selected":"") + ' data-item-value="' + selValue + '" ' + selectedValueHtml + '>' + x[strDropDownName] + '</option>'
            }
        }
        else {
            strHtml += '<option ' + strExtraHtml + ' value="' + x[strDropDownId] + '" data-item-value="' + selValue + '" ' + selectedValueHtml + '>' + x[strDropDownName] + '</option>'
        }
    }
    return strHtml
}

function getProjectDetail(projectId, userId) {
    var projectWbsUrl = ApiURL['GetWBSForProject'] + '&ProjectId=' + projectId

    $('body').addClass('hideEditIcon').addClass('hideDeleteIcon')
    if (window.projectList[projectId].projectCanDelete == 1) {
        $('body').removeClass('hideDeleteIcon')
    }
    if (window.projectList[projectId].projectCanEdit == 1) {
        $('body').removeClass('hideEditIcon')
    }

    $.ajax({
        url: projectWbsUrl,
        method: 'POST',
        success: function (response) {
            window.wbsData = response[0]
            if ('Sprint' in wbsData) {
                window.sprintData = {}

                for (i in wbsData.Sprint) {
                    window.sprintData[wbsData.Sprint[i]['SprintID']] = window.wbsData.Sprint[i]
                }

            }
            if ('UserStory' in wbsData) {
                window.userStoryData = {}
                for (i in wbsData.UserStory) {
                    window.userStoryData[wbsData.UserStory[i]['UserStoryID']] = window.wbsData.UserStory[i]
                }
            }


            window.ganttResourceList = {}
            getProjectTask(projectId, userId)
        }
    });
}

function getProjectTask(projectId, userId) {
    $('#loadingImg').show();
    $('#wbs-gantt-container').css('visibility', 'visible');
    var projectUrl = ApiURL['GetAssignedTasks'] + '&ProjectId=' + projectId;
    $.ajax({
        url: projectUrl,
        method: 'POST',
        success: function (response) {
            if (response == '') response = [{ tasks: [], resources: [], mspintegration: false }]
            var apiTasks = response[0].tasks;

            $.each(response[0].resources, function (i, v) {

                window.projectResources[v.id] = {
                    'id': v.id,
                    'name': v.name,
                    'resourceStartDate': v.resourceStartDate,
                    'resourceStart': new Date(v.resourceStartDate).getTime(),
                    'resourceEndDate': v.resourceEndDate,
                    'resourceEnd': new Date(v.resourceEndDate).getTime(),
                    'actualEnd': v.ActualEnddate
                }
            })
            if (response) {
                //console.log(apiTasks)
                if (apiTasks != null) {

                    $('#loadingImg').hide();
                    $("#workSpace").show();
                    $(".hideSection").show();

                    window.taskProgress = (response[0].mspintegration ? true : false)
                    if (window.taskProgress) {
                        $('#actualprogress').attr('class', 'tab-item-actualprogress custom-tab-items tab-slider--trigger active')
                        $('#custom_toggle_progress').addClass('slide');
                        $('.tab-item-' + $(this).data('id')).addClass('active')
                        $("#actualefforts").removeClass('active');
                        $('.progress-percent').show();
                        $('.progress-effort').hide();
                    } else {
                        $('#actualefforts').attr('class', ' tab-item-actualefforts custom-tab-items tab-slider--trigger active')
                        $('#custom_toggle_progress').removeClass('slide');
                        $("#actualprogress").removeClass('active');
                        $('.progress-percent').hide();
                        $('.progress-effort').show();
                    }
                    if (apiTasks) {
                        for (var k = 0; k < apiTasks.length; k++) {
                            var TaskID = apiTasks[k].TaskID;
                            var depends = String(apiTasks[k].depends).split(":");
                            if (depends.length > 1)
                                reflectDependancy(TaskID, depends[0], depends[1]);

                            apiTasks[k].TaskType = apiTasks[k].TypeId;
                            apiTasks[k].Phases = apiTasks[k].PhaseID;
                            apiTasks[k].Module = apiTasks[k].ModuleId;
                            apiTasks[k].SubProject = apiTasks[k].SubProjectID;
                            apiTasks[k].Deliverable = apiTasks[k].DeliverableID;
                            apiTasks[k].Milestone = apiTasks[k].MileStoneId;
                            apiTasks[k].Release = apiTasks[k].NextGen_ReleaseID;
                            apiTasks[k].UserStory = apiTasks[k].UserStoryID;
                            apiTasks[k].Sprint = apiTasks[k].NextGen_IterationID;
                        }
                    }
                    window.currentResponse = response;
                    window.taskIsStatus = false;
                    toggleResponse()
                } else {
                    //      window.currentResponse =response;
                    //      window.taskIsStatus=true;
                    //      toggleResponse()
                    // error_msg="<strong> Error ! </strong> No Task Found For Selected Project";
                    // //$("#workSpace").hide();
                    // $("#noworkSpace").show();
                    // $('#noworkSpace').html(error_msg);
                    // $("#noworkSpace").addClass("alert alert-danger");


                    // if apiTasks is null 
                    $('#loadingImg').hide();
                    $("#workSpace").show();
                    $(".hideSection").show();

                    window.taskProgress = (response[0].mspintegration ? true : false)
                    if (window.taskProgress) {
                        $('#actualprogress').attr('class', 'tab-item-actualprogress custom-tab-items tab-slider--trigger active')
                        $('#custom_toggle_progress').addClass('slide');
                        $('.tab-item-' + $(this).data('id')).addClass('active')
                        $("#actualefforts").removeClass('active');
                        $('.progress-percent').show();
                        $('.progress-effort').hide();
                    } else {
                        $('#actualefforts').attr('class', ' tab-item-actualefforts custom-tab-items tab-slider--trigger active')
                        $('#custom_toggle_progress').removeClass('slide');
                        $("#actualprogress").removeClass('active');
                        $('.progress-percent').hide();
                        $('.progress-effort').show();
                    }
                    if (apiTasks) {
                        for (var k = 0; k < apiTasks.length; k++) {
                            var TaskID = apiTasks[k].TaskID;
                            var depends = String(apiTasks[k].depends).split(":");
                            if (depends.length != 0)
                                reflectDependancy(TaskID, depends[0], depends[1]);

                            apiTasks[k].TaskType = apiTasks[k].TypeId;
                            apiTasks[k].Phases = apiTasks[k].PhaseID;
                            apiTasks[k].Module = apiTasks[k].ModuleId;
                            apiTasks[k].SubProject = apiTasks[k].SubProjectID;
                            apiTasks[k].Deliverable = apiTasks[k].DeliverableID;
                            apiTasks[k].Milestone = apiTasks[k].MileStoneId;
                            apiTasks[k].Release = apiTasks[k].NextGen_ReleaseID;
                            apiTasks[k].UserStory = apiTasks[k].UserStoryID;
                            apiTasks[k].Sprint = apiTasks[k].NextGen_IterationID;
                        }
                    }
                    window.currentResponse = response;
                    window.taskIsStatus = false;
                    toggleResponse()
                    // then also load grid



                }

            } else {
                error_msg = "<strong> Error ! </strong> Some error has occurred while getting response from getTaskAPI,  Please contact to Administrator";
                //$("#workSpace").hide();
                $("#noworkSpace").show();
                $('#noworkSpace').html(error_msg);
                $("#noworkSpace").addClass("alert alert-danger");

            }

        },
        complete: function () {
            $('#loadingImg').hide();
        },
        error: function (xhr, textStatus, errorThrown) {
            error_msg = "<strong>Warning!</strong> Session Expired!";
            $("#workSpace").hide();
            $("#noworkSpace").show();
            $('#noworkSpace').html(error_msg);
            $("#noworkSpace").addClass("alert alert-warning");
        }
    });
}

function toggleResponse() {

    ret = normalizeData(window.currentResponse);
    //Added By Vaijat K For Issue Id :- 26022
    for (var j = 0; j < ret.tasks.length; j++) {
        if (!('depends' in ret.tasks[j]) || ret.tasks[j]['depends'] == '') continue
        ret.tasks[j]['depends'] = getDependsRowId(ret.tasks[j]['depends'], ret.tasks)
    }
    //Added By Vaijat K For Issue Id :- 26022
    window.ge.loadProject(ret);
    window.ge.checkpoint();
    hideColumns()
    $('[title]').tooltip();
}

function getMiliSecond(passDate) {
    var d = new Date();
    var n = d.getMilliseconds();
    var date = new Date(passDate);
    var milliseconds = date.getTime();
    return milliseconds;
}
function getDaysCount(endDate, startDate) {
    var start = new Date(startDate),
        end = new Date(endDate),
        diff = new Date(end - start),
        days = diff / 1000 / 60 / 60 / 24;
    return days
}

function normalizeData(arrmixResponse) {
    var normalisedResponse = {}
    var newResponse = {}
    var tasks = []
    taskRowMapId = 1;
    arrmixResponse = arrmixResponse[0]
    response = arrmixResponse.tasks
    //console.log(response)
    window.arrUnit = {};
    for (i in arrmixResponse.unit) {
        window.arrUnit[arrmixResponse.unit[i].UnitId] = arrmixResponse.unit[i].UnitName
    }

    taskRowMapArr = {}

    window.taskHours = 0;
    currentProject = window.projectList[$('#cmbProject').val()]
    fieldArr = ['Priority', 'DeliverableID', 'PhaseId', 'ModuleId', 'SubProjectID', 'MileStoneId', 'ChangeRequestID', 'ProjectFeatureID', 'ProjectEstimationTypeID', 'NextGen_ReleaseID', 'NextGen_IterationID', 'UserStoryID'];

    //var boolIsEffort = ($('#custom_toggle_progress').find('.active').data('id') == 'actualprogress') ? false : true;
    var parentTaskIndexes = {}
    var taskIndexes = {}
    // Rearrange Data
    parentArr = {}
    childArr = {}
    parentGroupedEfforts = {}
    for (itemIndex in response) {
        id = response[itemIndex]['TaskID']
        parentId = parseInt(response[itemIndex]['ParentTaskId'])
        if (parentId == 0) {
            parentArr[id] = parseInt(itemIndex)
            parentGroupedEfforts[id] = { 'efforts': [], 'percent': [] };
            childArr[id] = {}
        }
    }
    
    for (itemIndex in response) {
        id = response[itemIndex]['TaskID']
        parentId = parseInt(response[itemIndex]['ParentTaskId'])

        if (parentId != 0 && childArr[parentId]) {
            childArr[parentId][id] = parseInt(itemIndex)
            parentGroupedEfforts[parentId]['efforts'].push(response[itemIndex]['ActualPercentageEffortwise'])
            parentGroupedEfforts[parentId]['percent'].push(response[itemIndex]['actualProgress'])
        }
    }

    var indexList = []
    for (i in parentArr) {
        indexList.push(parentArr[i])
        for (j in childArr[i]) {
            indexList.push(childArr[i][j])
        }
    }

    for (index in indexList) {
        parentId = response[indexList[index]]['ParentTaskId']

        parentTaskIndexes[parentId] = (parentId == "0") ? -1 : parseInt(indexList[index])
    }

    for (index in indexList) {
        i = parseInt(indexList[index])
        newResponse = {}
        
        for (objKey in response[i]) {
            
            objbaseKey = objKey.toString();
            objNewKey = jslcfirst(objKey.toString());
            objKeyUpperCase = objKey.toString().toUpperCase()
            newResponse['code'] = "";
            newResponse['progressOverflow'] = "";
            newResponse['progressByWorklog'] = true;

            //            
            if (objbaseKey == 'id') {
                newResponse['id'] = response[i]['TaskID']; // -(parseInt(i) + parseInt(1))
            } else if (objbaseKey == 'TaskID') {
                newResponse['taskid'] = response[i][objKey]
            } else if (objbaseKey == 'ParentTaskId') {
                newResponse['parentTaskId'] = parseInt(response[i][objKey])
                if (newResponse['parentTaskId'] > 0) {
                    parentTaskIndexes[newResponse['parentTaskId']] = i
                }
            } else if (objbaseKey == 'name') {
                newResponse['name'] = response[i][objKey]
            } else if (objbaseKey == 'actualProgress') {
                newResponse['actualProgress'] = Number(response[i][objKey])
                if (parseInt(response[i]['ParentTaskId']) == 0) {
                    newResponse['actualProgress'] = getAverage(parentGroupedEfforts[response[i]['TaskID']]['percent'])
                }
            } else if (objbaseKey == 'actualEfforts') {
                newResponse['actualEfforts'] = Number(response[i][objKey])

            } else if (objbaseKey == 'ActualPercentageEffortwise') {
                newResponse['ActualPercentageEffortwise'] = Number(response[i][objKey])
                if (parseInt(response[i]['ParentTaskId']) == 0) {
                    newResponse['ActualPercentageEffortwise'] = getAverage(parentGroupedEfforts[response[i]['TaskID']]['efforts'])
                }
            } else if (objbaseKey == 'ProgressByWorklog') {
                newResponse['progressByWorklog'] = Boolean(response[i][objKey])
            } else if (objbaseKey == 'Relevance') {
                newResponse['relevance'] = Number(response[i][objKey])
            } else if (objbaseKey == 'Type') {
                newResponse['TaskTypeName'] = response[i][objKey]
                newResponse['type'] = response[i][objKey]
            } else if (objbaseKey == 'TaskTypeName') {
                newResponse['TaskTypeName'] = newResponse['type']
            } else if (objbaseKey == 'TypeId') {
                newResponse['typeId'] = response[i][objKey]
                newResponse['TaskType'] = response[i][objKey]
            } else if (objbaseKey == 'description') {
                newResponse['description'] = response[i][objKey] == '0' ? '' : response[i][objKey]
            } else if (objbaseKey == 'level') {
                newResponse['level'] = Number(response[i][objKey])
            } else if (objbaseKey == "IsActive") {
                var isActiveTask = $.trim(response[i][objKey])
                newResponse['IsActive'] = (isActiveTask ? isActiveTask : '0');
            } else if (objbaseKey == 'status') {
                newResponse['status'] = $.trim(response[i][objKey])
                //				        var newStatus=$.trim(response[i][objKey]);
                //				        if(newStatus=="A"){
                //					       newResponse['status'] ='A'
                //				        }else if(newStatus=='I'){
                //					       newResponse['status'] ='I'
                //				        }else if(newStatus=='C'){
                //					       newResponse['status'] ='C'
                //				        }else{
                //					       newResponse['status'] ='STATUS_UNDEFINED'
                //				        }
            } else if (objbaseKey == 'depends') {
                newResponse['depends'] = response[i][objKey]
                //newResponse['depends_new'] =newResponse['depends']
            } else if (objbaseKey == 'canWrite') {
                newResponse['canWrite'] = Boolean(response[i][objKey])
            } else if (objbaseKey == 'TaskCustomFields') {
                newResponse['TaskCustomFields'] = response[i][objKey]
            } else if (objbaseKey == 'assigs') {
                var assignee = response[i].assigs
                var responseAssigs = []
                for (k in assignee) {
                    responseAssigs.push({ 'id': assignee[k].id, 'roleId': assignee[k].roleId, 'resourceId': assignee[k].resourceId, 'effort': assignee[k].effort })
                }
                newResponse['assigs'] = responseAssigs
                // if((newResponse['assigs'].length)>1){
                //  newResponse['hasChild'] = false;
                // }else{
                //  newResponse['hasChild'] = false;
                // }
            } else if (objbaseKey == 'taskhaschild') {
                newResponse['hasChild'] = response[i][objKey];
            } else if (objbaseKey == 'start') {
                newResponse['start'] = getMiliSecond(response[i][objKey])
                //newResponse['start'] = getMiliSecond("28 May 2019");
            } else if (objbaseKey == 'end') {
                if (response[i]["actualEndTime"] == "")
                    newResponse['end'] = getMiliSecond(response[i][objKey])
                else {
                    newResponse['end'] = getMiliSecond(response[i]["actualEndTime"]);
                }
                //newResponse['end'] =getMiliSecond("25 May 2019");
            } else if (objbaseKey == 'duration') {
                //var days = getDaysCount("28 May 2019","25 May 2019");
                newResponse['duration'] = Number(response[i][objKey]);
            } else if (objbaseKey == 'startIsMilestone') {
                newResponse['startIsMilestone'] = false
            } else if (objbaseKey == 'endIsMilestone') {
                newResponse['endIsMilestone'] = false
            } else if (objbaseKey == 'collapsed') {
                newResponse['collapsed'] = Boolean(response[i][objKey])
            } else if (objbaseKey == 'wizibletask') {
                newResponse['wizibletask'] = $.trim(response[i][objKey])
            } else if (objbaseKey == 'msptask') {
                newResponse['msptask'] = $.trim(response[i][objKey])
            } else if (objbaseKey == 'msptask') {
                newResponse['msptask'] = $.trim(response[i][objKey])
            } else if (objbaseKey == 'WhichTask') {
                newResponse['whiziblesubtask'] = $.trim(response[i][objKey])
                newResponse['WhichTask'] = $.trim(response[i][objKey])
            } else if (objbaseKey == 'TaskColor') {
                newResponse['subtaskcolor'] = $.trim(response[i][objKey])
            } else if (objbaseKey == 'Wbsid') {
                newResponse['wbsid'] = parseInt($.trim(response[i][objKey]));
                // newResponse['wbsid'] =newResponse['id']       
            } else if (objbaseKey == 'Priority') {
                newResponse['priorityID'] = response[i][objKey]
                newResponse['PriorityName'] = response[i][objKey]
            } else if (objbaseKey == 'taskOrder') {
                newResponse['taskOrder'] = i
            } else if (objbaseKey == 'PlanUnit') {
                newResponse['PlanUnit'] = response[i][objKey]
            } else if (objbaseKey == 'Unit') {
                newResponse['Unit'] = response[i][objKey]
            } else if (objbaseKey == 'IsTaskBillable') {
                newResponse['isBillable'] = response[i][objKey]
            } else if (objbaseKey == 'PlanUnitName') {
                newResponse['PlanUnitName'] = response[i][objKey]
                //          this.WhichTask = ""
                // this.PriorityName = ""
                // this.DelivarableName = ""
                // this.MilestoneName = ""
                // this.ModuleName = ""
                // this.SubprojectName = ""
                // this.PhasesName = ""
                // this.ChangeRequestName = ""
                // this.ReleaseName = ""
                // this.SprintName = ""
                // this.UserStoryName = ""
                // this.EstimationTypeName = ""
                // this.ProjectFeatureName = ""    
                //}else if (objbaseKey == 'DeliverableID') {
                //                newResponse['deliverableID'] =response[i][objKey]
                //            }else if (objbaseKey == 'PhaseId') {
                //                newResponse['phaseId'] =response[i][objKey]
                //            }else if (objbaseKey == 'ModuleId') {
                //                newResponse['moduleId'] =response[i][objKey]
                //            }else if (objbaseKey == 'subProjectID') {
                //                newResponse['subProjectID'] =response[i][objKey]
                //            }else if (objbaseKey == 'MileStoneId') {
                //                newResponse['mileStoneId'] =response[i][objKey]
                //            }else if (objbaseKey == 'ChangeRequestID') {
                //                newResponse['changeRequestID'] =response[i][objKey]
                //            }else if (objbaseKey == 'ProjectFeatureID') {
                //                newResponse['projectFeatureID'] =response[i][objKey]
                //            }else if (objbaseKey == 'ProjectEstimationTypeID') {
                //                newResponse['projectEstimationTypeID'] =response[i][objKey]
                //            }else if (objbaseKey == 'NextGen_ReleaseID') {
                //                newResponse['nextGen_ReleaseID'] =response[i][objKey]
                //            }else if (objbaseKey == 'NextGen_IterationID') {
                //                newResponse['nextGen_ReleaseID'] =response[i][objKey]
                //            }else if (objbaseKey == 'UserStoryID') {
                //                newResponse['userStoryID'] =response[i][objKey]
            } else if (objbaseKey == 'planEfforts') {
                newResponse['planefforts'] = $.trim(response[i][objKey])
                if (newResponse['level'] == 1) {
                    var parentTaskHours = taskHoursToMin(window.taskHours) + taskHoursToMin(newResponse['planefforts']);
                    window.taskHours = minToHHMM(parentTaskHours)
                }
                
                newResponse['planefforts'] = response[i]["WrokHM"];//minToHHMM(taskHoursToMin(newResponse['planefforts']))
            } else if (fieldArr.indexOf(objbaseKey)) {
                var parentIndexId = parentTaskIndexes[parseInt(response[i]['ParentTaskId'])]
                curIndexId = (parentIndexId == - 1) ? i : parentIndexId
                newResponse[objbaseKey] = $.trim(response[curIndexId][objKey])
            }

            // parentTask_Grouping_ActualPercent
            // if(){

            // }  

            //Commented And Added By Vaijat K For Gantt Percentage Issue 
            //if (taskProgress) {
            //    newResponse['progress'] = (parseInt(newResponse['actualProgress']) < 100 ? parseInt(newResponse['actualProgress']) : '100')
            //    newResponse['progressOverflow'] = (parseInt(newResponse['actualProgress']) < 100 ? false : true)
            //} else {
            //    // newResponse['progress'] =(parseInt(newResponse['actualEfforts'])<100?parseInt(newResponse['actualEfforts']):'100')
            //    newResponse['progress'] = (parseInt(newResponse['ActualPercentageEffortwise']) < 100 ? parseInt(newResponse['ActualPercentageEffortwise']) : '100')
            //    newResponse['progressOverflow'] = (parseInt(newResponse['ActualPercentageEffortwise']) < 100 ? false : true)
            //}

            //Commented And Added By Vaijat K For Issue Id :- 21793
            //if (taskProgress) {
            //    newResponse['progress'] = (parseFloat(newResponse['actualProgress']) < 100 ? parseFloat(newResponse['actualProgress']) : '100')
            //    newResponse['progressOverflow'] = (parseFloat(newResponse['actualProgress']) < 100 ? false : true)
            //} else {
            //    // newResponse['progress'] =(parseInt(newResponse['actualEfforts'])<100?parseInt(newResponse['actualEfforts']):'100')
            //    newResponse['progress'] = (parseFloat(newResponse['ActualPercentageEffortwise']) < 100 ? parseFloat(newResponse['ActualPercentageEffortwise']) : '100')
            //    newResponse['progressOverflow'] = (parseFloat(newResponse['ActualPercentageEffortwise']) < 100 ? false : true)
            //}

            if (taskProgress) {
                newResponse['progress'] = (parseFloat(response[i]['actualProgress']) < 100 ? parseFloat(response[i]['actualProgress']) : '100')
                newResponse['progressOverflow'] = (parseFloat(response[i]['actualProgress']) < 100 ? false : true)
            } else {
                // newResponse['progress'] =(parseInt(newResponse['actualEfforts'])<100?parseInt(newResponse['actualEfforts']):'100')
                newResponse['progress'] = (parseFloat(response[i]['ActualPercentageEffortwise']) < 100 ? parseFloat(response[i]['ActualPercentageEffortwise']) : '100')
                newResponse['progressOverflow'] = (parseFloat(response[i]['ActualPercentageEffortwise']) < 100 ? false : true)
            }
            //End Added Commented And Added By Vaijat K For Issue Id :- 21793
            //End Commented And Added By Vaijat K For Gantt Percentage Issue 

            newResponse['showUnit'] = currentProject.showUnit
            newResponse['hiddenDropDown'] = currentProject.hiddenDropDown
            newResponse['mandatoryDropDown'] = currentProject.mandatoryDropDown

            newResponse['moveable'] = true;



            if (currentProject.isAgile == 1 && window.userStoryData[response[i].UserStoryID] && window.userStoryData[response[i].UserStoryID]['SprintID']) {
                var sprintId = window.userStoryData[response[i].UserStoryID]['SprintID']
                if (sprintData[sprintId] && sprintData[sprintId]['SprintStatus'].toLowerCase() == 'completed') {
                    newResponse['moveable'] = false;
                }
            }
            //TaskColor
            //newResponse['id'] =-(parseInt(i) + parseInt(1));
            //newResponse['name'] ="Gantt editor";
            //newResponse['progress'] =0;
            //newResponse['relevance'] =0;
            //newResponse['type'] ="";
            //newResponse['typeId'] ="";
            //newResponse['description'] ="";
            //newResponse['code'] ="";
            //newResponse['level'] =0;
            //newResponse['status'] ="STATUS_ACTIVE";
            //newResponse['depends'] ="";
            //newResponse['canWrite'] =true;
            //newResponse['start'] =getMiliSecond("09/24/2019");
            //newResponse['start'] =milliseconds
            //newResponse['duration'] =3;
            //newResponse['end'] =getMiliSecond("09/23/2019"); 
            //newResponse['end'] =milliseconds2
            //newResponse['startIsMilestone'] =false;
            //newResponse['endIsMilestone'] =false;
            //newResponse['collapsed'] =false;
            //newResponse['assigs'] =[];
            //newResponse['hasChild'] =false;		
        }

        //console.log(newResponse)

        newResponse['condition'] = getTaskCondition(newResponse)
        newResponse['readOnly'] = (currentProject.projectCanEdit != 1)

        if (window.taskIsStatus == true) {
            if (newResponse.IsActive == '1') {
                if (window.taskType) {
                    if (newResponse.wizibletask == '1') {
                        newResponse['taskRowMapId'] = taskRowMapId
                        taskRowMapArr[newResponse.id] = taskRowMapId
                        tasks.push(newResponse);
                        taskRowMapId++
                    }
                } else {
                    if (newResponse.msptask == '1') {
                        newResponse['readOnly'] = 1;
                        newResponse['taskRowMapId'] = taskRowMapId
                        taskRowMapArr[newResponse.id] = taskRowMapId
                        tasks.push(newResponse);
                        taskRowMapId++
                    }
                }
            }
        } else {
            if (window.taskType) {
                if (newResponse.wizibletask == '1') {
                    newResponse['taskRowMapId'] = taskRowMapId
                    taskRowMapArr[newResponse.id] = taskRowMapId
                    tasks.push(newResponse);
                    taskRowMapId++
                }
            } else {
                if (newResponse.msptask == '1') {

                    newResponse['readOnly'] = 1;
                    newResponse['taskRowMapId'] = taskRowMapId
                    taskRowMapArr[newResponse.id] = taskRowMapId
                    tasks.push(newResponse);
                    taskRowMapId++
                }
            }
        }


        // if(window.taskProgress=='actualefforts'){
        //     if (newResponse.taskProgress == '1')
        //      tasks.push(newResponse);
        // }else {
        //     tasks.push(newResponse);
        // } 


        // if($.trim(response[i][objKey])){
        //         newResponse['taskProgress'] = '1'

        //       }else{
        //           newResponse['taskProgress'] = '1'
        //       }
        /*
        newResponse['progressByEffort'] = false; //showEffort
        //Following is temp code is Start ===>
        if (newResponse['start'] == 0 || newResponse['end'] == 0 ) {
        currentTime = new Date().getTime();
        var randomDays = Math.ceil(Math.abs(Math.random() * (0 - 30) + 30))
        newResponse['start'] = currentTime; // currentTime - (3600 * 24 * 1000 * Math.ceil(randomDays / 2))
        newResponse['end'] = newResponse['start'] + (3600 * 24 * 1000 * randomDays)
        newResponse['duration'] = newResponse['duration'] + randomDays
        }

        var vId = newResponse['id'].toString()
        var vEffort = vId[vId.length - 1];
        newResponse['progressEffort'] = vEffort * 10    // effort
        newResponse['progressPlanedEffort'] = 100 // effort
        newResponse['progress'] = vEffort * 7; //percent
        newResponse['progressPercent'] = newResponse['progress']
        //newResponse['progressPercent'] = newResponse['progress']
        //newResponse['progressEffort'] = Math.ceil(Math.abs(Math.random() * (1 - 20) + 20)) // effort
        //newResponse['progress'] = Math.ceil(Math.abs(Math.random() * (20 - 90) + 90)); //percent

        if (boolIsEffort == true) {
            newResponse['progress'] = Math.ceil((parseInt(newResponse['progressEffort']) / parseInt(newResponse['progressPlanedEffort'])) * 100.00)
        }*/

        //Above is temp code is End ====|
    }

    var roles = arrmixResponse.roles
    newRoles = [];
    for (j in roles) {
        newRoles.push({ 'id': roles[j].id, 'name': roles[j].name });
    }

    var resources = arrmixResponse.resources
    newResources = [];
    for (k in resources) {
        newResources.push({ 'id': resources[k].id, 'name': resources[k].name });
    }

    for (j in tasks) {
        // // Comment Below Lines For Dependancy
        // if( tasks[j].id == '29502' ){
        //   tasks[j]['depends'] = getDependsRowId('29658:2') 
        // }
        //Commented By Vaijat K For Issue Id :- 26022
        //UnCOmment Below Lines For Dependancy
        //if (!('depends' in tasks[j]) || tasks[j]['depends'] == '') continue
        //tasks[j]['depends'] = getDependsRowId(tasks[j]['depends'], tasks)
        //End Commented By Vaijat K For Issue Id :- 26022
    }

    // if(tasks.length=='0'){
    //    tasks=	[{"id": -1, "name": "Add New Task", "progress": 0, "progressByWorklog": false, "relevance": 0, "type": "", "typeId": "", "description": "", "code": "", "level": 0, "status": "STATUS_ACTIVE", "depends": "", "canWrite": true, "start": 1396994400000, "duration": 20, "end": 1399586399999, "startIsMilestone": false, "endIsMilestone": false, "collapsed": false, "assigs": [], "hasChild": false}]

    // }
    // console.log("tasks",tasks);
    normalisedResponse['tasks'] = tasks.sort(compareTask);
    normalisedResponse['selectedRows'] = 1;
    normalisedResponse['deletedTaskIds'] = [];
    normalisedResponse['resources'] = newResources;
    normalisedResponse['roles'] = newRoles;
    normalisedResponse["canWrite"] = currentProject.projectCanAdd && currentProject.projectCanEdit && window.taskType;
    normalisedResponse["canDelete"] = (currentProject.projectCanAdd || currentProject.projectCanEdit) && currentProject.projectCanDelete && window.taskType;
    normalisedResponse["canWriteOnParent"] = normalisedResponse["canWrite"];
    normalisedResponse["canAdd"] = currentProject.projectCanAdd && window.taskType;
    return normalisedResponse
}

function jslcfirst(string) {
    return string.charAt(0).toLowerCase() + string.slice(1);
}

function loadProject(userId) {
    $('#loadingImg').show();
    var error_msg
    $('#wbs-gantt-container').css('visibility', 'hidden');
    var projectUrl = ApiURL['GetAssignedProjects']
    //var postData = {'EmployeeID': userId};


    $.ajax({
        url: projectUrl,
        method: 'POST',
        //   data: postData,
        success: function (response) {
            // $('#cmbProject').selectpicker('destroy')
            if (!response) {
                error_msg = "<strong> Error !</strong> Some error has occurred while getting response from getProject API,  Please contact to Administrator";
                $("#workSpace").hide();
                $("#noworkSpace").show();
                $('#noworkSpace').html(error_msg);
                $("#noworkSpace").addClass("alert alert-danger");
            } else {
                strHtml = '<option value="">Select Project</option>'
                if (response.length > 0) {
                    var projectCount = 0;  // for count project which have view access
                    var firstProjectId = 0;
                    strHtml += '';
                    $.each(response, function (i, v) {

                        v.originalAddAccess = v.Add == '1'
                        v.isPassedProject = new Date().getTime() > getTimeInInt(v.Project_end_date)
                        //v.Add = v.isPassedProject ? '0' : v.Add
                        v.View = (v.Add == '1' || v.Edit == '1' || v.Delete == '1') ? '1' : v.View
                        v.Delete = (v.Add == '1' || v.Edit == '1') ? v.Delete : '0'

                        if (v.Access == '0' || (v.Access == '1' && v.View == '0')) return;
                        projectCount++;
                        //if( v.ID != 114 ) return; 
                        let hiddenDropDown = (v.IsAgileMethodFollowed == 1) ? [] : ['ShowReleaseInAT', 'ShowUserStoryInAT', 'ShowSprintInAT'];
                        let mandatoryDropDown = (v.IsAgileMethodFollowed == 1) ? ['PriorityMandatoryInAT', 'TaskTypeMandatoryInAT', 'ReleaseMandatoryInAT', 'UserStoryMandatoryInAT', 'SprintMandatoryInAT'] : ['PriorityMandatoryInAT', 'TaskTypeMandatoryInAT'];

                        Object.keys(v).forEach(dropdown => {
                            let dropdownKey = dropdown
                            dropdownKey = dropdownKey.replace('Phase', 'Phases')
                            dropdownKey = dropdownKey.replace('SubProject', 'Subproject')
                            dropdownKey = dropdownKey.replace('Feature', 'ProjectFeature')
                            //dropdownKey = dropdownKey.replace('Feature','Sprint') // Comment it it is added for only testing purpose

                            if (dropdown.indexOf('InAT') == (dropdown.length - 4)) {

                                if (dropdown.indexOf('Show') == 0 && v[dropdown] == 0) {
                                    hiddenDropDown.push(dropdownKey)
                                }

                                if (dropdown.indexOf('MandatoryInAT') == (dropdown.length - 13) && v[dropdown] == 1) {
                                    mandatoryDropDown.push(dropdownKey)
                                }
                            }
                        })

                        defaultProjectId = 0
                        if (false == isNaN(sessionProjectID)) {
                            defaultProjectId = sessionProjectID
                        } else if (v.isDefault == "1") {
                            defaultProjectId = v.ID
                        }

                        if (defaultProjectId == v.ID) {
                            firstProjectId = v.ID
                            strHtml += '<option value="' + v.ID + '" selected>' + v.Project + '</option>'
                            window.projectHours = v.projectWorkHours;
                            window.projectStartDate = v.Project_start_date;
                            window.projectEndDate = v.Project_end_date;
                            window.projectWorkHours = v.LocationWorkHour;
                            window.minHoursForDAEntry = v.MinHoursForDAEntry;
                            window.projectCanAdd = v.Add;
                            window.projectCanDelete = v.Delete;
                            window.projectCanEdit = v.Edit;
                            window.isPassedProject = v.isPassedProject;
                            window.originalAddAccess = v.originalAddAccess
                            window.currentProjectSprintId = v.CurrentSprintId;
                            window.isOver = v.Over
                        } else {
                            strHtml += '<option value="' + v.ID + '">' + v.Project + '</option>'
                            // window.projectHours = v.projectWorkHours;
                            // window.projectStartDate = v.Project_start_date;
                            // window.projectEndDate = v.Project_end_date;
                            // window.projectWorkHours = v.LocationWorkHour;
                            // window.minHoursForDAEntry =  v.MinHoursForDAEntry;
                            // window.projectCanAdd = v.Add;
                            // window.projectCanDelete = v.Delete;
                            // window.projectCanEdit = v.Edit;
                        }

                        window.projectList[v.ID.toString()] = {
                            'id': v.ID,
                            'title': v.Project,
                            'endDate': v.Project_end_date,
                            'startDate': v.Project_start_date,
                            'serverDate': v.ServerDate,
                            'taskProgress': v.mspintegration,
                            'projectHours': v.projectWorkHours,
                            'projectWorkHours': v.LocationWorkHour,
                            'isBillable': v.IsBillable,
                            'showUnit': v.IsAllowToShowPlanUnit,
                            'mandatoryDropDown': mandatoryDropDown,
                            'isAgile': v.IsAgileMethodFollowed,
                            'hiddenDropDown': hiddenDropDown,
                            'minHoursForDAEntry': v.MinHoursForDAEntry,
                            'projectCanAdd': v.Add,
                            'projectCanDelete': v.Delete,
                            'projectCanEdit': v.Edit,
                            'projectStatus': v.ProjectStatus,
                            'originalAddAccess': v.originalAddAccess,
                            'isPassedProject': v.isPassedProject,
                            'isOver': v.Over,
                            CurrentSprintId: v.CurrentSprintId
                        }


                    })

                    $('#cmbProject').html(strHtml);



                    if (projectCount > 0) {
                        if (!firstProjectId) {
                            error_msg = "<strong> Hello User !</strong> Please select project to view task.";
                            $("#workSpace").hide();
                            $("#noworkSpace").show();
                            $('#noworkSpace').html(error_msg);
                            $("#noworkSpace").addClass("alert alert-info");
                        } else {
                            getProjectDetail(firstProjectId, userId)
                            $("#noworkSpace").hide();
                        }

                        // hide delete button if not permission to delete
                        if (window.projectCanDelete <= 0) {
                            $('div.buttons button.delete').hide();
                        }

                        if (!isNaN($('#cmbProject').val()) && $('#cmbProject').val() > 0) {
                            var currProj = window.projectList[$('#cmbProject').val()]
                            $('#save_project_btn').removeAttr('disabled')
                            if (currProj.isOver) $('#save_project_btn').attr('disabled', 'disabled')
                            manageProjectAccess(currProj)
                        }

                        //******

                    } else {
                        $('#cmbProject').hide();
                        error_msg = "<strong>You are not authorized to view this record.</strong>";
                        $("#workSpace").hide();
                        $("#noworkSpace").show();
                        $('#noworkSpace').html(error_msg);
                        $("#noworkSpace").addClass("alert alert-danger");
                    }
                }
            }
        },
        complete: function () {
            $('#loadingImg').hide();
        },
        error: function (xhr, textStatus, errorThrown) {
            error_msg = "<strong>Warning !</strong> Session Expired!";
            $("#workSpace").hide();
            $("#noworkSpace").show();
            $('#noworkSpace').html(error_msg);
            $("#noworkSpace").addClass("alert alert-warning");
        }
    });


}


/* Validation for Task Edit Form */
$.fn.hasAttr = function (name) {
    return this.attr(name) !== undefined;
};

function calEditorProgress() {
    var workHrs = parseInt($('#effort').val())
    var calHrs = parseInt($('#duration').val()) * 8
    if (workHrs > calHrs) {
        triggerEditorError({ 'effort': 'Work Hours should not exceed the Duration' })
        $('#saveButton').attr('disabled', 'disabled')
        return false;
    }
    vProgress = Math.ceil(workHrs / calHrs * 100.00)
    if (false == isNaN(vProgress)) {
        $('#progress').val(vProgress)
    }
    $('#saveButton').removeAttr('disabled')
    triggerEditorError({})
}

function customSaveTask(elem) {

    $('#editorErrorContainer').html('').hide()
    if (true === $('table.taskData').is(":hidden") && true === $('table#tblCustomFieldContainer').is(":hidden")) {
        $(elem).trigger('saveFullEditor.gantt');
        return;
    }
    currentProject = window.projectList[$('#cmbProject').val()]
    var errorMsgs = {}
    triggerEditorError(errorMsgs)
    var currentSprint = {}
    var boolIsAgile = currentProject.isAgile == 1
    if (boolIsAgile) {
        currentSprint['id'] = $('#cmbSprint option:selected').val();
        currentSprint['start'] = $('#cmbSprint option:selected').attr('data-item-sprint-start')
        currentSprint['end'] = $('#cmbSprint option:selected').attr('data-item-sprint-end')
        currentSprint['status'] = $('#cmbSprint option:selected').attr('data-item-sprint-status')
        currentSprint['effort'] = $('#cmbSprint option:selected').attr('data-item-sprint-effort')
    }
    //console.log(currentSprint)

    if (!isNotEmpty($('#name').val())) {
        errorMsgs['name'] = 'Task Name should not be empty!'
    }
    if (!isNotEmpty($('#duration').val())) {
        errorMsgs['duration'] = 'Duration should not be empty!'
    }
    //Added By Vaijat K For Character issue
    if (isNaN(parseFloat($('#duration').val())) == true) {
        errorMsgs['duration'] = 'Please enter numeric value in duration';
    }
    if ($('#resourceId').length != 0 && !isNotEmpty($('#resourceId').val())) {
        errorMsgs['resourceId'] = 'Resource should be selected!'
    }

    if (!isNotEmpty($('#effort').val())) {
        errorMsgs['effort'] = 'Work Hours should not be empty!'
    } else {
        var strTaskHourMsg = '';
        if (isNaN(parseFloat($('#duration').val())) == false) {
            strTaskHourMsg = isValidWorkHours($('#effort').val(), $('#duration').val(), $('#effort').attr('data-is-parent'))
        }
        else {
            strTaskHourMsg = ''
        }
        //console.log(strTaskHourMsg)
        if ('' == strTaskHourMsg) {
            if (isNaN(parseFloat($('#effort').val())) == true) {
                errorMsgs['effort'] = 'Please enter numeric value in work hours';
            }
            else {
                var calculatedTaskHours = parseInt($('#effort').val()) + window.taskHours - parseInt($('#effort').data('val'))
                if ($('#effort').attr('data-is-parent') == '1')

                    if (calculatedTaskHours > window.projectHours) {
                        errorMsgs['effort'] = 'Work Hours should not be greater than Project Work Hours'
                    }
                // if ( boolIsAgile && parseInt( $('#effort').val() ) > parseInt( currentSprint['effort'] ) )  {
                //     errorMsgs['effort'] = 'Work Hours should not be greater than Sprint Work Hours'
                // }

                var newEfort = parseInt($('#effort').val());
                //var pt_hours = (parseInt(getParentTaskHours(window.globarParentId)) + newEfort) - parseInt(window.oldeffortvalue);
                //var pt_hours = parseInt(getParentTaskHours(window.globarParentId))
                var pt_hours = getCurrentSprintTasksEfforts(currentSprint['id']);
                if (window.globarParentId != 0) {
                    pt_hours = pt_hours - parseInt(taskHoursToMin(window.oldeffortvalue)) + taskHoursToMin(newEfort);
                }

                if (boolIsAgile && pt_hours > taskHoursToMin(parseInt(currentSprint['effort']))) {
                    //errorMsgs['effort'] = 'Work Hours should not be greater than Sprint Work Hours'
                    errorMsgs['effort'] = "\nWork Hours should not be greater than Sprint Work Hours[" + currentSprint.effort + "]. Total work hours entered [" + minToHHMM(getCurrentSprintTasksEfforts($("#cmbSprint").val())) + "]";
                }
                //console.log("globalid",pt_hours,window.globarParentId,getParentTaskHours(window.globarParentId),parseInt( currentSprint['effort'] ))
            }
        } else {
            errorMsgs['effort'] = strTaskHourMsg;
        }

    }

    if (!isNotEmpty($('#progress').val())) {
        errorMsgs['progress'] = 'Progress should not be empty!'
    }





    if (!isNotEmpty($('#start').val())) {
        errorMsgs['start'] = 'Task start date should not be empty!'
    } else if (getTimeInInt($('#start').val()) > getTimeInInt(window.projectEndDate)) {
        errorMsgs['start'] = 'Task start date should not be after Project end date (' + new Date(window.projectEndDate).format('MM/dd/yyyy') + ')!'
    } else if (boolIsAgile && (getTimeInInt($('#start').val()) < parseInt(currentSprint.start))) {
        errorMsgs['start'] = 'Task start date should be within or equal to Sprint start date (' + new Date(parseInt(currentSprint.start)).format('MM/dd/yyyy') + ')!'
    } else if (getTimeInInt($('#start').val()) < getTimeInInt(window.projectStartDate)) {
        errorMsgs['start'] = 'Task start date should be within or equal to Project start date (' + new Date(window.projectStartDate).format('MM/dd/yyyy') + ')!'

    }

    if (!isNotEmpty($('#end').val())) {
        errorMsgs['end'] = 'Task end date should not be empty!'
    } else if (getTimeInInt($('#end').val()) < getTimeInInt(window.projectStartDate)) {
        errorMsgs['end'] = 'Task end date should not be before Project start date (' + new Date(window.projectStartDate).format('MM/dd/yyyy') + ')!'
    } else if (boolIsAgile && (getTimeInInt($('#end').val()) > parseInt(currentSprint.end))) {
        errorMsgs['end'] = 'Task end date should be within or equal to Sprint end date (' + new Date(parseInt(currentSprint.end)).format('MM/dd/yyyy') + ')!'
    } else if (getTimeInInt($('#end').val()) > getTimeInInt(window.projectEndDate, true)) {
        errorMsgs['end'] = 'Task end date should be within or equal to Project end date (' + new Date(window.projectEndDate).format('MM/dd/yyyy') + ')!'
    }
    else {
        var status = $('#status').val()
        let current_datetime_1 = new Date($('#start').val());
        let current_datetime2_1 = new Date($('#end').val())

        var actualEfforts = taskHoursToMin(actualEffortsEdit)
        if (actualEfforts != 0 && (status == 'A' || status == "NV" || status == "R")) {
            var taskParameters = {
                TaskId: taskIdEdit,
                StartDate: new Date(current_datetime_1.getFullYear() + "/" + (current_datetime_1.getMonth() + 1) + "/" + current_datetime_1.getDate()).toLocaleDateString("en-US"),
                EndDate: new Date(current_datetime2_1.getFullYear() + "/" + (current_datetime2_1.getMonth() + 1) + "/" + current_datetime2_1.getDate()).toLocaleDateString("en-US")
            }

            jQuery.ajax({
                url: ApiURL['checkTaskActualDates'],
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json",
                type: 'POST',
                async: false,
                success: function (data) {
                    if (data != "0") {
                        errorMsgs['end'] = "\nDA is already filled for date(s) :- " + data;
                    }
                },
                error: function (xhr, status, error) {
                    //getTextHtml();
                    console.log(xhr, status, error)
                }
            });
        }
    }

    if (parseInt($('#duration').val()) < 0) {
        errorMsgs['end'] = 'Task End Date should not be less than Task Start Date (' + $('#start').val() + ')!'
    }


    // get resources start date and end date
    for (i in projectResources) {
        if (projectResources[i].id == $('#resourceId').val()) {

            var d1 = $('#start').val();
            var d2 = $('#end').val();
            var dateAr = d1.split('/');
            var date_start = (dateAr[0].length >= 2 ? dateAr[0] : '0' + dateAr[0]) + '/' + (dateAr[1].length >= 2 ? dateAr[1] : '0' + dateAr[1]) + '/' + dateAr[2].slice(-2);

            var dateAr = d2.split('/');
            var date_end = (dateAr[0].length >= 2 ? dateAr[0] : '0' + dateAr[0]) + '/' + (dateAr[1].length >= 2 ? dateAr[1] : '0' + dateAr[1]) + '/' + dateAr[2].slice(-2);
            if (getTimeInInt(projectResources[i].resourceStartDate) > getTimeInInt(date_start)) {
                errorMsgs['start'] = 'Task start date should be within or equal to Resource Start date (' + new Date(projectResources[i].resourceStartDate).format('MM/dd/yyyy') + ')!'
            }

            if (getTimeInInt(projectResources[i].resourceEndDate) < getTimeInInt(date_end)) {
                errorMsgs['end'] = 'Task End date should be within or equal to Resource End date (' + new Date(projectResources[i].resourceEndDate).format('MM/dd/yyyy') + ')!'
            }
        }
    }

    $('select.gdf-required').each(function () {
        if ($(this).attr('name') != "ChangeRequest") {//Added By Vaijat K For Issue Id:-26021
            if (!isNotEmpty($(this).val())) {
                errorMsgs['cmb' + $(this).attr('name')] = 'Please, Select ' + $(this).attr('name').split(/(?=[A-Z])/).join(' ') + '.'
            }
        }
    })


    $('.custom-field').each(function () {
        var strValue = $.trim($(this).val());
        var boolIsText = $(this).hasClass('custom-field-text') || $(this).hasClass('custom-field-textarea')
        var boolSizeExceed = $(this).hasAttr('size') && $(this).attr('size') < strValue.length
        var boolContainSpecialChars = /[!@#$%^&*()_+\-=\[\]{};':"\\|,<>\/?]/.test(strValue);
        var boolOnlyAlphabates = /^[a-zA-Z ]*$/.test(strValue);
        var intVal = parseInt(strValue);
        var boolMaxValue = $(this).hasAttr('data-max-value') && $(this).attr('data-max-value') < intVal;
        var boolMinValue = $(this).hasAttr('data-min-value') && $(this).attr('data-min-value') > intVal;

        var fieldCaption = 'Custom Field : ' + $(this).data('caption');
        var fieldName = $(this).attr('name')

        if (true == $(this).hasAttr('data-valid-not-blank') && !isNotEmpty(strValue)) {
            errorMsgs[fieldName] = fieldCaption + ' should not be empty!'; return;
        }

        if (boolIsText && true == $(this).hasAttr('data-valid-max-length') && boolSizeExceed) {
            errorMsgs[fieldName] = fieldCaption + ' should not exceeed ' + $(this).attr('size') + ' chars'; return;
        }

        if (boolIsText && true == $(this).hasAttr('data-valid-is-only-alphabates') && !boolOnlyAlphabates) {
            errorMsgs[fieldName] = fieldCaption + ' should contain only alphabates.'; return;
        }

        if (boolIsText && isNaN(intVal)) {
            if (true == $(this).hasAttr('data-valid-is-numeric')) {
                errorMsgs[fieldName] = fieldCaption + ' should be number only.'; return;
            } else if ($(this).hasAttr('data-valid-is-positive-number') || intVal < 0) {
                errorMsgs[fieldName] = fieldCaption + ' should be positive number only.'; return;
            }
        }

        if (boolIsText && true == $(this).hasAttr('data-valid-no-spacial-chars') && boolContainSpecialChars) {
            errorMsgs[fieldName] = fieldCaption + ' should not contain special chars.'; return;
        }


        if (boolIsText && true == $(this).hasAttr('data-valid-check-max-val') && boolMaxValue) {
            errorMsgs[fieldName] = fieldCaption + ' maximum value should be ' + $(this).hasAttr('data-max-val') + '.'; return;
        }

        if (boolIsText && true == $(this).hasAttr('data-valid-check-min-val') && boolMinValue) {
            errorMsgs[fieldName] = fieldCaption + ' minimum value should be ' + $(this).hasAttr('data-min-val') + '.'; return;
        }

    })

    if (Object.keys(errorMsgs).length != 0) return triggerEditorError(errorMsgs)
    $(elem).trigger('saveFullEditor.gantt');

}

function getCurrentSprintTasksEfforts(sprintId) {
    var taskHours = 0;
    var tasks = window.ge.tasks;
    for (var i = 0; i < tasks.length; i++) {
        var parentTaskId = tasks[i].parentTaskId;
        var NextGen_IterationID = tasks[i].NextGen_IterationID;
        if (parentTaskId == 0) {
            //if (parentTaskIdMain != parentTaskId) {
            if (sprintId == NextGen_IterationID) {
                taskHours += taskHoursToMin(tasks[i].planefforts);
            }
            //}
        }
    }
    return taskHours;
}

function getTasksEfforts(tasks) {
    var taskHours = 0;
    for (var i = 0; i < tasks.length; i++) {
        var parentTaskId = tasks[i].parentTaskId;
        if (parentTaskId != 0) {
            if (tasks[i].status == 'A' || tasks[i].status == 'C' || tasks[i].status == 'H')
                taskHours += taskHoursToMin(tasks[i].planefforts);
        }
    }
    return taskHours;
}

function getTimeInInt(dateStr, isMatchEndDateScenario) {
    var isMatchEndDateScenario = isMatchEndDateScenario || false
    var d = new Date(dateStr)
    if (isMatchEndDateScenario) d.setHours(23, 59, 59, 999);
    return d.getTime()
}

function isNotEmpty(str) {
    if (null == str) return false;
    if ("null" == str) return false;
    if (str && "" != str && str.replace(/^\s+|\s+$/g, "").length > 0) return true;
    return false
}

function triggerEditorError(errorMsgs) {

    $('.gdfInputError').removeClass('gdfInputError')
    $('#editorErrorContainer').hide().html('')
    if (Object.keys(errorMsgs).length == 0) return true
    $('#' + Object.keys(errorMsgs).join(', #')).addClass('gdfInputError')
    $('#editorErrorContainer').show().html('<div class="gdfEditorErrorMsg">' + Object.values(errorMsgs).join('</div><div class="gdfEditorErrorMsg">') + '</div>')

}

function tabClick(strtab) {
    var taskEditorNav = $('.ganttTaskEditor > .nav > li')
    var taskEditorPanel = $('.ganttTaskEditor > .tab-content > div.tab-pane')
    taskEditorNav.removeClass('active')
    taskEditorPanel.attr('class', 'tab-pane fade')
    $('li#tab_' + strtab).addClass('active')
    $('div#panel_' + strtab).addClass('in active')
}

function removeAssigns(taskId, assignIds, status) {
    var assignIds = assignIds || ''
    if (taskId == '') return false;
    var assignIdArr = assignIds.toString().split(',')
    var task = window.ge.getTask(taskId); // get task again because in case of rollback old task is lost 
    window.ge.beginTransaction();
    if (assignIds == '') {
        task.assigs = task.assigs.filter(ass => (-1 == assignIdArr.indexOf(ass.resourceId.toString())));
        ge.updateLinks(task)
    }
    task.status = status
    window.ge.endTransaction()

}

function confirmDependency(currentValue, task, tasks) {
    //Added by Vaijat K Issue Id :- 24551
    var parentTaskId = task.parentTaskId;
    if (currentValue > tasks.length) { return ''; }

    if (0 == parentTaskId) {
        alert('You cannot set dependency for parent.')
        return ''
    }

    if (!(task.assigs && task.assigs[0] && task.assigs[0].resourceId > 0)) {
        //Commented And Added by Vaijat K For Issue Id :- 21704
        //alert('Please Assign Resource first before setting the dependancy on the task.')
        alert('Please Assign Resource first before setting the dependency on the task.')
        //End Commented And Added by Vaijat K For Issue Id :- 21704
        return ''
    }
    
    if (parseInt(task.level) == 0) return '';
    if (currentValue == '') {
        delete dependencyTaskList[task.id]
        $('#depends_' + task.id).val('');
        $('#depends_' + task.id).attr('data-accept', '1').trigger('blur');
        return '';
    }
    var dependTaskIndex = 0; duration = 1;
    var arr = currentValue.split(':')
    if (parseInt(arr[0]) > 0) dependTaskIndex = arr[0]
    if (parseInt(arr[1]) > 0) duration = arr[1]

    if (0 == dependTaskIndex) {
        alert('Please Enter Depend Task alongwith Duration seperated by Colon(:). eg: 12, 11:1 ')
        return ''
    }

    

    if (dependTaskIndex == task.getRow() + 1) {
        alert('You cannot set dependency of same task.')
        return ''
    }

    var dependTaskId = $('#taskRowIndex' + dependTaskIndex).attr('data-task-id')
    if (parentTaskId == dependTaskId) {
        var sup = tasks[dependTaskIndex - 1];
        alert("\"" + task.name + "\"\n" + GanttMaster.messages.CANNOT_DEPENDS_ON_ANCESTORS + "\n\"" + sup.name + "\"");
        return;
    }

    if (parseInt(arr[1])) {
        newTaskStartDate = computeEndByDuration($('#endDate_' + dependTaskId).val(), parseInt(duration) + 2)
    } else {
        newTaskStartDate = computeEndByDuration($('#endDate_' + dependTaskId).val(), parseInt(duration) + 1)
    }

    newTaskStartDate = computeStart(newTaskStartDate)
    newTaskEndDate = computeEndByDuration(newTaskStartDate, $('#duration_' + task.id).val())
    newTaskEndDate = computeEnd(newTaskEndDate)
    if (new Date(newTaskEndDate).getTime() > new Date(window.projectEndDate)) {
        alert('Task End Date should not exceed Project End Date');
        return ''
    }

    //Added By Vaijat K For Issue Id :- 26289
    var startDateTime;
    if (typeof Date == newTaskStartDate) {
        startDateTime = parseInt(newTaskStartDate.getTime());
    } else {
        if (isNaN(newTaskStartDate)) return false;
        startDateTime = newTaskStartDate;
    }
    var endDateTime
    if (typeof Date == newTaskEndDate) {
        endDateTime = parseInt(newTaskEndDate.getTime());
    } else {
        if (isNaN(newTaskEndDate)) return false;
        endDateTime = newTaskEndDate;
    }
    var boolIsAgile = currentProject.isAgile == 1
    var currentSprint = {};
    if (boolIsAgile && window.userStoryData[task.UserStoryID] && window.userStoryData[task.UserStoryID]['SprintID']) {
        var sprintId = window.userStoryData[task.UserStoryID]['SprintID']
        currentSprint['start'] = getTimeInInt(sprintData[sprintId]['SprintStDate']);
        currentSprint['end'] = getTimeInInt(sprintData[sprintId]['SprintEndDate']);

    }

    //Added By Vaijat K For Issue Id :- 26044
    let current_datetime = new Date()
    current_datetime.setTime(startDateTime)
    startDateTime = new Date(current_datetime.getFullYear() + "/" + (current_datetime.getMonth() + 1) + "/" + current_datetime.getDate()).getTime()

    let current_datetime2 = new Date()
    current_datetime2.setTime(endDateTime)
    endDateTime = new Date(current_datetime2.getFullYear() + "/" + (current_datetime2.getMonth() + 1) + "/" + current_datetime2.getDate()).getTime()
    //End Added By Vaijat K For Issue Id :- 26044

    if (startDateTime > getTimeInInt(window.projectEndDate)) {
        alert(
            "Task start date should not be after Project end date (" +
            new Date(window.projectEndDate).format("MM/dd/yyyy") +
            ")!"
        );
        return task.depends;
    } else if (boolIsAgile && startDateTime < currentSprint.start) {

        alert(
            "Task start date should be within or equal to Sprint start date (" +
            new Date(parseInt(currentSprint.start)).format("MM/dd/yyyy") +
            ")!"
        );
        return task.depends;
    } else if (startDateTime < getTimeInInt(window.projectStartDate)) {
        alert(
            "Task start date should be within or equal to Project start date (" +
            new Date(window.projectStartDate).format("MM/dd/yyyy") +
            ")!"
        );
        return task.depends;
    }
    if (endDateTime < getTimeInInt(window.projectStartDate)) {
        alert(
            "Task end date should not be before Project start date (" +
            new Date(window.projectStartDate).format("MM/dd/yyyy") +
            ")!"
        );
        return task.depends;
    } else if (boolIsAgile && endDateTime > parseInt(currentSprint.end)) {
        alert(
            "Task end date should be within or equal to Sprint end date (" +
            new Date(parseInt(currentSprint.end)).format("MM/dd/yyyy") +
            ")!"
        );
        return task.depends;
    } else if (endDateTime > getTimeInInt(window.projectEndDate, true)) {
        alert(
            "Task end date should be within or equal to Project end date (" +
            new Date(window.projectEndDate).format("MM/dd/yyyy") +
            ")!"
        );
        return task.depends;
    }
    else {
        if (task.assigs.length > 0 && task.assigs[0].resourceId != 0) {
            for (i in projectResources) {
                if (projectResources[i].id == task.assigs[0].resourceId) {

                    var d1 = current_datetime.toLocaleDateString("en-US");
                    var d2 = current_datetime2.toLocaleDateString("en-US");
                    var dateAr = d1.split('/');
                    var date_start = (dateAr[0].length >= 2 ? dateAr[0] : '0' + dateAr[0]) + '/' + (dateAr[1].length >= 2 ? dateAr[1] : '0' + dateAr[1]) + '/' + dateAr[2].slice(-2);

                    var dateAr = d2.split('/');
                    var date_end = (dateAr[0].length >= 2 ? dateAr[0] : '0' + dateAr[0]) + '/' + (dateAr[1].length >= 2 ? dateAr[1] : '0' + dateAr[1]) + '/' + dateAr[2].slice(-2);
                    if (getTimeInInt(projectResources[i].resourceStartDate) > getTimeInInt(date_start)) {
                        alert('Task start date should be within or equal to Resource Start date (' + new Date(projectResources[i].resourceStartDate).format('MM/dd/yyyy') + ')!')
                        return task.depends;
                    }

                    if (getTimeInInt(projectResources[i].resourceEndDate) < getTimeInInt(date_end)) {
                        alert('Task End date should be within or equal to Resource End date (' + new Date(projectResources[i].resourceEndDate).format('MM/dd/yyyy') + ')!')
                        return task.depends;
                    }
                }
            }
        }
    }
    //End Added By Vaijat K For Issue Id :- 26289
    var data = {}
    data['taskId'] = task.id
    //Commented And Added For Issue ID :- 24546
    //data['curStartDate'] = $('#startDate_' + dependTaskId).val()
    //data['curEndDate'] = $('#endDate_' + dependTaskId).val()
    data['curStartDate'] = $('#startDate_' + data['taskId']).val()
    data['curEndDate'] = $('#endDate_' + data['taskId']).val()
    data['newStartDate'] = new Date(newTaskStartDate).format('MM/dd/yyyy')
    data['newEndDate'] = new Date(newTaskEndDate).format('MM/dd/yyyy')

    var curTaskResources = []
    var newTaskResources = []
    var delTaskResourceIds = []

    if (task.assigs.length > 0 && task.assigs[0].resourceId != 0) {
        task.assigs.forEach(function (item, index) {
            curResource = window.projectResources[item.resourceId]
            if (typeof curResource != 'undefined') {
                curTaskResources.push(curResource.name)
                if (curResource.resourceEnd > newTaskEndDate && curResource.resourceStart < newTaskStartDate) {
                    newTaskResources.push(curResource.name)
                } else {
                    delTaskResourceIds.push(item.resourceId)
                }
            }
        })
    }

    data['curResources'] = curTaskResources.join(', ')
    data['newResources'] = newTaskResources.join(', ')
    data['delResources'] = delTaskResourceIds.join(',')
    data['status'] = task.status;
    data['dependTaskId'] = dependTaskId
    data['task'] = task
    data['duration'] = (parseInt(arr[1]) > 0) ? duration : 0
    createModalPopup(800, 450, CloseDependencyModal).append($.JST.createFromTemplate(data, "DEPENDS_CONFIRMATION"));
    //Added By Vaijat K For Issue Id :- 26289
    function CloseDependencyModal() {
        if ($('#depends_' + task.id).attr('accept') != '1')
            $('#depends_' + task.id).val('');
        closeBlackPopup();
        $('#depends_' + task.id).attr('accept', '0');
    }
    //End Added By Vaijat K For Issue Id :- 26289
    //Commented And Added For Issue ID :- 24554
    $("[__template=DEPENDS_CONFIRMATION").parent().find(".popUpClose").click(function () {
        $('#depends_' + task.id).val('');
        closeBlackPopup();
    })

    if (parseInt(arr[1]) > 0) {
        //dependencyTaskList.push({ taskId : task.id, dependTaskId : parseInt(dependTaskId), duration : parseInt( duration) })
        return dependTaskIndex + ':' + duration
    } else {
        //dependencyTaskList.push({ taskId : task.id, dependTaskId : parseInt(dependTaskId), duration : 0 }) 
        return dependTaskIndex
    }


}



function reflectDependancy(taskId, dependTaskId, duration) {
    dependencyTaskList[taskId.toString()] = { dependTaskId: dependTaskId, duration: duration }
    //task.depends_new = dependTaskId + ':' + duration
}

function getTaskDependancy(taskId, parentTaskId) {
    if (!(taskId.toString() in dependencyTaskList)) return ''
    //Added By Vaijat K For Parent dependency issue
    if (dependencyTaskList[taskId.toString()]['dependTaskId'] == parentTaskId) return '';
    //End Added By Vaijat K For Parent dependency issue
    return dependencyTaskList[taskId.toString()]['dependTaskId'] + ':' + dependencyTaskList[taskId.toString()]['duration']
}


function generateCustomField(customField) {
    fieldType = customField.ControlType.toString().toUpperCase()
    customField['valueHtml'] = '';
    customField['size'] = '';
    var strStyle = '';
    if (customField.MaxLength > 0 && customField.validateMaxLength == 1) {
        customField['size'] = 'size="' + customField.MaxLength + '"';
    }
    if (customField['ControlHeight'] > 10) {
        strStyle += 'height:' + customField['ControlHeight'].toString() + 'px;';
    }
    if (customField['ControlWidth'] > 10) {
        strStyle += 'width:' + customField['ControlWidth'].toString() + 'px;';
    }

    if (fieldType === 'COMBO') {
        var strHtml = ''
        var combos = customField.ComboFieldValues
        //console.log( combos )
        for (i in combos) {
            strHtml += '<option value="' + combos[i].FieldID + '" ' + (combos.FieldID == (customField['curValue'] ? customField['curValue'] : customField.DefaultValue) ? 'selected' : '') + '>' + combos[i].FieldName + '</option>'
        }
        customField['valueHtml'] = strHtml
    } else if (fieldType === 'DATE') {
        customField['valueHtml'] = customField['curValue'] != '' ? customField['curValue'] : new Date(customField['DefaultValue']).format('MM/dd/y')
    } else if (fieldType === 'TEXT') {

        customField['valueHtml'] = customField['curValue'] != '' ? customField['curValue'] : customField['DefaultValue']
    } else if (fieldType === 'TEXTAREA') {
        customField['valueHtml'] = customField['curValue'] != '' ? customField['curValue'] : customField['DefaultValue']
    }
    customField['style'] = strStyle

    return $.JST.createFromTemplate(customField, "CUSTOM_FIELD_" + fieldType);
}

function generateCustomFieldHtml(task, taskCustomFields) {

    var customFieldTable = $.JST.createFromTemplate({}, "CUSTOM_FIELD_CONTAINER");
    //console.log( customFieldTable  )

    for (i in taskCustomFields) {
        var customField = taskCustomFields[i]
        customField['curValue'] = task[customField.DatabaseFieldName] ? task[customField.DatabaseFieldName] : ''
        //console.log( customField )
        customFieldTable.find('#tdCustomFieldCell_' + customField.RowNumber + '_' + customField.ColumnNumber).html(generateCustomField(customField, customFieldTable));
    }

    return customFieldTable
}

function charSet(prefix) {
    var vPrefix = prefix || ''
    var retArr = []
    for (i = 0; i < 26; i++) {
        retArr.push(vPrefix.toString() + String.fromCharCode(65 + i).toString())
    }

    return retArr
}

function excelUpload() {
    //Reference the FileUpload element.
    var fileUpload = document.getElementById("fileUpload");

    //Validate whether File is valid Excel file.
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.xls|.xlsx)$/;
    if (false == regex.test(fileUpload.value.toLowerCase())) return alert("Please upload a valid Excel file.");

    if (false == (typeof (FileReader) != "undefined")) return alert("This browser does not support HTML5.");

    var reader = new FileReader();

    //For Browsers other than IE.
    if (reader.readAsBinaryString) {
        reader.onload = function (e) {
            processExcelData(e.target.result);
        };
        reader.readAsBinaryString(fileUpload.files[0]);
    } else {
        //For IE Browser.
        reader.onload = function (e) {
            var data = "";
            var bytes = new Uint8Array(e.target.result);
            for (var i = 0; i < bytes.byteLength; i++) {
                data += String.fromCharCode(bytes[i]);
            }
            processExcelData(data);
        };
        reader.readAsArrayBuffer(fileUpload.files[0]);
    }


    $('#importEditor_step2_link').addClass('active');
}
var importExcelRows = {}
var importPostData = []
function processExcelData(data) {
    //Read the Excel File data.
    var workbook = XLSX.read(data, {
        type: 'binary'
    });

    //Fetch the name of First Sheet.
    var firstSheet = workbook.SheetNames[0];
    var workFirstSheet = workbook.Sheets[firstSheet];
    if (Object.keys(workFirstSheet).length == 0) {
        alert('Please, Do not use blank sheet')
        return false;
    }
    var refWorkFirstSheet = workFirstSheet['!ref'].split(':');
    window.importPostData = []
    if (refWorkFirstSheet[0] != 'A1') {
        alert('Please, Do not use blank column on left or blank row on top')
        return false;
    }

    var colLenght = (Object.keys(workFirstSheet).length - 2) / 2

    if (colLenght == 0) {
        alert('Invalid Data')
        return false;
    }


    //Read all rows from First Sheet into an JSON array.
    importExcelRows = XLSX.utils.sheet_to_row_object_array(workFirstSheet);

    $('#importEditor_step1').hide();
    var charctersArr = charSet();
    var optionTextValue = getTaskTypeOptionValue()
    var strHtml = '';

    charctersArr.forEach(function (item, index) {
        strItemIndex = item.toString() + '1'
        if (Object.keys(listTaskType)[index]) {
            strHtml += '<div class="gdf-import-task-column">';
            strHtml += '<label> ExcelColumn-' + item.toString() + ' <b>:</b> </label>';
            strHtml += '<select id="excel_row_' + item.toString() + '" data-column="' + item.toString() + '" name="excel_row_' + item.toString() + '" class="import-field import-field-dropdown formElements" onchange="selectImportTaskType()" ' + ((Object.keys(listTaskType)[index]) ? '' : 'disabled') + '>';

            strHtml += '<option value=""></option>'
            strHtml += optionTextValue;
            strHtml += '</select>';
            strHtml += '</div>';
        }
    })
    $('#importTaskTableContainer').html(strHtml)
    $('#importEditor_step2').show();
}


function getTextHtml() {

    var strHtml = '';
    var emptyHtml = '';
    var charctersArr = charSet();

    if (Object.keys(importExcelRows).length <= 0) {
        $('#importEditorDetails').html(strHtml);
        return false;
    }

    var headers = Object.keys(importExcelRows[0])

    strHtml += '<tr>'
    emptyHtml += '<tr>'
    emptyHtml += '<td></td>'
    strHtml += '<th><input type="checkbox" id="selectAllTask" data-row="all" onchange="importSelectRow(this)"/></th>';
    for (i in headers) {
        strHtml += '<th>' + $('#excel_row_' + charctersArr[i] + ' option:selected').text() + '</th>';
        emptyHtml += '<td>&nbsp;</td>'
    }

    strHtml += '<th>Error</th>';
    emptyHtml += '<td>&nbsp;</td>'
    emptyHtml += '</tr>'
    strHtml += '</tr>'
    window.importPostData = []
    for (row in importExcelRows) {
        importData = {}
        currentRow = importExcelRows[row]
        strHtml += '<tr>'
        indexCol = 0

        strHtml += '<td><input type="checkbox" id="select_row_' + row + '" class="import-select" onchange="importSelectRow(this)" data-row="' + row + '" /></td>';
        for (col in currentRow) {

            strHtml += '<td>' + currentRow[col] + '</td>';
            importData[$('#excel_row_' + charctersArr[indexCol]).val()] = currentRow[col]
            indexCol++
        }

        window.importPostData.push(importData)
        strHtml += '<td> </td>'
        strHtml += '</tr>'

    }
    strHtml += emptyHtml + emptyHtml + emptyHtml + emptyHtml + emptyHtml
    $('#importEditorDetails').html(strHtml);

}

function getTaskTypeOptionValue() {
    var strHtml = '';
    for (item in listTaskType) {
        let dropDownField = 'Show' + listTaskType[item] + 'InAT'
        if (false == (currentProject.hiddenDropDown && currentProject.hiddenDropDown.indexOf(dropDownField) != -1)) {
            strHtml += '<option value="' + item + '">' + listTaskType[item] + '</option>';
        }
    }
    return strHtml
}

function importFromXsl() {

    var importTask = $.JST.createFromTemplate({}, "IMPORT_TASK");
    var ndo = createModalPopup(800, 600).append(importTask);
}


function gotoImportStep1() {
    $('#importTaskTableContainer').html('')
    $('#importEditor_step1').show();
    $('#importEditor_step2,#importEditor_step3').hide();
    $('#importEditor_step2_link').removeClass('active');
}

function importSelectRow(elem) {
    if ($(elem).data('row') == 'all') {
        $('.import-select').prop('checked', $('#selectAllTask').prop('checked'))
    } else {
        $('#selectAllTask').prop('checked', $('.import-select:checked').length == $('.import-select').length)
    }
}

function getFormData() {

    var data = new FormData();
    boolIsValid = true;
    $('.import-field-dropdown:not([disabled])').each(function () {
        if ($(this).val() == "") boolIsValid = false
        data[$(this).attr('data-column')] = $(this).val()
    });


    var curMandatoryDropdown = ['TaskNameMandatoryInAT', 'EndDateMandatoryInAT', 'EmployeeNameMandatoryInAT', 'EffortMandatoryInAT', 'StartDateMandatoryInAT']
    for (i in currentProject.mandatoryDropDown) {
        curMandatoryDropdown.push(currentProject.mandatoryDropDown[i])
    }

    $('.import-field-dropdown:not([disabled])').each(function () {
        if ($(this).val() == "") boolIsValid = false
        data[$(this).attr('data-column')] = $(this).val()
        var keyField = $(this).val() + "MandatoryInAT"
        if ($(this).val().toUpperCase() == 'PHASE') keyField = "PhasesMandatoryInAT"
        var keyIndex = curMandatoryDropdown.indexOf(keyField)
        if (keyIndex != -1) {
            delete curMandatoryDropdown[keyIndex]
        }
    });
    var remainingKeys = []
    for (i in curMandatoryDropdown) {
        var remainKey = curMandatoryDropdown[i].replace('MandatoryInAT', '');
        remainingKeys.push(remainKey)
    }
    if (remainingKeys.length > 0) {
        //console.log( remainingKeys )
        alert(remainingKeys.join(',') + ' needs to be selected')
        return false;
    }

    jQuery.each(jQuery('#fileUpload')[0].files, function (i, file) {
        data['file'] = file;
    });

    $('.import-field-dropdown:not([disabled])').each(function () {
        data.append($(this).attr('data-column'), $(this).val())
    });
    return data
}

function sendImportTask() {

    var data = getFormData()
    if (data == false) return false;

    jQuery.ajax({
        url: ApiURL['importTasks'],
        data: data,
        cache: false,
        contentType: false,
        processData: false,
        type: 'POST',
        success: function (data) {
            getTextHtml();
        },
        error: function (xhr, status, error) {
            //getTextHtml();
            console.log(xhr, status, error)
        }
    });
    return true
}

function confirmUpload() {
    var data = getFormData()
    data['confirm-upload'] = true;
    var jsonData = []
    if ($('.import-select:checked').length == 0) {
        alert('Please Select At least one row to upload')
        return false;
    }
    $('.import-select:checked').each(function (index, item) {
        jsonData.push(importPostData[$(item).attr('data-row')])
    })

    jQuery.ajax({
        url: ApiURL['confirmImportTask'],
        data: data,
        cache: false,
        contentType: false,
        processData: false,
        type: 'POST',
        success: function (data) {
        },
        error: function (xhr, status, error) {
            console.log(xhr, status, error)
        }

    });
    return true;
}

function gotoImportStep2() {
    $('#importEditor_step2').show();
    $('#importEditor_step1,#importEditor_step3').hide();
    $('#importEditor_step3_link').removeClass('active');
}

function gotoImportStep3() {

    if (!sendImportTask()) {
        return false;
    } else {
        $('#importEditor_step3').show();
        $('#importEditor_step1,#importEditor_step2').hide();
        $('#importEditor_step3_link').addClass('active');
    }

}

function getTaskCondition(task) {
    var todaysDate = new Date(currentProject.serverDate).getTime()
    var planedStartDate = getTimeInInt(task.start);
    var actualStartDate = (task.actualStartTime != '0') ? new Date(task.actualStartTime).getTime() : 0;
    var actualEndDate = (task.actualEndTime != '0') ? new Date(task.actualEndTime).getTime() : 0;
    var planedEndDate = getTimeInInt(task.end);
    var taskCondition = 'CONDITION_BLACK'
    var plannedEfforts = taskHoursToMin(task.planefforts)
    var actualEfforts = taskHoursToMin(task.actualEfforts)
    var isTaskComplete = task.status == 'C'

    var isAmber1 = !isTaskComplete && actualStartDate == 0 && planedStartDate == todaysDate
    var isAmber2 = !isTaskComplete && actualStartDate != 0 && planedEndDate == todaysDate

    var isRed1 = planedEndDate < todaysDate && actualStartDate == 0
    var isRed2 = !isTaskComplete && actualStartDate != 0 && todaysDate > planedEndDate
    var isRed3 = actualEndDate > planedEndDate
    var isRed4 = actualEfforts > plannedEfforts

    var isGreen = actualEndDate <= planedEndDate && plannedEfforts !== 0 && actualEfforts <= plannedEfforts

    var isAmber3 = !((isTaskComplete && actualEndDate != 0 && actualEfforts != 0) && (!isRed3 || !isRed4 || !isGreen)) && (planedStartDate > actualStartDate && actualStartDate < planedEndDate)

    var isYellow = planedStartDate > todaysDate

    if (isRed1) return 'CONDITION_RED1'
    if (isRed2) return 'CONDITION_RED2'
    if (isRed3) return 'CONDITION_RED3'
    if (isRed4) return 'CONDITION_RED4'

    if (isAmber1) return 'CONDITION_AMBER1';
    if (isAmber2) return 'CONDITION_AMBER2';
    if (isAmber3) return 'CONDITION_AMBER3';

    if (isYellow) return 'CONDITION_YELLOW'

    if (isGreen) return 'CONDITION_GREEN'

    return taskCondition;
}

function selectImportTaskType() {

    var myOpt = [];
    $(".import-field-dropdown").each(function () {
        myOpt.push($(this).val());
    });

    $(".import-field-dropdown").each(function () {
        $(this).find("option").prop('hidden', false);
        var sel = $(this);
        $.each(myOpt, function (key, value) {
            if ((value != "") && (value != sel.val())) {
                sel.find("option").filter('[value="' + value + '"]').prop('hidden', true);
            }
        });
    });
}



function importFromXsl() {

    var importTask = $.JST.createFromTemplate({}, "IMPORT_TASK");
    var ndo = createModalPopup(800, 600).append(importTask);
}


function isValidWorkHours(taskHours, duration, isParent) {
    if (isParent == '1') return ''
    if (!taskHours) return '0'
    var str = taskHours || '0'
    //Commented and Added By Vaijat K For Issue Id : - 26015
    //var newStr = str.split(":");
    var newStr = String(str).split(":");
    //End Commented and Added By Vaijat K For Issue Id : - 26015
    if (newStr.length == 1) newStr['1'] = 0

    var min = parseInt(newStr['1'])

    if (taskHoursToMin(taskHours) <= 0) {
        return "Please enter work hours greater than 0";
    }

    if (window.currentProject.minHoursForDAEntry != 1) {
        if (0 != min % window.currentProject.minHoursForDAEntry) {
            return "Please enter minutes in multiple of " + window.currentProject.minHoursForDAEntry
        }
    }
    var completeDuration = duration * 24
    if (taskHoursToMin(taskHours) > taskHoursToMin(completeDuration)) {
        return "Please enter work hours which should be less than " + completeDuration + " hours";
    }

    return '';
}

function taskHoursToMin(taskHours) {
    if (typeof taskHours == 'undefined' || !taskHours || taskHours == 0) return 0
    var str = taskHours.toString()
    if (str.indexOf(':') == -1) return taskHours * 60
    var newStr = str.split(":");
    if (newStr.length == 1) newStr['1'] = 0
    // if (newStr.length == 0) newStr['0'] = 0
    var min = parseInt(newStr['1'])
    var hours = parseInt(newStr['0'])
    return min + (hours * 60)
}

function minToHHMM(taskMin) {
    //Commetned and added By Vaijat K For changing planned efforts issue
    //return Math.floor(taskMin / 60) + ':' + pad(Math.floor(taskMin % 60), 2)
    return Math.floor(taskMin / 60) + ':' + pad(Math.ceil(taskMin % 60), 2)
    //End Commetned and added By Vaijat K For changing planned efforts issue
}

function pad(n, width, z) {
    z = z || '0';
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

function changeDependantCombo(elemDropDown) {
    if ($(elemDropDown).attr('name') == 'UserStory') {
        var selOption = $('select[name="UserStory"] option:selected')
        $('select[name="Release"] option').attr('disabled', 'disabled')
        $('select[name="Sprint"] option').attr('disabled', 'disabled')
        var releaseId = selOption.attr('data-item-release-value')
        var sprintId = selOption.attr('data-item-sprint-value')
        //console.log(releaseId,sprintId)
        $('select[name="Release"] option[value="' + releaseId + '"]').removeAttr('disabled')
        $('select[name="Release"]').val(releaseId)
        $('select[name="Sprint"] option[value="' + sprintId + '"]').removeAttr('disabled')
        $('select[name="Sprint"]').val(sprintId)
        //$('select[name="Release"]').val($('option:selected', elemDropDown).attr('data-item-release-value'))
        //$('select[name="Sprint"]').val($('option:selected', elemDropDown).attr('data-item-sprint-value'))
    }
}

function enableStatusOptions(elemStatus, currentStatus, isNew, actualEfforts) {

    elemStatus.find('option:not([value="' + currentStatus + '"])').hide();

    switch (currentStatus) {
        case STATUS_ACTIVE:
            //Commented And Added By Vaijat K For Issue Id: 26006
            //elemStatus.find('option[value="' + STATUS_INACTIVE + '"]').show()
            !isNew && elemStatus.find('option[value="' + STATUS_INACTIVE + '"]').show()
            //End Commented And Added By Vaijat K For Issue Id: 26006
            //Added By Vaijat K For Not showing Completed status if actuals are not present
            if (actualEfforts != 0)
                !isNew && elemStatus.find('option[value="' + STATUS_COMPLETED + '"]').show()
            !isNew && elemStatus.find('option[value="' + STATUS_VOID + '"]').show()
            !isNew && elemStatus.find('option[value="' + STATUS_HOLD + '"]').show()
            break;

        case STATUS_INACTIVE:
            elemStatus.find('option[value="' + STATUS_ACTIVE + '"]').show()
            break;

        case STATUS_VOID:
            elemStatus.find('option[value="' + STATUS_NOT_VOID + '"]').show()
            break;

        case STATUS_NOT_VOID:
            elemStatus.find('option[value="' + STATUS_ACTIVE + '"]').show()
            break;

        case STATUS_HOLD:
            elemStatus.find('option[value="' + STATUS_UN_HOLD + '"]').show()
            break;

        case STATUS_UN_HOLD:
            elemStatus.find('option[value="' + STATUS_ACTIVE + '"]').show()
            break;

        case STATUS_COMPLETED:
            elemStatus.find('option[value="' + STATUS_ACTIVE + '"]').show()
            break;
    }
}

function changeChildTaskStatus(task, newParentStatus) {
    if (false == confirm("All child status will get changed as per the parent status/Relevant status")) return false;

    if (newParentStatus == STATUS_ACTIVE) return true;

    childs = task.getChildren()
    for (x in childs) {
        var childStatus = childs[x].status
        if (childStatus == newParentStatus) continue;

        if (newParentStatus == STATUS_COMPLETED) {
            if (childs[x].actualEfforts == 0 || childStatus == STATUS_VOID) {
                childs[x].status = STATUS_VOID
            } else {
                childs[x].status = STATUS_COMPLETED
                if (taskHoursToMin(childs[x].planefforts) < taskHoursToMin(childs[x].actualEfforts)) {
                    alert("Child Task's Planned Work hours should be greater than Actual work hours (" + minToHHMM(taskHoursToMin(chld[x].actualEfforts)) + ")")
                    return false;
                }
            }
        } else if (newParentStatus == STATUS_VOID) {
            childs[x].status = (childs[x].actualEfforts > 0 && childStatus == STATUS_COMPLETED) ? STATUS_COMPLETED : newParentStatus;
        } else {
            childs[x].status = newParentStatus
        }
    }

    return true;
}

function changeParentTaskStatus(task, newStatus) {
    var par = task.getParent()
    var childs = par.getChildren()
    if (childs.length == 1) {
        par.status = newStatus
        return false;
    }
    boolChangeParentStatus = true;
    for (x in childs) {
        if (childs[x].id == task.id) continue;
        boolChangeParentStatus &= childs[x].status == newStatus
    }

    par.status = boolChangeParentStatus ? newStatus : STATUS_ACTIVE
}

function updateResourceChangeList(taskId, oldResource, newResource) {
    //Commented And Added By Vaijat K
    //if (oldResource == newResource || false == confirm("Are you sure to change the current reource")) return true;
    if (oldResource == newResource || false == confirm("Are you sure to change the current resource")) return true;
    var taskKey = 'change_resource_' + taskId.toString()
    var boolIsExisting = (taskKey in ganttResourceList)
    var resoruceObj = {
        'orig': boolIsExisting ? ganttResourceList[taskKey]['orig'] : oldResource,
        'old': oldResource,
        'new': newResource
    }
    ganttResourceList[taskKey] = resoruceObj
}

function pushChangedResourceTask(task, newPushTask) {
    var taskKey = 'change_resource_' + task.id;
    if (!(taskKey in window.ganttResourceList)) return false;
    changeResourceTask = window.ganttResourceList[taskKey]
    if (changeResourceTask.orig == changeResourceTask.new) return false;
    var clonedTask = { ...task };
    clonedTask.id = 'tid_tmp_fk' + new Date().getTime()
    task.status = STATUS_VOID
    newPushTask.push(clonedTask)
}

function getAverage(grades) {
    //console.log(grades)
    if (grades.length == 0) return 0;
    if (grades.length == 1) return grades[0];
    const total = grades.reduce((acc, c) => acc + c, 0);
    return total / grades.length;
}

function getDependsRowId(depends, tasks) {
    var arr = depends.split(':')
    var dependTaskIndex = 0, duration = 0;
    if (parseInt(arr[0]) > 0) dependTaskIndex = arr[0]
    if (parseInt(arr[1]) > 0) duration = arr[1]
    //console.log(dependTaskIndex, ':', taskRowMapArr[dependTaskIndex], ':', duration)
    //if( parseInt(arr[1]) > 0 ){
    //return taskRowMapArr[dependTaskIndex]+':'+duration;
    //}else{
    //return taskRowMapArr[dependTaskIndex]+':'+0;	
    // }
    //Commented and Added By Vaijat K For Issue Id :- 26022
    //return taskRowMapArr[dependTaskIndex] + ':' + duration;
    return getTaskRowIdFromArray(dependTaskIndex, tasks) + ':' + duration;
    //End Commented By Vaijat K For Issue Id :- 26022
}

//Added By Vaijat K For Issue Id :- 26022
function getTaskRowIdFromArray(dependTaskIndex, tasks) {
    var rowId = 0;
    for (var i = 0; i < tasks.length; i++) {
        if (tasks[i].taskid == dependTaskIndex) {
            rowId = i + 1;
            return rowId;
        }
    }
}
//End Added By Vaijat K For Issue Id: - 26022

function compareTask(a, b) {
    //Commented By Vaijat K For Issue Id :- 
    //if (a['parentTaskId'] != b['parentTaskId']) return 0;

    if (parseInt(a['wbsid']) < parseInt(b['wbsid']))
        return -1;
    if (parseInt(a['wbsid']) > parseInt(b['wbsid']))
        return 1;
    return 0;
}

function customExpandAllTasks() {
    $('.taskEditRow.isParent').each(function (item, index) {
        $(this).click(); $('#workSpace').trigger('expandAll.gantt');
    });
}

function customCollapseAllTasks() {
    $('.taskEditRow.isParent').each(function (item, index) {
        $(this).click();
        $('#workSpace').trigger('collapseAll.gantt');
    });
}

function revertInlineDataData(task) {
    task['start'] = $('#startDate_' + task.id).data('oldValue')
    task['end'] = $('#endDate_' + task.id).data('oldValue')

    //Commented And Added By Vaijat K  For Issue Id :- 26044
    //$('#startDate_' + task.id).val(task['start'])
    //$('#startDate_' + task.id).val(task['end'])
    let current_datetime = new Date()
    current_datetime.setTime(task['start'])
    let formatted_date = + (current_datetime.getMonth() + 1) + "/" + current_datetime.getDate() + "/" + current_datetime.getFullYear()
    $('#startDate_' + task.id).val(formatted_date)

    let current_datetime2 = new Date()
    current_datetime2.setTime(task['end'])
    //Commented and added by Vaijat K For Issue id :- 26044
    //let formatted_date1 = current_datetime2.getFullYear() + "/" + (current_datetime2.getMonth() + 1) + "/" + current_datetime2.getDate()
    let formatted_date1 = + (current_datetime2.getMonth() + 1) + "/" + current_datetime2.getDate() + "/" + current_datetime2.getFullYear()
    $('#endDate_' + task.id).val(formatted_date1)
    //Commented And Added By Vaijat K  For Issue Id :- 26044
}

function triggerOnFocus(elem) {
    if ($(elem).attr('name') == 'name') {
        if ($(elem).val() == '') {
            $('#btnDeleteTask').attr('disabled', 'disabled')
        }
    }
}

function triggerOnBlur(elem) {
    if ($(elem).attr('name') == 'name') {
        $('#btnDeleteTask').removeAttr('disabled')
    }

    if ($.trim($(elem).val()) != '' && $(elem).attr('data-is-passed-project') == '1') {
        $(elem).removeAttr('data-is-passed-project')
        alert('Task End Date should not be after the Project End Date (' + new Date(window.projectEndDate).format('MM/dd/yyyy') + ')!')
    }
}

function manageProjectAccess(currProj) {
    $('body').addClass('hideEditIcon').addClass('hideDeleteIcon')
    accessAlertArr = []
    if (currProj.projectCanAdd == 1) {
        // Do nothing
    } else {
        accessAlertArr.push('Add')
    }

    if (currProj.projectCanDelete == 1) {
        $('body').removeClass('hideDeleteIcon')
    } else {
        accessAlertArr.push('Delete')
    }
    if (currProj.projectCanEdit == 1) {
        $('body').removeClass('hideEditIcon')
    } else {
        accessAlertArr.push('Edit')
    }
    $("#accessAlertContainer").hide();

    if (accessAlertArr.length > 0) {
        $("#accessAlertContainer").show().html('<i class="glyphicon glyphicon-alert"></i> ' + accessAlertArr.join('/') + ' Access is not given.');
    }
}

function changePlanEffort(planedefforts) {
    if (planedefforts && planedefforts.toString().indexOf(':') == -1) {
        return minToHHMM(taskHoursToMin(planedefforts))
    }
    return planedefforts
}

function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit) field.value = field.value.substring(0, maxlimit);
}
//Added By Vaijat K For making fields active again
function MakeActiveAll(obj, status) {
    $("#panel_basic").removeClass("task-" + status);
    $("#panel_basic").addClass("task-" + $(obj).val());
}
//End Added By Vaijat K For making fields active again