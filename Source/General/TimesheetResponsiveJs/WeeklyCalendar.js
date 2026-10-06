
$(document).ready(function () {
    var html = '';
    var EmployeeID = 0;
    var TaskHour = 0;
    var TaskID = 0;
    var ProjID = 0;
    var TotalHour = 0;
    var TotalHrV = 0;
    var ArrWeek = [];
    var ArrRespWeek = [];
    var flag = 0;
    var SelectedDate = 0;
    var Path = "";
    var RoleId = 0;
    var ArrDuration = [];
    var ArrGetTask = [];
    var ArrDurHour = [];
    var ArrDurationNew = [];
    var TID;
    var MInsert, MActualWork;
    var IsTaskComplete, voidTask;
    var DateSelected;
    getCurrentWeek();



});


function getCurrentWeek(dt) {
    ArrRespWeek = [];
    html = '';
    if (dt == undefined || dt == '') {
        ArrRespWeek = getCurrentWeekEvents();
    }
    else {
        ArrRespWeek = getCurrentWeekEvents(dt);
    }

    var topContent = "<b>" + GetStandardDate(GetTodaysDate(ArrRespWeek[0].date)) + '-' + GetStandardDate(GetTodaysDate(ArrRespWeek[6].date)) + "</b>";

    var NextPrevHtml1 = "<img id=\"btnPrev\" onclick=\"ShowPrevWeek('" + ArrRespWeek[0].date + "')\" class='ImgBL' />";           // Prev Button
    if(document.getElementById("DivPrevWeekBtn") != undefined || document.getElementById("DivPrevWeekBtn") != null)
        document.getElementById("DivPrevWeekBtn").innerHTML = NextPrevHtml1;
    var NextPrevHtml2 = "<img id=\"btnNext\" onclick=\"ShowNextWeek('" + ArrRespWeek[6].date + "')\" class='ImgBR' />";          // Next Button

    if (document.getElementById("DivNextWeekBtn") != undefined || document.getElementById("DivNextWeekBtn") != null)
        document.getElementById("DivNextWeekBtn").innerHTML = NextPrevHtml2;

    if (document.getElementById("Divweekrange") != undefined || document.getElementById("Divweekrange") != null)
        document.getElementById("Divweekrange").innerHTML = topContent;
    html += "<table style='width:100%;height:100%;'>";
    for (var i = 0; i <= ArrRespWeek.length - 1; i++) {
        html += "<div id='" + GetTodaysDate(ArrRespWeek[i].date) + "' class='tdcls' onclick=\"ViewTimeSheet('" + ArrRespWeek[i].date + "')\">";
        html += GetTodaysDate(ArrRespWeek[i].date);
        html += "</div>";
    }
    html += "</table>";

    if (document.getElementById("DivCurrWeekList") != undefined || document.getElementById("DivCurrWeekList") != null)
        document.getElementById("DivCurrWeekList").innerHTML = html;
}

function ViewTimeSheet(dt) {
    $("#WeekView").animate(2000, function () {
        $("#WeekView").fadeOut("slow");
        $("#DayView").animate(2000, function () {
            $("#DayView").fadeIn("slow", function () {
                document.getElementById("DayView").style.display = 'block';
            });
        });
    });

    ClearProjectTaskFields();
    SelectedDate = dt;

    BindDay(GetStandardDate(GetTodaysDate(dt)));
}

function BindDay(dt) {
    document.getElementById("localpages_txtHours").disabled=false;
    document.getElementById("BtnSaveUpdate").disabled=false;
   // document.getElementById("ErrorSpan").style.display = "none";
   // document.getElementById("ErrorSpan2").style.display = "none";
   // document.getElementById("ErrorSpan3").style.display = "none";
    document.getElementById("DivDAYTimeSheet").innerHTML = "<b title=" + GetWeekDay(new Date(dt).getDay()) + ">" + dt + "</b>";        // HEAD Date bold Center

    SelectedDate = dt;
    ClearProjectTaskFields();                                                   // Function to CLEAR PROJECT and TASK Fields

    var NextPrevDay1 = "<img id=\"btnPrev\" title=" + GetTodaysDate(GetPrevDate(dt)) + " onclick=\"BindDay('" + GetStandardDate(GetTodaysDate(GetPrevDate(dt))) + "')\" class='ImgBL' />";           // Prev Button
    document.getElementById("DivPrevDAYBtn").innerHTML = NextPrevDay1;
    var PrevDay2 = "<img id=\"btnNext\" title=" + GetTodaysDate(GetNextDate(dt)) + " onclick=\"BindDay('" + GetStandardDate(GetTodaysDate(GetNextDate(dt))) + "')\" class='ImgBR' />";          // Next Button
    document.getElementById("DivNextDAYBtn").innerHTML = PrevDay2;

    var dHTML = "";
}

