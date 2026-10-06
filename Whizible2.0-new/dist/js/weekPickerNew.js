var globalTriggeringElement;
var startDate;
var endDate;
var globalAdditionalFunction = function() { null; };

var getDateFromISOWeek = function(ywString, separator) {
    try {
        //console.log(ywString);
        var ywArray = ywString.split(separator);
        var y = ywArray[0];
        var w = ywArray[1];
        var simple = new Date(y, 0, 1 + (w - 1) * 7);
        var dow = simple.getDay();

        var ISOweekStart = simple;
        if (dow <= 4)
            ISOweekStart.setDate(simple.getDate() - simple.getDay() + 1);
        else
            ISOweekStart.setDate(simple.getDate() + 8 - simple.getDay());
        return ISOweekStart;
    } catch (err) {
        console.error("Cannot convert Week into date");
        return new Date();
    }
};

var showWeekCalendar = function(triggeringElement, additionalFunction) {
    globalTriggeringElement = triggeringElement;
    globalAdditionalFunction = additionalFunction;
    var prevItem = $(triggeringElement).prev();
    var weekValue = prevItem.val();

    prevItem.datepicker("option", "defaultDate", getDateFromISOWeek(weekValue, '-'));
    prevItem.val(weekValue);
    prevItem.datepicker("show");
};


var GstardDay = 0;

