<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PMDashboard.aspx.vb" Inherits="Whizible.PMDashboard1" %>

<!DOCTYPE html>
<html>
        <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("PM Dashboard")%>
<head>

<%--
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>PM Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">


    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>



</head>
        <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a {
            text-decoration: none;
        }

            a.clearalllink {
                font-weight: bold;
                margin: 7px 0px 0 8px;
                display: none;
            }

        .filter.float-end {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        tr.rowhiglight {
            background: #c3dbff;
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

            .DisableContent:hover {
                cursor: no-drop;
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }



        /*New css end here*/
        ul.statustext.hidden-xs {
            padding: 0;
        }

        .tblheadingrow td {
            text-align: left !important;
            font-weight: 500;
        }

        tr.totalrow {
            background: #ccc;
            font-weight: 500;
        }

        .PPBGOUTbllist tr td:nth-child(2) {
            text-align: left;
        }

        .lightgraybg {
            background: #f5f5f5;
        }

        .borderbox {
            border: 1px solid #ddd;
            margin: 15px;
            background: #f7f7f7;
        }

        .graphcontainer .panel {
            padding: 0;
        }

        .panel-default > .panel-heading {
            color: #464a4c;
            background-color: #e7edf0;
            border-color: #ddd;
            position: relative;
        }

        .mr1 {
            margin-right: 10px;
        }


        .sortaccess label {
            display: inline-block;
            float: left;
            margin-right: 10px;
        }

        select.form-select.accessdrop {
            float: right;
            width: 40%;
        }

        .inlinediv.sortaccess {
            float: left;
            width: 130px;
            margin-right: 15px;
            margin-top: 5px;
            border-right: 1px solid #ccc;
        }

        .main_graybgtbs li img {
            margin-right: 10px;
        }

        .custom_radio input[type="radio"] + label span {
            margin: 0px 6px;
        }

        .tabinnerFltr .custom_radio {
            margin-right: 10px;
        }


        /*.access1.dashGridTblOuter {
            display: block;
        }*/

        .boxformheading {
            color: #4263c1;
            margin: 0 0 15px;
            font-size: 15px;
            font-weight: bold;
        }

        .box-body.p-0 {
            padding: 0;
        }

        .keywords {
            display: flex;
            white-space: nowrap;
            overflow: scroll;
        }

            .keywords .col-sm-3 {
                float: none;
                margin-bottom: 15px;
            }

        #discussionTbl tr th:last-child, #discussionTbl tr th:last-child {
            text-align: left !important;
        }

        .showreportDownload {
            float: right;
            margin-left: 10px;
        }

        .pendingentriesdayslist a {
            padding: 3px 8px;
            border-radius: 4px;
            font-weight: 500;
        }

            .pendingentriesdayslist a:hover {
                background: #135a9c;
                color: #fff;
            }

        div.dataTables_wrapper div.dataTables_paginate ul.pagination {
            margin: 10px 0 0 !important;
        }

        .table.ClsdashTbl {
            width: 100% !important;
        }

        .horizontallinks a.nav-link {
            padding: 4px 12px;
            color: #464a4c;
            font-weight: 400;
            opacity: 0.8;
        }

            .horizontallinks a.nav-link:hover, .horizontallinks a.nav-link:focus, .horizontallinks a.nav-link.active {
                background: none;
                color: #135a9c;
                opacity: 1; /*font-weight:500;*/
            }

        .main_graybgtbs .nav-link.active {
            background: #1359a6;
            color: #fff;
        }

        .horizontallinks a.nav-link.active {
            font-weight: 600 !important;
        }

        .form-control.input-sm, .form-control.input-sm + span .btncalendar {
            height: 30px;
        }

        .btncalendar {
            background: #eee;
        }

        .voidrow td:first-child { /*box-shadow:inset 2px 0px 0px 0px #eb1c24;*/
        }

        .voidrow td {
            background: #f8d7da57;
        }

        #Createasigntaskmodal .modal-body .form-group {
            margin-bottom: 15px;
        }

        table.dataTable > tbody > tr.graybg {
            background: #e7edf0;
        }

        .mr0 {
            margin-right: 0 !important;
        }

        .attachments tr th:nth-child(3), .attachments tr td:nth-child(3) {
            text-align: left;
        }

        .form-group label {
            margin-bottom: 3px;
        }

        #IDIssueAsignmentListTbl tr th {
            min-width: 80px;
        }

            #IDIssueAsignmentListTbl tr th:nth-child(3), #IDIssueAsignmentListTbl tr th:nth-child(6), #IDIssueAsignmentListTbl tr th:nth-child(7) {
                min-width: 150px;
            }

        .showallToggle_link {
            margin-top: 5px;
        }

        a.togglelink {
            background: #1359ac;
            padding: 4px 12px;
            border-radius: 4px;
            border: 1px solid transparent;
            color: #fff;
            opacity: 1;
        }

        /* a.togglelink:hover {
                background: #1359ac;
                border: 1px solid #eee;
                opacity: 1;
                color: #fff;
            }*/

        p.text-small {
            font-size: 12px !important;
        }

        .text-small.clsbox {
            background: #f5f5f5;
            padding: 10px;
            border: 1px solid #eee;
            margin-top: 10px;
            border-radius: 4px;
            font-size: 12px;
        }

        #discussionTbl tr th:last-child, #discussionTbl tr td:last-child {
            text-align: left;
        }

        div.dataTables_wrapper div.dataTables_paginate {
            margin: 10px 0px 0;
        }

        #pmdashTab2 .pmdash-timesheet .col-sm-4 a {
            padding: 4px 12px;
        }

        .modal:nth-of-type(even) {
            z-index: 1052 !important;
        }

        .modal-backdrop.show:nth-of-type(even) {
            z-index: 1051 !important;
        }

        .content {
            padding: 15px;
        }

        .input-group-btn button.btn.btncalendar {
            border-radius: 0px;
            background: #eee;
        }

        #divDateRange {
            border-radius: 0px;
            background: #eee;
            padding: 10px;
            background: #f5f5f5;
            margin: 0 0px;
        }
        .smalltextfield {
            width: 100px; 
            display: inline-block;
        }
        .ui-datepicker {
    z-index: 9099!important;
}

.attachedDocTbl th:nth-child(4){ min-width:50px;}
        .table-fixed-header thead tr th, .table thead tr th { text-align:center;
        }

        @media screen and (max-width:767px) {
            canvas {
                height: auto !important;
            }
        }

        .fa-bug {
            color: #f51d1d;
        }
