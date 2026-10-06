<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyApproval.aspx.vb" Inherits="PbNIT.MyApproval" %>

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
<script src="../../responsive/Scripts/jquery-ui.custom.js" type="text/javascript"></script>
<script src="../../responsive/Scripts/jquery.mmenu.min.all.js" type="text/javascript"></script>
<script src="../XMLHttp/AjaxScript.js"></script>
<script src="../../responsive/Scripts/jquery.weekcalendar.js" type="text/javascript"></script>

<link href="../General/Stylesheet_Whiz_Mobile.css" rel="stylesheet" />

<link href="../../responsive/Content/MobileCss.css" rel="stylesheet" />



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
<style type="text/css">
    .ui-th-column {
        border: 0px solid #459DEF !important;
    }

    .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
        border: 0px solid #459DEF !important;
        font-weight: bold !important;
    }

    .ui-jqgrid-bdiv {
        border-bottom: 1px solid #459DEF !important;
        border-top: 1px solid #459DEF !important;
    }

    .ui-jqgrid-htable {
        padding-top: 2%;
    }

    .ui-widget-content {
        border: 1px solid #f6f6f6;
        border-color: #ddd;
        /*text-shadow:0 1px 0 #f3f3f3;*/
    }

    table {
        border-collapse: inherit;
    }

    .clsTRRowEven {
        background-color: white;
    }

    .clsTRRowOdd {
        background-color: #E6F3FF;
    }

    .content {
        /*padding: 16px 2% 23px !important;*/
    }

    .ui-jqgrid tr.ui-row-ltr td {
        border-right-width: 0px !important;
        border-right-style: none !important;
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

    .ui-datepicker {
        width: 98%;
        padding: .2em .2em 0;
        display: none;
        background-color: white;
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

    .ui-jqgrid .ui-pg-selbox {
        height: 22px;
    }

    .clsAccess {
        text-align: center;
        margin-top: 15px;
    }
    /* Width of button is given in pixel.It will not effect any other element of the form*/
</style>

<script type="text/javascript">
    $(function () {

        $('nav#menu').mmenu();
        // $("#mm-0").before("<div style='width:100%;height:100%;background:#F1DCDC'></div>");

        jQuery("#mm-0").before("<div style='width:100%;height:100%;background-image: url(../../img/1920/OpenVCE-Poster-Gold-Background.jpg);'> <table style='margin-left:10%'><tr><td> <img id='imgEmployee'  src='../../img/1920/no-photo.png' alt='No Image' style='margin-top:20px;width:75px;height: 75px;margin-right: 9%;' align='right' /></td><td><label id='cpName' style=color='white';font-weight:100' class='cpHome'></label><br><label id='cpRole' style='font-weight:100' class='cpHome'></label> </td></tr></table> </div>")
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

        window.location = '<%= ResolveUrl("../../default.aspx") %>';
    }

    var path = '<%=ConfigurationManager.AppSettings("WCFTimesheetMServicePath").ToString()%>';
    var GridName;
    var para;
    var ExpenseApprovalpass;
    var LeaveApprovalpass;
    var subgrid_table_id;
    var id;
    var glovalStatus;
    var empparaval = { intEmployeeID: '<%=Session("intUserID").ToString%>', strFilter: 'Employee' };
    var getperiodpass = { intEmployeeID: '<%=Session("intUserID").ToString%>' };
    var Leavecount = 0;
    var Entityworkflowcount = 0;
    var Timesheetcount = 0;
    var Expensecount = 0;
    var HelpDeskCount = 0;

    var objLeaveRoleAccess;
    var objExpenseRoleAccess;
    var objTimesheetRoleAccess;
    var objEntityRoleAccess;
    var objHelpdeskRoleAccess;
    var objResourceTimesheetAccess;
    var objProjectTimesheetAccess;

    function GetLeaveExtraDetails() {

        $.ajax({
            url: path + "GetListLeaveDetailsExtraForDropDown",//not required
            data: LeaveApprovalpass,  // For empty input data use "{}",
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                var thegrid = jQuery("#" + subgrid_table_id)[0];
                thegrid.addJSONData(JSON.parse(result));
            },
            error: function (xhr) {

                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                 <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>

            }

        });
    }
    var arr = [];
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
                    if (objExpenseRoleAccess == 1) {
                        arr.push(["Expense"]);

                    }
                    if (objTimesheetRoleAccess == 1) {
                        arr.push(["Timesheet"]);

                    }
                    if (objEntityRoleAccess == 1) {
                        arr.push(["Entity"]);

                    }
                    if (objHelpdeskRoleAccess == 1) {
                        arr.push(["HelpDesk"]);

                    }
                });
            }
        });
    }
    function EntityWorkflowApproval() {

        $("#EntityWorkflowApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetPendingProjectEntities",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            // data: { intUserID: '<%=Session("intUserID")%>', },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //end of COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Entityworkflowcount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Entityworkflowcount++;
                });
                if (objEntityRoleAccess == 1) {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = Entityworkflowcount;
                }
                else {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = 0;
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'Project Name', 'Start Date', 'End Date', 'Work', 'Created By'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                        { name: 'Project_Name', index: 'Project_Name', align: 'center' },
                    { name: 'Start_Date', index: 'start_Date', align: 'center' },
                    { name: 'End_Date', index: 'End_Date', align: 'center' },
                    { name: 'Work', index: 'Work', align: 'center' },
                    { name: 'Created_By', index: 'Created_By', align: 'center' }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    sortname: 'Project_Name',
                    pager: jQuery('#pageNavigation'),
                    sortorder: "asc",
                    loadonce: true,
                    viewrecords: true,
                    multiselect: true,
                    //caption:"Entity WorkFlow Approval"
                });
                }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {

                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                    <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";


            }
        });

    }
    function LeaveApprovalTest() {
        //alert(1);

        $("#LeaveApprovalGridview").GridUnload();
        var val;
        var Token;

        $.ajax({
            url: path + "GetLeaveDetails",//done
            data: para,  // For empty input data use "{}",
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try{
                Leavecount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Leavecount++;
                });
                if (objLeaveRoleAccess == 1) {
                    document.getElementById('notifyCountLeave').innerHTML = Leavecount;
                }
                else {
                    document.getElementById('notifyCountLeave').innerHTML = 0;
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
                    rowNum: 5,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    //Commented by Vaijat K ON 17/05/2016 For Production Issue
                    //autowidth: true,
                    //Commented by Vaijat K ON 17/05/2016 For Production Issue
                    multiselect: true,
                    loadonce: true,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'IssueID',
                    pager: jQuery('#LeavepageNavigation'),
                    sortorder: "asc",
                    viewrecords: true,
                    //caption: "Leave Approval",
                    loadComplete: function () {
                        $(this).find(">tbody>tr.jqgrow:odd").addClass("clsTRRowEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("clsTRRowOdd");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable>thead").addClass("clsTRColumnHeader");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").addClass("clsGridTable");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").removeClass("ui-jqgrid-htable");
                    },
                    onSelectRow: function (rowId, col, content, e) {
                        var myGrid = $('#LeaveApprovalGridview'),
                        selRowId = myGrid.jqGrid('getGridParam', 'selrow'),
                        empid = myGrid.jqGrid('getCell', selRowId, 'EmployeeID');
                        leaveid = myGrid.jqGrid('getCell', selRowId, 'LeaveID');
                        //leavetype = myGrid.jqGrid ('getCell', selRowId, 'LeaveType');

                        if (empid) {
                            //Commented and added by Nilesh g on 21/3/2016 for Generate Token
                            //LeaveApprovalpass = { LoginID: empid, LeaveID: leaveid };
                            //ShowApprovalDetails();
                            $.ajax({
                                type: 'POST',
                                dataType: 'json',
                                contentType: 'application/json',
                                url: 'MyApproval.aspx/SetWork',
                                data: JSON.stringify({ LoginID: empid, LeaveID: leaveid }),
                                async:false,
                                success: function (Result) {
                                    LeaveApprovalpass = { LoginID: empid, LeaveID: leaveid, pToken: Result.d };
                                    ShowApprovalDetails();
                                },
                                error: function () {
                                    alert("Error")
                                }
                            });
                            //setTimeout(function () {
                            //    ShowApprovalDetails();
                            //}, 500)
                            //end of Commented and added by Nilesh g on 21/3/2016 for Generate Token
                        }

                        else { LeaveApprovalpass = {}; document.getElementById("MyProfile").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto"; }
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

                });
                }
                catch (exception) {
                    document.getElementById("divLeaveApprovalChild").style.display = "none";
                    document.getElementById("divLeaveApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>

                document.getElementById("divLeaveApprovalChild").style.display = "none";
                document.getElementById("divLeaveApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";


            }
        });



    }

    function GenerateTaoken(Result, empid, leaveid) {
        LeaveApprovalpass = { LoginID: empid, LeaveID: leaveid, pToken: Result.d };

    }



    function ExpenseApproval() {
        jQuery("#ExpenseApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetExpenseApprovals",
            data: para,  // For empty input data use "{}",
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Expensecount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Expensecount++;
                });
                if (objExpenseRoleAccess == 1) {
                    document.getElementById('notifyCountExpense').innerHTML = Expensecount;
                }
                else {
                    document.getElementById('notifyCountExpense').innerHTML = 0;
                }
                jQuery("#ExpenseApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ExpenseSheetID', 'ExpensesEntryID', 'EmployeeID', 'Resource Name', 'Project Name', 'Description', 'Expense Title', 'Total Amount', 'isExpense'],
                    colModel: [
                    { name: 'ExpenseSheetID', index: '  ExpenseSheetID', align: 'center', hidden: true },
                    { name: 'ExpensesEntryID', index: 'ExpensesEntryID', align: 'center', hidden: true },
                    { name: 'EmployeeID', index: 'EmployeeID', align: 'center', hidden: true },
                    { name: 'EmployeeName', index: 'EmployeeName', align: 'center' },
                    { name: 'ProjectName', index: 'ProjectName', align: 'center' },
                    { name: 'Description', index: 'Description', align: 'center' },
                    { name: 'Title', index: 'Title', align: 'center' },
                    { name: 'Amount', index: 'Amount', align: 'center' },
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
                        //if (ExpID) {
                        //    ExpenseApprovalpass = { intUserID: '<%=Session("intUserID")%>', ExpenseEntryID: ExpID };
                        //ShowexpenseApprovalDetails();
                        //}
                        //else {
                        //    ExpenseApprovalpass = {};
                        //    document.getElementById("MyProfileExpense").style.display = "none"
                        //}
                        // ExpenseApprovalDetails();
                    },
                    //gridComplete: function () {
                    //    $("#ExpenseApprovalGridview").setSelection('1');
                    //}
                    //caption:"Expense Approval",

                });
                }
                catch (exception) {
                    console.log(exception.message);
                    document.getElementById("divExpenseApprovalChild").style.display = "none";
                    document.getElementById("divExpenseApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later..."
                }
            }
        });

    }
    function GetResourceTimesheetApproval() {
        $("#ResourceTimesheetApprovalgrid").GridUnload();
        $.ajax({
            url: path + "GetPendingTimesheetPendingRequest",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            //  data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //end of COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Entityworkflowcount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Entityworkflowcount++;
                });
                if (objResourceTimesheetAccess == 1) {
                    document.getElementById('notifyCountTimesheet').innerHTML = Entityworkflowcount;
                }
                else {
                    document.getElementById('notifyCountTimesheet').innerHTML = 0;
                }
                jQuery("#ResourceTimesheetApprovalgrid").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['EmployeeID', 'TimeSheetID', 'Resource Name', 'Status Description', 'FromDate', 'ToDate', 'Actual Work'],
                    colModel: [
                    { name: 'EmployeeID', align: 'center', index: 'EmployeeID', hidden: true },
                    { name: 'TimeSheetID', align: 'center', index: 'TimeSheetID', hidden: true },
                    { name: 'EmployeeName', index: 'EmployeeName', align: 'center' },
                    { name: 'StatusDescription', index: 'StatusDescription', align: 'center' },
                    { name: 'FromDate', index: 'FromDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" } },
                    { name: 'ToDate', index: 'ToDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" } },
                    { name: 'Actual_Work', index: 'Actual_Work', align: 'center' }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    sortname: 'TimeSheetID',
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
                        var myGrid = $('#ResourceTimesheetApprovalgrid'),
                        selRowId = myGrid.jqGrid('getGridParam', 'selrow'),
                        EmpID = myGrid.jqGrid('getCell', selRowId, 'EmployeeID'),
                        Projectnm = myGrid.jqGrid('getCell', selRowId, 'ProjectName'),
                        titalval = myGrid.jqGrid('getCell', selRowId, 'Title'),
                        amt = myGrid.jqGrid('getCell', selRowId, 'Amount');

                        ExpenseApprovalpass = { LoginID: '<%=Session("intLoginID").ToString%>', EmployeeID: EmpID, ProjectName: Projectnm, tital: titalval, amount: amt };

                        // ExpenseApprovalDetails();
                    },
                    //caption:"Timesheet Approval",

                });
                }
                catch (exception) {
                    $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
                    document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                    $("#ResourceTimesheetApprovalgrid").GridUnload();
                }

            }
            , error: function (xhr) {
                // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                                    <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>
                // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
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
                url: path + "GetListLeaveDetails", // Location of the service//not done
                data: LeaveApprovalpass,
                contentType: "application/json;charset=utf-8", // content type sent to server
                dataType: "jsonp", //Expected data format from server
                success: function (data) {//On Successfull service call  
                    //set empty table data 
                    $("#dinamictbl").empty();

                    $.each(JSON.parse(data), function (id, obj) {
                        // $("#detailsectionhide").Show(); 
                        //cerate dynamic table with data
                        $("#dinamictbl").append("<tr><td class='innermarg'>Employee Name</td><td class='innermarg'>" + obj.EmployeeName + "</td></tr><tr><td class='innermarg'>Leave Type</td><td class='innermarg'>" + obj.LeaveType + "</td></tr><tr><td class='innermarg'>From Date</td><td class='innermarg'>" + obj.FromDate + "</td></tr><tr><td class='innermarg'>To Date</td><td class='innermarg'>" + obj.ToDate + "</td></tr><tr><td class='innermarg'>Address</td><td class='innermarg'>" + obj.Address + "</td></tr><tr><td class='innermarg'>Phone Number</td><td class='innermarg'>" + obj.Phone_Number + "</td></tr><tr><td>Reason</td><td class='innermarg'>" + obj.Reason + "</td></tr>");
                        return false;
                    });
                    document.getElementById("MyProfile").style.display = "block";
                    document.getElementById("divLeaveApprovalParent").style.height = "626px"

                },
                error: function (xhr) {
                    // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                        <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
                    <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>

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

                },
                error: function (xhr) {
                    // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                     <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
                    <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    <%End If%>
                    // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);


                }
            });
        } catch (exception) { }
        if (document.getElementById("pg_pageNavigation") != null) {
            document.getElementById("pg_pageNavigation").firstChild.setAttribute("style", "width:100% !important");
            document.getElementById("pageNavigation_center").firstChild.setAttribute("style", "width:100% !important");
            document.getElementById("pageNavigation_center").removeAttribute("style");
        }

    }

    function GetTimesheetEntities() {
        document.getElementById("ddlTimesheet").innerHTML = "<option value='1' Selected>Resource</option><option value='2'>Project</option>";
    }


    Date.prototype.toDateInputValue = (function () {
        var local = new Date(this);
        local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
        return local.toJSON().slice(0, 10);

    });

    jQuery(document).ready(function () {
        DrawRoleAccessAllApprovalGraph()
        $("HTML").append("<div id='preloader'></div>");
        $("HTML").append("<div id='fillDiv'></div>");
        //  $("#detailsectionhide").hide();
        //Added by swapnil aswale on 14-12-2015 for Mulitple Login
        if ('<%=Session("LoginType").ToString%>' == 'C') {
            document.getElementsByClassName('MenuContent')[0].style.display = 'none';
            document.getElementById('Authorize').style.display = 'block';
        }
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
        $('#lbl_user').text('<%=Session("strUserName").ToString%>' + "(" + '<%=Session("RoleDesc").ToString%>' + ")");


        $('#applieddate').val(new Date().toDateInputValue());
        var globalstatus;
        //commented and added by Nilesh g on 18/3/2016 for generate token
        //para = { LoginID: '<%=Session("intUserID")%>'}
        para = { LoginID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' };

        //end of commented and added by Nilesh g on 18/3/2016 for generate token


        //          jQuery('#applieddate').val(new Date().toDateInputValue());
        jQuery("#approval").removeClass("box");
        jQuery("#approval").addClass("box active");
        jQuery("#HMyApproval").addClass("current");
        GetTimesheetEntities();
        EntityWorkflowApproval();
        LeaveApprovalTest();
        //GetResourceTimesheetApproval();
        GetTimesheet();
        ExpenseApproval();
        GetworkFlowEntity();
        GetEntityCountAll();
        PendingHelpDeskApproval();
    });

    function MileStoneDetails() {
        $("#EntityWorkflowApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetPendingMilestoneEntities",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            //data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //end of COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Entityworkflowcount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Entityworkflowcount++;
                });
                if (objEntityRoleAccess == 1) {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = Entityworkflowcount;
                }
                else {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = 0;
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'Milestone Name', 'Start Date', 'End Date', 'Project Name', 'Bill Amount'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'MileStone_Name', index: 'MileStone_Name', align: 'center' },
                    {
                        name: 'Start_Date', index: 'Start_Date', align: 'center',
                    },
                    {
                        name: 'End_Date', index: 'End_Date', align: 'center'
                    },
                    { name: 'Project_Name', index: 'Project_Name', align: '' },
                    { name: 'Bill_Amount', index: 'Bill_Amount', align: 'center' }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
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
                    //caption:"Entity WorkFlow Approval"
                });
                }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            }, error: function (xhr) {
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                   <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                    <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";

            }
        });
    }
    function subProject() {

        $("#EntityWorkflowApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetPendingSubProjectEntities",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            //data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //end of COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Entityworkflowcount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Entityworkflowcount++;
                });
                if (objEntityRoleAccess == 1) {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = Entityworkflowcount;
                }
                else {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = 0;
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'Sub Project Name', 'Start Date', 'End Date', 'Project Name', 'Work'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'SubProject_Name', index: 'SubProject_Name', align: 'center' },
                    {
                        name: 'Start_Date', index: 'Start_Date', align: 'center'
                    },
                    {
                        name: 'End_Date', index: 'End_Date', align: 'center'
                    },
                    { name: 'Project_Name', index: 'Project_Name', align: 'center' },
                    { name: 'Work', index: 'Work', align: 'center' }],
                    rowNum: 05,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
                    sortorder: "asc",
                    autoencode: true,
                    viewrecords: true,
                    multiselect: true,
                    loadComplete: function () {
                        $(this).find(">tbody>tr.jqgrow:odd").addClass("clsTRRowEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("clsTRRowOdd");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable>thead").addClass("clsTRColumnHeader");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").addClass("clsGridTable");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").removeClass("ui-jqgrid-htable");
                    },
                    //caption:"Entity WorkFlow Approval"
                });
                }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                   <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                    <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText); s
                <%End If%>
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";

            }
        });
    }
    function ModuleDetails() {
        $("#EntityWorkflowApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetPendingModuleEntities",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            // data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //end of COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Entityworkflowcount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Entityworkflowcount++;
                });
                if (objEntityRoleAccess == 1) {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = Entityworkflowcount;
                }
                else {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = 0;
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'Module Name', 'Start_Date', 'End Date', 'Project Name', 'Work'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'Module_Name', index: 'Module_Name', align: 'center' },
                    { name: 'Start_Date', index: 'Start_Date', align: 'center' },
                    { name: 'End_Date', index: 'End_Date', align: 'center' },
                    { name: 'Project_Name', index: 'Project_Name', align: 'center' },
                    { name: 'Work', index: 'Work', align: 'center' }],
                    rowNum: 05,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
                    sortorder: "asc",
                    autoencode: true,
                    viewrecords: true,
                    multiselect: true,
                    loadComplete: function () {
                        $(this).find(">tbody>tr.jqgrow:odd").addClass("clsTRRowEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("clsTRRowOdd");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable>thead").addClass("clsTRColumnHeader");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").addClass("clsGridTable");
                        //$("#gbox_LeaveApprovalGridview").find(".ui-jqgrid-htable").removeClass("ui-jqgrid-htable");
                    },
                    //caption:"Entity WorkFlow Approval"
                });
                }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                   <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                    <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";

            }
        });
    }
    function DeliverablesDetails() {
        $("#EntityWorkflowApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetPendingDeliverableEntities",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            // data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //end of COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Entityworkflowcount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Entityworkflowcount++;
                });
                if (objEntityRoleAccess == 1) {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = Entityworkflowcount;
                }
                else {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = 0;
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'Title', 'Start_Date', 'End Date', 'Project Name', 'Status'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'Title', index: 'Title', align: 'center' },
                    {
                        name: 'Start_Date', index: 'Start_Date', align: 'center'
                    },
                    {
                        name: 'End_Date', index: 'End_Date', align: 'center'
                    },
                    { name: 'Project_Name', index: 'Project_Name', align: 'center' },
                    { name: 'Status', index: 'Status', align: 'center' }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
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
                    //caption:"Entity WorkFlow Approval"
                });
                }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                   <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                    <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";

            }
        });
    }
    function ChangeRequest() {
        $("#EntityWorkflowApprovalGridview").GridUnload();
        $.ajax({
            url: path + "GetPendingChangeRequestEntities",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            //data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //end of COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            dataType: "jsonp",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                Entityworkflowcount = 0;
                $.each(JSON.parse(result), function (id, obj) {
                    Entityworkflowcount++;
                });
                if (objEntityRoleAccess == 1) {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = Entityworkflowcount;
                }
                else {
                    document.getElementById('notifyCountEntityworkflow').innerHTML = 0;
                }
                jQuery("#EntityWorkflowApprovalGridview").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result),
                    colNames: ['ID', 'Change Request', 'Project Name', 'Requester', 'Priority', 'Cost Of Change'],
                    colModel: [{ name: 'ID', index: 'ID', align: 'center', hidden: true },
                    { name: 'Change_Request', index: 'Change_Request', align: 'center' },
                    { name: 'Project_Name', index: 'Project_Name', align: 'center' },
                    { name: 'Requestor', index: 'Requestor', align: 'center' },
                    { name: 'Priority', index: 'Priority', align: 'center' },
                    { name: 'Cost_Of_Change', index: 'Cost_Of_Change', align: 'center' }],
                    rowNum: 05,
                    autoencode: true,
                    rowList: [5, 10, 20, 50, 100],
                    // sortname: 'ProjectID',
                    pager: jQuery('#pageNavigation'),
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
                    //caption:"Entity WorkFlow Approval"
                });
                }
                catch (exception) {
                    document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                    document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                }
            },
            error: function (xhr) {
                //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                // alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                   <%If Session("intUserID") Is Nothing Then%>
                alert("Session Expired!");
                    <%Else%>
                alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>
                document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";


            }
        });
    }

    function GetWorkflowEntity() {

        var mylist = document.getElementById("dropdownval");
        var entity = mylist.options[mylist.selectedIndex].value;

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
        //alert(JSON.stringify(para));
    }
    function Cancel(id) {
        document.getElementById("leaveappCommit").value = "";
        $('#' + id).modal('hide');
        if (id == 'approvalpopup') {
        }
        else {
            //location.reload(); 
            //ExpenseApproval();
            //LeaveApprovalTest();
            //GetResourceTimesheetApproval();
            //GetWorkflowEntity();
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
                url: 'MyApproval.aspx/SetWork1',
                contentType: 'application/json;charset-utf=8',
                data: JSON.stringify({ LoginID: '<%=Session("intUserID").ToString%>', Comments: comments, EmployeeID: entIDs, leaveID: levID, status: status }),
                dataType: 'json',
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
                            alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText);

                        }
                    });
                    //if (id.length == 1) {
                    //    window.open("../General/SendEmail.aspx?MessageID=" + intMessageID + "&LeaveID=" + Leaveid, "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                    //}
                    //else {
                        $.ajax({
                            //url: "MyApproval.aspx?Mode=Send&Msgto=" + emailids + "&MsgSubject=Leave " + dbstatus + "&EmailMsg=" + msg,
                            url: "MyApproval.aspx?Mode=Send&LeaveID=" + levID + "&ApproveorReject=" + glovalStatus,
                            success: function (result) {
                            }
                        });
                    //}
                }
                catch (exception) { }


            }
            });
            $('#approvalpopup').modal('hide');

        }

        setTimeout(function () {
            LeaveApprovalTest();
           // DrawPieChartForLeaveApprovalAction();
            document.getElementById("MyProfile").style.display = "none";
            document.getElementById("divLeaveApprovalParent").style.height = "auto";
        }, 1000);
    }


    function SendMail() {
        $.ajax({
            url: "MyApproval.aspx?Mode=Send&Msgfrom=" + document.getElementById("from").value + "&Msgto=" + document.getElementById("to").value + "&MsgSubject=" + document.getElementById("mailsubject").value + "&EmailMsg=" + document.getElementById('message').value + "&MsgCC=" + document.getElementById('cc').value + "&ids=" + document.getElementById('ids').value, success: function (result) {
            }
        });
        $("#mailBoxpopup").modal('hide');
        para = { LoginID: '<%=Session("intUserID").ToString%>' };
        //alert(para);
    }

    function checkSelectApproval(gridid, idcolumn, StatusAR) {

        GridName = gridid;
        glovalStatus = StatusAR;
        var id = jQuery("#" + gridid).jqGrid('getGridParam', 'selarrrow');

        if (id.length) {
            $('#approvalpopup').modal('show');

        }
        else {
            var entityName = ""
            if (GridName == "LeaveApprovalGridview") { entityName = "Leave"; }
            else if (GridName == "ResourceTimesheetApprovalgrid") { entityName = "Timesheet"; }
            else if (GridName == "EntityWorkflowApprovalGridview") { entityName = "Entity"; }
            else if (GridName == "ExpenseApprovalGridview") { entityName = "Expense"; }
            alert("Please Select Request Approval First");

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

            ValidateResourceDate_XML("MyApproval.aspx?Mode=Timesheet&TimesheetID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength);
            // if (tblLength == 1) {
            //  if (glovalStatus == "A") {
            //       window.open("../General/SendEmail.aspx?MessageID=435&VerifiedBy=" + <%=CType(Session("intUserID"), String)%> + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500")
            //  }
            // else {
            //     window.open("../General/SendEmail.aspx?MessageID=437&VerifiedBy=" + <%=CType(Session("intUserID"), String)%> + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500")
            // }
            //}
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
            ValidateResourceDate_XML("MyApproval.aspx?Mode=ProjTimesheet&TimesheetID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength)
            //if (tblLength == 1) {
            //    if (glovalStatus == "A") {
            //        window.open("../General/SendEmail.aspx?MessageID=4&TimeSheetID=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')
            //    }
            //    else {
            //        window.open("../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')
            //    }
            //}
        }
        setTimeout(function () {
            GetTimesheet();
            //GetResourceTimesheetApproval();
            //   DrawPieChartForTimesheetApprovalAction();
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
        ValidateResourceDate_XML("MyApproval.aspx?Mode=Entity&EntityID=" + entIDs + "&MasterTagID=" + entity + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength);
        //if (tblLength == 1) {
        //    window.open('../General/SendEmail.aspx?MessageID=' + MsgID + "&workflow=1&PrimaryKeyValue=" + empname, '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=600,height=500');
        //}
        setTimeout(function () {
            GetWorkflowEntity();
            //  DrawPieChartForEntityApprovalAction();
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
                    msgID = 460;
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
        ValidateResourceDate_XML("MyApproval.aspx?Mode=Expense&ExpensesEntryID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength + "&isExpense=" + isexpense)

        //if (tblLength == 1) {
        //    window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ExpenseSheetID=" + empname + "&ExpenseEntryIDList=" + ExpenseID + "", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
        //}
        setTimeout(function () {
            ExpenseApproval();
            // DrawPieChartForExpenseApprovalAction();
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


    function approveBtn() {
        if ($("#leaveappCommit").val() != "") {
            if (GridName == "LeaveApprovalGridview") { Approved('LeaveApprovalGridview', 'EmployeeID') }
            else if (GridName == "ResourceTimesheetApprovalgrid") { ApproveTimesheet('ResourceTimesheetApprovalgrid'); GetResourceTimesheetApproval(); }
            else if (GridName == "EntityWorkflowApprovalGridview") { ApproveEntity('EntityWorkflowApprovalGridview'); GetWorkflowEntity(); }
            else if (GridName == "ExpenseApprovalGridview") { ApproveExpense('ExpenseApprovalGridview'); ExpenseApproval(); }
            else if (GridName == "tblHelpDeskApproval") { ApproveHelpDesk('tblHelpDeskApproval'); PendingHelpDeskApproval(); }
            //if (GridName != "LeaveApprovalGridview"){
            //    setTimeout(function () {
            //        var objFrm = document.getElementById("frmMyApproval");
            //        objFrm.submit();
            //    }, 2000);
            //}
            document.getElementById("leaveappCommit").value = "";
        }
        else {
            alert("Please enter comment!")
        }
    }

    function PendingProjectApproval() {
        $("#ResourceTimesheetApprovalgrid").GridUnload();
        $.ajax({
            url: path + "getPendingProjectTimesheet",
            //COMMENTED AND ADDED BY nILESH G  ON 18/3/2016 FOR GENERATE PK TOKEN
            //data: { intUserID: '<%=Session("intUserID")%>' },  // For empty input data use "{}",
            data: { intUserID: '<%=Session("intUserID").ToString%>', pToken: '<%=CommonFunctions.Security.Token.GetToken(Session("intUserID"))%>' },  // For empty input data use "{}",
            //END OF ADDED BY nILESH G ON 18/3/2016
                dataType: "jsonp",
                type: "GET",
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    try
                    {
                    Entityworkflowcount = 0;
                    $.each(JSON.parse(result), function (id, obj) {
                        Entityworkflowcount++;
                    });
                    if (objProjectTimesheetAccess == 1) {
                        document.getElementById('notifyCountTimesheet').innerHTML = Entityworkflowcount;
                    }
                    else {
                        document.getElementById('notifyCountTimesheet').innerHTML = 0;
                    }
                    jQuery("#ResourceTimesheetApprovalgrid").jqGrid({
                        datatype: "local",
                        data: JSON.parse(result),
                        colNames: ['TimeSheetID', 'Project Name', 'Project ID', 'Status Description', 'FromDate', 'ToDate', 'Actual Work'],
                        colModel: [{ name: 'TimeSheetNo', align: 'center', index: 'TimeSheetNo', hidden: true },
                        { name: 'ProjectName', index: 'ProjectName', align: 'center' },
                        { name: 'ProjectID', align: 'center', index: 'ProjectID', hidden: true },
                        { name: 'TimesheetStatus', index: 'TimesheetStatus', align: 'center' },
                        { name: 'Fromdate', index: 'Fromdate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" } },
                        { name: 'ToDate', index: 'ToDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" } },
                        { name: 'TotalTimeSheetHours', index: 'TotalTimeSheetHours', align: 'center' }],
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
                            // var myGrid = $('#ResourceTimesheetApprovalgrid'),
                            // selRowId = myGrid.jqGrid('getGridParam', 'selrow'),
                            // EmpID = myGrid.jqGrid('getCell', selRowId, 'EmployeeID'),
                            // Projectnm = myGrid.jqGrid('getCell', selRowId, 'ProjectName'),
                            //titalval = myGrid.jqGrid('getCell', selRowId, 'Title'),
                            //amt = myGrid.jqGrid('getCell', selRowId, 'Amount');

                            //ExpenseApprovalpass = { LoginID: '<%=Session("intLoginID")%>', EmployeeID: EmpID, ProjectName: Projectnm, tital: titalval, amount: amt };
                            // ExpenseApprovalDetails();
                        },
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
                    //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    //alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                       <%If Session("intUserID") Is Nothing Then%>
                    alert("Session Expired!");
                    <%Else%>
                    alert('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                <%End If%>
                    $("#divResourceTimesheetApprovalChild .btn").css("visibility", "hidden");
                    document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "Something Went Wrong! Please Try Again Later...";
                    $("#ResourceTimesheetApprovalgrid").GridUnload();


                }
            });

        }

        function GetTimesheet() {
            var mylist = document.getElementById("ddlTimesheet");
            var entity = mylist.options[mylist.selectedIndex].value;
            $("#divResourceTimesheetApprovalChild .btn").css("visibility", "visible");
            document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
            switch (entity) {
                case '1':
                    $.ajax({
                        type: 'POST',
                        url: 'MyApproval.aspx/GetUserAccess',
                        dataType: 'json',
                        data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 2125 }),
                        contentType: 'application/json;charset-utf=8',
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
                        url: 'MyApproval.aspx/GetUserAccess',
                        dataType: 'json',
                        data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 42 }),
                        contentType: 'application/json;charset-utf=8',
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

        function GetEntityCountAll() {
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: '../General/Navigation.aspx/DrawChartForAllApproval',
                data: JSON.stringify({ EmployeeID: "<%=Session("intUserID").ToString%>" }),
                success: function (Result) {
                    var jsonData = JSON.parse(Result.d);
                    $.each(jsonData, function (id, obj) {
                        setTimeout(function () {
                            if (objEntityRoleAccess == 1) {
                                document.getElementById('notifyCountEntityworkflow').innerHTML = obj.EntityCount;
                            }
                            else {
                                document.getElementById('notifyCountEntityworkflow').innerHTML = 0;
                            }
                            if (obj.TimeSheetCount == null)
                                document.getElementById('notifyCountTimesheet').innerHTML = 0;
                            else
                                document.getElementById('notifyCountTimesheet').innerHTML = obj.TimeSheetCount;
                        }, 500);
                    });
                }
            });
        }

        function PendingHelpDeskApproval() {
            $("#tblHelpDeskApproval").GridUnload();
            $.ajax({
                url: "MyApproval.aspx/GetHeplDeskApprovalData",
                data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>' }),  // For empty input data use "{}",
                dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                try
                {
                HelpDeskCount = 0;
                $.each(JSON.parse(result.d), function (id, obj) {
                    HelpDeskCount++;
                });
                if (objHelpdeskRoleAccess == 1) {
                    document.getElementById('notifyCountHelpDesk').innerHTML = HelpDeskCount;
                }
                else {
                    document.getElementById('notifyCountHelpDesk').innerHTML = 0;
                }
                jQuery("#tblHelpDeskApproval").jqGrid({
                    datatype: "local",
                    data: JSON.parse(result.d),
                    colNames: ['QueryID', 'Submitted Date', 'Subject', 'Requestor', 'Request Type', 'Sub Request Type', 'Priority'],
                    colModel: [{ name: 'QueryID', align: 'center', index: 'QueryID', hidden: true },
                    { name: 'SubmittedDate', index: 'SubmittedDate', align: 'center', formatter: "date", formatoptions: { newformat: "d-M-Y" } },
                    { name: 'Subject', align: 'center', index: 'Subject', hidden: true },
                     { name: 'CustomerID', index: 'CustomerID', align: 'center' },
                    //{ name: 'InboxORwatchList', index: 'InboxORwatchList', align: 'center' },
                    { name: 'RequestType', index: 'RequestType', align: 'center' },
                    { name: 'SubRequestType', index: 'SubRequestType', align: 'center' },
                    { name: 'Priority', index: 'Priority', align: 'center' }],
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

                        //ShowHelpDeskApprovalDetails()
                            //document.getElementById("tblAllApprovalGraph").style.display = "none";
                            //$(".margin1").css("margin-top", "0%");
                    }
                    else {
                        HelpdeskParameter = {};
                            //dhn
                        //document.getElementById("MyProfileHelpdesk").style.display = "none";
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
        ValidateResourceDate_XML("MyApproval.aspx?Mode=HelpDesk&QueryID=" + entIDs + "&ApproveorReject=" + glovalStatus + "&Remarks=" + $('#leaveappCommit').val() + "&rowCount=" + tblLength)
        //if (tblLength == 1) {
        //   window.open("../General/SendEmail.aspx?MessageID=" + msgID + "&ApprovalStatus=" + glovalStatus + "&QueryID=" + empname + "&EmployeeIDList=" + <%=Session("intUserID").ToString%> + "&Comments=" + $('#leaveappCommit').val() + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
        //  }
        setTimeout(function () {
            PendingHelpDeskApproval();
            //DrawPieChartForHelpDeskApprovalAction();
            $("#approvalpopup").modal("hide");
        }, 1000);
    }
    //var access = 0;
    //function GetAccess(userID, tagID) {

    //    $.ajax({
    //        type: 'POST',
    //        url: 'MyApproval.aspx/GetUserAccess',
    //        dataType: 'json',
    //        data: JSON.stringify({ intUserID: userID, intTagID: tagID }),
    //        contentType: 'application/json;charset-utf=8',
    //        success: function (Result) {
    //            if (String(Result.d) == "1") {
    //                access = 1;
    //            }
    //            else {
    //                access = 0;
    //            }
    //        }
    //    });
    //}

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
</script>
<body>

    <form id="frmMyApproval" style="margin: 0px"></form>

    <div class="mm-page">
        <div id="divUnAuthorize" style="display: none; width: 100%; background-color: #E39321">
            <label style="width: 90%; font-size: 20px; text-align: center; color: black; position: relative; top: 400px">You are not authorize to view in this resolution.</label>
            <a id="aLogOut" style="position: absolute; right: 2px; top: 2px; font-size: 15px; color: white" href="<%= ResolveUrl("../../default.aspx") %>">Log Out</a>
        </div>
        <div id="page" style="display: none">
            <div class="menu-header">
                <a href="#menu"></a>
                <label style="margin-left: 20px">My Pending Approval</label>
                <div style="top: 5px; right: 18%; position: absolute;">
                    <%--<button class="btn" type="button" style="background-color: transparent; color: white; font-weight: bold;" onclick="logout();">Log Out</button>--%>
                </div>
                <img id="imgEmployeeHome" src="../../img/1920/no-photo.png" alt="No Image" style="margin-top: 4px; width: 30px; height: 30px; top: 2px; position: absolute; right: 1px;" align="right" />
            </div>
            <div id="Authorize" style="margin-top: 10%; text-align: center; font-weight: bold; display: none">You are not authorize to view in this resolution</div>
            <div id="divMenuContent" class="MenuContent">
                <div id="header">

                    <div class="leftheader">

                        <%--<div class="btn-group button-margin">
                                <asp:Label ID="lbl_user" runat="server"></asp:Label>
                            </div>--%>
                    </div>
                </div>

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

                            <a href="../PM/PM_DailyActivityMobile.aspx" class="menu-link">
                                <div class="box" id="timesheet">
                                    <img src="../../responsive/images/time.gif" alt="TimeSheet Entry" class="slider-image" /><br />
                                    TimeSheet Entry
                                </div>
                            </a>

                        </div>

                    </div>
                </div>--%>
                <div class="content">
                    <div class="center-caption">
                        My Pending Approval<br />
                    </div>
                    <div id="tblshow" class="Grid-data">
                        <div id="divLeaveApprovalParent" class="clsParent ">
                            <div id="divLeaveApproval" class="clsCaption flip">
                                <b class="cslLabel">Leave Approval</b>
                                <div class="notifyCount" id="notifyCountLeave"></div>
                                <%--<a style="right: 0px;float:right" id="aLeaveApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                            </div>
                            <div id="divLeaveApprovalAccess" class="clsAccess"></div>
                            <div id="divLeaveApprovalChild" style="margin: 3px">
                                <div class="workflow">
                                    <div style="margin: 3% 0% 2% 3%;">
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
                                <div id="MyProfile" class="right-Content" style="min-height: 700px;">
                                    <div class="center-text" style="margin: 0px !important">
                                        Details Section
                                    </div>
                                    <div id="detailsectionhide">
                                        <%--<div style="margin: 3% 0% 2% 3%; float: left; width: 100%">
                <a data-toggle="modal" class="btn btn-primary" onclick="checkSelectApproval('LeaveApprovalGridview','EmployeeID','A');">
                    Approve</a>
                <%--   Approve</button>--%>
                                        <%-- <button class="btn btn-primary" type="button" onclick="checkSelectApproval('LeaveApprovalGridview','EmployeeID','R');">
                    Reject</button>
            </div>--%>
                                        <div style="margin: 3% 0% 2% 3%; float: left; width: 100%">
                                            <div id="Detailssection" class="scroll" style="text-align: left; overflow: auto; width: 97%; border-radius: 4px; border: 1px solid black">
                                                <%--<table id="dinamictbl" style="width: 100%">--%>
                                                
                                                <table id="dinamictbl" style="width: 100%; max-height: 626px; overflow: auto">
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
                                    <textarea id="leaveappCommit" class="inputResponsive" required size="48" name="name" value=""></textarea>
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
                            <div id="divEntityWorkFlowApproval" class="clsCaption flip">
                                <b class="cslLabel">Entity WorkFlow Approval</b><div id="notifyCountEntityworkflow" class="notifyCount"></div>
                                <%--<a style="right: 0px;float:right" id="aEntityWorkFlowApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                            </div>
                            <div id="divEntityWorkFlowApprovalAccess" class="clsAccess"></div>
                            <div id="divEntityWorkFlowApprovalChild" class="clsChild">
                                <div class="workflow">
                                    <div style="margin: 3% 0% 2% 3%;">
                                        <button type="button" class="btn btn-primary" onclick="checkSelectApproval('EntityWorkflowApprovalGridview','EmployeeID','A')">
                                            Approve</button>
                                        <button type="button" class="btn btn-primary" onclick="checkSelectApproval('EntityWorkflowApprovalGridview','EmployeeID','R')">
                                            Reject</button>
                                    </div>
                                    <div style="float: right; margin-top: -10%; margin-right: 2%;">
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
                            </div>
                        </div>
                        <div id="divResourceTimesheetApprovalParent" class="clsParent">
                            <div id="divResourceTimesheetApproval" class="clsCaption flip">
                                <b class="cslLabel">Timesheet Approval</b><div id="notifyCountTimesheet" class="notifyCount"></div>
                                <%--<a style="right: 0px;float:right" id="aResourceTimesheetApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                            </div>

                            <div id="divResourceTimesheetApprovalChild" class="clsChild">
                                <div class="workflow">
                                    <div style="margin: 3% 0% 2% 3%;">
                                        <button type="button" class="btn btn-primary" onclick="checkSelectApproval('ResourceTimesheetApprovalgrid','TimeSheetID','A');">
                                            Approve</button>
                                        <button class="btn btn-primary" type="button" onclick="checkSelectApproval('ResourceTimesheetApprovalgrid','TimeSheetID','R');">
                                            Reject</button>
                                    </div>
                                    <div style="float: right; margin-top: -10%; margin-right: 2%;">
                                        <select id="ddlTimesheet" name="year" onchange="GetTimesheet()">
                                        </select>
                                    </div>
                                    <div id="divResourceTimesheetApprovalAccess" class="clsAccess"></div>
                                    <div class="Table-Header">
                                    </div>
                                    <table id="ResourceTimesheetApprovalgrid" class="scroll">
                                    </table>
                                    <div id="onResourceTimesheetApprovalpagging" class="scroll" style="text-align: center;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="divExpenseApprovalParent" class="clsParent " >
                            <div id="divExpenseApproval" class="clsCaption flip">
                                <b class="cslLabel">Expense Approval</b><div id="notifyCountExpense" class="notifyCount"></div>
                                <%--<a style="right: 0px;float:right" id="aExpenseApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                            </div>
                            <div id="divExpenseApprovalAccess" class="clsAccess"></div>
                            <div id="divExpenseApprovalChild" class="clsChild">
                                <div class="workflow">
                                    <div style="margin: 3% 0% 2% 3%;">
                                        <button class="btn btn-primary" type="button" onclick="checkSelectApproval('ExpenseApprovalGridview','EmployeeID','A')">
                                            Approve</button>
                                        <button class="btn btn-primary" type="button" onclick="checkSelectApproval('ExpenseApprovalGridview','EmployeeID','R')">
                                            Reject</button>
                                    </div>
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
                        <div id="divHelpDeskApprovalParent" class="clsParent " style="margin-bottom: 10%;">
                            <%--Commented By Tejas Rasage on 04 March Purpose:UI Change--%>
                            <div id="divHDeskApproval" class="clsCaption flip">
                                <b class="cslLabel">HelpDesk Approval</b><div id="notifyCountHelpDesk" class="notifyCount"></div>
                                <%--<a style="right: 0px;float:right" id="aExpenseApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a>--%>
                            </div>
                            <%--<div id="divHDeskApproval" class="fliplabel">
                                <b class="cslLabel">HelpDesk Approval</b>--%><%--<a style="right: 0px;float:right" id="aLeaveApproval" role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"><span class="ui-icon ui-icon-circle-triangle-s"></span></a></div>
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
                    </div>

                    <div id="mailBoxpopup" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
                        aria-labelledby="myLargeModalLabel" aria-hidden="true" style="overflow: hidden ! important;">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div style="width: 100%; text-align: right;">
                                    <a href="#">
                                        <img src="../../responsive/Images/closebtn.png" onclick="Cancel('mailBoxpopup')" /></a>
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
                    <div id="divfooter" class="footbar">Lifeline Systech Solutions Pvt.Ltd.</div>

                    <nav id="menu">
                        <ul>

                            <li><a href="../General/Navigation.aspx?FromWhere=DB" id="Hhome">
                                <img src="../../responsive/images/home.gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Home</a></li>
                            <li><a href="MyApproval.aspx" id="A1">
                                <img src="../../responsive/images/Project .gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;My Approval </a></li>

                            <%--  <li><a href="Projects.aspx" id="Hproject">
                            <img src="../../responsive/images/Project .gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Project </a></li>
                            --%>
                            <li><a href="../PM/PM_DailyActivityMobile.aspx">
                                <img src="../../responsive/images/time.gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;TimeSheet Entry</a></li>

                            <%-- <li><a >&nbsp;&nbsp;&nbsp;&nbsp;Settings</a></li>--%>
                            <li><a href="<%= ResolveUrl("../../default.aspx") %>">
                                <img src="../../responsive/images/Button-Log-Off.png" style="width: 20; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Log Out</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <input type="hidden" id="ids" />
        <script>

            // alert($("#pg_LeavepageNavigation").find('table').length);

            // .removeAttr("height")
            //$(document).ready(function () {
            //    document.body.style.height = window.innerHeight - 3 + 'px';
            //    document.body.style.overflow = "auto"

            //});
            //$(window).resize(function () {
            //    document.body.style.height = window.innerHeight - 3 + 'px';
            //    document.body.style.overflow = "auto"

            //});
            //document.getElementById("divfooter").onload = function () { alert(); };
            function hideDivs() {
                document.getElementById("divLeaveApprovalAccess").innerHTML = "";
                document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "";
                document.getElementById("divExpenseApprovalAccess").innerHTML = "";
                document.getElementById("divHelpDeskApprovalAccess").innerHTML = "";
                document.getElementById("divResourceTimesheetApprovalAccess").innerHTML = "";
                document.getElementById("MyProfile").style.display = "none";
            }
            window.onload = function () {

                document.body.style.height = window.innerHeight - 3 + 'px';
                document.getElementById("MyProfile").style.display = "none";
                $(document).removeAttr("height")
                //if (WhichBrowser()!='IE')
                //    AdjustStyle()
                $("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; setFrameLoaded() });

                $("#divLeaveApproval").click(function () {
                    //GetAccess(, )
                    hideDivs();
                    $("#divEntityWorkFlowApprovalChild").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none" });
                    $("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                    $("#divExpenseApprovalChild").fadeOut("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "none" });
                    $("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                    $.ajax({
                        type: 'POST',
                        url: 'MyApproval.aspx/GetUserAccess',
                        dataType: 'json',
                        data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 1209 }),
                        contentType: 'application/json;charset-utf=8',
                    success: function (Result) {
                        if (String(Result.d) == "1") {
                            //$("#divEntityWorkFlowApprovalChild").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none" });
                            //$("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                            //$("#divExpenseApprovalChild").fadeOut("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "none" });
                            //$("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                            if (document.getElementById("divLeaveApprovalChild").style.display == "block") {
                                $("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto" });
                            }
                            else {
                                //LeaveApprovalTest();
                                $("#divLeaveApprovalChild").fadeIn("slow", function () {
                                    document.getElementById("divLeaveApprovalChild").style.display = "block";
                                    if (document.getElementById("MyProfile").style.display == "none")
                                        document.getElementById("divLeaveApprovalParent").style.height = "auto"
                                    else
                                        document.getElementById("divLeaveApprovalParent").style.height = "626px"
                                });


                            }
                        }
                        else {
                            if (document.getElementById("divLeaveApprovalAccess").innerHTML == "") {
                                $("#divLeaveApprovalAccess").fadeIn("slow", function () { document.getElementById("divLeaveApprovalAccess").innerHTML = "You do not have access"; });
                            }
                            else {
                                $("#divLeaveApprovalAccess").fadeOut("slow", function () { document.getElementById("divLeaveApprovalAccess").innerHTML = ""; });
                            }
                        }
                    }
                });

            });
                $("#divEntityWorkFlowApproval").click(function () {
                    hideDivs();
                    $("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto" });
                    $("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                    $("#divExpenseApprovalChild").fadeOut("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "none" });
                    $("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 3936 }),
                    contentType: 'application/json;charset-utf=8',
                    success: function (Result) {
                        if (String(Result.d) == "1") {
                            //$("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto" });
                            //$("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                            //$("#divExpenseApprovalChild").fadeOut("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "none" });
                            //$("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                            if (document.getElementById("divEntityWorkFlowApprovalChild").style.display == "block") {
                                $("#divEntityWorkFlowApprovalChild").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none" });
                            }
                            else {
                                //$("#divEntityWorkFlowApprovalChild").fadeIn("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "block" });
                                //document.getElementById("dropdownval").value = '32';
                                //EntityWorkflowApproval();
                                $("#divEntityWorkFlowApprovalChild").fadeIn("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "block"; });//EntityWorkflowApproval();

                            }
                        }
                        else {
                            if (document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML == "") {
                                $("#divEntityWorkFlowApprovalAccess").fadeIn("slow", function () { document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = "You do not have access"; });
                            }
                            else {
                                $("#divEntityWorkFlowApprovalAccess").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalAccess").innerHTML = ""; });
                            }
                        }
                    }
                });
            });
                $("#divExpenseApproval").click(function () {
                    hideDivs();
                    $("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto" });
                    $("#divEntityWorkFlowApprovalChild").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none" });
                    $("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                    $("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                $.ajax({
                    type: 'POST',
                    url: 'MyApproval.aspx/GetUserAccess',
                    dataType: 'json',
                    data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 3595 }),
                    contentType: 'application/json;charset-utf=8',
                    success: function (Result) {
                        if (String(Result.d) == "1") {
                            //$("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto" });
                            //$("#divEntityWorkFlowApprovalChild").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none" });
                            //$("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                            //$("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                            if (document.getElementById("divExpenseApprovalChild").style.display == "block") {
                                $("#divExpenseApprovalChild").fadeOut("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "none" });
                            }
                            else {
                                //$("#divExpenseApprovalChild").fadeIn("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "block" });
                                //ExpenseApproval();
                                $("#divExpenseApprovalChild").fadeIn("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "block"; });//ExpenseApproval();

                            }
                        }
                        else {
                            if (document.getElementById("divExpenseApprovalAccess").innerHTML == "") {
                                $("#divExpenseApprovalAccess").fadeIn("slow", function () { document.getElementById("divExpenseApprovalAccess").innerHTML = "You do not have access"; });
                            }
                            else {
                                $("#divExpenseApprovalAccess").fadeOut("slow", function () { document.getElementById("divExpenseApprovalAccess").innerHTML = ""; });
                            }
                        }
                    }
                });
            });
            $("#divResourceTimesheetApproval").click(function () {
                //var myData = jQuery("#ResourceTimesheetApprovalgrid").jqGrid('getRowData');
                //if (myData.length > 0) {
                //    for (var i = 0; i < myData.length; i++) {
                //        if (myData[i]["StatusDescription"] == "Approved") {
                //            document.getElementById("jqg_ResourceTimesheetApprovalgrid_" + (i + 1)).disabled = true;
                //        }
                //        else if (myData[i]["StatusDescription"] == "Rejected") {
                //            document.getElementById("jqg_ResourceTimesheetApprovalgrid_" + (i + 1)).disabled = true;
                //        }
                //    }
                //}
                // GetAccess('<%=Session("intUserID")%>', 2125)
                hideDivs();
                $("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto" });
                $("#divEntityWorkFlowApprovalChild").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none" });
                $("#divExpenseApprovalChild").fadeOut("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "none" });
                $("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                if (document.getElementById("divResourceTimesheetApprovalChild").style.display == "block") {
                    $("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                }
                else {
                    //$("#divResourceTimesheetApprovalChild").fadeIn("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "block" });
                    //GetTimesheet();
                    $("#divResourceTimesheetApprovalChild").fadeIn("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "block"; });//GetTimesheet();

                }
            });

                $("#divHDeskApproval").click(function () {
                    hideDivs();
                    $("#divLeaveApprovalChild").fadeOut("slow", function () { document.getElementById("divLeaveApprovalChild").style.display = "none"; document.getElementById("divLeaveApprovalParent").style.height = "auto" });
                    $("#divEntityWorkFlowApprovalChild").fadeOut("slow", function () { document.getElementById("divEntityWorkFlowApprovalChild").style.display = "none" });
                    $("#divExpenseApprovalChild").fadeOut("slow", function () { document.getElementById("divExpenseApprovalChild").style.display = "none" });
                    $("#divResourceTimesheetApprovalChild").fadeOut("slow", function () { document.getElementById("divResourceTimesheetApprovalChild").style.display = "none" });
                    $("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                    //3753
                    $.ajax({
                        type: 'POST',
                        url: 'MyApproval.aspx/GetUserAccess',
                        dataType: 'json',
                        data: JSON.stringify({ intUserID: '<%=Session("intUserID").ToString%>', intTagID: 405 }),
                        contentType: 'application/json;charset-utf=8',
                    success: function (Result) {
                        if (String(Result.d) == "1") {
                            
                            if (document.getElementById("divHelpDeskApprovalChild").style.display == "block") {
                                $("#divHelpDeskApprovalChild").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "none" });
                            }
                            else {
                                // $("#divHelpDeskApprovalChild").fadeIn("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "block" });
                                //PendingHelpDeskApproval();
                                $("#divHelpDeskApprovalChild").fadeIn("slow", function () { document.getElementById("divHelpDeskApprovalChild").style.display = "block"; });//PendingHelpDeskApproval();

                            }
                            
                        }
                        else {
                            if (document.getElementById("divHelpDeskApprovalAccess").innerHTML == "") {
                                $("#divHelpDeskApprovalAccess").fadeIn("slow", function () { document.getElementById("divHelpDeskApprovalAccess").innerHTML = "You do not have access"; });
                            }
                            else {
                                $("#divHelpDeskApprovalAccess").fadeOut("slow", function () { document.getElementById("divHelpDeskApprovalAccess").innerHTML = ""; });
                            }
                           
                        }
                    }
                });
                });

            }



        //    window.onended = function () {
        //        if (WhichBrowser() != 'FF')
        //        { }
        //        else if (WhichBrowser() != 'CR')
        //        { }
        //        else
        //            AdjustStyle()
        //    }
        //    function AdjustStyle()
        //    {
        //        document.getElementById("pg_LeavepageNavigation").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("LeavepageNavigation_center").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("LeavepageNavigation_center").removeAttribute("style");

        //        document.getElementById("pg_pageNavigation").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("pageNavigation_center").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("pageNavigation_center").removeAttribute("style");


        //        document.getElementById("pg_ExpensepageNavigation").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("ExpensepageNavigation_center").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("ExpensepageNavigation_center").removeAttribute("style");

        //        document.getElementById("pg_onResourceTimesheetApprovalpagging").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("onResourceTimesheetApprovalpagging_center").firstChild.setAttribute("style", "width:100% !important");
        //        document.getElementById("onResourceTimesheetApprovalpagging_center").removeAttribute("style");

        //    }
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

        window.onresize = function () {
            document.body.style.height = window.innerHeight - 3 + 'px';
        }
        </script>
</body>
</html>
