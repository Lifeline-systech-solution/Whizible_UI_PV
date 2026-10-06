/*
 Copyright (c) 2012-2018 Open Lab
 Written by Roberto Bicchierai and Silvia Chelazzi http://roberto.open-lab.com
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
var globarParentId = 0;
var oldeffortvalue = 0;
var taskIdEdit = 0
var actualEffortsEdit = 0;
var taskGlobal;
function GridEditor(master) {
    this.master = master; // is the a GantEditor instance

    var editorTabel = $.JST.createFromTemplate({}, "TASKSEDITHEAD");
    if (!master.permissions.canSeeDep)
        editorTabel.find(".requireCanSeeDep").hide();

    this.gridified = $.gridify(editorTabel);
    this.element = this.gridified.find(".gdfTable").eq(1);

    this.minAllowedDate = new Date(new Date().getTime() - 3600000 * 24 * 365 * 20).format();
    this.maxAllowedDate = new Date(new Date().getTime() + 3600000 * 24 * 365 * 30).format();
}



GridEditor.prototype.fillEmptyLines = function () {
    //console.debug("fillEmptyLines")
    // console.log(window.taskHours);
    // console.log(window.projectResources);
    //  console.log(window.projectHours);
    //  console.log(window.projectStartDate);
    //  console.log(window.projectEndDate);

    var factory = new TaskFactory();
    var master = this.master;

    //console.debug("GridEditor.fillEmptyLines");
    var rowsToAdd = master.minRowsInEditor - this.element.find(".taskEditRow").length;
    var empty = this.element.find(".emptyRow").length;
    rowsToAdd = Math.max(rowsToAdd, empty > 5 ? 0 : 5 - empty);

    //fill with empty lines
    for (var i = 0; i < rowsToAdd; i++) {

        var emptyRow = $.JST.createFromTemplate({}, "TASKEMPTYROW");
        if (!master.permissions.canSeeDep)
            emptyRow.find(".requireCanSeeDep").hide();

        //click on empty row create a task and fill above
        emptyRow.click(function (ev) {
            //console.debug("emptyRow.click")
            var emptyRow = $(this);
            //add on the first empty row only
            if (parseInt(window.projectCanAdd) != 1) return false;

            if (!master.permissions.canAdd || emptyRow.prevAll(".emptyRow").length > 0)
                return;

            master.beginTransaction();
            var lastTask;
            var start = new Date().getTime();
            var level = 0;
            // if (master.tasks[0]) {
            //   start = master.tasks[0].start;
            //   level = master.tasks[0].level + 1;
            // }

            //fill all empty previouses
            var cnt = 0;
            emptyRow.prevAll(".emptyRow").addBack().each(function () {
                cnt++;
                var ch = factory.build("tmp_fk" + new Date().getTime() + "_" + cnt, "", "", level, start, Date.workingPeriodResolution);
                var task = master.addTask(ch);
                lastTask = ch;
            });
            master.endTransaction();
            if (lastTask.rowElement) {
                hideColumns()
                lastTask.rowElement.find("[name=name]").focus();//focus to "name" input
                if (currentProject.isPassedProject) {
                    lastTask.rowElement.find("[name=name]").attr('data-is-passed-project', 1);
                }

            }
        });
        this.element.append(emptyRow);
    }
};


GridEditor.prototype.addTask = function (task, row, hideIfParentCollapsed) {
    //console.debug("GridEditor.addTask",task,row);
    //var prof = new Profiler("ganttGridEditor.addTask");

    //remove extisting row
    this.element.find("#tid_" + task.id).remove();

    var taskRow = $.JST.createFromTemplate(task, "TASKROW");

    if (!this.master.permissions.canSeeDep)
        taskRow.find(".requireCanSeeDep").hide();

    if (!this.master.permissions.canSeePopEdit)
        taskRow.find(".edit .teamworkIcon").hide();

    //save row element on task
    task.rowElement = taskRow;

    this.bindRowEvents(task, taskRow);

    if (typeof (row) != "number") {
        var emptyRow = this.element.find(".emptyRow:first"); //tries to fill an empty row
        if (emptyRow.length > 0)
            emptyRow.replaceWith(taskRow);
        else
            this.element.append(taskRow);
    } else {
        var tr = this.element.find("tr.taskEditRow").eq(row);
        if (tr.length > 0) {
            tr.before(taskRow);
        } else {
            this.element.append(taskRow);
        }

    }

    //[expand]
    if (hideIfParentCollapsed) {
        if (task.collapsed) taskRow.addClass('collapsed');
        var collapsedDescendant = this.master.getCollapsedDescendant();
        if (collapsedDescendant.indexOf(task) >= 0) taskRow.hide();
    }
    //prof.stop();
    return taskRow;
};

GridEditor.prototype.refreshExpandStatus = function (task) {
    //console.debug("refreshExpandStatus",task);
    if (!task) return;
    if (task.isParent()) {
        task.rowElement.addClass("isParent");
    } else {
        task.rowElement.removeClass("isParent");
    }


    var par = task.getParent();
    if (par && !par.rowElement.is("isParent")) {
        par.rowElement.addClass("isParent");
    }

};

GridEditor.prototype.refreshTaskRow = function (task) {
    //console.debug("refreshTaskRow")
    //var profiler = new Profiler("editorRefreshTaskRow");

    var canWrite = this.master.permissions.canWrite || task.canWrite;

    var row = task.rowElement;

    row.find(".taskRowIndex").html(task.getRow() + 1);
    row.find(".indentCell").css("padding-left", task.level * 10 + 18);
    row.find("[name=name]").val(task.name);
    row.find("[name=code]").val(task.code);
    row.find("[status]").attr("status", task.status);

    //console.log('HH:MM',window.minHoursForDAEntry,task.planefforts);
    if (task.parentTaskId != 0) {

        row.find("[name=planefforts]").val(minToHHMM(taskHoursToMin(task.planefforts)));
        reCalculateParentWorkHours(task.parentTaskId);
        //Added By Vaijat K For Task effort issue 
        task.planefforts = minToHHMM(taskHoursToMin(task.planefforts));
    }

    row.find("[name=duration]").val(durationToString(task.duration)).prop("readonly", !canWrite || task.isParent() && task.master.shrinkParent);
    row.find("[name=progress]").val(task.progress).prop("readonly", !canWrite || task.progressByWorklog == true);
    row.find("[name=startIsMilestone]").prop("checked", task.startIsMilestone);
    row.find("[name=start]").val(new Date(task.start).format()).updateOldValue().prop("readonly", !canWrite || task.depends || !(task.canWrite || this.master.permissions.canWrite)); // called on dates only because for other field is called on focus event
    row.find("[name=endIsMilestone]").prop("checked", task.endIsMilestone);
    row.find("[name=end]").val(new Date(task.end).format()).prop("readonly", !canWrite || task.isParent() && task.master.shrinkParent).updateOldValue();
    row.find("[name=depends]").val(task.depends);
    row.find(".taskAssigs").html(task.getAssigsString());

    row.find(".taskAssigs").attr('data-is-empty', ('' == $.trim(task.getAssigsString()) ? 1 : 0));

    //manage collapsed
    if (task.collapsed)
        row.addClass("collapsed");
    else
        row.removeClass("collapsed");


    //Enhancing the function to perform own operations
    this.master.element.trigger('gantt.task.afterupdate.event', task);
    //profiler.stop();
};

GridEditor.prototype.redraw = function () {
    //console.debug("GridEditor.prototype.redraw")
    //var prof = new Profiler("gantt.GridEditor.redraw");
    for (var i = 0; i < this.master.tasks.length; i++) {
        this.refreshTaskRow(this.master.tasks[i]);
    }
    // check if new empty rows are needed
    if (this.master.fillWithEmptyLines)
        this.fillEmptyLines();

    //prof.stop()

};

GridEditor.prototype.reset = function () {
    this.element.find("[taskid]").remove();
};


GridEditor.prototype.bindRowEvents = function (task, taskRow) {
    var self = this;
    //console.debug("bindRowEvents",this,this.master,this.master.permissions.canWrite, task.canWrite);

    //bind row selection
    taskRow.click(function (event) {
        var row = $(this);
        //console.debug("taskRow.click",row.attr("taskid"),event.target)
        //var isSel = row.hasClass("rowSelected");
        row.closest("table").find(".rowSelected").removeClass("rowSelected");
        row.addClass("rowSelected");

        //set current task
        self.master.currentTask = self.master.getTask(row.attr("taskId"));

        //move highlighter
        self.master.gantt.synchHighlight();

        //if offscreen scroll to element
        var top = row.position().top;
        if (top > self.element.parent().height()) {
            row.offsetParent().scrollTop(top - self.element.parent().height() + 100);
        } else if (top <= 40) {
            row.offsetParent().scrollTop(row.offsetParent().scrollTop() - 40 + top);
        }

    });


    if (this.master.permissions.canWrite || task.canWrite) {
        self.bindRowInputEvents(task, taskRow);

    } else { //cannot write: disable input
        taskRow.find("input").prop("readonly", true);
        taskRow.find("input:checkbox,select").prop("disabled", true);
    }

    if (!this.master.permissions.canSeeDep)
        taskRow.find("[name=depends]").attr("readonly", true);

    self.bindRowExpandEvents(task, taskRow);

    if (this.master.permissions.canSeePopEdit) {
        taskRow.find(".edit").click(function () { self.openFullEditor(task, false) });

        taskRow.dblclick(function (ev) { //open editor only if no text has been selected
            if (task.name != "") { //Added By Vaijat K For Issue Id :- 26038
                if (window.getSelection().toString().trim() == "")
                    self.openFullEditor(task, $(ev.target).closest(".taskAssigs").size() > 0)
            }
        });
    }

    taskRow.focusout(function (ev) {
    });
    //prof.stop();
};


GridEditor.prototype.bindRowExpandEvents = function (task, taskRow) {
    var self = this;
    //expand collapse
    taskRow.find(".exp-controller").click(function () {
        var el = $(this);
        var taskId = el.closest("[taskid]").attr("taskid");
        var task = self.master.getTask(taskId);
        if (task.collapsed) {
            self.master.expand(task, false);
        } else {
            self.master.collapse(task, false);
        }
    });
};

GridEditor.prototype.bindRowInputEvents = function (task, taskRow) {
    var self = this;
    self.projectStartDate = new Date(window.projectStartDate)
    self.projectEndDate = new Date(window.projectEndDate)

    //bind dateField on dates
    taskRow.find(".date").each(function () {
        var el = $(this);
        el.click(function () {
            var inp = $(this);
            inp.dateField({
                inputField: el,
                minDate: self.minAllowedDate,
                maxDate: self.maxAllowedDate,
                callback: function (d) {
                    if (d.getTime() > self.projectEndDate.getTime()) {
                        alert('Task Date should not be greater than Project End Date (' + new Date(self.projectEndDate).format('MM/dd/yyyy') + ')')
                        inp.val(inp.getOldValue());
                        return false;
                    }
                    //Commented and added by Vaijat K For date validation
                    //if (d.getTime() <= self.projectStartDate.getTime()) {
                    if (d.getTime() < self.projectStartDate.getTime()) {
                        alert('Task Date should be greater than Project Start Date (' + new Date(self.projectStartDate).format('MM/dd/yyyy') + ')')
                        inp.val(inp.getOldValue());
                        return false;
                    }
                    $(this).blur();
                }
            });
        });

        el.blur(function (date) {
            var inp = $(this);
            if (inp.isValueChanged()) {
                if (!Date.isValid(inp.val())) {
                    alert(GanttMaster.messages["INVALID_DATE_FORMAT"]);
                    inp.val(inp.getOldValue());

                } else {
                    var row = inp.closest("tr");
                    var taskId = row.attr("taskId");
                    var task = self.master.getTask(taskId);
                    // check start date and end date of resource
                    // get resources start date and end date
                    var d1 = row.find("[name=start]").val();
                    var d2 = row.find("[name=end]").val();
                    var dateAr = d1.split('/');
                    var date_start = (dateAr[0].length >= 2 ? dateAr[0] : '0' + dateAr[0]) + '/' + (dateAr[1].length >= 2 ? dateAr[1] : '0' + dateAr[1]) + '/' + dateAr[2].slice(-2);

                    var dateAr = d2.split('/');
                    var date_end = (dateAr[0].length >= 2 ? dateAr[0] : '0' + dateAr[0]) + '/' + (dateAr[1].length >= 2 ? dateAr[1] : '0' + dateAr[1]) + '/' + dateAr[2].slice(-2);

                    var resources = row.find(".resources").html();
                    //Added By Vaijat K For Issue Id:- 
                    var isInvalid = 0;
                    // console.log("date",d1,d2,"date_start",date_start,date_end,resources)
                    for (i in projectResources) {
                        if (projectResources[i].name == resources) {
                            //Commented And Added By Vaijat K For Resource Date validation issue
                            //if (projectResources[i].resourceStartDate > date_start) {
                            if (new Date(projectResources[i].resourceStartDate) > new Date(date_start)) {
                                //End Commented And Added By Vaijat K For Resource Date validation issue
                                alert('Task start date should be within or equal to Resource Start date! (' + projectResources[i].resourceStartDate + ' )')
                                inp.val(inp.getOldValue());
                                //return false;
                                isInvalid = 1;
                            }

                            if (new Date(projectResources[i].resourceEndDate) < new Date(date_end)) {
                                alert('Task End date should be within or equal to Resource End date! (' + projectResources[i].resourceEndDate + ' )')
                                inp.val(inp.getOldValue());
                                //return false;
                                isInvalid = 1;
                            }
                        }
                    }

                    if (isInvalid == 1) {
                        return false;
                    }

                    var leavingField = inp.prop("name");
                    var dates = resynchDates(inp, row.find("[name=start]"), row.find("[name=startIsMilestone]"), row.find("[name=duration]"), row.find("[name=end]"), row.find("[name=endIsMilestone]"));
                    //console.debug("resynchDates",new Date(dates.start), new Date(dates.end),dates.duration)
                    //update task from editor
                    self.master.beginTransaction();
                    var bl = self.master.changeTaskDates(task, dates.start, dates.end);
                    self.master.endTransaction();
                    inp.updateOldValue(); //in order to avoid multiple call if nothing changed
                    if (bl == false) {
                        return false;
                    }
                    //Commented Added By Vaijat K For Issue Id :- 26004
                    //if (taskId.indexOf('tmp_') != -1 && inp.attr('name') == 'end') {
                    if (inp.attr('name') == 'end') {
                        var endDate = new Date()
                        endDate.setTime(new Date(inp.val()).getTime())
                        var endWorkHours = recomputeWorkHours(dates.start, endDate.getTime());
                        endWorkHours = minToHHMM(taskHoursToMin(endWorkHours))
                        $('#tid_' + taskId).find("input:text[name=planefforts]").val(endWorkHours).trigger('blur')
                    }
                    //End of Commented Added By Vaijat K For Issue Id :- 26004
                }
            }
        });
    });

    //milestones checkbox
    taskRow.find(":checkbox").click(function () {
        var el = $(this);
        var row = el.closest("tr");
        var taskId = row.attr("taskId");

        var task = self.master.getTask(taskId);

        //update task from editor
        var field = el.prop("name");

        if (field == "startIsMilestone" || field == "endIsMilestone") {
            self.master.beginTransaction();
            //milestones
            task[field] = el.prop("checked");
            resynchDates(el, row.find("[name=start]"), row.find("[name=startIsMilestone]"), row.find("[name=duration]"), row.find("[name=end]"), row.find("[name=endIsMilestone]"));
            self.master.endTransaction();
        }

    });


    //binding on blur for task update (date exluded as click on calendar blur and then focus, so will always return false, its called refreshing the task row)
    taskRow.find("input:text:not(.date)").focus(function () {
        $(this).updateOldValue();

    }).blur(function (event) {
        var el = $(this);
        var row = el.closest("tr");
        var taskId = row.attr("taskId");
        var task = self.master.getTask(taskId);
        //update task from editor
        var field = el.prop("name");

        boolValueChanged = el.isValueChanged()
        if (field == 'depends' && boolValueChanged == true) {
            if (parseInt(el.attr('data-accept')) == -1) {
                correctedValue = confirmDependency(el.val(), task, self.master.tasks);
                el.val(correctedValue)
                boolValueChanged = false;
            } else if (parseInt(el.attr('data-accept')) == 1) {
                boolValueChanged = true;
            }
        }

        if (boolValueChanged) {
            self.master.beginTransaction();

            if (field == "depends") {

                var oldDeps = task.depends;
                task.depends = el.val();
                // update links
                var linkOK = self.master.updateLinks(task);
                if (linkOK) {
                    //synchronize status from superiors states
                    var sups = task.getSuperiors();

                    var oneFailed = false;
                    var oneUndefined = false;
                    var oneActive = false;
                    var oneSuspended = false;
                    var oneWaiting = false;
                    for (var i = 0; i < sups.length; i++) {
                        oneFailed = oneFailed || sups[i].from.status == STATUS_FAILED;
                        oneUndefined = oneUndefined || sups[i].from.status == STATUS_UNDEFINED;
                        oneActive = oneActive || sups[i].from.status == STATUS_ACTIVE;
                        oneSuspended = oneSuspended || sups[i].from.status == STATUS_SUSPENDED;
                        oneWaiting = oneWaiting || sups[i].from.status == STATUS_WAITING;
                    }

                    if (oneFailed) {
                        task.changeStatus(STATUS_FAILED)
                    } else if (oneUndefined) {
                        task.changeStatus(STATUS_UNDEFINED)
                    } else if (oneActive) {
                        //task.changeStatus("STATUS_SUSPENDED")
                        //task.changeStatus(STATUS_WAITING)
                        // Do nothing
                    } else if (oneSuspended) {
                        task.changeStatus(STATUS_SUSPENDED)
                    } else if (oneWaiting) {
                        task.changeStatus(STATUS_WAITING)
                    } else {
                        task.changeStatus(STATUS_ACTIVE)
                    }
                    el.attr('data-accept', '-1')

                    self.master.changeTaskDeps(task); //dates recomputation from dependencies
                }

            } else if (field == "duration") {
                if (isNaN(parseFloat(el.val())) == true) {
                    el.val(task.duration);
                }
                var dates = resynchDates(el, row.find("[name=start]"), row.find("[name=startIsMilestone]"), row.find("[name=duration]"), row.find("[name=end]"), row.find("[name=endIsMilestone]"));
                self.master.changeTaskDates(task, dates.start, dates.end);

            } else if (field == "name" && el.val() == "") { // remove unfilled task
                self.master.deleteCurrentTask(taskId);


            } else if (field == "progress") {
                task[field] = parseFloat(el.val()) || 0;
                el.val(task[field]);
            } else if (field == "planefforts") {
                if (isNaN(parseFloat(el.val())) == true) {
                    el.val(task.planefforts);
                }
                currentTaskHours = task[field] || 0
                //Added By Vaijat K
                var newStr = String(el.val()).split(":");
                if (newStr.length == 2) {
                    if (newStr[0] == "") newStr[0] = "0";
                    if (newStr[1] == "") newStr[1] = "00";
                    el.val(String(newStr[0] + ":" + newStr[1]));
                }
                //End Added By Vaijat K
                errWorkHours = isValidWorkHours(el.val(), task['duration']);
                currentProject = window.projectList[$('#cmbProject').val()]
                if (currentProject['isAgile'] == 1) {
                    var oldeffortvalue = task.planefforts;
                    var parentTaskData = self.master.getTask(task.parentTaskId);
                    var SprintEffortsValue = 0;
                    if (window.sprintData && window.sprintData[parentTaskData['NextGen_IterationID']] && window.sprintData[parentTaskData['NextGen_IterationID']]['SprintEfforts']) {
                        SprintEffortsValue = taskHoursToMin(window.sprintData[parentTaskData['NextGen_IterationID']]['SprintEfforts']);
                    }

                    if (parentTaskData.NextGen_IterationID != 0) {
                        var parentHours = taskHoursToMin(getParentTaskHours(task.parentTaskId));
                        if (parentHours > SprintEffortsValue) {
                            alert('Work Hours should not be greater than Sprint Work Hours')
                            task.planefforts = oldeffortvalue;
                            el.val(minToHHMM(taskHoursToMin(oldeffortvalue)))
                            //Commented By Vaijat K For Issue Id:-26289
                            //revertInlineDataData(task)
                            //End Commented By Vaijat K For Issue Id:-26289
                            return false;
                        }
                    }
                }

                //if( el.attr('data-is-parent') == '0' && errWorkHours == '' ){
                if (el.attr('data-is-parent') != '1' && errWorkHours != '') {
                    //Added By Vaijat K For Issue Id:-26006
                    alert(errWorkHours);
                    //End Added By Vaijat K For Issue Id:-26006
                    el.val(currentTaskHours);
                    task[field] = currentTaskHours
                } else {
                    if (taskHoursToMin(el.val()) < taskHoursToMin(task.actualEfforts)) {
                        alert("Planned Work hours should be greater than Actual work hours (" + minToHHMM(taskHoursToMin(task.actualEfforts)) + ")");
                        el.val(task[field]);
                        //Commented By Vaijat K For Issue Id:-26289
                        //revertInlineDataData(task)
                        //End Commented By Vaijat K For Issue Id:-26289
                    } else {
                        var calculatedTaskHours = taskHoursToMin(el.val()) + taskHoursToMin(window.taskHours) - taskHoursToMin(currentTaskHours)

                        if (calculatedTaskHours > taskHoursToMin(window.projectHours)) {
                            alert('Work hours should not exceed Project Hours')
                            el.val(task[field])
                            //Commented By Vaijat K For Issue Id:-26289
                            //revertInlineDataData(task)
                            //End Commented By Vaijat K For Issue Id:-26289
                        } else {
                            task[field] = el.val();
                            window.taskHours = minToHHMM(calculatedTaskHours)
                            //Commented And Added By Vaijat K For issue id :- 26004
                            //reCalculateParentWorkHours(el.attr('data-parent-id'))
                            task.getParent().planefforts = reCalculateParentWorkHours(el.attr('data-parent-id'))
                            //End Of commetned and added By Vaijat K
                        }
                    }
                }

                strMsg = isValidWorkHours(task[field], task['duration'], el.attr('data-is-parent'))

                if (strMsg != '') {
                    alert(strMsg)
                    task[field] = currentTaskHours;
                    el.val(currentTaskHours);
                }

            } else {
                task[field] = el.val();
            }
            self.master.endTransaction();

        } else if (field == "name" && el.val() == "") { // remove unfilled task even if not changed
            if (task.getRow() != 0) {
                self.master.deleteCurrentTask(taskId);

            } else {
                el.oneTime(1, "foc", function () { $(this).focus() }); //
                event.preventDefault();
                //return false;
            }

        }
    });

    //cursor key movement
    taskRow.find("input").keydown(function (event) {
        var theCell = $(this);
        var theTd = theCell.parent();
        var theRow = theTd.parent();
        var col = theTd.prevAll("td").length;
        var field = $(this).prop("name");
        if (field == "name") {
            var r1 = new RegExp("[/:*?+\"><@#%!$^'=~`|,\\\\]");
            if (r1.test(event.key)) {
                event.preventDefault(); //stop character from entering input
            }
        }
        var ret = true;
        if (!event.ctrlKey) {
            switch (event.keyCode) {
                case 13:
                    if (theCell.is(":text"))
                        theCell.blur();
                    break;

                case 37: //left arrow
                    if (!theCell.is(":text") || (!this.selectionEnd || this.selectionEnd == 0))
                        theTd.prev().find("input").focus();
                    break;
                case 39: //right arrow
                    if (!theCell.is(":text") || (!this.selectionEnd || this.selectionEnd == this.value.length))
                        theTd.next().find("input").focus();
                    break;

                case 38: //up arrow
                    //var prevRow = theRow.prev();
                    var prevRow = theRow.prevAll(":visible:first");
                    var td = prevRow.find("td").eq(col);
                    var inp = td.find("input");

                    if (inp.length > 0)
                        inp.focus();
                    break;
                case 40: //down arrow
                    //var nextRow = theRow.next();
                    var nextRow = theRow.nextAll(":visible:first");
                    var td = nextRow.find("td").eq(col);
                    var inp = td.find("input");
                    if (inp.length > 0)
                        inp.focus();
                    else
                        nextRow.click(); //create a new row
                    break;
                case 36: //home
                    break;
                case 35: //end
                    break;

                case 9: //tab
                case 13: //enter
                    break;
            }
        }
        return ret;

    }).focus(function () {
        $(this).closest("tr").click();
    });


    //change status
    taskRow.find(".taskStatus").click(function () {
        var el = $(this);
        var tr = el.closest("[taskid]");
        var taskId = tr.attr("taskid");
        var task = self.master.getTask(taskId);

        var changer = $.JST.createFromTemplate({}, "CHANGE_STATUS");
        changer.find("[status=" + task.status + "]").addClass("selected");
        changer.find(".taskStatus").click(function (e) {
            e.stopPropagation();
            var newStatus = $(this).attr("status");
            changer.remove();
            self.master.beginTransaction();
            task.changeStatus(newStatus);
            self.master.endTransaction();
            el.attr("status", task.status);
        });
        el.oneTime(3000, "hideChanger", function () {
            changer.remove();
        });
        el.after(changer);
    });

};

GridEditor.prototype.openFullEditor = function (task, editOnlyAssig) {
    var self = this;
    currentProject = window.projectList[$('#cmbProject').val()]
    if (!self.master.permissions.canSeePopEdit || (!currentProject.projectCanEdit && !isNaN(task.id)))
        return;
    window.taskGlobal = task;
    var taskRow = task.rowElement;

    var taskOrder = taskRow[0].rowIndex;

    //task editor in popup
    var taskId = taskRow.attr("taskId");
    var data = { ...task, 'defautlWorkHours': window.projectWorkHours }

    //make task editor
    var taskEditor = $.JST.createFromTemplate(data, "TASK_EDITOR");

    //hide task data if editing assig only
    if (editOnlyAssig) {
        if (task.level == 0) return false;
        taskEditor.find(".taskData, .taskNavHeader, #task_custom_fields").hide();
        taskEditor.find(".assigsTableWrapper").height(455);
        taskEditor.prepend("<h1>\"" + task.name + "\"</h1>");
    }

    //got to extended editor
    if (task.isNew() || !self.master.permissions.canSeeFullEdit) {
        taskEditor.find("#taskFullEditor").remove();
    } else {
        taskEditor.bind("openFullEditor.gantt", function () {
            window.location.href = contextPath + "/applications/teamwork/task/taskEditor.jsp?CM=ED&OBJID=" + task.id;
        });
    }

    taskEditor.find("#name").val(task.name);
    taskEditor.find("#description").val(task.description);
    var chlds = task.getChildren();

    if (task.parentTaskId == 0 && task.msptask == 0 && chlds.length > 0) {
        var parentTaskHours = getParentTaskHours(task.id)
        taskEditor.find("#effort").val(parentTaskHours).attr('data-val', parentTaskHours);
    } else {
        var plannedEfforts = changePlanEffort(task.planefforts);
        taskEditor.find("#effort").val(plannedEfforts).attr('data-val', plannedEfforts);
    }

    if (currentProject.projectStatus.toLowerCase() == 'on hold') {
        taskEditor.find("#saveButton").hide();
    }

    taskEditor.find("#code").val(task.code);
    taskEditor.find("#progress").val(task.progress ? parseFloat(task.progress) : 0).prop("readonly", task.progressByWorklog == true);
    taskEditor.find("#progressByWorklog").prop("checked", task.progressByWorklog);
    taskEditor.find("#status").val(task.status);
    taskEditor.find("#type").val(task.typeId);
    taskEditor.find("#type_txt").val(task.type);
    taskEditor.find("#relevance").val(task.relevance);

    taskEditor.find("#unit").val(task.Unit);
    var actualEfforts = taskHoursToMin(task.actualEfforts)
    enableStatusOptions(taskEditor.find("#status"), task.status, task.isNew(), actualEfforts)

    strUnitTypeHtml = '<option value="0">Select Unit</option>';
    if (task.showUnit) {
        for (i in window.arrUnit) {
            if (task.PlanUnit == i) {
                strUnitTypeHtml += '<option value="' + i + '" selected>' + window.arrUnit[i] + '</option>'
            } else {
                strUnitTypeHtml += '<option value="' + i + '">' + window.arrUnit[i] + '</option>'
            }
            // strUnitTypeHtml +='<option value="'+ i +'">'+ window.arrUnit[i] +'</option>'
        }
    }
    taskEditor.find("#unitType").html(strUnitTypeHtml);



    projectListContainer = taskEditor.find('#projectDrowpDownContainer')
    var vHiddenDropDown = task.hiddenDropDown || currentProject.hiddenDropDown;
    var vMandatoryDropDown = task.mandatoryDropDown || currentProject.mandatoryDropDown;
    var boolIsParent = projectListContainer.attr('data-parent-task-id') == "0" || projectListContainer.attr('data-parent-task-id') == ''
    projectListContainer.html(buildDropDown(vHiddenDropDown, vMandatoryDropDown, boolIsParent));
    var referedWBSTask = task.getParent() ?? task//(boolIsParent) ? task : task.getParent();


    projectListContainer.find('#cmbPriority').html(generateDropdownHtml('Priority', referedWBSTask.PriorityID, boolIsParent));
    projectListContainer.find('#cmbTaskType').html(generateDropdownHtml('TaskType', referedWBSTask.TaskType, boolIsParent));
    projectListContainer.find('#cmbDelivarable').html(generateDropdownHtml('Delivarable', referedWBSTask.DeliverableID, boolIsParent));
    projectListContainer.find('#cmbMilestone').html(generateDropdownHtml('Milestone', referedWBSTask.MileStoneId, boolIsParent));
    projectListContainer.find('#cmbModule').html(generateDropdownHtml('Module', referedWBSTask.ModuleId, boolIsParent));
    projectListContainer.find('#cmbSubproject').html(generateDropdownHtml('Subproject', referedWBSTask.SubProjectID, boolIsParent));
    projectListContainer.find('#cmbPhases').html(generateDropdownHtml('Phases', referedWBSTask.PhaseID, boolIsParent));
    projectListContainer.find('#cmbChangeRequest').html(generateDropdownHtml('ChangeRequest', referedWBSTask.ChangeRequestID, boolIsParent));
    projectListContainer.find('#cmbRelease').html(generateDropdownHtml('Release', referedWBSTask.NextGen_ReleaseID, boolIsParent));
    projectListContainer.find('#cmbSprint').html(generateDropdownHtml('Sprint', referedWBSTask.NextGen_IterationID, boolIsParent));
    projectListContainer.find('#cmbUserStory').html(generateDropdownHtml('UserStory', referedWBSTask.UserStoryID, boolIsParent));
    projectListContainer.find('#cmbEstimationType').html(generateDropdownHtml('EstimationType', referedWBSTask.ProjectEstimationTypeID, boolIsParent));
    projectListContainer.find('#cmbProjectFeature').html(generateDropdownHtml('ProjectFeature', referedWBSTask.ProjectFeatureID, boolIsParent));
    if (currentProject.isAgile == 1) {
        var sprintStatus = projectListContainer.find('#cmbSprint option:selected').attr('data-item-sprint-status')
        if (sprintStatus && sprintStatus.toString().toLowerCase() == 'completed') {
            taskEditor.find('#saveButton').hide()
            taskEditor.find("#panel_basic").attr('style', 'pointer-events:none;')
        }
    }


    if (task.startIsMilestone)
        taskEditor.find("#startIsMilestone").prop("checked", true);
    if (task.endIsMilestone)
        taskEditor.find("#endIsMilestone").prop("checked", true);

    taskEditor.find("#duration").val(durationToString(task.duration));
    if (task.parentTaskId == 0) {
        taskEditor.find("#duration")[0].disabled = true
        //Added By Vaijat K For billable issue
        taskEditor.find("#isBillable")[0].disabled = false;
        //End Added By Vaijat K For billable issue
    }
    else {
        taskEditor.find("#duration")[0].disabled = false;
        taskEditor.find("#isBillable")[0].disabled = true;
    }
    var startDate = taskEditor.find("#start");
    startDate.val(new Date(task.start).format());
    //start is readonly in case of deps
    if (task.depends || !(this.master.permissions.canWrite || task.canWrite)) {
        startDate.attr("readonly", "true");
    } else {
        startDate.removeAttr("readonly");
    }

    taskEditor.find("#end").val(new Date(task.end).format());
    // console.log( task  )
    if (task.TaskCustomFields && task.TaskCustomFields.length > 0) {
        taskEditor.find('#task_custom_fields').html(generateCustomFieldHtml(task, task.TaskCustomFields))
    } else {
        taskEditor.find('#panel_additional').hide();
    }
    //make assignments table
    if (task.level != 0 || task.msptask == 1) {

        var assigsTable = taskEditor.find("#assigsTable");
        assigsTable.find("[assId]").remove();
        // loop on assignments
        //for (var i = 0; i < task.assigs.length -1; i++) {
        var assig = task.assigs[0];
        if (assig) {
            var assigRow = $.JST.createFromTemplate({ task: task, assig: assig }, "ASSIGNMENT_ROW");
            assigsTable.append(assigRow);
        }

        //}
    } else {
        taskEditor.find('h2.assignTableHeader, #assigsTable').hide();
    }
    taskEditor.find(":input").updateOldValue();

    if (!(self.master.permissions.canWrite || task.canWrite)) {
        taskEditor.find("input,textarea").prop("readOnly", true);
        taskEditor.find("input:checkbox,select").prop("disabled", true);
        taskEditor.find("#saveButton").remove();
        taskEditor.find(".button").addClass("disabled");

    } else {

        //bind dateField on dates, duration
        taskEditor.find("#start,#end,#duration").click(function () {
            var input = $(this);
            if (input.is("[entrytype=DATE]")) {
                input.dateField({
                    inputField: input,
                    minDate: self.minAllowedDate,
                    maxDate: self.maxAllowedDate,
                    callback: function (d) {
                        $(this).blur();
                        if (input.attr("id") == "start") {
                            changePlannedEfforts(1)
                        }
                        else if (input.attr("id") == "end") {
                            changePlannedEfforts()
                        }
                    }
                });
            }
        }).blur(function () {
            var inp = $(this);
            if (inp.validateField()) {
                resynchDates(inp, taskEditor.find("[name=start]"), taskEditor.find("[name=startIsMilestone]"), taskEditor.find("[name=duration]"), taskEditor.find("[name=end]"), taskEditor.find("[name=endIsMilestone]"));
                //workload computation
                
                if (typeof (workloadDatesChanged) == "function")
                    workloadDatesChanged();
            }
        });

        taskEditor.find("#startIsMilestone,#endIsMilestone").click(function () {
            var inp = $(this);
            resynchDates(inp, taskEditor.find("[name=start]"), taskEditor.find("[name=startIsMilestone]"), taskEditor.find("[name=duration]"), taskEditor.find("[name=end]"), taskEditor.find("[name=endIsMilestone]"));
        });

        //bind add assignment
        var cnt = 0;
        taskEditor.find("#addAssig").click(function () {
            cnt++;
            var assigsTable = taskEditor.find("#assigsTable");
            if (task.level == 0) return false;
            var assigRow = $.JST.createFromTemplate({ task: task, assig: { id: "tmp_" + new Date().getTime() + "_" + cnt } }, "ASSIGNMENT_ROW");
            assigsTable.append(assigRow);
            $("#bwinPopupd").scrollTop(10000);
        }).click();

        window.globarParentId = task.parentTaskId;
        window.oldeffortvalue = task.planefforts;
        window.taskIdEdit = task.id;
        window.actualEffortsEdit = task.actualEfforts
        //save task
        taskEditor.bind("saveFullEditor.gantt", function () {
            window.currentAssigns = []
            var task = self.master.getTask(taskId); // get task again because in case of rollback old task is lost

            // validate task is void or inactive then restrict to save
            var newChangeStatus = taskEditor.find("#status").val(); // hold new status for validate task save
            // console.log("new status",newChangeStatus);
            if ((task.status == "V" || task.status == "I") && (newChangeStatus == "I" || newChangeStatus == "V")) {
                alert("Task is Inactive or Void you cannot make change this");
                return false;
            }

            task.name = taskEditor.find("#name").val();
            task.description = taskEditor.find("#description").val();
            task.code = taskEditor.find("#code").val();
            task.progress = parseFloat(taskEditor.find("#progress").val());
            //task.duration = parseInt(taskEditor.find("#duration").val()); //bicch rimosso perchè devono essere ricalcolata dalla start end, altrimenti sbaglia
            task.startIsMilestone = taskEditor.find("#startIsMilestone").is(":checked");
            task.endIsMilestone = taskEditor.find("#endIsMilestone").is(":checked");

            task.type = taskEditor.find("#type_txt").val();
            task.typeId = taskEditor.find("#type").val();
            task.relevance = taskEditor.find("#relevance").val();
            task.progressByWorklog = taskEditor.find("#progressByWorklog").is(":checked");
            task.isBillable = taskEditor.find("#isBillable").is(":checked");
            task.effort = taskEditor.find("#effort").val();

            task.PlanUnit = parseInt(taskEditor.find("#unitType").val());
            task.Unit = taskEditor.find("#unit").val();

            if (newChangeStatus == "A" || newChangeStatus == "NV" || newChangeStatus == "R") {
                if (taskHoursToMin(task.effort) < taskHoursToMin(task.actualEfforts)) {
                    alert("Planned Work hours should be greater than Actual work hours (" + minToHHMM(taskHoursToMin(task.actualEfforts)) + ")");
                    return false;
                    //        console.log("task hours",task.actualEfforts,task.planefforts);
                }
            }
            var oldTaskAssignId = 0, newTaskAssignId = 0;

            var boolChangeStatus = task.status != taskEditor.find("#status").val()

            if (task.level == 0) {
                if (boolChangeStatus) {
                    var result = changeChildTaskStatus(task, taskEditor.find("#status").val());
                    if (result == false) return false;
                }
            } else {
                oldTaskAssignId = task.assigs[0].resourceId
                boolChangeStatus && changeParentTaskStatus(task, taskEditor.find("#status").val())
            }
            self.master.beginTransaction();
            //task.planefforts = minToHHMM(task.effort);
            //task.planEfforts = task.effort;

            taskEditor.find('#projectDrowpDownContainer select').each(function (item, index) {
                task[$(this).attr('name')] = ($(this).val() == '0' || $(this).val() == '') ? '' : $(this).val()
            })

            task.typeId = task['TaskType']
            task.DeliverableID = task['Delivarable'];  //delete task['Delivarable'];
            task.MileStoneId = task['Milestone']; // delete task['Milestone'];
            task.ModuleId = task['Module'];   //delete task['Module'];
            task.SubProjectID = task['Subproject'];  //delete task['Subproject'];
            task.PhaseID = task['Phases']; //delete task['Phases'];
            task.ChangeRequestID = task['ChangeRequest']; //delete task['ChangeRequest'];
            task.NextGen_ReleaseID = task['Release'];  //delete task['Release'];
            task.NextGen_IterationID = task['Sprint'];  //delete task['Sprint'];
            task.UserStoryID = task['UserStory'];  //delete task['UserStory'];
            task.ProjectFeatureID = task['ProjectFeature'];   //delete task['ProjectFeature'];
            task.PriorityID = task['Priority'];
            task.ProjectEstimationTypeID = task['EstimationType'];

            task.TaskTypeName = $('#cmbTaskType').val() == '' ? '' : $('#cmbTaskType option:selected').text()
            task.PriorityName = $('#cmbPriority').val() == '' ? '' : $('#cmbPriority option:selected').text()
            task.DelivarableName = $('#cmbDelivarable').val() == '' ? '' : $('#cmbDelivarable option:selected').text()
            task.MilestoneName = $('#cmbMilestone').val() == '' ? '' : $('#cmbMilestone option:selected').text()
            task.ModuleName = $('#cmbModule').val() == '' ? '' : $('#cmbModule option:selected').text()
            task.SubprojectName = $('#cmbSubproject').val() == '' ? '' : $('#cmbSubproject option:selected').text()
            task.PhasesName = $('#cmbPhases').val() == '' ? '' : $('#cmbPhases option:selected').text()
            task.ChangeRequestName = $('#cmbChangeRequest').val() == '' ? '' : $('#cmbChangeRequest option:selected').text()
            task.ReleaseName = $('#cmbRelease').val() == '' ? '' : $('#cmbRelease option:selected').text()
            task.SprintName = $('#cmbSprint').val() == '' ? '' : $('#cmbSprint option:selected').text()
            task.UserStoryName = $('#cmbUserStory').val() == '' ? '' : $('#cmbUserStory option:selected').text()
            task.EstimationTypeName = $('#cmbEstimationType').val() == '' ? '' : $('#cmbEstimationType option:selected').text()
            task.ProjectFeatureName = $('#cmbProjectFeature').val() == '' ? '' : $('#cmbProjectFeature option:selected').text()
            task.PlanUnitName = $('#unitType').val() == '0' ? '' : $('#unitType option:selected').text();
            // console.log('selected text',$('#cmbTaskType option:selected').text())
            task.taskOrder = taskOrder
            // console.log("editted",task);
            taskEditor.find('#task_custom_fields [name]').each(function (item, index) {
                task[$(this).attr('name')] = ($(this).val() == '') ? '' : $(this).val()
            })


            //set assignments
            var cnt = 0;
            taskEditor.find("tr[assId]").each(function () {
                var trAss = $(this);
                var assId = trAss.attr("assId");
                var resId = trAss.find("[name=resourceId]").val();
                var resName = trAss.find("[name=resourceId_txt]").val(); // from smartcombo text input part
                var roleId = trAss.find("[name=roleId]").val();
                var effort = millisFromString(trAss.find("[name=effort]").val(), true);

                //check if the selected resource exists in ganttMaster.resources
                var res = self.master.getOrCreateResource(resId, resName);

                //if resource is not found nor created
                if (!res)
                    return;

                //check if an existing assig has been deleted and re-created with the same values
                var found = false;
                for (var i = 0; i < task.assigs.length; i++) {
                    var ass = task.assigs[i];

                    if (assId == ass.id) {
                        ass.effort = effort;
                        ass.roleId = roleId;
                        ass.resourceId = res.id;
                        ass.touched = true;
                        found = true;
                        break;

                    } else if (roleId == ass.roleId && res.id == ass.resourceId) {
                        ass.effort = effort;
                        ass.touched = true;
                        found = true;
                        break;

                    }
                }

                if (!found && resId && roleId) { //insert
                    cnt++;
                    var ass = task.createAssignment("tmp_" + new Date().getTime() + "_" + cnt, resId, roleId, effort);
                    ass.touched = true;
                }

            });

            //remove untouched assigs
            task.assigs = task.assigs.filter(function (ass) {
                var ret = ass.touched;
                delete ass.touched;
                return ret;
            });

            if (task.level == 1) newTaskAssignId = task.assigs[0].resourceId
            if (!task.isNew() && task.actualEfforts > 0 && oldTaskAssignId > 0 && newTaskAssignId > 0 && oldTaskAssignId != newTaskAssignId) {
                updateResourceChangeList(task.id, oldTaskAssignId, newTaskAssignId)
            }
            //change dates
            task.setPeriod(Date.parseString(taskEditor.find("#start").val()).getTime(), Date.parseString(taskEditor.find("#end").val()).getTime() + (3600000 * 22));

            task.planefforts = task.effort
            //change status
            for (var i = 0; i < self.master.tasks.length; i++) {
                if (self.master.tasks[i].parentTaskId == task.id) {
                    if (task.isBillable == 1) {
                        self.master.tasks[i].isBillable = 1;
                    } else {
                        self.master.tasks[i].isBillable = 0;
                    }
                }
            }
            task.changeStatus(taskEditor.find("#status").val(), true);
            if (self.master.endTransaction()) {
                taskEditor.find(":input").updateOldValue();
                closeBlackPopup();
            }



        });
    }

    taskEditor.attr("alertonchange", "true");
    var ndo = createModalPopup(800, 450).append(taskEditor);//.append("<div style='height:800px; background-color:red;'></div>")
    //Added By Vaijat K
    if (String(task.id).indexOf("tmp") == -1 && task.assigs.length > 0) {
        if (task.assigs[0].resourceId != 0)
            $("#resourceId").attr("disabled", "");
    }
    else {
        $("#resourceId").removeAttr("disabled");

    }

    if (task.parentTaskId == 0) {
        $("#start").attr("readonly", "true");
    }
    else {
        $("#start").removeAttr("readonly");
    }

    //Added By Vaijat K For Issue Id :- 26004



    //workload computation
    if (typeof (workloadDatesChanged) == "function")
        workloadDatesChanged();
};

var fromDateChange = 0
function changePlannedEfforts(num) {
    if (num == undefined) {
        var endDate = new Date()
        var startDate = new Date()
        endDate.setTime(new Date($("#end").val()).getTime())
        startDate.setTime(new Date($("#start").val()).getTime())
        var endWorkHours = recomputeWorkHours(startDate, endDate.getTime());
        endWorkHours = minToHHMM(taskHoursToMin(endWorkHours))
        $('#effort').val(endWorkHours);
    }
    fromDateChange = 1
    if (String(window.taskGlobal.id).indexOf("tmp") == -1 && window.taskGlobal.assigs.length > 0) {

    }
    else {
        var assigsTable = $("#assigsTable");
        assigsTable.find("[assId]").remove();
        var assig = window.taskGlobal.assigs[0];
        if (assig) {
            var assigRow = $.JST.createFromTemplate({ task: window.taskGlobal, assig: assig }, "ASSIGNMENT_ROW");
            assigsTable.append(assigRow);
        }

    }
    fromDateChange = 0;

}