/// <reference path="../../Backup/General/Calendar.aspx" />

$(document).ready(function () {
    var html = '';
    var EmployeeID = 0;
    var TaskHour = 0;0 
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
    var z;
 // timeShit();
    getCurrentWeek();
    
    $("HTML").append("<div id='preloader'></div>");
    $("HTML").append("<div id='fillDiv'></div>");
    //$("#txtHours").parent().css("width", "87%");
    //$("#BtnSaveUpdate").css("width", "86%");
    // $("#DivCustomTimeSheet").css("margin-top", "106px");
   fillYears();
   populateTable(document.dateChooser);
   
  
});


function getFirstDay(theYear, theMonth) {
    var firstDate = new Date(theYear, theMonth, 1)
    return firstDate.getDay()
   
}
// number of days in the month
function getMonthLen(theYear, theMonth) {
    var oneDay = 1000 * 60 * 60 * 24
    var thisMonth = new Date(theYear, theMonth, 1)
    var nextMonth = new Date(theYear, theMonth + 1, 1)
    var len = Math.ceil((nextMonth.getTime() -
        thisMonth.getTime()) / oneDay)
    return len
}
// create array of English month names
var theMonths = ["January", "February", "March", "April", "May", "June", "July", "August",
"September", "October", "November", "December"]
// return IE4+ or W3C DOM reference for an ID
function getObject(obj) {
    var theObj
    if (document.all) {
        if (typeof obj == "string") {
            return document.all(obj)
        } else {
            return obj.style
        }
    }
    if (document.getElementById) {
        if (typeof obj == "string") {
            return document.getElementById(obj)
        } else {
            return obj.style
        }
    }
    return null
}


// added by tejal deshmukh
/************************
DRAW CALENDAR CONTENTS
*************************/
// clear and re-populate table based on form's selections
function populateTable(form) {

    var theMonth = document.getElementById("sel").selectedIndex
   
    var theYear = parseInt(document.getElementById("sel2").options[document.getElementById("sel2").selectedIndex].text)
    
   

  
    // initialize date-dependent variables
    var firstDay = getFirstDay(theYear, theMonth)
    var howMany = getMonthLen(theYear, theMonth)

  
    // fill in month/year in table header
    getObject("tableHeader").innerHTML = theMonths[theMonth] +
    " " + theYear
     
    // initialize vars for table creation
    var dayCounter = 1
    var TBody = getObject("tableBody");
    // clear any existing rows
    while (TBody.rows.length > 0) {
        TBody.deleteRow(0)
    }
    var newR, newC;
    var done = false
    while (!done) {
        // create new row at end
        newR = TBody.insertRow(TBody.rows.length)
        for (var i = 0; i < 7; i++) {
            // create new cell at end of row
            newC = newR.insertCell(newR.cells.length)
            if (TBody.rows.length == 1 && i < firstDay) {
                // no content for boxes before first day
                newC.innerHTML = ""
                continue
            }
            if (dayCounter == howMany) {
                // no more rows after this one
                done = true

            }
            // plug in date (or empty for boxes after last day)
            newC.id = dayCounter;
            newC.innerHTML = (dayCounter <= howMany) ?
                dayCounter++ : ""
            // newC.onclick = function () { alert(dayCounter); }
       
           

           
        }
        
       
    }
    
 //jQuery(document).ready(function () {
    //    $.ajax({
    //        type: "POST",
    //        url: "PM_dailyActivityMobile.aspx/DayChek",
    //        contentType: "application/json;charset=utf-8",
    //        dataType: "json",
    //        success: function (data) {
    //    GetCountryDetails(data.d[0],data.d[1]);
    //       // var W = (data.d[1]);
        
    //        }
            

    //    });

        
    //});

}

   
/*******************
  INITIALIZATIONS
********************/
// create dynamic list of year choices
function fillYears() {
    var start = 1900;
    var today = new Date()
    var thisYear = today.getFullYear()
    var yearChooser = document.dateChooser.chooseYear
    for (i = start; i < thisYear + 185; i++) {
        yearChooser.options[yearChooser.options.length] = new Option(i, i)
    }
    setCurrMonth(today)
    CurrentYear();
}
// set month choice to current month
function setCurrMonth(today) {
    document.dateChooser.chooseMonth.selectedIndex = today.getMonth();
    
}
function CurrentYear()  //set the choice to current year
{
    var d = new Date(),

n = d.getMonth(),

y = d.getFullYear();

    $('#sel option:eq(' + n + ')').prop('selected', true);

    $('#sel2 option[value="' + y + '"]').prop('selected', true);
   
}


function getval(cel) { //create date ex. '1 Mar2016' to pass 
    //debugger;
    var Z = cel.html();
    var Z1 = Z.split("<");
    var dat = Z1[0];
   
   // var Z1 = Z[0]+Z[1];
   //alert(cel.innerHTML);
 
    var M = $('#sel :selected').text();
    // alert(M);
    var Y = $('#sel2 :selected').text();
    //alert(Y);
   
    var X = dat + " " + M + " " + Y;

    if (dat != "")
    {

        //var Q = new Date(X);
          var Q = X;
            //alert(Q);
          var  dt = Q;

            SelectedDate = dt;
            BindDay(GetStandardDate(GetTodaysDate(dt)));
        }
    
   
    }

