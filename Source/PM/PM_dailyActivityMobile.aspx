<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_dailyActivityMobile.aspx.vb" Inherits="PbNIT.PM_dailyActivityMobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!--Including files & Libraries by Miiint Solutions-->
    <%CommonFunctions.General.PlotPageHeadTag("")%>

    
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="X-UA-Compatible" content="IE=5,8,9,11"/>
    <meta http-equiv="X-UA-Compatible" content="chrome=1"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <meta charset="UTF-8"/>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <link href="../General/Stylesheet_Whiz_Mobile.css" rel="stylesheet" />
    <script src="../../responsive/Scripts/Pmlifeline.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/grid.locale-en.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/jquery.jqGrid.src.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/pop.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/modernizr.js" type="text/javascript"></script>
<!-- <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script> -->
    <script src="../../responsive/Scripts/jquery.mmenu.min.all.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/WeeklyCalendar.js" type="text/javascript"></script>
    <!-- <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <script src="../General/CommonFunctions.js"></script> -->
    <link href="../../responsive/Content/MobileCss.css" rel="stylesheet" />
  


</head>


<style type="text/css">
    /*Added By Vaijat K ON 05/02/2016 For Highlight Selection*/
    table {
        border-collapse:separate !important;
    }
    /*End of Addition Vaijat K*/
    /*****added by tejal deshmukh,  purpose:caldender responsive************/
    hr { 
    display: block;
    margin-top: 0.5em;
    margin-bottom: 0.5em;
    /*margin-left: auto;*/
    /*margin-right: auto;*/
    border-style: inset;
    border-width: 0.1px;
    border-color:black;
}
    .baground {
        background-image: url("../../imgL/WeekendNew.gif") !important; /* code use on weekly.js page for bg img(weeekend)*/
        background-repeat: no-repeat;
        background-size: 100% 100%;
    }

    table {
        /*background-color: white;*/
        cursor: pointer;
     border:#e39321;
    }

    body {
        overflow-x: hidden;
        overflow-y: hidden;
    }

    #calendarTable, TD, TH {
        text-align: center;
        height: 55px;
        width: 42px;
        font-size: 12px;
    }

    #calendarTable, td {
        padding-top: 10px;
        padding-bottom: 0px;
    }

        td:empty {
            background-image: none;
        }

    /*a {
        text-decoration: underline;
        color: hotpink;
    }*/


    .corner {
        /*display: table-cell;*/
        vertical-align: bottom;
        text-align: right;
        margin: 0px;
        font-size: 10px !important;
        padding-top: 6px !important;
        margin: 0;
        bottom: 0;
    }

   

    #imgLink {
        margin-left: 4px;
        padding-bottom: 3px;
    }

    #link {
        /*float:left;
       text-align:left;
        padding-top:50px;
        padding-bottom:10px;
        padding-left:30px;
        /*padding-right:-10px;*/
        /*width:18%;*/
        height: 5%;
        position: absolute;
        background: #e39321;
    }


    #legend {
        /*
        text-align:right;
        width: 100%;
        height:50%;
        padding-top:10px;
        padding-right:50px;*/
        padding-left: 20px;
        float: right;
        padding-bottom: 5px;
        font-size: 11.5px;
    }
  
    /*purpose:media tag according to mobile resolution */

    @media (min-width: 320px) and (max-width:480px) {
        #calendarTable, TD, TH {
            text-align: center;
            height: 10px;
            width: 30px;
            font-size: 11px;
        }

        #imgLink {
            margin-left: 0px;
            padding-bottom: 3px;
        }

        #link {
            /*width:24%;*/
            height: 2%;
            background: #e39321;
            position: absolute;
        }

        #legend {
            font-size: 5px !important;
        }

        #calendarTable, td {
        padding-top: 4px;
        padding-bottom: 0px;
      }
    }

    @media (min-width: 320px) and (max-width:568px) /*iphone 5*/
    {
        #link {
            /*width:24%;*/
            height: 5%;
            background: #e39321;
            position: absolute;
        }

        #calendarTable, TD, TH {
            text-align: center;
            height: 32px;
            width: 30px;
            font-size: 10px;
        }
        #calendarTable, td {
        padding-top: 4px;
        padding-bottom: 0px;
      }
        .corner {
            /*display: table-cell;*/
            vertical-align: bottom;
            text-align: right;
            margin: 0px;
            font-size: 8px !important;
            /*padding-top: 3px !important;*/
            margin: 0;
            bottom: 0;
        }

        #imgLink {
            margin-left: 0px;
            padding-bottom: 3px;
        }

        #legend {
            font-size: 9.5px !important;
        }

       

    }

    @media (min-width: 375px) and (max-width:667px) /*iphone 6*/
    {
        #legend {
            /*
        text-align:right;
        width: 100%;
        height:50%;
        padding-top:10px;
        padding-bottom:30px;
        padding-right:50px;*/
            padding-right: 5px;
            float: right;
        }

        
    }

    @media (min-width: 360px) and (max-width:640px) /*galax S5*/
    {
        #legend {
            padding-right: 0px;
            float: right;
            font-size: 11px !important;
        }

        #link {
            /*float:left;
       text-align:left;
        padding-top:50px;
        padding-bottom:10px;
        padding-left:30px;
        /*padding-right:-10px;*/
            /*width:22%;*/
            height: 5%;
            background: #e39321;
            position: absolute;
        }
        #calendarTable, TD, TH {
            height: 33px !important;
            font-size: 10px;
        }
       
    }

    @media (min-width: 414px) and (max-width:736px) {
        #legend {
            padding-right: 0px;
            font-size: 12px !important;
        }

        #calendarTable, TD, TH {
            text-align: center;
            height: 50px;
            width: 35px;
            font-size: 12px;
        }
        

    }

    @media (min-width: 435px) and (max-width:773px) {/* 6P*/
        #legend {
            /*
        text-align:right;
        width: 100%;
        height:50%;
        padding-top:10px;
        padding-bottom:30px;
        padding-right:50px;*/
            padding-right: 0px;
            float: right;
            font-size: 13px !important;
        }

        #calendarTable, TD, TH {
            text-align: center;
            height: 52px !important;
            width: 30px;
            font-size: 12px !important;
        }

        #link {
            /*width:24%;*/
            height: 7%;
            background: #e39321;
            position: absolute;
            margin-left:3%;
            padding-top:1%;
        }
    }
    @media (min-width: 435px) and (max-width:773px) {

        #calendarTable, TD, TH {
            font-size: 11px!important;

        }

    }

