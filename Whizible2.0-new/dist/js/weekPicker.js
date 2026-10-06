/*jshint esversion: 6 */

var globalTriggeringElement;
var startDate;
var endDate;
var globalAdditionalFunction = function () { };
var isWeeklyView;
var startingDayOfWeek;
//debugger;
var getDateFromISOWeek = function (ywString, separator) {
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
//Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed
function getstartdate(startingDayOfWeek, dayCode, datepickerValue) {
    switch (startingDayOfWeek) {
        case 1:
            if (dayCode == 0) {
                dayCode = 7;
            }

            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 1);
                     
            break;
        case 2:
            if (dayCode == 0) {
                dayCode = 7;
            }
            if (dayCode == 1) {
                dayCode = 8;
            }

            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 2);
                       
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
                        
            break;
    }
    return startDate;
}
//End Of Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed
var showWeekCalendar = function (triggeringElement, additionalFunction) {
   // debugger;
    globalTriggeringElement = triggeringElement;
    globalAdditionalFunction = additionalFunction;
    var prevItem = $(triggeringElement).prev();
    var weekValue = prevItem.val();

    prevItem.datepicker("option", "defaultDate", getDateFromISOWeek(weekValue, '-'));
    prevItem.val(weekValue);
    prevItem.datepicker("show");

    if (isWeeklyView == 1) {
        var text = $('#weekPicker2').val();
        $('#weekPicker2').datepicker('setDate', new Date(new Date($("#weekPicker2").attr("StartDate")).getFullYear(), new Date($("#weekPicker2").attr("StartDate")).getMonth(), new Date($("#weekPicker2").attr("StartDate")).getDate()));
        $('#weekPicker2').val(text);
        setTimeout(function () {
            //debugger;
            $(".ui-datepicker-calendar").find("a").removeClass("ui-state-active");
            $('[data-month="' + new Date($("#weekPicker2").attr("StartDate")).getMonth() + '"][data-year="' + new Date($("#weekPicker2").attr("StartDate")).getFullYear() + '"]').find("a").each(function (idx, val) {
                if (new Date($("#weekPicker2").attr("StartDate")).getDate() == $(this).html()) {
                   // debugger;
                    var activeElement = $(this);
                    var tdElement = activeElement.parent();
                    var trElement = tdElement.parent();
                    trElement.find("a").each(function (idx, val) {
                      //  debugger;
                        $(this).addClass("ui-state-active");
                    })
                }
            })
        }, 10)
        $(".ui-datepicker-prev").on("mouseover", function () {
            $(".ui-datepicker-prev").tooltip();
        });
        $(".ui-datepicker-next").on("mouseover", function () {
            $(".ui-datepicker-next").tooltip();
        });
    }
    else {
        var text = $('#dailyviewdatepicker').val();
        $('#dailyviewdatepicker').datepicker('setDate', new Date(new Date($("#dailyviewdatepicker").attr("selecteddate")).getFullYear(), new Date($("#dailyviewdatepicker").attr("selecteddate")).getMonth(), new Date($("#dailyviewdatepicker").attr("selecteddate")).getDate()));
        $('#dailyviewdatepicker').val(text);
        setTimeout(function () {
            $(".ui-datepicker-calendar").find("a").removeClass("ui-state-active");
           // debugger;
            $('[data-month="' + new Date($("#dailyviewdatepicker").attr("selecteddate")).getMonth() + '"][data-year="' + new Date($("#dailyviewdatepicker").attr("selecteddate")).getFullYear() + '"]').find("a").each(function (idx, val) {
                if (new Date($("#dailyviewdatepicker").attr("selecteddate")).getDate() == $(this).html()) {

                    var activeElement = $(this);
                    var tdElement = activeElement.parent();
                    var trElement = tdElement.parent();

                    trElement.find("a").each(function (idx, val) {
                        //console.log($(this));
                        $(this).addClass("ui-state-active");
                    })
                }
            })
            $(".ui-datepicker-prev").on("mouseover", function () {
                $(".ui-datepicker-prev").tooltip();
            });
            $(".ui-datepicker-next").on("mouseover", function () {
                $(".ui-datepicker-next").tooltip();
            });
        }, 10)
    }
};

