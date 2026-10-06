<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PasswordManagement.aspx.vb" Inherits="PbNIT.PasswordManagement" %>

<!DOCTYPE html>
<html>

<%CommonFunctions.General.PlotPageHeadTag("Setup_Working Options")%>
<head >
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />--%>
    <meta name="description" />
    <meta name="author" />
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setup_Working Options")%>--%>
    <title>Setup_Working Options</title>
    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
    <meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
    <meta name='vs_defaultClientScript' content='JavaScript'>
    <meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Pragma" content="no-cache">
    <%--<link href="../../General/StyleSheetChanakya_BrickRed.css" rel="stylesheet" />--%>
    <link id='lnkWhizStyleSheetImgDir' type='text/plain' href='images/BrickRed/' />
    <%--<script language='javascript' src='../../General/CommonFunctions.js'></script>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
 <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>


   

    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
   
    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />
    

    	<%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>

    <link rel="stylesheet" type="text/css" href="slacss.css">
</head>

    <style>
        .form-group {
            border-bottom: 1px solid #ebedf2;
        }

        .v-tabs .tabcontent {
            float: left;
            padding: 0;
            border-style: solid;
            border-color: #647ea8;
            border-width: 0px 0px 0px 0px !important;
            width: 100%;
            border-left: none;
            height: 1214px;
        }

        .tablinks.active, .tablinks1.active, .h-tabs div.tab button.tablinks1.active, .h-tabs div.tab button.tablinks2.active, .h-tabs div.tab button.tablinks3.active {
            color: #4caac0 !important;
            border: none !important;
            text-decoration: underline !important;
        }

        .content-wrapper {
            margin-left: 0px !important;
            padding-left: 0px !important;
        }

        #collapseOne .panel-body {
            OVERFLOW: auto;
            HEIGHT: 246PX;
        }

        .h-tabs div .panel-heading {
            height: 21px;
            border-style: solid;
            border-color: #e3e2e2;
            border-width: 1px 0 1px 0;
            background: #cbddfa;
        }

        .table-responsive .btn-default.btn {
            padding: 0;
            background: none;
            border: none;
        }

        .table-responsive .fa {
            font-size: 15px;
        }

        .clsTRColumnHeader th:nth-child(4) {
            text-align: center;
        }

        .clsTRColumnHeader th:nth-child(5) {
            text-align: center;
        }






        /*.table-responsive table tbody {
        overflow:auto;
        }*/
        .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }


        .table-responsive {
            overflow: hidden;
        }

        .control-label {
            font-weight: normal !important;
        }

        .dataTables_paginate {
            float: right !important;
        }

        .pagination {
            margin: 5px 0 !important;
        }

        .dataTables_info {
            margin-top: 8px;
        }

        .pagination > .active > span:hover {
            z-index: 2;
            color: #fff;
            cursor: default;
            background-color: #cbddfa;
            border-color: #cbddfa;
        }

        .page-item.active .page-link {
            z-index: 2;
            color: #fff;
            background-color: #cbddfa;
            border-color: #cbddfa;
        }

        .edit-bt {
            background: transparent;
            border: none;
            font-size: 22px;
            position: relative;
            top: -3px;
            color: #1e88e5;
        }

        .h-tabs input[type=checkbox] {
            outline: none;
        }

        .h-type .table-responsive table.table thead th :nth-child(4) {
            padding-left: 0px;
        }

        .h-tabs .table-responsive {
            border-bottom: none;
        }

       .bottom-bar input{
        height:23px;
        /*padding: 0;*/
        font-size: 11px;    
        border-radius: 0;
        padding-left: 10px;
       border:1px solid #bbb;
       border-radius:3px;
       padding:8px 12px;
     
}

      

        #DivList .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            /* padding-left: 25px; */
            /* padding-top: 10px; */
            position: relative;
        }

        .dataTables_info {
            font-size: 13px;
        }

        #frmType {
            width: 100%;
        }

     

        #accordion {
            overflow: hidden;
        }

        .fa-pencil-square-o {
            color: #4caac0 !important;
        }

        .dataTables_scrollBody .table tbody .even {
            background-color: #e8edf6;
        }

        input, select, textarea {
            margin-top: 6px;
        }


        .form-control {
            font-weight: 100;
        }

     
        .form-horizontal {
            width: 100%;
            line-height: 2;
        }

        #accordion4 .form-group {
            border-bottom: none;
        }

      
        .container-fluid {
            min-height: 0px !important;
        }

        #CboType {
            width: 75px;
        }

        #idSearchHistory {
            position: absolute;
            margin-top: 14px;
            margin-left: 10px;
        }

        .panel-group {
            margin-bottom: 0px !important;
        }

        #page-top {
        }

        .setting-src {
            padding: 0px !important;
        }

        .selected_user {
            background: #cbddfa;
        }
          #divScroll {
        width:102%;
        padding-right:2%;
        overflow:auto;
      }
            #formSection {
             width:100%;
         }
         .clstable {
             width:100%;
         }
           
         .breadcrumb {
            background-color:#eeeeee;
        }

       

         .clsalign {
             text-align:center;
         }
      
          
        
           label {
                font-weight: normal;
            }
    
       
          #MainDiv {
            overflow:auto!important;
            width:103%;
            padding-right:5%;
         }
         #MainBody {
             font-size:12px!important;
         }
          .box {
            border-top:0px !important;
        }
  
        .btn-primary {
            width:100px!important;
            border: 1px solid #204d74!important;
            background-color: #204d74!important;
        }
        .lblHeading {
            /*font-weight:600 !important;*/
            padding-bottom:7PX;
        }
        #btnSave {
            margin-left: 5px;
            font-size: 11px;
            line-height: 25px;    
            margin-right:5px;
            color: white!important;
            /*border-color: #4b3b86 !important;*/
            font-weight:600;
            width:52px;
            margin-top:9px;
        }
        #btnCancel {
            border:none;
            border-left:1px solid;
            font-size: 11px;
            line-height: 25px;              
             color: white!important;
             /*border-color: #4b3b86 !important;*/
              font-weight:600;
              width:52px;
              margin-right:21px;
              margin-top:9px;
        }
        #idShowHistory {
            border:none;
            border-left:1px solid;
            font-size: 11px;
            line-height: 25px;              
             color: white!important;
             /*border-color: #4b3b86 !important;*/
              font-weight:600;
              width:82px;
              margin-right:7px;
              margin-top:9px;
        }
        #MainDiv input[type="checkbox"] {
            width:11px !important;
        }
        .clsTable {
            background-color:#ffffff!important;
        }
        #MainDiv {
            overflow:auto;
        }
        .form-group {
            border:none !important;
        }
       
        #MainDiv .clsTable td {
            vertical-align:middle !important;
        }
        #MainDiv .clsTable td input {
             margin-bottom:5px !important;
        }
          #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 30%;
        left: 50%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
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
        opacity: 0.4;
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
      .right .btn-default {
            background:#641a02 !important;
            color : white !important;
	    }
      .alertify-notifier {
            font-family: "Open Sans",sans-serif!important;
            font-size: 14px !important;
        }
        #ShowHistoryGrid .dataTables_scrollBody {
            margin-top:-4%;
            background-color:white!important;
            overflow:auto;
            width:100%;
	    }

         #ShowHistoryGrid table tr th {
           width:130px!important;
           text-align:center!important;
	    }

          #ShowHistoryGrid table tr td {
           width:130px!important;
            text-align:center!important;
	    }
  #ShowHistoryGrid .dataTable no-footer {
            width:651px!important;
	    }

	    #ShowHistoryGrid {
	        overflow: auto !Important;
	        
	        padding-right: -1%!important;
	        width: 105%!important;
	        height: 158px!important;
	        padding-right: 2%!important;
	    }

         input.form-control:not([type=button]) {
            background-color: #fff;
            border-color: transparent;
            box-sizing: border-box;
            padding: 4px;
            border: 1px solid #bbb;
            border-radius: 3px;
            color: #000;
            margin-bottom: 0px;
            margin-top: 6px;
            font-size: 12px!important;
            font-weight: 100!important;
            width: 200px!important;
        }


        input.form-control, input.form-control {
            height: 28px;
        }

        select.form-control {
           height:30px!important;
           width:200px!important;
        }

        
               #MainDiv {
            width: 102%;
            padding-right: 2%;
            /* overflow: auto; */
            /*height: 346px;*/
            overflow-x: hidden!important;
            overflow-y: auto!important;
}

                /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }
    </style>
    <%--<body class="" id="page-top" style="overflow: auto;">--%>

        <!-- Navigation -->


        <body id="MainBody" style="padding-left: 3%; padding-right: 1%; overflow: hidden; " onload="window_onloadPwdMgt()">
    <form id="FrmPwdMgnt" runat="server">
   <%--  <div>
            <ul class="breadcrumb">
                <li><a href="#">Configuration</a></li>
                <li><a href="#">Password Management</a></li>
            </ul>
        </div>--%>

        <div>
             <%PageInit()%>
       </div>

 </form>
            

       

         <div id="id13" class="modal">
              <div class="modal-content animate">
            <%--<form class="modal-content animate" action="/action_page.php">--%>
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close">&times;</span>
                </div>
                <div class="container-fluid">
                  
                     <div class="form-group">
                        <label class="control-label col-sm-2 clslabel" for="request type">Modified Field</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 1969", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 1969", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>
                    <div class="container-fluid" id="modalbody" style="overflow:auto;height: 160px;">
                    </div>
                </div>
                  </div>
            <%--</form>--%>
        </div>

   
