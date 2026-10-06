<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EntityUpdateSchedule.aspx.vb" Inherits="PbNIT.EntityUpdateSchedule" %>
<!DOCTYPE html>
<html lang="en">

    <%CommonFunctions.General.PlotPageHeadTag("Setting")%>
  <head>
      <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="description" content="" />
    <meta name="author" content="" />
       <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("EntityUpdateSchedule")%>--%>
    <%--<title>Setting</title>--%>
      
<HEAD>
<%--<TITLE>Setting</TITLE>--%>
<meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
<meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
<meta name='vs_defaultClientScript' content='JavaScript'>
<meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<link rel='stylesheet' type='text/css' href='../General/StyleSheetChanakya_Purple.css'/>
<link id='lnkWhizStyleSheetImgDir' type='text/plain' href=' images/purple/'/>


<%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
 <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />

       <script src="../../../EnhancementFiles/OnlineFiles/js/jquery/2.1.4/jquery.min.js"></script>--%>
 
 <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/OnlineFiles/css/Jquery.ui.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />
       <script src="../../../EnhancementFiles/js/timepicker.min.js"></script>
 
  
</HEAD>

   
      <link href=" slacss.css" rel="stylesheet" />



	<style>
      /*Added By Yasmin on 25th july 2018*/
     .ui-tooltip {
	        padding: 5px!important;
	        position: absolute;
	        z-index: 9999;
	        max-width: 300px;
            background: #000 !important;
            color: #fff !important;
	        -webkit-box-shadow: 0!important;
	        box-shadow: 0 !important;
            border:none!important;
            font-size:11.5px!important;
        }
        .ui-tooltip-content::after, .ui-tooltip-content::before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
}

.bottom .ui-tooltip-content::after {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.bottom .ui-tooltip-content::before {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.top .ui-tooltip-content::after {
    top: -6px;
    left: 50%;
    border-bottom-color: #000;
    
    border-width: 0 6px 6px;
    margin-left: -6px;
}

.top .ui-tooltip-content::before {
     border-color: rgba(118, 118, 118, 0);
     border-bottom-color: #000;
     top: -6px;
     left: 50%;
     border-width: 0 6px 6px;
     margin-left: -6px;
 }
        .v-tabs .tabcontent {
            float: left;
            padding: 0;
            border-style: solid;
            border-color: #647ea8;
            border-width: 0px 0px 0px 0px!important;
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

       .clsTRColumnHeader th:nth-child(2) {
            text-align: center;
        }

        .clsTRColumnHeader th:nth-child(3) {
            text-align: center;
        }
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

      

        #divEntity .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divEntity .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
         
            position: relative;
        }

       
        .dataTables_info {
        font-size:13px;
        }
        #frmType {
        width:100%;
        }
       #divEntity .dataTables_wrapper {
           padding-right:15px;
        padding-left: 0px;
        margin-right: auto;
        margin-left: auto;
         }
        #accordion {
        overflow:hidden;
        }
        .fa-pencil-square-o {
    color: #4caac0 !important;
}

      
        #idPanelBody {
        overflow: auto;
        height: 175px;
        width: 103%;
        padding-right: 2%;
}
       #divEntity .dataTables_scroll {
        OVERFLOW: HIDDEN;
        }
       /*Changed By Yasmin on 25th july 2018*/

        #divEntity .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: auto!important;
            padding-right: 0.5%;
        }
       

       
        #collapseOne2 {
        overflow:hidden;
        }
         #collapseOne2 .panel-body {
           /*commented By Kashish for ui change*/
           /*overflow: auto;*/
        /*height: 150px;*/
        width: 103%;
        padding-right: 2%;
        }
     
        .form-control {
        font-weight:100;
        }
      
      
     
        
        #collapseOne4 {
            overflow:hidden;
        }
        #collapseOne4 .panel-body {
            overflow: auto;
            /*height: 150px;*/
            width: 103%;
            padding-right: 2%;
        }
          #idCalender {
            position: relative;
            top: -20px !important;
            /* right: -144px !important; */
            float: right;
            margin-right: 23% !important;
        }

	    #txtEntityName {
            margin-bottom:3PX;
	    }
       
        
      
        .form-horizontal{
    width: 100%;
    line-height: 2;
}
        #accordion4 .form-group {
        border-bottom:none;
        }

    
        .container-fluid {
        min-height:0px !important;
        }
        #CboType {
        width:75px;
        }

        #idSearchHistory {
         position: absolute;
        margin-top: 8px;
        margin-left: 4px;
}
        .panel-group {
        margin-bottom:0px !important;
        }
        #page-top {
       
        }
        .setting-src {
        padding:0px !important;
        }
    .selected_user
{
background: #cbddfa;
}
td{
      font-family: Verdana !important;
    font-size: 12px !important;
}
.bottom-bar input{
    height:23px;
    /*padding: 0;*/
    font-size: 11px;
    border-radius: 0;
    padding-left: 10px;
   border:1px solid #bbb;
   border-radius:3px;
 
}
.form-group{

      border-bottom: 1px solid #ebedf2;
}

	    .control-label {
            font-size:12px !important;
	    }
 .form-control {
    /* display: block; */
    /*width: 71% !important;*/
    height: 29px !important;
    padding: 6px 12px;
    font-size: 12px !important;

    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
  #divScroll {
        width:102%;
        padding-right:2%;
        overflow:auto;
      }
  #divEntityGrid .collapseOne2 {
            overflow:hidden!important;
            width:100%!important;
        }

    #divEntityGrid .dataTables_scrollBody .clsTRColumnHeader{
        height:0px!important;
        }
    /*Added By Yasmin on 25th july 2018*/
        #divEntityGrid .dataTables_paginate {
            float:right!important;
                margin-top: 3px;
        }
          #divEntityGrid .dataTables_paginate ul {
             margin-top: 2%!important;
             margin-left: -5%!important;
        }