function GetCountryDetails(startDay, W) { // according to starting days an
    //alert(startDay);
   
   
    var b = W;
    if (startDay == '7') {                                       //sunday

       
        var tbl = document.getElementById("calendarTable");
        
        var week = 7;

        if (tbl != null) {

            for (var i = 3; i < tbl.rows.length; i++) {
               
                if (b == 1) {                                            //w=1 sunday
                    var dif = week;

                    var j = 0;
                    while (j != dif) {
                        if (j != week-7 ) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }

                    
                }
                if (b == 2)                                                        //w=2 sunday
                {
                    var dif = week;

                    var j = 0;
                    while (j != dif) {
                        if (j != week - 7 && j != week - 6) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }
                    
                    
                }
                if (b == 3) {                                                    //w=3 sunday
                    var dif = week;

                    var j = 0;
                    while (j != dif) {
                        if (j != week - 7 && j != week - 6 && j != week - 5) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }

                    }

                if (b == 4) {                                                       //w=4 sunday
                    
                            for (var j = 4; j < tbl.rows[i].cells.length; j += b) {

        (tbl.rows[i].cells[j].innerHTML + " " + tbl.rows[i].cells[j + 1].innerHTML + " " + tbl.rows[i].cells[j + 2].innerHTML);
                           
                            if (tbl.rows[i].cells[j].innerHTML != "") {
                                tbl.rows[i].cells[j].className = "baground";
                                
                            }
                            if (tbl.rows[i].cells[j + 1].innerHTML != "") {
                                tbl.rows[i].cells[j + 1].className = "baground";
                               
                            }
                            if (tbl.rows[i].cells[j + 2].innerHTML != "") {
                                tbl.rows[i].cells[j + 2].className = "baground";
                               
                            }
                    }
                }

                if (b == 5) {                                                          //w=5 sunday
                  
                    for (var j = 5; j < tbl.rows[i].cells.length; j += b) {


                     (tbl.rows[i].cells[j].innerHTML + " " + tbl.rows[i].cells[j + 1].innerHTML);
                       
                    
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                            tbl.rows[i].cells[j].className = "baground";
                            
                        }
                        if (tbl.rows[i].cells[j + 1].innerHTML != "") {
                            tbl.rows[i].cells[j + 1].className = "baground";
                           
                        }
                    }
                }

                if (b == 6) {                                                         //w=6 sunday

                    for (var j = 6; j < tbl.rows[i].cells.length; j += b) {
                           (tbl.rows[i].cells[j].innerHTML);
                        
                            if (tbl.rows[i].cells[j].innerHTML != "") {
                                tbl.rows[i].cells[j].className = "baground";
                               
                            }
                    }
                }
            }
        }

    }


    if (startDay == '1') {                                                             //monday
        var tbl = document.getElementById("calendarTable");
       var week = 7;
        if (tbl != null) {
            
            for (var i=3; i <tbl.rows.length-1; i++) {
                if (b == 1) {                                                         //W=1 monday

                    var dif = week;

                    var j = 0;
                    while (j != dif) {
                        if (j != week - 6) {
                            tbl.rows[i].cells[j].className = "baground";
                            
                        }
                        j++;
                    } 
                   

                }
                if (b == 2) {                                                       //w=2 monday

                    var dif = week;

                    var j = 0;
                    while (j != dif) {
                        if (j != week - 6 && j != week - 5) {
                            tbl.rows[i].cells[j].className = "baground";
                           
                        }
                        j++;
                    }
                    

                }
                if (b == 3)                                                             //w=3 monday
                {
                    for (var j = 4; j < tbl.rows[i].cells.length; j += b) {
                        tbl.rows[i].cells[j].className = "baground";
                        tbl.rows[i].cells[j + 1].className = "baground";
                        tbl.rows[i].cells[j + 2].className = "baground";
                        tbl.rows[i].cells[0].className = "baground";
                    }
                }

                if (b == 4) {                                                                 //w=4 monday
                    if (tbl.rows[i].cells[0].innerHTML != "") {
                        tbl.rows[i].cells[0].className = "baground";
                        
                    }
                    if (tbl.rows[tbl.rows.length - 1].cells[6].innerHTML != "") {
                        tbl.rows[tbl.rows.length - 1].cells[6].className = "baground";
                      
                    }
                    if (tbl.rows[tbl.rows.length - 1].cells[5].innerHTML != "") {
                        tbl.rows[tbl.rows.length - 1].cells[5].className = "baground";
                        
                    }


                    for (var j = 5; j < tbl.rows[i].cells.length; j += b) {                          
          (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML + "  " + tbl.rows[i + 1].cells[0].innerHTML);
                       
                        tbl.rows[i].cells[j].className = "baground";
                        tbl.rows[i].cells[j + 1].className = "baground";
                       tbl.rows[i + 1].cells[0].className = "baground";
                       
                    }
                }
                if (b == 5)  //w=5 monday
                {
                   
                    if (tbl.rows[i].cells[0].innerHTML != "") {
                        tbl.rows[i].cells[0].className = "baground";
                        }
                    if (tbl.rows[tbl.rows.length-1].cells[6].innerHTML != "") {
                        tbl.rows[tbl.rows.length - 1].cells[6].className = "baground";
                    }
                
                    for (var j = 6 ; j < tbl.rows[i].cells.length; j += b) {
                     
                        //alert(tbl.rows[i].cells[j].id)
                     (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i + 1].cells[0].innerHTML);
                     if (tbl.rows[i].cells[j].innerHTML != "") {
                         tbl.rows[i].cells[j].className = "baground";
                         tbl.rows[i + 1].cells[0].className = "baground";
                         
                     }
                       

                    }
                    
                }
                if (b == 6) {                                                                            //w=6 monday
                    if (tbl.rows[i].cells[0].innerHTML != "") {
                        tbl.rows[i].cells[0].className = "baground";
                      
                    }
                   
                    for (var j = 2 ; j < tbl.rows[i].cells.length; j += b) {                      
                     
                        //(tbl.rows[i + 1].cells[0].innerHTML);
                        if (tbl.rows[i].cells[0].innerHTML!="")
                       tbl.rows[i+1].cells[0].className = "baground";
                        
                        
                    }
                }
            }

        }
    }



    if (startDay == '2') {                                                                                     //tue

        var tbl = document.getElementById("calendarTable");
        var week = 7;
        if (tbl != null) {
            var i;
           
           for (i = 3; i < tbl.rows.length ; i++) {
               if (b == 1)                                                                                  //w=1 tue

               {
                   var dif = week;

                   var j = 0;
                   while (j != dif) {
                       if (j != week - 5) {
                           tbl.rows[i].cells[j].className = "baground";

                       }
                       j++;
                   }
                 
               }
               if (b == 2) {                                                                               //w=2 tue
                   var dif = week;

                   var j = 0;
                   while (j != dif) {
                       if (j != week - 5 && j != week - 4) {
                           tbl.rows[i].cells[j].className = "baground";

                       }
                       j++;
                   }
                   
               }
               if (b == 3) {                                                                                  //w=3 tue
                   var dif = week;

                   var j = 0;
                   while (j != dif) {
                       if (j != week - 5 && j != week - 4 && j != week - 3) {
                           tbl.rows[i].cells[j].className = "baground";

                       }
                       j++;
                   }
                   
               }

               if (b == 4) {                                                                                   //w=4 tue
                   if (tbl.rows[i].cells[0].innerHTML != "") {
                       tbl.rows[i].cells[0].className = "baground";
                      
                   }
                   if (tbl.rows[i].cells[1].innerHTML != "") {
                       tbl.rows[i].cells[1].className = "baground";
                     
                   }
                   if (tbl.rows[tbl.rows.length - 1].cells[6].innerHTML != "") {
                       tbl.rows[tbl.rows.length - 1].cells[6].className = "baground";
                       
                   }


                    for (var j = 6; j < tbl.rows[i].cells.length; j += b) {
        (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i + 1].cells[0].innerHTML + "  " + tbl.rows[i + 1].cells[1].innerHTML);
                     
                        tbl.rows[i].cells[j].className = "baground";
                       tbl.rows[i + 1].cells[0].className = "baground";
                       tbl.rows[i + 1].cells[1].className = "baground";
                       
                    }
                }

               if (b == 5) {                                                                                   //w=5 tue
                   if (tbl.rows[i].cells[1].innerHTML != "") {
                       tbl.rows[i].cells[1].className = "baground";
                      
                   }

                    for (var j = 0; j < tbl.rows[i].cells.length; j += 7) {
                        if (tbl.rows[i].cells[j].innerHTML !="") {
                            (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML);
                            tbl.rows[i].cells[j].className = "baground";
                            tbl.rows[i].cells[j + 1].className = "baground";
                            
                        }
                    }
                }
               if (b == 6) {                                                                                      //w=6 tue
                  
                   for (var j = 1; j < tbl.rows[i].cells.length; j += b) {
                       if (tbl.rows[i].cells[j].innerHTML != "") {
                           (tbl.rows[i].cells[j].innerHTML);
                           tbl.rows[i].cells[j].className = "baground";
                          
                       }
                   }
               }
            }
        }
    }

    if (startDay == '3') {                                                                     //wed 
        var week = 7;
        var tbl = document.getElementById("calendarTable");
        if (tbl != null) {



            for (var i = 3; i < tbl.rows.length; i++) {
                if (b == 1) {                                                                  //w=1 wed 

                    var dif = week;
                   
                    var j = 0;
                    while (j != dif) {
                        if (j != week - 4) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }
                    
                }
                if (b == 2) {                                                                   //w=2 wed 
                    var dif = week;

                    var j = 0;
                    while (j != dif) {
                        if (j != week - 4 && j != week - 3) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }

                    
                }
                if (b == 3) {                                                                         //w=3 wed 

                    var dif = week;

                    var j = 0;
                    while (j != dif) {
                        if (j != week - 4 && j != week - 3 && j != week - 2) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }
                    
                }

                if (b == 4) {                                                                      //w=4 wed 

                    if (tbl.rows[i].cells[1].innerHTML != "") {
                        tbl.rows[i].cells[1].className = "baground";
                        
                    }
                    if (tbl.rows[i].cells[2].innerHTML != "") {
                        tbl.rows[i].cells[2].className = "baground";
                       
                    }
                   for (var j = 0; j < tbl.rows[i].cells.length; j += 7) {
                       if (tbl.rows[i].cells[j].innerHTML != "") {
                           //alert(j);
                          (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML + "  " + tbl.rows[i].cells[j + 2].innerHTML);

                           tbl.rows[i].cells[j].className = "baground";
                         tbl.rows[i].cells[j + 1].className = "baground";
                       tbl.rows[i].cells[j + 2].className = "baground";
                           
                       }
                    }
                }

                if (b == 5) {                                                                        //w=5 wed 
                    if (tbl.rows[i].cells[2].innerHTML != "") {
                        tbl.rows[i].cells[2].className = "baground";
                        
                    }
                    for (var j = 1; j < tbl.rows[i].cells.length; j += b) {
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                            //alert(j);
                           (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML);
                            tbl.rows[i].cells[j].className = "baground";
                           tbl.rows[i].cells[j + 1].className = "baground";
                           
                        }
                    }
                }

                if (b == 6) {                                                                    //w=6 wed 
                    for (var j = 2; j < tbl.rows[i].cells.length; j += b) {
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                            //alert(j);
                          (tbl.rows[i].cells[j].innerHTML);
                            tbl.rows[i].cells[j].className = "baground";
              
                        }
                    }
                }

            }
        }
    }
    if (startDay == '4') {                                                                           //thu
        var week = 7;
        var tbl = document.getElementById("calendarTable");
        if (tbl != null) {

            for (var i = 3; i < tbl.rows.length; i++) {
                if (b == 1) { //w=1 thu
                    var dif = week;
                    // alert(dif);
                    var j = 0;
                    while (j != dif) {
                        if (j != week - 3) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }

                    
                }
                if (b == 2) {                                                                       //w=2 thu
                    
                    var dif = week;
                    // alert(dif);
                    var j = 0;
                    while (j != dif) {
                        if (j != week - 3 && j != week-2) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }
                }
               
            

                if (b == 3) {//w=3 thu
                    var dif = week;
                    // alert(dif);
                    var j = 0;
                    while (j != dif) {
                        if (j != week - 3 && j != week - 2 && j != week - 1) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }

                   
                }
                if (b == 4) {                                                           //w=4 thu
                   if (tbl.rows[i].cells[3].innerHTML != "") {
                       tbl.rows[i].cells[3].className = "baground";
                     
                   }
                   if (tbl.rows[i].cells[2].innerHTML != "") {
                       tbl.rows[i].cells[2].className = "baground";
                      
                   }
                   for (var j = 1; j < tbl.rows[i].cells.length; j += 6) {
                       if (tbl.rows[i].cells[j].innerHTML != "") {
                           //alert(j);
        (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML + "  " + tbl.rows[i].cells[j + 2].innerHTML);

                           tbl.rows[i].cells[j].className = "baground";
                          tbl.rows[i].cells[j + 1].className = "baground";
                        tbl.rows[i].cells[j + 2].className = "baground";
                        
                       }
                   }
                }

                if (b == 5) {                                                            //w=5 thu
                   if (tbl.rows[i].cells[3].innerHTML != "") {
                       tbl.rows[i].cells[3].className = "baground";
                       
                   }

                    for (var j = 2; j < tbl.rows[i].cells.length; j += 6) {
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                            //alert(j);
                           (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML);

                            tbl.rows[i].cells[j].className = "baground";
                           tbl.rows[i].cells[j + 1].className = "baground";
                            
                        }
                    }
                }

                if (b == 6) {                                                                //w=6 thu

                    for (var j = 3; j < tbl.rows[i].cells.length; j += 6) {
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                            //alert(j);
                           (tbl.rows[i].cells[j].innerHTML);
                            tbl.rows[i].cells[j].className = "baground";
                           
                        }
                    }
                }

            }

        }
    }
    if (startDay == '5') {                                                                       //fri
        var week = 7;
        var tbl = document.getElementById("calendarTable");
        if (tbl != null) {

            for (var i = 3; i < tbl.rows.length ; i++) {

                if (b == 1) {                                                                    //w=1 fri
                    var dif = week;
                   // alert(dif);
                    var j = 0;
                    while (j != dif) {
                        if (j != week-2) {
                            tbl.rows[i].cells[j].className = "baground";
                            
                        }
                        j++;
                    } 

                   

                }
                if (b == 2) {// w=2 fri
                    var dif = week;
                    // alert(dif);
                    var j = 0;
                    while (j != dif) {
                        if (j != week - 1 && j != week - 2) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }

                    

                }
                if (b == 3) {                                                                  //w=3 fri
                    var dif = week;
                    // alert(dif);
                    var j = 1;
                    while (j != dif) {
                        if (j != week - 1 && j != week - 2) {
                            tbl.rows[i].cells[j].className = "baground";

                        }
                        j++;
                    }
                }

                
                        if (b == 4) {                                                              //w=4 fri

                            if (tbl.rows[i].cells[4].innerHTML != "")
                     {
                        tbl.rows[i].cells[4].className = "baground";
                        
                    }

                    for (var j = 2; j < tbl.rows[i].cells.length; j += 6) {
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                            //alert(j);
         (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML + "  " + tbl.rows[i].cells[j + 2].innerHTML);

                            tbl.rows[i].cells[j].className = "baground";
                           tbl.rows[i].cells[j + 1].className = "baground";
                           tbl.rows[i].cells[j + 2].className = "baground";
                           
                        }
                    }
                }
           

                if (b == 5) {                                                        // w=5 fri

                    if (tbl.rows[i].cells[4].innerHTML != "") {
                        tbl.rows[i].cells[4].className = "baground";
                       
                    }

                    for (var j = 3; j < tbl.rows[i].cells.length; j += 6) {
                        
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                       // (tbl.rows[i].cells[j].innerHTML + "  " + tbl.rows[i].cells[j + 1].innerHTML);
                       
                        tbl.rows[i].cells[j].className = "baground";
                            tbl.rows[i].cells[j + 1].className = "baground";
                            
                        }
                    }
                }
                if (b == 6) {                                                        //w=6 fri

                    for (var j = 4; j < tbl.rows[i].cells.length; j += 6) {
                        if (tbl.rows[i].cells[j].innerHTML != "") {
                            
                           // (tbl.rows[i].cells[j].innerHTML);

                            tbl.rows[i].cells[j].className = "baground";
                            
                        }
                    }
                }
            }
        }
    }
    if (startDay == '6')  {                                                        //sat
        var week = 7;
        var tbl = document.getElementById("calendarTable");
        if (tbl != null) {

            for (var i = 3; i < tbl.rows.length ; i++) {

                if (b == 1) {                                                       // w=1 sat
                    var dif = week - b;
                   
                    var j = 0;
                    do {
                        tbl.rows[i].cells[j].className = "baground";

                        j++;

                    } while (j != dif);
                }


                if (b == 2) {//w=2 sat
                    var dif = week - b + 1;
                    var j = 1;
                    //for (var j = 1; j < tbl.rows[i].cells.length; j += b) {
                    do {

                        tbl.rows[i].cells[j].className = "baground";
                        j++;

                    } while (j != dif);

                }

           
                    if (b == 3) {                                                     //w=3 sat
                    var dif = week - b + 2;
                    var j = 2;
                    do {

                        tbl.rows[i].cells[j].className = "baground";

                        j++;

                    } while (j != dif);
                }


                if (b == 4) {                                                          //w=4 sat
                    var dif = week - b + 3;
                    var j = 3;
                    do {
                        tbl.rows[i].cells[j].className = "baground";

                        //if (tbl.rows[i].cells[5].innerHTML != "") {
                        //    tbl.rows[i].cells[5].className = "baground";

                        //}

                        j++;
                    } while (j != dif);
                }


                if (b == 5) {                                                         //w=5 sat
                    var dif = week - b + 4;
                    var j = 4;
                    do {
                        tbl.rows[i].cells[j].className = "baground";
                        j++;
                        //if (tbl.rows[i].cells[5].innerHTML != "") {
                        //    tbl.rows[i].cells[5].className = "baground";

                        //}


                    } while (j != dif);
                }
                if (b == 6) {                                                         // w=6 sat
                    var dif = week - b + 5;
                    var j = 5;
                    do {
                        
                        tbl.rows[i].cells[j].className = "baground";
                        j++;
                        
                    } while (j != dif);

                }
            }
        }
    }

}

