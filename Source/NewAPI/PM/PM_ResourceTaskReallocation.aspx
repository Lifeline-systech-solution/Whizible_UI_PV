<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ResourceTaskReallocation.aspx.vb" Inherits="PbNIT.PM_ResourceTaskReallocation" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Resource Reallocation")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource Reallocation</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">   
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>    
</head>
    
    <style type="text/css">

        .hidden-content {
            display: none;
        }
       
        .detailsubtabs {
            height: auto;
            width: 100%;
        }
        .Resourcedetailpanel {   
            min-height: 1px;
        }
        .red-background {
            background-color: red !important;
        }
        .light-red-background {
            background-color: #FFC0CB !important;  
        }
        .profile-pic {
            width: 25px;
            line-height: 25px;
            height: 25px;
            border: 1px solid #ddd;
            border-radius: 50%;
            background: #eee;
            position: relative;
        }
        .profile-pic1 {
            width: 25px;
            line-height: 25px;
            height: 25px;
            border: 1px solid #ddd;
            border-radius: 50%;
            background: #eee;
            position: relative;
        }
        .noteSec {
            position: static;       
        }
        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);           
        }
        .dataTables_scrollBody {
            margin-bottom: 10px;
        }
        table tr th,
        table tr td {
            text-align: center;
        }
        table tr th:last-child,
        table tr td:last-child {
            text-align: center;           
        }
        .dataTables_scrollHeadInner,
        .dataTables_scrollHeadInner table {
            width: 100% !important;
        }
        .dataTables_scrollHeadInner {
            width: 100% !important;
        }
        div.dataTables_scrollBody>table {
            width: 100% !important;
        }
        .custom_chckbox label:before {
            margin-right: 10px;
        }
        .dataTables_paginate {           
            float: none;
            text-align: right;
        }
        /* ---------------------------- */
        .offcanvas {
            --bs-offcanvas-width: 85%;
        }
        .tab-content {
            padding: 10px;
        }
        .edit-row td.toolactionsTD,
        .edit-row.edit_row_open td {
            pointer-events: auto;
        }
        .edit-row.edit_row_open .no-edit {
            border: 1px solid #ddd;           
            background: #ffffff;
        }
        table.dataTable thead > tr > th.sorting::before, table.dataTable thead > tr > th.sorting::after, table.dataTable thead > tr > th.sorting_asc::before, table.dataTable thead > tr > th.sorting_asc::after, table.dataTable thead > tr > th.sorting_desc::before, table.dataTable thead > tr > th.sorting_desc::after, table.dataTable thead > tr > th.sorting_asc_disabled::before, table.dataTable thead > tr > th.sorting_asc_disabled::after, table.dataTable thead > tr > th.sorting_desc_disabled::before, table.dataTable thead > tr > th.sorting_desc_disabled::after, table.dataTable thead > tr > td.sorting::before, table.dataTable thead > tr > td.sorting::after, table.dataTable thead > tr > td.sorting_asc::before, table.dataTable thead > tr > td.sorting_asc::after, table.dataTable thead > tr > td.sorting_desc::before, table.dataTable thead > tr > td.sorting_desc::after, table.dataTable thead > tr > td.sorting_asc_disabled::before, table.dataTable thead > tr > td.sorting_asc_disabled::after, table.dataTable thead > tr > td.sorting_desc_disabled::before, table.dataTable thead > tr > td.sorting_desc_disabled::after {
            display: none;
            cursor: none;
        }
        .text-center {
            text-align: center;
        }
        .no-border td {
            color:aqua;
        }
        .switch input {
            display: none
        }
        .nextBtnDiv {
            padding-top: 15px;
        }
        .NOI_MainHeader {
            padding-top: 15px;
        }        
        .switch {
            display: inline-block;
            width: 55px;
            height: 25px;
            margin-top: -12px;
            transform: translateY(50%);
            position: relative
        }   
        .slider {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            border-radius: 30px;
            border: 1px solid #ddd;
            cursor: pointer;
            border: 4px solid transparent;
            overflow: hidden;
            transition: .4s;
            background: #ddd
        }
        .slider:before {
            position: absolute;
            content: "";
            width: 100%;
            height: 100%;
            background: #fff;
            border-radius: 30px;
            transform: translateX(-30px);
            transition: .4s
        }
        input:checked+.slider:before {
            transform: translateX(30px);
            background: #fff
        }
        input:checked+.slider {
            border: 4px solid #4263c1;
            background: #4263c1
        }
        .switch.flat .slider {
            box-shadow: none
        }
        .switch.flat .slider:before {
            background: #FFF
        }
        .switch.flat input:checked+.slider:before {
            background: white
        }
        .switch.flat input:checked+.slider {
            background: limeGreen
        }        
        .borderbox {
            border: 1px solid #ddd;
            background: #f5f5f5;
            padding: 20px;
        }
        .text-truncate{
            overflow:visible;
        }       
        .red-text {
            color: red;
        }        
        .offcanvas-body{
            overflow-x:hidden;

        }
        /*Added for reflection of note on 02/11/2023*/
        .text_size {            font-size: 11px !important;            color: red;        }        .progressNote1{            height: max-content;        }        .progressNote2{            height: max-content;        }        .progress-bar-container {            width: 100%;             position: relative;            border-radius: 4px;            overflow: hidden;        }        .progress-bar {            background-color: #e7edf0 !important;            height: max-content;            width: max-content;            border-radius: 5px;            color: #FFF;            font-weight: 600;            border: 1px solid #ddd;        }        .progress-text {            line-height: 1.3;            width: 76vw;            margin: auto;            display: flex;            white-space: normal;        }        .progress-bar-inner {            display: block;            height: 100%;            width: 0%;            background-color: #f8ff94eb;            border-radius: 3px;            box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset;            position: relative;            animation: auto-progress 20s infinite linear;        }
        .text_bg {
        color: #4263c1;
        font-size: 11px !important;
        }

        .offcanvas {
        --bs-offcanvas-width: 80% !important;
        }
        </style>

<body class="hold-transition bgwhite sidebar-mini fixed" id="ResReall_mainbody">
     <%If m_blnEditAccess = True Or m_blnViewAccess = True Then%>
    <div class="bgwhite">
        <div class="container-fluid py-2 text-end graybg d-flex justify-content-between">
            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ResourceTaskReallocation") %></h5>
        </div>

        <div class="content">
            <!-- Main Section starts -->
            <div class="TaskSelectionSec">
                <div class="">
                    <div class="row">
                        <div class="col-sm-3">                          
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "onchange='PlotProjectonChange();' class='form-control selectpicker' data-live-search='true'",,,) %>
                        </div>
                        <div class="col-sm-3">                           
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceName", "usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_ActiveResourcesOnProject " & Session("intProjectID"),,, "onchange='BindSelectedResource();' class='form-control selectpicker' data-live-search='true'",,,) %>
                        </div>                        
                        <div class="col-sm-6">
                            <div class="form-group float-end">
                                <label class="switch">
                                    <input onclick ="GetActiveResourceList();" type="checkbox" >
                                    <span class="slider"></span>
                                </label> <%=MyBase.GetResourceString("C_OpenVoidTasks") %>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="container-fluid py-1 mb-2">                    
                    <p class="mb-0 d-flex justify-content-between">
                        <span>
                            <i class="far fa-sticky-note me-2"></i>
                            <small ><%=MyBase.GetResourceString("C_Note2") %></small>
                        </span>
                        <span class="ms-auto">
                            <i class="far fa-sticky-note me-2"></i>
                            <small class="red-text"><%=MyBase.GetResourceString("C_Note1") %></small>
                        </span>
                    </p>
                </div>
                <table id="tblResourceTable" class="table table-stripped table-bordered resourcesTable"
                    style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="col-sm-4"><%=MyBase.GetResourceString("C_ResourceName")%></th>
                            <th class="col-sm-4"><%=MyBase.GetResourceString("C_Role")%></th>
                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_NoOfTasksOpenVoid")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_Select")%></th>
                        </tr>
                    </thead>
                    <tbody id="tblResourceList">                     
                    </tbody>
                </table>

            </div>
            <!-- Main Section ends -->

            <!-- 1st Section starts -->
            <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
                id="offcanvasResScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
                <div class="offcanvas-body">
                    <div class="TaskSelectionSec">
                        <div class="py-1">                           
                            <div class="container-fluid py-2 graybg mb-2">
                                <div class="row align-items-center">
                                    <div class="col-sm-4">
                                        <div class="font-weight-600"><%=MyBase.GetResourceString("C_Step1") %></div>
                                    </div>
                                    <div class="col-sm-8">
                                        <div class="ResourceInfo d-flex justify-content-end align-items-center">
                                            <span><%=MyBase.GetResourceString("C_Resource") %></span>                                          
                                            <img class="profile-pic resImgSmall mx-1" src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" title="" />
                                                        <input hidden class="file-upload" type="file" accept=".png, .jpg, .jpeg"  /><i  hidden class="fas fa-camera openupload"> </i> 
                                                        <input hidden id="hiddenProfilePath0">
                                            <span id="txtResourceInfo"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <p class="mb-0"><i class="far fa-sticky-note me-2"></i><small><%=MyBase.GetResourceString("C_Note3") %></small></p>
                                </div>
                                <div class="col-sm-6">
                                    <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                        <input id="txtEmployeeID" hidden>
                                        <a href="javascript:;" class="btn borderbtn nextBtn" id="NextResBtn1"
                                            onclick="NextResdetail();"><%=MyBase.GetResourceString("C_Next")%></a>
                                            <button class="btn borderbtn" type="button" data-bs-dismiss="offcanvas"
                                                        aria-label="Close" id="txtClose" onclick="RefreshGrid();"><%=MyBase.GetResourceString("C_Close") %></button>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="TasksSelectionSec">
                            <table id="TasksSelectionTable" class="table table-stripped table-bordered resourcesTable "
                            style="width: 100%;">
                                <thead>
                                    <tr>                                                                    
                                        <th class="col-sm-3"><%=MyBase.GetResourceString("C_TaskName")%></th>
                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_StartDate")%></th>
                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_EndDate")%></th>
                                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_WorkHours")%></th>
                                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_ActualWorkHours")%></th>
                                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_RemainingWorkHours")%></th>                                   
                                        <th class="col-sm-1">
                                            <div class="custom_chckbox">
                                                <input id="resCheck0" class="chckHead" type="checkbox" />
                                                <label for="resCheck0"></label>
                                            </div>
                                        </th>                                   
                                    </tr>
                                </thead>
                                <tbody id="TasksSelectionList">
                              
                                </tbody>
                            </table>
                            <div class="clearfix"></div>
                        </div>                        
                        <div class="clearfix"></div>                     
                        </div>
                        <div class="noteAnimated mt-2">                            <div class="progress-bar-container">                              <div class="progress-bar animated slower progressNote1">                                <div class="progress-bar-inner px-2">                                    <div class="progress-text text_bg text-start pt-2">                                        <span class="font-weight-600"><%=MyBase.GetResourceString("C_Note") %></span> <%=MyBase.GetResourceString("C_Note4") %> <br> <%=MyBase.GetResourceString("C_Note5") %> <br> <%=MyBase.GetResourceString("C_Note6") %> 
                                <br> <%=MyBase.GetResourceString("C_Note7") %>                                        <%--<span class="text_size me-2">Note:</span>                                         <span>                                            1. Mpp Tasks are not reallocated through this screen. To reallocate them you have to edit the MSP Plan. <br>                                             2. Tasks with actual work greater than or equal to planned work cannot be reallocated. Please mark them complete.                                             In case for enabling reallocation, please increase the planned work for those tasks.                                        </span>--%>                                    </div>                                </div>                              </div>                            </div>                        </div>

                        <%--<div class="noteSec py-1 graybg my-2">
                            <div class="noteContent px-2"><span class="font-weight-600"><%=MyBase.GetResourceString("C_Note") %></span> <%=MyBase.GetResourceString("C_Note4") %> <br> <%=MyBase.GetResourceString("C_Note5") %> <br> <%=MyBase.GetResourceString("C_Note6") %> 
                                <br> <%=MyBase.GetResourceString("C_Note7") %>
                            </div>                            
                        </div>--%>

                    <div class="Resourcedetailpanel">
                        <div class="pgdetailinner p-0">
                            <ul class="nav nav-tabs detailsubtabs">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#prositedetailTab1" data-bs-toggle="tab"
                                        id=""><%=MyBase.GetResourceString("C_AssignResource") %></a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="prositedetailTab1" class="tab-pane active pt-0">
                                    <!-- 2nd Section starts -->
                                    <div class="ResAllctnContent AllocateResourceSec">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="NOI_MainHeader">
                                                    <span class="font-weight-600"><%=MyBase.GetResourceString("C_Step2") %>&nbsp;</span>
                                                    <!-- <i class="fas fa-chevron-left pe-2"></i> -->
                                                    <span class="projInnerTitle active"><%=MyBase.GetResourceString("C_SelectResource") %></span>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                                    <a href="javascript:;" class="btn borderbtn nextBtn"
                                                        id="NextResBtn2"><%=MyBase.GetResourceString("C_Next") %></a>
                                                    <a href="javascript:;" class="btn borderbtn canceldetailpanel"
                                                        id="CancelBtn"><%=MyBase.GetResourceString("C_Cancel") %></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <p class="mb-0"><i
                                                        class="far fa-sticky-note me-2"></i><small ><%=MyBase.GetResourceString("C_Note8") %></small>
                                                </p>                                                
                                            </div> 
                                        </div>
                                              
                                        <div class="row mt-2">
                                            <div class="col-sm-6">
                                                <div class="borderbox">
                                                    <div class="form-inline">
                                                        <div class="row form-group">
                                                            <label class="col-sm-5 control-label text-end required"><%=MyBase.GetResourceString("C_SelectResource") %></label>
                                                            <div class="col-sm-7">
                                                                <select class="selectpicker" aria-label="Select Resource" data-live-search="true" id="selectResource">                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                         <div class="row mt-2">
                                            <div class="col-sm-12">
                                                <p class="mb-0" id="txtvalidation"><i
                                                        class="far fa-sticky-note me-2"></i><small class="red-text" >Selected tasks start date and end date are not between resource start date and end date on project.</small>
                                                </p>
                                            </div>
                                        </div>
                                        </div>
                                        
                                    </div>
                                    <!-- 2nd Section ends -->

                                    <!-- 3rd Section starts -->
                                    <div class="ResAllctnContent ResourceAllocationSec d-none">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="NOI_MainHeader">
                                                    <span class="font-weight-600"><%=MyBase.GetResourceString("C_Step3") %> &nbsp;</span>                                                  
                                                    <span class="projInnerTitle"><%=MyBase.GetResourceString("C_SelectResource") %></span>                                                    
                                                    <i class="fas fa-arrow-right rightTabArrow px-1"></i>
                                                    <span class="projInnerTitle active"><%=MyBase.GetResourceString("C_AssignedTask") %></span>
                                                </div>                                               
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                                    <a href="javascript:;" class="btn borderbtn backBtn"
                                                        id="BackResBtn2"><%=MyBase.GetResourceString("C_Back") %></a>
                                                    <a href="javascript:;" class="btn borderbtn assignBtn"
                                                        id="NextResBtn3" onclick="AssignAllSelectedTasks();"><%=MyBase.GetResourceString("C_Assign") %></a>
                                                    <a href="javascript:;" class="btn borderbtn canceldetailpanel"
                                                        id="CancelBtn1"><%=MyBase.GetResourceString("C_Cancel") %></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        <div class="row mt-2">
                                            <div class="col-sm-12">
                                                <p class="mb-0"><i
                                                        class="far fa-sticky-note me-2"></i><small><%=MyBase.GetResourceString("C_FollowingTasksOf") %>                                                       
                                                        <img class="profile-pic resImgSmall mx-1" src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" title="" />
                                                        <input hidden class="file-upload" type="file" accept=".png, .jpg, .jpeg"  /><i  hidden class="fas fa-camera openupload"> </i> <%--accept="image/*"--%>
                                                        <input hidden id="hiddenProfilePath"><span class="font-weight-600" id="txtResourcrName"></span> <%=MyBase.GetResourceString("C_WillBeAssignedTo") %><img class="profile-pic1 resImgSmall mx-1" src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" title="" />
                                                        <input hidden class="file-upload" type="file" accept=".png, .jpg, .jpeg"  /><i hidden class="fas fa-camera openupload"> </i> <%--accept="image/*"--%>
                                                        <input hidden id="hiddenProfilePath1"><span class="font-weight-600" id="txtAssResource"></span></small>                                                
                                                </p>
                                            </div>                                           
                                        </div>
                                        <table id="ResourceReallocationTable"
                                            class="table table-stripped table-bordered mt-2" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_TaskName")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_StartDate")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_EndDate")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Work")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Edit")%></th>
                                                </tr>
                                            </thead>
                                            <tbody id="ResourceReallocationList">

                                            </tbody>
                                        </table>
                                        <div class="noteAnimated mt-2">
                                            <div class="progress-bar-container">
                                              <div class="progress-bar animated slower progressNote2">
                                                <div class="progress-bar-inner p-2">
                                                    <div class="progress-text text_bg text-start">
                                                        <span class="font-weight-600">Note:</span>                                                
                                               <%=MyBase.GetResourceString("C_Note9") %>
                                                        <%--<span class="text_size me-2">Note:</span> 
                                                        <span>Task in red will not be reallocated as task start date end end date are not between resource start date and end date on project.</span>--%>
                                                    </div>
                                                </div>
                                              </div>
                                            </div>
                                        </div>
                                        <%--<div class="noteSec py-1 graybg mb-2">
                                            <div class="noteContent px-2" id="txtTaskInRed"><span class="font-weight-600">Note:</span>                                                
                                               <%=MyBase.GetResourceString("C_Note9") %>  
                                            </div>
                                        </div>--%>
                                    </div>
                                    <!-- 3rd Section ends -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 1st Section ends -->      
        </div>   
        <div class="clearfix"></div>        
        <!-- modal pop up for Resource Confirmation starts here -->
        <div id="confirmTasksModal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall">               
                <div class="modal-content">
                    <div class="modal-header">                   
                        <h4 class="modal-title" style="text-align: center;"><%=MyBase.GetResourceString("C_Confirm") %></h4>
                    </div>
                    <div class="modal-body" > 
                        <span id="txtDrp1" class="modal1"></span><br /><br />
                        <span id="txtDrp2" class="modal2"></span><br />
                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="ConfirmTasks()"><%=MyBase.GetResourceString("C_Ok") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right" onclick="NextResdetail()" style="float: right" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel") %></button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- modal pop up for Resource Confirmation ends here -->
        <!-- modal pop up for Holiday Confirmation starts here -->
        <div id="confirmHolidayModal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall">  <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">                   
                        <h4 class="modal-title" style="text-align: center;"><%=MyBase.GetResourceString("C_Confirm") %></h4>
                    </div>
                    <div class="modal-body" >                        
                       <span id="txtHoliday1" class="modalHoliday1"></span><br/>
                        <span id="txtHoliday2" class="modalHoliday2"></span><br />
                        <span id="txtHoliday3" class="modalHoliday3"></span><br /> 
                        <input id="txtHoliday4" class="modalHoliday4" hidden>
                        <input id="txtHoliday5" class="modalHoliday5" hidden>
                        <input id="txtHoliday6" class="modalHoliday6" hidden>                        
                        <input id="txtHoliday7" class="modalHoliday7" hidden>
                        <input id="txtHoliday8" class="modalHoliday8" hidden>
                        <input id="txtHoliday9" class="modalHoliday9" hidden>
                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <button class="btn borderbtn ml-1 md1" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Ok") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right md2" style="float: right" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel") %></button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
         <!-- modal pop up for Holiday Confirmation ends here -->
        <!-- modal pop up for OU Hours Confirmation starts here -->
        <div id="confirmOUhoursModal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall">
                <div class="modal-content">
                    <div class="modal-header">                   
                        <h4 class="modal-title" style="text-align: center;"><%=MyBase.GetResourceString("C_Confirm") %></h4>
                    </div>
                    <div class="modal-body" >                        
                         <span id="txtOUhours1" class="modalOUhours1"></span><br/>
                         <span id="txtOUhours2" class="modalOUhours2"></span><br />
                         <span id="txtOUhours3" class="modalOUhours3"></span><br /> 
                         <input id="txtOUhours4" class="modalOUhours4" hidden>
                         <input id="txtOUhours5" class="modalOUhours5" hidden>
                         <input id="txtOUhours6" class="modalOUhours6" hidden>
                         <input id="txtOUhours7" class="modalOUhours7" hidden>
                         <input id="txtOUhours8" class="modalOUhours8" hidden>
                         <input id="txtOUhours9" class="modalOUhours9" hidden>                         
                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <button class="btn borderbtn ml-1 md3" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Ok") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right md4" style="float: right" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel") %></button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
         <!-- modal pop up for OU Hours Confirmation ends here -->
    </div>

     <%Else %>
          <div id="ViewAccess" class="tab-pane" style="height: 448px">
             <div style="text-align: center">
                   <p style="margin-top: 136px;font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %> </p>
              </div>
          </div>
     <%End If %>

    <div class="clearfix"></div>

     <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>   
    <script src="../../../Whizible2.0-new/dist/js/jquery.calendar.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>  
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script> 
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
     <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>   --%>                   
    <script src="../../../Whizible2.0-new/dist/js/common_filters.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../../Whizible2.0-new/dist/js/calendar-gc.min.js"></script>

    <script>
        var SessionProjectID = '<%= Session("intProjectID") %>';        
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get default project on project dropdown
        */
        window.onload = function GetSessionProject(changeProjectID) {
               
            if (SessionProjectID.length) {
                $("#cboProject").val(SessionProjectID);
                $("#cboProject").trigger("change");
                $('#tabActive').css('tab-slider-trigger,.active');
                $(".selectpicker").selectpicker('refresh');                
            }            
            else {
            }
        }      

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To get Resource List and Task List as per selected Project 
        */
        function PlotProjectonChange() {
           
            var ProjectID = $("#cboProject").val();
            GetResourcesList(ProjectID);
            GetActiveResourceList(ProjectID);
        }

        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip()
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $("#rolerateTbl_wrapper .dataTables_scrollBody").css({ height: tblheight - 232, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
        $(document).ready(function () {
            $("#NextResBtn2").click(function () {                
                var selectResource = $("#selectResource");
                var resAllctnContent = $(".ResAllctnContent");
                var resourceAllocationSec = $(".ResourceAllocationSec");
                if (selectResource.val() == 0 || selectResource.val() == undefined) {
                    //alert("Please select at least one resource to whom selected tasks to be reallocated");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<%=MyBase.GetResourceString("A_SelectedTasksToBeReassigned")%>");                    
                    selectResource.focus();
                } else if (validateCheckbox() === true) {                    
                   
                    $(".profile-pic").attr("src", "");
                    $(".profile-pic1").attr("src", "");
                    getResourceProfileFrom();                        
                    getResourceProfileTo();
                    resAllctnContent.hide();
                    resourceAllocationSec.removeClass('d-none').fadeIn();
                    var tasksTobeUpdated = [];
                    var result = validateStartDateEndDate();
                    var alertifyMsg = result.msg;
                    tasksTobeUpdated = result.tasksWithinRange;                    
                    if (tasksTobeUpdated.length != 0) {                        
                        $("#confirmTasksModal").modal("show"); 
                        $('.modal1').text(alertifyMsg);
                        $('.modal2').text("<%=MyBase.GetResourceString("C_ContinueTasks")%>"); 
                    }
                    else {
                        $(".offcanvas-body").animate(
                            {
                                scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                            },
                            "slow"
                        );
                        GetSelectedTaskList();                        
                    }
                }
                
            });
            $("#BackResBtn2").click(function () {
                $(".ResAllctnContent").hide();
                $(".AllocateResourceSec").removeClass('d-none').fadeIn();
            });           
            if (ViewAccess != 'False') {               
                GetResourcesList(SessionProjectID);
                GetActiveResourceList(SessionProjectID);
            }
        });
        /*
        Created By : Vishal Mane
        Created Date : 31/10/2023
        Purpose : To confirm Task List from modal pou-up
        */
        function ConfirmTasks() {
            var tasksTobeUpdated = [];
            var result = validateStartDateEndDate();
            var alertifyMsg = result.msg;
            tasksTobeUpdated = result.tasksWithinRange;
            GetSelectedTaskList();
            if (tasksTobeUpdated.length != 0) {
                for (var i = 0; i < tasksTobeUpdated.length; i++) {
                    var taskID = tasksTobeUpdated[i];
                    if (taskID != undefined) {
                        var row = $('#txtselectedStartDate' + taskID);
                        row.addClass('light-red-background');
                    }
                }
            }
        }
        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To Refresh Resources Task List
        */
        function RefreshGrid() {                    
            GetResourcesList(SessionProjectID);
            GetActiveResourceList(SessionProjectID);
            $(".profile-pic").attr("src", "");
        }

        /*
        Created By : Vishal Mane
        Created Date : 18/10/2023
        Purpose : To select and unselect all tasks when main checkbox is clicked
        */
        function selectAllRows() {            
            $(".task-checkbox1").prop("checked", true);
        }
        function unselectAllRows() {
            $(".task-checkbox1").prop("checked", false);
        }       
        $(".chckHead").change(function () {
            
            var checked = $(this).is(":checked");
            if (checked) {
                selectAllRows();
            } else {
                unselectAllRows();
            }
        });
        $('.task-checkbox1').click(function () {
          
            var checked = $(".chckHead").is(":checked");
            if (checked) {
                $(".chckHead").prop("checked", false);
            }
        });
        //Detailpanel Script start from here
        function NextResdetail() {
            
            //$(".Resourcedetailpanel").hide();
            //$("table tr").removeClass("rowhiglight");
            //$(".Resourcedetailpanel").hide();
            //$(".ResourceAllocationSec").hide();
            //$(".AllocateResourceSec").show();
            //$("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, #rolerateTbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            //$(".table").resize();
            if (validateCheckbox() === true) {
                $(".Resourcedetailpanel").show();
                //$(".offcanvas-body").animate(
                //    {
                //        scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                //    },
                //    "slow"
                //);                
                $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                $(".table").resize();
                BindResourcesExceptCurrentEmployee();
            } else {
                event.preventDefault();
                return;
            }
            $("#txtvalidation").hide();
        }
        $(".BGdetalilink").click(function () {
            $(this).closest("tr").addClass("rowhiglight");
        });
        $(".canceldetailpanel").click(function () {
            $("table tr").removeClass("rowhiglight");
            $(".Resourcedetailpanel").hide();
            $(".ResourceAllocationSec").hide();
            $(".AllocateResourceSec").show();
            $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, #rolerateTbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
        });
        $(".collapse").on("show.bs.collapse", function (e) {
            $(".table").resize();
        });
        $(".collapse").on("hidden.bs.collapse", function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on("shown.bs.tab", function (e) {
            $(".table").resize();
        });
        $(".assignrow").hide();

        //Start end add edit delete
        $(document).on("click", ".saverow", function () {
            var empty = false;
            var input = $(this).parents("tr").find('input[type="text"]');
            var select = $(this).parents("tr").find('select');
            // var textarea = $(this).parents("tr").find('textarea');
            input.each(function () {
                if (!$(this).val()) {
                    $(this).addClass("error");
                    empty = true;
                } else {
                    $(this).removeClass("error");
                }
            });

            $(this).parents("tr").find(".error").first().focus();
            if (!empty) {
                input.each(function () {
                    $(this).parent("td").html($(this).val());
                });               
                $(this).parents("tr").find(".saverow, .edit").toggle();
                $(this).parents("tr").find(".cancelval, .chckbox-hide").toggle();               
            }
        });
        //Delete row value
        $(document).on("click", ".delete", function () {
            $(this).tooltip('hide');
            $(this).closest('tr').remove();
        });
        //Cancel row value
        $(document).on("click", ".cancelval ", function () {
            var empty = false;
            var input = $(this).parents("tr").find('input[type="text"]');
            var select = $(this).parents("tr").find('select');

            input.each(function () {
                $(this).parent("td").html($(this).val());
                $(this).parent("td").html();
            });
            select.each(function () {
                $(this).parent("td").html($(this).val());
            });
            $(this).parents("tr").find(".saverow").toggle();
            $(this).parents("tr").find(".chckbox-hide, .cancelval").toggle();
        });
        /*$(".edit").show();*/
        //end add edit delete
        $('#offcanvasResScreen').on('hidden.bs.offcanvas', function () {
            // Uncheck the checkbox when the offcanvas is closed
            $('.chcktask').prop('checked', false);
        });

        /*
        Created By : Vishal Mane
        Created Date : 04/10/2023
        Purpose : To get list of active resources for selected project to bind Resource dropdown
        */
        function GetResourcesList(ProjectID) {
           
            var strHTML = "";
            $("#cboResourceName").html("");
            var parameter={
                ProjectID: ProjectID
            }
            var param = JSON.stringify(parameter)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetResourcesList", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var listComponent = strResult[i];
                strHTML += '<option value=' + listComponent.ID + ' >' + listComponent.ResourceName + '</option>';
            }
            $("#cboResourceName").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }
        $(document).on('change', '.cbochange', function () {
            BindSelectedResource();
        });

        /*
        Created By : Vishal Mane
        Created Date : 10/10/2023
        Purpose : To bind selected resource with total count of Assigned or void tasks against each resource
        */
        function BindSelectedResource() {            
            var strHTML = "";
            var OpenOrVoidFlag = 1;
            if ($('.switch input[type="checkbox"]').is(':checked')) {
                OpenOrVoidFlag = 0;
            }
            $("#tblResourceTable").dataTable().fnDestroy();
            StartLoader("#ResReall_mainbody");
            var ProjectID = $("#cboProject").val();
            var ResourceID = $("#cboResourceName").val();
            if (ResourceID != null && ResourceID != undefined && ResourceID != 0) {               
                var ResourceDetails = {
                    ResourceID: encodeURI(ResourceID),
                    ProjectID: encodeURI(ProjectID),
                    OpenOrVoidFlag: encodeURI(OpenOrVoidFlag),
                }
                var param = JSON.stringify(ResourceDetails)
                var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/BindSelectedResource", param, false);
                if (strResult.length != 0) {                   
                    $.each(strResult, function (index, obj) {
                        strHTML += '<tr><td class="text-centre">' + obj.EmployeeName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.RoleDescription + '</td>';
                        strHTML += '<td class="text-centre">' + obj.Total_No_of_Tasks_Open_Void + '</td>';
                        strHTML += '<td <div class="custom_chckbox task-checkbox" type="checkbox"><input id="' + index + '" onclick="GetSelectedResourcesTasks(' + obj.EmployeeID + ',' + ProjectID + ');" class="chcktask" type="checkbox" data-bs-toggle="offcanvas" data-bs-target="#offcanvasResScreen" aria-controls="offcanvasWithBothOptions" ><label for="' + index + '"></label></div></td></tr > ';
                    });
                }
                $("#tblResourceList").html(strHTML);
                $('#tblResourceTable').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": true,
                    "responsive": true,
                    "destroy": true,
                    "bFilter": false,
                    "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0, 1, 2, 3] }]
                });
                StopAjaxLoader("#ResReall_mainbody");

            } else {
                GetActiveResourceList();
            }

        }
        /*
        Created By : Vishal Mane
        Created Date : 04/10/2023
        Purpose : To get list of active resources with total count of Assigned or void tasks against each resource
        */
        function GetActiveResourceList() {
           
            var EmployeeID = $("#cboResourceName").val();
            var ProjectID = $("#cboProject").val();
            if (EmployeeID == 0) {
                var strHTML = "";
                $("#tblResourceTable").dataTable().fnDestroy();
                StartLoader("#ResReall_mainbody");
                var OpenOrVoidFlag = 1;
                if ($('.switch input[type="checkbox"]').is(':checked')) {
                    OpenOrVoidFlag = 0;
                }
                var ResourceDetails = {
                    ProjectID: encodeURI(ProjectID),
                    OpenOrVoidFlag: encodeURI(OpenOrVoidFlag),
                }
                var param = JSON.stringify(ResourceDetails)
                var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetActiveResourceList", param, false);
                if (strResult.length != 0) {
                  
                    $.each(strResult, function (index, obj) {
                        strHTML += '<tr><td class="text-centre">' + obj.EmployeeName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.RoleDescription + '</td>';
                        strHTML += '<td class="text-centre">' + obj.Total_No_of_Tasks_Open_Void + '</td>';
                        strHTML += '<td <div class="custom_chckbox task-checkbox" type="checkbox"><input id="' + index + '" onclick="GetSelectedResourcesTasks(' + obj.EmployeeID + ',' + ProjectID + ');" class="chcktask" type="checkbox" data-bs-toggle="offcanvas" data-bs-target="#offcanvasResScreen" aria-controls="offcanvasWithBothOptions" ><label for="' + index + '"></label></div></td></tr > ';
                    });
                }
                $("#tblResourceList").html(strHTML);
                $('#tblResourceTable').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": true,
                    "responsive": true,
                    "destroy": true,
                    "bFilter": false,
                    "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [0, 1, 2, 3] }]
                });
                StopAjaxLoader("#ResReall_mainbody");
            } else {
                BindSelectedResource();
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 04/10/2023
        Purpose : To get the list of open or void tasks of selected resource.
        */
        var intAsssignAllFlag = 0;
        function GetSelectedResourcesTasks(ResourceID, ProjectID) {           
                       
            $("#offcanvasResScreen").show();
            $(".offcanvas-backdrop").show();
            $("#resCheck0").prop("checked", false);
            $("#txtEmployeeID").text(ResourceID);
            $("#TasksSelectionTable").dataTable().fnDestroy();
            StartLoader("#bodyResourceReallocationDetails");
            var OpenOrVoidFlag = 1;
            if ($('.switch input[type="checkbox"]').is(':checked')) {
                OpenOrVoidFlag = 0;
            }
            var ResourceTaskDetails = {
                ProjectID: encodeURI(ProjectID),
                ResourceID: encodeURI(ResourceID),
                OpenOrVoidFlag: encodeURI(OpenOrVoidFlag),
            }
            var param = JSON.stringify(ResourceTaskDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetSelectedResourceTasksList", param, false);
            if (strResult.length != 0) {                
                $("#txtResourceInfo").text(strResult[0].ResourceDetail);
                var groupedData = {
                    'Assigned Tasks': [],
                    'Assigned Issues': [],
                    'Void Tasks': []
                };
                strResult.forEach(function (obj) {
                    groupedData[obj.TaskType].push(obj);
                });
                var strHTML = '';               
                if (groupedData['Assigned Tasks'].length > 0) {                   
                    strHTML += '<tr><td class="no-border" style="font-weight: bold;">Assigned Tasks</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>';
                    groupedData['Assigned Tasks'].forEach(function (obj, index) {                        
                            strHTML += '<tr><td class="text-centre">' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                                '<td class="text-centre">' + obj.StartDate +'<input hidden id="txtStartDate' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.StartDate + '"></td>' +
                                '<td class="text-centre">' + obj.EndDate +'<input hidden id="txtEndDate' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.EndDate + '"></td>' +
                                '<td class="text-centre">' + obj.WorkHHMM +'<input hidden id="txtWorkHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.WorkHHMM + '"></td>' +
                                '<td class="text-centre">' + obj.ActualWorkHHMM +'<input hidden id="txtActualWorkHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.ActualWorkHHMM + '"></td>' +
                                '<td class="text-centre">' + obj.RemainingWorkHoursHHMM +'<input hidden id="txtRemainingWorkHoursHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                                '<td><div class="custom_chckbox task-checkbox" type="checkbox"><input id="task_' + obj.TaskID + '"  type="checkbox" class="task-checkbox1"><label for="task_' + obj.TaskID + '" class =""><input hidden type="text" value=' + obj.TaskID + '></div></td></tr>';
                    });
                }               
                if (groupedData['Assigned Issues'].length > 0) {
                    strHTML += '<tr><td class="no-border" style="font-weight: bold;">Assigned Issues</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>';
                    groupedData['Assigned Issues'].forEach(function (obj, index) {
                        strHTML += '<tr><td class="text-centre">' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                            '<td class="text-centre">' + obj.StartDate + '<input hidden id="txtStartDate' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.StartDate + '"></td>' +
                            '<td class="text-centre">' + obj.EndDate + '<input hidden id="txtEndDate' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.EndDate + '"></td>' +
                            '<td class="text-centre">' + obj.WorkHHMM + '<input hidden id="txtWorkHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.WorkHHMM + '"></td>' +
                            '<td class="text-centre">' + obj.ActualWorkHHMM + '<input hidden id="txtActualWorkHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.ActualWorkHHMM + '"></td>' +
                            '<td class="text-centre">' + obj.RemainingWorkHoursHHMM + '<input hidden id="txtRemainingWorkHoursHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                            '<td><div class="custom_chckbox task-checkbox" type="checkbox"><input id="task_' + obj.TaskID + '"  type="checkbox" class="task-checkbox1"><label for="task_' + obj.TaskID + '" class =""><input hidden type="text" value=' + obj.TaskID + '></div></td></tr>';
                    });
                }
                if (groupedData['Void Tasks'].length > 0) {
                    strHTML += '<tr><td class="no-border" style="font-weight: bold;">Void Tasks</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>';
                    groupedData['Void Tasks'].forEach(function (obj, index) {
                        strHTML += '<tr><td class="text-centre">' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                            '<td class="text-centre">' + obj.StartDate + '<input hidden id="txtStartDate' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.StartDate + '"></td>' +
                            '<td class="text-centre">' + obj.EndDate + '<input hidden id="txtEndDate' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.EndDate + '"></td>' +
                            '<td class="text-centre">' + obj.WorkHHMM + '<input hidden id="txtWorkHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.WorkHHMM + '"></td>' +
                            '<td class="text-centre">' + obj.ActualWorkHHMM + '<input hidden id="txtActualWorkHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.ActualWorkHHMM + '"></td>' +
                            '<td class="text-centre">' + obj.RemainingWorkHoursHHMM + '<input hidden id="txtRemainingWorkHoursHHMM' + obj.TaskID + '" class="form-control text-center" type="text" readonly value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                            '<td><div class="custom_chckbox task-checkbox" type="checkbox"><input id="task_' + obj.TaskID + '"  type="checkbox" class="task-checkbox1"><label for="task_' + obj.TaskID + '" class =""><input hidden type="text" value=' + obj.TaskID + '></div></td></tr>';
                    });
                }

                $("#TasksSelectionList").html(strHTML);
                $('#TasksSelectionTable').dataTable({                    
                    scrollY: true,
                    scrollX: true,
                    paging: true,
                    pageLength: 10,
                    bLengthChange: false,
                    bFilter: false,
                    ordering: false,
                    responsive: true,
                    destroy: false,
                    retrieve: true,
                    bFilter: false,
                    ordering: false,
                    info: false,                   
                });
                StopAjaxLoader("#bodyResourceReallocationDetails");
                $("table tr").removeClass("rowhiglight");
                $(".Resourcedetailpanel").hide();
                $(".ResourceAllocationSec").hide();
                $(".AllocateResourceSec").show();
                $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, #rolerateTbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
                $(".table").resize();
                getResourceProfileFrom();
            }
            else {                
                return intAsssignAllFlag = 1;
            }
        }      

        /*
        Created By : Vishal Mane
        Created Date : 05/10/2023
        Purpose : To bind resources to dropdown except current employee dynamically
        */
        function BindResourcesExceptCurrentEmployee() {
            var ResourceID = $("#txtEmployeeID").text();
            var ProjectID = $("#cboProject").val();
            var strHTML = "";
            var parameter = {
                ProjectID: ProjectID,
                ResourceID: ResourceID,
            }
            var param = JSON.stringify(parameter)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/BindResourcesExceptCurrentEmployee", param, false);
            $("#selectResource").html("");
            for (var i = 0; i < strResult.length; i++) {
                var listComponent = strResult[i];
                strHTML += ('<option value=' + listComponent.ID + ' text =' + listComponent.ResourceName + '>' + listComponent.ResourceName + '</option>');
            }
            $("#selectResource").html(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }       

        /*
        Created By : Vishal Mane
        Created Date : 05/10/2023
        Purpose : To show selected task list to selected resource
        */
        function GetSelectedTaskList() {
            
            var ResourceTobeAssigned = $("#selectResource option:selected").text();
            var ProjectID = $("#cboProject").val();
            var ResourceID = $("#txtEmployeeID").text();
            $("#ResourceReallocationTable").dataTable().fnDestroy();
            var checked = $("#resCheck0").is(":checked");
            if (checked == true) {
                GetAllSelectedTasks(ResourceID, ProjectID);
            }
            var CheckedTaskIDs = [];
            $('.task-checkbox1:checked').each(function () {
                
                var taskID = $(this).closest('tr').find('td:nth-child(1) input[type="text"]').val();
                if (taskID !== null && taskID !== undefined) {
                    CheckedTaskIDs.push(taskID);
                }
            });            
            var CheckedTaskIDsString = CheckedTaskIDs.join(',');
            StartLoader("#bodyResourceReallocationDetails");
            var TaskIDs = "";
            var OpenOrVoidFlag = 1;
            if ($('.switch input[type="checkbox"]').is(':checked')) {
                OpenOrVoidFlag = 0;
            }
            var ResourceTaskDetails = {
                OpenOrVoidFlag: encodeURI(OpenOrVoidFlag),
                TaskIDs: encodeURI(CheckedTaskIDsString),
                ResourceID: encodeURI(ResourceID),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceTaskDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetSelectedTaskList", param, false);
            if (strResult.length != 0) {
                $("#txtResourcrName").text(strResult[0].EmployeeName);
                $("#txtAssResource").text(ResourceTobeAssigned);
                var groupedData = {
                    'Assigned Tasks': [],
                    'Assigned Issues': [],
                    'Void Tasks': []
                };
                strResult.forEach(function (obj) {
                    groupedData[obj.TaskType].push(obj);
                });
                var strHTML = '';
                if (groupedData['Assigned Tasks'].length > 0) {
                    strHTML += '<tr><td class="no-border" style="font-weight: bold;">Assigned Tasks</td><td></td><td></td><td></td><td></td></tr>';

                    groupedData['Assigned Tasks'].forEach(function (obj, index) {
                        if (obj.RemainingWorkHours !== 0) {
                            strHTML += '<tr  id="txtselectedStartDate' + obj.TaskID + '"><td>' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                                '<td class="text-centre">' + obj.StartDate + '<input hidden id="txtStDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.StartDate + '"></td>' +
                                '<td class="text-centre">' + obj.EndDate + '<input hidden id="txtEdDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.EndDate + '"></td>' +
                                '<td class="text-centre">' + obj.RemainingWorkHoursHHMM + '<input hidden id="txtReWorkHours' + obj.TaskID + '" class="form-control text-center" disabled type="text" value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                                '<td class="text-centre"><a href="javascript:;" class="edit-btn" title="Edit"><i class="fas fa-pencil-alt"></i></a><a href="javascript:;" class="delete-btn ms-2" title="Delete"><i class="fas fa-trash-alt"></i></a><a href="javascript:;" class="assign-btn ms-2" title = "Assign"  ><i class="fas fa-tasks"></i></a ></td>';
                        }

                    });
                }
                if (groupedData['Assigned Issues'].length > 0) {
                    strHTML += '<tr><td class="no-border" style="font-weight: bold;">Assigned Issues</td><td></td><td></td><td></td><td></td></tr>';
                    groupedData['Assigned Issues'].forEach(function (obj, index) {
                        if (obj.RemainingWorkHours != 0) {
                            strHTML += '<tr  id="txtselectedStartDate' + obj.TaskID + '"><td>' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                                '<td class="text-centre">' + obj.StartDate + '<input hidden id="txtStDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.StartDate + '"></td>' +
                                '<td class="text-centre">' + obj.EndDate + '<input hidden id="txtEdDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.EndDate + '"></td>' +
                                '<td class="text-centre">' + obj.RemainingWorkHoursHHMM + '<input hidden id="txtReWorkHours' + obj.TaskID + '" class="form-control text-center" disabled type="text" value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                                '<td class="text-centre"><a href="javascript:;" class="edit-btn" title="Edit"><i class="fas fa-pencil-alt"></i></a><a href="javascript:;" class="delete-btn ms-2" title="Delete"><i class="fas fa-trash-alt"></i></a><a href="javascript:;" class="assign-btn ms-2" title = "Assign"  ><i class="fas fa-tasks"></i></a ></td>';
                        }
                    });
                }
                if (groupedData['Void Tasks'].length > 0) {
                    strHTML += '<tr><td class="no-border" style="font-weight: bold;">Void Tasks</td><td></td><td></td><td></td><td></td></tr>';
                    groupedData['Void Tasks'].forEach(function (obj, index) {
                        if (obj.RemainingWorkHours != 0) {

                            strHTML += '<tr  id="txtselectedStartDate' + obj.TaskID + '"><td>' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                                '<td class="text-centre">' + obj.StartDate +'<input hidden id="txtStDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.StartDate + '"></td>' +
                                '<td class="text-centre">' + obj.EndDate +'<input hidden id="txtEdDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.EndDate + '"></td>' +
                                '<td class="text-centre">' + obj.RemainingWorkHoursHHMM +'<input hidden id="txtReWorkHours' + obj.TaskID + '" class="form-control text-center" disabled type="text" value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                                '<td class="text-centre"><a href="javascript:;" class="edit-btn" title="Edit"><i class="fas fa-pencil-alt"></i></a><a href="javascript:;" class="delete-btn ms-2" title="Delete"><i class="fas fa-trash-alt"></i></a><a href="javascript:;" class="assign-btn ms-2" title = "Assign"  ><i class="fas fa-tasks"></i></a ></td>';
                        }
                    });
                }
                $("#ResourceReallocationList").html(strHTML);
                $('.taskDate').each(function () {
                    var id = $(this).attr('id');
                    CustomfiledDatePicker(id);
                    event.preventDefault();
                });               
                $(".assign-btn").hide();
                if (EditAccess == 'True') {
                    $(".edit-btn").prop("disabled", false);
                } else {
                    $(".edit-btn").prop("disabled", true);
                }
                if (DeleteAccess == 'True') {
                    $(".delete-btn").prop("disabled", false);
                }
                else {
                    $(".delete-btn").prop("disabled", true);
                }                                
                $('#ResourceReallocationTable').dataTable({
                    scrollX: true,
                    paging: true,
                    pageLength: 10,
                    bLengthChange: false,
                    bFilter: false,
                    ordering: false,
                    responsive: true,
                    destroy: false,
                    retrieve: true,
                    bFilter: false,
                    ordering: false,
                    info: false,
                    "drawCallback": function (settings) {
                        $('[data-toggle="tooltip"]').tooltip();
                    }
                });
                StopAjaxLoader("#bodyResourceReallocationDetails");
            }
            else {
                $(".Resourcedetailpanel").hide();
                $("table tr").removeClass("rowhiglight");
               /* $(".Resourcedetailpanel").hide();*/
                $(".ResourceAllocationSec").hide();
                $(".AllocateResourceSec").show();
                $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, #rolerateTbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
                $(".table").resize();
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 14/10/2023
        Purpose : To get all selected tasks 
        */
        function GetAllSelectedTasks(ResourceID, ProjectID) {
           
            var ResourceTobeAssigned = $("#selectResource option:selected").text();
            $("#txtEmployeeID").text(ResourceID);
            $("#ResourceReallocationTable").dataTable().fnDestroy();
            StartLoader("#bodyResourceReallocationDetails");
            var OpenOrVoidFlag = 1;
            if ($('.switch input[type="checkbox"]').is(':checked')) {
                OpenOrVoidFlag = 0;
            }
            var ResourceTaskDetails = {
                ProjectID: encodeURI(ProjectID),
                ResourceID: encodeURI(ResourceID),
                OpenOrVoidFlag: encodeURI(OpenOrVoidFlag),
            }
            var param = JSON.stringify(ResourceTaskDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetSelectedResourceTasksList", param, false);
            $("#txtResourcrName").text(strResult[0].EmployeeName);
            $("#txtAssResource").text(ResourceTobeAssigned);
            var groupedData = {
                'Assigned Tasks': [],
                'Assigned Issues': [],
                'Void Tasks': []
            };
            strResult.forEach(function (obj) {
                groupedData[obj.TaskType].push(obj);
            });
            var strHTML = '';
            if (groupedData['Assigned Tasks'].length > 0) {
                strHTML += '<tr><td class="no-border" style="font-weight: bold;">Assigned Tasks</td><td></td><td></td><td></td><td></td></tr>';
                groupedData['Assigned Tasks'].forEach(function (obj, index) {
                    if (obj.RemainingWorkHours != 0) {
                        strHTML += '<tr  id="txtselectedStartDate' + obj.TaskID + '"><td>' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                            '<td class="text-centre">' + obj.StartDate + '<input hidden id="txtStDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.StartDate + '"></td>' +
                            '<td class="text-centre">' + obj.EndDate + '<input hidden id="txtEdDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.EndDate + '"></td>' +
                            '<td class="text-centre">' + obj.RemainingWorkHoursHHMM + '<input hidden id="txtReWorkHours' + obj.TaskID + '" class="form-control text-center" disabled type="text" value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                            '<td class="text-centre"><a href="javascript:;" class="edit-btn" title="Edit"><i class="fas fa-pencil-alt"></i></a><a href="javascript:;" class="delete-btn ms-2" title="Delete"><i class="fas fa-trash-alt"></i></a><a href="javascript:;" class="assign-btn ms-2" title = "Assign"  ><i class="fas fa-tasks"></i></a ></td>';
                    }
                });
            }
            if (groupedData['Assigned Issues'].length > 0) {
                strHTML += '<tr><td class="no-border" style="font-weight: bold;">Assigned Issues</td><td></td><td></td><td></td><td></td></tr>';
                groupedData['Assigned Issues'].forEach(function (obj, index) {
                    if (obj.RemainingWorkHours != 0) {
                        strHTML += '<tr  id="txtselectedStartDate' + obj.TaskID + '"><td>' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                            '<td class="text-centre">' + obj.StartDate + '<input hidden id="txtStDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.StartDate + '"></td>' +
                            '<td class="text-centre">' + obj.EndDate + '<input hidden id="txtEdDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.EndDate + '"></td>' +
                            '<td class="text-centre">' + obj.RemainingWorkHoursHHMM + '<input hidden id="txtReWorkHours' + obj.TaskID + '" class="form-control text-center" disabled type="text" value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                            '<td class="text-centre"><a href="javascript:;" class="edit-btn" title="Edit"><i class="fas fa-pencil-alt"></i></a><a href="javascript:;" class="delete-btn ms-2" title="Delete"><i class="fas fa-trash-alt"></i></a><a href="javascript:;" class="assign-btn ms-2" title = "Assign"  ><i class="fas fa-tasks"></i></a ></td>';
                    }
                });
            }
            if (groupedData['Void Tasks'].length > 0) {
                strHTML += '<tr><td class="no-border" style="font-weight: bold;">Void Tasks</td><td></td><td></td><td></td><td></td></tr>';
                groupedData['Void Tasks'].forEach(function (obj, index) {
                    if (obj.RemainingWorkHours != 0) {
                        strHTML += '<tr  id="txtselectedStartDate' + obj.TaskID + '"><td>' + obj.TaskName + '<input hidden type="text" value=' + obj.TaskID + '></td>' +
                            '<td class="text-centre">' + obj.StartDate + '<input hidden id="txtStDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.StartDate + '"></td>' +
                            '<td class="text-centre">' + obj.EndDate + '<input hidden id="txtEdDt' + obj.TaskID + '" class="form-control taskDate" type="text" disabled value="' + obj.EndDate + '"></td>' +
                            '<td class="text-centre">' + obj.RemainingWorkHoursHHMM + '<input hidden id="txtReWorkHours' + obj.TaskID + '" class="form-control text-center" disabled type="text" value="' + obj.RemainingWorkHoursHHMM + '"></td>' +
                            '<td class="text-centre"><a href="javascript:;" class="edit-btn" title="Edit"><i class="fas fa-pencil-alt"></i></a><a href="javascript:;" class="delete-btn ms-2" title="Delete"><i class="fas fa-trash-alt"></i></a><a href="javascript:;" class="assign-btn ms-2" title = "Assign"  ><i class="fas fa-tasks"></i></a ></td>';
                    }
                });
            }
            $("#ResourceReallocationList").html(strHTML);
            $('.taskDate').each(function () {
                var id = $(this).attr('id');
                CustomfiledDatePicker(id);
            });
            $(".assign-btn").hide();
            if (EditAccess == 'True') {
                $(".edit-btn").prop("disabled", false);
            } else {
                $(".edit-btn").prop("disabled", true);
            }
            if (DeleteAccess == 'True') {
                $(".delete-btn").prop("disabled", false);
            }
            else {
                $(".delete-btn").prop("disabled", true);
            }
            $('#ResourceReallocationTable').dataTable({
                scrollY: true,
                scrollX: true,
                paging: true,
                pageLength: 10,
                bLengthChange: false,
                bFilter: false,
                ordering: false,
                responsive: true,
                destroy: false,
                retrieve: true,
                bFilter: false,
                ordering: false,
                info: false,
                "drawCallback": function (settings) {
                    $('[data-toggle="tooltip"]').tooltip();
                }
            });
            StopAjaxLoader("#bodyResourceReallocationDetails");
        }

        /*
        Created By : Vishal Mane
        Created Date : 19/10/2023
        Purpose : To get datepicker to start date and end date selected task 
        */
        function CustomfiledDatePicker(customfileddateid) {            
            var filedid = "#" + customfileddateid;
            $(filedid).datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'd M yy',
                changeYear: true,                
                onSelect: function (dateText, inst) {                   
                    return false;
                }
            });
        }
        $(document).on('click', '.edit-btn', function () {
            //var row = $(this).closest('tr');
            //row.find('td:nth-child(2) input[type="text"]').prop("disabled", false);
            //row.find('td:nth-child(3) input[type="text"]').prop("disabled", false);
            //row.find('td:nth-child(4) input[type="text"]').prop("disabled", false);
            //row.find('.delete-btn').show();
            //row.find('.assign-btn').show();
            //row.find('.edit-btn').hide();
            //row.find('td:nth-child(4) input[type="text"]').focus();

            var row = $(this).closest('tr');
            var taskID = row.find('input[type="text"]').val();

            // To show hidden input fields
            $('#txtStDt' + taskID).prop("hidden", false);
            row.find('td:nth-child(2) input[type="text"]').prop("disabled", false);

            $('#txtEdDt' + taskID).prop("hidden", false);
            row.find('td:nth-child(3) input[type="text"]').prop("disabled", false);

            $('#txtReWorkHours' + taskID).prop("hidden", false);
            row.find('td:nth-child(4) input[type="text"]').prop("disabled", false);

            // To hide column value and show input box value
            row.find('td:nth-child(2)').contents().filter(function () {
                return this.nodeType === 3; 
            }).wrap('<span class="hidden-content">'); 
            row.find('td:nth-child(3)').contents().filter(function () {
                return this.nodeType === 3;
            }).wrap('<span class="hidden-content">');
            row.find('td:nth-child(4)').contents().filter(function () {
                return this.nodeType === 3;
            }).wrap('<span class="hidden-content">');

            // To hide edit button and to show assign button
            row.find('.delete-btn').show();
            row.find('.assign-btn').show();
            row.find('.edit-btn').hide();
            // To set focus to Work Hours input field 
            row.find('td:nth-child(4) input[type="text"]').focus();
        });

        /*
        Created By : Vishal Mane
        Created Date : 21/10/2023
        Purpose : To delete selected task from task list
        */
        $(document).on('click', '.delete-btn', function () {
            
            var EmployeeID = $("#txtEmployeeID").text();
            var row = $(this).closest('tr');
            var taskID = row.find('td:nth-child(1) input[type ="text"]').val();
            var taskIDToRemove = taskID;
            $('#ResourceReallocationTable tr').each(function () {
                var row = $(this);
                var taskID1 = row.find('td:nth-child(1) input[type ="text"]').val();

                if (taskID1 == taskIDToRemove) {
                    row.remove();
                    return false;
                }
            });
            onCheckboxClick(taskID);
        });

        /*
        Created By : Vishal Mane
        Created Date : 21/10/2023
        Purpose : To assign single task to selected resource
        */
        var TaskIDsForUpdatedSelection = [];
        $(document).on('click', '.assign-btn', function () {
            
            var ProjectID = $("#cboProject").val();
            var row = $(this).closest('tr');
            var startDate = row.find('td:nth-child(2) input[type ="text"]').val();
            var endDate = row.find('td:nth-child(3) input[type ="text"]').val();
            var workHour = row.find('td:nth-child(4) input[type ="text"]').val();
            var taskID = row.find('td:nth-child(1) input[type ="text"]').val();
            var intFromEmployeeID = $("#txtEmployeeID").text();
            var intToEmployeeID = $("#selectResource option:selected").val();
            var value = validateWorkHours(workHour, startDate, endDate, taskID, intFromEmployeeID, intToEmployeeID, 0);
            var HolidayValue = validateHoliday(workHour, startDate, endDate, taskID, intFromEmployeeID, intToEmployeeID);
            if (value == 0 && HolidayValue == 0) {
                var WorkHour = convertTimeToDecimal(workHour);
                var ResourceTaskDetails = {
                    'intFromEmployeeID': encodeURI(intFromEmployeeID),
                    'intToEmployeeID': encodeURI(intToEmployeeID),
                    'ProjectID': encodeURI(ProjectID),
                    'TaskIDs': encodeURI(taskID),
                    'StartDate': startDate,
                    'EndDate': endDate,
                    'WorkHour': encodeURI(WorkHour),
                }
                var param = JSON.stringify(ResourceTaskDetails)
                var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/AssignSelectedTasks", param, false);
                if (strResult == 1) {
                    /*alert("Selected Task reallocated successfully");*/
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("<%=MyBase.GetResourceString("A_Success") %>");
                    RefreshGrid();
                    TaskIDsForUpdatedSelection = [];                   
                    $('#ResourceReallocationTable tr').each(function () {
                        var row = $(this);
                        var taskIDNew = row.find('td:nth-child(1) input[type ="text"]').val();                      
                        if (taskIDNew != undefined) {
                            TaskIDsForUpdatedSelection.push(taskIDNew);
                        }
                    });
                    GetSelectedResourcesTasks(intFromEmployeeID, ProjectID);
                    if (intAsssignAllFlag == 1) {
                       
                        $("#offcanvasResScreen").hide();
                        $(".offcanvas-backdrop").hide();
                    } else {
                        for (var i = 0; i < TaskIDsForUpdatedSelection.length; i++) {
                            var taskIDNew = TaskIDsForUpdatedSelection[i];
                            $('#TasksSelectionTable tr').each(function () {
                                var row = $(this);
                                var taskIDExisting = row.find('td:nth-child(1) input[type ="text"]').val();
                                var checkbox = row.find('td:last-child input[type="checkbox"]');

                                if (taskIDExisting == taskIDNew) {
                                    checkbox.prop('checked', true);
                                }
                            });
                        }
                        $(".Resourcedetailpanel").show();
                        $(".offcanvas-body").animate(
                            {
                                scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                            },
                            "slow"
                        );
                        //used for disable grid
                        $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                        $(".table").resize();

                        GetSelectedTaskList();
                        $(".ResAllctnContent").hide();
                        $(".ResourceAllocationSec").removeClass('d-none').fadeIn();
                    }
                }
            }
        });

        /*
        Created By : Vishal Mane
        Created Date : 21/10/2023
        Purpose : To convert Time To Decimal format
        */
        function convertTimeToDecimal(timeString) {
            var parts = timeString.split(':');
            var hours = parseInt(parts[0], 10);
            var minutes = parseInt(parts[1], 10);
            var decimalHours = hours + (minutes / 60);
            return decimalHours.toFixed(1); // Round to one decimal place
        }
        /*
        Created By : Vishal Mane
        Created Date : 23/10/2023
        Purpose : To validate Start Date, End date and Work Hours
        */
        function validateWorkHours(workHour, startDate, endDate, taskID, intFromEmployeeID, intToEmployeeID, flag) {
           
            var IsValid = 0;
            var EmpStartDate = startDate;
            var EmpEndDate = endDate;
            var ProjectID = $("#cboProject").val();
            var strMsg;
            // validation for Work Hours
            var parts = workHour.split(':');
            if (!workHour || workHour == "" || workHour == undefined) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_WorkHour") %>");
                $('#txtReWorkHours' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (parts.length !== 2) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_WorkHoursHM") %>");
                $('#txtReWorkHours' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            var hours = parseInt(parts[0], 10);
            var minutes = parseFloat(parts[1]);
            if (isNaN(hours) || isNaN(minutes)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_WorkHourNumeric") %>");
                $('#txtReWorkHours' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (hours < 0 || minutes < 0 || minutes >= 60) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_WorkHour60") %>");
                $('#txtReWorkHours' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (hours < 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_PositiveNumeric") %>");
                $('#txtReWorkHours' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (startDate == endDate) {
               
                if (hours > 24) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<%=MyBase.GetResourceString("A_WorkHour24Hours") %>");
                    if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                        $('#txtReWorkHours' + taskID).prop("disabled", false)
                        $('#txtStDt' + taskID).prop("disabled", false)
                        $('#txtEdDt' + taskID).prop("disabled", false)
                    }
                    $('#txtReWorkHours' + taskID).focus();
                    IsValid = 1;
                    return IsValid;
                }
            }
            var OpenOrVoidFlag = 1;
            if ($('.switch input[type="checkbox"]').is(':checked')) {
                OpenOrVoidFlag = 0;
            }
          
            var ResourceTaskDetails = {
                OpenOrVoidFlag: encodeURI(OpenOrVoidFlag),
                TaskIDs: encodeURI(taskID),
                ResourceID: encodeURI(intFromEmployeeID),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceTaskDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetSelectedTaskList", param, false);
            var oldworkHours = "";
            var oldStartDate = "";
            var oldEndDate = "";
            if (strResult.length != 0) {
                var oldworkHours = strResult[0].RemainingWorkHoursHHMM;
                var oldStartDate = strResult[0].StartDate;
                var oldEndDate = strResult[0].EndDate;
            }
            // validation for Start Date and End date
            if (!startDate && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_StartDateBlank")%>");
                $('#txtStDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (!startDate && flag == 1) {
                var msg = "<%=MyBase.GetResourceString("A_StartDateBlank")%>";
                IsValid = 1;                
                return { msg: msg, IsValid: IsValid };
            }
            if (!endDate && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_EndDateBlank") %>");
                $('#txtEdDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (!endDate && flag == 1) {
                var msg = "<%=MyBase.GetResourceString("A_EndDateBlank")%>";
                IsValid = 1;
                return { msg: msg, IsValid: IsValid };
            }

            var ProjectStartDate1;
            var ProjectEndDate1;
            var TotalWorkHours;
            var AllocatedWorkHours;
            var ProjectDetails = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ProjectDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetProjectDetailsForValidation", param, false);
            if (strResult.length != 0) {
                ProjectStartDate1 = strResult[0].ProjectStartDate;
                ProjectEndDate1 = strResult[0].ProjectEndDate;
                TotalWorkHours = strResult[0].TotalWorkHours;
                AllocatedWorkHours = strResult[0].AllocatedWorkHours;
            }
            var Thours = Math.floor(TotalWorkHours);
            var Tminutes = (TotalWorkHours - Thours) * 60;
            var TformattedHours = (Thours < 10 ? '0' : '') + Thours;
            var TformattedMinutes = (Tminutes < 10 ? '0' : '') + Tminutes;
            var TformattedTime = TformattedHours + ':' + TformattedMinutes;
            var Ahours = Math.floor(AllocatedWorkHours);
            var Aminutes = (AllocatedWorkHours - Thours) * 60;
            var AformattedHours = (Ahours < 10 ? '0' : '') + Ahours;
            var AformattedMinutes = (Aminutes < 10 ? '0' : '') + Aminutes;
            var AformattedTime = AformattedHours + ':' + AformattedMinutes;
            var AllocatedWorkMinutes = convertToMinutes(AformattedTime);
            var TotalWorkMinutes = convertToMinutes(TformattedTime);
            var newWorkMinutes = convertToMinutes(workHour);
            var oldWorkMinutes = convertToMinutes(oldworkHours);           
            var NewtaskMinutes = Math.abs(newWorkMinutes - oldWorkMinutes);
            var FinalWorkMinutes = AllocatedWorkMinutes + NewtaskMinutes;
            if (FinalWorkMinutes > TotalWorkMinutes) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_TotalWorkHour") %>");
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtReWorkHours' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            <%--if (newWorkMinutes > oldWorkMinutes) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_RemainingWorkHour") %>");
                $('#txtReWorkHours' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }--%>
            var startDate = new Date(startDate);
            var endDate = new Date(endDate);
            var ProjectStartDate = new Date(ProjectStartDate1);
            var ProjectEndDate = new Date(ProjectEndDate1);
            if (startDate < ProjectStartDate || startDate > ProjectEndDate && flag == 1) {                
                var msg = `Start date and end date of the task should be between project start date [${ProjectStartDate1}] and end date[${ProjectEndDate1}].`
                IsValid = 1;              
                return { msg: msg, IsValid: IsValid };
            }            
            if (startDate < ProjectStartDate || startDate > ProjectEndDate && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Start date and end date of the task should be between project start date [${ProjectStartDate1}] and end date[${ProjectEndDate1}].`);
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtStDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (endDate < ProjectStartDate || endDate > ProjectEndDate && flag == 1) {                
                var msg = `Start date and end date of the task should be between project start date [${ProjectStartDate1}] and end date[${ProjectEndDate1}].`
                IsValid = 1;
                return { msg: msg, IsValid: IsValid };
            }
            if (endDate < ProjectStartDate || endDate > ProjectEndDate && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Start date and end date of the task should be between project start date [${ProjectStartDate1}] and end date[${ProjectEndDate1}].`);
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtEdDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            var ResourceDetails = {
                ProjectID: encodeURI(ProjectID),
                intToEmployeeID: encodeURI(intToEmployeeID),
            }
            var ResourceStartDate1;
            var ResourceEndDate1;
            var param = JSON.stringify(ResourceDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetResourceDetailsForValidation", param, false);
            if (strResult.length != 0) {
                var ResourceStartDate1 = strResult[0].ResourceStartDate;
                var ResourceEndDate1 = strResult[0].ResourceEndDate;
                var EmployeeName = strResult[0].EmployeeName;
            }
            var ResourceStartDate = new Date(ResourceStartDate1);
            var ResourceEndDate = new Date(ResourceEndDate1);

            if (startDate < ResourceStartDate || startDate > ResourceEndDate && flag == 1) {            
                var msg = `Start date  should be between Resource [${EmployeeName}] Start Date [${ResourceStartDate1}] and End Date [${ResourceEndDate1}] on Project.`
                IsValid = 1;               
                return { msg: msg, IsValid: IsValid };
            }
            if (startDate < ResourceStartDate || startDate > ResourceEndDate && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Start date  should be between Resource [${EmployeeName}] Start Date [${ResourceStartDate1}] and End Date [${ResourceEndDate1}] on Project.`);
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtStDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (endDate < ResourceStartDate || endDate > ResourceEndDate && flag == 1) {
                var msg = `End date  should be between Resource [${EmployeeName}] Start Date [${ResourceStartDate1}] and End Date [${ResourceEndDate1}] on Project.`
                IsValid = 1;                
                return { msg: msg, IsValid: IsValid };
            }
            if (endDate < ResourceStartDate || endDate > ResourceEndDate && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`End date  should be between Resource [${EmployeeName}] Start Date [${ResourceStartDate1}] and End Date [${ResourceEndDate1}] on Project.`);
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtEdDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (endDate < startDate && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_EndDateGreater") %>");
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtEdDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (endDate < startDate && flag == 1) {
                var msg = "<%=MyBase.GetResourceString("A_EndDateGreater")%>";
                IsValid = 1;
                return { msg: msg, IsValid: IsValid };                
            }
            var ProjectLocationID = "";
            var ProjectDetails = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ProjectDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetProjectLocationID", param, false);
            if (strResult.length != 0) {
                ProjectLocationID = strResult[0].LocationID;
            }
            var ProjectDetails = {
                ProjectLocationID: encodeURI(ProjectLocationID),
            }
            var param = JSON.stringify(ProjectDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetProjectHolidaysList", param, false);
            var strHolidays = [];
            for (var i = 0; i < strResult.length; i++) {
                strHolidays.push(strResult[i].HolidayDate);
            }
            var EmployeeStartDate = startDate.toLocaleDateString('en-GB'); // Convert to "DD/MM/YYYY"
            var partsEmployeeStartDate = EmployeeStartDate.split('/');
            var formattedEmployeeStartDate = partsEmployeeStartDate[2] + '-' + partsEmployeeStartDate[1] + '-' + partsEmployeeStartDate[0] + 'T00:00:00';
            var EmployeeEndDate = endDate.toLocaleDateString('en-GB'); // Convert to "DD/MM/YYYY"
            var partsEmployeeEndDate = EmployeeEndDate.split('/');
            var formattedEmployeeEndDate = partsEmployeeEndDate[2] + '-' + partsEmployeeEndDate[1] + '-' + partsEmployeeEndDate[0] + 'T00:00:00';
            if (strHolidays.includes(formattedEmployeeStartDate) && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_HolidaysStartDay") %>");
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtStDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (strHolidays.includes(formattedEmployeeStartDate) && flag == 1) {
                var msg = "<%=MyBase.GetResourceString("A_HolidaysStartDay")%>";
                IsValid = 1;
                return { msg: msg, IsValid: IsValid };                
            }
            if (strHolidays.includes(formattedEmployeeEndDate && flag == 0)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_HolidaysEndDay")%>");
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtEdDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (strHolidays.includes(formattedEmployeeEndDate && flag == 1)) {
                var msg = "<%=MyBase.GetResourceString("A_HolidaysEndDay")%>";
                IsValid = 1;
                return { msg: msg, IsValid: IsValid };
            }
            
            var ResourceDetails = {
                intToEmployeeID: encodeURI(intToEmployeeID),
                StartDate: EmpStartDate,
                EndDate: EmpEndDate,
            }
            var param = JSON.stringify(ResourceDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetEmployeeLeaveValidationMsg", param, false);
            if (strResult == 1 && flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Resource (${EmployeeName}) having leave between current start date and end date.");
                alertify.error(`Resource [${EmployeeName}] having leave between current start date and end date.`);
                if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                    $('#txtReWorkHours' + taskID).prop("disabled", false)
                    $('#txtStDt' + taskID).prop("disabled", false)
                    $('#txtEdDt' + taskID).prop("disabled", false)
                }
                $('#txtStDt' + taskID).focus();
                IsValid = 1;
                return IsValid;
            }
            if (strResult == 1 && flag == 1) {
                var msg = `Resource [${EmployeeName}] having leave between current start date and end date.`;
                IsValid = 1;
                return { msg: msg, IsValid: IsValid };
            }
           
            var SprintDetails = {
                ProjectID: encodeURI(ProjectID),
                /* TaskIDs: encodeURI(taskID),*/
                intToEmployeeID: encodeURI(intToEmployeeID),
            }
            var param = JSON.stringify(SprintDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetSprintStDateEdDate", param, false);           
            if (strResult[0].SprintStartDate != 1 && strResult[0].SprintEndDate != 1) {
                SprintStartDate1 = strResult[0].SprintStartDate;
                SprintEndDate1 = strResult[0].SprintEndDate;
                var SprintStartDate = new Date(SprintStartDate1);
                var SprintEndDate = new Date(SprintEndDate1);
                if (startDate < SprintStartDate && flag == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(`Start date and end date of the task should be between Sprint start date [${SprintStartDate1}] and end date [${SprintEndDate1}].`);
                    if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                        $('#txtReWorkHours' + taskID).prop("disabled", false)
                        $('#txtStDt' + taskID).prop("disabled", false)
                        $('#txtEdDt' + taskID).prop("disabled", false)
                    }
                    $('#txtStDt' + taskID).focus();
                    IsValid = 1;
                    return IsValid;
                }
                if (startDate < SprintStartDate && flag == 1) {
                    var msg = `Start date and end date of the task should be between Sprint start date [${SprintStartDate1}] and end date [${SprintEndDate1}].`;
                    IsValid = 1;
                    return { msg: msg, IsValid: IsValid };
                }
                if (endDate > SprintEndDate && flag == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(`Start date and end date of the task should be between Sprint start date [${SprintStartDate1}] and end date [${SprintEndDate1}].`);
                    if ($('#txtReWorkHours' + taskID).prop("disabled", true)) {
                        $('#txtReWorkHours' + taskID).prop("disabled", false)
                        $('#txtStDt' + taskID).prop("disabled", false)
                        $('#txtEdDt' + taskID).prop("disabled", false)
                    }
                    $('#txtEdDt' + taskID).focus();
                    IsValid = 1;
                    return IsValid;
                }
                if (endDate > SprintEndDate && flag == 1) {
                    var msg = `Start date and end date of the task should be between Sprint start date [${SprintStartDate1}] and end date [${SprintEndDate1}].`;
                    IsValid = 1;
                    return { msg: msg, IsValid: IsValid };
                }                
            }
            
            var MinDAENtryDisplay = "";
            var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
            if (MinDAEntry == 0.25) {
                MinDAEntry = 15
                MinDAENtryDisplay = "00:15"
            }
            else if (MinDAEntry == 0.50) {
                MinDAEntry = 30
                MinDAENtryDisplay = "00:30"
            }
            else if (MinDAEntry == 0.75) {
                MinDAEntry = 45
                MinDAENtryDisplay = "00:45"
            }
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetCompanyInfo", param, false);
            if (strResult[0].RestrictByMinHours == true) {
                
                if (MinDAEntry == 0.016) {
                }
                else {
                    
                    var parts = workHour.split(':');
                    var minutes = parseFloat(parts[1]);
                    if ((minutes % MinDAEntry) != 0 && flag == 0) {                        
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Please enter the work Hours in multiple of [" + MinDAENtryDisplay + "] min");
                        $('#txtReWorkHours' + taskID).focus();
                        IsValid = 1;
                        return IsValid;
                    }
                    if ((minutes % MinDAEntry) != 0 && flag == 1) {
                        var msg = "Please enter the work Hours in multiple of [" + MinDAENtryDisplay + "] min";
                        IsValid = 1;
                        return { msg: msg, IsValid: IsValid };
                    }                   
                }
            } 
            var OUHoursDetails = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(OUHoursDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetOUHoursDetails", param, false);
            if (strResult.length != 0) {
                var intCompanyHrsPerDay = strResult[0].WorkingHours;
                var intCompanyWeekDays = strResult[0].WorkingDays;
            }
            var bitHoliday = false;
            var dtCurrentDate;
            var dtHoliday;
            var intWorkingDays = 0;
            var intHolidays = 0;
            var strMsg;
            var intDays;
            intDays = Math.floor((endDate.getTime() - startDate.getTime()) / (1000 * 3600 * 24));
            for (intCnt = 0; intCnt <= intDays; intCnt++) {
                var dtCurrentDate = new Date(startDate);
                dtCurrentDate.setDate(dtCurrentDate.getDate() + intCnt);
                var dayOfWeek = dtCurrentDate.getDay(); // 0 for Sunday, 1 for Monday, ..., 6 for Saturday
                if (dayOfWeek !== 0 && dayOfWeek !== 6) {
                    // Not Saturday or Sunday, increment intWorkingDays
                    intWorkingDays = intWorkingDays + 1;
                }
            }
            if (strHolidays != "") {               
                var strMsg = "The Dates\n";               
                for (intCount = 0; intCount < strHolidays.length - 1; intCount++) {                  
                    intDays = Math.floor((endDate.getTime() - startDate.getTime()) / (1000 * 3600 * 24));
                    for (intCnt = 0; intCnt <= intDays; intCnt++) {
                        var dtCurrentDate = new Date(startDate);
                        dtCurrentDate.setDate(dtCurrentDate.getDate() + intCnt);
                        var dtHoliday = new Date(strHolidays[intCount]);
                        var isoDtHoliday = dtHoliday.toISOString().split('T')[0];
                        var isoDtCurrentDate = dtCurrentDate.toISOString().split('T')[0];
                        if (isoDtHoliday === isoDtCurrentDate) {
                            bitHoliday = true;
                            strMsg = strMsg + formatDate(dtHoliday) + "\n";
                            intHolidays = intHolidays + 1;
                        }
                    }
                }
            }
            if (bitHoliday == true && flag == 1) {                
                var msg = `Resource [${ EmployeeName }] having leave between current start date and end date.`
                IsValid = 1;                
                return { msg: msg, IsValid: IsValid };
            }
            if (bitHoliday != true && flag == 1) {
                var idealWorkHours = intWorkingDays * intCompanyHrsPerDay;
                var dblTotalWorkForConfirm = (parseInt(workHour.split(':')[0]) * 60 + parseInt(workHour.split(':')[1])) / 60;
                var avgWorkHours = dblTotalWorkForConfirm / intWorkingDays;
                if (avgWorkHours > intCompanyHrsPerDay) {                    
                    var msg = `You are assigning [${avgWorkHours}] hours per day.\n(OU Working hours work per day are [${intCompanyHrsPerDay}] hours.)`
                    IsValid = 1;                  
                    return { msg: msg, IsValid: IsValid };
                }
                else {
                    return IsValid;
                }                
            }
            else {
                IsValid = 0;
                return IsValid;
            }
            return IsValid;
        }

        function validateHoliday(workHour, startDate, endDate, taskID, intFromEmployeeID, intToEmployeeID) {
            
            var IsValid = 0;
            var ProjectID = $("#cboProject").val(); 
            var startDateNew = new Date(startDate);
            var endDateNew = new Date(endDate);
            var ProjectLocationID = "";
            var ProjectDetails = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ProjectDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetProjectLocationID", param, false);
            if (strResult.length != 0) {
                ProjectLocationID = strResult[0].LocationID;
            }
            var ProjectLocDetails = {
                ProjectLocationID: encodeURI(ProjectLocationID),
            }
            var param = JSON.stringify(ProjectLocDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetProjectHolidaysList", param, false);
            var strHolidays = [];
            for (var i = 0; i < strResult.length; i++) {
                strHolidays.push(strResult[i].HolidayDate);
            }            
            var bitHoliday = false;
            var dtCurrentDate;
            var dtHoliday;
            var intWorkingDays = 0;
            var intHolidays = 0;
            var strMsg;
            var intDays;
            intDays = Math.floor((endDateNew.getTime() - startDateNew.getTime()) / (1000 * 3600 * 24));
            for (intCnt = 0; intCnt <= intDays; intCnt++) {
                var dtCurrentDate = new Date(startDate);
                dtCurrentDate.setDate(dtCurrentDate.getDate() + intCnt);
                var dayOfWeek = dtCurrentDate.getDay(); // 0 for Sunday, 1 for Monday, ..., 6 for Saturday
                if (dayOfWeek !== 0 && dayOfWeek !== 6) {
                    // Not Saturday or Sunday, increment intWorkingDays
                    intWorkingDays = intWorkingDays + 1;
                }
            }
            if (strHolidays != "") {                
                var strMsg = "The Dates ";
                for (intCount = 0; intCount < strHolidays.length - 1; intCount++) {                    
                    intDays = Math.floor((endDateNew.getTime() - startDateNew.getTime()) / (1000 * 3600 * 24));
                    for (intCnt = 0; intCnt <= intDays; intCnt++) {
                        var dtCurrentDate = new Date(startDate);
                        dtCurrentDate.setDate(dtCurrentDate.getDate() + intCnt);
                        var dtHoliday = new Date(strHolidays[intCount]);
                        var isoDtHoliday = dtHoliday.toISOString().split('T')[0];
                        var isoDtCurrentDate = dtCurrentDate.toISOString().split('T')[0];
                        if (isoDtHoliday === isoDtCurrentDate) {
                            bitHoliday = true;
                            strMsg = strMsg + formatDate(dtHoliday) + "," + " ";
                            intHolidays = intHolidays + 1;
                        }
                    }
                }
            }
            var OUHoursDetails = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(OUHoursDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetOUHoursDetails", param, false);
            if (strResult.length != 0) {
                var intCompanyHrsPerDay = strResult[0].WorkingHours;
                var intCompanyWeekDays = strResult[0].WorkingDays;
            }
            if (bitHoliday == true) {
                
                strMsg = strMsg.slice(0, -2);
                $("#confirmHolidayModal").modal("show");
                $('.modalHoliday1').text(strMsg);
                $('.modalHoliday2').text("<%=MyBase.GetResourceString("C_HolidatStDateEnddate")%>");
                $('.modalHoliday3').text("<%=MyBase.GetResourceString("C_MaintainStDateEnddate")%>");
                $('.modalHoliday4').val(workHour);
                $('.modalHoliday5').val(startDate);
                $('.modalHoliday6').val(endDate);
                $('.modalHoliday7').val(taskID);
                $('.modalHoliday8').val(intFromEmployeeID);
                $('.modalHoliday9').val(intToEmployeeID);

                IsValid = 1;
            }
            else if (bitHoliday != true) {
               
                var idealWorkHours = intWorkingDays * intCompanyHrsPerDay;
                var dblTotalWorkForConfirm = (parseInt(workHour.split(':')[0]) * 60 + parseInt(workHour.split(':')[1])) / 60;
                var avgWorkHours = dblTotalWorkForConfirm / intWorkingDays;
                if (avgWorkHours > intCompanyHrsPerDay) {
                    var txtOUmsg = "You are assigning [" + avgWorkHours + "] hours per day.";
                    var txtOUmsg2 = "(OU Working hours work per day are [" + intCompanyHrsPerDay + "] hours.)";
                    var txtOUmsg3 = "<%=MyBase.GetResourceString("C_Continue")%>"; 
                    $("#confirmOUhoursModal").modal("show");
                    $('.modalOUhours1').text(txtOUmsg);
                    $('.modalOUhours2').text(txtOUmsg2);
                    $('.modalOUhours3').text(txtOUmsg3);
                    $('.modalOUhours4').val(workHour);
                    $('.modalOUhours5').val(startDate);
                    $('.modalOUhours6').val(endDate);
                    $('.modalOUhours7').val(taskID);
                    $('.modalOUhours8').val(intFromEmployeeID);
                    $('.modalOUhours9').val(intToEmployeeID);
                    IsValid = 1;
                } else {
                    IsValid = 0;
                }
            }            
            return IsValid;
        }

        $('.md1').click(function () {
            
            var intWorkingDays = 0;           
            var intDays;
            $("#confirmHolidayModal").modal("hide");
            var ProjectID = $("#cboProject").val();
            var workHour = $('.modalHoliday4').val();
            var startDate = $('.modalHoliday5').val();
            var endDate = $('.modalHoliday6').val();
            var taskID = $('.modalHoliday7').val();
            var intFromEmployeeID = $('.modalHoliday8').val();
            var intToEmployeeID = $('.modalHoliday9').val();
            var OUHoursDetails = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(OUHoursDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetOUHoursDetails", param, false);
            if (strResult.length != 0) {
                var intCompanyHrsPerDay = strResult[0].WorkingHours;                
            }
            var startDateNew = new Date(startDate);
            var endDateNew = new Date(endDate);
            intDays = Math.floor((endDateNew.getTime() - startDateNew.getTime()) / (1000 * 3600 * 24));
            for (intCnt = 0; intCnt <= intDays; intCnt++) {
                var dtCurrentDate = new Date(startDate);
                dtCurrentDate.setDate(dtCurrentDate.getDate() + intCnt);
                var dayOfWeek = dtCurrentDate.getDay(); // 0 for Sunday, 1 for Monday, ..., 6 for Saturday
                if (dayOfWeek !== 0 && dayOfWeek !== 6) {
                    // Not Saturday or Sunday, increment intWorkingDays
                    intWorkingDays = intWorkingDays + 1;
                }
            }           
            var dblTotalWorkForConfirm = (parseInt(workHour.split(':')[0]) * 60 + parseInt(workHour.split(':')[1])) / 60;
            var avgWorkHours = dblTotalWorkForConfirm / intWorkingDays;
            if (avgWorkHours > intCompanyHrsPerDay) {
                var txtOUmsg = "You are assigning [" + avgWorkHours + "] hours per day.";
                var txtOUmsg2 = "(OU Working hours work per day are (" + intCompanyHrsPerDay + ") hour.)";
                var txtOUmsg3 = "<%=MyBase.GetResourceString("C_Continue")%>";
                $("#confirmOUhoursModal").modal("show");
                $('.modalOUhours1').text(txtOUmsg);
                $('.modalOUhours2').text(txtOUmsg2);
                $('.modalOUhours3').text(txtOUmsg3);
                $('.modalOUhours4').val(workHour);
                $('.modalOUhours5').val(startDate);
                $('.modalOUhours6').val(endDate);
                $('.modalOUhours7').val(taskID);
                $('.modalOUhours8').val(intFromEmployeeID);
                $('.modalOUhours9').val(intToEmployeeID);
            }
            else {
                var WorkHour = convertTimeToDecimal(workHour);
                var ResourceTaskDetails = {
                    'intFromEmployeeID': encodeURI(intFromEmployeeID),
                    'intToEmployeeID': encodeURI(intToEmployeeID),
                    'ProjectID': encodeURI(ProjectID),
                    'TaskIDs': encodeURI(taskID),
                    'StartDate': startDate,
                    'EndDate': endDate,
                    'WorkHour': encodeURI(WorkHour),
                }
                var param = JSON.stringify(ResourceTaskDetails)
                var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/AssignSelectedTasks", param, false);
                if (strResult == 1) {                   
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("<%=MyBase.GetResourceString("A_Success") %>");
                    RefreshGrid();
                    TaskIDsForUpdatedSelection = [];
                    $('#ResourceReallocationTable tr').each(function () {
                    var row = $(this);
                    var taskIDNew = row.find('td:nth-child(1) input[type ="text"]').val();
                    if (taskIDNew != undefined) {
                        TaskIDsForUpdatedSelection.push(taskIDNew);
                        }
                    });
                    GetSelectedResourcesTasks(intFromEmployeeID, ProjectID);
                    if (intAsssignAllFlag == 1) {
                       
                        $("#offcanvasResScreen").hide();
                        $(".offcanvas-backdrop").hide();
                    }
                else {
                    for (var i = 0; i < TaskIDsForUpdatedSelection.length; i++) {
                        var taskIDNew = TaskIDsForUpdatedSelection[i];
                        $('#TasksSelectionTable tr').each(function () {
                            var row = $(this);
                            var taskIDExisting = row.find('td:nth-child(1) input[type ="text"]').val();
                            var checkbox = row.find('td:last-child input[type="checkbox"]');

                            if (taskIDExisting == taskIDNew) {
                                checkbox.prop('checked', true);
                            }
                        });
                    }
                    $(".Resourcedetailpanel").show();
                    $(".offcanvas-body").animate(
                        {
                            scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                        },
                        "slow"
                    );
                    //used for disable grid
                    $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                    $(".table").resize();
                    GetSelectedTaskList();
                    $(".ResAllctnContent").hide();
                    $(".ResourceAllocationSec").removeClass('d-none').fadeIn();
                    }
                }
            }
        });
        $('.md2').click(function () {            
            GetSelectedTaskList();
        });
        $('.md3').click(function () {
            
            var ProjectID = $("#cboProject").val();
            var workHour = $('.modalOUhours4').val();
            var startDate = $('.modalOUhours5').val();
            var endDate = $('.modalOUhours6').val();
            var taskID = $('.modalOUhours7').val();
            var intFromEmployeeID = $('.modalOUhours8').val();
            var intToEmployeeID = $('.modalOUhours9').val();
            var WorkHour = convertTimeToDecimal(workHour);
            var ResourceTaskDetails = {
                'intFromEmployeeID': encodeURI(intFromEmployeeID),
                'intToEmployeeID': encodeURI(intToEmployeeID),
                'ProjectID': encodeURI(ProjectID),
                'TaskIDs': encodeURI(taskID),
                'StartDate': startDate,
                'EndDate': endDate,
                'WorkHour': encodeURI(WorkHour),
            }
            var param = JSON.stringify(ResourceTaskDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/AssignSelectedTasks", param, false);
            if (strResult == 1) {
                /*alert("Selected Task reallocated successfully");*/
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<%=MyBase.GetResourceString("A_Success") %>");
                    RefreshGrid();
                    TaskIDsForUpdatedSelection = [];
                    $('#ResourceReallocationTable tr').each(function () {
                        var row = $(this);
                        var taskIDNew = row.find('td:nth-child(1) input[type ="text"]').val();
                        if (taskIDNew != undefined) {
                            TaskIDsForUpdatedSelection.push(taskIDNew);
                        }
                    });
                    GetSelectedResourcesTasks(intFromEmployeeID, ProjectID);
                    if (intAsssignAllFlag == 1) {
                        
                        $("#offcanvasResScreen").hide();
                        $(".offcanvas-backdrop").hide();
                    } else {
                        for (var i = 0; i < TaskIDsForUpdatedSelection.length; i++) {
                            var taskIDNew = TaskIDsForUpdatedSelection[i];
                            $('#TasksSelectionTable tr').each(function () {
                                var row = $(this);
                                var taskIDExisting = row.find('td:nth-child(1) input[type ="text"]').val();
                                var checkbox = row.find('td:last-child input[type="checkbox"]');

                                if (taskIDExisting == taskIDNew) {
                                    checkbox.prop('checked', true);
                                }
                            });
                        }
                        $(".Resourcedetailpanel").show();
                        $(".offcanvas-body").animate(
                            {
                                scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                            },
                            "slow"
                        );
                        //used for disable grid
                        $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                        $(".table").resize();
                        GetSelectedTaskList();
                        $(".ResAllctnContent").hide();
                        $(".ResourceAllocationSec").removeClass('d-none').fadeIn();
                    }
                }           
        });
        $('.md4').click(function () {
            GetSelectedTaskList();
        });
        function convertToMinutes(timeString) {
            var parts = timeString.split(':');
            return parseInt(parts[0], 10) * 60 + parseInt(parts[1], 10);
        }
        function formatDate(date) {
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            const day = String(date.getDate()).padStart(2, '0');
            const month = months[date.getMonth()];
            const year = date.getFullYear();
            return `${day} ${month} ${year}`;
        }
        /*
        Created By : Vishal Mane
        Created Date : 25/10/2023
        Purpose : To validate Start Date and End Date of the tasks
        */
        function validateStartDateEndDate() {
            
            var ProjectID = $("#cboProject").val();
            var intToEmployeeID = $("#selectResource option:selected").val();
            var ResourceDetails = {
                ProjectID: encodeURI(ProjectID),
                intToEmployeeID: encodeURI(intToEmployeeID),
            }
            var ResourceStartDate1;
            var ResourceEndDate1;
            var param = JSON.stringify(ResourceDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetResourceDetailsForValidation", param, false);
            if (strResult.length != 0) {
                var ResourceStartDate1 = strResult[0].ResourceStartDate;
                var ResourceEndDate1 = strResult[0].ResourceEndDate;
                var EmployeeName = strResult[0].EmployeeName;
            }
            var ResourceStartDate = new Date(ResourceStartDate1);
            var ResourceEndDate = new Date(ResourceEndDate1);

            var CheckedTaskIDs = [];
            $('.task-checkbox1:checked').each(function () {
                
                var taskID = $(this).closest('tr').find('td:nth-child(1) input[type="text"]').val();
                //var taskName = $(this).closest('tr').find('td:eq(2) input[type="text"]').text();
                var startDate = $(this).closest('tr').find('td:nth-child(2) input[type="text"]').val();
                var endDate = $(this).closest('tr').find('td:nth-child(3) input[type="text"]').val();

                if (taskID != undefined && startDate != undefined && endDate != undefined) {
                    var taskDetails = { taskID, startDate, endDate };
                    CheckedTaskIDs.push(taskDetails);
                }
            });
            var tasksWithinRange = [];
            for (var i = 0; i < CheckedTaskIDs.length; i++) {
                
                var task = CheckedTaskIDs[i];
                var taskStartDate = new Date(task.startDate);
                var taskEndDate = new Date(task.endDate);
                if (taskStartDate < ResourceStartDate || taskEndDate > ResourceEndDate) {
                    tasksWithinRange.push(task.taskID);
                }
            }
            if (tasksWithinRange.length > 0) {
                var msg = `The start date and end date of the tasks are not between resource Start Date (${ResourceStartDate1}) and End date (${ResourceEndDate1})`
            }            
            return { msg: msg, tasksWithinRange: tasksWithinRange };
        }
        /*
        Created By : Vishal Mane
        Created Date : 10/10/2023
        Purpose : To deselect task when it is fully allocated to selected resource
        */
        function onCheckboxClick(taskID) {
            var checkbox = document.getElementById('task_' + taskID);            
            if (checkbox) {
                checkbox.checked = false;
            }
            $(".chckHead").prop("checked", false);
        }
        /*
        Created By : Vishal Mane
        Created Date : 10/10/2023
        Purpose : To validate wheather task is selected or not 
        */  
        function validateCheckbox() {
            
            var checkboxes = document.querySelectorAll('.task-checkbox1');
            var flag = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked === true) {
                    flag = true;
                    break; 
                }
            }
            if (flag === false) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%=MyBase.GetResourceString("A_Checkbox") %>");
                return false;
            }
            return true; // At least one checkbox was checked
        }   
        /*
        Created By : Vishal Mane
        Created Date : 05/10/2023
        Purpose : To assign selected task to selected resource
        */
        function AssignAllSelectedTasks() {
            
            var ProjectID = $("#cboProject").val();
            var intFromEmployeeID = $("#txtEmployeeID").text();
            var intToEmployeeID = $("#selectResource option:selected").val();
            var value = 0;
            var CheckedTaskIDsToAssignString = [];
            var ValidationAlerts = [];
            var breakLoop = false;
            var countZeroz = 0;
            var countOnes = 0;
            var alertifyMsg = "";
            $('#ResourceReallocationList tr').each(function () {
                var row = $(this);
                
                var WorkHour = "";
                var taskID = row.find('td:first-child input[type="text"]').val();
                var startDate = row.find('td:nth-child(2) input[type="text"]').val();
                var endDate = row.find('td:nth-child(3) input[type="text"]').val();
                var workHour = row.find('td:nth-child(4) input[type="text"]').val();
                if (workHour != undefined) {
                    WorkHour = convertTimeToDecimal(workHour);
                }               
                if (taskID != undefined && startDate != undefined && endDate != undefined && workHour != undefined) {
                    var value = validateWorkHours(workHour, startDate, endDate, taskID, intFromEmployeeID, intToEmployeeID, 1);
                    if (value === 0) {
                        countZeroz = countZeroz + 1;
                        var taskDetails = { taskID, startDate, endDate, WorkHour };
                        CheckedTaskIDsToAssignString.push(taskDetails);
                    }
                    if (value.IsValid === 1) {
                        countOnes = countOnes + 1;
                        ValidationAlerts.push(value.msg);
                    }
                    if (value == 2) {
                        breakLoop = true;
                        GetSelectedTaskList();                        
                    }
                }
            });
            var strValidationAlerts = ValidationAlerts.join(',\n');            
            if (CheckedTaskIDsToAssignString.length == 0) {
                breakLoop = true;
                var result = validateStartDateEndDate();
                var alertifyMsg = result.msg;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Tasks can not be reallocated since ${strValidationAlerts}`);
                return false;
            }
            if (breakLoop == false) {
                
                var intFromEmployeeName = $("#txtResourcrName").text();
                var intToEmployeeName = $("#txtAssResource").text();
                var ResourceTaskDetails = {
                    intFromEmployeeID: encodeURI(intFromEmployeeID),
                    intToEmployeeID: encodeURI(intToEmployeeID),
                    ProjectID: encodeURI(ProjectID),
                    TaskIDsDetails: CheckedTaskIDsToAssignString,
                }
                //var ResourceTaskDetails = {
                //    'intFromEmployeeID': encodeURI(intFromEmployeeID),
                //    'intToEmployeeID': encodeURI(intToEmployeeID),
                //    'ProjectID': encodeURI(ProjectID),
                //    'TaskIDsDetails': CheckedTaskIDsToAssignString,
                //}
                var param = JSON.stringify(ResourceTaskDetails)
                var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/AssignAllSelectedTasks", param, false);
                if (strResult == 1) {  
                    if (countZeroz != 0 && countOnes == 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(`[${countZeroz}] : Tasks of [${intFromEmployeeName}] reallocated successfully to [${intToEmployeeName}]`);

                    } else if (countZeroz != 0 && countOnes != 0) {
                        var result = validateStartDateEndDate();
                        var alertifyMsg = result.msg;
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(`[${countZeroz}] : Tasks of [${intFromEmployeeName}] reallocated successfully to [${intToEmployeeName}] and (${countOnes}) : Tasks of [${intFromEmployeeName}] can not be reallocated since ${strValidationAlerts}`);

                    } else if (countZeroz == 0 && countOnes != 0) {
                        var result = validateStartDateEndDate();
                        var alertifyMsg = result.msg;
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(`(${countOnes}) : Tasks of [${intFromEmployeeName}] can not be reallocated since ${alertifyMsg}`);
                    }   
                    TaskIDsForUpdatedSelection = [];
                    $('#ResourceReallocationTable tr').each(function () {
                        var row = $(this);
                        var taskIDNew = row.find('td:nth-child(1) input[type ="text"]').val();                        
                        if (taskIDNew != undefined) {
                            TaskIDsForUpdatedSelection.push(taskIDNew);
                        }
                    });
                    RefreshGrid();
                    GetSelectedResourcesTasks(intFromEmployeeID, ProjectID);

                    if (intAsssignAllFlag == 1) {
                        refreshTaskLisk();
                    } else {
                        for (var i = 0; i < TaskIDsForUpdatedSelection.length; i++) {
                            var taskIDNew1 = TaskIDsForUpdatedSelection[i];
                            $('#TasksSelectionTable tr').each(function () {
                                var row = $(this);
                                var taskIDExisting = row.find('td:nth-child(1) input[type ="text"]').val();
                                var checkbox = row.find('td:last-child input[type="checkbox"]');
                                if (taskIDExisting == taskIDNew1) {
                                    checkbox.prop('checked', true);
                                }
                            });
                        }
                        $(".Resourcedetailpanel").show();
                        $(".offcanvas-body").animate(
                            {
                                scrollTop: $(".Resourcedetailpanel").offset().top - 60,
                            },
                            "slow"
                        );
                        //used to disable grid
                        $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, .paginate_button, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
                        $(".table").resize();
                        var tasksTobeUpdated = [];
                        var result = validateStartDateEndDate();
                        var alertifyMsg = result.msg;
                        tasksTobeUpdated = result.tasksWithinRange;
                        GetSelectedTaskList();
                        if (tasksTobeUpdated.length != 0) {                            
                            for (var i = 0; i < tasksTobeUpdated.length; i++) {
                                var taskID = tasksTobeUpdated[i];
                                if (taskID != undefined) {
                                    var row = $('#txtselectedStartDate' + taskID);
                                    row.addClass('light-red-background');
                                }
                            }
                            $("#txtDropDownValidation").show();
                        } else {
                            $("#txtDropDownValidation").hide();
                        }
                        //GetSelectedTaskList();
                        $(".ResAllctnContent").hide();
                        $(".ResourceAllocationSec").removeClass('d-none').fadeIn();
                    }
                }
            }            
        }
        /*
        Created By : Vishal Mane
        Created Date : 29/09/2023
        Purpose : Common ajax function 
        */
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
           
            //StartLoader("#ResReall_mainbody");
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    
                    //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                  
                    ajaxResult = data;
                },
                error: function (err) {
                    //ajaxResult = undefined;
                    //console.log(err);
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //StopAjaxLoader("#ResReall_mainbody");
            return ajaxResult;
        }   
        /*
        Created By : Vishal Mane
        Created Date : 29/09/2023
        Purpose : for Loader Start
        */
        function StartLoader(bodyID) {
            var progress2 = new LoadingOverlayProgress({
                bar: {
                    "background": "#ddd",
                    "top": "50px",
                    "height": "30px",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
                },
            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }
        /*
        Created By : Vishal Mane
        Created Date : 29/09/2023
        Purpose : for Loader Stop
        */
        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {
            });
        }

        /*
        Created By : Vishal Mane
        Created Date : 23/10/2023
        Purpose : To get Resource Profile pic of selected tasks resource
        */
        function getResourceProfileFrom() {            
            var strHTML = "";
            $(".profile-pic").attr("src", "");
            var intFromEmployeeID = $("#txtEmployeeID").text();
            var ResourceTaskDetails = {
                intFromEmployeeID: encodeURI(intFromEmployeeID)               
            }
            var param = JSON.stringify(ResourceTaskDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetEmployeeDetails", param, false);
            if (strResult.length != 0) {
                var ProfilePicUrl = strResult[0].ProfilePicURL
            }
            if (ProfilePicUrl == "") {
                $(".profile-pic").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");
            }
            else {
                $(".profile-pic").attr("src", ProfilePicUrl);
                $("#hiddenProfilePath").val(ProfilePicUrl);
                $("#hiddenProfilePath0").val(ProfilePicUrl);
            }            
        }
        /*
        Created By : Vishal Mane
        Created Date : 23/10/2023
        Purpose : To get Resource Profile pic of Selected Resource dropdown
        */
        function getResourceProfileTo() {            
            var strHTML = "";
            $(".profile-pic1").attr("src", "");
            var intFromEmployeeID = $("#selectResource option:selected").val();
            var ResourceTaskDetails = {
                intFromEmployeeID: encodeURI(intFromEmployeeID)
            }
            var param = JSON.stringify(ResourceTaskDetails)
            var strResult = AJAXCallWithResult("/api/PM_ResourceTaskReallocation/GetEmployeeDetails", param, false);
            if (strResult.length != 0) {
                var ProfilePicUrl = strResult[0].ProfilePicURL
            }
            if (ProfilePicUrl == "") {
                $(".profile-pic1").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");
            }
            else {
                $(".profile-pic1").attr("src", ProfilePicUrl);
                $("#hiddenProfilePath1").val(ProfilePicUrl);
            }
        }
        function refreshTaskLisk() {
            $("table tr").removeClass("rowhiglight");
            $(".Resourcedetailpanel").hide();
            $(".ResourceAllocationSec").hide();
            $(".AllocateResourceSec").show();
            $("#rolerateTbl_wrapper .dataTables_scrollBody, .backbtn, #rolerateTbl_wrapper .paginate_button, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
            $("#offcanvasResScreen").hide();
            $(".offcanvas-backdrop").hide();
            RefreshGrid();
        }        
    </script>
</body>


</html>