/******ended media tag according to mobile resolution*******/
 .rightCorner { vertical-align: bottom;
        text-align: left;
    }
           
            /***********ended by tejal**********************/
   .ui-datepicker
{
        width: 98%;
        padding: .2em .2em 0;
        display: none;
        background-color: white;
    }

    pre {
        margin: 0;
    }

    .ui-state-default, .ui-widget-content .ui-state-default {
        font-weight: normal;
    }

    .ui-jqgrid .ui-jqgrid-htable th div {
        overflow: hidden;
        position: relative;
        height: 37px;
    }

    #jqgh_ProjectlistGrid_Work {
        padding-top: 10px;
    }

    #jqgh_ProjectlistGrid_ActualWork {
        padding-top: 10px;
    }

    #jqgh_ProjectlistGrid_TaskName {
        padding-top: 10px;
    }

    #FFE29587WHIZ_txtDate {
        padding-top: 0px !important;
    }
    /*Added by Nilesh g on 5/12/2015 for issue id 2629*/
    table {
        width: 95% !important;
        height: 95%!important;
    }

    body {
        border: none!important;
        margin-left: 0px!important;
        margin-right: 0px!important;
    }
    /*Added By Vaijat K ON 31/12/2015*/
    .center-caption {
        margin-top: 2%;
        text-align: center;
        width: 100%;
    }

    #DivCustomTimeSheet {
        margin-top: 12px !important;
        /*font-size:14px;*/
    }

    body {
        font-size: 12px !important;
    }

    /*table td {
            font-size: 13px;
        }*/

    .ui-bar-a, .ui-page-theme-a .ui-bar-inherit, html .ui-bar-a .ui-bar-inherit, html .ui-body-a .ui-bar-inherit, html body .ui-group-theme-a .ui-bar-inherit {
        background-color: white!important;
    }

    .ui-select .ui-btn > span:not(.ui-li-count) {
        white-space: normal !important;
    }
    /*ENDED*/
    label {
        display: inline-block;
        margin-bottom: 5px;
        font-weight: normal;
        font-size: 12px;
        /*padding-top: 11%;
        margin-right: 3%;*/
    }

    #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 60%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
        width: 100px;
        height: 100px;
        /*z-index: 99;
            height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
    }

    #fillDiv {
        opacity: 0.95;
        background-color: ghostwhite;
        /*DISPLAY: none;*/
        Z-INDEX: 100;
        LEFT: 0px;
        VISIBILITY: visible;
        WIDTH: 100%;
        POSITION: absolute;
        TOP: 0px;
        HEIGHT: 100%;
        float: right;
    }
</style>
<script type="text/javascript">
  
    // Added by Kiran for Loader 2/11/15
    function setFrameLoaded() {
        //Added by swapnil aswale on 14-12-2015 for Mulitple Login
        
        //Ended

        //Added by swapnil aswale on 14-12-2015 for Mulitple Login
        //$("#frmMain").contents().find("#frmSub").find("a").click(function(){
        //    $.ajax({url: "MultipleLogin.aspx", success: function(result){

        //    }});

        //});
        //Ended 
        //Added by swapnil aswale on 14-12-2015 for Mulitple Login
        jQuery("#preloader").fadeOut("slow");
        jQuery("#fillDiv").fadeOut("slow");
        jQuery("#preloader").remove();
        jQuery("#fillDiv").remove();
        //=====================//
        jQuery("#preloader").remove();
        jQuery("#fillDiv").remove();
        //===========================
        RemoveFrameLoader();
    }
    function setFrameLoader() {

        $("HTML").append("<div id='preloader'></div>");
        $("HTML").append("<div id='fillDiv'></div>");
    }
    function RemoveFrameLoader() {
        jQuery("#preloader").remove();
        jQuery("#fillDiv").remove();
        jQuery("#preloader").fadeOut("slow");
        jQuery("#fillDiv").fadeOut("slow");
        jQuery("#preloader").remove();
        jQuery("#fillDiv").remove();
    }

    //End by KIran for Loader 2/11/15
</script>
<!-- Ended by swapnil a on 17-06-2015 Purpose:TimesheetResponsive-->
<script language="javascript">
    //code shifted to declare dblPreviousHours before PageInit() method
    var dblPreviousHours = 0;
   
</script>

<script type="text/javascript">
   
    $(document).ready(function(){
        $("a").click(function () {
            $.ajax({
                url: "../Home/MultipleLogin.aspx", success: function (result) {

                }
            });
            $("#link").hide();
        });

     $.ajax({
            type: 'POST',
            url: 'PM_dailyActivityMobile.aspx/GetRoleAccess',
            dataType: 'json',
            data: JSON.stringify({ intUserID: '<%=Session("intUserID")%>' }),
            contentType: 'application/json;charset-utf=8',
            success: function (Result) {
                if (String(Result.d) == "1"){
                    
                }
                else{
                    document.getElementById("divAccess").style.display = "block"
                    document.getElementsByClassName('MenuContent')[0].style.display = 'none';
                    
                }
            }
        });  
                                
        setTimeout(function(){ setFrameLoaded(); },1000);

        var m_blnProjectBackdateEntry = "";
        var m_blnProjectFwddateEntry = "";
        $("#DDLProject").change(function(){
            $.ajax({
                type: 'POST',
                url: 'PM_dailyActivityMobile.aspx/GetTimesheetDetailsforEntryDate',
                dataType: 'json',
                data: JSON.stringify({ m_strProjectID: $("#DDLProject").val() }),
                contentType: 'application/json;charset-utf=8',
                success: function (Result) {
                    var strResult = String(Result.d);
                    strResult = strResult.split(",");
                    m_blnProjectBackdateEntry = strResult[0];
                    m_blnProjectFwddateEntry = strResult[1];
                }
               
            });
            // GetTimesheetDetailsforEntryDate();
        });
        $("#txtHours").blur(function(){
            Hours_OnChange('<%=EXPIRY_OF_TASK%>','<%=EXPIRY_OF_TASK_FORWARD%>',m_blnProjectBackdateEntry,m_blnProjectFwddateEntry)
        });
    });
    function Hours_OnChange(intBackDate, intForwardDate, m_blnProjectBackdateEntry, m_blnProjectFwddateEntry) {
        if (document.getElementById("DDLProject").value == "0") {
        }
        else if (document.getElementById("DDLTask").value == "0" || document.getElementById("DDLTask").value == "") {
        }
        else  if (document.getElementById("txtHours").value == "") {
        }
        else{
            var objTextBox = document.getElementById("txtHours")
            intBackDating = intBackDate;
            intFwdDating = intForwardDate;
            strProjectBackdateEntry = m_blnProjectBackdateEntry;
            strProjectFwddateEntry = m_blnProjectFwddateEntry;
            objEntryDate = document.getElementById('bDate')
            objEntryDate = objEntryDate.innerHTML;
            if (intBackDating.length != 0) {
                if (strProjectBackdateEntry != "True") {
                    if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate, '', "rev")), intBackDating, 0, 0), new Date('<%=Date.Now().toString()%>'), "d") > 0) {
                        alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
                        objTextBox.value = "";
                        //dblHours[intRow][intCol] = -1;
                        return;
                    }
                }
            }

            if (intFwdDating.length != 0) {
                if (strProjectFwddateEntry != "True") {
                    if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate, '', "rev")), -(intFwdDating - 0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0) {
                        alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
                        objTextBox.value = "";
                        //dblHours[intRow][intCol] = -1;
                        return;
                    }
                }
            }
        }
}
$(function () {

    $('nav#menu').mmenu();
    $("#mm-blocker").css("position","absolute");
    $("#menu").css("position", "absolute");
    //  $("#mm-0").before("<div style='width:100%;height:100%;background:#FDF4E8'></div>");
    jQuery("#mm-0").before("<div style='width:100%;height:20%;background-image: url(../../img/1920/OpenVCE-Poster-Gold-Background.jpg);'> <table style='margin-left:5%'><tr><td> <img id='imgEmployee' src='../../img/1920/no-photo.png' alt='No Image' style='margin-top:20px;width:75px;height: 75px;margin-right: 9%;' align='right' /></td><td><label id='cpName' style=color='white';font-weight:100' class='cpHome'></label><br><label id='cpRole' style='font-weight:100' class='cpHome'></label> </td></tr></table> </div>")
    $.ajax({
        type: 'POST',
        dataType: 'JSON',
        contentType: 'application/json',
        url: '../General/Navigation.aspx/GetEmployeeImagePath',
        data: JSON.stringify({ intEmployeeID: "<%=Session("intUserID")%>" }),
        success: function (Result) {
            if (String(Result.d) != "") {
                document.getElementById("imgEmployee").src = Result.d;
                document.getElementById("imgEmployeeHome").src = Result.d;
            }
        }
    });
    $('#cpName').text('<%=Session("strUserName")%>');
    $('#cpRole').text('<%=Session("RoleDesc")%>');
});
function logout() {
    window.location.href = '<%= ResolveUrl("../../default.aspx") %>';
}
//$(document).ready(function(){ 
//    $("a").click(function () {

