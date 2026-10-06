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
    for (var i = 0; i < arrYears.length; i++) {
        var iYear = arrYears[i];
        var iMonthCounter = 1;
        if (iYear == iStartYear) {
            iMonthCounter = iStartMonth
        }
        for (var j = iMonthCounter; j <= 12; j++) {
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
                            sHtml += "<th class='daycol today' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='bottom' data-html='true' id='result" + sTDID + "' ></th>";
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
                                    strtoolTip += arrMileStone[0];
                                    strPoint = "<img src='../../../Whizible2.0/dist/img/rhomb-outline.png' class='" + arrMileStone[2] + "'>";
                                }
                                if (strReview != "") {
                                    var arrReview = strReview.split("|");
                                    if (strtoolTip != "") {
                                        strtoolTip += "</br>" + arrReview[0];
                                    }
                                    else {
                                        strtoolTip += arrReview[0];
                                    }
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint += "</br>" + "<i class='fa fa-refresh " + arrReview[2] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint = "<i class='fa fa-refresh " + arrReview[2] + "'></i>";
                                    }
                                }
                                if (strPhase != "") {
                                    var arrPhase = strPhase.split("|");
                                    if (strtoolTip != "") {
                                        strtoolTip += "</br>" + arrPhase[0];
                                    }
                                    else {
                                        strtoolTip += arrPhase[0];
                                    }
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint += "</br>" + "<i class='" + arrPhase[2] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint = "<i class='" + arrPhase[2] + "'></i>";
                                    }
                                }
                                sHtml += "<td class='daycol today' data-toggle='popover' title='" + strForToolTip + " - " + strtoolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'>" + strPoint + "</td>";
                            }
                            else {
                                if (dtForToolTip.getFullYear() == dtexpEndDate.getFullYear()
                                    && dtForToolTip.getMonth() + 1 == dtexpEndDate.getMonth() + 1
                                    && dtForToolTip.getDate() == dtexpEndDate.getDate()) {
                                    sHtml += "<td class='daycol today' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><i class='fa fa-arrow-right' aria-hidden='true' style='color:" + ScheduleObject.ProjectStatus + "'></i></td>"
                                }
                                else {
                                    sHtml += "<td class='daycol today' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><hr style='border-color:" + ScheduleObject.ProjectStatus + "'></td>"
                                }
                            }
                        }
                    }
                    else {
                        if (ScheduleObject.RecordLevel == "H") {
                            sHtml += "<th class='daycol' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "' ></th>";
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
                                    strtoolTip += arrMileStone[0];
                                    strPoint = "<img src='../../../Whizible2.0/dist/img/rhomb-outline.png' class='" + arrMileStone[2] + "'>";
                                }
                                if (strReview != "") {
                                    var arrReview = strReview.split("|");
                                    if (strtoolTip != "") {
                                        strtoolTip += "</br>" + arrReview[0];
                                    }
                                    else {
                                        strtoolTip += arrReview[0];
                                    }
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint += "</br>" + "<i class='fa fa-refresh " + arrReview[2] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrReview[2] + "'>" + arrReview[1] + "</i>";
                                        strPoint = "<i class='fa fa-refresh " + arrReview[2] + "'></i>";
                                    }
                                }
                                if (strPhase != "") {
                                    var arrPhase = strPhase.split("|");
                                    if (strtoolTip != "") {
                                        strtoolTip += "</br>" + arrPhase[0];
                                    }
                                    else {
                                        strtoolTip += arrPhase[0];
                                    }
                                    if (strPoint != "") {
                                        //strPoint += "</br>" + "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint += "</br>" + "<i class='" + arrPhase[2] + "'></i>";
                                    }
                                    else {
                                        //strPoint = "<i class='" + arrPhase[2] + "'>" + arrPhase[1] + "</i>";
                                        strPoint = "<i class='" + arrPhase[2] + "'></i>";
                                    }
                                }
                                sHtml += "<td class='daycol' data-toggle='popover' Title='" + strForToolTip + " - " + strtoolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'>" + strPoint + "</td>";
                            }
                            else {
                                if (dtForToolTip.getFullYear() == dtexpEndDate.getFullYear()
                                    && dtForToolTip.getMonth() + 1 == dtexpEndDate.getMonth() + 1
                                    && dtForToolTip.getDate() == dtexpEndDate.getDate()) {
                                    sHtml += "<td class='daycol' data-toggle='popover' Title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><i class='fa fa-arrow-right' aria-hidden='true' style='color:" + ScheduleObject.ProjectStatus + "'></i></td>"
                                }
                                else {
                                    sHtml += "<td class='daycol' data-toggle='popover' Title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'><hr style='border-color:" + ScheduleObject.ProjectStatus + "'></td>"
                                }
                            }
                        }

                    }
                }
                else {
                    if (iYear == dtCurr.getFullYear() && dtCurr.getMonth() + 1 == j && dtCurr.getDate() == arrDays[k]) {
                        if (ScheduleObject.RecordLevel == "H") {
                            sHtml += "<th class='daycol today' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "'></th>";
                        }
                        else {
                            sHtml += "<td class='daycol today' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='bottom' data-html='true' id='result" + sTDID + "'></td>";
                        }
                    }
                    else {
                        if (ScheduleObject.RecordLevel == "H") {
                            sHtml += "<th class='daycol' data-toggle='popover' title='" + strForToolTip + "' data-container='body' data-placement='top' data-html='true' id='result" + sTDID + "' ></th>";
                        }
                        else {
                            sHtml += "<td class='daycol' data-toggle='popover' Title='" + strForToolTip + "' data-container='body' data-placement='bottom' data-html='true' id='result" + sTDID + "'></td>";
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
            if (msrobject.ProjectID == ProjectID) {
                intCount += 1;
                if (dtexpEndDate.getFullYear() == dt.getFullYear()
                    && dtexpEndDate.getMonth() == dt.getMonth()
                    && dtexpEndDate.getDate() == dt.getDate()) {
                    strRet = msrobject.ProjectName;
                    strRecordLevel = msrobject.RecordLevel;
                    break;
                }
            }
        }
        if (strRet != "") {
            strRet = strRet + "|" + strRecordLevel + intCount.toString() + "|" + msrcls
        }
    }
    return strRet;
}

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