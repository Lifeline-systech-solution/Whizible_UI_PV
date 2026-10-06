<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_BulkExtensionApproval.aspx.vb" Inherits="Whizible.PM_BulkExtensionApproval" %>


<!DOCTYPE html>
<html>

<head>
    <%--commented and added  by Aditya J. on 23-03-2026--%> 
    <%--<meta charset="utf-8"> 
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_Title") %></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/ css/bootstrap-select-1.13.18.min.css"> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

    Added by Aditya J. on 30-12-2024 for alertify notifications
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    End of Added by Aditya J. on 30-12-2024 for alertify notifications--%>
 <!-- Added By Madhuri.K On 26-03-2026 -->
 <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%CommonFunctions.General.PlotPageHeadTag("Bulk Extension Approval")%>
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--end of commneted and added by Aditya J. on 23-03-2026--%>
    <style type="text/css">
        /* Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen */
        body{
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        img.CardViewIniImg.mx-auto {
            width: 30px !important;
            height: 30px !important;
        }
        
        .clickYes {
            color: #269b0b;
            cursor: pointer;
        }

        .clickNo {
            color: #c50008;
            cursor: pointer;
        }
        .lblProjectName {
            color: #606feb;
        }

        .fw-bold {
            color: #606feb;
        }

        .lbl_text {
            color: #606feb;
            font-weight: 500;
        }

        .alert_note {
            background: #fff4af;
            color: #720606;
        }
        /* End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen */
        body::-webkit-scrollbar {
            display: none;
        }

        .btn-default {
            background-color: #f4f4f4;
            color: #444;
            border-color: #ddd;
        }

        .btn-default:hover,
        .btn-default:active,
        .btn-default.hover {
            background-color: #e7e7e7;
        }

        .table thead tr th span {
            display: inline;
        }

        h5.pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .form-group label {
            line-height: 1.2;
        }

        .custmodal .modal-content .modal-body {
            padding: 20px;
        }

        .dblock {
            display: block;
        }

        .mb-1 {
            margin-bottom: 10px
        }
        .toplinks {
            border-top: 1px solid #eee;
        }

        .dataTables_paginate a.paginate_button.disabled {
            cursor: no-drop
        }

        .dataTables_paginate a.paginate_button {
            border: 1px solid #e9e9e9;
            min-width: 40px;
            display: inline-block;
            text-align: center;
            height: 32px;
            padding: 8px;
            line-height: 14px;
            color: #1359a6;
            margin-left: -1px;
            cursor: pointer
        }

        .dataTables_paginate a.paginate_button.current {
            background: #1359a6;
            color: #fff;
            cursor: pointer
        }

        .ui-datepicker {
            z-index: 9999 !important;
        }

        .alertify-notifier {
            z-index: 9999 !important;
        }

        .pr0 {
            padding-right: 0;
        }

        .custom_radio input[type="radio"] {
            display: none
        }

        .custom_radio input[type="radio"]+label span {
            display: inline-block;
            width: 15px;
            height: 15px;
            background: transparent;
            vertical-align: middle;
            border: 1px solid #464a4c;
            border-radius: 50%;
            padding: 2px;
            margin: 0 12px
        }

        .custom_radio input[type="radio"]:checked+label span {
            width: 15px;
            height: 15px;
            background: #464a4c;
            background-clip: content-box
        }

        .custom_radio span {
            margin: 0px 10px 0px 0px !important;
        }

        table tr th,
        table tr td {
            text-align: center !important
        }

        table tr th:last-child,
        table tr td:last-child {
            text-align: center;
        }
        .custom_chckbox label:before {
            margin-right: 0;
        }
        .table-fixed-header thead tr th, .table thead tr th {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .bootstrap-select .dropdown-menu{
            max-width: 100%;
        }
        .custom_chckbox input:checked + label:after {
            top: 4px;
        }
        .form-check-input:checked {
            background-color: #8b8b8b;
            border-color: #8b8b8b;
        }
        .form-check-input:focus {
            border-color: unset;
            outline: 0;
            box-shadow: none;
        }
        tr.CustRowEdt .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 50%;
        }   
        
        .disabled-icon {
            pointer-events: none; /* Disables click events */
            opacity: 0.5;        /* Makes it visually distinct */
        }
        .cursorDisabled{
            cursor: no-drop; /* Shows a disabled cursor */
        }

        .ApprRejDiv {
            width: 80px;
        }
        .custom_chckbox input[disabled] + label:before {
            cursor: no-drop;
        }
        .btnGreen, .btnGreen:hover {
            background-color: #40ad65;
            color: #fff;
        }

        .btnRed, .btnRed:hover {
            background-color: #eb1c24;
            color: #fff;
        }
        table.dataTable thead .sorting_asc:after {
            opacity :0!important;
        }

        /* Added by Vishal Mane on 08/10/2025 to show contract details */ 
        #ContractDetailsModal label {
            font-weight: 400;
        }

        #ContractDetailsModal .ContractContent label {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        #ContractDetailsModal .modal-xl {
            --bs-modal-width: 900px;
        }

        #ContractDetailsModal .custom_chckbox label:before {
            margin-right: 0 !important;
        }
        .ContractContent {
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .contractLabels {
            color: #4263c1;
        }
        .contractinfo{
            color: #ff0000;
            text-align: center;
        } 
        /*End of Added by Vishal Mane on 08/10/2025 to add new column Contract Details*/

    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
    <%If m_blnViewAccess = True Then%>
    <div class="bgwhite">
        <%--commented and added by Aditya J. on 20-03-2026 for Icon and note for Bulk Extension Approval page--%>
        <%--<div class="container-fluid py-2 graybg">
            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_Title") %></h5>
        </div>--%>
        <div class="container-fluid py-2 graybg">
            <h5 class="pgtitle">
                <i class="fas fa-check-double" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;" data-bs-toggle="tooltip" title="Bulk Extension Approval"></i>
                <%=MyBase.GetResourceString("C_Title") %>

            </h5>
            <p style="color: #6b7280; font-size: 0.7rem; margin: 0;">Review and submit multiple project/resource extension requests for approval in a single action</p>
        </div>
        <%--End of commented and added by Aditya J. on 20-03-2026 for Icon and note for Bulk Extension Approval page--%>

        <div class="clearfix"></div>

        <!-- Main content -->
        <div class="content pt-0">
            <!-- Filters -->
            <div class="filtersSection" id="BulkTopFilSec">
                <!-- Top Section -->
                <div class="row py-2">
                    <div class="col-sm-7">
                        <div class="allApprTabsDiv">
                            <ul class="nav nav-tabs pe-3" id="AllEntityTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button type="button" class="nav-link active" data-bs-toggle="tab"
                                        data-bs-target="#ProjExtensionApprTab" role="tab"> <%=MyBase.GetResourceString("C_ProjectExtensionApproval") %>
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button type="button" class="nav-link" data-bs-toggle="tab"
                                        data-bs-target="#ResExtensionApprTab" role="tab" onclick="getResourceExtensionGrid()"> <%=MyBase.GetResourceString("C_ResourceExtensionApproval") %>
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-5 text-end">
                        <div class="row">
                            <div class="staticFilDiv" id="projectNoteSec">
                                <i class="far fa-lightbulb noteIcon me-1"></i>
                                <!-- <label class="mt-2" style="font-size: 11.5px;"> Page Is Applicable For INR To EURO Conversion</label> -->
                                <label class="mt-2" style="font-size: 11.5px;"> <%=MyBase.GetResourceString("C_Max5ProjectsNote") %></label>
                            </div>
                            <div class="staticFilDiv" id="resourceNoteSec">
                                <i class="far fa-lightbulb noteIcon me-1"></i>
                                <!-- <label class="mt-2" style="font-size: 11.5px;"> Page Is Applicable For INR To EURO Conversion</label> -->
                                <label class="mt-2" style="font-size: 11.5px;"> <%=MyBase.GetResourceString("C_Max10ResourcesNote") %></label>
                               <%-- Added & commented by Ajit L on 20th june 2025--%>
                                <label class="mt-2" style="font-size: 11.5px;">Only active resources can be selected.</label>
                                <%-- Added & commented by Ajit L on 20th june 2025--%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="ApprTabContent">
                    <div class="row">
                        <div class="tab-content" id="BulkApprTabContent">
                            <!-- Project Extension Approval Tab Start here -->
                            <div class="tab-pane fade show active" id="ProjExtensionApprTab" role="tabpanel">
                                <!-- Project Extension Approval List View starts here -->

                                <!-- Top filters -->
                                <div class="TopFilters lightGrey py-2 mb-1">
                                    <div class="form-group mb-0">
                                        <div class="row">
                                            <%--Added by Vishal Mane on 08/10/2025 to show Contract Details--%>
                                            <div class="col-sm-4" hidden>
                                                <div class="row form-group">
                                                    <label for="ContractProjFilter" class="col-sm-4 text-end mt-2">                                                       
                                                        <%=MyBase.GetResourceString("C_Contract") %>
                                                    </label>                                                    
                                                    <%--Added by Vishal Mane on 08/10/2025 to show Contract Details--%>
                                                    <div class="col-sm-7 text-start pe-0">    
                                                        <div style="flex-grow: 1;"> 
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("ContractProjFilter", "usp_Expleo_Sel_ActiveContract",,, "  onchange=GetProjectOnChange(1);getBulkExtensionApprovalGrid(); class='form-control selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-1 text-start d-flex align-items-center"> 
                                                        <span data-bs-toggle="tooltip" aria-label="Contract Details" data-bs-original-title="Contract Details">
                                                           <span class="txt_hover">
                                                               <i class="fas fa-info-circle Card_View_whiz contractinfo" onclick="ShowContractDetails(0)"></i>
                                                           </span>
                                                       </span>
                                                    </div>
                                                     <%--End of Added by Vishal Mane on 08/10/2025 to show Contract Details--%>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="row form-group">
                                                    <label for="ProjectFilter1" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Project") %></label>
                                                    <div class="col-sm-7">                                                        
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("ProjectFilter1", "usp_Expleo_Sel_Projects_OnChangeContract",,, "onchange=getBulkExtensionApprovalGrid(); class='form-control selectpicker'  data-live-search='true'",,, ) %>                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="row form-group">
                                                    <label for="StatusProjFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Status") %></label>
                                                    <div class="col-sm-7">
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("StatusProjFilter", "usp_Expleo_Sel_StatusDropdown",,, "onchange=getBulkExtensionApprovalGrid(); class='form-control selectpicker'  data-live-search='true'",,, ) %>
                                                       
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <table id="ProjExtensionApprTbl" class="table" style="width:100%;">
                                    <thead class="stickyTblHeader">
                                        <tr>
                                            <th class="col-sm-2 ">Project Code</th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_ProjectName") %></th>
                                            <%--<th class="col-sm-1 ">Old Project Value</th>--%>
                                            <%--Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value--%>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_ProjectValue")%></th>
                                             <%--End of Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value--%>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_RevisedProjectValue")%></th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_PlanStartDate") %></th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_PlanEndDate") %></th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_PlannedEffort") %><br>(<span class="">Hrs.</span>)</th>
                                            <th class="col-sm-1 ">Revised Efforts<br>(<span class="">Hrs.</span>)</th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_ProjectStatus") %></th>
                                            <th class="col-sm-1 ">Revised Project status</th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_NewEndDate") %></th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_ApprovalStatus") %></th>
                                            <th class="col-sm-1 "><%=MyBase.GetResourceString("C_SubmittedDate") %></th>
                                            <th class=""><%=MyBase.GetResourceString("C_ApproveReject") %>
                                                <div class="ApprRejDiv d-flex justify-content-start mx-auto gap-2">
                                                    <div class="custom_chckbox">
                                                        <input id="ProjApprCheckAll" class="chckHead" type="checkbox" />
                                                        <label for="ProjApprCheckAll"></label>
                                                    </div>
                                                    <span data-bs-toggle="tooltip" title="Approve"><i class="fas fa-check clickYes" id="ProjApprYesAll" data-bs-toggle="modal" data-bs-target="" onclick="ApproveRejectProjectExtensionRequest('0','A')"></i></span>
                                                    <span data-bs-toggle="tooltip" title="Reject"><i class="fas fa-times clickNo" id="ProjApprNoAll" data-bs-toggle="modal" data-bs-target="" onclick="ApproveRejectProjectExtensionRequest('0','R')"></i></span>
                                                </div>
                                            </th>
                                            <%--Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page--%>
                                            <%--<th class="col-sm-1 "><%=MyBase.GetResourceString("C_Contract") %></th>--%>
                                            <%--Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page--%>
                                        </tr>
                                    </thead>
                                    <tbody id="ProjectExtensionApprovalBodyID">
                                     
                                    </tbody>
                                </table>
                                <!-- Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval -->
                                <div class="cstm_pagination mt-2" id="paginationControlsProjectExtension">
                                    <div class="d-flex justify-content-end w-100">
                                        <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                            <span class="spntotal">Total Records : </span>
                                            <span class="spntotal" id="TotalRecordsProjectExtension"></span>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                    <li class="page-item" id="btnPreviousProjectExtension">
                                                        <a class="page-link" aria-label="Previous" onclick="PrevProjectExtensionList()" id="LinkPreviousProjectExtension">
                                                            <i class="fas fa-angle-double-left"></i>
                                                        </a>
                                                    </li>
                                                    <li class="page-item" id="btnNextProjectExtension">
                                                        <a class="page-link" aria-label="Next" onclick="NextProjectExtensionList()" id="LinkNextProjectExtension">
                                                            <i class="fas fa-angle-double-right"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                                <!-- End of Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval -->
                                <!-- Project Extension Approval List View ends here -->
                            </div>

                            <!-- Resource Extension Approval Tab Start here -->
                            <div class="tab-pane fade show" id="ResExtensionApprTab" role="tabpanel">
                                <!-- Top filters -->
                                <div class="TopFilters lightGrey py-2 mb-1">
                                    <div class="form-group mb-0">
                                        <div class="row">
                                            <div class="col-sm-3" hidden>
                                                <div class="row form-group">
                                                    <label for="ContractResFilter" class="col-sm-4 text-end mt-2">
                                                        <%=MyBase.GetResourceString("C_Contract") %>
                                                    </label>
                                                    <%--Added by Vishal Mane on 08/10/2025 to show Contract Details--%>
                                                    <div class="col-sm-8 text-start">    
                                                        <div class="row"> 
                                                            <div class="col-sm-11 px-0"> 
                                                              <% CommonFunctions.HTMLControls.DrawComboBox("ContractResFilter", "usp_Expleo_Sel_ActiveContract",,, "  onchange=GetProjectOnChange(2);getResourceExtensionGrid(); class='form-control selectpicker' data-live-search='true'",,,) %>
                                                            </div>
                                                            <div class="col-sm-1 px-0" style="display: flex; align-items: center;"> 
                                                                <div style="margin-left: 5px;" data-bs-toggle="tooltip" aria-label="Contract Details" data-bs-original-title="Contract Details"> 
                                                                 <span class="txt_hover">
                                                                            <i class="fas fa-info-circle Card_View_whiz contractinfo" onclick="ShowContractDetails(1)"></i>
                                                                        </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                     <%--End of Added by Vishal Mane on 08/10/2025 to show Contract Details--%>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="row form-group">
                                                    <label for="ProjectResFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Project") %></label>
                                                    <div class="col-sm-8">
                                                        <%--<select class="selectpicker" data-live-search="true" id="ProjectResFilter">
                                                            <option>Select Project</option>
                                                            <option>Project 01</option>
                                                            <option>Project 02</option>
                                                            <option>Project 03</option>
                                                            <option>Project 04</option>
                                                        </select>--%>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("ProjectResFilter", "usp_Expleo_Sel_Projects_OnChangeContract",,, "onchange=getResourceExtensionGrid();getResourcesOnChange(); class='form-control selectpicker'  data-live-search='true'",,, ) %>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="row form-group">
                                                    <label for="SelResourceFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Resource") %></label>
                                                    <div class="col-sm-8">
                                                        <%--<select class="selectpicker" data-live-search="true" id="SelResourceFilter">
                                                            <option>Select Resource</option>
                                                            <option>Rahul Sharma</option>
                                                            <option>Shubham Tiwari</option>
                                                            <option>Shriram Sinha</option>
                                                            <option>Jyoti Patil</option>
                                                            <option>Rohit Patel</option>
                                                            <option>Ankita Sharma</option>
                                                        </select>--%>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("SelResourceFilter", "usp_Expleo_Sel_ResourceExtensionApproval_Res_Drpdwn",,, "onchange=getResourceExtensionGrid(); class='form-control selectpicker'  data-live-search='true'",,, ) %>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="row form-group">
                                                    <label for="StatusResFilter" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Status") %></label>
                                                    <div class="col-sm-8">
                                                        <%--<select class="selectpicker statusColors" data-live-search="true" id="StatusResFilter">
                                                            <option>Select Status</option>
                                                            <option
                                                                data-content="<span class='statusBox statusSubmitted mx-2'>&nbsp;</span> Submitted">
                                                            </option>
                                                            <option
                                                                data-content="<span class='statusBox statusApproved mx-2'>&nbsp;</span> Approved">
                                                            </option>
                                                            <option
                                                                data-content="<span class='statusBox statusRejected mx-2'>&nbsp;</span> Rejected">
                                                            </option>
                                                        </select>--%>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("StatusResFilter", "usp_Expleo_Sel_StatusDropdown",,, "onchange=getResourceExtensionGrid(); class='form-control selectpicker'  data-live-search='true'",,, ) %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Resource Extension Approval List View starts here -->
                                 <div class="table-responsive">
                                    <table id="ResExtensionApprTbl" class="table" style="width:100%;">
                                        <thead class="stickyTblHeader">
                                            <tr>
                                                
                                                <th class="col-sm-2 "><%=MyBase.GetResourceString("C_ProjectName") %></th>
                                                <th class="col-sm-2 "><%=MyBase.GetResourceString("C_ResourceName") %></th>
                                                <th class="col-sm-1 "><%=MyBase.GetResourceString("C_Role") %></th>
                                                <%--<th class=""><%=MyBase.GetResourceString("C_CBU") %></th>--%>
                                                <%--<th class=""><%=MyBase.GetResourceString("C_Designation") %></th>--%>
                                                <%--<th class=""><%=MyBase.GetResourceString("C_ResourceSite") %></th>--%>
                                                <th class=""><%=MyBase.GetResourceString("C_PercentageAllocation") %></th>
                                                <th class="col-sm-1 "><%=MyBase.GetResourceString("C_PlanStartDate") %></th>
                                                <th class="col-sm-1 "><%=MyBase.GetResourceString("C_PlanEndDate") %></th>
                                                <th class="col-sm-1 "><%=MyBase.GetResourceString("C_NewEndDate") %></th>
                                                <th class="col-sm-1 "><%=MyBase.GetResourceString("C_ApprovalStatus") %></th>
                                                <th class="col-sm-1 "><%=MyBase.GetResourceString("C_SubmittedDate") %></th>
                                                <th class="col-sm-1"><%=MyBase.GetResourceString("C_ApproveReject") %>
                                                    <div class="d-flex justify-content-center mx-auto gap-2">
                                                        <div class="custom_chckbox">
                                                            <input id="ResApprCheckAll" class="chckHead" type="checkbox" />
                                                            <label for="ResApprCheckAll"></label>
                                                        </div>
                                                        <span data-bs-toggle="tooltip" title="Approve"><i class="fas fa-check clickYes" id="ResApprYesAll" data-bs-toggle="modal" data-bs-target=""  onclick="ApproveRejectResourceExtensionRequest('0','A')"></i></span>
                                                        <span data-bs-toggle="tooltip" title="Reject"><i class="fas fa-times clickNo" id="ResApprNoAll" data-bs-toggle="modal" data-bs-target=""  onclick="ApproveRejectResourceExtensionRequest('0','R')"></i></span>
                                                        <span><i class="fas fa-info-circle textOrange crsrLink" style="opacity:0"></i></span>
                                                    </div>
                                                </th>
                                                <%--Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page--%>
                                                <%--<th class="col-sm-1 "><%=MyBase.GetResourceString("C_Contract") %></th>--%>
                                               <%--Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page--%>
                                            </tr>
                                        </thead>
                                        <tbody id="ResourceExtensionBodyId">
                                         
                                        </tbody>
                                    </table>
                                    <!-- Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval -->
                                    <div class="cstm_pagination mt-2" id="paginationControlsResourceExtension">
                                        <div class="d-flex justify-content-end w-100">
                                            <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                                <span class="spntotal">Total Records : </span>
                                                <span class="spntotal" id="TotalRecordsResourceExtension"></span>
                                                <nav aria-label="Page navigation example">
                                                    <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                        <li class="page-item" id="btnPreviousResourceExtension">
                                                            <a class="page-link" aria-label="Previous" onclick="PrevResourceExtensionList()" id="LinkPreviousResourceExtension">
                                                                <i class="fas fa-angle-double-left"></i>
                                                            </a>
                                                        </li>
                                                        <li class="page-item" id="btnNextResourceExtension">
                                                            <a class="page-link" aria-label="Next" onclick="NextResourceExtensionList()" id="LinkNextResourceExtension">
                                                                <i class="fas fa-angle-double-right"></i>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End of Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval -->
                                    <!-- Resource Extension Approval List View ends here -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bulk Extension Approval Details For Project Offcanvas Section starts -->
    <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
        id="MoreApprovalDetailsOffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
        <div class="offcanvas-body">
            <div class="container-fluid py-2 graybg mb-2">
                <div class="row align-items-center">
                    <div class="col-sm-12 d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center font-weight-500">
                          <!-- Modified By Madhuri.K On 03-04-2026 -->
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_BulkExtensionApprovalDetails") %></h5>
                        </div>

                        <!-- Close Button -->
                        <!-- Added by Aditya J. on 20-03-2026 for close button in header -->
                        <a href="javascript:;" 
                           class="btn-close" 
                           data-bs-dismiss="offcanvas" 
                           data-bs-toggle="tooltip" 
                           title="Close" 
                           id="closeCustGpBtn">
                        </a>
                        <!-- End of Added by Aditya J. on 20-03-2026 for close button in header -->

                    </div>
                </div>
            </div>

            <div class="RemarkInfo">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="d-flex justify-content-end gap-2">
                            <%--commented by Aditya J. on 20-03-2026 for removing the close button--%>
                            <%--<button class="btn borderbtn" type="button" id="closeCustGpBtn" data-bs-dismiss="offcanvas"
                                aria-label="Close" data-bs-toggle="tooltip" title="Close"><%=MyBase.GetResourceString("C_Close") %></button>--%>
                            <%--End of commented by Aditya J. on 20-03-2026 for removing the close button--%>
                        </div>
                    </div>
                </div>
                <div class="RemarkEdtInfo mb-2">
                    <div class="SubmitterRemarkSec">
                        <div class="row mb-1">
                            <div class="col-sm-12 mb-2">
                                <div class="row ">
                                    <div class="col-sm-3 text-start">
                                        <label class="pro_text"><%=MyBase.GetResourceString("C_SubmitterRemark") %></label>
                                    </div>:
                                    <div class="col-sm-7 text-start">
                                        <label class="pro_text" id="submitterremarkid"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-1">
                           <div class="col-sm-12 mb-2">
                            <div class="row ">
                                <div class="col-sm-3 text-start">
                                    <label class="pro_text"><%=MyBase.GetResourceString("C_Submitteddate1") %></label>
                                </div>:
                                <div class="col-sm-5 text-start">
                                    <label class="pro_text" id="submitteddateid"></label>
                                </div>
                            </div>
                            </div>
                        </div>
                        <div class="row mb-1">
                           <div class="col-sm-12 mb-2">
                            <div class="row mb-1">
                                <div class="col-sm-3 text-start">
                                    <label class="txt_Blue"><%=MyBase.GetResourceString("C_SubmittedBy") %></label>
                                </div>:
                                <div class="col-sm-5 text-start">
                                    <label class="" id="submittedbyid"></label>
                                </div>
                            </div>
                          </div>
                        </div>
                       
                    </div>

                    <hr />
                    
                    <div class="SubmitterRemarkSec">
                        <div class="row mb-1">
                            <div class="col-sm-12 mb-2">
                                <div class="row">
                                    <div class="col-sm-5 text-start">
                                        <label class="pro_text">Rejection Remark/<%=MyBase.GetResourceString("C_ApprovalRemark") %></label>
                                    </div>:
                                    <div class="col-sm-6 text-start">
                                        <label class="pro_text" id="apprremrkid"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mb-1">
                            <div class="col-sm-12 mb-2">
                                <div class="row ">
                                    <div class="col-sm-5 text-start">
                                        <label class="pro_text">Rejected Date/<%=MyBase.GetResourceString("C_Approveddate") %></label>
                                    </div>:
                                    <div class="col-sm-6 text-start">
                                        <label class="pro_text" id="approveddateid"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mb-1">
                            <div class="col-sm-12 mb-2">
                                <div class="row mb-1">
                                    <div class="col-sm-5 text-start">
                                        <label class="txt_Blue">Rejected By/<%=MyBase.GetResourceString("C_ApprovedBy") %></label>
                                    </div>:
                                    <div class="col-sm-6 text-start">
                                        <label class="" id="approvedbyid"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>

        </div>
    </div>
    <!-- Bulk Extension Approval Details for Project Offcanvas Section ends -->

    <!-- Approval Comment modal start here-->
    <div class="modal custmodal fade" id="ApprovalCommentModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_Approve") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory") %>)</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="required"><%=MyBase.GetResourceString("C_ApprovalComments") %> </label>
                        <div class="col-sm-12">
                            <textarea rows="3" class="form-control required" id="txtApproveCommentID" maxlength="500"></textarea>
                        </div>
                    </div>
                    <div class="text-center my-2">
                        <%--commented and added by Aditya J. on 20-03-2026 for making the button color to yellow--%>
                        <%--<a href="javascript:;" class="btn btnGreen" data-bs-toggle="tooltip"
                            title="Approve" onclick="ApproveRejectRequest('A')"><%=MyBase.GetResourceString("C_Approve") %></a>--%>
                        <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                            title="Approve" onclick="ApproveRejectRequest('A')"><%=MyBase.GetResourceString("C_Approve") %></a>
                        <%--End of commented and added by Aditya J. on 20-03-2026 for making the button color to yellow--%>

                        <%--commented by Aditya J. on 20-03-2026 for removing cancel button--%>
                        <%--<a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"
                            data-bs-toggle="tooltip" title="Cancel"><%=MyBase.GetResourceString("C_Cancel") %></a>--%>
                        <%--End of commented by Aditya J. on 20-03-2026 for removing cancel button--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Approval Comment modal end here-->

    <!--Rejection Comment modal start here-->
    <div class="modal custmodal fade" id="RejectionCommentModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%=MyBase.GetResourceString("C_Reject") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory") %>)</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="required"><%=MyBase.GetResourceString("C_RejectionComments") %> </label>
                        <div class="col-sm-12">
                            <textarea rows="3" class="form-control" id="txtRejectCommentID" maxlength="500"></textarea>
                        </div>
                    </div>
                    <div class="text-center my-2">

                        <%--commented and added by Aditya J. on 20-03-2026 for making the button color to yellow--%>
                        <%--<a href="javascript:;" class="btn btnRed" data-bs-toggle="tooltip"
                            title="Reject"  onclick="ApproveRejectRequest('R')"><%=MyBase.GetResourceString("C_Reject") %></a>--%>
                        <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                            title="Reject"  onclick="ApproveRejectRequest('R')"><%=MyBase.GetResourceString("C_Reject") %></a>
                        <%--End of commented and added by Aditya J. on 20-03-2026 for making the button color to yellow--%>

                        <%--commeneted by Aditya J. on 20-03-2026 for removing the cancel button--%>
                        <%--<a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"
                            data-bs-toggle="tooltip" title="Cancel"><%=MyBase.GetResourceString("C_Cancel") %></a>--%>
                        <%--End of commeneted by Aditya J. on 20-03-2026 for removing the cancel button--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Rejection Comment modal end here-->

    <!-- Auto Reject Alert modal start here-->
    <div id="AutoRejectionModal" class="modal fade custmodal" role="dialog" aria-hidden="false">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h5 class="modal-title"><i class="far fa-bell confirmIcn me-2"></i> Alert </h5>
                </div>

                <div class="modal-body">
                    <p class="text-center" id="autorejectionid"></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="d-flex justify-content-center">
                                <button class="btn btnyellow" data-bs-dismiss="modal">Ok</button>
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Auto Reject Alert modal end here-->

    <!-- Contract Details For Project Offcanvas Section starts here added by Vishal Mane on 08/10/2025 -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
            id="moredetailsContract_OffcvsScreen" aria-labelledby="moredetailsProject_OffcvsScreen">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-4">
                            <div class="d-flex align-items-center font-weight-600">
                                <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle text-center"><%=MyBase.GetResourceString("C_ContractDetails")%></h5>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-inline hstryfltr pb-2">
                            <div class="row">
                                <div class="col-sm-6">                                   
                                </div>
                                <div class="col-sm-6">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="javascript:;" class="btn borderbtn cancelEdtDetpanel"
                                            id="BtnCancelResHistory1" data-bs-toggle="tooltip" data-bs-dismiss="offcanvas" title="Cancel"><%=MyBase.GetResourceString("C_Close")%></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                 <div class="row form-group mb-2">
                            <div class="col-sm-4">
                                <div class="row mb-1">
                                    <div class="col-sm-6 text-end">
                                        <label><strong><%=MyBase.GetResourceString("C_CustomerName")%></strong></label>
                                    </div>
                                    <div class="col-sm-6 text-start">
                                        <label id="CustomerNameLabel"></label>
                                    </div>
                                    <div class="col-sm-8" style="display: none">
                                        <%CommonFunctions.HTMLControls.DrawTextBox("hiddencontractid", "hiddencontractid", "form-control", widthInPixel:=0, maxLength:=50)%>
                                        <%CommonFunctions.HTMLControls.DrawTextBox("hiddencontractCurrencyID", "hiddencontractCurrencyID", "form-control", widthInPixel:=0, maxLength:=50)%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="contrctDetailsSec">
                            <div class="row">
                                <div class="col-sm-4">
                                    <table id="contrctDetailsTbl" class="table table-bordered" style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th class="col-sm-3"><%=MyBase.GetResourceString("C_UniqueId")%></th>
                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_Name")%></th>
                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_Select")%></th>
                                            </tr>
                                        </thead>
                                        <tbody id="contractdetailsid"></tbody>
                                    </table>
                                    <button class="btn borderbtn" id="UpdateContractBtn" data-bs-toggle="tooltip" data-bs-original-title="Update" onclick="updateContractData()"><%=MyBase.GetResourceString("C_Update")%></button>
                                </div>
                                <div class="col-sm-8">
                                    <div class="ContractContent">
                                        <div class="row form-group mt-3">
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_UniqueId1")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ContractUniqueIdEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractSummary")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ContractSumEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractDetails1")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="CtractDetEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_Customer")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="CustEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractType")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ContctEdtTypeLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_CommencementDate")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ComDateEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractSigningDate")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ComSignDateEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractExpiryDate")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ComExpDateEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractValue")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ContctEdtValLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_Currency")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="CurrValEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_SOWNumber")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="SOW_NoEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_PONumber")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="PO_NoEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_TypeofApproval")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="ApprTypeEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_EndCustomertotheGroup")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="EndCustGpEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-1">
                                                <div class="row mb-1">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="contractLabels"><%=MyBase.GetResourceString("C_OpportunityId")%></label>
                                                    </div>
                                                    <div class="col-sm-6 text-start">
                                                        <label id="OppIdEdtLabel"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="contrctAttmentInfo">
                            <div class="contrctAttSec">
                                <ul class="nav nav-tabs detailsubtabs mt-4">
                                    <li class="nav-item"><a class="nav-link active" href="#contrctAttmentTab" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_ContractAttachment")%></a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <!-- History Tab -->
                                    <div id="contrctAttmentTab" class="tab-pane active mt-2">
                                        <div class="container-fluid">
                                            <div class="table-responsive">
                                                <table id="contrctDocumentsTbl" class="table table-bordered" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_FileName")%></th>
                                                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_AttachedBy")%></th>
                                                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_AttachedDate")%></th>
                                                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_Description")%></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="contractdocid"></tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                <div class="clearfix"></div>

            </div>
        </div>
        <!-- Contract Details For Project Offcanvas Section ends here added by Vishal Mane on 08/10/2025 -->

    <!-- Send for Approval Offcanvas Section starts here added by Vishal Mane on 09/02/2026  sendforRejection_OffcvsScreen-->
    <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="sendforApproval_OffcvsScreen">
        <div class="offcanvas-body">
            <!-- HEADER BAR -->
            <div class="container-fluid py-2 graybg mb-3">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="font-weight-600">
                            <!-- Modified By Madhuri.K On 03-04-2026 -->
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ApproveProjectDetails") %></h5>
                        </div>
                    </div>
                    <div class="col-sm-6 text-end">
                        <!-- commented by Aditya J. on 20-03-2026 for button alignment Aditya bhai-->
                        <%--<a href="javascript:;" class="btn btnGreen" id="btnSendWorkflowApproval" onclick="ApproveRejectRequest_WF('A')"><%=MyBase.GetResourceString("C_Approve") %></a>--%>
                        <!--End of commented by Aditya J. on 20-03-2026 for button alignment -->

                        <!-- commented by Aditya J. on 20-03-2026 for removing close button and give cross icon -->
                        <%--<a href="javascript:;" class="btn borderbtn" data-bs-dismiss="offcanvas" id="btnCloseWorkflow"><%=MyBase.GetResourceString("C_Cancel") %></a>--%>
                        <a href="javascript:;" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close" id="btnCloseWorkflow"></a>
                        <!--End of commented by Aditya J. on 20-03-2026 for removing close button and give cross icon -->
                    </div>
                </div>
            </div>
            <!-- Added by Aditya J. on 20-03-2026 for button alignment -->
                <div class="text-end mb-2">
                    <a href="javascript:;" 
                       class="btn btnyellow" 
                       id="btnSendWorkflowApproval" 
                       onclick="ApproveRejectRequest_WF('A')">
                        <%=MyBase.GetResourceString("C_Approve") %>
                    </a>
                </div>
            <!-- End of Added by Aditya J. on 20-03-2026 for button alignment -->
            <!-- INFO MESSAGE -->
            <div class="alert small alert_note">
                <%=MyBase.GetResourceString("C_WorkflowNote") %>
            </div>

            <!-- PROJECT BLOCK (DYNAMIC) -->
            <div id="workflowProjectContainer">
            </div>

            <!-- APPROVAL COMMENTS -->
            <div class="form-group mt-3">
                <label class="required"><%=MyBase.GetResourceString("C_ApprovalComments") %></label>
                <textarea rows="3" class="form-control required" id="txtApproveCommentID_WF" placeholder="Enter Approval Comment" maxlength="500"></textarea>
            </div>

            <!-- FOOTER BUTTONS -->
            <div class="text-end mt-4">
            </div>

        </div>
    </div>

     <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="sendforRejection_OffcvsScreen">
        <div class="offcanvas-body">
            <!-- HEADER BAR -->
            <div class="container-fluid py-2 graybg mb-3">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="font-weight-600">
                           <!-- Modified By Madhuri.K On 03-04-2026 -->
                           <h5 class="pgtitle"><%=MyBase.GetResourceString("C_RejectProjectDetails") %> </h5>
                        </div>
                    </div>
                    <div class="col-sm-6 text-end">     
                        <%--commented by Aditya J. on 20-03-2026 for Reject button alignment--%>
                        <%--<a href="javascript:;" class="btn btnRed" id="btnSendWorkflowRejection" onclick="ApproveRejectRequest_WF('R')"><%=MyBase.GetResourceString("C_Reject")%></a>--%>
                        <%--End of commented by Aditya J. on 20-03-2026 for Reject button alignment--%>

                        <%--commneted Added by Aditya J. on 20-03-2026 for removing cancel button and give cross icon--%>
                        <%--<a href="javascript:;" class="btn borderbtn" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Cancel") %></a>--%>
                        <a href="javascript:;" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close"></a>
                        <%--End of commneted Added by Aditya J. on 20-03-2026 for removing cancel button and give cross icon--%>
                    </div>
                </div>
            </div>
            <!-- Added by Aditya J. on 20-03-2026 for Reject button alignment -->
                <div class="text-end mb-2">
                    <a href="javascript:;" 
                       class="btn btnyellow" 
                       id="btnSendWorkflowRejection" 
                       onclick="ApproveRejectRequest_WF('R')">
                        <%=MyBase.GetResourceString("C_Reject") %>
                    </a>
                </div>
            <!-- End of Added by Aditya J. on 20-03-2026 for Reject button alignment -->
            <!-- INFO MESSAGE -->
            <div class="alert small alert_note">
                <%=MyBase.GetResourceString("C_WorkflowNote")%>
            </div>

            <!-- PROJECT BLOCK (DYNAMIC) -->
            <div id="workflowProjectContainer_Rejection">
            </div>

            <!-- APPROVAL COMMENTS -->
            <div class="form-group mt-3">
                <label class="required"><%=MyBase.GetResourceString("C_RejectionComments") %></label>
                <textarea rows="3" class="form-control required" id="txtRejectCommentID_WF" placeholder="Enter Rejection Comment" maxlength="500"></textarea>
            </div>

            <!-- FOOTER BUTTONS -->
            <div class="text-end mt-4">
            </div>

        </div>
    </div>
    <!-- End of Send for Approval Offcanvas Section starts here added by Vishal Mane on 09/02/2026 -->

    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NotAuthorize") %></p>
        </div>
    </div>
    <%End If %>
    <div class="clearfix"></div>

    <%--commented by Aditya J. on 23-03-2026--%>
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <%--Added by Aditya J. on 27-12-2024--%>
    <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
    <%--End of Added by Aditya J. on 27-12-2024--%>
    <!-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script> -->
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <%--Added by Aditya J. on 30-12-2024 for alertify notifications--%>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <%--End of Added by Aditya J. on 30-12-2024 for alertify notifications--%>
    <%--End of commented by Aditya J. on 23-03-2026--%>
    <script>

        var strUrl_Project = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
        var ContractID;
        var ProjectID;
        var Status;
        var flag;
        var ModalFlag;
        $(document).ready(function () {
           

            $('.allApprTabsDiv .nav-link.active').css('color', '#0d6efd');
            $('.allApprTabsDiv .nav-link').not('.active').css('color', 'black');
            getBulkExtensionApprovalGrid(0);
            getStatusColors();
            $("#StatusProjFilter").val(1);
            $(".selectpicker").selectpicker('refresh');
            $("#StatusResFilter").val(1);
            $(".selectpicker").selectpicker('refresh');
            getBulkExtensionApprovalGrid()
        });

        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();

            // Event listener for tab shown event
            $('button[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                updateHeading();
            });

            // $("#ResApprNo4").alert("Resource (resource name) extension request rejected as the resource is already allocated to another project.")
        });

        $('.allApprTabsDiv .nav-link').on('click', function () {
            if ($(this).hasClass('active')) {
                // Set active tab to blue
                $(this).css('color', '#0d6efd');

                // Set inactive tabs to black
                $('.allApprTabsDiv .nav-link').not(this).css('color', 'black');
            }
        });


        // Function to update the heading based on the active tab
        function updateHeading() {
            var activeTab = $("#BulkApprTabContent .tab-pane.active").attr("id");
            $(".staticFilDiv").hide();
            
            if (activeTab === 'ProjExtensionApprTab') {
                $("#projectNoteSec").show();
            } else if (activeTab === 'ResExtensionApprTab') {
                $("#resourceNoteSec").show();
            }
        }

        // Initial call to set the heading on page load
        updateHeading();

        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        function refreshPage() {
            window.location.reload();
        } 

        //datatable
        //$('#ProjExtensionApprTbl').dataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 10,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "bAutoWidth": false,
        //    "ordering": false,
        //    "info": false,
        //});
        //$('#ProjExtensionApprTbl').wrap('<div class="dataTables_scroll" />');

        ////datatable
        //$('#ResExtensionApprTbl').dataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 10,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "bAutoWidth": false,
        //    "ordering": false,
        //    "info": false,
        //});

        //$('#ResExtensionApprTbl').wrap('<div class="dataTables_scroll" />');

        // Project Extension Check or Uncheck All checkboxes
        //$("#ProjApprCheckAll").change(function () {
        //    var checked = $(this).is(':checked');
        //    if (checked) {
        //        $(".chckProject").each(function () {
        //            $(this).prop("checked", true);
        //        });
        //    } else {
        //        $(".chckProject").each(function () {
        //            $(this).prop("checked", false);
        //        });
        //    }
        //});

        // Changing state of CheckAll checkbox
        //$(".chckProject").click(function () {
        //    if ($(".chckProject").length === $(".chckProject:checked").length) {
        //        $("#ProjApprCheckAll").prop("checked", true);
        //    } else {
        //        $("#ProjApprCheckAll").prop("checked", false);
        //    }
        //});

        $('#ProjExtensionApprTbl tbody tr').each(function () {
            // Get the current row
            const $row = $(this);

            // Find the checkbox with the .chckProject class in this row
            const $checkbox = $row.find('.chckProject');

            // Check if the checkbox is present
            if ($checkbox.length) {
                const isChecked = $checkbox.is(':checked'); // Check if it's checked
                const checkboxId = $checkbox.attr('id'); // Get the ID of the checkbox
                const checkboxValue = $checkbox.val(); // Get the value of the checkbox (if any)

                // Log or process the checkbox
                console.log(`Row Checkbox: ID=${checkboxId}, Value=${checkboxValue}, Checked=${isChecked}`);
            }
        });


        $('#ProjApprCheckAll').change(function () {
            
            const isChecked = $(this).is(':checked');
            //$('.chckProject').prop('checked', isChecked); 
            if (isChecked) {
                $(".chckProject").each(function () {
                    //$(this).prop("checked", true);
                    if ($(this).is(':disabled')) {
                        $(this).prop("checked", false);
                    } else {
                        $(this).prop("checked", true);
                    }
                });
            } else {
                $(".chckProject").each(function () {
                    $(this).prop("checked", false);
                });
            }
            GetSelectedRequest();
        });

        $(document).on('change', '.chckProject', function () {
            var chckLength = $(".chckProject").not(":disabled");
            const allChecked = chckLength.length === $('.chckProject:checked').length;
            $('#ProjApprCheckAll').prop('checked', allChecked); 
            GetSelectedRequest();
        });

        // Resource Extension Check or Uncheck All checkboxes
        $("#ResApprCheckAll").change(function () {
            
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chckRes").each(function () {
                    //$(this).prop("checked", true);
                    if ($(this).is(':disabled')) {
                        $(this).prop("checked", false);
                    } else {
                        $(this).prop("checked", true);
                    }
                });
            } else {
                $(".chckRes").each(function () {
                    $(this).prop("checked", false);
                });
            }
            GetSelectedRequestResource();
        });

        // Changing state of CheckAll checkbox
        $(".chckRes").click(function () {
            if ($(".chckRes").length === $(".chckRes:checked").length) {
                $("#ResApprCheckAll").prop("checked", true);
            } else {
                $("#ResApprCheckAll").prop("checked", false);
            }
            GetSelectedRequestResource();
        });

        var g_ResApprovalTable ;
        function checkuncheckAllres() {
            
            if ($(".chckRes:checked").length == $(".chckRes:not(:disabled)").length) {
                $("#ResApprCheckAll").prop("checked", true);
            }
            else {
                $("#ResApprCheckAll").prop("checked", false);
            }
            GetSelectedRequestResource();
        }

        $('#ResExtensionApprTbl').on('page.dt', function () {
            $("#ResApprCheckAll").prop("checked", false);
            $(".chckRes").prop("checked", false);
            GetSelectedRequestResource();
        });



        $('#ProjExtensionApprTbl').on('page.dt', function () {
            $("#ProjApprCheckAll").prop("checked", false);
            $(".chckProject").prop("checked", false);
            GetSelectedRequest();
        });

        //function checkuncheckAllProject() {

        //    if ($(".chckProject:checked").length == $(".chckProject:not(:disabled)").length) {
        //        $("#ProjApprCheckAll").prop("checked", true);
        //    }
        //    else {
        //        $("#ProjApprCheckAll").prop("checked", false);
        //    }
        //    GetSelectedRequest();
        //}
        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".modal").on('show.bs.modal', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.modal', function (e) {
            $(".table").resize();
        });


        function resizeSection() {
            var tblheight = $(window).height();
            $('#ProjExtensionApprTbl_wrapper .dataTables_scroll').css({ 'height': tblheight - 200, "overflow-y": "auto" });
            $('#ResExtensionApprTbl_wrapper .dataTables_scroll').css({ 'height': tblheight - 200, "overflow-y": "auto" });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        var ProjectApprovalID;
        var ProjectName;
        var OldProjectValue;
        var NewProjectValue;
        var PlanStartDate;
        var PlanEndDate;
        var NewEnddate;
        var PlannedEffort;
        var NewEfforts;
        var ProjectStatus;
        var NewProjectStatus;
        var ApprovalStatus;
        var SubmittedDate;
        var EmployeeID;

        // Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval
        var projectExtensionCurrentPage = 1;
        var projectExtensionItemsPerPage = 5;
        var projectExtensionTotalItems = 0;
        var projectExtensionTotalPages = 0;

        function initProjectExtensionPagination() {
            var $items = $('#ProjectExtensionApprovalBodyID .project-extension-item');
            projectExtensionTotalItems = $items.length;
            projectExtensionTotalPages = Math.ceil(projectExtensionTotalItems / projectExtensionItemsPerPage);

            $('#TotalRecordsProjectExtension').text(projectExtensionTotalItems);

            if (!projectExtensionTotalItems) {
                $('#paginationControlsProjectExtension').hide();
                return;
            }

            $('#paginationControlsProjectExtension').show();
            projectExtensionCurrentPage = 1;
            showProjectExtensionPage(1);
        }

        function showProjectExtensionPage(page) {
            projectExtensionCurrentPage = page;

            var $items = $('#ProjectExtensionApprovalBodyID .project-extension-item');
            var start = (page - 1) * projectExtensionItemsPerPage;
            var end = start + projectExtensionItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateProjectExtensionPaginationControls();
        }

        function updateProjectExtensionPaginationControls() {
            $("#btnPreviousProjectExtension, #LinkPreviousProjectExtension").removeClass("disabled fa-disabled");
            $("#btnNextProjectExtension, #LinkNextProjectExtension").removeClass("disabled fa-disabled");

            if (projectExtensionCurrentPage <= 1) {
                $("#btnPreviousProjectExtension").addClass("fa-disabled");
                $("#LinkPreviousProjectExtension").addClass("disabled");
            }

            if (projectExtensionCurrentPage >= projectExtensionTotalPages) {
                $("#btnNextProjectExtension").addClass("fa-disabled");
                $("#LinkNextProjectExtension").addClass("disabled");
            }
        }

        function PrevProjectExtensionList() {
            if ($("#btnPreviousProjectExtension").hasClass("fa-disabled")) return false;
            if (projectExtensionCurrentPage > 1) showProjectExtensionPage(projectExtensionCurrentPage - 1);
        }

        function NextProjectExtensionList() {
            if ($("#btnNextProjectExtension").hasClass("fa-disabled")) return false;
            if (projectExtensionCurrentPage < projectExtensionTotalPages) showProjectExtensionPage(projectExtensionCurrentPage + 1);
        }
        // End of Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval

        // Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval
        var resourceExtensionCurrentPage = 1;
        var resourceExtensionItemsPerPage = 5;
        var resourceExtensionTotalItems = 0;
        var resourceExtensionTotalPages = 0;

        function initResourceExtensionPagination() {
            var $items = $('#ResourceExtensionBodyId .resource-extension-item');
            resourceExtensionTotalItems = $items.length;
            resourceExtensionTotalPages = Math.ceil(resourceExtensionTotalItems / resourceExtensionItemsPerPage);

            $('#TotalRecordsResourceExtension').text(resourceExtensionTotalItems);

            if (!resourceExtensionTotalItems) {
                $('#paginationControlsResourceExtension').hide();
                return;
            }

            $('#paginationControlsResourceExtension').show();
            resourceExtensionCurrentPage = 1;
            showResourceExtensionPage(1);
        }

        function showResourceExtensionPage(page) {
            resourceExtensionCurrentPage = page;

            var $items = $('#ResourceExtensionBodyId .resource-extension-item');
            var start = (page - 1) * resourceExtensionItemsPerPage;
            var end = start + resourceExtensionItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateResourceExtensionPaginationControls();
        }

        function updateResourceExtensionPaginationControls() {
            $("#btnPreviousResourceExtension, #LinkPreviousResourceExtension").removeClass("disabled fa-disabled");
            $("#btnNextResourceExtension, #LinkNextResourceExtension").removeClass("disabled fa-disabled");

            if (resourceExtensionCurrentPage <= 1) {
                $("#btnPreviousResourceExtension").addClass("fa-disabled");
                $("#LinkPreviousResourceExtension").addClass("disabled");
            }

            if (resourceExtensionCurrentPage >= resourceExtensionTotalPages) {
                $("#btnNextResourceExtension").addClass("fa-disabled");
                $("#LinkNextResourceExtension").addClass("disabled");
            }
        }

        function PrevResourceExtensionList() {
            if ($("#btnPreviousResourceExtension").hasClass("fa-disabled")) return false;
            if (resourceExtensionCurrentPage > 1) showResourceExtensionPage(resourceExtensionCurrentPage - 1);
        }

        function NextResourceExtensionList() {
            if ($("#btnNextResourceExtension").hasClass("fa-disabled")) return false;
            if (resourceExtensionCurrentPage < resourceExtensionTotalPages) showResourceExtensionPage(resourceExtensionCurrentPage + 1);
        }
        // End of Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval

        function getBulkExtensionApprovalGrid(flag) {
            //debugger
            //var param = JSON.stringify(parameter);
            var strHTML = "";
            var parameters = {
                ContractID: (flag == 0 ? 0 : $('#ContractProjFilter').val()),
                ProjectID: (flag == 0 ? 0 : $('#ProjectFilter1').val()),
                Status: ((flag == 0) ? "Select Status" : $('#StatusProjFilter option:selected').text()),
                EmployeeID: '<%= Session("intUserId") %>'
            }
            var param = JSON.stringify(parameters);
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetBulkExtensionApprovalGrid", param, false);
            $("#ProjExtensionApprTbl").dataTable().fnDestroy();
            var RoleID = '<%= Session("intPostID") %>';
            var PageStatus = $('#StatusProjFilter option:selected').text();
            $("#ProjectExtensionApprovalBodyID").html('');
            for (var i = 0; i < strResult.length; i++) {
                var fullProjectName = strResult[i].ProjectName;
                var shortProjectName = fullProjectName.length > 20 ? fullProjectName.substring(0, 20) + "..." : fullProjectName;
                //Added by Vishal Mane on 13/02/2026 to show only those rows which stage Role and Logged in person Role matches for Workflow Approval
                if (RoleID == strResult[i].AccessibleRoleID && PageStatus == "Submitted") {
                    strHTML += "<tr class='project-extension-item'>";
                    strHTML += "<td class=''>" + strResult[i].ProjectCode + "</td>";
                    //strHTML += "<td class=''>" + strResult[i].ProjectName + "</td>";
                    strHTML += "<td class='' data-bs-toggle='tooltip' title='" + fullProjectName + "'>" + shortProjectName + "</td>";
                    //Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
                    strHTML += "<td class='text-start'>" + (strResult[i].OldProjectValue || '') + "</td>";
                    //End of Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
                    //Added null condition by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    strHTML += "<td class=''>" + (strResult[i].NewProjectValue || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].PlanStartDate || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].PlanEndDate || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].PlannedEffort || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].NewEfforts || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].ProjectStatus || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].NewProjectStatus || '') + "</td>";
                    strHTML += "<td class=' trColor'>" + (strResult[i].NewEnddate || '') + "</td>";
                    //End of Added null condition by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    //strHTML += "<td>" + strResult[i].ApprovalStatus + "</td>";
                    if (strResult[i].ApprovalStatus == "Submitted") {
                        strHTML += '<td class=" trColor">';
                        strHTML += '<div class="statusDiv d-flex justify-content-center">';
                        strHTML += '    <span class="statusBox statusSubmitted mx-1">&nbsp;</span>';
                        strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Submitted">Submitted</label>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                    }
                    else if (strResult[i].ApprovalStatus == "Approved") {
                        strHTML += '<td class=" trColor">';
                        strHTML += '<div class="statusDiv d-flex justify-content-center">';
                        strHTML += '    <span class="statusBox statusApproved mx-1">&nbsp;</span>';
                        strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Approved">Approved</label>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                    }
                    else if (strResult[i].ApprovalStatus == "Rejected") {
                        strHTML += '<td class=" trColor">';
                        strHTML += '<div class="statusDiv d-flex justify-content-center">';
                        strHTML += '    <span class="statusBox statusRejected mx-1">&nbsp;</span>';
                        strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Rejected">Rejected</label>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                    }
                    strHTML += "<td class=' trColor'>" + strResult[i].SubmittedDate + "</td>";
                    //if (strResult[i].ApprovalStatus == "Submitted" && strResult[i].IsProjectExtensionApprover == "1" && strResult[i].IsDisabled == "0") {
                    //Added by Vishal Mane on 13/02/2026 to show only those rows which stage Role and Logged in person Role matches for Workflow Approval
                    //if (strResult[i].ApprovalStatus == "Submitted" && strResult[i].IsProjectExtensionApprover == "1") {
                    if (strResult[i].ApprovalStatus == "Submitted") {
                    //End of Added by Vishal Mane on 13/02/2026 to show only those rows which stage Role and Logged in person Role matches for Workflow Approval
                        strHTML += "<td class=''>";
                        strHTML += "    <div class='ApprRejDiv d-flex justify-content-start mx-auto gap-2'>";
                        strHTML += "        <div class='custom_chckbox'>";
                        //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                        //strHTML += '<input id="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"  value="' + strResult[i].ProjectApprovalID + '" class="chckProject" type="checkbox" onchange="GetSelectedRequest()">'
                        strHTML += '<input id="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"  value="' + strResult[i].ProjectApprovalID + '" class="chckProject" type="checkbox" onchange="GetSelectedRequest()" data-projectid="' + strResult[i].ProjectID + '" data-projectname="' + strResult[i].ProjectName + '" data-projectapprovalid="' + strResult[i].ProjectApprovalID + '">'
                        //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                        //strHTML += "            <input id='ProjApprCheck5' class='chckProject' type='checkbox' />";
                        //strHTML += "            <label for='ProjApprCheck5'></label>";
                        strHTML += '<label for="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"></label>'
                        strHTML += "</div>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Approve'>";
                        strHTML += "<i class='fas fa-check clickYes' id='ProjApprYes5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"A\")'></i>";
                        strHTML += "</span>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Reject'>";
                        strHTML += "<i class='fas fa-times clickNo' id='ProjApprNo5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"R\")'></i>";

                        strHTML += "</span>";
                    }
                    else {
                        strHTML += "<td class=''>";
                        strHTML += "    <div class='ApprRejDiv d-flex justify-content-start mx-auto gap-2'>";
                        strHTML += "        <div class='custom_chckbox'>";
                        strHTML += '<input id="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"  value="' + strResult[i].ProjectApprovalID + '" class="chckProject" type="checkbox" onchange="GetSelectedRequest()" disabled>'
                        //strHTML += "            <input id='ProjApprCheck5' class='chckProject' type='checkbox' />";
                        //strHTML += "            <label for='ProjApprCheck5'></label>";
                        strHTML += '<label for="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"></label>'
                        strHTML += "</div>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Approve' class='cursorDisabled'>";
                        strHTML += "<i class='fas fa-check clickYes disabled-icon' id='ProjApprYes5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"A\")'></i>";
                        strHTML += "</span>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Reject' class='cursorDisabled'>";
                        strHTML += "<i class='fas fa-times clickNo disabled-icon' id='ProjApprNo5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"R\")'></i>";

                        strHTML += "</span>";
                    }
                    //strHTML += "<span data-bs-toggle='tooltip' title='More Details'>";
                    //strHTML += '<i class="fas fa-info-circle textOrange crsrLink" ' +
                    //    'data-bs-toggle="offcanvas" ' +
                    //    'data-bs-target="#MoreApprovalDetailsOffcvsScreen" ' +
                    //    'data-id="' + strResult[i].ProjectApprovalID + '" ' +
                    //    'onclick="BulkExtensionApprovalDetails(this.getAttribute(\'data-id\'),\'p\');" ' +
                    //    'title="More Details"></i>';
                    //strHTML += "        </span>";
                    strHTML += "    </div>";
                    strHTML += "</td>";
                    //Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    //strHTML += "<td class=''>";
                    //strHTML += "<span data-bs-toggle='tooltip' title='Contract Details'>";
                    //strHTML += "<i class='fas fa-info-circle Card_View_whiz contractinfo' onclick='ShowContractDetails(2,\"" + strResult[i].ContractID + "\" )'></i>";
                    //strHTML += "        </span>";
                    //strHTML += "    </div>";
                    //strHTML += "</td>";
                    //End of Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    strHTML += "</tr>";
                }
                else if (PageStatus != "Submitted"){
                    strHTML += "<tr class='project-extension-item'>";
                    strHTML += "<td class=''>" + strResult[i].ProjectCode + "</td>";
                    //strHTML += "<td class=''>" + strResult[i].ProjectName + "</td>";
                    strHTML += "<td class='' data-bs-toggle='tooltip' title='" + fullProjectName + "'>" + shortProjectName + "</td>";
                    //Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
                    strHTML += "<td class='text-start'>" + (strResult[i].OldProjectValue || '') + "</td>";
                    //End of Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
                    //Added null condition by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    strHTML += "<td class=''>" + (strResult[i].NewProjectValue || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].PlanStartDate || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].PlanEndDate || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].PlannedEffort || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].NewEfforts || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].ProjectStatus || '') + "</td>";
                    strHTML += "<td class=''>" + (strResult[i].NewProjectStatus || '') + "</td>";
                    strHTML += "<td class=' trColor'>" + (strResult[i].NewEnddate || '') + "</td>";
                    //End of Added null condition by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    //strHTML += "<td>" + strResult[i].ApprovalStatus + "</td>";
                    if (strResult[i].ApprovalStatus == "Submitted") {
                        strHTML += '<td class=" trColor">';
                        strHTML += '<div class="statusDiv d-flex justify-content-center">';
                        strHTML += '    <span class="statusBox statusSubmitted mx-1">&nbsp;</span>';
                        strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Submitted">Submitted</label>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                    }
                    else if (strResult[i].ApprovalStatus == "Approved") {
                        strHTML += '<td class=" trColor">';
                        strHTML += '<div class="statusDiv d-flex justify-content-center">';
                        strHTML += '    <span class="statusBox statusApproved mx-1">&nbsp;</span>';
                        strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Approved">Approved</label>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                    }
                    else if (strResult[i].ApprovalStatus == "Rejected") {
                        strHTML += '<td class=" trColor">';
                        strHTML += '<div class="statusDiv d-flex justify-content-center">';
                        strHTML += '    <span class="statusBox statusRejected mx-1">&nbsp;</span>';
                        strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Rejected">Rejected</label>';
                        strHTML += '</div>';
                        strHTML += '</td>';
                    }
                    strHTML += "<td class=' trColor'>" + strResult[i].SubmittedDate + "</td>";
                    //if (strResult[i].ApprovalStatus == "Submitted" && strResult[i].IsProjectExtensionApprover == "1" && strResult[i].IsDisabled == "0") {                    
                    //Added by Vishal Mane on 13/02/2026 to show only those rows which stage Role and Logged in person Role matches for Workflow Approval
                    //if (strResult[i].ApprovalStatus == "Submitted" && strResult[i].IsProjectExtensionApprover == "1") {
                    if (strResult[i].ApprovalStatus == "Submitted") {
                    //End of Added by Vishal Mane on 13/02/2026 to show only those rows which stage Role and Logged in person Role matches for Workflow Approval
                        strHTML += "<td class=''>";
                        strHTML += "    <div class='ApprRejDiv d-flex justify-content-start mx-auto gap-2'>";
                        strHTML += "        <div class='custom_chckbox'>";
                        //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                        //strHTML += '<input id="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"  value="' + strResult[i].ProjectApprovalID + '" class="chckProject" type="checkbox" onchange="GetSelectedRequest()">'
                        strHTML += '<input id="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"  value="' + strResult[i].ProjectApprovalID + '" class="chckProject" type="checkbox" onchange="GetSelectedRequest()" data-projectid="' + strResult[i].ProjectID + '" data-projectname="' + strResult[i].ProjectName + '" data-projectapprovalid="' + strResult[i].ProjectApprovalID + '">'
                        //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                        //strHTML += "            <input id='ProjApprCheck5' class='chckProject' type='checkbox' />";
                        //strHTML += "            <label for='ProjApprCheck5'></label>";
                        strHTML += '<label for="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"></label>'
                        strHTML += "</div>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Approve'>";
                        strHTML += "<i class='fas fa-check clickYes' id='ProjApprYes5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"A\")'></i>";
                        strHTML += "</span>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Reject'>";
                        strHTML += "<i class='fas fa-times clickNo' id='ProjApprNo5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"R\")'></i>";

                        strHTML += "</span>";
                    }
                    else {
                        strHTML += "<td class=''>";
                        strHTML += "    <div class='ApprRejDiv d-flex justify-content-start mx-auto gap-2'>";
                        strHTML += "        <div class='custom_chckbox'>";
                        strHTML += '<input id="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"  value="' + strResult[i].ProjectApprovalID + '" class="chckProject" type="checkbox" onchange="GetSelectedRequest()" disabled>'
                        //strHTML += "            <input id='ProjApprCheck5' class='chckProject' type='checkbox' />";
                        //strHTML += "            <label for='ProjApprCheck5'></label>";
                        strHTML += '<label for="ProjectExtensionApproval_' + strResult[i].ProjectApprovalID + '"></label>'
                        strHTML += "</div>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Approve' class='cursorDisabled'>";
                        strHTML += "<i class='fas fa-check clickYes disabled-icon' id='ProjApprYes5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"A\")'></i>";
                        strHTML += "</span>";
                        strHTML += "<span data-bs-toggle='tooltip' title='Reject' class='cursorDisabled'>";
                        strHTML += "<i class='fas fa-times clickNo disabled-icon' id='ProjApprNo5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectProjectExtensionRequest(\"" + strResult[i].ProjectApprovalID + "\", \"R\")'></i>";

                        strHTML += "</span>";
                    }
                    //strHTML += "<span data-bs-toggle='tooltip' title='More Details'>";
                    //strHTML += '<i class="fas fa-info-circle textOrange crsrLink" ' +
                    //    'data-bs-toggle="offcanvas" ' +
                    //    'data-bs-target="#MoreApprovalDetailsOffcvsScreen" ' +
                    //    'data-id="' + strResult[i].ProjectApprovalID + '" ' +
                    //    'onclick="BulkExtensionApprovalDetails(this.getAttribute(\'data-id\'),\'p\');" ' +
                    //    'title="More Details"></i>';
                    //strHTML += "        </span>";
                    strHTML += "    </div>";
                    strHTML += "</td>";
                    //Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    //strHTML += "<td class=''>";
                    //strHTML += "<span data-bs-toggle='tooltip' title='Contract Details'>";
                    //strHTML += "<i class='fas fa-info-circle Card_View_whiz contractinfo' onclick='ShowContractDetails(2,\"" + strResult[i].ContractID + "\" )'></i>";
                    //strHTML += "        </span>";
                    //strHTML += "    </div>";
                    //strHTML += "</td>";
                    //End of Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                    strHTML += "</tr>";
                }
            }
            $("#ProjectExtensionApprovalBodyID").html('');
            $("#ProjectExtensionApprovalBodyID").html(strHTML);

            // Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval
            initProjectExtensionPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval

            //Added by Aditya J. on 20-03-2026 for tooltip not showing issue
            $('[data-bs-toggle="tooltip"]').tooltip();
            //End of Added by Aditya J. on 20-03-2026 for tooltip not showing issue

            //commented and added by Aditya J. on 20-03-2026 for consistent pagination
            //datatable
            $('#ProjExtensionApprTbl').dataTable({
                //"scrollY": true,
                //"scrollX": true,
                "paging": false,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "bAutoWidth": false,
                "ordering": false,
                "info": false,
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
            //End of commented and added by Aditya J. on 20-03-2026 for consistent pagination

            $('#ProjExtensionApprTbl').wrap('<div class="dataTables_scroll" />');

            // Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval
            // Re-apply slice pagination after DataTable redraw/setup.
            initProjectExtensionPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Project Extension Approval

            $('#ProjectFilter1').selectpicker('refresh');
            $('#ProjectResFilter').selectpicker('refresh');
            $('#SelResourceFilter').selectpicker('refresh');
        }

        function GetProjectOnChange(flag) {
           
            if (flag == 1) {
                FillProjectDropdownOnChange($("#ContractProjFilter").val(),1);
            }
            else if (flag == 2) {
                FillProjectDropdownOnChange($("#ContractResFilter").val(),2);
            }
            
        }
        
        function FillProjectDropdownOnChange(contractid, flag) {
            
            var Parameters = {
                ContractID: contractid
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/FillProjectDropdown", param, false);

            var html = "";
            for (var i = 0; i < strResult.length; i++) {
                html += "<option value='" + strResult[i].ProjectID + "'>" + strResult[i].ProjectName + "</option>";
            }

            if (flag == 1) {
                $('#ProjectFilter1').selectpicker('refresh');
                $("#ProjectFilter1").html(html);
            }
            else if (flag == 2) {
                $('#ProjectResFilter').selectpicker('refresh');
                $("#ProjectResFilter").html(html);
            }
        }

        function getStatusColors() {
            var html = "";
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetStatusColors", '', false);
            for (var i = 0; i < strResult.length; i++) {
                if (strResult[i].StatusID === 0) {
                    html += "<option value='" + strResult[i].StatusID + "'>" + "Select Status" + "</option>";
                } else if (strResult[i].StatusID === 1) {
                    html += "<option value='" + strResult[i].StatusID + "'data-content=\"<span class='statusBox statusSubmitted mx-2'>&nbsp;</span> Submitted\">" + strResult[i].StatusName + "</option>";
                } else if (strResult[i].StatusID === 2) {
                    html += "<option value='" + strResult[i].StatusID + "'data-content=\"<span class='statusBox statusApproved mx-2'>&nbsp;</span> Approved\">" + strResult[i].StatusName + "</option>";
                } else if (strResult[i].StatusID === 3) {
                    html += "<option value='" + strResult[i].StatusID + "'data-content=\"<span class='statusBox statusRejected mx-2'>&nbsp;</span> Rejected\">" + strResult[i].StatusName + "</option>";
                }
            }            
            $("#StatusProjFilter").html(html);
            $('#StatusProjFilter').selectpicker('refresh');

            $("#StatusResFilter").html(html);
            $('#StatusResFilter').selectpicker('refresh');
        }

        function BulkExtensionApprovalDetails(ID, flag) {

            if (flag == 'p') {
                var parameters = {
                    ProjectApprovalID: ID
                }
                var param = JSON.stringify(parameters);
                var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/ProjectExtensionApprovalDetails", param, false);
            }

            if (flag == 'r') {
                var parameters = {
                    ResourceApprovalID: ID
                }
                var param = JSON.stringify(parameters);
                var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/ResourceExtensionApprovalDetails", param, false);
            }
            

            $("#submitterremarkid").text(strResult[0].SubmitterRemark);
            $("#submitteddateid").text(strResult[0].SubmittedDate);
            $("#submittedbyid").text(strResult[0].SubmittedBy);
            $("#apprremrkid").text(strResult[0].ApprovalRemark);
            $("#approveddateid").text(strResult[0].Approveddate);
            $("#approvedbyid").text(strResult[0].ApprovedBy);
        }

        var checkedValues = [];
        //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        var checkedValues_WF = [];
        //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        function GetSelectedRequest() {
            //debugger
            checkedValues = [];
            checkedValues_WF = [];            
            $('.chckProject:checked').each(function () {
                checkedValues.push($(this).val());
                //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                let projectId = $(this).data("projectid");
                const rowData = {
                    ProjectID: $(this).data("projectid"), 
                    ProjectName: $(this).data("projectname"),
                    ProjectApprovalID: $(this).data("projectapprovalid"),
                }
                checkedValues_WF.push(rowData);
                //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
            });
            console.log(checkedValues);
        }
        
        function ApproveRejectProjectExtensionRequest(id, ApproveRejectFlag) {
            //debugger
            //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
            if (ApproveRejectFlag == 'A') {
                IsApproveReject = 1;
            }
            else {
                IsApproveReject = 0;
            }
            //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
            ModalFlag = 'FromProject';
            if (checkedValues.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select at least one request.");
                return;
            }
            if (checkedValues.length >10) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select only 10 request.");
                return;
            }
            // Check if the ID is in the checkedValues array
            if ((id == 0)) {
                if (ApproveRejectFlag === "A") {                    
                    //Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                    //$('#ApprovalCommentModal').modal('show');
                    buildWorkflowApprovalUI(checkedValues_WF,'A');
                    //End of Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                } else if (ApproveRejectFlag === "R") {                    
                    //Commented and Added by Vishal Mane on 09/02 / 2026 to open off canvas for Send For Approval Screen
                    //$('#RejectionCommentModal').modal('show');
                    buildWorkflowApprovalUI(checkedValues_WF, 'R');
                    //End of Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                }
            //} else if (!(($('.chckProject').length === $('.chckProject:checked').length)) && checkedValues.includes(id.toString())) {
            }
            else if (checkedValues.includes(id.toString())) {
                if (ApproveRejectFlag === "A") {
                    //Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                    //$('#ApprovalCommentModal').modal('show');
                    buildWorkflowApprovalUI(checkedValues_WF, 'A');
                    //End of Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                } else if (ApproveRejectFlag === "R") {
                    //Commented and Added by Vishal Mane on 09/02 / 2026 to open off canvas for Send For Approval Screen
                    //$('#RejectionCommentModal').modal('show');
                    buildWorkflowApprovalUI(checkedValues_WF, 'R');
                    //End of Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
                }
            } 
        }

        function ApproveRejectResourceExtensionRequest(id, ApproveRejectFlag) {
            ModalFlag = 'FromResource';
            if (checkedValuesResource.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select at least one request.");
                return;
            }
            if (checkedValuesResource.length > 10) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select only 10 request.");
                return;
            }
            // Check if the ID is in the checkedValues array
            if ((id == 0)) {
                if (ApproveRejectFlag === "A") {
                    $('#ApprovalCommentModal').modal('show');
                } else if (ApproveRejectFlag === "R") {
                    $('#RejectionCommentModal').modal('show');
                }
                //} else if (!(($('.chckRes').length === $('.chckRes:checked').length)) && checkedValuesResource.includes(id.toString())) {
            } else if (checkedValuesResource.includes(id.toString())) {
                if (ApproveRejectFlag === "A") {
                    $('#ApprovalCommentModal').modal('show');
                } else if (ApproveRejectFlag === "R") {
                    $('#RejectionCommentModal').modal('show');
                }
            }
        }

        var Remarks;
        function ApproveRejectRequest(flag) {
            if (flag == 'A') {
                Remarks = $("#txtApproveCommentID").val();
            }
            else if (flag == 'R') {
                Remarks = $("#txtRejectCommentID").val();
            }
            var ApprovalStatus = '';
           // alert(ModalFlag);
            if (flag == 'A') {
                if ($("#txtApproveCommentID").val().trim() == '' || $("#txtApproveCommentID").val().trim() == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Approval Comments should not be left blank.");
                    $("#txtApproveCommentID").focus();
                    return;
                }
                ApprovalStatus = "Approved";                
                // else
                if (ModalFlag == 'FromResource') {                   
                    var parameters = {
                        ResourceApprovalIDs: checkedValuesResource.toString(),
                        Remarks: Remarks,
                        ApprovedBy:<%= Session("intUserID") %>,
                        ApprovalStatus: ApprovalStatus
                    }
                    var param = JSON.stringify(parameters);
                    var strResult1 = AJAXCallWithResult("/api/PM_BulkExtensionApproval/ResourceExtensionApprovalRejectRequests", param, false);
                    if (strResult1[0].strResult != '') {
                        if (ApprovalStatus == "Approved" && strResult1[0].strResult.indexOf('rejected') != -1) {
                            $('#autorejectionid').text(strResult1[0].strResult);
                            $("#AutoRejectionModal").modal('show');
                        }
                        else if (ApprovalStatus == "Approved") {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("Request approved successfully.");
                        }
                        $('#ApprovalCommentModal').modal('hide'); 
                    }
                    if (ApprovalStatus == "Approved") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("Request approved successfully.");
                    }
                    if (strResult1[0].strResult.indexOf('rejected') == -1) {
                        window.open(
                            "../Email/SendEmail.aspx?MessageID=35017&ResourceApprovalIDs=" + checkedValuesResource.join(',') + "&SubmitterIDs=" + strResult1[0].Submittedby,
                            '',
                            'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                        );
                    }
                    else {
                        window.open(
                            "../Email/SendEmail.aspx?MessageID=35018&ResourceApprovalIDs=" + checkedValuesResource.join(',') + "&SubmitterIDs=" + strResult1[0].Submittedby,
                            '',
                            'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                        );
                    }
                    getResourceExtensionGrid(0);
                    $('#ApprovalCommentModal').modal('hide');
                    return;
                }                
                $('#ApprovalCommentModal').modal('hide');
                ApprovalStatus = 'Approved';
            }
            if (flag == 'R') {
                if ($("#txtRejectCommentID").val().trim() == '' || $("#txtRejectCommentID").val().trim() == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Rejection Comments should not be left blank.");
                    $("#txtRejectCommentID").focus();
                    return;
                }
                //if (ModalFlag == 'FromProject') {
                //    window.open(
                //        "../Email/SendEmail.aspx?MessageID=35015&ProjectApprovalIDs=" + checkedValues.join(','),
                //        '',
                //        'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                //    );
                //}
                //else
                //    if (ModalFlag == 'FromResource') {
                //    window.open(
                //        "../Email/SendEmail.aspx?MessageID=35018&ResourceApprovalIDs=" + checkedValuesResource.join(',') + "&SubmitterIDs=" + strResult,
                //        '',
                //        'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                //    );
                //}
                
                $('#RejectionCommentModal').modal('hide');
                ApprovalStatus = 'Rejected';
            }

            if (flag == 'A') {
                Remarks = $("#txtApproveCommentID").val();
            }
            else if (flag == 'R') {
                Remarks = $("#txtRejectCommentID").val();
            }
            if (ModalFlag == 'FromProject') {
                var parameters = {
                    ProjectApprovalIDs: checkedValues.toString(),
                    Remarks: Remarks,
                    ApprovedBy:<%= Session("intUserID") %>,
                    ApprovalStatus: ApprovalStatus
                }
                var param = JSON.stringify(parameters);
                var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/ProjectExtensionApprovalRejectRequests", param, false);
                
                getBulkExtensionApprovalGrid(1);
                if (flag == 'A') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Request approved successfully.");
                }
                else if (flag == 'R') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Request rejected successfully.");
                }
                if (flag == 'A') {
                    window.open(
                        "../Email/SendEmail.aspx?MessageID=35014&ProjectApprovalIDs=" + checkedValues.join(',') + "&SubmitterIDs=" + strResult,
                        '',
                        'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                    );
                } else if (flag == 'R') {
                    window.open(
                        "../Email/SendEmail.aspx?MessageID=35015&ProjectApprovalIDs=" + checkedValues.join(',') + "&SubmitterIDs=" + strResult,
                        '',
                        'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                    );
                }               
            }
            else if (ModalFlag == 'FromResource') {
                var parameters = {
                    ResourceApprovalIDs: checkedValuesResource.toString(),
                    Remarks: Remarks,
                    ApprovedBy:<%= Session("intUserID") %>,
                    ApprovalStatus: ApprovalStatus
                }
                var param = JSON.stringify(parameters);
                var strResult1 = AJAXCallWithResult("/api/PM_BulkExtensionApproval/ResourceExtensionApprovalRejectRequests", param, false);
                if (strResult1[0].strResult != '') {
                    $('#autorejectionid').text(strResult1[0].strResult);
                    $("#AutoRejectionModal").modal('show');
                }
                if (ApprovalStatus == "Rejected") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Request rejected successfully.");
                }               
                window.open(
                    "../Email/SendEmail.aspx?MessageID=35018&ResourceApprovalIDs=" + checkedValuesResource.join(',') + "&SubmitterIDs=" + strResult1[0].Submittedby,
                    '',
                    'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                ); 
                getResourceExtensionGrid(1);
            }
            $("#ProjApprCheckAll").prop("checked", false);
            $("#ResApprCheckAll").prop("checked", false);
        }

        $('#ApprovalCommentModal').on('hidden.bs.modal', function () {
            $("#txtApproveCommentID").val('');
        });

        $('#RejectionCommentModal').on('hidden.bs.modal', function () {
            $("#txtRejectCommentID").val('');
        });

        function getResourcesOnChange() {
            fillResourceDropdown($('#ProjectResFilter').val());
        }

        function fillResourceDropdown(projectid) {            
            var Parameters = {
                ProjectID: projectid
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/FillResourceDropdown", param, false);

            var html = "";
            for (var i = 0; i < strResult.length; i++) {
                html += "<option value='" + strResult[i].EmployeeID + "'>" + strResult[i].EmployeeName + "</option>";
            }

            $("#SelResourceFilter").html(html);
            $('#SelResourceFilter').selectpicker('refresh');
            
        }

        function getResourceExtensionGrid() {

            var strHTML = "";
            var parameters = {
                ContractID: (flag == 0 ? 0 : $('#ContractResFilter').val()),
                ProjectID: (flag == 0 ? 0 : $('#ProjectResFilter').val()),
                ResourceID: (flag == 0 ? 0 : $('#SelResourceFilter').val()),
                Status: ((flag == 0) ? "Select Status" : $('#StatusResFilter option:selected').text()),
                EmployeeID: '<%= Session("intUserId") %>'
            }
            var param = JSON.stringify(parameters);
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetResourceExtensionGrid", param, false);
            $("#ResExtensionApprTbl").dataTable().fnDestroy();
            
            for (var i = 0; i < strResult.length; i++) {

                strHTML += "<tr class='resource-extension-item'>";
                //commented and Added by Aditya J. on 20-03-2026 for tooltip on Project Name
                //strHTML += "<td class=''>" + strResult[i].ProjectName + "</td>";                
                strHTML += "<td data-bs-toggle='tooltip' title='Project Name: " + strResult[i].ProjectName + "'>"
                    + strResult[i].ProjectName +
                    "</td>";
                // End of Added by Aditya J. on 20-03-2026 for tooltip on Project Name
                                  
                    if (strResult[i].SystemFilename != null) {
                        strHTML += "<td class=''><img src=" + strResult[i].SystemFilename+" class='CardViewIniImg mx-auto' alt=''><br>" + strResult[i].ResourceName + "</td>";
                }
                    else {
                        strHTML += "<td class=''><img src='../../../Whizible2.0-new/dist/img/blankprofile.png' class='CardViewIniImg mx-auto' alt=''><br>" + strResult[i].ResourceName + "</td>";
                    }
                strHTML += "<td class=''>" + strResult[i].Role + "</td>";
                //strHTML += "<td class=''>" + strResult[i].CBU + "</td>";
                //strHTML += "<td class=''>" + strResult[i].Designation + "</td>";
                //strHTML += "<td class=''>" + strResult[i].ResourceSite + "</td>";
                strHTML += "<td class=''>" + strResult[i].PerAllocation + "%</td>";
                strHTML += "<td class=''>" + strResult[i].PlanStartDate + "</td>";
                strHTML += "<td class=''>" + strResult[i].PlanEndDate + "</td>";
                strHTML += "<td class=' trColor'>" + strResult[i].NewEndDate + "</td>";
                //strHTML += "<td>" + strResult[i].ApprovalStatus + "</td>";
                if (strResult[i].ApprovalStatus == "Submitted") {
                    strHTML += '<td class=" trColor">';
                    strHTML += '<div class="statusDiv d-flex justify-content-center">';
                    strHTML += '    <span class="statusBox statusSubmitted mx-1">&nbsp;</span>';
                    strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Submitted">Submitted</label>';
                    strHTML += '</div>';
                    strHTML += '</td>';
                } else if (strResult[i].ApprovalStatus == "Approved") {
                    strHTML += '<td class=" trColor">';
                    strHTML += '<div class="statusDiv d-flex justify-content-center">';
                    strHTML += '    <span class="statusBox statusApproved mx-1">&nbsp;</span>';
                    strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Approved">Approved</label>';
                    strHTML += '</div>';
                    strHTML += '</td>';
                } else if (strResult[i].ApprovalStatus == "Rejected") {
                    strHTML += '<td class=" trColor">';
                    strHTML += '<div class="statusDiv d-flex justify-content-center">';
                    strHTML += '    <span class="statusBox statusRejected mx-1">&nbsp;</span>';
                    strHTML += '    <label class="crsrLink" data-bs-toggle="tooltip" title="Rejected">Rejected</label>';
                    strHTML += '</div>';
                    strHTML += '</td>';
                }
                strHTML += "<td class=' trColor'>" + strResult[i].SubmittedDate + "</td>";
                //if (strResult[i].ApprovalStatus == "Submitted" && strResult[i].IsResourceExtensionApprover == "1" && strResult[i].IsDisabled==0) {
                //Commented & Added by Ajit L on 20th June 2025
                //if (strResult[i].ApprovalStatus == "Submitted" && strResult[i].IsResourceExtensionApprover == "1" ) {
                if (strResult[i].ApprovalStatus == "Submitted" && strResult[i].IsResourceExtensionApprover == "1" && strResult[i].ActualEndDate == null) {
                    //End of Commented & Added by Ajit L on 20th June 2025
                    strHTML += "<td class=''>";
                    strHTML += "    <div class='ApprRejDiv d-flex justify-content-start mx-auto gap-2'>";
                    strHTML += "        <div class='custom_chckbox'>";
                    strHTML += '<input id="ResourceExtensionApproval_' + strResult[i].ResourceApprovalID + '_' + strResult[i].RevisionNo + '"  value="' + strResult[i].ResourceApprovalID + '" class="chckRes" type="checkbox" onchange="checkuncheckAllres();GetSelectedRequestResource()">'
                    //strHTML += "            <input id='ProjApprCheck5' class='chckProject' type='checkbox' />";
                    //strHTML += "            <label for='ProjApprCheck5'></label>";
                    strHTML += '<label for="ResourceExtensionApproval_' + strResult[i].ResourceApprovalID + '_' + strResult[i].RevisionNo + '"></label>'
                    strHTML += "</div>";
                    strHTML += "<span data-bs-toggle='tooltip' title='Approve'>";
                    strHTML += "<i class='fas fa-check clickYes' id='ResApprYes5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectResourceExtensionRequest(\"" + strResult[i].ResourceApprovalID + "\", \"A\")'></i>";
                    strHTML += "</span>";
                    strHTML += "<span data-bs-toggle='tooltip' title='Reject'>";
                    strHTML += "<i class='fas fa-times clickNo' id='ResApprNo5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectResourceExtensionRequest(\"" + strResult[i].ResourceApprovalID + "\", \"R\")'></i>";

                    strHTML += "</span>";
                }
                else {
                    strHTML += "<td class=''>";
                    strHTML += "    <div class='ApprRejDiv d-flex justify-content-start mx-auto gap-2'>";
                    strHTML += "        <div class='custom_chckbox'>";
                    strHTML += '<input id="ResourceExtensionApproval_' + strResult[i].ResourceApprovalID + '_' + strResult[i].RevisionNo + '"  value="' + strResult[i].ResourceApprovalID + '" class="chckRes" type="checkbox" onchange="GetSelectedRequestResource()" disabled>'
                    //strHTML += "            <input id='ProjApprCheck5' class='chckProject' type='checkbox' />";
                    //strHTML += "            <label for='ProjApprCheck5'></label>";
                    strHTML += '<label for="ResourceExtensionApproval_' + strResult[i].ResourceApprovalID + '_' + strResult[i].RevisionNo + '"></label>'
                    strHTML += "</div>";
                    strHTML += "<span data-bs-toggle='tooltip' title='Approve' class='cursorDisabled'>";
                    strHTML += "<i class='fas fa-check clickYes disabled-icon' id='ResApprYes5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectResourceExtensionRequest(\"" + strResult[i].ResourceApprovalID + "\", \"A\")'></i>";
                    strHTML += "</span>";
                    strHTML += "<span data-bs-toggle='tooltip' title='Reject' class='cursorDisabled'>";
                    strHTML += "<i class='fas fa-times clickNo disabled-icon' id='ResApprNo5' data-bs-toggle='modal' data-bs-target='' onclick='ApproveRejectResourceExtensionRequest(\"" + strResult[i].ResourceApprovalID + "\", \"R\")'></i>";

                    strHTML += "</span>";
                }
                strHTML += "<span data-bs-toggle='tooltip' title='More Details'>";
                strHTML += '<i class="fas fa-info-circle textOrange crsrLink" ' +
                    'data-bs-toggle="offcanvas" ' +
                    'data-bs-target="#MoreApprovalDetailsOffcvsScreen" ' +
                    'data-id="' + strResult[i].ResourceApprovalID + '" ' +
                    'onclick="BulkExtensionApprovalDetails(this.getAttribute(\'data-id\'),\'r\');" ' +
                    'title="More Details"></i>';
                strHTML += "        </span>";
                strHTML += "    </div>";
                strHTML += "</td>";

                //Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                //strHTML += "<td class=''>";
                //strHTML += "<span data-bs-toggle='tooltip' title='Contract Details'>";
                //strHTML += "<i class='fas fa-info-circle Card_View_whiz contractinfo' onclick='ShowContractDetails(2,\"" + strResult[i].ContractID + "\" )'></i>";
                //strHTML += "        </span>";
                //strHTML += "    </div>";
                //strHTML += "</td>";
                //End of Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
                strHTML += "</tr>";

            }

            $("#ResourceExtensionBodyId").html('');
            $("#ResourceExtensionBodyId").html(strHTML);

            // Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval
            initResourceExtensionPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval

            //Added by Aditya J. on 20-03-2026 for tooltip not coming issue
            $('[data-bs-toggle="tooltip"]').tooltip();
            //End of Added by Aditya J. on 20-03-2026 for tooltip not coming issue

            //commented and added by Added by Aditya J. on 20-03-2026 for consistent pagination
            //datatable
            //g_ResApprovalTable=$('#ResExtensionApprTbl').dataTable({
            //    // "scrollY": true,
            //    // "scrollX": true,
            //    "paging": true,
            //    "pageLength": 10,
            //    "bLengthChange": false,
            //    "bFilter": false,
            //    "ordering": false,
            //    "responsive": true,
            //    "destroy": false,
            //    "retrieve": true,
            //    "bFilter": false,
            //    "bAutoWidth": false,
            //    "ordering": false,
            //    "info": false,
            //});
            g_ResApprovalTable = $('#ResExtensionApprTbl').dataTable({
                //"scrollY": true,
                //"scrollX": true,
                "paging": false,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "bAutoWidth": false,
                "ordering": false,
                "info": false,
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
            //End of commented and added by Added by Aditya J. on 20-03-2026 for consistent pagination

            $('#ResExtensionApprTbl').wrap('<div class="dataTables_scroll" />');

            // Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval
            initResourceExtensionPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Resource Extension Approval

            $('#ProjectFilter1').selectpicker('refresh');
            $('#ProjectResFilter').selectpicker('refresh');
            $('#SelResourceFilter').selectpicker('refresh');
        }       

        var checkedValuesResource = [];
        function GetSelectedRequestResource() {
            checkedValuesResource = [];
            $('.chckRes:checked').each(function () {
                checkedValuesResource.push($(this).val());
            });
            console.log(checkedValuesResource);
        }

        //Added by Aditya J. on 27-12-2024 for common ajax function
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            /*StartLoader("#mainbody");*/
            $.ajax({
                url: encodeURI(strUrl_Project + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    console.log(err);
                    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //StopAjaxLoader("#mainbody");
            return ajaxResult;
        }
        //End of Added by Aditya J. on 27-12-2024 for common ajax function


        //Added by Vishal Mane on 08/10/2025 to show contract details 
        function ShowContractDetails(flag, ContractID) {
            //debugger
            //if (ContractID) {
            //}
            var SelContractID = 0;
            if (flag == 0) {
                var selectedcontractid = $("#ContractProjFilter").val();
                if (selectedcontractid == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_ContractMandatory") %>');
                    $("#ContractProjFilter").focus();
                    return false;                    
                }
                SelContractID = selectedcontractid;
            }
            else if (flag == 1) {
                var selectedRescontractid = $("#ContractResFilter").val();
                if (selectedRescontractid == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_ContractMandatory") %>');
                    $("#ContractResFilter").focus();
                    return false;
                }
                SelContractID = selectedRescontractid;
            }
            //Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
            else if (flag == 2) {
                SelContractID = ContractID;
            }
            //End of Added by Vishal Mane on 27/11/2025 to display Contract Details on Bulk Extension Approval Page
            var offcanvasEl = document.getElementById('moredetailsContract_OffcvsScreen');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();
            //GetContractData(SelContractID);
            var strHTML = "";
            var contractid;
            contractid = SelContractID;
            var WhichAction = 'C';
            var parameter = {
                CustomerID: GlobalCustomerID,
                Flag: 1
            }
            var Param = JSON.stringify(parameter);
            var Result = AJAXCallWithResult_WebAPIUrl("/api/PM_CreateProject/GetContractList", Param, false);
            $("#contrctDetailsTbl").DataTable().destroy();
            //if (Result.length != 0) {
            //    contractid = Result[0]["ContractID"]
            //}
            for (var i = 0; i < Result.length; i++) {
                if (contractid == Result[i]["ContractID"]) {
                    strHTML += '<tr id="tr_"' + Result[i]["ContractID"] + '">'
                    strHTML += '<td>' + Result[i]["ContractID"] + '</td>'
                    strHTML += '<td>' + Result[i]["ContractSummary"] + '</td>'
                    strHTML += '<td><div class="custom_chckbox"><input id="' + Result[i]["ContractID"] + '" class="contrctChck" checked type="checkbox" onclick="bindContractid(' + Result[i]["ContractID"] + ')"><label for="' + Result[i]["ContractID"] + '"></label></div></td>'
                    strHTML += '</tr>'
                }                
            }
            $("#contractdetailsid").html('');
            $("#contractdetailsid").html(strHTML);
            $('#contrctDetailsTbl input[type="checkbox"]').click(function () {
                $('input[type="checkbox"]').not(this).prop("checked", false);
            });
            if (WhichAction == 'C') {
                $("#UpdateContractBtn").hide();
                $(".contrctChck").prop("disabled", true);
            }
            $("#hiddencontractid").val(contractid);
            bindContractData(contractid, GlobalCustomerID);
            getContractAttachmentDetails(contractid, GlobalCustomerID);
        }

        function bindContractData(contractid, CustomerID) {
            var Parameter = {
                CustomerID: CustomerID,
                ContractID: contractid
            }
            var param = JSON.stringify(Parameter);
            Result = AJAXCallWithResult_WebAPIUrl("/api/PM_CreateProject/GetContractDetails", param, false);
            for (var i = 0; i < Result.length; i++) {
                //console.log(Result);
                $('#ContractUniqueIdEdtLabel').text(Result[i].ContractID);
                $("#ContractSumEdtLabel").text(Result[i].ContractSummary);
                $("#CtractDetEdtLabel").text(Result[i].ContractDetails);
                $("#CustEdtLabel").text(Result[i].CustomerName);
                $("#ContctEdtTypeLabel").text(Result[i].ContractTypeID);
                $("#ComDateEdtLabel").text(Result[i].ContractStartDate);
                $("#ComSignDateEdtLabel").text(Result[i].ContractSigningDate);
                $("#ComExpDateEdtLabel").text(Result[i].ContractEndDate);
                $("#ContctEdtValLabel").text(Result[i].ContractValue);
                $("#CurrValEdtLabel").text(Result[i].Currency);
                $("#SOW_NoEdtLabel").text(Result[i].SOWNumber);
                $("#PO_NoEdtLabel").text(Result[i].PONumber);
                $("#ApprTypeEdtLabel").text(Result[i].ApprovalTypeID);
                $("#EndCustGpEdtLabel").text(Result[i].EndCustomerID);
                $("#OppIdEdtLabel").text(Result[i].OpportunityID);
                $("#hiddencontractCurrencyID").val(Result[i].CurrencyID);
                //var CustomerName = $("#cboProjectCustomer option:selected").text();
                $("#CustomerNameLabel").text(Result[i].CustomerName);
            }
        }

        function getContractAttachmentDetails(contractid, CustomerID) {
            var strHTML = "";
            var parameter = {
                ContractID: contractid
            };
            var Param = JSON.stringify(parameter);
            Result = AJAXCallWithResult_WebAPIUrl("/api/PM_CreateProject/GetContractAttachmentList", Param, false);
            if (Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    var filesize = Result[i]["FileSize"];
                    strHTML += '<tr>';
                    strHTML += '<input type="hidden" class="form-control" id="hdn_OrgDocument' + Result[i]["ContractAttachmentID"] + '"  value="' + Result[i]["GeneratedFileName"] + '"/><input type="hidden" class="form-control" id="hdn_Document' + Result[i]["ContractAttachmentID"] + '"  value="' + Result[i]["OriginalFileName"] + '"/>';
                    strHTML += '<td><a href="javascript:;" onclick="DownloadFile(\'' + Result[i]["OriginalFileName"] + '\',\'' + Result[i]["GeneratedFileName"] + '\') ">' + Result[i]["OriginalFileName"] + '</a><i class="fas fa-file-download blueIcn ps-2" data-bs-toggle="tooltip" title="Download" ></i></td>';
                    strHTML += '<td>' + Result[i]["AttachedBy"] + '</td>';
                    strHTML += '<td>' + Result[i]["DateAttached"] + '</td>';
                    strHTML += '<td>' + Result[i]["Description"] + '</td>';
                    strHTML += '</tr>';
                }
            } else {
                strHTML = '<tr><td colspan="4">No data available in table</td></tr>'
            }
            $("#contractdocid").html('');
            $("#contractdocid").html(strHTML);
        }

        function DownloadFile(OriginalFileName, SystemFileName) {
            if (SystemFileName == null) {
                SystemFileName = '';
            }
            var strTemp = '../../General/ViewAttachment.aspx?FromWhere=Contracts&FileName=' + OriginalFileName + '&SystemFileName=' + SystemFileName;
            window.open(strTemp);
        }

        var strWebAPIUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var GlobalCustomerID;
        function AJAXCallWithResult_WebAPIUrl(url, param, async) {
            $.ajax({
                url: encodeURI(strWebAPIUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                //contentType: "application/json;charset-utf=8",
                contentType: "application/json; charset=UTF-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        function GetContractData(ContractId) {
            //debugger
            var Parameters = {
                ContractID: ContractId,
            }
            var param = JSON.stringify(Parameters);
            //var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetContractData", param, false);
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetContractData", param, false);
            GlobalCustomerID = strResult[0].CustomerID;
        }
        //Added by Vishal Mane on 08/10/2025 to show contract details

        //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        function buildWorkflowApprovalUI(projectList, flag) {
            //debugger
            alertify.set('notifier', 'position', 'top-right');
            var container;
            if (flag == 'A') {
                $("#txtApproveCommentID_WF").val("");
                container = $("#workflowProjectContainer");
                
            } else {
                $("#txtRejectCommentID_WF").val("");
                container = $("#workflowProjectContainer_Rejection");
            }
            //Added by Vishal Mane on 02/03/2025 to fix refresh issue which is passing multiple Project IDs
            $("#workflowProjectContainer").html("");
            $("#workflowProjectContainer_Rejection").html("");
            //End of Added by Vishal Mane on 02/03/2025 to fix refresh issue which is passing multiple Project IDs
            container.html("");
            var IsValid = 1;
            for (let i = 0; i < projectList.length; i++) {
                let p = projectList[i];
                // 🔵 API call per project
                let payload = { ProjectID: p.ProjectID };
                var Result;
                var SubmittedWorkflowID = 0;
                if (flag == 'A') {
                    Result = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetWorkflowDetails", JSON.stringify(payload), false);
                }
                else {
                    Result = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetRejectedWorkflowDetails", JSON.stringify(payload), false);
                }
                if (!Result.Workflows || Result.Workflows.length == 0) {
                    alertify.error("Workflow is not configured for project: " + p.ProjectName);
                    IsValid = 0;
                    break;
                }
                // SP returns 2 result tables
                //let workflowList = Result.Table;      // dropdown workflows
                //let headerInfo = Result.Table1[0];  // comma workflow + practice/BG/OU
                let workflowList = Result.Workflows;
                let headerInfo = Result.Header[0];
                let SubmittedWorkflowDetails;
                if (flag == 'R') {
                    SubmittedWorkflowDetails = Result.SubmittedWorkflow[0];
                    SubmittedWorkflowID = SubmittedWorkflowDetails.SubmittedWorkflowID;
                }                
                //let workflowOptions = '<option value="">Select Workflow</option>';
                let workflowOptions = "";
                for (let i = 0; i < workflowList.length; i++) {
                    workflowOptions += `<option value="${workflowList[i].WorkflowID}">
                                    ${workflowList[i].WorkflowName}
                                </option>`;
                }
                let html = `<div class="card border rounded mb-3 workflow-block" data-fromstageid="${headerInfo.FromStageID}" data-projectid="${p.ProjectID}" data-isresubmit="${p.IsResubmit}" data-projectapprovalid="${p.ProjectApprovalID}">
                                <div class="card-body">
                                    <div class="fw-bold mb-1">
                                        Project Name : <span class="lblProjectName">${p.ProjectName}</span>
                                    </div>
                                    <div class="text-muted small mb-3">
                                        <span class="lbl_text">Workflow:</span> 
                                        <span class="lblWorkflowName">${headerInfo.WorkflowName ?? ''}</span><br>
                                        <span class="lbl_text">Practice:</span> ${headerInfo.PracticeName ?? ''} >>
                                        <span class="lbl_text">BU:</span> ${headerInfo.BusinessGroupName ?? ''} >>
                                        <span class="lbl_text">OU:</span> ${headerInfo.LocationName ?? ''}
                                    </div>
                                    <div class="row">
                                        <!-- WORKFLOW DROPDOWN -->
                                        <div class="col-sm-6">
                                            <div class="row align-items-center">
                                                <div class="col-sm-4 text-end">
                                                    <label class="required mb-0">Workflow:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <select class="selectpicker ddlWorkflow" data-live-search="true" data-width="100%" data-projectid="${p.ProjectID}" id="cboSubmittedWF"> ${workflowOptions}</select>
                                                    <!--<select class="ddlWorkflow" data-width="100%" data-projectid="${p.ProjectID}"> ${workflowOptions}</select>-->
                                                </div>
                                            </div>
                                        </div>
                                        <!-- STATUS DROPDOWN -->
                                        <div class="col-sm-6">
                                            <div class="row align-items-center">
                                                <div class="col-sm-4 text-end">
                                                    <label class="required mb-0">Status:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <select class="selectpicker ddlStatusWF" data-live-search="true" data-width="100%" data-projectid="${p.ProjectID}"><option value="">Select Status</option></select>
                                                    <!--<select class="ddlStatusWF" data-width="100%" data-projectid="${p.ProjectID}"><option value="">Select Status</option></select>-->
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>`;
                container.append(html);
                // initialize selectpicker for newly added html
                $('.selectpicker').selectpicker('refresh');
                if (workflowList.length > 0) {
                    if (flag == 'A') {
                        loadWorkflowStatuses(p.ProjectID, 'A');
                    }
                    else {
                        loadWorkflowStatuses(p.ProjectID, 'R');
                    }
                }
                if (flag == 'R') {
                    //$("#cboSubmittedWF").val(SubmittedWorkflowID);
                    //$("#cboSubmittedWF").attr("disabled", true);
                    //$('.selectpicker').selectpicker('refresh');

                    let workflowDDL = $(`.ddlWorkflow[data-projectid='${p.ProjectID}']`);

                    workflowDDL.val(SubmittedWorkflowID);
                    workflowDDL.prop("disabled", true);
                    workflowDDL.selectpicker('refresh');
                }
                //container.append(html);
            }
            if (IsValid == 1) {
                if (flag == 'A') {
                    var offcanvasEl = document.getElementById('sendforApproval_OffcvsScreen');
                    var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
                    offcanvas.show();
                } else {
                    var offcanvasEl = document.getElementById('sendforRejection_OffcvsScreen');
                    var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
                    offcanvas.show();
                }
                
            }
            $('.selectpicker').selectpicker('refresh');
        }

        function loadWorkflowStatuses(projectid, flag) {
            let payload = {
                ProjectID: projectid
            };
            var Result;
            if (flag == 'A') {
                Result = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetWorkflowStatusMaster", JSON.stringify(payload), false);
            }
            else {
                Result = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetRejectedWorkflowStatusMaster", JSON.stringify(payload), false);
            }
            //var Result = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetWorkflowStatusMaster", JSON.stringify(payload), false);
            let statusDDL = $(`.ddlStatusWF[data-projectid='${projectid}']`);
            // destroy selectpicker instance first (important)
            statusDDL.selectpicker('destroy');
            statusDDL.empty();
            //statusDDL.html('<option value="">Select Status</option>');
            if (Result && Result.length > 0) {
                for (let i = 0; i < Result.length; i++) {
                    statusDDL.append(`<option value="${Result[i].StatusID}" data-roleid="${Result[i].RoleID}">
                                ${Result[i].StatusName}
                              </option>`);
                }
            }
            statusDDL.selectpicker('refresh');
        }
        var ApproverRoleList = [];
        function getWorkflowApprovalData() {
            let approvalList = [];
            ApproverRoleList = [];
            let uniqueMap = {};   // 🔵 used to prevent duplicates
            $(".workflow-block").each(function () {
                let fromstageid = $(this).data("fromstageid");
                let projectId = $(this).data("projectid");
                let projapprovalid = $(this).data("projectapprovalid");
                let workflowDDL = $(this).find(".ddlWorkflow");
                let statusDDL = $(this).find(".ddlStatusWF");
                let workflowId = workflowDDL.find("option:selected").val();
                let statusId = statusDDL.find("option:selected").val();
                let actionType = "";
                if (IsApproveReject === 0) {
                    actionType = "REJECT";
                } else {
                    actionType = "APPROVE";
                }
                let roleId = statusDDL.find("option:selected").data("roleid");
                if (!workflowId || !statusId) return;
                // 🔵 create unique key
                let key = projectId + "_" + roleId + "_" + fromstageid + "_" + statusId;
                if (!uniqueMap[key]) {
                    uniqueMap[key] = true;
                    approvalList.push({
                        ProjectID: projectId,
                        WorkflowID: workflowId,
                        StageID: statusId,
                        ActionType: actionType,
                        ProjectApprovalID: projapprovalid,
                        FromStage: fromstageid
                    });
                    ApproverRoleList.push({
                        ProjectID: projectId,
                        RoleID: roleId,
                        FromStageID: fromstageid,
                        ToStageID: statusId,
                        WorkflowID: workflowId,
                    });
                }
            });
            return approvalList;
        }

        var IsApproveReject = 0;
        function ApproveRejectRequest_WF(flag) {
            var IsValid = ValidateSendForApproval(flag);
            if (IsValid == 1) {
                Remarks = "";
                alertify.set('notifier', 'position', 'top-right');
                //if (flag == 'A') {
                //    IsApproveReject = 1;
                //}
                ModalFlag == 'FromProject';
                if (flag == 'A') {
                    Remarks = $("#txtApproveCommentID_WF").val();
                }
                else if (flag == 'R') {
                    Remarks = $("#txtRejectCommentID_WF").val();
                }
                var ApprovalStatus = '';
                if (flag == 'A') {
                    if ($("#txtApproveCommentID_WF").val().trim() == '' || $("#txtApproveCommentID_WF").val().trim() == undefined) {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.error("Approval Comments should not be left blank.");
                        alertify.error('<%=MyBase.GetResourceString("A_BlankApprovalComment") %>');
                        $("#txtApproveCommentID_WF").focus();
                        return;
                    }
                    ApprovalStatus = "Approved";
                }
                if (flag == 'R') {
                    if ($("#txtRejectCommentID_WF").val().trim() == '' || $("#txtRejectCommentID_WF").val().trim() == undefined) {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.error("Rejection Comments should not be left blank.");
                        alertify.error('<%=MyBase.GetResourceString("A_BlankRejectionComment") %>');
                        $("#txtRejectCommentID_WF").focus();
                        return;
                    }
                    ApprovalStatus = 'Rejected';
                }
                if (flag == 'A') {
                    Remarks = $("#txtApproveCommentID_WF").val();
                }
                else if (flag == 'R') {
                    Remarks = $("#txtRejectCommentID_WF").val();
                }
                if (ModalFlag == 'FromProject') {
                   let approvalData = getWorkflowApprovalData();
                   if (approvalData.length == 0) {
                        //alertify.error("No project data available for approval.");
                        alertify.error('<%=MyBase.GetResourceString("A_NoDataAvailable") %>');
                        return;
                    }
                    let payload = {
                        UserID: <%= Session("intUserID") %>,
                        SubmitterRemark: Remarks.replaceAll("'", "''"),
                        WorkflowAttributes: approvalData
                    };
                    var Result = AJAXCallWithResult("/api/PM_BulkExtensionApproval/SubmitWorkflowForApproval", JSON.stringify(payload), false);
                    if (flag == 'A') {
                        if (Result != "") {
                            var ProjectApprovalIDs = Result;
                            Final_Approval_Rejection(ApprovalStatus, ProjectApprovalIDs, 'A');
                            var offcanvasEl = document.getElementById('sendforApproval_OffcvsScreen');
                            var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                            offcanvas.hide();
                            $("#ProjApprCheckAll").prop("checked", false);
                            $("#ResApprCheckAll").prop("checked", false);
                            //Added by Vishal Mane on 02/03/2026 to fix refresh issue
                            checkedValues = [];
                            //End of Added by Vishal Mane on 02/03/2026 to fix refresh issue
                        } else {
                            alertify.success("Request approved successfully.");
                            var offcanvasEl = document.getElementById('sendforApproval_OffcvsScreen');
                            var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                            offcanvas.hide();
                            //$("#btnCloseWorkflow").click();
                            getBulkExtensionApprovalGrid(1);
                            $("#ProjApprCheckAll").prop("checked", false);
                            $("#ResApprCheckAll").prop("checked", false);                            
                            var parameters = {
                                UserID: <%=Session("intUserID")%>,
                                ApproverRoles: ApproverRoleList
                            }
                            var param = JSON.stringify(parameters);
                            var strResult = AJAXCallWithResult_SilentMail("/api/PM_BulkExtensionApproval/SilentMailWorkFowApproval", param, false);
                            //Added by Vishal Mane on 02/03/2026 to fix refresh issue
                            checkedValues = [];
                            //End of Added by Vishal Mane on 02/03/2026 to fix refresh issue
                        }
                    }
                    else if (flag == 'R') {
                        var ProjectApprovalIDs = Result;
                        Final_Approval_Rejection(ApprovalStatus, ProjectApprovalIDs, 'R');
                        var offcanvasEl = document.getElementById('sendforRejection_OffcvsScreen');
                        var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                        offcanvas.hide();
                        $("#ProjApprCheckAll").prop("checked", false);
                        $("#ResApprCheckAll").prop("checked", false);
                        //Added by Vishal Mane on 02/03/2026 to fix refresh issue
                        checkedValues = [];
                        //End of Added by  Vishal Mane on 02/03/2026 to fix refresh issue
                    }
                }
            }
        }

        function ValidateSendForApproval(flag) {
            //debugger
            let IsValid = 1;
            if (flag == 'A') {
                alertify.set('notifier', 'position', 'top-right');
                $(".workflow-block").each(function () {
                    let workflowDDL = $(this).find(".ddlWorkflow");
                    let statusDDL = $(this).find(".ddlStatusWF");
                    //Added by Vishal Mane on 17/02/2026 to Validate If no active employee is mapped to the approver role 
                    let postId = statusDDL.find("option:selected").data("roleid");
                    if (postId > 0) {
                        var ProjectdataParameter = {
                            RoleID: postId,
                        }
                        var param = JSON.stringify(ProjectdataParameter);
                        var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/CheckIsRoleActiveEmployee", param, false);
                        if (strResult[0].IsACtiveEmployee == 0) {
                            alertify.error(`No active employee is mapped to the selected role >> ${strResult[0].RoleDescription}`);
                            //statusDDL.selectpicker('toggle');
                            //statusDDL.focus();
                            IsValid = 0;
                            return false;
                        }
                    }                    
                    //End of Added by Vishal Mane on 17/02/2026 to Validate If no active employee is mapped to the approver role 
                });
            }                        
            return IsValid;
        }

        function Final_Approval_Rejection(Status, PrjApprovalIDs, flag){
            var parameters = {
                //ProjectApprovalIDs: checkedValues.toString(),
                ProjectApprovalIDs: PrjApprovalIDs,
                Remarks: Remarks.replaceAll("'", "''"),
                ApprovedBy:<%= Session("intUserID") %>,
                ApprovalStatus: Status
            }
            var param = JSON.stringify(parameters);
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/ProjectExtensionApprovalRejectRequests", param, false);
            getBulkExtensionApprovalGrid(1);
            if (flag == 'A') {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.success("Request approved successfully.");
                alertify.success('<%=MyBase.GetResourceString("A_RequestApproved") %>');
            }
            else if (flag == 'R') {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.success("Request rejected successfully.");
                alertify.success('<%=MyBase.GetResourceString("A_RequestRejected") %>');
            }
            if (flag == 'A') {                
                //window.open(
                //    "../Email/SendEmail.aspx?MessageID=35014&ProjectApprovalIDs=" + PrjApprovalIDs + "&SubmitterIDs=" + strResult,'','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                //);
                var parameters = {
                    UserID: <%=Session("intUserID")%>,
                    ApproverRoles: ApproverRoleList
                }
                var param = JSON.stringify(parameters);
                var strResult = AJAXCallWithResult_SilentMail("/api/PM_BulkExtensionApproval/SilentMailWorkFowApproval", param, false);
            }
            else if (flag == 'R') {
                var parameters = {
                    UserID: <%=Session("intUserID")%>,
                    ApproverRoles: ApproverRoleList
                }
                var param = JSON.stringify(parameters);
                var strResult = AJAXCallWithResult_SilentMail("/api/PM_BulkExtensionApproval/SilentMailWorkFowRejection", param, false);
                //window.open(
                //    "../Email/SendEmail.aspx?MessageID=35015&ProjectApprovalIDs=" + PrjApprovalIDs + "&SubmitterIDs=" + strResult,'','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550'
                //);
            }
        }

        function AJAXCallWithResult_SilentMail(url, param, async) {
            let ajaxResult = null;
            $.ajax({
                url: encodeURI(strUrl_Project + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (xhr, status, error) {
                    ajaxResult = null;
                    alertify.set('notifier', 'position', 'top-right');
                    let errorMsg = "Failure Sending Mail. Unable to connect to remote server.";
                    //try {
                    //    if (xhr.responseJSON && xhr.responseJSON.Message) {
                    //        errorMsg = xhr.responseJSON.Message;
                    //    }
                    //    else if (xhr.responseText) {
                    //        errorMsg = xhr.responseText;
                    //    }
                    //    else if (error) {
                    //        errorMsg = error;
                    //    }
                    //} catch (e) { }
                    //Specified argument was out of the range of valid values
                    alertify.error(errorMsg);
                }
            });
            return ajaxResult;
        }


        
    //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen

    </script>

</body>

</html>
