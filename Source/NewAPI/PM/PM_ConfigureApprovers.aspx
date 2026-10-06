<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ConfigureApprovers.aspx.vb" Inherits="PbNIT.PM_ConfigureApprovers" %>

<!DOCTYPE html>
<html>
    <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Project")%> 
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">
  --%>  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
  <%--  <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>


    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

    
</head>
<style>
        /*.table-bordered {
            border-width: 1px;
            border-style: solid;
            border-color: white;
            border-image: initial;
        }*/

        #pstbl_confureApprovers .dataTables_scrollHeadInner {
            width: 100% !important;
        }

            #pstbl_confureApprovers .dataTables_scrollHeadInner .table {
                width: 100% !important;
            }


        /*added by pradip on 20-12-2019 for IssueID-20935*/
        #pstbl_confureApprovers .dataTables_scrollHeadInner {
            width: 100% !important;
        }

        #pstbl_confureApprovers table {
            width: 100%;
        }
        /*End added by pradip on 20-12-2019 for IssueID-20935*/
        /*#tblTimesheetHistory thead, #tblExpenseApproversHistory thead {display:none;}*/
        div#historyMain, div#historyMain2, #IRhistoryMain {
           /* Commented & Added By Dipali V On 24th March For datatable UI issues*/
            /*padding: 10px 10px 30px;*/
            padding: 10px 10px 59px;
             /*End of Commented & Added By Dipali V On 24th March For datatable UI issues*/
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        .tbl-keywords tr th:last-child, .tbl-keywords tr td:last-child {
            text-align: center !important;
        }
        /*by vishal Mahajan 21-12-2019*/
        .alertify-notifier {
            z-index: 9999 !important;
        }

        #tblTimeshetApprovers, #tblExpenseApprovers {
            margin: 0 auto;
            width: 97% !important;
        }

        #tblTimesheetHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:first-child, #tblTimesheetHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:nth-child(2), #tblTimesheetHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:first-child, #tblTimesheetHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:nth-child(3), #tblTimesheetHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:first-child, #tblTimesheetHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:nth-child(4), #tblbdyTimesheetHistroy > tr > td:first-child, #tblbdyTimesheetHistroy > tr > td:nth-child(2), #tblbdyTimesheetHistroy > tr > td:nth-child(3), #tblbdyTimesheetHistroy > tr > td:nth-child(4), #tblExpenseApproversHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:first-child, #tblExpenseApproversHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:nth-child(2), #tblExpenseApproversHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:first-child, #tblExpenseApproversHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:nth-child(3), #tblExpenseApproversHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:first-child, #tblExpenseApproversHistory_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:nth-child(4), #tblbdyExpenseApproversHistory > tr > td:first-child, #tblbdyExpenseApproversHistory > tr > td:nth-child(2), #tblbdyExpenseApproversHistory > tr > td:nth-child(3), #tblbdyExpenseApproversHistory > tr > td:nth-child(4) {
            min-width: 25% !important;
            max-width: 25% !important;
            width: 25% !important;
        }
        /*Added by Omkar at 06-01-2020*/
        #tblTimesheetHistory_wrapper #tblTimesheetHistory_info, #tblExpenseApproversHistory_wrapper #tblExpenseApproversHistory_info {
            display: inline-block;
        }

        #tblTimesheetHistory_wrapper #tblTimesheetHistory_paginate, #tblExpenseApproversHistory_wrapper #tblExpenseApproversHistory_paginate {
            margin-top: 10px;
        }
        /*End Of Added by Omkar at 06-01-2020*/
        #historyMain2 {padding-bottom:5%!important}

        /*Added ruby Dipali V For Datatable Issue*/ 
        table.dataTable thead > tr > th.sorting:before, table.dataTable thead>tr>th.sorting_asc:before, table.dataTable thead > tr > th.sorting:after, table.dataTable thead > tr > th.sorting_asc:after{display:none}
        /*End of Added ruby Dipali V For Datatable Issue*/ 

    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divConfigureApprovers">
        <div class="tab-pane pstbl_confureApprovers pt-0 in active" id="pstbl_confureApprovers" style="border-top: 1px solid #ddd;">
            <div class="modalpgHead  pt-1 pb-1 col-sm-12 mb-10">
                <span><%= MyBase.GetResourceString("C_Configure_Timesheet_Approvers") %></span>
            </div>

            <div class="timesheet-tabing">
                <ul class="">
                    <%-- <li class="main-tabing active"><a data-bs-toggle="tab" href="#main-tab-inner-1" aria-expanded="false">Timesheet Apporovers</a></li>
                <li class="main-tabing"><a data-bs-toggle="tab" href="#main-tab-inner-2" aria-expanded="false">Expense Apporovers</a></li>--%>
                    <li id="liTimesheetApporovers" class="main-tabing active"><a href="#" onclick="showTimesheetApporovers()"><%= MyBase.GetResourceString("C_Timesheet_Apporovers") %></a></li>
                    <li id="liExpenseApporovers" class="main-tabing"><a href="#" onclick="showExpenseApporovers()"><%= MyBase.GetResourceString("C_Expense_Apporovers") %></a></li>
                </ul>
            </div>
            <div class="tab-content">
                <div id="main-tab-inner-1" class="tab-pane fade in show active">
                    <div class="right-side-save mb-10">
                        <%--Added By Omkar P On 15.01.2020 For showing current project name --%>
                        <p class="float-start pl-20"><strong>Project Name : <span class="spnProjectName"></span></strong></p>
                        <%--End Of Added By Omkar P On 15.01.2020 For showing current project name --%>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnSetDefaultTimesheetApprover" onclick="btnSetDefaultTimesheetApproverclick()"><%= MyBase.GetResourceString("C_Set_Default_Approver") %></a>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnTimesheetSetApproverc" onclick="btnTimesheetSetApproverclick()"><%= MyBase.GetResourceString("C_Set_Approver") %></a>
                        <a href="javascript:;" class="btn borderbtn" data-bs-toggle="collapse" data-bs-target="#historyMain"><%= MyBase.GetResourceString("C_Show_History") %></a>
                    </div>
                    <div class="history-wrap accordian-body collapse" id="historyMain">
                        <div class="right-side-save mr-0">
                            <a href="#" class="btn borderbtn mb-10" data-bs-toggle="collapse" data-bs-target="#historyMain" aria-expanded="false"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                        <div class="page-main-head">
                            <h4><%= MyBase.GetResourceString("C_Timesheet_Approvers_History") %></h4>
                        </div>
                        <table id="tblTimesheetHistory" class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_Resource_Name") %></th>
                                    <th><%= MyBase.GetResourceString("C_Old_Approver") %>Old Approver</th>
                                    <th><%= MyBase.GetResourceString("C_New_Approver") %>New Approver</th>
                                    <th><%= MyBase.GetResourceString("C_Modified_Date") %></th>
                                </tr>
                            </thead>
                            <tbody id="tblbdyTimesheetHistroy">
                            </tbody>
                        </table>
                    </div>
                    <div class="approverfilter-wrap">
                        <div class="row pad">
                            <div class="col-sm-4">
                                <div class="approverMain">
                                    <label><%= MyBase.GetResourceString("C_Approver") %></label>
                                    <div class="custom-dropdown">

                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetApporovers", "exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_ReportingTo " & Session("intProjectID"),,,, True, , "class='form-control ' onchange='cboTimesheetApporoversOnChange()'",,,) %>--%>
                                        <%--Commented And Added By Reshma on 21st Dec 2019 For IssueID-20970--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetApporovers", "Select 0,'--selet IssueID--'",,,, True, , "class='form-control ' onchange='cboTimesheetApporoversOnChange()'",,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetApporovers", "Select 0,'--selet IssueID--'",,,,, , "class='form-control ' onchange='cboTimesheetApporoversOnChange()'",,,) %>
                                        <%--End Added By Reshma on 21st Dec 2019 For IssueID-20970--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="approverMain">
                                    <label><%= MyBase.GetResourceString("C_Role") %></label>
                                    <div class="custom-dropdown">
                                        <%--Commented And Added By Reshma on 21st Dec 2019 For IssueID-20970--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetRole", "usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_RoleDescription " & Request.QueryString("ProjectID"),,,, False, , "class='form-control onchange='cboTimesheetRoleOnChange()'",,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetRole", "usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_RoleDescription " & Request.QueryString("ProjectID"),,,,, , "class='form-control onchange='cboTimesheetRoleOnChange()'",,,) %>
                                        <%--End Added By Reshma on 21st Dec 2019 For IssueID-20970--%>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="approverMain">
                                    <label><%= MyBase.GetResourceString("C_Select_New_Approver") %></label>
                                    <div class="custom-dropdown">
                                        <%--<input type="text" class="text-field" name="Select New Approver" value="" id="approverTimeName">--%>
                                        <%--by vishal Mahajan 21-12-2019--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetNewApprover", "usp_Whizible2_sel_tbl_PM_RowWiseExternalApprovers " & Request.QueryString("ProjectID") & ",0,'-1', 'Employee Name', 'ASC'",,, "class='form-control '",,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetNewApprover", "usp_Whizible2_sel_tbl_PM_RowWiseExternalApprovers " & Request.QueryString("ProjectID") & ",0,'-1', 'Employee Name', 'ASC'",,,, False, , "form-control",,,) %>
                                        <%--by vishal Mahajan 21-12-2019--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <table id="tblTimeshetApprovers" class="table table-stripped table-bordered tbl-keywords mb-20">
                        <thead>
                            <tr>
                                <th width="15%"><%= MyBase.GetResourceString("C_Resource") %></th>
                                <th><%= MyBase.GetResourceString("C_Role") %></th>
                                <th width="15%"><%= MyBase.GetResourceString("C_Approver") %></th>
                                <th width="15%"><%= MyBase.GetResourceString("C_Last_Approver") %></th>
                                <th width="5%" class="text-center">
                                    <div class="custom_chckbox">
                                        <input id="configureAppAll" class="chckHead" type="checkbox">
                                        <label for="configureAppAll"></label>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody id="tblbdyTimeshetApprovers">
                        </tbody>
                    </table>
                </div>
                <%--Commented By Pradip on 21st Dec 2019 For IssueID-20968--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--End Commented By Pradip on 21st Dec 2019 For IssueID-20968--%>
                <div id="main-tab-inner-2" class="tab-pane fade">
                    <div class="right-side-save mb-10">
                        <%--Added By Omkar P On 15.01.2020 For showing current project name --%>
                        <p class="float-start pl-20"><strong>Project Name : <span class="spnProjectName"></span></strong></p>
                        <%--End Of Added By Omkar P On 15.01.2020 For showing current project name --%>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnSetDefaultExpenseApprover" onclick="btnSetDefaultExpenseApproverclick()"><%= MyBase.GetResourceString("C_Set_Default_Approver") %></a>
                        <a href="javascript:;" class="btn borderbtn mr-5" id="btnExpenseSetApproverc" onclick="btnExpenseSetApproverclick()"><%= MyBase.GetResourceString("C_Set_Approver") %></a>
                        <a href="javascript:;" class="btn borderbtn" data-bs-toggle="collapse" data-bs-target="#historyMain2"><%= MyBase.GetResourceString("C_Show_History") %></a>
                    </div>
                    <div class="history-wrap accordian-body collapse" id="historyMain2">
                        <div class="right-side-save mr-0">
                            <a href="#" class="btn borderbtn mb-10" data-bs-toggle="collapse" data-bs-target="#historyMain2" aria-expanded="false"><%= MyBase.GetResourceString("C_Close") %></a>
                        </div>
                        <div class="page-main-head">
                            <h4><%= MyBase.GetResourceString("C_Expense_Approvers_History") %></h4>
                        </div>
                        <table id="tblExpenseApproversHistory" class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_Resource_Name") %></th>
                                    <th><%= MyBase.GetResourceString("C_Old_Approver") %>Old Approver</th>
                                    <th><%= MyBase.GetResourceString("C_New_Approver") %>New Approver</th>
                                    <th><%= MyBase.GetResourceString("C_Modified_Date") %></th>
                                </tr>
                            </thead>
                            <tbody id="tblbdyExpenseApproversHistory">
                            </tbody>
                        </table>
                    </div>
                    <div class="approverfilter-wrap">
                        <div class="row pad">
                            <div class="col-sm-4">
                                <div class="approverMain">
                                    <label><%= MyBase.GetResourceString("C_Approver") %></label>
                                    <div class="custom-dropdown">

                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetApporovers", "exec usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_ReportingTo " & Session("intProjectID"),,,, True, , "class='form-control ' onchange='cboTimesheetApporoversOnChange()'",,,) %>--%>
                                        <%--Commented And Added By Reshma on 21st dec 2019 For IssueID-20970--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboExpenseApporovers", "Select 0,'--selet IssueID--'",,,, True, , "class='form-control ' onchange='cboExpenseApporoversOnChange()'",,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboExpenseApporovers", "Select 0,'--selet IssueID--'",,,,, , "class='form-control ' onchange='cboExpenseApporoversOnChange()'",,,) %>
                                        <%--End Added By Reshma on 21st dec 2019 For IssueID-20970--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="approverMain">
                                    <label><%= MyBase.GetResourceString("C_Role") %></label>
                                    <div class="custom-dropdown">
                                        <%--Commented And Added By Reshma on 21st Dec 2019 For IssueID-20970--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboExpenseRole", "usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_RoleDescription " & Request.QueryString("ProjectID"),,,, False, , "class='form-control onchange='cboExpenseRoleOnChange()'",,,) %>--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboExpenseRole", "usp_Whizible2_sel_tbl_PM_ProjectEmployeeRole_RoleDescription " & Request.QueryString("ProjectID"),,,,, , "class='form-control onchange='cboExpenseRoleOnChange()'",,,) %>
                                        <%--Commented And Added By Reshma on 21st Dec 2019 For IssueID-20970--%>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="approverMain">
                                    <label><%= MyBase.GetResourceString("C_Select_New_Approver") %></label>
                                    <div class="custom-dropdown">
                                        <%--<input type="text" class="text-field" name="Select New Approver" value="" id="approverTimeName">--%>
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboExpenseNewApprover", "usp_Whizible2_sel_tbl_PM_RowWiseExternalApprovers " & Request.QueryString("ProjectID") & ",0,'-1', 'Employee Name', 'ASC'",,, "class='form-control '",,,) %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table id="tblExpenseApprovers" class="table table-stripped table-bordered tbl-keywords mb-20">
                        <thead>
                            <tr>
                                <th width="15%"><%= MyBase.GetResourceString("C_Resource") %></th>
                                <th><%= MyBase.GetResourceString("C_Role") %></th>
                                <th width="15%"><%= MyBase.GetResourceString("C_Approver") %></th>
                                <th width="15%"><%= MyBase.GetResourceString("C_Last_Approver") %></th>
                                <th width="5%" class="text-center">
                                    <div class="custom_chckbox">
                                        <input id="expenseAppAll" class="chckHead" type="checkbox">
                                        <label for="expenseAppAll"></label>
                                    </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody id="tblbdyExpenseApprovers">
                        </tbody>
                    </table>
                </div>
                <%--Added By Pradip on 21st Dec 2019 For IssueID-20968--%>
            </div>
            <%--End Added By Pradip on 21st Dec 2019 For IssueID-20968--%>
        </div>
        <%--Commented By Pradip on 21st Dec 2019 For IssueID-20968--%>
        <%--</div>--%>
        <%--End Commented By Pradip on 21st Dec 2019 For IssueID-20968--%>


        <!--Add new site modal end here-->


        <!--Add_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPaddSubtaskModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Add New Sub Task</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <div class="row">
                                <label class="control-label col-sm-4">Sub Task Type</label>
                                <div class="col-sm-8">
                                    <select class="form-select selectpicker">
                                        <option>Risk Analysis</option>
                                        <option>Requirement Analysis</option>
                                        <option>Feasibility Study</option>
                                        <option>Documentation</option>
                                        <option>Defect Analysis</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row  mb-3">
                                <label class="control-label col-sm-4">&nbsp;</label>
                                <div class="col-sm-8">
                                    <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow float-end ml-1">Save</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow float-end">Save and Add</button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Add_new_Sub_tasktype_modal_end_here-->


        <!--Select Expense approver Start_here-->
        <div class="modal custmodal fade" id="approverTimeModal" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Select Approver</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th>User Name</th>
                                    <th>Resource</th>
                                    <th>Role</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">Ameya Paratkar</a></td>
                                    <td>Ameya Paratkar</td>
                                    <td>BUSINESS DEVELOPMENT MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">AnandG</a></td>
                                    <td>Anand Gadhave</td>
                                    <td>APPLICATION ADMINISTRATOR</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">Dipa</a></td>
                                    <td>Dipali Vekhande</td>
                                    <td>HR MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">manali.Jagtap</a></td>
                                    <td>Manali Jagtap</td>
                                    <td>PROJECT MANAGER / SCRUM MASTER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">narendra.kulkarni</a></td>
                                    <td>Narendra Kulkarni</td>
                                    <td>PRESIDENT</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">pradip.p</a></td>
                                    <td>Pradip Pradhan</td>
                                    <td>DEVELOPER CONSULTANT</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">saji.unni</a></td>
                                    <td>Saji Unni</td>
                                    <td>DEVELOPER CONSULTANT</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">swapnagandha.kavitkar</a></td>
                                    <td>Swapnagandha Mukund Kavitkar</td>
                                    <td>BUSINESS DEVELOPMENT MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">Admin</a></td>
                                    <td>TOOL ADMIN</td>
                                    <td>BUSINESS DEVELOPMENT MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-time" data-bs-dismiss="modal" aria-label="Close">vishwas.mhajan</a></td>
                                    <td>Vishwas Mahajan</td>
                                    <td>MANAGING DIRECTOR</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-12 btns-center">
                                <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Select Expense approver end here-->


        <!--Select Expense approver Start_here-->
        <div class="modal custmodal fade" id="approverExpModal" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Select Approver</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th>User Name</th>
                                    <th>Resource</th>
                                    <th>Role</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">Ameya Paratkar</a></td>
                                    <td>Ameya Paratkar</td>
                                    <td>BUSINESS DEVELOPMENT MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">AnandG</a></td>
                                    <td>Anand Gadhave</td>
                                    <td>APPLICATION ADMINISTRATOR</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">Dipa</a></td>
                                    <td>Dipali Vekhande</td>
                                    <td>HR MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">manali.Jagtap</a></td>
                                    <td>Manali Jagtap</td>
                                    <td>PROJECT MANAGER / SCRUM MASTER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">narendra.kulkarni</a></td>
                                    <td>Narendra Kulkarni</td>
                                    <td>PRESIDENT</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">pradip.p</a></td>
                                    <td>Pradip Pradhan</td>
                                    <td>DEVELOPER CONSULTANT</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">saji.unni</a></td>
                                    <td>Saji Unni</td>
                                    <td>DEVELOPER CONSULTANT</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">swapnagandha.kavitkar</a></td>
                                    <td>Swapnagandha Mukund Kavitkar</td>
                                    <td>BUSINESS DEVELOPMENT MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">Admin</a></td>
                                    <td>TOOL ADMIN</td>
                                    <td>BUSINESS DEVELOPMENT MANAGER</td>
                                </tr>
                                <tr>
                                    <td><a href="#" class="approver-exp" data-bs-dismiss="modal" aria-label="Close">vishwas.mhajan</a></td>
                                    <td>Vishwas Mahajan</td>
                                    <td>MANAGING DIRECTOR</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-12 btns-center">
                                <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Select Expense approver end here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Delete Sub Task</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5>
                                <center>Are you sure you want to delete these records?</center>
                            </h5>
                        </div>
                        <br />
                        <center>
                            <button data-bs-dismiss="modal" class="btn borderbtn">No</button>
                            <button data-bs-dismiss="modal" class="btn btnyellow ml-1">Yes</button>
                        </center>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Delete_new_Sub_tasktype_modal_end_here-->
        <!--Set Default Approver modal start here-->
        <div class="modal custmodal fade" id="setTimesheetDefApprover" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Select_Default_Approver") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center form-group">
                            <label><%= MyBase.GetResourceString("C_Select_Default_Approver") %> </label>
                            <div class="inp-select cont-center">
                              <%--  Commented & Added By Dipali V On 24th March 2023 For UI Issues--%>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetDefaultApprover", "usp_Whizible2_sel_tbl_PM_RowWiseApprovers " & Request.QueryString("ProjectID"), 300,,, False, , "form-control ",,,) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboTimesheetDefaultApprover", "usp_Whizible2_sel_tbl_PM_RowWiseApprovers " & Request.QueryString("ProjectID"), 300,,, False, , "form-select ",,,) %>
                             <%--End of Commented & Added By Dipali V On 24th March 2023 For UI Issues--%>
                            </div>
                        </div><br/>
                        <div class="text-center btn-grp-new">
                            <button data-bs-dismiss="modal" class="btn borderbtn mr-5" onclick="btncloseTimesheetDefaultApproverclick()"><%= MyBase.GetResourceString("C_Close") %></button>
                            <%--<button data-bs-dismiss="modal" class="btn borderbtn" onclick="btnsetTimesheetDefaultApproverclick()"><%= MyBase.GetResourceString("C_Set_Default_Approver") %></button>--%>
                            <%--by Vishal Mahajan 24-12-2019--%>
                            <button class="btn borderbtn" onclick="btnsetTimesheetDefaultApproverclick()"><%= MyBase.GetResourceString("C_Set_Default_Approver") %></button>
                            <%--by Vishal Mahajan 24-12-2019--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal custmodal fade" id="setExpenseDefApprover" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Select_Default_Approver") %> </h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <div class="text-center">
                                <label><%= MyBase.GetResourceString("C_Select_Default_Approver") %> </label>
                                <div class="inp-select cont-center">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboExpenseDefaultApprover", "usp_Whizible2_sel_tbl_PM_ExpenseApprovers " & Request.QueryString("ProjectID"), 300,,, False, , "form-control ",,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="text-center btn-grp-new">
                            <button data-bs-dismiss="modal" class="btn borderbtn mr-5" onclick="btncloseExpenseDefaultApproverclick()"><%= MyBase.GetResourceString("C_Close") %></button>
                            <%--<button data-bs-dismiss="modal" class="btn borderbtn" onclick="btnsetExpenseDefaultApproverclick()"><%= MyBase.GetResourceString("C_Set_Default_Approver") %></button>--%>
                            <%--by vishal Mahajan 21-12-2019--%>
                            <button class="btn borderbtn" onclick="btnsetExpenseDefaultApproverclick()"><%= MyBase.GetResourceString("C_Set_Default_Approver") %></button>
                            <%--by vishal Mahajan 21-12-2019--%>
                        </div>



                    </div>
                </div>
            </div>
        </div>
        <!--Set Default Approver modal end here-->

        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->


        <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
      --%>  <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
  <%--      <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
        <%-- Added By Reshma on 23re Dc 2019 For Loader--%>
        <!-- custome js -->