//Ended by tejal deshmukh
/*xxxxxxxxxxxxxxxxx*/
/* comment week and add new function below*/

function getCurrentWeek(dt) {
    ArrRespWeek = [];
    html = '';
    if (dt == undefined || dt == '') {
        ArrRespWeek = getCurrentWeekEvents();
    }
    else {
        ArrRespWeek = getCurrentWeekEvents(dt);
    }
    var m_names = new Array("January", "February", "March",
"April", "May", "June", "July", "August", "September",
"October", "November", "December");
    var topContent = "<label style='display:inline-block;'>" + GetStandardDate(GetTodaysDate(ArrRespWeek[0].date)) + '-' + GetStandardDate(GetTodaysDate(ArrRespWeek[6].date)) + "</label>";
    //var topContent = "<label1 style='display:block;'>" + GetStandardDate(GetTodaysDate(ArrRespWeek[0].date)) + '-' + GetStandardDate(GetTodaysDate(ArrRespWeek[6].date)) + "</label1>";

    var NextPrevHtml1 = "<img id=\"btnPrev\" onclick=\"ShowPrevWeek('" + ArrRespWeek[0].date + "')\" class='ImgBL' />";           // Prev Button
    document.getElementById("DivPrevWeekBtn").innerHTML = NextPrevHtml1;
    var NextPrevHtml2 = "<img id=\"btnNext\" onclick=\"ShowNextWeek('" + ArrRespWeek[6].date + "')\" class='ImgBR' />";          // Next Button
    document.getElementById("DivNextWeekBtn").innerHTML = NextPrevHtml2;
   
    document.getElementById("Divweekrange").innerHTML = topContent;
    html += "<table style='width:100%;height:100%;'>";
    for (var i = 0; i <= ArrRespWeek.length - 1; i++) {
        html += "<div id='" + GetTodaysDate(ArrRespWeek[i].date) + "' class='tdcls' onclick=\"ViewTimeSheet('" + ArrRespWeek[i].date + "')\">";
        html += "<label>" + ArrRespWeek[i].date.getDate() + ' ' + m_names[(ArrRespWeek[i].date.getMonth())] + ' ' + ArrRespWeek[i].date.getFullYear() + "</label>";
        // html += "<label1>" + ArrRespWeek[i].date.getDate() + ' ' + m_names[(ArrRespWeek[i].date.getMonth())] + ' ' + ArrRespWeek[i].date.getFullYear() + "</label1>";
        html += "</div>";

    }
  
    html += "</table>";

    document.getElementById("DivCurrWeekList").innerHTML = html;
}



    function ViewTimeSheet(dt) {
        //$("#WeekView").animate(2000, function () {
        
        //});
   
        $("#DivCustomTimeSheetNew").fadeOut("slow", function () { document.getElementById("DayView").style.display = 'block', document.getElementById("divrem").style.display = 'none'; });
        //$('#link').fadeOut("slow", function () { document.getElementById("DivCustomTimeSheet").style.display = 'block'; });
      
 //$("#calendarTable").fadeOut("slow", function () { document.getElementById("DayView").style.display = 'block'; });
        //$("#DayView").animate(2200, function () {
        ClearProjectTaskFields();
       SelectedDate = dt;
       BindDay(GetStandardDate(GetTodaysDate(dt)));
       GetProjectListForEmployee(dt);
    }

    function BindDay(dt) {
   
        if (document.getElementById("txtHours")!=null)
            document.getElementById("txtHours").disabled = false;
        if (document.getElementById("BtnSaveUpdate") != null)
            document.getElementById("BtnSaveUpdate").disabled=false;
        // document.getElementById("ErrorSpan").style.display = "none";
        // document.getElementById("ErrorSpan2").style.display = "none";
        // document.getElementById("ErrorSpan3").style.display = "none";
        document.getElementById("DivDAYTimeSheet").innerHTML = "<label style='display:inline-block;' id='bDate' title=" + GetWeekDay(new Date(dt).getDay()) + ">" + dt + "</b></label>";        // HEAD Date bold Center

        SelectedDate = dt;
        ClearProjectTaskFields();                                                   // Function to CLEAR PROJECT and TASK Fields

        var NextPrevDay1 = "<a title=" + GetTodaysDate(GetPrevDate(dt)) + " onclick=\"BindDay('" + GetStandardDate(GetTodaysDate(GetPrevDate(dt))) + "')\"><img id=\"btnPrev\" class='ImgBL' /></a>";           // Prev Button
        document.getElementById("DivPrevDAYBtn").innerHTML = NextPrevDay1;
        var PrevDay2 = "<a title=" + GetTodaysDate(GetNextDate(dt)) + " onclick=\"BindDay('" + GetStandardDate(GetTodaysDate(GetNextDate(dt))) + "')\"><img id=\"btnNext\" class='ImgBR' /> </a>";          // Next Button
        document.getElementById("DivNextDAYBtn").innerHTML = PrevDay2;

        var dHTML = "";
        GetProjectListForEmployee(dt);
    }
    
    function GoToMainWeek(flag_1) {
        
       
        // added by tejal deshmukh 
        if (flag_1 == 0) { //calander display 
            
            
            document.getElementById("DayView").style.display = 'none';
            $("#calendarTable").fadeIn("slow");
            $("#legend").css('display', 'block');
          }
        else if (flag_1 == 1) //week view display if condition are true

        {

            document.getElementById("DayView").style.display = 'none';

            $("#DivCustomTimeSheetNew").fadeIn("slow");
            $("#WeekView").fadeIn("slow");
            $("#legend").css('display', 'none');

        }
        else
        {
            document.getElementById("DayView").style.display = 'none';
            $("#calendarTable").fadeIn("slow");
            $("#legend").css('display', 'block');
        }
        //getCurrentWeek();
        //ened 
    }

    function M_GetProjectListForEmployee(para, strLoginType, path) {
   
        Path = path;
        try {
            $.ajax({
                type: "GET",                                                //GET or POST or PUT or DELETE verb
                url: path + "GetProjectListForTimesheet", // Location of the service
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
                error: function (xhr) {
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        } catch (exception) { }

    }
    function M_ToCheckActiveOnHoldProject(EmployeeID, PKToken)
    {
        // paraEmployeeID={intEmployeeID:504};
        Path = path;
        //            alert(Path + '' + paraEmployeeID)
        try {
            $.ajax({
                type: "GET", //GET or POST or PUT or DELETE verb
                url: path + "ToCheckActiveOnholdProject", // Location of the service
                //Added by Yogesh Jalamkar on 18-Mar-2016 to genarate Token
                //  data: { intEmployeeID: EmployeeID, Token: PKToken },
                data: { intEmployeeID: EmployeeID, Token: PKToken },
                //End of addition by Yogesh Jalamkar on 18-Mar-2016 to genarate Token
                contentType: "application/json;charset=utf-8", // content type sent to server
                dataType: "jsonp", //Expected data format from server
                success: function (data) {//On Successfull service call         

                    $.each(JSON.parse(data), function (id, obj) {
                        if (obj.ProjectsOnHold == null) {
                            //ToCheckActiveWorkFlowProject();
                            //getTimesheet();
                            // GetTask();
                                
                            M_ToCheckActiveWorkFlowProject(EmployeeID, PKToken);
                        }
                        else {
                            alert(obj.ProjectsOnHoldMsg);
                        }

                    });


                },
                error: function (xhr) {
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        } catch (exception) { }
    }
    function M_ToCheckActiveWorkFlowProject(EmployeeID, PKToken)
    {
        //paraEmployeeID = EmployeeID;
        Path = path;
        mylist = document.getElementById("DDLProject");
        entity=mylist.options[mylist.selectedIndex].value; //get Dropdown ProjectId
            
        // alert(JSON.stringify(paraEmployeeID));
        try {           
            $.ajax({
                type: "GET", //GET or POST or PUT or DELETE verb
                url: path + "ToCheckActiveWorkflowProjects", // Location of the service
                //Commented And Added By Vaijat K ON 28/04/2016 For WCF Security Token
                //data: { intEmployeeID: EmployeeID },
                data: { intEmployeeID: EmployeeID, Token: PKToken },
                //End Of Addition by Vaijat K
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
                                mylist.value = "0";
                                //GetTask();
                                document.getElementById("lblAllocatedWork").innerHTML = "";
                                document.getElementById("lblActualWork").innerHTML = "";
                            }                                               

                        }

                        //if(flag==0)
                        //{
                                          
                        //   GetTask();
                        //}


                    });                                     
                                            
                        
                },
                error: function (xhr) {
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        } catch (exception) { }
    }
    //Commented And Added By Vaijat K ON 28/04/2016 For WCF Security
    //function GetAssignedTaskDayWise(ProjectID, EmpID, RoleID) {
    //    if (document.getElementById("txtHours") != null)
    //        document.getElementById("txtHours").disabled=false;
    //    document.getElementById("BtnSaveUpdate").disabled=false;
   
    //    EmployeeID = EmpID;
    //    RoleId = RoleID;
    //    // ArrDurationNew = [];
    //    ProjID = ProjectID;

    //    M_ToCheckActiveOnHoldProject(EmployeeID);
    //    // document.getElementById("ErrorSpan").style.display = "none";

    //    if (document.getElementById("DDLProject").value == "0") {
    //        ClearProjectTaskFields();
    //        $("#DDLTask").html("");
    //    }
    //    else {
    //        //alert('ProjectID: ' + ProjectID + ', EmpID: ' + EmpID + ', RoleID: ' + RoleID + ', Date: ' + SelectedDate + ' ,Path: ' + Path);
    //        DateSelected = GetMMddYYDate(SelectedDate);

    //        try {
    //            $.ajax({
    //                type: "GET",
    //                url: Path + "TimesheetEntryDateWiseFilter",
    //                data: { projectID: ProjectID, employeeID: EmpID, fromDate: DateSelected, toDate: DateSelected, assignedBugTasksFlag: undefined, defaultTasksFlag: undefined, mPPTasksFlag: undefined, assignedTasksFlag: 1, weekRangeFlag: 1, roleID: RoleID },
    //                contentType: "application/json;charset=utf-8",
    //                dataType: "jsonp",
    //                success: function (data) {
    //                    ArrGetTask = [];
    //                    $("#DDLTask").html("");
    //                    $("#DDLTask").append("<option value='0' selected='selected'>Select Task</option>");
    //                    $.each(JSON.parse(data), function (id, obj) {
    //                        //alert('CallGetTaskHr '+ obj.TaskName)
    //                        //GetTaskHour(obj.TaskID, DateSelected, obj.ActualWork, obj.Work, obj.TaskName);
    //                        $("#DDLTask").append("<option id=" + obj.TaskID + " value=" + obj.TaskID + "|" + obj.ActualWork + "|" + obj.Work + "|" + obj.IsTaskComplete + "|" + obj.void + ">" + obj.TaskName + "</option>");
    //                        ArrGetTask.push({ TaskID: obj.TaskID, DateSelected: DateSelected, ActualWork: obj.ActualWork, Work: obj.Work, TaskName: obj.TaskName,IsTaskComplete:obj.IsTaskComplete,voidTask:obj.void });

    //                        ArrDurationNew = [];
    //                        //CalcDuration(obj.TaskID, DateSelected);
    //                        $.ajax({
    //                            type: "GET",
    //                            url: Path + "GetTaskHours",
    //                            //data: { TaskId: TaskID, EntryDate: EntryDate },
    //                            data: { TaskId: obj.TaskID, EntryDate: DateSelected },
    //                            contentType: "application/json;charset=utf-8",
    //                            dataType: "jsonp",
    //                            success: function (data) {
    //                                // alert('SUCCESS: ' + JSON.stringify(data));
    //                                $.each(JSON.parse(data), function (id, obj) {

    //                                    ArrDurationNew.push({ taskid: obj.TaskID, hour: obj.Duration });
    //                                    //TotalHour = TotalHour + obj.Duration;
    //                                });
    //                            },
    //                            error: function (xhr) {
    //                                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

    //                            }
    //                        });

    //                    });
    //                    //GetTaskHour(ArrGetTask);
    //                },
    //                error: function (xhr) {
    //                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

    //                }
    //            });
            
    //        } catch (exception) { }
    //    }
    //}
    function GetAssignedTaskDayWise(ProjectID, EmpID, RoleID, PKToken) {
        if (document.getElementById("txtHours") != null)
            document.getElementById("txtHours").disabled = false;
        document.getElementById("BtnSaveUpdate").disabled = false;

        EmployeeID = EmpID;
        RoleId = RoleID;
        // ArrDurationNew = [];
        ProjID = ProjectID;

        //Added by Yogesh Jalamkar on 18-Mar-2016 to generate Token
        //  M_ToCheckActiveOnHoldProject(EmployeeID);
        M_ToCheckActiveOnHoldProject(EmployeeID, PKToken);
        //Added by Yogesh Jalamkar on 18-Mar-2016 to generate Token
        // document.getElementById("ErrorSpan").style.display = "none";

        if (document.getElementById("DDLProject").value == "0") {
            ClearProjectTaskFields();
            $("#DDLTask").html("");
            $("#DDLTask").append("<option value='0' selected='selected'>Select Task</option>");
        }
        else {
            //Added by Vaijat K ON 05/03/2016 For Timesheet Refresh Issue
            ClearTaskFields();
            //End of Addition Vaijat K
            //alert('ProjectID: ' + ProjectID + ', EmpID: ' + EmpID + ', RoleID: ' + RoleID + ', Date: ' + SelectedDate + ' ,Path: ' + Path);
            DateSelected = GetMMddYYDate(SelectedDate);

            try {
                $.ajax({
                    type: "GET",
                    url: Path + "TimesheetEntryDateWiseFilter",
                    data: { projectID: ProjectID, employeeID: EmpID, fromDate: DateSelected, toDate: DateSelected, assignedBugTasksFlag: undefined, defaultTasksFlag: undefined, mPPTasksFlag: undefined, assignedTasksFlag: 1, weekRangeFlag: 1, roleID: RoleID },
                    contentType: "application/json;charset=utf-8",
                    dataType: "jsonp",
                    success: function (data) {
                        ArrGetTask = [];
                        $("#DDLTask").html("");
                        $("#DDLTask").append("<option value='0' selected='selected'>Select Task</option>");
                        var JSONdata = JSON.parse(data);
                        $.each(JSON.parse(data), function (id, obj) {

                            //alert('CallGetTaskHr '+ obj.TaskName)
                            //GetTaskHour(obj.TaskID, DateSelected, obj.ActualWork, obj.Work, obj.TaskName);
                            $("#DDLTask").append("<option id=" + obj.TaskID + " value=" + obj.TaskID + "|" + obj.ActualWork + "|" + obj.Work + "|" + obj.IsTaskComplete + "|" + obj.void + ">" + obj.TaskName + "</option>");
                            ArrGetTask.push({ TaskID: obj.TaskID, DateSelected: DateSelected, ActualWork: obj.ActualWork, Work: obj.Work, TaskName: obj.TaskName, IsTaskComplete: obj.IsTaskComplete, voidTask: obj.void });

                            ArrDurationNew = [];
                            //CalcDuration(obj.TaskID, DateSelected);
                            //Added By Vaijat K ON 29/03/2016 Purpose Generating Token For WCF security
                            $.ajax({
                                type: 'POST',
                                dataType: 'json',
                                contentType: 'application/json',
                                url: 'PM_dailyActivityMobile.aspx/SetWork',
                                data: JSON.stringify({ TaskId: obj.TaskID, EntryDate: GetMMddYYDate(DateSelected) }),
                                success: function (Result) {
                                    //Ended
                                    $.ajax({

                                        type: "GET",
                                        url: Path + "GetTaskHours",
                                        //data: { TaskId: TaskID, EntryDate: EntryDate },
                                        data: { TaskId: obj.TaskID, EntryDate: DateSelected, PKToken: Result.d },
                                        contentType: "application/json;charset=utf-8",
                                        dataType: "jsonp",
                                        success: function (data) {

                                            // alert('SUCCESS: ' + JSON.stringify(data));
                                            $.each(JSON.parse(data), function (id, obj) {

                                                ArrDurationNew.push({ taskid: obj.TaskID, hour: obj.Duration });
                                                //TotalHour = TotalHour + obj.Duration;
                                            });
                                        },
                                        error: function (xhr) {
                                            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                                        }
                                    });
                                }
                            });
                        });
                        if (JSONdata.length == 1)
                        {
                            document.getElementById("DDLTask").selectedIndex = 1;
                            SetWork(document.getElementById("DDLTask").value)
                        }
                        //GetTaskHour(ArrGetTask);
                    },
                    error: function (xhr) {
                        alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                    }
                });

            } catch (exception) { }
        }
    }
    //End of Addition Vaijat K

    //Commented And Added By Vaijat K ON 28/04/2016 For WCF Security
    //function GetTaskHour(ArrGetTask) {
    //    try {
    //        ArrDurHour = [];
     
    //        for (var i = 0; i <= ArrGetTask.length - 1; i++) {
    //            $.ajax({
    //                type: "GET",
    //                url: Path + "GetTaskHours",
    //                //data: { TaskId: TaskID, EntryDate: EntryDate },
    //                data: { TaskId: ArrGetTask[i].TaskID, EntryDate: ArrGetTask[i].DateSelected },
    //                contentType: "application/json;charset=utf-8",
    //                dataType: "jsonp",
    //                success: function (data) {
    //                    $.each(JSON.parse(data), function (id, obj) {
                       
    //                        ArrDurHour.push({ Duration: obj.Duration });
    //                        //$("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + obj.Duration + ">" + ArrGetTask[i].TaskName + "</option>");
    //                        //ArrDuration.push({ taskid: ArrGetTask[i].TaskID, hour: obj.Duration });
    //                    });
    //                },
    //                error: function (xhr) {
    //                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

    //                }
    //            });
    //        }
    //    } catch (exception) { }
//}

    function GetTaskHour(ArrGetTask) {
        try {
            ArrDurHour = [];

            for (var i = 0; i <= ArrGetTask.length - 1; i++) {
                //Added By Vaijat K ON 29/03/2016 Purpose Generating Token For WCF security
                $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    url: 'PM_dailyActivityMobile.aspx/SetWork',
                    data: JSON.stringify({ TaskId: ArrGetTask[i].TaskID, EntryDate: GetMMddYYDate(ArrGetTask[i].DateSelected) }),
                    success: function (Result) {
                        //Ended
                        $.ajax({
                            type: "GET",
                            url: Path + "GetTaskHours",
                            //data: { TaskId: TaskID, EntryDate: EntryDate },
                            data: { TaskId: ArrGetTask[i].TaskID, EntryDate: ArrGetTask[i].DateSelected, PKToken: Result.d },

                            contentType: "application/json;charset=utf-8",
                            dataType: "jsonp",
                            success: function (data) {
                                $.each(JSON.parse(data), function (id, obj) {

                                    ArrDurHour.push({ Duration: obj.Duration });
                                    //$("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + obj.Duration + ">" + ArrGetTask[i].TaskName + "</option>");
                                    //ArrDuration.push({ taskid: ArrGetTask[i].TaskID, hour: obj.Duration });
                                });
                            },
                            error: function (xhr) {
                                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                            }
                        });
                    }
                });
            }
        } catch (exception) { }
    }

//End of Addition Vaijat K

    function CombineArrays(ArrGetTask, ArrDurHour) {
   
        ArrDuration = [];
   
        for (var i = 0; i <= ArrGetTask.length - 1; i++) {
            for (var j = 0; j <= ArrDurHour.length - 1; j++) {
                $("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + ArrDurHour[j].Duration + ">" + ArrGetTask[i].TaskName + "</option>");
                ArrDuration.push({ taskid: ArrGetTask[i].TaskID, hour: ArrDurHour[j].Duration });
            }
        }
    }

//Commented And Added By Vaijat K ON 28/04/2016 For WCF Security
    //function CalcDuration(TaskID,Date) {
    //    $.ajax({
    //        type: "GET",
    //        url: Path + "GetTaskHours",
    //        //data: { TaskId: TaskID, EntryDate: EntryDate },
    //        data: { TaskId: TaskID, EntryDate: Date },
    //        contentType: "application/json;charset=utf-8",
    //        dataType: "jsonp",
    //        success: function (data) {
    //            // alert('SUCCESS: ' + JSON.stringify(data));
    //            $.each(JSON.parse(data), function (id, obj) {
    //                //alert("function");
    //                ArrDuration.push({ taskid: ArrGetTask[i].TaskID, hour: obj.Duration });
    //                //TotalHour = TotalHour + obj.Duration;
    //            });
    //        },
    //        error: function (xhr) {
    //            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

    //        }
    //    });

//}

    function CalcDuration(TaskID, Date) {
        //Added By Vaijat K ON 29/03/2016 Purpose Generating Token For WCF security
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'PM_dailyActivityMobile.aspx/SetWork',
            data: JSON.stringify({ TaskId: TaskID, EntryDate: GetMMddYYDate(Date) }),
            success: function (Result) {
                //Ended
                $.ajax({
                    type: "GET",
                    url: Path + "GetTaskHours",
                    //data: { TaskId: TaskID, EntryDate: EntryDate },
                    data: { TaskId: TaskID, EntryDate: Date, PKToken: Result.d },

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
                    error: function (xhr) {
                        alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                    }
                });
            }
        });
    }
//End Addition By Vaijat K

//Commented And Added By Vaijat K ON 28/04/2016 For WCF Security
    //function SetWork(value) {
    //    //debugger;
    //    if (document.getElementById("txtHours") != null)
    //        document.getElementById("txtHours").disabled = false;
    //    document.getElementById("BtnSaveUpdate").disabled=false;

    //    var work = value.split("|");
    //    TID = work[0];
    //    TotalHour = 0;
    //    if (document.getElementById("DDLTask").value == "0") {
    //        if (document.getElementById("lblAllocatedWork") != null)
    //            document.getElementById("lblAllocatedWork").innerHTML = "";
    //        if (document.getElementById("lblActualWork") != null)
    //            document.getElementById("lblActualWork").innerHTML = "";
    //        if (document.getElementById("txtHours") != null)
    //            document.getElementById("txtHours").value = "";
    //    }
    //    else {
    //        MInsert=0;
    //        ArrDuration = [];
    //        $.ajax({
    //            type: "GET",
    //            url: Path + "GetTaskHours",
    //            //data: { TaskId: TaskID, EntryDate: EntryDate },
    //            data: { TaskId: work[0], EntryDate: GetMMddYYDate(SelectedDate) },
    //            contentType: "application/json;charset=utf-8",
    //            dataType: "jsonp",
    //            success: function (data) {
                
    //                $.each(JSON.parse(data), function (id, obj) {
    //                    //ArrDurHour.push({ Duration: obj.Duration });
    //                    //$("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + obj.Duration + ">" + ArrGetTask[i].TaskName + "</option>");
                     
    //                    ArrDuration.push({ taskid: work[0], hour: obj.Duration });

    //                    if (ArrDuration == "") {
    //                        if (document.getElementById("txtHours") != null)
    //                            document.getElementById("txtHours").value = "";
    //                    }
    //                    else {
    //                        if (document.getElementById("txtHours") != null)
    //                            document.getElementById("txtHours").value = ArrDuration[0].hour;
    //                        MInsert = ArrDuration[0].hour;
                        
    //                    }
    //                    TaskHour = ArrDuration[0].hour;
    //                    TotalHrV = ArrDuration[0].hour;
    //                    //alert(TotalHrV)
    //                });
    //                // alert(ArrDuration[0].hour)
    //                //alert(work[1])
    //                if (document.getElementById("lblAllocatedWork") != null)
    //                    document.getElementById("lblAllocatedWork").innerHTML = work[2];
    //                if (document.getElementById("lblActualWork") != null)
    //                    document.getElementById("lblActualWork").innerHTML = work[1];
    //                IsTaskComplete = work[3];
    //                voidTask = work[4];
               
              
    //                MActualWork = work[1];


    //                TaskID = work[0];
    //                //MCheckIsMarkCompleteTask(TaskID);
    //                for (var i = 0; i <= ArrDurationNew.length - 1; i++) {
    //                    //alert(parseFloat(work[0]) + 'sss' + ArrDurationNew + parseFloat(ArrDurationNew[i].taskid))
    //                    if (parseFloat(work[0]) != parseFloat(ArrDurationNew[i].taskid)) {
    //                        //                        alert("Total " + parseFloat(ArrDuration[0].hour) + parseFloat(ArrDurationNew[i].hour))
    //                        TotalHour = parseFloat(TotalHour) + parseFloat(ArrDurationNew[i].hour);

    //                    }
    //                }

                
    //            },
    //            error: function (xhr) {
    //                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

    //            }
    //        });

    //    }

//}


    function SetWork(value) {

        if (document.getElementById("txtHours") != null)
            document.getElementById("txtHours").disabled = false;
        document.getElementById("BtnSaveUpdate").disabled = false;

        var work = value.split("|");
        TID = work[0];
        TotalHour = 0;
        if (document.getElementById("DDLTask").value == "0") {
            if (document.getElementById("lblAllocatedWork") != null)
                document.getElementById("lblAllocatedWork").innerHTML = "";
            if (document.getElementById("lblActualWork") != null)
                document.getElementById("lblActualWork").innerHTML = "";
            if (document.getElementById("txtHours") != null)
                document.getElementById("txtHours").value = "";
        }
        else {
            MInsert = 0;
            ArrDuration = [];

            //Commented Added by Yogesh J on 18-Mar-2016 for to generate  Token
            //$.ajax({

            //    type: "GET",
            //    url: Path + "GetTaskHours",
            //    //data: { TaskId: TaskID, EntryDate: EntryDate },
            //    data: { TaskId: work[0], EntryDate: GetMMddYYDate(SelectedDate), PKToken:Token },
            //    contentType: "application/json;charset=utf-8",
            //    dataType: "jsonp",
            //    success: function (data) {

            //        $.each(JSON.parse(data), function (id, obj) {
            //            //ArrDurHour.push({ Duration: obj.Duration });
            //            //$("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + obj.Duration + ">" + ArrGetTask[i].TaskName + "</option>");

            //            ArrDuration.push({ taskid: work[0], hour: obj.Duration });

            //            if (ArrDuration == "") {
            //                if (document.getElementById("txtHours") != null)
            //                    document.getElementById("txtHours").value = "";
            //            }
            //            else {
            //                if (document.getElementById("txtHours") != null)
            //                    document.getElementById("txtHours").value = ArrDuration[0].hour;
            //                MInsert = ArrDuration[0].hour;

            //            }
            //            TaskHour = ArrDuration[0].hour;
            //            TotalHrV = ArrDuration[0].hour;
            //            //alert(TotalHrV)
            //        });
            //        // alert(ArrDuration[0].hour)
            //        //alert(work[1])
            //        if (document.getElementById("lblAllocatedWork") != null)
            //            document.getElementById("lblAllocatedWork").innerHTML = work[2];
            //        if (document.getElementById("lblActualWork") != null)
            //            document.getElementById("lblActualWork").innerHTML = work[1];
            //        IsTaskComplete = work[3];
            //        voidTask = work[4];


            //        MActualWork = work[1];


            //        TaskID = work[0];
            //        //MCheckIsMarkCompleteTask(TaskID);
            //        for (var i = 0; i <= ArrDurationNew.length - 1; i++) {
            //            //alert(parseFloat(work[0]) + 'sss' + ArrDurationNew + parseFloat(ArrDurationNew[i].taskid))
            //            if (parseFloat(work[0]) != parseFloat(ArrDurationNew[i].taskid)) {
            //                //                        alert("Total " + parseFloat(ArrDuration[0].hour) + parseFloat(ArrDurationNew[i].hour))
            //                TotalHour = parseFloat(TotalHour) + parseFloat(ArrDurationNew[i].hour);

            //            }
            //        }


            //    },
            //    error: function (xhr) {
            //        alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

            //    }
            //});


            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'PM_dailyActivityMobile.aspx/SetWork',
                data: JSON.stringify({ TaskId: work[0], EntryDate: GetMMddYYDate(SelectedDate) }),
                success: function (Result) {
                    $.ajax({

                        type: "GET",
                        url: Path + "GetTaskHours",
                        //data: { TaskId: TaskID, EntryDate: EntryDate },
                        data: { TaskId: work[0], EntryDate: GetMMddYYDate(SelectedDate), PKToken: Result.d },
                        contentType: "application/json;charset=utf-8",
                        dataType: "jsonp",
                        async:false,
                        success: function (data) {
                            //Added by Vaijat K ON 05/03/2016 For Issue ID- 3732
                            $.ajax({
                                type: "POST",
                                url: "PM_dailyActivityMobile.aspx/GetIsTaskCompleteFlag",
                                dataType: 'json',
                                contentType: 'application/json',
                                data: JSON.stringify({ taskID: work[0] }),
                                async:false,
                                success: function (data) {
                                    if (data.d == "False") {
                                        document.getElementById("txtHours").disabled = false;
                                    }
                                    else {
                                       
                                        document.getElementById("txtHours").disabled = true;
                                    }
                                }
                            });
                            //End of Addition Vaijat K
                            $.each(JSON.parse(data), function (id, obj) {
                                //ArrDurHour.push({ Duration: obj.Duration });
                                //$("#DDLTask").append("<option id=" + ArrGetTask[i].TaskID + " value=" + ArrGetTask[i].TaskID + "|" + ArrGetTask[i].ActualWork + "|" + ArrGetTask[i].Work + "|" + obj.Duration + ">" + ArrGetTask[i].TaskName + "</option>");
                                ArrDuration.push({ taskid: work[0], hour: obj.Duration });

                                if (ArrDuration == "") {
                                    if (document.getElementById("txtHours") != null)
                                        document.getElementById("txtHours").value = "";
                                }
                                else {
                                    if (document.getElementById("txtHours") != null)
                                        document.getElementById("txtHours").value = ArrDuration[0].hour;
                                    MInsert = ArrDuration[0].hour;

                                }
                                TaskHour = ArrDuration[0].hour;
                                TotalHrV = ArrDuration[0].hour;
                                //alert(TotalHrV)
                            });
                            // alert(ArrDuration[0].hour)
                            //alert(work[1])
                          
                            if (document.getElementById("lblAllocatedWork") != null)
                                document.getElementById("lblAllocatedWork").innerHTML = work[2];
                            if (document.getElementById("lblActualWork") != null)
                                document.getElementById("lblActualWork").innerHTML = work[1];
                            IsTaskComplete = work[3];
                            voidTask = work[4];


                            MActualWork = work[1];


                            TaskID = work[0];
                            //MCheckIsMarkCompleteTask(TaskID);
                            for (var i = 0; i <= ArrDurationNew.length - 1; i++) {
                                //alert(parseFloat(work[0]) + 'sss' + ArrDurationNew + parseFloat(ArrDurationNew[i].taskid))
                                if (parseFloat(work[0]) != parseFloat(ArrDurationNew[i].taskid)) {
                                    //                        alert("Total " + parseFloat(ArrDuration[0].hour) + parseFloat(ArrDurationNew[i].hour))
                                    TotalHour = parseFloat(TotalHour) + parseFloat(ArrDurationNew[i].hour);

                                }
                            }


                        },
                        error: function (xhr) {
                            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                        }
                    });

                },
                error: function () {
                    // alert("Error")
                }
            });

            //End of addition by Yogesh J on 18-Mar-2016

        }

    }