function GoToMainWeek() {
    $("#DayView").animate(2000, function () {
        $("#DayView").fadeOut("slow");
        $("#WeekView").animate(2000, function () {
            $("#WeekView").fadeIn("slow", function () {
                document.getElementById("WeekView").style.display = 'block';
                document.getElementById("DayView").style.display = 'none';
            });
        });
    });
    getCurrentWeek();
}

function M_GetProjectListForEmployee(para, strLoginType, path) {

    Path = path;
    try {
        $.ajax({
            type: "GET",                                                //GET or POST or PUT or DELETE verb
            url: path + "HomeService.svc/GetProjectListForTimesheet", // Location of the service
            data: { intUserID: para, strLoginType: strLoginType },
            contentType: "application/json;charset=utf-8",          // content type sent to server
            dataType: "jsonp",                                      //Expected data format from server
            success: function (data) {                              //On Successfull service call  
                $("#DDLProject").html("");
                $("#DDLProject").append("<option value='0' selected='selected'>Select Project</option>");
                $.each(JSON.parse(data), function (id, obj) {
                    $("#DDLProject").append("<option value=" + obj.ProjectID + " selected=" + obj.ProjectName + ">" + obj.ProjectName + "</option>");
                });

            },
            error: function (msg) {
                alert("Failed");
            }
        });
    } catch (exception) { }

}
 function M_ToCheckActiveOnHoldProject(EmployeeID)
        {
            // paraEmployeeID={intEmployeeID:504};
             Path = path;
//            alert(Path + '' + paraEmployeeID)
             try {
                 $.ajax({
                     type: "GET", //GET or POST or PUT or DELETE verb
                     url: path + "HomeService.svc/ToCheckActiveOnholdProject", // Location of the service
                     data: { intEmployeeID: EmployeeID },
                     contentType: "application/json;charset=utf-8", // content type sent to server
                     dataType: "jsonp", //Expected data format from server
                     success: function (data) {//On Successfull service call         

                         $.each(JSON.parse(data), function (id, obj) {
                             if (obj.ProjectsOnHold == null) {
                                 //ToCheckActiveWorkFlowProject();
                                 //getTimesheet();
                                 // GetTask();
                                
                                 M_ToCheckActiveWorkFlowProject(EmployeeID);
                             }
                             else {
                                 alert(obj.ProjectsOnHoldMsg);
                             }

                         });


                     },
                     error: function (msg) {
                         alert("Failed");
                     }
                 });
                } catch (exception) { }
         }
        function M_ToCheckActiveWorkFlowProject(EmployeeID)
        {

            //paraEmployeeID = EmployeeID;
            Path = path;
            mylist = document.getElementById("DDLProject");
            entity=mylist.options[mylist.selectedIndex].value; //get Dropdown ProjectId
            
           // alert(JSON.stringify(paraEmployeeID));
             try {           
                $.ajax({
                     type: "GET", //GET or POST or PUT or DELETE verb
                     url: path+"HomeService.svc/ToCheckActiveWorkflowProjects", // Location of the service
                     data: { intEmployeeID: EmployeeID },
                     contentType: "application/json;charset=utf-8", // content type sent to server
                     dataType: "jsonp", //Expected data format from server
                     success: function (data) {//On Successfull service call    
                                             
                                        $.each(JSON.parse(data), function (id, obj) 
                                        { 
                                               
                                             var TimesheetBlockedProjectList=obj.TimesheetBlockedProjects;
                                             
                                             //var a;
                                             //alert(TimesheetBlockedProjectList);
                                             var ad = TimesheetBlockedProjectList.split(',');
                                             var flag=0;
                                          
                                             for(var i=1;i<ad.length;i++)
                                             {
                                             
                                                  if(entity==ad[i]) {
                                                    
                                                    flag=1;
                                                    alert(obj.TimesheetBlockProjectsMsg);
                                                    mylist.selectedIndex = 0;
                                                    GetTask();
                                                   
                                                  }                                               

                                             }

                                             if(flag==0)
                                             {
                                          
                                                GetTask();
                                             }


                                        });                                     
                                            
                        
                     },
                     error: function (msg) {
                         alert("Failed");
                     }
                   });
                } catch (exception) { }
        }
      