</body>
    <%-- *************************************************** Modal Plotting **************************************************************** --%>
       
    <!-- Bootstrap core JavaScript -->
 
     


    
<script>
    function window_onloadPwdMgt()
    {
      
        //var intDivHeight;
        //var intRightDivHeight;
        //var objtabDiv = $("#MainDiv");
        ////var objRightDiv = $("#ListDiv");
        //intDivHeight = $('#FrmPwdMgnt').innerHeight() - objtabDiv.offset().top - 400;
        ////intRightDivHeight = window.innerHeight - objtabDiv.offset().top - 50;
        ////alert($('#FrmPwdMgnt').innerHeight());
        //objtabDiv.css("height", intDivHeight + 'px');
        ////objtabDiv.css("overflow", "auto");
        //alert($('#FrmPwdMgnt').innerHeight());
        //alert(window.innerHeight);
        //alert(document.getElementById("frmTagNavigation").offsetTop);
        var intDivGridListHeight;
        if ($(window).height() < 780) {
         
            intDivGridListHeight = parseInt(window.innerHeight) - 140;
            $('#MainDiv').css('height', "480px");
        }
        else if ($(window).height() < 850) {
          
            intDivGridListHeight = parseInt(window.innerHeight) - 255;
            $('#MainDiv').css('height', intDivGridListHeight);
        }
        else {
          
            intDivGridListHeight = parseInt(window.innerHeight) - 300;
            $('#MainDiv').css('height', intDivGridListHeight);
        }

       
    }

$(".list-group-item").click(function(){
if($(this).hasClass("selected_user"))
        {
            $(this).removeClass("selected_user");
        }
        else
        {
            $(this).addClass("selected_user");
        }
    });
$("#add").click(function(){
  var selected_users="";
	c=document.getElementsByClassName("selected_user");
		for (var i=0;i < c.length;i++)
	{
		selected_users+='<button type="button" class=" btn  btn-primary " style="margin-left:20px; margin-top:10px;" ><span id="test" onclick="this.parentNode.parentNode.removeChild(this.parentNode);">'+c[i].innerText+'&#10006;</span></button>';
	
	}
	$(".right_section").html(selected_users);
 });


$(".list-group-item").click(function(){

  });

$(document).ready(function () {
   
    RefreshGridDetails();
    $(":checkbox").each(function () {
        EnableDisableControls(this);
    });

    /*Added by yasmin for pagination alignment on 18 july 2018*/
    $('[data-toggle="tooltip"]').tooltip();
});