#divEntityGrid .dataTables_scrollBody {
           overflow: auto!important;
            width: 101.5%!important;
            /*height: 132px!important;*/
            padding-right: 1.8%!important;
}

        #divEntityGrid .dataTables_scroll {
            overflow: hidden!important;
            width: 100%!important;

        }
 #divEntityGrid table tr th {
             border:1px solid #ddd!important;
              
            }
	    #EntityFilter {
            padding-bottom:15px !important;
	    }
	    #cboDepartment {
            height:29px;
	    }
	    #CboRole {
            height:29px;
	    }
	    #CboStatus {
             height:29px;
	    }
	     .editor textarea, input[type="text"] {
            padding-left:18px !important;
	    }

	    #divEntityGrid .fa-sort {
            display:none!important;
	    }

	    #EntityFilter {
            margin-top:-3%;
	    }
         #isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block;
        background-color:white!important;
        color:white;
    }
          #idPlus {
            display:inline-block !important;
        }
           /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }

    </style>


<script>

</script>

  

  </head>
  <body class="" id="page-top">

  <div id='Type' class='tabcontent1 h-type clsSettingstabs'>

  <div class="content-wrapper" style="margin-left: 0px !important;" id="divScroll">
  <div class="container-fluid">
   <div class="request-details-pg clsSettings">
    <div class="v-tabs1"><div id="" class="tabcontent">

       <div class="h-tabs" id="divMain">
             <%WritePage()%>
    </div>
  </div>
</div>
</div>
</div>
      </div>
  </div>       
  
</body>



    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
	<%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../General/CommonFunctions.js"></script>--%>

        <script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>

        <script src="../../../EnhancementFiles/js/editor.js"></script>


    <link href="../../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />
    <script src="../../../EnhancementFiles/OnlineFiles/datepicker/bootstrap-datepicker.js"></script>
   
     


     

<script>

    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    })
    $(document).ready(function () {
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
		    <%End If%>
        RefreshGridDetails();
    });
  

    //Added by Dipali on 16th Dec for Close LogOut Pop_up
    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    });
    //End of Added by Dipali on 16th Dec for Close LogOut Pop_up
     $(function () {
         //$("#idCalender").datepicker();
         $("#dtNextUpdate").datepicker();
         $('#idCalender').click(function () {
             var popup = $(this).offset();
             var popupTop = popup.top - 230;
             $('.ui-datepicker').css({
                 'top': popupTop
             });
         });
     });
	
     $(function () {
         $(document).tooltip({
             position: {
                 my: "center bottom-20",
                 at: "center top",
                 using: function (position, feedback) {
                     $(this).css(position);
                     $(this)
                         .addClass(feedback.vertical);
                 }
             }
         });

     });
     $("[title]").click(function () {
         $('.ui-tooltip').fadeOut('fast', function () {
             $('.ui-tooltip').remove();
         });
     });