function GetAssignedTaskDayWise(ProjectID, EmpID, RoleID) {
    document.getElementById("localpages_txtHours").disabled=false;
    document.getElementById("BtnSaveUpdate").disabled=false;

    EmployeeID = EmpID;
    RoleId = RoleID;
   // ArrDurationNew = [];
    ProjID = ProjectID;

    M_ToCheckActiveOnHoldProject(EmployeeID);
   // document.getElementById("ErrorSpan").style.display = "none";

    if (document.getElementById("DDLProject").value == "0") {
        ClearProjectTaskFields();
        $("#DDLTask").html("");
    }
    else {
        //alert('ProjectID: ' + ProjectID + ', EmpID: ' + EmpID + ', RoleID: ' + RoleID + ', Date: ' + SelectedDate + ' ,Path: ' + Path);
        DateSelected = GetMMddYYDate(SelectedDate);

        try {
            $.ajax({
                type: "GET",
                url: Path + "HomeService.svc/TimesheetEntryDateWiseFilter",
                data: { projectID: ProjectID, employeeID: EmpID, fromDate: DateSelected, toDate: DateSelected, assignedBugTasksFlag: undefined, defaultTasksFlag: undefined, mPPTasksFlag: undefined, assignedTasksFlag: 1, weekRangeFlag: 1, roleID: RoleID },
                contentType: "application/json;charset=utf-8",
                dataType: "jsonp",
                success: function (data) {

                    ArrGetTask = [];
                    $("#DDLTask").html("");
                    $("#DDLTask").append("<option value='0' selected='selected'>Select Task</option>");
                    $.each(JSON.parse(data), function (id, obj) {
                        //alert('CallGetTaskHr '+ obj.TaskName)
                        //GetTaskHour(obj.TaskID, DateSelected, obj.ActualWork, obj.Work, obj.TaskName);
                        $("#DDLTask").append("<option id=" + obj.TaskID + " value=" + obj.TaskID + "|" + obj.ActualWork + "|" + obj.Work + "|" + obj.IsTaskComplete + "|" + obj.void + ">" + obj.TaskName + "</option>");
                        ArrGetTask.push({ TaskID: obj.TaskID, DateSelected: DateSelected, ActualWork: obj.ActualWork, Work: obj.Work, TaskName: obj.TaskName,IsTaskComplete:obj.IsTaskComplete,voidTask:obj.void });

                        ArrDurationNew = [];
                        //CalcDuration(obj.TaskID, DateSelected);
                        $.ajax({
                            type: "GET",
                            url: Path + "HomeService.svc/GetTaskHours",
                            //data: { TaskId: TaskID, EntryDate: EntryDate },
                            data: { TaskId: obj.TaskID, EntryDate: DateSelected },
                            contentType: "application/json;charset=utf-8",
                            dataType: "jsonp",
                            success: function (data) {

                                // alert('SUCCESS: ' + JSON.stringify(data));
                                $.each(JSON.parse(data), function (id, obj) {

                                    ArrDurationNew.push({ taskid: obj.TaskID, hour: obj.Duration });
                                    //TotalHour = TotalHour + obj.Duration;
                                });
                            },
                            error: function (msg) {
                                alert("Failed");
                            }
                        });

                    });
                    //GetTaskHour(ArrGetTask);
                },
                error: function (msg) {
                    alert("Failed");
                }
            });
            
        } catch (exception) { }
    }
}

