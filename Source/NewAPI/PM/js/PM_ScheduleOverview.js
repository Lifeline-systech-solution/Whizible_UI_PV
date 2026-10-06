var dtStartDate = new Date();
var dtEndDate = new Date();

function addYearHeader(iYear, iMonth) {
    var sHtml = "";
    var iStartYear = dtStartDate.getFullYear();
    var iEndYear = dtEndDate.getFullYear();
    var sYears = getRangeString(iStartYear, iEndYear);
    var arrYears = sYears.split(',');
    for (var i = 0; i < arrYears.length; i++) {
        if (iYear == arrYears[i]) {
            sHtml += "<th colspan='" + (13 - iMonth).toString() + "'>";
        }
        else {
            sHtml += "<th colspan='12'>";
        }
        sHtml += arrYears[i].toString();
        sHtml += "</th>";
    }
    return sHtml;
}

var months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
];

function addMonthHeader(iYear, iMonth) {
    var sHtml = "";
    var iStartYear = dtStartDate.getFullYear();
    var iEndYear = dtEndDate.getFullYear();
    var sYears = getRangeString(iStartYear, iEndYear);
    var arrYears = sYears.split(',');
    for (var i = 0; i < arrYears.length; i++) {
        if (iYear == arrYears[i]) {
            if (iMonth == 1) {
                sHtml += "<th class='cell'>Jan</th>";
                sHtml += "<th class='cell'>Feb</th>";
                sHtml += "<th class='cell'>Mar</th>";
                sHtml += "<th class='cell'>Apr</th>";
                sHtml += "<th class='cell'>May</th>";
                sHtml += "<th class='cell'>Jun</th>";
                sHtml += "<th class='cell'>Jul</th>";
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 2) {
                sHtml += "<th class='cell'>Feb</th>";
                sHtml += "<th class='cell'>Mar</th>";
                sHtml += "<th class='cell'>Apr</th>";
                sHtml += "<th class='cell'>May</th>";
                sHtml += "<th class='cell'>Jun</th>";
                sHtml += "<th class='cell'>Jul</th>";
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 3) {
                sHtml += "<th class='cell'>Mar</th>";
                sHtml += "<th class='cell'>Apr</th>";
                sHtml += "<th class='cell'>May</th>";
                sHtml += "<th class='cell'>Jun</th>";
                sHtml += "<th class='cell'>Jul</th>";
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 4) {
                sHtml += "<th class='cell'>Apr</th>";
                sHtml += "<th class='cell'>May</th>";
                sHtml += "<th class='cell'>Jun</th>";
                sHtml += "<th class='cell'>Jul</th>";
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 5) {
                sHtml += "<th class='cell'>May</th>";
                sHtml += "<th class='cell'>Jun</th>";
                sHtml += "<th class='cell'>Jul</th>";
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 6) {
                sHtml += "<th class='cell'>Jun</th>";
                sHtml += "<th class='cell'>Jul</th>";
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 7) {
                sHtml += "<th class='cell'>Jul</th>";
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 8) {
                sHtml += "<th class='cell'>Aug</th>";
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 9) {
                sHtml += "<th class='cell'>Sep</th>";
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 10) {
                sHtml += "<th class='cell'>Oct</th>";
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 11) {
                sHtml += "<th class='cell'>Nov</th>";
                sHtml += "<th class='cell'>Dec</th>";
            }
            if (iMonth == 12) {
                sHtml += "<th class='cell'>Dec</th>";
            }
        }
        else {
            //commented and added By Vaijat K For plotting exact month
            //sHtml += "<th class='cell'>Jan</th>";
            //sHtml += "<th class='cell'>Feb</th>";
            //sHtml += "<th class='cell'>Mar</th>";
            //sHtml += "<th class='cell'>Apr</th>";
            //sHtml += "<th class='cell'>May</th>";
            //sHtml += "<th class='cell'>Jun</th>";
            //sHtml += "<th class='cell'>Jul</th>";
            //sHtml += "<th class='cell'>Aug</th>";
            //sHtml += "<th class='cell'>Sep</th>";
            //sHtml += "<th class='cell'>Oct</th>";
            //sHtml += "<th class='cell'>Nov</th>";
            //sHtml += "<th class='cell'>Dec</th>";
            var monthNo = dtEndDate.getMonth();
            for (var i = 0; i <= monthNo; i++) {
                sHtml += "<th class='cell'>" + months[i] + "</th>";
            }
            //end commented and added By Vaijat K For plotting exact month
        }
    }
    return sHtml;
}