</script>
    
<script>
    var strPageName = "EntityUpdateSchedule.aspx"
    function openCity(evt, cityName, strTabURL) {

        $(".btnSettingTab").removeClass("active");
        evt.currentTarget.className += " active";

        setFrameLoader();

        $("#frmSettingsTabs").attr("src", "" + strTabURL + "");

    }
    function WhichBrowser() {

        var brwser = '';
        var ua = navigator.userAgent, tem,
        M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
        if (/trident/i.test(M[1])) {
            tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
            //return 'IE '+(tem[1] || '');
            return 'IE';
        }
        if (M[1] === 'Chrome') {
            tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
            if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
            brwser = 'CR';
        }
        else if (M[1] === 'Firefox') {
            tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
            if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
            brwser = 'FF';
        }
        M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
        if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
        //return M.join(' ');
        return brwser;
    }
    // Get the element with id="defaultOpen" and click on it
    //document.getElementById("defaultOpen").click();
    function AddEntity() {
        RefreshGrid();
        $("#divEntity").css("display", "none");

    }


    function Cancel_Login() {
        // alert(Flag);
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!

        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        var today = mm + '/' + dd + '/' + yyyy;
        //alert(today);

        $("#divEntity").css("display", "block");
        $("#EntityFilter").css("display", "block");
        $("#txtActivity").val();
        EditActivityID = ''
        /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto');
            $("#collapseOne2").addClass('in');
        }
        $('#txtEntityName').val("");
        $('#CboSQLToUpdate').val("");
        $('#CboUpdateSchedule').val("");
        $('#CboStartTime').val("");
        $('#dtUpdatedate').val(today);
    }
    /*End of Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/

    var AjaxResult;
    function AJAXCallWithResult(url, data, async) {
        console.log(url);
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout: 180000,
            async: async,
            success: function (result) {
                AjaxResult = result;
                $(".loadingoverlay", parent.document).css("display", "none");
                //Stop();
            },
            error: function (xhr, status, error) {
                //Stop();
                //StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

        return AjaxResult;
    }

    function RefreshGrid() {
        $('#idCalender').click(function () {
            var popup = $(this).offset();
            var popupTop = popup.top - 230;
            $('.ui-datepicker').css({
                'top': popupTop
            });
        });
        var strResult, data;
        EditActivityID = ''
        //alert(Status)

        //data = JSON.stringify({ GridParameter: GridParameter });
        data = JSON.stringify({})

        strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
        var DivId;
        var DivSerach;
        //  alert(strResult.d);
        if (strResult.d != '') {

            DivId = "divMain";
            DivSerach = "txtSearchHistory";

            $("#divMain").html("");
            $("#divMain").html(strResult.d);

            $(".table-responsive:first table").addClass("table");
        }
        RefreshGridDetails();
    }
    function RefreshGridDetails() {
        //  debugger;

        var strResult, data;
        var GridParameter = {};
        var DivId;
        var DivSerach;

        DivId = "divEntityGrid";
        DivSerach = "txtSearchHistory";

        var TypeDiv; var accordion;
        var intDivGridHeight

        if (WhichBrowser() == "IE") {
            intDivGridHeight = (window.innerHeight / 2);

            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                intDivGridListHeight = parseInt(window.innerHeight) - 500;
               // $('#divEntity').css('height', intDivGridListHeight - 140 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }

            else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {

                intDivGridListHeight = parseInt(window.innerHeight) - 355;
               // $('#divEntity').css('height', intDivGridListHeight - 150 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                intDivGridListHeight = parseInt(window.innerHeight) - 200;
            }
            else {

                intDivGridListHeight = parseInt(window.innerHeight) - 100;

            }
           // $('#divEntity').css('height', intDivGridListHeight - 600 + 'px');
            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
        }
        else {
            intDivGridHeight = (window.innerHeight / 2);

            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
                //alert(1);
                intDivGridListHeight = parseInt(window.innerHeight) - 370;
               // $('#divEntity').css('height', intDivGridListHeight - 140 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
                //alert(2);
                intDivGridListHeight = parseInt(window.innerHeight) - 360;
               // $('#divEntity').css('height', intDivGridListHeight - 140 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                //alert(3);
                intDivGridListHeight = parseInt(window.innerHeight) - 470;
               // $('#divEntity').css('height', intDivGridListHeight - 80 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else {
                //alert(4);
                intDivGridListHeight = parseInt(window.innerHeight) - 570;

                //$('#divEntity').css('height', intDivGridListHeight - 100 + "px");

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }



            //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
        }

        //   $(".table-responsive:first table").addClass("table");
        datatables(DivId, DivSerach, intDivGridListHeight);
        //setWidthDatatable(DivId);

    }
    function datatables(divID, txtBoxID) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({

            responsive: true, "pageLength": 3,
            scrollY: '120px',
            pagingType: "simple_numbers",
            scrollX: true,
            language: {
             
            },
        });
        // debugger;
        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }



    $("#frmSettingsTabs").load(function () {
        RemoveFrameLoader();
    });
   
    var EditEntityID = "";
    function Entity_OnClick(EntityID) {
    
       
        EditEntityID = EntityID;
        var strResult, data;

        data = JSON.stringify({ EntityID: EntityID })
        strResult = AJAXCallWithResult(strPageName + "/PlotEntityDetails", data, false);
        if (strResult.d != '') {
            $("#collapseOne2").html("");
            $("#collapseOne2").html(strResult.d);
        }
        $('#idCalender').click(function ()
        {
            var popup = $(this).offset();
            var popupTop = popup.top - 230;
            $('.ui-datepicker').css({
                'top': popupTop
            });
        });

        $("#divEntity").css("display", "none")
        $("#EntityFilter").css("display", "none")
        $("#collapseOne2").css('height', 'auto');
        $("#collapseOne2").addClass('in');
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto !important');
            $("#collapseOne2").addClass('in');
        }

    }
    function SaveEntity() {

        //debugger;
        if (ValidateAEntity() == 0) {
            var EntitytyID = EditEntityID;
            var strScheduleName;
            var strCboSQLToUpdate;
            var strCboUpdateSchedule;
            var strCboStartTime;
            var strdtUpdatedate;
            var dataSave;

            strScheduleName = $("#txtEntityName").val();
            strCboSQLToUpdate = $("#CboSQLToUpdate").val();
            strCboUpdateSchedule = $("#CboUpdateSchedule").val();
            strCboStartTime = $("#CboStartTime").val();
            strdtUpdatedate = $("#dtUpdatedate").val();
            dataSave = JSON.stringify({ EntitytyID: EntitytyID, Entity: strScheduleName, SQLToUpdate: strCboSQLToUpdate, UpdateSchedule: strCboUpdateSchedule, StartTime: strCboStartTime, UpdateDate: strdtUpdatedate });
            //  alert(data);
            strResult = AJAXCallWithResult(strPageName+"/SaveEntity", dataSave, false);

            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data saved successfully', 'success');
                RefreshGrid();
                EditEntityID = "";
            }
        }

    }
    function ValidateAEntity() {
      
        var chkVal = 0;
        var strMsg = "";
        var objtxtActivity;
        var EntityName = $("#txtEntityName").val();
        var objtxtEntity = GetObjectReference("", "txtEntityName");
        var objtxthdnCurrentDate = GetObjectReference("", "txthdnCurrentDate");
        var objNextUpdate = GetObjectReference("", "dtUpdatedate");
 
        if ($("#txtEntityName").val() == "") {
            strMsg += "<li> Schedule Name should not be left blank. </li><br>";
            chkVal = 1;
        }
        if (disallowSpecialCharacters(objtxtEntity)) {
            strMsg += '<li>  A Schedule Name cannot contain any of these /\\:*?<>|,"+- characters. </li><br>'
            chkVal = 1;
        }
        if (EntityName != "") {
            if (EditEntityID == '') {
                data = JSON.stringify({ EntityName: EntityName });
                strResult = AJAXCallWithResult(strPageName + "/CheckIsDuplicate", data, false);
                if (strResult.d == "1") {
                    strMsg += "<li> Schedule Name already exists. </li><br>";
                    chkVal = 1;
                }
            }
        }
     
        if (disallowMaxlengthViolation(objtxtEntity, 200))
        {
            strMsg += '<li>  Max Length of Schedule Name is 200 characters. </li><br>'
            chkVal = 1;
        }
       

     

        if (disallowBlank(GetObjectReference("", "CboSQLToUpdate")))
        {
            strMsg += '<li>  Stored Procedure should not be left blank. </li><br>'
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "CboUpdateSchedule")))
        {
            strMsg += '<li>  Update Schedule should not be left blank.</li><br>'
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "CboStartTime")))
        {
            strMsg += '<li>  Start Time should not be left blank.</li><br>'
            chkVal = 1;
        }


        if ($("#dtUpdatedate").val()== "")
        {
            strMsg += '<li>  Next Update should not be left blank.</li><br>'
            chkVal = 1;
        }

        //if (disallowDate1GreaterThanDate2(objtxthdnCurrentDate, objNextUpdate) == true)
        if (new Date(objNextUpdate.value).toDateString() < new Date(objtxthdnCurrentDate.value).toDateString())
        {
            strMsg += '<li>Next Update should not be less than current date.</li><br>'
            chkVal = 1;
        }
          


        if (new Date(objNextUpdate.value).toDateString() == new Date(objtxthdnCurrentDate.value).toDateString()) {
           
                  var objCurrentDate = new Date();
                  var objStartTime = GetObjectReference('', 'CboStartTime');
                  var str = objStartTime.value;
                  if (objCurrentDate.getHours() > parseInt(str.substr(0, str.search(":")))) {

                      strMsg += '<li>  Selected Time has already passed.</li><br>'
                      chkVal = 1;
                  }
                  if (objCurrentDate.getHours() == parseInt(str.substr(0, str.search(":")))) {
                      if (objCurrentDate.getMinutes() >= parseInt(str.substr(str.search(":") + 1, str.length))) {
                          strMsg += '<li>  Selected Time has already passed.</li><br>'
                          chkVal = 1;
                      }
                  }
              
          }

        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '-');
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }

        return chkVal;
    }
    function SaveAndAddEntity() {
        if (ValidateAEntity() == 0) {
            var EntitytyID = EditEntityID;
            var strScheduleName;
            var strCboSQLToUpdate;
            var strCboUpdateSchedule;
            var strCboStartTime;
            var strdtUpdatedate;
            var dataSave;

            strScheduleName = $("#txtEntityName").val();
            strCboSQLToUpdate = $("#CboSQLToUpdate").val();
            strCboUpdateSchedule = $("#CboUpdateSchedule").val();
            strCboStartTime = $("#CboStartTime").val();
            strdtUpdatedate = $("#dtUpdatedate").val();
            dataSave = JSON.stringify({ EntitytyID: EntitytyID, Entity: strScheduleName, SQLToUpdate: strCboSQLToUpdate, UpdateSchedule: strCboUpdateSchedule, StartTime: strCboStartTime, UpdateDate: strdtUpdatedate });
            //  alert(data);
            strResult = AJAXCallWithResult(strPageName + "/SaveEntity", dataSave, false);

            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data saved successfully', 'success');
                RefreshGrid();
                //AddActivity();
                AddEntity();
                EditEntityID = "";
            }
        }
     

    }
    function DeleteEntity() {

        var strActivityIDs;
        var strMsg;
        strEntitytyIDs = $('input[name=chkEntityDelete]:checked').map(function () {
            return this.value;
        }).get().join(',');

        if (strEntitytyIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Please select atleast one entity.", 'error');
            return;
        }
        data = JSON.stringify({ EntityID: strEntitytyIDs });

        strMsg = AJAXCallWithResult(strPageName + "/DeleteEntity", data, false);

        if (strMsg.d != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Entity deleted successfully", 'success');
        }

        RefreshGrid();

    }
    function DeleteMultiple_Activity() {
        var table = $('#divEntityGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllActivity').checked == true) {
            // $("input[name=chkEntityDelete]:not(:disabled)").prop('checked', true);
            $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('input[type="checkbox"]', rows).prop('checked', false);
        }
    }
</script>




   
</html>