<%--        <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
        <%-- End Added By Reshma on 23re Dc 2019 For Loader--%>


        <script>

            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>';

            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
            var TimesheetGetDefaultApproverName;
            var ViewAccess = "<%= m_PM_ConfigureApproversViewAccess %>";


            $(document).ready(function () {
               
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divConfigureApprovers").html(bodyHTML);
                    return;
                }
                //alert("dd");
                $("#configureAppAll").click(function () {
                    $(".configurechck").prop('checked', $(this).prop('checked'));
                });

                $(".configurechck").change(function () {
                    if (!$(this).prop("checked")) {
                        $("#configureAppAll").prop("checked", false);
                    }
                });
             <%If m_PM_ConfigureApproversEditAccess = False Then%>
                $("#btnTimesheetSetApproverc").hide();
                $("#btnSetDefaultTimesheetApprover").hide();
                $("#main-tab-inner-1 > div.right-side-save.mb-10 > a:nth-child(3)").hide();

             <%End If %>
            <%If m_PM_ConfigureExpenseApproversEditAccess = False Then%>
                $("#btnExpenseSetApproverc").hide();
                $("#btnSetDefaultExpenseApprover").hide();
                $("#main-tab-inner-2 > div.right-side-save.mb-10 > a:nth-child(3)").hide();
            //alert("you have add access");
            //strHTML += '<a href="javascript:;" class="copy"><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Copy" class="far fa-copy Copy" id="CopySP' + SubProjectID + '" onclick="SubProjectEditAdd(this.id)" ></i></a> <a href="javascript:;" class="add" title="" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save"> <img class="material-icons" src="dist/img/save.svg" alt="" width="16px">  </a>'
             <%End If %>
                //alert();
                //Added By Omkar P On 15.01.2020 For showing current project name
                getProjectName(ProjectID);
                //End Of Added By Omkar P On 15.01.2020 For showing current project name
            });

            $(document).ready(function () {
                $("#expenseAppAll").click(function () {
                    // $(".expensechck").prop('checked', $(this).prop('checked'));
                    if ($(this).prop("checked")) {
                        $('#tblbdyExpenseApprovers input[type="checkbox"]').prop('checked', true);
                    } else {
                        $('#tblbdyExpenseApprovers input[type="checkbox"]').prop('checked', false);
                    }
                });



            });


            $(document).ready(function () {
                $(".approver-time").click(function () {
                    var text = $(this).text();
                    $("#approverTimeName").val(text);
                });

                $(".approver-exp").click(function () {
                    var text = $(this).text();
                    $("#approverExpName").val(text);
                });
                //return;
                GetApproverlst(ProjectID);
                // alert(ProjectID);
                //alert("daffasf");
                GetRowWiseApproversDetails(ProjectID, 0, 0);
                GetRowwiseApproversHistory(ProjectID);

                var select = $('#cboTimesheetNewApprover');
                select.html(select.find('option').sort(function (x, y) {
                    // to change to descending order switch "<" for ">"
                    //  console.log($(x).text());
                    //by vishal Mahajan 21-12-2019
                    //if ($(y).text() != "Select ReportingTo") {
                    if ($(y).val() != "") {
                        return $(x).text() > $(y).text() ? 1 : -1;
                    }
                    //by vishal Mahajan 21-12-2019

                }));
                //$("select#cboTimesheetNewApprover option").attr('selectedIndex', 0);
                $("#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetNewApprover").prop("selectedIndex", 0);
                callExpanseFunction();

            });

            function cboTimesheetApporoversOnChange() {
                // alert("code");
                var ApproverId = $('#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetApporovers option:selected').val();
                var RoleId = $('#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetRole option:selected').val();
                if (ApproverId.length == 0 || ApproverId == null) {
                    ApproverId = 0;
                }
                if (RoleId.length == 0 || RoleId == null) {
                    RoleId = 0;
                }
                GetRowWiseApproversDetails(ProjectID, ApproverId, RoleId);
                //Added By Usha Pandit On 12.06.2020 For unchecking previously selected parent checkbox if filter changed
                $("#configureAppAll").prop("checked", false);
                //End Of Added By Usha Pandit On 12.06.2020 For unchecking previously selected parent checkbox if filter changed
            }

            function cboTimesheetRoleOnChange() {
                var ApproverId = $('#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetApporovers option:selected').val();
                var RoleId = $('#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetRole option:selected').val();
                if (ApproverId.length == 0 || ApproverId == null) {
                    ApproverId = 0;
                }
                if (RoleId.length == 0 || RoleId == null) {
                    RoleId = 0;
                }
                GetRowWiseApproversDetails(ProjectID, ApproverId, RoleId);
                //Added By Usha Pandit On 12.06.2020 For unchecking previously selected parent checkbox if filter changed
                $("#configureAppAll").prop("checked", false);
                //End Of Added By Usha Pandit On 12.06.2020 For unchecking previously selected parent checkbox if filter changed
            }

            function GetRowWiseApproversDetails(ProjectId, ReportTo, Role) {
                //var ProjectId = ProjectId;
                // $("#tblprojectos").dataTable().fnDestroy();
                var configureApprovers = {
                    ProjectId: encodeURI(ProjectId),
                    ReportToId: encodeURI(ReportTo),
                    RoleId: encodeURI(Role),
                };
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetRowWiseApproversDetails',
                    method: 'Post',
                    data: JSON.stringify(configureApprovers),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (configureApprovers) {
                            xhr.setRequestHeader("Params", encryptString(isJson(configureApprovers) ? configureApprovers : JSON.stringify(configureApprovers)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        var RowWiseApprovers = result.RowWiseApprovers;
                        // console.log();
                        $("#tblbdyTimeshetApprovers").empty();
                        var strHTML = "";
                        TimesheetGetDefaultApproverName = "";
                        arrApproverIds = [];
                        if (RowWiseApprovers.length != 0) {


                            for (var i = 0; i < RowWiseApprovers.length; i++) {
                                var EmployeeID = RowWiseApprovers[i]["EmployeeID"];
                                var EmployeeName = RowWiseApprovers[i]["EmployeeName"];
                                var ApproverID = RowWiseApprovers[i]["ApproverID"];
                                var Approver = RowWiseApprovers[i]["Approver"];
                                var OldApprover = RowWiseApprovers[i]["OldApprover"];
                                var RoleDescription = RowWiseApprovers[i]["RoleDescription"];
                                if (Approver == null) {
                                    Approver = "";
                                }
                                strHTML += " <tr>"
                                strHTML += "         <td>" + EmployeeName + "</td>"
                                strHTML += "<td>" + RoleDescription + "</td>"
                                strHTML += "<td>" + Approver + "</td>"
                                if (OldApprover == null) {
                                    strHTML += "         <td></td>"
                                } else {
                                    strHTML += "         <td>" + OldApprover + "</td>"
                                }
                                strHTML += "<td>"
                                strHTML += "             <div class='custom_chckbox'>"
                                strHTML += "<input id='chkTSA" + EmployeeID + "' class='chckHead configurechck' type='checkbox' onchange = 'TimesheetApproverschkbxclickevent(this.id)'>"
                                strHTML += " <label for='chkTSA" + EmployeeID + "'></label>"
                                strHTML += " </div>"
                                strHTML += "</td>"
                                strHTML += "     </tr>"



                            }
                        } else {
                            strHTML += "<tr> <td colspan='5'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }

                        $("#tblbdyTimeshetApprovers").html(strHTML);

                        //$("#tblTimeshetApprovers ").css('width','100%');
                        var GetDefaultApproverName = result.GetDefaultApproverName;
                        for (var i = 0; i < GetDefaultApproverName.length; i++) {
                            TimesheetGetDefaultApproverName = GetDefaultApproverName[i]["EmployeeID"];
                        }

                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
            function GetRowwiseApproversHistory(ProjectId) {
                //var ProjectId = ProjectId;
                // $("#tblprojectos").dataTable().fnDestroy();
                //var configureApprovers = {
                //    ProjectId: encodeURI(ProjectId),
                //    ReportToId:encodeURI(ReportTo),
                //    RoleId:encodeURI(Role),
                //};
                $("#tblTimesheetHistory").dataTable().fnDestroy();
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetRowwiseApproversHistory',
                    method: 'Post',
                    data: JSON.stringify(ProjectId),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                        }
                    },
                    success: function (result) {
                        console.log(result);


                        var RowwiseApprovers_History = result.RowwiseApprovers_History;
                        // console.log();
                        try {
                            $("#tblbdyTimesheetHistroy").empty();
                            var strHTML = "";
                            for (var i = 0; i < RowwiseApprovers_History.length; i++) {
                                var ResourceName = RowwiseApprovers_History[i]["ResourceName"];
                                var OldApprover = RowwiseApprovers_History[i]["OldApprover"];
                                var NewApprover = RowwiseApprovers_History[i]["NewApprover"];
                                var Createddate = RowwiseApprovers_History[i]["Createddate"];

                                strHTML += " <tr>"
                                strHTML += " <td>" + ResourceName + "</td>"
                                strHTML += " <td>" + OldApprover + "</td>"
                                strHTML += " <td>" + NewApprover + "</td>"
                                strHTML += " <td>" + Createddate + "</td>"
                                strHTML += " </tr>"


                            }
                            $("#tblbdyTimesheetHistroy").html(strHTML);



                            $("#tblTimesheetHistory").DataTable({
                                "scrollY": false,
                                "scrollX": false,
                                "pageLength": 3,
                                "lengthChange": false,
                                "bFilter": false,
                                "ordering": true,
                                "responsive": true,
                                "retrieve": true


                            });

                            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                                $($.fn.dataTable.tables(true)).DataTable()
                                    .columns.adjust();
                            });

                            //  $("#tblTimesheetHistory").css('width','100%');
                            $("#tblTimesheetHistory ").css('width', '100%');

                            if (strHTML == "") {
                                $("#tblTimesheetHistory tbody tr td").prop("colspan", 4);
                            }

                            //             $('a[data-bs-toggle="tab"]').on( 'shown.bs.tab', function (e) {
                            //$.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
                            //            });

                            table.columns.adjust().draw();
                            $('#historyMain2').on('shown.bs.collapse', function (e) {
                                $($.fn.dataTable.tables(true)).DataTable()
                                    .columns.adjust();
                            });
                        }
                        catch (ex) {
                            //alert(ex.message);
                        }

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function btnTimesheetSetApproverclick() {
                // console.log("All ids");
                var flag = true;
                var EmployeeId = $('#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetNewApprover option:selected').val();
                var ck_box_cnt = $('#tblbdyTimeshetApprovers input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdyTimeshetApprovers input[type="checkbox"]:checked').length;

                if (EmployeeId.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                    // alertify.error("Select the New Approver");
                    alertify.error(message);
                    $('#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetNewApprover').focus();
                    flag = false;
                    return false;
                }
                if (chk_box_checked_cnt == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Select_Atleast_One_Employee_To_Set_Approver") %>';
                    // alertify.error("Select Atleast One Employee To Set Approver");
                    alertify.error(message);
                    flag = false;
                    return false;
                }
                tblTimeshetApproversCheckBoxChecked();
                var empid = parseInt(EmployeeId);
                if (arrApproverIds.indexOf(empid) != -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_The_Resource_cannot_be_set_as_approver_for_himself") %>';
                    // alertify.error("The Resource cannot be set as approver for himself");
                    alertify.error(message);
                    flag = false;
                    arrApproverIds = [];
                    return false;

                }
                if (flag == true) {


                    //tblTimeshetApproversCheckBoxChecked();

                    // console.log(arrApproverIds);
                    var configureApprovers = {
                        ProjectId: encodeURI(ProjectID),
                        EmployeeId: encodeURI(EmployeeId),
                        ApproverIds: arrApproverIds
                    };
                    // console.log(configureApprovers);

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectSettings/InsertRowWiseApprovers',
                        method: 'Post',
                        data: JSON.stringify(configureApprovers),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            //if (configureApprovers) {
                            //    xhr.setRequestHeader("Params", encryptString(isJson(configureApprovers) ? configureApprovers : JSON.stringify(configureApprovers)));
                            //}
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Timesheet_Approver_set_successfully") %>';
                            // alertify.success("Timesheet Approver set successfully");
                            alertify.success(message);
                            GetApproverlst(ProjectID);
                            GetRowwiseApproversHistory(ProjectID);
                            GetApproverlst(ProjectID);
                            cboTimesheetRoleOnChange();
                            $("#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetNewApprover").prop("selectedIndex", 0);
                            $('#tblTimeshetApprovers > thead > tr > th > div>input#configureAppAll').prop('checked', false);
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });

                }
            }
            var arrApproverIds = [];
            function tblTimeshetApproversCheckBoxChecked() {

                $('#tblTimeshetApprovers > tbody> tr').each(function (index, value) {

                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);

                        if (i == 4) {
                            var id = $(this).find('input[type=checkbox]').attr("id");
                            // console.log(id);


                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chkTSA', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (arrApproverIds.indexOf(id) == -1) {

                                    arrApproverIds.push(id);
                                }

                            }
                            //console.log(id);

                        }

                    });
                });
            }

            function GetApproverlst(ProjectId) {


                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetApproverlst',
                    method: 'Post',
                    data: JSON.stringify(ProjectId),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                        }
                    },
                    success: function (result) {
                        console.log(result);

                        var strResult = result.Approverlst;
                        $("#cboTimesheetApporovers").empty();
                        if (strResult != undefined) {
                            var selHTML = "";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            selHTML += "<option value=0 > Select Timesheet Approver </option>";
                            for (var i = 0; i < strResult.length; i++) {

                                var ReportingTo = strResult[i]["ReportingTo"];
                                var EmployeeName = strResult[i]["EmployeeName"];
                                // var ReportingTo = d.ReportingTo;
                                //var EmployeeName = d.EmployeeName;
                                //var Category = d.Category;
                                selHTML += "<option  value='" + ReportingTo + "'  >" + EmployeeName + "</option>";
                            }
                            // StopAjaxLoader("#bodyIssueList");

                            // $("#txtPhaseFilterResponsiblePerson").html(selHTML);
                            $("#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetApporovers").html(selHTML);


                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });


            }

            function showTimesheetApporovers() {

                $("#main-tab-inner-2").hide();
                $("#main-tab-inner-1").show();
                $("#main-tab-inner-1").removeClass("active");
                $("#main-tab-inner-1").removeClass("fade");
                $("#main-tab-inner-1").addClass("active");
                $("#main-tab-inner-1").addClass("fade");
                $("#liExpenseApporovers").removeClass("active");

                $("#liTimesheetApporovers").addClass("active");

            }

            function showExpenseApporovers() {

                $("#main-tab-inner-1").hide();
                $("#main-tab-inner-2").show();
                $("#main-tab-inner-2").removeClass("active");
                $("#main-tab-inner-2").removeClass("fade");
                $("#main-tab-inner-2").addClass("active");
                $("#main-tab-inner-1").addClass("fade");
                $("#liTimesheetApporovers").removeClass("active");
                //  $("#liTimesheetApporovers").addClass("fade");
                $("#liExpenseApporovers").addClass("active");
                // callExpanseFunction();
                // alert("ExpenseApporovers");
                //Added By Reshma on 23rd Dec 2019 For IssueID-20969
                $(".configurechck").prop('checked', false);
                //End Added By Reshma on 23rd Dec 2019 For IssueID-20969
            }

            function callExpanseFunction() {
                GetExpanseApproverlst(ProjectID);
                // alert(ProjectID);
                //alert("daffasf");
                GetRowWiseExpenseApproversDetails(ProjectID, 0, 0);
                GetRowwiseExpenseApproversHistory(ProjectID);

                var select = $('#cboExpenseNewApprover');
                select.html(select.find('option').sort(function (x, y) {
                    // to change to descending order switch "<" for ">"
                    //  console.log($(x).text());
                    //by vishal Mahajan 21-12-2019
                    //if ($(y).text() !="Select ReportingTo") {                    
                    if ($(y).val() != "") {
                        return $(x).text() > $(y).text() ? 1 : -1;
                    }
                    //by vishal Mahajan 21-12-2019
                }));
                //$("select#cboTimesheetNewApprover option").attr('selectedIndex', 0);
                $("#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseNewApprover").prop("selectedIndex", 0);
                // $('#tblExpenseApprovers > thead > tr > th > div>input#expenseAppAll').prop('checked', false);

            }

            function TimesheetApproverschkbxclickevent(id) {
                Allchkbxchekedoruncheckd();
            }
            function Allchkbxchekedoruncheckd() {
                var ck_box_cnt = $('#tblbdyTimeshetApprovers input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdyTimeshetApprovers input[type="checkbox"]:checked').length;
                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('#tblTimeshetApprovers > thead > tr > th > div>input#configureAppAll').prop('checked', true);
                } else {
                    $('#tblTimeshetApprovers > thead > tr > th > div>input#configureAppAll').prop('checked', false);
                }
            }
            function btnSetDefaultTimesheetApproverclick() {
                //  $("#setTimesheetDefApprover > div > div > div> div > div>select#cboTimesheetDefaultApprover option[value='"+TimesheetGetDefaultApproverName+"']").prop('selected' , true);
                $("#setTimesheetDefApprover > div > div > div> div > div>select#cboTimesheetDefaultApprover option[value='" + TimesheetGetDefaultApproverName + "']").prop('selected', true);
                $("#setTimesheetDefApprover").modal("show");


            }

            function btncloseTimesheetDefaultApproverclick() {
                $("#setTimesheetDefApprover").modal("hide");
            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ConfigureApprovers%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ConfigureApprovers%>');
                    newpath = newpath.toString().replace("FromWhereProjectId=" + currentFromWhereProjectId, "FromWhereProjectId=" + '<%= Request.QueryString("ProjectID") %>');
                    newpath = newpath.toString().replace("FromWhereData=D", "FromWhereData=C");
                    if (newpath.indexOf("Add#") != -1) {
                        newpath = newpath.toString().replace("Add#", "Edit&update=done");
                    }
                    else if (newpath.indexOf("Edit#") != -1) {
                        newpath = newpath.toString().replace("Edit#", "Edit&update=done");
                    }
                    else if (newpath.indexOf("Edit") != -1) {
                        newpath = newpath.toString().replace("Edit", "Edit&update=done");
                    }

                    opener.window.location.replace(newpath);
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }
            function btnsetTimesheetDefaultApproverclick() {

                var flag = true;
                var EmployeeId = $('#setTimesheetDefApprover > div > div > div> div > div>select#cboTimesheetDefaultApprover option:selected').val();

                //alert(EmployeeId.length);
                if (EmployeeId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Select_Default_Approver") %>';
                    //alertify.error("Select the Default Approver");
                    alertify.error(message);
                    $('#setTimesheetDefApprover > div > div > div> div > div>select#cboTimesheetDefaultApprover').focus();
                    flag = false;
                    return false;
                }

                if (flag == true) {


                    //tblTimeshetApproversCheckBoxChecked();
                    arrApproverIds.push(EmployeeId);
                    // console.log(arrApproverIds);
                    var configureApprovers = {
                        ProjectId: encodeURI(ProjectID),
                        EmployeeId: encodeURI(EmployeeId),
                        ApproverIds: arrApproverIds
                    };
                    // console.log(configureApprovers);

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectSettings/SetDefaultRowWiseApprovers',
                        method: 'Post',
                        data: JSON.stringify(configureApprovers),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            //if (configureApprovers) {
                            //    xhr.setRequestHeader("Params", encryptString(isJson(configureApprovers) ? configureApprovers : JSON.stringify(configureApprovers)));
                            //}
                        },
                        success: function (result) {
                            console.log(result);
                            $("#setTimesheetDefApprover").modal("hide");
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Timesheet_Approver_set_Default_successfully") %>';
                            // alertify.success("Timesheet Approver set Default successfully");
                            alertify.success(message);

                            //GetApproverlst(ProjectID);
                            //GetRowwiseApproversHistory(ProjectID);
                            //GetApproverlst(ProjectID);
                            cboTimesheetRoleOnChange();
                            //Added By Usha Pandit On 06.01.2019 for refresh issue
                            plotExpenseDefaultApproverCombo();
                            GetRowWiseExpenseApproversDetails(ProjectID, 0, 0);
                            //End Of Added By Usha Pandit On 06.01.2019 for refresh issue
                            //$("#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetNewApprover").prop("selectedIndex", 0);
                            //$('#tblTimeshetApprovers > thead > tr > th > div>input#configureAppAll').prop('checked', false);
                            refreshMyParent();
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });

                }

            }
            ////////////////////////////Project Expanse Code //////////////////////////////////////

            function cboExpenseApporoversOnChange() {

                var ApproverId = $('#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseApporovers option:selected').val();
                var RoleId = $('#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseRole option:selected').val();

                if (ApproverId.length == 0 || ApproverId == null) {
                    ApproverId = 0;
                }
                if (RoleId.length == 0 || RoleId == null) {
                    RoleId = 0;
                }
                //alert(RoleId);
                GetRowWiseExpenseApproversDetails(ProjectID, ApproverId, RoleId);
            }

            function cboExpenseRoleOnChange() {
                var ApproverId = $('#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseApporovers option:selected').val();
                var RoleId = $('#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseRole option:selected').val();
                if (ApproverId.length == 0 || ApproverId == null) {
                    ApproverId = 0;
                }
                if (RoleId.length == 0 || RoleId == null) {
                    RoleId = 0;
                }
                GetRowWiseExpenseApproversDetails(ProjectID, ApproverId, RoleId);
            }
            var ExpenseGetDefaultApproverName;
            var arrExpenseApproverIds = [];
            function GetRowWiseExpenseApproversDetails(ProjectId, ReportTo, Role) {
                //var ProjectId = ProjectId;
                //$("#tblExpenseApprovers").dataTable().fnDestroy();
                var configureApprovers = {
                    ProjectId: encodeURI(ProjectId),
                    ReportToId: encodeURI(ReportTo),
                    RoleId: encodeURI(Role),
                };
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetRowWiseExpenseApproversDetails',
                    method: 'Post',
                    data: JSON.stringify(configureApprovers),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (configureApprovers) {
                            xhr.setRequestHeader("Params", encryptString(isJson(configureApprovers) ? configureApprovers : JSON.stringify(configureApprovers)));
                        }
                    },
                    success: function (result) {
                        console.log(result);


                        var RowWiseApprovers = result.RowWiseApprovers;
                        // console.log();
                        $("#tblbdyExpenseApprovers").empty();
                        var strHTML = "";
                        ExpenseGetDefaultApproverName = "";
                        arrExpenseApproverIds = [];
                        if (RowWiseApprovers.length != 0) {

                            for (var i = 0; i < RowWiseApprovers.length; i++) {
                                var EmployeeID = RowWiseApprovers[i]["EmployeeID"];
                                var EmployeeName = RowWiseApprovers[i]["EmployeeName"];
                                var ApproverID = RowWiseApprovers[i]["ApproverID"];
                                var Approver = RowWiseApprovers[i]["Approver"];
                                var OldApprover = RowWiseApprovers[i]["OldApprover"];
                                var RoleDescription = RowWiseApprovers[i]["RoleDescription"];
                                if (Approver == null) {
                                    Approver = "";
                                }
                                strHTML += " <tr>"
                                strHTML += "         <td>" + EmployeeName + "</td>"
                                strHTML += "<td>" + RoleDescription + "</td>"
                                strHTML += "<td>" + Approver + "</td>"
                                if (OldApprover == null) {
                                    strHTML += "         <td></td>"
                                } else {
                                    strHTML += "         <td>" + OldApprover + "</td>"
                                }
                                strHTML += "<td>"
                                strHTML += "             <div class='custom_chckbox'>"
                                strHTML += "<input id='chkEA" + EmployeeID + "' class='chckHead configurechck' type='checkbox' onchange = 'ExpenseApproverschkbxclickevent(this.id)'>"
                                strHTML += " <label for='chkEA" + EmployeeID + "'></label>"
                                strHTML += " </div>"
                                strHTML += "</td>"
                                strHTML += "     </tr>"



                            }
                        } else {
                            strHTML += "<tr> <td colspan='5'  height='5'><center>There are no items to show in this view.</center></td> </tr>";
                        }
                        $("#tblbdyExpenseApprovers").html(strHTML);

                        var GetDefaultApproverName = result.GetDefaultApproverName;

                        for (var i = 0; i < GetDefaultApproverName.length; i++) {
                            ExpenseGetDefaultApproverName = GetDefaultApproverName[i]["EmployeeID"];
                        }

                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        // $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function GetRowwiseExpenseApproversHistory(ProjectId) {

                $("#tblExpenseApproversHistory").dataTable().fnDestroy();
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetExpenseApproversHistory',
                    method: 'Post',
                    data: JSON.stringify(ProjectId),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                        }
                    },
                    success: function (result) {
                        console.log(result);


                        var RowwiseApprovers_History = result.RowwiseApprovers_History;
                        // console.log();

                        $("#tblbdyExpenseApproversHistory").empty();
                        var strHTML = "";
                        for (var i = 0; i < RowwiseApprovers_History.length; i++) {
                            var ResourceName = RowwiseApprovers_History[i]["EmployeeName"];
                            var OldApprover = RowwiseApprovers_History[i]["OldApproverName"];
                            var NewApprover = RowwiseApprovers_History[i]["NewApproverName"];
                            var Createddate = RowwiseApprovers_History[i]["ModifiedDate"];

                            strHTML += " <tr>"
                            strHTML += " <td>" + ResourceName + "</td>"
                            strHTML += " <td>" + OldApprover + "</td>"
                            strHTML += " <td>" + NewApprover + "</td>"
                            strHTML += " <td>" + Createddate + "</td>"
                            strHTML += " </tr>"


                        }

                        $("#tblbdyExpenseApproversHistory").html(strHTML);



                        $("#tblExpenseApproversHistory").DataTable({
                            "scrollY": 'auto',
                            "scrollX": true,
                            "pageLength": 3,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": true,
                            "responsive": true,
                            "retrieve": true


                        });
                        $("#tblExpenseApproversHistory > thead").css('width', '100%');
                        $("#tblExpenseApproversHistory").css('width', '100%');
                        //$("#tblTimesheetHistory ").css('width','100%');
                        if (strHTML == "") {
                            $("#tblExpenseApproversHistory tbody tr td").prop("colspan", 4);
                        }



                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function btnExpenseSetApproverclick() {
                // console.log("All ids");
                var flag = true;
                var EmployeeId = $('#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseNewApprover option:selected').val();
                var ck_box_cnt = $('#tblbdyExpenseApprovers input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdyExpenseApprovers input[type="checkbox"]:checked').length;
                //alert(EmployeeId.length);
                if (EmployeeId.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Select_the_New_Approver") %>';
                    //alertify.error("Select the New Approver");
                    alertify.error(message);
                    $('#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseNewApprover').focus();
                    flag = false;
                    return false;
                }
                if (chk_box_checked_cnt == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Select_Atleast_One_Employee_To_Set_Approver") %>';
                    //alertify.error("Select Atleast One Employee To Set Approver");
                    alertify.error(message);
                    flag = false;
                    return false;
                }
                tblExpenseApproversCheckBoxChecked();
                var empid = parseInt(EmployeeId);
                if (arrExpenseApproverIds.indexOf(empid) != -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_The_Resource_cannot_be_set_as_approver_for_himself") %>';
                    //alertify.error("The Resource cannot be set as approver for himself");
                    alertify.error(message);
                    flag = false;
                    arrExpenseApproverIds = [];
                    return false;

                }
                if (flag == true) {


                    //tblTimeshetApproversCheckBoxChecked();

                    console.log(arrExpenseApproverIds);
                    var configureApprovers = {
                        ProjectId: encodeURI(ProjectID),
                        EmployeeId: encodeURI(EmployeeId),
                        ApproverIds: arrExpenseApproverIds
                    };
                    // console.log(configureApprovers);

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectSettings/InsertRowWiseExpenseApprovers',
                        method: 'Post',
                        data: JSON.stringify(configureApprovers),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            //if (configureApprovers) {
                            //    xhr.setRequestHeader("Params", encryptString(isJson(configureApprovers) ? configureApprovers : JSON.stringify(configureApprovers)));
                            //}
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Expense_Approver_set_successfully") %>';
                            //alertify.success("Expense Approver set successfully");
                            alertify.success(message);
                            GetExpanseApproverlst(ProjectID);
                            GetRowwiseExpenseApproversHistory(ProjectID);
                            // GetExpanseApproverlst(ProjectID);
                            cboExpenseRoleOnChange();
                            $("#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseNewApprover").prop("selectedIndex", 0);
                            $('#tblExpenseApprovers > thead > tr > th > div>input#expenseAppAll').prop('checked', false);
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });

                }
            }

            function tblExpenseApproversCheckBoxChecked() {

                $('#tblbdyExpenseApprovers > tr').each(function (index, value) {

                    var message = "";
                    //var File;
                    //var Date = "";
                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        //console.log(this);

                        if (i == 4) {
                            var id = $(this).find('input[type=checkbox]').attr("id");
                            // console.log(id);


                            if ($(this).find('input[type="checkbox"]').is(':checked')) {
                                //console.log("checked");
                                id = id.replace('chkEA', '');
                                id = parseInt(id);
                                //var search_value = id;
                                if (arrExpenseApproverIds.indexOf(id) == -1) {

                                    arrExpenseApproverIds.push(id);
                                }

                            }
                            //console.log(id);

                        }

                    });
                });
            }

            function GetExpanseApproverlst(ProjectId) {


                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetExpenseApproverlst',
                    method: 'Post',
                    data: JSON.stringify(ProjectId),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                        }
                    },
                    success: function (result) {
                        console.log(result);

                        var strResult = result.Approverlst;
                        $("#cboExpenseApporovers").empty();
                        if (strResult != undefined) {
                            var selHTML = "";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            //selHTML += "<option  value=0 >--Select Category --</option>";
                            selHTML += "<option value=0 > Select Expense Approver </option>";
                            for (var i = 0; i < strResult.length; i++) {

                                var ExpenseApprover = strResult[i]["ExpenseApprover"];
                                var EmployeeName = strResult[i]["EmployeeName"];
                                // var ReportingTo = d.ReportingTo;
                                //var EmployeeName = d.EmployeeName;
                                //var Category = d.Category;
                                selHTML += "<option  value='" + ExpenseApprover + "'  >" + EmployeeName + "</option>";
                            }
                            // StopAjaxLoader("#bodyIssueList");

                            // $("#txtPhaseFilterResponsiblePerson").html(selHTML);
                            $("#main-tab-inner-2 > div.approverfilter-wrap > div > div > div > div>select#cboExpenseApporovers").html(selHTML);


                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });


            }

            function ExpenseApproverschkbxclickevent(id) {
                AlltblEpensechkbxchekedoruncheckd();
            }
            function AlltblEpensechkbxchekedoruncheckd() {
                var ck_box_cnt = $('#tblbdyExpenseApprovers input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#tblbdyExpenseApprovers input[type="checkbox"]:checked').length;
                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('#tblExpenseApprovers > thead > tr > th > div>input#expenseAppAll').prop('checked', true);
                } else {
                    $('#tblExpenseApprovers > thead > tr > th > div>input#expenseAppAll').prop('checked', false);
                }
            }

            function btnSetDefaultExpenseApproverclick() {
                //alert(ExpenseGetDefaultApproverName);
                //console.log(ExpenseGetDefaultApproverName);
                // $("#setExpenseDefApprover > div > div > div > div> div > div>select#cboExpenseDefaultApprover option[value='" + ExpenseGetDefaultApproverName + "']").prop('selected', true);
                $("#setExpenseDefApprover > div > div > div > div> div > div>select#cboExpenseDefaultApprover option[value='" + ExpenseGetDefaultApproverName + "']").prop('selected', true);
                $("#setExpenseDefApprover").modal("show");


            }
            //Added By Usha Pandit On 06.01.2019 for refresh of expense approver
            function plotExpenseDefaultApproverCombo() {


                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/FillExpenseDefaultApproverCombo',

                    method: 'Post',
                    data: JSON.stringify(ProjectID),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                        }
                    },
                    success: function (data) {
                        var objCbo1 = document.getElementById("cboExpenseDefaultApprover");
                        $("#cboExpenseDefaultApprover option").remove();

                        if (data.length != 0) {
                            for (var i = 0; i < data.length; i++) {
                                var ObjExpenseApprove = data[i];

                                var objOption = document.createElement("OPTION");
                                objCbo1.options.add(objOption);

                                objOption.text = ObjExpenseApprove.EmployeeName;
                                objOption.value = ObjExpenseApprove.EmployeeID;
                            }
                        }
                    },
                    error: function (xhr, errorThrown) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    },
                });
            }
            //End Of Added By Usha Pandit On 06.01.2019 for refresh of expense approver
            function btncloseExpenseDefaultApproverclick() {
                $("#setExpenseDefApprover").modal("hide");
            }

            function btnsetExpenseDefaultApproverclick() {

                var flag = true;
                var EmployeeId = $('#setExpenseDefApprover > div > div > div > div> div > div>select#cboExpenseDefaultApprover option:selected').val();

                //alert(EmployeeId);
                if (EmployeeId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Select_Default_Approver") %>';
                    // alertify.error("Select the Default Approver");
                    alertify.error(message);
                    $('#setExpenseDefApprover > div > div > div > div> div > div>select#cboExpenseDefaultApprover').focus();
                    flag = false;
                    return false;
                }

                if (flag == true) {


                    //tblTimeshetApproversCheckBoxChecked();
                    arrExpenseApproverIds.push(EmployeeId);
                    // console.log(arrApproverIds);
                    var configureApprovers = {
                        ProjectId: encodeURI(ProjectID),
                        EmployeeId: encodeURI(EmployeeId),
                        ApproverIds: arrExpenseApproverIds
                    };
                    // console.log(configureApprovers);

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectSettings/setDefaultExpenseApprovers',
                        method: 'Post',
                        data: JSON.stringify(configureApprovers),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            //if (configureApprovers) {
                            //    xhr.setRequestHeader("Params", encryptString(isJson(configureApprovers) ? configureApprovers : JSON.stringify(configureApprovers)));
                            //}
                        },
                        success: function (result) {
                            console.log(result);
                            $("#setExpenseDefApprover").modal("hide");
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Expense_Approver_set_Default_successfully") %>';
                            //alertify.success("Expense Approver set Default successfully");
                            alertify.success(message);

                            //GetApproverlst(ProjectID);
                            //GetRowwiseApproversHistory(ProjectID);
                            //GetApproverlst(ProjectID);
                            cboExpenseRoleOnChange();
                            //$("#main-tab-inner-1 > div.approverfilter-wrap > div > div > div > div>select#cboTimesheetNewApprover").prop("selectedIndex", 0);
                            //$('#tblTimeshetApprovers > thead > tr > th > div>input#configureAppAll').prop('checked', false);
                            refreshMyParent();
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });

                }

            }


            //Added By Omkar P On 15.01.2020 For showing current project name
            function getProjectName(ProjectId) {
               // var ProjectId = ProjectId;
               
                var Parameter = { ProjectId: ProjectId }


                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                    method: 'Post',
                    data: JSON.stringify(Parameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Parameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                        }
                    },
                    success: function (result) {
                        //console.log(result);
                        $(".spnProjectName").text(result);

                    },
                    error: function (err) {
                        alert(err.responseText);

                        //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
            //End Of Added By Omkar P On 15.01.2020 For showing current project name
        </script>
    </div>
</body>

</html>