//    $.ajax({
//        url: "../Home/MultipleLogin.aspx", success: function (result) {

//        }
//    });
//});});
         
var path='<%=ConfigurationManager.AppSettings("WCFTimesheetMServicePath").ToString()%>';
  
             
    // Code Added by swapnil a on 17-06-2015 Purpose:TimesheetResponsive
           
    jQuery(document).ready(function ()
    { 
        //debugger;
        if ($(window).width() <= 768) {
           
          
            // document.getElementById('divMenuContent').style.height = window.innerHeight  + "px";
            document.getElementById('divMenuContent').style.height = window.innerHeight - 289 + "px";
             
            //document.getElementById('DivCustomTimeSheet').style.height = window.innerHeight - 260+"px";
                
            $('#lbl_user').text('<%=Session("strUserName")%>'+ "("+ '<%=Session("RoleDesc")%>'+ ")");
					      
          
                   
         var intDivHeight = window.innerHeight -411;
         if (intDivHeight < 257)
             intDivHeight =247;


            //$("#divMenuContent").css("height",intDivHeight + 'px');
            /*Ended*/
					      
         //para={intUserID:'<%=Session("intUserID")%>',strLoginType:"E"};
                //GetProjectListForEmployee();
            }
					      
        
        	      
    });

        function GetProjectListForEmployee(EntryDate)
        {    
            //Added By Vaijat K ON 28/04/2016 For Project Listing Day Wise
            var strDate = new Date(EntryDate).toJSON();
            //End of addition vaijat k
            var par = {intUserID:'<%=Session("intUserID")%>',strLoginType:"E",dtmEntryDate:strDate}
            try {
                                
                $.ajax({
                    type: "GET", //GET or POST or PUT or DELETE verb
                    url: path+"GetProjectListForTimesheet", // Location of the service
                    data: par,
                    contentType: "application/json;charset=utf-8", // content type sent to server
                    dataType: "jsonp", //Expected data format from server
                    success: function (data) {//On Successfull service call 
                        $("#DDLProject").html('');
                        $("#DDLTask").html('');
                        $("#DDLProject").append("<option value='0' selected='selected'>Select Project</option>");
                        $("#DDLTask").append("<option value='0' selected='selected'>Select Task</option>");
                        var JsonData = JSON.parse(data)
                        
                        $.each(JSON.parse(data), function (id, obj) 
                        { 
                            $("#DDLProject").append("<option value="+obj.ProjectID+">"+obj.ProjectName+"</option>");
                        });
                        if (JsonData.length == 1)
                        {
                            document.getElementById("DDLProject").selectedIndex = 1;
                            GetAssignedTaskDayWise($("#DDLProject").val(),<%=Session("intUserID")%>,<%=Session("intRoleLevel")%>,'<%=m_PKToken%>')
                        }
                        
                    },
                    error: function (xhr) {
                        alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                    }
                });
                document.getElementById("DDLProject").value = "0";
            } catch (exception) { }

        }
        $(window).resize(function(){
            /*Added By Vaijat K ON 31/12/2015*/
            var intDivHeight = window.innerHeight - 411;
            if (intDivHeight < 257)
                intDivHeight =257;
            //$("#divMenuContent").css("height",intDivHeight + 'px');
            /*Ended*/
                  
                 

        });
            
        // Ended by swapnil a on 17-06-2015 Purpose:TimesheetResponsive
        $("#txtHours").blur(function(){
                
        });


    // *added by tejal deshmukh purpose: calender Responsive****//  
        

        jQuery(document).ready(function () {
       
             $('#DivCustomTimeSheetNew').hide(); //week view div id  
             $('#link').hide();
            // $('#taskInfoDisply').hide(); //------------
             $('#taskInfo').hide();
             
              var counter;
             var  TaskName;
            emptyClick();
            cellClick()
            chekLeaves()
            halfDay()
            chekCount()
            plannedTaskColor()
           companyHoliday()
            showHoliday()
            todayDate()
            HideDiv()
            divCounter_Click()
            //focus_CurrentDate()
            $('#sel').change(function() //#sel id of month dropdown
            { 
                emptyClick();
                cellClick()
                chekLeaves()
                halfDay()
                chekCount()
                plannedTaskColor()
                companyHoliday()
                showHoliday()
                $('#taskInfo').hide();
                todayDate()
                divCounter_Click()
                })
            $('#sel2').change(function()   //#sel id of year dropdown
            {  
                emptyClick();
                cellClick()
                chekLeaves()
                halfDay()
                chekCount()
                plannedTaskColor()
                companyHoliday()
                showHoliday()
                $('#taskInfo').hide();
                todayDate()
               divCounter_Click()
                
            })
            $('#tableBody').dblclick(function() //(dblclick)
            {
                $('#legend').hide();
                $('#link').hide();
                $('#divrem').hide();
            })
      
           
            $('#imgBack').click(function() //
            {
                $('#legend').show();
                $('#link').hide();
                $('#divrem').show();
                GoToMainWeek(flag_1);
               $('#taskInfo').hide();//-----------
            })   
        
       
            $('#DivCustomTimeSheetNew').click(function()
            {
                $('#DivCustomTimeSheetNew').show(); 
                $('#DivCustomTimeSheet').show();
                //$('#divrem').hide();
                $('#link').hide();
            })

           
            $('#MonthlyViewL2').click(function() // id of link monthly view
            {
            
                // $('#DivCustomTimeSheet').hide();
                //$('#led').show();
                $('#legend').show();
                $('#link').hide();
                $('#taskName').text("");
                $('#TaskNameLb').text("");
                $('#HolidayName').text("");
                $('#HolidayNameLb').text("");
                $('#birthday').text("");
                $('#birthdayLb').text("");
                //todayDate();
                //divCounter_Click();
            })

            $('#WeekViewL1').click(function() // id of link weekly view 
            {
                $('#legend').hide();
                $('#link').hide();
                $('#taskInfo').hide();
            })
            //$('#divrem').click(function(){
            //    $('#link').hide();
            //})
          

            //****************on mouse leave or click outside <div #link> will hide******//
            $("#link").mouseleave(function(){
                $(this).hide();
            });
            $('#legend').click(function() 
            {
                $('#link').hide();
            })

            $('#tbldropdown').click(function() 
            {
                $('#link').hide();
            })

            $('#tableHeader').click(function() 
            {
                $('#link').hide();
            })

            $('#sel').click(function() 
            {
                $('#link').hide();
            })
            $('#sel2').click(function() 
            {
                $('#link').hide();
            })

            $('#PreMonth').click(function() 
            {
                $('#link').hide();
            })
            $('#NextMonth').click(function() 
            {
                $('#link').hide();
            })
            //*******End  mouse leave or click outside <div #link> will hide******//
           
           
            
            });

    //*****purose :function for calender responsive***//
        //function taskInfo_click()
        //{
        //    document.getElementById('calendar').style.display="block";
        //        $('#legend').hide();
        //        $('#link').hide();
        //        $('#divrem').hide();
        //        $("#calendarTable").hide();
               
           

        //}

        
       function buttonClick() //on click of imgLink 
        {
            document.getElementById('link').style.display = "block";
           
        }

        
       //function divCounter_Click(id) //old one t90 click
       //{
       //     document.getElementById('taskInfo').style.display = "block";  
                
       //         taskNameDisplay(id);
       //         showHolidayName(id);
           
       //}
   
       function divCounter_Click(){
           //Commented By Vaijat K ON 28/04/2016 
           //$("#tableBody td").click(function(){
              
           //    var T=$( this ).text();
           //    var td=T.split("T");
           //   var tdate=td[0];
           // document.getElementById('taskInfo').style.display = "block";  
              
           //    taskNameDisplay(tdate);
           //    showHolidayName(tdate);
           //  // birthday_OfEmployee(tdate);
           //})
           //End of comment Vaijat K
       }
   
        function HideDiv()  
        {
            $('#tableBody td').dblclick(function()
            {
                $('#divrem').hide();
        
            })
       
        }
        var emptyCell = 0;

        function emptyClick() // purpose:stop empty cell click event
        {
            
       
            $("#tableBody td:empty").click(function(e)
            {  
                try{
                    $(this).each(e.stopPropagation());
                }
                catch(exception)
                {
                }
            });
            $("#tableBody td:empty").dblclick(function(e)
            {   $(this).each(e.stopPropagation());
            });
        } 
        var touchtime = 0;
        function cellClick()//-----------
        {  
            //Commented And Added By Vaijat K ON 28/04/2016 For Mobile Double Click Event
            //$("#tableBody td").dblclick(function () {
            //        emptyClick();
            //        getval($(this));
            //        $("#calendarTable").fadeOut("slow", function () { document.getElementById("DayView").style.display = 'block'; });
            //        $('#taskInfo').hide();
            //});

            $('#tableBody td').on('click', function() {
                $('#tableBody td').css("box-shadow","none");
                if(touchtime == 0) {
                    //set first click
                    touchtime = new Date().getTime();
                } else {
                    //compare first click to this click and see if they occurred within double click threshold
                    if(((new Date().getTime())-touchtime) < 200) {
                        //double click occurred
                        document.getElementById('taskInfo').style.display="none";
                        getval($(this));
                        $("#calendarTable").fadeOut("slow", function () { document.getElementById("DayView").style.display = 'block'; });
                        $('#legend').hide();
                        $('#link').hide();
                        $('#divrem').hide();
                        touchtime = 0;
                    } else {
                        //not a double click so set as a new first click
                        touchtime = new Date().getTime();
                        var T=$( this ).text();
                        var td=T.split("T");
                        var tdate=td[0];
                        document.getElementById('taskInfo').style.display = "block";  
                        $(this).css("box-shadow","2px 2px 2px 2px #CCC")
                        taskNameDisplay(tdate);
                        showHolidayName(tdate);
                    }
                } 
            });
            //End of Addition Vaijat K
    }
       
       
        function showHoliday()    //purpose:ajax call to GetCountryDetails() to set start day and week days
        { 
             
             
            $.ajax({
                type: "POST",
                url: "PM_dailyActivityMobile.aspx/DayChek", 
                contentType: "application/json;charset=utf-8",
                dataType: "json", 
                success: function (data)      {
                         
                   
                    //   GetCountryDetails(data.d);        
                    //alert(data.d);
                    GetCountryDetails(data.d[0],data.d[1]); 
                    //var W= ( data.d[1]);
                }
                
            }); 
           
        }
   
   
        function  companyHoliday()    //purpose: company declred holiday will show in color
        { 
            var arr = [];
            
            var tbl = document.getElementById("calendarTable");
            
            if (tbl != null) {

                for (var i = 3; i < tbl.rows.length; i++) {

                    for (var j = 0; j < tbl.rows[i].cells.length; j++) {
                        var H1 = (tbl.rows[i].cells[j].innerHTML);
                        tbl.rows[i].cells[j].style.color="black";
                        //alert(H1);
                        var M = $('#sel :selected').text();

                        var Y = $('#sel2 :selected').text();

                        var H2 = H1 + " " + M + " " + Y;
                        // alert(H2);
                        //arr[i] = H2;
                        if(H1 != "")
                        {
                            arr.push(H2);
                        }
                  
                    
                    }
                }
            }

            $.ajax({
         
           
                type: "POST",
                url: "PM_dailyActivityMobile.aspx/HolidayChek",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ DateHoliday: arr}),

                success: function (data) {
              
                    var sub;
                    var str = String(data.d).split(",");
                    //JSON.parse(data.d);
                     
                    for(var i=0;i<str.length;i++)
                    {
                        // alert(str[i]);
                        // sub=str[i].substring(1," ");
                        sub=  str[i].substring(0,str[i].indexOf(' '));
                        if(sub!=""){
                            //alert (sub);
                            document.getElementById("" + sub).style.backgroundImage="url('../../imgL/HolidayNew.gif')";
                            document.getElementById("" + sub).style.backgroundSize="100% 100%";
                            document.getElementById("" + sub).style.backgroundRepeat="no-repeat";

                            //for (var k = 3; k < tbl.rows.length; k++) {
                            //    for (var j = 0; j < tbl.rows[k].cells.length; j++) {
                            //        var H3 = (tbl.rows[k].cells[j].innerHTML);
                            //        if(H3==sub)
                            //        {
                            //            if(H3!="")
                            //            {
                            //                // $(tbl.rows[k].cells[j]).css('color','#8000ff');
                            //                tbl.rows[k].cells[j].style.backgroundImage="url('../../imgL/Holiday.gif')";
                            //                tbl.rows[k].cells[j].style.backgroundSize="100%";
                            //            }
                            //        }
                            //    }
                            //}
                        }
                    }
                },                            
                  
                //error: function () { alert(" session expired plz login"); }
                   
            });
        }
    //Added By Vaijat K ON 05/02/2016 For Numeric Validation
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    //End of Addition Vaijat K

        function chekLeaves() //purpose:according to login user it will chek approved leaves having type 2 and show in color
        {
            //debugger;
            var arr1 = [];
            // debugger;
            var tbl = document.getElementById("calendarTable");
            
            if (tbl != null) {

                for (var i = 3; i < tbl.rows.length; i++) {

                    for (var j = 0; j < tbl.rows[i].cells.length; j++) {
                        var H4 = (tbl.rows[i].cells[j].innerHTML);
                        tbl.rows[i].cells[j].style.color="black";
                        //alert(H1);
                        var M = $('#sel :selected').text();

                        var Y = $('#sel2 :selected').text();

                        var H5 = H4 + " " + M + " " + Y;
                   
                        if(H4 != "")
                        {
                            arr1.push(H5);
                        }
                        //alert(arr);
                    
                    }
                }
            }
            $.ajax({
         
           
                type: "POST",
                url: "PM_dailyActivityMobile.aspx/LeavesChek",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({intUserID:'<%=Session("intUserID")%>', DateHoliday1: arr1}),

                success: function (data) {
                    //alert(data.d);
                    var sub1;
                    var str1 = String(data.d).split(",");
                    //JSON.parse(data.d);
                     
                    for(var i=0;i<str1.length;i++)
                    {
                        
                        sub1=  str1[i].substring(0,str1[i].indexOf(' '));
                        if(sub1!=""){
                            document.getElementById("" + sub1).style.backgroundImage="url('../../imgL/WeekendNew.gif')";
                            document.getElementById("" + sub1).style.backgroundSize="100% 100%";
                            document.getElementById("" + sub1).style.backgroundRepeat="no-repeat";
                            //alert (sub);
                            //for (var m = 3; m < tbl.rows.length; m++) {
                            //    for (var j = 0; j < tbl.rows[m].cells.length; j++) {
                            //        var H4 = (tbl.rows[m].cells[j].innerHTML);
                            //        if(H4==sub1)
                            //        {
                            //            if(H4!= "")
                            //            {
                            //                // $(tbl.rows[m].cells[j]).css('color','red');
                            //                tbl.rows[m].cells[j].style.backgroundImage="url('../../imgL/weekend.gif')";
                            //                tbl.rows[m].cells[j].style.backgroundSize="100%";
                            //            }
                            //        }
                            //    }
                            //}
                        } }
            
                },                            
                       
                // error: function () { alert("session expired plz login"); }
            });

        }

        function halfDay()     //purpose:will show the half day in pink color
        {
           
            var arr1 = [];
      
            var tbl = document.getElementById("calendarTable");
            
            if (tbl != null) {

                for (var i = 3; i < tbl.rows.length; i++) {

                    for (var j = 0; j < tbl.rows[i].cells.length; j++) {
                        var H4 = (tbl.rows[i].cells[j].innerHTML);
                        // tbl.rows[i].cells[j].style.color="black";
                        //alert(H1);
                        var M = $('#sel :selected').text();

                        var Y = $('#sel2 :selected').text();

                        var H5 = H4 + " " + M + " " + Y;
                   
                        if(H4 != "")
                        {
                            arr1.push(H5);
                        }
                        //alert(arr);
                    
                    }
                }
            }
            $.ajax({
         
           
                type: "POST",
                url: "PM_dailyActivityMobile.aspx/HalfDayChek",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({intUserID:'<%=Session("intUserID")%>', DateHoliday2: arr1}),

                success: function (data) {
                    //alert(data.d);
                    var sub1;
                   
                    var str1 = String(data.d).split(",");
                    //JSON.parse(data.d);
                
                    for(var i=0;i<str1.length;i++)
                    {//debugger;
                        
                   
                        sub1=  str1[i].substring(0,str1[i].indexOf(' '));
                    
                        //alert(sub1);
                        if(sub1!=""){
                            document.getElementById("" + sub1).style.backgroundImage="url('../../imgL/HalfDayNew.gif')";
                            document.getElementById("" + sub1).style.backgroundSize="100% 100%";
                            document.getElementById("" + sub1).style.backgroundRepeat="no-repeat";
                            //for (var k = 3; k < tbl.rows.length; k++) {
                            //    for (var s = 0; s < tbl.rows[k].cells.length; s++) {
                            //        var H4 = (tbl.rows[k].cells[s].innerHTML);
                            //        if(H4==sub1)
                            //        {
                            //            if(H4!="")
                            //            {
                                    
                            //                tbl.rows[k].cells[s].style.backgroundImage="url('../../imgL/HalfDay.gif')";
                            //                tbl.rows[k].cells[s].style.backgroundSize="100%";
                            //            }
                            //        }
                            //    }
                            //}
                        }}
            
                },                            
                       
                //error: function () { alert("session expired plz login"); }
            });


        }



        
    
    function chekCount()                //purpose: show assigned task counter on dates until its not complte 
    {
        // debugger;
        var arr3 = [];
        var tbl = document.getElementById("calendarTable");
            
        if (tbl != null) {

            for (var i = 3; i < tbl.rows.length; i++) {

                for (var j = 0; j < tbl.rows[i].cells.length; j++) {
                    var H8 = (tbl.rows[i].cells[j].innerHTML);
                    
                    //alert(H6);
                    var M = $('#sel :selected').text();

                    var Y = $('#sel2 :selected').text();

                    var H9 = H8 + " " + M + " " + Y;
                    // alert(H2);
                    //arr[i] = H2;
                    if(H8 != "")
                    {
                        arr3.push(H9);
                    }
                    //alert(arr);
                    
                }
            }
        }
        $.ajax({
            type: "POST",
            url: "PM_dailyActivityMobile.aspx/ChekTaskCount",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({intUserID:'<%=Session("intUserID")%>', DateHoliday3: arr3}),
                success: function (result) {
                    
                    $.each(JSON.parse(result.d), function (id, val) {
                        //alert(val.isTaskCount);
                        counter=val.isTaskCount;
                        var str1;
                        //alert(val.Date);
                        str1= val.Date.split(" ");
                        //alert(str1[0]);
                       
                        var sub1=str1[0];
                       
                        //alert(sub1);
                        if(sub1!=""){
                           // debugger;
                            $("#" + sub1).append('<div class=corner id="counter" title="You have '+counter+' Tasks are Open .Close if task is over"><b><font size="2"><sub>T</sub></font></b>'+counter+'</div>')
                            //for (var m = 3; m < tbl.rows.length; m++) {
                            //    for (var j = 0; j < tbl.rows[m].cells.length; j++) {
                            //        var H4 = (tbl.rows[m].cells[j].innerHTML);
                            //        if(H4==sub1)
                            //        {
                            //            if(counter>0)
                            //            {
                            //                //debugger;onclick="divCounter_Click('+sub1+')"
                                           
                            //                //$(tbl.rows[m].cells[j]).append('<div class=corner><sub>T</sub>1</div>')
                            //                $(tbl.rows[m].cells[j]).append('<div class=corner id="counter" title="You have '+counter+' Tasks are Open .Close if task is over" onclick="T90()"><b><font size="2"><sub>T</sub></font></b>'+counter+'</div>')
                                       
                                       
                            //            }
                            //        }
                            //    }
                            //}
                            //alert(sub1);
                        }
                    });
                   
                } ,
                // error: function () { alert(" session expired plz login"); }
                   
            });  
        }

        //var myvar=0;
        function plannedTaskColor() // purpose:on which date task has planned will show task bg img
        {
            
            //debugger;
            //myvar=1;
            var arr3 = [];
            var tbl = document.getElementById("calendarTable");
            
            if (tbl != null) {

                for (var i = 3; i < tbl.rows.length; i++) {

                    for (var j = 0; j < tbl.rows[i].cells.length; j++) {
                        var H8 = (tbl.rows[i].cells[j].innerHTML);
                    
                        //alert(H6);
                        var M = $('#sel :selected').text();

                        var Y = $('#sel2 :selected').text();

                        var H9 = H8 + " " + M + " " + Y;
                        // alert(H2);
                        //arr[i] = H2;
                        if(H8 != "")
                        {
                            arr3.push(H9);
                        }
                        //alert(arr);
                    
                    }
                }
            }
            $.ajax({
               

                type: "POST",
                url: "PM_dailyActivityMobile.aspx/PlannedTask",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({intUserID:'<%=Session("intUserID")%>', DateHoliday3: arr3}),

                success: function (data) {
                    //debugger;
                    var sub1;
                    var str1 = String(data.d).split(",");
                   
                    for(var i=0;i<str1.length;i++)
                    {
                       
                        sub1=  str1[i].substring(0,str1[i].indexOf(' '));
                        
                       
                        if(sub1!=""){
                                
                            document.getElementById("" + sub1).style.backgroundImage="url('../../imgL/Task.jpg')";
                            document.getElementById("" + sub1).style.backgroundSize="100% 100%";
                            document.getElementById("" + sub1).style.backgroundRepeat="no-repeat";
                            
                        }  
                    }
                   
                },
               
                // error: function () { alert(" session expired plz login"); }
            });  
            
        }

    
   
    function taskNameDisplay(cel)   //show the task name
    {
        
       var M = $('#sel :selected').text();
       var Y = $('#sel2 :selected').text();

       var date = cel + " " + M + " " + Y;
      
    $.ajax({
               

            type: "POST",
            url: "PM_dailyActivityMobile.aspx/DisplayTaskName",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({intUserID:'<%=Session("intUserID")%>', DateHoliday3:date}),

        success: function (data) {
            if(data.d=="no Events")
            {
                $('#taskName').text("");
                $('#TaskNameLb').text("");
                //Added By Vaijat K ON 28/04/2016 For Hiding control
                $('#TaskNameLb').css("display","none");
                $('#taskName').css("display","none");
                //End of Addition by Vaijat K
                $('#noEvent').text("NO Events");

            }
            else{
                //Added By Vaijat K ON 28/04/2016 For showing control
                $('#TaskNameLb').css("display","inline-block");
                $('#taskName').css("display","inline-block");
                //End of Addition by Vaijat K
                $('#noEvent').text("");
                $('#taskName').text(" Task Name:");
                $('#TaskNameLb').text("");
                 
                $('#TaskNameLb').text(data.d);
                
            }
           
                },
               
    });  

    }
    
    function showHolidayName(cel)
    {
        var M = $('#sel :selected').text();
        var Y = $('#sel2 :selected').text();

        var date = cel + " " + M + " " + Y;
        $.ajax({
               

            type: "POST",
            url: "PM_dailyActivityMobile.aspx/DisplayHolidayname",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({DateHoliday3:date}),
            success: function (data) 
            {
                
                if(data.d=="no Events")
                {
                    $('#HolidayName').text("");
                    $('#HolidayNameLb').text("");
                    //Added By Vaijat K ON 28/04/2016 For Hiding control
                    $('#HolidayName').css("display","none");
                    $('#HolidayNameLb').css("display","none");
                    //End of Addition by Vaijat K
                }
                else{
                    //Added By Vaijat K ON 28/04/2016 For showing control
                    $('#HolidayName').css("display","inline-block");
                    $('#HolidayNameLb').css("display","inline-block");
                    //End of Addition by Vaijat K
                    $('#noEvent').text("");
                    $('#HolidayName').text(" Holiday Name:");
                    $('#HolidayNameLb').text("");
                 
                    $('#HolidayNameLb').text(data.d);
                }
            }
        });  

    }

    //function birthday_OfEmployee(cel)
    //{
    //    var X=$('#tableHeader').text();
    //    var X1=X.split(" ");
    //    ;
    //    var M=X1[0];
     
        
    //    var date = cel + " " + M ;
       
        //$.ajax({
               

           // type: "POST",
          //  url: "PM_dailyActivityMobile.aspx/BirthDate",
           // contentType: "application/json;charset=utf-8",
           // dataType: "json",
           // data: JSON.stringify({intUserID:'<%=Session("intUserID")%>',DateHoliday3:date}),
            //data: JSON.stringify({intUserID:'<%=Session("intUserID")%>'}),
           // success: function (data) 
            //{
               
                //alert(data.d);
               
               // if(data.d=="no Events")
                //{
                   // $('#birthday').text("");
                   // $('#birthdayLb').text("");
                   
               // }
                //else{
                    //$('#noEvent').text("");
                   // $('#birthday').text(" Birthday:");
                   
                   // $('#birthdayLb').text("");
                 
                    //$('#birthdayLb').text(data.d);
                    
                //}
            //}
        //});  
    //}

        function todayDate() {   // purpose:by default currunt date is selected
            //debugger;

            var Currentdate

            var d = new Date(),
           // n = d.getMonth(),
            y = d.getFullYear(); //current year
         

            ///////////////////////////////////////////////
            var d1 = new Date(),
             n = d1.getMonth();  // current month
            var n1=n+1;
          
            /////////////////////////////////////////

            var C = new Date();
            var CurruntTime = d.getHours()+":"+d.getMinutes();  //current time
            //alert(CurruntTime);
            //////////////////////////////////////

            var M = $('#sel :selected').val();
          
            var Y = $('#sel2 :selected').text();

            if(M==n1 && Y==y)
            {
      
                var D2 = new Date();
                Currentdate=D2.getDate()
                var tbl = document.getElementById("calendarTable");
                if (tbl != null) {

                    for (var i = 3; i < tbl.rows.length; i++) {

                        for (var j = 0; j < tbl.rows[i].cells.length; j++) {
                            var H1 = (tbl.rows[i].cells[j].innerHTML);
                           
                            if (H1!="")
                            { //debugger;
                                //alert(Currentdate);
                                if (H1 == Currentdate) 
                                { 
                                    // alert("date match");
                                    tbl.rows[i].cells[j].style.borderColor="#e39321";
                                    tbl.rows[i].cells[j].style.borderStyle="solid";
                                    tbl.rows[i].cells[j].style.borderWidth="3px";
                                   // $(tbl.rows[i].cells[j]).append('<div class="rightCorner">'+CurruntTime+'</div>');
                                    document.getElementById('taskInfo').style.display = "block";  
                                           taskNameDisplay(Currentdate);
                                           showHolidayName(Currentdate);
                                    
                                }
                       
                            }
                        }
                    }
                   
                }
            }
           
           
        }

        var flag_1;  //delcre flag->> refer to GoToMainWeek()
      
        function Link()  //link to weekly veiw
        {  
            flag_1=1;
            $('#DivCustomTimeSheetNew').show();
            $('#monthly').hide();
          // $('#DivCustomTimeSheet').
        }

        function Link2()   //link to monthly view
        {    
            //flag_2=1;
            flag_1=0;
            $('#monthly').show();
            $('#DivCustomTimeSheetNew').hide();
            $('#taskInfo').show();
        }

        function previousMonthClick() // prvious button code
        { 
           
            var value;
            var Y = $('#sel2 :selected').text();
           
            var M = $('#sel :selected').val();
            value=M-1;
            $('#sel').val(value);
       
            if(value<1)
            { 
                var Year=Y-1;
                $('#sel2 :selected').text(Year);
                value=12;
                $('#sel').val(value);
           
            }
            if($('#sel').change())
            {
                populateTable(this.form);
           
            }
            emptyClick();
            cellClick()
            chekLeaves()
            halfDay()
            chekCount()
            plannedTaskColor()
            companyHoliday()
            showHoliday()
          
           HideDiv()
           //divClick()
            // taskNameDisplay()
           $('#taskInfo').hide();
           todayDate()
           divCounter_Click()
        }

        function nextMonthClick() //next button code
        {  //debugger;
            var value;
            var M;
            var Y;

            Y = $('#sel2 :selected').text();
            M = $('#sel :selected').val();
            if($('#sel').change())
            {
                //  Y = $('#sel2 :selected').text();
                //    M = $('#sel :selected').val();
                value= (parseInt(M)+1);
                $('#sel').val(value);
                populateTable(this.form);
            }
          
            if(value>12)
            {  
                //Y = $('#sel2 :selected').text();
                
                if($('#sel').change())
                {

                    var Year=(parseInt(Y)+1);
                    $('#sel2 :selected').text(Year);
                    value=1;
                    $('#sel').val(value);
                    populateTable(this.form);

                }
            }
            emptyClick();
            cellClick()
            chekLeaves()
            halfDay()
            chekCount()
            plannedTaskColor()
            companyHoliday()
            showHoliday()
           HideDiv()
           //divClick()
            //taskNameDisplay()
            $('#taskInfo').hide();
            todayDate()
            divCounter_Click()
        }
  

        //ended by tejal deshmukh                               