/*Added by yasmin for pagination alignment on 18 july 2018*/
$('[data-toggle="tooltip"]').tooltip();
function RefreshGridDetails() {
    //  debugger;

    var strResult, data;
    var GridParameter = {};

    var TypeDiv; var accordion;
    var intDivGridHeight
    
    //if (isIE() == "IE") {
    var intDivGridHeight, intDivGridListHeight
    intDivGridListHeight = parseInt(window.innerHeight);
    if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

        $("#MainDiv").css('height', intDivGridListHeight - 280 + "px");
    }

    else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

        $("#MainDiv").css('height', intDivGridListHeight - 320 + "px");
    }
    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

        $("#MainDiv").css('height', intDivGridListHeight - 280 + "px");
    }
    else {
        $("#MainDiv").css('height', intDivGridListHeight - 280 + "px");
    }
    //}
    //else {
    //    intDivGridHeight = (window.innerHeight / 2);

    //    if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
    //        //alert(1);
    //        intDivGridListHeight = parseInt(window.innerHeight) - 370;
      
    //        $('#MainDiv').css('height', intDivGridListHeight -200 +'px');
    //    }

    //    else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
    //        //alert(2);
    //        intDivGridListHeight = parseInt(window.innerHeight) - 360;
        

    //        $('#MainDiv').css('height', intDivGridListHeight - 200 +'px');
    //    }
    //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
    //        //alert(3);
    //        intDivGridListHeight = parseInt(window.innerHeight) - 470;
     

    //        $('#MainDiv').css('height', intDivGridListHeight - 200 +'px');
    //    }
    //    else {
    //        //alert(4);
    //        intDivGridListHeight = parseInt(window.innerHeight) - 570;
    //        $('#MainDiv').css('height', intDivGridListHeight -200 + 'px');
    //    }



       
    //}

  

}
function EnableDisableControls(objControl) {


    var ObjControlID = objControl.id;
    // alert(ObjControlID);
    var objPassCaptchaCount = GetObjectReference("FrmPwdMgnt", "PassCaptchaCount");
    var objPassLockingCount = GetObjectReference("FrmPwdMgnt", "PassLockingCount");
    var objPassLockoutDuration = GetObjectReference("FrmPwdMgnt", "PassLockoutDuration");
    var objLockUserID = GetObjectReference("FrmPwdMgnt", "EnableLockUserID");
    var objLockoutDuration = GetObjectReference("FrmPwdMgnt", "EnablePassLockoutDuration");
    var objPassLockoutDuration = GetObjectReference("FrmPwdMgnt", "PassLockoutDuration");
    var objMinPassword = GetObjectReference("FrmPwdMgnt", "MiniPwdLength");
    var objMaxPassword = GetObjectReference("FrmPwdMgnt", "MaxPwdLength");
    var objNumOfAlpha = GetObjectReference("FrmPwdMgnt", "NumOfAlpha");
    var objNumOfNumerals = GetObjectReference("FrmPwdMgnt", "NumOfNumerals");
    var objNumOfSpecial = GetObjectReference("FrmPwdMgnt", "NumOfSpecial")
    var ObjEnablePwdLength = GetObjectReference("FrmPwdMgnt", "EnablePwdLength")
    var ObjEnableAlphaNumSpecialChar = GetObjectReference("FrmPwdMgnt", "EnableAlphaNumSpecialChar")

    var objEnableCaptcha = GetObjectReference("FrmPwdMgnt", "EnableCaptcha");

    switch (ObjControlID) {
        case "EnablePwdLength":

            if (objControl.checked == true) {

                objMinPassword.disabled = false;
                objMaxPassword.disabled = false
                ObjEnableAlphaNumSpecialChar.checked = true
                objNumOfAlpha.disabled = false;
                objNumOfNumerals.disabled = false;
                objNumOfSpecial.disabled = false;
                //if (objMinPassword != null) {
                //    objMinPassword.value = 5;
                //}
                //if (objMaxPassword != null) {
                //    objMaxPassword.value = 7;
                //}
            }
            else {
                objMinPassword.disabled = true;
                objMaxPassword.disabled = true;
                ObjEnableAlphaNumSpecialChar.checked = false
                objNumOfAlpha.disabled = true;
                objNumOfNumerals.disabled = true;
                objNumOfSpecial.disabled = true;
                objNumOfAlpha.value = "";
                objNumOfNumerals.value = "";
                objNumOfSpecial.value = "";
                if (objMinPassword != null) {
                    objMinPassword.value = "";
                }
                if (objMaxPassword != null) {
                    objMaxPassword.value = "";
                }
            }
            break;
        case "EnableAlphaNumSpecialChar":
            ;
            if (objControl.checked == true) {
                objNumOfAlpha.disabled = false;
                objNumOfNumerals.disabled = false;
                objNumOfSpecial.disabled = false;
                ObjEnablePwdLength.checked = true
                objMinPassword.disabled = false;
                objMaxPassword.disabled = false
                //if (objMinPassword != null) {
                //    objMinPassword.value = 5;
                //}
                //if (objMaxPassword != null) {
                //    objMaxPassword.value = 7;
                //}
            }
            else {
                objNumOfAlpha.disabled = true;
                objNumOfNumerals.disabled = true;
                objNumOfSpecial.disabled = true;
                objNumOfAlpha.value = "";
                objNumOfNumerals.value = "";
                objNumOfSpecial.value = "";
                ObjEnablePwdLength.checked = false
                objMinPassword.disabled = true;
                objMaxPassword.disabled = true
                if (objMinPassword != null) {
                    objMinPassword.value = "";
                }
                if (objMaxPassword != null) {
                    objMaxPassword.value = "";
                }
            }
            break;
        case "EnablePassPhrases":
            var objPassPharsesDays = GetObjectReference("FrmPwdMgnt", "PassPharsesDays");

            if (objControl.checked == true) {
                objPassPharsesDays.disabled = false;
            }
            else {
                objPassPharsesDays.disabled = true;
                objPassPharsesDays.value = "";
            }
            break;

        case "EnablePreviousPassCheck":
            var objPreviousPassCount = GetObjectReference("FrmPwdMgnt", "PreviousPassCount");

            if (objControl.checked == true) {
                objPreviousPassCount.disabled = false;
            }
            else {
                objPreviousPassCount.disabled = true;
                objPreviousPassCount.value = "";
            }
            break;
        case "EnablePassLockoutDuration":


            if (objControl.checked == true) {
                objPassLockoutDuration.disabled = false;
                if (objLockUserID != null) {
                    objLockUserID.checked = true;
                    objPassLockingCount.disabled = false;
                }
            }
            else {
                objPassLockoutDuration.disabled = true;
                objPassLockoutDuration.value = "";
                if (objLockUserID != null) {
                    objLockUserID.checked = false;
                    objPassLockingCount.disabled = true;
                    objPassLockingCount.value = "";

                }
            }
            break;

        case "EnableLockUserID":


            if (objControl.checked == true) {

                objPassLockingCount.disabled = false;

                if (objLockoutDuration != null) {
                    objLockoutDuration.checked = true;
                    objPassLockoutDuration.disabled = false;
                    objPassLockingCount.disabled = false;


                }

            }
            else {

                objPassLockingCount.disabled = true;
                objPassLockingCount.value = "";
                if (objLockoutDuration != null) {
                    objLockoutDuration.checked = false;
                    objPassLockoutDuration.disabled = true;
                    objPassLockoutDuration.value = "";

                }
            }
            break;
        case "EnableCaptcha":
            if (objControl.checked == true) {
                objPassCaptchaCount.disabled = false;
            }
            else {
                objPassCaptchaCount.value = "";
                objPassCaptchaCount.disabled = true;
            }
            break;
    }


}
function EnablePWD(objControl) {
    var ObjControlID = objControl.id;
    var objPassCaptchaCount = GetObjectReference("FrmPwdMgnt", "PassCaptchaCount");
    var objPassLockingCount = GetObjectReference("FrmPwdMgnt", "PassLockingCount");
    var objPassLockoutDuration = GetObjectReference("FrmPwdMgnt", "PassLockoutDuration");
    var objLockUserID = GetObjectReference("FrmPwdMgnt", "EnableLockUserID");
    var objLockoutDuration = GetObjectReference("FrmPwdMgnt", "EnablePassLockoutDuration");
    var objPassLockoutDuration = GetObjectReference("FrmPwdMgnt", "PassLockoutDuration");
    var objMinPassword = GetObjectReference("FrmPwdMgnt", "MiniPwdLength");
    var objMaxPassword = GetObjectReference("FrmPwdMgnt", "MaxPwdLength");
    var objNumOfAlpha = GetObjectReference("FrmPwdMgnt", "NumOfAlpha");
    var objNumOfNumerals = GetObjectReference("FrmPwdMgnt", "NumOfNumerals");
    var objNumOfSpecial = GetObjectReference("FrmPwdMgnt", "NumOfSpecial")
    var ObjEnablePwdLength = GetObjectReference("FrmPwdMgnt", "EnablePwdLength")
    var ObjEnableAlphaNumSpecialChar = GetObjectReference("frmCommonPage", "EnableAlphaNumSpecialChar")
    var objEnableCaptcha = GetObjectReference("FrmPwdMgnt", "EnableCaptcha");
    switch (ObjControlID) {
        case "EnablePwdLength":
            if (objControl.checked == true) {
                objMinPassword.disabled = false;
                objMaxPassword.disabled = false
                ObjEnableAlphaNumSpecialChar.checked = true
                objNumOfAlpha.disabled = false;
                objNumOfNumerals.disabled = false;
                objNumOfSpecial.disabled = false;
                if (objMinPassword != null) {
                    objMinPassword.value = 5;
                }
                if (objMaxPassword != null) {
                    objMaxPassword.value = 7;
                }
            } else {
                objMinPassword.disabled = true;
                objMaxPassword.disabled = true;
                ObjEnableAlphaNumSpecialChar.checked = false
                objNumOfAlpha.disabled = true;
                objNumOfNumerals.disabled = true;
                objNumOfSpecial.disabled = true;
                objNumOfAlpha.value = "";
                objNumOfNumerals.value = "";
                objNumOfSpecial.value = "";
                if (objMinPassword != null) {
                    objMinPassword.value = "";
                } if (objMaxPassword != null) {
                    objMaxPassword.value = "";
                }
            }
            break;
        case "EnableAlphaNumSpecialChar":;
            if (objControl.checked == true) {
                objNumOfAlpha.disabled = false;
                objNumOfNumerals.disabled = false;
                objNumOfSpecial.disabled = false;
                ObjEnablePwdLength.checked = true;
                objMinPassword.disabled = false;
                objMaxPassword.disabled = false
                if (objMinPassword != null) {
                    objMinPassword.value = 5;
                } if (objMaxPassword != null) {
                    objMaxPassword.value = 7;
                }
            }
            else {
                objNumOfAlpha.disabled = true;
                objNumOfNumerals.disabled = true;
                objNumOfSpecial.disabled = true;
                objNumOfAlpha.value = "";
                objNumOfNumerals.value = "";
                objNumOfSpecial.value = "";
                ObjEnablePwdLength.checked = false
                objMinPassword.disabled = true;
                objMaxPassword.disabled = true
                if (objMinPassword != null) {
                    objMinPassword.value = "";
                }
                if (objMaxPassword != null) {
                    objMaxPassword.value = "";
                }
            }
            break;
        case "EnablePassPhrases":
            var objPassPharsesDays = GetObjectReference("FrmPwdMgnt", "PassPharsesDays");
            if (objControl.checked == true) {
                objPassPharsesDays.disabled = false;
            } else {
                objPassPharsesDays.disabled = true;
                objPassPharsesDays.value = "";
            }
            break; case "EnablePreviousPassCheck":
                var objPreviousPassCount = GetObjectReference("FrmPwdMgnt", "PreviousPassCount");
                if (objControl.checked == true) {
                    objPreviousPassCount.disabled = false;
                }
                else {
                    objPreviousPassCount.disabled = true;
                    objPreviousPassCount.value = "";
                } break;
        case "EnablePassLockoutDuration":
            if (objControl.checked == true) {
                objPassLockoutDuration.disabled = false;
                if (objLockUserID != null) {
                    objLockUserID.checked = true;
                    objPassLockingCount.disabled = false;
                }
            } else {
                objPassLockoutDuration.disabled = true;
                objPassLockoutDuration.value = "";
                if (objLockUserID != null) {
                    objLockUserID.checked = false;
                    objPassLockingCount.disabled = true;
                    objPassLockingCount.value = "";
                }
            } break;
        case "EnableLockUserID":
            if (objControl.checked == true) {
                objPassLockingCount.disabled = false;
                if (objLockoutDuration != null) {
                    objLockoutDuration.checked = true;
                    objPassLockoutDuration.disabled = false;
                    objPassLockingCount.disabled = false;
                }
            } else {
                objPassLockingCount.disabled = true;
                objPassLockingCount.value = "";
                if (objLockoutDuration != null) {
                    objLockoutDuration.checked = false;
                    objPassLockoutDuration.disabled = true;
                    objPassLockoutDuration.value = "";
                }
            } break;
        case "EnableCaptcha":
            if (objControl.checked == true) {
                objPassCaptchaCount.disabled = false;
            }
            else {
                objPassCaptchaCount.value = ""; objPassCaptchaCount.disabled = true;
            }
            break;
    }
}
function Save_Data() {
    //debugger;
    // if (validation() == true)
    //{
    if (validation()) {
        var Firsttimelogin, EnablePwdOnRese, EnablePwdLength, MiniPwdLength, MaxPwdLength, EnableAlphaNumSpecialChar, NumOfAlpha, NumOfNumerals, NumOfSpecial, AllowSameLoginPwd, EnablePassPhrases;
        var PassPharsesDays, EnablePreviousPassCheck, PreviousPassCount, EnablePassLockoutDuration, PassLockoutDuration, EnableLockUserID, PassLockingCount, EnableCaptcha, PassCaptchaCount, IsAutoPasswordCreation;

        if (document.getElementById("EnableFirstTimeLogin").checked == true) {
            Firsttimelogin = "1";
        }
        else {
            Firsttimelogin = "0";
        }

        if (document.getElementById("EnablePwdOnReset").checked == true) {
            EnablePwdOnReset = "1";
        }
        else {
            EnablePwdOnReset = "0";
        }

        //if (document.getElementById("EnablePwdLength").checked == true) {
        //    EnablePwdLength = "1";
        //}
        //else {
        //    EnablePwdLength = "0";
        //}


        if (document.getElementById("EnablePwdLength").checked == true) {
            EnablePwdLength = "1";
            MiniPwdLength = $("#MiniPwdLength").val();
            MaxPwdLength = $("#MaxPwdLength").val();
            EnableAlphaNumSpecialChar = "1"
            NumOfAlpha = $("#NumOfAlpha").val();
            NumOfNumerals = $("#NumOfNumerals").val();
            // alert(NumOfNumerals);
            NumOfSpecial = $("#NumOfSpecial").val();


        }
        else {
            //EnablePwdLength = "0";
            //EnableAlphaNumSpecialChar = "0"
            //MiniPwdLength = 0;
            //MaxPwdLength = 0;

            //NumOfAlpha = 0;
            //NumOfNumerals = 0;
            //NumOfSpecial = 0;
        }

        if (document.getElementById("AllowSameLoginPwd").checked == true) {
            AllowSameLoginPwd = "1";
        }
        else {
            AllowSameLoginPwd = "0";

        }

        if (document.getElementById("EnablePassPhrases").checked == true) {
            EnablePassPhrases = "1";
            PassPharsesDays = $("#PassPharsesDays").val();
        }
        else {
            EnablePassPhrases = "0";
            PassPharsesDays = "0"
        }

        if (document.getElementById("EnablePreviousPassCheck").checked == true) {
            EnablePreviousPassCheck = "1";
            PreviousPassCount = $("#PreviousPassCount").val();
        }
        else {
            EnablePreviousPassCheck = "0";
            PreviousPassCount = "0"
        }

        if (document.getElementById("EnablePassLockoutDuration").checked == true) {
            EnablePassLockoutDuration = "1";
            PassLockoutDuration = $("#PassLockoutDuration").val();
        }
        else {
            EnablePassLockoutDuration = "0";
            PassLockoutDuration = "0"
        }

        if (document.getElementById("EnableLockUserID").checked == true) {
            EnableLockUserID = "1";
            PassLockingCount = $("#PassLockingCount").val();
        }
        else {
            EnableLockUserID = "0";
            PassLockingCount = "0"
        }

        if (document.getElementById("EnableCaptcha").checked == true) {
            EnableCaptcha = "1";
            PassCaptchaCount = $("#PassCaptchaCount").val();
        }
        else {
            EnableCaptcha = "0";
            PassCaptchaCount = "0"
        }


        if (document.getElementById("IsAutoPasswordCreation").checked == true) {
            IsAutoPasswordCreation = "1";

        }
        else {
            IsAutoPasswordCreation = "0";

        }






        if (Firsttimelogin == "" || Firsttimelogin == null)
            Firsttimelogin = 0
        if (EnablePwdOnReset == "" || EnablePwdOnReset == null)
            EnablePwdOnReset = 0
        if (EnablePwdLength == "" || EnablePwdLength == null)
            EnablePwdLength = 0
        if (MiniPwdLength == "" || MiniPwdLength == null)
            MiniPwdLength = 0
        if (MaxPwdLength == "" || MaxPwdLength == null)
            MaxPwdLength = 0
        if (EnableAlphaNumSpecialChar == "" || EnableAlphaNumSpecialChar == null)
            EnableAlphaNumSpecialChar = 0
        if (NumOfAlpha == "" || NumOfAlpha == null)
            NumOfAlpha = 0
        if (NumOfNumerals == "" || NumOfNumerals == null)
            NumOfNumerals = 0
        if (NumOfSpecial == "" || NumOfSpecial == null)
            NumOfSpecial = 0
        if (AllowSameLoginPwd == "" || AllowSameLoginPwd == null)
            AllowSameLoginPwd = 0

        if (EnablePassPhrases == "" || EnablePassPhrases == null)
            EnablePassPhrases = 0

        if (PassPharsesDays == "" || PassPharsesDays == null)
            PassPharsesDays = 0

        if (EnablePreviousPassCheck == "" || EnablePreviousPassCheck == null)
            EnablePreviousPassCheck = 0

        if (PreviousPassCount == "" || PreviousPassCount == null)
            PreviousPassCount = 0





        if (EnablePassLockoutDuration == "" || EnablePassLockoutDuration == null)
            EnablePassLockoutDuration = 0

        if (PassLockoutDuration == "" || PassLockoutDuration == null)
            PassLockoutDuration = 0

        if (EnableLockUserID == "" || EnableLockUserID == null)
            EnableLockUserID = 0


        if (PassLockingCount == "" || PassLockingCount == null)
            PassLockingCount = 0

        if (EnableCaptcha == "" || EnableCaptcha == null)
            EnableCaptcha = 0


        if (PassCaptchaCount == "" || PassCaptchaCount == null)
            PassCaptchaCount = 0

        if (IsAutoPasswordCreation == "" || IsAutoPasswordCreation == null)
            IsAutoPasswordCreation = 0


        var data;
        data = JSON.stringify({
            Firsttimelogin: Firsttimelogin,
            EnablePwdOnReset: EnablePwdOnReset,
            EnablePwdLength: EnablePwdLength,
            MiniPwdLength: MiniPwdLength,
            MaxPwdLength: MaxPwdLength,
            EnableAlphaNumSpecialChar: EnableAlphaNumSpecialChar,
            NumOfAlpha: NumOfAlpha,
            NumOfNumerals: NumOfNumerals,
            NumOfSpecial: NumOfSpecial,
            AllowSameLoginPwd: AllowSameLoginPwd,
            EnablePassPhrases: EnablePassPhrases,
            PassPharsesDays: PassPharsesDays,
            EnablePreviousPassCheck: EnablePreviousPassCheck,
            PreviousPassCount: PreviousPassCount,
            EnablePassLockoutDuration: EnablePassLockoutDuration,
            PassLockoutDuration: PassLockoutDuration,
            EnableLockUserID: EnableLockUserID,
            PassLockingCount: PassLockingCount,
            EnableCaptcha: EnableCaptcha,
            PassCaptchaCount: PassCaptchaCount,
            IsAutoPasswordCreation: IsAutoPasswordCreation
        });
        setFrameLoader();
        var strResult = AJAXCallWithResult("PasswordManagement.aspx/SaveData", data, false);
        if (strResult.d != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Data saved successfully', 'success');
            //alert(strResult.d);
            document.getElementById("MainDiv").innerHTML = ""
            document.getElementById("MainDiv").innerHTML = strResult.d;

            $(":checkbox").each(function () {
                EnableDisableControls(this);
            });

        }
        RemoveFrameLoader();
    }
    RefreshGridDetails();
    
}


