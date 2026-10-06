<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_BulkExtensionWorkflow.aspx.vb" Inherits="Whizible.SM_BulkExtensionWorkflow" %>

<!DOCTYPE html>
<html>
<!--  Created by Vishal Mane on 01/02/2026 to implement bulk extension workflow for Expleo -->
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_BulkExtensionWorkflowMaster")%></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css?v=2">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.2" rel="stylesheet" />

    <style type="text/css">

        .grayShade td{
            background:#f4f6f9 !important;
            color:#6c757d;
            font-weight:500;
        }
        /*.btn-primary {
            background-color: #269c63 !important;
        }*/
        .disabled-icon{
            pointer-events:none;   /* cannot click */
            opacity:0.4;           /* faded */
            cursor:not-allowed;
        }
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
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

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }

        body#bodyGlobal-Resource {
            padding-right: 0 !important;
        }

        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .Resourcedetailpanel:hover {
            cursor: auto;
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

        .dataTable > thead > tr > th[class*="sort"]:after {
            content: "" !important;
        }

        table.dataTable thead > tr > th.sorting_asc,
        table.dataTable thead > tr > th.sorting_desc,
        table.dataTable thead > tr > th.sorting,
        table.dataTable thead > tr > td.sorting_asc,
        table.dataTable thead > tr > td.sorting_desc,
        table.dataTable thead > tr > td.sorting {
            padding-right: inherit;
        }

        body#bodyVisa-Type {
            padding-right: 0 !important;
        }

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
        }

        .clsShowHide {
            display: none !important;
        }

        .filterpanel .issfilter_actiondropdown {
            float: right;
        }

        .issfilter_actiondropdown {
            float: right;
        }

        .filterpanel .MyFiltersdropdown li span i {
            font-size: 14px;
            cursor: pointer;
            padding: 9px;
        }

        .unsavedHeading {
            color: red;
            font-style: italic;
            font-weight: 900;
        }

        .unsavedText {
            color: red;
            font-style: italic;
        }

        .editFilter {
            color: #1359a6;
            border: 1px;
            border-style: dotted;
            background: aliceblue;
        }

        .issuefilter_container .filterpanelbody {
            background: #ffffff;
        }

        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            border-radius: 15px;
            background: #ddd;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

        .clTextCenter {
            text-align: center;
        }

        .clTextLeft {
            text-align: left;
        }

        .clTextRight {
            text-align: right;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .btnrow {
            margin-top: 20px;
        }

        .offcanvas-50 {
            --bs-offcanvas-width: 80%;
        }

        .WF_TopAccordianPanel .accordion-item {
            border: none;
        }

        .WF_TopAccordianPanel
        .accordion-button {
            background-color: #FFF !important;
            border-top: unset;
            box-shadow: unset;
            padding: 0 10px;
            padding-bottom: 0.5rem !important;
            border-bottom: 1px solid #ddd;
            /* color: #9838d5 !important; */
            font-size: 15px;
        }

        .accordion-button {
            background-color: #e7edf0 !important;
            color: #464a4c !important;
            font-weight: 500;
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .AddAttributeBtn {
            width: max-content;
            margin: auto;
        }
        #workFlowOffcvsScreen .form-check-input {
            -webkit-appearance: auto;
            -moz-appearance: auto;
            appearance: auto;
        }
        /*select.form-select {
        -webkit-appearance: none;
        }*/

        /* Added or Modified by Vishal Mane on 24/03/2026 to align Total Records and pagination controls */
        #tbl_Workflow_wrapper .row:last-child {
            display: flex;
            justify-content: flex-end !important;
            align-items: center;
            gap: 8px;
        }

        #tbl_Workflow_wrapper .row:last-child > div {
            width: auto !important;
            max-width: none !important;
            flex: 0 0 auto !important;
            padding-left: 0 !important;
            padding-right: 0 !important;
        }

        #tbl_Workflow_wrapper .dataTables_info,
        #tbl_Workflow_wrapper .dataTables_paginate {
            float: none !important;
            width: auto !important;
            margin: 0 !important;
            padding: 0 !important;
            white-space: nowrap !important;
        }

        #tbl_Workflow_wrapper .dataTables_paginate {
            display: inline-flex !important;
            align-items: center;
            gap: 0;
        }

        #tbl_Workflow_wrapper .dataTables_paginate .paginate_button {
            min-width: 28px;
            height: 24px;
            line-height: 14px;
            padding: 4px 8px;
            margin-left: 0;
            cursor: default !important;
        }

        #tbl_Workflow_wrapper .dataTables_paginate .paginate_button.previous {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        #tbl_Workflow_wrapper .dataTables_paginate .paginate_button.next {
            border-left: 0;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }

        #tbl_Workflow_wrapper .dataTables_paginate .paginate_button.disabled {
            cursor: default !important;
        }

        /*Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list*/
        .offcanvas-close-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            background: transparent;
            border: none;
            border-radius: 4px;
            color: #374151;
            font-size: 18px;
            line-height: 1;
            cursor: pointer;
            opacity: 0.6;
            transition: opacity 0.15s ease, background 0.15s ease;
            flex-shrink: 0;
        }

        .offcanvas-close-btn:hover {
            opacity: 1;
            background: rgba(0, 0, 0, 0.08);
        }

        .offcanvas-close-btn:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.25);
        }

        .page-header {
           /* background-color: #e7edf0;*/
            padding: 12px 14px;
            margin-bottom: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #e9ecef;
            margin: 0px;
        }

        .header-icon {
            width: 26px;
            height: 26px;
            background-color: #1e40af;
            border-radius: 6px;
            margin-top: -5px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 18px;
            flex-shrink: 0;
        }

        .header-content {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .page-title {
            color: #1e40af;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
            line-height: 1.2;
        }

        .page-subtitle {
            color: #6B7280;
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 4px;
            margin-left: -42px;
        }

        .highlight-box {
            display: inline-block;
            background-color: #fff3cd;   /* light yellow */
            color: #856404;
            padding: 4px 10px;
            border-radius: 6px;
            border: 1px solid #ffeeba;
            font-weight: 500;
        }

         /* Added by Vishal Mane on 11/03/2026 for UI changes */


    </style>

</head>

<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyVisa-Type">
    <div class="bgwhite">
        <%--<div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_BulkExtensionWorkflowMaster")%></h5>
            <div class="clearfix"></div>
        </div>--%>

        <div class="graybg page-header">
            <div class="header-icon">
                <i class="fas fa-project-diagram"></i>
            </div>
            <div class="header-content">
                <h5 class="page-title"><%=MyBase.GetResourceString("C_BulkExtensionWorkflowMaster") %></h5>
                <p class="page-subtitle">Create, manage, and control workflow configurations including status, activation, and revision tracking.</p>
            </div>
        </div>
        <div class="clearfix"></div>

        <div class="row align-items-center pt-1 pb-1 px-3">
            <!-- Search Box -->
            <div class="col-sm-3">
                <div class="input-group">
                    <input id="searchWorkfloNameInput" type="text" placeholder="Search Workflow Name" onkeyup="searchWorkfloName()" class="form-control input-sm">
                    <button class="btn btn-default srchBtn" type="submit"><i class="fas fa-search"></i></button>
                </div>
            </div>
            <div class="col-sm-5"></div>
            <div class="col-sm-4 d-flex justify-content-end gap-2">
                <a href="javascript:;" class="btn borderbtn backbtn"
                    id="AddStatus" data-bs-toggle="offcanvas" data-bs-target="#workFlowOffcvsScreen"
                    title="Add" onclick="AddStatus()">
                    <i class="fa fa-plus"></i><%=MyBase.GetResourceString("C_Add")%>
                </a>

                <button class="btn borderbtn" id="DeleteStatus"
                    onclick="DeleteWorkflowConfirmation();" data-bs-toggle="tooltip" title="Delete">
                    <%=MyBase.GetResourceString("C_Delete")%>
                </button>
            </div>
        </div>
        <div class="content pt-1">
            <table class="table table-bordered GRPtbl" style="width: 100%;" id="tbl_Workflow">
                <thead>
                    <tr>
                        <th class="text-start" style="width:40%"><%=MyBase.GetResourceString("C_WorkflowName")%></th>
                        <th class="text-center" style="width:15%"><%=MyBase.GetResourceString("C_Active")%></th>
                        <th class="text-center" style="width:20%"><%=MyBase.GetResourceString("C_Status")%></th>
                        <th class="text-center" style="width:10%"><%=MyBase.GetResourceString("C_RevisionNumber")%></th>
                        <th class="text-center pe-2" style="width:15%">
                            <div class="custom_chckbox">
                                <input id="Statuscheck0" class="chckHead" type="checkbox">
                                <label for="Statuscheck0"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tbl_Workflow_Body">
                </tbody>
            </table>
        </div>

        <div class="clearfix"></div>
    </div>

    <div class="modal custmodal fade" id="DeleteConfirmMModal" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_DeleteWorkflow")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notebox">
                        <strong><%=MyBase.GetResourceString("C_Note")%> </strong><%=MyBase.GetResourceString("C_WorkflowIsInUse")%><br />
                        <p id="showdeleterow"></p>
                    </div>
                    <div class="text-end">
                        <button class="btn borderbtn" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="Ok"><%=MyBase.GetResourceString("C_Ok")%></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Status modal start here-->
    <div id="deleteStatusModal" class="modal fade custmodal" role="dialog" aria-hidden="false" data-bs-backdrop="static">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteConfirmation")%></h4>
                </div>
                <div class="modal-body">
                    <p class="text-center"><%=MyBase.GetResourceString("C_DeleteYesNo")%></p>
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="No"><%=MyBase.GetResourceString("C_No")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal" onclick="DeleteWorkflowAfterConfirm()" data-bs-toggle="tooltip" title="Yes"><%=MyBase.GetResourceString("C_Yes")%></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Delete Status modal end here-->

    <!-- More Details Offcanvas Section starts -->
    <div class="offcanvas offcanvas-end offcanvas-50" data-bs-scroll="false" tabindex="-1"
        id="workFlowOffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
        <input type="hidden" id="hdnWorkflow_UniqueIDTab" name="hdnWorkflow_UniqueIDTab">
        <div class="offcanvas-body">
            <div class="container-fluid py-2 graybg mb-2">
                <div class="row align-items-center">
                    <div class="col-sm-12">
                        <%--<div class="d-flex align-items-center font-weight-600">
                            <span>
                                <bold><%=MyBase.GetResourceString("C_WorkflowDetails")%></bold></span>
                        </div>--%>
                        <div class="d-flex align-items-center justify-content-between font-weight-600">
                                <!-- Modified By Madhuri.K On 03-04-2026 -->
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_WorkflowDetails")%></h5>
                                <button type="button" class="offcanvas-close-btn"
                                    data-bs-dismiss="offcanvas" aria-label="Close" title="Close">
                                    &#x2715;
                                </button>
                            </div>
                    </div>
                </div>
            </div>
            <div id="statusEdtTab" class="statusInfo">
                <div class="row">
                    <div class="col-sm-4">&nbsp;</div>
                    <div class="col-sm-8">
                        <div class="nextBtnDiv d-flex justify-content-end gap-2">
                            <button class="btn btnyellow" id="saveStatusBtn" data-bs-toggle="tooltip" title="Save" onclick="SaveWorkflowDetails(0);"><%=MyBase.GetResourceString("C_Save")%></button>
                            <button class="btn btnyellow" id="btnSaveWorkflowDetails" data-bs-toggle="tooltip" title="Save And Add" onclick="SaveWorkflowDetails(1);"><%=MyBase.GetResourceString("C_SaveAndAdd")%></button>
                            <%--<button class="btn borderbtn" type="button" id="closeStatuBtn" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip" title="Close"><%=MyBase.GetResourceString("C_Close")%></button>--%>
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col-sm-12 text-end">
                        <label class="form-label ">
                            (<font color="red">*</font>
                            <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                    </div>
                </div>
                <div>
                    <div class="addCGContent">
                        <div class="row form-group mt-3">
                            <div class="col-sm-6 mb-3" id="DivWorkflowCode" style="display:none">
                                <div class="row mb-1">
                                    <div class="col-sm-4 text-end">
                                        <label class="required"><%=MyBase.GetResourceString("C_WorkflowCode")%></label>
                                    </div>
                                    <div class="col-sm-8 text-start">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtWorkflowCode", "txtWorkflowCode", cssClass:="form-control", widthInPixel:=0, maxLength:=100)%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <div class="row mb-1">
                                    <div class="col-sm-4 text-end">
                                        <label class="required"><%=MyBase.GetResourceString("C_WorkflowName")%></label>
                                    </div>
                                    <div class="col-sm-8 text-start">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtWorkflowName", "idtxtWorkflowName", cssClass:="form-control", widthInPixel:=0, maxLength:=100)%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-6 mb-3" id="DivRevisionNo" style="display:none">
                                <div class="row mb-1" >
                                    <div class="col-sm-4 text-end">
                                        <label class="required"><%=MyBase.GetResourceString("C_RevisionNumber")%></label>
                                    </div>
                                    <div class="col-sm-8 text-start">
                                        <input type="text" id="txtRevisionNo" name="txtRevisionNo" class="form-control" value="0" disabled/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 mb-3" id="DivIsActive" style="display:none">
                                <div class="row mb-1">
                                    <div class="col-sm-4 text-end">
                                        <label class="required"><%=MyBase.GetResourceString("C_IsActive")%></label>
                                    </div>
                                    <div class="col-sm-8 text-start">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="IsActive" name="IsActive" value="true" checked>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="margin-top:30px;"></div>
                    <div class="accordion WF_TopAccordianPanel my-3" id="CListDetailsAcc">
                        <div class="accordion-item mb-3">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#CListDetailsTab" aria-expanded="true">
                                    <%=MyBase.GetResourceString("C_FieldsStagesInformation")%>
                                </button>
                            </h2>
                            <div id="CListDetailsTab" class="accordion-collapse collapse show"
                                data-bs-parent="#CListDetailsAcc">
                                <div class="accordion-body px-3">
                                    <div class="TabSection">
                                        <ul class="nav nav-tabs detailsubtabs">
                                            <li class="nav-item">
                                                <a class="nav-link active" href="#StageWorkflowTab" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_Stage")%></a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#ApplicableAttributesTab" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_ ApplicableAttributes")%></a>
                                            </li>
                                        </ul>
                                        <div class="tab-content py-3">
                                            <div id="StageWorkflowTab" class="tab-pane active">
                                                <div class="AnsSetDetails">
                                                    <div class="container-fluid gx-0">
                                                        <div class="table-responsive">
                                                            <div>
                                                            <button class="btn btnyellow float-end mb-2 me-1" id="btnSaveStages" data-bs-toggle="tooltip" title="Save" onclick="SaveStages();"><%=MyBase.GetResourceString("C_Save")%></button>
                                                            <%--<button class="btn btn-primary float-end mb-2 me-1" id="btnSaveStages" data-bs-toggle="tooltip" title="Save" onclick="SaveStages();"><%=MyBase.GetResourceString("C_ConfigureStages")%></button>--%>
                                                        </div>
                                                            <table id="StageWorkflowTable" class="table table-bordered" style="width: 100%;">
                                                                <thead class="stickyTblHeader">
                                                                    <tr>
                                                                        <th style="width:10%"><%=MyBase.GetResourceString("C_Order")%></th>
                                                                        <th style="width:30%"><%=MyBase.GetResourceString("C_StageName")%></th>
                                                                        <th style="width:30%"><%=MyBase.GetResourceString("C_StageApproverRole")%></th>
                                                                        <th style="width:10%"><%=MyBase.GetResourceString("C_Mandatory")%></th>
                                                                        <th style="width:10%"><%=MyBase.GetResourceString("C_Applicable")%></th>
                                                                        <th style="width:10%"><%=MyBase.GetResourceString("C_Action")%></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="StageWorkflowTable_Tbody">
                                                                
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <br />
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="ApplicableAttributesTab" class="tab-pane">
                                                <div class="ApplicableAttributesInfo">                                                    
                                                    <div class="row form-group px-2">
                                                        <div>
                                                            <button class="btn btnyellow float-end" id="saveAttributesBtn" data-bs-toggle="tooltip" title="Save" onclick="SaveAttributes();"><%=MyBase.GetResourceString("C_Save")%></button>
                                                            <%--<button class="btn btn-primary float-end" id="saveAttributesBtn" data-bs-toggle="tooltip" title="Save" onclick="SaveAttributes();"><%=MyBase.GetResourceString("C_ConfigureAttributes")%></button>--%>
                                                        </div>
                                                        <table id="tbl_ApplicableAttributes" class="table table-bordered mt-2">
                                                            <thead>
                                                                <tr>
                                                                    <th style="width:8%"><%=MyBase.GetResourceString("C_SrNo")%></th>
                                                                    <th style="width:25%"><%=MyBase.GetResourceString("C_Practice")%></th>
                                                                    <th style="width:25%"><%=MyBase.GetResourceString("C_BusinessGroup")%></th>
                                                                    <th style="width:25%"><%=MyBase.GetResourceString("C_OrganizationUnit")%></th>
                                                                    <th style="width:7%"><%=MyBase.GetResourceString("C_Applicable")%></th>
                                                                    <th style="width:10%"><%=MyBase.GetResourceString("C_Action")%></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tbl_ApplicableAttributes_Body">
                                                               
                                                            </tbody>
                                                        </table>
                                                        <button type="button" class="btn btn-primary btn-sm AddAttributeBtn" id="btnAddAttribute">
                                                            <%=MyBase.GetResourceString("C_AddAttribute")%>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- More Details Offcanvas Section ends -->


    <!-- Publish Stages modal start here-->
    <div id="publishStagesModal" class="modal fade custmodal" role="dialog" aria-hidden="false" data-bs-backdrop="static">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
                </div>
                <div class="modal-body">
                    <p class="text-center"><%=MyBase.GetResourceString("C_PublishConfirmationNote")%></p>
                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="No"><%=MyBase.GetResourceString("C_No")%></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal" onclick="PublishWorkflowStages()" data-bs-toggle="tooltip" title="Yes"><%=MyBase.GetResourceString("C_Yes")%></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Publish Stages modal start here-->
    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>

    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>

    <script>
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();

        $(function () {
            $("[rel='tooltip']").tooltip();
        });
        $("[data-toggle=tooltip").tooltip();

        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';

        var UserName = '<%= Session("strUserName") %>';
        var TagID = 719;

        var noOfRowsPerPage = 10;
        var DeleteRecord = '<%=MyBase.GetResourceString("A_AtLeastRecord")%>';
        var NoDataFound = '<%=MyBase.GetResourceString("NoDataFound")%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var tbl_Workflow;
        $(document).ready(function () {
            $('.btn, a').tooltip({ trigger: 'hover' });
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });

            $(document).on("click", function () {
                $(".tooltip").removeClass('show');
            });
            if (blnAddAccess == "False") {
                $("#AddStatus").addClass("clsShowHide");
                $('#btnSaveWorkflowDetails').attr("disabled", true);
            }
            else {
                $("#AddStatus").removeClass("clsShowHide");
                $('#btnSaveWorkflowDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteStatus").addClass("clsShowHide");
            }
            else {
                $("#DeleteStatus").removeClass("clsShowHide");
            }
            if (blnViewAccess == "True") {
                GetWorkflowMasterDetails();
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }


        });

        function AddStatus() {
            $('#idtxtWorkflowName').attr("disabled", false);
            $('#btnSaveWorkflowDetails').attr("disabled", false);
            //$('#txtWorkflowCode').attr("disabled", false);
            $('#txtWorkflowCode').attr("disabled", true);
            $("#hdnWorkflow_UniqueIDTab").val(0);
            $('#idtxtWorkflowName').val("");
            $("#txtWorkflowCode").val("");
            $("#txtRevisionNo").val("0");
            $("#CListDetailsAcc").hide();
            $("#DivIsActive").hide();
            $("#DivRevisionNo").hide();
            $("#DivWorkflowCode").hide();
        }
        var GlobalWorkflowID = 0;
        $('#tbl_Workflow_Body').on('click', '.clEditVisalink', function () {
            //debugger
            $("#DivIsActive").show();
            $("#DivRevisionNo").show();
            $("#DivWorkflowCode").show();
            $("#CListDetailsAcc").show();
            var isCheckOrNOt = "No";
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            $('#txtWorkflowCode').attr("disabled", true);
            GlobalWorkflowID = $row.find(".hdn_WorkflowId").val();
            //alert(GlobalWorkflowID);
            $.each($tds, function (index, obj) {
                var hiddenField = $(this).find("#hdn_WorkflowId").val();
                //var hiddenField = $(this).find(".hdn_WorkflowId").val();                
                var hiddenSystemStatus = $(this).find("#hdn_WorkFlowCode").val();
                var hiddenIsActive = $(this).find("#hdn_IsActive").val();
                var hiddenRevisionNumber = $(this).find("#hdn_RevisionNumber").val();                
                
                if (hiddenField != 'undefined' && hiddenField != null) {
                    var eventId = hiddenField;
                    $('#hdnWorkflow_UniqueIDTab').val(eventId);
                    $('#idtxtWorkflowName').val($(this).text());
                    $('#txtWorkflowCode').val(hiddenSystemStatus);
                    $('#IsActive').prop('checked', hiddenIsActive === "true");
                    $('#txtRevisionNo').val(hiddenRevisionNumber);
                }
                //$('#AddStatusModal').modal('show');
            });
            bindStages();
            bindAttribute();
        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 230, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        $(".chckHead").change(function () {
            var allPages = tbl_Workflow.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#tbl_Workflow").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedStatusID.push(parseInt($(rows[i]).find("#hdn_WorkflowId").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedStatusID = [];
                }
            }
        });

        function checkUncheck() {
            if (tbl_Workflow.$('input:checked').length == tbl_Workflow.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").prop("checked", false);
            }
        }
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            tbl_Workflow = $('#tbl_Workflow').dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
                pageLength: 10,
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }],
                pagingType: "simple",
                language: {
                    info: "Total Records: _TOTAL_",
                    infoEmpty: "Total Records: 0",
                    paginate: {
                        previous: "<<",
                        next: ">>"
                    }
                }
            });
        }

        function GetWorkflowMasterDetails() {
            //debugger
            SelectedStatusID = [];
            var strHTML = "";
            StartLoader("#bodyVisa-Type");
            var Result = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/GetWorkflowMasterDetails", '', false);
            var visaList = Result;
            statusList = Result
            if (visaList.length > 0) {
                $.each(visaList, function (index, obj) {
                    if (blnEditAccess == "True") {
                        strHTML += '<tr><td class="text-start"><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#workFlowOffcvsScreen" class="clEditVisalink"</a><input type = "hidden" name = "hdn_IsActive" id = "hdn_RevisionNumber" value = ' + obj.RevisionNo + '><input type="hidden" name="hdn_IsActive" id="hdn_IsActive" value= ' + obj.IsActive + '>';
                        //strHTML += '<input type = "hidden" name = "hdn_WorkFlowCode" id = "hdn_WorkFlowCode" value = ' + obj.WorkflowCode + '>';
                        strHTML += `<input type="hidden" name="hdn_WorkFlowCode" id="hdn_WorkFlowCode" value="${obj.WorkflowCode}">`;
                        strHTML += '<input type = "hidden" name = "hdn_WorkflowName" id = "hdn_WorkflowName" value = ' + obj.WorkflowName + ' > ' + obj.WorkflowName + '<input type = "hidden" name = "hdn_WorkflowId" id = "hdn_WorkflowId" class="hdn_WorkflowId" value = ' + obj.WorkflowID + ' ></td>';
                        if (obj.IsActive == 1) {
                            strHTML += '<td class="text-center">Yes</td>';
                        } else {
                            strHTML += '<td class="text-center">No</td>';
                        }
                        if (obj.WorkflowStatus === "Publish Stages") {
                            strHTML += `<td class="text-center"><a href="javascript:;" class="clsPublishLink"</a>${obj.WorkflowStatus}</td>`;
                        } else {
                            strHTML += `<td class="text-center">${obj.WorkflowStatus}</td>`;
                        }
                        strHTML += '<td class="text-center">' + obj.RevisionNo + '</td>';
                        strHTML += '<td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                    }
                    else {
                        //strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_WorkflowName" id="hdn_WorkflowName" value= ' + obj.WorkflowName + '>' + obj.WorkflowName + '<input type="hidden" name="hdn_WorkflowId" id="hdn_WorkflowId" value= ' + obj.WorkflowID + '></td><td class="text-start">' + obj.WorkflowCode + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                        strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_IsActive" id="hdn_IsActive" value= ' + obj.IsActive + '><input type="hidden" name="hdn_WorkFlowCode" id="hdn_WorkFlowCode" value= ' + obj.WorkflowCode + '><input type="hidden" name="hdn_WorkflowName" id="hdn_WorkflowName" value= ' + obj.WorkflowName + '>' + obj.WorkflowName + '<input type="hidden" name="hdn_WorkflowId" id="hdn_WorkflowId" value= ' + obj.WorkflowID + ' ></td>';
                        //strHTML += '<td class="text-start">' + obj.IsActiveText + '</td>';
                        if (obj.IsActive == 1) {
                            strHTML += '<td class="text-center">Yes</td>';
                        } else {
                            strHTML += '<td class="text-center">No</td>';
                        }
                        if (obj.Published == 0) {
                            strHTML += '<td class="text-center">Draft</td>';
                        }
                        //else if (obj.Published == 0) {
                        //    strHTML += '<td class="text-center">Publish Stages</td>';
                        //}
                        else {
                            strHTML += '<td class="text-center">Publish Stages</td>';
                        }
                        strHTML += '<td class="text-center">' + obj.RevisionNo + '</td>';
                        strHTML += '<td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';

                    }
                });
            }
            $('#tbl_Workflow').dataTable().fnDestroy();
            $("#tbl_Workflow_Body").html(strHTML);
            LoadPagination(Result);
            StopAjaxLoader("#bodyVisa-Type");
            $(".chckHead").prop("checked", false);
        }

        $('#tbl_Workflow_Body').on('click', '.clsPublishLink', function () {
            $('#publishStagesModal').modal('show');
            var $row = $(this).closest("tr");
            GlobalWorkflowID = $row.find(".hdn_WorkflowId").val();
            //alert(GlobalWorkflowID);
        });

        function PublishWorkflowStages() {
            //debugger
            var Parameters = {
                WorkflowID: GlobalWorkflowID,
                CreatedBy: encodeURI(UserName)
            };
            var Param = JSON.stringify(Parameters);
            var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/PublishWorkflowStages", Param, false);
            alertify.set('notifier', 'position', 'top-right');
            alertify.success(data);
            GetWorkflowMasterDetails();
        }
        
        function ReloadTableSearchForItem(Result) {
            var strHTML = "";
            $('#tbl_Workflow').dataTable().fnDestroy();
            $("#tbl_Workflow_Body").html("");
            var visaList = Result;
            if (visaList.length > 0) {
                $.each(visaList, function (index, obj) {
                    if (blnEditAccess == "True") {
                        strHTML += '<tr><td class="text-start"><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#workFlowOffcvsScreen" class="clEditVisalink"</a><input type = "hidden" name = "hdn_IsActive" id = "hdn_RevisionNumber" value = ' + obj.RevisionNo + '><input type="hidden" name="hdn_IsActive" id="hdn_IsActive" value= ' + obj.IsActive + '>';
                        //strHTML += '<input type = "hidden" name = "hdn_WorkFlowCode" id = "hdn_WorkFlowCode" value = ' + obj.WorkflowCode + '>';
                        strHTML += `<input type="hidden" name="hdn_WorkFlowCode" id="hdn_WorkFlowCode" value="${obj.WorkflowCode}">`;
                        strHTML += '<input type = "hidden" name = "hdn_WorkflowName" id = "hdn_WorkflowName" value = ' + obj.WorkflowName + ' > ' + obj.WorkflowName + '<input type = "hidden" name = "hdn_WorkflowId" id = "hdn_WorkflowId" class="hdn_WorkflowId" value = ' + obj.WorkflowID + ' ></td>';
                        if (obj.IsActive == 1) {
                            strHTML += '<td class="text-center">Yes</td>';
                        } else {
                            strHTML += '<td class="text-center">No</td>';
                        }
                        if (obj.WorkflowStatus === "Publish Stages") {
                            strHTML += `<td class="text-center"><a href="javascript:;" class="clsPublishLink"</a>${obj.WorkflowStatus}</td>`;
                        } else {
                            strHTML += `<td class="text-center">${obj.WorkflowStatus}</td>`;
                        }
                        strHTML += '<td class="text-center">' + obj.RevisionNo + '</td>';
                        strHTML += '<td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                    }
                    else {
                        //strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_WorkflowName" id="hdn_WorkflowName" value= ' + obj.WorkflowName + '>' + obj.WorkflowName + '<input type="hidden" name="hdn_WorkflowId" id="hdn_WorkflowId" value= ' + obj.WorkflowID + '></td><td class="text-start">' + obj.WorkflowCode + '</td><td><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';
                        strHTML += '<tr><td class="text-start"><input type="hidden" name="hdn_IsActive" id="hdn_IsActive" value= ' + obj.IsActive + '><input type="hidden" name="hdn_WorkFlowCode" id="hdn_WorkFlowCode" value= ' + obj.WorkflowCode + '><input type="hidden" name="hdn_WorkflowName" id="hdn_WorkflowName" value= ' + obj.WorkflowName + '>' + obj.WorkflowName + '<input type="hidden" name="hdn_WorkflowId" id="hdn_WorkflowId" value= ' + obj.WorkflowID + ' ></td>';
                        //strHTML += '<td class="text-start">' + obj.IsActiveText + '</td>';
                        if (obj.IsActive == 1) {
                            strHTML += '<td class="text-center">Yes</td>';
                        } else {
                            strHTML += '<td class="text-center">No</td>';
                        }
                        if (obj.Published == 0) {
                            strHTML += '<td class="text-center">Draft</td>';
                        } else if (obj.Published == 0) {
                            strHTML += '<td class="text-center">Publish Stages</td>';
                        }
                        strHTML += '<td class="text-center">' + obj.RevisionNo + '</td>';
                        strHTML += '<td class="text-center"><div class="custom_chckbox"><input id="' + index + '" onclick="checkUncheck();GetSelectedStatusDetails(this);" class="chcktbl" type="checkbox"><label for="' + index + '"></label></div></td></tr>';

                    }
                });
            }
            $('#tbl_Workflow').dataTable().fnDestroy();
            $("#tbl_Workflow_Body").html(strHTML);
            LoadPagination(Result);
            //StopAjaxLoader("#bodyVisa-Type");
            $(".chckHead").prop("checked", false);
        }

        var statusList = '';
        function searchWorkfloName() {
            var SearchText = $("#searchWorkfloNameInput").val().trim().replace(/'/g, "''");
            if (SearchText == "") {
                GetWorkflowMasterDetails();
            }
            else {
                var statusListData = statusList.filter(function (x) { return x.WorkflowName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
                if (statusListData.length == 0) {
                    var strHTML = "";
                    $('#tbl_Workflow').dataTable().fnDestroy();
                    $("#tbl_Workflow_Body").html(strHTML);
                    LoadPagination(Result);
                    $(".chckHead").prop("checked", false);
                }
                else {
                    ReloadTableSearchForItem(statusListData);
                }
            }
        }
        function clearVTDetail() {
            $("#hdnWorkflow_UniqueIDTab").val(0);
            $("#idtxtWorkflowName").val("");
            $("#txtWorkflowCode").val("");
            Details = {};
        }
        //disabled copy and paste
        //$('#idtxtWorkflowName').bind('copy paste', function (e) {
        //    e.preventDefault();
        //});

        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
                var isSpecialCharacter = 0;
                for (var i = 0; i < regularExpression.length; i++) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1
                    }
                }
                if (isSpecialCharacter == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }
        }
        function SaveWorkflowDetails(isFromSaveAndclick) {
            //var WorkFlowName = $("#idtxtWorkflowName").val().replace(/'/g, "''");
            var WorkFlowName = $("#idtxtWorkflowName").val()
                .replace(/'/g, "''")      // escape single quote
                .replace(/\s+/g, ' ')     // remove extra spaces
                .trim();
            //var WorkFLowCode = $("#txtWorkflowCode").val();
            var WorkFLowCode = $("#txtWorkflowCode").val()
                .replace(/'/g, "''")      // escape single quote
                .replace(/\s+/g, ' ')     // remove extra spaces
                .trim();
            if (WorkFlowName.length > 0) {
                if (WorkFLowCode.length > 0 && checkSpecialCharacter($("#txtWorkflowCode").val().trim(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Workflow Code should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtWorkflowCode").focus();
                    return;
                }
                <%--else if (WorkFLowCode.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_WorkflowMandatory")%>');
                    $("#txtWorkflowCode").focus();
                    return;
                }--%>
                else if (checkSpecialCharacter($("#idtxtWorkflowName").val().trim(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Workflow Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#idtxtWorkflowName").focus();
                }
                else {
                    var WorkflowID = $("#hdnWorkflow_UniqueIDTab").val();
                    var IsActive = $('#IsActive').is(':checked') ? 1 : 0;
                    var RevisionNumber = $("#txtRevisionNo").val();
                    var Parameters = {
                        WorkflowID: WorkflowID > 0 ? WorkflowID : 0,
                        WorkflowName: WorkFlowName,
                        WorkflowCode: WorkFLowCode,
                        IsActive: IsActive,
                        RevisionNumber: RevisionNumber,
                        CreatedBy: encodeURI(UserName)
                    };
                    var Param = JSON.stringify(Parameters);
                    var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/SaveWorkflowDetails", Param, false);
                    if (isFromSaveAndclick == 0) {          
                        if (data[0]["Result"] == "Bulk Extension Workflow Name already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data[0]["Result"]);
                        }
                        else if (data[0]["Result"] == "Bulk Extension Workflow Code already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data[0]["Result"]);
                        }
                        else {                            
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data[0]["Result"]);
                            GlobalWorkflowID = data[0]["WorkflowID"];
                            $("#hdnWorkflow_UniqueIDTab").val(GlobalWorkflowID);
                            $("#CListDetailsAcc").show();
                            $("#DivIsActive").show();
                            $("#DivRevisionNo").show();
                            $("#DivWorkflowCode").show();
                            bindStages();
                            bindAttribute();
                            //$("#idtxtWorkflowName").val(WorkFlowName);
                            $("#idtxtWorkflowName").val(data[0]["WorkflowName"]);
                            $("#txtWorkflowCode").val(data[0]["WorkflowCode"]);
                            GetWorkflowMasterDetails();
                        }
                    }
                    else {                                                           // Save and Add                        
                        if (data[0]["Result"] == "Bulk Extension Workflow Name already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data[0]["Result"]);
                        }
                        else if (data[0]["Result"] == "Bulk Extension Workflow Code already exist.") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data[0]["Result"]);
                        }
                        else {
                            clearVTDetail();
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(data[0]["Result"]);
                            $("#CListDetailsAcc").hide();
                            $("#DivIsActive").hide();
                            $("#DivRevisionNo").hide();
                            $("#DivWorkflowCode").hide();
                            //$('#txtWorkflowCode').attr("disabled", false);
                            $('#txtWorkflowCode').attr("disabled", true);
                            //$("#idtxtWorkflowName").val(data[0]["WorkflowName"]);
                            //$("#txtWorkflowCode").val(data[0]["WorkflowCode"]);
                            GetWorkflowMasterDetails();
                        }
                    }
                }
            }
            else {
                <%--if (WorkFLowCode.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error('Workflow Code is mandatory');
                    alertify.error('<%=MyBase.GetResourceString("A_WorkflowMandatory")%>');
                    $("#txtWorkflowCode").focus();
                    return;
                }
                else {
                    $("#idtxtWorkflowName").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Status is mandatory");
                    //alertify.error('Workflow Name is mandatory');
                    alertify.error('<%=MyBase.GetResourceString("A_WorkflowName")%>');
                }--%>

                $("#idtxtWorkflowName").focus();
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error('Workflow Name is mandatory');
                alertify.error('<%=MyBase.GetResourceString("A_WorkflowName")%>');
            }
        }
        var SelectedStatusID = [];
        function GetSelectedStatusDetails(currentObject) {
            var row = $(currentObject).closest("tr");
            if (row.find('input[type="checkbox"]').is(':checked')) {
                SelectedStatusID.push(parseInt(row.find('#hdn_WorkflowId').val()));
            }
            else {
                if (SelectedStatusID != 'undefined' && SelectedStatusID.length > 0) {
                    var removeEmp = row.find('#hdn_WorkflowId').val();
                    SelectedStatusID.remove(parseInt(removeEmp));
                }
            }

        }
        Array.prototype.remove = function () {
            var what, a = arguments, L = a.length, ax;
            while (L && this.length) {
                what = a[--L];
                while ((ax = this.indexOf(what)) !== -1) {
                    this.splice(ax, 1);
                }
            }
            return this;
        };

        function DeleteWorkflowConfirmation() {
            var selectedStatusUniqueId = SelectedStatusID.toString();
            if (selectedStatusUniqueId.length > 0) {
                $('#deleteStatusModal').modal('show');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
        }

        function DeleteWorkflowAfterConfirm() {
            var strHTML = "";
            var selectedStatusUniqueId = SelectedStatusID.toString();
            if (selectedStatusUniqueId.length > 0) {
                var Param = JSON.stringify(selectedStatusUniqueId);
                var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/DeleteStatusDetails", Param, false);
                StopAjaxLoader("#bodyVisa-Type");
                GetWorkflowMasterDetails();
                strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                $('#showdeleterow').html(strHTML);
                $('#DeleteConfirmMModal').modal('show');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedStatusID = [];
            selectedStatusUniqueId = "";
        }

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
        }
        //Added by Vishal Mane on 05/02/2026 for Applicable Attributes    
        
        // Added by Vishal Mane on 04/02/2026 to add UI Changes for Attributes dropdowns
        function updateSrNo() {
            $('#tbl_ApplicableAttributes_Body tr').each(function (index) {
                $(this).find('.srno').text(index + 1);
            });
        }
        $(document).on('click', '.delete-attr', function () {
            $(this).closest('tr').remove();
            updateSrNo();
        });
        var RowIndex = 0;
        $('#btnAddAttribute').on('click', function () {
            let lastRow = $('#tbl_ApplicableAttributes_Body tr:last');
            if (lastRow.length > 0) {
                let practice = lastRow.find('.cboPracticeType').val();
                let bg = lastRow.find('.cboProjectBG').val();
                let ou = lastRow.find('.cboProjectOU').val();
                let isPractice = practice && practice != "0";
                let isBG = bg && bg != "0";
                let isOU = ou && ou != "0";
                if (!isPractice && !isBG && !isOU) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Please select at least one value in the last row before adding a new attribute.");
                    alertify.error('<%=MyBase.GetResourceString("A_AtleastOneAttribute")%>');
                    lastRow.find('select:first').focus();
                    return false;
                }
            }
            RowIndex++;
            let row = `
                <tr class="attr-row" data-row="${RowIndex}">
                        <td class="srno text-center"></td>
                        <td>
                        <select class="form-select cboPracticeType"
                                id="cboPracticeType_${RowIndex}">
                        </select>
                    </td>
                    <td>
                        <select class="form-select cboProjectBG"
                                id="cboProjectBG_${RowIndex}"
                                onchange="BG_Onchange(${RowIndex})">
                        </select>
                    </td>
                    <td>
                        <select class="form-select cboProjectOU"
                                id="cboProjectOU_${RowIndex}">
                        </select>
                    </td>
                    <!-- Applicable checkbox -->
                    <td class="text-center">
                        <input type="checkbox"
                                class="form-check-input chkApplicable"
                                id="chkApplicable_${RowIndex}" checked />
                    </td>
                    <td class="text-center">
                        <!--<i class="far fa-check-circle text-success save-attr" title="Save"></i>-->
                        <!--<i class="fas fa-pen text-primary edit-attr ms-2" title="Edit"></i>-->
                        <i class="fas fa-trash-alt text-danger delete-attr ms-2" title="Delete"></i>
                    </td>
                </tr>
            `;
            $('#tbl_ApplicableAttributes_Body').append(row);
            updateSrNo();
            GetPracticeType(RowIndex);
            GetBusinessGroup(RowIndex);
            var BGID = 0;
            GetLocation(BGID, RowIndex);
        });
        $(document).on('click', '.save-attr', function () {
            $(this).closest('tr').find('select').prop('disabled', true);
            $('.selectpicker').selectpicker('refresh');
        });
        $(document).on('click', '.edit-attr', function () {
            $(this).closest('tr').find('select').prop('disabled', false);
            $('.selectpicker').selectpicker('refresh');
        });
        $(document).on('click', '.delete-attr', function () {
            $(this).closest('tr').remove();
        });
        // End of Added by Vishal Mane on 04/02/2026 to add UI Changes for Attributes dropdowns

        //let i = 0;
        function bindAttribute() {
            let payload = {
                //WorkflowID: $("#hdn_WorkflowId").val()
                WorkflowID: GlobalWorkflowID
            };
            var Result = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/GetWorkflowAttribute",JSON.stringify(payload),false);
            RowIndex = Result.length;
            $("#tbl_ApplicableAttributes_Body").html(""); // clear table
            var row = ""
            if (Result.length != 0) {                
                for (var i = 0; i < Result.length; i++) {
                    var PracticeID = Result[i]["PracticeID"];
                    var BusinessGroupID = Result[i]["BusinessGroupID"];
                    var OrganizationUnitID = Result[i]["OrganizationUnitID"];
                    var IsApplicable = Result[i]["IsApplicable"];
                    var ProjectType = Result[i]["ProjectType"];
                    var BusinessGroup = Result[i]["BusinessGroup"];
                    var Location = Result[i]["Location"];
                    row += `
                    <tr class="attr-row" data-row="${i}">
                        <td class="srno text-center"></td>
                        <td>
                            <select class="form-select cboPracticeType"
                                    id="cboPracticeType_${i}" disabled>
                            </select>
                        </td>
                        <td>
                            <select class="form-select cboProjectBG"
                                    id="cboProjectBG_${i}"
                                    onchange="BG_Onchange(${i})" disabled>
                            </select>
                        </td>
                        <td>
                            <select class="form-select cboProjectOU"
                                    id="cboProjectOU_${i}" disabled>
                            </select>
                        </td>
                        <td class="text-center">
                            <input type="checkbox"
                                   class="form-check-input chkApplicable"
                                   id="chkApplicable_${i}"
                                   ${IsApplicable == 1 ? "checked" : ""}/>
                        </td>
                        <td class="text-center">
                            <i class="fas fa-pen text-primary edit-attr ms-2" title="Edit"></i>
                            <!-- <i class="fas fa-trash-alt text-danger ms-2 disabled-icon" title="Delete"></i> -->
                        </td>
                    </tr>`;                    
                }
                $("#tbl_ApplicableAttributes_Body").html(row);
                if (Result.length > 0) {
                    for (var i = 0; i < Result.length; i++) {
                        var PracticeID = Result[i]["PracticeID"];
                        var BusinessGroupID = Result[i]["BusinessGroupID"];
                        var OrganizationUnitID = Result[i]["OrganizationUnitID"];                        
                        var ProjectType = Result[i]["ProjectType"];
                        var BusinessGroup = Result[i]["BusinessGroup"];
                        var Location = Result[i]["Location"];
                        GetPracticeType(i, PracticeID, ProjectType);
                        GetBusinessGroup(i, BusinessGroupID, BusinessGroup);
                        GetLocation(BusinessGroupID, i, OrganizationUnitID, Location);
                        $("#cboPracticeType_" + i).val(PracticeID);
                        $("#cboProjectBG_" + i).val(BusinessGroupID);
                        $("#cboProjectOU_" + i).val(OrganizationUnitID);
                    }
                }
                updateSrNo();
            }
        }

        function GetPracticeType(indexID, PracticeIDI, ProjectTypeI) {
            var Practice = {
                WorkflowID: GlobalWorkflowID
            };
            var Param = JSON.stringify(Practice);
            var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/GetPracticeType", Param, false);
            $("#cboPracticeType_" + indexID).empty();
            if (data && data.length > 0) {
                $.each(data, function (index, item) {
                    $("#cboPracticeType_" + indexID).append(
                        $("<option></option>")
                            .val(item.TypeID)   // or LocationID if API returns that
                            .text(item.ProjectType)
                    );
                });
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue            
            if (PracticeIDI > 0) {
                $("#cboPracticeType_" + indexID).append(
                    $("<option></option>")
                        .val(PracticeIDI)   // or LocationID if API returns that
                        .text(ProjectTypeI)
                );
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
        }
        function GetBusinessGroup(indexID, BusinessGroupIDI, BusinessGroupI) {
            var BussinessGroup = {
                WorkflowID: GlobalWorkflowID
            };
            var Param = JSON.stringify(BussinessGroup);
            var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/GetBusinessGroup", Param, false);
            $("#cboProjectBG_" + indexID).empty();
            if (data && data.length > 0) {
                $.each(data, function (index, item) {
                    $("#cboProjectBG_" + indexID).append(
                        $("<option></option>")
                            .val(item.BusinessGroupID)   // or LocationID if API returns that
                            .text(item.BusinessGroup)
                    );
                });
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
            if (BusinessGroupIDI > 0) {
                $("#cboProjectBG_" + indexID).append(
                    $("<option></option>")
                        .val(BusinessGroupIDI)   // or LocationID if API returns that
                        .text(BusinessGroupI)
                );
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
        }
        function BG_Onchange(indexID) {
            var BGID = $("#cboProjectBG_" + indexID).val();
            GetLocation(BGID, indexID);
        }
        function GetLocation(BGID, indexID, OUID, location) {
            var BussinessGroup = {
                BussinessGroupID: BGID,
                WorkflowID: GlobalWorkflowID
            };
            var Param = JSON.stringify(BussinessGroup);
            var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/GetLocation", Param, false);
            //$("#cboProjectOU").empty();
            $("#cboProjectOU_" + indexID).empty();
            //$("#cboProjectOU").empty();
            if (BGID == 0) {
                if (data && data.length > 0) {
                    $.each(data, function (index, item) {
                        $("#cboProjectOU_" + indexID).append(
                            $("<option></option>")
                                .val(item.LocationID)   // or LocationID if API returns that
                                .text(item.Location)
                        );
                    });
                }
                // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
                if (OUID > 0) {
                    $("#cboProjectOU_" + indexID).append(
                        $("<option></option>")
                            .val(OUID)   // or LocationID if API returns that
                            .text(location)
                    );
                }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
            }
            else {
                if (data && data.length > 0) {
                    $.each(data, function (index, item) {
                        $("#cboProjectOU_" + indexID).append(
                            $("<option></option>")
                                .val(item.OUPoolID)   // or LocationID if API returns that
                                .text(item.Location)
                        );
                    });
                }
                // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
                if (OUID > 0) {
                    $("#cboProjectOU_" + indexID).append(
                        $("<option></option>")
                            .val(OUID)   // or LocationID if API returns that
                            .text(location)
                    );
                }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
            }
        }

        function SaveAttributes() {
            attributeList = [];
            let attrData = getApplicableAttributesData();
            if (!validateApplicableAttributes()) {
                return false; // stop save  
            }
            if (attrData.length == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_NoAttribute")%>');
                return false; // break loop
            }
            let payload = {
                WorkflowID: GlobalWorkflowID, 
                //WorkflowID: $("#hdn_WorkflowId").val(),
                CreatedBy: encodeURI(UserName),
                Attributes: attrData
            };           
            var Result = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/SaveApplicableAttributes", JSON.stringify(payload), false);
            alertify.set('notifier', 'position', 'top-right');
            alertify.success(Result);
            GetWorkflowMasterDetails();
            bindAttribute();
        }
        var attributeList = [];
        function getApplicableAttributesData() {
            attributeList = [];
            $('#tbl_ApplicableAttributes_Body tr').each(function () {
                let row = $(this);
                let OrderNumber = row.find('.srno').text().trim();
                let practiceId = row.find('.cboPracticeType').val();
                let bgId = row.find('.cboProjectBG').val();
                let ouId = row.find('.cboProjectOU').val();
                let Applicable = row.find('.chkApplicable').is(':checked') ? 1 : 0;
                if (
                    practiceId == "" || practiceId == null ||
                    bgId == "" || bgId == null ||
                    ouId == "" || ouId == null
                )
                {
                    return; // to skip this row
                }
                attributeList.push({
                    OrderNo: OrderNumber,
                    PracticeID: practiceId,
                    BusinessGroupID: bgId,
                    OrganizationUnitID: ouId,
                    IsApplicable: Applicable
                });

            });
            return attributeList;
        }

        function validateApplicableAttributes() {

            let isValid = true;
            let rowNo = 0;
            alertify.set('notifier', 'position', 'top-right');
            let practiceSet = new Set();   // practice duplicate
            let bgOuSet = new Set();       // BG + OU duplicate
            let fullSet = new Set();       // Practice+BG+OU duplicate
            let bgSet = new Set();
            let OuSet = new Set();

            
            $('#tbl_ApplicableAttributes_Body tr').each(function () {
                rowNo++;
                let row = $(this);
                let practice = row.find('.cboPracticeType').val();
                let bg = row.find('.cboProjectBG').val();
                let ou = row.find('.cboProjectOU').val();
                row.find('select').removeClass('border-danger');
                let isPractice = practice && practice != "0";
                let isBG = bg && bg != "0";
                let isOU = ou && ou != "0";
                // nothing selected
                if (!isPractice && !isBG && !isOU) {
                    //alertify.error("Row " + rowNo + ": Please select at least one attribute.");
                    //alertify.error("Please select at least one attribute");
                    alertify.error('<%=MyBase.GetResourceString("A_AtLeastOneAttribute1")%>');
                    row.find('.cboPracticeType').addClass('border-danger').focus();
                    isValid = false;
                    return false;
                }
                //  Practice duplicate (NEW RULE ⭐)
                if (isPractice) {
                    if (practiceSet.has(practice)) {
                        //alertify.error("Duplicate Practice not allowed. Practice already used in another row. (Row " + rowNo + ").");
                        //alertify.error("Duplicate Practice not allowed. Practice already used");
                        alertify.error('<%=MyBase.GetResourceString("A_DuplicateAttribute")%>');
                        row.find('.cboPracticeType').addClass('border-danger').focus();
                        isValid = false;
                        return false;
                    }
                    practiceSet.add(practice);
                }
                // Duplicate BG
                if (isBG) {
                    if (bgSet.has(bg)) {
                        //alertify.error("Duplicate Business Group not allowed");
                        alertify.error('<%=MyBase.GetResourceString("A_DuplicateBG")%>');
                        row.find('.cboProjectBG').addClass('border-danger');
                        //row.find('.cboProjectOU').addClass('border-danger').focus();
                        isValid = false;
                        return false;
                    }
                    bgSet.add(bg);
                }
                // Duplicate OU
                if (isOU) {
                    if (OuSet.has(ou)) {
                        //alertify.error("Duplicate Organization Unit not allowed");
                        alertify.error('<%=MyBase.GetResourceString("A_DuplicateOU")%>');
                        row.find('.cboProjectOU').addClass('border-danger').focus();
                        isValid = false;
                        return false;
                    }
                    OuSet.add(ou);
                }
                //  BG + OU duplicate
                if (isBG && isOU) {
                    let bgou = bg + "_" + ou;
                    if (bgOuSet.has(bgou)) {
                        //alertify.error("Duplicate Business Group and Organization Unit combination not allowed (Row " + rowNo + ").");
                        //alertify.error("Duplicate Business Group and Organization Unit combination not allowed");
                        alertify.error('<%=MyBase.GetResourceString("A_DuplicateBGOU")%>');
                        row.find('.cboProjectBG').addClass('border-danger');
                        row.find('.cboProjectOU').addClass('border-danger').focus();
                        isValid = false;
                        return false;
                    }
                    bgOuSet.add(bgou);
                }
                //  Full duplicate (practice+bg+ou)
                if (isPractice && isBG && isOU) {
                    let full = practice + "_" + bg + "_" + ou;
                    if (fullSet.has(full)) { 
                        alertify.error('<%=MyBase.GetResourceString("A_ExactMatch")%>');
                        row.find('select').addClass('border-danger');
                        isValid = false;
                        return false;
                    }
                    fullSet.add(full);
                }
                
            });

            
            return isValid;
        }       
        //End of Added by Vishal Mane on 05/02/2026 for Applicable Attributes

        // Added by Vishal Mane on 04/02/2026 to add UI Changes for stages configuration
        function onMandatoryClick(ctrl) {
            let row = $(ctrl).closest("tr");
            let applicableChk = row.find(".applicable_stages");
            if ($(ctrl).is(":checked")) {
                // if mandatory checked → applicable must be checked
                applicableChk.prop("checked", true);
            }
        }

        function onApplicableClick(ctrl) {
            let row = $(ctrl).closest("tr");
            let mandatoryChk = row.find(".mandatory_stages");
            if (mandatoryChk.is(":checked") && !$(ctrl).is(":checked")) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Applicable cannot be unchecked when stage is marked mandatory.");
                alertify.error('<%=MyBase.GetResourceString("A_ApplicableUnchecked")%>');
                $(ctrl).prop("checked", true); // revert back
            }
        }

        let stageCounter = 1;
        //$('#btnAddStage').on('click', function () {

        $(document).on('click', '#btnAddStage', function () {
            // get only editable rows (having dropdowns)
            let hasSubmitted = false;
            let hasApprovedRejected = false;
            $('#StageWorkflowTable_Tbody tr.stage-row').each(function () {
                let systemStatus = ($(this).data('systemstatus') || "").toString().toLowerCase().trim();
                if (systemStatus === "submitted")
                    hasSubmitted = true;

                if (systemStatus === "approved/closed")
                    hasApprovedRejected = true;
            });
            if (!hasSubmitted || !hasApprovedRejected) {
                let msg = "Please configure status for ";
                if (!hasSubmitted && !hasApprovedRejected) {
                    msg += "'Submitted' and 'Approved/Closed' system statuses";
                }
                else if (!hasSubmitted) {
                    msg += "'Submitted' system status";
                }
                else if (!hasApprovedRejected) {
                    msg += "'Approved/Closed' system status";
                }
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(msg);
                return false;
            }
            let editableRows = $('#StageWorkflowTable_Tbody tr.stage-row').filter(function () {
                return $(this).find('.cboStageName').length > 0;
            });
            if (editableRows.length > 0) {
                let lastRow = editableRows.last();
                let stageName = lastRow.find('.cboStageName').val();
                let stageRole = lastRow.find('.cboStageRole').val();
                let isStageName = stageName && stageName !== "" && stageName !== "0";
                let isStageRole = stageRole && stageRole !== "" && stageRole !== "0";
                if (!isStageName || !isStageRole) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Please complete previous stage before adding new stage");
                    alertify.error('<%=MyBase.GetResourceString("A_MandatoryPreviousStage")%>');
                    lastRow.find('.cboStageName').toggleClass('border-danger', !isStageName);
                    lastRow.find('.cboStageRole').toggleClass('border-danger', !isStageRole);
                    if (!isStageName)
                        lastRow.find('.cboStageName').focus();
                    else
                        lastRow.find('.cboStageRole').focus();
                    return false;
                }
            }
            stageCounter++;
            const newRow = `
                            <tr class="stage-row dynamic-row" data-row="${stageCounter}">
                                <td class="order-col text-center"></td>

                                <td>
                                    <select class="form-select cboStageName text-left" 
                                            id="cboStageName_${stageCounter}"></select>
                                </td>
                                <td>
                                    <select class="form-select cboStageRole text-left"
                                            id="cboStageRole_${stageCounter}"></select>
                                </td>
                                <td class="text-center">
                                    <input type="checkbox" class="form-check-input mandatory_stages" onclick="onMandatoryClick(this)" checked>
                                </td>
                                <td class="text-center">
                                    <input type="checkbox" class="form-check-input applicable_stages" onclick="onApplicableClick(this)" checked>
                                </td>

                                <td class="text-center">
                                    <!--<i class="fas fa-pen text-primary edit-stage ms-2"></i> -->
                                    <i class="fas fa-trash-alt text-danger delete-stage ms-2"></i>
                                </td>
                            </tr>`;
            // find all editable rows (user added rows having dropdown)
            editableRows = $('#StageWorkflowTable_Tbody tr.stage-row').filter(function () {
                return $(this).find('.cboStageName').length > 0;
            });
            if (editableRows.length > 0) {
                // insert after last editable row
                editableRows.last().after(newRow);
            }
            else {
                // no editable rows yet → insert before completed
                //let completedRow = $('#StageWorkflowTable_Tbody tr').filter(function () {
                //    return $(this).find('td:eq(1)').text().trim().toLowerCase().includes('complete');
                //});
                //if (completedRow.length > 0)
                //    completedRow.first().before(newRow);
                //else
                //    $('#addStageRow').before(newRow);
                let allRows = $('#StageWorkflowTable_Tbody tr.stage-row');

                if (allRows.length > 0) {
                    // insert before LAST row always
                    allRows.last().before(newRow);
                } else {
                    $('#StageWorkflowTable_Tbody').append(newRow);
                }

            }
            reOrderStages();
            GetWorkflowStages(stageCounter);
            GetWorkflowRoles(stageCounter);

            //setTimeout(() => {
            //    GetWorkflowStages(stageCounter);
            //    GetWorkflowRoles(stageCounter);
            //}, 20);

            //requestAnimationFrame(() => {
            //    reOrderStages();
            //});

        });

        function GetWorkflowStages(indexID, StageIDI, StageTypeI) {
            let payload = {
                WorkflowID: GlobalWorkflowID,
            };            
            var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/GetWorkflowStatusMaster", JSON.stringify(payload), false);
            $("#cboStageName_" + indexID).empty();
            if (data && data.length > 0) {
                $.each(data, function (index, item) {
                    $("#cboStageName_" + indexID).append(
                        $("<option></option>")
                            .val(item.StageID)   
                            .text(item.StageName)
                    );
                });
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
            if (StageIDI > 0) {
                $("#cboStageName_" + indexID).append(
                    $("<option></option>")
                        .val(StageIDI)
                        .text(StageTypeI)
                );
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
        }
        function GetWorkflowRoles(indexID, RoleIDI, RoleDescriptionI) {
            let payload = {
                WorkflowID: GlobalWorkflowID,
            };
            var data = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/GetWorkflowRoles", JSON.stringify(payload), false);
            $("#cboStageRole_" + indexID).empty();
            if (data && data.length > 0) {
                $.each(data, function (index, item) {
                    $("#cboStageRole_" + indexID).append(
                        $("<option></option>")
                            .val(item.RoleID)   
                            .text(item.RoleDescription)
                    );
                });
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
            if (RoleIDI > 0) {
                $("#cboStageRole_" + indexID).append(
                    $("<option></option>")
                        .val(RoleIDI)
                        .text(RoleDescriptionI)
                );
            }
            // Added by Vishal Mane on 05/02/2026 to fix null dropdown issue
        }

        function bindStages() {
            var strHtml = "";
            let payload = {
                WorkflowID: GlobalWorkflowID
            };
            var Result = AJAXCallWithResult(
                "/api/SM_BulkExtensionWorkflow/GetWorkflowStages",
                JSON.stringify(payload),
                false
            );
            stageCounter = Result.length;
            // clear table once
            $("#StageWorkflowTable_Tbody").html("");
            if (Result.length > 0) {
                // 🔷 STEP 1: build html only
                for (var i = 0; i < Result.length; i++) {
                    var OrderNo = Result[i]["OrderNo"];
                    var StageID = Result[i]["StageID"];
                    var RoleID = Result[i]["RoleID"];
                    var IsMandatory = Result[i]["IsMandatory"];
                    var IsApplicable = Result[i]["IsApplicable"];
                    var StageName = Result[i]["StageName"];
                    var RoleDescription = Result[i]["RoleDescription"];
                    var SystemStatus = Result[i]["SystemStatus"];
                    var isCompleted = StageName.toLowerCase().includes("approved/closed");
                    // 🔵 START / COMPLETED ROWS (no role)
                    if (RoleID == 0) {
                        strHtml += `<tr class="grayShade stage-row ${isCompleted ? 'completed-row' : ''}" data-stageid="${StageID}" data-systemstatus="${SystemStatus}">
                                <td class="order-col text-center">${OrderNo}</td>
                                <td class="text-center">${StageName}</td>
                                <td>--</td>
                                <td class="text-center">
                                    <input type="checkbox"
                                           class="form-check-input mandatory_stages"
                                           ${IsMandatory == 1 ? "checked" : ""} onclick="onMandatoryClick(this)" disabled/>
                                </td>
                                <td class="text-center">
                                    <input type="checkbox"
                                           class="form-check-input applicable_stages"
                                           ${IsApplicable == 1 ? "checked" : ""}  onclick="onApplicableClick(this)" disabled/>
                                </td>

                                <td></td>
                            </tr>`;
                    }
                    else {
                        // 🔵 EDITABLE STAGE ROW
                        strHtml += `<tr class="stage-row dynamic-row" data-row="${i}">
                                <td class="order-col text-center">${OrderNo}</td>

                                <td>
                                    <select class="form-select cboStageName text-left"
                                            id="cboStageName_${i}" disabled>
                                    </select>
                                </td>
                                <td>
                                    <select class="form-select cboStageRole text-left"
                                            id="cboStageRole_${i}" disabled>
                                    </select>
                                </td>
                                <td class="text-center">
                                    <input type="checkbox"
                                           class="form-check-input mandatory_stages"
                                           id="chkMandatory_stages_${i}"
                                           ${IsMandatory == 1 ? "checked" : ""} onclick="onMandatoryClick(this)" disabled/>
                                </td>
                                <td class="text-center">
                                    <input type="checkbox"
                                           class="form-check-input applicable_stages"
                                           id="chkApplicable_stages_${i}"
                                           ${IsApplicable == 1 ? "checked" : ""} onclick="onApplicableClick(this)" disabled/>
                                </td>

                                <td class="text-center">
                                    <i class="fas fa-pen text-primary edit-stage ms-2" data-row="${i}"></i>
                                    <!-- <i class="fas fa-trash-alt text-danger ms-2 disabled-icon" data-row="${i}"></i> -->
                                </td>
                            </tr>`;
                    }
                }
            }
            // 🔷 STEP 2: add add-stage button row
            strHtml += `<tr id="addStageRow">
                    <td colspan="6" class="text-center">
                        <button type="button" class="btn btn-primary btn-sm" id="btnAddStage">
                            + Add Stage
                        </button>
                    </td>
                </tr>`;

            // 🔷 STEP 3: append once only (IMPORTANT)
            $("#StageWorkflowTable_Tbody").html(strHtml);
            // 🔷 STEP 4: now bind dropdowns AFTER append
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var StageID = Result[i]["StageID"];
                    var RoleID = Result[i]["RoleID"];
                    var StageName = Result[i]["StageName"];
                    var RoleDescription = Result[i]["RoleDescription"];
                    if (RoleID != 0) {
                        GetWorkflowStages(i, StageID, StageName);
                        GetWorkflowRoles(i, RoleID, RoleDescription);
                        $("#cboStageName_" + i).val(StageID);
                        $("#cboStageRole_" + i).val(RoleID);
                    }
                }
            }
            // 🔷 STEP 5: reorder
            reOrderStages();
        }

        function SaveStages(){
            //debugger
            let stageData = getStagesData();
            if (!validateStages()) {
                return false;
            }
            if (stageData.length == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_MandatoryStage")%>');
                //alertify.error("Please add at least one stage before saving");
                return false;
            }
            let payload = {
                WorkflowID: GlobalWorkflowID,
                CreatedBy: encodeURI(UserName),
                StageAttributes: stageData
            };
            var Result = AJAXCallWithResult(
                "/api/SM_BulkExtensionWorkflow/SaveWorkflowStages",
                JSON.stringify(payload),
                false
            );
            alertify.success(Result);
            GetWorkflowMasterDetails();
            bindStages();
        }

        var stageList = [];
        function getStagesData() {
            stageList = [];
            $('#StageWorkflowTable_Tbody tr.stage-row').each(function () {
                let row = $(this);
                let orderNo = row.find('.order-col').text().trim();
                let stageId = 0;
                let roleId = 0;
                let Mandatory = 0;
                let Applicable = 0;
                // 🔵 CASE 1: dynamic editable row
                if (row.find('.cboStageName').length > 0) {
                    stageId = row.find('.cboStageName').val();
                    roleId = row.find('.cboStageRole').val();
                    Mandatory = row.find('.mandatory_stages').is(':checked') ? 1 : 0;
                    Applicable = row.find('.applicable_stages').is(':checked') ? 1 : 0;
                    if (!stageId || stageId == "0" || !roleId || roleId == "0")
                        return; // skip incomplete row
                }
                // 🔵 CASE 2: Start / Completed fixed rows
                else {
                    // StageID stored in hidden field OR data attribute (recommended)
                    stageId = row.data("stageid") || 0;
                    roleId = 0;
                    Mandatory = row.find('.mandatory_stages').is(':checked') ? 1 : 0;
                    Applicable = row.find('.applicable_stages').is(':checked') ? 1 : 0;
                }
                stageList.push({
                    OrderNo: orderNo,
                    StageID: stageId,
                    RoleID: roleId,
                    IsMandatory: Mandatory,
                    IsApplicable: Applicable
                });
            });
            return stageList;
        }

        function validateStages() {
            //debugger
            let isValid = true;
            let rowNo = 0;
            alertify.set('notifier', 'position', 'top-right');
            let stageSet = new Set();
            let stageRoleSet = new Set();
            let hasApplicableStage = false;
            $('#StageWorkflowTable_Tbody tr.stage-row').each(function () {
                let row = $(this);
                // skip Start & Completed rows
                if (row.find('.cboStageName').length === 0)
                    return;               
                let stage = row.find('.cboStageName').val();
                let role = row.find('.cboStageRole').val();
                row.find('select').removeClass('border-danger');
                let isStage = stage && stage != "0";
                let isRole = role && role != "0";
                // empty row
                //Added by Vishal Mane to fix mandatory stage issue
                if (!isStage) {
                    alertify.error("Please select Stage.");
                    //alertify.error('<%=MyBase.GetResourceString("A_MandatoryRole")%>');
                    row.find('.cboStageName').addClass('border-danger').focus();
                    isValid = false;
                    return false;
                }
                //End of Added by Vishal Mane to fix mandatory stage issue

                if (!isStage && !isRole) {
                    //alertify.error("Row " + rowNo + ": Please select Stage and Role.");
                    //alertify.error("Please select Stage and Role.");
                    alertify.error('<%=MyBase.GetResourceString("A_SelectStageRole")%>');
                    row.find('.cboStageName').addClass('border-danger').focus();
                    isValid = false;
                    return false;
                }
                // stage selected but role missing
                if (isStage && !isRole) {
                    //alertify.error("Row " + rowNo + ": Please select Stage Role.");
                    //alertify.error("Please select Stage Role.");
                    alertify.error('<%=MyBase.GetResourceString("A_MandatoryRole")%>');
                    row.find('.cboStageRole').addClass('border-danger').focus();
                    isValid = false;
                    return false;
                }
                // duplicate stage not allowed
                if (isStage) {
                    let normalizedStage = stage.toString().trim();
                    if (stageSet.has(normalizedStage)) {
                        alertify.error('<%=MyBase.GetResourceString("A_DuplicateStage")%>');
                        row.find('.cboStageName').addClass('border-danger').focus();
                        isValid = false;
                        return false;
                    }

                    stageSet.add(normalizedStage);
                }
                // duplicate stage+role not allowed
                if (isStage && isRole) {
                    let combo = stage + "_" + role;
                    if (stageRoleSet.has(combo)) {
                        alertify.error('<%=MyBase.GetResourceString("A_DuplicateStageRole")%>');
                        //alertify.error("Duplicate Stage + Role combination not allowed.");
                        row.find('select').addClass('border-danger');
                        isValid = false;
                        return false;
                    }
                    stageRoleSet.add(combo);
                }
                let isApplicable = $(this).find('.applicable_stages').is(':checked');
                if (isApplicable) {
                    hasApplicableStage = true;
                }

                //Added by Vishal Mane on 17/02/2026 to Validate If no active employee is mapped to the approver role 
                if (role > 0) {
                    var ProjectdataParameter = {
                        RoleID: role,
                    }
                    var param = JSON.stringify(ProjectdataParameter);
                    var strResult = AJAXCallWithResult("/api/SM_BulkExtensionWorkflow/CheckIsRoleActiveEmployee", param, false);
                    if (strResult[0].IsACtiveEmployee == 0) {
                        alertify.error(`No active employee is mapped to the selected role >> ${strResult[0].RoleDescription}`);
                        //row.find('.cboStageRole').addClass('border-danger').focus();
                        isValid = false;
                        return false;
                    }
                }
            //End of Added by Vishal Mane on 17/02/2026 to Validate If no active employee is mapped to the approver role

            });
            if (!hasApplicableStage && isValid == true) {
            //if (!hasApplicableStage) {
                alertify.error('<%=MyBase.GetResourceString("A_AtLeastOneApplicable")%>');
                // highlight all applicable checkboxes area
                $('.applicable_stages').addClass('border-danger');
                return false;
            } else {
                $('.applicable_stages').removeClass('border-danger');
            }
            return isValid;
        }

        function reOrderStages() {
            $('#StageWorkflowTable_Tbody .stage-row').each(function (index) {
                $(this).find('.order-col').text(index + 1);
            });
        }
        $(document).on('click', '.delete-stage', function () {
            $(this).closest('tr').remove();
            //reOrderStages();
            requestAnimationFrame(() => {
                reOrderStages();
            });
        });
        $(document).on('click', '.edit-stage', function () {
            $(this).closest('tr').find('input, select').prop('disabled', false);
        });
        $(document).on('click', '.save-stage', function () {
            $(this).closest('tr').find('input, select').prop('disabled', true);
        });
        // End of Added by Vishal Mane on 04/02/2026 to add UI Changes for stages configuration

        var ajaxResult = "";
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Configuration"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                    /*window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""*/
                }
            });
            return ajaxResult;
        }

    </script>

</body>

</html>