</script>



<body>
 
    <%-- <form id="DA" name="DA" method="post" runat="server">
        <div id="MainDiv" style="float: left; width: 100%;">
          
        </div>
    </form>--%>
   
    <div class="mm-page">

        <div id="divUnAuthorize" style="display: none; width: 100%; background-color: #E39321">
            <label style="width: 90%; font-size: 20px; text-align: center; color: black; position: relative; top: 400px; font-weight: bold">You are not authorize to view in this resolution.</label>
            <a id="aLogOut" style="position: absolute; right: 2px; top: 2px; font-size: 15px; color: white" href="<%= ResolveUrl("../../default.aspx") %>">Log Out</a>
        </div>

        <!--Added by swapnil aswale on 2-Dec-2015 for[ Mobile Responsive Code]-->
        <div id="page" style="display: none">

            <div data-role="page">
                <div data-role="header">
                    <div class="menu-header">
                        <a href="#menu"></a>
                        <label style="margin-left: 20px">Timesheet</label>
                        <div style="top: 0px; right: 5px; position: absolute;">
                            <%-- <button class="btn" type="button" style="background-color: transparent;color: white;font-weight: bold;" onclick="logout();">Log Out</button>--%>
                        </div>
                    </div>

                    <div data-role="main" class="ui-content">
                        <div id="divAccess" style="margin-top: 10%; text-align: center; font-weight: bold; display: none">You do not have access to view this page</div>
                        <div id="Authorize" style="margin-top: 10%; text-align: center; font-weight: bold; display: none">You are not authorize to view in this resolution</div>
                        <div id="divMenuContent" class="MenuContent" style="display: block">

                            <div id="header">

                                <div class="leftheader">

                                    <%-- <div class="btn-group button-margin">
                                <asp:Label ID="lbl_user" runat="server"></asp:Label>
                            </div>
                            <div style="margin-top: 6%; float: left;">
                                <button class="btn" type="button" onclick="logout();">Log Out</button>
                            </div>--%>
                                </div>
                                <img id="imgEmployeeHome" src="../../img/1920/no-photo.png" alt="No Image" style="margin-top: 4px; width: 30px; height: 30px; top: 2px; position: absolute; right: 1px;" align="right" />
                            </div>

                            <div class="master">
                                <div class="master-Menus">
                                    <div id="con" class="boxcontainer">
                                        <a href="../General/Navigation.aspx" class="menu-link">
                                            <div class="box" id="home">
                                                <img src="../../responsive/images/home.gif" alt="Home" class="slider-image" /><br />
                                                Home
                                            </div>
                                        </a>
                                        <a href="../PM/MyApproval.aspx" class="menu-link">
                                            <div class="box" id="Div1">
                                                <img src="../../responsive/images/time.gif" alt="TimeSheet Entry" class="slider-image" /><br />
                                                My Approval
                                            </div>
                                        </a>
                                        <a href="Projects.aspx" class="menu-link">
                                            <div class="box" id="project">
                                                <img src="../../responsive/images/Project%20.gif" alt="Project" class="slider-image" /><br />
                                                Project
                                            </div>
                                        </a>

                                        <a href="../PM/PM_DailyActivityMobile.aspx" class="menu-link">
                                            <div class="box" id="timesheet">
                                                <img src="../../responsive/images/time.gif" alt="TimeSheet Entry" class="slider-image" /><br />
                                                TimeSheet Entry
                                            </div>
                                        </a>

                                    </div>

                                </div>
                            </div>

                            <div class="content-page">

                                <!----------     DivCustomTimeSheet Starts Here       --------->
                                <style type="text/css">
                                    .Error {
                                        color: Red;
                                    }
                                </style>
                                <script type="text/javascript">
                                    jQuery(document).ready(function () {
                                     
                                        if ('<%=Session("LoginType")%>' == 'C') {
                                            document.getElementsByClassName('MenuContent')[0].style.display = 'none';
                                            document.getElementById('Authorize').style.display = 'block';
                                        }

                                       
                                    });
                                </script>
                                <div class="center-caption">
                                    <label><b>Timesheet Entry</b></label>
                                </div>
                              
                                

                                <div id="link" style="box-shadow: 1px 0px 1px #888888;height:10%; margin-left: 9px">
 <div> <%--style="border-radius:3px;border:1px solid;padding-top:1px;background-color:#f6eee4 "--%><a href="#DivCustomTimeSheetNew" onclick="Link()" id="WeekViewL1"><b style="color:white">Week View</b></a></div><hr/>
 <div> <%--style="border-radius:3px;border:1px solid;padding-top:7px ;background-color:#f6eee4"--%><a href="#monthly" onclick="Link2()" id="MonthlyViewL2"><b style="color:white">MonthlyView</b></a></div>

                                </div>
                               

                          

                           <div id="divrem" style="padding-left:3%"><table id="bgtable" style="width: 97% !important"><tbody>
                               <tr id="row" bgcolor="#f6eee4">
                                   
               <td><div id="imgclick" style="float:left;padding-left:3%"><img id="imgClickdiv" src="../../imgL/icon.PNG" onclick="buttonClick()" height="25px" width="25px" id="imgLink"/></div></td>
                                 <td style="white-space:nowrap;text-align:right">
                                    
           <div id="legend">Holiday <img src="../../imgL/Holiday.gif" title="Holiday" width="21px"/>Weekends <img src="../../imgL/weekend.gif" title="WeekEnds And Leaves" width="21px" />HalfDay <img src="../../imgL/HalfDay.gif" title="HalfDay" width="21px"/>PlannedTask <img src="../../imgL/Task.jpg" title="Plannedtask" width="20px"/>
                                </div>

                                 </td>
                               </tr>
                               </tbody>
                             </table></div>
    <div id="DivCustomTimeSheetNew" style="border-radius: 2%; box-shadow: 0 2px 2px 0 rgba(0,0,0,.14),0 3px 1px -2px rgba(0,0,0,.2),0 1px 5px 0 rgba(0,0,0,.12) !important" class="DivCustomTimeSheetNew">
                                 <div id="WeekView">
                                     <!---- WEEK VIEW ---->
                                        <br />
                                        <div id="WeekHead">
                                            <center>
                                        <span id="DivPrevWeekBtn" class="width40px"></span>
                                        <span id="Divweekrange"></span>
                                        <span id="DivNextWeekBtn" class="width40px"></span>
                                       
                                    </center>
                                        </div>
                                        <br />
                                        <div id="DivCurrWeekList"> 
                                        </div>
                                    </div>
                                    </div>

                                  <%-- /*PLOT CALENDER  tejal deshmukh*/--%>
                                
                               <div id="monthly">
                               <%--<div id="legend" style="background-color:#f6eee4">
                                  Holiday<img src="../../imgL/Holiday.gif" title="Holiday"/>Weekends<img src="../../imgL/weekend.gif" title="WeekEnds And Leaves" />HalfDay
                                   <img src="../../imgL/HalfDay.gif" title="HalfDay"/>PlannedTask<img src="../../imgL/Task.jpg" title="Plannedtask" width="20px" />
                                    </div>--%>
                                   
                             &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                   <table id="calendarTable" border="1" align="center">
                                       <tr>
                                    <th id="tableHeader" colspan="7" style="background-color:#f6eee4;font-size:12px"></th>  </tr>
                                        <tr>  
                                          <td colspan="7" id="tbldropdown" style="padding-bottom:8px">
                                                <%-- <p>--%>
                                               <form name="dateChooser">
                                                   <div id="dropdownList"><img src="../../imgL/left.gif" style="width:30px" id="PreMonth" onclick="previousMonthClick()" />&nbsp;
                                                <select id="sel" name="chooseMonth" 
                                                onchange="populateTable(this.form)">
                                                    <option selected value="1">Jan</option>
                                                    <option value="2" >Feb</option>
                                                    <option value="3">Mar</option>
                                                     <option value="4">Apr</option>
                                                      <option value="5">May</option>
                                                       <option value="6"> Jun</option>
                                                       <option value="7">July</option>
                                                       <option value="8"> Aug</option>
                                                       <option value="9">Sep</option>
                                                        <option value="10"> Oct</option>
                                                         <option value="11"> Nov</option>
                                                     <option value="12">Dec</option>

                                                </select>
                                                          
                                        <select  id="sel2" name="chooseYear" onchange="populateTable(this.form)">
                                        </select>
                                                  &nbsp;<img src="../../imgL/right.gif" width="30px" id="NextMonth" onclick="nextMonthClick()"/></div>
                                       </form>
                                       <%-- </p>--%>

                                          </td>
                                    </tr>    
                                      
                                    <tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th>
                                    <th>Thu</th><th>Fri</th><th>Sat</th></tr>
                                  <%--<tbody id="tableBody" onclick="timeShit()"></tbody>--%>
                                       <tbody id="tableBody"></tbody> 
                                      
                                     </table>
                                    </div>
                               <div id="taskInfo" style="width:99%;overflow: auto;"><table class="panel shadow" style="border: 0px white; width: 100%; display: table; background-color:#f6eee4;">
                             <tbody id="taskInfoDisply"><tr style="color: #27408B">
                                 <td style="text-align:left;line-height: 1.428571429;">
                            <label id="noEvent"></label>
                            <label id="HolidayName"></label>&nbsp;<label id="HolidayNameLb"></label><br/>
                              
                           <label id="taskName"></label>&nbsp;<label id="TaskNameLb"></label><br/>
                              
                                <%--<label id="birthday"></label>&nbsp;<label id="birthdayLb"></label>--%>
                                     </td>
                                
                           </tr>

                    </tbody></table></div>


                                    <%-- /*END CALENDER*/-tejal deshmukh-%>--%>
                                

                                    <div id="DayView" style="display: none;">
                                        <br />

                                        
                                        <!---- DAY VIEW ---->
                                       <center>
                                           
                <div id="DivCustomTimeSheet" style="border-radius: 2%; box-shadow: 0 2px 2px 0 rgba(0,0,0,.14),0 3px 1px -2px rgba(0,0,0,.2),0 1px 5px 0 rgba(0,0,0,.12) !important" class="DivCustomTimeSheet" >
                 
                                            <span style="float: left; margin-left: 10px;">
                            <%--<center> <asp:Label ID="lb1" runat="server" Text="" style="font-size:18px;" ></asp:Label></center>--%>
  
                       <img id="imgBack" alt="Back" src="../../responsive/Images/backimg.png" style="cursor:pointer"  />
                                                 
                                                </span>
                   
                  
                     <span id="DivPrevDAYBtn" class="width40px"></span><span id="DivDAYTimeSheet"></span><span id="DivNextDAYBtn" class="width40px"></span>
            <%--</center>
                      --%>                  
                    <div id="DivDayTask">

                                            <div>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 93%">
                                                            <%--   Added by Yogesh J on 18-Mar-2016 To generate Token--%>
                                                           <%-- <select id="DDLProject" name="DDLProject" class="BoldFonts" onchange="GetAssignedTaskDayWise(this.value,<%=Session("intUserID")%>,<%=Session("intRoleLevel")%>)"
                                                                style="width: 100%; height: 23px; float: left;">
                                                            </select>--%>
                                                               <select id="DDLProject" name="DDLProject" class="BoldFonts" onchange="GetAssignedTaskDayWise(this.value,<%=Session("intUserID")%>,<%=Session("intRoleLevel")%>,'<%=m_PKToken%>')"
                                                                style="width: 100%; height: 23px; float: left;">
                                                            </select>
                                                       <%--       End of addition by Yogesh J on 18-Mar-2016 To generate Token--%>
                                                        </td>
                                                        <td>
                                                            <span id="ErrorSpan" class="Error" style="float: left;">*</span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 93%">
                                                            <select id="DDLTask" name="DDLTask" onchange="SetWork(this.value)" class="BoldFonts" style="width: 100%; height: 23px; float: left;">
                                                            </select></td>
                                                        <td>
                                                            <span id="ErrorSpan2" class="Error" style="float: left;">*</span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div>
                                                <br/>
                                                <label>Allocated Work (hrs) :</label>
                                                <label id="lblAllocatedWork" runat="server" />
                                            </div>
                                            <div>

                                                <label>Actual Work (hrs) :</label>
                                                <label id="lblActualWork" runat="server" />
                                            </div>
                                            <div>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 93%"> 
                                                            <input id="txtHours" runat="server" maxlength="5"
                                                               onkeypress="return isNumber(event)"  placeholder="Hours" style="width: 100%" /></td> <%--onchange="NumericValidation(this.value);"--%>
                                                        <td><span id="ErrorSpan3" class="Error" style="float: left;">*</span></td>
                                                    </tr>
                                                </table>


                                            </div>

                                            <div>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 93%">
                                                            <input type="button" id="BtnSaveUpdate" onclick="ValidateControls(<%=Session("intUserID")%>,<%=Session("intRoleLevel")%>)" style="width: 100%" value="Save"/></td>
                                                            <td><span id="Span1" class="Error" style="float: left;"></span></td>
                                                    </tr>
                                                </table>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <!----------     DivCustomTimeSheet Ends Here       --------->

                            </div>
                        </div>
                 

                    <div data-role="footer">
                        <div class="footbar" style="">Lifeline Systech Solutions Pvt.Ltd.</div>
                    </div>
                    <nav id="menu">
                        <ul>

                            <li><a href="../General/Navigation.aspx?FromWhere=DB" id="Hhome">
                                <img src="../../responsive/images/home.gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Home</a></li>
                            <li><a href="MyApproval.aspx" id="A1">
                                <img src="../../responsive/images/Project .gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;My Approval </a></li>

                            <%--  <li><a href="Projects.aspx" id="Hproject">
                            <img src="../../responsive/images/Project .gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Project </a></li>
                            --%>
                            <li><a href="PM_dailyActivityMobile.aspx">
                                <img src="../../responsive/images/time.gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;<label>TimeSheet Entry</label></a></li>
                            <%--<li><a>&nbsp;&nbsp;&nbsp;&nbsp;Settings</a></li>--%>
                            <li><a href="<%= ResolveUrl("../../default.aspx") %>"><%--onclick="logout();"--%>
                                <img src="../../responsive/images/Button-Log-Off.png" style="width:20px" height: 20px"/>&nbsp;&nbsp;&nbsp;&nbsp;Log Out</a></li>
                        </ul>
                    </nav>

                </div>

            </div>
        </div>
   
</div>
</body>
</html>