//function Clear_Data() {
//    var objEnableCaptcha = GetObjectReference("FrmPwdMgnt", "EnableCaptcha");
//    var objIsAutoPasswordCreation = GetObjectReference("FrmPwdMgnt", "IsAutoPasswordCreation");
//    var objEnableLockUserID = GetObjectReference("FrmPwdMgnt", "EnableLockUserID");
//    var objEnablePassLockoutDuration = GetObjectReference("FrmPwdMgnt", "EnablePassLockoutDuration");
//    var objEnablePreviousPassCheck = GetObjectReference("FrmPwdMgnt", "EnablePreviousPassCheck");
//    var objEnablePassPhrases = GetObjectReference("FrmPwdMgnt", "EnablePassPhrases");
//    var objAllowSameLoginPwd = GetObjectReference("FrmPwdMgnt", "AllowSameLoginPwd");
//    var objEnableAlphaNumSpecialChar = GetObjectReference("FrmPwdMgnt", "EnableAlphaNumSpecialChar");
//    var objEnablePwdLength = GetObjectReference("FrmPwdMgnt", "EnablePwdLength");
//    var objEnablePwdOnReset = GetObjectReference("FrmPwdMgnt", "EnablePwdOnReset");
//    var objEnableFirstTimeLogin = GetObjectReference("FrmPwdMgnt", "EnableFirstTimeLogin");
             
