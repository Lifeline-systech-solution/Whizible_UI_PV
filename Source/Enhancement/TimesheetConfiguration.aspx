<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimesheetConfiguration.aspx.vb" Inherits="PbNIT.TimesheetConfiguration" %>

<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Timesheet Configuration")%>
    
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    


<script src="../../responsive/responsive.js"></script>
<head runat="server">
    <title></title>
    <style>
        
        #PageDiv {
            /*background-color:#f6eee4;*/
            overflow:auto;
            
        }

        #tblTimesheetExe td {
            padding:5px;
        }

        
        #tblAttendance td
        {
           padding:4px;
        }
        
        #tblAttendance {
          margin-left:5%;
        
        }
         hr {
            margin:0px !important;
        }
        /*#tdTimer {
            padding-left:9% !important;
        }*/
    </style>
</head>
<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
   
    <form id="frmTimesheetExe" method="post" runat="server">   
      <%PageInit()%>
    </form>
    <div>
    
    </div>
</body>
   
    <script>
     
        var checkValu;
        $(document).ready(function () {

            //-------------------------------------------***---------------------------------------------
            //onload enforced timesheet checked box checking according to that section will disable or enable for setting
            var Enforced1 = document.getElementById("chkEnforcedTime").checked;
            var IsAlert = document.getElementById("chkAlert").checked;
           // alert(Enforced1);
            if (Enforced1 == false) {
                //document.getElementById("Alert_Sys").checked = true;

                $("#txtNotication").attr('disabled', 'disabled');
                document.getElementById("txtTimer").disabled = true;
                document.getElementById("Sel_Pevious").disabled = true;
                document.getElementById("Sel_Current").disabled = true;
                document.getElementById("txtTaskDeadline").disabled = true;

                document.getElementById("chkAllowByPass").disabled = true;
                document.getElementById("chkReportMgr").disabled = true;
                document.getElementById("chkReportPm").disabled = true;
                document.getElementById("chkReportAdmin").disabled = true;

                document.getElementById("Sel_Day").disabled = true;
                document.getElementById("Sel_Week").disabled = true;
                document.getElementById("Sel_Role").disabled = true;
                document.getElementById("Sel_Employee").disabled = true;
                // Added by Yogesh Jalamkar on 30-AUg-2017 Purpose: To enable/disable alert section if show alert is enable
                if (IsAlert == false)
                {
                    document.getElementById("Alert_Sys").disabled = true;
                    document.getElementById("Alert_Resource").disabled = true;                 
                    document.getElementById("txtSetTimer").disabled = true;
                }
                $("#SpnNotificationNote").css("display", "none");

                document.getElementById("chk_IsEnableDifferentShift").disabled = true;
                document.getElementById("txtshiftStartTime").disabled = true;
                document.getElementById("txtshiftEndTime").disabled = true;
                document.getElementById("txtBackTSDaysForShift").disabled = true;
                //End of addition by Yogesh Jalamkar on 30-AUg-2017
            }

            else
            {

                document.getElementById("Alert_Sys").disabled = true;
                document.getElementById("Alert_Resource").disabled = true;
                document.getElementById("chkAlert").disabled = true;
                document.getElementById("txtSetTimer").disabled = true;
                $("#SpnNotificationNote").css("display", "block");
            }

            //-------------------------------------------***---------------------------------------------
            //onload Allow by pass checked box checking according to that section will disable or enable for setting
            var CheckAllowByPass = document.getElementById("chkAllowByPass").checked;

            if (CheckAllowByPass == true) {
                document.getElementById("chkReportMgr").disabled = false;
                document.getElementById("chkReportPm").disabled = false;
                document.getElementById("chkReportAdmin").disabled = false;

            }
            else {
                document.getElementById("chkReportMgr").disabled = true;
                document.getElementById("chkReportPm").disabled = true;
                document.getElementById("chkReportAdmin").disabled = true;

            }
            //-------------------------------------------***---------------------------------------------
            // on keypress text box border color change
            $("#txtSetTimer").keypress(function () {
                
                $("#txtSetTimer").css('border-color', 'skyblue');
            });

            $("#txtNotication").keypress(function () {

                $("#txtNotication").css('border-color', 'skyblue');
                document.getElementById("SpnNumOfNotification").style.display = "none";
            });

            $("#txtTaskDeadline").keypress(function () {

                $("#txtTaskDeadline").css('border-color', 'skyblue');
                document.getElementById("SpnTaskDeadline").style.display = "none";
            });

            $("#txtTimer").keypress(function () {

                $("#txtTimer").css('border-color', 'skyblue');
                document.getElementById("SpnHourNotification").style.display = "none";
            });

            $("#txtshiftStartTime").keypress(function () {

                $("#txtshiftStartTime").css('border-color', 'skyblue');
                document.getElementById("SpntxtshifStartTime").style.display = "none";
            });

            $("#txtshiftEndTime").keypress(function () {

                $("#txtshiftEndTime").css('border-color', 'skyblue');
                document.getElementById("SpntxtshiftEndTime").style.display = "none";
            });

            $("#txtBackTSDaysForShift").keypress(function () {

                $("#txtBackTSDaysForShift").css('border-color', 'skyblue');
                document.getElementById("SpntxtBackTSDaysForShift").style.display = "none";
            });
            // Added by Yogesh Jalamkar on 30-AUg-2017 Purpose: To enable/disable alert section if show alert is enable
            $("#chkAlert").click(function ()
            {
                if ($('#chkAlert').is(':checked')) {

                    document.getElementById("Alert_Sys").disabled = false;
                    document.getElementById("Alert_Resource").disabled = false;
                    document.getElementById("txtSetTimer").disabled = false;
                  

                }
                else {
                 
                        document.getElementById("Alert_Sys").disabled = true;
                        document.getElementById("Alert_Resource").disabled = true;
                        document.getElementById("txtSetTimer").disabled = true;
                        $("#txtSetTimer").val("");
                        //$('#Alert_Sys').prop('checked', false);
                }
            }
            );
            if ($('#Sel_Pevious').is(':checked')) {
                $('#txtTaskDeadline').prop('disabled', true);
                $('#txtTaskDeadline').val("");
            }
            else {
                $('#txtTaskDeadline').prop('disabled', false);
            }
            //End of addition by Yogesh Jalamkar  on 30-AUg-2017
            //Added by Yogesh Jalamkar on 30-Aug-2017 Purpose : To unable/disable the control at page load
            if (Enforced1 == false) {
                SystemResource_onChange('');
            }
           
            $('input[name="EnforceTimesheet_Section"]').click(function () {
                if ($('#Sel_Pevious').is(':checked')) {
                    $('#txtTaskDeadline').prop('disabled', true);
                    $('#txtTaskDeadline').val("");
                }
                else {
                    $('#txtTaskDeadline').prop('disabled', false);
                }
            });
          
            //End of addition by yogesh Jalamkar
        })    
        //-------------------------------------------***---------------------------------------------
        var objform = GetFormReference('frmTimesheetExe');

     
        function SystemResource_onChange(obj) {

            //onchange of system radio button text feild will enabled or disabled
           
            var System = document.getElementById("Alert_Sys").checked;
           

            var Resource = document.getElementById("Alert_Resource").checked;

            if (System == true) {
                document.getElementById("txtSetTimer").disabled = false;

            }
            else 

            {
                document.getElementById("txtSetTimer").disabled = true;
                document.getElementById("txtSetTimer").value = "";
            }
           
        }

       


        function RoleEmployee_onChange(obj) {

            //on change of role and Employee radio button exclusion will disable or enable

            var ISRole = document.getElementById("Sel_Role").checked;
            var Enforced = document.getElementById("chkEnforcedTime").checked;

            var Resource = document.getElementById("Sel_Employee").checked;

            if (Enforced == true) {
                if (ISRole == true) {
                    document.getElementById("linkRole").href = "javascript:Flag_OnClick('Role')"

                }
                else {
                    document.getElementById("linkRole").href = "#";
                }
                if (Resource == true) {
                    document.getElementById("linkEmp").href = "javascript:Flag_OnClick('Emp')"

                }
                else {
                    document.getElementById("linkEmp").href = "#";
                }
            }
            else {
                document.getElementById("linkRole").href = "#";
                document.getElementById("linkEmp").href = "#";
            }
          

        }

     
        function Save_OnClick() {

         //saving data
            var Alert = document.getElementById("chkAlert").checked;

            var Enforced = document.getElementById("chkEnforcedTime").checked;

            var CheckAllowByPass = document.getElementById("chkAllowByPass").checked;

            //var CheckAttendance = document.getElementById("chkAttendance").checked;
         

            //var CheckLocation = document.getElementById("chkLocation").checked;

            //var Onsiteresource = document.getElementById("chkOnsiteResource").checked;

            //var CheckHoliday = document.getElementById("chkExculdHoliday").checked;

            //var CheckDayWeek = document.getElementById("chkDayWeek").checked;
          

            var chkReportMgr = document.getElementById("chkReportMgr").checked;
            var chkReportPm = document.getElementById("chkReportPm").checked;
            var chkReportAdmin = document.getElementById("chkReportAdmin").checked;

            var valSetTime = document.getElementById("txtSetTimer").value;
            var ActiveDirectoryCheck = document.getElementById("chkActiveDirectory").checked;
            var IsEnableDifferentShift = document.getElementById("chk_IsEnableDifferentShift").checked;
        if ($('#chkAlert').is(':checked')) {
                if ($('#Alert_Sys').is(':checked')) {
                    if (valSetTime < 5 || valSetTime == '') {
                        // alert("Set time Should be greater than '0'");

                        $('#SpnSetTimer').text("Minimum minutes should be '5'");
                        $('#SpnSetTimer').css('display', 'block');
                        $('#txtSetTimer').css('border-color', 'red');
                        $('#txtSetTimer').css('border-width', '1px'); //SpnSetTimer
                        return false;
                    }
                }
            }

            

            if (Validation() == true) {

                var MenuTags = document.getElementsByTagName('A');
                for (i = 0; i < MenuTags.length; i++) {
                    if (MenuTags[i].className == "Menu") {
                        //MenuTags[i].style.display= "none";
                        MenuTags[i].parentNode.style.display = "none";
                    }
                }


                setFrameLoader();

                objform.action = "TimesheetConfiguration.aspx?MasterTagID=50001&Action=Save&Alert=" + Alert + "&Enforced=" + Enforced + "&CheckAllowByPass=" + CheckAllowByPass + "&CheckAttendance=0&CheckLocation=0&Onsiteresource=0&CheckHoliday=0&CheckDayWeek=0&chkReportMgr=" + chkReportMgr + "&chkReportPm=" + chkReportPm + "&chkReportAdmin=" + chkReportAdmin + "&EnableDifferentShift=" + IsEnableDifferentShift + "&ActiveDirectoryCheck=" + ActiveDirectoryCheck + "";
                objform.submit();

            }
        }
        
        function AlertSecction_Disable(obj)
        {
            //on cheked on EnforcedTime controls will enable or disable
           
            var checkEnforced = document.getElementById("chkEnforcedTime").checked;
           
            if (checkEnforced == true) {
                document.getElementById("Alert_Sys").disabled = true;
                document.getElementById("Alert_Resource").disabled = true;
                document.getElementById("chkAlert").disabled = true;
                document.getElementById("txtSetTimer").disabled = true;
                document.getElementById("txtSetTimer").value = "";
                $("#chkAlert").prop("checked", false);



                document.getElementById("txtNotication").disabled = false;
                document.getElementById("txtTimer").disabled = false;
                document.getElementById("Sel_Pevious").disabled = false;
                document.getElementById("Sel_Current").disabled = false;
                if ($('#Sel_Current').is(':checked')) {
                    document.getElementById("txtTaskDeadline").disabled = false;
                }
              
              

                document.getElementById("chkAllowByPass").disabled = false;
                document.getElementById("chkReportMgr").disabled = false;
                document.getElementById("chkReportPm").disabled = false;
                document.getElementById("chkReportAdmin").disabled = false;

                document.getElementById("Sel_Day").disabled = false;
                document.getElementById("Sel_Week").disabled = false;
                document.getElementById("Sel_Role").disabled = false;
                document.getElementById("Sel_Employee").disabled = false;
               
                $("#SpnNotificationNote").css("display", "block");
              
                //Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift
                document.getElementById("chk_IsEnableDifferentShift").disabled = false;
                if ($('#chk_IsEnableDifferentShift').is(':checked')) {
                document.getElementById("txtshiftStartTime").disabled = false;
                document.getElementById("txtshiftEndTime").disabled = false;
                document.getElementById("txtBackTSDaysForShift").disabled = false;
                    }
                //End of addition by YOgesh Jalamkar
            }
            else {
                document.getElementById("chkAlert").disabled = false;

                if ($('#chkAlert').is(':checked')) {
                    document.getElementById("Alert_Sys").disabled = false;
                    document.getElementById("Alert_Resource").disabled = false;                 
                   document.getElementById("txtSetTimer").disabled = false;
                }
               



                document.getElementById("txtNotication").disabled = true;
                document.getElementById("txtTimer").disabled = true;
                document.getElementById("Sel_Pevious").disabled = true;
                document.getElementById("Sel_Current").disabled = true;
                document.getElementById("txtTaskDeadline").disabled = true;

                document.getElementById("txtNotication").value = "";
                document.getElementById("txtTimer").value = "";


                document.getElementById("chkAllowByPass").disabled = true;
                document.getElementById("chkReportMgr").disabled = true;
                document.getElementById("chkReportPm").disabled = true;
                document.getElementById("chkReportAdmin").disabled = true;

                document.getElementById("Sel_Day").disabled = true;
                document.getElementById("Sel_Week").disabled = true;
                document.getElementById("Sel_Role").disabled = true;
                document.getElementById("Sel_Employee").disabled = true;

                $("#SpnNotificationNote").css("display", "none");
                //Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift
                document.getElementById("chk_IsEnableDifferentShift").disabled = true;
                document.getElementById("txtshiftStartTime").disabled = true;
                document.getElementById("txtshiftEndTime").disabled = true;
                document.getElementById("txtBackTSDaysForShift").disabled = true;
                //End of addition by YOgesh Jalamkar
            }
        }
        function AllowPass_Checked(obj)
        {
            //on cheked on Allow by pass controls will enable or disable
            var CheckAllowByPass = document.getElementById("chkAllowByPass").checked;
            
            if (CheckAllowByPass == true) {
                document.getElementById("chkReportMgr").disabled = false;
                document.getElementById("chkReportPm").disabled = false;
                document.getElementById("chkReportAdmin").disabled = false;

            }
            else {
                document.getElementById("chkReportMgr").disabled = true;
                document.getElementById("chkReportPm").disabled = true;
                document.getElementById("chkReportAdmin").disabled = true;

            }
        }
        function Flag_OnClick(flag) {
            //redirect to RoleAndEmployeeList page
            var Enforced = document.getElementById("chkEnforcedTime").checked;

            if (Enforced == true) {
                window.open("../Enhancement/RoleAndEmployeeList.aspx?FromWhere=Exclusion&flag=" + flag + "", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=500'");
                //Save_OnClick();
            }
        }

        function ShowHistory_OnClick() {
            //redirect to Role And EmployeeList page

            window.open("../Enhancement/ShowHistory_TimeSheetConfiguration.aspx", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=500'");

        }
        function Validation() {
            //validate controls
            var decimalcheck = /^\d+\.\d{0,2}$/;
            
           checkValu = 0;
           var Enforced = document.getElementById("chkEnforcedTime").checked;
           if (Enforced == true) {

               if ($("#txtNotication").val() == "") { //text feild Should not  blank
                   $('#txtNotication').css('border-color', 'red');
                   $('#txtNotication').css('border-width', '1px');
                   $('#SpnNumOfNotification').css('display', 'block');
                   $('#SpnNumOfNotification').text("Number of Notification should not be left blank");
                   if (checkValu != 1) {
                       $('#txtNotication').focus()
                   }
                   checkValu = 1;
               }
            
                   if ($("#txtTimer").val() == "") { //text feild Should not  blank
                       $('#txtTimer').css('border-color', 'red');
                       $('#txtTimer').css('border-width', '1px');
                       $('#SpnHourNotification').css('display', 'block');
                       $('#SpnHourNotification').text("Timer value should not be blank.");
                       if (checkValu != 1) {
                           $('#txtTimer').focus()
                       }
                       checkValu = 1;
                   }
               
               if ($('#Sel_Current').is(':checked')) {
                   if ($("#txtTaskDeadline").val() == "") { //text feild Should not  blank 
                       $('#txtTaskDeadline').css('border-color', 'red');
                       $('#txtTaskDeadline').css('border-width', '1px');
                       $('#SpnTaskDeadline').css('display', 'block');
                       $('#SpnTaskDeadline').text("Notification Time should not be left blank");
                       if (checkValu != 1) {
                           $('#txtTaskDeadline').focus()
                       }
                       checkValu = 1;
                   }
               }
               var IntTimer = document.getElementById("txtTimer");
               if (isNaN(IntTimer.value)) { //text feild will not accept non numeric value 
                   $('#txtTimer').css('border-color', 'red');
                   $('#txtTimer').css('border-width', '1px');
                   $('#SpnHourNotification').css('display', 'block');
                   $('#SpnHourNotification').text("Please enter numeric value");
                   checkValu = 1;
               }

               if (decimalcheck.test(IntTimer.value)) { //text feild will not accept decimal value
                   $('#txtTimer').css('border-color', 'red');
                   $('#txtTimer').css('border-width', '1px');
                   $('#SpnHourNotification').css('display', 'block');
                   $('#SpnHourNotification').text("Please Enter Positive Integer Values");
                   checkValu = 1;
               }

               if (IntTimer.value < 6 || IntTimer.value == '') {
                   // alert("Set time Should be greater than '0'");

                   $('#SpnHourNotification').text("Minimum minutes should be '30'");
                   $('#SpnHourNotification').css('display', 'block');
                   $('#txtTimer').css('border-color', 'red');
                   $('#txtTimer').css('border-width', '1px'); //SpnSetTimer
                   return false;
               }

               var TaskDeadline = document.getElementById("txtTaskDeadline");
               //if (isNaN(TaskDeadline.value)) { //text feild will not accept non numeric value 
               //    $('#txtTaskDeadline').css('border-color', 'red');
               //    $('#txtTaskDeadline').css('border-width', '1px');
               //    $('#SpnTaskDeadline').css('display', 'block');
               //    $('#SpnTaskDeadline').text("Please enter numeric value");
               //    checkValu = 1;
               //}
               var TaskNotifiy = document.getElementById("txtNotication");
               if (isNaN(TaskNotifiy.value)) { //text feild will not accept non numeric value 
                   $('#txtNotication').css('border-color', 'red');
                   $('#txtNotication').css('border-width', '1px');
                   $('#SpnNumOfNotification').css('display', 'block');
                   $('#SpnNumOfNotification').text("Please enter numeric value");
                   checkValu = 1;
               }

               if (decimalcheck.test(TaskNotifiy.value)) { //text feild will not accept decimal value
                   $('#txtNotication').css('border-color', 'red');
                   $('#txtNotication').css('border-width', '1px');
                   $('#SpnNumOfNotification').css('display', 'block');
                   $('#SpnNumOfNotification').text("Please Enter Positive Integer Values");
                   checkValu = 1;
               }

               if (IntTimer <= 0) {
                   $('#SpnHourNotification').text("Timer Should be greater than '0'");
                   $('#txtTimer').css('border-color', 'red');
                   $('#txtTimer').css('border-width', '1px');
                   $('#SpnHourNotification').css('display', 'block');
                   checkValu = 1;
               }
               if ($('#Sel_Current').is(':checked')) {
                   if (isTime(TaskDeadline) == false) {
                       $('#txtTaskDeadline').css('border-color', 'red');
                       $('#txtTaskDeadline').css('border-width', '1px');
                       $('#SpnTaskDeadline').css('display', 'block');
                       $('#SpnTaskDeadline').text("Please enter valid time format.");
                       checkValu = 1;
                   }
               }
              
               var objtxtbackwardDay = document.getElementById("txtbackwardDay");
               if (isNaN(objtxtbackwardDay.value)) { //text feild will not accept non numeric value 
                   $('#txtbackwardDay').css('border-color', 'red');
                   $('#txtbackwardDay').css('border-width', '1px');
                   $('#SpntxtbackwardDay').css('display', 'block');
                   $('#SpntxtbackwardDay').text("Please Enter Positive Integer Values");
                   checkValu = 1; checkValu = 1;
               }
               if (decimalcheck.test(objtxtbackwardDay.value)) { //text field will not accept decimal value
                   $('#txtbackwardDay').css('border-color', 'red');
                   $('#txtbackwardDay').css('border-width', '1px');
                   $('#SpntxtbackwardDay').css('display', 'block');
                   $('#SpntxtbackwardDay').text("Please Enter Positive Integer Values");
                   checkValu = 1;
               }

               //Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift
               var ShiftStartTime = document.getElementById("txtshiftStartTime");
               var ShiftEndTime = document.getElementById("txtshiftEndTime");
               var BackTSDaysForShift = document.getElementById("txtBackTSDaysForShift");


            
               if ($('#chk_IsEnableDifferentShift').is(':checked')) {
                   if ($("#txtshiftStartTime").val() == "")
                   {
                       $('#txtshiftStartTime').css('border-color', 'red');
                       $('#txtshiftStartTime').css('border-width', '1px');
                       $('#SpntxtshifStartTime').css('display', 'block');
                       $('#SpntxtshifStartTime').text("Start time should not be left blank.");
                       checkValu = 1;
                   }
                   if ($("#txtshiftEndTime").val() == "") {
                       $('#txtshiftEndTime').css('border-color', 'red');
                       $('#txtshiftEndTime').css('border-width', '1px');
                       $('#SpntxtshiftEndTime').css('display', 'block');
                       $('#SpntxtshiftEndTime').text("End date should not be left blank.");
                       checkValu = 1;
                   }
                   else {

                       if (isTime(ShiftStartTime) == false) {
                           $('#txtshiftStartTime').css('border-color', 'red');
                           $('#txtshiftStartTime').css('border-width', '1px');
                           $('#SpntxtshifStartTime').css('display', 'block');
                           $('#SpntxtshifStartTime').text("Please enter valid time format e.g: 18:00.");
                           checkValu = 1;
                       }
                       else if (isTime(ShiftEndTime) == false) {
                           $('#txtshiftEndTime').css('border-color', 'red');
                           $('#txtshiftEndTime').css('border-width', '1px');
                           $('#SpntxtshiftEndTime').css('display', 'block');
                           $('#SpntxtshiftEndTime').text("Please enter valid time format e.g: 18:00.");
                           checkValu = 1;
                       }
                       else if (ShiftStartTime.value >= ShiftEndTime.value) {
                           $('#txtshiftEndTime').css('border-color', 'red');
                           $('#txtshiftEndTime').css('border-width', '1px');
                           $('#SpntxtshiftEndTime').css('display', 'block');
                           $('#SpntxtshiftEndTime').text("Shift End time should be greater than Shift start time ");
                           checkValu = 1;
                       }
                   }

                   if ($("#txtBackTSDaysForShift").val() == "")
                   {
                       $('#txtBackTSDaysForShift').css('border-color', 'red');
                       $('#txtBackTSDaysForShift').css('border-width', '1px');
                       $('#SpntxtBackTSDaysForShift').css('display', 'block');
                       $('#SpntxtBackTSDaysForShift').text("Back days should not left blank.");
                       checkValu = 1;
                       
                   }
                   if (isNaN(BackTSDaysForShift.value)) { //text feild will not accept non numeric value 
                       $('#txtBackTSDaysForShift').css('border-color', 'red');
                       $('#txtBackTSDaysForShift').css('border-width', '1px');
                       $('#SpntxtBackTSDaysForShift').css('display', 'block');
                       $('#SpntxtBackTSDaysForShift').text("Please Enter Positive Integer Values");
                       checkValu = 1; checkValu = 1;
                   }
                   if (decimalcheck.test(BackTSDaysForShift.value)) { //text field will not accept decimal value
                       $('#txtBackTSDaysForShift').css('border-color', 'red');
                       $('#txtBackTSDaysForShift').css('border-width', '1px');
                       $('#SpntxtBackTSDaysForShift').css('display', 'block');
                       $('#SpntxtBackTSDaysForShift').text("Please Enter Positive Integer Values");
                       checkValu = 1;
                   }
               }
             
               //End of addition by Yogesh Jalamkar
           }
          //-------------------------------------------------------------------------------------------------------------------
          

           var Alert = document.getElementById("chkAlert").checked;

           if (Alert == true) {

               var setTimerVal = document.getElementById("txtSetTimer");
               if (isNaN(setTimerVal.value)) { //text feild will not accept non numeric value 
                   $('#SpnSetTimer').css('display', 'block');
                   $('#txtSetTimer').css('border-color', 'red');
                   $('#txtSetTimer').css('border-width', '1px'); //SpnSetTimer
                   $('#SpnSetTimer').text("Please enter numeric value");
                   checkValu = 1;
               }


               if (decimalcheck.test(setTimerVal.value)) { //text feild will not accept decimal value
                   $('#SpnSetTimer').css('display', 'block');
                   $('#txtSetTimer').css('border-color', 'red');
                   $('#txtSetTimer').css('border-width', '1px'); //SpnSetTimer
                   $('#SpnSetTimer').text("Please Enter Positive Integer Values");
                   checkValu = 1;
               }

           }
          
        

           //if (objtxtbackwardDay.value < 30) {
           //    $('#SpntxtbackwardDay').text("Minimum Bacward days Should be '30'");
           //    $('#txtbackwardDay').css('border-color', 'red');
           //    $('#txtbackwardDay').css('border-width', '1px');
           //    $('#SpntxtbackwardDay').css('display', 'block');
           //    $('#txtbackwardDay').focus();
           //    checkValu = 1;
           //}

           
            if (checkValu == 1) {
                return false;
            }
            else {

                return true;
            }
        }
      
       

        var objtimesheet = GetObjectReference('frmTimesheetExe', 'PageDiv');

        function window_onload() {

            
            var intDivHeight;
            var intDivHeightRisk;
            
            if (objtimesheet != null) {

                intDivHeight = window.innerHeight - objtimesheet.offsetTop - 10;
                objtimesheet.style.height = intDivHeight + 'px';
            }
            if (objdivlist != null) {
               
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 10;
                if (intDivHeight < 100) intDivHeight = 200;
                objdivlist.style.height = intDivHeight + 'px';
               
            }
        }

        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
           
            if (objtimesheet != null) {

                intDivHeight = window.innerHeight - objtimesheet.offsetTop - 10;
                objtimesheet.style.height = intDivHeight + 'px';
            }
            if (objdivlist != null) {
               
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 10;
                if (intDivHeight < 100) intDivHeight = 200;
                objdivlist.style.height = intDivHeight + 'px';
                if (objtimesheet != null) {
                    intDivHeight = window.innerHeight - objtimesheet.offsetTop - 10;
                    objtimesheet.style.height = intDivHeight + 'px';
                }
            }
        }

      //Added by YOgesh Jalamkar on 01-SEP-2017 Purpose: Allow bypass should be Resource or Employee specific
        function BypassRoleEmployee_onChange(obj) {

            //on change of role and Employee radio button exclusion will disable or enable

            var ISBypassRole = document.getElementById("Sel_ByPassRole").checked;
            var Enforced = document.getElementById("chkEnforcedTime").checked;

            var BypassResource = document.getElementById("Sel_BypassEmployee").checked;

            if (Enforced == true) {
                if (ISBypassRole == true) {
                    document.getElementById("linkBypassRole").href = "javascript:ByPassFlag_OnClick('Role')"

                }
                else {
                    document.getElementById("linkBypassRole").href = "#";

                }
                if (BypassResource == true) {
                    document.getElementById("linkBypassEmp").href = "javascript:ByPassFlag_OnClick('Emp')"

                }
                else {
                    document.getElementById("linkBypassEmp").href = "#";
                }
            }
            else {
                document.getElementById("linkBypassRole").href = "#";
                document.getElementById("linkBypassEmp").href = "#";
            }


        }

        function ByPassFlag_OnClick(flag) {
            //redirect to RoleAndEmployeeList page
            var Enforced = document.getElementById("chkEnforcedTime").checked;

            if (Enforced == true) {
                window.open("../Enhancement/RoleAndEmployeeList.aspx?FromWhere=Bypass&flag=" + flag + "", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=500'");
                //Save_OnClick();
            }
        }

        //End of addition by Yogesh Jalamkar
        //Added by Yogesh Jalamkar on 04-SEP-2017 Purpose: To check pending TS for different shift
        function AllowShift_Checked(obj) {
            //on cheked on  related controls will enable or disable
            var CheckIsEnableDifferentShift = document.getElementById("chk_IsEnableDifferentShift").checked;

            if (CheckIsEnableDifferentShift == true) {
                document.getElementById("txtshiftStartTime").disabled = false;
                document.getElementById("txtshiftEndTime").disabled = false;
                document.getElementById("txtBackTSDaysForShift").disabled = false;

            }
            else {
                document.getElementById("txtshiftStartTime").disabled = true;
                document.getElementById("txtshiftEndTime").disabled = true;
                document.getElementById("txtBackTSDaysForShift").disabled = true;
                $("#txtshiftStartTime").val("");
                $("#txtshiftEndTime").val("");
                $("#txtBackTSDaysForShift").val("");
            }
        }
        //End of addition by YOgesh Jalamkar
    </script>

</html>