//End Of Addition Vaijat K

    function SaveUpdateTask(EmpID, RoleID) {
        var Duration = document.getElementById("txtHours").value;
        //alert('CheckForTask: EmpID' + EmpID + ' SelectedDate' + GetMMddYYDate(SelectedDate) + ' TaskID' + TaskID + ' RoleID' + RoleID + ' Duration' + Duration + ' ProjID' + ProjID);
  
        CheckFortimeSheetExists(EmpID, GetMMddYYDate(SelectedDate), TID, RoleID, Duration);
   
   
    }

    function CheckFortimeSheetExists(EmployeeID, EntryDate, TaskID, RoleID, Duration, Token) {

        //Added and commented by Yogesh J on 18-Mar-2016 for to generate  Token

        //$.ajax({
        //    type: "GET",
        //    url: Path + "CheckDuplicateTimesheetRecord",
        //    data: { EmployeeID: EmployeeID, EntryDate: EntryDate, TaskID: TaskID, PKToken: Result.d },
        //    contentType: "application/json;charset=utf-8",
        //    dataType: "jsonp",
        //    success: function (data) {

        //        $.each(JSON.parse(data), function (id, obj) {
        //            var dailyActivity = obj.DailyActivityEntryID;


        //            if (dailyActivity != 0) {
        //                var para = { DailyActivityEntryID: dailyActivity, TaskID: TaskID, ProjectID: ProjID, EmployeeID: EmployeeID, RoleID: RoleID, EntryDate: EntryDate, Duration: Duration };

        //                InsertTimesheet(para);

        //            }
        //            else {
        //                var para = { TaskID: TaskID, ProjectID: ProjID, EmployeeID: EmployeeID, RoleID: RoleID, EntryDate: EntryDate, Duration: Duration };

        //                InsertTimesheet(para);


        //            }
        //        });
        //    }
        //});

        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'PM_dailyActivityMobile.aspx/SaveUpdateTask',
            data: JSON.stringify({ EmployeeID: EmployeeID, TaskID: TaskID }),
            success: function (Result) {

                $.ajax({
                    type: "GET",
                    url: Path + "CheckDuplicateTimesheetRecord",
                    data: { EmployeeID: EmployeeID, EntryDate: EntryDate, TaskID: TaskID, PKToken: Result.d },
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

            },
            error: function () {
                // alert("Error")
            }
        });

    }
    //End of addition by Yogesh Jalamkar 18-Mar-2016 for to generate  Token


    function InsertTimesheet(para) {

        var diff;
        $.ajax({
            type: "GET",
            url: Path + "InsertTimesheetEntry",
            data: para,
            contentType: "application/json;charset=utf-8",
            dataType: "jsonp",
            success: function (data) {
                alert("TimeSheet updated successfully");
                //ClearProjectTaskFields();
                //var mylist = document.getElementById("DDLTask");
                //var entity = mylist.options[mylist.selectedIndex].value;

                if (parseInt(document.getElementById("txtHours").value) > MInsert) {
          
                    diff = (parseInt(document.getElementById("txtHours").value)) - (parseInt(MInsert));
               
                    document.getElementById("lblActualWork").innerHTML = parseFloat(MActualWork) + parseFloat(diff);
                }
                else if (parseInt(document.getElementById("txtHours").value) < MInsert) {

                    diff = (parseInt(MInsert)) - (parseInt(document.getElementById("txtHours").value));
            
                    document.getElementById("lblActualWork").innerHTML = parseFloat(MActualWork) - parseFloat(diff);
                }
                MInsert = document.getElementById("txtHours").value;
                MActualWork = document.getElementById("lblActualWork").innerHTML;
            },
            error: function (xhr) {
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

            }
        });
    }
    function ValidateControls(empid, roleid) {

        //debugger;
        //    if ($("TxtHours").is(':focus')) {
        //       
        //    }
        //    else { 
        //        alert("Please Fill/Update the Hours")
        //    }
        if (document.getElementById("DDLProject").value == "0") {
            // document.getElementById("ErrorSpan").style.display = "block";
            alert("Please select Project Name");
            return false;
        }
        else {
            // document.getElementById("ErrorSpan").style.display = "none";
        }
        if (document.getElementById("DDLTask").value == "0" || document.getElementById("DDLTask").value == "") {
            //document.getElementById("ErrorSpan2").style.display = "block";
            alert("Please select Task Name");
            return false;
        }
        else {
            //document.getElementById("ErrorSpan2").style.display = "none";
        }
        if (document.getElementById("txtHours").value == "") {
            //document.getElementById("ErrorSpan3").style.display = "block";
            alert("Hours Field cannot be blank");
            return false;
        }
        else {
            //document.getElementById("ErrorSpan3").style.display = "none";
        }
        if (parseInt(document.getElementById("txtHours").value) == MInsert) {
            alert("You already filled this hour");
        }
        else {
            //if (document.getElementById("DDLProject").value != "0" && document.getElementById("DDLTask").value != "0" && document.getElementById("txtHours").value != "" && HourValidate(document.getElementById("txtHours").value)) {
            if (HourValidate(document.getElementById("txtHours").value))
                SaveUpdateTask(empid, roleid);
            //}
       
            //alert(TotalHour);
        }
    }

    function ClearProjectTaskFields() {
        if (document.getElementById("txtHours") != null)
            document.getElementById("txtHours").value = "";
        if (document.getElementById("DDLProject") != null)
            document.getElementById("DDLProject").value = "0";
        if (document.getElementById("DDLTask") != null)
            document.getElementById("DDLTask").value = "0";
        if (document.getElementById("lblAllocatedWork") != null)
            document.getElementById("lblAllocatedWork").innerHTML = "";
        if (document.getElementById("lblActualWork") != null)
            document.getElementById("lblActualWork").innerHTML = "";
    }

    function ClearTaskFields() {
        if (document.getElementById("txtHours") != null)
            document.getElementById("txtHours").value = "";
        if (document.getElementById("DDLTask") != null)
            document.getElementById("DDLTask").value = "0";
        if (document.getElementById("lblAllocatedWork") != null)
            document.getElementById("lblAllocatedWork").innerHTML = "";
        if (document.getElementById("lblActualWork") != null)
            document.getElementById("lblActualWork").innerHTML = "";
    }


    function HourValidate(val) {
        var AllocatedHr = document.getElementById("lblAllocatedWork").innerHTML;
        var ActualHr = document.getElementById("lblActualWork").innerHTML;
        TotalHour=0;
        //alert("TotalHour " + TotalHour + " Validate: " + parseFloat(document.getElementById("txtHours").value));
        TotalHour = TotalHour + parseFloat(document.getElementById("txtHours").value);
        var TotalActualHr = parseFloat(ActualHr) + parseFloat(document.getElementById("txtHours").value);
        var TotalActualHr1 = parseFloat(document.getElementById("txtHours").value);
        //alert(TotalHour+'asdasd'+parseFloat(document.getElementById("txtHours").value))
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
                        document.getElementById("txtHours").value = MInsert;
                        return false;
                    }
                    else {
               
                        if (CheckForWeekDaysHours(TotalHour)) {
                            return true;
                        }
                        else {
              
                            alert("You can book only 24 hours in a day you have already booked " + TotalHour + " hours.Your current entry will be adjusted to bring the total to 24");
                            document.getElementById("txtHours").value = MInsert;
                            TotalHour = parseInt(TotalHour) - parseInt(val);
                            return false;
                        }
               
                    }
                }
                 //Commented And Added By Vaijat K ON 05/02/2016 For Issue ID-3724
                //else if (parseFloat(diffActualHr) < parseFloat(AllocatedHr))
                else if (parseFloat(diffActualHr) <= parseFloat(AllocatedHr)) {
                //End of Addition Vaijat K
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
            //                document.getElementById("txtHours").value = MInsert;
            //                //MActualWork = document.getElementById("lblActualWork").innerHTML;
            //                return false;
            //            }
            //            else {

            //                if (CheckForWeekDaysHours(TotalHour)) {
            //                    return true;
            //                }
            //                else {
            //               
            //                    alert("You can book only 24 hours in a day you have already booked " + TotalHour + " hours.Your current entry will be adjusted to bring the total to 24");
            //                    document.getElementById("txtHours").value = MInsert;
            //                    TotalHour = parseInt(TotalHour) - parseInt(val);
            //                    return false;
            //                }
            //            }
            //            }

        }
   
        else if (val > 24) {
            document.getElementById("txtHours").value = MInsert;
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
        //        document.getElementById("txtHours").disabled = true;
        //        document.getElementById("BtnSaveUpdate").disabled = true;
        //    }
        //    else
        //    {
        //        document.getElementById("txtHours").disabled=false;
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
                url: path+"chk_disabledTimesheet", // Location of the service
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
    
                            document.getElementById("txtHours").disabled = true;
                            document.getElementById("BtnSaveUpdate").disabled = true;
                        }
                        else
                        {
                            document.getElementById("txtHours").disabled=false;
                            document.getElementById("BtnSaveUpdate").disabled=false;
                        }
                    });                                     
                                            
                        
                },
                error: function (xhr) {
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        } catch (exception) { }
    }

    /************************** FUNCTIONS ******************************/

    function ShowPrevWeek(dt) {
        flag = 0;
        getCurrentWeek(GetPrevDate(dt));
        getCurr
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
                    document.getElementById("txtHours").value = "";
                }

            }
            else {
                document.getElementById("txtHours").value = "";
            }
        }
        else {
            alert('Please Enter Numeric Value');
            document.getElementById("txtHours").value = TotalHrV;
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