//    var objPassCaptchaCount = GetObjectReference("FrmPwdMgnt", "PassCaptchaCount");
//    var objPassLockingCount = GetObjectReference("FrmPwdMgnt", "PassLockingCount");
//    var objPassLockoutDuration = GetObjectReference("FrmPwdMgnt", "PassLockoutDuration");
//    var objPreviousPassCount = GetObjectReference("FrmPwdMgnt", "PreviousPassCount");
//    var objPassPharsesDays = GetObjectReference("FrmPwdMgnt", "PassPharsesDays");
//    var objNumOfSpecial = GetObjectReference("FrmPwdMgnt", "NumOfSpecial");
//    var objNumOfAlpha = GetObjectReference("FrmPwdMgnt", "NumOfAlpha");
//    var objNumOfNumerals = GetObjectReference("FrmPwdMgnt", "NumOfNumerals");
//    var objMiniPwdLength = GetObjectReference("FrmPwdMgnt", "MiniPwdLength");
//    var objMaxPwdLength = GetObjectReference("FrmPwdMgnt", "MaxPwdLength");

//    objEnableCaptcha.checked = false;
//    objIsAutoPasswordCreation.checked = false;
//    objEnableLockUserID.checked = false;
//    objEnablePassLockoutDuration.checked = false;
//    objEnablePreviousPassCheck.checked = false;
//    objEnablePassPhrases.checked = false;
//    objAllowSameLoginPwd.checked = false;
//    objEnableAlphaNumSpecialChar.checked = false;
//    objEnablePwdLength.checked = false;
//    objEnablePwdOnReset.checked = false;
//    objEnableFirstTimeLogin.checked = false;