var setWeekCalendar = function (settingElement, def, isWeek, StartingDayOfWeek, FinancialYearStart, SelectedDate, TodaysDate) {
    //if (SelectedDate !="") {
    //    SelectedDate = new Date(SelectedDate).toISOString();
    //}
     
    isWeek = isWeeklyView;

    var selectCurrentWeek = function () {

        window.setTimeout(function () {
            //debugger;
            var activeElement = $("#ui-datepicker-div .ui-state-active");
            var tdElement = activeElement.parent();
            var trElement = tdElement.parent();

            trElement.find("a").addClass("ui-state-active")
            
        }, 1);
    };
    
    if (def == 'yes') {

        //$(settingElement).datepicker('setDate', 'today');
        var date = new Date(TodaysDate);
        $(settingElement).datepicker('setDate', date);

        var datepickerValue = $(settingElement).datepicker('getDate');
        var weekCode = datepickerValue.getDay();
        var dayCode = datepickerValue.getDay();
        var dateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - StartingDayOfWeek);
        var weekNum = $.datepicker.iso8601Week(dateObj);
        //alert("datepickerValue " + datepickerValue + " " + datepickerValue + "  dateObj " + dateObj + " weekNum " + weekNum + " StartingDayOfWeek " + StartingDayOfWeek);
        //alert(isWeek);
        //alert(datepickerValue);
        //alert(dateObj);
        //alert(weekNum);
       
        //if (weekCode < 4) {
        //    weekNum = weekNum - 1;
        //}
        //if (weekNum < 10) {
        //    weekNum = "0" + weekNum;
        //}
      
        
        if (isWeek == 1) {
            //Commented and Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the dates with respect to starting day
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
                   
                    var weekNum = $.datepicker.iso8601Week(startDate);
                   
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var weekNum = $.datepicker.iso8601Week(startDate);
                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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

                    var weekNum = $.datepicker.iso8601Week(startDate);

                    
                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    //alert("dayCode " + dayCode + " total " + (dayCode + 3));
                    var dd = startDate.getDate();
                    var mm = startDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = startDate.getFullYear();
                    var newStartDate = mnth + ' ' + dd;
                   
                    var weekNum = $.datepicker.iso8601Week(startDate);
                   
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 9);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;
                  
                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 10);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var weekNum = $.datepicker.iso8601Week(startDate);
                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 11);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var weekNum = $.datepicker.iso8601Week(startDate);
                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 12);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var weekNum = $.datepicker.iso8601Week(startDate);
                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 13);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var weekNum = $.datepicker.iso8601Week(startDate);
                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
                    break;
            }

            //if (weekCode < 4) {

            //    startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() - 3);

            //    var dd = startDate.getDate();
            //    var mm = startDate.getMonth() + 1; //January is 0!
            //    var mnth = getMnth(mm);
            //    var yyyy = startDate.getFullYear();
            //    var newStartDate = mnth + ' ' + dd;

            //    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 3);

            //    var dd = endDate.getDate();
            //    var mm = endDate.getMonth() + 1; //January is 0!
            //    var mnth = getMnth(mm);
            //    var yyyy = endDate.getFullYear();
            //    var newEndDate = mnth + ' ' + dd;

            //} else {
            //    startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 4);

            //    var dd = startDate.getDate();
            //    var mm = startDate.getMonth() + 1; //January is 0!
            //    var mnth = getMnth(mm);
            //    var yyyy = startDate.getFullYear();
            //    var newStartDate = mnth + ' ' + dd;

            //    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 10);

            //    var dd = endDate.getDate();
            //    var mm = endDate.getMonth() + 1; //January is 0!
            //    var mnth = getMnth(mm);
            //    var yyyy = endDate.getFullYear();
            //    var newEndDate = mnth + ' ' + dd;

            //}


            // startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 4 );
            // var dd = startDate.getDate();
            // var mm = startDate.getMonth()+1; //January is 0!
            // var yyyy = startDate.getFullYear();
            // var newStartDate = mm+'/'+dd+'/'+yyyy;    

            // endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 10);

            //  var dd = endDate.getDate();
            // var mm = endDate.getMonth()+1; //January is 0!
            // var yyyy = endDate.getFullYear();
            // var newEndDate = mm+'/'+dd+'/'+yyyy;    
            //End of Commented and Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the dates with respect to starting day

            $(settingElement).val(newStartDate + ' - ' + newEndDate);

            //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
            //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
            //var sd = new Date(startDate);
            //if (sd > fiscalStart) {
            //    var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
            //} else {
            //    var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
            //}
            //var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + week_no + '</span>';

            //$(settingElement).prev().html(ywString);
            //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year

            selectCurrentWeek();
            //$(settingElement).data('datepicker').inline = true;
            //globalAdditionalFunction(globalTriggeringElement);
            // alert(datepickerValue);
        }
        else {
            
            $(settingElement).val(getMnth(new Date(datepickerValue).getMonth() + 1) + " " + new Date(datepickerValue).getDate());
            $(settingElement).attr("selecteddate", datepickerValue);
            //  alert(datepickerValue);
            //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
            //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
            //var sd = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
            //if (sd > fiscalStart) {
            //    var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
            //} else {
            //    var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
            //}
            //Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed
            try {
                dateObj = getstartdate(startingDayOfWeek, dayCode, datepickerValue);
                weekNum = $.datepicker.iso8601Week(dateObj);
                //alert(startingDayOfWeek);
                //alert(weekNum);
            }
            catch (ex) {
                //alert(ex.message);
            }
            //End Of Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed
            var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';

            $(settingElement).prev().html(ywString);
            //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
        }

    }


    if (def == 'Selected') {
        //debugger;
        
        var date = new Date(SelectedDate.toISOString());

        //Added By Nikhil  on  17-Feb-2021 for Timeshzone issue fixing
        let intlDateObj = new Intl.DateTimeFormat('en-US', {
            timeZone: "Asia/Kolkata"
        }); 

        date = intlDateObj.format(date);
        //End of added By Nikhil A 
        $(settingElement).datepicker('setDate', date);

        var datepickerValue = $(settingElement).datepicker('getDate');
        var weekCode = datepickerValue.getDay();
        var dayCode = datepickerValue.getDay();
        var dateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
        var weekNum = $.datepicker.iso8601Week(dateObj);
        //if (weekCode < 4) {
        //    weekNum = weekNum - 1;
        //}
        //if (weekNum < 10) {
        //    weekNum = "0" + weekNum;
        //}
        
       
        
        if (isWeek == 1) {
            //switch (startingDayOfWeek) {
                //case 1:
                    if (dayCode == 0) {
                        dayCode = 7;
                    }

                 //   startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 1);
            startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
                    var dd = startDate.getDate();
                    var mm = startDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = startDate.getFullYear();
                    var newStartDate = mnth + ' ' + dd;

               //     endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);
            endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() + 6);
                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
            //        break;
            //    case 2:
            //        if (dayCode == 0) {
            //            dayCode = 7;
            //        }
            //        if (dayCode == 1) {
            //            dayCode = 8;
            //        }

            //        startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 2);

            //        var dd = startDate.getDate();
            //        var mm = startDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = startDate.getFullYear();
            //        var newStartDate = mnth + ' ' + dd;

            //        endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 8);

            //        var dd = endDate.getDate();
            //        var mm = endDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = endDate.getFullYear();
            //        var newEndDate = mnth + ' ' + dd;

            //        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
            //        $(settingElement).prev().html(ywString);
            //        break;
            //    case 3:
            //        if (dayCode == 0) {
            //            dayCode = 7;
            //        }
            //        if (dayCode == 1) {
            //            dayCode = 8;
            //        }
            //        if (dayCode == 2) {
            //            dayCode = 9;
            //        }

            //        startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 3);

            //        var dd = startDate.getDate();
            //        var mm = startDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = startDate.getFullYear();
            //        var newStartDate = mnth + ' ' + dd;

            //        endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 9);

            //        var dd = endDate.getDate();
            //        var mm = endDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = endDate.getFullYear();
            //        var newEndDate = mnth + ' ' + dd;

            //        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
            //        $(settingElement).prev().html(ywString);
            //        break;
            //    case 4:
            //        if (dayCode == 0) {
            //            dayCode = 7;
            //        }
            //        if (dayCode == 1) {
            //            dayCode = 8;
            //        }
            //        if (dayCode == 2) {
            //            dayCode = 9;
            //        }
            //        if (dayCode == 3) {
            //            dayCode = 10;
            //        }

            //        startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 4);

            //        var dd = startDate.getDate();
            //        var mm = startDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = startDate.getFullYear();
            //        var newStartDate = mnth + ' ' + dd;

            //        endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 10);

            //        var dd = endDate.getDate();
            //        var mm = endDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = endDate.getFullYear();
            //        var newEndDate = mnth + ' ' + dd;

            //        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
            //        $(settingElement).prev().html(ywString);
            //        break;
            //    case 5:
            //        if (dayCode == 0) {
            //            dayCode = 7;
            //        }
            //        if (dayCode == 1) {
            //            dayCode = 8;
            //        }
            //        if (dayCode == 2) {
            //            dayCode = 9;
            //        }
            //        if (dayCode == 3) {
            //            dayCode = 10;
            //        }
            //        if (dayCode == 4) {
            //            dayCode = 11;
            //        }

            //        startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 5);

            //        var dd = startDate.getDate();
            //        var mm = startDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = startDate.getFullYear();
            //        var newStartDate = mnth + ' ' + dd;

            //        endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 11);

            //        var dd = endDate.getDate();
            //        var mm = endDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = endDate.getFullYear();
            //        var newEndDate = mnth + ' ' + dd;

            //        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
            //        $(settingElement).prev().html(ywString);
            //        break;
            //    case 6:
            //        if (dayCode == 0) {
            //            dayCode = 7;
            //        }
            //        if (dayCode == 1) {
            //            dayCode = 8;
            //        }
            //        if (dayCode == 2) {
            //            dayCode = 9;
            //        }
            //        if (dayCode == 3) {
            //            dayCode = 10;
            //        }
            //        if (dayCode == 4) {
            //            dayCode = 11;
            //        }
            //        if (dayCode == 5) {
            //            dayCode = 12;
            //        }

            //        startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 6);

            //        var dd = startDate.getDate();
            //        var mm = startDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = startDate.getFullYear();
            //        var newStartDate = mnth + ' ' + dd;

            //        endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 12);

            //        var dd = endDate.getDate();
            //        var mm = endDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = endDate.getFullYear();
            //        var newEndDate = mnth + ' ' + dd;

            //        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
            //        $(settingElement).prev().html(ywString);
            //        break;
            //    case 7:
            //        if (dayCode == 0) {
            //            dayCode = 7;
            //        }
            //        if (dayCode == 1) {
            //            dayCode = 8;
            //        }
            //        if (dayCode == 2) {
            //            dayCode = 9;
            //        }
            //        if (dayCode == 3) {
            //            dayCode = 10;
            //        }
            //        if (dayCode == 4) {
            //            dayCode = 11;
            //        }
            //        if (dayCode == 5) {
            //            dayCode = 12;
            //        }
            //        if (dayCode == 6) {
            //            dayCode = 13;
            //        }

            //        startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);

            //        var dd = startDate.getDate();
            //        var mm = startDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = startDate.getFullYear();
            //        var newStartDate = mnth + ' ' + dd;

            //        endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 13);

            //        var dd = endDate.getDate();
            //        var mm = endDate.getMonth() + 1; //January is 0!
            //        var mnth = getMnth(mm);
            //        var yyyy = endDate.getFullYear();
            //        var newEndDate = mnth + ' ' + dd;

            //        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';
            //        $(settingElement).prev().html(ywString);

            //        break;
            //}

            $(settingElement).val(newStartDate + ' - ' + newEndDate);

            selectCurrentWeek();
        }
        else {
            $(settingElement).val(getMnth(new Date(datepickerValue).getMonth() + 1) + " " + new Date(datepickerValue).getDate());
            $(settingElement).attr("selecteddate", datepickerValue);


        }

    }

    if (def == 'next') {
        var date = new Date($(settingElement).attr("StartDate"));
        if (isWeek == 1) {
            date = new Date($(settingElement).attr("StartDate"));
            var EndDate = new Date(endDate);
            EndDate.setDate(EndDate.getDate() + 1);
            var d = EndDate.getDate();
            var m = EndDate.getMonth();
            var y = EndDate.getFullYear();
            date = new Date(y, m, d);
        }
        else {
            date = new Date($(settingElement).attr("selecteddate"));
            date.setDate(date.getDate() + 1);
        }

        $(settingElement).datepicker('setDate', date);

        var datepickerValue = $(settingElement).datepicker('getDate');
        var dayCode = datepickerValue.getDay();
        var dateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
        var weekNum = $.datepicker.iso8601Week(dateObj);
        //if (weekNum < 10) {
        //    weekNum = "0" + weekNum;
        //}

        

       
        if (isWeek == 1) {
            //startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 4);
            //var dd = startDate.getDate();
            //var mm = startDate.getMonth() + 1; //January is 0!
            //var mnth = getMnth(mm);
            //var yyyy = startDate.getFullYear();
            //var newStartDate = mnth + ' ' + dd;

            //endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 10);

            //var dd = endDate.getDate();
            //var mm = endDate.getMonth() + 1; //January is 0!
            //var mnth = getMnth(mm);
            //var yyyy = endDate.getFullYear();
            //var newEndDate = mnth + ' ' + dd;
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 8);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 9);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
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

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
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

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 12);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 13);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
                    break;
            }

            $(settingElement).val(newStartDate + ' - ' + newEndDate);

            //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
            //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
            //var sd = new Date(startDate);
            //if (sd > fiscalStart) {
            //    var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
            //} else {
            //    var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
            //}
            //var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + week_no + '</span>';

            //$(settingElement).prev().html(ywString);
            //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year

            selectCurrentWeek();
        }
        else {
            
            $(settingElement).val(getMnth(new Date(datepickerValue).getMonth() + 1) + " " + new Date(datepickerValue).getDate());
            $(settingElement).attr("selecteddate", datepickerValue);

            //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
            //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
            //var sd = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
            //if (sd > fiscalStart) {
            //    var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
            //} else {
            //    var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
            //}

            //Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed
            try {
                dateObj = getstartdate(startingDayOfWeek, dayCode, datepickerValue);
                weekNum = $.datepicker.iso8601Week(dateObj);
                //alert(startingDayOfWeek);
                //alert(weekNum);
            }
            catch (ex) {
                //alert(ex.message);
            }          
            //End Of Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed
            var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';

            $(settingElement).prev().html(ywString);
            //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
        }

    }

    if (def == 'prev') {

        var date = new Date($(settingElement).attr("StartDate"));
        if (isWeek == 1) {
            var StartDate = new Date(startDate);
            StartDate.setDate(startDate.getDate() - 7);
            var d = StartDate.getDate();
            var m = StartDate.getMonth();
            var y = StartDate.getFullYear();
            date = new Date(y, m, d);
        }
        else {
            date = new Date($(settingElement).attr("selecteddate"));
            date.setDate(date.getDate() - 1);
        }
        $(settingElement).datepicker('setDate', date);

        var datepickerValue = $(settingElement).datepicker('getDate');
        var dayCode = datepickerValue.getDay();
        var dateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
        var weekNum = $.datepicker.iso8601Week(dateObj);
        //if (weekNum < 10) {
        //    weekNum = "0" + weekNum;
        //}

        

        
        if (isWeek == 1) {
            //startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 4);
            //var dd = startDate.getDate();
            //var mm = startDate.getMonth() + 1; //January is 0!
            //var mnth = getMnth(mm);
            //var yyyy = startDate.getFullYear();
            //var newStartDate = mnth + ' ' + dd;

            //endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 10);

            //var dd = endDate.getDate();
            //var mm = endDate.getMonth() + 1; //January is 0!
            //var mnth = getMnth(mm);
            //var yyyy = endDate.getFullYear();
            //var newEndDate = mnth + ' ' + dd;
            //alert(startingDayOfWeek);
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

                   
                    var weekNum = $.datepicker.iso8601Week(startDate);
                  
                  
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 7);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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

                   
                    var weekNum = $.datepicker.iso8601Week(startDate);
                    
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 8);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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

                   
                    var weekNum = $.datepicker.iso8601Week(startDate);
                   
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 9);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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

                   
                    var weekNum = $.datepicker.iso8601Week(startDate);
                   
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 10);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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

                    
                    var weekNum = $.datepicker.iso8601Week(startDate);
                   
                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 11);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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

                   
                    var weekNum = $.datepicker.iso8601Week(startDate);                   

                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 12);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);
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

                    
                    var weekNum = $.datepicker.iso8601Week(startDate);                    

                    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - dayCode + 13);

                    var dd = endDate.getDate();
                    var mm = endDate.getMonth() + 1; //January is 0!
                    var mnth = getMnth(mm);
                    var yyyy = endDate.getFullYear();
                    var newEndDate = mnth + ' ' + dd;

                    var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                    $(settingElement).prev().html(ywString);

                    break;
            }

            $(settingElement).val(newStartDate + ' - ' + newEndDate);

            //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
            //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
            //var sd = new Date(startDate);
            //if (sd > fiscalStart) {
            //    var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
            //} else {
            //    var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
            //}
            //var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + week_no + '</span>';

            //$(settingElement).prev().html(ywString);
            //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year

            selectCurrentWeek();
        }
        else {
            $(settingElement).val(getMnth(new Date(datepickerValue).getMonth() + 1) + " " + new Date(datepickerValue).getDate());
            $(settingElement).attr("selecteddate", datepickerValue);

            //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
            //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
            //var sd = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
            //if (sd > fiscalStart) {
            //    var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
            //} else {
            //    var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
            //}

            //Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed
            try {
                dateObj = getstartdate(startingDayOfWeek, dayCode, datepickerValue);
                weekNum = $.datepicker.iso8601Week(dateObj);
                //alert(startingDayOfWeek);
                //alert(weekNum);
            }
            catch (ex) {
                //alert(ex.message);
            }        
            //End Of Added by Usha Pandit On 07.08.2019 For getting correct Week number if startingDayOfWeek is changed

            var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + weekNum + '</span>';

            $(settingElement).prev().html(ywString);
            //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
        }

    }

    $(settingElement).datepicker({
        showOtherMonths: true,
        selectOtherMonths: true,
        showWeek: false,
        firstDay: startingDayOfWeek,

        onSelect: function (dateText, inst) {

            isWeek = isWeeklyView;

            var datepickerValue = $(this).datepicker('getDate');

            var weekCode = datepickerValue.getDay();
            var dayCode = datepickerValue.getDay();
            var dateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
            var weekNum = $.datepicker.iso8601Week(dateObj);
            //if (weekCode < 4) {
            //    weekNum = weekNum - 1;
            //}
            //if (weekNum < 10) {
            //    weekNum = "0" + weekNum;
            //}

            var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
            $(this).prev().html(ywString);
            if (isWeek == 1) {
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
                        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
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
                        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
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
                        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
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
                        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
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
                        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
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
                        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
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
                        var ywString = '<span class="year">' + endDate.getFullYear() + '</span>' + '<span class"weekNo"> Week ' + weekNum + '</span>';
                        $(this).prev().html(ywString);
                        break;
                }
                //if (weekCode < 4) {

                //    startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 1);

                //    var dd = startDate.getDate();
                //    var mm = startDate.getMonth() + 1; //January is 0!
                //    var mnth = getMnth(mm);
                //    var yyyy = startDate.getFullYear();
                //    var newStartDate = mnth + ' ' + dd;

                //    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 7);

                //    var dd = endDate.getDate();
                //    var mm = endDate.getMonth() + 1; //January is 0!
                //    var mnth = getMnth(mm);
                //    var yyyy = endDate.getFullYear();
                //    var newEndDate = mnth + ' ' + dd;

                //} else {
                //    startDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 4);
                //    var dd = startDate.getDate();
                //    var mm = startDate.getMonth() + 1; //January is 0!
                //    var mnth = getMnth(mm);
                //    var yyyy = startDate.getFullYear();
                //    var newStartDate = mnth + ' ' + dd;

                //    endDate = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate() - datepickerValue.getDay() + 10);

                //    var dd = endDate.getDate();
                //    var mm = endDate.getMonth() + 1; //January is 0!
                //    var mnth = getMnth(mm);
                //    var yyyy = endDate.getFullYear();
                //    var newEndDate = mnth + ' ' + dd;

                //}

                $(this).val(newStartDate + ' - ' + newEndDate);

                $(this).attr("StartDate", startDate);
                $(this).attr("EndDate", endDate);

                //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
                //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
                //var sd = new Date(startDate);
                //if (sd > fiscalStart) {
                //    if (getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) < 0)
                //        var week_no = 52 - (getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()));
                //    else
                //        var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
                //} else {
                //    if ((getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate())) < 0)
                //        var week_no = -1 * (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
                //    else
                //        var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
                //}
                //var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + week_no + '</span>';

                //$(settingElement).prev().html(ywString);
                //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year

                selectCurrentWeek();
                $(this).data('datepicker').inline = true;
            }
            else {
                $(this).val(getMnth(new Date(datepickerValue).getMonth() + 1) + " " + new Date(datepickerValue).getDate());
                $(this).attr("selecteddate", datepickerValue);

                //Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
                //var fiscalStart = new Date(FinancialYearStart); //Fiscal year start date
                //var sd = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
                //if (sd > fiscalStart) {
                //    var week_no = getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()) - getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate());
                //} else {
                //    var week_no = 52 - (getWeek(y2k(fiscalStart.getYear()), fiscalStart.getMonth(), fiscalStart.getDate()) - getWeek(y2k(sd.getYear()), sd.getMonth(), sd.getDate()));
                //}
                //var ywString = '<span class="year">' + datepickerValue.getFullYear() + '</span>' + '<span class="weekNo"> Week ' + week_no + '</span>';

                //$(settingElement).prev().html(ywString);
                //End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
                //$(this).focusout();
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

    $('body').on('mousemove', '.ui-weekpicker .ui-datepicker-calendar tr', function () { $(this).find('td a').addClass('ui-state-hover'); });
    $('body').on('mouseleave', '.ui-weekpicker .ui-datepicker-calendar tr', function () { $(this).find('td a').removeClass('ui-state-hover'); });

    $(settingElement).attr("StartDate", startDate);
    $(settingElement).attr("EndDate", endDate);
    $(settingElement).attr("selecteddate", datepickerValue);
    //$(settingElement).focus();
    // function for doing something more
    //debugger;
    // $("#ui-datepicker-div").find(".ui-datepicker-next").click(); 


};

$('#weekPicker2').click(function () {
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
})
$('#dailyviewdatepicker').click(function () {
    var text = $('#dailyviewdatepicker').val();
    $('#dailyviewdatepicker').datepicker('setDate', new Date(new Date($("#dailyviewdatepicker").attr("selecteddate")).getFullYear(), new Date($("#dailyviewdatepicker").attr("selecteddate")).getMonth(), new Date($("#dailyviewdatepicker").attr("selecteddate")).getDate()));
    $('#dailyviewdatepicker').val(text);
    setTimeout(function () {
        $(".ui-datepicker-calendar").find("a").removeClass("ui-state-active");

        $('[data-month="' + new Date($("#dailyviewdatepicker").attr("selecteddate")).getMonth() + '"][data-year="' + new Date($("#dailyviewdatepicker").attr("selecteddate")).getFullYear() + '"]').find("a").each(function (idx, val) {
            if (new Date($("#dailyviewdatepicker").attr("selecteddate")).getDate() == $(this).html()) {

                var activeElement = $(this);
                var tdElement = activeElement.parent();
                var trElement = tdElement.parent();

                trElement.find("a").each(function (idx, val) {
                    //console.log($(this));
                    $(this).addClass("ui-state-active");
                })
                //tdElement.find("a").each(function (idx, val) {
                //    //console.log($(this));
                //    $(this).addClass("ui-state-highlight");
                //})
            }
        })
        $(".ui-datepicker-prev").on("mouseover", function () {
            $(".ui-datepicker-prev").tooltip();
        });
        $(".ui-datepicker-next").on("mouseover", function () {
            $(".ui-datepicker-next").tooltip();
        });
    }, 10)
})

var convertToWeekPicker = function (targetElement) {   
    //debugger;
    //targetElement[0].tagName == "INPUT"
    if (targetElement.prop("tagName") == "INPUT" && (targetElement.attr("type") == "text" || targetElement.attr("type") == "hidden")) {
        var week = targetElement.val();
        $('<span class="displayDate DWnoumber" title="Calendar Week" data-placement="bottom" data-toggle="tooltip">' + week + '</span>').insertBefore(targetElement);
        $('<i class="fa fa-calendar showCalendar" aria-hidden="true" style="cursor:pointer;margin-left: 10px;margin-top: 3px;" onclick="javascript:showWeekCalendar(this)"></i>').insertAfter(targetElement);
        setWeekCalendar(targetElement);


    } else {
        targetElement.replaceWith("<span>ERROR: please control js console</span>");
        console.error("convertToWeekPicker() - ERROR: The target element is not compatible with this conversion, try to use an <input type=\"text\" /> or an <input type=\"hidden\" />");
    }


    //$("#ui-datepicker-div .ui-datepicker-prev").click(function () {
    //    alert('C');
    //});
};


//$('#next').click(function () {
//    setWeekCalendar($('#weekPicker2'), 'next');
//});

//$('#prev').click(function () {
//    setWeekCalendar($('#weekPicker2'), 'prev');
//});

//$(document).ready(function () {

//    setWeekCalendar($('#weekPicker2'), 'yes');
//    setWeekCalendar($('#dailyviewdatepicker'), 'yes');
//});



//dailyviewdatepicker

//$('#dailyviewdatepicker').datepicker({ dateFormat: 'M dd' });
//$("#dailyviewdatepicker").datepicker().datepicker('setDate', new Date());

//$('.next-day').on("click", function () {
//    var datepickerValue = $('#dailyviewdatepicker').datepicker('getDate');

//    datepickerValue.setTime(datepickerValue.getTime() + (1000 * 60 * 60 * 24))
//    $('#dailyviewdatepicker').datepicker("setDate", datepickerValue);
//    $('#dailyviewdatepicker').attr("SelectedDate", datepickerValue);
//});

//$('.prev-day').on("click", function () {
//    var datepickerValue = $('#dailyviewdatepicker').datepicker('getDate');
//    datepickerValue.setTime(datepickerValue.getTime() - (1000 * 60 * 60 * 24))
//    $('#dailyviewdatepicker').datepicker("setDate", datepickerValue);
//    $('#dailyviewdatepicker').attr("SelectedDate", datepickerValue);
//});

//$("#dailyviewdatepicker").datepicker({
//    //showWeekNumber: true,
//    //$('#dailyviewdatepicker').val($.datepicker.iso8601Week(new Date(dateText)));
//});





convertToWeekPicker($("#weekPicker2, #dailyviewdatepicker"))

function getMnth(mm) {
    switch (mm) {
        case 1:
            return ("Jan");
            break;
        case 2:
            return ("Feb");
            break;
        case 3:
            return ("Mar");
            break;
        case 4:
            return ("Apr");
            break;
        case 5:
            return ("May");
            break;
        case 6:
            return ("Jun");
            break;
        case 7:
            return ("Jul");
            break;
        case 8:
            return ("Aug");
            break;
        case 9:
            return ("Sep");
            break;
        case 10:
            return ("Oct");
            break;
        case 11:
            return ("Nov");
            break;
        case 12:
            return ("Dec");
            break;
    }
}
//Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year
function y2k(number) { return (number < 1000) ? number + 1900 : number; }

function getWeek(year, month, day) {
    var when = new Date(year, month, day);
    var newYear = new Date(year, 0, 1);
    var modDay = newYear.getDay();
    if (modDay == 0) modDay = 6; else modDay--;

    var daynum = ((Date.UTC(y2k(year), when.getMonth(), when.getDate(), 0, 0, 0) - Date.UTC(y2k(year), 0, 1, 0, 0, 0)) / 1000 / 60 / 60 / 24) + 1;

    if (modDay < 4) {
        var weeknum = Math.floor((daynum + modDay - 1) / 7) + 1;
    } else {
        var weeknum = Math.floor((daynum + modDay - 1) / 7);
        if (weeknum == 0) {
            year--;
            var prevNewYear = new Date(year, 0, 1);
            var prevmodDay = prevNewYear.getDay();
            if (prevmodDay == 0) prevmodDay = 6; else prevmodDay--;
            if (prevmodDay < 4) weeknum = 53; else weeknum = 52;
        }
    }

    return + weeknum;
}
//End of Added By Aniruddh Gujar on 15-Nov-2018 Purpose::To get the week number through financial Year

//$('#dailyviewdatepicker').datepicker({
//    dateFormat: 'M dd',
//    onSelect: function (dateText, inst) {
//        $('.weekNo').val($.datepicker.iso8601Week(new Date(dateText)));
//        $('#dailyviewdatepicker').attr("SelectedDate", dateText);
//    }
//}).datepicker('setDate', new Date());