function addProjectRow(iStartMonth, ScheduleObject, ProjectScheduleMilestoneList, ProjectScheduleReviewList, ProjectSchedulePhaseList) {
    var sHtml = "";
    var dtexpStartDate = new Date(ScheduleObject.ExpectedStartDate);
    var dtexpEndDate = new Date(ScheduleObject.ExpectedEndDate);
    var dtCurr = new Date();
    var iStartYear = dtStartDate.getFullYear();
    var iEndYear = dtEndDate.getFullYear();
    var sYears = getRangeString(iStartYear, iEndYear);
    var arrYears = sYears.split(',');
    var iMonthEnd = 0;
    for (var i = 0; i < arrYears.length; i++) {
        var iYear = arrYears[i];
        var iMonthCounter = 1;
        if (iYear == iStartYear) {
            iMonthCounter = iStartMonth
            iMonthEnd = 12;
        }
        else {
            iMonthEnd = dtEndDate.getMonth() + 1;
        }
        //Commented And Added By Vaijat K
        //for (var j = iMonthCounter; j <= 12; j++) {
        for (var j = iMonthCounter; j <= iMonthEnd; j++) {
            //End Commented And Added By Vaijat K
            var strDivID = iYear.toString() + "_" + j.toString();
            var dtLastDayOfMonth = new Date(iYear, j, 0);
            var intDays = dtLastDayOfMonth.getDate();
            var sDays = getRangeString(1, intDays);
            var dtForToolTip = new Date();
            var strForToolTip = "";
            var arrDays = sDays.split(',');
            if (ScheduleObject.RecordLevel == "H") {
                sHtml += "<th class='monthcolumn'>";
            }
            else {
                sHtml += "<td class='monthcolumn'>";
            }
            sHtml += "<div id='popover-content-result1' class='hide'> </div>";
            sHtml += "<table id='myTable" + strDivID + "' class='myTable'  style='border-collapse: collapse;' cellpadding='1'><tbody>";
            sHtml += "<tr>";
            for (var k = 0; k < arrDays.length; k++) {
                dtForToolTip = new Date(iYear, j - 1, arrDays[k]);
                strForToolTip = getFormattedDate(dtForToolTip);
                var sTDID = strDivID + '_' + k.toString();

                if (dtForToolTip >= dtexpStartDate && dtForToolTip <= dtexpEndDate) {
                    if (iYear == dtCurr.getFullYear() && dtCurr.getMonth() + 1 == j && dtCurr.getDate() == arrDays[k]) {
                        if (ScheduleObject.RecordLevel == "H") {
                            sHtml += "<th class='daycol today " + strForToolTip + "' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='bottom' data-html='true' id='result" + sTDID + "' ></th>";
                        }
                        else {
                            var strMilestone = GetMSR(ScheduleObject.ProjectID, dtForToolTip, ProjectScheduleMilestoneList, "milestone");
                            var strReview = GetMSR(ScheduleObject.ProjectID, dtForToolTip, ProjectScheduleReviewList, "review");
                            var strPhase = GetMSR(ScheduleObject.ProjectID, dtForToolTip, ProjectSchedulePhaseList, "phases");
                            if (strMilestone != "" || strReview != "" || strPhase != "") {
                                var strtoolTip = "";
                                var strcls = "";
                                var strPoint = "";
                                if (strMilestone != "") {
                                    var arrMileStone = strMilestone.split("|");
                                    //strtoolTip += "</br> Milestones :- " + arrMileStone[0];
                                    //strPoint = "<i class='" + arrMileStone[2] + "'>" + arrMileStone[1] + "</i>";
                                    strPoint = "<img src='../PM/img/rhomb-outline.png' class='" + arrMileStone[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br> Milestones :- " + arrMileStone[0] + "' >";
                                }
                                if (strReview != "") {
                                    var arrReview = strReview.split("|");
                                    //if (strtoolTip != "") {
                                        //strtoolTip += "</br>Synchronization Pt :" + arrReview[0];
                                    //}
                                    //else {
                                    //    strtoolTip += arrReview[0];
                                    //}
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint += "</br>" + "<i class='fa fa-refresh " + arrReview[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br>Synchronization Pt :- " + arrReview[0] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint = "<i class='fa fa-refresh " + arrReview[2] + "'  data-toggle='popover' title='" + strForToolTip + " - " + "</br>Synchronization Pt :- " + arrReview[0] + "'></i>";
                                    }
                                }
                                if (strPhase != "") {
                                    var arrPhase = strPhase.split("|");
                                    //if (strtoolTip != "") {
                                        strtoolTip += "</br>Phases : " + arrPhase[0];
                                    //}
                                    //else {
                                    //    strtoolTip += arrPhase[0];
                                    //}
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint += "</br>" + "<i class='" + arrPhase[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br>Phases :- " + arrPhase[0] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint = "<i class='" + arrPhase[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br>Phases :- " + arrPhase[0] + "'></i>";
                                    }
                                }
                                sHtml += "<td class='daycol today makeEqual " + strForToolTip + "'  data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'>" + strPoint + "</td>";
                            }
                            else {
                                if (dtForToolTip.getFullYear() == dtexpEndDate.getFullYear()
                                    && dtForToolTip.getMonth() + 1 == dtexpEndDate.getMonth() + 1
                                    && dtForToolTip.getDate() == dtexpEndDate.getDate()) {
                                    sHtml += "<td class='daycol today " + strForToolTip + "' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><i class='fa fa-arrow-right' aria-hidden='true' style='color:" + ScheduleObject.ProjectStatus + "'></i></td>"
                                }
                                else {
                                    sHtml += "<td class='daycol today " + strForToolTip + "' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><hr style='border-color:" + ScheduleObject.ProjectStatus + "'></td>"
                                }
                            }
                        }
                    }
                    else {
                        if (ScheduleObject.RecordLevel == "H") {
                            sHtml += "<th class='daycol " + strForToolTip + "' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "' ></th>";
                        }
                        else {
                            var strMilestone = GetMSR(ScheduleObject.ProjectID, dtForToolTip, ProjectScheduleMilestoneList, "milestone");
                            var strReview = GetMSR(ScheduleObject.ProjectID, dtForToolTip, ProjectScheduleReviewList, "review");
                            var strPhase = GetMSR(ScheduleObject.ProjectID, dtForToolTip, ProjectSchedulePhaseList, "phases");
                            if (strMilestone != "" || strReview != "" || strPhase != "") {
                                var strtoolTip = "";
                                var strcls = "";
                                var strPoint = "";
                                if (strMilestone != "") {
                                    var arrMileStone = strMilestone.split("|");
                                    //strtoolTip += "</br> Milestones :- " + arrMileStone[0];
                                    //strPoint = "<i class='" + arrMileStone[2] + "'>" + arrMileStone[1] + "</i>";
                                    strPoint = "<img src='../PM/img/rhomb-outline.png' class='" + arrMileStone[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br> Milestones :- " + arrMileStone[0] + "' >";
                                }
                                if (strReview != "") {
                                    var arrReview = strReview.split("|");
                                    //if (strtoolTip != "") {
                                    //strtoolTip += "</br>Synchronization Pt :" + arrReview[0];
                                    //}
                                    //else {
                                    //    strtoolTip += arrReview[0];
                                    //}
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint += "</br>" + "<i class='fa fa-refresh " + arrReview[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br>Synchronization Pt :- " + arrReview[0] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint = "<i class='fa fa-refresh " + arrReview[2] + "'  data-toggle='popover' title='" + strForToolTip + " - " + "</br>Synchronization Pt :- " + arrReview[0] + "'></i>";
                                    }
                                }
                                if (strPhase != "") {
                                    var arrPhase = strPhase.split("|");
                                    //if (strtoolTip != "") {
                                    strtoolTip += "</br>Phases : " + arrPhase[0];
                                    //}
                                    //else {
                                    //    strtoolTip += arrPhase[0];
                                    //}
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint += "</br>" + "<i class='" + arrPhase[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br>Phases :- " + arrPhase[0] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint = "<i class='" + arrPhase[2] + "' data-toggle='popover' title='" + strForToolTip + " - " + "</br>Phases :- " + arrPhase[0] + "'></i>";
                                    }
                                }
                                sHtml += "<td class='daycol makeEqual " + strForToolTip + "' data-toggle='popover'  data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'>" + strPoint + "</td>";
                            }
                            else {
                                if (dtForToolTip.getFullYear() == dtexpEndDate.getFullYear()
                                    && dtForToolTip.getMonth() + 1 == dtexpEndDate.getMonth() + 1
                                    && dtForToolTip.getDate() == dtexpEndDate.getDate()) {
                                    sHtml += "<td class='daycol " + strForToolTip + "' data-toggle='popover' Title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><i class='fa fa-arrow-right' aria-hidden='true' style='color:" + ScheduleObject.ProjectStatus + "'></i></td>"
                                }
                                else {
                                    sHtml += "<td class='daycol " + strForToolTip + "' data-toggle='popover' Title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><hr style='border-color:" + ScheduleObject.ProjectStatus + "'></td>"
                                }
                            }
                        }

                    }
                }
                else {
                    if (iYear == dtCurr.getFullYear() && dtCurr.getMonth() + 1 == j && dtCurr.getDate() == arrDays[k]) {
                        if (ScheduleObject.RecordLevel == "H") {
                            sHtml += "<th class='daycol today " + strForToolTip + "' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'></th>";
                        }
                        else {
                            sHtml += "<td class='daycol today " + strForToolTip + "' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='bottom' data-html='true' id='result" + sTDID + "'></td>";
                        }
                    }
                    else {
                        if (ScheduleObject.RecordLevel == "H") {
                            sHtml += "<th class='daycol " + strForToolTip + "' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "' ></th>";
                        }
                        else {
                            sHtml += "<td class='daycol " + strForToolTip + "' data-toggle='popover' Title='" + strForToolTip + "' data-container='body' data-placement='bottom' data-html='true' id='result" + sTDID + "'></td>";
                        }
                    }
                }


            }
            sHtml += "</tr>";
            sHtml += "</table>";
            if (ScheduleObject.RecordLevel == "H") {
                sHtml += "</th>";
            }
            else {
                sHtml += "</td>";
            }
        }
    }
    return sHtml;
}

function GetMSR(ProjectID, dt, msrList, msrcls) {
    var strRet = "";
    var strRecordLevel = "";
    var intCount = 0;
    if (msrList != undefined) {
        for (var i = 0; i < msrList.length; i++) {
            var msrobject = msrList[i];
            var dtexpEndDate = new Date(msrobject.ExpectedEndDate);
            var dtexpStartDate = new Date(msrobject.ExpectedStartDate);
            if (msrobject.ProjectID == ProjectID) {
                var projectName = ""
                if (String(msrobject.ProjectName).replace("'", "&apos;").length > 150) {
                    projectName = String(msrobject.ProjectName).replace("'", "&apos;").substring(0,150) + "..."
                }
                else {
                    projectName = String(msrobject.ProjectName).replace("'", "&apos;")
                }
                intCount += 1;
                if (dtexpEndDate.getFullYear() == dt.getFullYear()
                    && dtexpEndDate.getMonth() == dt.getMonth()
                    && dtexpEndDate.getDate() == dt.getDate()) {
                    if (strRet == "")
                        strRet = projectName + " [" + dtexpStartDate.toLocaleDateString() + "-" + dtexpEndDate.toLocaleDateString() + "]";
                    else
                        strRet = strRet + ' , ' + projectName + " [" + dtexpStartDate.toLocaleDateString() + "-" + dtexpEndDate.toLocaleDateString() + "]";

                    if (strRecordLevel == "")
                        strRecordLevel = msrobject.RecordLevel;
                    else
                        strRecordLevel = strRecordLevel + ', ' + msrobject.RecordLevel;
                    //break;
                }
               else if (dtexpStartDate.getFullYear() == dt.getFullYear()
                    && dtexpStartDate.getMonth() == dt.getMonth()
                    && dtexpStartDate.getDate() == dt.getDate()) {
                    if (strRet == "")
                        strRet = projectName + " [" + dtexpStartDate.toLocaleDateString() + "-" + dtexpEndDate.toLocaleDateString() + "]";
                    else
                        strRet = strRet + ' , ' + projectName + " [" + dtexpStartDate.toLocaleDateString() + "-" + dtexpEndDate.toLocaleDateString() + "]";

                    if (strRecordLevel == "")
                        strRecordLevel = msrobject.RecordLevel;
                    else
                        strRecordLevel = strRecordLevel + ', ' + msrobject.RecordLevel;
                    //break;
                }
            }
        }
        if (strRet != "") {
            strRet = strRet + "|" + strRecordLevel + intCount.toString() + "|" + msrcls
        }
    }
    return strRet;
}

var fromHtmlEntities = function (string) {
    return (string + "").replace(/&#\d+;/gm, function (s) {
        return String.fromCharCode(s.match(/\d+/gm)[0]);
    })
};

function getMonthName(imonth) {
    var sMonth = "";
    switch (imonth) {
        case 1:
            sMonth = "Jan";
            break;
        case 2:
            sMonth = "Feb";
            break;
        case 3:
            sMonth = "Mar";
            break;
        case 4:
            sMonth = "Apr";
            break;
        case 5:
            sMonth = "May";
            break;
        case 6:
            sMonth = "Jun";
            break;
        case 7:
            sMonth = "Jul";
            break;
        case 8:
            sMonth = "Aug";
            break;
        case 9:
            sMonth = "Sep";
            break;
        case 10:
            sMonth = "Oct";
            break;
        case 11:
            sMonth = "Nov";
            break;
        case 12:
            sMonth = "Dec";
            break;
    }
    return sMonth;
}

function getFormattedDate(dt) {
//debugger;
    var strdt = dt.getDate() + "-" + getMonthName(dt.getMonth() + 1) + "-" + dt.getFullYear();
    return strdt;
}

function getRangeString(iStart, iEnd) {
    var sRange = "";
    for (var i = iStart; i <= iEnd; i++) {
        if (sRange == "") {
            sRange = i.toString();
        }
        else {
            sRange += "," + i.toString();
        }
    }
    return sRange;
}

var ajaxResult;
function ajaxCall(url, type, contentType, dataType, param, async) {
    ajaxResult = undefined;
    $.ajax({
        url: strUrl + url,
        type: type,
        contentType: contentType,
        dataType: dataType,
        data: param,
        async: async,
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
        },
        success: function (data) {
            ajaxResult = data;
        },
        error: function (xhr) {
            console.log(xhr);
        }
    })
    return ajaxResult;
}

function StartLoader(bodyID) {

    var progress2 = new LoadingOverlayProgress({
        bar: {
            "background": "#ddd",
            "top": "50px",
            "height": "30px",
            "border-radius": "15px",
          /*  "background": " url('../../../Whizible2.0/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"*/
            "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
        },

    });
    $(bodyID).LoadingOverlay("show", {
        custom: progress2.Init()
    });
}

function StopAjaxLoader(bodyID) {
    // This gets executed when the content is loaded
    $(bodyID).LoadingOverlay("hide", {

    });
}