//    objPassCaptchaCount.value = "";
//    objPassLockingCount.value = "";
//    objPassLockoutDuration.value = "";
//    objPreviousPassCount.value = "";
//    objPassPharsesDays.value = "";
//    objNumOfSpecial.value = "";
//    objNumOfAlpha.value = "";
//    objNumOfNumerals.value = "";
//    objMiniPwdLength.value = "";
//    objMaxPwdLength.value = "";
//    //window.location.href = window.location.href;
//}
function Clear_Data()
{
        var objEnableCaptcha = GetObjectReference("FrmPwdMgnt", "EnableCaptcha");
        var objIsAutoPasswordCreation = GetObjectReference("FrmPwdMgnt", "IsAutoPasswordCreation");
        var objEnableLockUserID = GetObjectReference("FrmPwdMgnt", "EnableLockUserID");
        var objEnablePassLockoutDuration = GetObjectReference("FrmPwdMgnt", "EnablePassLockoutDuration");
        var objEnablePreviousPassCheck = GetObjectReference("FrmPwdMgnt", "EnablePreviousPassCheck");
        var objEnablePassPhrases = GetObjectReference("FrmPwdMgnt", "EnablePassPhrases");
        var objAllowSameLoginPwd = GetObjectReference("FrmPwdMgnt", "AllowSameLoginPwd");
        var objEnableAlphaNumSpecialChar = GetObjectReference("FrmPwdMgnt", "EnableAlphaNumSpecialChar");
        var objEnablePwdLength = GetObjectReference("FrmPwdMgnt", "EnablePwdLength");
        var objEnablePwdOnReset = GetObjectReference("FrmPwdMgnt", "EnablePwdOnReset");
        var objEnableFirstTimeLogin = GetObjectReference("FrmPwdMgnt", "EnableFirstTimeLogin");

        var objPassCaptchaCount = GetObjectReference("FrmPwdMgnt", "PassCaptchaCount");
        var objPassLockingCount = GetObjectReference("FrmPwdMgnt", "PassLockingCount");
        var objPassLockoutDuration = GetObjectReference("FrmPwdMgnt", "PassLockoutDuration");
        var objPreviousPassCount = GetObjectReference("FrmPwdMgnt", "PreviousPassCount");
        var objPassPharsesDays = GetObjectReference("FrmPwdMgnt", "PassPharsesDays");
        var objNumOfSpecial = GetObjectReference("FrmPwdMgnt", "NumOfSpecial");
        var objNumOfAlpha = GetObjectReference("FrmPwdMgnt", "NumOfAlpha");
        var objNumOfNumerals = GetObjectReference("FrmPwdMgnt", "NumOfNumerals");
        var objMiniPwdLength = GetObjectReference("FrmPwdMgnt", "MiniPwdLength");
        var objMaxPwdLength = GetObjectReference("FrmPwdMgnt", "MaxPwdLength");

        data = JSON.stringify({ 1: 1 });
    var strResult = AJAXCallWithResult("PasswordManagement.aspx/ClearData", data, false);
    if (strResult.d != "")
    {
        //alertify.set('notifier', 'position', 'top-right');
        //alertify.notify('Data saved successfully', 'success');
        //alert(strResult.d);
        //document.getElementById("MainDiv").innerHTML = ""
        //document.getElementById("MainDiv").innerHTML = strResult.d;

        var arrResult = strResult.d.split("#$#");

        
        EnableFirstTimeLogin = arrResult[0];
        EnablePwdOnReset = arrResult[1];
        EnablePwdLength = arrResult[2];
        MiniPwdLength = arrResult[3];
        MaxPwdLength = arrResult[4];
        EnableAlphaNumSpecialChar = arrResult[5];
        NumOfAlpha = arrResult[6];
        NumOfNumerals = arrResult[7];
        NumOfSpecial = arrResult[8];
        AllowSameLoginPwd = arrResult[9];
        EnablePassPhrases = arrResult[10];
        PassPharsesDays = arrResult[11];
        EnablePreviousPassCheck = arrResult[12];
        PassLockoutDuration = arrResult[13];
        EnableLockUserID = arrResult[14];
        PassLockingCount = arrResult[15];
        PassCaptchaCount = arrResult[16];
        EnableCaptcha = arrResult[17];
        IsAutoPasswordCreation = arrResult[18];
        PreviousPassCount = arrResult[19];
        EnablePassLockoutDuration = arrResult[20];

             
        if (EnableFirstTimeLogin == "False") {           
            $("#EnableFirstTimeLogin").prop('checked', false);
        }
        if (EnablePwdOnReset == "False") {
            $("#EnablePwdOnReset").prop('checked', false);
        }
        if (EnablePwdLength == "False") {
            $("#EnablePwdLength").prop('checked', false);
        }
        if (EnableAlphaNumSpecialChar == "False") {
            $("#EnableAlphaNumSpecialChar").prop('checked', false);
        }
        if (AllowSameLoginPwd == "False") {
            $("#AllowSameLoginPwd").prop('checked', false);
        }
        if (EnablePassPhrases == "False") {
            $("#EnablePassPhrases").prop('checked', false);
        }
        if (EnablePreviousPassCheck == "False") {
            $("#EnablePreviousPassCheck").prop('checked', false);
        }
        if (EnablePassLockoutDuration == "False") {
            $("#EnablePassLockoutDuration").prop('checked', false);
        }
        if (EnableLockUserID == "False") {
            $("#EnableLockUserID").prop('checked', false);
        }
        if (IsAutoPasswordCreation == "False") {
            $("#IsAutoPasswordCreation").prop('checked', false);
        }
        if (EnableCaptcha == "False") {
            $("#EnableCaptcha").prop('checked', false);
        }
            $("#PassCaptchaCount").val(arrResult[16]);
            $("#PassLockingCount").val(arrResult[15]);
            $("#PassLockoutDuration").val(arrResult[13]);
            $("#PreviousPassCount").val(arrResult[19]);
            $("#PassPharsesDays").val(arrResult[11]);
            $("#NumOfSpecial").val(arrResult[8]);
            $("#NumOfAlpha").val(arrResult[6]);
            $("#NumOfNumerals").val(arrResult[7]);
            $("#MiniPwdLength").val(arrResult[3]);
            $("#MaxPwdLength").val(arrResult[4]);           

        $(":checkbox").each(function () {
            EnableDisableControls(this);
        });

    }
}
function validation() {
    var strAlertMsg = "";
    var objEnablePwdLength = GetObjectReference("FrmPwdMgnt", "EnablePwdLength");
    var objMiniPwdLength = GetObjectReference("FrmPwdMgnt", "MiniPwdLength");
    var objMaxPwdLength = GetObjectReference("FrmPwdMgnt", "MaxPwdLength");
    if (objEnablePwdLength != null) {
        if (objEnablePwdLength.checked == true) {
            if (objMiniPwdLength != null) {
                if (disallowNegativeInteger(objMiniPwdLength))
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please enter only positive Integer', 'error');
                    objMiniPwdLength.focus();                   
                    return false;
                }

                if (disallowSpecialCharacters(objMiniPwdLength))
                { 
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- A Minimum Length cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
                    objMiniPwdLength.focus();
                    return false;
                }

                if (objMiniPwdLength.value <= 0) {

                    // alert("'Minimum Length' should not be left blank");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("- 'Minimum Length' should be greater than ''0'", 'error');
                    objMiniPwdLength.focus();
                    return false;
                }
                if (objMiniPwdLength.value < 5) {
                    // alert("'Minimum Length' should not be less than 5 ");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("- 'Minimum Length' should not be less than 5 ", 'error');
                    objMiniPwdLength.focus();
                    return false;
                }
            }
            if (objMaxPwdLength != null) {
                if (disallowNegativeInteger(objMaxPwdLength)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please enter only positive Integer', 'error');
                    objMaxPwdLength.focus();
                    return false;
                }
                if (disallowSpecialCharacters(objMaxPwdLength)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- A Maximum Length cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
                    objMiniPwdLength.focus();
                    return false;
                }
                if (objMaxPwdLength.value <= 0) {

                    // alert("'Maximum Length' should not be left blank");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("- 'Maximum Length' should be greater than '0'", 'error');
                    objMaxPwdLength.focus();
                    return false;
                }
                if (objMaxPwdLength.value < 7) {
                    //alert("'Maximum Length' should not be less than 7 ");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("- 'Maximum Length' should not be less than 7 ", 'error');
                    objMaxPwdLength.focus();
                    return false;
                }
            }
        }
    }
    var objANSpechar = GetObjectReference("FrmPwdMgnt", "EnableAlphaNumSpecialChar");
    var objAlpha = GetObjectReference("FrmPwdMgnt", "NumOfAlpha");
    var objNumber = GetObjectReference("FrmPwdMgnt", "NumOfNumerals");
    var objSpecl = GetObjectReference("FrmPwdMgnt", "NumOfSpecial");
    var intTotal = 0;
    var intAlpha, intNumber, intSpecl
    if (objAlpha != null && objNumber != null && objSpecl != null) {
        if (disallowNegativeInteger(objAlpha)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please enter only positive Integer', 'error');
            objAlpha.focus();
            return false;
        }
        if (disallowSpecialCharacters(objAlpha)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- A Alphabet cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
            objAlpha.focus();
            return false;
        }

        if (disallowNegativeInteger(objNumber)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please enter only positive Integer', 'error');
            objNumber.focus();
            return false;
        }
        if (disallowSpecialCharacters(objNumber)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- A Numeral cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
            objNumber.focus();
            return false;
        }
        if (disallowNegativeInteger(objSpecl)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please enter only positive Integer', 'error');
            objSpecl.focus();
            return false;
        }
        if (disallowSpecialCharacters(objSpecl)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- A Special Character cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
            objMiniPwdLength.focus();
            return false;
        }

        if (objAlpha.value == "") {
            intAlpha = 0;
            objAlpha.value = 0;
        }
        else
            intAlpha = objAlpha.value;
        if (objNumber.value == "") {
            intNumber = 0;
            objNumber.value = 0;
        }
        else
            intNumber = objNumber.value;
        if (objSpecl.value == "") {
            intSpecl = 0;
            objSpecl.value = 0;
        }
        else
            intSpecl = objSpecl.value;
        intTotal = parseInt(intAlpha) + parseInt(intNumber) + parseInt(intSpecl);
    }
    if (objANSpechar != null) {
        if (objANSpechar.checked == true) {
            if (objMiniPwdLength != null) {
                if (objMiniPwdLength.value > 0 && (intTotal > objMaxPwdLength.value || intTotal < objMiniPwdLength.value)) {

                 
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("- Sum of Alphabet(s),Numeral(s) and Special Character(s) should be greater than or equal to " + objMiniPwdLength.value + " and less than or equal to " + objMaxPwdLength.value + "", 'error');
                    objAlpha.focus();
                    return false;
                }
            }
         
        }
    }  
    var objChangePass = GetObjectReference("FrmPwdMgnt", "EnablePassPhrases");
    var objChangePassDay = GetObjectReference("FrmPwdMgnt", "PassPharsesDays");
    var objCheckOldPass = GetObjectReference("FrmPwdMgnt", "EnablePreviousPassCheck");
    var objCheckOldPassCount = GetObjectReference("FrmPwdMgnt", "PreviousPassCount");
    var objSetLockoutPass = GetObjectReference("FrmPwdMgnt", "EnablePassLockoutDuration");
    var objSetLockoutPassCount = GetObjectReference("FrmPwdMgnt", "PassLockoutDuration");
    if (objChangePass != null) {
        if (objChangePass.checked == true) {
            if (disallowNegativeInteger(objChangePassDay)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter only positive Integer', 'error');
                objChangePassDay.focus();
                return false;
            }
            if (disallowSpecialCharacters(objChangePassDay)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- A Days Length cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
                objChangePassDay.focus();
                return false;
            }
            if (objChangePassDay.value == "") {
                //alert("Day's should not be left blank");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("- Day's should not be left blank", 'error');
                objChangePassDay.focus();
                return false;
            }
           
        }
    }
    if (objCheckOldPass.value != null) {
        if (objCheckOldPass.checked == true) {
            if (objCheckOldPassCount.value == "") {
                //alert("Count should not be left blank");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("- Count should not be left blank", 'error');
                objCheckOldPassCount.focus();
                return false;
            }
            if (disallowNegativeInteger(objCheckOldPassCount)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter only positive Integer', 'error');
                objChangePass.focus();
                return false;
            }
            if (disallowSpecialCharacters(objCheckOldPassCount)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- A Count Length cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
                objChangePass.focus();
                return false;
            }
        }
    }
    if (objSetLockoutPass.value != null) {
        if (objSetLockoutPass.checked == true) {
            if (objSetLockoutPassCount.value == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("- Duration should not be left blank", 'error');
                // alert("Duration should not be left blank");
                objSetLockoutPassCount.focus();
                return false;
            }
            if (disallowNegativeInteger(objSetLockoutPassCount)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter only positive Integer', 'error');
                objSetLockoutPassCount.focus();
                return false;
            }
            if (disallowSpecialCharacters(objSetLockoutPassCount)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- A Duration cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
                objSetLockoutPassCount.focus();
                return false;
            }
        }
    }
    var objEnablePassLock = GetObjectReference("FrmPwdMgnt", "EnableLockUserID");
    var objPassLockingCount = GetObjectReference("FrmPwdMgnt", "PassLockingCount");
    var objCaptchaCount = GetObjectReference("FrmPwdMgnt", "PassCaptchaCount");
    if (objEnablePassLock != null) {
        if (objEnablePassLock.checked == true) {
            if (objPassLockingCount != null) {
                if (objPassLockingCount.value == "") {
                    //alert(" Locking Count should not be left blank");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("- Locking Count should not be left blank", 'error');
                    objPassLockingCount.focus();
                    return false;
                }
                if (disallowNegativeInteger(objCaptchaCount)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please enter only positive Integer', 'error');
                    objCaptchaCount.focus();
                    return false;
                }
                if (disallowSpecialCharacters(objCaptchaCount)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- A Locking Count cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
                    objCaptchaCount.focus();
                    return false;
                }
                if (disallowNegativeInteger(objPassLockingCount)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please enter only positive Integer', 'error');
                    objPassLockingCount.focus();
                    return false;
                }
                if (disallowSpecialCharacters(objPassLockingCount)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- A Locking Count cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
                    objPassLockingCount.focus();
                    return false;
                }

                if (disallowValue1EqualToValue2(objCaptchaCount, objPassLockingCount)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("- A Locking Count should  be greater than Captcha Count.", 'error');
                    objPassLockingCount.focus();
                    return false ;
                }
                if (disallowValue1GreaterThanValue2(objCaptchaCount, objPassLockingCount)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("-The Locking Count should  be greater than Captcha Count.", 'error');
                    objPassLockingCount.focus();
                    return false ;
                }
            }
        }
    }
    var objEnableCaptcha = document.getElementById('EnableCaptcha');
    if (objEnableCaptcha.checked == true) {
        if (objCaptchaCount.value == "") {
            //alert(" Captcha Count should not be left blank");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("- Captcha Count should not be left blank", 'error');
            objCaptchaCount.focus();
            return false;
        }
        if (disallowNegativeInteger(objCaptchaCount)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please enter only positive Integer', 'error');
            objEnableCaptcha.focus();
            return false;
        }
        if (disallowSpecialCharacters(objCaptchaCount)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- A Captcha Count cannot contain any of these /\\:*?<>|,"+- characters.', 'error');
            objEnableCaptcha.focus();
            return false;
        }
    }

    return true;

}