th.sorting_asc.sorting_disabled::before, th.sorting_asc.sorting_disabled::after {display: none!important;}
.ClsdashTbl td:nth-child(5), .ClsdashTbl td:nth-child(6), .ClsdashTbl td:nth-child(9) {min-width: 80px;}
.table-fixed-header tbody tr th, .table tbody tr td {text-align: center;} 
</style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="body-PMDashboard">

    <div class="bgwhite">

        <div class="col-sm-12 pt-1 pb-2 px-3 text-end graybg">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("Page_Name") %></h5>
            <div class="clearfix"></div>
        </div>
        <div class="clearfix"></div>
        <div class="col-sm-12 pt-1 pb-1 px-3">
            <div class="row">
                <div class="col-sm-8">
                    <ul class="nav nav-tabs main_graybgtbs">
                        <li class="nav-item"><a href="#pmdashTab1" class="nav-link active" data-bs-toggle="tab">
                            <img src="../../../Whizible2.0-new/dist/img/graph-icon.png" class="tabImages" width="16px"><%= MyBase.GetResourceString("E-Dashboard") %></a></li>
                        <li class="nav-item"><a href="#pmdashTab2" class="nav-link" data-bs-toggle="tab" onclick="TaskListByDate('')">
                            <img src="../../../Whizible2.0-new/dist/img/section-icon.png" class="tabImages" width="16px"><%= MyBase.GetResourceString("PendingEntries") %></a></li>
                        <li class="nav-item"><a href="#pmdashTab3" class="nav-link" data-bs-toggle="tab">
                            <img src="../../../Whizible2.0-new/dist/img/bugReport.png" class="tabImages" width="16px"><%= MyBase.GetResourceString("IssueAgeingAnalysis") %></a></li>
                        <%--<li class="nav-item"><a href="#pmdashTab3" class="nav-link" data-bs-toggle="tab"> <i class="fas fa-bug"></i>  <%= MyBase.GetResourceString("IssueAgeingAnalysis") %></a></li>--%>
                    </ul>
                </div>
                <div class="col-sm-4">&nbsp;</div>
            </div>
        </div>

        <div class="clearfix"></div>
        <div class="content">

            <div class="tab-content">
                <!--edashboard start here-->
                <div id="pmdashTab1" class="tab tab-pane active">

                    <div class="tab-content" id="myTabContent">

                        <div class="bg-light p-1 justify-content-md-end mb-1 px-3">
                            <div class="inlinediv sortaccess">
                                <label><%= MyBase.GetResourceString("SortAcross") %></label>
                                <div class="custom_chckbox">
                                    <input id="sortaccess" class="chcktbl" type="checkbox" onclick="DoSort()">
                                    <label for="sortaccess"></label>
                                </div>
                            </div>

                            <ul class="nav horizontallinks float-start">
                                <li class="nav-item"><a class="nav-link active" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDtodolistTblwrapper" type="button" role="tab" aria-controls="IDtodolistTblwrapper" aria-selected="true" onclick="ToDoListFill()"><%= MyBase.GetResourceString("ToDoList") %></a></li>
                                <li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDIssuelistTblwrapper" type="button" role="tab" aria-controls="IDIssuelistTblwrapper" aria-selected="false" onclick="IssueList()"><%= MyBase.GetResourceString("Issues") %></a></li>
                                <li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDReviewlistTblwrapper" type="button" role="tab" aria-controls="IDReviewlistTblwrapper" aria-selected="false" onclick="ReviewsList()"><%= MyBase.GetResourceString("Reviews") %></a></li>
                                <li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDRisklistTblwrapper" type="button" role="tab" aria-controls="IDRisklistTblwrapper" aria-selected="false" onclick="RiskList()"><%= MyBase.GetResourceString("Risks") %></a></li>
                                <li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDMilestonelistTblwrapper" type="button" role="tab" aria-controls="IDMilestonelistTblwrapper" aria-selected="false" onclick="MileStoneList()"><%= MyBase.GetResourceString("Milestones") %></a></li>
                                <li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDDlvrablelistTblwrapper" type="button" role="tab" aria-controls="IDDlvrablelistTblwrapper" aria-selected="false" onclick="DeliverableList()"><%= MyBase.GetResourceString("Deliverables") %></a></li>
                                <li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDETCrequestTblwrapper" type="button" role="tab" aria-controls="IDETCrequestTblwrapper" aria-selected="false" onclick="ETCListFill()"><%= MyBase.GetResourceString("ETCRequests") %></a></li>
                                <li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDMyProjectTblwrapper" type="button" role="tab" aria-controls="IDMyProjectTblwrapper" aria-selected="false" onclick="MyProjectList()"><%= MyBase.GetResourceString("MyProjects") %></a></li>
                                <!--<li class="nav-item"><a class="nav-link" href="javascript:;" data-bs-toggle="tab" data-bs-target="#IDShowalllistTblwrapper" type="button" role="tab" aria-controls="IDShowalllistTblwrapper" aria-selected="false">Show All Project</a></li>-->
                            </ul>

                            <div class="showallToggle_link float-end" id="ShowAllProject"><a class="togglelink " href="javascript:;" onclick="ShowAllProject()"><%= MyBase.GetResourceString("ShowAllProject") %></a></div>
                            <div class="showallToggle_link float-end" id="ShowSelectedProject" style="display: none"><a class="togglelink" href="javascript:;" onclick="ShowSelectedProject()"><%= MyBase.GetResourceString("ShowSelectedProject") %></a></div>
                            <div class="clearfix"></div>
                        </div>

                        <!--To Do List Table start here-->
                        <div id="IDtodolistTblwrapper" class="IDtodolistTblwrapper access1 dashGridTblOuter tab-pane fade show active" role="tabpanel" tabindex="0">
                            <div class="tabinnerFltr mb-1">
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr1" name="Rgroup1" value="" type="radio" checked="checked" onclick="GetTodolist()">
                                    <label for="edashRadioFltr1"><span></span><%= MyBase.GetResourceString("Today(PendingTaskIncluded)") %></label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr2" name="Rgroup1" value="" type="radio" onclick="GetTodolist()">
                                    <label for="edashRadioFltr2"><span></span><%= MyBase.GetResourceString("PreviousWeek") %></label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr3" name="Rgroup1" value="" type="radio" onclick="GetTodolist()">
                                    <label for="edashRadioFltr3"><span></span><%= MyBase.GetResourceString("ThisWeek") %></label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr4" name="Rgroup1" value="" type="radio" onclick="GetTodolist()">
                                    <label for="edashRadioFltr4"><span></span><%= MyBase.GetResourceString("NextWeek") %></label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr5" name="Rgroup1" value="" type="radio" onclick="GetTodolist()">
                                    <label for="edashRadioFltr5"><span></span><%= MyBase.GetResourceString("DateRange") %></label>
                                </div>

                            </div>

                            <div class="row" id="divDateRange" style="display: none">
                                <div class="col-sm-4 row">
                                    <label class="col-sm-3 pr-0">From Date</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("ffromdate", "ffromdate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4 row">
                                    <label class="col-sm-3 pr-0">To Date</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("ftodate", "ftodate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4 row">
                                    <button class="btn btnyellow" style="width: 80px;" onclick="DateRange()">Show</button>
                                </div>
                            </div>


                            <table id="TodoListGridTbl" class="table table-bordered ClsdashTbl" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <%--<th>&nbsp;</th>--%>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th colspan="4"><%= MyBase.GetResourceString("H_Baseline") %></th>
                                        <th colspan="2"><%= MyBase.GetResourceString("H_Actual") %></th>
                                        <th>&nbsp;</th>
                                    </tr>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <%--<th><%= MyBase.GetResourceString("H_Flag") %></th>--%>
                                        <th width="35px"><%= MyBase.GetResourceString("H_Document") %></th>
                                        <th><%= MyBase.GetResourceString("H_TaskName") %></th>
                                        <th><%= MyBase.GetResourceString("H_Priority") %></th>
                                        <th><%= MyBase.GetResourceString("H_StartDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_EndDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_Duration") %></th>
                                        <th><%= MyBase.GetResourceString("H_Work") %></th>
                                        <th><%= MyBase.GetResourceString("H_StartDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_Work(hrs)") %></th>
                                        <th><%= MyBase.GetResourceString("H_Variance(hrs)") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyTodoListGridTbl"></tbody>
                            </table>
                        </div>

                        <!--To Do List Table end here-->
                        <!--Issues Table start here-->
                        <div id="IDIssuelistTblwrapper" class="access2 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">

                            <table id="IssueListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("H_Flag") %></th>
                                        <th><%= MyBase.GetResourceString("H_Document") %></th>
                                        <th width="200px"><%= MyBase.GetResourceString("H_Issue") %></th>
                                        <th><%= MyBase.GetResourceString("H_Priority") %></th>
                                        <th><%= MyBase.GetResourceString("H_Status") %></th>
                                        <th><%= MyBase.GetResourceString("H_StartDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_EndDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_Work(hrs)") %></th>
                                        <th><%= MyBase.GetResourceString("H_ActualWork(hrs)") %></th>
                                        <%--<th><%= MyBase.GetResourceString("H_TaskEntry") %></th>--%>
                                    </tr>
                                </thead>
                                <tbody id="BodyIssueListTbl"></tbody>
                            </table>
                        </div>
                        <!--Issues Table end here-->
                        <!--Reviews Table start here-->
                        <div id="IDReviewlistTblwrapper" class="access3 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">
                            <table id="ReviewListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_IsReviewee") %></th>
                                        <%-- <th><%= MyBase.GetResourceString("H_Flag") %></th>--%>
                                        <th><%= MyBase.GetResourceString("H_Document") %></th>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("H_ReviewType") %></th>
                                        <th><%= MyBase.GetResourceString("H_ReviewDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_Reviewer(s)") %></th>
                                        <th><%= MyBase.GetResourceString("H_Reviewee") %></th>
                                        <th><%= MyBase.GetResourceString("H_Work(hrs)") %></th>
                                        <th><%= MyBase.GetResourceString("H_ReviewStatus") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyReviewListTbl"></tbody>
                            </table>
                        </div>
                        <!--Reviews Table end here-->
                        <!--Risks Table start here-->
                        <div id="IDRisklistTblwrapper" class="access4 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">

                            <table id="RiskListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <%--<th><%= MyBase.GetResourceString("H_RiskID") %></th>
                                        <th><%= MyBase.GetResourceString("H_Flag") %></th>--%>
                                        <th><%= MyBase.GetResourceString("H_Risk") %></th>
                                        <th><%= MyBase.GetResourceString("H_DateIdentified") %></th>
                                        <th><%= MyBase.GetResourceString("H_Probability") %></th>
                                        <th><%= MyBase.GetResourceString("H_Severity") %></th>
                                        <th><%= MyBase.GetResourceString("H_Status") %></th>
                                        <th><%= MyBase.GetResourceString("H_PersonResponsible") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyIDRisklistTbl">
                                </tbody>
                            </table>
                        </div>
                        <!--Risks Table end here-->
                        <!--Milestone Table end here-->
                        <div id="IDMilestonelistTblwrapper" class="access5 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">

                            <table id="milestoneListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("H_MilestoneID") %></th>
                                        <%--<th><%= MyBase.GetResourceString("H_Flag") %></th>--%>
                                        <th><%= MyBase.GetResourceString("H_Document") %></th>
                                        <th><%= MyBase.GetResourceString("H_Milestone") %></th>
                                        <th><%= MyBase.GetResourceString("H_StartDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_EndDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_AnalysisStatus") %></th>
                                        <th><%= MyBase.GetResourceString("H_Milestonestatus") %></th>
                                        <th><%= MyBase.GetResourceString("H_ShowReport") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodymilestoneListTbl"></tbody>
                            </table>
                        </div>
                        <!--Milestone Table end here-->
                        <!--Deliverables Table start here-->
                        <div id="IDDlvrablelistTblwrapper" class="access6 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">

                            <table id="DlvrableListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <%--  <th><%= MyBase.GetResourceString("H_Flag") %></th>
                                        <th><%= MyBase.GetResourceString("H_Document") %></th>--%>
                                        <th><%= MyBase.GetResourceString("H_DeliverableCode") %></th>
                                        <th><%= MyBase.GetResourceString("H_Title") %></th>
                                        <th><%= MyBase.GetResourceString("H_StartDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_EndDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_PlanEffort") %></th>
                                        <th><%= MyBase.GetResourceString("H_ActualEffort") %></th>
                                        <th><%= MyBase.GetResourceString("H_ShowReport") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyDlvrableListTbl"></tbody>
                            </table>
                        </div>
                        <!--Deliverables Table end here-->
                        <!--ETC Requests Table start here-->
                        <div id="IDETCrequestTblwrapper" class="access7 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">

                            <table id="ETCrequestsListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("H_TotalTasks") %></th>
                                        <th><%= MyBase.GetResourceString("H_TotalETCHours") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodyETCrequestsListTbl"></tbody>
                            </table>
                        </div>
                        <!--ETC Requests Table end here-->
                        <!--My Projects Table start here-->
                        <div id="IDMyProjectTblwrapper" class="access8 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">

                            <table id="myProjectListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("H_StartDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_EndDate") %></th>
                                        <th><%= MyBase.GetResourceString("H_Duration(Days)") %></th>
                                        <th><%= MyBase.GetResourceString("H_Work(Hrs)") %></th>
                                        <th><%= MyBase.GetResourceString("H_ActualWork(hrs)") %></th>
                                        <th><%= MyBase.GetResourceString("H_ShowReport") %></th>
                                    </tr>
                                </thead>
                                <tbody id="BodymyProjectListTbl"></tbody>
                            </table>
                        </div>
                        <!--My Projects Table end here-->
                        <!--Selected Project List Table start here-->
                        <div class="IDShowalllistTblwrapper access9 dashGridTblOuter tab-pane fade" role="tabpanel" tabindex="0">
                            <div class="tabinnerFltr">
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr1" name="Rgroup1" value="" type="radio" checked="checked">
                                    <label for="edashRadioFltr1"><span></span>Today(Pending Task Included)</label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr2" name="Rgroup1" value="" type="radio" checked="checked">
                                    <label for="edashRadioFltr2"><span></span>Previous Week</label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr3" name="Rgroup1" value="" type="radio" checked="checked">
                                    <label for="edashRadioFltr3"><span></span>This Week</label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr4" name="Rgroup1" value="" type="radio" checked="checked">
                                    <label for="edashRadioFltr4"><span></span>Next Week</label>
                                </div>
                                <div class="custom_radio d-inline-block">
                                    <input id="edashRadioFltr5" name="Rgroup1" value="" type="radio" checked="checked">
                                    <label for="edashRadioFltr5"><span></span>Date Range</label>
                                </div>

                            </div>
                            <table id="ShowAllListTbl" class="table table-bordered ClsdashTbl">
                                <thead>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th colspan="4">Baseline</th>
                                        <th colspan="2">ACtual</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                    <tr>
                                        <th>Task Type Link</th>
                                        <th>Flag</th>
                                        <th>Document</th>
                                        <th>Task Name</th>
                                        <th>Priority</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Duration</th>
                                        <th>Work</th>
                                        <th>Start Date</th>
                                        <th>Work(hrs)</th>
                                        <th>Variance(hrs)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="graybg">
                                        <td colspan="12" class="text-start"><strong>12345</strong></td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><a href="javascript:;"><i class="fa-regular fa-file-lines"></i></a></td>
                                        <td>Web Developement</td>
                                        <td>High</td>
                                        <td>20 Mar 2022</td>
                                        <td>28 Mar 2022</td>
                                        <td>12.00</td>
                                        <td>6.00</td>
                                        <td>28 Mar 2022</td>
                                        <td>3.00</td>
                                        <td>2.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><a href="javascript:;"><i class="fa-regular fa-file-lines"></i></a></td>
                                        <td>Task Type New 1</td>
                                        <td>High</td>
                                        <td>23 Sep 2022</td>
                                        <td>31 Sep 2022</td>
                                        <td>14.00</td>
                                        <td>5.00</td>
                                        <td>23 Sep 2022</td>
                                        <td>5.00</td>
                                        <td>2.00</td>
                                    </tr>
                                    <tr class="graybg">
                                        <td colspan="12" class="text-start"><strong>Project -233545656</strong></td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><a href="javascript:;"><i class="fa-regular fa-file-lines"></i></a></td>
                                        <td>Graphic Designing</td>
                                        <td>Medium</td>
                                        <td>23 Oct 2022</td>
                                        <td>31 Oct 2022</td>
                                        <td>13.00</td>
                                        <td>4.00</td>
                                        <td>22 Sep 2022</td>
                                        <td>4.00</td>
                                        <td>3.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><a href="javascript:;"><i class="fa-regular fa-file-lines"></i></a></td>
                                        <td>Task Type New 1</td>
                                        <td>High</td>
                                        <td>23 Sep 2022</td>
                                        <td>31 Sep 2022</td>
                                        <td>14.00</td>
                                        <td>5.00</td>
                                        <td>23 Sep 2022</td>
                                        <td>5.00</td>
                                        <td>2.00</td>
                                    </tr>
                                    <tr class="graybg">
                                        <td colspan="12" class="text-start"><strong>Lorem Ipsum Project-1234</strong></td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                        <td style="display: none;">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><a href="javascript:;"><i class="fa-regular fa-file-lines"></i></a></td>
                                        <td>Html Design</td>
                                        <td>Medium</td>
                                        <td>23 Sep 2022</td>
                                        <td>31 Sep 2022</td>
                                        <td>10.00</td>
                                        <td>5.00</td>
                                        <td>23 Sep 2022</td>
                                        <td>3.00</td>
                                        <td>2.00</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><a href="javascript:;"><i class="fa-regular fa-file-lines"></i></a></td>
                                        <td>Html Developer</td>
                                        <td>Low</td>
                                        <td>23 Sep 2022</td>
                                        <td>31 Sep 2022</td>
                                        <td>10.00</td>
                                        <td>5.00</td>
                                        <td>23 Sep 2022</td>
                                        <td>3.00</td>
                                        <td>2.00</td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                        <!--Selected Project List Table end here-->
                    </div>


                </div>
                <!--edashboard end here-->
                <!--edashboard start here-->
                <div id="pmdashTab2" class="tab tab-pane">
                    <div class="row pt-2 pb-2 graybg">
                        <div class="col-sm-4"><%= MyBase.GetResourceString("C_PendingTaskEntriesForLast7Days") %></div>
                        <div class="col-sm-8 text-end">
                            <div class="pendingentriesdayslist" id="pendingentriesdayslist"></div>
                        </div>
                    </div>

                    <div class="pmdash-timesheet">
                        <div class="row pt-1 pb-1 d-flex align-items-center">
                            <div class="col-sm-8">
                                <div class="row">
                                    <div class="col-sm-7 d-flex">
                                        <strong>Task List: <span id="DayName"></span></strong>
                                        <div class="form-group mr1">
                                            <div class="input-group">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("daylistdatepicker", "daylistdatepicker", "inp form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-5 mt-1">
                                        <a href="javascript:;" class="btn borderbtn" onclick="PreviousDay()"><%= MyBase.GetResourceString("B_PreviousDay") %></a>
                                        <a href="javascript:;" class="btn borderbtn" onclick="NextDay()"><%= MyBase.GetResourceString("btn_NextDay") %></a>
                                    </div>


                                </div>
                            </div>
                            <div class="col-sm-4 text-end">
                                <%--<a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#updatetaskModal"><%= MyBase.GetResourceString("UpdateTask") %></a>--%>
                               <%-- <% If m_blnDeleteAccess = True Then %>
                                    <a href="javascript:;" class="btn borderbtn" onclick="DeletePendingTaskEntry()"><%= MyBase.GetResourceString("Btn_Delete") %></a>
                                <% End If %>--%>
                                <a href="javascript:;" class="btn borderbtn" onclick="DeletePendingTaskEntry()"><%= MyBase.GetResourceString("Btn_Delete") %></a>
                                <%--<a href="javascript:;" class="btn borderbtn"><%= MyBase.GetResourceString("Btn_WeeklyView") %></a>--%>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                        <table id="pmdashTimesheetTbl" class="table" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("H_TaskName") %></th>
                                    <th><%= MyBase.GetResourceString("H_ActualWork(hrs)") %></th>
                                    <th><%= MyBase.GetResourceString("H_Description") %></th>
                                    <th><%= MyBase.GetResourceString("H_DAType") %></th>
                                    <th><%= MyBase.GetResourceString("H_Delete") %></th>
                                </tr>
                            </thead>
                            <tbody id="BodypmdashTimesheetTbl"></tbody>
                        </table>
                        <div class="clearfix"></div>
                        <div class="row">
                            <div class="col-sm-6">Activities marked as <font color="red">RED</font> are either void, deleted or on hold.</div>
                            <div class="col-sm-6 text-end"><strong>Total Actual Work (hrs) =  <span id="txtPendingTaskEntriesTotal"></span> </strong></div>
                        </div>
                    </div>


                </div>
                <!--edashboard end here-->
                <!--edashboard start here-->
                <div id="pmdashTab3" class="tab tab-pane">
                    <div class="divwrapIA">
                        <table id="issueagingTbl" class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("H_ProjectName") %></th>
                                    <th><%= MyBase.GetResourceString("Upto5Days") %></th>
                                    <th><%= MyBase.GetResourceString("5To10Days") %></th>
                                    <th><%= MyBase.GetResourceString("MoreThan10Days") %></th>
                                </tr>
                            </thead>
                            <tbody id="BodyissueagingTbl"></tbody>
                        </table>
                    </div>
                </div>
                <!--edashboard end here-->
            </div>

        </div> 
        <div class="clearfix"></div>
        <div class="clearfix"></div>
    </div>


    <!--issue entry modal start here-->
    <div class="modal custmodal fade" id="issueentrymodal" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Issues</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="text-end pb-1">
                        <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#AssignIssueModal">Assign Issue</a>
                        <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#discussionModal">Discussion Thread</a>
                        <button href="javascript:;" class="btn btnyellow">Save</button>
                    </div>
                    <div class="box-body p-0">
                        <div class="boxformheading"><strong>Issues [Details]</strong></div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>Summary</label>
                                    <textarea class="form-control"></textarea>
                                </div>
                                <div class="col-sm-6">
                                    <label>Description</label>
                                    <textarea class="form-control"></textarea>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <hr />
                    <div class="box-body p-0">
                        <div class="boxformheading"><strong>Common Fields</strong></div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label>Submitted By</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>User 1</option>
                                        <option>User 2</option>
                                        <option>User 3</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="mandatory">Submitted Date</label>
                                    <div class="input-group">
                                        <input id="CF_submitteddate" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label>Type</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Customer Complaint</option>
                                        <option>Customer Conncern</option>
                                        <option>Defect</option>
                                        <option>Observation</option>
                                        <option>Type</option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Submitted Time</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Status</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Acknowladge</option>
                                        <option>Closed</option>
                                        <option>Defined</option>
                                        <option>In Progress</option>
                                        <option>ReOpen</option>
                                        <option>Resolved</option>
                                        <option>Submitted</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Sub Type</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Customer Concern</option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Severity</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Critical</option>
                                        <option>Normal</option>
                                        <option>ShowStoper</option>
                                        <option>Trivial</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Complexity</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Highly Complex</option>
                                        <option>Medium Complex</option>
                                        <option>Simple</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Root Cause</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Module Name</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Module1</option>
                                        <option>Module2</option>
                                        <option>Module3</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Change Request</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Request1</option>
                                        <option>Request2</option>
                                        <option>Request3</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Coded By</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>User 1</option>
                                        <option>User 2</option>
                                        <option>User 3</option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Responsible Person</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>User1</option>
                                        <option>User2</option>
                                        <option>User3</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Reported In Version</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Corrected In Version</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Source Phase</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Product Documentation</option>
                                        <option>Project Management</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Found In Phase</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Product Documentation</option>
                                        <option>Project Management</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Fixed In Phase</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option>Product Documentation</option>
                                        <option>Project Management</option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Import ID</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Customer Issue ID</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="col-sm-4">
                                    <label>Show To Customer</label>
                                    <div class="custom_chckbox inline">
                                        <input id="Showcustcheck" class="chcktbl" type="checkbox">
                                        <label for="Showcustcheck">First Half Day</label>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Hardware</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Operating System</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Kernel</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Iteration</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">User Story</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Action Type</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Origin</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">TBMS Layer</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Base Incident Category</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Incident Category</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Defect Origination Layer</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>RCA Category</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Defect Kind</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Functional Area</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>SubFunctional Area</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">RCA Detail</label>

                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Assigned to</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Corrective Action</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Preventive Action</label>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Environment Details</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Expected Outcome</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Actual Outcome</label>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Test Case ID</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Incident Failed Count</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Issue Identified in-Release ID</label>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Sub User Story</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>FixedInUser Story</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Fixed by</label>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Fixed date</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Fixed in Release Patch</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Resolution Comment</label>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Project Layer</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Release Patch</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">Id Test Step</label>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required">Issue Sprint</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Issue User Story</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="required">PMS No</label>
                                </div>
                                <div class="col-sm-4">
                                    &nbsp;
                                </div>
                                <div class="col-sm-4">
                                    &nbsp;
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <hr />

                    <div class="box-body p-0">
                        <div class="boxformheading">Custom Field</div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label>Custom field 1</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="col-sm-4">
                                    <label>Custom field 2</label>
                                    <select class="form-control">
                                        <option>Select Option</option>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <label>Custom field 3</label>
                                    <textarea class="form-control"></textarea>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <hr />
                    <div class="box-body p-0">
                        <div class="boxformheading">Keywords</div>
                        <div class="form-group">
                            <div class="row keywords">
                                <div class="col-sm-3">
                                    <select class="form-control">
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control">
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control">
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control">
                                        <option></option>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control">
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                    </div>
                    <hr />
                    <div class="box-body p-0">
                        <div class="boxformheading">Attachments</div>
                        <table class="table table-bordered attachments">
                            <thead>
                                <tr>
                                    <th>File Name</th>
                                    <th>Attached By</th>
                                    <th>Description</th>
                                    <th>
                                        <div class="custom_chckbox">
                                            <input id="delcheck0" class="chckHead" type="checkbox">
                                            <label for="delcheck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Test File</td>
                                    <td>User 1</td>
                                    <td>Lorem ipsum is a dummy text. lorem ipsum is a dummy text</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="delcheck0" class="chckHead" type="checkbox">
                                            <label for="delcheck0"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Test File</td>
                                    <td>User 1</td>
                                    <td>Lorem ipsum is a dummy text.</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="delcheck1" class="chckHead" type="checkbox">
                                            <label for="delcheck1"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Test File</td>
                                    <td>User 2</td>
                                    <td>Lorem ipsum is a dummy text. lorem ipsum text</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="delcheck2" class="chckHead" type="checkbox">
                                            <label for="delcheck2"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Test File</td>
                                    <td>User 3</td>
                                    <td>Lorem ipsum is a dummy text. lorem ipsum is a dummy text</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="delcheck3" class="chckHead" type="checkbox">
                                            <label for="delcheck3"></label>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="text-center">
                    <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                </div>
                <br />
            </div>
        </div>
    </div>

    <%--<!--issue entry modal end-->
    <!--Assign Issues modal start here-->
    <div class="modal custmodal fade" id="AssignIssueModal" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Issue Assignment</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#issueentrymodal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-inline">Show names starting with these letters only<input type="text" class="form-control ml-1" />
                        <button class="btn btnyellow">Show</button><a href="javascript:;" class="btn borderbtn ml-1">Clear</a></div>
                    <br />
                    <div class="d-flex justify-content-start">
                        <div class="form-group col">
                            <div class="d-flex justify-content-start">
                                <label class="col-sm-2">Due Date</label>
                                <div class="input-group" style="width: 200px;">
                                    <input id="issueassignDuedatepicker" type="text" class="form-control">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col ml-1 text-end">
                            <label>Work(H:M) :</label>
                            32.00
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <br />
                    <table id="IDIssueAsignmentListTbl" class="table table-stripped table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>User Name</th>
                                <th>Organization Unit</th>
                                <th>Role</th>
                                <th>Show Schedule</th>
                                <th>Assign</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Work (H:M)</th>
                                <th>Re-Open Task</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>user466</td>
                                <td>Kuravankonam</td>
                                <td>First Impression Officer</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#showschedule">Show Schedule</a></td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="showAllResourceChek1" class="chcktbl" type="checkbox">
                                        <label for="showAllResourceChek1"></label>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridstartdate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridenddate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <input type="text" class="form-control" /></td>
                                <td>N/A</td>
                            </tr>
                            <tr>
                                <td>user466</td>
                                <td>Kuravankonam</td>
                                <td>First Impression Officer</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#showschedule">Show Schedule</a></td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="showAllResourceChek2" class="chcktbl" type="checkbox">
                                        <label for="showAllResourceChek2"></label>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridstartdate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridenddate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <input type="text" class="form-control" /></td>
                                <td>N/A</td>
                            </tr>
                            <tr>
                                <td>user466</td>
                                <td>Kuravankonam</td>
                                <td>First Impression Officer</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#showschedule">Show Schedule</a></td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="showAllResourceChek3" class="chcktbl" type="checkbox">
                                        <label for="showAllResourceChek3"></label>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridstartdate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridenddate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <input type="text" class="form-control" /></td>
                                <td>N/A</td>
                            </tr>
                            <tr>
                                <td>user466</td>
                                <td>Kuravankonam</td>
                                <td>First Impression Officer</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#showschedule">Show Schedule</a></td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="showAllResourceChek4" class="chcktbl" type="checkbox">
                                        <label for="showAllResourceChek4"></label>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridstartdate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridenddate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <input type="text" class="form-control" /></td>
                                <td>N/A</td>
                            </tr>
                            <tr>
                                <td>user466</td>
                                <td>Kuravankonam</td>
                                <td>First Impression Officer</td>
                                <td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#showschedule">Show Schedule</a></td>
                                <td>
                                    <div class="custom_chckbox">
                                        <input id="showAllResourceChek5" class="chcktbl" type="checkbox">
                                        <label for="showAllResourceChek5"></label>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridstartdate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input id="IssueAsinmntgridenddate1" type="text" class="form-control">
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <input type="text" class="form-control" /></td>
                                <td>N/A</td>
                            </tr>
                        </tbody>
                    </table>
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Assign Issues modal end-->
    <!-- Schedule Type Modal start here-->
    <div class="modal custmodal fade" id="showschedule" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Schedule</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#showschedule" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="form-inline">
                        <div class="form-group float-start">
                            Date Range From
                            <div class="input-group inline">
                                <input id="daterangeFrom" type="text" class="form-control mr0">
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>
                            &nbsp;&nbsp; To &nbsp;&nbsp;
                            <div class="input-group inline">
                                <input id="daterangeTo" type="text" class="form-control mr0">
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>
                            <button class="btn btnyellow">Show</button>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <br />
                    <div class="notebox graybg">The period for which you are viewing the schedule of the resource(s) has already elapsed. So you may not get an accurate picture of the schedule.</div>
                    <div class="table-responsive" style="max-height: 300px;">
                        <table class="table table-stripped table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Project Name</th>
                                    <th>Task Name</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Work(H:M)</th>
                                    <th>Actual Work(H:M)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Resource 01</td>
                                    <td>Whiz Project</td>
                                    <td>Html Task</td>
                                    <td>01 Jan 2022</td>
                                    <td>31 Jan 2022</td>
                                    <td>20.00</td>
                                    <td>30.00</td>
                                </tr>
                                <tr>
                                    <td>Resource 01</td>
                                    <td>Whiz Project</td>
                                    <td>Html Task</td>
                                    <td>01 Jan 2022</td>
                                    <td>31 Jan 2022</td>
                                    <td>20.00</td>
                                    <td>30.00</td>
                                </tr>
                                <tr>
                                    <td>Resource 01</td>
                                    <td>Whiz Project</td>
                                    <td>Html Task</td>
                                    <td>01 Jan 2022</td>
                                    <td>31 Jan 2022</td>
                                    <td>20.00</td>
                                    <td>30.00</td>
                                </tr>
                                <tr>
                                    <td>Resource 01</td>
                                    <td>Whiz Project</td>
                                    <td>Html Task</td>
                                    <td>01 Jan 2022</td>
                                    <td>31 Jan 2022</td>
                                    <td>20.00</td>
                                    <td>30.00</td>
                                </tr>
                                <tr>
                                    <td>Resource 01</td>
                                    <td>Whiz Project</td>
                                    <td>Html Task</td>
                                    <td>01 Jan 2022</td>
                                    <td>31 Jan 2022</td>
                                    <td>20.00</td>
                                    <td>30.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>


                    <div class="clearfix"></div>
                    <hr />

                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Schedule Modal End here-->
    <!-- Discussion Thred Modal start here-->
    <div class="modal custmodal fade" id="discussionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Discussion Thread</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#issueentrymodal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p class="text-end"><small>(Discussion thread in blue color indicates thread shown to customer)(<font color="red">*</font>Mandatory)</small></p>
                    <div class="form-vertical">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-4 text-end">User Name :</label>
                                <div class="col-sm-8">user61</div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-4 text-end">Date :</label>
                                <div class="col-sm-8">09 Jun 2022 <span>|</span> 11:44:10 AM</div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <label class="col-sm-4 text-end">Comments<small>(max length 7000 characters)</small> :</label>
                                <div class="col-sm-8">
                                    <textarea class="form-control"></textarea>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-4 text-end">Status :</label>
                                <div class="col-sm-8">
                                    <select class="form-control">
                                        <option>In Progress</option>
                                        <option>Acknowladge</option>
                                        <option>Closed</option>
                                        <option>Defined</option>
                                        <option>ReOpen</option>
                                        <option>Resolved</option>
                                        <option>Submitted</option>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <br />
                    <table id="discussionTbl" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>User Name</th>
                                <th>Dates</th>
                                <th>Comments</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>User 1</td>
                                <td>2 Jun 2022</td>
                                <td>Lorem ipsum is dummy text.Lorem ipsum is dummy text.</td>
                            </tr>
                            <tr>
                                <td>User 2</td>
                                <td>2 Mar 2022</td>
                                <td>Lorem ipsum is dummy text.</td>
                            </tr>
                            <tr>
                                <td>User 3</td>
                                <td>4 Jul 2022</td>
                                <td>Lorem ipsum is dummy text.Lorem ipsum is dummy text.</td>
                            </tr>
                            <tr>
                                <td>User 4</td>
                                <td>6 Jul 2022</td>
                                <td>Lorem ipsum is dummy text.</td>
                            </tr>
                            <tr>
                                <td>User 5</td>
                                <td>2 Jun 2022</td>
                                <td>Lorem ipsum is dummy text.Lorem ipsum is dummy text.</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="clearfix"></div>
                    <hr />

                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Discussion Thred Modal End here-->--%>

    <!-- Show Milestone Report Modal start here-->
    <div class="modal custmodal fade" id="ShowReportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("ShowReport") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><strong><%= MyBase.GetResourceString("MilestoneAnalysis") %></strong></p>
                        </div>
                        <div class="col-sm-6">
                            <div class="text-end">
                                <%--<a href="javascript:;" class="btn borderbtn">Add To Dashboard</a>
                                <a href="javascript:;" class="btn borderbtn">Configuration</a>--%>
                                <div class="dropdown filedownload showreportDownload">
                                    <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" title="Click here to download" class="fas fa-download"></i></button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('PDF',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px"><%= MyBase.GetResourceString("H_Pdf") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('EXCEL',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px"><%= MyBase.GetResourceString("H_Xlsx") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('XML',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px"><%= MyBase.GetResourceString("H_Xml") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('TEXT',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px"><%= MyBase.GetResourceString("H_Doc") %></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="form-vertical">
                        <div class="form-group mb-3">
                            <div class="row">
                                <label class="col-sm-2 text-start"><%= MyBase.GetResourceString("Milestone:") %></label>
                                <div class="col-sm-4 text-start"><% CommonFunctions.HTMLControls.DrawComboBox("cboMileStone", "Select ''",,, "class='form-select input-sm'", False,, ) %></div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="notebox graybg">
                        <strong>Note:</strong> <%= MyBase.GetResourceString("MilestoneNote") %>
                    </div>

                    <div class="clearfix"></div>
                    <hr />

                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("Btn_Cancel") %></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Show Report Modal End here-->

    <!-- Show Deliverable Report Modal start here-->
    <div class="modal custmodal fade" id="ShowDelReportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="modal-title" id=""><%= MyBase.GetResourceString("ShowDeliverableReport") %></p>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><%= MyBase.GetResourceString("DeliverableReport") %></p>
                            <input id="DeliverableUniqueid" type="hidden" />
                        </div>
                        <div class="col-sm-6">
                            <div class="text-end">
                               <%-- <a href="javascript:;" class="btn borderbtn">Add To Dashboard</a>--%>
                                <div class="dropdown filedownload showreportDownload">
                                    <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" title="Click here to download" class="fas fa-download"></i></button>
                                    <ul class="dropdown-menu">
                                      <li>
                                            <a href="#" onclick="Export_PDFClick('PDF',1895)">
                                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px"><%= MyBase.GetResourceString("H_Pdf") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('EXCEL',1895)">
                                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px"><%= MyBase.GetResourceString("H_Xlsx") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('XML',1895)">
                                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px"><%= MyBase.GetResourceString("H_Xml") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('TEXT',1895)">
                                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px"><%= MyBase.GetResourceString("H_Doc") %></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="form-vertical">
                        <div class="form-group mb-3">
                            <div class="row">
                                <label class="col-sm-2 text-start required"><%= MyBase.GetResourceString("Deliverable :") %></label>
                                <div class="col-sm-4">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboDeliverable", "Select ''",,, "class='form-select input-sm'", False,, ) %>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="notebox graybg">
                        <strong>Note:</strong> <%= MyBase.GetResourceString("DeliverableNote") %>
                    </div>

                    <div class="clearfix"></div>
                    <hr />

                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("Btn_Cancel") %></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Show Deliverable Report Modal End here-->
   
    <!-- My Projects Report Modal start here-->
    <div class="modal custmodal fade" id="ShowMyProReportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("ProjectReport") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><strong><%= MyBase.GetResourceString("ProjectInformationReport") %></strong></p>
                        </div>
                        <div class="col-sm-6">
                            <div class="text-end">
                              <%--  <a href="javascript:;" class="btn borderbtn">Add To Dashboard</a>
                                <a href="javascript:;" class="btn borderbtn">Configuration</a>--%>
                                <div class="dropdown filedownload showreportDownload">
                                    <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" title="Click here to download" class="fas fa-download"></i></button>
                                    <ul class="dropdown-menu">
                                      <li>
                                            <a href="#" onclick="Export_PDFClick('PDF',746)">
                                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px"><%= MyBase.GetResourceString("H_Pdf") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('EXCEL',746)">
                                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px"><%= MyBase.GetResourceString("H_Xlsx") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('XML',746)">
                                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px"><%= MyBase.GetResourceString("H_Xml") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('TEXT',746)">
                                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px"><%= MyBase.GetResourceString("H_Doc") %></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="form-vertical">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-2 text-start required"><%= MyBase.GetResourceString("ProjectName:") %></label>
                                <div class="col-sm-4">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "Select ''",,, "class='form-select input-sm'", False,, ) %>                                     
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <br />
                    <div class="notebox graybg">
                        <strong>Note:</strong> <%= MyBase.GetResourceString("ProjectNameNote") %>
                    </div>

                    <div class="clearfix"></div>
                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("Btn_Cancel") %></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- My Projects Report Modal End here-->
    
    <!-- Update Task Modal start here-->
    <div class="modal custmodal fade" id="updatetaskModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("Timesheet") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-1 text-end">
                        <a href="javscript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#Createasigntaskmodal"><%= MyBase.GetResourceString("CreateTask") %></a>
                        <button class="btn btnyellow"><%= MyBase.GetResourceString("SaveAndAddMore") %></button>
                        <button class="btn btnyellow"><%= MyBase.GetResourceString("SaveAndRefreshTaskList") %></button>
                        <button class="btn btnyellow"><%= MyBase.GetResourceString("SaveAndClose") %></button>
                    </div>
                    <br />
                    <div class="notebox graybg"><%= MyBase.GetResourceString("TimesheetNote") %></div>
                    <div class="d-flex justify-content-start graybg container-fluid pt-1 pb-1 mb-1">
                        <strong><%= MyBase.GetResourceString("Add/Modify") %></strong>
                        <div class="form-group">
                            <div class="input-group ml-1">
                                <input id="modifytaskdate" type="text" class="form-control">
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="form-vertical">
                        <div class="form-group">
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("SelectProject:") %></label>
                                <div class="col-sm-6">
                                    <select class="form-control">
                                        <option></option>
                                        <option>Project 002</option>
                                        <option>Whiz Project</option>
                                        <option>Whiz Project 003</option>
                                    </select>
                                </div>
                                <div class="col-sm-1 pl-0"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#projectlistModal"><i class="fas fa-ellipsis-v" data-bs-toggle="tooltip" title="Project Selection"></i></a></div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end">&nbsp;</label>
                                <div class="col-sm-9">
                                    <div class="custom_radio d-inline-block">
                                        <input id="radio0" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radio0"><span></span><%= MyBase.GetResourceString("GeneralTasks") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radio" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radio"><span></span><%= MyBase.GetResourceString("MPPTasks") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radio1" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radio1"><span></span><%= MyBase.GetResourceString("AssignedTasks") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radio2" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radio2"><span></span><%= MyBase.GetResourceString("IssuesAssigned") %></label>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("SelectTask:") %></label>
                                <div class="col-sm-6">
                                    <select class="form-control">
                                        <option>Select Task</option>
                                        <option>Task 002</option>
                                        <option>Html Task</option>
                                        <option>Graphic Task 004</option>
                                    </select>
                                </div>
                                <div class="col-sm-1 pl-0">
                                    <a href="javascript:;" data-bs-toggle="tooltip" data-bs-target="#TaskSelectionModal"><i class="fas fa-ellipsis-v" data-bs-toggle="tooltip" title="Task Selection"></i></a>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("SelectActivity:") %></label>
                                <div class="col-sm-6">
                                    <select class="form-control">
                                        <option>Select Activity</option>
                                        <option>Activity 01</option>
                                        <option>Activity 02</option>
                                    </select>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end">&nbsp;</label>
                                <div class="col-sm-7">
                                    <div class="custom_radio d-inline-block">
                                        <input id="SelActivityradio1" name="SLgroup2" value="" type="radio" checked="checked">
                                        <label for="SelActivityradio1"><span></span><%= MyBase.GetResourceString("Normal") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="SelActivityradio2" name="SLgroup2" value="" type="radio" checked="checked">
                                        <label for="SelActivityradio2"><span></span><%= MyBase.GetResourceString("OverTime") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="SelActivityradio3" name="SLgroup2" value="" type="radio" checked="checked">
                                        <label for="SelActivityradio3"><span></span><%= MyBase.GetResourceString("OverStay") %></label>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("ActualWork(Hrs):") %></label>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" />
                                        </div>
                                        <div class="col-sm-9 form-inline">
                                            <div class="form-group">
                                                <label><%= MyBase.GetResourceString("Actual%complete") %></label><input type="text" class="form-control ml-1" /></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("Description:") %></label>
                                <div class="col-sm-8">
                                    <textarea class="form-control"></textarea>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <br />

                    <div class="clearfix"></div>
                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("Btn_Cancel") %></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Update Task Modal End here-->
   
    <!--E-dash-Timesheet Modal start here-->
    <div class="modal custmodal fade" id="EdashTMModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("Timesheet") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-1 text-end"> 
                        <button class="btn btnyellow" onclick="ToDoListSave()"><%= MyBase.GetResourceString("Btn_SaveAndClose") %></button>
                    </div>
                    <br />
                    <div class="notebox graybg"><%= MyBase.GetResourceString("TimesheetNote") %></div>
                    <div class="d-flex justify-content-start graybg container-fluid pt-1 pb-1 mb-1">
                        <strong><%= MyBase.GetResourceString("Add/Modify") %></strong>
                        <div class="form-group">
                            <div class="input-group ml-1">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtTimesheetmodifytaskdate", "txtTimesheetmodifytaskdate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                <span class="input-group-btn">
                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="form-vertical">
                        <div class="form-group">
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("SelectProject:") %></label>
                                <div class="col-sm-6">
                                   <% CommonFunctions.HTMLControls.DrawComboBox("cboToDoListProjectName", "Select ''",,, "class='form-select input-sm'", False,, ) %> 
                                </div>
                                <!--<div class="col-sm-1 pl-0"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#projectlistModal"><i class="fas fa-ellipsis-v" data-bs-toggle="tooltip" title="Project Selection"></i></a></div>-->
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end">&nbsp;</label>
                                <div class="col-sm-9">
                                     <div class="custom_radio d-inline-block">
                                        <input id="radioGeneralTasks" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radioGeneralTasks"><span></span><%= MyBase.GetResourceString("GeneralTasks") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radioMPPTasks" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radioMPPTasks"><span></span><%= MyBase.GetResourceString("MPPTasks") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radioAssignedTasks" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radioAssignedTasks"><span></span><%= MyBase.GetResourceString("AssignedTasks") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radioIssuesAssigned" name="Rgroup1" value="" type="radio" checked="checked">
                                        <label for="radioIssuesAssigned"><span></span><%= MyBase.GetResourceString("IssuesAssigned") %></label>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("SelectTask:") %></label>
                                <div class="col-sm-6">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboToDoListTask", "Select ''",,, "class='form-select input-sm'", False,, ) %>                                     
                                    <br />
                                    <small>Selected Task :<span is="txtToDoListSelectedTaskName"></span></small>
                                </div>
                                <div class="col-sm-1 pl-0">
                                    <a href="javascript:;" data-bs-toggle="tooltip" data-bs-target=""><i class="fas fa-ellipsis-v" data-bs-toggle="tooltip" title="Show Task Notes"></i></a>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("SelectActivity:") %></label>
                                <div class="col-sm-6">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboToDoListSelectActivity", "Select ''",,, "class='form-select input-sm'", False,, ) %>                                     
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="row mb-3">
                                <label class="col-sm-3 text-end">&nbsp;</label>
                                <div class="col-sm-7">
                                    <div class="custom_radio d-inline-block">
                                        <input id="radioActivityNormal" name="SLgroup2" value="" type="radio" checked="checked">
                                        <label for="radioActivityNormal"><span></span><%= MyBase.GetResourceString("Normal") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radioActivityOverTime" name="SLgroup2" value="" type="radio" checked="checked">
                                        <label for="radioActivityOverTime"><span></span><%= MyBase.GetResourceString("OverTime") %></label>
                                    </div>
                                    <div class="custom_radio d-inline-block">
                                        <input id="radioActivityOverStay" name="SLgroup2" value="" type="radio" checked="checked">
                                        <label for="radioActivityOverStay"><span></span><%= MyBase.GetResourceString("OverStay") %></label>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("ActualWork(Hrs):") %></label>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-3"> 
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtTimesheetactualHrs", "txtTimesheetactualHrs", "form-control", 0, 50,,,, , False, "white",, "onkeypress='return Field_OnKeyPress(event)' Autocomplete='off'", , , True,,,, True) %>
                                        </div>
                                        <div class="col-sm-9 form-inline">
                                            <div class="form-group">
                                                <label><%= MyBase.GetResourceString("Actual%complete") %></label>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtTimesheetactualPer", "txtTimesheetactualPer", "form-control ml-1", 0, 50,,,, , False, "white",, "onkeypress='return Field_OnKeyPress(event)' Autocomplete='off'", , , True,,,, True) %>
                                        </div>
                                    </div>
                                    <div class="text-small clsbox pt-1">
                                        Allocated Work (hrs): <strong> <span id="txtTimesheetAllocatedWork"></span></strong> Actual Work (hrs) : <strong><span id="txtTimesheetActualWork"></span></strong>
                                        Do you need more than the allocated time to complete this task?<br />
                                        If yes, enter the additional estimated time to complete (ETC)  <% CommonFunctions.HTMLControls.DrawTextBox("txtTimesheetETC", "txtTimesheetETC", "form-control input-sm ml-1 smalltextfield", 0, 5,,,, , False, "white",, "onkeypress='return Field_OnKeyPress(event)' Autocomplete='off'", , , True,,,, True) %> 
                                        <div class="d-flex"><span class="col"><strong>Start Date : <span id="txtTimesheetStartDate"></span></strong></span><span class="col"><strong>End Date : <span id="txtTimesheetEndDate"></span></strong></span></div>
                                        <div class="clearfix"></div>
                                    </div>

                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-sm-3 text-end"><%= MyBase.GetResourceString("Description:") %></label>
                                <div class="col-sm-8">
                                    <textarea id="txtToDoListDescription" class="form-control"></textarea>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <br />

                    <div class="clearfix"></div>
                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <!--E-dash-Timesheet Modal End here-->
    
   <%-- <!--assign task modal start here-->
    <div class="modal custmodal fade" id="Createasigntaskmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Assigned Tasks</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-1 text-end mtoplinks">
                        <button class="btn btnyellow">Save</button>
                    </div>
                    <br />

                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label required">Task Name</label>
                                <input type="text" class="form-control" />
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Task Notes</label>
                                <textarea class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label required">Resource(s)</label>
                                <div class="row">
                                    <div class="col-sm-10 pr-0">
                                        <select class="form-control">
                                            <option>Select Resources</option>
                                            <option>John C</option>
                                            <option>Mac D</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#showschedule">Show Schedule</a></div>
                                </div>

                            </div>
                            <div class="col-sm-6">
                                &nbsp;
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label required">Work (H:M)</label>
                                <input type="text" class="form-control" />
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Billable</label>
                                <div class="custom_chckbox">
                                    <input id="assignTskBillableChk" class="" type="checkbox">
                                    <label for="assignTskBillableChk"></label>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label required">Start Date</label>
                                <div class="input-group">
                                    <input id="CRTskStartDate" type="text" class="form-control">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label required">End Date</label>
                                <div class="input-group">
                                    <input id="CRTskEndDate" type="text" class="form-control">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label">Priority</label>
                                <select class="form-control">
                                    <option>Select Priority</option>
                                    <option>High</option>
                                    <option>Low</option>
                                    <option>Medium</option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Deliverable</label>
                                <div class="row">
                                    <div class="col-sm-11 pr-0">
                                        <input type="text" class="form-control" /></div>
                                    <div class="col-sm-1">
                                        <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#CRDTmodal"><i class="fa fa-link" aria-hidden="true" style="margin: 5px 0 0;"></i></a>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label required">Task Type</label>
                                <select class="form-control">
                                    <option>Select Option</option>
                                    <option></option>
                                    <option>Review</option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Phase</label>
                                <select class="form-control">
                                    <option>Select Option</option>
                                    <option></option>
                                    <option>Phase 1</option>
                                </select>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label">Module</label>
                                <select class="form-control">
                                    <option>Select Option</option>
                                    <option></option>
                                    <option></option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Sub Project</label>
                                <select class="form-control">
                                    <option>Select Option</option>
                                    <option></option>
                                    <option></option>
                                </select>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label">Milestone</label>
                                <select class="form-control">
                                    <option>Select Option</option>
                                    <option></option>
                                    <option></option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Change Request</label>
                                <select class="form-control">
                                    <option>Select Option</option>
                                    <option></option>
                                    <option>Test</option>
                                </select>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                    <hr />
                    <div class="custmfields">
                        <p><strong>Custom Fields</strong></p>
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-2 text-end">Rework</label>
                                <div class="col-sm-10">(N/A)</div>
                            </div>
                            <div class="row">
                                <label class="col-sm-2 text-end">Domain</label>
                                <div class="col-sm-10">(N/A)</div>
                            </div>
                            <div class="row">
                                <label class="col-sm-2 text-end">Sow</label>
                                <div class="col-sm-10">(N/A)</div>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!--assign task modal end here-->--%>
   
   <%-- <!-- Project selction List Modal start here-->
    <div id="projectlistModal" class="modal custmodal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Project List</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#updatetaskModal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="text-end"><small>(Red color indicates applied filter)</small></div>
                    <div class="d-flex justify-content-start">
                        <div class="form-group">
                            <label>Project Name</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group ml-1">
                            <label>Project Code</label>
                            <input type="text" class="form-control" />
                        </div>
                    </div>
                    <br />
                    <table id="projectlistTbl" class="table table-stripped table-bordered listTbl">
                        <thead>
                            <tr>
                                <th>Project Name</th>
                                <th>Project Code</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="">
                                <td>Whiz Project</td>
                                <td>002</td>
                                <td>01 Jan 2022</td>
                                <td>31 Jan 2022</td>
                            </tr>
                            <tr class="">
                                <td>Whiz Project</td>
                                <td>002</td>
                                <td>01 Jan 2022</td>
                                <td>31 Jan 2022</td>
                            </tr>
                            <tr class="">
                                <td>Whiz Project</td>
                                <td>002</td>
                                <td>01 Jan 2022</td>
                                <td>31 Jan 2022</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="clearfix"></div>
                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!--Project selection List Modal End here-->--%>
    
    <%--<!--task selection Modal start here-->
    <div class="modal custmodal fade" id="TaskSelectionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Task Selection</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="pb-1">
                        <div class="custom_radio d-inline-block">
                            <input id="taskSelradio1" name="taskSelgroup" value="" type="radio" checked="checked">
                            <label for="taskSelradio1"><span></span>General Task</label>
                        </div>
                        <div class="custom_radio d-inline-block">
                            <input id="taskSelradio2" name="taskSelgroup" value="" type="radio" checked="checked">
                            <label for="taskSelradio2"><span></span>MPP Task</label>
                        </div>
                        <div class="custom_radio d-inline-block">
                            <input id="taskSelradio3" name="taskSelgroup" value="" type="radio" checked="checked">
                            <label for="taskSelradio3"><span></span>Assigned Task</label>
                        </div>
                        <div class="custom_radio d-inline-block">
                            <input id="taskSelradio4" name="taskSelgroup" value="" type="radio" checked="checked">
                            <label for="taskSelradio4"><span></span>Issues Task</label>
                        </div>
                    </div>
                    <br />
                    <table id="TskSellistTbl" class="table table-bordered listTbl">
                        <thead>
                            <tr>
                                <th>Task Name</th>
                                <th>Task Notes</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Duration(Days)</th>
                                <th>Work(Hrs)</th>
                                <th>Actual Start Date</th>
                                <th>Actual End Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Project 001</td>
                                <td>&mdash;</td>
                                <td>1 Jan 2022</td>
                                <td>31 Jan 2022</td>
                                <td>2</td>
                                <td>2.00</td>
                                <td>1 Mar 2022</td>
                                <td>31 Apr 2022</td>
                            </tr>
                            <tr>
                                <td>Project 001</td>
                                <td>&mdash;</td>
                                <td>1 Jan 2022</td>
                                <td>31 Jan 2022</td>
                                <td>2</td>
                                <td>2.00</td>
                                <td>1 Mar 2022</td>
                                <td>31 Apr 2022</td>
                            </tr>
                            <tr>
                                <td>Project 001</td>
                                <td>&mdash;</td>
                                <td>1 Jan 2022</td>
                                <td>31 Jan 2022</td>
                                <td>2</td>
                                <td>2.00</td>
                                <td>1 Mar 2022</td>
                                <td>31 Apr 2022</td>
                            </tr>
                            <tr>
                                <td>Project 001</td>
                                <td>&mdash;</td>
                                <td>1 Jan 2022</td>
                                <td>31 Jan 2022</td>
                                <td>2</td>
                                <td>2.00</td>
                                <td>1 Mar 2022</td>
                                <td>31 Apr 2022</td>
                            </tr>
                            <tr>
                                <td>Project 001</td>
                                <td>&mdash;</td>
                                <td>1 Jan 2022</td>
                                <td>31 Jan 2022</td>
                                <td>2</td>
                                <td>2.00</td>
                                <td>1 Mar 2022</td>
                                <td>31 Apr 2022</td>
                            </tr>
                            <tr>
                                <td>Project 001</td>
                                <td>&mdash;</td>
                                <td>1 Jan 2022</td>
                                <td>31 Jan 2022</td>
                                <td>2</td>
                                <td>2.00</td>
                                <td>1 Mar 2022</td>
                                <td>31 Apr 2022</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="clearfix"></div>
                    <div class="btnrow text-center">
                        <!--<button id="savefilterbtn" class="btn btnyellow float-start">Save</button>-->
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!--Project List Modal End here-->--%>
    
    <!-- Flag Report Modal start here-->
    <div class="modal custmodal fade" id="flagmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_TrackingDetails") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox graybg">
                        <%= MyBase.GetResourceString("C_TrackingDetailsNote") %>
                    </div>

                    <input id="txtFlagProjectid" type="hidden"/>
                    <p><strong>Issue ID : </strong><span id="TrackingDetailsIssueID"></span></p>
                    <p><strong>Issue : </strong><span id="TrackingDetailsTaskName"></span></p>
                    <input id="txtUniqueid" type="hidden" />
                    <div class="form-vertical">
                        <div class="row">
                            <div class="form-group mb-3 col">
                                <div class="">
                                    <label class="required"><%= MyBase.GetResourceString("C_Flagto") %></label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboFlagto", "Select ''",,, "class='form-select input-sm'", False,, ) %>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="form-group mb-3 col">
                                <div class="">
                                    <label class="required"><%= MyBase.GetResourceString("C_Dueby") %></label>
                                    <div class="input-group">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("duebydate", "duebydate", "form-control", 0, 50,,,, , True, "white",, "onPaste='return false' Autocomplete='off'", , , True,,,, True) %>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <div class="row">
                                <label class=""><%= MyBase.GetResourceString("C_Complete") %></label>
                                <div class="custom_chckbox">
                                    <input id="flagchkcomplete" class="chcktbl" type="checkbox">
                                    <label for="flagchkcomplete"></label>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>


                    <div class="clearfix"></div>
                    <hr />

                    <div class="btnrow text-center">
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn" onclick="ClearIssueDetails()"><%= MyBase.GetResourceString("Btn_Cancel") %></button>
                        <button id="" class="btn btnyellow" onclick="SaveTrackingDetails()"><%= MyBase.GetResourceString("Btn_Save") %></button>
                        <button id="ClearFlagDetails" class="btn btnyellow" onclick="ClearFlagDetails()"><%= MyBase.GetResourceString("Btn_ClearFlag") %></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Flag Modal End here-->
    
    <!-- Document Report Modal start here-->
    <div class="modal custmodal fade" id="documentationmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("T_DocumentsAttached") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="ClearAttachemnt()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><strong><%= MyBase.GetResourceString("T_DocumentsAttached") %></strong></p>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                    <br />

                    <table id="attachedDocTbl" class="table table-stripped table-bordered attachedDocTbl" style="width: 100%;">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("T_DocumentCategory") %></th>
                                <th><%= MyBase.GetResourceString("T_DocumentSubCategory") %></th>
                                <th><%= MyBase.GetResourceString("T_DocumentName") %></th>
                                <th width="80px"><%= MyBase.GetResourceString("T_UploadDate") %></th>
                                <th><%= MyBase.GetResourceString("T_FileSize(KB)") %></th>
                                <th><%= MyBase.GetResourceString("T_LastModified") %></th>
                            </tr>
                        </thead>
                        <tbody id="BodyattachedDocTbl"></tbody>
                    </table>

                    <div class="clearfix"></div>

                    <div class="btnrow text-center"> 
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn" onclick="ClearAttachemnt()">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Document Modal End here-->

    <div class="modal custmodal fade" id="IssueAttachemntmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("T_DocumentsAttached") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="ClearAttachemnt()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><strong><%= MyBase.GetResourceString("T_DocumentsAttached") %></strong></p>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                    <br />

                    <table id="attachedIssueTbl" class="table table-stripped table-bordered" style="width: 100%;">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("T_FileName") %></th>
                                <th><%= MyBase.GetResourceString("T_AttachedBy") %></th>
                                <th><%= MyBase.GetResourceString("T_UploadDate") %></th>
                                <th><%= MyBase.GetResourceString("T_Description") %></th>
                            </tr>
                        </thead>
                        <tbody id="BodyattachedIssueTbl"></tbody>
                    </table>

                    <div class="clearfix"></div>

                    <div class="btnrow text-center">
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn" onclick="ClearAttachemnt()">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Show Milestone Report Modal start here-->
    <div class="modal custmodal fade" id="ShowProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("ShowReport") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><strong>Project Information Report</strong></p>
                        </div>
                        <div class="col-sm-6">
                            <div class="text-end"> 
                                <div class="dropdown filedownload showreportDownload">
                                    <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" title="Click here to download" class="fas fa-download"></i></button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('PDF',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px"><%= MyBase.GetResourceString("H_Pdf") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('EXCEL',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px"><%= MyBase.GetResourceString("H_Xlsx") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('XML',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px"> <%= MyBase.GetResourceString("H_Xml") %></a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('TEXT',640)">
                                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px"><%= MyBase.GetResourceString("H_Doc") %></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />

                    <div class="form-vertical">
                        <div class="form-group mb-3">
                            <div class="row">
                                <label class="col-sm-2 text-start"><%= MyBase.GetResourceString("ProjectName:") %></label>
                                <div class="col-sm-4 text-start"><% CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "Select ''",,, "class='form-select input-sm'", False,, ) %></div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="notebox graybg">
                        <strong>Note:</strong> Our recommended report format is PDF. Other formats do work in most of the reports, but in some cases output format may not be as good as PDF. This is due to inherent reporting engine problems, which are beyond our control. If you desire we can disable other output formats in your configuration.
                    </div>

                    <div class="clearfix"></div>
                    <hr />

                    <div class="btnrow text-center"> 
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn">Cancel</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Show Report Modal End here-->

    <div class="modal custmodal fade" id="etcauthenticationTblModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ETCAuthentication") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <p><strong><%= MyBase.GetResourceString("C_ETCAuthentication") %></strong></p>
                        </div>
                        <div class="col-sm-6 text-end">
                            <a href="javascript:;" class="btn borderbtn" onclick="ETCAuth()"><%= MyBase.GetResourceString("Btn_Authenticate") %></a>
                            <a href="javascript:;" class="btn borderbtn" onclick="ETCAuthDelete()"><%= MyBase.GetResourceString("Btn_Delete") %></a>
                            <%--<% If m_blnAddAccess = True Then %>
                               <a href="javascript:;" class="btn borderbtn" onclick="ETCAuth()"><%= MyBase.GetResourceString("Btn_Authenticate") %></a>
                            <% End If %> 
                            <% If m_blnDeleteAccess = True Then %>
                               <a href="javascript:;" class="btn borderbtn" onclick="ETCAuthDelete()"><%= MyBase.GetResourceString("Btn_Delete") %></a>
                            <% End If %> --%>
                        </div>
                    </div><br />

                    <div class="tabinnerFltr ETCtabinnerFltr">
                        <div class="custom_radio d-inline-block">
                            <input id="authRadioFltr1" name="authGroup1" value="" type="radio" checked="checked" onclick="MPPTasksETCRequests()">
                            <label for="authRadioFltr1"><span></span><%= MyBase.GetResourceString("C_MPPTasksETCRequests") %>(<span id="txtMPPTasksETCRequestsCount"></span>)</label>
                        </div>
                        <div class="custom_radio d-inline-block">
                            <input id="authRadioFltr2" name="authGroup1" value="" type="radio" checked=""onclick="AssignedTasksETCRequests()">
                            <label for="authRadioFltr2"><span></span><%= MyBase.GetResourceString("C_AssignedTasksETCRequests") %>(<span id="txtAssignedTasksETCRequestsCount"></span>)</label>
                        </div> 
                    </div>

                    <table id="etcauthTbl" class="table table-stripped table-bordered" style="width:100%;">
                        <thead>
                            <tr>
                                <th><%= MyBase.GetResourceString("C_TaskName") %></th>
                                <th><%= MyBase.GetResourceString("C_StartDate") %></th>
                                <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                <th><%= MyBase.GetResourceString("C_ResourceName") %></th>
                                <th><%= MyBase.GetResourceString("C_Work(H:M)") %></th>
                                <th><%= MyBase.GetResourceString("C_ActualWork(H:M)") %></th>
                                <th><%= MyBase.GetResourceString("C_BilledWork(H:M)") %></th>
                                <th><%= MyBase.GetResourceString("C_EstimatedTime(H:M)") %></th>
                                <th><%= MyBase.GetResourceString("C_Authenticate") %></th>
                                <th><%= MyBase.GetResourceString("Btn_Delete") %></th>
                            </tr>
                        </thead>
                        <tbody id="BodyetcauthTbl"></tbody>
                    </table>

                    <div class="clearfix"></div>

                    <div class="btnrow text-center">
                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("Btn_Cancel") %></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- REQUIRED JS SCRIPTS -->

<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> --%>
  

    <script>var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Dashboard").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserId = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var ProjectId = '<%= Session("intProjectID") %>';
        var ajaxResult;
        var gSortAccess = 0;
        var CurrentDate = 0;
        var Showall = 0;
        var ProjectidAccessiable = '';
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        //datepicker
        $('#ffromdate, #ftodate,#daylistdatepicker,#duebydate,#txtTimesheetmodifytaskdate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            yearRange: '-115:+10',
            dateFormat: 'dd M yy',
            onSelect: function (dateText, inst) {
                //alert(dateText);
                TaskListByDate(dateText);
            }
        });

        //change date format
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        $(document).ready(function ()
        {
            debugger
            //$("#divDateRange").hide();
            let radBtnDefault = document.getElementById("edashRadioFltr1");
            radBtnDefault.checked = true;

            var Result = AJAXCallWithResult("/api/PMDshBoard/GetCurrentDate", '', false);
            CurrentDate = Result;
            $("#daylistdatepicker").val(CurrentDate);

            Parameter =
            {
                UserID: UserId,
                LoginType: LoginType
            } 
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ProjectidAccessiable", param, false);
            for (var i = 0; i < Result.length; i++) {
                var ProjectID = Result[i]["ProjectID"];
                ProjectidAccessiable += "''" + ProjectID + "'',";
            }
            ProjectidAccessiable = ProjectidAccessiable.substring(0, ProjectidAccessiable.length - 1);

            $("#accessDrop").change(function () {
                $(this).find("option:selected").each(function () {
                    var optionValue = $(this).attr("value");
                    if (optionValue) {
                        $(".dashGridTblOuter").not("." + optionValue).hide();
                        $("." + optionValue).show();
                    } else {
                        $(".dashGridTblOuter").hide();
                    }
                });
            }).change();

            ToDoListFill();
            PendingEntries();
            IssueAgingFill();
        });

        $('table.ClsdashTbl').dataTable({
            //"ajax": '/api/data',
            "scrollY": '42vh',
            "scrollX": true,
            "scroller": true,
            "pageLength": 10,
            "paging": true,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            //"scrollable":true,
            "scrollCollapse": true
        });
        $('#IDIssueAsignmentListTbl').dataTable({
            //"ajax": '/api/data',
            //"scrollY": '50vh',
            "scrollX": true,
            "scroller": true,
            "pageLength": 5,
            "paging": true,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            //"scrollable":true,
            "scrollCollapse": true
        });
        $('#attachedDocTbl').dataTable({
            //"ajax": '/api/data',
            //"scrollY": '50vh',
            "scrollX": true,
            "scroller": true,
            "pageLength": 5,
            "paging": true,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            //"scrollable":true,
            "scrollCollapse": true
        });
        $('#attachedIssueTbl').dataTable({
            "scrollY": '40vh',
            "scrollX": true,
            "scroller": true,
            "pageLength": 5,
            "paging": true,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            "scrollCollapse": true
        });
        $('#pmdashTimesheet, #issueagingTbl').dataTable({
            //"ajax": '/api/data',
            "scrollY": '50vh',
            "scrollX": true,
            "scroller": true,
            "pageLength": 10,
            "paging": true,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,
            //"scrollable":true,
            "scrollCollapse": true,

        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        //$('#ActionTypeListTbl').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });

        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="modal"]').on('shown.bs.modal', function (e) {
            $(".table").resize();

            $($.fn.dataTable.tables(true)).DataTable()
                .scroller.measure();
        });

        $(document).on('shown.bs.modal', '#AssignIssueModal, #etcauthenticationTblModal, #documentmodal, #etcauthenticationTbl, #documentationmodal, .modal', function () {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust()
                .responsive.recalc()
                .scroller.measure();
        });  

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 365, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });

        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        function DoSort() {
            ToDoListFill();
            IssueList();
            ReviewsList();
            RiskList();
            MileStoneList();
            DeliverableList();

            //if (gSortAccess == 1) {
            //    ToDoListFill();
            //}
            //else if (gSortAccess == 2) {
            //    IssueList();
            //}
            //else if (gSortAccess == 3) {
            //    ReviewsList();
            //}
            //else if (gSortAccess == 4) {
            //    RiskList();
            //}
            //else if (gSortAccess == 5) {
            //    MileStoneList();
            //}
            //else if (gSortAccess == 6) {
            //    DeliverableList();
            //}
            //else if (gSortAccess == 7) {
            //    MyProjectList();
            //}  
        }

        function GetTodolist()
        {
            $("#ffromdate").val('');
            $("#ftodate").val('');
            if ($("#edashRadioFltr5").is(":checked") == true)
            {
                $('#TodoListGridTbl').dataTable().fnDestroy();
                $("#BodyTodoListGridTbl").html('');
                $("#divDateRange").show();
            }
            else {
                $("#divDateRange").hide();
                ToDoListFill();
            }
        }

        function DateRange() {
            if ($("#ffromdate").val() == "") { 
                alertify.error("<%= MyBase.GetResourceString("A_FromDate") %>");
                $("#ffromdate").focus();
                return;
            }
            else if ($("#ftodate").val() == "") { 
                alertify.error("<%= MyBase.GetResourceString("A_ToDate") %>");
                $("#ftodate").focus();
                return;
            }
            else {
                ToDoListFill();
            }
        }

        function ToDoListFill() {
            gSortAccess = 1;
            var isActive = $("#sortaccess").is(":checked");
            var gProjectName = '';
            var strHtml = '';
            var Parameter = '';

            $('#TodoListGridTbl').dataTable().fnDestroy();
            $("#BodyTodoListGridTbl").html('');
           
            if ($("#edashRadioFltr1").is(":checked") == true) {
                if (Showall == 0 && ProjectId != "") {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "A.ProjectID = " + ProjectId,
                        GetProjectCount: 0,
                        FromDate: "",
                        ToDate: CurrentDate
                    }
                }
                else {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "",
                        GetProjectCount: 0,
                        FromDate: "",
                        ToDate: CurrentDate
                    }
                }

            }
            else if ($("#edashRadioFltr2").is(":checked") == true) {
                var Result = AJAXCallWithResult("/api/PMDshBoard/GetPreviousWeekDate", '', false);
                Result = Result.split("~");
                var FromDate = Result[0];
                var ToDate = Result[1];
                if (Showall == 0 && ProjectId != "") {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "A.ProjectID = " + ProjectId,
                        GetProjectCount: 0,
                        FromDate: FromDate,
                        ToDate: ToDate
                    }
                }
                else {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "",
                        GetProjectCount: 0,
                        FromDate: FromDate,
                        ToDate: ToDate
                    }
                }
            }
            else if ($("#edashRadioFltr3").is(":checked") == true) {
                var Result = AJAXCallWithResult("/api/PMDshBoard/GetThisWeekDate", '', false);
                Result = Result.split("~");
                var FromDate = Result[0];
                var ToDate = Result[1];
                if (Showall == 0 && ProjectId != "") {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "A.ProjectID = " + ProjectId,
                        GetProjectCount: 0,
                        FromDate: FromDate,
                        ToDate: ToDate
                    }
                }
                else {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "",
                        GetProjectCount: 0,
                        FromDate: FromDate,
                        ToDate: ToDate
                    }
                }
            }
            else if ($("#edashRadioFltr4").is(":checked") == true) {
                var Result = AJAXCallWithResult("/api/PMDshBoard/GetNextWeekDate", '', false);
                Result = Result.split("~");
                var FromDate = Result[0];
                var ToDate = Result[1];
                if (Showall == 0 && ProjectId != "") {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "A.ProjectID = " + ProjectId,
                        GetProjectCount: 0,
                        FromDate: FromDate,
                        ToDate: ToDate
                    }
                }
                else {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "",
                        GetProjectCount: 0,
                        FromDate: FromDate,
                        ToDate: ToDate
                    }
                }
            }

            else if ($("#edashRadioFltr5").is(":checked") == true) {
                if (Showall == 0 && ProjectId != "") {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "",
                        GetProjectCount: 0,
                        FromDate: $("#ffromdate").val(),
                        ToDate: $("#ftodate").val()
                    }
                }
                else {
                    Parameter =
                    {
                        TagID: 21034,
                        UserID: UserId,
                        Querytype: 1,
                        OrderByClause: 'ORDER BY ProjectName,StartDate ASC',
                        WhereClause: "",
                        GetProjectCount: 0,
                        FromDate: $("#ffromdate").val(),
                        ToDate: $("#ftodate").val()
                    }
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ToDoListFill", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var ParentTask_UID = Result[i]["ParentTask_UID"];
                    var DocumentID = Result[i]["DocumentID"];
                    var ProjectID = Result[i]["ProjectID"];
                    var TaskId = Result[i]["TaskId"];
                    var ProjectName = Result[i]["ProjectName"];
                    var TaskName = Result[i]["TaskName"];
                    var Flag = Result[i]["Flag"];
                    var DocumentLink = Result[i]["DocumentLink"];
                    var Priority = Result[i]["Priority"];
                    var StartDate = Result[i]["StartDate"];
                    var EndDate = Result[i]["EndDate"];
                    //var Duration = Result[i]["Duration"].toFixed(2);
                    var Duration = Result[i]["Duration"];
                    //var Work = Result[i]["Work"].toFixed(2);
                    var Work = Result[i]["Work"];
                    var ActualStartDate = Result[i]["ActualStartDate"];
                    //var WorkHrs = Result[i]["ActualWork"].toFixed(2);
                    var WorkHrs = Result[i]["ActualWork"];
                    //var Variance = Result[i]["Variance"].toFixed(2);
                    var Variance = Result[i]["VarianceHHMM"];
                    var IssueFlag = Result[i]["IssueFlag"];

                    if (isActive == false) {
                        if (gProjectName == '') {
                            strHtml += '<tr class="graybg">';
                            strHtml += '<td colspan="12" class="text-start"><strong>' + ProjectName + '</strong></td>';
                            //strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '</tr>';

                            strHtml += '<tr>';
                            strHtml += '<td>&nbsp;</td>';
                            //strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + ProjectID + "," + TaskId + ")' ><i class='far fa-flag'></i></a></td>";
                            //strHtml += '<td>&nbsp;</td>';
                            if (DocumentLink == "") {
                                //Commented & Added By Dipali V On 15th May 2023 For If no document then NA should Display
                               // strHtml += '<td></td>';
                                strHtml += '<td>NA</td>';
                                 //End of Commented & Added By Dipali V On 15th May 2023 For If no document then NA should Display
                            }
                            else {
                                strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + ParentTask_UID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                            }
                            //strHtml += '<td class="text-left"><a href="javacript:;" data-bs-toggle="modal" onclick="ToDoList(' + ProjectID + ',' + TaskId + ')">' + TaskName + '</a></td>';
                            strHtml += '<td>' + TaskName + ' </td>';
                            strHtml += '<td>' + Priority + ' </td>';
                            strHtml += '<td class="text-center">' + StartDate + ' </td>';
                            strHtml += '<td class="text-center">' + EndDate + ' </td>';
                            strHtml += '<td class="text-center">' + Duration + ' </td>';
                            strHtml += '<td class="text-center">' + Work + ' </td>';
                            strHtml += '<td class="text-center">' + ActualStartDate + ' </td>';
                            strHtml += '<td class="text-center">' + WorkHrs + ' </td>';
                            strHtml += '<td class="text-center">' + Variance + ' </td>';
                            strHtml += '</tr>';
                        }
                        else if (gProjectName == ProjectName) {
                            strHtml += '<tr>';
                            strHtml += '<td>&nbsp;</td>';
                            //strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + ProjectID + "," + TaskId + ")' ><i class='far fa-flag'></i></a></td>";
                            //strHtml += '<td></td>';
                            if (DocumentLink == "") {
                                strHtml += '<td>NA</td>';
                            }
                            else {
                                strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + ParentTask_UID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                            }
                            //strHtml += '<td class="text-left"><a href="javacript:;" data-bs-toggle="modal" onclick="ToDoList(' + ProjectID + ',' + TaskId + ')">' + TaskName + '</a></td>';
                            strHtml += '<td>' + TaskName + ' </td>';
                            strHtml += '<td>' + Priority + ' </td>';
                            strHtml += '<td class="text-center">' + StartDate + ' </td>';
                            strHtml += '<td class="text-center">' + EndDate + ' </td>';
                            strHtml += '<td class="text-center">' + Duration + ' </td>';
                            strHtml += '<td class="text-center">' + Work + ' </td>';
                            strHtml += '<td class="text-center">' + ActualStartDate + ' </td>';
                            strHtml += '<td class="text-center">' + WorkHrs + ' </td>';
                            strHtml += '<td class="text-center">' + Variance + ' </td>';
                            strHtml += '</tr>';
                        }
                        else if (gProjectName != ProjectName) {
                            strHtml += '<tr class="graybg">';
                            strHtml += '<td colspan="12" class="text-start"><strong>' + ProjectName + '</strong></td>';
                            //strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '<td style="display:none;">&nbsp;</td>';
                            strHtml += '</tr>';

                            strHtml += '<tr>';
                            strHtml += '<td>&nbsp;</td>';
                            //strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + ProjectID + "," + TaskId + ")' ><i class='far fa-flag'></i></a></td>";
                            //strHtml += '<td></td>';
                            if (DocumentLink == "") {
                                strHtml += '<td>NA</td>';
                            }
                            else {
                                strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' class='documentlink' onclick='DocumentLink_OnClick(" + ProjectID + "," + ParentTask_UID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                            }
                            //strHtml += '<td class="text-left"><a href="javacript:;" data-bs-toggle="modal" onclick="ToDoList(' + ProjectID + ',' + TaskId + ')">' + TaskName + '</a></td>';
                            strHtml += '<td>' + TaskName + ' </td>';
                            strHtml += '<td>' + Priority + ' </td>';
                            strHtml += '<td class="text-center">' + StartDate + ' </td>';
                            strHtml += '<td class="text-center">' + EndDate + ' </td>';
                            strHtml += '<td class="text-center">' + Duration + ' </td>';
                            strHtml += '<td class="text-center">' + Work + ' </td>';
                            strHtml += '<td class="text-center">' + ActualStartDate + ' </td>';
                            strHtml += '<td class="text-center">' + WorkHrs + ' </td>';
                            strHtml += '<td class="text-center">' + Variance + ' </td>';
                            strHtml += '</tr>';
                        }
                        gProjectName = ProjectName;
                    }
                    else {
                        strHtml += '<tr>';
                        strHtml += '<td>' + ProjectName + '</td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        //strHtml += '<td></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + ParentTask_UID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        //strHtml += '<td class="text-left"><a href="javacript:;" data-bs-toggle="modal" onclick="ToDoList(' + ProjectID + ',' + TaskId + ')">' + TaskName + '</a></td>';
                        strHtml += '<td>' + TaskName + ' </td>';
                        strHtml += '<td class="text-center">' + Priority + ' </td>';
                        strHtml += '<td class="text-center">' + StartDate + ' </td>';
                        strHtml += '<td class="text-center">' + EndDate + ' </td>';
                        strHtml += '<td class="text-center">' + Duration + ' </td>';
                        strHtml += '<td class="text-center">' + Work + ' </td>';
                        strHtml += '<td class="text-center">' + ActualStartDate + ' </td>';
                        strHtml += '<td class="text-center">' + WorkHrs + ' </td>';
                        strHtml += '<td class="text-center">' + Variance + ' </td>';
                        strHtml += '</tr>';
                    }
                }
            }
            $("#BodyTodoListGridTbl").html(strHtml);
            $('#TodoListGridTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
                "columnDefs": [
                    { "width": "85px", "targets": 4 },
                    { "width": "85px", "targets": 5 },
                    { "width": "85px", "targets": 8 }
                ],
            });
            if (strHtml == "") {
                $("#BodyTodoListGridTbl tbody tr td").prop("colspan", 12);
            }
        }
        function ShowAllProject() {
            Showall = 1;
           
            //if (ProjectId == "") {
            //    $("#ShowSelectedProject").hide();
            //    $("#ShowAllProject").show();
            //}
            //else {
            //    $("#ShowAllProject").hide();
            //    $("#ShowSelectedProject").show();
            //}   

            $("#ShowAllProject").hide();
            $("#ShowSelectedProject").show();

            ToDoListFill();
            IssueList();
            ReviewsList();
            RiskList();
            MileStoneList();
            DeliverableList();
            ETCListFill();
        }

        function ShowSelectedProject() {
            Showall = 0;
            gSortAccess = 0;
            $("#ShowAllProject").show();
            $("#ShowSelectedProject").hide();
            ToDoListFill();
            IssueList();
            ReviewsList();
            RiskList();
            MileStoneList();
            DeliverableList();
            ETCListFill();
        }

        function IssueAgingFill() {
            var strHtml = '';
            $('#issueagingTbl').dataTable().fnDestroy();
            $("#BodyissueagingTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                UserID: UserId
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/IssueAgingFill", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var ProjectName = Result[i]["ProjectName"];
                    var Five = Result[i]["5"];
                    var Ten = Result[i]["10"];
                    var Fifteen = Result[i]["15"];

                    if (Five > 0 || Ten > 0 || Fifteen > 0) {
                        strHtml += '<tr>';
                        strHtml += '<td class="text-left">' + ProjectName + ' </td>';
                        strHtml += '<td class="text-center">' + Five + ' </td>';
                        strHtml += '<td class="text-center">' + Ten + ' </td>';
                        strHtml += '<td class="text-center">' + Fifteen + ' </td>';
                        strHtml += '</tr>';
                    }
                }
            }
            $("#BodyissueagingTbl").html(strHtml);
            $('#issueagingTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHtml == "") {
                $("#BodyissueagingTbl tbody tr td").prop("colspan", 4);
            }
        }

        function PendingEntries() {

            var strHtml = '';
            var Dates1 = '';
            var Dates = [];
            var DaysName1 = '';
            var DaysName = [];
            $("#pendingentriesdayslist").html('');
            var Parameter =
            {
                TagID: 21034,
                UserID: UserId
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillDays", param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    Dates1 = Result[i]["Dates"];
                    Dates = Dates1.split(",");
                    DaysName1 = Result[i]["DaysName"];
                    DaysName = DaysName1.split(",");
                }
            }
            for (k = 0; k < (Dates.length - 1); k++) {
                strHtml += '<a href="javascript:;" data-bs-placement="bottom" data-bs-toggle="modal" data-bs-target="#pendingentriesmodal" title="' + Dates[k] + '" onclick=TaskListByDate(' + "'" + escape(Dates[k]) + "'" + ')>' + DaysName[k] + '</a > ';
                //strHtml += "<a href='javascript:;' data-bs-placement='bottom' data-bs-toggle='modal' data-bs-target='#pendingentriesmodal' title='" + Dates[k] + "' onclick=TaskListByDate("' + Dates[k] + '")>" + DaysName[k] + "</a>"
            }
            $("#pendingentriesdayslist").html(strHtml);
        }

        function IssueList() {
            gSortAccess = 2;
            var isActive = $("#sortaccess").is(":checked");
            var gProjectName = '';
            var strHtml = '';

            $('#IssueListTbl').dataTable().fnDestroy();
            $("#BodyIssueListTbl").html('');
            if (Showall == 0 && ProjectId != "") {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 2,
                    OrderByClause: '',
                    WhereClause: "A.ProjectID = " + ProjectId,
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: ""
                }
            }
            else {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 2,
                    OrderByClause: '',
                    WhereClause: "",
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: ""
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ToDoListFill", param, false);

            for (var i = 0; i < Result.length; i++) {
                var ProjectName = Result[i]["ProjectName"];
                var Flag = Result[i]["Flag"];
                var DocumentLink = Result[i]["DocumentLink"];
                var IssueName = Result[i]["OtherTaskID"] + " -> " + Result[i]["TaskNotes"];
                var Issue_Priority = Result[i]["Issue_Priority"];
                var Issue_Status = Result[i]["Issue_Status"];
                var Task_StartDate = Result[i]["Task_StartDate"];
                var Task_EndDate = Result[i]["Task_EndDate"];
                //var Work = Result[i]["Work"].toFixed(2);
                var Work = Result[i]["Work"];
                //var ActualWork = Result[i]["ActualWork"].toFixed(2);
                var ActualWork = Result[i]["ActualWork"]; 
                var TaskId = Result[i]["ActualWork"]
                var DocumentID = Result[i]["DocumentID"];
                var ProjectID = Result[i]["ProjectID"];
                var OtherTaskID = Result[i]["OtherTaskID"];
                var IssueFlag = Result[i]["IssueFlag"];

                if (isActive == false) {
                    if (gProjectName == '') {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td>&nbsp;</td>';
                        //Added By Rehan C for Flag Colour Change Issue on 20th Feb 2023
                        if (Flag == 'Blank') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='far fa-flag''></i></a></td>";
                        }

                        else if (Flag == 'R') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag' style='color: red'></i></a></td>";
                        }
                        else if (Flag == 'G') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag' style='color: green'></i></a></td>";
                        }
                        else if (Flag == 'B') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag'></i></a></td>";  /* style = 'color: black'*/
                        }
                        else if (Flag == 'Y') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag flagorange '></i></a></td>";
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag'></i></a></td>";
                        }
                        //End of Comment By Rehan C for Flag Colour Change Issue on 20th Feb 2023
                        //strHtml += '<td class="text-center"><a href="javascript:;" class="documentlink" data-bs-toggle="modal" data-bs-target="#documentationmodal"><i class="far fa-file-alt" data-bs-toggle="tooltip" data-placement="top" data-bs-container="body" title="Documents Attached"></i></a></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentIssue_OnClick(" + ProjectID + "," + OtherTaskID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        //strHtml += '<td class="text-left"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#issueentrymodal">' + IssueName + '</a></td>';
                        strHtml += "<td class='text-left'><a href='javascript:;' data-bs-toggle='modal' onclick='IssueID_OnClick(" + ProjectID + ", " + OtherTaskID + ")'>" + IssueName + "</a></td>";
                        strHtml += '<td class="text-center">' + Issue_Priority + '</td>';
                        strHtml += '<td class="text-center">' + Issue_Status + '</td>';
                        strHtml += '<td class="text-center">' + Task_StartDate + '</td>';
                        strHtml += '<td class="text-center">' + Task_EndDate + '</td>';
                        strHtml += '<td class="text-center">' + Work + '</td>';
                        strHtml += '<td class="text-center">' + ActualWork + '</td>';
                        //strHtml += '<td><a href="javascript:;">Task Entry</a></td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName == ProjectName) {
                        strHtml += '<tr>';
                        strHtml += '<td>&nbsp;</td>';
                        //Added By Rehan C for Flag Colour Change Issue on 20th Feb 2023
                        if (Flag == 'Blank') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID +")' ><i class='far fa-flag''></i></a></td>";
                        }
                        else if (Flag == 'R') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag' style='color: red'></i></a></td>";
                        }
                        else if (Flag == 'G') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag' style='color: green'></i></a></td>";
                        }
                        else if (Flag == 'B') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag'></i></a></td>"; /*style = 'color: black'*/
                        }
                        else if (Flag == 'Y') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag flagorange '></i></a></td>";
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID +")' ><i class='fas fa-flag'></i></a></td>";
                        }
                        //End of Comment By Rehan C for Flag Colour Change Issue on 20th Feb 2023
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentIssue_OnClick(" + ProjectID + "," + OtherTaskID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        //strHtml += '<td class="text-left"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#issueentrymodal">' + IssueName + '</a></td>';
                        strHtml += "<td class='text-left'><a href='javascript:;' data-bs-toggle='modal' onclick='IssueID_OnClick(" + ProjectID + ", " + OtherTaskID + ")'>" + IssueName + "</a></td>";
                        strHtml += '<td class="text-center">' + Issue_Priority + '</td>';
                        strHtml += '<td class="text-center">' + Issue_Status + '</td>';
                        strHtml += '<td class="text-center">' + Task_StartDate + '</td>';
                        strHtml += '<td class="text-center">' + Task_EndDate + '</td>';
                        strHtml += '<td class="text-center">' + Work + '</td>';
                        strHtml += '<td class="text-center">' + ActualWork + '</td>';
                        //strHtml += '<td><a href="javascript:;">Task Entry</a></td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName != ProjectName) {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td>&nbsp;</td>';
                        //Added By Rehan C for Flag Colour Change Issue on 20th Feb 2023
                        if (Flag == 'Blank') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID +")' ><i class='far fa-flag''></i></a></td>";
                        }
                        else if (Flag == 'R') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag' style='color: red'></i></a></td>";
                        }
                        else if (Flag == 'G') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag' style='color: green'></i></a></td>";
                        }
                        else if (Flag == 'B') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag'></i></a></td>";  /* style = 'color: black'*/
                        }
                        else if (Flag == 'Y') {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID + ")' ><i class='fas fa-flag flagorange '></i></a></td>";
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID +")' ><i class='fas fa-flag'></i></a></td>";
                        }
                        //End Of Comment By Rehan C for Flag Colour Change Issue on 20th Feb 2023
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentIssue_OnClick(" + ProjectID + "," + OtherTaskID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        //strHtml += '<td class="text-left"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#issueentrymodal">' + IssueName + '</a></td>';
                        strHtml += "<td class='text-left'><a href='javascript:;' data-bs-toggle='modal' onclick='IssueID_OnClick(" + ProjectID + ", " + OtherTaskID + ")'>" + IssueName + "</a></td>";
                        strHtml += '<td class="text-center">' + Issue_Priority + '</td>';
                        strHtml += '<td class="text-center">' + Issue_Status + '</td>';
                        strHtml += '<td class="text-center">' + Task_StartDate + '</td>';
                        strHtml += '<td class="text-center">' + Task_EndDate + '</td>';
                        strHtml += '<td class="text-center">' + Work + '</td>';
                        strHtml += '<td class="text-center">' + ActualWork + '</td>';
                        //strHtml += '<td><a href="javascript:;">Task Entry</a></td>';
                        strHtml += '</tr>';
                    }
                    gProjectName = ProjectName;
                }
                else {
                    strHtml += '<tr>';
                    strHtml += '<td>' + ProjectName + '</td>';
                    strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-placement='top' data-bs-container='body' title='Tracking Details' onclick='Flag_OnClick(" + OtherTaskID + ", " + ProjectID +")' ><i class='far fa-flag'></i></a></td>";
                    if (DocumentLink == "") {
                        strHtml += '<td>NA</td>';
                    }
                    else {
                        strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentIssue_OnClick(" + ProjectID + "," + OtherTaskID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                    }
                    strHtml += "<td class='text-left'><a href='javascript:;' data-bs-toggle='modal' onclick='IssueID_OnClick(" + ProjectID + ", " + OtherTaskID + ")'>" + IssueName + "</a></td>";
                    strHtml += '<td class="text-center">' + Issue_Priority + '</td>';
                    strHtml += '<td class="text-center">' + Issue_Status + '</td>';
                    strHtml += '<td class="text-center">' + Task_StartDate + '</td>';
                    strHtml += '<td class="text-center">' + Task_EndDate + '</td>';
                    strHtml += '<td class="text-center">' + Work + '</td>';
                    strHtml += '<td class="text-center">' + ActualWork + '</td>';
                    //strHtml += '<td><a href="javascript:;">Task Entry</a></td>';
                    strHtml += '</tr>';
                }
            }
            $("#BodyIssueListTbl").html(strHtml);
            $('#IssueListTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
                "columnDefs": [
                    { "width": "85px", "targets": 6 },
                    { "width": "85px", "targets": 7 }
                ],
            });
            if (strHtml == "") {
                $("#BodyIssueListTbl tbody tr td").prop("colspan", 10);
            }
        }

        function ReviewsList() {
            gSortAccess = 3;
            var isActive = $("#sortaccess").is(":checked");
            var gIsReviewee = '';
            var strHtml = '';

            $('#ReviewListTbl').dataTable().fnDestroy();
            $("#BodyReviewListTbl").html('');

            if (Showall == 0 && ProjectId != "") {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 8,
                    OrderByClause: "",
                    WhereClause: " R.ProjectID = " + ProjectId,
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: "",
                    UserName: UserName
                }
            }
            else {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 8,
                    OrderByClause: "",
                    WhereClause: "",
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: "",
                    UserName: UserName
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ToDoListFill", param, false);

            for (var i = 0; i < Result.length; i++) {
                var IsReviewee = Result[i]["IsReviewee"];
                if (IsReviewee == null || IsReviewee == "") {
                    IsReviewee = "";
                }
                var ProjectName = Result[i]["ProjectName"];
                var ReviewType = Result[i]["ReviewType"];
                var Flag = Result[i]["Flag"];
                var DocumentLink = Result[i]["DocumentLink"];
                var ReviewedDate = Result[i]["ReviewedDate1"];
                var ReviewedBy = Result[i]["ReviewedBy"].replace(/,/g, ", ");
                var Reviewee = Result[i]["Reviewee"];
                //var ReviewEffortHrs = Result[i]["ReviewEffort"].toFixed(2);
                var ReviewEffortHrs = Result[i]["ReviewEffortHHMM"];
                var ReviewStatus = Result[i]["ReviewStatus"];
                var ProjectID = Result[i]["ProjectId"];
                var ReviewStatisticsID = Result[i]["ReviewStatisticsID"];
                var TaskId = "2191";

                if (isActive == false) {
                    if (gIsReviewee == '') {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + IsReviewee + '</strong></td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + ReviewStatisticsID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        strHtml += '<td>' + ProjectName + '</td>';
                        strHtml += '<td>' + ReviewType + '</td>';
                        strHtml += '<td class="text-center">' + ReviewedDate + '</td>';
                        strHtml += '<td>' + ReviewedBy + '</td>';
                        strHtml += '<td class="text-center">' + Reviewee + '</td>';
                        strHtml += '<td class="text-center">' + ReviewEffortHrs + '</td>';
                        strHtml += '<td class="text-center">' + ReviewStatus + '</td>';
                        strHtml += '</tr>';
                    }
                    else if (gIsReviewee == IsReviewee) {
                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + ReviewStatisticsID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        strHtml += '<td>' + ProjectName + '</td>';
                        strHtml += '<td>' + ReviewType + '</td>';
                        strHtml += '<td class="text-center">' + ReviewedDate + '</td>';
                        strHtml += '<td>' + ReviewedBy + '</td>';
                        strHtml += '<td class="text-center">' + Reviewee + '</td>';
                        strHtml += '<td class="text-center">' + ReviewEffortHrs + '</td>';
                        strHtml += '<td class="text-center">' + ReviewStatus + '</td>';
                        strHtml += '</tr>';
                    }
                    else if (gIsReviewee != IsReviewee) {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + IsReviewee + '</strong></td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + ReviewStatisticsID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        strHtml += '<td>' + ProjectName + '</td>';
                        strHtml += '<td>' + ReviewType + '</td>';
                        strHtml += '<td class="text-center">' + ReviewedDate + '</td>';
                        strHtml += '<td>' + ReviewedBy + '</td>';
                        strHtml += '<td class="text-center">' + Reviewee + '</td>';
                        strHtml += '<td class="text-center">' + ReviewEffortHrs + '</td>';
                        strHtml += '<td class="text-center">' + ReviewStatus + '</td>';
                        strHtml += '</tr>';
                    }
                    gIsReviewee = IsReviewee;
                }
                else {
                    strHtml += '<tr>';
                    strHtml += '<td>' + IsReviewee + '</td>';
                    //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                    if (DocumentLink == "") {
                        strHtml += '<td>NA</td>';
                    }
                    else {
                        strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + ReviewStatisticsID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                    }
                    strHtml += '<td>' + ProjectName + '</td>';
                    strHtml += '<td>' + ReviewType + '</td>';
                    strHtml += '<td class="text-center">' + ReviewedDate + '</td>';
                    strHtml += '<td>' + ReviewedBy + '</td>';
                    strHtml += '<td class="text-center">' + Reviewee + '</td>';
                    strHtml += '<td class="text-center">' + ReviewEffortHrs + '</td>';
                    strHtml += '<td class="text-center">' + ReviewStatus + '</td>';
                    strHtml += '</tr>';
                }
            }
            $("#BodyReviewListTbl").html(strHtml);
            $('#ReviewListTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
                "columnDefs": [
                    { "width": "85px", "targets": 4 }
                ],
            });
            if (strHtml == "") {
                $("#BodyIssueListTbl tbody tr td").prop("colspan", 11);
            }
            $("table").resize(); // Added by pradip on 11-5-2023
        }

        function RiskList() {
            gSortAccess = 4;
            var isActive = $("#sortaccess").is(":checked");
            var gProjectName = '';
            var strHtml = '';

            $('#RiskListTbl').dataTable().fnDestroy();
            $("#BodyIDRisklistTbl").html('');

            if (Showall == 0 && ProjectId != "") {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 7,
                    OrderByClause: " ORDER BY R.Risk_Description ASC ",
                    WhereClause: "R.ProjectID = " + ProjectId,
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: "",
                    UserName: UserName
                }
            }
            else {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 7,
                    OrderByClause: " ORDER BY R.Risk_Description ASC ",
                    WhereClause: "",
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: "",
                    UserName: UserName
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ToDoListFill", param, false);

            for (var i = 0; i < Result.length; i++) {
                var RiskId = Result[i]["RiskId"];
                var ProjectName = Result[i]["ProjectName"];
                var Flag = Result[i]["Flag"];
                var DocumentLink = Result[i]["DocumentLink"];
                var Risk_Description = Result[i]["Risk_Description"];
                var Date = Result[i]["DateIdentified"];
                var Probability = Result[i]["Probability"];
                var Severity = Result[i]["Severity"];
                var Status = Result[i]["Status"];
                var PersonResponsible = Result[i]["PersonResponsible"];


                if (isActive == false) {
                    if (gProjectName == '') {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="8" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td>' + RiskId + '</td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        strHtml += '<td class="text-left">' + Risk_Description + '</td>';
                        strHtml += '<td class="text-center">' + Date + '</td>';
                        strHtml += '<td class="text-center">' + Probability + '</td>';
                        strHtml += '<td class="text-center">' + Severity + '</td>';
                        strHtml += '<td class="text-center">' + Status + '</td>';
                        strHtml += '<td class="text-left">' + PersonResponsible + '</td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName == ProjectName) {
                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td>' + RiskId + '</td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        strHtml += '<td class="text-left">' + Risk_Description + '</td>';
                        strHtml += '<td class="text-center">' + Date + '</td>';
                        strHtml += '<td class="text-center">' + Probability + '</td>';
                        strHtml += '<td class="text-center">' + Severity + '</td>';
                        strHtml += '<td class="text-center">' + Status + '</td>';
                        strHtml += '<td class="text-left">' + PersonResponsible + '</td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName != ProjectName) {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="8" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td>' + RiskId + '</td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        strHtml += '<td class="text-left">' + Risk_Description + '</td>';
                        strHtml += '<td class="text-center">' + Date + '</td>';
                        strHtml += '<td class="text-center">' + Probability + '</td>';
                        strHtml += '<td class="text-center">' + Severity + '</td>';
                        strHtml += '<td class="text-center">' + Status + '</td>';
                        strHtml += '<td class="text-left">' + PersonResponsible + '</td>';
                        strHtml += '</tr>';
                    }
                    gProjectName = ProjectName;
                }
                else {
                    strHtml += '<tr>';
                    strHtml += '<td>' + ProjectName + '</td>';
                    //strHtml += '<td>' + RiskId + '</td>';
                    //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                    strHtml += '<td class="text-left">' + Risk_Description + '</td>';
                    strHtml += '<td class="text-center">' + Date + '</td>';
                    strHtml += '<td class="text-center">' + Probability + '</td>';
                    strHtml += '<td class="text-center">' + Severity + '</td>';
                    strHtml += '<td class="text-center">' + Status + '</td>';
                    strHtml += '<td class="text-left">' + PersonResponsible + '</td>';
                    strHtml += '</tr>';
                }
            }
            $("#BodyIDRisklistTbl").html(strHtml);
            $('#RiskListTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHtml == "") {
                $("#BodyIDRisklistTbl tbody tr td").prop("colspan", 8);
            }
        }

        function MileStoneList() {
            gSortAccess = 5;
            var isActive = $("#sortaccess").is(":checked");
            var gProjectName = '';
            var strHtml = '';

            $('#milestoneListTbl').dataTable().fnDestroy();
            $("#BodymilestoneListTbl").html('');

            if (Showall == 0 && ProjectId != "") {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 6,
                    OrderByClause: " ORDER BY Milestone ASC ",
                    WhereClause: "M.ProjectID = " + ProjectId,
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: "",
                    UserName: UserName
                }
            }
            else {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 6,
                    OrderByClause: " ORDER BY Milestone ASC ",
                    WhereClause: "",
                    GetProjectCount: 0,
                    FromDate: "",
                    ToDate: "",
                    UserName: UserName
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ToDoListFill", param, false);

            for (var i = 0; i < Result.length; i++) {
                var ProjectName = Result[i]["ProjectName"];
                var Flag = Result[i]["Flag"];
                var DocumentLink = Result[i]["DocumentLink"];
                var MileStone = Result[i]["MileStone"];
                var PlannedCompletionDate = Result[i]["PlannedCompletionDate"];
                var ActualCompletionDate = Result[i]["ActualCompletionDate"];
                var AnalysisStatus = Result[i]["AnalysisStatus"];
                var MilestoneStatus = Result[i]["MilestoneStatus"];
                var PersonResponsible = Result[i]["PersonResponsible"];
                var MileStoneID = Result[i]["MileStoneID"];
                var ProjectID = Result[i]["ProjectID"];
                var TaskId = "34";

                if (isActive == false) {
                    if (gProjectName == '') {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        strHtml += '<td class="text-center">' + MileStoneID + '</td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + MileStoneID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        strHtml += '<td class="text-left">' + MileStone + '</td>';
                        strHtml += '<td class="text-center">' + PlannedCompletionDate + '</td>';
                        strHtml += '<td class="text-center">' + ActualCompletionDate + '</td>';
                        strHtml += '<td>' + AnalysisStatus + '</td>';
                        strHtml += '<td class="text-left">' + MilestoneStatus + '</td>';
                        strHtml += '<td class="text-center"><a href="javascript:;" onclick="MilestoneReport_OnClick(' + ProjectID + ', ' + MileStoneID +')">Show Report</a></td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName == ProjectName) {
                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        strHtml += '<td class="text-center">' + MileStoneID + '</td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + MileStoneID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        strHtml += '<td class="text-left">' + MileStone + '</td>';
                        strHtml += '<td class="text-center">' + PlannedCompletionDate + '</td>';
                        strHtml += '<td class="text-center">' + ActualCompletionDate + '</td>';
                        strHtml += '<td>' + AnalysisStatus + '</td>';
                        strHtml += '<td class="text-left">' + MilestoneStatus + '</td>';
                        strHtml += '<td class="text-center"><a href="javascript:;" onclick="MilestoneReport_OnClick(' + ProjectID + ', ' + MileStoneID +')">Show Report</a></td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName != ProjectName) {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        strHtml += '<td class="text-center">' + MileStoneID + '</td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        if (DocumentLink == "") {
                            strHtml += '<td>NA</td>';
                        }
                        else {
                            strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + MileStoneID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        }
                        strHtml += '<td class="text-left">' + MileStone + '</td>';
                        strHtml += '<td class="text-center">' + PlannedCompletionDate + '</td>';
                        strHtml += '<td class="text-center">' + ActualCompletionDate + '</td>';
                        strHtml += '<td>' + AnalysisStatus + '</td>';
                        strHtml += '<td class="text-left">' + MilestoneStatus + '</td>';
                        strHtml += '<td class="text-center"><a href="javascript:;" onclick="MilestoneReport_OnClick(' + ProjectID + ', ' + MileStoneID +')">Show Report</a></td>';
                        strHtml += '</tr>';
                    }
                    gProjectName = ProjectName;
                }
                else {
                    strHtml += '<tr>';
                    strHtml += '<td>' + ProjectName + '</td>';
                    strHtml += '<td class="text-center">' + MileStoneID + '</td>';
                    //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                    if (DocumentLink == "") {
                        strHtml += '<td>NA</td>';
                    }
                    else {
                        strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLink_OnClick(" + ProjectID + "," + MileStoneID + "," + TaskId + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                    }
                    strHtml += '<td class="text-left">' + MileStone + '</td>';
                    strHtml += '<td class="text-center">' + PlannedCompletionDate + '</td>';
                    strHtml += '<td class="text-center">' + ActualCompletionDate + '</td>';
                    strHtml += '<td>' + AnalysisStatus + '</td>';
                    strHtml += '<td class="text-left">' + MilestoneStatus + '</td>';
                    strHtml += '<td class="text-center"><a href="javascript:;" onclick="MilestoneReport_OnClick(' + ProjectID + ', ' + MileStoneID +')">Show Report</a></td>';
                    strHtml += '</tr>';
                }
            }
            $("#BodymilestoneListTbl").html(strHtml);
            $('#milestoneListTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
                "columnDefs": [
                    { "width": "85px", "targets": 4 },
                    { "width": "85px", "targets": 5 }
                ],
            });
            if (strHtml == "") {
                $("#BodymilestoneListTbl tbody tr td").prop("colspan", 10);
            }
        }

        function DeliverableList() {
            gSortAccess = 6;
            var isActive = $("#sortaccess").is(":checked");
            var gProjectName = '';
            var strHtml = '';

            $('#DlvrableListTbl').dataTable().fnDestroy();
            $("#BodyDlvrableListTbl").html('');

            if (Showall == 0 && ProjectId != "") {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    OrderByClause: "ORDER BY ProjectID ASC",
                    WhereClause: "tbl_PM_Project.ProjectID = " + ProjectId
                }
            }
            else {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    OrderByClause: "ORDER BY ProjectName ASC"
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillDeliverable", param, false); 
            for (var i = 0; i < Result.length; i++) {
                var ProjectName = Result[i]["ProjectName"];
                var Flag = Result[i]["Flag"];
                var DocumentLink = Result[i]["DocumentLink"];
                var Title = Result[i]["Title"];
                var StartDate = Result[i]["StartDate"];
                var EarliestStartDate = Result[i]["EarliestStartDate"];
                var PlannedEffort = Result[i]["DeliverableLCE"];
                var ActualEffort = Result[i]["ActualEffort"];
                var DocumentNo = Result[i]["DocumentNo"];
                var ScheduleID = Result[i]["ScheduleID"];

                if (isActive == false) {
                    if (gProjectName == '') {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        //if (DocumentLink == "") {
                        //    strHtml += '<td></td>';
                        //}
                        //else {
                        //    strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLinkDeliverable_OnClick(" + ScheduleID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        //}
                        strHtml += '<td class="text-center">' + DocumentNo + '</td>';
                        strHtml += '<td>' + Title + '</td>';
                        strHtml += '<td class="text-center">' + StartDate + '</td>';
                        strHtml += '<td class="text-center">' + EarliestStartDate + '</td>';
                        strHtml += '<td class="text-center">' + PlannedEffort + '</td>';
                        strHtml += '<td class="text-center">' + ActualEffort + '</td>';
                        strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" onclick="DisplayDeliverableReport(' + ScheduleID + ')">Show Report</a></td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName == ProjectName) {
                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        //if (DocumentLink == "") {
                        //    strHtml += '<td></td>';
                        //}
                        //else {
                        //    strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLinkDeliverable_OnClick(" + ScheduleID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        //}
                        strHtml += '<td class="text-center">' + DocumentNo + '</td>';
                        strHtml += '<td>' + Title + '</td>';
                        strHtml += '<td class="text-center">' + StartDate + '</td>';
                        strHtml += '<td class="text-center">' + EarliestStartDate + '</td>';
                        strHtml += '<td class="text-center">' + PlannedEffort + '</td>';
                        strHtml += '<td class="text-center">' + ActualEffort + '</td>';
                        strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" onclick="DisplayDeliverableReport(' + ScheduleID + ')">Show Report</a></td>';
                        strHtml += '</tr>';
                    }
                    else if (gProjectName != ProjectName) {
                        strHtml += '<tr class="graybg">';
                        strHtml += '<td colspan="10" class="text-start"><strong>' + ProjectName + '</strong></td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        //strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '<td style="display:none;">&nbsp;</td>';
                        strHtml += '</tr>';

                        strHtml += '<tr>';
                        strHtml += '<td></td>';
                        //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                        //if (DocumentLink == "") {
                        //    strHtml += '<td></td>';
                        //}
                        //else {
                        //    strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLinkDeliverable_OnClick(" + ScheduleID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                        //}
                        strHtml += '<td class="text-center">' + DocumentNo + '</td>';
                        strHtml += '<td>' + Title + '</td>';
                        strHtml += '<td class="text-center">' + StartDate + '</td>';
                        strHtml += '<td class="text-center">' + EarliestStartDate + '</td>';
                        strHtml += '<td class="text-center">' + PlannedEffort + '</td>';
                        strHtml += '<td class="text-center">' + ActualEffort + '</td>';
                        strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" onclick="DisplayDeliverableReport(' + ScheduleID + ')">Show Report</a></td>';
                        strHtml += '</tr>';
                    }
                    gProjectName = ProjectName;
                }
                else {
                    strHtml += '<tr>';
                    strHtml += '<td>' + ProjectName + '</td>';
                    //strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#flagmodal" data-placement="top" data-bs-container="body" title="Tracking Details"><i class="far fa-flag"></i></a></td>';
                    //if (DocumentLink == "") {
                    //    strHtml += '<td></td>';
                    //}
                    //else {
                    //    strHtml += "<td class='text-center'><a href='javascript:;' class='documentlink' data-bs-toggle='modal' onclick='DocumentLinkDeliverable_OnClick(" + ScheduleID + ")'><i class='far fa-file-alt' data-bs-toggle='tooltip' data-placement='top' data-bs-container='body' title='Documents Attached'></i></a></td>";
                    //}
                    strHtml += '<td class="text-center">' + DocumentNo + '</td>';
                    strHtml += '<td>' + Title + '</td>';
                    strHtml += '<td class="text-center">' + StartDate + '</td>';
                    strHtml += '<td class="text-center">' + EarliestStartDate + '</td>';
                    strHtml += '<td class="text-center">' + PlannedEffort + '</td>';
                    strHtml += '<td class="text-center">' + ActualEffort + '</td>';
                    strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal"  onclick="DisplayDeliverableReport(' + ScheduleID + ')">Show Report</a></td>';
                    strHtml += '</tr>';
                }
            }
            $("#BodyDlvrableListTbl").html(strHtml);
            $('#DlvrableListTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHtml == "") {
                $("#BodyDlvrableListTbl tbody tr td").prop("colspan", 10);
            }
        }

        function ETCListFill() {
            var strHtml = '';
            $('#ETCrequestsListTbl').dataTable().fnDestroy();
            $("#BodyETCrequestsListTbl").html('');

            if (Showall == 0 && ProjectId != "") {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 5,
                    OrderByClause: "ORDER BY ProjectName ASC",
                    WhereClause: "E.ProjectID = " + ProjectId
                }
            }
            else {
                var Parameter =
                {
                    TagID: 21034,
                    UserID: UserId,
                    Querytype: 5,
                    OrderByClause: "ORDER BY ProjectName ASC"
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ToDoListFill", param, false);

            for (var i = 0; i < Result.length; i++) {
                var ProjectID = Result[i]["ProjectID"];
                var ProjectNAme = Result[i]["ProjectNAme"];
                var TotalTasks = Result[i]["TotalTasks"];
                var TotalHours = Result[i]["TotalHours"];

                strHtml += '<tr>';
                //strHtml += '<td>' + ProjectNAme + '</td>';
                strHtml += "<td class='text-center'><a href='javascript:;' data-bs-toggle='modal' data-bs-target='#etcauthenticationTblModal' class='documentlink' onclick='ETC(" + ProjectID + ")'>" + ProjectNAme + "</a></td>";
                strHtml += '<td class="text-center">' + TotalTasks + '</td>';
                strHtml += '<td class="text-center">' + TotalHours + '</td>';
                strHtml += '</tr>';
            }
            $("#BodyETCrequestsListTbl").html(strHtml);
            $('#ETCrequestsListTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHtml == "") {
                $("#BodyETCrequestsListTbl tbody tr td").prop("colspan", 3);
            }
        }

        var gETCProjectID
        function ETC(ProjectID)
        {
            gETCProjectID = ProjectID;
            var strHtml = '';
            $('#etcauthTbl').dataTable().fnDestroy();
            $("#BodyetcauthTbl").html('');

            //total Count show on both tab
            var Parameter =
            {
                ETCID: gETCProjectID,
                Flagg: 'M'
            }            
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillETCAuthentication", param, false);
            $("#txtMPPTasksETCRequestsCount").text(Result.length);

            var Parameter =
            {
                ETCID: gETCProjectID,
                Flagg: 'O'
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillETCAuthentication", param, false);
            $("#txtAssignedTasksETCRequestsCount").text(Result.length);
            //end of count showing

            if ($("#authRadioFltr1").is(":checked") == true) {
                var Parameter =
                {
                    ETCID: gETCProjectID,
                    Flagg: 'M'
                }
            }
            else {
                var Parameter =
                {
                    ETCID: gETCProjectID,
                    Flagg: 'O'
                }
            }           
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillETCAuthentication", param, false);

            //if ($("#authRadioFltr1").is(":checked") == true) {
            //    $("#txtMPPTasksETCRequestsCount").text(Result.length);
            //    $("#txtAssignedTasksETCRequestsCount").text(0);
            //}
            //else {
            //    $("#txtMPPTasksETCRequestsCount").text(0);
            //    $("#txtAssignedTasksETCRequestsCount").text(Result.length);
            //}
            for (var i = 0; i < Result.length; i++) {
                var ETCID = Result[i]["ETCID"];
                var TaskName = Result[i]["TaskName"];
                var StartDate = Result[i]["StartDate"];
                var EndDate = Result[i]["EndDate"];
                var UserName = Result[i]["UserName"];
                var BudgetedWork = Result[i]["BudgetedWork"];
                var ActualWork = Result[i]["ActualWork"];
                var ETC_Value = Result[i]["ETC_Value"];
                var BilledWork = Result[i]["BilledWork"];

                strHtml += '<tr>';
                strHtml += '<td class="text-Left">' + TaskName + '</td>';
                strHtml += '<td class="text-center">' + StartDate + '</td>';
                strHtml += '<td class="text-center">' + EndDate + '</td>';
                strHtml += '<td class="text-Left">' + UserName + '</td>';
                strHtml += '<td class="text-center">' + BudgetedWork + '</td>';
                strHtml += '<td class="text-center">' + ActualWork + '</td>';
                strHtml += '<td class="text-center">' + BilledWork + '</td>';
                strHtml += '<td class="text-center">' + ETC_Value + '</td>';
                strHtml += '<td class="text-center"><div class="custom_chckbox"> <input id="ETCAuth' + ETCID + '" class="checkETCauth" name="checkETCauth" type="checkbox" value="' + ETCID + '" onclick="CheckboxETCauth(' + ETCID + ')"> <label for="ETCAuth' + ETCID +'"></label> </div> </td>';
                strHtml += '<td class="text-center"><div class="custom_chckbox"> <input id="DelETCAuth' + ETCID + '" class="checkETCdel" name="checkETCdel" type="checkbox" value="' + ETCID + '" onclick="CheckboxETCdel(' + ETCID + ')"> <label for="DelETCAuth' + ETCID +'"></label> </div> </td>';
                strHtml += '</tr>';
            }
            $("#BodyetcauthTbl").html(strHtml);
            $('#etcauthTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            }); 
            if (strHtml == "") {
                $("#BodyetcauthTbl tbody tr td").prop("colspan", 10);
            } 
            $("#etcauthenticationTblModal").modal("show");
        }

        function ETCAuth() { 
            var strProjectStatus = '';
            var Parameter =
            {
                ETCID: gETCProjectID 
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillETCProjectStatus", param, false);
            for (var i = 0; i < Result.length; i++) {
                strProjectStatus = Result[i]["Flag"];
            }

            var table = $('#etcauthTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var MasterIDs = $('input[name=checkETCauth]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrMasterIDs = MasterIDs.split(',');
            
            if (strProjectStatus == 1) { 
                alertify.error("<%= MyBase.GetResourceString("A_ETC") %>");
                return;
            }
            else if (MasterIDs =="")
            { 
                alertify.error("<%= MyBase.GetResourceString("A_Selectatleastonerecord") %>");
                return;
            }
            else
            {
                for (i = 0; i < arrMasterIDs.length; i++) 
                {
                    var Parameter =
                    {
                        ETCID: arrMasterIDs[i]
                    }
                    var param = JSON.stringify(Parameter);
                    var Result = AJAXCallWithResult("/api/PMDshBoard/ETCAuthSave", param, false);                                     
                }
                ETCListFill();
                ETC(gETCProjectID); 
                alertify.success("<%= MyBase.GetResourceString("A_ETC_Approved") %>");
            }
        }

        function ETCAuthDelete() {
            var strProjectStatus = '';
            var Parameter =
            {
                ETCID: gETCProjectID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillETCProjectStatus", param, false);
            for (var i = 0; i < Result.length; i++) {
                strProjectStatus = Result[i]["Flag"];
            }

            var table = $('#etcauthTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var MasterIDs = $('input[name=checkETCdel]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrMasterIDs = MasterIDs.split(',');

            if (strProjectStatus == 1) { 
                alertify.error("<%= MyBase.GetResourceString("A_ETC") %>");
                return;
            }
            else if (MasterIDs == "") { 
                alertify.error("<%= MyBase.GetResourceString("A_Selectatleastonerecord") %>");
                return;
            }
            else {
                for (i = 0; i < arrMasterIDs.length; i++) {
                    var Parameter =
                    {
                        ETCID: arrMasterIDs[i]
                    }
                    var param = JSON.stringify(Parameter); 
                    var Result = AJAXCallWithResult("/api/PMDshBoard/ETCAuthDelete", param, false);
                }
                ETCListFill();
                ETC(gETCProjectID); 
                alertify.success("<%= MyBase.GetResourceString("A_ETC_Delete") %>");
            }
        }

        function MPPTasksETCRequests() {
            ETC(gETCProjectID);
        }
        function AssignedTasksETCRequests() {
            ETC(gETCProjectID);
        }

        function MyProjectList() {
            gSortAccess = 7;
            //var isActive = $("#sortaccess").is(":checked"); 
            var gProjectName = '';
            var strHtml = '';

            $('#myProjectListTbl').dataTable().fnDestroy();
            $("#BodymyProjectListTbl").html('');

            var Parameter =
            {
                TagID: 21034,
                UserID: UserId,
                OrderByClause: "ORDER BY ProjectName ASC",
                Flag: 0
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillMyProject", param, false);

            for (var i = 0; i < Result.length; i++) {
                var ProjectId = Result[i]["ProjectId"];
                var ProjectName = Result[i]["ProjectName"];
                var ExpectedStartDate = Result[i]["ExpectedStartDate"];
                var ExpectedEndDate = Result[i]["ExpectedEndDate"];
                var DurrationINDay = Result[i]["ExpectedDuration"];
                var EstimatedEfforts = Result[i]["EstimatedEfforts"];
                var ActualEfforts = Result[i]["ActualEfforts"];

                //if (isActive == false) {
                //    if (gProjectName == '') {
                //        strHtml += '<tr class="graybg">';
                //        strHtml += '<td colspan="7" class="text-start"><strong>' + ProjectName + '</strong></td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>'; 
                //        strHtml += '</tr>';

                //        strHtml += '<tr>';
                //        strHtml += '<td></td>';
                //        strHtml += '<td>' + ExpectedStartDate + '</td>';
                //        strHtml += '<td>' + ExpectedEndDate + '</td>';
                //        strHtml += '<td>' + DurrationINDay + '</td>';
                //        strHtml += '<td>' + EstimatedEfforts + '</td>';
                //        strHtml += '<td>' + ActualEfforts + '</td>'; 
                //        strHtml += '<td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ShowReportModal">Show Report</a></td>';
                //        strHtml += '</tr>';
                //    }
                //    else if (gProjectName == ProjectName) {
                //        strHtml += '<tr>';
                //        strHtml += '<td></td>';
                //        strHtml += '<td>' + ExpectedStartDate + '</td>';
                //        strHtml += '<td>' + ExpectedEndDate + '</td>';
                //        strHtml += '<td>' + DurrationINDay + '</td>';
                //        strHtml += '<td>' + EstimatedEfforts + '</td>';
                //        strHtml += '<td>' + ActualEfforts + '</td>';
                //        strHtml += '<td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ShowReportModal">Show Report</a></td>';
                //        strHtml += '</tr>';
                //    }
                //    else if (gProjectName != ProjectName) {
                //        strHtml += '<tr class="graybg">';
                //        strHtml += '<td colspan="7" class="text-start"><strong>' + ProjectName + '</strong></td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '<td style="display:none;">&nbsp;</td>';
                //        strHtml += '</tr>';

                //        strHtml += '<tr>';
                //        strHtml += '<td></td>';
                //        strHtml += '<td>' + ExpectedStartDate + '</td>';
                //        strHtml += '<td>' + ExpectedEndDate + '</td>';
                //        strHtml += '<td>' + DurrationINDay + '</td>';
                //        strHtml += '<td>' + EstimatedEfforts + '</td>';
                //        strHtml += '<td>' + ActualEfforts + '</td>';
                //        strHtml += '<td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ShowReportModal">Show Report</a></td>';
                //        strHtml += '</tr>';
                //    }
                //    gProjectName = ProjectName;
                //}
                //else {
                strHtml += '<tr>';
                strHtml += '<td>' + ProjectName + '</td>';
                strHtml += '<td class="text-center">' + ExpectedStartDate + '</td>';
                strHtml += '<td class="text-center">' + ExpectedEndDate + '</td>';
                strHtml += '<td class="text-center">' + DurrationINDay + '</td>';
                strHtml += '<td class="text-center">' + EstimatedEfforts + '</td>';
                strHtml += '<td class="text-center">' + ActualEfforts + '</td>';
                strHtml += '<td class="text-center"><a href="javascript:;" data-bs-toggle="modal" onclick="ShowProjectInfo(' + ProjectId +')">Show Report</a></td>';
                strHtml += '</tr>';
                //}
            }
            $("#BodymyProjectListTbl").html(strHtml);
            $('#myProjectListTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHtml == "") {
                $("#BodymyProjectListTbl tbody tr td").prop("colspan", 7);
            }
        }

        //Start Pending Entries
        function TaskListByDate(date) {
            if (date == null || date == "") {
                var Parameter =
                {
                    FromDate: $("#daylistdatepicker").val(),
                    Flag: 2//Current Date Day
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/PMDshBoard/GetDate", param, false);
                Result = Result.split("~");
                $("#DayName").text(Result[1]);
            }
            else {
                var k = unescape(date);
                $("#daylistdatepicker").val(k);

                var Parameter =
                {
                    FromDate: $("#daylistdatepicker").val(),
                    Flag: 2//Current Date Day
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/PMDshBoard/GetDate", param, false);
                Result = Result.split("~");
                $("#DayName").text(Result[1]);
            }
            var strHtml = '';
            var gProjectName = '';
            $('#pmdashTimesheetTbl').dataTable().fnDestroy();
            $("#BodypmdashTimesheetTbl").html('');
            var Parameter =
            {
                TagID: 21034,
                UserID: UserId,
                FromDate: $("#daylistdatepicker").val(),
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillPendingEntries", param, false);
            for (var i = 0; i < Result.length; i++) {
                var ProjectName = Result[i]["ProjectName"];
                var TaskName = Result[i]["TaskName"];
                var Description = Result[i]["Description"];
                //var Duration = Result[i]["Duration"].toFixed(2);
                var Duration = Result[i]["DurationHHMM"];
                var DATypeList = Result[i]["DATypeList"];
                var DailyActivityEntryID = Result[i]["DailyActivityEntryID"];
                var TaskOnHold = Result[i]["TaskOnHold"];
                var Void = Result[i]["Void"];
                var IsActive = Result[i]["IsActive"];
                var Status = Result[i]["Status"];

                if (gProjectName == '')
                {
                     
                    strHtml += '<tr class="graybg">';                    
                    strHtml += '<td> <a data-bs-toggle="tooltip" data-placement="top" data-bs-container="body" title="Project Name">' + ProjectName + '</a></td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '</tr>';

                    if (TaskOnHold > 0 || Void > 0)
                    {
                        if (IsActive == 1) {
                            strHtml += '<tr class="voidrow">';
                        }
                        else {
                            strHtml += '<tr>';
                        }
                    }
                    else {
                        if (IsActive == 0) {
                            strHtml += '<tr class="voidrow">';
                        }
                        else {
                            strHtml += '<tr>';
                        }
                    }
                    //strHtml += '<td>' + TaskName + '</td>';
                    strHtml += '<td> <a data-bs-toggle="tooltip" data-placement="top" data-bs-container="body" title="Task Name">' + TaskName + '</a></td>';
                    strHtml += '<td class="text-center">' + Duration + '</td>';
                    strHtml += '<td class="text-center">' + Description + '</td>';
                    strHtml += '<td class="text-center">' + DATypeList + '</td>';
                    strHtml += '<td>';
                    strHtml += '<div class="custom_chckbox">';
                    strHtml += '<center><input type="checkbox" id="pmdashtimesheetDel' + DailyActivityEntryID + ' " class="chcktbl" name="checkPendingTaskEntries" value="' + DailyActivityEntryID + '">';
                    strHtml += '<label for="pmdashtimesheetDel' + DailyActivityEntryID + ' " ></label></center>';
                    strHtml += '</div>';
                    strHtml += '</td>';
                    strHtml += '</tr>';
                }
                else if (gProjectName == ProjectName) {
                    if (TaskOnHold > 0 || Void > 0) {
                        strHtml += '<tr class="graybg">';
                    }
                    else {
                        strHtml += '<tr class="">';
                    }
                    //strHtml += '<td>' + TaskName + '</td>';
                    strHtml += '<td> <a data-bs-toggle="tooltip" data-placement="top" data-bs-container="body" title="Task Name">' + TaskName + '</a></td>';
                    strHtml += '<td class="text-center">' + Duration + '</td>';
                    strHtml += '<td class="text-center">' + Description + '</td>';
                    strHtml += '<td class="text-center">' + DATypeList + '</td>';
                    strHtml += '<td>';
                    strHtml += '<div class="custom_chckbox">';
                    strHtml += '<center><input type="checkbox" id="pmdashtimesheetDel' + DailyActivityEntryID + ' " class="chcktbl" name="checkPendingTaskEntries" value="' + DailyActivityEntryID + '">';
                    strHtml += '<label for="pmdashtimesheetDel' + DailyActivityEntryID + ' " ></label> </center>';
                    strHtml += '</div>';
                    strHtml += '</td>';
                    strHtml += '</tr>';
                }
                else if (gProjectName != ProjectName) {
                   
                    strHtml += '<tr class="graybg">';                    
                    strHtml += '<td> <a data-bs-toggle="tooltip" data-placement="top" data-bs-container="body" title="Project Name">' + ProjectName + '</a></td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '<td>&nbsp;</td>';
                    strHtml += '</tr>';

                    if (TaskOnHold > 0 || Void > 0) {
                        if (IsActive == 1) {
                            strHtml += '<tr class="voidrow">';
                        }
                        else {
                            strHtml += '<tr>';
                        }
                    }
                    else {
                        if (IsActive == 0) {
                            strHtml += '<tr class="voidrow">';
                        }
                        else {
                            strHtml += '<tr>';
                        }
                    }
                    //strHtml += '<td>' + TaskName + '</td>';
                    strHtml += '<td> <a data-bs-toggle="tooltip" data-placement="top" data-bs-container="body" title="Task Name">' + TaskName + '</a></td>';
                    strHtml += '<td class="text-center">' + Duration + '</td>';
                    strHtml += '<td class="text-center">' + Description + '</td>';
                    strHtml += '<td class="text-center">' + DATypeList + '</td>';
                    strHtml += '<td>';
                    strHtml += '<div class="custom_chckbox">';
                    strHtml += '<center><input type="checkbox" id="pmdashtimesheetDel' + DailyActivityEntryID + ' " class="chcktbl" name="checkPendingTaskEntries" value="' + DailyActivityEntryID + '">';
                    strHtml += '<label for="pmdashtimesheetDel' + DailyActivityEntryID + ' " ></label></center>';
                    strHtml += '</div>';
                    strHtml += '</td>';
                    strHtml += '</tr>';
                }
                gProjectName = ProjectName;
            }
            $("#BodypmdashTimesheetTbl").html(strHtml);
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

            //Total HHMM
            var Parameter =
            {
                TagID: 21034,
                UserID: UserId,
                FromDate: $("#daylistdatepicker").val(),
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillPendingEntriesTotal", param, false);
            for (var i = 0; i < Result.length; i++) {
                $("#txtPendingTaskEntriesTotal").text(Result[i]["TotalDurationHHMM"]);
            }

            $('#pmdashTimesheetTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
                "info": false,
            });
            if (strHtml == "") {
                $("#BodypmdashTimesheetTbl tbody tr td").prop("colspan", 5);
            }
        }

        function PreviousDay() {
            var Parameter =
            {
                FromDate: $("#daylistdatepicker").val(),
                Flag: 0
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/GetDate", param, false);
            Result = Result.split("~");
            TaskListByDate(Result[0]);
            $("#DayName").text(Result[1]);
        }

        function NextDay() {
            var Parameter =
            {
                FromDate: $("#daylistdatepicker").val(),
                Flag: 1
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/GetDate", param, false);
            Result = Result.split("~");
            TaskListByDate(Result[0]);
            $("#DayName").text(Result[1]);
        }
        //Pending Entries

        function Flag_OnClick(IssueID,Projectid) {
            $("#ClearFlagDetails").hide();
            $("#TrackingDetailsIssueID").text(IssueID);
            $("#txtFlagProjectid").val(Projectid);

            var Parameter =
            {
                TaskID: IssueID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillFlagTo", param, false);
            var s = '';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.FlagTo + '">' + ObjRateCard.FlagName + '</option>';
            }
            $("#cboFlagto").html(s);

            var Parameter =
            {
                TaskID: IssueID,
                FromWhere: "IB",
                UserID: UserId
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillTrackingDetailsInformation", param, false);
            if (Result.length > 0) { // Added By Dipali V On 14th March 2023 For Flag Refresh Issue
                for (var i = 0; i < Result.length; i++) {

                    var DueDate = Result[i]["DueDate"];
                    var FlagTo = Result[i]["FlagTo"];
                    var IsComplete = Result[i]["IsComplete"];
                    var UniqueID = Result[i]["UniqueID"];

                    $("#txtUniqueid").val(UniqueID);
                    $("#cboFlagto").val(FlagTo);
                    $("#duebydate").val(DueDate);

                    if (IsComplete == 0) {
                        $("#flagchkcomplete").prop('checked', false);
                        $("#ClearFlagDetails").show();
                    }
                    else {
                        $("#flagchkcomplete").prop('checked', true);
                    }
                }
            }
            else {// Added By Dipali V On 14th March 2023 For Flag Refresh Issue
                $("#duebydate").val("");
                $("#flagchkcomplete").prop('checked', false);
                //End of  Added By Dipali V On 14th March 2023 For Flag Refresh Issue
            }
            var Parameter =
            {
                TaskID: IssueID,
                FromWhere: "IB"
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillTrackingDetails", param, false);
            $("#TrackingDetailsTaskName").text(Result[0]["Column1"]);


            $("#flagmodal").modal("show");
        }

        function DocumentLink_OnClick(Projectid, ParentTaskID, TaskID) {
            $('#attachedDocTbl').dataTable().fnDestroy();
            
            var gCategory = '';
            var strHtml = ''; 
           
            $("#BodyattachedDocTbl").html('');
            if (TaskID == 2191 || TaskID == 34) {
                var Parameter =
                {
                    TagID: TaskID,
                    UserID: UserId,
                    ProjectID: Projectid,
                    UniqueID: ParentTaskID,
                    SortBy: 'Category',
                    SortOrder: 'ASC',
                    Paging: '-1'
                }
            }
            else {
                var Parameter =
                {
                    TagID: 1038,
                    UserID: UserId,
                    ProjectID: Projectid,
                    /* UniqueID: TaskID,*/
                    UniqueID: ParentTaskID,
                    SortBy: 'Category',
                    SortOrder: 'ASC',
                    Paging: '-1'
                }
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillDocument", param, false);
            for (var i = 0; i < Result.length; i++) {
                var Category = Result[i]["Category"];
                var SubCategory = Result[i]["SubCategory"];
                var FileName = Result[i]["FileName"];
                var UploadedDate = Result[i]["UploadedDate"];
                var FileSize = Result[i]["FileSize"];
                var DocumentID = Result[i]["DocumentID"];
                var ProjectID = Result[i]["ProjectID"];

                if (gCategory == '') {
                    strHtml += '<tr class="graybg">';
                    strHtml += '<td colspan="6" class="text-start"><strong>' + Category + '</strong></td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '</tr>';

                    strHtml += '<tr>';
                    strHtml += '<td></td>';
                    strHtml += '<td>' + SubCategory + '</td>';
                    strHtml += "<td><a href='javascript: ;' onclick='downLoadDocument(" + DocumentID + ", " + ProjectID + ")'>" + FileName + " </a></td>";
                    strHtml += '<td>' + UploadedDate + '</td>';
                    strHtml += '<td class="text-center">' + FileSize + '</td>';
                    strHtml += '<td class="text-center">' + UploadedDate + '</td>';
                    strHtml += '</tr>';
                }
                else if (gCategory == Category) {
                    strHtml += '<tr>';
                    strHtml += '<td></td>';
                    strHtml += '<td>' + SubCategory + '</td>';
                    strHtml += "<td><a href='javascript: ;' onclick='downLoadDocument(" + DocumentID + ", " + ProjectID + ")'>" + FileName + " </a></td>";
                    strHtml += '<td>' + UploadedDate + '</td>';
                    strHtml += '<td class="text-center">' + FileSize + '</td>';
                    strHtml += '<td class="text-center">' + UploadedDate + '</td>';
                    strHtml += '</tr>';
                }
                else if (gCategory != Category) {
                    strHtml += '<tr class="graybg">';
                    strHtml += '<td colspan="6" class="text-start"><strong>' + Category + '</strong></td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '</tr>';

                    strHtml += '<tr>';
                    strHtml += '<td></td>';
                    strHtml += '<td>' + SubCategory + '</td>';
                    strHtml += "<td><a href='javascript: ;' onclick='downLoadDocument(" + DocumentID + ", " + ProjectID + ")'>" + FileName + " </a></td>";
                    strHtml += '<td>' + UploadedDate + '</td>';
                    strHtml += '<td class="text-center">' + FileSize + '</td>';
                    strHtml += '<td class="text-center">' + UploadedDate + '</td>';
                    strHtml += '</tr>';
                }
                gCategory = Category;
            }
            $("#BodyattachedDocTbl").html(strHtml);
            $('#attachedDocTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true, 
                "retrieve": true,
                "responsive": true,
            }); 
            if (strHtml == "") {
                $("#BodyattachedDocTbl tbody tr td").prop("colspan", 6);
            } 
            $("#documentationmodal").modal("show"); 
        }

        function DocumentLinkDeliverable_OnClick(ScheduleID)
        {
            if (ProjectId == "" || ProjectId == null) {
                alertify.error("<%= MyBase.GetResourceString("A_SelectProject") %>");
                return;
            }
            var gCategory = '';
            var strHtml = '';

            $('#attachedDocTbl').dataTable().fnDestroy();
            $("#BodyattachedDocTbl").html('');
            var Parameter =
            {
                TagID: 2133,
                UserID: UserId,
                ProjectID: ProjectId,
                UniqueID: ScheduleID,
                SortBy: 'Category',
                SortOrder: 'ASC',
                Paging: '-1'
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillDocument", param, false);
            for (var i = 0; i < Result.length; i++) {
                var Category = Result[i]["Category"];
                var SubCategory = Result[i]["SubCategory"];
                var FileName = Result[i]["FileName"];
                var UploadedDate = Result[i]["UploadedDate"];
                var FileSize = Result[i]["FileSize"];
                var DocumentID = Result[i]["DocumentID"];
                var ProjectID = Result[i]["ProjectID"];

                if (gCategory == '') {
                    strHtml += '<tr class="graybg">';
                    strHtml += '<td colspan="6" class="text-start"><strong>' + Category + '</strong></td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '</tr>';

                    strHtml += '<tr>';
                    strHtml += '<td></td>';
                    strHtml += '<td>' + SubCategory + '</td>';
                    strHtml += "<td><a href='javascript: ;' onclick='downLoadDocument(" + DocumentID + ", " + ProjectID + ")'>" + FileName + " </a></td>";
                    strHtml += '<td>' + UploadedDate + '</td>';
                    strHtml += '<td class="text-center">' + FileSize + '</td>';
                    strHtml += '<td class="text-center">' + UploadedDate + '</td>';
                    strHtml += '</tr>';
                }
                else if (gCategory == Category) {
                    strHtml += '<tr>';
                    strHtml += '<td></td>';
                    strHtml += '<td>' + SubCategory + '</td>';
                    strHtml += "<td><a href='javascript: ;' onclick='downLoadDocument(" + DocumentID + ", " + ProjectID + ")'>" + FileName + " </a></td>";
                    strHtml += '<td>' + UploadedDate + '</td>';
                    strHtml += '<td class="text-center">' + FileSize + '</td>';
                    strHtml += '<td class="text-center">' + UploadedDate + '</td>';
                    strHtml += '</tr>';
                }
                else if (gCategory != Category) {
                    strHtml += '<tr class="graybg">';
                    strHtml += '<td colspan="6" class="text-start"><strong>' + Category + '</strong></td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '<td style="display:none;">&nbsp;</td>';
                    strHtml += '</tr>';

                    strHtml += '<tr>';
                    strHtml += '<td></td>';
                    strHtml += '<td>' + SubCategory + '</td>';
                    strHtml += "<td><a href='javascript: ;' onclick='downLoadDocument(" + DocumentID + ", " + ProjectID + ")'>" + FileName + " </a></td>";
                    strHtml += '<td>' + UploadedDate + '</td>';
                    strHtml += '<td class="text-center">' + FileSize + '</td>';
                    strHtml += '<td class="text-center">' + UploadedDate + '</td>';
                    strHtml += '</tr>';
                }
                gCategory = Category;
            }
            $("#BodyattachedDocTbl").html(strHtml);
            $('#attachedDocTbl').dataTable({
                "scrollY": false,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHtml == "") {
                $("#BodyattachedDocTbl tbody tr td").prop("colspan", 6);
            }

            $("#documentationmodal").modal("show");
        }

        function downLoadDocument(DID, ProjectID) {
            //var strTemp = '../../PM/PM_ViewDocument.aspx?DocumentID=' + DID + '&ProjectID=' + ProjectID + '&FromDashboard=Dashboard';
            var strTemp = '../../PM/PM_ViewDocument.aspx?MasterTagID=1038&DocumentID=' + DID + '&ProjectID=' + ProjectID + '&FromWhere=PM';
            window.open(strTemp);
        }

        function ClearAttachemnt() {
            $('#attachedDocTbl').dataTable().fnDestroy();
            $("#BodyattachedDocTbl").html('');

            $('#attachedIssueTbl').dataTable().fnDestroy();
            $("#BodyattachedIssueTbl").html('');
        }

        function ClearIssueDetails() {
            $("#cboFlagto").val(-1);
            $("#duebydate").val('');
            $("#flagchkcomplete").prop('checked', false);
            $("#TrackingDetailsIssueID").text('');
            $("#TrackingDetailsTaskName").text('');
            $("#txtFlagProjectid").val('');
            $("#txtUniqueid").val('');
        }

        function SaveTrackingDetails() {
            var FlagTo = $("#cboFlagto").val();
            
            /*if ($("#cboFlagto").val() == "") {*/
            if (FlagTo == "" || FlagTo == -1) {
                alertify.error("<%= MyBase.GetResourceString("A_FlagTo") %>");
                $("#cboFlagto").focus();
                return;
            }
            else if ($("#duebydate").val() == "") { 
                alertify.error("<%= MyBase.GetResourceString("A_DueBy") %>");
                $("#duebydate").focus();
                return;
            }
            else {
                var isComplete = 0;
                var checkBox = document.getElementById('flagchkcomplete');
                if (checkBox.checked) {
                    isComplete = 1;
                }

                

                var Parameter =
                {
                    UserID: UserId,
                    Flagg: 'IB',
                    IssueID: $("#TrackingDetailsIssueID").text(),
                    ProjectID: $("#txtFlagProjectid").val(),
                    FlagTo: $("#cboFlagto").val(),
                    DueDate: $("#duebydate").val(),
                    isComplete: isComplete,
                }
                var param = JSON.stringify(Parameter);
                var Result = AJAXCallWithResult("/api/PMDshBoard/SaveIssueFlagDetails", param, false);
                var Msg = "";
                for (var i = 0; i < Result.length; i++) {
                    Msg = Result[i]["Msg"];
                }
                IssueList();
                Flag_OnClick($("#TrackingDetailsIssueID").text()); 
                alertify.success("<%= MyBase.GetResourceString("A_TrackingSave") %>");
                //ClearIssueDetails();
                $("#flagmodal").modal("hide");
            }
        }

        function ClearFlagDetails() {
            var Parameter =
            {
                UniqueID: $("#txtUniqueid").val()
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/ClearFlagDetails", param, false);
            var Msg = "";
            for (var i = 0; i < Result.length; i++) {
                Msg = Result[i]["Msg"];
            }

            if (Msg == "Deleted") {
                IssueList();
                alertify.success("<%= MyBase.GetResourceString("A_TrackingDelete") %>");
                ClearIssueDetails();
                $("#flagmodal").modal("hide");
            }
        }

        function DocumentIssue_OnClick(Projectid, TaskID) {
            var strHtml = '';

            $('#attachedIssueTbl').dataTable().fnDestroy();
            $("#BodyattachedIssueTbl").html('');
            var Parameter =
            {
                TagID: 1038,
                UserID: UserId,
                ProjectID: Projectid,
                TaskID: TaskID,
                SortBy: 'DateOfAttaching',
                SortOrder: 'DESC',
                Paging: '-1'
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillIssueDocumentList", param, false);
            for (var i = 0; i < Result.length; i++) {
                var OriginalFileName = Result[i]["OriginalFileName"];
                var AttachmentID = Result[i]["AttachmentID"];
                var ProjectID = Result[i]["ProjectID"];
                var AttachedBy = Result[i]["AttachedBy"];
                var DateOfAttaching = Result[i]["DateOfAttaching"];
                var Description = Result[i]["Description"];
                var FilePath = Result[i]["FilePath"];

                strHtml += '<tr>';
                strHtml += '<td><a href="javascript:;"  onclick=Document_OnClick_For_Issue(' + "'" + FilePath + "'" + ',' + "'" + FilePath + "'" + ')>' + OriginalFileName + '</a > ';
                strHtml += '<td>' + AttachedBy + '</td>';
                strHtml += '<td class="text-center">' + DateOfAttaching + '</td>';
                strHtml += '<td class="text-center">' + Description + '</td>';
                strHtml += '</tr>';
            }
            $("#BodyattachedIssueTbl").html(strHtml);
            $('#attachedIssueTbl').dataTable({
                "scrollY": '40vh',
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
            if (strHtml == "") {
                $("#BodyattachedIssueTbl tbody tr td").prop("colspan", 4);
            }
            $("#IssueAttachemntmodal").modal("show");
        }

        function Document_OnClick_For_Issue(strSystemFileName, strOriginalFileName) {
            var strTemp = '../../General/ViewAttachment.aspx?FromWhere=BTS&FileName=' + strOriginalFileName + '&SystemFileName=' + strSystemFileName;
            window.open(strTemp);
        }

        function DisplayDeliverableReport(ScheduleID) {
            window.open("../../CRW/CRW_ReportUIBuilder.aspx?ReportID=1895&UniqueID=" + ScheduleID, "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=650,height=450");
            //var Parameter =
            //{
            //    ScheduleID: ScheduleID
            //}
            //var param = JSON.stringify(Parameter);
            //var Result = AJAXCallWithResult("/api/PMDshBoard/ShowDeliverableReport", param, false);
            //var s = '';
            //for (var i = 0; i < Result.length; i++) {
            //    var ObjRateCard = Result[i];
            //    s += '<option value="' + ObjRateCard.ScheduleID + '">' + ObjRateCard.Title + '</option>';
            //}
            //$("#cboDeliverable").html(s);
            //$("#ShowDelReportModal").modal("show");

            //$("#cboDeliverable").val(ScheduleID);
            //$("#DeliverableUniqueid").val(ScheduleID);
        }

        function MilestoneReport_OnClick(ProjectID, MileStoneID)
        {
            var AnaysisID=0;
            var Parameter =
            { 
                ProjectID: ProjectID,
                MileStoneID: MileStoneID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/GetMileStoneAnalysisID", param, false);
            for (var i = 0; i < Result.length; i++) {
                AnaysisID = Result[i]["AnalysisID"];
            }
            window.open("../../CRW/CRW_ReportUIBuilder.aspx?ReportID=640&UniqueID=" + AnaysisID, "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=650,height=450");
            //var Parameter =
            //{
            //    ScheduleID: 1,
            //    ProjectID: ProjectID,
            //    AnalysisID: MileStoneID
            //}
            //var param = JSON.stringify(Parameter);
            //var Result = AJAXCallWithResult("/api/PMDshBoard/ShowMilestoneReport", param, false);
            //var s = '';
            //for (var i = 0; i < Result.length; i++) {
            //    var ObjRateCard = Result[i];
            //    s += '<option value="' + ObjRateCard.AnalysisID + '">' + ObjRateCard.Milestone + '</option>';
            //}
            //$("#cboMileStone").html(s);
            //$("#cboMileStone").val(MileStoneID);
            //$("#ShowReportModal").modal("show");
            
        }

        function Export_PDFClick(ReportFormat, ReportID)
        { 
            if (ReportID == 640) {
                if ($("#cboMileStone").val() == "0") {
                    alertify.error("<%= MyBase.GetResourceString("A_Milestone") %>");
                    $("#cboMileStone").focus();
                }
                else
                {
                    window.open("../../CRW/CRW_ReportUIBuilder.aspx?ReportID=640&UniqueID=" + $("#cboMileStone").val(), "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=650,height=450");

                    //Parameter =
                    //{
                    //    DeliverableUniqueid: $("#cboMileStone").val(),
                    //    ReportFormat: ReportFormat,
                    //    ReportID: ReportID
                    //}
                    //$.ajax({
                    //    url: strUrl + '/api/PMDshBoard/ExportToReport',
                    //    method: 'Post',
                    //    data: JSON.stringify(Parameter),
                    //    dataType: 'json',
                    //    async: false,
                    //    contentType: "application/json",
                    //    beforeSend: function (xhr) {
                    //        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Dashboard"));
                    //    },
                    //    success: function (result)
                    //    { 
                    //        if (result != "0") {
                    //            window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                    //        }
                    //        else {
                    //            alertify.error("No data avialable");
                    //        }
                    //    },
                    //    error: function (err) {
                    //        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    //    }
                    //});
                }
            }
            else if (ReportID == 1895) {
                if ($("#cboDeliverable").val() == "0") {
                    alertify.error("<%= MyBase.GetResourceString("A_Deliverable") %>");
                    $("#cboDeliverable").focus();
                }
                else {
                    window.open("../../CRW/CRW_ReportUIBuilder.aspx?ReportID=640&UniqueID=" + $("#DeliverableUniqueid").val(), "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=650,height=450");

                    //Parameter = {
                    //    RiskID: ReportID,
                    //    DeliverableUniqueid: $("#DeliverableUniqueid").val(),
                    //    ReportFormat: ReportFormat,
                    //    ReportID: ReportID
                    //}
                    //$.ajax({
                    //    url: strUrl + '/api/PMDshBoard/ExportToReport',
                    //    method: 'Post',
                    //    data: JSON.stringify(Parameter),
                    //    dataType: 'json',
                    //    async: false,
                    //    contentType: "application/json",
                    //    beforeSend: function (xhr) {
                    //        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Dashboard"));
                    //    },
                    //    success: function (result) {
                    //        if (result != "0") {
                    //            window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                    //        }
                    //    },
                    //    error: function (err) {
                    //        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    //    }
                    //});
                }
            }
            else if (ReportID == 746) {
                if ($("#cboProjectName").val() == "0") {
                    alertify.error("<%= MyBase.GetResourceString("A_ProjectName") %>");
                    $("#cboProjectName").focus();
                }
                else {
                    Parameter =
                    { 
                        DeliverableUniqueid: $("#cboProjectName").val(),
                        ReportFormat: ReportFormat,
                        ReportID: ReportID
                    }
                    $.ajax({
                        url: strUrl + '/api/PMDshBoard/ExportToReport',
                        method: 'Post',
                        data: JSON.stringify(Parameter),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Dashboard"));
                        },
                        success: function (result) {
                            if (result != "0") {
                                window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                            }
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                        }
                    });
                }
            } 
        }

        function ShowProjectInfo(ProjectID)
        {
            window.open("../../CRW/CRW_ReportUIBuilder.aspx?ReportID=746&UniqueID=" + ProjectID, "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=650,height=450");
             
            //var Parameter =
            //{
            //    TagID: 1,
            //    //ProjecIDs: ProjectidAccessiable
            //    ProjecIDs: ProjectID
            //}
            //var param = JSON.stringify(Parameter);
            //var Result = AJAXCallWithResult("/api/PMDshBoard/FillProjectName", param, false);
            //var s = '';
            //for (var i = 0; i < Result.length; i++) {
            //    var ObjRateCard = Result[i];
            //    s += '<option value="' + ObjRateCard.ProjectID + '">' + ObjRateCard.ProjectName + '</option>';
            //}
            //$("#cboProjectName").html(s);
            //$("#cboProjectName").val(ProjectID);
            //$("#ShowMyProReportModal").modal("show");
        }

        //To Do List TimeSheet Popup
       <%-- function ToDoList(ProjectID, TaskID)
        {
            $("#radioGeneralTasks").prop('checked', false);
            $("#radioMPPTasks").prop('checked', false);
            $("#radioAssignedTasks").prop('checked', false);
            $("#radioIssuesAssigned").prop('checked', false);

            $("#radioActivityNormal").prop('checked', true);
             
            document.getElementById("radioGeneralTasks").disabled = true;
            document.getElementById("radioMPPTasks").disabled = true;
            document.getElementById("radioAssignedTasks").disabled = true;
            document.getElementById("radioIssuesAssigned").disabled = true;
            document.getElementById("cboToDoListTask").disabled = true;
            document.getElementById("cboToDoListProjectName").disabled = true;

            var Parameter =
            { 
                UserID: UserId,
                ProjectID: ProjectID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillToDoListProjectList", param, false);
            var s = '';
            s += '<option value="0">Select Project</option>';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.ProjectID + '">' + ObjRateCard.Project + '</option>';
            }
            $("#cboToDoListProjectName").html(s);

            var Parameter =
            {
                UserID: UserId,
                ProjectID: ProjectID,
                AssignedTasksFlag: 1,
                GetConcatenatedTaskID:1
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillToDoListTask", param, false);
            var s = '';
            s += '<option value="0">Select Task</option>';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.TaskID + '">' + ObjRateCard.TaskName + '</option>';
            }
            $("#cboToDoListTask").html(s);

            var Parameter =
            { 
                ProjectID: ProjectID,
                Flag:1
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillToDoListActivity", param, false);
            var s = '';
            s += '<option value="0">Select Activity</option>';
            for (var i = 0; i < Result.length; i++) {
                var ObjRateCard = Result[i];
                s += '<option value="' + ObjRateCard.SubTaskTypeID + '">' + ObjRateCard.SubTaskType + '</option>';
            }
            $("#cboToDoListSelectActivity").html(s);


            var Parameter =
            { 
                TaskID: TaskID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillToDoListData", param, false);
            for (var i = 0; i < Result.length; i++) {
                var Obj = Result[i]; 
                $("#txtTimesheetmodifytaskdate").val(Obj.StartingDate);
                $("#cboToDoListProjectName").val(Obj.ProjectID);
                $("#cboToDoListTask").val(Obj.TaskInfo);
                
                if (Obj.WhichTask == "D") {
                    $("#radioGeneralTasks").prop('checked', true); 
                }
                else if (Obj.WhichTask == "M") {
                    $("#radioMPPTasks").prop('checked', true); 
                }
                else if (Obj.WhichTask == "O") {
                    $("#radioAssignedTasks").prop('checked', true);                   
                }
                else if (Obj.WhichTask == "B") {
                    $("#radioIssuesAssigned").prop('checked', true);                   
                }

                $("#txtTimesheetAllocatedWork").text(Obj.Work.toFixed(2));
                $("#txtTimesheetActualWork").text(Obj.ActualWork.toFixed(2));
                $("#txtTimesheetStartDate").text(Obj.StartingDate);
                $("#txtTimesheetEndDate").text(Obj.EndingDate);
                $("#txtTimesheetactualPer").val(0.00);
            }

            $("#EdashTMModal").modal("show");
        }

        function ToDoListSave()
        {
          
            var TimesheetBlockedProjects = '';
            var Parameter =
            {
                UserID: UserId
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/PMDshBoard/FillToDoListSavevalidation", param, false); 
            for (var i = 0; i < Result.length; i++) {
                var Obj = Result[i];
                TimesheetBlockedProjects = Obj.TimesheetBlockedProjects;
            }
            if (TimesheetBlockedProjects.indexOf(',' + $("#cboToDoListProjectName").val() + ',') != -1) {
                alertify.error("Timesheet entry has been blocked. You cannot enter timesheet for this date.");
                return;
            }

            var TaskDate = $("#txtTimesheetmodifytaskdate").val();
            if (TaskDate == "" || TaskDate == null) {
                alert('Please enter a value for date');
                return;
            }

            var strProjectBackdateEntry = "No";
            intBackDating = "<%=EXPIRY_OF_TASK%>";
            intFwdDating = "<%=EXPIRY_OF_TASK_FORWARD%>";

            if (intBackDating.length != 0)
            {
                if (strProjectBackdateEntry != "Yes")
                {                   
                    var splitArr = TaskDate.split(" ");
                     var cmpDate = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), (intBackDating - 0), 0, 0);

                    if (DateDiff(cmpDate, new Date('<%=Date.Now.ToString()%>'), "d") > 0 )
					{
                        alertify.error("Timesheet entry had been blocked. You cannot enter timesheet for this date.");
                        return;
                    }
                }
            }

            var txtHours = $("#txtTimesheetactualHrs").val();
            var txtHoursPer = $("#txtTimesheetactualPer").val();
            if (txtHours == "") {
                alertify.error("Please Enter Actual Work (hrs)");
                $("#txtTimesheetactualHrs").focus();
                return;
            }

            if (txtHoursPer == "") {
                alertify.error("Please Enter Actual % complete");
                $("#txtTimesheetactualHrs").focus();
                return;
            }

            if (<%=CommonFunctions.Application.MinHoursForDAEntry%> != "0.016") {
                if ((((txtHours - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) - 0).toFixed(0) != ((txtHours - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
				{
					alert('<%=MyBase.GetResourceString("VALIDATE_MULTIPLE_HOURS")%>' + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
                    objtxtHours.focus();
                    return;
                }
            }

        }

        function DateAdd(startDate, numDays, numMonths, numYears) {
            var returnDate = new Date(startDate.getTime());
            var yearsToAdd = numYears;

            var month = returnDate.getMonth() + numMonths;
            if (month > 11) {
                yearsToAdd = Math.floor((month + 1) / 12);
                month -= 12 * yearsToAdd;
                yearsToAdd += numYears;
            }
            returnDate.setMonth(month);
            returnDate.setFullYear(returnDate.getFullYear() + yearsToAdd);

            returnDate.setTime(returnDate.getTime() + 60000 * 60 * 24 * numDays);

            return returnDate;

        }

        function DateDiff(start, end, interval, rounding) {

            var iOut = 0;

            // Create 2 error messages, 1 for each argument.</KBD> 
            var startMsg = "Check the Start Date and End Date\n"
            startMsg += "must be a valid date format.\n\n"
            startMsg += "Please try again.";

            var intervalMsg = "Sorry the dateAdd function only accepts\n"
            intervalMsg += "d, h, m OR s intervals.\n\n"
            intervalMsg += "Please try again.";

            var bufferA = Date.parse(start);
            var bufferB = Date.parse(end);

            // check that the start parameter is a valid Date. </KBD>
            if (isNaN(bufferA) || isNaN(bufferB)) {
                alert(startMsg);
                return null;
            }

            // check that an interval parameter was not numeric.</KBD> 
            if (interval.charAt == 'undefined') {
                // the user specified an incorrect interval, handle the error.</KBD> 
                alert(intervalMsg);
                return null;
            }
            var number = bufferB - bufferA;
            // what kind of add to do?</KBD> 
            switch (interval.charAt(0)) {
                case 'd': case 'D':
                    iOut = parseInt(number / 86400000);
                    if (rounding) iOut += parseInt((number % 86400000) / 43200001);
                    break;
                case 'h': case 'H':
                    iOut = parseInt(number / 3600000);
                    if (rounding) iOut += parseInt((number % 3600000) / 1800001);
                    break;
                case 'm': case 'M':
                    iOut = parseInt(number / 60000);
                    if (rounding) iOut += parseInt((number % 60000) / 30001);
                    break;
                case 's': case 'S':
                    iOut = parseInt(number / 1000);
                    if (rounding) iOut += parseInt((number % 1000) / 501);
                    break;
                default:
                    // If we get to here then the interval parameter
                    // didn't meet the d,h,m,s criteria.  Handle
                    // the error.</KBD> 		
                    alert(intervalMsg);
                    return null;
            }
            return iOut;
        }--%>

        var specialKeys = '';
        function Field_OnKeyPress(e, fieldId) {
            var keyCode = e.which ? e.which : e.keyCode
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) { 
                    alertify.error("<%= MyBase.GetResourceString("Pleaseenteronlynumericvalues") %>");
                }
            }
            return ret;
        }

        function IssueID_OnClick(intProjectid, IssueID) {
            //$("#issueentrymodal").modal("show");
            var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";
          
            var issueIdList = '';
            var tab = 'undefined';
            var intPageNo = 1;
            var ProjectID = intProjectid;
            var ProjectName = $("#cboIssueProjects :selected").text();
            var validatedparameter = parseInt(IssueID) + parseInt(ProjectID);
            var token;
            $.ajax({
                url: url + '/api/IB_IssueDetails/generateToken',
                type: 'POST',
                data: JSON.stringify(validatedparameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (validatedparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(validatedparameter) ? validatedparameter : JSON.stringify(validatedparameter)));
                    }
                },
                success: function (result) { 
                    token = result;
                    var secondfilter = "";
                    var FirstFilter = "";
                    if (secondfilter != "") {
                        if (secondfilter.indexOf("''") > -1) {
                            secondfilter = secondfilter.replace(/\''/g, "'");
                        }
                    }
                    if (FirstFilter != "") {
                        if (FirstFilter.indexOf("''") > -1) {
                            FirstFilter = FirstFilter.replace(/\''/g, "'");
                        }
                    }

                    var SavedQueryName = "";
                    var EmployeeID = "";
                    var QueryID = "";
                    var QueryType ="";
                    var vType ="A";
                    var vid ="0";
                    var url1 = "PMDAshBoardIssueDetail.aspx?ProjectID=" + parseInt(ProjectID) + "&PKToken=" + token + "&ProjectName=" + ProjectName + " &IssueID=" + parseInt(IssueID) + " &IssueIDList=" + issueIdList + " &ViewType=" + vType + "&View=" + vid +
                        " &intPageNo=" + intPageNo + " &tab=" + tab + "&secondfilter=" + escape(secondfilter)
                        + "&FirstFilter=" + escape(FirstFilter) + "&SavedQueryName=" + escape(SavedQueryName) +
                        "&EmployeeID=" + escape(EmployeeID) + "&QueryID=" + escape(QueryID) + "&QueryType=" + escape(QueryType) + "";

                    //url1 = "PMDAshBoardIssueDetail.aspx?ProjectID=" + parseInt(ProjectID) + "&PKToken=" + token + "&ProjectName=AGILE-T&M by Resource-Product Development &IssueID=" + parseInt(IssueID) + " &IssueIDList=2085|2084|2083|2082|2081|2080|2079|2078|2075|2071|2070|2069|32|31|16|15|14|12|11|10|9|8| &ViewType=A&View=0 &intPageNo=1  &tab=undefined&secondfilter=&FirstFilter=&SavedQueryName=&EmployeeID=&QueryID=&QueryType=";
                    PopUpWondowUtilization(url1, 1150, 500);
                },
                error: function (xhr, errorThrown) {
                     
                }
            });
        }

        function PopUpWondowUtilization(url, width, height) {
            var leftPosition, topPosition;
            leftPosition = (window.screen.width / 2) - ((width / 2) + 10);
            topPosition = (window.screen.height / 2) - ((height / 2) + 50);
            window.open(url, "Window2",
                "status=no,height=" + height + ",width=" + width + ",resizable=yes,left="
                + leftPosition + ",top=" + topPosition + ",screenX=" + leftPosition + ",screenY="
                + topPosition + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
        }

        function DeletePendingTaskEntry() {
            var table = $('#pmdashTimesheetTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            var MasterIDs = $('input[name=checkPendingTaskEntries]:checked', rows).map(function () {
                return this.value;
            }).get().join(',');
            var arrMasterIDs = MasterIDs.split(',');
             
            if (MasterIDs == "") { 
                alertify.error("<%= MyBase.GetResourceString("A_Selectatleastonerecord") %>");
                return;
            }
            else {
                for (i = 0; i < arrMasterIDs.length; i++)
                {
                    var Parameter =
                    {
                        DailyActivityEntryID: arrMasterIDs[i]
                    }
                    var param = JSON.stringify(Parameter);
                    var Result = AJAXCallWithResult("/api/PMDshBoard/DeletePendingTaskEntry", param, false);
                }
                TaskListByDate($("#daylistdatepicker").val());
            }
        }

        function CheckboxETCauth(id)
        {
            var x = document.getElementById("ETCAuth" + id).checked;
            if (x == true) {
                //$(".checkETCdel").prop("disabled", true);
                $(".checkETCdel").each(function () {
                    $(this).prop("checked", false);
                });
            }
            //else {
            //    $(".checkETCdel").prop("disabled", false); 
            //}
        }

        function CheckboxETCdel(id) {
            var x = document.getElementById("DelETCAuth" + id).checked; 
            if (x == true) {
                //$(".checkETCauth").prop("disabled", true);
                $(".checkETCauth").each(function () {
                    $(this).prop("checked", false);
                });
            }
            //else {
            //    $(".checkETCauth").prop("disabled", false); 
            //}
        }

        //AjaxCall Function
        function AJAXCallWithResult(url, param, async)
        {
            StartLoader("#body-PMDashboard"); 
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Dashboard"));
                    if (param)
                    {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    } 
                },
                success: function (data)
                {
                    ajaxResult = data;
                    StopAjaxLoader("#body-PMDashboard");
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        } 
    </script>
</body>
</html>