var setWeekCalendar = function (settingElement, def = 'no', IsDateChanged, startDayOfWeek, TodaysDate) {
    //debugger
        var selectCurrentWeek = function () {
            window.setTimeout(function () {
                var activeElement = $("#ui-datepicker-div .ui-state-active");
                var tdElement = activeElement.parent();
                var trElement = tdElement.parent();
                trElement.find("a").addClass("ui-state-active");
            }, 1);
        };

        // Retrieve the previously selected date or default to today
        var datepickerValue = $(settingElement).datepicker('getDate') || new Date();
        var weekDay = datepickerValue.getDay();

        // Calculate startDate (the first day of the week based on startDayOfWeek)
        var startDate, endDate;

        if (IsDateChanged == "1") {
            // Destroy the datepicker
            GstardDay = startDayOfWeek;
            //$(settingElement).datepicker("destroy");
            var startOffset = (weekDay - startDayOfWeek + 7) % 7;
            startDate = new Date(datepickerValue);
            startDate.setDate(datepickerValue.getDate() - startOffset); // Set the start date to the first day of the week
        } else {
            //$(settingElement).datepicker("destroy");
            startDate = new Date(datepickerValue);
            startDate.setDate(datepickerValue.getDate() - weekDay + (weekDay === 0 ? -6 : 1)); // Adjust for Sunday to Monday if needed
        }
        
        endDate = new Date(startDate);
        endDate.setDate(startDate.getDate() + 6); // End of the week

        // Format dates as "DD Mon"
        var newStartDate = formatDate(startDate);
        var newEndDate = formatDate(endDate);
        // Construct display string
        var weekNum = $.datepicker.iso8601Week(datepickerValue);
        if (weekNum < 10) {
            weekNum = "0" + weekNum;
        }
        var monthName = getMnth(datepickerValue.getMonth() + 1);
        var ywString = `<span class="year">${monthName} ${datepickerValue.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;

        // Update input and display
        $(settingElement).prev().html(ywString);
        $(settingElement).val(newStartDate + " - " + newEndDate);
        $(settingElement).attr("startDate", formatISODate(startDate));
        $(settingElement).attr("endDate", formatISODate(endDate));
        
        $(settingElement).datepicker({ 
            showOtherMonths: true,
            selectOtherMonths: true,
            showWeek: false,
            firstDay: startDayOfWeek, // Week starts on Monday
            onSelect: function (dateText, inst) {
                //debugger
                isWeek = 1;
                var datepickerValue = $(this).datepicker('getDate');
                var weekCode = datepickerValue.getDay();
                var dayCode = datepickerValue.getDay();
                var dateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
                var weekNum = $.datepicker.iso8601Week(dateObj);          
                var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class"weekNo">Week ' + weekNum + '</span>';
                $(this).prev().html(ywString);
                if (isWeek == 1) {
                    //debugger
                    switch (startingDayOfWeek) {
                    
                        case 1:
                            if (dayCode == 0) {
                                dayCode = 7;
                            }

                            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 1);

                            var dd = startDate.getDate();
                            var mm = startDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = startDate.getFullYear();
                            var newStartDate = mnth + ' ' + dd;

                            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);

                            var dd = endDate.getDate();
                            var mm = endDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = endDate.getFullYear();
                            var newEndDate = mnth + ' ' + dd;

                            var newdateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 1);
                            var weekNum = $.datepicker.iso8601Week(newdateObj);
                            //var ywString = '<span class="year">' + getMnth(endDate.getMonth() + 1) + ' ' + endDate.getFullYear() + '</span>' + '<span class="weekNo">Week ' + weekNum + '</span>';
                            var ywString = `<span class="year">${getMnth(endDate.getMonth() + 1)} ${endDate.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;
                            $(this).prev().html(ywString);
                            break;
                        case 2:
                            if (dayCode == 0) {
                                dayCode = 7;
                            }
                            if (dayCode == 1) {
                                dayCode = 8;
                            }

                            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 2);

                            var dd = startDate.getDate();
                            var mm = startDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = startDate.getFullYear();
                            var newStartDate = mnth + ' ' + dd;

                            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 8);

                            var dd = endDate.getDate();
                            var mm = endDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = endDate.getFullYear();
                            var newEndDate = mnth + ' ' + dd;

                            var newdateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 2);
                            var weekNum = $.datepicker.iso8601Week(newdateObj);
                            //var ywString = '<span class="year">' + getMnth(endDate.getMonth() + 1) + ' ' + endDate.getFullYear() + '</span>' + '<span class="weekNo">Week ' + weekNum + '</span>';
                            var ywString = `<span class="year">${getMnth(endDate.getMonth() + 1)} ${endDate.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;
                            $(this).prev().html(ywString);
                            break;
                        case 3:
                            if (dayCode == 0) {
                                dayCode = 7;
                            }
                            if (dayCode == 1) {
                                dayCode = 8;
                            }
                            if (dayCode == 2) {
                                dayCode = 9;
                            }

                            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 3);

                            var dd = startDate.getDate();
                            var mm = startDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = startDate.getFullYear();
                            var newStartDate = mnth + ' ' + dd;

                            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 9);

                            var dd = endDate.getDate();
                            var mm = endDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = endDate.getFullYear();
                            var newEndDate = mnth + ' ' + dd;

                            var newdateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 3);
                            var weekNum = $.datepicker.iso8601Week(newdateObj);
                            //var ywString = '<span class="year">' + getMnth(endDate.getMonth() + 1) + ' ' + endDate.getFullYear() + '</span>' + '<span class="weekNo">Week ' + weekNum + '</span>';
                            var ywString = `<span class="year">${getMnth(endDate.getMonth() + 1)} ${endDate.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;
                            $(this).prev().html(ywString);
                            break;
                        case 4:
                            if (dayCode == 0) {
                                dayCode = 7;
                            }
                            if (dayCode == 1) {
                                dayCode = 8;
                            }
                            if (dayCode == 2) {
                                dayCode = 9;
                            }
                            if (dayCode == 3) {
                                dayCode = 10;
                            }

                            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 4);

                            var dd = startDate.getDate();
                            var mm = startDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = startDate.getFullYear();
                            var newStartDate = mnth + ' ' + dd;

                            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 10);

                            var dd = endDate.getDate();
                            var mm = endDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = endDate.getFullYear();
                            var newEndDate = mnth + ' ' + dd;

                            var newdateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 4);
                            var weekNum = $.datepicker.iso8601Week(newdateObj);
                            //var ywString = '<span class="year">' + getMnth(endDate.getMonth() + 1) + ' ' + endDate.getFullYear() + '</span>' + '<span class="weekNo">Week ' + weekNum + '</span>';
                            var ywString = `<span class="year">${getMnth(endDate.getMonth() + 1)} ${endDate.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;
                            $(this).prev().html(ywString);
                            break;
                        case 5:
                            if (dayCode == 0) {
                                dayCode = 7;
                            }
                            if (dayCode == 1) {
                                dayCode = 8;
                            }
                            if (dayCode == 2) {
                                dayCode = 9;
                            }
                            if (dayCode == 3) {
                                dayCode = 10;
                            }
                            if (dayCode == 4) {
                                dayCode = 11;
                            }

                            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 5);

                            var dd = startDate.getDate();
                            var mm = startDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = startDate.getFullYear();
                            var newStartDate = mnth + ' ' + dd;

                            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 11);

                            var dd = endDate.getDate();
                            var mm = endDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = endDate.getFullYear();
                            var newEndDate = mnth + ' ' + dd;

                            var newdateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 5);
                            var weekNum = $.datepicker.iso8601Week(newdateObj);
                            //var ywString = '<span class="year">' + getMnth(endDate.getMonth() + 1) + ' ' + endDate.getFullYear() + '</span>' + '<span class="weekNo">Week ' + weekNum + '</span>';
                            var ywString = `<span class="year">${getMnth(endDate.getMonth() + 1)} ${endDate.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;
                            $(this).prev().html(ywString);
                            break;
                        case 6:
                            if (dayCode == 0) {
                                dayCode = 7;
                            }
                            if (dayCode == 1) {
                                dayCode = 8;
                            }
                            if (dayCode == 2) {
                                dayCode = 9;
                            }
                            if (dayCode == 3) {
                                dayCode = 10;
                            }
                            if (dayCode == 4) {
                                dayCode = 11;
                            }
                            if (dayCode == 5) {
                                dayCode = 12;
                            }

                            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 6);

                            var dd = startDate.getDate();
                            var mm = startDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = startDate.getFullYear();
                            var newStartDate = mnth + ' ' + dd;

                            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 12);

                            var dd = endDate.getDate();
                            var mm = endDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = endDate.getFullYear();
                            var newEndDate = mnth + ' ' + dd;

                            var newdateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 6);
                            var weekNum = $.datepicker.iso8601Week(newdateObj);
                            //var ywString = '<span class="year">' + getMnth(endDate.getMonth() + 1) + ' ' + endDate.getFullYear() + '</span>' + '<span class="weekNo">Week ' + weekNum + '</span>';
                            var ywString = `<span class="year">${getMnth(endDate.getMonth() + 1)} ${endDate.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;
                            $(this).prev().html(ywString);
                            break;
                        case 7:
                            if (dayCode == 0) {
                                dayCode = 7;
                            }
                            if (dayCode == 1) {
                                dayCode = 8;
                            }
                            if (dayCode == 2) {
                                dayCode = 9;
                            }
                            if (dayCode == 3) {
                                dayCode = 10;
                            }
                            if (dayCode == 4) {
                                dayCode = 11;
                            }
                            if (dayCode == 5) {
                                dayCode = 12;
                            }
                            if (dayCode == 6) {
                                dayCode = 13;
                            }

                            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);

                            var dd = startDate.getDate();
                            var mm = startDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = startDate.getFullYear();
                            var newStartDate = mnth + ' ' + dd;

                            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 13);

                            var dd = endDate.getDate();
                            var mm = endDate.getMonth() + 1; //January is 0!
                            var mnth = getMnth(mm);
                            var yyyy = endDate.getFullYear();
                            var newEndDate = mnth + ' ' + dd;

                            var newdateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);
                            var weekNum = $.datepicker.iso8601Week(newdateObj);
                            //var ywString = '<span class="year">' + getMnth(endDate.getMonth() + 1) + ' ' + endDate.getFullYear() + '</span>' + '<span class="weekNo">Week ' + weekNum + '</span>';
                            var ywString = `<span class="year">${getMnth(endDate.getMonth() + 1)} ${endDate.getFullYear()}<span>&nbsp;&nbsp;&nbsp;</span></span><span class="weekNo">Week ${weekNum}</span>`;
                            $(this).prev().html(ywString);
                            break;
                    }

                    $(this).val(newStartDate + ' - ' + newEndDate);

                    $(this).attr("StartDate", startDate);
                    $(this).attr("EndDate", endDate);

                    selectCurrentWeek();
                    $(this).data('datepicker').inline = true;
                }
                else {
                    $(this).val(getMnth(new Date(datepickerValue).getMonth() + 1) + " " + new Date(datepickerValue).getDate());
                  //  $(this).attr("selecteddate", datepickerValue);
                    $(this).attr("selecteddate", newStartDate + " - " + newEndDate);
                }
                $(this).change();

            },
            onClose: function () {
                $(this).data('datepicker').inline = false;
            },
            beforeShow: function () {
                selectCurrentWeek();
            },
            beforeShowDay: function (datepickerValue) {
                var cssClass = '';
                if (datepickerValue >= startDate && datepickerValue <= endDate)
                    cssClass = 'ui-datepicker-current-day';
                selectCurrentWeek();
                return [true, cssClass];
            },
            onChangeMonthYear: function (year, month, inst) {
                selectCurrentWeek();
            }
        }).datepicker('widget').addClass('ui-weekpicker');

        //$(settingElement).datepicker('setDate', startDate);
        $('body').on('mousemove', '.ui-weekpicker .ui-datepicker-calendar tr', function () { $(this).find('td a').addClass('ui-state-hover'); });
        $('body').on('mouseleave', '.ui-weekpicker .ui-datepicker-calendar tr', function () { $(this).find('td a').removeClass('ui-state-hover'); });

    //$(settingElement).attr("StartDate", formatISODate(startDate));
    //$(settingElement).attr("EndDate", formatISODate(endDate));
    //$(settingElement).attr("selecteddate", newStartDate + " - " + newEndDate);
    //$(settingElement).val(newStartDate + " - " + newEndDate);
    if (IsDateChanged == "2") {
        $(settingElement).datepicker("destroy");
    }
};

$('#weekPicker2').click(function () {
    //debugger
    var text = $('#weekPicker2').val();
    $('#weekPicker2').datepicker('setDate', new Date(new Date($("#weekPicker2").attr("StartDate")).getFullYear(), new Date($("#weekPicker2").attr("StartDate")).getMonth(), new Date($("#weekPicker2").attr("StartDate")).getDate()));
    $('#weekPicker2').val(text);
    setTimeout(function () {
        $(".ui-datepicker-calendar").find("a").removeClass("ui-state-active");
        $('[data-month="' + new Date($("#weekPicker2").attr("StartDate")).getMonth() + '"][data-year="' + new Date($("#weekPicker2").attr("StartDate")).getFullYear() + '"]').find("a").each(function (idx, val) {
            if (new Date($("#weekPicker2").attr("StartDate")).getDate() == $(this).html()) {
                //  debugger;
                var activeElement = $(this);
                var tdElement = activeElement.parent();
                var trElement = tdElement.parent();
                trElement.find("a").each(function (idx, val) {
                    $(this).addClass("ui-state-active");
                })
                //tdElement.find("a").each(function (idx, val) {
                //    //console.log($(this));
                //    $(this).addClass("ui-state-highlight");
                //})
            }
        })
    }, 10)
    $(".ui-datepicker-prev").on("mouseover", function () {
        $(".ui-datepicker-prev").tooltip();
    });
    $(".ui-datepicker-next").on("mouseover", function () {
        $(".ui-datepicker-next").tooltip();
    });
    
});

// Helper function to format dates as "DD Mon"
function formatDate(date) {
    var dd = date.getDate();
    var mm = date.getMonth() + 1; // Months are 0-based
    var mnth = getMnth(mm);
    return `${dd < 10 ? "0" + dd : dd} ${mnth}`;
}

// Helper function to format dates in ISO (YYYY-MM-DD)
function formatISODate(date) {
    //debugger
    var dd = date.getDate();
    var mm = date.getMonth() + 1; // Months are 0-based
    var yyyy = date.getFullYear();
    return `${yyyy}-${mm < 10 ? "0" + mm : mm}-${dd < 10 ? "0" + dd : dd}`;
}

// Month name helper function
function getMnth(mm) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[mm - 1];
}


var convertToWeekPicker = function(targetElement) {
    if (targetElement.prop("tagName") == "INPUT" && (targetElement.attr("type") == "text" || targetElement.attr("type") == "hidden")) {
        var week = targetElement.val();
        $('<span class="displayDate DWnoumber">' + week + '</span>').insertBefore(targetElement);
        $('<i class="fa fa-calendar showCalendar" aria-hidden="true" style="cursor:pointer;margin-left: 10px;margin-top: 3px;" onclick="javascript:showWeekCalendar(this)"></i>').insertAfter(targetElement);
        setWeekCalendar(targetElement,"yes","2");
    } else {
        targetElement.replaceWith("<span>ERROR: please control js console</span>");
        console.error("convertToWeekPicker() - ERROR: The target element is not compatible with this conversion, try to use an <input type=\"text\" /> or an <input type=\"hidden\" />");
    }
};

$('#next').click(function(){
setWeekCalendar($('#weekPicker2'),'next');
});

$('#prev').click(function(){
 setWeekCalendar($('#weekPicker2'),'prev');
});


$('#dailyviewdatepicker').datepicker({ dateFormat: 'M dd' });
$("#dailyviewdatepicker").datepicker().datepicker('setDate', new Date());


$('.next-day').on("click", function () {
    //debugger
    var datepickerValue = $('#dailyviewdatepicker').datepicker('getDate'); 
    
    datepickerValue.setTime(datepickerValue.getTime() + (1000*60*60*24))
    $('#dailyviewdatepicker').datepicker("setDate", date);
});

$('.prev-day').on("click", function () {
    //debugger
    var datepickerValue = $('#dailyviewdatepicker').datepicker('getDate');
    datepickerValue.setTime(datepickerValue.getTime() - (1000*60*60*24))
    $('#dailyviewdatepicker').datepicker("setDate", date);
});

$("#dailyviewdatepicker").datepicker({
	//showWeekNumber: true,
 //$('#dailyviewdatepicker').val($.datepicker.iso8601Week(new Date(dateText)));
});

convertToWeekPicker($("#weekPicker2, #dailyviewdatepicker"))

function getMnth(mm) {
    switch(mm) {
        case 1:
            return("Jan");
            break;
        case 2:
            return("Feb");
            break;
        case 3:
            return("Mar");
            break;
        case 4:
            return("Apr");
            break;
        case 5:
            return("May");
            break;
        case 6:
            return("Jun");
            break;
        case 7:
            return("Jul");
            break;
        case 8:
            return("Aug");
            break;
        case 9:
            return("Sep");
            break;
        case 10:
            return("Oct");
            break;
        case 11:
            return("Nov");
            break;
        case 12:
            return("Dec");
            break;
    }
}

$('#dailyviewdatepicker').datepicker({
    onSelect: function (dateText, inst) {
        $('.weekNo').val($.datepicker.iso8601Week(new Date(dateText)));
    }
});




  
 