function disallowValue1EqualToValue2(obj1, obj2) {
    if (obj1 == null) { return false; }
    if (obj2 == null) { return false; }
    if (isBlank(getInputValue(obj1))) { return false; }
    if (isBlank(getInputValue(obj2))) { return false; }
    var msg = (arguments.length > 2) ? arguments[2] : "";
    msg = replaceSubstring(msg, "&#39;", "'");
    var dofocus = (arguments.length > 3) ? arguments[3] : true;
    var val1 = parseFloat(obj1.value);
    var val2 = parseFloat(obj2.value);
    if (isNaN(val1)) { val1 = obj1.value; }
    if (isNaN(val2)) { val2 = obj2.value; }
    //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var matchCase = (arguments.length > 4) ? arguments[4] : true;
    if (matchCase == false) {
        if (isNaN(val1)) { val1 = val1.toUpperCase(); }//Modified By Ninad IssueID-29330
        if (isNaN(val2)) { val2 = val2.toUpperCase(); }//Modified By Ninad IssueID-29330
    }
    //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    if (val1 == val2) {
        if (!isBlank(msg)) { alert(msg); }
        if (dofocus) {
            setFocus(obj1);
        }
        return true;
    }
    return false;
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
function datatables(divID, txtBoxID) {

    $('#' + divID + ' > table').removeClass("clsGridTable");
    $('#' + divID + ' table').addClass("table table-bordered table-stripped");

    var table = $('#' + divID + ' > table').DataTable({
        //"ajax": {url: "{{ route('datatables') }}",
        ordering: false,
        responsive: true, "pageLength": 3,
                                    //Commented by Usha Pandit on 18.12.2017 for Grid height
        scrollY: '115px',                                   //Added by Usha Pandit on 18.12.2017 for Grid height
        pagingType: "simple_numbers",
        scrollX: true,
      
        language: {
           
        },
    });
   
    
}

