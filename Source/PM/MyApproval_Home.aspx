<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyApproval_Home.aspx.vb" Inherits="PbNIT.MyApproval_Home" %>

<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("")%>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="IE=5,8,9,11">
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta charset="UTF-8">
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../responsive/Scripts/Pmlifeline.js" type="text/javascript"></script>
<script src="../../responsive/Scripts/grid.locale-en.js" type="text/javascript"></script>
<script src="../../responsive/Scripts/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="../../responsive/Scripts/pop.js" type="text/javascript"></script>
<script src="../../responsive/Scripts/modernizr.js" type="text/javascript"></script>
<script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../responsive/Scripts/jquery.mmenu.min.all.js" type="text/javascript"></script>
<script src="../XMLHttp/AjaxScript.js"></script>
<script src="../../responsive/Scripts/jquery.weekcalendar.js" type="text/javascript"></script>
<link href="../../responsive/Content/MobileCss.css" rel="stylesheet" />


<script src="../../responsive/GraphScript/jquery.jqplot.js"></script>
<script src="../../responsive/GraphScript/jquery.jqplot.min.js"></script>
<script src="../../responsive/GraphScript/plugins/jqplot.barRenderer.js"></script>
<script src="../../responsive/GraphScript/plugins/jqplot.pieRenderer.js"></script>
<script src="../../responsive/GraphScript/plugins/jqplot.donutRenderer.js"></script>
<script src="../../responsive/GraphScript/WebForms/jqplot.categoryAxisRenderer.js"></script>
<script src="../../responsive/GraphScript/WebForms/jqplot.categoryAxisRenderer.min.js"></script>
<script src="../../responsive/GraphScript/jqplot.pointLabels.js"></script>
<script src="../../responsive/GraphScript/jqplot.pointLabels.min.js"></script>
<link href="../../responsive/GraphScript/jquery.jqplot.css" rel="stylesheet" />

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
        //=====================
        jQuery("#preloader").remove();
        jQuery("#fillDiv").remove();
        ////===========================
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
<style type="text/css">
    table {
        border-collapse: separate;
    }

    .noData {
        position: relative;
        /*top:100px;*/
        text-align: center;
        color: rgb(39, 64, 139);
    }

    .imgAll {
        height: 60%;
        width: 60px;
        /*border: 1px solid black;*/
        margin: 2%;
    }

    .pAll {
        line-height: 10px;
        margin: 0px !important;
    }

    #AllApprovalGraph .jqplot-table-legend {
        margin-top: 34px;
        margin-left: 80%;
    }

    .jqplot-target {
        color: black !important;
    }

    .jqplot-pieRenderer-highlight-canvas {
        top: 10px !important;
    }

    .jqplot-series-canvas {
        top: 10px !important;
    }

    table.jqplot-table-legend, table.jqplot-cursor-legend {
        border: 0px solid black !important;
    }

    jqplot-table-legend {
        border: 0px solid black !important;
    }

    .jqplot-data-label {
        color: black;
    }

    .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
        border: 2px solid #f0d1a1 !important;
    }

    .menu-header {
        background-color: transparent !important;
        font-size: 16px;
        font-weight: bold;
        color: black;
        line-height: 40px;
        display: block !important;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        width: 100%;
        height: 40px;
        padding: 0 50px;
    }

    /*.margin1 {
        width: 500px;
        /*margin-left: 10% !important;*/
    /* }*/

    .content-page {
        margin: 0px 0px 0px 0px !important;
    }

    .content {
        padding: 16px 2% 23px !important;
    }

    .labelHeading {
        position: relative;
        /*top: -60px;*/
        margin-top: 3px;
        /*left: 28px;*/
    }

    /*.MarginDiv {
        margin-left: 45%;
    }*/

    .ui-jqgrid tr.ui-row-ltr td {
        border-right-width: 0px !important;
        border-right-style: none !important;
    }

    #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
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

    .inputResponsive {
        width: 100%;
        padding: 2px;
        margin: 15px 0;
        border: 1px solid #7ac9b7;
    }

    .cslLabel {
        margin-left: 10px;
    }

    .clsParent {
        margin-top: 20px !important;
        /*border:1px solid black;*/
    }

    .flip {
        margin: 0% !important;
    }

    .clsCaption {
        padding-top: 5px;
        cursor: pointer;
    }

    .clsChild {
        margin: 3px !important;
        display: none;
    }

    .ui-jqgrid .ui-pg-table {
        height: 0% !important;
        width: 100% !important;
    }

    #LeavepageNavigation_center {
        width: 75% !important;
    }

    #pageNavigation_center {
        width: 75% !important;
    }

    #ExpensepageNavigation_center {
        width: 75% !important;
    }

    #onResourceTimesheetApprovalpagging_center {
        width: 75% !important;
    }

    #divHelpdeskApproval_center {
        width: 75% !important;
    }

    .ui-datepicker {
        width: 98%;
        padding: .2em .2em 0;
        display: none;
        background-color: white;
    }

    .ui-state-default, .ui-widget-content .ui-state-default {
        font-weight: normal;
        height: 25px;
        overflow: hidden;
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

    .leftHeader {
        text-align: center;
        width: auto;
        margin-left: 0px;
        float: right;
    }

    #header {
        display: block !important;
        height: auto;
    }

    body {
        border: none!important;
        margin-left: 0px!important;
        margin-right: 0px!important;
    }

    div {
        font-size: 12px !important;
    }

    table td {
        font-size: 12px !important;
    }

    overflow {
        width: 1px;
    }

    .clsAccess {
        text-align: center;
        margin-top: 15px;
    }

    .margin {
        height: 30px;
        padding-top: 2px;
    }

    .clsParent {
        width: 99% !important;
    }
    /*.workflow {
        margin-left: 15px;
    }*/
    @media only screen and (min-width:1241px) {
       select {
    background-color: #fff;
    border-color: transparent;
    box-sizing: border-box;
    padding: 0px !important;
    border: 1px solid #bbb;
    border-radius: 3px;
    color: #000;
    margin-bottom: 0px !important;
    margin-top: 4px !important;
    background-image: -webkit-linear-gradient(top,#fff 20%,#f6f6f6 50%,#eee 52%,#f4f4f4 100%);
}
    }
    @media only screen and (min-width:1200px) {
        .workflow {
            width: 99% !important;
        }

        .right-Content {
            width: 99% !important;
        }

        /*.dtSection {
            height: 212px !important;
        }*/
        /*#DivGraphInfo {
            width: 1065px !important;
        }*/

        /*.shadow1 {
            width: 450px !important;
        }*/

        /*#leaveGraph {
            margin-left: 15% !important;
        }*/

        /*#MyProfile {
            width: 500px !important;
            padding-left: 60px !important;
        }

        #MyProfile1 {
            width: 500px !important;
            padding-left: 60px !important;
        }*/
        /*.margin1 {
             margin-left: 34% !important;
        }*/
    }

    @media only screen and (max-width:1200px) and (min-width:1000px) {
        .workflow {
            width: 99% !important;
        }

        .right-Content {
            width: 99% !important;
        }
        /*#DivGraphInfo {
            width: 880px !important;
        }*/

        /*.shadow1 {
            width: 415px !important;
        }*/

        /*#leaveGraph {
            margin-left: 12% !important;
        }*/

        /*#MyProfile {
            width: 408px !important;
            padding-left: 49px !important;
        }

        #MyProfile1 {
            width: 408px !important;
            padding-left: 49px !important;
        }*/
        /*.margin1 {
             margin-left: 10% !important;
        }*/
    }

    @media only screen and (max-width:1000px) {
        .workflow {
            width: 93% !important;
        }

        .right-Content {
            width: 87% !important;
        }

        .dtSection {
            height: 167px !important;
        }
        /*#DivGraphInfo {
            width: 768px !important;
        }*/

        /*.shadow1 {
            width: 331px !important;
        }*/

        /*#leaveGraph {
            margin-left: 8% !important;
        }*/

        /*#MyProfile {
            width: 350px !important;
            padding-left: 35px !important;
        }

        #MyProfile1 {
            width: 350px !important;
            padding-left: 35px !important;
        }*/
        /*.margin1 {
             margin-left: 0% !important;
        }*/
    }

    .divTitle {
        width: 92%;
        height: 92%;
        background: white !important;
        color: black !important;
        /*border: 1px solid #e39321!important; // Commented And Added By Vaijat K ON 21/09/2016 For Dynamic Theme*/ 
        border: 1px solid #e39321;
    }

    /* Width of button is given in pixel.It will not effect any other element of the form*/
    .MenuContent {
        height: 100%;
    }
     #divRoleAccessDisplay
    {
            display:none;
    }

    
</style>

<script type="text/javascript">
    // Added By Vaijat K ON 21/09/2016 For Dynamic Theme
    var link = document.createElement("link");
    link.href = "../General/<%=CommonFunctions.Data.GetDataScalar("usp_get_StyleSheet " & Session("intUserID") & ",N'" & Session("LoginType") & "',0", True)%>";
    link.rel = "stylesheet";
    document.head.appendChild(link);
    //End Added By Vaijat K ON 21/09/2016 For Dynamic Theme
    $(function () {
        $('nav#menu').mmenu();
        $("#mm-0").before("<div style='width:100%;height:100%;background:#F1DCDC'></div>");
    });
    function logout() {

        window.location = '<%= ResolveUrl("../../default.aspx") %>';
    }
    var intPosition;
    var path = '<%=ConfigurationManager.AppSettings("WCFTimesheetMServicePath").ToString()%>';
    var para;
    var ExpenseApprovalpass;
    var LeaveApprovalpass;
    var subgrid_table_id;
    var id;
    var glovalStatus;
    var empparaval = { intEmployeeID: '<%=Session("intUserID").ToString%>', strFilter: 'Employee' };
    var getperiodpass = { intEmployeeID: '<%=Session("intUserID").ToString%>' };
    var ProjectApprovalpass;
    var HelpdeskParameter;
    var expenseParameter;
    var TimesheetParameter;
    var SubProjectApprovalpass;
    var MilestoneIdApprovalpass;
    var ModuleApprovalpass;
    var DeliverableApprovalpass;
    var ChangeRequestApprovalpass;
    var GridName;
    var countgrid = 0;
    var objLeave;
    var objExpense;
    var objentity;
    var objHelpdesk;
    var objTimesheet;
    var objOverall;
    var objAgeing;
    var objEntitySelection = 0;
    //Added by Dhanashri S on 7 June 2016
    var objLeaveRoleAccess;
    var objExpenseRoleAccess;
    var objTimesheetRoleAccess;
    var objEntityRoleAccess;
    var objHelpdeskRoleAccess;
    var objResourceTimesheetAccess;
    var objProjectTimesheetAccess;
    var jsonData1=0;
    //End of Addition by Dhanashri S on 7 June 2016
    function GetLeaveExtraDetails() {

        $.ajax({
            url: path + "GetListLeaveDetailsExtraForDropDown",
            data: LeaveApprovalpass,  // For empty input data use "{}",
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                var thegrid = jQuery("#" + subgrid_table_id)[0];
                thegrid.addJSONData(JSON.parse(result));
            }

        });
    }
    //Added By Vaijat K ON 29/01/2016 For Adding Data To Dropdown For Timesheet Selection
    function GetTimesheetEntities() {
        document.getElementById("ddlTimesheet").innerHTML = "<option value='1' Selected>Resource</option><option value='2'>Project</option>";
    }
    //End Of Addition by Vaijat k

    function EntityWorkflowApproval() {

        $("#EntityWorkflowApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetPendingProjectEntities",
            //COMMENTED AND ADDED BY Vaijat K  ON 22/3/2016 FOR GENERATE PK TOKEN
            // data: { intUserID: '<%=Session("intUserID")%>', },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //ended
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                try {

                    $("#EntityWorkflowApprovalGridview").GridUnload();
                    var JSONdata = JSON.parse(result);
                    if (JSONdata.length > 0) {
                        $("#divnoDataToPreview").css("display", "none");
                        $("#divnoDataToPreview").parent().css("box-shadow", "none")
                    }
                    else {
                        $("#divnoDataToPreview").css("display", "block");
                        $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                    }
                    jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                        datatype: "local",
                        data: JSON.parse(result),
                        colNames: ['ID', 'Project Name', 'Start Date', 'End Date', 'Work', 'Created By'],
                        colModel: [
                        { name: 'ID', index: 'ID', align: 'center', hidden: true },
                        { name: 'Project_Name', index: 'Project_Name', align: 'center', width: 40 },
                        { name: 'Start_Date', index: 'start_Date', align: 'center', width: 40 },
                        { name: 'End_Date', index: 'End_Date', align: 'center', width: 40 },
                        { name: 'Work', index: 'Work', align: 'center', width: 40 },
                        { name: 'Created_By', index: 'Created_By', align: 'center', width: 40 }],
                        rowNum: 05,
                        autoencode: true,
                        rowList: [5, 10, 20, 50, 100],
                        sortname: 'Project_Name',
                        pager: jQuery('#pageNavigation'),
                        sortorder: "asc",
                        loadonce: true,
                        viewrecords: true,
                        multiselect: true,
                        loadComplete: function () {
                            $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                            $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                        },
                        //caption:"Entity WorkFlow Approval"
                        onSelectRow: function (rowId, col, content, e) {
                            var myGrid = $('#EntityWorkflowApprovalGridview'),
                            selRowId = myGrid.jqGrid('getGridParam', 'selrow'),

                            intEmployeeID = '<%=Session("intUserID").ToString%>'
                            ProjId = myGrid.jqGrid('getCell', selRowId, 'ID');
                            //leaveid = myGrid.jqGrid('getCell', selRowId, 'LeaveID');
                            //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');

                            if (ProjId) {
                                ProjectApprovalpass = { LoginID: intEmployeeID, ProjectID: ProjId };
                                ShowProjectApprovalDetails();
                            }
                            else {
                                ProjectApprovalpass = {};
                                document.getElementById("MyProfile1").style.display = "none";
                                var windowWidth = $(window).width();
                                //if (windowWidth > 720) {
                                //    //document.getElementById("divEntityWorkFlowApprovalParent").style.height = "325px";
                                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                                //}
                                //else {
                                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                                //}
                            }
                        },
                        gridComplete: function () {
                            $("#EntityWorkflowApprovalGridview").setSelection('1');
                            $("#cb_EntityWorkflowApprovalGridview").click(function () {
                                var myGrid = $('#EntityWorkflowApprovalGridview')
                                var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                                if (selRowId.length > 1) {
                                    $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                                }
                                else if (selRowId.length == 0) {
                                    $("#MyProfile1").css("display", "none");
                                }
                                else {
                                    $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                                }
                            });
                        }
                    });
                }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            }
        });

    }
    function LeaveApprovalTest() {
        jQuery("#LeaveApprovalGridview").GridUnload();
        var val;
        $.ajax({
            url: path + "GetLeaveDetails",
            data: para,  // For empty input data use "{}",
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try {
                    jQuery("#LeaveApprovalGridview").GridUnload();
                    var JSONdata = JSON.parse(result);
                    if (JSONdata.length > 0) {
                        $("#divnoDataToPreview").css("display", "none");
                        $("#divnoDataToPreview").parent().css("box-shadow", "none")
                    }
                    else {
                        $("#divnoDataToPreview").css("display", "block");
                        $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                    }
                    jQuery("#LeaveApprovalGridview").jqGrid({
                        datatype: "local",
                        data: JSON.parse(result),
                        colNames: ['LeaveID', 'EmployeeID', 'Resource Name', 'LeaveType', 'FromDate', 'ToDate', 'first half', 'second half', 'Email'],
                        colModel: [
                        //{ name: 'enbl', index: 'enbl', width: 20, align: 'center', formatter: 'checkbox', editoptions: { value: '1:0' }, formatoptions: { disabled: false }, },              
                        { name: 'LeaveID', index: 'LeaveID', align: 'center', hidden: true },
                        { name: 'EmployeeID', index: 'EmployeeID', align: 'center', hidden: true },
                        { name: 'EmployeeName', index: 'EmployeeName', align: 'center' },
                        { name: 'LeaveType', index: 'LeaveType', align: 'center' },
                        { name: 'FromDate', index: 'FromDate', align: 'center' },
                        { name: 'ToDate', index: 'ToDate', align: 'center' },
                        { name: 'FirstHalfDay', index: 'FirstHalfDay', align: 'center', hidden: true },
                        { name: 'SecondHalfDay', index: 'SecondHalfDay', align: 'center', hidden: true },
                        { name: 'EmailID', index: 'EmailID', align: 'center', hidden: true }],
                        rowNum: 10,
                        autoencode: true,
                        rowList: [5, 10, 20, 50, 100],
                        //autowidth: true,
                        multiselect: true,
                        loadonce: true,
                        rowList: [5, 10, 20, 50, 100],
                        // sortname: 'IssueID',
                        pager: jQuery('#LeavepageNavigation'),
                        sortorder: "asc",
                        viewrecords: true,
                        //caption: "Leave Approval",
                        loadComplete: function () {
                            $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                            $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                        },
                        onSelectRow: function (rowId, col, content, e) {
                            var myGrid = $('#LeaveApprovalGridview'),
                            selRowId = myGrid.jqGrid('getGridParam', 'selrow'),
                            empid = myGrid.jqGrid('getCell', selRowId, 'EmployeeID');
                            leaveid = myGrid.jqGrid('getCell', selRowId, 'LeaveID');
                            //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');
                            if (empid) {
                                //Commented And Added By Vaijat K ON 22/03/2016 For WCF Security
                                //LeaveApprovalpass = { LoginID: empid, LeaveID: leaveid };
                                //ShowApprovalDetails();
                                $.ajax({
                                    type: 'POST',
                                    dataType: 'json',
                                    contentType: 'application/json',
                                    url: 'MyApproval_Home.aspx/SetWork',
                                    data: JSON.stringify({ LoginID: empid, LeaveID: leaveid }),
                                    async: false,
                                    success: function (Result) {
                                        LeaveApprovalpass = { LoginID: empid, LeaveID: leaveid, pToken: Result.d };
                                        ShowApprovalDetails();
                                    },
                                    error: function () {
                                        alert("Error")
                                    }
                                });
                                //var Intervaltimer = setInterval(function () {
                                //    if (LeaveApprovalpass != undefined) {

                                //        clearInterval(Intervaltimer);
                                //    }
                                //}, 200)
                                //Ended
                                //document.getElementById("tblAllApprovalGraph").style.display = "none";
                                //$(".margin1").css("margin-top", "0%");
                            }
                            else {
                                LeaveApprovalpass = {};
                                document.getElementById("MyProfile").style.display = "none";
                                var windowWidth = $(window).width();
                                //if (windowWidth > 720) {
                                //    //document.getElementById("divLeaveApprovalParent").style.height = "325px";
                                //    document.getElementById("divLeaveApprovalParent").style.height = "auto";
                                //}
                                //else {
                                //    document.getElementById("divLeaveApprovalParent").style.height = "auto";
                                //}
                                //document.getElementById("tblAllApprovalGraph").style.display = "";
                                //$(".margin1").css("margin-top", "-4%");
                            }
                        },

                        subGrid: false,
                        subGridOptions: {
                            "plusicon": "ui-icon-triangle-1-e",
                            "minusicon": "ui-icon-triangle-1-s",
                            "openicon": "ui-icon-arrowreturn-1-e",
                            // load the subgrid data only once
                            // and the just show/hide
                            "reloadOnExpand": false,
                            // select the row when the expand column is clicked
                            "selectOnExpand": true
                        },
                        subGridRowExpanded: function (subgrid_id, row_id) {

                            subgrid_table_id = subgrid_id + "_t";
                            var myGrid = $('#LeaveApprovalGridview');
                            leaveid = myGrid.jqGrid('getCell', row_id, 'LeaveID');
                            leavetype = myGrid.jqGrid('getCell', row_id, 'LeaveType');

                            LeaveApprovalpass = { LeaveID: leaveid, LeaveType: leavetype };

                            jQuery("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table>");

                            jQuery("#" + subgrid_table_id).jqGrid({
                                datatype: GetLeaveExtraDetails,
                                colNames: ['Leave Taken', 'Leave Balance', 'Reason'],
                                colModel: [
                                { name: 'Leaves_Taken', index: 'Leaves_Taken', align: 'center' },
                                { name: 'Leave_Balance', index: 'Leave_Balance', align: 'center' },
                                { name: 'Reason', index: 'Reason', align: 'center' }, ],
                                rowNum: 05,
                                rowList: [5, 10, 20, 50, 100],
                                height: 30

                            });
                        },
                        gridComplete: function () {
                            $("#LeaveApprovalGridview").setSelection('1');
                            $("#cb_LeaveApprovalGridview").click(function () {
                                var myGrid = $('#LeaveApprovalGridview')
                                var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                                if (selRowId.length > 1) {
                                    $("#MyProfile").find(".margin").find(".btn").css("visibility", "hidden");
                                }
                                else if (selRowId.length == 0) {
                                    $("#MyProfile").css("display", "none");
                                }
                                else {
                                    $("#MyProfile").find(".margin").find(".btn").css("visibility", "");
                                }
                            });


                            //Added By Dipali V On 7th April 2020 For select All issues for Leave Section
                    $('#LeaveApprovalGridview td .cbox').change(function () {
                        if ($('#LeaveApprovalGridview td .cbox:checked').length == $('#LeaveApprovalGridview td .cbox').length) {
                            $('#cb_LeaveApprovalGridview').prop('checked', true);
                        }
                        else {
                            $('#cb_LeaveApprovalGridview').prop('checked', false);
                        }
                    });
                    //End of Added By Dipali V On 7th April 2020 For select All issues for Leave Section

                        }
                    });
                    

                }
                catch (exception) {
                    document.getElementById("divLeaveApprovalChild").style.display = "none";
                    document.getElementById("divLeaveApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                document.getElementById("divLeaveApprovalChild").style.display = "none";
                document.getElementById("divLeaveApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            }
        });
    }


      

    //To Display Data in Expense Approval Grid
    function ExpenseApproval() {
        jQuery("#ExpenseApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetExpenseApprovals",
            data: para,  // For empty input data use "{}",
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try {
                    jQuery("#ExpenseApprovalGridview").GridUnload();
                    var JSONdata = JSON.parse(result);
                    if (JSONdata.length > 0) {
                        $("#divnoDataToPreview").css("display", "none");
                        $("#divnoDataToPreview").parent().css("box-shadow", "none")
                    }
                    else {
                        $("#divnoDataToPreview").css("display", "block");
                        $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                    }
                    jQuery("#ExpenseApprovalGridview").jqGrid({
                        datatype: "local",
                        data: JSON.parse(result),
                        colNames: ['ExpenseSheetID', 'ExpensesEntryID', 'EmployeeID', 'Resource Name', 'Project Name', 'Description', 'Expense Title', 'Total Amount', 'isExpense'],
                        colModel: [
                        { name: 'ExpenseSheetID', index: '  ExpenseSheetID', align: 'center', hidden: true },
                        { name: 'ExpensesEntryID', index: 'ExpensesEntryID', align: 'center', hidden: true },
                        { name: 'EmployeeID', index: 'EmployeeID', align: 'center', hidden: true },
                        { name: 'EmployeeName', index: 'EmployeeName', align: 'center', width: 40 },
                        { name: 'ProjectName', index: 'ProjectName', align: 'center', width: 40 },
                        { name: 'Description', index: 'Description', align: 'center', width: 40 },
                        { name: 'Title', index: 'Title', align: 'center', width: 40 },
                        { name: 'Amount', index: 'Amount', align: 'center', width: 40 },
                        { name: 'isExpense', index: 'isExpense', align: 'center', hidden: true }],
                        rowNum: 05,
                        autoencode: true,
                        rowList: [5, 10, 20, 50, 100],
                        sortname: 'EmployeeID',
                        pager: jQuery('#ExpensepageNavigation'),
                        sortorder: "asc",
                        viewrecords: true,
                        multiselect: true,
                        loadComplete: function () {
                            $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                            $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                        },
                        onSelectRow: function (rowId, col, content, e) {
                            var myGrid = $('#ExpenseApprovalGridview'),
                            selRowId = myGrid.jqGrid('getGridParam', 'selrow'),
                            ExpID = myGrid.jqGrid('getCell', selRowId, 'ExpensesEntryID')
                            //Projectnm = myGrid.jqGrid('getCell', selRowId, 'ProjectName'),
                            //titalval = myGrid.jqGrid('getCell', selRowId, 'Title'),
                            //amt = myGrid.jqGrid('getCell', selRowId, 'Amount');
                            if (ExpID) {
                                ExpenseApprovalpass = { intUserID: '<%=Session("intUserID").ToString%>', ExpenseEntryID: ExpID };
                        ShowexpenseApprovalDetails();
                    }
                    else {
                        ExpenseApprovalpass = {};
                        document.getElementById("MyProfileExpense").style.display = "none"
                    }
                        // ExpenseApprovalDetails();
                    },
                    gridComplete: function () {
                        $("#ExpenseApprovalGridview").setSelection('1');
                        $("#cb_ExpenseApprovalGridview").click(function () {
                            var myGrid = $('#ExpenseApprovalGridview')
                            var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                            if (selRowId.length > 1) {
                                $("#MyProfileExpense").find(".margin").find(".btn").css("visibility", "hidden");
                            }
                            else if (selRowId.length == 0) {
                                $("#MyProfileExpense").css("display", "none");
                            }
                            else {
                                $("#MyProfileExpense").find(".margin").find(".btn").css("visibility", "");
                            }
                        });
                         //Added By Dipali V On 7th April 2020 For select All issues for Expense Section
                    $('#ExpenseApprovalGridview td .cbox').change(function () {
                        if ($('#ExpenseApprovalGridview td .cbox:checked').length == $('#ExpenseApprovalGridview td .cbox').length) {
                            $('#cb_ExpenseApprovalGridview').prop('checked', true);
                        }
                        else {
                            $('#cb_ExpenseApprovalGridview').prop('checked', false);
                        }
                    });
                    //End of Added By Dipali V On 7th April 2020 For select All issues for Expense Section






                    }
                    //caption:"Expense Approval",

                });
        }
                catch (exception) {
                    //Commented And Added By Usha Pandit On 02.07.2019 For Javascript Error - Function Expected
                    //document.getElementById("divExpenseApprovalChild").style.display("none");
                    document.getElementById("divExpenseApprovalChild").style.display = "none";
                    //End OF Added By Usha Pandit On 02.07.2019 For Javascript Error - Function Expected
                    document.getElementById("divExpenseApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later..."
                }
            },
            error: function (xhr) {  
                //Commented And Added By Usha Pandit On 02.07.2019 For Javascript Error - Function Expected
                //document.getElementById("divExpenseApprovalChild").style.display("none");
                document.getElementById("divExpenseApprovalChild").style.display = "none";
                //End OF Added By Usha Pandit On 02.07.2019 For Javascript Error - Function Expected
                document.getElementById("divExpenseApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later..."
            }
        });

}
    function GetResourceTimesheetApproval() {
    jQuery("#ResourceTimesheetApprovalgrid").GridUnload();
    $.ajax({
        url: path + "GetPendingTimesheetPendingRequest",
        //COMMENTED AND ADDED BY Vaijat K  ON 22/3/2016 FOR GENERATE PK TOKEN
        //  data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
        data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
        //ended
        dataType: "jsonp",
        type: "GET",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            try {
                jQuery("#ResourceTimesheetApprovalgrid").GridUnload();
                var JSONdata = JSON.parse(result);
                if (JSONdata.length > 0) {
                    $("#divnoDataToPreview").css("display", "none");
                    $("#divnoDataToPreview").parent().css("box-shadow", "none")
                }
                else {
                    $("#divnoDataToPreview").css("display", "block");
                    $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                }
                jQuery("#ResourceTimesheetApprovalgrid").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['EmployeeID', 'TimeSheetID', 'Resource Name', 'Status Description', 'FromDate', 'ToDate', 'Actual Work'],
                    colModel: [
                    { name: 'EmployeeID', align: 'center', index: 'EmployeeID', hidden: true },
                    { name: 'TimeSheetID', align: 'center', index: 'TimeSheetID', hidden: true },
                    { name: 'EmployeeName', index: 'EmployeeName', align: 'center', width: 40 },
                    { name: 'StatusDescription', index: 'StatusDescription', align: 'center', width: 40 },
                    { name: 'FromDate', index: 'FromDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" }, width: 40 },
                    { name: 'ToDate', index: 'ToDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" }, width: 40 },
                    { name: 'Actual_Work', index: 'Actual_Work', align: 'center', width: 40 }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    sortname: 'TimeSheetID',
                    pager: jQuery('#onResourceTimesheetApprovalpagging'),
                    sortorder: "asc",
                    viewrecords: true,
                    multiselect: true,
                    loadComplete: function () {
                        $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                    },
                    onSelectRow: function (rowId, col, content, e) {
                        var myGrid = $('#ResourceTimesheetApprovalgrid'),
                        selRowId = myGrid.jqGrid('getGridParam', 'selrow'),
                        TSID = myGrid.jqGrid('getCell', selRowId, 'TimeSheetID')
                        if (TSID) {
                            ExpenseApprovalpass = { intUserID: '<%=Session("intUserID").ToString%>', TimesheetNo: TSID, isProject: 1 };
                    ShowTimesheetApprovalDetails();
                }
                else {
                    ExpenseApprovalpass = {};
                    document.getElementById("MyProfileTimesheet").style.display = "none"
                }
                    // ExpenseApprovalDetails();
                },
                gridComplete: function () {
                    $("#ResourceTimesheetApprovalgrid").setSelection('1');
                    $("#cb_ResourceTimesheetApprovalgrid").click(function () {
                        var myGrid = $('#ResourceTimesheetApprovalgrid')
                        var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                        if (selRowId.length > 1) {
                            $("#MyProfileTimesheet").find(".margin").find(".btn").css("visibility", "hidden");
                        }
                        else if (selRowId.length == 0) {
                            $("#MyProfileTimesheet").css("display", "none");
                        }
                        else {
                            $("#MyProfileTimesheet").find(".margin").find(".btn").css("visibility", "");
                        }
                    });

                     //Added By Dipali V On 7th April 2020 For select All issues for Timesheet Section
                    $('#ResourceTimesheetApprovalgrid td .cbox').change(function () {
                        if ($('#ResourceTimesheetApprovalgrid td .cbox:checked').length == $('#ResourceTimesheetApprovalgrid td .cbox').length) {
                            $('#cb_ResourceTimesheetApprovalgrid').prop('checked', true);
                        }
                        else {
                            $('#cb_ResourceTimesheetApprovalgrid').prop('checked', false);
                        }
                    });
                    //End of Added By Dipali V On 7th April 2020 For select All issues for Timesheet Section



                }
                //caption:"Timesheet Approval",

            });
    }
            catch (exception) {
                $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                $("#ResourceTimesheetApprovalgrid").GridUnload();
            }
        },
        error: function (xhr) {
            $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
            document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            $("#ResourceTimesheetApprovalgrid").GridUnload();
        }
    });

}
function ShowApprovalDetails() {
    try {
        $.ajax({
            type: "GET", //GET or POST or PUT or DELETE verb
            url: path + "GetListLeaveDetails", // Location of the service
            data: LeaveApprovalpass,
            contentType: "application/json;charset=utf-8", // content type sent to server
            dataType: "jsonp", //Expected data format from server
            async: false,
            success: function (data) {//On Successfull service call  
                //set empty table data 
                $("#dinamictbl").empty();
                var myGrid = $('#LeaveApprovalGridview'),
                selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                if (selRowId.length > 1) {
                    $("#MyProfile").find(".margin").find(".btn").css("visibility", "hidden");
                }
                else {
                    $("#MyProfile").find(".margin").find(".btn").css("visibility", "");
                }
                $.each(JSON.parse(data), function (id, obj) {
                    //cerate dynamic table with data
                    //Commented and Added By Aniruddh Gujar on 07-Oct-2016 Purpose::To show halfDay/Full Day
                    //$("#dinamictbl").append("<tr><td class='innermarg'>Employee Name</td><td class='innermarg'>" + obj.EmployeeName + "</td></tr><tr><td class='innermarg'>Leave Type</td><td class='innermarg'>" + obj.LeaveType + "</td></tr><tr><td class='innermarg'>From Date</td><td class='innermarg'>" + obj.FromDate + "</td></tr><tr><td class='innermarg'>To Date</td><td class='innermarg'>" + obj.ToDate + "</td></tr><tr><td class='innermarg'>Address</td><td class='innermarg'>" + obj.Address + "</td></tr><tr><td class='innermarg'>Phone Number</td><td class='innermarg'>" + obj.Phone_Number + "</td></tr><tr><td>Reason</td><td class='innermarg'>" + obj.Reason + "</td></tr>");
                    $("#dinamictbl").append("<tr><td class='innermarg'>Employee Name</td><td class='innermarg'>" + obj.EmployeeName + "</td></tr><tr><td class='innermarg'>Leave Type</td><td class='innermarg'>" + obj.LeaveType + "</td></tr><tr><td class='innermarg'>From Date</td><td class='innermarg'>" + obj.FromDate + "</td></tr><tr><td class='innermarg'>To Date</td><td class='innermarg'>" + obj.ToDate + "</td></tr><tr><td class='innermarg'>Address</td><td class='innermarg'>" + obj.Address + "</td></tr><tr><td class='innermarg'>Phone Number</td><td class='innermarg'>" + obj.Phone_Number + "</td></tr><tr><td>Reason</td><td class='innermarg'>" + obj.Reason + "</td></tr><tr><td>Half Day/Full Day</td><td class='innermarg'>" + obj.HalfDay + "</td></tr>");
                    //End of Commented and Added By Aniruddh Gujar on 07-Oct-2016 Purpose::To show halfDay/Full Day
                    return false;
                });
                document.getElementById("MyProfile").style.display = "block";
                var windowWidth = $(window).width();
                if (windowWidth < 721) {
                    document.getElementById("divLeaveApprovalParent").style.height = "100%";
                }
                else {
                    document.getElementById("divLeaveApprovalParent").style.height = "auto";
                }
            }
        });
    } catch (exception) { }
}

function GetworkFlowEntity() {

    try {
        $.ajax({
            type: "GET", //GET or POST or PUT or DELETE verb
            url: path + "GetIMAttributesWFApprovals", // Location of the service
            data: '{}',
            contentType: "application/json;charset=utf-8", // content type sent to server
            dataType: "jsonp", //Expected data format from server
            success: function (data) {//On Successfull service call  
                var Project = eval(data.d);

                $.each(JSON.parse(data), function (id, obj) {
                    //create droupdown for workflow approval
                    if (obj.AttributeID == 32) {
                        $("#dropdownval").append("<option value=" + obj.AttributeID + " selected=" + obj.Attribute + ">" + obj.Attribute + "</option>");
                    }
                    else {
                        $("#dropdownval").append("<option value=" + obj.AttributeID + ">" + obj.Attribute + "</option>");
                    }
                });

            }
        });
    } catch (exception) { }
    if (document.getElementById("pg_pageNavigation") != null) {
        document.getElementById("pg_pageNavigation").firstChild.setAttribute("style", "width:100% !important");
        document.getElementById("pageNavigation_center").firstChild.setAttribute("style", "width:100% !important");
        document.getElementById("pageNavigation_center").removeAttribute("style");
    }

}

Date.prototype.toDateInputValue = (function () {
    var local = new Date(this);
    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
    return local.toJSON().slice(0, 10);

});
var arr = [];
jQuery(document).ready(function () {
    DrawRoleAccessAllApprovalGraph();
    //Added By Vidya J ON 7 July 2016 For Pending Count
    GetAllCount1();
    var Sum = jsonData1;
    document.getElementById("spanOverAll").innerHTML = "(" + Sum + ")";
    //End Of Added By Vidya J ON 7 July 2016 For Pending Count
    //$("HTML").append("<div id='preloader'></div>");
    //$("HTML").append("<div id='fillDiv'></div>");
    //  $("#detailsectionhide").hide();
    //Added by swapnil aswale on 14-12-2015 for Mulitple Login
    $("a").click(function () {
        $.ajax({
            url: "../Home/MultipleLogin.aspx", success: function (result) {

            }
        });
    });
    $(document).click(function () {
        $.ajax({
            url: "../Home/MultipleLogin.aspx", success: function (result) {

            }
        });
    });
    //Ended
    $('#lbl_user').text('<%=Session("strUserName")%>' + "(" + '<%=Session("RoleDesc")%>' + ")");

    $('#applieddate').val(new Date().toDateInputValue());
    var globalstatus;
    //commented and added by Vaijat K on 18/3/2016 for generate token
    //para = { LoginID: '<%=Session("intUserID")%>'}
    para = { LoginID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' };
    //ended
    jQuery("#approval").removeClass("box");
    jQuery("#approval").addClass("box active");
    jQuery("#HMyApproval").addClass("current");
    $("#tblEntityGraph").css("display", "none");
    $("#tblExpenseGraph").css("display", "none");
    $("#tblTimesheetGraph").css("display", "none");
    document.getElementById("MyProfile").style.display = "none";
    document.getElementById("tblAllApprovalGraph").style.display = "block";
    document.getElementById("tblshow").style.display = "none";
    $(document).removeAttr("height");
    GetTimesheetEntities();
    GetworkFlowEntity();
    ScreenResolutionForAll();
    GraphClick();
    //GetExpenseEntities()
    $("#divOverAll").css("box-shadow", "1px 1px 1px 1px #CCC");

});
var modeForAge = 0;
function GraphClick() {
    $('#AllApprovalGraph').bind('jqplotDataClick',
              function (ev, seriesIndex, pointIndex, data) {

                  // $('#info1').html('series: ' + seriesIndex + ', point: ' + pointIndex + ', data: ' + data);
                  //$("#tblleaveGraph1").css("display", "none");
                  //$("#tblEntityGraph").css("display", "none");
                  //$("#tblExpenseGraph").css("display", "none");
                  //$("#tblTimesheetGraph").css("display", "none");

                  var mode = String(data);

                  mode = mode.split(",")
                  if (mode[0] == 1) {
                      // $("#tblleaveGraph").css("display", "block");
                      //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                      //DrawPieChartForLeaveApprovalAction();
                      if (arr[0] == 'Leave') {
                          DrawPieChartForLeaveApprovalAction();
                          modeForAge = 1;
                          DrawApprovalAgeingGraph('Leave');
                      }
                      else if (arr[0] == 'Expense') {
                          DrawPieChartForExpenseApprovalAction();
                          modeForAge = 2;
                          DrawApprovalAgeingGraph('Expense');
                      }
                      else if (arr[0] == 'Timesheet') {
                          DrawPieChartForTimesheetApprovalAction();
                          modeForAge = 3;
                          DrawApprovalAgeingGraph('Timesheet');
                      }
                      else if (arr[0] == 'Entity') {
                          DrawPieChartForEntityApprovalAction();
                          DrawApprovalAgeingGraph('Entity');
                          modeForAge = 4;
                      }
                      else if (arr[0] == 'HelpDesk') {
                          DrawPieChartForHelpDeskApprovalAction();
                          modeForAge = 5
                          DrawApprovalAgeingGraph('HelpDesk');
                      }

                      //document.getElementById("DivApprovalAgeing").style.marginLeft = "30%"
                      //document.getElementById("P1").style.marginLeft = "32%"
                      // document.getElementById("GraphHeaderLeave").style.left = intPosition + "px";
                  }
                  if (mode[0] == 2) {
                      // $("#tblExpenseGraph").css("display", "block");
                      //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                      ////DrawPieChartForExpenseApprovalAction();
                      //DrawPieChartForExpenseApprovalAction();
                      //modeForAge = 2;
                      //// document.getElementById("GraphHeaderExpense").style.left = intPosition + "px";
                      ////document.getElementById("DivApprovalAgeing").style.marginLeft = "30%"
                      ////document.getElementById("P1").style.marginLeft = "32%"
                      //DrawApprovalAgeingGraph('Expense');
                      if (arr[1] == 'Leave') {
                          DrawPieChartForLeaveApprovalAction();
                          modeForAge = 1;
                          DrawApprovalAgeingGraph('Leave');
                      }
                      else if (arr[1] == 'Expense') {
                          DrawPieChartForExpenseApprovalAction();
                          modeForAge = 2;
                          DrawApprovalAgeingGraph('Expense');
                      }
                      else if (arr[1] == 'Timesheet') {
                          DrawPieChartForTimesheetApprovalAction();
                          modeForAge = 3;
                          DrawApprovalAgeingGraph('Timesheet');
                      }
                      else if (arr[1] == 'Entity') {
                          DrawPieChartForEntityApprovalAction();
                          DrawApprovalAgeingGraph('Entity');
                          modeForAge = 4;
                      }
                      else if (arr[1] == 'HelpDesk') {
                          DrawPieChartForHelpDeskApprovalAction();
                          modeForAge = 5
                          DrawApprovalAgeingGraph('HelpDesk');
                      }
                  }
                  if (mode[0] == 3) {
                      // $("#tblTimesheetGraph").css("display", "block");
                      //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                      //DrawPieChartForTimesheetApprovalAction();
                      //DrawPieChartForTimesheetApprovalAction();
                      //modeForAge = 3;
                      ////document.getElementById("GraphHeaderTimesheet").style.left = intPosition + "px";
                      ////document.getElementById("DivApprovalAgeing").style.marginLeft = "20%"
                      ////document.getElementById("P1").style.marginLeft = "22%"
                      //DrawApprovalAgeingGraph('Timesheet');
                      if (arr[2] == 'Leave') {
                          DrawPieChartForLeaveApprovalAction();
                          modeForAge = 1;
                          DrawApprovalAgeingGraph('Leave');
                      }
                      else if (arr[2] == 'Expense') {
                          DrawPieChartForExpenseApprovalAction();
                          modeForAge = 2;
                          DrawApprovalAgeingGraph('Expense');
                      }
                      else if (arr[2] == 'Timesheet') {
                          DrawPieChartForTimesheetApprovalAction();
                          modeForAge = 3;
                          DrawApprovalAgeingGraph('Timesheet');
                      }
                      else if (arr[2] == 'Entity') {
                          DrawPieChartForEntityApprovalAction();
                          DrawApprovalAgeingGraph('Entity');
                          modeForAge = 4;
                      }
                      else if (arr[2] == 'HelpDesk') {
                          DrawPieChartForHelpDeskApprovalAction();
                          modeForAge = 5
                          DrawApprovalAgeingGraph('HelpDesk');
                      }

                  }
                  if (mode[0] == 4) {
                      //$("#tblEntityGraph").css("display", "block");
                      //document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                      //DrawPieChartForEntityApprovalAction();
                      //DrawPieChartForEntityApprovalAction();
                      //// document.getElementById("GraphHeaderEntity").style.left = intPosition + "px";
                      ////document.getElementById("DivApprovalAgeing").style.marginLeft = "10px"
                      ////document.getElementById("P1").style.marginLeft = "26px"
                      //DrawApprovalAgeingGraph('Entity');
                      //modeForAge = 4;
                      if (arr[3] == 'Leave') {
                          DrawPieChartForLeaveApprovalAction();
                          modeForAge = 1;
                          DrawApprovalAgeingGraph('Leave');
                      }
                      else if (arr[3] == 'Expense') {
                          DrawPieChartForExpenseApprovalAction();
                          modeForAge = 2;
                          DrawApprovalAgeingGraph('Expense');
                      }
                      else if (arr[3] == 'Timesheet') {
                          DrawPieChartForTimesheetApprovalAction();
                          modeForAge = 3;
                          DrawApprovalAgeingGraph('Timesheet');
                      }
                      else if (arr[3] == 'Entity') {
                          DrawPieChartForEntityApprovalAction();
                          DrawApprovalAgeingGraph('Entity');
                          modeForAge = 4;
                      }
                      else if (arr[3] == 'HelpDesk') {
                          DrawPieChartForHelpDeskApprovalAction();
                          modeForAge = 5
                          DrawApprovalAgeingGraph('HelpDesk');
                      }
                  }
                  if (mode[0] == 5) {
                      // $("#tblEntityGraph").css("display", "block");
                      //document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                      //DrawPieChartForEntityApprovalAction();
                      //DrawPieChartForHelpDeskApprovalAction();
                      //modeForAge = 5
                      ////document.getElementById("GraphHeaderEntity").style.left = intPosition + "px";
                      ////document.getElementById("DivApprovalAgeing").style.marginLeft = "30%"
                      ////document.getElementById("P1").style.marginLeft = "32%"
                      //DrawApprovalAgeingGraph('HelpDesk');
                      if (arr[4] == 'Leave') {
                          DrawPieChartForLeaveApprovalAction();
                          modeForAge = 1;
                          DrawApprovalAgeingGraph('Leave');
                      }
                      else if (arr[4] == 'Expense') {
                          DrawPieChartForExpenseApprovalAction();
                          modeForAge = 2;
                          DrawApprovalAgeingGraph('Expense');
                      }
                      else if (arr[4] == 'Timesheet') {
                          DrawPieChartForTimesheetApprovalAction();
                          modeForAge = 3;
                          DrawApprovalAgeingGraph('Timesheet');
                      }
                      else if (arr[4] == 'Entity') {
                          DrawPieChartForEntityApprovalAction();
                          DrawApprovalAgeingGraph('Entity');
                          modeForAge = 4;
                      }
                      else if (arr[4] == 'HelpDesk') {
                          DrawPieChartForHelpDeskApprovalAction();
                          modeForAge = 5
                          DrawApprovalAgeingGraph('HelpDesk');
                      }
                  }
              }
          );

}
function ScreenResolutionForAll() {
    allScreenResolution();
    document.getElementById("leaveGraph").innerHTML = "";
    document.getElementById("AllApprovalGraph").innerHTML = "";
    document.getElementById("DivApprovalAgeing").innerHTML = "";
    if (document.getElementById("divEntityWorkFlowApprovalChild").style.display == "block")

        DrawPieChartForEntityApprovalAction();

    if (document.getElementById("divExpenseApprovalChild").style.display == "block")

        DrawPieChartForExpenseApprovalAction();

    if (document.getElementById("divResourceTimesheetApprovalChild").style.display == "block")

        DrawPieChartForTimesheetApprovalAction();

    if (document.getElementById("divHelpDeskApprovalChild").style.display == "block")

        DrawPieChartForHelpDeskApprovalAction();

    if (document.getElementById("divLeaveApprovalChild").style.display == "block")

        DrawPieChartForLeaveApprovalAction();

    if (document.getElementById("tblAllApprovalGraph").style.display == "block") {

        DrawPieChartForAllApprovalAction();
        if (arr[0] == 'Leave') {
            DrawPieChartForLeaveApprovalAction();
        }
        else if (arr[0] == 'Expense') {
            DrawPieChartForExpenseApprovalAction();
        }
        else if (arr[0] == 'Timesheet') {
            DrawPieChartForTimesheetApprovalAction();
        }
        else if (arr[0] == 'Entity') {
            DrawPieChartForEntityApprovalAction();
        }
        else if (arr[0] == 'HelpDesk') {
            DrawPieChartForHelpDeskApprovalAction();
        }
        $("#tblEntityGraph").css("display", "none");
        $("#tblExpenseGraph").css("display", "none");
        $("#tblTimesheetGraph").css("display", "none");
        DrawApprovalAgeingGraph('Overall')

    }
}

function MileStoneDetails() {
    $("#EntityWorkflowApprovalGridview").GridUnload();
    $.ajax({
        url: path + "GetPendingMilestoneEntities",
        //COMMENTED AND ADDED BY Vaijat K ON 22/3/2016 FOR GENERATE PK TOKEN
        //data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
        data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
        //ended
        dataType: "jsonp",
        type: "GET",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            try {
                $("#EntityWorkflowApprovalGridview").GridUnload();
                var JSONdata = JSON.parse(result);
                if (JSONdata.length > 0) {
                    $("#divnoDataToPreview").css("display", "none");
                    $("#divnoDataToPreview").parent().css("box-shadow", "none")
                }
                else {
                    $("#divnoDataToPreview").css("display", "block");
                    $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'MileStone Name', 'Start Date', 'End Date', 'Project Name', 'Bill Amount'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'MileStone_Name', index: 'MileStone_Name', align: 'center', width: 40 },
                    {
                        name: 'Start_Date', index: 'Start_Date', align: 'center', width: 40
                    },
                    {
                        name: 'End_Date', index: 'End_Date', align: 'center', width: 40
                    },
                    { name: 'Project_Name', index: 'Project_Name', align: '', width: 40 },
                    { name: 'Bill_Amount', index: 'Bill_Amount', align: 'center', width: 40 }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
                    sortorder: "asc",
                    viewrecords: true,
                    //caption: "Entity WorkFlow Approval",
                    multiselect: true,
                    loadComplete: function () {
                        $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                    },
                    onSelectRow: function (rowId, col, content, e) {
                        var myGrid = $('#EntityWorkflowApprovalGridview'),
                        selRowId = myGrid.jqGrid('getGridParam', 'selrow'),

                        intEmployeeID = '<%=Session("intUserID").ToString%>'
                    MilestoneId = myGrid.jqGrid('getCell', selRowId, 'ID');
                    //leaveid = myGrid.jqGrid('getCell', selRowId, 'LeaveID');
                    //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');

                    if (MilestoneId) {
                        MilestoneIdApprovalpass = { LoginID: intEmployeeID, MilestoneID: MilestoneId };
                        ShowMilestoneApprovalDetails();
                    }
                    else {
                        MilestoneIdApprovalpass = {};
                        document.getElementById("MyProfile1").style.display = "none";
                        var windowWidth = $(window).width();
                        if (windowWidth > 720) {
                            //document.getElementById("divEntityWorkFlowApprovalParent").style.height = "325px";
                            document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                        }
                        else {
                            document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                        }
                    }
                }, gridComplete: function () {
                    $("#EntityWorkflowApprovalGridview").setSelection('1');
                    $("#cb_EntityWorkflowApprovalGridview").click(function () {
                        var myGrid = $('#EntityWorkflowApprovalGridview')
                        var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                        if (selRowId.length > 1) {
                            $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                        }
                        else if (selRowId.length == 0) {
                            $("#MyProfile1").css("display", "none");
                        }
                        else {
                            $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                        }
                        });

                         //Added By Dipali V On 7th April 2020 For select All issues for Entity Section
                    $('#EntityWorkflowApprovalGridview td .cbox').change(function () {
                        if ($('#EntityWorkflowApprovalGridview td .cbox:checked').length == $('#EntityWorkflowApprovalGridview td .cbox').length) {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', true);
                        }
                        else {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', false);
                        }
                    });
                    //End of Added By Dipali V On 7th April 2020 For select All issues for Entity Section


                }
            });
        }
            catch (exception) {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            }
        },
        error: function (xhr) {
            document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
            document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
        }
    });

}
function subProject() {

    $("#EntityWorkflowApprovalGridview").GridUnload();
    $.ajax({
        url: path + "GetPendingSubProjectEntities",
        //COMMENTED AND ADDED BY Vaijat K  ON 22/3/2016 FOR GENERATE PK TOKEN
        //data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
        data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
        //ended
        dataType: "jsonp",
        type: "GET",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            try {
                $("#EntityWorkflowApprovalGridview").GridUnload();
                var JSONdata = JSON.parse(result);
                if (JSONdata.length > 0) {
                    $("#divnoDataToPreview").css("display", "none");
                    $("#divnoDataToPreview").parent().css("box-shadow", "none")
                }
                else {
                    $("#divnoDataToPreview").css("display", "block");
                    $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'SubProject Name', 'Start Date', 'End Date', 'Project Name', 'Work'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'SubProject_Name', index: 'SubProject_Name', align: 'center', width: 40 },
                    { name: 'Start_Date', index: 'Start_Date', align: 'center', width: 40 },
                    { name: 'End_Date', index: 'End_Date', align: 'center', width: 40 },
                    { name: 'Project_Name', index: 'Project_Name', align: 'center', width: 40 },
                    { name: 'Work', index: 'Work', align: 'center', width: 40 }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
                    sortorder: "asc",
                    viewrecords: true,
                    multiselect: true,
                    loadComplete: function () {
                        $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                    },
                    //caption: "Entity WorkFlow Approval",
                    onSelectRow: function (rowId, col, content, e) {
                        var myGrid = $('#EntityWorkflowApprovalGridview'),
                        selRowId = myGrid.jqGrid('getGridParam', 'selrow'),

                        intEmployeeID = '<%=Session("intUserID").ToString%>'
                    SubProjId = myGrid.jqGrid('getCell', selRowId, 'ID');
                    //leaveid = myGrid.jqGrid('getCell', selRowId, 'LeaveID');
                    //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');

                    if (SubProjId) {
                        //alert(SubProjId)
                        SubProjectApprovalpass = { LoginID: intEmployeeID, SubProjectID: SubProjId };
                        ShowSubProjectApprovalDetails();
                    }
                    else {
                        SubProjectApprovalpass = {};
                        document.getElementById("MyProfile1").style.display = "none";
                        var windowWidth = $(window).width();
                        if (windowWidth > 720) {
                            //document.getElementById("divEntityWorkFlowApprovalParent").style.height = "325px";
                            document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                        }
                        else {
                            document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                        }
                    }
                }, gridComplete: function () {
                    $("#EntityWorkflowApprovalGridview").setSelection('1');
                    $("#cb_EntityWorkflowApprovalGridview").click(function () {
                        var myGrid = $('#EntityWorkflowApprovalGridview')
                        var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                        if (selRowId.length > 1) {
                            $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                        }
                        else if (selRowId.length == 0) {
                            $("#MyProfile1").css("display", "none");
                        }
                        else {
                            $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                        }
                        });
                         //Added By Dipali V On 7th April 2020 For select All issues for Entity Section
                    $('#EntityWorkflowApprovalGridview td .cbox').change(function () {
                        if ($('#EntityWorkflowApprovalGridview td .cbox:checked').length == $('#EntityWorkflowApprovalGridview td .cbox').length) {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', true);
                        }
                        else {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', false);
                        }
                    });
                    //End of Added By Dipali V On 7th April 2020 For select All issues for Entity Section





                }
            });
        }
            catch (exception) {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            }
        },
        error: function (xhr) {
            document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
            document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
        }
    });

}
function ModuleDetails() {
    $("#EntityWorkflowApprovalGridview").GridUnload();
    $.ajax({
        url: path + "GetPendingModuleEntities",
        //COMMENTED AND ADDED BY Vaijat K  ON 22/3/2016 FOR GENERATE PK TOKEN
        // data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
        data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
        //ended
        dataType: "jsonp",
        type: "GET",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            try {
                $("#EntityWorkflowApprovalGridview").GridUnload();
                var JSONdata = JSON.parse(result);
                if (JSONdata.length > 0) {
                    $("#divnoDataToPreview").css("display", "none");
                    $("#divnoDataToPreview").parent().css("box-shadow", "none")
                }
                else {
                    $("#divnoDataToPreview").css("display", "block");
                    $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'Module Name', 'Start_Date', 'End Date', 'Project Name', 'Work'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'Module_Name', index: 'Module_Name', align: 'center', width: 40 },
                    { name: 'Start_Date', index: 'Start_Date', align: 'center', width: 40 },
                    { name: 'End_Date', index: 'End_Date', align: 'center', width: 40 },
                    { name: 'Project_Name', index: 'Project_Name', align: 'center', width: 40 },
                    { name: 'Work', index: 'Work', align: 'center', width: 40 }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
                    sortorder: "asc",
                    viewrecords: true,
                    //caption: "Entity WorkFlow Approval",
                    multiselect: true,
                    loadComplete: function () {
                        $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                    },
                    onSelectRow: function (rowId, col, content, e) {
                        var myGrid = $('#EntityWorkflowApprovalGridview'),
                        selRowId = myGrid.jqGrid('getGridParam', 'selrow'),

                        intEmployeeID = '<%=Session("intUserID").ToString%>'
                    ModuleID = myGrid.jqGrid('getCell', selRowId, 'ID');
                    //leaveid = myGrid.jqGrid('getCell', selRowId, 'LeaveID');
                    //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');

                    if (ModuleID) {
                        ModuleApprovalpass = { LoginID: intEmployeeID, ModuleID: ModuleID };
                        ShowModuleApprovalDetails();
                    }
                    else {
                        ModuleApprovalpass = {};
                        document.getElementById("MyProfile1").style.display = "none";
                        var windowWidth = $(window).width();
                        if (windowWidth > 720) {
                            //document.getElementById("divEntityWorkFlowApprovalParent").style.height = "325px";
                            document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                        }
                        else {
                            document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                        }

                    }
                }, gridComplete: function () {
                    $("#EntityWorkflowApprovalGridview").setSelection('1');
                    $("#cb_EntityWorkflowApprovalGridview").click(function () {
                        var myGrid = $('#EntityWorkflowApprovalGridview')
                        var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                        if (selRowId.length > 1) {
                            $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                        }
                        else if (selRowId.length == 0) {
                            $("#MyProfile1").css("display", "none");
                        }
                        else {
                            $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                        }
                        });

                         //Added By Dipali V On 7th April 2020 For select All issues for Entity Section
                    $('#EntityWorkflowApprovalGridview td .cbox').change(function () {
                        if ($('#EntityWorkflowApprovalGridview td .cbox:checked').length == $('#EntityWorkflowApprovalGridview td .cbox').length) {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', true);
                        }
                        else {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', false);
                        }
                    });
                    //End of Added By Dipali V On 7th April 2020 For select All issues for Entity Section




                }

            });
        }
            catch (exception) {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            }
        },
        error: function (xhr) {
            document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
            document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
        }
    });

}
function DeliverablesDetails() {
    $("#EntityWorkflowApprovalGridview").GridUnload();
    $.ajax({
        url: path + "GetPendingDeliverableEntities",
        //COMMENTED AND ADDED BY Vaijat K  ON 22/3/2016 FOR GENERATE PK TOKEN
        // data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //ended
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try {
                    $("#EntityWorkflowApprovalGridview").GridUnload();
                    var JSONdata = JSON.parse(result);
                    if (JSONdata.length > 0) {
                        $("#divnoDataToPreview").css("display", "none");
                        $("#divnoDataToPreview").parent().css("box-shadow", "none")
                    }
                    else {
                        $("#divnoDataToPreview").css("display", "block");
                        $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                    }
                    jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                        datatype: "local",
                        data: JSON.parse(result),
                        colNames: ['ID', 'Title', 'Start_Date', 'End Date', 'Project Name', 'Status'],
                        colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                        { name: 'Title', index: 'Title', align: 'center', width: 40 },
                        {
                            name: 'Start_Date', index: 'Start_Date', align: 'center', width: 40
                        },
                        {
                            name: 'End_Date', index: 'End_Date', align: 'center', width: 40
                        },
                        { name: 'Project_Name', index: 'Project_Name', align: 'center', width: 40 },
                        { name: 'Status', index: 'Status', align: 'center', width: 40 }],
                        rowNum: 05,
                        autoencode: true,
                        rowList: [5, 10, 20, 50, 100],
                        // sortname: 'ProjectID',
                        pager: jQuery('#pageNavigation'),
                        sortorder: "asc",
                        viewrecords: true,
                        //caption: "Entity WorkFlow Approval",
                        multiselect: true,
                        loadComplete: function () {
                            $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                            $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                        },
                        onSelectRow: function (rowId, col, content, e) {
                            var myGrid = $('#EntityWorkflowApprovalGridview'),
                            selRowId = myGrid.jqGrid('getGridParam', 'selrow'),

                            intEmployeeID = '<%=Session("intUserID").ToString%>'
                        ScheduleID = myGrid.jqGrid('getCell', selRowId, 'ID');
                        //leaveid = myGrid.jqGrid('getCell', selRowId, 'LeaveID');
                        //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');

                        if (ScheduleID) {
                            DeliverableApprovalpass = { LoginID: intEmployeeID, ScheduleID: ScheduleID };
                            ShowDeliverableApprovalDetails();
                        }
                        else {
                            DeliverableApprovalpass = {};
                            document.getElementById("MyProfile1").style.display = "none";
                            var windowWidth = $(window).width();
                            if (windowWidth > 720) {
                                //document.getElementById("divEntityWorkFlowApprovalParent").style.height = "325px";
                                document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                            }
                            else {
                                document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                            }
                        }
                    }, gridComplete: function () {
                        $("#EntityWorkflowApprovalGridview").setSelection('1');
                        $("#cb_EntityWorkflowApprovalGridview").click(function () {
                            var myGrid = $('#EntityWorkflowApprovalGridview')
                            var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                            if (selRowId.length > 1) {
                                $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                            }
                            else if (selRowId.length == 0) {
                                $("#MyProfile1").css("display", "none");
                            }
                            else {
                                $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                            }
                        });
                    }
                });
            }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            }
        });

}
function ChangeRequest() {
    $("#EntityWorkflowApprovalGridview").GridUnload();
    $.ajax({
        url: path + "GetPendingChangeRequestEntities",
        //COMMENTED AND ADDED BY Vaijat K  ON 22/3/2016 FOR GENERATE PK TOKEN
        // data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //ended
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try {
                    $("#EntityWorkflowApprovalGridview").GridUnload();
                    var JSONdata = JSON.parse(result);
                    if (JSONdata.length > 0) {
                        $("#divnoDataToPreview").css("display", "none");
                        $("#divnoDataToPreview").parent().css("box-shadow", "none")
                    }
                    else {
                        $("#divnoDataToPreview").css("display", "block");
                        $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                    }
                    jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                        datatype: "local",
                        data: JSON.parse(result),
                        colNames: ['ID', 'Change Request', 'Project Name', 'Requester', 'Priority', 'Cost Of Change'],
                        colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                        { name: 'Change_Request', index: 'Change_Request', align: 'center', width: 40 },
                        { name: 'Project_Name', index: 'Project_Name', align: 'center', width: 40 },
                        { name: 'Requestor', index: 'Requestor', align: 'center', width: 40 },
                        { name: 'Priority', index: 'Priority', align: 'center', width: 40 },
                        { name: 'Cost_Of_Change', index: 'Cost_Of_Change', align: 'center', width: 40 }],
                        rowNum: 05,
                        autoencode: true,
                        rowList: [5, 10, 20, 50, 100],
                        // sortname: 'ProjectID',
                        pager: jQuery('#pageNavigation'),
                        sortorder: "asc",
                        viewrecords: true,
                        //caption: "Entity WorkFlow Approval",
                        multiselect: true,
                        loadComplete: function () {
                            $(this).find(">tbody>tr.jqgrow:odd").addClass("myAltRowClassEven");
                            $(this).find(">tbody>tr.jqgrow:even").addClass("myAltRowClassOdd");
                        },
                        onSelectRow: function (rowId, col, content, e) {
                            var myGrid = $('#EntityWorkflowApprovalGridview'),
                            selRowId = myGrid.jqGrid('getGridParam', 'selrow'),

                            intEmployeeID = '<%=Session("intUserID").ToString%>'
                        ChangeRequestID = myGrid.jqGrid('getCell', selRowId, 'ID');
                        if (ChangeRequestID) {
                            ChangeRequestApprovalpass = { LoginID: intEmployeeID, ChangeRequestID: ChangeRequestID };
                            ShowChangeRequestApprovalDetails();
                        }
                        else {
                            ChangeRequestApprovalpass = {};
                            document.getElementById("MyProfile1").style.display = "none";
                            var windowWidth = $(window).width();
                            if (windowWidth > 720) {
                                //document.getElementById("divEntityWorkFlowApprovalParent").style.height = "325px";
                                document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                            }
                            else {
                                document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                            }
                        }
                    }, gridComplete: function () {
                        $("#EntityWorkflowApprovalGridview").setSelection('1');
                        $("#cb_EntityWorkflowApprovalGridview").click(function () {
                            var myGrid = $('#EntityWorkflowApprovalGridview')
                            var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                            if (selRowId.length > 1) {
                                $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                            }
                            else if (selRowId.length == 0) {
                                $("#MyProfile1").css("display", "none");
                            }
                            else {
                                $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                            }
                            });
                             //Added By Dipali V On 7th April 2020 For select All issues for Entity Section
                    $('#EntityWorkflowApprovalGridview td .cbox').change(function () {
                        if ($('#EntityWorkflowApprovalGridview td .cbox:checked').length == $('#EntityWorkflowApprovalGridview td .cbox').length) {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', true);
                        }
                        else {
                            $('#cb_EntityWorkflowApprovalGridview').prop('checked', false);
                        }
                    });
                    //End of Added By Dipali V On 7th April 2020 For select All issues for Entity Section




                    }
                });
            }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
            }
        });


}
function ShowProjectApprovalDetails() {

    try {
        $.ajax({
            type: "POST", //GET or POST or PUT or DELETE verb
            url: "MyApproval_Home.aspx/WriteGrid", // Location of the service
            data: JSON.stringify(ProjectApprovalpass),
            contentType: "application/json;charset=utf-8", // content type sent to server
            dataType: "json", //Expected data format from server
            async: false,
            success: function (data) {//On Successfull service call 

                //set empty table data 
                $("#dinamictbl1").empty();
                var myGrid = $('#EntityWorkflowApprovalGridview'),
                selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                if (selRowId.length > 1) {
                    $("#MyProfile1").find(".margin").find(".btn").css("display", "none");
                }
                else {
                    $("#MyProfile1").find(".margin").find(".btn").css("display", "");
                }
                $.each(JSON.parse(data.d), function (id, obj) {
                    //    //cerate dynamic table with data

                    var Prj_Start_Date = new Date(parseInt((obj.Start_Date).substr(6)));
                    var Start_Date = $.datepicker.formatDate("dd/mm/yy", Prj_Start_Date);

                    var Prj_End_Date = new Date(parseInt((obj.End_Date).substr(6)));
                    var End_Date = $.datepicker.formatDate("dd/mm/yy", Prj_End_Date);

                    $("#dinamictbl1").append("<tr><td class='innermarg'>Abbriviated Name</td><td class='innermarg'>" + obj.Abbreviated_Name + "</td></tr><tr><td class='innermarg'>Project Code</td><td class='innermarg'>" + obj.Project_Code + "</td></tr><tr><td class='innermarg'>Project Name</td><td class='innermarg'>" + obj.Project_Name + "</td></tr><tr><td class='innermarg'>Description</td><td class='innermarg'>" + obj.Description + "</td></tr><tr><td class='innermarg'>Senders Comment</td><td class='innermarg'>" + HtmlEncode(obj.SendersComment) + "</td></tr><tr><td class='innermarg'>Project Group</td><td class='innermarg'>" + obj.Project_Group + "</td></tr><tr><td class='innermarg'>Billable</td><td class='innermarg'>" + obj.Billable + "</td></tr><tr><td>Commertial Details</td><td class='innermarg'>" + obj.Commercial_Details + "</td></tr><tr><td>Start Date</td><td class='innermarg'>" + Start_Date + "</td></tr><tr><td>End Date</td><td class='innermarg'>" + End_Date + "</td></tr><tr><td>Work</td><td class='innermarg'>" + obj.Work + "</td></tr><tr><td>Duration(days)</td><td class='innermarg'>" + obj.Duration_days + "</td></tr><tr><td>Project Value</td><td class='innermarg'>" + obj.Project_Value + "</td></tr><tr><td>Project Currency</td><td class='innermarg'>" + obj.Project_Currency + "</td></tr><tr><td>Business Group</td><td class='innermarg'>" + obj.Business_Group + "</td></tr><tr><td>Organization Unit</td><td class='innermarg'>" + obj.Organization_Unit + "</td></tr><tr><td>Practice</td><td class='innermarg'>" + obj.Practice + "</td></tr><tr><td>Customer</td><td class='innermarg'>" + obj.Customer + "</td></tr><tr><td>Project Size</td><td class='innermarg'>" + obj.Project_Size + "</td></tr><tr><td>Project Sponsor</td><td class='innermarg'>" + obj.Project_Sponsor + "</td></tr><tr><td>Life Cycle</td><td class='innermarg'>" + obj.Life_Cycle + "</td></tr><tr><td>Project Size Unit</td><td class='innermarg'>" + obj.Project_Size_Unit + "</td></tr><tr><td>Proposal Reference</td><td class='innermarg'>" + obj.Proposal_Reference + "</td></tr><tr><td>Project Status</td><td class='innermarg'>" + obj.Project_Status + "</td></tr>");
                    return false;
                });
                document.getElementById("MyProfile1").style.display = "block";
                var windowWidth = $(window).width();
                if (windowWidth < 721) {
                    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                }
                else {
                    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                }
            },
            error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
               <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>


                }
            });
        } catch (exception) { }
    }

    function ShowSubProjectApprovalDetails() {
        try {
            $.ajax({
                type: "POST", //GET or POST or PUT or DELETE verb
                url: "MyApproval_Home.aspx/WriteGridSubProject", // Location of the service
                data: JSON.stringify(SubProjectApprovalpass),
                contentType: "application/json;charset=utf-8", // content type sent to server
                dataType: "json", //Expected data format from server
                async: false,
                success: function (data) {//On Successfull service call 

                    //set empty table data 
                    $("#dinamictbl1").empty();
                    var myGrid = $('#EntityWorkflowApprovalGridview'),
                   selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                    if (selRowId.length > 1) {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                    }
                    else {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                    }
                    $.each(JSON.parse(data.d), function (id, obj) {
                        //    //cerate dynamic table with data


                        var SubPrj_Start_Date = new Date(parseInt((obj.Start_Date).substr(6)));
                        var Start_Date = $.datepicker.formatDate("dd/mm/yy", SubPrj_Start_Date);

                        var SubPrj_End_Date = new Date(parseInt((obj.End_Date).substr(6)));
                        var End_Date = $.datepicker.formatDate("dd/mm/yy", SubPrj_End_Date);


                        $("#dinamictbl1").append("<tr><td class='innermarg'>Sub Project Name</td><td class='innermarg'>" + obj.Sub_Project_Name + "</td></tr><tr><td class='innermarg'>Description</td><td class='innermarg'>" + obj.Description + "</td></tr><tr><td class='innermarg'>Senders Comment</td><td class='innermarg'>" + obj.Comments + "</td></tr><tr><td class='innermarg'>Start Date</td><td class='innermarg'>" + Start_Date + "</td></tr><tr><td class='innermarg'>End Date</td><td class='innermarg'>" + End_Date + "</td></tr><tr><td class='innermarg'>Work</td><td class='innermarg'>" + obj.Work + "</td></tr><tr><td class='innermarg'>Closed</td><td class='innermarg'>" + obj.Closed + "</td></tr><tr><td>Responsible Person</td><td class='innermarg'>" + obj.Responsible_Person + "</td></tr>");
                        return false;
                    });
                    document.getElementById("MyProfile1").style.display = "block";
                    var windowWidth = $(window).width();
                    if (windowWidth < 721) {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                    }
                    else {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                    }

                },
                error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
               <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>


                }
            });
        } catch (exception) { }
    }

    function ShowMilestoneApprovalDetails() {
        //alert(MilestoneIdApprovalpass);
        try {
            $.ajax({
                type: "POST", //GET or POST or PUT or DELETE verb
                url: "MyApproval_Home.aspx/WriteGridMilestone", // Location of the service
                data: JSON.stringify(MilestoneIdApprovalpass),
                contentType: "application/json;charset=utf-8", // content type sent to server
                dataType: "json", //Expected data format from server
                async: false,
                success: function (data) {//On Successfull service call 

                    //set empty table data 
                    $("#dinamictbl1").empty();
                    var myGrid = $('#EntityWorkflowApprovalGridview'),
                   selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                    if (selRowId.length > 1) {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                    }
                    else {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                    }
                    $.each(JSON.parse(data.d), function (id, obj) {
                        //    //cerate dynamic table with data

                        //var Mil_Start_Date = new Date(parseInt((obj.Start_Date).substr(6)));
                        //var Start_Date = $.datepicker.formatDate("dd/mm/yy", Mil_Start_Date);

                        //var Mil_End_Date = new Date(parseInt((obj.End_Date).substr(6)));
                        //var End_Date = $.datepicker.formatDate("dd/mm/yy", Mil_End_Date);

                        //var Mil_Revenue_Recognize_Date = new Date(parseInt((obj.Revenue_Recognize_Date).substr(6)));
                        //var Revenue_Recognize_Date = $.datepicker.formatDate("dd/mm/yy", Mil_Revenue_Recognize_Date);

                        $("#dinamictbl1").append("<tr><td class='innermarg'>MileStone Name</td><td class='innermarg'>" + obj.MileStone_Name + "</td></tr><tr><td class='innermarg'>Start Date</td><td class='innermarg'>" + obj.Start_Date + "</td></tr><tr><td class='innermarg'>End Date</td><td class='innermarg'>" + obj.End_Date + "</td></tr><tr><td class='innermarg'>Milestone Details</td><td class='innermarg'>" + obj.Milestone_Details + "</td></tr><tr><td class='innermarg'>Senders Comment</td><td class='innermarg'>" + obj.Comments + "</td></tr><tr><td class='innermarg'>Bill Amount</td><td class='innermarg'>" + obj.Bill_Amount + "</td></tr><tr><td class='innermarg'>Ready for Billing</td><td class='innermarg'>" + obj.Ready_for_Billing + "</td></tr><tr><td>Invoice Printed</td><td class='innermarg'>" + obj.Invoice_Printed + "</td></tr><tr><td>Analysis applicable</td><td class='innermarg'>" + obj.Analysis_applicable + "</td></tr><tr><td>Analysis Status</td><td class='innermarg'>" + obj.Analysis_Status + "</td></tr><tr><td>Milestone Status</td><td class='innermarg'>" + obj.Milestone_Status + "</td></tr><tr><td>Invoice No</td><td class='innermarg'>" + obj.Invoice_No + "</td></tr><tr><td>ResponsiblePerson</td><td class='innermarg'>" + obj.ResponsiblePerson + "</td></tr><tr><td>Closed</td><td class='innermarg'>" + obj.Closed + "</td></tr><tr><td>Revenue Recognize Date</td><td class='innermarg'>" + obj.Revenue_Recognize_Date + "</td></tr>");
                        return false;
                    });
                    document.getElementById("MyProfile1").style.display = "block";
                    var windowWidth = $(window).width();
                    if (windowWidth < 721) {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                    }
                    else {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                    }
                },
                error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
               <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>

                }
            });
        } catch (exception) { }
    }

    function ShowModuleApprovalDetails() {
        //alert(MilestoneIdApprovalpass);
        try {
            $.ajax({
                type: "POST", //GET or POST or PUT or DELETE verb
                url: "MyApproval_Home.aspx/WriteGridModule", // Location of the service
                data: JSON.stringify(ModuleApprovalpass),
                contentType: "application/json;charset=utf-8", // content type sent to server
                dataType: "json", //Expected data format from server
                async: false,
                success: function (data) {//On Successfull service call 

                    //set empty table data 
                    $("#dinamictbl1").empty();
                    var myGrid = $('#EntityWorkflowApprovalGridview'),
                   selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                    if (selRowId.length > 1) {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                    }
                    else {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                    }
                    $.each(JSON.parse(data.d), function (id, obj) {
                        //    //cerate dynamic table with data

                        //var Mod_Start_Date = new Date(parseInt((obj.Start_Date).substr(6)));
                        //var Start_Date = $.datepicker.formatDate("dd/mm/yy", Mod_Start_Date);

                        //var Mod_End_Date = new Date(parseInt((obj.End_Date).substr(6)));
                        //var End_Date = $.datepicker.formatDate("dd/mm/yy", Mod_End_Date);

                        $("#dinamictbl1").append("<tr><td class='innermarg'>Module Name</td><td class='innermarg'>" + obj.Module_Name + "</td></tr><tr><td class='innermarg'>Module Description</td><td class='innermarg'>" + obj.Module_Description + "</td></tr><tr><td class='innermarg'>Senders Comment</td><td class='innermarg'>" + obj.Comments + "</td></tr><tr><td class='innermarg'>Start Date</td><td class='innermarg'>" + obj.Start_Date + "</td></tr><tr><td class='innermarg'>End Date</td><td class='innermarg'>" + obj.End_Date + "</td></tr><tr><td class='innermarg'>Work</td><td class='innermarg'>" + obj.Work + "</td></tr><tr><td class='innermarg'>Responsible Person</td><td class='innermarg'>" + obj.ResponsiblePerson + "</td></tr><tr><td>Complexity</td><td class='innermarg'>" + obj.Complexity + "</td></tr><tr><td>Closed</td><td class='innermarg'>" + obj.Closed + "</td></tr>");
                        return false;
                    });
                    document.getElementById("MyProfile1").style.display = "block";
                    var windowWidth = $(window).width();
                    if (windowWidth < 721) {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                    }
                    else {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                    }
                },
                error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
               <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>

                }
            });
        } catch (exception) { }
    }

    function ShowDeliverableApprovalDetails() {
        try {
            $.ajax({
                type: "POST", //GET or POST or PUT or DELETE verb
                url: "MyApproval_Home.aspx/WriteGridDeliverable", // Location of the service
                data: JSON.stringify(DeliverableApprovalpass),
                contentType: "application/json;charset=utf-8", // content type sent to server
                dataType: "json", //Expected data format from server
                async: false,
                success: function (data) {//On Successfull service call 
                    //set empty table data 
                    $("#dinamictbl1").empty();
                    var myGrid = $('#EntityWorkflowApprovalGridview'),
                   selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                    if (selRowId.length > 1) {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                    }
                    else {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                    }
                    $.each(JSON.parse(data.d), function (id, obj) {
                        //    //cerate dynamic table with data

                        //var Del_Start_Date = new Date(parseInt((obj.Start_Date).substr(6)));
                        //var Start_Date = $.datepicker.formatDate("dd/mm/yy", Del_Start_Date);

                        //var Del_End_Date = new Date(parseInt((obj.End_Date).substr(6)));
                        //var End_Date = $.datepicker.formatDate("dd/mm/yy", Del_End_Date);

                        $("#dinamictbl1").append("<tr><td class='innermarg'>Code Template</td><td class='innermarg'>" + obj.Code_Template + "</td></tr><tr><td class='innermarg'>Title</td><td class='innermarg'>" + obj.Title + "</td></tr><tr><td class='innermarg'>Description</td><td class='innermarg'>" + obj.Description + "</td></tr><tr><td class='innermarg'>Senders Comment</td><td class='innermarg'>" + obj.Comments + "</td></tr><tr><td class='innermarg'>Start Date</td><td class='innermarg'>" + obj.Start_Date + "</td></tr><tr><td class='innermarg'>End Date</td><td class='innermarg'>" + obj.End_Date + "</td></tr><tr><td class='innermarg'>Efforts</td><td class='innermarg'>" + obj.efforts + "</td></tr><tr><td>Priority</td><td class='innermarg'>" + obj.Priority + "</td></tr><tr><td>Requested By</td><td class='innermarg'>" + obj.Requested_By + "</td></tr><tr><td>Responsible Person</td><td class='innermarg'>" + obj.Responsible_Person + "</td></tr><tr><td>Status</td><td class='innermarg'>" + obj.Status + "</td></tr><tr><td>Start Time</td><td class='innermarg'>" + obj.Start_Time + "</td></tr><tr><td>Complition Time</td><td class='innermarg'>" + obj.Complition_Time + "</td></tr><tr><td>Billable</td><td class='innermarg'>" + obj.Billable + "</td></tr><tr><td>On Hold</td><td class='innermarg'>" + obj.OnHold + "</td></tr><tr><td>Void</td><td class='innermarg'>" + obj.Void + "</td></tr><tr><td>Billable Amount</td><td class='innermarg'>" + obj.Billable_Amount + "</td></tr>");
                        return false;
                    });
                    document.getElementById("MyProfile1").style.display = "block";
                    var windowWidth = $(window).width();
                    if (windowWidth < 721) {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                    }
                    else {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                    }
                },
                error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
               <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
                }
            });
        } catch (exception) { }
    }

    function ShowChangeRequestApprovalDetails() {
        try {
            $.ajax({
                type: "POST", //GET or POST or PUT or DELETE verb
                url: "MyApproval_Home.aspx/WriteGridChangeRequest", // Location of the service
                data: JSON.stringify(ChangeRequestApprovalpass),
                contentType: "application/json;charset=utf-8", // content type sent to server
                dataType: "json", //Expected data format from server
                async: false,
                success: function (data) {//On Successfull service call 
                    //set empty table data 
                    $("#dinamictbl1").empty();
                    var myGrid = $('#EntityWorkflowApprovalGridview'),
                   selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                    if (selRowId.length > 1) {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "hidden");
                    }
                    else {
                        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
                    }
                    $.each(JSON.parse(data.d), function (id, obj) {
                        //    //cerate dynamic table with data

                        //var date = new Date(parseInt((obj.Change_Requested_Date).substr(6)));
                        //var Change_Requested_Date = $.datepicker.formatDate("dd/mm/yy", date);

                        //var chgReq_Approved_Date = new Date(parseInt((obj.Approved_Date).substr(6)));
                        //var Approved_Date = $.datepicker.formatDate("dd/mm/yy", chgReq_Approved_Date);

                        //var chgReq_Rejected_Date = new Date(parseInt((obj.Rejected_Date).substr(6)));
                        //var Rejected_Date = $.datepicker.formatDate("dd/mm/yy", chgReq_Rejected_Date);

                        $("#dinamictbl1").append("<tr><td class='innermarg'>Change Request</td><td class='innermarg'>" + obj.Change_Request + "</td></tr><tr><td class='innermarg'>Change Requestor</td><td class='innermarg'>" + obj.Change_Requestor + "</td></tr><tr><td class='innermarg'>Change Requested Date</td><td class='innermarg'>" + obj.Change_Requested_Date + "</td></tr><tr><td class='innermarg'>Senders Comment</td><td class='innermarg'>" + obj.Comments + "</td></tr><tr><td class='innermarg'>Module</td><td class='innermarg'>" + obj.Module + "</td></tr><tr><td class='innermarg'>Version</td><td class='innermarg'>" + obj.Version + "</td></tr><tr><td class='innermarg'>Change Priority</td><td class='innermarg'>" + obj.Change_Priority + "</td></tr><tr><td>Description</td><td class='innermarg'>" + obj.Description + "</td></tr><tr><td>Benefits</td><td class='innermarg'>" + obj.Benefits + "</td></tr><tr><td>Category</td><td class='innermarg'>" + obj.Category + "</td></tr><tr><td>Estimation Document Reference</td><td class='innermarg'>" + obj.Estimation_Document_Reference + "</td></tr><tr><td>Approved By</td><td class='innermarg'>" + obj.Approved_By + "</td></tr><tr><td>Approved Date</td><td class='innermarg'>" + obj.Approved_Date + "</td></tr><tr><td>Rejected By</td><td class='innermarg'>" + obj.Rejected_By + "</td></tr><tr><td>Rejected Date</td><td class='innermarg'>" + obj.Rejected_Date + "</td></tr><tr><td>Change Status</td><td class='innermarg'>" + obj.Change_Status + "</td></tr><tr><td>Cost Of Change</td><td class='innermarg'>" + obj.Cost_Of_Change + "</td></tr><tr><td>Deliverable</td><td class='innermarg'>" + obj.Deliverable + "</td></tr>");
                        return false;
                    });
                    document.getElementById("MyProfile1").style.display = "block";
                    var windowWidth = $(window).width();
                    if (windowWidth < 721) {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                    }
                    else {
                        document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                    }
                },
                error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
               <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
                }
            });
        } catch (exception) { }
    }

    function GetWorkflowEntity() {

        var mylist = document.getElementById("dropdownval");
        var entity = mylist.options[mylist.selectedIndex].value;
        document.getElementById("MyProfile1").style.display = "none";
        $("#MyProfile1").find(".margin").find(".btn").css("visibility", "");
        switch (entity) {
            case '32': EntityWorkflowApproval()
                break;
            case '34': MileStoneDetails()
                break;
            case '661': subProject()
                break;
            case '454': ModuleDetails()
                break;
            case '2133': DeliverablesDetails()
                break;
            case '1039': ChangeRequest()
                break;

        }
    }
    function Cancel(id) {
        if (document.getElementById("leaveappCommit") == "") {
            document.getElementById("leaveappCommit").value = "";
        }
        $('#' + id).modal('hide');
        if (id == 'approvalpopup') {
        }
        else {
            location.reload();
        }
    }

    function Approved(gridid, idcolumn) {
        var intMessageID;
        var idesval = "";
        var EmployeeID;
        var FromDate;
        var todate;
        var empname;
        var fihalf;
        var sehalf;
        var email;
        var status = glovalStatus;
        var dbstatus;
        var para1;
        var entIDs = "";
        var levID = "";
        var emailids = "";
        var msg = "";
        var comments
        if ('A' == glovalStatus) {
            dbstatus = 'Approved';
            intMessageID = 69;
            comments = 'Leave Approved'
        }
        else {
            dbstatus = 'Rejected';
            intMessageID = 70;
            comments = 'Leave Rejected'
        }
        var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');

        if (id.length) {
            for (var i = 0; i < id.length; i++)  //For Multiple Delete of row
            {

                EmployeeID = $('#LeaveApprovalGridview').getCell(id[i], 'EmployeeID');
                idesval += EmployeeID + ',';
                FromDate = $('#LeaveApprovalGridview').getCell(id[i], 'FromDate');
                todate = $('#LeaveApprovalGridview').getCell(id[i], 'ToDate');
                Leaveid = $('#LeaveApprovalGridview').getCell(id[i], 'LeaveID');
                empname = $('#LeaveApprovalGridview').getCell(id[i], 'EmployeeName');
                comments = $('#leaveappCommit').val();
                fihalf = $('#LeaveApprovalGridview').getCell(id[i], 'FirstHalfDay');
                sehalf = $('#LeaveApprovalGridview').getCell(id[i], 'SecondHalfDay');
                email = $('#LeaveApprovalGridview').getCell(id[i], 'EmailID');
                //para = { LoginID: '<%=Session("intUserID")%>', Comments: comments, EmployeeID: EmployeeID, leaveID: Leaveid, status: status };
                var halfdayval;
                if (fihalf == 1)
                    halfdayval = 'First Half Day';
                else if (sehalf == 1)
                    halfdayval = 'Second Half Day';
                else
                    halfdayval = '';
                if (entIDs == "") {
                    entIDs = $('#' + gridid).getCell(id[i], 'EmployeeID')
                }
                else {
                    entIDs += "," + $('#' + gridid).getCell(id[i], 'EmployeeID')
                }
                if (levID == "") {
                    levID = $('#' + gridid).getCell(id[i], 'LeaveID')
                }
                else {
                    levID += "," + $('#' + gridid).getCell(id[i], 'LeaveID')
                }
                if (emailids == "") {
                    emailids = $('#' + gridid).getCell(id[i], 'EmailID')
                }
                else {
                    emailids += "," + $('#' + gridid).getCell(id[i], 'EmailID')
                }

                if (msg == "") {
                    msg = ' Hi ' + empname + ', \n\nThis is to inform you that your ' + halfdayval + 'leave from ' + FromDate + ' to ' + todate + ' has been ' + dbstatus + '.\nComments :' + comments + '\n\nRegards,\n <%=Session("strUserName")%>'
                }
                else {
                    msg += "*" + ' Hi ' + empname + ', \n\nThis is to inform you that your ' + halfdayval + 'leave from ' + FromDate + ' to ' + todate + ' has been ' + dbstatus + '.\nComments :' + comments + '\n\nRegards,\n <%=Session("strUserName")%>'
                }


            }
            $.ajax({
                type: 'POST',
                url: 'MyApproval_Home.aspx/SetWork1',
                contentType: 'application/json;charset-utf=8',
                data: JSON.stringify({ LoginID: '<%=Session("intUserID").ToString%>', EmployeeID: entIDs, leaveID: levID, status: status }),
                dataType: 'json',
                async: false,
                success: function (Result) {

                    para1 = { LoginID: '<%=Session("intUserID").ToString%>', Comments: comments, EmployeeID: entIDs, leaveID: levID, status: status, pToken: Result.d };
                    try {

                        $.ajax({
                            type: "GET", //GET or POST or PUT or DELETE verb
                            url: path + "ApproveorRejectLeave_Home",
                            data: para1,
                            contentType: "application/json;charset=utf-8",
                            dataType: "jsonp", //Expected data format from server
                            async: false,
                            success: function (data) {//On Successfull service call  

                                //  alert("Leave "+dbstatus); 


                            },
                            error: function (xhr) {
                              <%If Session("intUserID") Is Nothing Then%>
                                alert("Session Expired!");
                                <%Else%>
                                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
                                <%End If%>

                            }
                        });
                        if (id.length == 1) {
                            window.open("../General/SendEmail.aspx?MessageID=" + intMessageID + "&LeaveID=" + Leaveid, "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                        }
                        else {
                            $.ajax({
                                //url: "MyApproval_Home.aspx?Mode=Send&Msgto=" + emailids + "&MsgSubject=Leave " + dbstatus + "&EmailMsg=" + msg,
                                url: "MyApproval_Home.aspx?Mode=Send&LeaveID=" + levID + "&ApproveorReject=" + glovalStatus,
                                success: function (result) {
                                }
                            });
                        }
                    }
                    catch (exception) { }


                }
            });
            $('#approvalpopup').modal('hide');

        }

        setTimeout(function () {
            LeaveApprovalTest();
            DrawPieChartForLeaveApprovalAction();
            document.getElementById("MyProfile").style.display = "none";
            document.getElementById("divLeaveApprovalParent").style.height = "auto";
        }, 1000);
    }
    function GetTimesheet() {

        var mylist = document.getElementById("ddlTimesheet");
        var entity = mylist.options[mylist.selectedIndex].value;
        $("#divResourceTimesheetApprovalChild .btn").css("visibility", "visible");
        document.getElementById("MyProfileTimesheet").style.display = "none"
        $("#MyProfileTimesheet").find(".margin").find(".btn").css("visibility", "");
        document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
        switch (entity) {
            case '1':
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval_Home.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 2125 }),
                    contentType: 'application/json;charset-utf=8',
                    async: false,
                    success: function (Result) {
                        if (String(Result.d) == "1") {
                            GetResourceTimesheetApproval()
                        }
                        else {
                            document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "You do not have access";
                            $("#ResourceTimesheetApprovalgrid").GridUnload();
                            $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
                        }
                    }
                });
                break;
            case '2':
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval_Home.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 42 }),
                        contentType: 'application/json;charset-utf=8',
                        async: false,
                        success: function (Result) {
                            if (String(Result.d) == "1") {
                                PendingProjectApproval()
                            }
                            else {
                                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "You do not have access";
                                $("#ResourceTimesheetApprovalgrid").GridUnload();
                                $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
                            }
                        }
                    });
                    break;
            }
        }
        function SendMail() {
            $.ajax({
                url: "MyApproval.aspx?Mode=Send&Msgfrom=" + document.getElementById("from").value + "&Msgto=" + document.getElementById("to").value + "&MsgSubject=" + document.getElementById("mailsubject").value + "&EmailMsg=" + document.getElementById('message').value + "&MsgCC=" + document.getElementById('cc').value + "&ids=" + document.getElementById('ids').value,
                async: false,
                success: function (result) {
                }
            });
            $("#mailBoxpopup").modal('hide');
            para = { LoginID: '<%=Session("intUserID").ToString%>' };
        LeaveApprovalTest();
        document.getElementById("MyProfile").style.display = "none";
        document.getElementById("divLeaveApprovalParent").style.height = "auto";

    }
    function checkSelectApproval(gridid, idcolumn, StatusAR) {
        GridName = gridid;
        glovalStatus = StatusAR;
        var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');

        if (id.length) {
            approveBtn();
        }
        else {
            //Commented And Added By Vaijat K ON 12/04/2016 For Issue ID-
            //var entityName = ""
            //if (GridName == "LeaveApprovalGridview") { entityName = "Leave"; }
            //else if (GridName == "ResourceTimesheetApprovalgrid") { entityName = "Timesheet"; }
            //else if (GridName == "EntityWorkflowApprovalGridview") { entityName = "Entity"; }
            //else if (GridName == "ExpenseApprovalGridview") { entityName = "Expense"; }
            //alert("Select " + entityName + " Approval First");
            alert("Please Select Request First.");
        }
    }

    function checkSelectApprovalDetail(gridid, idcolumn, StatusAR) {
        GridName = gridid;
        glovalStatus = StatusAR;
        var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');

        if (id.length == 1) {
            approveBtn();
        }
    }
    function ApproveTimesheet(gridid) {
        var mylist = document.getElementById("ddlTimesheet");
        var entity = mylist.options[mylist.selectedIndex].value;
        var strResourceID;
        var entIDs = "";
        var strFromDate;
        var strToDate;
        if (entity == "1") {
            var Ajaxresult = "";
            var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');
            var tblLength = id.length;
            for (var i = 0; i < tblLength; i++) {
                strFromDate = $('#' + gridid).getCell(id[i], 'FromDate');
                strToDate = $('#' + gridid).getCell(id[i], 'ToDate');
                strResourceID = $('#' + gridid).getCell(id[i], 'EmployeeID');

                //if (glovalStatus == "A") {
                //    window.open("../General/SendEmail.aspx?MessageID=435&VerifiedBy=" + <%=CType(Session("intUserID"), String)%> + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500")
                        //  }
                        // else {
                        //      window.open("../General/SendEmail.aspx?MessageID=437&VerifiedBy=" + <%=CType(Session("intUserID"), String)%> + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500")
                        //  }
                        if (entIDs == "") {
                            entIDs = $('#' + gridid).getCell(id[i], 'TimeSheetID')
                        }
                        else {
                            entIDs += "," + $('#' + gridid).getCell(id[i], 'TimeSheetID')
                        }
                    }

                    ValidateResourceDate_XML("MyApproval_Home.aspx?Mode=Timesheet&TimesheetID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength);
                    if (tblLength == 1) {
                        if (glovalStatus == "A") {
                            window.open("../General/SendEmail.aspx?MessageID=435&VerifiedBy=" + <%=CType(Session("intUserID"), String)%> + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500")
                            }
                            else {
                                window.open("../General/SendEmail.aspx?MessageID=437&VerifiedBy=" + <%=CType(Session("intUserID"), String)%> + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500")
                            }
                        }
                    }
                    else {
                        var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');
                        var tblLength = id.length;
                        var empname = "";
                        for (var i = 0; i < tblLength; i++) {
                            empname = $('#' + gridid).getCell(id[i], 'TimeSheetNo');
                            if (entIDs == "") {
                                entIDs = $('#' + gridid).getCell(id[i], 'TimeSheetNo')
                            }
                            else {
                                entIDs += "," + $('#' + gridid).getCell(id[i], 'TimeSheetNo')
                            }

                            //if (glovalStatus == "A") {
                            //    window.open("../General/SendEmail.aspx?MessageID=4&TimeSheetID=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')
                            //}
                            //else {
                            //    window.open("../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')
                            //}
                        }
                        ValidateResourceDate_XML("MyApproval_Home.aspx?Mode=ProjTimesheet&TimesheetID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength)
                        if (tblLength == 1) {
                            if (glovalStatus == "A") {
                                window.open("../General/SendEmail.aspx?MessageID=4&TimeSheetID=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')
                            }
                            else {
                                window.open("../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')
                            }
                        }
                    }
                    setTimeout(function () {
                        GetTimesheet();
                        //GetResourceTimesheetApproval();
                        DrawPieChartForTimesheetApprovalAction();
                        $("#approvalpopup").modal("hide");
                    }, 1000);
                }
                function ApproveEntity(gridid) {
                    var stAction;
                    if (glovalStatus == 'A') {
                        stAction = "SYS_APPROVE";
                    }
                    else {
                        stAction = "SYS_REJECT";
                    }
                    var objResult = null;
                    var strComments;
                    var MsgID;
                    var mylist = document.getElementById("dropdownval");
                    var entity = mylist.options[mylist.selectedIndex].value;
                    var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');
                    var tblLength = id.length;
                    var entIDs = "";
                    var success = 0;
                    var strPrimaryKey = "";
                    var empname
                    for (var i = 0; i < tblLength; i++) {
                        empname = $('#' + gridid).getCell(id[i], 'ID');
                        MsgID = getMsgID();
                        if (entIDs == "") {
                            entIDs = $('#' + gridid).getCell(id[i], 'ID')
                        }
                        else {
                            entIDs += "," + $('#' + gridid).getCell(id[i], 'ID')
                        }
                        //window.open('../General/SendEmail.aspx?MessageID=' + MsgID + "&workflow=1&PrimaryKeyValue=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500');
                    }
                    //ValidateResourceDate_XML("MyApproval_Home.aspx?Mode=Entity&EntityID=" + entIDs + "&MasterTagID=" + entity + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength);
                    if (tblLength == 1) {
                        $.ajax({
                            url: "MyApproval_Home.aspx/GetEntityPrimaryKey",
                            type: "POST",
                            data: JSON.stringify({ intEntityID: empname, strTagID: entity, strAction: glovalStatus }),
                            contentType: "application/json;charset-utf=8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                // window.open('../General/SendEmail.aspx?MessageID=' + MsgID + "&workflow=1&PrimaryKeyValue=" + data.d, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500');
                                strPrimaryKey = data.d;
                            }
                        });
                    }
                    ValidateResourceDate_XML("MyApproval_Home.aspx?Mode=Entity&EntityID=" + entIDs + "&MasterTagID=" + entity + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength);
                    if (tblLength == 1) {
                        window.open('../General/SendEmail.aspx?MessageID=' + MsgID + "&workflow=1&PrimaryKeyValue=" + strPrimaryKey, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500');
                    }
                    setTimeout(function () {
                        GetWorkflowEntity();
                        DrawPieChartForEntityApprovalAction();
                        $("#approvalpopup").modal("hide");
                    }, 1000);
                }
                function getMsgID() {
                    var mylist = document.getElementById("dropdownval");
                    var entity = mylist.options[mylist.selectedIndex].value;
                    switch (entity) {
                        case '32':
                            if (glovalStatus == "A") {
                                return 2;
                            }
                            else {
                                return 3;
                            }
                            break;
                        case '34':
                            if (glovalStatus == "A") {
                                return 5;
                            }
                            else {
                                return 6;
                            }
                            break;
                        case '661':
                            if (glovalStatus == "A") {
                                return 11;
                            }
                            else {
                                return 12;
                            }
                            break;
                        case '454': if (glovalStatus == "A") {
                            return 8;
                        }
                        else {
                            return 9;
                        }
                            break;
                        case '2133': if (glovalStatus == "A") {
                            return 14;
                        }
                        else {
                            return 15;
                        }
                            break;
                        case '1039': if (glovalStatus == "A") {
                            return 17;
                        }
                        else {
                            return 18;
                        }
                            break;

                    }
                }
                function ApproveExpense(gridid) {
                    //var mylist = document.getElementById("ddlExpense");
                    //var entity = mylist.options[mylist.selectedIndex].value;
                    //if (entity == "1") {
                    var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');
                    var timer = 1000;
                    var msgID;
                    var expensesheetID;
                    var entIDs = "";
                    var tblLength = id.length;
                    var empname;
                    var ExpenseID
                    var isexpense = "";
                    for (var i = 0; i < tblLength; i++) {
                        timer = timer + 300;
                        empname = $('#' + gridid).getCell(id[i], 'ExpenseSheetID');
                        ExpenseID = $('#' + gridid).getCell(id[i], 'ExpensesEntryID')
                        if (glovalStatus == "A") {
                            if ($('#' + gridid).getCell(id[i], 'isExpense') == 0)
                                msgID = 466;
                            else
                                msgID = 461;
                        }
                        else {
                            if ($('#' + gridid).getCell(id[i], 'isExpense') == 0)
                                msgID = 467;
                            else
                                msgID = 464;
                        }
                        if (entIDs == "") {
                            entIDs = $('#' + gridid).getCell(id[i], 'ExpensesEntryID')
                        }
                        else {
                            entIDs += "," + $('#' + gridid).getCell(id[i], 'ExpensesEntryID')
                        }

                        if (isexpense == "") {
                            isexpense = $('#' + gridid).getCell(id[i], 'isExpense')
                        }
                        else {
                            isexpense += "," + $('#' + gridid).getCell(id[i], 'isExpense')
                        }
                        //window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ExpenseSheetID=" + empname + "&ExpenseEntryIDList=" + ExpenseID + "", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                    }
                    ValidateResourceDate_XML("MyApproval_Home.aspx?Mode=Expense&ExpensesEntryID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength + "&isExpense=" + isexpense)

                    if (tblLength == 1) {
                        window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ExpenseSheetID=" + empname + "&ExpenseEntryIDList=" + ExpenseID + "", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                    }
                    setTimeout(function () {
                        ExpenseApproval();
                        DrawPieChartForExpenseApprovalAction();
                        $("#approvalpopup").modal("hide");
                    }, 1000);
                    //}
                    //else {
                    //    alert();
                    //    var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');
                    //    var timer = 1000;
                    //    var msgID;
                    //    var expensesheetID;
                    //    var entIDs = "";
                    //    var tblLength = id.length;
                    //    var empname;
                    //    var ExpenseID
                    //    for (var i = 0; i < tblLength; i++) {
                    //        timer = timer + 300;
                    //        empname = $('#' + gridid).getCell(id[i], 'ExpenseSheetID');
                    //        ExpenseID = $('#' + gridid).getCell(id[i], 'ExpensesEntryID')

                    //        if (glovalStatus == "A") {
                    //            msgID = 461;
                    //        }
                    //        else {
                    //            msgID = 464;
                    //        }
                    //        if (entIDs == "") {
                    //            entIDs = $('#' + gridid).getCell(id[i], 'ExpensesEntryID')
                    //        }
                    //        else {
                    //            entIDs += "," + $('#' + gridid).getCell(id[i], 'ExpensesEntryID')
                    //        }
                    //        //window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ExpenseSheetID=" + empname + "&ExpenseEntryIDList=" + ExpenseID + "", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                    //    }
                    //    ValidateResourceDate_XML("MyApproval_Home.aspx?Mode=Finance&ExpensesEntryID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength)

                    //    if (tblLength == 1) {
                    //        window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ExpenseSheetID=" + empname + "&ExpenseEntryIDList=" + ExpenseID + "", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                    //    }
                    //    setTimeout(function () {
                    //        PendingFinanceApproval();
                    //        DrawPieChartForExpenseApprovalAction();
                    //        $("#approvalpopup").modal("hide");
                    //    }, 1000);
                    //}

                }

                function ApproveHelpDesk(gridid) {
                    var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');
                    var timer = 1000;
                    var msgID;
                    var expensesheetID;
                    var entIDs = "";
                    var tblLength = id.length;
                    var empname;
                    for (var i = 0; i < tblLength; i++) {
                        timer = timer + 300;
                        empname = $('#' + gridid).getCell(id[i], 'QueryID');
                        if (entIDs == "") {
                            entIDs = $('#' + gridid).getCell(id[i], 'QueryID')
                        }
                        else {
                            entIDs += "," + $('#' + gridid).getCell(id[i], 'QueryID')
                        }

                        if (glovalStatus == "A") {
                            msgID = 531;
                        }
                        else {
                            msgID = 530;
                        }

                        //window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ApprovalStatus=" + glovalStatus + "&QueryID=" + empname + "&EmployeeIDList=" + <%=Session("intUserID").ToString%> + "&Comments=" + $('#leaveappCommit').val() + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                }
                ValidateResourceDate_XML("MyApproval_Home.aspx?Mode=HelpDesk&QueryID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength)
                if (tblLength == 1) {
                    window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ApprovalStatus=" + glovalStatus + "&QueryID=" + empname + "&EmployeeIDList=" + <%=Session("intUserID").ToString%> + "&Comments=" + $('#leaveappCommit').val() + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                }
                setTimeout(function () {
                    PendingHelpDeskApproval();
                    DrawPieChartForHelpDeskApprovalAction();
                    $("#approvalpopup").modal("hide");
                }, 1000);
            }
            function approveBtn() {
                document.getElementById("MyProfile").style.display = "none";
                document.getElementById("MyProfile1").style.display = "none";
                document.getElementById("MyProfileTimesheet").style.display = "none";
                document.getElementById("MyProfileExpense").style.display = "none";
                document.getElementById("MyProfileHelpdesk").style.display = "none";
                if (GridName == "LeaveApprovalGridview") { Approved('LeaveApprovalGridview', 'EmployeeID'); }
                else if (GridName == "ResourceTimesheetApprovalgrid") { ApproveTimesheet('ResourceTimesheetApprovalgrid'); }
                else if (GridName == "EntityWorkflowApprovalGridview") { ApproveEntity('EntityWorkflowApprovalGridview'); }
                else if (GridName == "ExpenseApprovalGridview") { ApproveExpense('ExpenseApprovalGridview'); }
                else if (GridName == "tblHelpDeskApproval") { ApproveHelpDesk('tblHelpDeskApproval'); }
            }
            /*************************************************Graph Section Function***********************************/

    //Added By Vidya J ON 7 July 2016 For Pending Entity Count
            function GetAllCount1() {
                 $.ajax({
                    type: 'POST',
                    dataType: 'JSON',
                    contentType: 'application/json',
                    url: 'MyApproval_Home.aspx/GetAllCount',
                    data: JSON.stringify({ intUserID: "<%=Session("intUserID").ToString%>" }),
                    //async: false,
                    success: function (Result) {
                         try {
                                   jsonData1 = Result.d;
                              }
                        catch (exception) {
                           
                        }

                    }, error: function (xhr) {
                <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
               <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
                
                }
                });
            }
          //End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count

    function DrawPieChartForAllApprovalAction() {
                
                document.getElementById("AllApprovalGraph").innerHTML = "";
                $("#AllApprovalGraph").css("text-align", "");
                $.ajax({
                    type: 'POST',
                    dataType: 'JSON',
                    contentType: 'application/json',
                    url: 'MyApproval_Home.aspx/DrawChartForAllApproval',
                    data: JSON.stringify({ EmployeeID: "<%=Session("intUserID").ToString%>" }),
                //async: false,
                success: function (Result) {
                    try {
                        document.getElementById("AllApprovalGraph").innerHTML = "";
                        objOverall = Result.d;
                        //Added By Vidya J ON 7 July 2016 For Pending Entity Count
                        GetAllCount1();
                        var Sum = jsonData1;
                        //End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count
                        var jsonData = JSON.parse(Result.d);

                        $.each(jsonData, function (id, obj) {
                             DrawPieChartForAllApproval(Result.d);

                            //Added By Vidya J ON 7 July 2016 For Pending Entity Count
                            var LeaveCountData = obj.LeaveCount;
                            if (LeaveCountData == null)
                            {
                                LeaveCountData = 0;
                            }
                            var ExpenseCountData = obj.ExpenseCount;
                          
                            if (ExpenseCountData == null) {
                                ExpenseCountData = 0;
                            }
                            var TimeSheetCountData = obj.TimeSheetCount;
                           
                            if (TimeSheetCountData == null) {
                                TimeSheetCountData = 0;
                            }
                            var EntityCountData = obj.EntityCount;
                          
                            if (EntityCountData == null) {
                                EntityCountData = 0;
                            }
                            var HelpDeskPendingData = obj.HelpDeskPending;
                        
                            if (HelpDeskPendingData == null) {
                                HelpDeskPendingData = 0;
                            }
                            //if (objLeaveRoleAccess == 0) {
                            //  LeaveCountData = 0;
                            //}
                     
                            //if (objExpenseRoleAccess == 0) {
                         
                            //     ExpenseCountData = 0;
                            //}
                            //if (objTimesheetRoleAccess == 0) {

                            //     TimeSheetCountData = 0;
                            //}
                            //if (objEntityRoleAccess == 0) {

                            //     EntityCountData = 0;
                            //}
                            //if (objHelpdeskRoleAccess == 0) {
                            //      HelpDeskPendingData = 0;
                            //}
                          
                            document.getElementById("spanOverAll").innerHTML = "(" + Sum + ")";
                            document.getElementById("spanEntityWorkFlowApproval").innerHTML = "(" + EntityCountData + ")";
                            document.getElementById("spanLeaveApproval").innerHTML = "(" + LeaveCountData + ")";
                            document.getElementById("spanResourceTimesheetApproval").innerHTML = "(" + TimeSheetCountData + ")";
                            document.getElementById("spanExpenseApproval").innerHTML = "(" + ExpenseCountData + ")";
                            document.getElementById("spanHelpDesk").innerHTML = "(" + HelpDeskPendingData + ")";
                            //End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count

                            document.getElementById("AllApprovalGraph").style.visibility = "visible";
                            document.getElementById("AllApprovalGraph").style.visibility = "visible";
                            document.getElementById("divNoAllApprovalGraph").style.display = "none"
                            //    if (obj.LeaveCount != 0 || obj.ExpenseCount != 0 || obj.TimeSheetCount != 0 || obj.EntityCount != 0 || obj.HelpDeskPending != 0) {

                            //        document.getElementById("AllApprovalGraph").style.visibility = "visible";
                            //        document.getElementById("divNoAllApprovalGraph").style.display = "none"
                            //    }
                            //    else {
                            //        document.getElementById("AllApprovalGraph").style.visibility = "hidden";
                            //        document.getElementById("divNoAllApprovalGraph").innerHTML = "No data to preview."
                            //        document.getElementById("divNoAllApprovalGraph").style.color = "#27408b"
                            //        document.getElementById("divNoAllApprovalGraph").style.height = "auto";
                            //        document.getElementById("divNoAllApprovalGraph").style.textAlign = "center"
                            //        document.getElementById("divNoAllApprovalGraph").style.width = "100%";
                            //        document.getElementById("divNoAllApprovalGraph").style.display = "inline-block"
                            //        document.getElementById("divNoAllApprovalGraph").style.marginTop = "111px";
                            //    }
                        });
                    }
                    catch (exception) {
                        if (arr.length > 0) {
                            $("#AllApprovalGraph").html('Something Went Wrong! The Graph was not Generated...');
                            $("#AllApprovalGraph").css("text-align", "center");
                        }
                        else {
                            $("#AllApprovalGraph").html('You Do Not Have Access');
                            $("#AllApprovalGraph").css("text-align", "center");
                        }
                    }

                    }, error: function (xhr) {
                    
                <%If Session("intUserID") Is Nothing Then%>
                        alert("Session Expired!");
                        //Commented By Reshma Chavan on 15 Jan 2021 For Unwanted alert display
              <%-- <%Else%>--%>
                    //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
                     //End of Commented By Reshma Chavan on 15 Jan 2021 For Unwanted alert display
                        <%End If%>
                    $("#AllApprovalGraph").html('Something Went Wrong! The Graph was not Generated...');
                    $("#AllApprovalGraph").css("text-align", "center");
                }
            });
        }


    function DrawPieChartForAllApproval(Result) {
         
            var dataSlices = [];
            var s1 = [];
            var dataLabels = "";
            var title = [];
            title[0] = "Leave";
            title[1] = "Expense";
            title[2] = "Timesheet";
            title[3] = "Entity";
            title[4] = "HelpDesk";

            $.each(JSON.parse(Result), function (id, obj) {
                 
                dataSlices.push([title[0], obj.LeaveCount], [title[1], obj.ExpenseCount], [title[2], obj.TimeSheetCount], [title[3], obj.EntityCount], [title[4], obj.HelpDeskPending]);
               
                //$("#LeaveCount").text(title[0] + " : " + obj.LeaveCount)       
                //$("#ExpenseCount").text(title[1] + " : " + obj.ExpenseCount)
                //$("#TimeSheetCount").text(title[2] + " : " + obj.TimeSheetCount)
                //$("#EntityCount").text(title[3] + " : " + obj.EntityCount)
                //dataLabels = dataLabels + obj.TimePerc;
               // document.getElementById('.spanEntityWorkFlowApproval').innerHTML = EntityCountData;
                 
                //Added by Tejas Rasage on 09-March-2016
                $("#LeaveCount").text(title[0] + " : " + obj.LeaveCount)
                $("#ExpenseCount").text(title[1] + " : " + obj.ExpenseCount)
                $("#TimeSheetCount").text(title[2] + " : " + obj.TimeSheetCount)
                $("#EntityCount").text(title[3] + " : " + obj.EntityCount)
                //s1.push(['Leave', obj.LeaveCount], ['Expense', obj.ExpenseCount], ['TimeSheet', obj.TimeSheetCount], ['Entity', obj.EntityCount], ['HelpDesk', obj.HelpDeskPending])
                //End of Added by Tejas Rasage on 09-March-2016


                if (objLeaveRoleAccess == 1) {
                    s1.push(['Leave', obj.LeaveCount])
                }
                if (objExpenseRoleAccess == 1) {
                    s1.push(['Expense', obj.ExpenseCount])
                }
                if (objTimesheetRoleAccess == 1) {
                    s1.push(['TimeSheet', obj.TimeSheetCount])
                }
                if (objEntityRoleAccess == 1) {
                    s1.push(['Entity', obj.EntityCount])
                }
                if (objHelpdeskRoleAccess == 1) {
                    s1.push(['HelpDesk', obj.HelpDeskPending])
                }

            });
            //Added by Tejas Rasage on 09-March-2016
            $.jqplot.config.enablePlugins = true;

            //var s1 = [2, 6, 7];
            // var ticks = ['Leave', 'Expense', 'TimeSheet', 'Entity', 'HelpDesk'];

            plot1 = $.jqplot('AllApprovalGraph', [s1], {
                // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
                animate: !$.jqplot.use_excanvas,
                seriesDefaults: {
                    renderer: $.jqplot.BarRenderer,

                    pointLabels: { show: true },
                    rendererOptions: { barWidth: 40 }
                },
                series: [{ label: 'Pending' }],
                seriesColors: ["#FF0000"],
                axes: {
                    xaxis: {
                        renderer: $.jqplot.CategoryAxisRenderer,
                        // ticks: ticks
                    }
                }, legend: {
                    show: true,
                    location: 's',
                    placement: 'outside',
                    marginLeft: 300
                },
                cursor: { style: 'pointer', show: true, showTooltip: false }
            });
            //End of Added by Tejas Rasage on 09-March-2016
            //Added by Tejas Rasage on 09-March-2016

            //End of Added by Tejas Rasage on 09-March-2016
            //Commented by Tejas Rasage on 09-March-2016
            //     options = {
            //         gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
            //         seriesDefaults: {
            //             renderer: $.jqplot.PieRenderer,
            //             trendline: { show: false },
            //             rendererOptions: {
            //                 padding: 8, showDataLabels: true,
            //                 dataLabels: 'value',
            //                 dataLabelFormatString: '%.0f'
            //             }
            //         },
            //         grid: {
            //             drawBorder: false,
            //             drawGridlines: false,
            //             background: '#ffffff',
            //             shadow: false
            //         },
            //         seriesColors: ["#E51F30", "#0171D0", "#5DA934", "#9234A9"],
            //         highlightColors: ["white", "white"],
            //         legend: {
            //             show: true,
            //             //placement: 'outside',
            //             rendereroptions: {
            //                 numberrows: 1
            //             },
            //             location: 'e',
            //         },
            //     }
            //     var plot = $.jqplot('AllApprovalGraph', [dataSlices], options);

            //     dataSlices = [];
            //     dataLabels = "";
            //     $('#AllApprovalGraph').css("cursor", "pointer");
            //     $('#AllApprovalGraph').bind('jqplotDataClick',
            //    function (ev, seriesIndex, pointIndex, data) {
            //        $("#tblleaveGraph").css("display", "none");
            //        $("#tblEntityGraph").css("display", "none");
            //        $("#tblExpenseGraph").css("display", "none");
            //        $("#tblTimesheetGraph").css("display", "none");
            //        var mode = String(data);
            //        mode = mode.split(",")
            //        if (mode[0] == "Leave") {
            //            $("#tblleaveGraph").css("display", "block");
            //            DrawPieChartForLeaveApprovalAction();
            //            //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0px"
            //            document.getElementById("GraphHeaderLeave").style.left = intPosition + "px";
            //        }
            //        if (mode[0] == "Expense") {
            //            $("#tblExpenseGraph").css("display", "block");
            //            DrawPieChartForExpenseApprovalAction();
            //            //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0px"
            //            document.getElementById("GraphHeaderExpense").style.left = intPosition + "px";
            //        }
            //        if (mode[0] == "Timesheet") {
            //            $("#tblTimesheetGraph").css("display", "block");
            //            DrawPieChartForTimesheetApprovalAction();
            //            //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0px"
            //            document.getElementById("GraphHeaderTimesheet").style.left = intPosition + "px";
            //        }
            //        if (mode[0] == "Entity") {
            //            $("#tblEntityGraph").css("display", "block");
            //            DrawPieChartForEntityApprovalAction();
            //            //document.getElementById("tblAllApprovalGraph").style.marginBottom = "25%"
            //            document.getElementById("GraphHeaderEntity").style.left = intPosition + "px";
            //        }
            //    }
            //);

            //     $("#AllApprovalGraph .jqplot-table-legend").css("right", "9px");
            //     $("#AllApprovalGraph canvas").each(function (id, val) {
            //         if (id == 2) {
            //             $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            //             $(this).css("background-size", "390px,342px");
            //         }
            //     });
            //End of Commented by Tejas Rasage on 09-March-2016
        }

        function DrawRoleAccessAllApprovalGraph() {

            $.ajax({
                type: 'POST',
                url: 'MyApproval_Home.aspx/DrawChartForOverallPendingRequest',
                dataType: 'json',
                data: JSON.stringify({ EmployeeID: '<%=Session("intUserID")%>' }),
                contentType: 'application/json;charset-utf=8',
                async: false,
                success: function (Result) {
                     $.each(JSON.parse(Result.d), function (id, obj) {
                        objLeaveRoleAccess = obj.LeaveRoleAccess
                        objExpenseRoleAccess = obj.ExpenseRoleAccess
                        objTimesheetRoleAccess = obj.TimesheetRoleAccess
                        objEntityRoleAccess = obj.EntityRoleAccess
                        objHelpdeskRoleAccess = obj.HelpdeskRoleAccess
                        objResourceTimesheetAccess = obj.ResourceTimesheetAccess;
                        objProjectTimesheetAccess = obj.ProjectTimesheetAccess;
                        if (objLeaveRoleAccess == 1) {
                            arr.push(["Leave"]);

                        }
                        else { $("#divLeaveApproval").parent().parent().css("display", "none"); }
                        if (objExpenseRoleAccess == 1) {
                            arr.push(["Expense"]);

                        }
                        else { $("#divExpenseApproval").parent().parent().css("display", "none"); }
                        if (objTimesheetRoleAccess == 1) {
                            arr.push(["Timesheet"]);

                        }
                        else { $("#divResourceTimesheetApproval").parent().parent().css("display", "none"); }
                        if (objEntityRoleAccess == 1) {
                            arr.push(["Entity"]);

                        }
                        else { $("#divEntityWorkFlowApproval").parent().parent().css("display", "none"); }
                        if (objHelpdeskRoleAccess == 1) {
                            arr.push(["HelpDesk"]);

                        } else { $("#divHelpDesk").parent().parent().css("display", "none"); }


                    });
                }
            });
        }


    function PendingProjectApproval() {
           $("#ResourceTimesheetApprovalgrid").GridUnload();
            $.ajax({
                url: path + "getPendingProjectTimesheet",
                //COMMENTED AND ADDED BY Vaijat K  ON 22/3/2016 FOR GENERATE PK TOKEN
                // data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
                data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
                //ended
                dataType: "jsonp",
                type: "GET",
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    try {
                        $("#ResourceTimesheetApprovalgrid").GridUnload();
                        var JSONdata = JSON.parse(result);
                        if (JSONdata.length > 0) {
                            $("#divnoDataToPreview").css("display", "none");
                            $("#divnoDataToPreview").parent().css("box-shadow", "none")
                        }
                        else {
                            $("#divnoDataToPreview").css("display", "block");
                            $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                        }
                        jQuery("#ResourceTimesheetApprovalgrid").jqGrid({
                            datatype: "local",
                            data: JSON.parse(result),
                            colNames: ['TimeSheetID', 'Project Name', 'Project ID', 'Status Description', 'FromDate', 'ToDate', 'Actual Work'],
                            colModel: [{ name: 'TimeSheetNo', align: 'center', index: 'TimeSheetNo', hidden: true },
                            { name: 'ProjectName', index: 'ProjectName', align: 'center', width: 40 },
                            { name: 'ProjectID', align: 'center', index: 'ProjectID', hidden: true },
                            { name: 'TimesheetStatus', index: 'TimesheetStatus', align: 'center', width: 40 },
                            { name: 'Fromdate', index: 'Fromdate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" }, width: 40 },
                            { name: 'ToDate', index: 'ToDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" }, width: 40 },
                            { name: 'TotalTimeSheetHours', index: 'TotalTimeSheetHours', align: 'center', width: 40 }],
                            rowNum: 05,
                            autoencode: true,
                            rowList: [5, 10, 20, 50, 100],
                            sortname: 'TimeSheetNo',
                            pager: jQuery('#onResourceTimesheetApprovalpagging'),
                            sortorder: "asc",
                            viewrecords: true,
                            multiselect: true,
                            loadComplete: function () {
                                $(this).find(">tbody>tr.jqgrow:odd").addClass("clsTRRowEven");
                                $(this).find(">tbody>tr.jqgrow:even").addClass("clsTRRowOdd");
                                //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable>thead").addClass("clsTRColumnHeader");
                                //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").addClass("clsGridTable");
                                //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").removeClass("ui-jqgrid-htable");
                            },
                            onSelectRow: function (rowId, col, content, e) {
                                var myGrid = $('#ResourceTimesheetApprovalgrid')
                                var selRowId = myGrid.jqGrid('getGridParam', 'selrow')
                                var TSID = myGrid.jqGrid('getCell', selRowId, 'TimeSheetNo')
                                if (TSID) {
                                    ExpenseApprovalpass = { intUserID: '<%=Session("intUserID")%>', TimesheetNo: TSID, isProject: 2 };
                            ShowTimesheetApprovalDetails();
                        }
                        else {
                            ExpenseApprovalpass = {};
                            document.getElementById("MyProfileTimesheet").style.display = "none"
                        }

                            // ExpenseApprovalDetails();
                        }, gridComplete: function () {
                            $("#ResourceTimesheetApprovalgrid").setSelection('1');
                            $("#cb_ResourceTimesheetApprovalgrid").click(function () {
                                var myGrid = $('#ResourceTimesheetApprovalgrid')
                                var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                                if (selRowId.length > 1) {
                                    $("#MyProfileTimesheet").find(".margin").find(".btn").css("visibility", "hidden");
                                }
                                else if (selRowId.length == 0) {
                                    $("#MyProfileTimesheet").css("display", "none");
                                }
                                else {
                                    $("#MyProfileTimesheet").find(".margin").find(".btn").css("visibility", "");
                                }
                            });
                        }
                        //caption:"Timesheet Approval",

                    });
            }
                    catch (exception) {
                        $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
                        document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                        $("#ResourceTimesheetApprovalgrid").GridUnload();
                    }
                },
                error: function (xhr) {
                    $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
                    document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                    $("#ResourceTimesheetApprovalgrid").GridUnload();
                }
            });

}

/**********Leave Approval Graph**********/

function DrawPieChartForLeaveApprovalAction() {
    $("#leaveGraph").css("text-align", "");
    $("#leaveGraph").html('');
    $.ajax({
        type: 'POST',
        dataType: 'JSON',
        contentType: 'application/json',
        url: 'MyApproval_Home.aspx/DrawChartForLeaveApproval',
        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID").ToString%>" }),
            //async:false,
            success: function (Result) {
                try {
                    objLeave = Result.d;
                    var jsonData = JSON.parse(Result.d)
                    $.each(jsonData, function (id, obj) {
                        //document.getElementById("leaveGraph").style.width = "297px"
                        DrawPieChartForLeaveApproval(Result.d);
                        if (obj.LeaveCountSubmitted != 0 || obj.LeaveCountApproved != 0) {
                            $("#divNoLeaveGraph").parent().css("box-shadow", "none");
                            document.getElementById("leaveGraph").style.visibility = "visible";
                            document.getElementById("divNoLeaveGraph").style.display = "none"

                        }
                        else {
                            $("#divNoLeaveGraph").parent().css("box-shadow", "1px 1px 1px 1px #CCC");
                            document.getElementById("leaveGraph").style.visibility = "hidden";
                            document.getElementById("divNoLeaveGraph").innerHTML = "No data to preview."
                            document.getElementById("divNoLeaveGraph").style.color = "#27408b"
                            document.getElementById("divNoLeaveGraph").style.height = "auto";
                            document.getElementById("divNoLeaveGraph").style.textAlign = "center"
                            document.getElementById("divNoLeaveGraph").style.width = "100%";
                            document.getElementById("divNoLeaveGraph").style.display = "inline-block"
                            document.getElementById("divNoLeaveGraph").style.position = "relative";
                            document.getElementById("divNoLeaveGraph").style.top = "100px";
                        }
                    });
                }
                catch (exception) {
                    if (arr.length > 0) {
                        $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
                        $("#leaveGraph").css("text-align", "center");
                    }
                    else {
                        $("#leaveGraph").html('You Do Not Have Access');
                        $("#leaveGraph").css("text-align", "center");
                    }
                }
                var display = $("#GraphHeaderLeave");
                display.text("Leave");
            },
            error: function (xhr) {
                <%If Session("intUserID") Is Nothing Then%>
            alert("Session Expired!");
               <%Else%>
            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
            $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
            $("#leaveGraph").css("text-align", "center");
        }
        });
}

function DrawPieChartForLeaveApproval(Result) {
    var dataSlices = [];

    var dataLabels = "";
    var title = [];
    title[0] = "Pending";
    title[1] = "Approved";


    $.each(JSON.parse(Result), function (id, obj) {
        if (obj.LeaveCountSubmitted == null) {
            obj.LeaveCountSubmitted = 0;
        }
        if (obj.LeaveCountApproved == null) {
            obj.LeaveCountApproved = 0;
        }
        dataSlices.push([title[0], obj.LeaveCountSubmitted], [title[1], obj.LeaveCountApproved]);
        //$("#LeaveCount").text(title[0] + " : " + obj.LeaveCount)       
        //$("#ExpenseCount").text(title[1] + " : " + obj.ExpenseCount)
        //$("#TimeSheetCount").text(title[2] + " : " + obj.TimeSheetCount)
        //$("#EntityCount").text(title[3] + " : " + obj.EntityCount)
        //dataLabels = dataLabels + obj.TimePerc;                
    });

    options = {
        gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
        seriesDefaults: {
            renderer: $.jqplot.PieRenderer,
            trendline: { show: false },
            rendererOptions: {
                padding: 0, showDataLabels: true,
                dataLabels: 'value',
                dataLabelFormatString: '%.0f',
                dataLabelThreshold: 1
            }
        },
        grid: {
            drawBorder: false,
            drawGridlines: false,
            background: '#ffffff',
            shadow: false
        },
        seriesColors: ["#ff0000", "#009900"],
        highlightColors: ["white", "white"],
        legend: {
            show: true,
            //placement: 'outside',
            rendereroptions: {
                numberrows: 1
            },
            location: 'e',
        }
    }
    document.getElementById("leaveGraph").innerHTML = "";
    var plot = $.jqplot('leaveGraph', [dataSlices], options);
    dataSlices = [];
    dataLabels = "";
    $("#leaveGraph .jqplot-table-legend").css("right", "9px");
    $("#leaveGraph canvas").each(function (id, val) {
        if (id == 2) {
            //    if ($("#leaveGraph").height() == 300) {
            //        //$(this).height(286);
            //        this.height = "268";
            //    }
            //    else if ($("#leaveGraph").height() == 210) {
            //        //$(this).height(200);
            //        this.height = "187";
            //    }
            //    else if ($("#leaveGraph").height() == 190) {
            //        this.height = "168";
            //        //$(this).height(179);
            //    }
            $(this).height("86%");
            $(this).width("100%");
            $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            $(this).css("background-size", "100%,100%");
            $(this).css("background-repeat", " no-repeat");
        }
    });
};

/**********Entity Approval Graph**********/

function DrawPieChartForEntityApprovalAction() {
    $("#leaveGraph").css("text-align", "");
    $("#leaveGraph").html('');
    $.ajax({
        type: 'POST',
        dataType: 'JSON',
        contentType: 'application/json',
        url: 'MyApproval_Home.aspx/DrawChartForEntityApproval',
        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID").ToString%>" }),
            //async: false,
            success: function (Result) {
                try {
                    var jsonData = JSON.parse(Result.d)
                    $.each(jsonData, function (id, obj) {
                        //document.getElementById("leaveGraph").style.width = "319px"
                        objentity = Result.d;
                        DrawPieChartForEntityApproval(Result.d);
                        if (obj.ProjectCount != 0 || obj.SubProjectCount != 0 || obj.MileStoneCount != 0 || obj.ModuleCount != 0 || obj.DeliverableCount != 0 || obj.ChangeRequestCount != 0) {
                            $("#divNoLeaveGraph").parent().css("box-shadow", "none");
                            document.getElementById("leaveGraph").style.visibility = "visible";
                            document.getElementById("divNoLeaveGraph").style.display = "none"

                        }
                        else {
                            $("#divNoLeaveGraph").parent().css("box-shadow", "1px 1px 1px 1px #CCC");
                            document.getElementById("leaveGraph").style.visibility = "hidden";
                            document.getElementById("divNoLeaveGraph").innerHTML = "No data to preview."
                            document.getElementById("divNoLeaveGraph").style.color = "#27408b"
                            document.getElementById("divNoLeaveGraph").style.height = "auto";
                            document.getElementById("divNoLeaveGraph").style.textAlign = "center"
                            document.getElementById("divNoLeaveGraph").style.width = "100%";
                            document.getElementById("divNoLeaveGraph").style.display = "inline-block"
                            document.getElementById("divNoLeaveGraph").style.position = "relative";
                            document.getElementById("divNoLeaveGraph").style.top = "100px";
                        }
                    });
                }
                catch (exception) {
                    if (arr.length > 0) {
                        $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
                        $("#leaveGraph").css("text-align", "center");
                    }
                    else {
                        $("#leaveGraph").html('You Do Not Have Access');
                        $("#leaveGraph").css("text-align", "center");
                    }
                }
                var display = $("#GraphHeaderLeave");
                display.text("Entity");
            },
            error: function (xhr) {
            <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
               <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>

                $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
                $("#leaveGraph").css("text-align", "center");
            }
        });
    }

    function DrawPieChartForEntityApproval(Result) {
        var dataSlices = [];

        var dataLabels = "";
        var title = [];
        title[0] = "Project";
        title[1] = "SubProject";
        title[2] = "Milestone";
        title[3] = "Module";
        title[4] = "Deliverable";
        title[5] = "Change Request";


        $.each(JSON.parse(Result), function (id, obj) {
            if (obj.ProjectCount == null) {
                obj.ProjectCount = 0;
            }
            if (obj.SubProjectCount == null) {
                obj.SubProjectCount = 0;
            }
            if (obj.MileStoneCount == null) {
                obj.MileStoneCount = 0;
            }
            if (obj.ModuleCount == null) {
                obj.ModuleCount = 0;
            }
            if (obj.DeliverableCount == null) {
                obj.DeliverableCount = 0;
            }
            if (obj.ChangeRequestCount == null) {
                obj.ChangeRequestCount = 0;
            }
            dataSlices.push([title[0], obj.ProjectCount], [title[1], obj.SubProjectCount], [title[2], obj.MileStoneCount], [title[3], obj.ModuleCount], [title[4], obj.DeliverableCount], [title[5], obj.ChangeRequestCount]);

        });

        options = {
            gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
            seriesDefaults: {
                renderer: $.jqplot.PieRenderer,
                trendline: { show: false },
                rendererOptions: {
                    padding: 0, showDataLabels: true,
                    dataLabels: 'value',
                    dataLabelFormatString: '%.0f',
                    dataLabelThreshold: 1
                }
            },
            grid: {
                drawBorder: false,
                drawGridlines: false,
                background: '#FFFFFF',
                shadow: false
            },
            seriesColors: ["#02CFE1", "#7E8EA7", "#ffff99", "#3384ff", "#ffad33", "#661aff"],
            highlightColors: ["white", "white"],
            legend: {
                show: true,
                //placement: 'outside',
                rendereroptions: {
                    numberrows: 1
                },
                location: 'e',
            }
        }
        document.getElementById("leaveGraph").innerHTML = "";
        // var plot = $.jqplot('EntityGraph', [dataSlices], options);
        var plot = $.jqplot('leaveGraph', [dataSlices], options);

        dataSlices = [];
        dataLabels = "";

        //$("#EntityGraph .jqplot-table-legend").css("right", "9px");
        //$("#EntityGraph canvas").each(function (id, val) {
        //    if (id == 2) {
        //        $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
        //        $(this).css("background-size", "391px,342px");
        //        $(this).css("background-repeat", " no-repeat");
        //    }
        //});
        $("#leaveGraph .jqplot-table-legend").css("right", "9px");
        $("#leaveGraph canvas").each(function (id, val) {
            if (id == 2) {
                //if ($("#leaveGraph").height() == 300) {
                //    //$(this).height(286);
                //    this.height = "268";
                //}
                //else if ($("#leaveGraph").height() == 210) {
                //    //$(this).height(200);
                //    this.height = "187";
                //}
                //else if ($("#leaveGraph").height() == 190) {
                //    this.height = "168";
                //    //$(this).height(179);
                //}
                $(this).height("86%");
                $(this).width("100%");
                $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
                $(this).css("background-size", "100%,100%");
                $(this).css("background-repeat", " no-repeat");
            }
        });
    };


    /**********Expense Approval Graph**********/

    function DrawPieChartForExpenseApprovalAction() {
        $("#leaveGraph").css("text-align", "");
        $("#leaveGraph").html('');
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'MyApproval_Home.aspx/DrawChartForExpenseApproval',
            data: JSON.stringify({ EmployeeID: "<%=Session("intUserID").ToString%>" }),
        //async: false,
        success: function (Result) {
            try {
                objExpense = Result.d;
                var jsonData = JSON.parse(Result.d)
                $.each(jsonData, function (id, obj) {
                    //document.getElementById("leaveGraph").style.width = "297px"
                    DrawPieChartForExpenseApproval(Result.d);
                    if (obj.ExpensePending != 0 || obj.ExpenseApproved != 0) {
                        $("#divNoLeaveGraph").parent().css("box-shadow", "none");
                        document.getElementById("leaveGraph").style.visibility = "visible";
                        document.getElementById("divNoLeaveGraph").style.display = "none"

                    }
                    else {
                        $("#divNoLeaveGraph").parent().css("box-shadow", "1px 1px 1px 1px #CCC");
                        document.getElementById("leaveGraph").style.visibility = "hidden";
                        document.getElementById("divNoLeaveGraph").innerHTML = "No data to preview."
                        document.getElementById("divNoLeaveGraph").style.color = "#27408b"
                        document.getElementById("divNoLeaveGraph").style.height = "auto";
                        document.getElementById("divNoLeaveGraph").style.textAlign = "center"
                        document.getElementById("divNoLeaveGraph").style.width = "100%";
                        document.getElementById("divNoLeaveGraph").style.display = "inline-block"
                        document.getElementById("divNoLeaveGraph").style.position = "relative";
                        document.getElementById("divNoLeaveGraph").style.top = "100px";
                    }
                });
            }
            catch (exception) {
                if (arr.length > 0) {
                    $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
                    $("#leaveGraph").css("text-align", "center");
                }
                else {
                    $("#leaveGraph").html('You Do Not Have Access');
                    $("#leaveGraph").css("text-align", "center");
                }
            }
            var display = $("#GraphHeaderLeave");
            display.text("Expense");
        },
        error: function (xhr) {
           <%If Session("intUserID") Is Nothing Then%>
            alert("Session Expired!");
               <%Else%>
            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
            $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
            $("#leaveGraph").css("text-align", "center");

        }
    });
}

function DrawPieChartForExpenseApproval(Result) {
    var dataSlices = [];

    var dataLabels = "";
    var title = [];
    title[0] = "Approved";
    title[1] = "Pending";


    $.each(JSON.parse(Result), function (id, obj) {
        if (obj.ExpensePending == null) {
            obj.ExpensePending = 0;
        }
        if (obj.ExpenseApproved == null) {
            obj.ExpenseApproved = 0;
        }
        dataSlices.push([title[1], obj.ExpensePending], [title[0], obj.ExpenseApproved]);

    });

    options = {
        gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
        seriesDefaults: {
            renderer: $.jqplot.PieRenderer,
            trendline: { show: false },
            rendererOptions: {
                padding: 0, showDataLabels: true,
                dataLabels: 'value',
                dataLabelFormatString: '%.0f',
                dataLabelThreshold: 1
            }
        },
        grid: {
            drawBorder: false,
            drawGridlines: false,
            background: '#ffffff',
            shadow: false
        },
        seriesColors: ["#ff0000", "#009900"],
        highlightColors: ["white", "white"],
        legend: {
            show: true,
            //placement: 'outside',
            rendereroptions: {
                numberrows: 1
            },
            location: 'e',
        }
    }
    document.getElementById("leaveGraph").innerHTML = "";
    //var plot = $.jqplot('ExpenseGraph', [dataSlices], options);
    var plot = $.jqplot('leaveGraph', [dataSlices], options);

    dataSlices = [];
    dataLabels = "";

    //$("#ExpenseGraph .jqplot-table-legend").css("right", "9px");
    //$("#ExpenseGraph canvas").each(function (id, val) {
    //    if (id == 2) {
    //        $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
    //        $(this).css("background-size", "365px,342px");
    //        $(this).css("background-repeat", " no-repeat");
    //    }
    //});
    $("#leaveGraph .jqplot-table-legend").css("right", "9px");
    $("#leaveGraph canvas").each(function (id, val) {
        if (id == 2) {
            //if ($("#leaveGraph").height() == 300) {
            //    //$(this).height(286);
            //    this.height = "268";
            //}
            //else if ($("#leaveGraph").height() == 210) {
            //    //$(this).height(200);
            //    this.height = "187";
            //}
            //else if ($("#leaveGraph").height() == 190) {
            //    this.height = "168";
            //    //$(this).height(179);
            //}
            $(this).height("86%");
            $(this).width("100%");
            $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            $(this).css("background-size", "100%,100%");
            $(this).css("background-repeat", " no-repeat");
        }
    });
};


/**********Timesheet Approval Graph**********/

function DrawPieChartForTimesheetApprovalAction() {
    $("#leaveGraph").css("text-align", "");
    $("#leaveGraph").html('');
    $.ajax({
        type: 'POST',
        dataType: 'JSON',
        contentType: 'application/json',
        url: 'MyApproval_Home.aspx/DrawChartForTimesheetApproval',
        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID").ToString%>" }),
        //async: false,
        success: function (Result) {
            try {
                objTimesheet = Result.d;
                var jsonData = JSON.parse(Result.d)
                $.each(jsonData, function (id, obj) {
                    //document.getElementById("leaveGraph").style.width = "297px"
                    DrawPieChartForTimesheetApproval(Result.d);
                    if (obj.ResourceTimeSheetCount == null || objResourceTimesheetAccess != 1) {
                        obj.ResourceTimeSheetCount = 0;
                    }
                    if (obj.ProjectTimeSheetCount == null || objProjectTimesheetAccess != 1) {
                        obj.ProjectTimeSheetCount = 0;
                    }
                    //if ((obj.ResourceTimeSheetCount != 0 && obj.ResourceTimeSheetCount != null) || (obj.ProjectTimeSheetCount != 0 && obj.ProjectTimeSheetCount != null)) {
                    if (obj.ResourceTimeSheetCount != 0 || obj.ProjectTimeSheetCount != 0) {
                        $("#divNoLeaveGraph").parent().css("box-shadow", "none");
                        document.getElementById("leaveGraph").style.visibility = "visible";
                        document.getElementById("divNoLeaveGraph").style.display = "none"
                    }
                    else {
                        $("#divNoLeaveGraph").parent().css("box-shadow", "1px 1px 1px 1px #CCC");
                        document.getElementById("leaveGraph").style.visibility = "hidden";
                        document.getElementById("divNoLeaveGraph").innerHTML = "No data to preview."
                        document.getElementById("divNoLeaveGraph").style.color = "#27408b"
                        document.getElementById("divNoLeaveGraph").style.height = "auto";
                        document.getElementById("divNoLeaveGraph").style.textAlign = "center"
                        document.getElementById("divNoLeaveGraph").style.width = "100%";
                        document.getElementById("divNoLeaveGraph").style.display = "inline-block"
                        document.getElementById("divNoLeaveGraph").style.position = "relative";
                        document.getElementById("divNoLeaveGraph").style.top = "100px";
                    }
                });
            }
            catch (exception) {
                if (arr.length > 0) {
                    $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
                    $("#leaveGraph").css("text-align", "center");
                }
                else {
                    $("#leaveGraph").html('You Do Not Have Access');
                    $("#leaveGraph").css("text-align", "center");
                }
            }
            var display = $("#GraphHeaderLeave");
            display.text("Timesheet");
        },
        error: function (xhr) {
             <%If Session("intUserID") Is Nothing Then%>
            alert("Session Expired!");
             <%Else%>
            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
             <%End If%>

            $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
            $("#leaveGraph").css("text-align", "center");
        }
    });
}

function DrawPieChartForTimesheetApproval(Result) {
    var dataSlices = [];

    var dataLabels = "";
    var title = [];
    title[0] = "Resource TimeSheet";
    title[1] = "Project TimeSheet";


    $.each(JSON.parse(Result), function (id, obj) {
        if (obj.ResourceTimeSheetCount == null) {
            obj.ResourceTimeSheetCount = 0;
        }
        if (obj.ProjectTimeSheetCount == null) {
            obj.ProjectTimeSheetCount = 0;
        }
        if (objResourceTimesheetAccess == 1)
            dataSlices.push([title[0], obj.ResourceTimeSheetCount]);
        if (objProjectTimesheetAccess == 1)
            dataSlices.push([title[1], obj.ProjectTimeSheetCount]);
        //dataSlices.push([title[0], obj.ResourceTimeSheetCount], [title[1], obj.ProjectTimeSheetCount]);

    });

    options = {
        gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
        seriesDefaults: {
            renderer: $.jqplot.PieRenderer,
            trendline: { show: false },
            rendererOptions: {
                padding: 0, showDataLabels: true,
                dataLabels: 'value',
                dataLabelFormatString: '%.0f',
                dataLabelThreshold: 1
            }
        },
        grid: {
            drawBorder: false,
            drawGridlines: false,
            background: '#ffffff',
            shadow: false
        },
        seriesColors: ["#02CFE1", "#7E8EA7"],
        highlightColors: ["white", "white"],
        legend: {
            show: true,
            //placement: 'outside',
            rendereroptions: {
                numberrows: 1
            },
            location: 'e',
        }
    }
    document.getElementById("leaveGraph").innerHTML = "";
    //var plot = $.jqplot('TimesheetGraph', [dataSlices], options);
    var plot = $.jqplot('leaveGraph', [dataSlices], options);

    dataSlices = [];
    dataLabels = "";

    //$("#TimesheetGraph .jqplot-table-legend").css("right", "9px");
    //$("#TimesheetGraph canvas").each(function (id, val) {
    //    if (id == 2) {
    //        $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
    //        $(this).css("background-size", "421px,342px");
    //        $(this).css("background-repeat", " no-repeat");
    //    }
    //});
    $("#leaveGraph .jqplot-table-legend").css("right", "9px");
    $("#leaveGraph canvas").each(function (id, val) {
        if (id == 2) {
            //if ($("#leaveGraph").height() == 300) {
            //    //$(this).height(286);
            //    this.height = "268";
            //}
            //else if ($("#leaveGraph").height() == 210) {
            //    //$(this).height(200);
            //    this.height = "187";
            //}
            //else if ($("#leaveGraph").height() == 190) {
            //    this.height = "168";
            //    //$(this).height(179);
            //}
            $(this).height("86%");
            $(this).width("100%");
            $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            $(this).css("background-size", "100%,100%");
            $(this).css("background-repeat", " no-repeat");
        }
    });
};

//Added By Vaijat K ON 10/03/2016 For Helpdesk Approval Graph

function DrawPieChartForHelpDeskApprovalAction() {
    $("#leaveGraph").css("text-align", "");
    $("#leaveGraph").html('');
    $.ajax({
        type: 'POST',
        dataType: 'JSON',
        contentType: 'application/json',
        url: 'MyApproval_Home.aspx/GetHeplDeskApprovalDataCount',
        data: JSON.stringify({ intUserID: "<%=Session("intUserID").ToString%>" }),
            //async: false,
            success: function (Result) {
                try {
                    objHelpdesk = Result.d;
                    var jsonData = JSON.parse(Result.d)
                    $.each(jsonData, function (id, obj) {
                        //document.getElementById("leaveGraph").style.width = "297px"
                        DrawPieChartForHelpDeskApproval(Result.d);
                        if (obj.HelpDeskPending != 0 || obj.HelpDeskApproved != 0) {
                            $("#divNoLeaveGraph").parent().css("box-shadow", "none");
                            document.getElementById("leaveGraph").style.visibility = "visible";
                            document.getElementById("divNoLeaveGraph").style.display = "none"

                        }
                        else {
                            $("#divNoLeaveGraph").parent().css("box-shadow", "1px 1px 1px 1px #CCC");
                            document.getElementById("leaveGraph").style.visibility = "hidden";
                            document.getElementById("divNoLeaveGraph").innerHTML = "No data to preview."
                            document.getElementById("divNoLeaveGraph").style.color = "#27408b"
                            document.getElementById("divNoLeaveGraph").style.height = "auto";
                            document.getElementById("divNoLeaveGraph").style.textAlign = "center"
                            document.getElementById("divNoLeaveGraph").style.width = "100%";
                            document.getElementById("divNoLeaveGraph").style.display = "inline-block"
                            document.getElementById("divNoLeaveGraph").style.position = "relative";
                            document.getElementById("divNoLeaveGraph").style.top = "100px";
                        }
                    });
                }
                catch (exception) {
                    if (arr.length > 0) {
                        $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
                        $("#leaveGraph").css("text-align", "center");
                    }
                    else {
                        $("#leaveGraph").html('You Do Not Have Access');
                        $("#leaveGraph").css("text-align", "center");
                    }
                }
                var display = $("#GraphHeaderLeave");
                display.text("Helpdesk");
            },
            error: function (xhr) {
                   <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
               <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>

                $("#leaveGraph").html('Something Went Wrong! The Graph was not Generated...');
                $("#leaveGraph").css("text-align", "center");
            }
        });
    }

    function DrawPieChartForHelpDeskApproval(Result) {
        var dataSlices = [];

        var dataLabels = "";
        var title = [];
        title[0] = "Approved";
        title[1] = "Pending";


        $.each(JSON.parse(Result), function (id, obj) {
            if (obj.HelpDeskApproved == null) {
                obj.HelpDeskApproved = 0;
            }
            if (obj.HelpDeskPending == null) {
                obj.HelpDeskPending = 0;
            }
            dataSlices.push([title[0], obj.HelpDeskApproved], [title[1], obj.HelpDeskPending]);

        });

        options = {
            gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
            seriesDefaults: {
                renderer: $.jqplot.PieRenderer,
                trendline: { show: false },
                rendererOptions: {
                    padding: 0, showDataLabels: true,
                    dataLabels: 'value',
                    dataLabelFormatString: '%.0f',
                    dataLabelThreshold: 1
                }
            },
            grid: {
                drawBorder: false,
                drawGridlines: false,
                background: '#ffffff',
                shadow: false
            },
            seriesColors: ["#009900", "#ff0000"],
            highlightColors: ["white", "white"],
            legend: {
                show: true,
                //placement: 'outside',
                rendereroptions: {
                    numberrows: 1
                },
                location: 'e',
            }
        }
        document.getElementById("leaveGraph").innerHTML = "";
        //var plot = $.jqplot('TimesheetGraph', [dataSlices], options);
        var plot = $.jqplot('leaveGraph', [dataSlices], options);

        dataSlices = [];
        dataLabels = "";

        //$("#TimesheetGraph .jqplot-table-legend").css("right", "9px");
        //$("#TimesheetGraph canvas").each(function (id, val) {
        //    if (id == 2) {
        //        $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
        //        $(this).css("background-size", "421px,342px");
        //        $(this).css("background-repeat", " no-repeat");
        //    }
        //});
        $("#leaveGraph .jqplot-table-legend").css("right", "9px");
        $("#leaveGraph canvas").each(function (id, val) {
            if (id == 2) {
                //if ($("#leaveGraph").height() == 300) {
                //    //$(this).height(286);
                //    this.height = "268";
                //}
                //else if ($("#leaveGraph").height() == 210) {
                //    //$(this).height(200);
                //    this.height = "187";
                //}
                //else if ($("#leaveGraph").height() == 190)
                //{
                //    this.height = "168";
                //    //$(this).height(179);
                //}
                $(this).height("86%");
                $(this).width("100%");
                $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
                $(this).css("background-size", "100%,100%");
                $(this).css("background-repeat", " no-repeat");
            }
        });
    };
    //End Of Addition Vaijat K

    //Added By Vaijat K ON 04/03/2016 For Showing Pending HelpDesk Request in Table
    function PendingHelpDeskApproval() {
        $("#tblHelpDeskApproval").GridUnload();
        $.ajax({
            url: "MyApproval_Home.aspx/GetHeplDeskApprovalData",
            data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>' }),  // For empty input data use "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (result) {
                    try {
                        var JSONdata = JSON.parse(result.d);
                        if (JSONdata.length > 0) {
                            $("#divnoDataToPreview").css("display", "none");
                            $("#divnoDataToPreview").parent().css("box-shadow", "none")
                        }
                        else {
                            $("#divnoDataToPreview").css("display", "block");
                            $("#divnoDataToPreview").parent().css("box-shadow", "1px 1px 1px 1px #CCC")
                        }
                        jQuery("#tblHelpDeskApproval").jqGrid({
                            datatype: "local",
                            data: JSON.parse(result.d),
                            colNames: ['QueryID', 'Submitted Date', 'Subject', 'Requestor', 'Request Type', 'Sub Request Type', 'Priority'],
                            colModel: [{ name: 'QueryID', align: 'center', index: 'QueryID', hidden: true },
                            { name: 'SubmittedDate', index: 'SubmittedDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" }, width: 40 },
                            { name: 'Subject', align: 'center', index: 'Subject', hidden: true },
                            { name: 'CustomerID', index: 'CustomerID', align: 'center', width: 40 },
                            //{ name: 'InboxORwatchList', index: 'InboxORwatchList', align: 'center' },
                            { name: 'RequestType', index: 'RequestType', align: 'center', width: 40 },
                            { name: 'SubRequestType', index: 'SubRequestType', align: 'center', width: 40 },
                            { name: 'Priority', index: 'Priority', align: 'center', width: 40 }],
                            rowNum: 05,
                            autoencode: true,
                            rowList: [5, 10, 20, 50, 100],
                            sortname: 'QueryID',
                            pager: jQuery('#divHelpDeskApproval'),
                            sortorder: "asc",
                            viewrecords: true,
                            multiselect: true,
                            loadComplete: function () {
                                $(this).find(">tbody>tr.jqgrow:odd").addClass("clsTRRowEven");
                                $(this).find(">tbody>tr.jqgrow:even").addClass("clsTRRowOdd");
                                //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable>thead").addClass("clsTRColumnHeader");
                                //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").addClass("clsGridTable");
                                //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").removeClass("ui-jqgrid-htable");
                            },
                            onSelectRow: function (rowId, col, content, e) {
                                var myGrid = $('#tblHelpDeskApproval'),
                                selRowId = myGrid.jqGrid('getGridParam', 'selrow'),
                                QueryID = myGrid.jqGrid('getCell', selRowId, 'QueryID');
                                //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');

                                if (QueryID) {

                                    HelpdeskParameter = { intUserID: '<%=Session("intUserID").ToString%>', QueryID: QueryID };
                            ShowHelpDeskApprovalDetails()
                                //document.getElementById("tblAllApprovalGraph").style.display = "none";
                                //$(".margin1").css("margin-top", "0%");
                        }
                        else {
                            HelpdeskParameter = {};
                                //dhn
                            document.getElementById("MyProfileHelpdesk").style.display = "none";
                                //var windowWidth = $(window).width();
                                //if (windowWidth > 720) {
                                //    //document.getElementById("divLeaveApprovalParent").style.height = "325px";
                                //    document.getElementById("divLeaveApprovalParent").style.height = "auto";
                                //}
                                //else {
                                //    document.getElementById("divLeaveApprovalParent").style.height = "auto";
                                //}
                                //document.getElementById("tblAllApprovalGraph").style.display = "";
                                //$(".margin1").css("margin-top", "-4%");
                                //dhn
                        }
                        }, gridComplete: function () {
                            $("#tblHelpDeskApproval").setSelection('1');
                            $("#cb_tblHelpDeskApproval").click(function () {
                                var myGrid = $('#tblHelpDeskApproval')
                                var selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                                if (selRowId.length > 1) {
                                    $("#MyProfileHelpdesk").find(".margin").find(".btn").css("visibility", "hidden");
                                }
                                else if (selRowId.length == 0) {
                                    $("#MyProfileHelpdesk").css("display", "none");
                                }
                                else {
                                    $("#MyProfileHelpdesk").find(".margin").find(".btn").css("visibility", "");
                                }
                                });

                                //Added by pradip on 24-03-2020 for select all chckbox
        $('#tblHelpDeskApproval td .cbox').change(function () {
 if ($('#tblHelpDeskApproval td .cbox:checked').length == $('#tblHelpDeskApproval td .cbox').length){
  $('#cb_tblHelpDeskApproval').prop('checked',true);
 }
 else {
  $('#cb_tblHelpDeskApproval').prop('checked',false);
 }
        });
//End Added by pradip on 24-03-2020 for select all chckbox

                        }
                        //caption:"Timesheet Approval",

                    });
            }
                    catch (exception) {                       
                        document.getElementById("divHelpDeskApprovalChild").style.display = "none";                    
                        
                        document.getElementById("divHelpDeskApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                    }
                },
            error: function (xhr) {                   
                    document.getElementById("divHelpDeskApprovalChild").style.display = "none";
                    document.getElementById("divHelpDeskApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            });

}
//End of Addition by Vaijat K

//Added By Vaijat K ON 04/03/2016 For Showing Approval Ageing Graph
function DrawApprovalAgeingGraph(strTypeApp) {
    var width = 20;
    document.getElementById("DivApprovalAgeing").innerHTML = "";
    if (strTypeApp == 'Entity') {
        document.getElementById("DivApprovalAgeing").style.width = "90%";
        width = 15;
        document.getElementById("P1").style.marginLeft = "26px"
        document.getElementById("DivApprovalAgeing").style.marginLeft = "10px"
    }
    else if (strTypeApp == 'Timesheet') {
        document.getElementById("DivApprovalAgeing").style.width = "500px";
        // width = 25;
        document.getElementById("P1").style.marginLeft = "22%"
        document.getElementById("DivApprovalAgeing").style.marginLeft = "20%"

    }
    else if (strTypeApp == 'Overall') {
        document.getElementById("DivApprovalAgeing").style.width = "85%";
        // width = 25;
        document.getElementById("P1").style.marginLeft = "26px"
        document.getElementById("DivApprovalAgeing").style.marginLeft = "10px"
    }
    else {
        document.getElementById("DivApprovalAgeing").style.width = "300px";
        //width = 25;
        document.getElementById("P1").style.marginLeft = "32%"
        document.getElementById("DivApprovalAgeing").style.marginLeft = "30%"
    }

    $.ajax({
        type: 'POST',
        dataType: 'JSON',
        contentType: 'application/json',
        url: 'MyApproval_Home.aspx/GetApprovalAgeing',
        data: JSON.stringify({ intUserID: "<%=Session("intUserID").ToString%>", strType: strTypeApp }),
        //async: false,
        success: function (Result) {
            objAgeing = Result.d;
            $("#DivApprovalAgeing").css("text-align", "")
            try {
                ApprovalAgeingGraph(Result.d, width, strTypeApp);
            }
            catch (exception) {
                if (arr.length > 0) {
                    $("#DivApprovalAgeing").html('Something Went Wrong! The Graph was not Generated...');
                    $("#DivApprovalAgeing").css("text-align", "center");
                }
                else {
                    $("#DivApprovalAgeing").html('You Do Not Have Access');
                    $("#DivApprovalAgeing").css("text-align", "center");
                }
            }
        },
        error: function (xhr) {
            <%If Session("intUserID") Is Nothing Then%>
            alert("Session Expired!");
               <%Else%>
            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>

            $("#DivApprovalAgeing").html('Something Went Wrong! The Graph was not Generated...');
            $("#DivApprovalAgeing").css("text-align", "center");
        }
    });
}
    function ApprovalAgeingGraph(Result, width, strType) {

    var s1 = [];
    var s2 = [];
    var s3 = [];
    var s4 = [];
    //Commented By Vaijat K ON 27/04/2016 For Removing Approval Count
    //var s5 = [];
    //End Of Comment By Vaijat K
    var ticks = [];
    $.each(JSON.parse(Result), function (id, obj) {
        //s1.push(obj.Age)
        //s2.push(obj.Age5)
        //s3.push(obj.Age10)
        //s4.push(obj.Pending);
        ////Commented By Vaijat K ON 27/04/2016 For Removing Approval Count
        //// s5.push(obj.Approved);
        ////End Of Comment By Vaijat K
        //ticks.push(obj.EntityName);
        if (strType == 'Overall') {
            if (obj.EntityName == "Leave") {
                if (objLeaveRoleAccess == 1) {
                    s1.push(obj.Age)
                    s2.push(obj.Age5)
                    s3.push(obj.Age10)
                    s4.push(obj.Pending);
                    ticks.push(obj.EntityName);
                }
            }
            if (obj.EntityName == "Expense") {
                if (objExpenseRoleAccess == 1) {
                    s1.push(obj.Age)
                    s2.push(obj.Age5)
                    s3.push(obj.Age10)
                    s4.push(obj.Pending);
                    ticks.push(obj.EntityName);
                }
            }
            if (obj.EntityName == "Timesheet") {
                if (objTimesheetRoleAccess == 1) {
                    s1.push(obj.Age)
                    s2.push(obj.Age5)
                    s3.push(obj.Age10)
                    s4.push(obj.Pending);
                    ticks.push(obj.EntityName);
                }
            }
            if (obj.EntityName == "Entity") {
                if (objEntityRoleAccess == 1) {
                    s1.push(obj.Age)
                    s2.push(obj.Age5)
                    s3.push(obj.Age10)
                    s4.push(obj.Pending);
                    ticks.push(obj.EntityName);
                }
            }
            if (obj.EntityName == "HelpDesk") {
                if (objHelpdeskRoleAccess == 1) {
                    s1.push(obj.Age)
                    s2.push(obj.Age5)
                    s3.push(obj.Age10)
                    s4.push(obj.Pending);
                    ticks.push(obj.EntityName);
                }
            }
        }
        else if ((strType == 'Timesheet')) {
            if (obj.EntityName == "ResourceTimeSheet") {
                if (objResourceTimesheetAccess == 1) {
                    s1.push(obj.Age)
                    s2.push(obj.Age5)
                    s3.push(obj.Age10)
                    s4.push(obj.Pending);
                    ticks.push(obj.EntityName);
                }
            }
            else if (obj.EntityName == "ProjectTimeSheet") {
                if (objProjectTimesheetAccess == 1) {
                    s1.push(obj.Age)
                    s2.push(obj.Age5)
                    s3.push(obj.Age10)
                    s4.push(obj.Pending);
                    ticks.push(obj.EntityName);
                }
            }
        }
        else {
            s1.push(obj.Age)
            s2.push(obj.Age5)
            s3.push(obj.Age10)
            s4.push(obj.Pending);
            ticks.push(obj.EntityName);
        }
    });
    //Commented And Added By Vaijat K ON 27/04/2016 For Removing Approval Count
    // plot2 = $.jqplot('DivApprovalAgeing', [s1, s2, s3, s4, s5], {
        document.getElementById("DivApprovalAgeing").innerHTML = "";
        //Added By Usha Pandit On 02.07.2019 For Javascript Error No Data Specified if access is not there for any module
        if (ticks != "") {
            //End Of Added By Usha Pandit On 02.07.2019 For Javascript Error No Data Specified if access is not there for any module
            plot2 = $.jqplot('DivApprovalAgeing', [s1, s2, s3, s4], {
                //End Of Addition By Vaijat K
                animate: !$.jqplot.use_excanvas,
                seriesDefaults: {
                    renderer: $.jqplot.BarRenderer,
                    pointLabels: { show: true },
                    rendererOptions: { barWidth: width }
                },
                axes: {
                    xaxis: {
                        renderer: $.jqplot.CategoryAxisRenderer,
                        ticks: ticks
                    }
                },
                series: [{ label: 'Age > 3' }, { label: 'Age > 5' }, { label: 'Age > 10' }, { label: 'Pending' }], //, { label: 'Approved' }
                seriesColors: ['#993333', '#800000', '#4d0000', '#FF0000', '#009900'],
                legend: {
                    show: true,
                    location: 'e',
                    placement: 'outside'
                }
            });
        }
}
//End of Addition Vaijat K

//Added By Vaijat K ON 04/03/2016 For Ajax Call 
var strResult;
function ValidateResourceDate_XML(strUrl) {
    // TO SEE IF WE ARE RUNNING IN IE 
    var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
    strNavigator = navigator.appName;
    strNavigator = strNavigator.toUpperCase();
    //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
    if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
    {
        g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
        //hook the event handler
        g_objXHttp.onreadystatechange = TaskValidation_state_change;
        //prepare the call, http method=GET, false=asynchronous call
        g_objXHttp.open("GET", strUrl, false);
        //finally send the call
        g_objXHttp.send();
    }
    else {
        // Mozilla - based browser , Netscape
        g_objXHttp = new XMLHttpRequest();
        //hook the event handler
        g_objXHttp.onreadystatechange = TaskValidation_state_change;
        //prepare the call, http method=GET, false=asynchronous call
        g_objXHttp.open("GET", strUrl, false);
        //finally send the call
        g_objXHttp.send(null);

        if (g_objXHttp.responseText != null) {
            xmlDoc = document.implementation.createDocument("", "", null);
            xmlDoc.async = false;
            if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                xmlDoc.load(g_objXHttp.responseXML);
            strResult = g_objXHttp.responseText;
        }
    }
    return strResult;
}

function TaskValidation_state_change() {
    var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
    if (g_objXHttp.readyState == 4) {
        // Make sure request came back OK 
        if (g_objXHttp.status == 200) {
            //if (window.ActiveXObject)
            if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
            {
                xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                xmlDoc.async = false;
                xmlDoc.loadXML(g_objXHttp.responseText);
            }
                // code for Mozilla, etc.
            else if (document.implementation && document.implementation.createDocument) {
                xmlDoc = document.implementation.createDocument("", "", null);
                xmlDoc.async = false;
                if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                    xmlDoc.load(g_objXHttp.responseXML);
            }
            //Save the Result in a Global variable
            strResult = g_objXHttp.responseText;
        }
    }
}
//End of Addition Vaijat K

//Added By Vaijat K ON 04/03/2016 For Checking browser
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
//End of Addition Vaijat K

//Added By Vaijat K ON 04/03/2016 For Click Function to show HelpDesk Details 
function ShowHelpDeskApprovalDetails() {
    try {
        $.ajax({
            type: "POST", //GET or POST or PUT or DELETE verb
            url: "MyApproval_Home.aspx/GetDataHelpDeskForQuery", // Location of the service {intUserID:'<%=Session("intUserID")%>'}
            data: JSON.stringify(HelpdeskParameter),
            contentType: "application/json;charset=utf-8", // content type sent to server
            dataType: "json", //Expected data format from server
            async: false,
            success: function (data) {//On Successfull service call 

                //debugger;
                //alert();
                //set empty table data 
                $("#dinamictblHelpdesk").empty();
                var myGrid = $('#tblHelpDeskApproval'),
                 selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                if (selRowId.length > 1) {
                    $("#MyProfileHelpdesk").find(".margin").find(".btn").css("visibility", "hidden");
                }
                else {
                    $("#MyProfileHelpdesk").find(".margin").find(".btn").css("visibility", "");
                }
                $.each(JSON.parse(data.d), function (id, obj) {
                    //    // $("#detailsectionhide").Show(); 
                    //    //cerate dynamic table with data

                    var Prj_Start_Date = new Date(parseInt((obj.SubmittedDate).substr(6)));
                    var Start_Date = $.datepicker.formatDate("dd/mm/yy", Prj_Start_Date);

                    $("#dinamictblHelpdesk").append("<tr><td class='innermarg'>Subject</td><td class='innermarg'>" + HtmlEncode(obj.Subject) + "</td></tr><tr><td class='innermarg'>Requestor</td><td class='innermarg'>" + obj.CustomerID + "</td></tr><tr><td class='innermarg'>Request Type</td><td class='innermarg'>" + HtmlEncode(obj.RequestType) + "</td></tr><tr><td class='innermarg'>Sub Request Type</td><td class='innermarg'>" + HtmlEncode(obj.SubRequestType) + "</td></tr><tr><td class='innermarg'>Submitted Date</td><td class='innermarg'>" + Start_Date + "</td></tr><tr><td class='innermarg'>Priority</td><td class='innermarg'>" + obj.Priority + "</td></tr>");
                    return false;
                });
                document.getElementById("MyProfileHelpdesk").style.display = "block";
                ////dhn
                //var windowWidth = $(window).width();
                //if (windowWidth < 721) {
                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                //}
                //else {
                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                //}
                ////dhn
            },
            error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
               <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
            }
        });
    } catch (exception) { }
}
//End of Addition by Vaijat K

//Added By Vaijat K ON 04/03/2016 For Click Function to show Expense Details 
function ShowexpenseApprovalDetails() {
    try {
        $.ajax({
            type: "POST", //GET or POST or PUT or DELETE verb
            url: "MyApproval_Home.aspx/GetDataExpenseForQuery", // Location of the service {intUserID:'<%=Session("intUserID")%>'}
            data: JSON.stringify(ExpenseApprovalpass),
            contentType: "application/json;charset=utf-8", // content type sent to server
            dataType: "json", //Expected data format from server
            async: false,
            success: function (data) {//On Successfull service call 
                //alert();
                //set empty table data 
                $("#dinamictblExpense").empty();
                var myGrid = $('#ExpenseApprovalGridview'),
                  selRowId = myGrid.jqGrid('getGridParam', 'selarrrow')
                if (selRowId.length > 1) {
                    $("#MyProfileExpense").find(".margin").find(".btn").css("visibility", "hidden");
                }
                else {
                    $("#MyProfileExpense").find(".margin").find(".btn").css("visibility", "");
                }
                $.each(JSON.parse(data.d), function (id, obj) {
                    //    // $("#detailsectionhide").Show(); 
                    //    //cerate dynamic table with data
                    var Prj_Entry_Date = new Date(parseInt((obj.entryDate).substr(6)));
                    var Start_Date = $.datepicker.formatDate("dd/mm/yy", Prj_Entry_Date);

                    $("#dinamictblExpense").append("<tr><td class='innermarg'>Employee Name</td><td class='innermarg'>" + obj.EmployeeName + "</td></tr><tr><td class='innermarg'>Entry Date</td><td class='innermarg'>" + Start_Date + "</td></tr><tr><td class='innermarg'>Title</td><td class='innermarg'>" + HtmlEncode(obj.Title) + "</td></tr><tr><td class='innermarg'>Comments</td><td class='innermarg'>" + HtmlEncode(obj.Comments) + "</td></tr><tr><td class='innermarg'>Amount</td><td class='innermarg'>" + obj.Amount + "</td></tr>");
                    return false;
                });
                document.getElementById("MyProfileExpense").style.display = "block";
                ////dhn
                //var windowWidth = $(window).width();
                //if (windowWidth < 721) {
                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                //}
                //else {
                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                //}
                ////dhn
            },
            error: function (xhr) {
                <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
               <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
            }
        });
    } catch (exception) { }
}
//End of Addition by Vaijat K

//Added By Vaijat K ON 04/03/2016 For Click Function to show Timesheet Details 
function ShowTimesheetApprovalDetails() {
    try {
        $.ajax({
            type: "POST", //GET or POST or PUT or DELETE verb
            url: "MyApproval_Home.aspx/GetDataTimesheetForQuery", // Location of the service {intUserID:'<%=Session("intUserID")%>'}
            data: JSON.stringify(ExpenseApprovalpass),
            contentType: "application/json;charset=utf-8", // content type sent to server
            dataType: "json", //Expected data format from server
            async: false,
            success: function (data) {//On Successfull service call 
                //debugger;
                //alert();
                //set empty table data 
                var myGrid = $('#ResourceTimesheetApprovalgrid'),
                   selRowId = myGrid.jqGrid('getGridParam', 'selarrrow');
                if (selRowId.length > 1) {
                    $("#MyProfileTimesheet").find(".margin").find(".btn").css("visibility", "hidden");
                }
                else {
                    $("#MyProfileTimesheet").find(".margin").find(".btn").css("visibility", "");
                }
                $("#detailsectionhideTimesheet").empty();

                $.each(JSON.parse(data.d), function (id, obj) {
                    //    // $("#detailsectionhide").Show(); 
                    //    //cerate dynamic table with data

                    var Prj_Start_Date = new Date(parseInt((obj.FromDate).substr(6)));
                    var Start_Date = $.datepicker.formatDate("dd/mm/yy", Prj_Start_Date);
                    var Prj_End_Date = new Date(parseInt((obj.ToDate).substr(6)));
                    var End_Date = $.datepicker.formatDate("dd/mm/yy", Prj_End_Date);

                    if (document.getElementById("ddlTimesheet").value == 1)
                        $("#detailsectionhideTimesheet").append("<tr><td class='innermarg'>Employee Name</td><td class='innermarg'>" + obj.EmployeeName + "</td></tr><tr><td class='innermarg'>Description</td><td class='innermarg'>" + HtmlEncode(obj.StatusDescription) + "</td></tr><tr><td class='innermarg'>From Date</td><td class='innermarg'>" + Start_Date + "</td></tr><tr><td class='innermarg'>To Date</td><td class='innermarg'>" + End_Date + "</td></tr>");
                    else if (document.getElementById("ddlTimesheet").value == 2)
                        $("#detailsectionhideTimesheet").append("<tr><td class='innermarg'>Project Name</td><td class='innermarg'>" + obj.projectName + "</td></tr><tr><td class='innermarg'>From Date</td><td class='innermarg'>" + Start_Date + "</td></tr><tr><td class='innermarg'>To Date</td><td class='innermarg'>" + End_Date + "</td></tr><tr><td class='innermarg'>Total Timesheet Hours</td><td class='innermarg'>" + obj.TotalTimesheetHours + "</td></tr>");
                    return false;
                });
                document.getElementById("MyProfileTimesheet").style.display = "block";
                ////dhn
                //var windowWidth = $(window).width();
                //if (windowWidth < 721) {
                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "100%";
                //}
                //else {
                //    document.getElementById("divEntityWorkFlowApprovalParent").style.height = "auto";
                //}
                ////dhn
            },
            error: function (xhr) {
               <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
               <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);
               <%End If%>
            }
        });
    } catch (exception) { }
}
//End OF Addition by Vaijat K ON 25/04/2016

//Added By Vaijat K ON 04/03/2016 For HTML Encode
function HtmlEncode(value) {
    return !value ? value : String(value).replace(/&/g, "&amp;").replace(/\"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
//End of Addtion Vaijat K
/********************************************************************************************************/
//Added By Vaijat K ON 25/04/2016 For adjust screen resolution

function adjustWidth(width) {

}
function allScreenResolution() {
    $(".imgAll").height("65px")
    if ($(window).width() < 800 && $(window).height() < 600) {
        document.getElementById("leaveGraph").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.height = "135px";
        document.getElementById("DivApprovalAgeing").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.width = "250px";
        $(".dtsection").css("height", "190px !important")
        //$(".imgAll").height("50%")
    }
    else if ($(window).width() <= 1024 && $(window).height() <= 600) {
        $(".imgAll").height("23px")
        document.getElementById("leaveGraph").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.height = "135px";
        document.getElementById("DivApprovalAgeing").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.width = "300px";
        ///$(".imgAll").height("60%")
        $(".dtsection").css("height", "190px !important")
    }
    else if ($(window).width() <= 900 && $(window).height() <= 768) {
        $(".imgAll").height("40px")
        document.getElementById("leaveGraph").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.height = "200px";
        document.getElementById("DivApprovalAgeing").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.width = "350px";
        //$(".imgAll").height("50%")
        $(".dtsection").css("height", "190px !important")
    }
    else if ($(window).width() <= 1024 && $(window).height() <= 768) {
        $(".imgAll").height("40px")
        document.getElementById("leaveGraph").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.height = "200px";
        document.getElementById("DivApprovalAgeing").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.width = "350px";
        //$(".imgAll").height("50%")
        $(".dtsection").css("height", "190px !important")
    }
    else if ($(window).width() <= 1366 && $(window).height() <= 768) {
        $(".imgAll").height("40px")
        document.getElementById("leaveGraph").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.height = "200px";
        document.getElementById("DivApprovalAgeing").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.width = "400px";
        //$(".imgAll").height("50%")
        $(".dtsection").css("height", "190px !important")
    }
    else if ($(window).width() <= 1280 && $(window).height() <= 600) {
        $(".imgAll").height("23px")
        document.getElementById("leaveGraph").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.height = "135px";
        document.getElementById("DivApprovalAgeing").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.width = "350px";
        ///$(".imgAll").height("60%")
        $(".dtsection").css("height", "190px !important")
    }
    else if ($(window).width() <= 1280 && $(window).height() <= 960) {
        document.getElementById("leaveGraph").style.height = "240px";
        document.getElementById("AllApprovalGraph").style.height = "240px";
        document.getElementById("DivApprovalAgeing").style.height = "240px";
        document.getElementById("AllApprovalGraph").style.width = "400px";
        //$(".imgAll").height("60%")
    }
    else if ($(window).width() <= 1280 && $(window).height() <= 1024) {
        document.getElementById("leaveGraph").style.height = "300px";
        document.getElementById("AllApprovalGraph").style.height = "300px";
        document.getElementById("DivApprovalAgeing").style.height = "300px";
        document.getElementById("AllApprovalGraph").style.width = "450px";
        ///$(".imgAll").height("60%")
    }
    else if ($(window).width() < 850) {
        document.getElementById("leaveGraph").style.height = "190px";
        document.getElementById("AllApprovalGraph").style.height = "190px";
        document.getElementById("DivApprovalAgeing").style.height = "190px";
        document.getElementById("AllApprovalGraph").style.width = "300px";
    }
    else if ($(window).height() < 768 && (window).height() > 680) {
        $(".imgAll").height("40px")
        document.getElementById("leaveGraph").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.height = "200px";
        document.getElementById("DivApprovalAgeing").style.height = "200px";
        document.getElementById("AllApprovalGraph").style.width = "300px";
        $(".dtsection").css("height", "190px !important")
    }
    else if ($(window).height() < 680 && (window).height() > 600) {
        $(".imgAll").height("23px")
        document.getElementById("leaveGraph").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.height = "135px";
        document.getElementById("DivApprovalAgeing").style.height = "135px";
        document.getElementById("AllApprovalGraph").style.width = "300px";
        $(".dtsection").css("height", "190px !important")
    }
    else {
        document.getElementById("leaveGraph").style.height = "300px";
        document.getElementById("AllApprovalGraph").style.height = "300px";
        document.getElementById("DivApprovalAgeing").style.height = "300px";
        document.getElementById("AllApprovalGraph").style.width = "450px";
        //$(".imgAll").height("60%")
    }
    if (arr.length == 1) {
        $(".fliplabel").parent().parent().parent().parent().css("height", "33.34%");
    }
    else if (arr.length == 2) {
        $(".fliplabel").parent().parent().parent().parent().css("height", "50.1%");
    }
    else if (arr.length == 3) {
        $(".fliplabel").parent().parent().parent().parent().css("height", "66.68%");
    }
    else if (arr.length == 4) {
        $(".fliplabel").parent().parent().parent().parent().css("height", "83.35%");
    }
    else if (arr.length == 5) {
        $(".fliplabel").parent().parent().parent().parent().css("height", "100%");
    }
    else if (arr.length == 0) {
        $(".fliplabel").parent().parent().parent().parent().css("height", "16.67%");
    }
}
//End of Addtion by Vaijat K

//Added By Vaijat K ON 25/04/2016 For clearing box shadow from div
function clearBoxShadow() {
    $("#divOverAll").css("box-shadow", "");
    $("#divLeaveApproval").css("box-shadow", "");
    $("#divEntityWorkFlowApproval").css("box-shadow", "");
    $("#divResourceTimesheetApproval").css("box-shadow", "");
    $("#divHelpDesk").css("box-shadow", "");
    $("#divExpenseApproval").css("box-shadow", "");
}
//End of Addtion by Vaijat K

//Added By Vaijat K ON 25/04/2016 For Hiding Profile Div
function HideDiv() {
    document.getElementById("MyProfile").style.display = "none";
    document.getElementById("MyProfile1").style.display = "none";
    document.getElementById("MyProfileTimesheet").style.display = "none";
    document.getElementById("MyProfileExpense").style.display = "none";
    document.getElementById("MyProfileHelpdesk").style.display = "none";
    document.getElementById("lblNote").style.display = "none";

}
//End of Addtion by Vaijat K

</script>
<body>
    <%--dhn 19--%>
    <form id="frmMyApprovalHome"></form>
    <%--dhn 19--%>
    <div class="mm-page">
        <%--Commented And Added By Usha Pandit On 12.08.2020 For applying scroll to page--%>
        <%--<div id="page1" style="border: 2px solid #e39321; margin: 5px;">--%>
        <div id="page1" style="overflow: scroll !important; border: 2px solid #e39321; margin: 5px;">
            <%--End Of Added By Usha Pandit On 12.08.2020 For applying scroll to page--%>
            <div class="menu-header" style="text-align: center; width: 99%">
                <%--<a href="#menu"></a>--%>
                <label style="margin-left: 30px">My Pending Approval</label>
                <label id="lblNote" style="float: right; position: relative; top: 16px; left: -5px;">Click On Overall Graph Bars To See Details...</label>
                <%--<div style="top: 5px; right: 5px; position: absolute;">
                    <button class="btn" type="button" style="background-color: transparent; color: white; font-weight: bold;" onclick="logout();">Log Out</button>
                </div>--%>
            </div>
            <div id="divMenuContent" class="MenuContent">
                <%-- <div id="header">

                    <div class="leftheader">--%>

                <%--<div class="btn-group button-margin">
                                <asp:Label ID="lbl_user" runat="server"></asp:Label>
                            </div>--%>
                <%--       </div>
                </div>--%>

                <%--<div class="master">
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

                            <a href="../PM/PM_DailyActivity.aspx" class="menu-link">
                                <div class="box" id="timesheet">
                                    <img src="../../responsive/images/time.gif" alt="TimeSheet Entry" class="slider-image" /><br />
                                    TimeSheet Entry
                                </div>
                            </a>

                        </div>

                    </div>
                </div>--%>
                <%--Added by Tejas Rasage on 02 March 2016 Purpose:UI Change--%>

                <table style="width: 98%; height: 93%; table-layout: inherit">

                    <tr style="height: 100%">
                        <td rowspan="2" style="vertical-align: top; width: 13%; height: 100%;" align="right"><%--style="width:20%"--%>
                            <table style="height: 100%;width:92%">
                                <%--style="margin-top:-5px"--%>
                                <%--End of Added by Tejas Rasage on 02 March 2016 Purpose:UI Change--%>
                                <%--Commented by Tejas Rasage on 02 March 2016 Purpose:UI Change--%>
                                <%--<div class="content">
                        <div class="center-caption" style="background-color: #e39321; color: white; padding: 2px">
                            My Pending Approval<br />
                        </div>--%>
                                <%--End of Commented by Tejas Rasage on 02 March 2016 Purpose:UI Change--%>
                                <%--Added by Tejas Rasage on 03 March 2016 Purpose:UI Change--%>
                                <tr style="height: 16.67%; vertical-align: baseline;">
                                    <td>
                                        <div id="divOverAll" class="fliplabel divTitle" title="Overall">
                                          
                                               <%--  <table style="width:100%">
                                                <tr>
                                                    <td align="center">--%>
                                            <img class="imgAll" src="../../img/1920/Overall.gif" />
                                            <%-- </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; vertical-align: baseline">--%>
                                            <p class="pAll">Overall</p>
                                            <%--Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <div id="spanOverAll"></div>
                                            <%--End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <%-- </td>
                                                </tr>
                                            </table>--%>
                                            <%--style="background: url(../../img/1920/Overall.gif) !important;background-repeat: no-repeat !important;"<a style="right: 0px;float:right" id="aLeaveApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                                        </div>
                                        <%--<div id="div10" class="clsAccess"></div>--%>
                                    </td>
                                </tr>

                                <tr style="height: 16.67%; vertical-align: baseline;">
                                    <td>
                                        <div id="divLeaveApproval" class="fliplabel divTitle" title="Leave Approval">
                                            <%--<table style="width: 100%">
                                                <tr>
                                                    <td align="center">--%>
                                            <img class="imgAll" src="../../img/1920/leave.gif" />
                                            <%--  </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; vertical-align: baseline">--%>
                                            <p class="pAll">Leave Approval</p>
                                            <%--Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <div id="spanLeaveApproval"></div>
                                            <%--End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <%--  </td>
                                                </tr>
                                            </table>--%>
                                            <%--style="background: url(../../img/1920/leave.gif) !important;background-repeat: no-repeat !important;"<a style="right: 0px;float:right" id="aLeaveApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                                        </div>
                                        <%--<div id="div5" class="clsAccess"></div>--%>
                                    </td>
                                </tr>
                                <tr style="height: 16.67%; vertical-align: baseline;">
                                    <td>
                                        <div id="divEntityWorkFlowApproval" class="fliplabel divTitle" title="Entity WorkFlow Approval">
                                          
                                            <%--<table style="width: 100%">
                                                <tr>
                                                    <td align="center">--%>
                                            <img class="imgAll" src="../../img/1920/entity.gif" />
                                            <%-- </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; vertical-align: baseline">--%>
                                            <p class="pAll">Entity WorkFlow Approval</p>
                                            <%--Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                             <div id="spanEntityWorkFlowApproval"></div>
                                            <%--End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <%--  </td>
                                                </tr>
                                            </table>--%>
                                            <%--style="background: url(../../img/1920/entity.gif) !important;background-repeat: no-repeat !important;"<a style="right: 0px;float:right" id="aEntityWorkFlowApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                                        </div>
                                        <%--<div id="div11" class="clsAccess"></div>--%>
                                    </td>
                                </tr>
                                <tr style="height: 16.67%; vertical-align: baseline;">
                                    <td>
                                        <div id="divResourceTimesheetApproval" class="fliplabel divTitle" title="Timesheet Approval">
                                            <%--<table style="width: 100%">
                                                <tr>
                                                    <td align="center">--%>
                                            <img class="imgAll" src="../../img/1920/timesh.gif" />
                                            <%-- </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; vertical-align: baseline">--%>
                                            <p class="pAll">Timesheet Approval</p>
                                            <%--Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <div id="spanResourceTimesheetApproval"></div>
                                            <%--End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <%-- </td>
                                                </tr>
                                            </table>--%>
                                            <%--style="background: url(../../img/1920/timesh.gif) !important;background-repeat: no-repeat !important;"<a style="right: 0px;float:right" id="aEntityWorkFlowApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                                        </div>
                                        <%--<div id="div4" class="clsAccess"></div>--%>
                                    </td>
                                </tr>
                                <tr style="height: 16.67%; vertical-align: baseline;">
                                    <td>
                                        <div id="divHelpDesk" class="fliplabel divTitle" title="Helpdesk Approval">
                                          
                                            <%-- <table style="width: 100%">
                                                <tr>
                                                    <td align="center">--%>
                                            <img class="imgAll" src="../../img/1920/Helpdesk.gif" />
                                            <%--</td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; vertical-align: baseline">--%>
                                            <p class="pAll">Helpdesk Approval</p>
                                            <%--Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                             <div id="spanHelpDesk"></div>
                                            <%--End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <%-- </td>
                                                </tr>
                                            </table>--%>
                                            <%--style="background: url(../../img/1920/Helpdesk.gif) !important;background-repeat: no-repeat !important;"<a style="right: 0px;float:right" id="aEntityWorkFlowApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                                        </div>
                                        <%--<div id="div9" class="clsAccess"></div>--%>
                                    </td>
                                </tr>
                                <tr style="height: 16.67%; vertical-align: baseline;">
                                    <td>
                                        <div id="divExpenseApproval" class="fliplabel divTitle" title="Expense Approval">
                                            <%-- <table style="width: 100%">
                                                <tr>
                                                    <td align="center">--%>
                                            <img class="imgAll" src="../../img/1920/expense.gif" />
                                            <%-- </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center; vertical-align: baseline">--%>
                                            <p class="pAll">Expense Approval</p>
                                            <%--Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                             <div id="spanExpenseApproval"></div>
                                            <%--End Of Added By Vidya J ON 7 July 2016 For Pending Entity Count--%>
                                            <%-- </td>
                                                </tr>
                                            </table>--%>
                                            <%--style="background: url(../../img/1920/expense.gif) !important;background-repeat: no-repeat !important;"<a style="right: 0px;float:right" id="aExpenseApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                                        </div>
                                        <%--<div id="div7" class="clsAccess"></div>--%>

                                    </td>
                                </tr>
                            </table>
                        </td>
                        <%--End of Tejas Add 03-MARCH--%>
                        <td style="vertical-align: top; height: 100%"><%--width:80% display: block;--%>
                            <table id="tblRoleAccessDisplay" style="width: 96%; border: 1px solid #e39321; height: 97%">
                                <tr style="height: 50%">
                                    <td style="width: 100%">
                                        <%--Commented and Added Tejas R 04-March 2016--%>
                                        <%--<p class="Leaveflip pHeading labelHeading" id="P4" style="left: 523px; top: 45px">Details</p>--%>
                                        <%--<p class="Leaveflip pHeading labelHeading" id="P4" style="left: 523px; top: 45px;display:none">Details</p>--%>
                                        <%--End Commented and Added Tejas R 04-March 2016--%>
                                        <%--dhn Graph 21--%>
                                        <div class="content-page">

                                            <div id="DivGraphInfo" style="width: 100%; height: 100%">
                                                <%-- border: 2px solid #5175B3;--%>
                                                <table style="background-color: transparent; border: 0px white; vertical-align: top; width: 100%">
                                                    <tr>
                                                        <td id="tdOverall" style="width: 50%">
                                                            <%--Commented and Added Tejas R 04-March 2016--%>
                                                            <%--<table id="tblAllApprovalGraph" style="background-color: transparent; border: 0px white; margin-top: 10%;">--%>
                                                            <table id="tblAllApprovalGraph" class="MarginDiv" style="background-color: transparent; border: 0px white; width: 100%">
                                                                <%--End of Commented and Added Tejas R 04-March 2016--%>
                                                                <tr>
                                                                    <td>
                                                                        <%--<div class="shadow1" style="margin-top: 1%; margin-left: 1%">--%>
                                                                        <%--Commented and Added Tejas R 04-March 2016--%>
                                                                        <%--<p class="Leaveflip pHeading labelHeading" id="GraphHeaderApproval" align="center" style="position: relative; top: -67px;">Overall Pending</p>--%>
                                                                        <p class="Leaveflip pHeading labelHeading" id="GraphHeaderApproval" align="center" style="position: relative; left: 26px;">Overall pending requests</p>
                                                                        <%--End Commented and Added Tejas R 04-March 2016--%>
                                                                        <div id="divNoAllApprovalGraph" style="width: 100%; display: inline-block"></div>
                                                                        <div id="AllApprovalGraph" style="white-space: nowrap; height: 90%; width: 100%; margin-bottom: 5%; margin-left: 10px; margin-top: 10px; display: block">
                                                                        </div>
                                                                        <%--</div>--%>

                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <%--  <%--Added by Tejas Rasage on 09-March-2016 --%>

                                                            <%-- <table  id="tblAllApprovalGraph" style="background-color: transparent; border: 0px white;">
                                         <tr>
                                            <td>
                                                <p class="Leaveflip pheading" id="GraphHeaderApproval" style="width:100%">Overall Pending</p>
                                                <div id="divNoAllApprovalGraph" style="width:100%;display:inline-block"></div>
                                                <div id="AllApprovalGraph" style="white-space: nowrap; height: 250px; width: 185px;">
                                                </div>
                                            </td>
                                        </tr>
                                        </table>--%>
                                                            <%--End of Added by Tejas Rasage on 09-March-2016 --%>
                                                        </td>
                                                        <%--<td width="50%" style="color: #27408B">--%>
                                                        <%--<label id="LeaveCount"></label>
                                <br />
                                <label id="ExpenseCount"></label>
                                <br />
                                <label id="TimeSheetCount"></label>
                                <br />
                                <label id="EntityCount"></label>--%>
                                                        <%--</td>--%>


                                                        <td id="tdGraph" style="vertical-align: baseline; width: 50%">
                                                            <table id="tblleaveGraph" class="MarginDiv" style="background-color: transparent; border: 0px white; width: 100%">
                                                                <tr>
                                                                    <td>
                                                                        <%--<div class="shadow1 margin1" style="width: 430px; margin-right: 1%;">--%>
                                                                        <p class="Leaveflip pHeading labelHeading" id="GraphHeaderLeave" style="margin-left: auto !important">My Leave</p>
                                                                        <div id="divNoLeaveGraph" style="width: 100%; display: inline-block"></div>
                                                                        <div id="leaveGraph" style="white-space: nowrap; height: 100%; width: 90%; margin-top: 18px">
                                                                        </div>
                                                                        <%--</div>--%>

                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </td>
                                                        <td id="tdDetails" style="width: 50%; display: none">
                                                            <div id="divnoDataToPreview" style="display: none" class="noData">No Data To Preview.</div>
                                                            <div id="MyProfile" class="right-Content" style="min-height: 700px; width: 100%; margin-top: 0%; display: none; margin-left: 0px">

                                                                <div class="center-text" style="text-align: center; margin: 0px !important; height: 30px; padding-top: 7px;">
                                                                    Details Section
                                                                </div>
                                                                <div style="margin: 3% 0% 2% 3%; text-align: right; background-color: #f6eee4;" class="margin">
                                                                    <%--   <button class="btn" type="button" onclick="Approved('LeaveApprovalGridview','EmployeeID')">--%>
                                                                    <a data-toggle="modal" class="btn btn-primary" onclick="checkSelectApprovalDetail('LeaveApprovalGridview','EmployeeID','A');">Approve</a>
                                                                    <%--   Approve</button>--%>
                                                                    <button class="btn btn-primary" type="button" onclick="checkSelectApprovalDetail('LeaveApprovalGridview','EmployeeID','R');">
                                                                        Reject</button>
                                                                </div>
                                                                <div id="detailsectionhide" style="">
                                                                    <%--<div style="margin: 3% 0% 2% 3%; float: left; width: 100%">
                <a data-toggle="modal" class="btn btn-primary" onclick="checkSelectApproval('LeaveApprovalGridview','EmployeeID','A');">
                    Approve</a>
                <%--   Approve</button>--%>
                                                                    <%-- <button class="btn btn-primary" type="button" onclick="checkSelectApproval('LeaveApprovalGridview','EmployeeID','R');">
                    Reject</button>
            </div>--%>
                                                                    <div style="margin: 3% 0% 2% 3%; float: left; width: 100%" class="DetailSectionMargin">
                                                                        <div id="Detailssection" class="scroll" style="text-align: left; overflow: auto; width: 97%; border-radius: 4px; border: 1px solid black">
                                                                            <table id="dinamictbl" style="width: 100%">
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                    <div>
                                                                    </div>
                                                                    <div id="IssueGrid" class="Table-Header">
                                                                    </div>
                                                                    <div>
                                                                        <table id="milestoneGrid" class="scroll">
                                                                        </table>
                                                                        <div id="onmilestonePagging" class="scroll" style="text-align: center;">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="MyProfile1" class="right-Content" style="min-height: 700px; width: 100%; margin-top: 0%; display: none; margin-left: 0px">

                                                                <div class="center-text" style="margin: 0px !important; text-align: center; height: 30px; padding-top: 7px;">
                                                                    Entity Details Section
                                                                </div>
                                                                <div style="margin: 3% 0% 2% 3%; text-align: right; background-color: #f6eee4;" class="margin">
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('EntityWorkflowApprovalGridview','EmployeeID','A')">
                                                                        Approve</button>
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('EntityWorkflowApprovalGridview','EmployeeID','R')">
                                                                        Reject</button>
                                                                </div>
                                                                <div id="detailsectionhide1" style="">
                                                                    <div style="margin: 3% 0% 2% 3%; float: left; width: 100%" class="DetailSectionMargin">
                                                                        <div id="Detailssection1" class="scroll" style="text-align: left; overflow: auto; width: 97%; border-radius: 4px; border: 1px solid black">
                                                                            <table id="dinamictbl1" style="width: 100%">
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                    <div>
                                                                    </div>
                                                                    <div id="IssueGrid1" class="Table-Header">
                                                                    </div>
                                                                    <div>
                                                                        <table id="milestoneGrid1" class="scroll">
                                                                        </table>
                                                                        <div id="onmilestonePagging1" class="scroll" style="text-align: center;">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="MyProfileExpense" class="right-Content" style="min-height: 700px; margin-left: 0px; width: 100%; margin-top: 0%; display: none">

                                                                <div class="center-text" style="margin: 0px !important; height: 30px; text-align: center; padding-top: 7px;">
                                                                    Expense Details Section
                                                                </div>
                                                                <div style="margin: 3% 0% 2% 3%; text-align: right; background-color: #f6eee4;" class="margin">
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('ExpenseApprovalGridview','EmployeeID','A')">
                                                                        Approve</button>
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('ExpenseApprovalGridview','EmployeeID','R')">
                                                                        Reject</button>
                                                                </div>
                                                                <div id="detailsectionhideExpense" class="dtSection" style="">
                                                                    <div style="margin: 3% 0% 2% 3%; float: left; width: 100%" class="DetailSectionMargin">
                                                                        <div id="DetailssectionExpense" class="scroll DetailssectionH" style="text-align: left; overflow: auto; width: 97%; border-radius: 4px; border: 1px solid black">
                                                                            <table id="dinamictblExpense" style="width: 100%">
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                    <div>
                                                                    </div>
                                                                    <div id="IssueGridexpense" class="Table-Header">
                                                                    </div>
                                                                    <div>
                                                                        <table id="milestoneGridExpense" class="scroll">
                                                                        </table>
                                                                        <div id="onmilestonePaggingExpense" class="scroll" style="text-align: center;">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="MyProfileTimesheet" class="right-Content" style="min-height: 700px; margin-left: 0px; width: 100%; margin-top: 0%; display: none">

                                                                <div class="center-text" style="margin: 0px !important; height: 30px; text-align: center; padding-top: 7px;">
                                                                    Timesheet Details Section
                                                                </div>
                                                                <div style="margin: 3% 0% 2% 3%; text-align: right; background-color: #f6eee4;" class="margin">
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('ResourceTimesheetApprovalgrid','EmployeeID','A')">
                                                                        Approve</button>
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('ResourceTimesheetApprovalgrid','EmployeeID','R')">
                                                                        Reject</button>
                                                                </div>
                                                                <div id="detailsectionhideTimesheet" class="dtSection" style="">
                                                                    <div style="margin: 3% 0% 2% 3%; float: left; width: 100%" class="DetailSectionMargin">
                                                                        <div id="DetailssectionTimesheet" class="scroll DetailssectionH" style="text-align: left; overflow: auto; width: 97%; border-radius: 4px; border: 1px solid black">
                                                                            <table id="dinamictblTimesheet" style="width: 100%">
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                    <div>
                                                                    </div>
                                                                    <div id="IssueGridTimesheet" class="Table-Header">
                                                                    </div>
                                                                    <div>
                                                                        <table id="milestoneGridTimesheet" class="scroll">
                                                                        </table>
                                                                        <div id="onmilestonePaggingTimesheet" class="scroll" style="text-align: center;">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="MyProfileHelpdesk" class="right-Content" style="min-height: 700px; margin-left: 0px; width: 100%; margin-top: 0%; display: none">

                                                                <div class="center-text" style="margin: 0px !important; height: 30px; text-align: center; padding-top: 7px;">
                                                                    HelpDesk Details Section
                                                                </div>
                                                                <div style="margin: 3% 0% 2% 3%; text-align: right; background-color: #f6eee4;" class="margin">
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('tblHelpDeskApproval','EmployeeID','A')">
                                                                        Approve</button>
                                                                    <button type="button" class="btn btn-primary" onclick="checkSelectApprovalDetail('tblHelpDeskApproval','EmployeeID','R')">
                                                                        Reject</button>
                                                                </div>
                                                                <div id="detailsectionhideHelpdesk" class="dtSection" style="">
                                                                    <div style="margin: 3% 0% 2% 3%; float: left; width: 100%" class="DetailSectionMargin">
                                                                        <div id="DetailssectionHelpdesk" class="scroll DetailssectionH" style="text-align: left; overflow: auto; width: 97%; border-radius: 4px; border: 1px solid black">
                                                                            <table id="dinamictblHelpdesk" style="width: 100%">
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                    <div>
                                                                    </div>
                                                                    <div id="IssueGridHelpdesk" class="Table-Header">
                                                                    </div>
                                                                    <div>
                                                                        <table id="milestoneGridHelpdesk" class="scroll">
                                                                        </table>
                                                                        <div id="onmilestonePaggingHelpdesk" class="scroll" style="text-align: center;">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </td>
                                                        <%--Commented By Tejas Rasage on 09-March-2016--%>
                                                        <%--<td>

                                        <table id="tblEntityGraph" class="MarginDiv" style="background-color: transparent; border: 0px white;margin-top:-8% !important">
                                            <tr>
                                                <td>
                                                    <div class="shadow1 margin1" >
                                                        <center><p class="Leaveflip pHeading labelHeading" id="GraphHeaderEntity" style="margin-left:auto !important">My Entity</p></center>
                                                        <div id="EntityGraph" style="white-space: nowrap; height: 400px; width: 405px; margin-left: 10%;margin-top: 10px">
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>

                                        <table id="tblExpenseGraph" class="MarginDiv" style="background-color:transparent; border: 0px white;margin-top:-8% !important">
                                            <tr>
                                                <td>
                                                    <div class="shadow1 margin1" >
                                                        <center><p class="Leaveflip pHeading labelHeading" id="GraphHeaderExpense" style="margin-left:auto !important">My Expense</p></center>
                                                        <div id="ExpenseGraph" style="white-space: nowrap; height: 400px; width: 375px; margin-left: 10%;margin-top: 10px">
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                    <td>

                                        <table id="tblTimesheetGraph" class="MarginDiv" style="background-color: transparent; border: 0px white;margin-top:-8% !important">
                                            <tr>
                                                <td>
                                                    <div class="shadow1 margin1"style="margin-top:-3% !important">
                                                        <center><p class="Leaveflip pHeading labelHeading" id="GraphHeaderTimesheet" style="margin-left:auto !important">My Timesheet</p></center>
                                                        <div id="TimesheetGraph" style="white-space: nowrap; height: 400px; width: 425px; margin-left: 10%;margin-top: 10px">
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>--%>
                                                        <%--End of Commented By Tejas Rasage on 09-March-2016--%>
                                                    </tr>
                                                </table>

                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="height: 50%">

                                    <td style="vertical-align: top">
                                        <table id="tblApprovalAgeing" class="MarginDiv" style="background-color: transparent; border: 0px white; width: 100%; height: 100%">
                                            <%--;border: 2px solid #5175B3;--%>
                                            <tr>
                                                <td style="vertical-align: top">
                                                    <div id="divMainApproval" style="width: 99%; margin-right: 1%; margin-left: 5px">
                                                        <p class="Leaveflip pHeading labelHeading" id="P1" style="margin-left: 26px !important;">Approval Ageing/Pending</p>
                                                        <div id="DivApprovalAgeing" style="white-space: nowrap; height: 100%; width: 100%; margin-left: 10px">
                                                        </div>
                                                    </div>

                                                </td>
                                            </tr>
                                        </table>
                                        <div id="tblshow" class="Grid-data">
                                            <div id="divLeaveApprovalParent" class="clsParent">
                                                <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <%--<div id="divLeaveApproval" class="fliplabel"><b class="cslLabel">Leave Approval</b><%--<a style="right: 0px;float:right" id="aLeaveApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a></div>--%>
                                                <%--End of Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <div id="divLeaveApprovalAccess" class="clsAccess"></div>
                                                <div id="divLeaveApprovalChild" style="margin: 3px;">
                                                    <div class="workflow" style="width: 100%;">
                                                        <%--padding-left:147px;margin-top:-10%--%>
                                                        <div style="margin: 3% 0% 2% 3%;" class="margin">
                                                            <%--   <button class="btn" type="button" onclick="Approved('LeaveApprovalGridview','EmployeeID')">--%>
                                                            <a data-toggle="modal" class="btn btn-primary" onclick="checkSelectApproval('LeaveApprovalGridview','EmployeeID','A');">Approve</a>
                                                            <%--   Approve</button>--%>
                                                            <button class="btn btn-primary" type="button" onclick="checkSelectApproval('LeaveApprovalGridview','EmployeeID','R');">
                                                                Reject</button>
                                                        </div>
                                                        <div class="Table-Header">
                                                        </div>
                                                        <table id="LeaveApprovalGridview" class="scroll">
                                                        </table>
                                                        <div id="LeavepageNavigation" class="scroll" style="text-align: center;">
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div id="approvalpopup" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
                                                aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div style="width: 100%; text-align: right;">
                                                            <a href="#">
                                                                <img src="../../responsive/Images/closebtn.png" onclick="Cancel('approvalpopup')" /></a>
                                                        </div>
                                                        <center>
                        <table>
                            <tr>
                                <td style="width: 22%;">
                                    <label>
                                        comments<strong><font color="red">*</font></strong></label>
                                </td>
                                <td>
                                    <%--dhn 21--%>
                                    <textarea id="Textarea1" class="inputResponsive" required size="48" name="name" value=""></textarea>
                                    <%--<input type=text id="leaveappCommit" class="inputResponsive" required size="48" name="name" value="" />--%>
                                    <%--dhn 21--%>
                                   <%-- <textarea name="message" cols="48" rows="8" id="leaveappCommit" class="inputResponsive"></textarea>--%>
                               </td>
                            </tr>
                        </table> 
                         </center>
                                                        <div style="width: 100%; padding-bottom: 2%;">
                                                            <%--<div style="width: 15%; margin-left: 31%; float: left;">
                                <input type="button" class="btn btn-primary" value="OK" onclick="Approved('LeaveApprovalGridview','EmployeeID')" />
                            </div>
                            <div style="width:30%;margin-left:20%;">
                                <input type="button" class="btn btn-primary" value="Cancel" onclick="Cancel('approvalpopup')" />
                            </div>--%>

                                                            <table style="width: 30%; margin: 0px auto;">
                                                                <tr>
                                                                    <td>
                                                                        <input type="button" class="btn btn-primary" style="float: right" value="OK" onclick="approveBtn()" />
                                                                    </td>
                                                                    <td>
                                                                        <input type="button" class="btn btn-primary" value="Cancel" onclick="Cancel('approvalpopup')" />
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divEntityWorkFlowApprovalParent" class="clsParent ">
                                                <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <%--<div id="divEntityWorkFlowApproval" class="fliplabel"><b class="cslLabel" style="margin-left: 68px;">Entity WorkFlow Approval</b><%--<a style="right: 0px;float:right" id="aEntityWorkFlowApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a></div>--%>
                                                <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <div id="divEntityWorkFlowApprovalAccess" class="clsAccess"></div>
                                                <div id="divEntityWorkFlowApprovalChild" class="clsChild">
                                                    <div class="workflow" style="width: 100%">
                                                        <%--padding-left:147px;margin-top:-10% --%>
                                                        <div style="margin: 3% 0% 2% 3%;" class="margin">
                                                            <button type="button" class="btn btn-primary" onclick="checkSelectApproval('EntityWorkflowApprovalGridview','EmployeeID','A')">
                                                                Approve</button>
                                                            <button type="button" class="btn btn-primary" onclick="checkSelectApproval('EntityWorkflowApprovalGridview','EmployeeID','R')">
                                                                Reject</button>
                                                        </div>
                                                        <div style="float: right; margin-top: -7%; margin-right: 2%;" class="EntityDropdown">
                                                            <select id="dropdownval" name="year" onchange="GetWorkflowEntity()">
                                                            </select>
                                                        </div>
                                                        <div class="Table-Header" style="display: none">
                                                        </div>
                                                        <div class="EntityWorkflowApprovalGridData">
                                                            <table id="EntityWorkflowApprovalGridview" class="scroll">
                                                            </table>
                                                            <div id="pageNavigation" class="scroll" style="text-align: center;">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--dhn--%>

                                                    <%-- dhn--%>
                                                </div>
                                            </div>
                                            <div id="divResourceTimesheetApprovalParent" class="clsParent">
                                                <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <%--<div id="divResourceTimesheetApproval" class="fliplabel"><b class="cslLabel" style="margin-left: 40px;">Timesheet Approval</b><%--<a style="right: 0px;float:right" id="aResourceTimesheetApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a></div>--%>
                                                <%--End of Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <div id="divResourceTimesheetApprovalChild" class="clsChild">
                                                    <div class="workflow" style="width: 100%;">
                                                        <%--padding-left:147px;margin-top:-10%--%>
                                                        <div style="margin: 3% 0% 2% 3%;" class="margin">
                                                            <%--dhn 19--%>
                                                            <%--<button type="button" class="btn btn-primary" onclick="popup('popUpDiv')">
                        Approve</button>
                    <button class="btn btn-primary" type="button">
                        Reject</button>--%>
                                                            <button type="button" class="btn btn-primary" onclick="checkSelectApproval('ResourceTimesheetApprovalgrid','TimeSheetID','A');">
                                                                Approve</button>
                                                            <button class="btn btn-primary" type="button" onclick="checkSelectApproval('ResourceTimesheetApprovalgrid','TimeSheetID','R');">
                                                                Reject</button>
                                                            <%--dhn 19--%>
                                                        </div>
                                                        <div style="float: right; margin-top: -2%; margin-right: 2%;">
                                                            <select id="ddlTimesheet" name="year" onchange="GetTimesheet()">
                                                            </select>
                                                        </div>
                                                        <div id="divResourceTimesheetApprovalAccess" class="clsAccess"></div>
                                                        <div class="Table-Header">
                                                        </div>
                                                        <table id="ResourceTimesheetApprovalgrid" class="scroll" style="max-height: 200px">
                                                        </table>
                                                        <div id="onResourceTimesheetApprovalpagging" class="scroll" style="text-align: center;">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divExpenseApprovalParent" class="clsParent ">
                                                <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <%--<div id="divExpenseApproval" class="fliplabel"><b class="cslLabel" style="margin-left: 49px;">My Expense Approval</b><%--<a style="right: 0px;float:right" id="aExpenseApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a></div>--%>
                                                <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <div id="divExpenseApprovalAccess" class="clsAccess"></div>
                                                <div id="divExpenseApprovalChild" class="clsChild">
                                                    <div class="workflow" style="width: 100%;">
                                                        <%--margin-top:-10%;    padding-left:147px;--%>
                                                        <div style="margin: 3% 0% 2% 3%;" class="margin">
                                                            <button class="btn btn-primary" type="button" onclick="checkSelectApproval('ExpenseApprovalGridview','ExpensesEntryID','A')">
                                                                Approve</button>
                                                            <button class="btn btn-primary" type="button" onclick="checkSelectApproval('ExpenseApprovalGridview','ExpensesEntryID','R')">
                                                                Reject</button>
                                                        </div>
                                                        <%--<div style="float: right; margin-top: -2%; margin-right: 2%;">
                                                            <select id="ddlExpense" name="year" onchange="GetExpense()">
                                                            </select>
                                                        </div>--%>

                                                        <div class="Table-Header">
                                                        </div>
                                                        <div class="ExpenseAppraovalGridData">
                                                            <table id="ExpenseApprovalGridview" class="scroll">
                                                            </table>
                                                            <div id="ExpensepageNavigation" class="scroll" style="text-align: center;">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divHelpDeskApprovalParent" class="clsParent ">
                                                <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <%--<div id="divLeaveApproval" class="fliplabel"><b class="cslLabel">Leave Approval</b><%--<a style="right: 0px;float:right" id="aLeaveApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a></div>--%>
                                                <%--End of Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                                                <div id="divHelpDeskApprovalAccess" class="clsAccess"></div>
                                                <div id="divHelpDeskApprovalChild" class="clsChild">
                                                    <div class="workflow" style="width: 100%;">
                                                        <%--padding-left:147px;margin-top:-10%--%>
                                                        <div style="margin: 3% 0% 2% 3%;" class="margin">
                                                            <%--   <button class="btn" type="button" onclick="Approved('LeaveApprovalGridview','EmployeeID')">--%>
                                                            <a data-toggle="modal" class="btn btn-primary" onclick="checkSelectApproval('tblHelpDeskApproval','QueryID','A');">Approve</a>
                                                            <%--   Approve</button>--%>
                                                            <button class="btn btn-primary" type="button" onclick="checkSelectApproval('tblHelpDeskApproval','QueryID','R');">
                                                                Reject</button>
                                                        </div>
                                                        <div class="Table-Header">
                                                        </div>
                                                        <table id="tblHelpDeskApproval" class="scroll">
                                                        </table>
                                                        <div id="divHelpDeskApproval" class="scroll" style="text-align: center;">
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>


                        </td>

                        <%--dhn Graph 21--%>
                    </tr>
                </table>
                <%--End of Add Tejas 02March--%>

                <%-- <div class="content">
        <div class="center-caption">
          My Pending Approval<br />
        </div>--%>
            </div>

            <div id="mailBoxpopup" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
                aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div style="width: 100%; text-align: right;">
                            <a href="#">
                                <img src="../responsive/Images/closebtn.png" onclick="Cancel('mailBoxpopup')" /></a>
                        </div>
                        <center><label><h4><b>Send Email </b></h4></label></center>
                        <table style="margin-left: 7%;">
                            <tr>
                                <td>
                                    <label>
                                        From<strong>*</strong></label>
                                </td>
                                <td>
                                    <input type="text" name="name" id="from" class="inputResponsive" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        To<strong>*</strong></label>
                                </td>
                                <td>
                                    <input type="text" name="name" id="to" class="inputResponsive" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        CC</label>
                                </td>
                                <td>
                                    <input type="text" name="name" id="cc" class="inputResponsive" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        Subject <strong>*</strong></label>
                                </td>
                                <td>
                                    <input type="text" name="name" id="mailsubject" class="inputResponsive" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        Note <strong>*</strong></label>
                                </td>
                                <td>
                                    <label>
                                        The valid separators for the Email IDs are space(" "), comma(",") and semi-colon(";").</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        Message <strong>*</strong></label>
                                </td>
                                <td>
                                    <textarea name="message" cols="48" rows="8" id="message" class="inputResponsive"
                                        runat="server"></textarea>
                                </td>
                            </tr>
                        </table>
                        <div class="leave-btn-cls-M">
                            <div class="leave-btn-cls-M-sub">
                                <table class="tblBtn">
                                    <tr>
                                        <td>
                                            <input type="button" class="btn btn-primary" value="Send" onclick="SendMail()" style="margin-left: 70%;" />
                                            <asp:Button ID="sendemailbtn" class="btn btn-primary" runat="server" Text="send"
                                                OnClick="sendemailbtn_Click" Visible="false" />
                                        </td>
                                        <td style="text-align: center">
                                            <input type="button" value="Cancel" class="btn btn-primary" onclick="Cancel('mailBoxpopup')" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div>
                        </div>
                    </div>
                </div>
            </div>
            <%--<div id="divfooter" class="footbar" >@Copyright 2014</div>--%>

            <nav id="menu">
                <ul>

                    <li><a href="../General/Navigation.aspx?FromWhere=DB" id="Hhome">
                        <img src="../../responsive/images/home.gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Home</a></li>
                    <li><a href="MyApproval.aspx" id="A1">
                        <img src="../../responsive/images/Project .gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;My Approval </a></li>

                    <%--  <li><a href="Projects.aspx" id="Hproject">
                            <img src="../../responsive/images/Project .gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Project </a></li>
                    --%>
                    <li><a href="../PM/PM_DailyActivity.aspx">
                        <img src="../../responsive/images/time.gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;TimeSheet Entry</a></li>

                </ul>
            </nav>
        </div>
    </div>
    </div>
    <input type="hidden" id="ids" runat="server" />
    <script>

        window.onload = function () {

            if (WhichBrowser() == 'FF')
                document.getElementById("page1").style.height = window.innerHeight - 16 + 'px';
            else
                document.getElementById("page1").style.height = window.innerHeight - 9 + 'px';
            //var closeInterval = 0;
            //var myInterval= setInterval(function () {
            //        if($("#AllApprovalGraph canvas").length != 0)
            //        {
            //            closeInterval = 1
            //        }
            //        if (closeInterval == 1) {
            //            $("#AllApprovalGraph canvas").each(function (id, val) {
            //                if (id == 2) {
            //                    $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            //                    $(this).css("background-size", "390px,342px");
            //                }
            //            });
            //            $("#leaveGraph canvas").each(function (id, val) {
            //                if (id == 2) {
            //                    $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            //                    $(this).css("background-size", "390px,342px");
            //                }
            //            });
            //            clearInterval(myInterval);
            //        }
            //    }, 2000);
            //document.getElementById("GraphHeaderApproval").style.left = -26 + "px";
            //if ($(window).width() < 1200) {
            //    document.getElementById("AllApprovalGraph").style.marginLeft = "0%";
            //    document.getElementById("leaveGraph").style.marginLeft = "0%";
            //    //Commented by Tejas Rasage on 09-March-2016
            //    //document.getElementById("ExpenseGraph").style.marginLeft = "0%";
            //    //document.getElementById("TimesheetGraph").style.marginLeft = "0%";
            //    //document.getElementById("EntityGraph").style.marginLeft = "0%";
            //    //End of Commented by Tejas Rasage on 09-March-2016
            //}
            //else {
            //    document.getElementById("AllApprovalGraph").style.marginLeft = "10%";
            //    document.getElementById("leaveGraph").style.marginLeft = "10%";
            //    //Commented by Tejas Rasage on 09-March-2016
            //    //document.getElementById("ExpenseGraph").style.marginLeft = "10%";
            //    //document.getElementById("TimesheetGraph").style.marginLeft = "10%";
            //    //document.getElementById("EntityGraph").style.marginLeft = "10%";
            //    //End of Commented by Tejas Rasage on 09-March-2016
            //}
            //if (WhichBrowser()!='IE')
            //    AdjustStyle()


            //$("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; setFrameLoaded() });

            //$("#divLeaveApproval").click(function () {
            //    if (document.getElementById("divLeaveApprovalChild").style.display == "block") {
            //        $("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto"; });
            //    }
            //    else {
            //        $("#divLeaveApprovalChild").fadeIn("slow", function () {
            //            document.getElementById("divLeaveApprovalChild").style.display = "block";
            //            if (document.getElementById("MyProfile").style.display == "none")
            //                document.getElementById("divLeaveApprovalParent").style.height = "auto"
            //            else
            //                document.getElementById("divLeaveApprovalParent").style.height = "100%"
            //        });


            //    }
            //});
            $("#divLeaveApprovalChild").fadeOut("fast", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; setFrameLoaded() });

            //Added By Vaijat K For Click Function to show Leave Details 
            $("#divLeaveApproval").click(function () {
                objEntitySelection = 1;
                setFrameLoader();
                clearBoxShadow()
                $("#divLeaveApproval").css("box-shadow", "1px 1px 1px 1px #CCC");
                document.getElementById("tblshow").style.display = "block";
                HideDiv();
                document.getElementById("tblApprovalAgeing").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none"
                document.getElementById("divResourceTimesheetApprovalChild").style.display = "none"
                document.getElementById("divExpenseApprovalChild").style.display = "none"
                document.getElementById("divHelpDeskApprovalChild").style.display = "none"
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "";

                document.getElementById("divLeaveApprovalAccess").innerHTML = "";

                document.getElementById("divExpenseApprovalAccess").innerHTML = "";

                document.getElementById("divHelpDeskApprovalAccess").innerHTML = "";

                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
                document.getElementById("tdOverall").style.display = "none";
                document.getElementById("tdDetails").style.display = "";
                ////Added by Tejas R on 09-March-2016 Purpose:UI Change
                //DrawPieChartForLeaveApprovalAction();
                ////Added by Tejas R on 09-March-2016 Purpose:UI Change
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval_Home.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID")%>', intTagID: 1209 }),
                    contentType: 'application/json;charset-utf=8',
                    async: false,
                    success: function (Result) {
                        if (String(Result.d) == "1") {

                            //if (document.getElementById("divLeaveApprovalChild").style.display == "block") {
                            //    $("#divLeaveApprovalChild").fadeOut("fast", function () {
                            //        document.getElementById("divLeaveApprovalChild").style.display = "none";
                            //        document.getElementById("divLeaveApprovalParent").style.height = "auto";
                            //        $("#P4").css("display", "block");
                            //        //setTimeout(function () { GetAllGraph() }, 500);
                            //        //$("#tdGraph").css("float", "right");
                            //        //document.getElementById("tblAllApprovalGraph").style.display = "";
                            //        //document.getElementById("tblApprovalAgeing").style.display = "";
                            //        //DrawApprovalAgeingGraph('Leave');
                            //        //$(".margin1").css("margin-top", "-4%");
                            //        $("#div01").click();
                            //    });
                            //}
                            //else {
                            $("#P4").css("display", "none");
                            document.getElementById("divLeaveApprovalChild").style.display = "block";
                            if (document.getElementById("MyProfile").style.display == "none")
                                document.getElementById("divLeaveApprovalParent").style.height = "auto";
                            else
                                document.getElementById("divLeaveApprovalParent").style.height = "100%";

                            document.getElementById("tblAllApprovalGraph").style.display = "none";
                            $(".margin1").css("margin-top", "0%");
                            //$("#tdGraph").css("float", "left");
                            LeaveApprovalTest();

                            assignImage();
                            // }
                        }
                        else {
                            //if (document.getElementById("divLeaveApprovalAccess").innerHTML == "") {

                            document.getElementById("divLeaveApprovalAccess").innerHTML = "You do not have access";
                            //}
                            //else {
                            //    $("#divLeaveApprovalAccess").fadeOut("fast", function () {
                            //        document.getElementById("divLeaveApprovalAccess").innerHTML = "";
                            //    });
                            //}
                        }
                    }
                });
                DrawPieChartForLeaveApprovalAction();
                //setTimeout(function () { RemoveFrameLoader(); }, 1000);
            });

            $(document).ajaxStop(function (a) {
                setTimeout(function () { RemoveFrameLoader(); }, 1000);
            });
            //End Of Addtion by Vaijat K
            document.getElementById("MyProfile1").style.display = "none";
            $(document).removeAttr("height")

            $("#divEntityWorkFlowApprovalChild").fadeOut("fast", function () {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none"; setFrameLoaded()
            });
            //Added By Vaijat K For Click Function to show Entity Details 
            $("#divEntityWorkFlowApproval").click(function () {
                objEntitySelection = 2;
                setFrameLoader();
                clearBoxShadow()
                $("#divEntityWorkFlowApproval").css("box-shadow", "1px 1px 1px 1px #CCC");
                document.getElementById("dropdownval").value = 32;
                document.getElementById("tblshow").style.display = "block";
                document.getElementById("tdOverall").style.display = "none";
                document.getElementById("tdDetails").style.display = "";
                HideDiv();
                document.getElementById("tblApprovalAgeing").style.display = "none";
                document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto";
                document.getElementById("divResourceTimesheetApprovalChild").style.display = "none";
                document.getElementById("divExpenseApprovalChild").style.display = "none";
                document.getElementById("divHelpDeskApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "";

                document.getElementById("divLeaveApprovalAccess").innerHTML = "";

                document.getElementById("divExpenseApprovalAccess").innerHTML = "";

                document.getElementById("divHelpDeskApprovalAccess").innerHTML = "";

                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval_Home.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID")%>', intTagID: 3936 }),
                    contentType: 'application/json;charset-utf=8',
                    async: false,
                    success: function (Result) {
                        if (String(Result.d) == "1") {

                            //if (document.getElementById("divEntityWorkFlowApprovalChild").style.display == "block") {
                            //    $("#divEntityWorkFlowApprovalChild").fadeOut("fast", function () {
                            //        document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                            //        // $("#DivGraphInfo").css("display", "block");
                            //        $("#P4").css("display", "block");
                            //        //setTimeout(function () { GetAllGraph() }, 500);
                            //        //$("#tdGraph").css("float", "right");
                            //        //document.getElementById("tblAllApprovalGraph").style.display = "";
                            //        //document.getElementById("tblApprovalAgeing").style.display = "";
                            //        //DrawApprovalAgeingGraph('Entity');
                            //        //$(".margin1").css("margin-top", "-4%");
                            //        $("#div01").click();
                            //    });
                            //}
                            //else {
                            document.getElementById("divEntityWorkFlowApprovalChild").style.display = "block";
                            // $("#DivGraphInfo").css("display", "none");
                            $("#P4").css("display", "none");
                            document.getElementById("tblAllApprovalGraph").style.display = "none";
                            //$(".margin1").css("margin-top", "0%");
                            //$("#tdGraph").css("float", "left");
                            EntityWorkflowApproval();

                            assignImage();
                            //}
                        }
                        else {
                            //if (document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML == "") {
                            $("#divEntityWorkFlowApprovalAccess").fadeIn("fast", function () {
                                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "You do not have access";
                            });
                            //}
                            //else {
                            //    $("#divEntityWorkFlowApprovalAccess").fadeOut("fast", function () {
                            //        document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "";
                            //    });
                            //}
                        }
                    }
                });

                DrawPieChartForEntityApprovalAction();
                //$(document).ajaxStop(function () {
                //    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //});

            });
            //End Of Addtion by Vaijat K



            //$("#divExpenseApproval").click(function () {

            //    if (document.getElementById("divExpenseApprovalChild").style.display == "block") {
            //        $("#divExpenseApprovalChild").fadeOut("slow", function () {
            //            document.getElementById("divExpenseApprovalChild").style.display = "none";
            //        });
            //    }
            //    else {
            //        $("#divExpenseApprovalChild").fadeIn("slow", function () {
            //            document.getElementById("divExpenseApprovalChild").style.display = "block"
            //        });
            //    }

            //});
            //Added By Vaijat K For Click Function to show Expense Details 
            $("#divExpenseApproval").click(function () {
                objEntitySelection = 3;
                setFrameLoader();
                clearBoxShadow()
                $("#divExpenseApproval").css("box-shadow", "1px 1px 1px 1px #CCC");
                document.getElementById("tblshow").style.display = "block";
                HideDiv();
                document.getElementById("tblApprovalAgeing").style.display = "none";
                document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto";
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divResourceTimesheetApprovalChild").style.display = "none";
                document.getElementById("divHelpDeskApprovalChild").style.display = "none"
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "";

                document.getElementById("divLeaveApprovalAccess").innerHTML = "";

                document.getElementById("divExpenseApprovalAccess").innerHTML = "";

                document.getElementById("divHelpDeskApprovalAccess").innerHTML = "";

                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
                document.getElementById("tdOverall").style.display = "none";
                document.getElementById("tdDetails").style.display = "";
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval_Home.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID")%>', intTagID: 3595 }),
                    contentType: 'application/json;charset-utf=8',
                    async: false,
                    success: function (Result) {
                        if (String(Result.d) == "1") {

                            //if (document.getElementById("divExpenseApprovalChild").style.display == "block") {
                            //    $("#divExpenseApprovalChild").fadeOut("fast", function () {
                            //        document.getElementById("divExpenseApprovalChild").style.display = "none";
                            //        //$("#DivGraphInfo").css("display", "block");
                            //        $("#P4").css("display", "block");
                            //        //setTimeout(function () { GetAllGraph() }, 500);
                            //        //$("#tdGraph").css("float", "right");
                            //        //document.getElementById("tblAllApprovalGraph").style.display = "";
                            //        //document.getElementById("tblApprovalAgeing").style.display = "";
                            //        //DrawApprovalAgeingGraph('Expense');
                            //        //$(".margin1").css("margin-top", "-4%");
                            //        $("#div01").click();
                            //    });
                            //}
                            //else {

                            document.getElementById("divExpenseApprovalChild").style.display = "block";
                            //$("#DivGraphInfo").css("display", "none");
                            $("#P4").css("display", "none");
                            document.getElementById("tblAllApprovalGraph").style.display = "none";
                            //$(".margin1").css("margin-top", "0%");
                            //$("#tdGraph").css("float", "left");
                            ExpenseApproval();

                            //}
                        }
                        else {
                            //if (document.getElementById("divExpenseApprovalAccess").innerHTML == "") {

                            document.getElementById("divExpenseApprovalAccess").innerHTML = "You do not have access";
                            //}
                            //else {
                            //  $("#divExpenseApprovalAccess").fadeOut("fast", function () {
                            //      document.getElementById("divExpenseApprovalAccess").innerHTML = "";
                            //  });
                            //}
                        }
                    }
                });

                DrawPieChartForExpenseApprovalAction();
                //setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //$(document).ajaxStop(function () {
                //    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //});
            });
            //End of Addtion by Vaijat K
            //$("#divResourceTimesheetApproval").click(function () {
            //    //dhn 19
            //    var myData = jQuery("#ResourceTimesheetApprovalgrid").jqGrid('getRowData');
            //    if (myData.length > 0) {
            //        for (var i = 0; i < myData.length; i++) {
            //            if (myData[i]["StatusDescription"] == "Approved") {
            //                document.getElementById("jqg_ResourceTimesheetApprovalgrid_" + (i + 1)).disabled = true;
            //            }
            //            else if (myData[i]["StatusDescription"] == "Rejected") {
            //                document.getElementById("jqg_ResourceTimesheetApprovalgrid_" + (i + 1)).disabled = true;
            //            }
            //        }
            //    }
            //    //dhn 19
            //    if (document.getElementById("divResourceTimesheetApprovalChild").style.display == "block") {
            //        $("#divResourceTimesheetApprovalChild").fadeOut("slow", function () {
            //            document.getElementById("divResourceTimesheetApprovalChild").style.display = "none";
            //        });
            //    }
            //    else {
            //        $("#divResourceTimesheetApprovalChild").fadeIn("slow", function () {
            //            document.getElementById("divResourceTimesheetApprovalChild").style.display = "block"
            //        });
            //    }

            //});
            //Added By Vaijat K For Click Function to show Timesheet Details 
            $("#divResourceTimesheetApproval").click(function () {
                objEntitySelection = 4;
                setFrameLoader();
                clearBoxShadow()
                document.getElementById("tdOverall").style.display = "none";
                document.getElementById("tdDetails").style.display = "";
                $("#divResourceTimesheetApproval").css("box-shadow", "1px 1px 1px 1px #CCC");
                document.getElementById("ddlTimesheet").value = 1;
                document.getElementById("tblshow").style.display = "block";
                HideDiv();
                document.getElementById("tblApprovalAgeing").style.display = "none";
                document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto"
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none"
                document.getElementById("divExpenseApprovalChild").style.display = "none";
                document.getElementById("divHelpDeskApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "";
                document.getElementById("divLeaveApprovalAccess").innerHTML = "";
                document.getElementById("divExpenseApprovalAccess").innerHTML = "";
                document.getElementById("divHelpDeskApprovalAccess").innerHTML = "";
                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
                //if (document.getElementById("divResourceTimesheetApprovalChild").style.display == "block") {
                //    $("#divResourceTimesheetApprovalChild").fadeOut("slow", function () {
                //        document.getElementById("divResourceTimesheetApprovalChild").style.display = "none";
                //        // $("#DivGraphInfo").css("display", "block");
                //        $("#P4").css("display", "block");
                //        //$("#tdGraph").css("float", "right");
                //        // setTimeout(function () { GetAllGraph() }, 100);
                //        //document.getElementById("tblAllApprovalGraph").style.display = "";
                //        //document.getElementById("tblApprovalAgeing").style.display = "";
                //        //DrawApprovalAgeingGraph('Timesheet');
                //        //$(".margin1").css("margin-top", "-4%");
                //        $("#div01").click();
                //    });
                //}
                //else {
                document.getElementById("ddlTimesheet").disabled = false;
                document.getElementById("divResourceTimesheetApprovalChild").style.display = "block";
                // $("#DivGraphInfo").css("display", "none");
                $("#P4").css("display", "none");
                document.getElementById("tblAllApprovalGraph").style.display = "none";
                //$(".margin1").css("margin-top", "0%");
                //$("#tdGraph").css("float", "left");
                //GetResourceTimesheetApproval();
                document.getElementById("ddlTimesheet").value = '1';
                GetTimesheet();
                assignImage()
                //}
                DrawPieChartForTimesheetApprovalAction();
                //setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //$(document).ajaxStop(function () {
                //    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //});
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval_Home.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 42 }),
                    contentType: 'application/json;charset-utf=8',
                    async: false,
                    success: function (Result) {
                        if (String(Result.d) == "1") {

                        }
                        else {
                            document.getElementById("ddlTimesheet").disabled = true;
                        }
                    }
                 });
            });
            //End Of Addition
            //Added By Vaijat K For Click Function to show HelpDesk Details 
            $("#divHelpDesk").click(function () {
                objEntitySelection = 5;
                setFrameLoader();
                clearBoxShadow()
                $("#divHelpDesk").css("box-shadow", "1px 1px 1px 1px #CCC");
                HideDiv();
                document.getElementById("tdOverall").style.display = "none";
                document.getElementById("tdDetails").style.display = "";
                document.getElementById("tblApprovalAgeing").style.display = "none";
                document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto"
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divExpenseApprovalChild").style.display = "none";
                document.getElementById("divResourceTimesheetApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "";

                document.getElementById("divLeaveApprovalAccess").innerHTML = "";

                document.getElementById("divExpenseApprovalAccess").innerHTML = "";

                document.getElementById("divHelpDeskApprovalAccess").innerHTML = "";

                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
                document.getElementById("tblshow").style.display = "block";
                //3753
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval_Home.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID")%>', intTagID: 405 }),
                    contentType: 'application/json;charset-utf=8',
                    async: false,
                    success: function (Result) {
                        if (String(Result.d) == "1") {
                            //if (document.getElementById("divHelpDeskApprovalChild").style.display == "block") {
                            //    $("#divHelpDeskApprovalChild").fadeOut("slow", function () {
                            //        document.getElementById("divHelpDeskApprovalChild").style.display = "none";
                            //        // $("#DivGraphInfo").css("display", "block");
                            //        $("#P4").css("display", "block");
                            //        //$("#tdGraph").css("float", "right");
                            //        //setTimeout(function () { GetAllGraph() }, 100);
                            //        //document.getElementById("tblAllApprovalGraph").style.display = "";
                            //        //document.getElementById("tblApprovalAgeing").style.display = "";
                            //        //DrawApprovalAgeingGraph('HelpDesk');
                            //        $("#div01").click();
                            //        //$(".margin1").css("margin-top", "-4%");

                            //    });
                            //}
                            //else {
                            document.getElementById("divHelpDeskApprovalChild").style.display = "block";
                            // $("#DivGraphInfo").css("display", "none");
                            $("#P4").css("display", "none");
                            document.getElementById("tblAllApprovalGraph").style.display = "none";
                            //$(".margin1").css("margin-top", "0%");
                            //$("#tdGraph").css("float", "left");
                            PendingHelpDeskApproval();

                            assignImage()
                            // }
                        }
                        else {
                            // if (document.getElementById("divHelpDeskApprovalAccess").innerHTML == "") {
                            document.getElementById("divHelpDeskApprovalAccess").innerHTML = "You do not have access";
                            //}
                            //else {
                            //    $("#divHelpDeskApprovalAccess").fadeOut("fast", function () {
                            //        document.getElementById("divHelpDeskApprovalAccess").innerHTML = "";
                            //    });
                            //}
                        }
                    }
                });
                DrawPieChartForHelpDeskApprovalAction()
                //setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //$(document).ajaxStop(function () {
                //    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //});
            });
            //End Of Addition By Vaijat k
            //Added By Vaijat K For Click Function to show Overall Details 
            $("#divOverAll").click(function () {
                objEntitySelection = 0;
                setFrameLoader();
                clearBoxShadow();
                modeForAge = 0;
                $("#divOverAll").css("box-shadow", "1px 1px 1px 1px #CCC");
                // $("#divLeaveApprovalChild").fadeOut("fast", function () {
                document.getElementById("divLeaveApprovalChild").style.display = "none"; //document.getElementById("divLeaveApprovalParent").style.height = "auto"
                // });
                // $("#divEntityWorkFlowApprovalChild").fadeOut("fast", function () {
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none"
                // });
                //$("#divExpenseApprovalChild").fadeOut("fast", function () {
                document.getElementById("divExpenseApprovalChild").style.display = "none"
                //});
                //$("#divResourceTimesheetApprovalChild").fadeOut("fast", function () {
                document.getElementById("divResourceTimesheetApprovalChild").style.display = "none"
                //});
                ///$("#divHelpDeskApprovalChild").fadeOut("fast", function () {
                document.getElementById("divHelpDeskApprovalChild").style.display = "none"
                //});
                HideDiv();
                document.getElementById("lblNote").style.display = "block";
                document.getElementById("tblAllApprovalGraph").style.display = "block";
                document.getElementById("tblApprovalAgeing").style.display = "";
                document.getElementById("tdOverall").style.display = "";
                document.getElementById("tdDetails").style.display = "none";
                document.getElementById("tblshow").style.display = "none";
                document.getElementById("DivApprovalAgeing").style.marginLeft = "10px"
                document.getElementById("P1").style.marginLeft = "26px"
                //$("#tdGraph").css("float", "right");
                if (arr[0] == 'Leave') {
                    DrawPieChartForLeaveApprovalAction();
                }
                else if (arr[0] == 'Expense') {
                    DrawPieChartForExpenseApprovalAction();
                }
                else if (arr[0] == 'Timesheet') {
                    DrawPieChartForTimesheetApprovalAction();
                }
                else if (arr[0] == 'Entity') {
                    DrawPieChartForEntityApprovalAction();
                }
                else if (arr[0] == 'HelpDesk') {
                    DrawPieChartForHelpDeskApprovalAction();
                }
                DrawPieChartForAllApprovalAction();
                DrawApprovalAgeingGraph('Overall');
               
                //$(".margin1").css("margin-top", "-4%");
                //setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //$(document).ajaxStop(function () {
                //    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                //});
            })

            //End of Addition by Vaijat K


            //if (WhichBrowser() == "FF") {
            //    $(".margin1").css("margin-top", "5px");
            //}
            //else if (WhichBrowser() == "CR") {
            //    $(".margin1").css("margin-top", "5px");
            //}
            //else if (WhichBrowser() == "IE") {
            //    $(".margin1").css("margin-top", "5px");
            //}
            //else {
            //    $(".margin1").css("margin-top", "5px");
            //}
            //if ($(window).width() < 1000 && $(window).width() > 900) {
            //if ($(window).width() < 1000) {
            //    if (WhichBrowser() == "FF") {
            //        //$(".shadow1").css("width", "390px");
            //        $("#P4").css("left", "431px");
            //        $("#DivGraphInfo").css("margin-top", "22px");
            //    }
            //    else if (WhichBrowser() == "CR") {
            //        //$(".shadow1").css("width", "400px");
            //        $("#P4").css("left", "401px");
            //        $("#DivGraphInfo").css("margin-top", "22px");
            //    }
            //    else {
            //        //$(".shadow1").css("width", "400px");
            //        $("#P4").css("left", "401px");
            //        $("#DivGraphInfo").css("margin-top", "29px");
            //    }
            //    //pGraphHeight(350, 340, 0);
            //    //pGraphHeight(350, 325, 1);
            //    //pGraphHeight(350, 325, 2);
            //    //pGraphHeight(350, 375, 3);
            //    //pGraphHeight(350, 355, 4);
            //}
            //else if ($(window).width() < 900) {
            //    if (WhichBrowser() == "FF") {
            //        $(".shadow1").css("width", "300px");
            //        $("#P4").css("left", "431px");
            //    }
            //    else {
            //        $(".shadow1").css("width", "310px");
            //        $("#P4").css("left", "401px");
            //    }
            //    pGraphHeight(290, 280, 0);
            //    pGraphHeight(290, 265, 1);
            //    pGraphHeight(290, 265, 2);
            //    pGraphHeight(290, 315, 3);
            //    pGraphHeight(290, 295, 4);
            //}
            //else if ($(window).width() < 1200) {
            //    if (WhichBrowser() == "FF") {
            //        //$(".shadow1").css("width", "440px");
            //        $("#P4").css("left", "481px");
            //    }
            //    else {
            //        //$(".shadow1").css("width", "450px");
            //        $("#P4").css("left", "451px");
            //    }
            //    //pGraphHeight(400, 390, 0);
            //    //pGraphHeight(400, 375, 1);
            //    //pGraphHeight(400, 375, 2);
            //    //pGraphHeight(400, 425, 3);
            //    //pGraphHeight(400, 405, 4);
            //}
            //else {
            //    if (WhichBrowser() == "FF") {
            //        //$(".shadow1").css("width", "500px");
            //        //$(".shadow1").css("width", "425px");
            //        $("#P4").css("left", "532px");
            //    }
            //    else {
            //        //$(".shadow1").css("width", "500px");
            //        //$(".shadow1").css("width", "425px");
            //        $("#P4").css("left", "500px");
            //    }
            //    //pGraphHeight(400, 390, 0);
            //    //pGraphHeight(400, 375, 1);
            //    //pGraphHeight(400, 375, 2);
            //    //pGraphHeight(400, 425, 3);
            //    //pGraphHeight(400, 405, 4);
            //}
            ////dhn 21 
            //$(".flip").click(function () {
            //    //alert('Hi');
            //    DrawPieChartForLeaveAction();

            //    $(".panel").fadeToggle(1000);
            //});

            //dhn 21

            //if (WhichBrowser() == "IE" || WhichBrowser() == "Edge 12") {
            //    //$(".margin1").css("margin-top", "9%")
            //}
            //else
            //    //$(".margin1").css("margin-top", "5%")
            //    //$(".margin1").css("margin-top", "-4%")

            //if (WhichBrowser() == "FF") {
            //    $(".content").css("height", "98%");
            //}
            //else {
            //    $(".content").css("height", "100%");
            //}


        }
        function assignImage() {
            $("#leaveGraph canvas").each(function (id, val) {
                if (id == 2) {
                    //if ($("#leaveGraph").height() == 300) {
                    //    //$(this).height(286);
                    //    this.height = "268";
                    //}
                    //else if ($("#leaveGraph").height() == 210) {
                    //    //$(this).height(200);
                    //    this.height = "187";
                    //}
                    //else if ($("#leaveGraph").height() == 190) {
                    //    this.height = "168";
                    //    //$(this).height(179);
                    //}
                    $(this).height("86%");
                    $(this).width("100%");
                    $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
                    $(this).css("background-size", "100%,100%");
                    $(this).css("background-repeat", " no-repeat");
                }
            });
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
            //function GetAllGraph() {
            //    DrawPieChartForAllApprovalAction();
            //    DrawPieChartForEntityApprovalAction();
            //    DrawPieChartForExpenseApprovalAction();
            //    DrawPieChartForLeaveApprovalAction();
            //    DrawPieChartForTimesheetApprovalAction();
            //}

        }

        window.onresize = function () {

            if (WhichBrowser() == 'FF')
                document.getElementById("page1").style.height = window.innerHeight - 16 + 'px';
            else
                document.getElementById("page1").style.height = window.innerHeight - 9 + 'px';


            allScreenResolution();
            if (objEntitySelection == 2) {
                setTimeout(function () {
                    setFrameLoader();
                    document.getElementById("leaveGraph").innerHTML = "";
                    if (objentity != undefined) {
                        DrawPieChartForEntityApproval(objentity);
                    }
                    else {
                        DrawPieChartForEntityApprovalAction();
                    }
                    setFrameLoaded();
                }, 500);
            }
            else if (objEntitySelection == 3) {
                setTimeout(function () {
                    setFrameLoader();
                    document.getElementById("leaveGraph").innerHTML = "";
                    if (objExpense != undefined) {
                        DrawPieChartForExpenseApproval(objExpense);
                    }
                    else
                        DrawPieChartForExpenseApprovalAction();
                    setFrameLoaded();
                }, 500);
            }
            else if (objEntitySelection == 4) {
                setTimeout(function () {
                    setFrameLoader();
                    document.getElementById("leaveGraph").innerHTML = "";
                    if (objTimesheet != undefined) {
                        DrawPieChartForTimesheetApproval(objTimesheet);
                    }
                    else
                        DrawPieChartForTimesheetApprovalAction();
                    setFrameLoaded();
                }, 500);
            }
            else if (objEntitySelection == 5) {
                setTimeout(function () {
                    setFrameLoader();
                    document.getElementById("leaveGraph").innerHTML = "";
                    if (objHelpdesk != undefined) {
                        DrawPieChartForHelpDeskApproval(objHelpdesk);
                    }
                    else {
                        DrawPieChartForHelpDeskApprovalAction();
                    }
                    setFrameLoaded();
                }, 500);
            }
            else if (objEntitySelection == 1) {
                setTimeout(function () {
                    setFrameLoader();
                    document.getElementById("leaveGraph").innerHTML = "";
                    if (objLeave != undefined) {
                        DrawPieChartForLeaveApproval(objLeave);
                    }
                    else {
                        DrawPeChartForLeaveApprovalAction();
                    }
                    setFrameLoaded();
                }, 500);
            }
            else if (objEntitySelection == 0) {
                setTimeout(function () {
                    setFrameLoader();
                    document.getElementById("AllApprovalGraph").innerHTML = "";
                    document.getElementById("DivApprovalAgeing").innerHTML = "";
                    DrawPieChartForAllApprovalAction();
                    $("#tblEntityGraph").css("display", "none");
                    $("#tblExpenseGraph").css("display", "none");
                    $("#tblTimesheetGraph").css("display", "none");
                    var GraphHeaderLeave = $("#GraphHeaderLeave").text();
                    if (modeForAge == 1) {
                        if (objAgeing != undefined) {
                            ApprovalAgeingGraph(objAgeing, 20, 'Leave')
                        }
                        else {
                            DrawApprovalAgeingGraph('Leave');
                        }
                        if (objLeave != undefined) {
                            DrawPieChartForLeaveApproval(objLeave);
                        }
                        else {
                            DrawPieChartForLeaveApprovalAction();
                        }
                    }
                    else if (modeForAge == 2) {
                        if (objAgeing != undefined) {
                            ApprovalAgeingGraph(objAgeing, 20, 'Expense')
                        }
                        else
                            DrawApprovalAgeingGraph('Expense');
                        if (objExpense != undefined) {
                            DrawPieChartForExpenseApproval(objExpense);
                        }
                        else
                            DrawPieChartForExpenseApprovalAction();
                    }
                    else if (modeForAge == 3) {
                        if (objAgeing != undefined) {
                            ApprovalAgeingGraph(objAgeing, 20, 'Timesheet')
                        }
                        else
                            DrawApprovalAgeingGraph('Timesheet');
                        if (objTimesheet != undefined) {
                            DrawPieChartForTimesheetApproval(objTimesheet);
                        }
                        else
                            DrawPieChartForTimesheetApprovalAction()
                    }
                    else if (modeForAge == 5) {
                        if (objAgeing != undefined) {
                            ApprovalAgeingGraph(objAgeing, 20, 'HelpDesk')
                        }
                        else
                            DrawApprovalAgeingGraph('HelpDesk');
                        if (objHelpdesk != undefined) {
                            DrawPieChartForHelpDeskApproval(objHelpdesk);
                        }
                        else
                            DrawPieChartForHelpDeskApprovalAction();
                    }
                    else if (modeForAge == 4) {
                        if (objAgeing != undefined) {
                            ApprovalAgeingGraph(objAgeing, 15, 'Entity')
                        }
                        else
                            DrawApprovalAgeingGraph('Entity');
                        if (objentity != undefined) {
                            DrawPieChartForEntityApproval(objentity);
                        }
                        else
                            DrawPieChartForEntityApprovalAction();
                    }
                    else {
                        if (objAgeing != undefined) {
                            ApprovalAgeingGraph(objAgeing, 15, 'Overall')
                        }
                        else
                            DrawApprovalAgeingGraph('Overall');

                        if (arr[0] == 'Leave') {
                            if (objLeave != undefined) {
                                DrawPieChartForLeaveApproval(objLeave);
                            }
                            else
                                DrawPieChartForLeaveApprovalAction();
                        }
                        else if (arr[0] == 'Expense') {
                            if (objExpense != undefined) {
                                DrawPieChartForExpenseApproval(objExpense);
                            }
                            else
                                DrawPieChartForExpenseApprovalAction();
                        }
                        else if (arr[0] == 'Timesheet') {
                            if (objTimesheet != undefined) {
                                DrawPieChartForTimesheetApproval(objTimesheet);
                            }
                            else
                                DrawPieChartForTimesheetApprovalAction()
                        }
                        else if (arr[0] == 'Entity') {
                            if (objentity != undefined) {
                                DrawPieChartForEntityApproval(objentity);
                            }
                            else
                                DrawPieChartForEntityApprovalAction();
                        }
                        else if (arr[0] == 'HelpDesk') {
                            if (objHelpdesk != undefined) {
                                DrawPieChartForHelpDeskApproval(objHelpdesk);
                            }
                            else
                                DrawPieChartForHelpDeskApprovalAction();
                        }

                    }

                    setFrameLoaded();
                }, 500);
            }



            if ($(window).width() > 720) {
                //document.getElementById("GraphHeaderApproval").style.left = -26 + "px";
                //intPosition = 240;
                //document.getElementById("GraphHeaderApproval").style.right = $(window).width() - 300 + "px";
                //document.getElementById("GraphHeaderLeave").style.left = intPosition + "px";
                //document.getElementById("GraphHeaderEntity").style.left = intPosition + "px";
                //document.getElementById("GraphHeaderExpense").style.left = intPosition + "px";
                //document.getElementById("GraphHeaderTimesheet").style.left = intPosition + "px";
                //if ($(window).width() < 1200) {
                //    document.getElementById("AllApprovalGraph").style.marginLeft = "0%";
                //    document.getElementById("leaveGraph").style.marginLeft = "0%";
                //    //Commented by Tejas Rasage on 09-March-2016
                //    //document.getElementById("ExpenseGraph").style.marginLeft = "0%";
                //    //document.getElementById("TimesheetGraph").style.marginLeft = "0%";
                //    //document.getElementById("EntityGraph").style.marginLeft = "0%";
                //    //End of Commented by Tejas Rasage on 09-March-2016
                //}
                //else {
                //    document.getElementById("AllApprovalGraph").style.marginLeft = "10%";
                //    document.getElementById("leaveGraph").style.marginLeft = "10%";
                //    //Commented by Tejas Rasage on 09-March-2016
                //    //document.getElementById("ExpenseGraph").style.marginLeft = "10%";
                //    //document.getElementById("TimesheetGraph").style.marginLeft = "10%";
                //    //document.getElementById("EntityGraph").style.marginLeft = "10%";
                //    //End of Commented by Tejas Rasage on 09-March-2016
                //}

                //if ($(window).width() < 1000 && $(window).width() > 900) {
                ////if ($(window).width() < 1000) {
                ////    if (WhichBrowser() == "FF") {
                ////        //$(".shadow1").css("width", "390px");
                ////        $("#P4").css("left", "431px");
                ////    }
                ////    else {
                ////        //$(".shadow1").css("width", "400px");
                ////        $("#P4").css("left", "401px");
                ////    }
                ////    //pGraphHeight(350, 340, 0);
                ////    //pGraphHeight(350, 325, 1);
                ////    //pGraphHeight(350, 325, 2);
                ////    //pGraphHeight(350, 375, 3);
                ////    //pGraphHeight(350, 355, 4);
                ////}
                ////    //else if ($(window).width() < 900) {
                ////    //    if (WhichBrowser() == "FF") {
                ////    //        $(".shadow1").css("width", "300px");
                ////    //        $("#P4").css("left", "431px");
                ////    //    }
                ////    //    else {
                ////    //        $(".shadow1").css("width", "310px");
                ////    //        $("#P4").css("left", "401px");
                ////    //    }
                ////    //    pGraphHeight(290, 280, 0);
                ////    //    pGraphHeight(290, 265, 1);
                ////    //    pGraphHeight(290, 265, 2);
                ////    //    pGraphHeight(290, 315, 3);
                ////    //    pGraphHeight(290, 295, 4);
                ////    //}
                ////else if ($(window).width() < 1200) {
                ////    if (WhichBrowser() == "FF") {
                ////        //$(".shadow1").css("width", "440px");
                ////        $("#P4").css("left", "481px");
                ////    }
                ////    else {
                ////        //$(".shadow1").css("width", "450px");
                ////        $("#P4").css("left", "451px");
                ////    }
                ////    //pGraphHeight(400, 390, 0);
                ////    //pGraphHeight(400, 375, 1);
                ////    //pGraphHeight(400, 375, 2);
                ////    //pGraphHeight(400, 425, 3);
                ////    //pGraphHeight(400, 405, 4);
                ////}
                ////else {
                ////    if (WhichBrowser() == "FF") {
                ////        //$(".shadow1").css("width", "500px");
                ////        $("#P4").css("left", "532px");
                ////    }
                ////    else {
                ////        //$(".shadow1").css("width", "500px");
                ////        $("#P4").css("left", "500px");
                ////    }
                //    //pGraphHeight(400, 390, 0);
                //    //pGraphHeight(400, 375, 1);
                //    //pGraphHeight(400, 375, 2);
                //    //pGraphHeight(400, 425, 3);
                //    //pGraphHeight(400, 405, 4);
                //}
            }
        }
    </script>
</body>
</html>