function GetTaskHour(ArrGetTask) {
    try {
        ArrDurHour = [];
     
        for (var i = 0; i <= ArrGetTask.length - 1; i++) {
            $.ajax({
                type: "GET",
                url: Path + "HomeService.svc/GetTaskHours",
                //data: { TaskId: TaskID, EntryDate: EntryDate },
                data: { TaskId: ArrGetTask[i].TaskID, EntryDate: ArrGetTask[i].DateSelected },
                contentType: "application/json;charset=utf-8",
                dataType: "jsonp",
                success: function (data) {
                    $.each(JSON.parse(data), function (id, obj) {
                       
                        ArrDurHour.push({ Duration: obj.Duration });
                        //$("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + obj.Duration + ">" + ArrGetTask[i].TaskName + "</option>");
                        //ArrDuration.push({ taskid: ArrGetTask[i].TaskID, hour: obj.Duration });
                    });
                },
                error: function (msg) {
                    alert("Failed");
                }
            });
        }
    } catch (exception) { }
}

function CombineArrays(ArrGetTask, ArrDurHour) {
   
    ArrDuration = [];
   
    for (var i = 0; i <= ArrGetTask.length - 1; i++) {
        for (var j = 0; j <= ArrDurHour.length - 1; j++) {
            $("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + ArrDurHour[j].Duration + ">" + ArrGetTask[i].TaskName + "</option>");
            ArrDuration.push({ taskid: ArrGetTask[i].TaskID, hour: ArrDurHour[j].Duration });
        }
    }
}
function CalcDuration(TaskID,Date) {
    $.ajax({
        type: "GET",
        url: Path + "HomeService.svc/GetTaskHours",
        //data: { TaskId: TaskID, EntryDate: EntryDate },
        data: { TaskId: TaskID, EntryDate: Date },
        contentType: "application/json;charset=utf-8",
        dataType: "jsonp",
        success: function (data) {
            // alert('SUCCESS: ' + JSON.stringify(data));
            $.each(JSON.parse(data), function (id, obj) {
                //alert("function");
                ArrDuration.push({ taskid: ArrGetTask[i].TaskID, hour: obj.Duration });
                //TotalHour = TotalHour + obj.Duration;
            });
        },
        error: function (msg) {
            alert("Failed");
        }
    });

}
function SetWork(value) {
 
    document.getElementById("localpages_txtHours").disabled=false;
    document.getElementById("BtnSaveUpdate").disabled=false;

    var work = value.split("|");
    TID = work[0];
    TotalHour = 0;
    if (document.getElementById("DDLTask").value == "0") {
        document.getElementById("localpages_lblAllocatedWork").innerHTML = "";
        document.getElementById("localpages_lblActualWork").innerHTML = "";
        document.getElementById("localpages_txtHours").value = "";
    }
    else {
        MInsert=0;
        ArrDuration = [];
        $.ajax({
            type: "GET",
            url: Path + "HomeService.svc/GetTaskHours",
            //data: { TaskId: TaskID, EntryDate: EntryDate },
            data: { TaskId: work[0], EntryDate: GetMMddYYDate(SelectedDate) },
            contentType: "application/json;charset=utf-8",
            dataType: "jsonp",
            success: function (data) {
                
                $.each(JSON.parse(data), function (id, obj) {
                    //ArrDurHour.push({ Duration: obj.Duration });
                    //$("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + obj.Duration + ">" + ArrGetTask[i].TaskName + "</option>");
                     
                    ArrDuration.push({ taskid: work[0], hour: obj.Duration });

                    if (ArrDuration == "") {
                    document.getElementById("localpages_txtHours").value = "";
                    }
                    else {
                        document.getElementById("localpages_txtHours").value = ArrDuration[0].hour;
                        MInsert = ArrDuration[0].hour;
                        
                    }
                    TaskHour = ArrDuration[0].hour;
                    TotalHrV = ArrDuration[0].hour;
                    //alert(TotalHrV)
                });
                // alert(ArrDuration[0].hour)
                //alert(work[1])
                document.getElementById("localpages_lblAllocatedWork").innerHTML = work[2];
                document.getElementById("localpages_lblActualWork").innerHTML = work[1];
                IsTaskComplete = work[3];
                voidTask = work[4];
               
              
                MActualWork = work[1];


                TaskID = work[0];
                MCheckIsMarkCompleteTask(TaskID);
                for (var i = 0; i <= ArrDurationNew.length - 1; i++) {
                    //alert(parseFloat(work[0]) + 'sss' + ArrDurationNew + parseFloat(ArrDurationNew[i].taskid))
                    if (parseFloat(work[0]) != parseFloat(ArrDurationNew[i].taskid)) {
                        //                        alert("Total " + parseFloat(ArrDuration[0].hour) + parseFloat(ArrDurationNew[i].hour))
                        TotalHour = parseFloat(TotalHour) + parseFloat(ArrDurationNew[i].hour);

                    }
                }

                
            },
            error: function (msg) {
                alert("Failed");
            }
        });

    }

}
function SaveUpdateTask(EmpID, RoleID) {
    var Duration = document.getElementById("localpages_txtHours").value;
    //alert('CheckForTask: EmpID' + EmpID + ' SelectedDate' + GetMMddYYDate(SelectedDate) + ' TaskID' + TaskID + ' RoleID' + RoleID + ' Duration' + Duration + ' ProjID' + ProjID);
  
        CheckFortimeSheetExists(EmpID, GetMMddYYDate(SelectedDate), TID, RoleID, Duration);
   
   
}

function CheckFortimeSheetExists(EmployeeID, EntryDate, TaskID, RoleID, Duration) {

    $.ajax({
        type: "GET",
        url: Path + "HomeService.svc/CheckDuplicateTimesheetRecord",
        data: { EmployeeID: EmployeeID, EntryDate: EntryDate, TaskID: TaskID },
        contentType: "application/json;charset=utf-8",
        dataType: "jsonp",
        success: function (data) {
            $.each(JSON.parse(data), function (id, obj) {
                var dailyActivity = obj.DailyActivityEntryID;

              
                if (dailyActivity != 0) {
                    var para = { DailyActivityEntryID: dailyActivity, TaskID: TaskID, ProjectID: ProjID, EmployeeID: EmployeeID, RoleID: RoleID, EntryDate: EntryDate, Duration: Duration };
                   
                        InsertTimesheet(para);
                   
                }
                else {
                    var para = { TaskID: TaskID, ProjectID: ProjID, EmployeeID: EmployeeID, RoleID: RoleID, EntryDate: EntryDate, Duration: Duration };
                   
                        InsertTimesheet(para);
                    
                    
                }
            });
        }
    });
}
function InsertTimesheet(para) {

    var diff;
    $.ajax({
        type: "GET",
        url: Path + "HomeService.svc/InsertTimesheetEntry",
        data: para,
        contentType: "application/json;charset=utf-8",
        dataType: "jsonp",
        success: function (data) {
            alert("TimeSheet updated successfully");
            //ClearProjectTaskFields();
            //var mylist = document.getElementById("DDLTask");
            //var entity = mylist.options[mylist.selectedIndex].value;

            if (parseInt(document.getElementById("localpages_txtHours").value) > MInsert) {
          
                diff = (parseInt(document.getElementById("localpages_txtHours").value)) - (parseInt(MInsert));
               
                document.getElementById("localpages_lblActualWork").innerHTML = parseFloat(MActualWork) + parseFloat(diff);
            }
            else if (parseInt(document.getElementById("localpages_txtHours").value) < MInsert) {

                diff = (parseInt(MInsert)) - (parseInt(document.getElementById("localpages_txtHours").value));
            
                document.getElementById("localpages_lblActualWork").innerHTML = parseFloat(MActualWork) - parseFloat(diff);
            }
            MInsert = document.getElementById("localpages_txtHours").value;
            MActualWork = document.getElementById("localpages_lblActualWork").innerHTML;
        },
        error: function (msg) {
            alert("Failed");
        }
    });
}
function ValidateControls(empid, roleid) {


//    if ($("TxtHours").is(':focus')) {
//       
//    }
//    else { 
//        alert("Please Fill/Update the Hours")
//    }
    if (document.getElementById("DDLProject").value == "0") {
       // document.getElementById("ErrorSpan").style.display = "block";
       alert("Please select Project Name");
    }
    else {
       // document.getElementById("ErrorSpan").style.display = "none";
    }
    if (document.getElementById("DDLTask").value == "0" || document.getElementById("DDLTask").value == "") {
        //document.getElementById("ErrorSpan2").style.display = "block";
        alert("Please select Task Name");
    }
    else {
        //document.getElementById("ErrorSpan2").style.display = "none";
    }
    if (document.getElementById("localpages_txtHours").value == "") {
        //document.getElementById("ErrorSpan3").style.display = "block";
        alert("Hours Field cannot be blank");
        return false;
    }
    else {
        //document.getElementById("ErrorSpan3").style.display = "none";
    }
   
    if (parseInt(document.getElementById("localpages_txtHours").value) == MInsert) {
        alert("You already filled this hour");
    }
    else {
        if (document.getElementById("DDLProject").value != "0" && document.getElementById("DDLTask").value != "0" && document.getElementById("localpages_txtHours").value != "" && HourValidate(document.getElementById("localpages_txtHours").value)) {
        SaveUpdateTask(empid, roleid);
    }
       
    //alert(TotalHour);
    }
}

function ClearProjectTaskFields() {
    document.getElementById("localpages_txtHours").value = "";
    document.getElementById("DDLProject").value = "0";
    document.getElementById("DDLTask").value = "0";
    document.getElementById("localpages_lblAllocatedWork").innerHTML = "";
    document.getElementById("localpages_lblActualWork").innerHTML = "";
}


function HourValidate(val) {

    var AllocatedHr = document.getElementById("localpages_lblAllocatedWork").innerHTML;
    var ActualHr = document.getElementById("localpages_lblActualWork").innerHTML;
    TotalHour=0;
    //alert("TotalHour " + TotalHour + " Validate: " + parseFloat(document.getElementById("localpages_txtHours").value));
    TotalHour = TotalHour + parseFloat(document.getElementById("localpages_txtHours").value);
    var TotalActualHr = parseFloat(ActualHr) + parseFloat(document.getElementById("localpages_txtHours").value);
    var TotalActualHr1 =  parseFloat(document.getElementById("localpages_txtHours").value);
     //alert(TotalHour+'asdasd'+parseFloat(document.getElementById("localpages_txtHours").value))
     var diff;
     var diffActualHr;
     //alert(AllocatedHr+'Actual'+ActualHr)
    if (val <= 24) {
           
                 if(parseFloat(val)>parseFloat(MInsert))
                   {

                       diff=parseFloat(val)-parseFloat(MInsert);
                       diffActualHr=parseFloat(ActualHr)+parseFloat(diff);
                      
     
                      if(parseFloat(diffActualHr)>parseFloat(AllocatedHr))
                      {
  
               
      
                            var stat = confirm("You were Allocated " + AllocatedHr + "hour(s) to complete the task .with this entry,the total hours that will be booked against this task is " + diffActualHr + " Your project schedule may be affected");
                            if (stat == false) {
                            document.getElementById("localpages_txtHours").value = MInsert;
                            return false;
                            }
                            else {
               
                            if (CheckForWeekDaysHours(TotalHour)) {
                                return true;
                            }
                            else {
              
                                alert("You can book only 24 hours in a day you have already booked " + TotalHour + " hours.Your current entry will be adjusted to bring the total to 24");
                                document.getElementById("localpages_txtHours").value = MInsert;
                                TotalHour = parseInt(TotalHour) - parseInt(val);
                                return false;
                            }
               
                            }
                       }
                       else if(parseFloat(diffActualHr)<parseFloat(AllocatedHr))
                       {
                        return true;
                       }
                   
                         
                     }
                     else if(parseFloat(val)<parseFloat(MInsert))
                         {
            
                           return true;
                         }
//            else if (parseFloat(val) <= parseFloat(AllocatedHr)) {
//       
//            var stat;
//            if (TotalActualHr1 > AllocatedHr) {
//                stat = confirm("You were Allocated " + AllocatedHr + "hour(s) to complete the task .with this entry,the total hours that will be booked against this task is " + TotalActualHr1 + " Your project schedule may be affected");
//            }
//            if (stat == false) {
//                document.getElementById("localpages_txtHours").value = MInsert;
//                //MActualWork = document.getElementById("localpages_lblActualWork").innerHTML;
//                return false;
//            }
//            else {

//                if (CheckForWeekDaysHours(TotalHour)) {
//                    return true;
//                }
//                else {
//               
//                    alert("You can book only 24 hours in a day you have already booked " + TotalHour + " hours.Your current entry will be adjusted to bring the total to 24");
//                    document.getElementById("localpages_txtHours").value = MInsert;
//                    TotalHour = parseInt(TotalHour) - parseInt(val);
//                    return false;
//                }
//            }
//            }

        }
   
    else if (val > 24) {
        document.getElementById("localpages_txtHours").value = MInsert;
        alert('Hour cannot be greater than 24');
        return false;
    }

}

// to check IsTaskComplete and void task validation
function MCheckIsMarkCompleteTask(TaskID) {



    M_CheckDisableTimesheet(TaskID);//To check the generate timesheet validation
//   alert("A"+CheckDisableTimesheetFlag)
//    if(CheckDisableTimesheetFlag==1 || IsTaskComplete=='true' || voidTask=='true')
//    {
//    
//        document.getElementById("localpages_txtHours").disabled = true;
//        document.getElementById("BtnSaveUpdate").disabled = true;
//    }
//    else
//    {
//        document.getElementById("localpages_txtHours").disabled=false;
//        document.getElementById("BtnSaveUpdate").disabled=false;
//    }




}
var CheckDisableTimesheet_WStartDate;
var CheckDisableTimesheet_endDate;
var CheckDisableTimesheetFlag;
function M_CheckDisableTimesheet()
{

     
        CheckDisableTimesheet_WStartDate=DateSelected;
        CheckDisableTimesheet_endDate=DateSelected;
        
        para={intEmployeeID:EmployeeID,dtStartDate:CheckDisableTimesheet_WStartDate,dtEndDate:CheckDisableTimesheet_endDate,TaskID:TaskID}
        try {           
            $.ajax({
            type: "GET", //GET or POST or PUT or DELETE verb
            url: path+"HomeService.svc/chk_disabledTimesheet", // Location of the service
            data: para,
            contentType: "application/json;charset=utf-8", // content type sent to server
            dataType: "jsonp", //Expected data format from server
            success: function (data) {//On Successfull service call                                       
                            $.each(JSON.parse(data), function (id, obj) 
                            { 
                                     

                                    // alert(obj.Result)
                                        if(obj.Result==1)
                                        {
                                               
                                        CheckDisableTimesheetFlag=1;
                                        }                  
                                        else
                                        {
                                        CheckDisableTimesheetFlag=0;
                                        }
                                     
                                        if(CheckDisableTimesheetFlag==1 || IsTaskComplete=='true' || voidTask=='true')
                                            {
    
                                                document.getElementById("localpages_txtHours").disabled = true;
                                                document.getElementById("BtnSaveUpdate").disabled = true;
                                            }
                                            else
                                            {
                                                document.getElementById("localpages_txtHours").disabled=false;
                                                document.getElementById("BtnSaveUpdate").disabled=false;
                                            }
                            });                                     
                                            
                        
            },
            error: function (msg) {
                alert("Failed");
            }
        });
    } catch (exception) { }
}

/************************** FUNCTIONS ******************************/

function ShowPrevWeek(dt) {
    flag = 0;
    getCurrentWeek(GetPrevDate(dt));
}

function ShowNextWeek(dt) {
    flag = 1;
    getCurrentWeek(GetNextDate(dt));
}

/********************************  FUNCTIONS   *****************************************/


function GetStandardDate(dt) {                                      // GET STANDARD DATE IN READABLE FORM
    var arrdt = [];
    arrdt = dt.split('-');
    if (arrdt[1] <= 9) {
        arrdt[1] = arrdt[1].toString().substr(1, 1);
        arrdt[1] = parseInt(arrdt[1]) - 1;
    }
    else {
        arrdt[1] = parseInt(arrdt[1]) - 1;
    }
    return dt = arrdt[0] + ' ' + MonthAsString(arrdt[1]) + ' ' + arrdt[2];
}

function GetTodaysDate(dt) {
    var d, yyyy, mm, dd;
    if (dt == undefined) {
        d = new Date();
    }
    else {
        d = new Date(dt);
    }
    yyyy = d.getFullYear().toString();
    mm = (d.getMonth() + 1).toString();                             // getMonth() is zero-based
    dd = d.getDate().toString();
    return (dd[1] ? dd : "0" + dd[0]) + '-' + (mm[1] ? mm : "0" + mm[0]) + '-' + yyyy;
}
function GetMMddYYDate(dt) {
    var d, yyyy, mm, dd;
    if (dt == undefined) {
        d = new Date();
    }
    else {
        d = new Date(dt);
    }
    yyyy = d.getFullYear().toString();
    mm = (d.getMonth() + 1).toString();                             // getMonth() is zero-based
    dd = d.getDate().toString();
    return (mm[1] ? mm : "0" + mm[0]) + '/' + (dd[1] ? dd : "0" + dd[0]) + '/' + yyyy;
}
function GetNextDate(dt) {
    var nextDay;
    nextDay = new Date(dt);
    nextDay.setDate(nextDay.getDate() + 1);
    return nextDay;
}
function GetPrevDate(dt) {
    var prevDay;
    prevDay = new Date(dt);
    prevDay.setDate(prevDay.getDate() - 1);
    return prevDay;
}

function getCurrentWeekEvents(dt) {                                 // GET CURRENT WEEK DAYS
    var curr = '';
    ArrWeek = [];
    var startDate = '';
    var endDate = '';

    if (dt == undefined || dt == '') {
        curr = new Date();
    }
    else {
        curr = new Date(dt);
    }

    if (GetWeekDay(curr.getDay()) == "Sunday") {
        startDate = new Date(curr.getFullYear(), curr.getMonth(), curr.getDate() - curr.getDay() - 6);
        endDate = new Date(curr.getFullYear(), curr.getMonth(), curr.getDate() - curr.getDay());
    }
    else {
        startDate = new Date(curr.getFullYear(), curr.getMonth(), curr.getDate() - curr.getDay() + 1);
        endDate = new Date(curr.getFullYear(), curr.getMonth(), curr.getDate() - curr.getDay() + 7);
    }

    if (dt == undefined || dt == '') {
        for (var i = startDate; i <= endDate; ) {
            ArrWeek.push({ date: i });
            i = GetNextDate(i);
        }
    }
    else if (flag == 0) {
        for (var i = startDate; i <= dt; ) {
            ArrWeek.push({ date: i });
            i = GetNextDate(i);
        }
    }
    else if (flag == 1) {
        for (var i = startDate; i <= endDate; ) {
            ArrWeek.push({ date: i });
            i = GetNextDate(i);
        }
    }

    return ArrWeek;
}

function MonthAsString(monthIndex) {
    var d = new Date();
    var month = new Array();
    month[0] = "Jan";
    month[1] = "Feb";
    month[2] = "Mar";
    month[3] = "Apr";
    month[4] = "May";
    month[5] = "Jun";
    month[6] = "Jul";
    month[7] = "Aug";
    month[8] = "Sep";
    month[9] = "Oct";
    month[10] = "Nov";
    month[11] = "Dec";

    return month[monthIndex];
}

function DDLVal(val) {
    if (val == 0) {
        alert('Invalid selection');
        return false;
    }
    else {
        return true;
    }
}

var specialKeys = new Array();
specialKeys.push(8); //Backspace
function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode
    var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
    return ret;
}
function NumericValidation(numbers) {
    var number = /^\d{0,9}(?:\.\d{0,9}){0,9}$/
    if (numbers.match(number)) {
        if (NumericValidationPoint(numbers)) {
            if (NumericValidationPointNext(numbers)) {
                return true;
            }
            else {
                document.getElementById("localpages_txtHours").value = "";
            }

        }
        else {
            document.getElementById("localpages_txtHours").value = "";
        }
    }
    else {
        alert('Please Enter Numeric Value');
        document.getElementById("localpages_txtHours").value = TotalHrV;
    }


}

function NumericValidationPoint(numbers) {
    if (numbers < 0.25 && numbers != 0) {
        alert('Please enter hours complete in multiple of [0.25]');
        return false;
    }
    else {
        return true;
    }
}

function NumericValidationPointNext(numbers) {
    if (numbers % 0.25 != 0) {
        alert('Please enter hours complete in multiple of [0.25]');
        return false;
    }
    else {
        return true;
    }
}

function GetWeekDay(day) {
    var ArrWeekDays = new Array(7);
    ArrWeekDays[0] = "Sunday";
    ArrWeekDays[1] = "Monday";
    ArrWeekDays[2] = "Tuesday";
    ArrWeekDays[3] = "Wednesday";
    ArrWeekDays[4] = "Thursday";
    ArrWeekDays[5] = "Friday";
    ArrWeekDays[6] = "Saturday";

    return ArrWeekDays[day];
}

function CheckForWeekDaysHours(TotalHours) {

    if (TotalHours > 24) {
        return false;
    }
    else {
        return true;
    }
}

/*****************************   GENERIC FUNCTIONS  ENDS HERE   *****************************************/