function ShowHistory() {

    var obj = { "UniqueID": 1 };
    var myJSON = JSON.stringify(obj);
    var url = "PasswordManagement.aspx/ShowMailHistoryDetails"

    var result = AJAXCallWithResult(url, myJSON, false)

    //$("#id13").html(result.d);
    //$("#id13").html("");
    //document.getElementById('id13').innerHTML = result.d;   
    
   
    document.getElementById('id13').style.display = 'block';
    $("#id13 #modalbody").html(result.d);

    //$('#ShowHistoryGrid > table').removeClass("clsGridTable");
    //$('#ShowHistoryGrid > table').addClass("table table-bordered table-stripped");
   
    
    //datatables("ShowHistoryGrid", "txtSearchHistory");
    
   

}

function ModifiedFieldFilter_Change() {

    var ModifiedField = $('#cboModifiedField :selected').text();
    var ModifiedBy = $('#cboModifiedBy :selected').text();

    var obj = { "newModifiedField": ModifiedField, "MessageID": 1, "newModifiedBy": ModifiedBy };
    var myJSON = JSON.stringify(obj);

    var url = "PasswordManagement.aspx/FilteredHistory"
    var result = AJAXCallWithResult(url, myJSON, false)
    $("#id13 #modalbody").html(result.d);

    //datatables("ShowHistoryGrid", 'txtSearchHistory');

    document.getElementById('id13').style.display = 'block';
}


</script>

  

</html>
