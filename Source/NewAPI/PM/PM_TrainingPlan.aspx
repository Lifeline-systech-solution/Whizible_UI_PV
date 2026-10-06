<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TrainingPlan.aspx.vb" Inherits="Whizible.PM_TrainingPlan" %>

<!DOCTYPE html>

<html>

        <%CommonFunctions.General.PlotPageHeadTag("Training Plan")%>


<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">



    <title><%=MyBase.GetResourceString("C_TrainingPlans")%></title>
    <!-- Tell the browser to be responsive to screen width -->
    <%--<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css"> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
     <!-- Added By Madhuri.K On 02-04-2026 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">

    <style>
        /* Fix z-index issue - make alertify notifications appear above modals */
        .alertify-notifier {
            z-index: 9999 !important;
        }
        .alertify-notifier .ajs-message {
            z-index: 9999 !important;
        }
        
        /* Hide sorting arrows from table headers */
        #ResourcesTbl th::after,
        #ResourcesTbl th::before,
        #ResourcesTbl th i,
        #ResourcesTbl th .fa,
        #ResourcesTbl th .fas,
        #ResourcesTbl th .far,
        #ResourcesTbl th .sort,
        #ResourcesTbl th .sorting,
        #ResourcesTbl th .sorting_asc,
        #ResourcesTbl th .sorting_desc {
            display: none !important;
        }
        
        /* Hide any pseudo-elements that might be creating arrows */
        #ResourcesTbl th:after,
        #ResourcesTbl th:before {
            display: none !important;
        }
    </style>

    <style type="text/css">
         /* <!-- Modified By Madhuri.K On 02-04-2026 --> */
        body{
            font-size:11.5px;
        }
        .bootstrap-select .dropdown-menu>li>a {
    font-size: 11.5px !important;
}
        .table-fixed-header thead tr th, .table thead tr th {
            background: rgb(231, 237, 240) !important;
        }
        .pagination-containerRs, .pagination-containerHs{
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 8px;
        }
        

         #AdvanceFilterIconClicked {
           background-color: #1359a6;
           color: white;
         }

        .dataTables_scrollBody {
            margin-bottom: 10px
        }

        .listboxpanel select {
            min-height: 320px
        }

        table tr th, table tr td {
            text-align: center !important
        }

            table tr th:last-child, table tr td:last-child {
                text-align: center;
                /*width: 80px*/
            }

        .dataTables_scrollHeadInner, .dataTables_scrollHeadInner table {
            width: 100% !important
        }

        .dataTables_scrollHeadInner {
            width: 100% !important
        }

        div.dataTables_scrollBody > table {
            width: 100% !important
        }
        .custom_chckbox label:before {
            margin-right: 10px;
        }
        .accordion-button{
               /* <!-- Modified By Madhuri.K On 02-04-2026 --> */
            font-size: 12px;
        }
        .nostylebtn {
            background: none;
            border: none;
            padding: 0;
            outline: none;
        }
        .custmfields .form-group {
            background: #f5f5f5;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .custmfields .form-group .col-sm-2 {
            padding-right: 0px;
        }
        .ui-datepicker {
            z-index: 9999!important;
        }
        
        /* Hide scrollbar when dropdown is closed, show when open */
        .bootstrap-select .dropdown-menu {
            overflow-y: auto;
        }
        
        .bootstrap-select:not(.open) .dropdown-menu {
            overflow-y: hidden;
        }
        
        .bootstrap-select.open .dropdown-menu {
            overflow-y: auto;
            max-height: 200px; /* Adjust height as needed */
        }
        
        /* Custom scrollbar styling */
        .bootstrap-select .dropdown-menu::-webkit-scrollbar {
            width: 6px;
        }
        
        .bootstrap-select .dropdown-menu::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }
        
        .bootstrap-select .dropdown-menu::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
        }
        
        .bootstrap-select .dropdown-menu::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }
        
        /* Required field asterisk styling */
        .required::after {
            content: " *";
            color: red;
            font-weight: bold;
        }

        /* Added by Vyankat B. on 23-Mar-2026 - keep AddResources close icon white always */
        #AddResourcesModalClose,
        #AddResourcesModalClose:hover,
        #AddResourcesModalClose:focus,
        #AddResourcesModalClose:active {
            color: #fff !important;
        }
        #AddResourcesModalClose i,
        #AddResourcesModalClose:hover i,
        #AddResourcesModalClose:focus i,
        #AddResourcesModalClose:active i {
            color: #fff !important;
        }
        /* End of Added by Vyankat B. on 23-Mar-2026 - keep AddResources close icon white always */

        /* Hide DataTable's built-in pagination completely */
        .dataTables_paginate {
            display: none !important;
        }
        
        .dataTables_info {
            display: none !important;
        }
        
        .dataTables_length {
            display: none !important;
        }

        /* Fixed table header */
        .dataTables_scrollHead {
            position: sticky !important;
            top: 0 !important;
            z-index: 100 !important;
            background: white !important;
        }
        
        .dataTables_scrollHead table {
            margin-bottom: 0 !important;
        }
        
        .dataTables_scrollHead th {
            background: #f8f9fa !important;
            border-bottom: 2px solid #dee2e6 !important;
            position: sticky !important;
            top: 0 !important;
            z-index: 101 !important;
        }
        
        /* Ensure proper scrolling with fixed header */
        .dataTables_scrollBody {
            max-height: calc(100vh - 120px) !important;
            overflow-y: auto !important;
            height: auto !important;
            transition: height 0.3s ease; /* Smooth transition when height changes */
        }
        
        /* Fix header styling to match table */
        .dataTables_scrollHeadInner {
            background: white !important;
        }

        /* Pagination container after table */
        .pagination-container {
            background: white;
            display: flex !important;
            justify-content: flex-end;
            align-items: center;
            padding: 1rem;
            gap: 1rem;
            margin-top: 0;
            /*position: absolute;*/
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            visibility: visible !important;
            opacity: 1 !important;
        }
        
        /* Red circle indicators for disabled pagination buttons */
        #firstPageBtn:hover .prev-red-circle,
        #lastPageBtn:hover .next-red-circle {
            opacity: 1 !important;
        }
        
        /* Show red circle when button is disabled */
        #firstPageBtn:disabled .prev-red-circle,
        #lastPageBtn:disabled .next-red-circle {
            opacity: 1 !important;
        }
        
      
        
        /* Show scrollbar on hover */
        #TrainingPlanTbl_wrapper:hover {
            overflow-y: auto; /* Show scrollbar on hover */
            padding-right: 0; /* Remove padding when scrollbar is visible */
        }
        
        /* Custom scrollbar styling for webkit browsers */
        #TrainingPlanTbl_wrapper::-webkit-scrollbar {
            width: 8px; /* Thin scrollbar width */
        }
        
        #TrainingPlanTbl_wrapper::-webkit-scrollbar-track {
            background: #f1f1f1; /* Track color */
        }
        
        #TrainingPlanTbl_wrapper::-webkit-scrollbar-thumb {
            background: #ccc; /* Thumb color */
            border-radius: 4px; /* Rounded corners */
        }
        
        #TrainingPlanTbl_wrapper::-webkit-scrollbar-thumb:hover {
            background: #999; /* Thumb color on hover */
        }
        
        #TrainingPlanTbl thead th {
            position: sticky;
            top: 0;
            z-index: 10;
            border-bottom: 2px solid #dee2e6;
        }
        
        #TrainingPlanTbl {
            margin-bottom: 0;
        }
        
        
        
        
        /* Add bottom padding to body to prevent content from being hidden behind fixed pagination */
        body {
            padding-bottom: 80px;
        }

      


        /* Hide number input spinner arrows */
        input[type="text"]::-webkit-outer-spin-button,
        input[type="text"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        
        input[type="text"] {
            -moz-appearance: textfield;
        }

        /* Hide DataTable sorting arrows */
        #TrainingPlanTbl thead th.sorting,
        #TrainingPlanTbl thead th.sorting_asc,
        #TrainingPlanTbl thead th.sorting_desc {
            background-image: none !important;
        }
        
        #TrainingPlanTbl thead th.sorting:after,
        #TrainingPlanTbl thead th.sorting_asc:after,
        #TrainingPlanTbl thead th.sorting_desc:after {
            content: none !important;
        }
        .bootstrap-select>.dropdown-toggle {
            width: 250px;
        }
        
    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
   <!-- Page Loader - Show immediately -->
   <div class="loader-overlay" id="loaderOverlay" style="display: none;">
       <div class="loader"></div>
   </div>
     
      <!--  Added By Vyankat B on 19/04/2025 for the Role Access -->
     <%If m_blnViewAccess = True Then%>
      <!--End of Added By Vyankat B on 19/04/2025 for the Role Access -->
    <div class="bgwhite">
        <!-- Header Section with Icon and Subtitle -->
        <div style="background: white; padding: 1rem 0;">
            <div style="padding-left: 1rem; margin-left: 0;">
                <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                    <i class="fas fa-graduation-cap" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;"></i>
                  <%=MyBase.GetResourceString("C_TrainingPlans")%> 
                </h2>
                <p style="color: #6b7280; font-size: 0.7rem; margin: 0;"> <%=MyBase.GetResourceString("C_TrainigDesc")%>  </p>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div style="background: rgb(231, 237, 240); padding: 0.5rem 1rem; margin-left: 2px;">
            <div style="display: flex; align-items: center; justify-content: space-between; gap: 0.75rem;">
                <!-- Left Side - Project Dropdown -->
                <div style="display: flex; align-items: center; gap: 0.5rem;">
                    <label style="color: #374151;  font-weight: 500; margin: 0;"><%=MyBase.GetResourceString("C_SelProj")%></label>
                    <div style="min-width: 200px;">
                        <select id="ProjectFilter" class="selectpicker" data-live-search="true">
                            <option value=""><%=MyBase.GetResourceString("C_SelProject")%></option>
                        </select>
                    </div>
                </div>
                <!-- Right Side - Search and Filter -->
                <div style="display: flex; align-items: center; gap: 0.75rem;">
                    <div style="display: flex; align-items: center; background: white; border-radius: 0.25rem; border: 1px solid #d1d5db; overflow: hidden; height: 2rem; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
                        <input type="text" id="searchInput" placeholder="Search.." oninput="handleSearchInput()" style="border: none; outline: none; padding: 0.25rem 0.5rem; flex: 1; background: transparent; height: 100%; font-size: 11.5px;">
                        <button id="searchBtn" onclick="handleSearchInput()" style="background: #f3f4f6; border: none; padding: 0.25rem 0.5rem; color: #374151; cursor: pointer; height: 100%; display: flex; align-items: center; border-left: 1px solid #d1d5db;">
                            <i class="fas fa-search" style="font-size: 11.5px;"></i>
                        </button>
                    </div>
                    <a href="javascript:;" class="clearalllink pe-3" id="ClearAllFilter" data-bs-toggle="tooltip" title="Clear All" onclick="clearAllFilters()" style="color: #1359a6; text-decoration: none; font-size: 11.5px; margin-right: 0; display: none !important;"><strong><%=MyBase.GetResourceString("C_ClearAll")%></strong></a>
                    <span data-bs-toggle="tooltip" title="Filter">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" id="AdvanceFilterIcon" autocomplete="off" class="" aria-expanded="false" style="background: none; border: none; color: #374151; font-size: 11.5px; cursor: pointer; padding: 0.5rem;">
                            <i class="fas fa-filter"></i>
                        </button>
                    </span>
                </div>
            </div>
        </div>

        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid py-1 filterpanelheader">
                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="nav-item active" style="margin-left: 0px;">
                            <a class="nav-link" href="#TPlanBasicFilters" data-bs-toggle="tab" aria-expanded="true" onclick="showBasicFilterPanel()"><%=MyBase.GetResourceString("C_BFilters")%>
                                </a>
                        </li>
                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="TPlanBasicFilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center mb-3">
                                    <% If m_blnAddAccess Then %>
<%--                                    <button class="btn btnyellow" id="svfilterbtn" onclick="checkFieldsAndShowModal()"><%=MyBase.GetResourceString("C_SaveApply")%></button>--%>
                                     <%End If %>
                                    <button class="btn btnyellow" onclick="basicFilterApply()"><%=MyBase.GetResourceString("C_Apply")%></button>
                                </div>

                                <div class="filterSection">
                                    <div class="row d-flex justify-content-center">
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="SkillsFilter" class="text-end"><%=MyBase.GetResourceString("C_Skills")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <%=CommonFunctions.HTMLControls.DrawComboBox("SkillsFilter", "usp_Whizible2_Sel_AllSkills ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="TraningPeriodFilter" class="text-end"><%=MyBase.GetResourceString("C_Training_Period")%></label>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <input type="text" class="form-control" id="TraningPeriodFilter" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="UnitFilter" class="text-end"><%=MyBase.GetResourceString("C_Unit")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                             <%=CommonFunctions.HTMLControls.DrawComboBox("UnitFilter", "usp_Whizible2_Sel_DayFormat ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="TraningAreaFilter" class="text-end"><%=MyBase.GetResourceString("C_TrainingArea")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="TraningAreaFilter" maxlength="250"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
            
                                                
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="WaiverCriteriaFilter" class="text-end"><%=MyBase.GetResourceString("C_WaiverCriteria")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="WaiverCriteriaFilter" maxlength="250"></textarea>
                                                        </div>
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
                </div>
            </div>
        </div>
    </div>
    <!--end filter panel-->


    <!-- Set Base line confrimation modal start --Added by Vyankat B -->
 <div id="SetBaseLineConfirmation" class="modal fade custmodal" role="dialog" aria-hidden="false" data-bs-backdrop="static" >


  <div class="modal-dialog modalsmall ui-draggable">

<!-- Modal content-->
 
<div class="modal-content">

  <div class="modal-header ui-draggable-handle">

  <button type="button" class="close" data-bs-dismiss="modal">×</button>

      <h4 class="modal-title w-100" ><%=MyBase.GetResourceString("C_Confirm")%></h4>

 </div>
 
<div class="modal-body">
 
                  <p class="text-center"><%=MyBase.GetResourceString("C_PressOk")%>
                      </p>
<p class="text-center"><%=MyBase.GetResourceString("C_PressCancel")%></p>
 
   <div class="form-group mt-4">
 
  <div class="form-group mt-4">
       <div class="d-flex justify-content-center">
             <button class="btn borderbtn mx-2" data-bs-dismiss="modal" onclick="assignTaskToResource(true)"><%=MyBase.GetResourceString("C_OK")%></button>
             <button class="btn btnyellow mx-2" data-bs-dismiss="modal" onclick="assignTaskToResource(false)"><%=MyBase.GetResourceString("C_Cancel")%></button>
       </div>
  </div>
</div>
 
       </div>
 
         </div>
</div>
  <div class="clearfix"></div>
</div>
<!-- Set Base line confrimation modal end  --End of Added by Ajit-->


    <div class="content">

                                   <%--Added By Vyankat B On 19th Nov 2025 For the Edit View Access--%>
                                <% If m_blnEditAccess = True Then %>
                                <div class="text-end mb-2">
                                    <button class="btn btnyellow" id="AddTrPlanDtlsTab" data-bs-toggle="offcanvas" data-bs-target="#offcanvasAddTrainingPlan" onclick="binddropdown()">Add</button>
                                </div>
                                <%End If %>

                        <!-- Added by Gauri - Issue Details Offcanvas start -->
                        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-80" data-bs-scroll="false" tabindex="-1" id="offcanvasAddTrainingPlan">
                            <%--<div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                                <div class="row flex-grow-1">
                                    <div class="col-sm-10">
                                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_SetTrainingPlan")%></h5>
                                    </div>
                                    <div class="col-sm-2 text-end">
                                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>--%>


                            <div class="offcanvas-body px-4 pb-4">
                                <div class="graybg container-fluid py-1 mb-2">
                                    <div class="row align-items-center">
                                        <div class="col-sm-6">
                                            <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_SetTrainingPlan")%></h5>
                                        </div>
                                       <%-- <div class="col-sm-6 text-end">
                                            <button type="button" class="btn-close" id='AddClose' data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                        </div>--%>
                                        <div class="col-sm-6 text-end">
                                            <button type="button" class="btn btn-sm btn-danger-modern" id='AddClose' data-bs-toggle="tooltip" data-bs-dismiss="offcanvas"  aria-label="<%= MyBase.GetResourceString("C_Close") %>" data-bs-original-title="<%= MyBase.GetResourceString("C_Close") %>" style="padding: 2px 6px; line-height: 1;">
                                                <i class="fas fa-times" style="font-size: 12px;"></i>
                                            </button>
                                        </div>

                                    </div>
                                </div>

                                <div class="EditContent">
                                    <div class="text-end mb-2">
                                        <button class="btn btnyellow" id="SaveTrPlanDtlsTab" onclick="saveTrainingSkill()">Save</button>
                                    </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="SkillsAdd" class="required text-end"><%=MyBase.GetResourceString("C_Skills")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <%=CommonFunctions.HTMLControls.DrawComboBox("SkillsAdd", "usp_Whizible2_Sel_AllSkills ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="TraningPeriodAdd" class="required text-end"><%=MyBase.GetResourceString("C_Training_Period")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="TraningPeriodAdd" maxlength="5" pattern="[0-9]{1,5}" title="Please enter only numeric values (1-5 digits)" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="UnitAdd" class="required text-end"><%=MyBase.GetResourceString("C_Unit")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <%=CommonFunctions.HTMLControls.DrawComboBox("UnitAdd", "usp_Whizible2_Sel_DayFormat",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="TraningAreaAdd" class="text-end"><%=MyBase.GetResourceString("C_TrainingArea")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="TraningAreaAdd" maxlength="250"></textarea>
                                                        </div>
                                                    </div>
                                                </div>

                                            
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="WaiverCriteriaAdd" class="text-end"><%=MyBase.GetResourceString("C_WCriteria")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="WaiverCriteriaAdd" maxlength="250"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                               <%-- <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row" id="compleCheckBox">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="completedEdtCheck" class="text-end"><%=MyBase.GetResourceString("C_Completed")%></label>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <div class="custom_chckbox">
                                                                <input id="completedEdtCheck" class="chcktbl" type="checkbox">
                                                                <label for="completedEdtCheck"></label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                            </div>
                                        </div>
                            </div>
                        </div>
                        <!-- Edit Details Panel end here -->
                                   <%--End of Added By Vyankat B On 19th Nov 2025 For the Edit View Access--%>

        <!-- Add Training Plan Details start here -->
      <%--  <div class="accordion WF_TopAccordianPanel my-3 " id="AddDtlsAcc">
            <div class="accordion-item mb-3">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#AddTrPlanDtlsTab" aria-expanded="false" onclick="binddropdown()">
                        <i class="fas fa-plus addIcn pe-2"></i><%=MyBase.GetResourceString("C_NewTPlan")%>  
                    </button>
                </h2>

                <div id="AddTrPlanDtlsTab" class="accordion-collapse collapse">
                    <div class="accordion-body">
                        <div class="AddNewDtlsInfo">
                            <div class="row">
                                <div class="col-sm-11">
                                    <div class="AddContent">
                                        <div class="row">
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="SkillsAdd" class="required text-end"><%=MyBase.GetResourceString("C_Skills")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <%=CommonFunctions.HTMLControls.DrawComboBox("SkillsAdd", "usp_Whizible2_Sel_AllSkills ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="TraningPeriodAdd" class="text-end"><%=MyBase.GetResourceString("C_Training_Period")%><span style="color: red; display: inline; vertical-align: baseline; line-height: 1;">*</span></label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="TraningPeriodAdd" maxlength="5" pattern="[0-9]{1,5}" title="Please enter only numeric values (1-5 digits)" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="UnitAdd" class="required text-end"><%=MyBase.GetResourceString("C_Unit")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <%=CommonFunctions.HTMLControls.DrawComboBox("UnitAdd", "usp_Whizible2_Sel_DayFormat",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="TraningAreaAdd" class="text-end"><%=MyBase.GetResourceString("C_TrainingArea")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <textarea class="form-control" id="TraningAreaAdd" maxlength="250"></textarea>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="WaiverCriteriaAdd" class="text-end"><%=MyBase.GetResourceString("C_WaiverCriteria")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <textarea class="form-control" id="WaiverCriteriaAdd" maxlength="250"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row mt-4">
                                                    <div class="col-sm-12 d-flex justify-content-center gap-2" style="margin-left: -2rem;">
                                                        <%--Added By Vyankat B On 19th Nov 2025 For the Add View Access--%>
                                       <%--  <% If m_blnAddAccess Then %>
                                                        <i class="fas fa-check clickYes pe-2" id="AddClickYes" data-bs-toggle="tooltip" title="Save" onclick="saveTrainingSkill()" style="color: #28a745; font-size: 1.2rem; cursor: pointer; background: white; border: 1px solid #d1d5db; border-radius: 50%; padding: 0.5rem; display: flex; align-items: center; justify-content: center; width: 2rem; height: 2rem;"></i>
                                          <%End If %>
                                                        <%--End of Added By Vyankat B On 19th Nov 2025 For the Add View Access--%>
                                                      <%--  <i class="fas fa-times clickNo" id="AddClickNo" data-bs-toggle="tooltip" title="Clear" onclick="clearTrainingPlan()" style="color: #dc3545; font-size: 1.2rem; cursor: pointer; background: white; border: 1px solid #d1d5db; border-radius: 50%; padding: 0.5rem; display: flex; align-items: center; justify-content: center; width: 2rem; height: 2rem;"></i>
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
        </div>--%>
        <!-- Add Training Plan Details end here -->
        <div class="TrainingPlansDiv">

        <table id="TrainingPlanTbl" class="table table-stripped newTblStyle" style="width: 100%;">
            <thead>
                <tr>
                    <th><%=MyBase.GetResourceString("C_Skills")%></th>
                    <th><%=MyBase.GetResourceString("C_Training_Period")%></th>
                    <th><%=MyBase.GetResourceString("C_Completed")%></th>
                    <th>&nbsp;<%=MyBase.GetResourceString("C_Action")%></th>
                </tr>
            </thead>
            <tbody>
              
            </tbody>
        </table>
        </div>

        <!-- Custom Pagination Section -->
        <div class="pagination-container">
            <div style="color: #374151; font-size: 11.5px;">
                <span id="totalRecords">
<%--                    Total Records: 0--%>

                </span>
            </div>
            <div style="display: flex; gap: 0.5rem;">
                <button id="firstPageBtn" onclick="goToPreviousPage()" data-bs-toggle="tooltip" title="Previous Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                    <i class="fas fa-angle-double-left"></i>
                    <span class="prev-red-circle" style="position: absolute; top: -6px; right: -6px; width: 12px; height: 12px; background-color: #dc3545; border-radius: 50%; opacity: 0; transition: opacity 0.3s ease; border: 2px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.3); z-index: 10;"></span>
                </button>
                <button id="lastPageBtn" onclick="goToNextPage()" data-bs-toggle="tooltip" title="Next Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                    <i class="fas fa-angle-double-right"></i>
                    <span class="next-red-circle" style="position: absolute; top: -6px; right: -6px; width: 12px; height: 12px; background-color: #dc3545; border-radius: 50%; opacity: 0; transition: opacity 0.3s ease; border: 2px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.3); z-index: 10;"></span>
                </button>
            </div>
        </div>

         <!-- Edit Training Plan Section starts -->
         <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="offcanvas_EdtTrainPlans">
            <div class="offcanvas-body">
                <div class="Edit_Details">
                    <div class="graybg container-fluid py-1 mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-6">
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_Training")%></h5>
                            </div>
                            <div class="col-sm-6 text-end">
                                <button type="button" class="btn btn-sm btn-danger-modern" id='EditClose' data-bs-toggle="tooltip" data-bs-dismiss="offcanvas" aria-label="<%= MyBase.GetResourceString("C_Close") %>" data-bs-original-title="<%= MyBase.GetResourceString("C_Close") %>" style="padding: 2px 6px; line-height: 1;">
                                    <i class="fas fa-times" style="font-size: 12px;"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-sm-12 ">
                            <div class="row">
                                <div class="col-sm-4">
                                </div>
                                <div class="col-sm-8 text-end">
                                    <a href="javascript:;" class="textUndrln me-3" id="BkPlansShowHisBtn"
                                    onclick="ShowHistoryTab()">
                                    <span data-bs-toggle="tooltip" title="Show History"><%=MyBase.GetResourceString("C_ShowHistory")%></span>
                                </a>

                                   <%--Added By Vyankat B On 19th Nov 2025 For the Edit View Access--%>
                                   <% If m_blnEditAccess = True Then %>
                                    <button class="btn btnyellow" id="saveAddTrPlanBtn" data-bs-toggle="tooltip" title="Save" onclick="updateTrainingPlan(true)"><%=MyBase.GetResourceString("C_Save")%></button>
                                   <%End If %>
                                   <%--End of Added By Vyankat B On 19th Nov 2025 For the Edit View Access--%>

                                     <%--Added By Vyankat B On 19th Nov 2025 For the Edit and Add View Access--%>
                                     <% If m_blnEditAccess = True And m_blnAddAccess = True Then %>
                                    <button class="btn btnyellow" id="saveandAddTrPlanBtn" data-bs-toggle="tooltip" title="Save and Add" onclick="updateTrainingPlan()"><%=MyBase.GetResourceString("C_SaveAdd")%></button>
                                                                <%End If %>
                                     <%--End of Added By Vyankat B On 19th Nov 2025 For the Edit and Add View Access--%>

                                    
                                    <%--Added By Vyankat B On 19th Nov 2025 For the Delete View Access--%>
                                      <% If m_blnDeleteAccess = True Then %>
                                    <button class="btn borderbtn me-2" id="deleteTrPlanBtn" data-bs-toggle="tooltip" title="Delete" onclick="showDelModalTplan()"><%=MyBase.GetResourceString("C_Delete")%></button>
                                    <%End If %>
                                <%--End of Added By Vyankat B On 19th Nov 2025 For the Delete View Access--%>
                                    <button type="button" class="btn borderbtn closebtn text-end" id="offcanvasClose"   style="display: none;" data-bs-toggle="tooltip" title="Close"
                                        data-bs-dismiss="offcanvas">
                                       <%=MyBase.GetResourceString("C_Close")%>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red"><%=MyBase.GetResourceString("C_Star")%></font>
                              <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                        </div>
                    </div>

                    <div class="accordion Off_acordian_panel my-3 " id="EditDetailsAcc">
                        <!-- Edit Details Panel start here -->


                        <div class="accordion-item mb-3">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#EditDetailsTab" aria-expanded="true">
                                    <%=MyBase.GetResourceString("C_SetTrainingPlan")%>
                                </button>
                            </h2>
                            <div id="EditDetailsTab" class="accordion-collapse collapse show">
                                <div class="accordion-body">
                                    <div class="EditContent">
                                        <div class="row">
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label for="SkillsEdit" class="required text-end"><%=MyBase.GetResourceString("C_Skills")%></label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <%=CommonFunctions.HTMLControls.DrawComboBox("SkillsEdit", "usp_Whizible2_Sel_AllSkills ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label for="TraningPeriodEdit" class="required text-end"><%=MyBase.GetResourceString("C_Training_Period")%></label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="TraningPeriodEdit" maxlength="5" pattern="[0-9]{1,5}" title="Please enter only numeric values (1-5 digits)" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label for="UnitEdit" class="required text-end"><%=MyBase.GetResourceString("C_Unit")%></label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <%=CommonFunctions.HTMLControls.DrawComboBox("UnitEdit", "usp_Whizible2_Sel_DayFormat ",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label for="TraningAreaEdit" class="text-end"><%=MyBase.GetResourceString("C_TrainingArea")%></label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <textarea class="form-control" id="TraningAreaEdit" maxlength="250"></textarea>
                                                    </div>
                                                </div>
                                            </div>

                                            
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label for="WaiverCriteriaEdit" class="text-end"><%=MyBase.GetResourceString("C_WCriteria")%></label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <textarea class="form-control" id="WaiverCriteriaEdit" maxlength="250"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="row" id="compleCheckBox">
                                                    <div class="col-sm-4 d-flex justify-content-end">
                                                        <label for="completedEdtCheck" class="text-end"><%=MyBase.GetResourceString("C_Completed")%></label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="custom_chckbox">
                                                            <input id="completedEdtCheck" class="chcktbl" type="checkbox">
                                                            <label for="completedEdtCheck"></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Edit Details Panel end here -->

                        <!-- Resources Details Panel start here -->
                        <div class="accordion-item mb-3" id="ResourceDetails">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#ResDetailsTab" aria-expanded="true">
                                   <%=MyBase.GetResourceString("C_IdentifyTraining")%>
                                </button>
                            </h2>
                            <div id="ResDetailsTab" class="accordion-collapse collapse show">
                                <div class="accordion-body">
                                    <div class="TabSection">
                                        <ul class="nav nav-tabs detailsubtabs">
                                            <li class="nav-item">
                                                <a class="nav-link active" href="#ResourcesTabEdt" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_Resources")%></a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <!-- Resources Tab -->
                                            <div id="ResourcesTabEdt" class="tab-pane active mt-2">
                                                <div class="container-fluid">
                                                    <div class="form-inline pb-1">
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                &nbsp;
                                                            </div>
                                                             <% If m_blnAddAccess Then %>
                                                            <div class="col-sm-6 text-end">
                                                                <a href="javascript:;" class="btn borderbtn addbtn" id="AddResourcesBtn"  data-bs-toggle="modal" data-bs-target="#AddResourcesModal"><i class="fas fa-plus"></i><%=MyBase.GetResourceString("C_Add")%></a>
                                                            </div>
                                                            <%End If %>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                    </div>
                            
                                                    <div class="table-responsive">
                                                        <table id="ResourcesTbl" class="table table-stripped" style="width: 100%;">
                                                            <thead>
                                                                <tr>
                                                                    <th><%=MyBase.GetResourceString("C_Resource")%></th>
                                                                    <th><%=MyBase.GetResourceString("C_StartDate")%></th>
                                                                    <th><%=MyBase.GetResourceString("C_EndDate")%></th>
                                                                    <th><%=MyBase.GetResourceString("C_WorkHM")%></th>
                                                                    <th>&nbsp;<%=MyBase.GetResourceString("C_Action")%></th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                               
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <%--                                                    Pagination of Resource Table--%>

                                                                                                 <!-- Custom Pagination Section -->
                                                    <div class="pagination-containerRs">
                                                        <div style="color: #374151; font-size: 11.5px;">
                                                            <span id="totalRecordsRs">
                                            <%--                    Total Records: 0--%>

                                                            </span>
                                                        </div>
                                                        <div style="display: flex; gap: 0.5rem;">
                                                            <button id="firstPageBtnRs" onclick="goToPreviousPageRs()" data-bs-toggle="tooltip" title="Previous Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                                                <i class="fas fa-angle-double-left"></i>
                                                                <span class="prev-red-circle" style="position: absolute; top: -6px; right: -6px; width: 12px; height: 12px; background-color: #dc3545; border-radius: 50%; opacity: 0; transition: opacity 0.3s ease; border: 2px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.3); z-index: 10;"></span>
                                                            </button>
                                                            <button id="lastPageBtnRs" onclick="goToNextPageRs()" data-bs-toggle="tooltip" title="Next Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                                                <i class="fas fa-angle-double-right"></i>
                                                                <span class="next-red-circle" style="position: absolute; top: -6px; right: -6px; width: 12px; height: 12px; background-color: #dc3545; border-radius: 50%; opacity: 0; transition: opacity 0.3s ease; border: 2px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.3); z-index: 10;"></span>
                                                            </button>
                                                        </div>
                                                    </div>

<%--                                                    Pagination of Resource Table--%>
                                                </div>
                        
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- Resources Details Panel end here -->
                    </div>

                </div>

                                        <!-- Show History Details Panel start here -->
                                        <div class="ShowHisDetailpanel mb-4" id="showhisID">
                                            <div class="pgdetailinner p-0">
                                                <hr />
                                                <div class="BkPlanHistory">
                                                    <ul class="nav nav-tabs detailsubtabs mt-4">
                                                        <li class="nav-item">
                                                            <a class="nav-link active" href="#BkPlanHisTab" data-bs-toggle="tab"
                                                                id=""><%=MyBase.GetResourceString("C_History")%></a>
                                                        </li>
                                                    </ul>
                                                    <div class="tab-content">
                                                        <!-- History Tab -->
                                                        <div id="BkPlanHisTab" class="tab-pane active mt-2">
                                                            <div class="container-fluid">
                                                                <div class="form-inline hstryfltr pb-1">
                                                                    <div class="row">
                                                                        <div class="col-sm-6">
                                                                            &nbsp;
                                                                        </div>
                                                                        <div class="col-sm-6">
                                                                            <div class="d-flex justify-content-end gap-2 pe-2">
                                                                                <a href="javascript:;"
                                                                                    class="btn borderbtn cancelEdtDetpanel"
                                                                                    id="CancelBtn" data-bs-toggle="tooltip"
                                                                                    title="Cancel"><%=MyBase.GetResourceString("C_Cancel")%></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row d-flex justify-content-center mt-3">
                                                                        <div class="col-sm-5">
                                                                            <div class="row form-group">
                                                                                <div class="col-sm-6 d-flex justify-content-end">
                                                                                    <label><%=MyBase.GetResourceString("C_ModifiedField")%></label>
                                                                                </div>
                                                                                <div class="col-sm-6">
                                                                                    <select class="selectpicker" data-live-search="true"
                                                                                        id="modifiedHisField">   
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-5">
                                                                            <div class="row form-group">
                                                                                <div class="col-sm-6 d-flex justify-content-end">
                                                                                    <label><%=MyBase.GetResourceString("C_ModifiedBy")%></label>
                                                                                </div>
                                                                                <div class="col-sm-6">
                                                                                    <select class="selectpicker" data-live-search="true"
                                                                                        id="modifiedHisBy">
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                
                                                                <div class="table-responsive">
                                                                    <table id="BkPlanShowHisTable" class="table table-stripped"
                                                                        style="width:100%;">
                                                                        <thead>
                                                                            <tr>
                                                                                <th class="col-sm-3"><%=MyBase.GetResourceString("C_ModifiedFld")%></th>
                                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_OldValue")%></th>
                                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_NewValue")%></th>
                                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                                                                                <th class="col-sm-2"><%=MyBase.GetResourceString("C_MfdBy")%></th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                          
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <br />

                                                                  <%--                                                    Pagination of Resource Table--%>

                                                                                                 <!-- Custom Pagination Section -->
                                                    <div class="pagination-containerHs">
                                                        <div style="color: #374151; font-size: 11.5px;">
                                                            <span id="totalRecordsHs">
                                            <%--                    Total Records: 0--%>

                                                            </span>
                                                        </div>
                                                        <div style="display: flex; gap: 0.5rem;">
                                                            <button id="firstPageBtnHs" onclick="goToPreviousPageHs()" data-bs-toggle="tooltip" title="Previous Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                                                <i class="fas fa-angle-double-left"></i>
                                                                <span class="prev-red-circle" style="position: absolute; top: -6px; right: -6px; width: 12px; height: 12px; background-color: #dc3545; border-radius: 50%; opacity: 0; transition: opacity 0.3s ease; border: 2px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.3); z-index: 10;"></span>
                                                            </button>
                                                            <button id="lastPageBtnHs" onclick="goToNextPageHs()" data-bs-toggle="tooltip" title="Next Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                                                <i class="fas fa-angle-double-right"></i>
                                                                <span class="next-red-circle" style="position: absolute; top: -6px; right: -6px; width: 12px; height: 12px; background-color: #dc3545; border-radius: 50%; opacity: 0; transition: opacity 0.3s ease; border: 2px solid white; box-shadow: 0 2px 4px rgba(0,0,0,0.3); z-index: 10;"></span>
                                                            </button>
                                                        </div>
                                                    </div>

<%--                                                    Pagination of Resource Table--%>
                                                            </div>
                
                                                           


                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Show History Details Panel end here -->
            </div>
        </div>
        <!-- Edit Training Plan Section ends -->
    </div>


      <%--Commented & Added By Vyankat B. For Filter Delete Issue on on 24thJuly 2021--%>     
                     <div id="deleteConfirm" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
                        <div class="modal-dialog ui-draggable">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header ui-draggable-handle">
                                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteConf")%></h4>
                                </div>
                                <div class="modal-body">
                                   
                                    <p id="deleteConfirmTPlan"><center><%=MyBase.GetResourceString("C_DelTrainingPlan")%></center></p>

                                </div>
                                <div class="modal-footer">
                                    <button class="btn borderbtn float-start uncheckbtn me-auto" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_No")%></button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="deleteTheSelectedTrainingSkill()"><%=MyBase.GetResourceString("C_Yes")%></button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>
    
       <%--End of Commented & Added By Vyankat B. For Filter Delete Issue on on 24thJuly 2021--%>  

    <!-- Add Resources Modal start here-->
    <div class="modal custmodal fade" id="AddResourcesModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header" style="position: relative; justify-content: center;">
                    <h5 class="modal-title text-center w-100" id=""><%=MyBase.GetResourceString("C_Resources")%></h5>
                    <button type="button" class="btn btn-sm btn-danger-modern" id='AddResourcesModalClose' data-bs-toggle="tooltip" data-bs-dismiss="modal" aria-label="<%= MyBase.GetResourceString("C_Close") %>" data-bs-original-title="<%= MyBase.GetResourceString("C_Close") %>" style="padding: 2px 6px; line-height: 1; position: absolute; right: 12px; top: 50%; transform: translateY(-50%);">
                        <i class="fas fa-times" style="font-size: 12px;"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-2">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red"><%=MyBase.GetResourceString("C_Star")%></font>
                               <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                        </div>
                    </div>
                    <div class="fscroll mb-3">
                        <div class="row">
                            <div class="col-sm-12 form-group">
                                <div class="row mb-3">
                                    <label class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_NewResource")%></label>
                                    <div class="col-sm-6">
                                        <!-- <input type="text" class="form-control" /> -->
                                        <select class="selectpicker" data-live-search="true"
                                            id="projDeliverables">
                                            
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_WorkHM")%></label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="AnalysisAssRes" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="AssResStartDate" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_StartDate")%></label>
                                    <div class="col-sm-5">
                                        <div class="input-group">
                                            <input id="AssResStartDate" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i
                                                        class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="AssResEndDate" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_EndDate")%></label>
                                    <div class="col-sm-5">
                                        <div class="input-group">
                                            <input id="AssResEndDate" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i
                                                        class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="btnrow text-center">

                            <% If m_blnAddAccess Then %>
                        <button id="ResSaveBtn" class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="addNewResource(1)"><%=MyBase.GetResourceString("C_Save")%></button>
                           <%End If %>
                          <% If m_blnAddAccess Then %>
                        <button id="ResSaveAddBtn" class="btn btnyellow" data-bs-toggle="tooltip" title="Save and Add" onclick="addNewResource(2)"><%=MyBase.GetResourceString("C_SaveAdd")%></button>
                          <%End If %>
                        <button data-bs-dismiss="modal" id="ResCancelBtn" class="btn borderbtn" data-bs-toggle="tooltip" title="Cancel"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Add Resources Modal End here-->

     <!--Resources Name Click  Modal start here-->
 <div class="modal custmodal fade" id="AddResourcesModal2" tabindex="-1" role="dialog" aria-hidden="true">
     <div class="modal-dialog modal-md" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title text-center" id=""><%=MyBase.GetResourceString("C_Resources")%></h5>
                 <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" id="closeNameClickModal">
                     <span aria-hidden="true">&times;</span>
                 </button>
             </div>
             <div class="modal-body">
                 <div class="row mb-2">
                     <div class="col-sm-12 text-end">
                         <label class="form-label ">(<font color="red"><%=MyBase.GetResourceString("C_Star")%></font>
                             <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                     </div>
                 </div>
                 <div class="fscroll mb-3">
                     <div class="row">
                         <div class="col-sm-12 form-group">
                             <div class="row mb-3">
                                 <label class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_NewResource")%></label>
                                 <div class="col-sm-6">
                                     <!-- <input type="text" class="form-control" /> -->
                                     <select class="selectpicker" data-live-search="true"
                                         id="projDeliverables2">
                                     </select>
                                 </div>
                             </div>
                             <div class="row mb-3">
                                 <label class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_WorkHM")%></label>
                                 <div class="col-sm-3">
                                     <input type="text" class="form-control" id="AnalysisAssRes2" />
                                 </div>
                             </div>
                             <div class="row mb-3">
                                 <label for="AssResStartDate" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_StartDate")%></label>
                                 <div class="col-sm-5">
                                     <div class="input-group">
                                         <input id="AssResStartDate2" class="form-control">
                                         <span class="input-group-btn">
                                             <button class="btn btncalendar" type="button"><i
                                                     class="fas fa-calendar-alt"></i></button>
                                         </span>
                                     </div>
                                 </div>
                             </div>
                             <div class="row mb-3">
                                 <label for="AssResEndDate" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_EndDate")%></label>
                                 <div class="col-sm-5">
                                     <div class="input-group">
                                         <input id="AssResEndDate2" class="form-control">
                                         <span class="input-group-btn">
                                             <button class="btn btncalendar" type="button"><i
                                                     class="fas fa-calendar-alt"></i></button>
                                         </span>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>

                 <div class="btnrow text-center">

                      <!--  Added By Vyankat B on 18/04/2025 for the Edit Role Access -->
                       <% If m_blnEditAccess = True Then %>
                     <button id="ResSaveBtn2" class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="saveResourceDetails(1)"><%=MyBase.GetResourceString("C_Save")%></button>
                        <%End If %>
                        <!--End of Added By Vyankat B on 18/04/2025 for the Edit Role Access -->

                        <%--Added By Vyankat B On 19th Nov 2025 For the Edit and Add View Access--%>
                       <% If m_blnAddAccess = True And m_blnEditAccess = True Then %>
                     <button id="ResSaveAddBtn2" class="btn btnyellow" data-bs-toggle="tooltip" title="Save and Add" onclick="saveAndAddResource(1)"><%=MyBase.GetResourceString("C_SaveAdd")%></button>
                         <%End If %>
<%--                    End of Added By Vyankat B on 18/04/2025 --%>

                     <button data-bs-dismiss="modal" id="ResCancelBtn2" class="btn borderbtn" data-bs-toggle="tooltip" title="Cancel"><%=MyBase.GetResourceString("C_Cancel")%></button>
                 </div>
                 <div class="clearfix"></div>
             </div>
         </div>
     </div>
 </div>
  <!--Resources Name Click  Modal Ends here-->

    <!-- Edit Resources Modal start here-->
    <div class="modal custmodal fade" id="EdtResourcesModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header d-block">
                    <h5 class="modal-title text-center" id=""><%=MyBase.GetResourceString("C_Resources")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" id="closeEditResourceModal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-2">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red"><%=MyBase.GetResourceString("C_Star")%></font>
                               <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                        </div>
                    </div>
                    <div class="fscroll mb-3">
                        <div class="row">
                            <div class="col-sm-12 form-group">
                                <div class="row mb-3">
                                    <label for="EdtResourcesInput" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_NewResource")%></label>
                                    <div class="col-sm-6">
                                        <!-- <input type="text" class="form-control" /> -->
                                        <select class="selectpicker" data-live-search="true"
                                            id="EdtResourcesInput">
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="EdtWorkInput" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_WorkHM")%></label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="EdtWorkInput" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="EdtStartDateInput" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_StartDate")%></label>
                                    <div class="col-sm-5">
                                        <div class="input-group">
                                            <input id="EdtStartDateInput" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i
                                                        class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="EdtEndDateInput" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_EndDate")%></label>
                                    <div class="col-sm-5">
                                        <div class="input-group">
                                            <input id="EdtEndDateInput" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btncalendar" type="button"><i
                                                        class="fas fa-calendar-alt"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="btnrow text-center">
                        <%--Added By Vyankat B On 19th Nov 2025 For the Edit Role Access--%>
                        <% If m_blnEditAccess = True Then %>
                        <button id="EdtResSaveBtn" class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="saveResourceDetails(2)"><%=MyBase.GetResourceString("C_Save")%></button>
                        <%End If %>
                        <%--End of Added By Vyankat B On 19th Nov 2025 For the Edit Role Access--%>
                        
                        <%--Added By Vyankat B On 19th Nov 2025 For the Edit and Add View Access--%>
                        <% If m_blnEditAccess = True And m_blnAddAccess = True Then %>
                        <button id="EdtResSaveAddBtn" class="btn btnyellow" data-bs-toggle="tooltip" title="Save and Add"  onclick="saveAndAddResource(2)"><%=MyBase.GetResourceString("C_SaveAdd")%></button>
                        <%End If %>
                        <%--End of Added By Vyankat B On 19th Nov 2025 For the Edit and Add View Access--%>
                        
                          <% If m_blnDeleteAccess = True Then %>
                        <button class="btn borderbtn" id="EdtDeleteResBtn" data-bs-toggle="tooltip" data-bs-original-title="Delete" onclick="deleteSelectedTrainingPlanResources()"><%=MyBase.GetResourceString("C_Delete")%></button>
                          <%End If %>
                        
                        <button data-bs-dismiss="modal" id="EdtResCancelBtn" class="btn borderbtn" data-bs-toggle="tooltip" title="Cancel"><%=MyBase.GetResourceString("C_Cancel")%></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit Resources Modal End here-->

            <!--Durgesh : Edit Filter  Modal start here-->
        <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
     id="offcanvas_FiltersAdd" aria-labelledby="offcanvas_Filters">
    <div class="offcanvas-body">
        <div id="Filters_DetailsAdd" class="NOI_Details">
            <div class="NOI_Details_Header d-flex justify-content-between">
                <div class="Overlay-title"></div>
                <div class="NOI_HeaderBtns">
                </div>
            </div>
            <div class="graybg container-fluid pt-1 pb-1 mb-2 statckmainheader">
                <div class="row">
                    <div class="col-sm-12">
                        <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_EditFilter")%></h5>
                    </div>

                </div>
            </div>

            <div class="row mt-2 mb-2 project_timeperiod">
                <div class="col-sm-12 ">
                    <div class="row">
                        <div class="col-sm-8">
                        </div>
                        <div class="col-sm-4 text-end">
                           <a href="javascript:;" class="btn btnyellow " id="Sv_Filters_infoAdd" data-bs-toggle="tooltip" data-bs-container="body"
                               data-bs-placement="top" title="Save" onclick="UpdateFilter()"><%=MyBase.GetResourceString("C_Save")%></a>

                            <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                    onclick="closeNOIDetails()" data-bs-dismiss="offcanvas">
                               <%=MyBase.GetResourceString("C_Close")%>
                            </button>

                        </div>
                    </div>
                </div>
            </div>

            <div id="tools_skills_filter2" class="tab-pane stackbasicfilter">
     <!--filter panel start here-->
     <div class="filterpanelwrapbasicfilter">
         <div class="filterpanelbody" id="accordion2">
             <div class="row hidden-xs IB_filterlist">
                 <!--basic filter conduct review start here-->
                 <div class="row">
                  <div class="col-12 col-sm-6 mb-3">
                      <div class="row">
                          <div class="col-sm-4 d-flex justify-content-end">
                              <label for="SkillsFilter" class="text-end"><%=MyBase.GetResourceString("C_Skills")%></label>
                          </div>
                          <div class="col-sm-8">
                              <%=CommonFunctions.HTMLControls.DrawComboBox("SkillsFilterEdit", "usp_Whizible2_Sel_AllSkills ",,, "class='selectpicker'",,,) %>
                          </div>
                      </div>
                  </div>
              </div>

                  <div class="row">
                  <div class="col-12 col-sm-6 mb-3">
                      <div class="row">
                          <div class="col-sm-4 d-flex justify-content-end">
                              <label for="TraningPeriodFilter" class="text-end"><%=MyBase.GetResourceString("C_Training_Period")%></label>
                          </div>
                          <div class="col-sm-4">
                              <input type="text" class="form-control" id="TraningPeriodFilterEdit" />
                          </div>
                      </div>
                  </div>
                  <div class="col-12 col-sm-6 mb-3">
                      <div class="row">
                          <div class="col-sm-4 d-flex justify-content-end">
                              <label for="UnitFilter" class="text-end"><%=MyBase.GetResourceString("C_Unit")%></label>
                          </div>
                          <div class="col-sm-6">
                               <%=CommonFunctions.HTMLControls.DrawComboBox("UnitFilterEdit", "usp_Whizible2_Sel_DayFormat ",,, "class='selectpicker'",,,) %>
                          </div>
                      </div>
                  </div>
              </div>

                 <div class="row">
                  <div class="col-12 col-sm-6 mb-3">
                      <div class="row">
                          <div class="col-sm-4 d-flex justify-content-end">
                              <label for="TraningAreaFilter" class="text-end"><%=MyBase.GetResourceString("C_TrainingArea")%></label>
                          </div>
                          <div class="col-sm-8">
                              <textarea class="form-control" id="TraningAreaFilterEdit" maxlength="250"></textarea>
                          </div>
                      </div>
                  </div>
            
                  
                  <div class="col-12 col-sm-6 mb-3">
                      <div class="row">
                          <div class="col-sm-4 d-flex justify-content-end">
                              <label for="WaiverCriteriaFilter" class="text-end"><%=MyBase.GetResourceString("C_WaiverCriteria")%></label>
                          </div>
                          <div class="col-sm-8">
                              <textarea class="form-control" id="WaiverCriteriaFilterEdit" maxlength="250"></textarea>
                          </div>
                      </div>
                  </div>
              </div>
        
             </div>
             <div class="clearfix"></div>
         </div>
        
     </div>
 </div>

        </div>
    </div>
</div>
        <!--Edit Filter offcanvas Section End Here-->

    <div class="clearfix"></div>

     <%Else %>
     <div id="ViewAccess" class="tab-pane" style="height: 448px">
     <div style="text-align: center">
      <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_AuthAlert")%></p>
     </div>
     </div>
    <%End If %>

    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script> -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>

    <script>
        var hasDeleteAccess = <%= m_blnDeleteAccess.ToString().ToLower() %>;
    </script>

    <script>

       // Added By Vyankat B on 19/04/2025 for globally declared the variable and flag

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';

        var LoginType = '<%= Session("LoginType") %>';
        var UserId = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var defaultProjectID = <%= Session("intProjectID")%>;

        var specialCharactersList = '<%= System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString %>';
        var selectedTrainingPlanID = null;
        var resourceNameClickTrainingResourceId = null;
        var resourceNameClickEmployeeID = null;
        var selectedTraiingPlanResources = null;

        var saveAndAddClickForNameClick = 0;

        var selectedTrainingPlanTrainingID = null;

        var selectedTrainingResourceID = null;

        var saveAndAddTrainingPlanClickCount = null;

        var defaultFilterID = null;
        var defaultFilterSelected = 0;
        var isBasicFilterApplied = 0;
        var isFilterAppliedByClick = 0;
        var FilterAppliedByClickId = null;

        var isAppliedFilterBeingEdited = null;
        var selectedFilterForEditID = null;

        var textAreaValueForConvertToTask = null;
        var TaskID;
        var gStartDate;
        var gEndDate;
        var gEmpName;
        var gEmpID;
        let IsApliedFilter;
        var saveFlag;
        var currentFID;
        var invalidChars = specialCharactersList

        // Helper function to check for invalid characters using string contains method
        function hasInvalidChars(text) {
            if (!text || !invalidChars) return false;
            for (var i = 0; i < text.length; i++) {
                if (invalidChars.includes(text.charAt(i))) {
                    return true;
                }
            }
            return false;
        }

        //End of Added By Vyankat B on 19/04/2025 for globally declared the variable and flag



        // Added by Vyankat B on 19/04/2025 – for DOM ready function
        $(document).ready(function () {
            
            // Initially hide the "Show History" button until a training plan is selected
            document.getElementById('BkPlansShowHisBtn').style.display = 'none';
           
            // Initialize ProjectFilter selectpicker
            $('#ProjectFilter').selectpicker({
                title: 'Select Project',
                noneSelectedText: 'Select Project'
            });
            
            // Load projects for training plan dropdown
            loadProjectsForTrainingPlan();
           
            // Set default project ID in ProjectFilter dropdown
            if (defaultProjectID && defaultProjectID > 0) {
                // Wait for selectpicker to initialize, then set the value
                setTimeout(function() {
                    $('#ProjectFilter').val(defaultProjectID);
                    $('#ProjectFilter').selectpicker('refresh');
                    $('#ProjectFilter').trigger('change');
                }, 500);
            }

            // Add event listener for project dropdown change
            $('#ProjectFilter').on('change', function() {
                var selectedProjectID = $(this).val();
                
                // Call appendTrainingSkills with the selected project ID
                if (selectedProjectID && selectedProjectID !== '') {
                    appendTrainingSkills(selectedProjectID, 1);
                } else {
                    // If no project selected, use default project ID
                    appendTrainingSkills(defaultProjectID, 1);
                }
            });

            // Initialize resource dropdowns with proper placeholder text
            initializeResourceDropdowns();
           
            document.querySelector('#UnitAdd').selectedIndex = -1; 
            $(document.querySelector('#UnitAdd')).selectpicker({
                title: 'Select Unit',
                noneSelectedText: 'Select Unit'
            });
            $(document.querySelector('#UnitAdd')).selectpicker('refresh');

            document.querySelector('[data-id="SkillsEdit"]').querySelector('.filter-option-inner-inner').innerHTML = "";
            
            // Set placeholder for SkillsEdit dropdown
            var skillsEditDropdown = document.querySelector('#SkillsEdit');
            if (skillsEditDropdown) {
                $(skillsEditDropdown).selectpicker({
                    title: 'Select Skills',
                    noneSelectedText: 'Select Skills'
                });
                $(skillsEditDropdown).selectpicker('refresh');
            }
            
            // Control scrollbar visibility for dropdowns
            $('.selectpicker').on('show.bs.select', function() {
                $(this).next('.dropdown-menu').css('overflow-y', 'auto');
            });
            
            $('.selectpicker').on('hide.bs.select', function() {
                $(this).next('.dropdown-menu').css('overflow-y', 'hidden');
            });
            document.querySelector('#UnitEdit').selectedIndex = -1; 
            $(document.querySelector('#UnitEdit')).selectpicker({
                title: 'Select Unit',
                noneSelectedText: 'Select Unit'
            });
            $(document.querySelector('#UnitEdit')).selectpicker('refresh');

            var dropdown = document.querySelector('#SkillsAdd'); // Target the dropdown by its ID
            dropdown.selectedIndex = -1;
            $(dropdown).selectpicker({
                title: 'Select Skills',
                noneSelectedText: 'Select Skills'
            });
            $(dropdown).selectpicker('refresh');

            //For Filter
            document.getElementById('SkillsFilter').value = "";
            $(document.getElementById('SkillsFilter')).selectpicker({
                title: 'Select Skills',
                noneSelectedText: 'Select Skills'
            });
            $(document.getElementById('SkillsFilter')).selectpicker('refresh');

            document.getElementById('UnitFilter').value = "";
            $(document.getElementById('UnitFilter')).selectpicker({
                title: 'Select Unit',
                noneSelectedText: 'Select Unit'
            });
            $(document.getElementById('UnitFilter')).selectpicker('refresh');

            var selectedProjectID = document.getElementById('ProjectFilter').value;


            appendTrainingSkills(defaultProjectID, 1);

            appendEmployeeDropdown();
            
            
            // Hide Clear All button initially - only show after applying filters
            toggleClearAllSpan(0);      
            // Ensure Clear All button is hidden on page load
            document.getElementById('ClearAllFilter').style.setProperty('display', 'none', 'important');
        });

     //End of Added by Vyankat B on 19/04/2025 – for DOM ready function

        // Added By Vyankat B. - AJAX call function for Whizible26 service integration on 30th Sep 2025
        function AJAXCallWithResult(url, param, async) {
            var result = null;
            var fullUrl = strUrl.endsWith('/') ? strUrl + url : strUrl + '/' + url;

            $.ajax({
                url: fullUrl,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset=utf-8",

                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    // Always add Params header for POST requests
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    // Return the complete response object to preserve pagination info
                    result = data;
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_AuthenticationFailed")%>', 'error', 5);
                   } else {
                       window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                   }
               }
        });
            
            // For synchronous calls, return the result directly
            if (!async) {
                return result;
            }
            
            // For asynchronous calls, return AjaxResult (legacy behavior)
            return AjaxResult;
        }

        // Added By Vyankat B - Function to load projects for training plan dropdown
        function loadProjectsForTrainingPlan() {
            try {
                
                // Call the GetProjectsForTrainingPlan API
               
                var param = {
                    userId: UserId,
                    loginType: LoginType
                };

                param = JSON.stringify(param);

                var url = "api/TrainingPlan/GetProjectsForTrainingPlan";
                var result = AJAXCallWithResult(url, param, false);
                
                // Clear existing options
                var projectDropdown = document.getElementById('ProjectFilter');
                if (projectDropdown) {
                    projectDropdown.innerHTML = '';
                    
                    // Check if we have valid data based on your API response format
                    if (result && result.projects && result.projects.ProjectEntity && Array.isArray(result.projects.ProjectEntity)) {
                        // Bind the data to dropdown using your specific response format
                        result.projects.ProjectEntity.forEach(function(project) {
                            var option = document.createElement('option');
                            option.value = project.projectID;
                            option.textContent = project.projectName;
                            projectDropdown.appendChild(option);
                        });
                        
                    } else if (result && result.result && Array.isArray(result.result)) {
                        // Fallback for other response formats
                        result.result.forEach(function(project) {
                            var option = document.createElement('option');
                            option.value = project.ProjectID || project.ID || project.id;
                            option.textContent = project.ProjectName || project.Name || project.ProjectTitle || project.Title;
                            projectDropdown.appendChild(option);
                        });
                        
                    } else if (result && Array.isArray(result)) {
                        // Handle direct array response
                        result.forEach(function(project) {
                            var option = document.createElement('option');
                            option.value = project.ProjectID || project.ID || project.id;
                            option.textContent = project.ProjectName || project.Name || project.ProjectTitle || project.Title;
                            projectDropdown.appendChild(option);
                        });
                        
                    }
                    
                    // Refresh the selectpicker
                    $(projectDropdown).selectpicker('refresh');
                }
                
            } catch (error) {
                // Error loading projects
            }
        }


        //Start of Added By Vyankat B on 3rd Oct 2025 Function to perform search with database-level filtering
        function performSearch() {
            var searchText = document.getElementById('searchInput').value;
            var projectID = document.getElementById('ProjectFilter').value || '<%=Session("intProjectID")%>';
            var skillsFilter = document.getElementById('SkillsFilter').value || 0;
            var trainingPeriod = document.getElementById('TraningPeriodFilter').value || 0;
            var unitFilter = document.getElementById('UnitFilter').value || 0;
            var trainingArea = document.getElementById('TraningAreaFilter').value || '';
            var waiverCriteria = document.getElementById('WaiverCriteriaFilter').value || '';

            var searchParams = {
                ProjectID: parseInt(projectID),
                SearchText: searchText,
                SkillsFilter: parseInt(skillsFilter),
                TrainingPeriod: parseInt(trainingPeriod),
                UnitFilter: parseInt(unitFilter),
                TrainingArea: trainingArea,
                WaiverCriteria: waiverCriteria
            };

            // Convert to JSON object for POST request
            var param = {
                ProjectID: searchParams.ProjectID,
                SearchText: searchParams.SearchText
            };

            param = JSON.stringify(param);

            var url = "api/TrainingPlan/GetTrainingNeedsWithSearch";
            var result = AJAXCallWithResult(url, param, false);
            
            // Use the existing appendTrainingSkills function with search results
            var tableBody = document.getElementById('TrainingPlanTbl').getElementsByTagName('tbody')[0];

            tableBody.innerHTML = '';

            if ($.fn.DataTable.isDataTable('#TrainingPlanTbl')) {
                $('#TrainingPlanTbl').DataTable().clear().destroy();
            }

            result.forEach(function (training) {
                var rowHTML = '<tr>' +
                                '<td>' + training.description + '</td>' +
                                '<td>' + training.trainingPeriod + '</td>' +
                                '<td>' + (training.completed ? "Yes" : "No") + '</td>' +
                                '<td>' +
                                    '<a href="javascript:;" data-bs-toggle="offcanvas" ' +
                                        'data-bs-target="#offcanvas_EdtTrainPlans" aria-controls="offcanvasWithBothOptions" onclick="handleTrainingPlanClick(' + training.trainingID + ',true)">' +
                                  <% If m_blnEditAccess = True Then %>
                                        '<i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" title="More Details"></i>' +
                                   <%End If %>
                                    '</a>' +
                                '</td>' +
                            '</tr>';

                tableBody.innerHTML += rowHTML;
            });

            $('#TrainingPlanTbl').dataTable({
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "info": false,
                "paging": true,
                "bPaginate": true
            });

            // Update total records count - use pagination data if available
            var totalRecordsCount = totalRecords || result.length;
            document.getElementById('totalRecords').innerHTML = 'Total Records: ' + totalRecordsCount;

            // Don't show Clear All button for search - only show after applying filters

        }
        //End of Added By Vyankat B on 3rd Oct 2025 Function to perform search with database-level filtering

        //Start of Added By Vyankat B on 3rd Oct 2025 - Add Enter key support for search input
        $(document).ready(function() {
            $('#searchInput').on('keypress', function(e) {
                if (e.which === 13) { // Enter key
                    performSearch();
                }
            });
        });
        //End of Added By Vyankat B on 3rd Oct 2025 - Add Enter key support for search input

        //Start of Added By Vyankat B on 3rd Oct 2025 - Handle real-time search input with debounce
        var searchTimeout;
        function handleSearchInput() {
            // Clear the previous timeout
            clearTimeout(searchTimeout);
            
            // Set a new timeout to perform search after 500ms of no typing
            searchTimeout = setTimeout(function() {
                appendTrainingSkills(undefined, 1);
            }, 500); // 500ms delay
        }
        //End of Added By Vyankat B on 3rd Oct 2025 - Handle real-time search input with debounce

        //Added By Vyankat B on 3rd Oct 2025 - Loader functions
        function showLoader() {
            document.getElementById('loaderOverlay').style.display = 'block';
            loaderShown = true;
            loaderStartTime = Date.now();
        }

        function hideLoader() {
            if (!loaderShown) return;
            
            var elapsedTime = Date.now() - loaderStartTime;
            var minDisplayTime = 1500; // Minimum 1.5 seconds
            
            if (elapsedTime < minDisplayTime) {
                setTimeout(function() {
                    document.getElementById('loaderOverlay').style.display = 'none';
                    loaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                document.getElementById('loaderOverlay').style.display = 'none';
                loaderShown = false;
            }
        }

        // Show loader immediately when script starts (before any data loading)
        //showLoader();

        // Pagination variables - Global scope
        let currentPage = 1;
        let pageSize = 10;
        let totalRecords = 0;
        let totalPages = 0;

        //Added By Vyankat B on 19/04/2025 fUNCTION TO APPEND THE DATA TO THE MAIN GRID
        function appendTrainingSkills(projectID, pageNumber = 1) {
            
           


            // Use provided projectID or fallback to defaultProjectID
            var selectedProjectID = document.getElementById('ProjectFilter').value;
            
            if (defaultFilterSelected == 1) {
                applySelectedFilter(defaultFilterID, 1);
                //hideLoader();
                return;
            }

            if (isFilterAppliedByClick == 1) {
                applySelectedFilter(FilterAppliedByClickId, 1);
                //hideLoader();
                return;
            }

            if (isBasicFilterApplied == 1) {
                basicFilterApply();
                //hideLoader();
                return;
            }

            var searchText = document.getElementById('searchInput').value;

            // Build JSON object for POST request
            var searchTextValue = searchText && searchText.trim() !== '' ? searchText : '';
            var param = {
                ProjectID: projectID,
                SearchText: searchTextValue,
                PageNumber: pageNumber,
                PageSize: pageSize
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/GetTrainingNeedsForProject";
            var result = AJAXCallWithResult(url, param, false);
            var tableBody = document.getElementById('TrainingPlanTbl').getElementsByTagName('tbody')[0];

            tableBody.innerHTML = '';

            if ($.fn.DataTable.isDataTable('#TrainingPlanTbl')) {
                $('#TrainingPlanTbl').DataTable().clear().destroy();
                updatePaginationDisplay();
            }

            // Update pagination variables
            currentPage = pageNumber;
            
            // Check if result is an array (direct response) or object with data property
            var trainingData = [];
            var paginationData = null;
            
            
            if (result && result.data && Array.isArray(result.data)) {
                // Object response with data property
                trainingData = result.data;
                
                // Extract pagination data if available
                if (result.paginationEntities && result.paginationEntities.length > 0) {
                    paginationData = result.paginationEntities[0];
                    currentPage = paginationData.currentPage;
                    pageSize = paginationData.pageSize;
                    totalRecords = paginationData.totalRecords;
                    totalPages = paginationData.totalPages;
                } else {
                    // If no pagination data, don't override the totalRecords
                    // Keep the existing value or set to 0 if not available
                    if (!totalRecords) {
                        totalRecords = 0;
                    }
                    totalPages = Math.ceil(totalRecords / pageSize);
                }
            } else if (Array.isArray(result)) {
                // Direct array response (fallback)
                trainingData = result;
                
                // For direct array, only set totalRecords if it's not already set
                if (!totalRecords || totalRecords === 0) {
                    totalRecords = trainingData.length;
                }
                totalPages = Math.ceil(totalRecords / pageSize);
            }
            
            
            if (trainingData && trainingData.length > 0) {
                
                trainingData.forEach(function (training) {
                var rowHTML = `
                                <tr>
                                    <td>${training.description}</td>
                                    <td>${training.trainingPeriod}</td>
                                    <td>${training.completed ? "Yes" : "No"}</td>
                                    <td>
                                        <a href="javascript:;" data-bs-toggle="offcanvas" 
                                            data-bs-target="#offcanvas_EdtTrainPlans" aria-controls="offcanvasWithBothOptions" onclick="handleTrainingPlanClick(${training.trainingID},true)">
<%--                                     <% If m_blnEditAccess = True Then %>--%>
                                            <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" title="More Details"></i>
<%--                                     <%End If %>--%>
                                        </a>
                                    </td>
                                </tr>
                            `;

                tableBody.innerHTML += rowHTML;
            });

                // Update pagination display
                updatePaginationDisplay();

            try {
            $('#TrainingPlanTbl').dataTable({
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "info": false,
                "paging": true,
                "bPaginate": true,
                    "autoWidth": false,
                "columnDefs": [
                    { "width": "25%", "targets": 0 },
                    { "width": "25%", "targets": 1 },
                    { "width": "25%", "targets": 2 },
                    { "width": "25%", "targets": 3 }
                ]
            });
            } catch (e) {
                console.error('Error initializing TrainingPlanTbl DataTable with data:', e);
            }

                
                // Update pagination display
                updatePaginationDisplay();

                // Update total records count (already set above)
                // totalRecords and totalPages are already calculated from the first item
                
                // Hide any existing DataTable info elements
                $('.dataTables_info').hide();
                $('.dataTables_paginate').hide();
                
                
                // Update pagination display
                updatePaginationDisplay();
                

            // Hide loader when data loading is complete
                //hideLoader();
            } else {
                // Clear table body - let DataTable handle empty state
                tableBody.innerHTML = '';
                
                // Wait a moment for DOM to update, then initialize DataTable
                setTimeout(function() {
                    try {
                        $('#TrainingPlanTbl').dataTable({
                            "pageLength": 10,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "destroy": true,
                            "retrieve": false,
                            "info": false,
                            "paging": true,
                            "bPaginate": true,
                            "autoWidth": false,
                            "columnDefs": [
                                { "width": "25%", "targets": 0 },
                                { "width": "25%", "targets": 1 },
                                { "width": "25%", "targets": 2 },
                                { "width": "25%", "targets": 3 }
                            ],
                            "language": {
                                "emptyTable": "<%= MyBase.GetResourceString("C_NoDataAvaible")%>"
                            }
                        });
                    } catch (e) {
                        console.error('Error initializing TrainingPlanTbl DataTable:', e);
                    }
                }, 100);
                
                // Set totalRecords to 0 for empty state
                totalRecords = 0;
                // Even if no data, show pagination
                updatePaginationDisplay(true);
                
                // Update pagination buttons for empty state
                setTimeout(function() {
                    updatePaginationButtons();
                }, 200);
            }
        }
        //End of Added By Vyankat B on 19/04/2025 fUNCTION TO APPEND THE DATA TO THE MAIN GRID


        // Pagination functions
        function updatePaginationDisplay(flag) {

            var paginationContainer = document.querySelector('.pagination-container');
            if (paginationContainer) {
                paginationContainer.style.display = 'flex';
                paginationContainer.style.visibility = 'visible';
                paginationContainer.style.opacity = '1';
            }
            
            // Update total records display - ensure we have a valid count
            var totalRecordsSpan = document.getElementById('totalRecords');
            if (totalRecordsSpan) {
                var displayCount = totalRecords || 0;
                totalRecordsSpan.textContent = `Total Records: ${displayCount}`;
            }
            if (flag && totalRecordsSpan) {
                var displayCount = 0;
                totalRecordsSpan.textContent = `Total Records: ${displayCount}`;
            }
            // Update button states
            var firstPageBtn = document.getElementById('firstPageBtn');
            var lastPageBtn = document.getElementById('lastPageBtn');
            
            if (firstPageBtn) {
                var prevRedCircle = firstPageBtn.querySelector('.prev-red-circle');
                if (currentPage <= 1) {
                    firstPageBtn.disabled = true;
                    firstPageBtn.style.opacity = '0.5';
                    firstPageBtn.style.cursor = 'not-allowed';
                    firstPageBtn.style.background = '#f8f9fa';
                    firstPageBtn.style.color = '#6c757d';
                    // Show red circle for disabled previous button
                    if (prevRedCircle) {
                        prevRedCircle.style.opacity = '1';
                    }
                } else {
                    firstPageBtn.disabled = false;
                    firstPageBtn.style.opacity = '1';
                    firstPageBtn.style.cursor = 'pointer';
                    firstPageBtn.style.background = 'white';
                    firstPageBtn.style.color = '#3b82f6';
                    // Hide red circle for enabled previous button
                    if (prevRedCircle) {
                        prevRedCircle.style.opacity = '0';
                    }
                }
            }
            
            if (lastPageBtn) {
                var nextRedCircle = lastPageBtn.querySelector('.next-red-circle');
                if (currentPage >= totalPages) {
                    lastPageBtn.disabled = true;
                    lastPageBtn.style.opacity = '0.5';
                    lastPageBtn.style.cursor = 'not-allowed';
                    lastPageBtn.style.background = '#f8f9fa';
                    lastPageBtn.style.color = '#6c757d';
                    // Show red circle for disabled next button
                    if (nextRedCircle) {
                        nextRedCircle.style.opacity = '1';
                    }
                } else {
                    lastPageBtn.disabled = false;
                    lastPageBtn.style.opacity = '1';
                    lastPageBtn.style.cursor = 'pointer';
                    lastPageBtn.style.background = 'white';
                    lastPageBtn.style.color = '#3b82f6';
                    // Hide red circle for enabled next button
                    if (nextRedCircle) {
                        nextRedCircle.style.opacity = '0';
                    }
                }
            }
        }

        function updatePageNumbers() {
            var pageNumbersContainer = document.getElementById('pageNumbers');
            if (!pageNumbersContainer) return;
            
            var startPage = Math.max(1, currentPage - 2);
            var endPage = Math.min(totalPages, currentPage + 2);
            
            var pageNumbersHTML = '';
            for (var i = startPage; i <= endPage; i++) {
                var activeClass = i === currentPage ? 'btn-primary' : 'btn-outline-primary';
                pageNumbersHTML += `<button class="btn btn-sm ${activeClass} me-1" onclick="goToPage(${i})">${i}</button>`;
            }
            
            pageNumbersContainer.innerHTML = pageNumbersHTML;
        }

        function goToPreviousPage() {
            if (currentPage > 1) {
                var selectedProjectID = document.getElementById('ProjectFilter').value || defaultProjectID;
                var prevPage = currentPage - 1;
                
                // Update current page before making the call
                currentPage = prevPage;
                
                appendTrainingSkills(selectedProjectID, prevPage);
            }
        }

        function goToNextPage() {
            if (currentPage < totalPages) {
                var selectedProjectID = document.getElementById('ProjectFilter').value || defaultProjectID;
                var nextPage = currentPage + 1;
                
                // Update current page before making the call
                currentPage = nextPage;
                
                appendTrainingSkills(selectedProjectID, nextPage);
            }
        }

        function goToPage(pageNumber) {
            if (pageNumber >= 1 && pageNumber <= totalPages && pageNumber !== currentPage) {
                var selectedProjectID = document.getElementById('ProjectFilter').value || defaultProjectID;
                appendTrainingSkills(selectedProjectID, pageNumber);
            }
        }

        // Force update pagination display with correct values
        function forceUpdatePagination() {
            // Force update the display
            updatePaginationDisplay();
            
            // Also update any existing pagination info text
            var paginationInfo = document.getElementById('paginationInfo');
            if (paginationInfo) {
                var startRecord = ((currentPage - 1) * pageSize) + 1;
                var endRecord = Math.min(currentPage * pageSize, totalRecords);
                paginationInfo.textContent = `Showing ${startRecord} to ${endRecord} of ${totalRecords} entries`;
            }
        }

        //Added By Vyankat B on 19/04/2025 Common validation function for training skills
        function validateTrainingSkill(skillID, trainingPeriod, unit, trainingArea, waiverCriteria, isEdit = false) {
            // Skill ID validation
            if (!skillID || skillID == '0') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_SkillsAlert")%></span>");
                return false;
            }

            // Training Period validation
            if (!trainingPeriod) {
                const errorMessage =
                    "<%= MyBase.GetResourceString("A_TrainingBlank")%>" ;
                   
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>" + errorMessage + "</span>");
                return false;
            }

            // Training Period format validation - only numeric values, 1-5 digits
            if (!/^[0-9]{1,5}$/.test(trainingPeriod)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>Training Period must contain only numeric values (1-5 digits)</span>");
                return false;
            }

            var num = parseInt(trainingPeriod);
            if (isNaN(num)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("C_PlzNumeric")%></span>");
                return false;
            }

            if (num < 1) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%=MyBase.GetResourceString("C_TrainPerAlert")%></span>");
                return false;
            }

            // Unit validation
            if (!unit || unit === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_UnitAlert")%></span>");
                return false;
            }

            // Training Area validation (invalid characters)
            if (trainingArea && trainingArea.trim() !== "" && hasInvalidChars(trainingArea.trim())) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>Training Area <%= MyBase.GetResourceString("A_InvalidChars")%></span>");
                return false;
            }

            // Waiver Criteria validation (invalid characters)
            if (waiverCriteria && waiverCriteria.trim() !== "" && hasInvalidChars(waiverCriteria.trim())) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>Waiver Criteria <%= MyBase.GetResourceString("A_InvalidChars")%></span>");
                return false;
            }

            return true;
        }

        //Added By Vyankat B on 19/04/2025 Helper function to create training skill parameters
        function createTrainingSkillParams(skillID, trainingPeriod, unit, trainingArea, waiverCriteria, isUpdate = false, trainingID = null, completed = 0, projectID = null) {
            

            var selectedProjectID = $('#ProjectFilter').val() || defaultProjectID;


            if (isUpdate) {
                return {
                    TrainingID: parseInt(trainingID) || 0,
                    ProjectID: parseInt(selectedProjectID || defaultProjectID) || 0,
                    ToolID: parseInt(skillID) || 0,
                    TrainingDuration: trainingPeriod.toString() || "0",
                    DayFormat: unit.toString() || "0",
                    TrainingArea: trainingArea || "",
                    WaiverCriteria: waiverCriteria || "",
                    Completed: completed === 1 || completed === true,
                    CreatedBy: UserName || ""
                };
            } else {
                return {
                    ProjectID: parseInt(selectedProjectID || defaultProjectID) || 0,
                    ToolID: parseInt(skillID) || 0,
                TrainingDuration: parseInt(trainingPeriod) || 0,
                DayFormat: parseInt(unit) || 0,
                TrainingArea: trainingArea || "",
                WaiverCriteria: waiverCriteria || "",
                CreatedBy: UserName || ""
            };
            }
        }

        //Added By Vyankat B on 19/04/2025 Helper function to call training skill API
        function callTrainingSkillAPI(params, isUpdate = false) {
            const url = isUpdate ? 
                "api/TrainingPlan/UpdateTrainingNeeds" : 
                "api/TrainingPlan/PostTrainingSkillForProject";
            
            const param = JSON.stringify(params);
            const response = AJAXCallWithResult(url, param, false);

            if (response && response.message && response.message.includes("successfully")) {
                const successMessage = isUpdate ? 
                    "<%= MyBase.GetResourceString("A_TrainingPlanUpd")%>" : 
                    "<%=MyBase.GetResourceString("A_TrainingSkillSaved")%>";
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'>" + successMessage + "</span>");
                return true;
            } else {
                const errorMessage = isUpdate ? 
                    "Failed to update training plan. Please try again." : 
                    "Failed to save training skill. Check console for details.";
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>" + errorMessage + "</span>");
                return false;
            }
        }

        //Added By Vyankat B on 19/04/2025 fUNCTION To Save Training Skill
        function saveTrainingSkill() {
           
            var toolID = document.getElementById("SkillsAdd").value;
            var trainingPeriod = document.getElementById("TraningPeriodAdd").value;
            var unitElement = document.getElementById("UnitAdd");
            var unit = unitElement && unitElement.selectedIndex >= 0 ? unitElement.options[unitElement.selectedIndex].value : "";
            var trainingArea = document.getElementById("TraningAreaAdd").value;
            var waiverCriteria = document.getElementById("WaiverCriteriaAdd").value;

            // Validate resource name (if needed)
            let name = $.trim($("#ResName").val());
            if (name === "") {
                errorMessage = "<%= MyBase.GetResourceString("A_VName")%>";
            } else if (hasInvalidChars(name)) {
                errorMessage = "A Name <%= MyBase.GetResourceString("A_InvalidChars")%>";
            }

            // Validate using the common validation function
            if (!validateTrainingSkill(toolID, trainingPeriod, unit, trainingArea, waiverCriteria, false)) {
                return;
            }

            // Create parameters and call API
            var selectedProjectID = $('#ProjectFilter').val() || defaultProjectID;
            var params = createTrainingSkillParams(toolID, trainingPeriod, unit, trainingArea, waiverCriteria, false, null, 0, selectedProjectID);
            
            if (callTrainingSkillAPI(params, false)) {
            clearTrainingPlan();
            // Get the currently selected project ID and pass it to appendTrainingSkills
            var selectedProjectID = $('#ProjectFilter').val() || defaultProjectID;
            appendTrainingSkills(selectedProjectID, 1);
            }
            $('#AddClose').trigger('click');
        }
       //End of Added By Vyankat B on 19/04/2025 fUNCTION To Save Training Skill


        // Added By Vyankat B on 19/04/2025 Function To Clear the Add Training Plan Selection
        function clearTrainingPlan() {
           
            $("#SkillsAdd").val(0).change();
            $("#SkillsAdd").selectpicker("refresh");
            document.getElementById("TraningPeriodAdd").value = "";
            document.getElementById("TraningAreaAdd").value = "";
            document.getElementById("WaiverCriteriaAdd").value = "";

            $("#UnitAdd").val(0).change();
            $("#UnitAdd").selectpicker("refresh");

            document.querySelector('[data-id="SkillsEdit"]').querySelector('.filter-option-inner-inner').innerHTML = "";
            document.querySelector('#UnitEdit').selectedIndex = -1;
 
        }
        //End of Added By Vyankat B on 19/04/2025 Function To Clear the Add Training Plan Selection

        // Added By Vyankat B on 19/04/2025 Function to handle training plan click
        function handleTrainingPlanClick(toolId,flag) {
           
            

            function checkAssignedTask() {
                var TrainIDtoolId = toolId;
            }
            saveFlag = flag
            if (flag == true) {
                currentPageRs = 1,
                currentPageHs = 1
            }
            saveAndAddTrainingPlanClickCount = 0;

            //if (hasDeleteAccess == True) {
            //    document.getElementById('deleteTrPlanBtn').disabled = false;

            //}
            document.getElementById('CancelBtn').click();

            selectedTrainingPlanID = toolId;
            
            // Check if history data exists and show/hide "Show History" button accordingly
            checkAndToggleHistoryButton(toolId);
            // Build JSON object for the POST request
            var param = {
                ToolID: toolId
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/GetDetailsOfTrainingByID";
            var response = AJAXCallWithResult(url, param, false);

            $('#ResourceDetails').show();
            $('#deleteTrPlanBtn').show();
            $('#saveAddTrPlanBtn').show();
            $('#compleCheckBox').show();



           // var response = AJAXCallWithResult("/api/PM_TrainingPlan/GetDetailsOfTrainingByID", JSON.stringify(Parameters), false);

            if (response && response.details && response.details.TrainingNeedsDetailsEntity && response.details.TrainingNeedsDetailsEntity.length > 0) {
                var data = response.details.TrainingNeedsDetailsEntity[0]; 
                selectedTrainingPlanTrainingID = data.trainingID;

                var skillsDropdown = document.querySelector('#SkillsEdit');
                skillsDropdown.value = data.toolID;
                $(skillsDropdown).selectpicker('refresh'); 

                var trainingPeriodInput = document.querySelector('#TraningPeriodEdit');
                if (trainingPeriodInput) {
                    trainingPeriodInput.value = data.trainingDuration || "";
                }

                var unitDropdown = document.querySelector('#UnitEdit');
                if (unitDropdown) {
                    for (let option of unitDropdown.options) {
                        if (option.textContent === data.trainingPeriod.split(' ')[1]) {
                            option.selected = true;
                            break;
                        }
                    }
                }
                $(unitDropdown).selectpicker('refresh'); 

                var trainingAreaTextarea = document.querySelector('#TraningAreaEdit');
                if (trainingAreaTextarea) {
                    trainingAreaTextarea.value = data.trainingArea || "";
                    textAreaValueForConvertToTask = data.trainingArea || "";
                }

                var waiverCriteriaTextarea = document.querySelector('#WaiverCriteriaEdit');
                if (waiverCriteriaTextarea) {
                    waiverCriteriaTextarea.value = data.waiverCriteria || "";
                }

                var completedCheckbox = document.querySelector('#completedEdtCheck');
                if (completedCheckbox) {
                    completedCheckbox.checked = data.completed || false;
                }
            } else {
                console.error("No valid data found in response.");
            }

            appendTrainingPlanResources(selectedTrainingPlanTrainingID);

            $("#CancelAssTaskBtn").trigger("click");
            $(".Taskdetailpanel").hide();
            $(".ShowHisDetailpanel").hide();
            
        }
        //End of Added By Vyankat B on 19/04/2025 Function to handle training plan click

        // Added function to check if history data exists and toggle "Show History" button visibility
        function checkAndToggleHistoryButton(trainingId) {

            var param = {
                TrainingID: trainingId
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/FetchTrainingPlanHistory";
            var historyData = AJAXCallWithResult(url, param, false);

           // var historyData = AJAXCallWithResult("/api/PM_TrainingPlan/FetchTrainingPlanHistory", JSON.stringify(Parameters), false);
            var showHistoryBtn = document.getElementById('BkPlansShowHisBtn');
            
            if (historyData && Array.isArray(historyData.data) && historyData.data.length > 0) {
                // History data exists, show the button
                showHistoryBtn.style.display = 'inline';
            } else {
                // No history data, hide the button
                showHistoryBtn.style.display = 'none';
            }
        }

        // Added By Vyankat B on 19/04/2025 Function to append ModifiedFields and ModifiedBy in the history table
        function appendModifiedDropdowns() {
            var Parameters2 = {
                TrainingID: selectedTrainingPlanID
            }
         
            var param = {
                TrainingID: Parameters2.TrainingID
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/FetchTrainingPlanHistory";
            var historyResponse = AJAXCallWithResult(url, param, false);

            var historyData = [];
            if (historyResponse && Array.isArray(historyResponse.data)) {
                historyData = historyResponse.data;
            } else if (Array.isArray(historyResponse)) {
                historyData = historyResponse;
            }

            var fieldNameDropdown = document.getElementById('modifiedHisField');
            fieldNameDropdown.innerHTML = '';
            fieldNameDropdown.innerHTML = '<option>Select Option</option>';
            
            // Extract unique field names from the history data
            var uniqueFields = [...new Set(historyData.map(item => item.modifiedField || item.ModifiedField))];
            uniqueFields.forEach(function (fieldName) {
                if (fieldName) { // Only add non-empty field names
                    var option = document.createElement('option');
                    option.text = fieldName;
                    fieldNameDropdown.add(option);
                }
            });

            var modifiedByDropdown = document.getElementById('modifiedHisBy');
            modifiedByDropdown.innerHTML = '';
            modifiedByDropdown.innerHTML = '<option>Select Option</option>';
            
            // Extract unique modified by users from the history data
            var uniqueModifiedBy = [...new Set(historyData.map(item => item.modifiedBy || item.ModifiedBy))];
            uniqueModifiedBy.forEach(function (user) {
                if (user) { // Only add non-empty users
                    var option = document.createElement('option');
                    option.text = user;
                    modifiedByDropdown.add(option);
                }
            });

            $(modifiedByDropdown).selectpicker('refresh');
            $(fieldNameDropdown).selectpicker('refresh');

            document.getElementById('modifiedHisField').addEventListener('change', filterAndAppendToolData);
            document.getElementById('modifiedHisBy').addEventListener('change', filterAndAppendToolData);

        }
       //End of Added By Vyankat B on 19/04/2025 Function to append ModifiedFields and ModifiedBy in the history table

       // Added By Vyankat B on 19/04/2025 Function to append the new data to the history on the basis of the changing dropdown
        function filterAndAppendToolData() {
            
            var param = {
                TrainingID: selectedTrainingPlanID
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/FetchTrainingPlanHistory";
            var historyResponse = AJAXCallWithResult(url, param, false);

            // Extract the actual data from the correct response structure
            var historyData2 = [];
            if (historyResponse && Array.isArray(historyResponse.data)) {
                historyData2 = historyResponse.data;
            } else if (Array.isArray(historyResponse)) {
                historyData2 = historyResponse;
            }

            var selectedField = document.getElementById('modifiedHisField').value;
            var selectedUser = document.getElementById('modifiedHisBy').value;

            var filteredData = historyData2.filter(function (entry) {
                var matchField = selectedField === "Select Option" || (entry.modifiedField || entry.ModifiedField) === selectedField;
                var matchUser = selectedUser === "Select Option" || (entry.modifiedBy || entry.ModifiedBy) === selectedUser;
                return matchField && matchUser;
            });

            var tableBody = document.getElementById('BkPlanShowHisTable').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = '';


            if ($.fn.DataTable.isDataTable('#BkPlanShowHisTable')) {
                $('#BkPlanShowHisTable').DataTable().clear().destroy();
            }

            filteredData.forEach(function (entry) {
                var rowHTML = `
                               <tr>
                                   <td>${entry.modifiedField || entry.ModifiedField || ''}</td>
                                   <td>${entry.oldValue || entry.OldValue || ''}</td>
                                   <td>${entry.newValue || entry.NewValue || ''}</td>
                                    <td>${entry.modifiedDate || entry.ModifiedDate ? new Date(entry.modifiedDate || entry.ModifiedDate).toLocaleString('en-US', {
                                        year: 'numeric',
                                        month: 'short',
                                        day: 'numeric'
                                    }) : ''}</td>
                                   <td>${entry.modifiedBy || entry.ModifiedBy || ''}</td>
                               </tr>
                           `;
                tableBody.innerHTML += rowHTML;
            });

            $('#BkPlanShowHisTable').dataTable({
                pageLength: 5,
                lengthChange: false,
                bFilter: false,
                ordering: false,
                responsive: true,
                destroy: true,
                retrieve: true,
                bAutoWidth: false
            });
        }
        //End of Added By Vyankat B on 19/04/2025 Function to append the new data to the history on the basis of the changing dropdown

       //Added By Vyankat B on 19/04/2025 Function to Delete the selected Training plan
        function deleteTheSelectedTrainingSkill(){
            
            // Convert to proper data types for the API
            var selectedProjectID = $('#ProjectFilter').val() || defaultProjectID;
            var deleteParameters = {
                TrainingID: parseInt(selectedTrainingPlanID) || 0,
                ProjectID: parseInt(selectedProjectID) || 0
            };


            // Build JSON object for the delete API call
            var param = {
                TrainingID: deleteParameters.TrainingID,
                ProjectID: deleteParameters.ProjectID
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/DeleteSelectedTrainingPlan";
            var deletionResponse = AJAXCallWithResult(url, param, false);


            if (deletionResponse && deletionResponse.result && deletionResponse.result.TrainingPlanDeleteEntity && deletionResponse.result.TrainingPlanDeleteEntity.length > 0) {
                var deleteMessage = deletionResponse.result.TrainingPlanDeleteEntity[0].result;
                
                if (deleteMessage && deleteMessage.includes("successfully")) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success(`<span style='font-size:14px;'>${deleteMessage}</span>`);
                    document.getElementById('offcanvasClose').click();
                    // Use the selected project ID for refreshing the training skills list
                    appendTrainingSkills(selectedProjectID, 1);
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(`<span style='font-size:14px;'>${deleteMessage}</span>`);
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>Unexpected error occurred while deleting the training plan.</span>");
            }
        }
        //End of Added By Vyankat B on 19/04/2025 Function to Delete the selected Training plan


        function goToPreviousPageRs() {
            
            if (currentPageRs > 1) {
                currentPageRs--;
                appendTrainingPlanResources(selectedTrainingPlanTrainingID, currentPageRs);
            }
        }


        function goToNextPageRs() {
            
            if (currentPageRs < totalPagesRs) {
                currentPageRs++;
                appendTrainingPlanResources(selectedTrainingPlanTrainingID, currentPageRs);
            }
        }

      


        function updatePaginationButtonsRs() {

            var firstPageBtn = document.getElementById('firstPageBtnRs');
            var lastPageBtn = document.getElementById('lastPageBtnRs');
            
            // -------- PREVIOUS BUTTON --------
            if (currentPageRs <= 1) {

                firstPageBtn.disabled = true;
                firstPageBtn.style.opacity = '0.5';
                firstPageBtn.style.cursor = 'not-allowed';
                firstPageBtn.style.background = '#f8f9fa';
                firstPageBtn.style.color = '#6c757d';
             
            } else {

                firstPageBtn.disabled = false;
                firstPageBtn.style.opacity = '1';
                firstPageBtn.style.cursor = 'pointer';
                firstPageBtn.style.background = 'white';
                firstPageBtn.style.color = '#3b82f6';
              
            }

            // -------- NEXT BUTTON --------
            if (currentPageRs >= totalPagesRs) {

                lastPageBtn.disabled = true;
                lastPageBtn.style.opacity = '0.5';
                lastPageBtn.style.cursor = 'not-allowed';
                lastPageBtn.style.background = '#f8f9fa';
                lastPageBtn.style.color = '#6c757d';

            } else {

                lastPageBtn.disabled = false;
                lastPageBtn.style.opacity = '1';
                lastPageBtn.style.cursor = 'pointer';
                lastPageBtn.style.background = 'white';
                lastPageBtn.style.color = '#3b82f6';
              
            }
        }




        var currentPageRs = 1;
        var pageSizeRs = 5;
        var totalRecordsRs = 0;
        var totalPagesRs = 0;

        //Added By Vyankat B on 19/04/2025 Function to apend resources of training plan
        function appendTrainingPlanResources(toolId) {
            
            
            var param = {
                TrainingID: toolId,
                PageNumber: currentPageRs,
                PageSize: 5  
            };
            param = JSON.stringify(param);

            var url = "api/TrainingPlan/GetResourcesForTrainingPlan";
            var resources = AJAXCallWithResult(url, param, false);



            var tableBody = document.getElementById('ResourcesTbl').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = '';

           

            // Check if response has the expected structure and extract the data
            var resourceData = [];
            if (resources && Array.isArray(resources.resources)) {
                resourceData = resources.resources;
            } else {
                resourceData = [];
            }


            if (resources?.paginationEntities?.length > 0) {
                var pageInfo = resources.paginationEntities[0];

                currentPageRs = pageInfo.currentPage;
                pageSizeRs = pageInfo.pageSize;
                totalPagesRs = pageInfo.totalPages;
                totalRecordsRs = pageInfo.totalRecords;
            }

            // -----------------------------
            // Bind total records
            // -----------------------------
            document.getElementById('totalRecordsRs').innerText =
                `Total Records: ${totalRecordsRs}`;


            if (resourceData && resourceData.length > 0) {
            resourceData.forEach(function (resource) {
                var rowHTML = `
                            <tr>
<%--                                    <% If m_blnEditAccess = True Then %>--%>
                                <td><a href="javascript:;" data-bs-target="#AddResourcesModal2" onclick="openResourceDetails(${resource.trainingResourceID}, ${resource.employeeID})">${resource.employeeName || 'No Resource Assigned'}</a></td>
<%--                                    <%End If %>--%>
                                                               <td>
                                ${resource.startDate &&
                                                        resource.startDate !== '1900-01-01T00:00:00' &&
                                                        resource.startDate !== '0001-01-01T00:00:00'
                                                        ? new Date(resource.startDate).toLocaleDateString('en-GB', {
                                                            day: 'numeric',
                                                            month: 'short',
                                                            year: 'numeric'
                                                        })
                                                        : 'Not Set'}
                                </td>

                                <td>
                                ${resource.endDate &&
                                                        resource.endDate !== '1900-01-01T00:00:00' &&
                                                        resource.endDate !== '0001-01-01T00:00:00'
                                                        ? new Date(resource.endDate).toLocaleDateString('en-GB', {
                                                            day: 'numeric',
                                                            month: 'short',
                                                            year: 'numeric'
                                                        })
                                                        : 'Not Set'}
                                </td>

                                <td>${resource.hours && resource.hours !== '00:00' ? resource.hours : 'Not Set'}</td>
                                <td>
                           <% If m_blnEditAccess = True Then %>
                                    <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#EdtResourcesModal" onclick="openEditResourceDetails(${resource.trainingResourceID}, ${resource.trainingID})">
                                        <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" title="More Details"></i>
                                    </a>
                      <%End If %>
                                </td>
                            </tr>
                        `;
                tableBody.innerHTML += rowHTML;
            });

            $('#ResourcesTbl').dataTable({
                pageLength: 7,
                lengthChange: false,
                bFilter: false,
                ordering: true,
                responsive: true,
                destroy: false,
                retrieve: true
            });
            } else {
                // Show "No data available" message when no data
                var rowHTML = `
                    <tr>
                        <td colspan="5" class="text-center" style="color: black;">
        <%= MyBase.GetResourceString("C_NoDataAvaible") %>
    </td>
                    </tr>
                `;
                tableBody.innerHTML = rowHTML;

                $('#ResourcesTbl').dataTable({
                    pageLength: 7,
                    lengthChange: false,
                    bFilter: false,
                    ordering: false,
                    responsive: true,
                    destroy: false,
                    retrieve: true,
                    info: false,
                    paging: false
                });
            }

            // Store the resource data for later use
            selectedTraiingPlanResources = resourceData;

            updatePaginationButtonsRs();
        }
        //End of Added By Vyankat B on 19/04/2025 Function to apend resources of training plan


        //Added By Vyankat B on 19/04/2025 Function to appedn the available resources to the dropdown.
        function appendEmployeeDropdown() {
            var param = {
                ProjectID: defaultProjectID
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/FetchActiveProjectResources";
            var employees = AJAXCallWithResult(url, param, false);


            // Extract the actual data from the nested response structure
            var resourceData = [];
            if (employees && employees.result && employees.result.ActiveProjectResourceEntity) {
                resourceData = employees.result.ActiveProjectResourceEntity;
            } else if (employees && employees.resources && employees.resources.ActiveProjectResourceEntity) {
                resourceData = employees.resources.ActiveProjectResourceEntity;
            } else if (Array.isArray(employees)) {
                resourceData = employees;
            }


            var resourceDropdown = document.getElementById('projDeliverables');
            resourceDropdown.innerHTML = '<option value="">Select Resource</option>';

            resourceData.forEach(function (resource) {
                var optionHTML = `<option value="${resource.employeeID || resource.employeeId}">${resource.employeeName || resource.employeeName}</option>`;
                resourceDropdown.innerHTML += optionHTML;
            });

            $(resourceDropdown).selectpicker({
                title: 'Select Resource',
                noneSelectedText: 'Select Resource'
            });

            var resourceDropdown2 = document.getElementById('projDeliverables2');
            resourceDropdown2.innerHTML = '<option value="">Select Resource</option>';

            resourceData.forEach(function (resource) {
                var optionHTML = `<option value="${resource.employeeID || resource.employeeId}">${resource.employeeName || resource.employeeName}</option>`;
                resourceDropdown2.innerHTML += optionHTML;
            });

            $(resourceDropdown2).selectpicker({
                title: 'Select Resource',
                noneSelectedText: 'Select Resource'
            });

            var resourceDropdownEdit = document.getElementById('EdtResourcesInput');
            resourceDropdownEdit.innerHTML = '<option value="">Select Resource</option>';

            employees.resources.ActiveProjectResourceEntity.forEach(function (resource) {
                var optionHTML = `<option value="${resource.employeeID}">${resource.employeeName}</option>`;
                resourceDropdownEdit.innerHTML += optionHTML;
            });

            $(resourceDropdownEdit).selectpicker({
                title: 'Select Resource',
                noneSelectedText: 'Select Resource'
            });

        }
       //End of Added By Vyankat B on 19/04/2025 Function to appedn the available resources to the dropdown.

       //Added By Vyankat B on 30th Sep 2025 Function to initialize resource dropdowns with proper placeholder text
        function initializeResourceDropdowns() {
         
            // Initialize projDeliverables dropdown
            var resourceDropdown = document.getElementById('projDeliverables');
            if (resourceDropdown) {
                if (resourceDropdown.innerHTML.trim() === '') {
                    resourceDropdown.innerHTML = '<option value="">Select Resource</option>';
                }
                $(resourceDropdown).selectpicker({
                    title: 'Select Resource',
                    noneSelectedText: 'Select Resource'
                });
            }

            // Initialize projDeliverables2 dropdown
            var resourceDropdown2 = document.getElementById('projDeliverables2');
            if (resourceDropdown2) {
                if (resourceDropdown2.innerHTML.trim() === '') {
                    resourceDropdown2.innerHTML = '<option value="">Select Resource</option>';
                }
                $(resourceDropdown2).selectpicker({
                    title: 'Select Resource',
                    noneSelectedText: 'Select Resource'
                });
            }

            // Initialize EdtResourcesInput dropdown
            var resourceDropdownEdit = document.getElementById('EdtResourcesInput');
            if (resourceDropdownEdit) {
                if (resourceDropdownEdit.innerHTML.trim() === '') {
                    resourceDropdownEdit.innerHTML = '<option value="">Select Resource</option>';
                }
                $(resourceDropdownEdit).selectpicker({
                    title: 'Select Resource',
                    noneSelectedText: 'Select Resource'
                });
            }

            // Initialize TaskResourcesAdd dropdown (Convert to Assigned Task)
            var taskResourcesDropdown = document.getElementById('TaskResourcesAdd');
            if (taskResourcesDropdown) {
                if (taskResourcesDropdown.innerHTML.trim() === '') {
                    taskResourcesDropdown.innerHTML = '<option value="">Select Resources</option>';
                }
                $(taskResourcesDropdown).selectpicker({
                    title: 'Select Resources',
                    noneSelectedText: 'Select Resources'
                });
            }
        }
       //End of Added By Vyankat B on 30th Sep 2025 Function to initialize resource dropdowns

     

       //Added By Vyankat B on 19/04/2025 Function to populate edit resource dropdown
        function populateEditResourceDropdown() {
            var param = {
                ProjectID: defaultProjectID
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/FetchActiveProjectResources";
            var employees = AJAXCallWithResult(url, param, false);


            // Extract the actual data from the nested response structure
            var resourceData = [];
            if (employees && employees.result && employees.result.ActiveProjectResourceEntity) {
                resourceData = employees.result.ActiveProjectResourceEntity;
            } else if (employees && employees.resources && employees.resources.ActiveProjectResourceEntity) {
                resourceData = employees.resources.ActiveProjectResourceEntity;
            } else if (Array.isArray(employees)) {
                resourceData = employees;
            }


            var resourceDropdown = document.getElementById('EdtResourcesInput');
            resourceDropdown.innerHTML = '<option value="">Select Resource</option>';

            resourceData.forEach(function (resource) {
                var optionHTML = `<option value="${resource.employeeID || resource.employeeId}">${resource.employeeName || resource.employeeName}</option>`;
                resourceDropdown.innerHTML += optionHTML;
            });

            $(resourceDropdown).selectpicker({
                title: 'Select Resource',
                noneSelectedText: 'Select Resource'
            });
        }
       //End of Added By Vyankat B on 19/04/2025 Function to populate edit resource dropdown
      
        // Added By Vyankat B on 19/04/2025
        // Function to fill up on the last column resource table click
        function openEditResourceDetails(trainingResourceID, trainingID) {
            
            saveAndAddClickForNameClick = 0;
            //document.getElementById('EdtDeleteResBtn').disabled = false;

            // First, populate the dropdown with available resources
            populateEditResourceDropdown();

            var param = {
                TrainingID: trainingID,
                TrainingResourceID: trainingResourceID
            };
            param = JSON.stringify(param);

            var url = "api/TrainingPlan/GetResourcesForTrainingPlan";
            var response = AJAXCallWithResult(url, param, false);

            // ✅ Validate API response
            if (
                !response ||
                !Array.isArray(response.resources)
            ) {
                console.error('Invalid API response:', response);
                return;
            }

            var resourceList = response.resources;

            // ✅ Find resource by TrainingResourceID (NOT employeeID)
            var resource = resourceList.find(function (res) {
                return res.trainingResourceID === trainingResourceID
                    || res.TrainingResourceID === trainingResourceID;
            });

            if (resource) {
                selectedTrainingResourceID = resource.trainingResourceID || resource.TrainingResourceID;

                var resourceDropdown = document.getElementById('EdtResourcesInput');
                resourceDropdown.value = resource.employeeID || resource.EmployeeID;
                $(resourceDropdown).selectpicker('refresh');

                document.getElementById('EdtWorkInput').value =
                    resource.hours || resource.Hours || '';


                document.getElementById('EdtStartDateInput').value =
                    formatDateDDMMMYYYY(resource.startDate || resource.StartDate);

                document.getElementById('EdtEndDateInput').value =
                    formatDateDDMMMYYYY(resource.endDate || resource.EndDate);

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%= MyBase.GetResourceString("A_ResNotF") %>');
                return;
            }

            resourceNameClickTrainingResourceId =
                resource.trainingResourceID || resource.TrainingResourceID;
            resourceNameClickEmployeeID =
                resource.employeeID || resource.EmployeeID;

            $('#EdtResSaveBtn').show();
            $('#EdtDeleteResBtn').show();
        }
        // End of Added By Vyankat B on 19/04/2025



        function formatDateDDMMMYYYY(dateValue) {
            if (!dateValue) return '';

            var d = new Date(dateValue);
            if (isNaN(d.getTime())) return '';

            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

            var day = String(d.getDate()).padStart(2, '0');
            var month = months[d.getMonth()];
            var year = d.getFullYear();

            return day + ' ' + month + ' ' + year;
        }



        //Added By Vyankat B on 19/04/2025 Common validation function for resource details
        function validateResourceDetails(selectedResource, workHours, startDate, endDate, isInsert = true) {
            
            if (selectedResource === "Select Resource" || selectedResource === "") {
                const errorMessage = isInsert ?
                    "<%= MyBase.GetResourceString("A_ValidRes") %>" :
                    "<%= MyBase.GetResourceString("A_ValidResource")%>";
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>" + errorMessage + "</span>");
                return false;
            }

            // Work hours validation (HH:MM format)
            if (!workHours || !/^([01]?[0-9]|2[0-3]):[0-5][0-9]$/.test(workHours)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_WorkForHM")%></span>");
                return false;
            }

            // Start date validation
            if (!startDate || isNaN(Date.parse(startDate))) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_StartDInValid")%></span>");
                return false;
            }

            // End date validation
            if (!endDate || isNaN(Date.parse(endDate))) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_EndDInValid")%></span>");
                return false;
            }

            // Date range validation
            if (new Date(endDate) < new Date(startDate)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_EndvsStart")%></span>");
                return false;

            }

            if (startDate) {

            var result = checkIsBetweenProjectDate(selectedResource, startDate, endDate);

                if (result && result.trim() !== "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("<span style='font-size:14px;'>" + result + "</span>");
                    return false;
                }
        }

            return true;

        }

        //Added By Vyankat B on 19/04/2025 Function to update the resource details on save click
        function saveResourceDetails(flag) {
            
            if (flag === 1) {

                var selectedResource = (document.getElementById('projDeliverables2').value || "").trim();
                var workHours = (document.getElementById('AnalysisAssRes2').value || "").trim();
                var startDate = document.getElementById('AssResStartDate2').value;
                var endDate = document.getElementById('AssResEndDate2').value;
            } else {
                var selectedResource = (document.getElementById('EdtResourcesInput').value || "").trim();
                var workHours = (document.getElementById('EdtWorkInput').value || "").trim();
                var startDate = document.getElementById('EdtStartDateInput').value;
                var endDate = document.getElementById('EdtEndDateInput').value;
            }
            if (saveAndAddClickForNameClick >= 1) {
                //insert logic will be here
                if (!validateResourceDetails(selectedResource, workHours, startDate, endDate, true)) {
                    return;
                }

                var param = {
                    TrainingID: selectedTrainingPlanTrainingID,
                    EmployeeId: selectedResource,
                    StartDate: toSqlDate(startDate),
                    EndDate: toSqlDate(endDate),
                    Hours: workHours
                };
                param = JSON.stringify(param);
                
                var url = "api/TrainingPlan/InsertTrainingPlanResources";
                var resources = AJAXCallWithResult(url, param, false);

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_ResourceAdd")%></span>");
            } else {
                //update logic
                if (!validateResourceDetails(selectedResource, workHours, startDate, endDate, false)) {
                    return;
                }

               


                var param = {
                    trainingResourceID: resourceNameClickTrainingResourceId, // ✅ correct
                    employeeId: selectedResource,                            // ✅ employeeId
                    startDate: toSqlDate(startDate),
                    endDate: toSqlDate(endDate),                               // ✅ nullable
                    hours: workHours || null                                 // ✅ hours
                };


                param = JSON.stringify(param);
                
                var url = "api/TrainingPlan/UpdateTrainingPlanResources";
                var resources = AJAXCallWithResult(url, param, false);

                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_ResDetail")%></span>");
               
            }
            document.getElementById('closeNameClickModal').click();
            document.getElementById('closeEditResourceModal').click();


            appendTrainingPlanResources(selectedTrainingPlanTrainingID);

          
        }
        //End of Added By Vyankat B on 19/04/2025 Function to update the resource details on save click


        function toSqlDate(dateValue) {
            if (!dateValue) return null;

            const d = new Date(dateValue);
            if (isNaN(d.getTime())) return null;

            // Build YYYY-MM-DD using LOCAL date parts
            const year = d.getFullYear();
            const month = String(d.getMonth() + 1).padStart(2, '0');
            const day = String(d.getDate()).padStart(2, '0');

            return `${year}-${month}-${day}`; // SAFE, NO UTC
        }

        //Added By Vyankat B on 19/04/2025 Function to add new resource details
        function insertResourceDetails(flag) {
            if (flag === 1) {
                var selectedResource = (document.getElementById('projDeliverables2').value || "").trim();
                var workHours = (document.getElementById('AnalysisAssRes2').value || "").trim();
                var startDate = document.getElementById('AssResStartDate2').value;
                var endDate = document.getElementById('AssResEndDate2').value;
            } else {
                    var selectedResource = (document.getElementById('EdtResourcesInput').value || "").trim();
                    var workHours = (document.getElementById('EdtWorkInput').value || "").trim();
                    var startDate = document.getElementById('EdtStartDateInput').value;
                    var endDate = document.getElementById('EdtEndDateInput').value;
                }



            // Validate resource details using the common validation function
            if (!validateResourceDetails(selectedResource, workHours, startDate, endDate, true)) {
                return;
            }

          

            var param = {
                TrainingID: selectedTrainingPlanTrainingID,
                EmployeeId: selectedResource,
                startDate: toSqlDate(startDate),
                endDate: toSqlDate(endDate),
                Hours: workHours
            };
            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/InsertTrainingPlanResources";
            var resources = AJAXCallWithResult(url, param, false);

            alertify.set('notifier', 'position', 'top-right');
            alertify.success("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_ResourceAdd")%></span>");
        }
        //End of Added By Vyankat B on 19/04/2025 Function to add new resource details

        //Added By Vyankat B on 19/04/2025 Helper function to reset form fields
        function resetResourceFormFields() {
            // Reset main form fields
            document.getElementById('projDeliverables2').value = "Select Resource";
            $(document.getElementById('projDeliverables2')).selectpicker('refresh');
            document.getElementById('AnalysisAssRes2').value = "";
            document.getElementById('AssResStartDate2').value = "";
            document.getElementById('AssResEndDate2').value = "";

            // Reset edit form fields
            document.getElementById('EdtResourcesInput').value = "Select Resource";
            $(document.getElementById('EdtResourcesInput')).selectpicker('refresh');
            document.getElementById('EdtWorkInput').value = "";
            document.getElementById('EdtStartDateInput').value = "";
            document.getElementById('EdtEndDateInput').value = "";

            // Reset global variables
            resourceNameClickTrainingResourceId = null;
            resourceNameClickEmployeeID = null;
        }

        //Added By Vyankat B on 19/04/2025 Helper function to get form values based on flag
        function getResourceFormValues(flag) {
                if (flag === 1) {
                return {
                    selectedResource: (document.getElementById('projDeliverables2').value || "").trim(),
                    workHours: (document.getElementById('AnalysisAssRes2').value || "").trim(),
                    startDate: document.getElementById('AssResStartDate2').value,
                    endDate: document.getElementById('AssResEndDate2').value
                };
            } else {
                return {
                    selectedResource: (document.getElementById('EdtResourcesInput').value || "").trim(),
                    workHours: (document.getElementById('EdtWorkInput').value || "").trim(),
                    startDate: document.getElementById('EdtStartDateInput').value,
                    endDate: document.getElementById('EdtEndDateInput').value
                };
            }
        }

        //Added By Vyankat B on 19/04/2025 Helper function to update resource details
        function updateResourceDetails(selectedResource, workHours, startDate, endDate) {
                  

            var param = {
                trainingResourceID: resourceNameClickTrainingResourceId, // ✅ correct
                employeeId: selectedResource,                            // ✅ employeeId
                startDate: toSqlDate(startDate),
                endDate: toSqlDate(endDate),                               // ✅ nullable
                hours: workHours || null                                 // ✅ hours
            };
                    param = JSON.stringify(param);
                    
                    var url = "api/TrainingPlan/UpdateTrainingPlanResources";
            var resources = AJAXCallWithResult(url, param, false);

                    alertify.set('notifier', 'position', 'top-right');
            alertify.success("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_ResDetail")%></span>");


            $('#EdtResSaveBtn').hide();

            $('#EdtDeleteResBtn').hide();
   

        }

        //Added By Vyankat B on 19/04/2025 Function to save and add resources.
        function saveAndAddResource(flag) {

            saveAndAddClickForNameClick += 1;
            document.getElementById('EdtDeleteResBtn').disabled = true;
            
            if (saveAndAddClickForNameClick === 1) {
                // First click - Update existing resource
                var formValues = getResourceFormValues(flag);
                
                // Validate using the common validation function
                if (!validateResourceDetails(formValues.selectedResource, formValues.workHours, formValues.startDate, formValues.endDate, false)) {
                        return;
                    }

                // Update resource details
                updateResourceDetails(formValues.selectedResource, formValues.workHours, formValues.startDate, formValues.endDate);
                
                // Reset form fields
                resetResourceFormFields();
            } else {
                // Subsequent clicks - Insert new resource
                if (flag === 1) {
                    insertResourceDetails(1);
                } else {
                    insertResourceDetails(2);
                }
              
                // Reset form fields
                resetResourceFormFields();
            }

            appendTrainingPlanResources(selectedTrainingPlanTrainingID);

        }
        //End of Added By Vyankat B on 19/04/2025 Function to save and add resources.

        //Added By Vyankat B on 19/04/2025 Advanced validation function for addNewResource with project date checking
        function validateAddNewResource(selectedResource, workHours, taskStartDate, taskEndDate) {
            if (selectedResource === "Select Resource" || selectedResource === "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_ValidRes")%></span>");
                return false;
            }

            // Work hours validation (HH:MM format)
            if (!workHours) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_Work")%></span>");
                return false;
            }

            // Work hours validation (HH:MM format)
            if ( !/^([01]?[0-9]|2[0-3]):[0-5][0-9]$/.test(workHours)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_WorkForHM")%></span>");
                return false;
            }

            

            let errorMessage = "";

            // Start date validation
            if (taskStartDate == "" && !errorMessage) {
                errorMessage = "<%= MyBase.GetResourceString("A_StartDate")%>";
                } else if (!errorMessage && isNaN(Date.parse(taskStartDate))) {
                    errorMessage = "<%= MyBase.GetResourceString("A_ValidStartDate")%>";
                } else if (taskStartDate != '' && !errorMessage && hasInvalidChars(taskStartDate)) {
                    errorMessage = "<%= MyBase.GetResourceString("A_InvalidChars")%>";
            }

            // End date validation
            if (taskEndDate === "" && !errorMessage) {
                errorMessage = "<%= MyBase.GetResourceString("A_EndDate")%>";
            } else if (!errorMessage && isNaN(Date.parse(taskEndDate))) {
                errorMessage = "<%= MyBase.GetResourceString("A_EndDInValid")%>";
                } else if (taskEndDate != '' && !errorMessage && hasInvalidChars(taskEndDate)) {
                    errorMessage = "<%= MyBase.GetResourceString("A_InvalidChars")%>";
            }

            // Project date validation
            if (!errorMessage) {
                var result = checkIsBetweenProjectDate(selectedResource,taskStartDate, taskEndDate);


                if (result && result.trim() !== "") {
                    errorMessage = result;
                }
            }

            if (errorMessage) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>" + errorMessage + "</span>");
                return false;
            }

            return true;
        }

        //Added By Vyankat B on 19/04/2025 Helper function to insert resource via API
        function insertResourceViaAPI(selectedResource, workHours, taskStartDate, taskEndDate) {
                var param = {
                    TrainingID: selectedTrainingPlanTrainingID,
                    EmployeeId: selectedResource,
                   
                    StartDate: toSqlDate(taskStartDate),
                    EndDate: toSqlDate(taskEndDate),
                    Hours: workHours
                };
                param = JSON.stringify(param);
                
                var url = "api/TrainingPlan/InsertTrainingPlanResources";
            var resources = AJAXCallWithResult(url, param, false);
            
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_ResourceAdd")%></span>");
        }

        //Added By Vyankat B on 19/04/2025 Helper function to reset add resource form fields
        function resetAddResourceFormFields() {
                document.getElementById('projDeliverables').value = "Select Resource";
                $(document.getElementById('projDeliverables')).selectpicker('refresh');
                document.getElementById('AnalysisAssRes').value = "";
                document.getElementById('AssResStartDate').value = "";
                document.getElementById('AssResEndDate').value = "";
        }

        //Added By Vyankat B on 19/04/2025 Function to facilitate save, Save and Add for Add Button
        function addNewResource(flag) {

            var selectedResource = (document.getElementById('projDeliverables').value || "").trim();
            var workHours = (document.getElementById('AnalysisAssRes').value || "").trim();
            let taskStartDate = $.trim($("#AssResStartDate").val());
            let taskEndDate = $.trim($("#AssResEndDate").val());

            // Validate using the advanced validation function
            if (!validateAddNewResource(selectedResource, workHours, taskStartDate, taskEndDate)) {
                return;
            }

            console.log("Resource Details to Save:", {
                EmployeeId: selectedResource,
                TrainingID: selectedTrainingPlanTrainingID,
                StartDate: taskStartDate,
                EndDate: taskEndDate,
                Hours: workHours
            });

            // Insert resource via API
            insertResourceViaAPI(selectedResource, workHours, taskStartDate, taskEndDate);

            if (flag === 1) {
                // Save and close - click cancel button
                document.getElementById('ResCancelBtn').click();
                // Trigger cancel button and refresh resources
                $("#ResCancelBtn").trigger("click");
            } else {
                // Save and add - reset form fields
                resetAddResourceFormFields();
            }

         
            appendTrainingPlanResources(selectedTrainingPlanTrainingID);
        }
        //End of Added By Vyankat B on 19/04/2025 Function to facilitate save, Save and Add for Add Button

        //Added By Vyankat B on 19/04/2025 EventListener to clear all the fields while adding a new resource
        document.getElementById('AddResourcesBtn').addEventListener('click', () => {

            document.getElementById('projDeliverables').value = "Select Resource";
            $(document.getElementById('projDeliverables')).selectpicker('refresh');

            document.getElementById('AnalysisAssRes').value = "";
            document.getElementById('AssResStartDate').value = "";
            document.getElementById('AssResEndDate').value = "";
        });
        //End of Added By Vyankat B on 19/04/2025 EventListener to clear all the fields while adding a new resource

        //Added By Vyankat B on 19/04/2025 Function to delete selected resources
        function deleteSelectedTrainingPlanResources() {

            var param = {
                TrainingResourceID: selectedTrainingResourceID
            };
            param = JSON.stringify(param);

            var url = "api/TrainingPlan/DeleteTrainingPlanResources";
            var resources = AJAXCallWithResult(url, param, false);

            alertify.set('notifier', 'position', 'top-right');
            alertify.success("<span style='font-size:14px;'><%= MyBase.GetResourceString("A_ResDel")%></span>");

            document.getElementById('EdtResCancelBtn').click();

            appendTrainingPlanResources(selectedTrainingPlanTrainingID);
        }
        //End of Added By Vyankat B on 19/04/2025 Function to delete selected resources

        //Added By Vyankat B on 19/04/2025 Function to update the Training Plan
        function updateTrainingPlan(flag) {
            
            var skillID = (document.getElementById('SkillsEdit').value || "").trim();
            var trainingPeriod = (document.getElementById('TraningPeriodEdit').value || "").trim();
            var unitElement = document.getElementById('UnitEdit');
            var unit = unitElement && unitElement.selectedIndex >= 0 ? (unitElement.options[unitElement.selectedIndex].value || "").trim() : "";
            var trainingArea = (document.getElementById('TraningAreaEdit').value || "").trim();
            var waiverCriteria = (document.getElementById('WaiverCriteriaEdit').value || "").trim();
            var completed = document.getElementById('completedEdtCheck').checked ? 1 : 0;

            // Validate using the common validation function
            if (!validateTrainingSkill(skillID, trainingPeriod, unit, trainingArea, waiverCriteria, true)) {
                return;
            }

                if (saveFlag == true) {
                // Update existing training plan
                var params = createTrainingSkillParams(skillID, trainingPeriod, unit, trainingArea, waiverCriteria, true, selectedTrainingPlanID, completed);
                
                if (callTrainingSkillAPI(params, true)) {
                    appendTrainingSkills(params.ProjectID, 1);
                    saveFlag = false;   
                }
                } else {
                // Add new training skill
                var params = createTrainingSkillParams(skillID, trainingPeriod, unit, trainingArea, waiverCriteria, false);
                
                if (callTrainingSkillAPI(params, false)) {
                    appendTrainingSkills(params.ProjectID, 1);
                }
                 }

            if (flag) {

                /*  $("#offcanvasClose").trigger("click");*/
                checkAndToggleHistoryButton(selectedTrainingPlanID)

            } else

            {

                $('#SkillsEdit').val('0');
                $('#SkillsEdit').selectpicker('refresh');
                $('#TraningPeriodEdit').val('');
                $('#UnitEdit').val('0');
                $('#UnitEdit').selectpicker('refresh');
                $('#TraningAreaEdit').val('');
                $('#WaiverCriteriaEdit').val('');
                $("#completedEdtCheck").prop("checked", false);
                $('#completedEdtCheck').selectpicker('refresh');

                $('#ResourceDetails').hide();
                $('#deleteTrPlanBtn').hide();
                $('#BkPlansShowHisBtn').hide();
                $('#saveAddTrPlanBtn').hide();
                $('#compleCheckBox').hide();
                $('#showhisID').hide();

               
            }
            
        }
        //End of Added By Vyankat B on 19/04/2025 Function to update the Training Plan

    
    

        //Added By Vyankat B on 19/04/2025 Function to apply the filter on Button:{apply} click
        function basicFilterApply() {

            var skillID = (document.getElementById('SkillsFilter').value || "").trim();
            if (skillID == 0) {
                skillID = '';
            }
            var trainingPeriod = (document.getElementById('TraningPeriodFilter').value || "").trim();
            var unit = (document.getElementById('UnitFilter').value || "").trim();
            if (unit == 0) {
                unit = '';
            }
            var trainingArea = (document.getElementById('TraningAreaFilter').value || "").trim();
            var waiverCriteria = (document.getElementById('WaiverCriteriaFilter').value || "").trim();

            // Check if at least one filter field is selected
            if (!skillID && !trainingPeriod && !unit && !trainingArea && !waiverCriteria) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'><%= MyBase.GetResourceString("C_SelFilter")%></span>");
                return;
            }

            // Get the currently selected project from dropdown
            var selectedProjectID = $('#ProjectFilter').val() || defaultProjectID;
            
            // Build JSON object for the API call
            var param = {
                ToolID: skillID && skillID !== "" ? parseInt(skillID) : null,
                TrainingArea: trainingArea || null,
                DayFormat: unit && unit !== "" ? parseInt(unit) : null,
                ProjectID: selectedProjectID && selectedProjectID !== "" ? parseInt(selectedProjectID) : null,
                WaiverCriteria: waiverCriteria || null,
                TrainingDuration: trainingPeriod && trainingPeriod !== "" ? parseInt(trainingPeriod) : null,
                PageNumber: currentPage || 1,
                PageSize: pageSize || 10
            };
            
            console.log('ApplyFilter Parameters:', param);
            console.log('skillID:', skillID, 'unit:', unit, 'trainingPeriod:', trainingPeriod);
            
            param = JSON.stringify(param);

            var url = "api/TrainingPlan/ApplyFilter";
            var filteredTrainingPlans = AJAXCallWithResult(url, param, false);


            var tableBody = document.getElementById('TrainingPlanTbl').getElementsByTagName('tbody')[0];

            tableBody.innerHTML = '';

            if ($.fn.DataTable.isDataTable('#TrainingPlanTbl')) {
                $('#TrainingPlanTbl').DataTable().clear().destroy();
            }

            // Check if response has the expected structure and extract the data
            var trainingData = [];
            if (filteredTrainingPlans && filteredTrainingPlans.result && filteredTrainingPlans.result.FilteredTrainingNeedsEntity) {
                trainingData = filteredTrainingPlans.result.FilteredTrainingNeedsEntity;
            } else if (Array.isArray(filteredTrainingPlans)) {
                trainingData = filteredTrainingPlans;
            }


            trainingData.forEach(function (training) {
                var rowHTML = `
                               <tr>
                                   <td>${training.description}</td>
                                   <td>${training.trainingPeriod}</td>
                                   <td>${training.completed ? "Yes" : "No"}</td>
                                   <td>
                                       <a href="javascript:;" data-bs-toggle="offcanvas" 
                                           data-bs-target="#offcanvas_EdtTrainPlans" aria-controls="offcanvasWithBothOptions" onclick="handleTrainingPlanClick(${training.trainingID})">
                                           <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" title="More Details"></i>
                                       </a>
                                   </td>
                               </tr>
                           `;

                tableBody.innerHTML += rowHTML;
            });

            $('#TrainingPlanTbl').dataTable({
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "info": false,
                "paging": true,
                "bPaginate": true
            });

           

            // Show success alert
            alertify.set('notifier', 'position', 'top-right');
            alertify.success("<span style='font-size:14px;'>Filter applied successfully!</span>");

            // Show Clear All button and highlight filter icon
            toggleClearAllSpan(1);
            IsApliedFilter = 1;
        } 
        //End of Added By Vyankat B on 19/04/2025 Function to apply the filter on Button:{apply} click

       


        //Added By Vyankat B on 19/04/2025 function to clear all the applied filter even the default one
        function clearAllFilters() {
          
            // Clear txtFilterName if it exists
            var txtFilterName = document.getElementById('txtFilterName');
            if (txtFilterName) {
                txtFilterName.value = "";
            }
            
            document.getElementById('SkillsFilter').value = "";
            $(document.getElementById('SkillsFilter')).selectpicker('refresh');

            document.getElementById('TraningPeriodFilter').value = "";
            document.getElementById('UnitFilter').value = "";
            $(document.getElementById('UnitFilter')).selectpicker('refresh');

            document.getElementById('TraningAreaFilter').value = "";
            document.getElementById('WaiverCriteriaFilter').value = "";

            $(this).closest('span[data-bs-toggle="tooltip"]').tooltip('hide');

            // Collapse only the filterpanelbody when clearing all filters
            const filterPanelBody = document.querySelector('.filterpanelbody');
            if (filterPanelBody) {
                // Hide the filterpanelbody div
                filterPanelBody.style.display = 'none';
            }

            isBasicFilterApplied = 0;
            isFilterAppliedByClick = 0;
            toggleClearAllSpan(0);
            IsApliedFilter = 0;
            // Show success alert
            alertify.set('notifier', 'position', 'top-right');
            alertify.success("<span style='font-size:14px;'>Clear filter successfully!</span>");

           <%-- alertify.set('notifier', 'position', 'top-right');
            alertify.success("<span style='font-size:14px;'><%=MyBase.GetResourceString("A_ClearFilter")%></span>");--%>

            // Get the currently selected project from dropdown and refresh the table
            var selectedProjectID = $('#ProjectFilter').val() || defaultProjectID;
            appendTrainingSkills(selectedProjectID, 1);

        }
        //End of Added By Vyankat B on 19/04/2025 function to clear all the applied filter even the default one.

        //Added By Vyankat B on 19/04/2025 Function to Toggle the clear all option
        function toggleClearAllSpan(isDefFilterEnabled) {

            var clearAllSpan = document.getElementById('ClearAllFilter');

            if (isDefFilterEnabled === 0) {
                clearAllSpan.style.setProperty('display', 'none', 'important');
                // Reset to simple black icon when no filter is applied
                document.getElementById('AdvanceFilterIcon').style.backgroundColor = 'transparent';
                document.getElementById('AdvanceFilterIcon').style.color = '#374151';
                document.getElementById('AdvanceFilterIcon').style.borderRadius = '0';
                document.getElementById('AdvanceFilterIcon').style.width = 'auto';
                document.getElementById('AdvanceFilterIcon').style.height = 'auto';
                document.getElementById('AdvanceFilterIcon').style.display = 'inline-block';
                document.getElementById('AdvanceFilterIcon').style.alignItems = 'normal';
                document.getElementById('AdvanceFilterIcon').style.justifyContent = 'normal';
            } else {
                clearAllSpan.style.setProperty('display', 'inline', 'important');
                // Apply blue square styling when filter is applied
                document.getElementById('AdvanceFilterIcon').style.backgroundColor = '#1359a6';
                document.getElementById('AdvanceFilterIcon').style.color = 'white';
                document.getElementById('AdvanceFilterIcon').style.borderRadius = '0.375rem';
                document.getElementById('AdvanceFilterIcon').style.width = '2rem';
                document.getElementById('AdvanceFilterIcon').style.height = '2rem';
                document.getElementById('AdvanceFilterIcon').style.display = 'flex';
                document.getElementById('AdvanceFilterIcon').style.alignItems = 'center';
                document.getElementById('AdvanceFilterIcon').style.justifyContent = 'center';
            }
        }
        //End of Added By Vyankat B on 19/04/2025 Function to Toggle the clear all option

        // Function to show Basic Filter panel when tab is clicked
        function showBasicFilterPanel() {
            const filterElement = document.getElementById("TPlanBasicFilters");
            const filterPanelBody = document.querySelector('.filterpanelbody');
            
            if (filterElement) {
                filterElement.style.display = "block";
            }
            
            if (filterPanelBody) {
                filterPanelBody.style.display = "block";
            }
        }


      
        $(function(){
            // Initialize tooltips only once
            if (!$("[data-bs-toggle='tooltip']").data('bs.tooltip')) {
                $("[data-bs-toggle='tooltip']").tooltip();
            }

            // Hide tooltip when filter icon is clicked
            $('#AdvanceFilterIcon').on('click', function () {

                $(this).closest('span[data-bs-toggle="tooltip"]').tooltip('hide');
                if (IsApliedFilter == 1) {
                    toggleClearAllSpan();
                }
              
            });

            // Hide tooltip when "Set Default filter" is clicked
            $(document).on('click', '.checkmark[data-bs-toggle="tooltip"]', function() {
                $(this).tooltip('hide');
            });

            // Hide tooltip when apply filter checkbox is clicked
            $(document).on('click', 'input[name="applyFilter"]', function() {
                $(this).closest('div').find('label[data-bs-toggle="tooltip"]').tooltip('hide');
            });

            // Hide tooltip when delete filter icon is clicked
            $(document).on('click', '.far.fa-trash-alt[data-bs-toggle="tooltip"]', function() {
                $(this).tooltip('hide');
            });

        // Hide tooltip when edit filter icon is clicked
        $(document).on('click', '.edit_filter img[data-bs-toggle="tooltip"]', function() {
            $(this).tooltip('hide');
        });

        // Function to check if fields are selected and show modal or alert
        window.checkFieldsAndShowModal = function() {
            console.log("checkFieldsAndShowModal function called");
            
            var skillID = (document.getElementById('SkillsFilter').value || "").trim();
            if (skillID == 0) {
                skillID = '';
            }
            var trainingPeriod = (document.getElementById('TraningPeriodFilter').value || "").trim();
            var unit = (document.getElementById('UnitFilter').value || "").trim();
            if (unit == 0) {
                unit = '';
            }
            var trainingArea = (document.getElementById('TraningAreaFilter').value || "").trim();
            var waiverCriteria = (document.getElementById('WaiverCriteriaFilter').value || "").trim();

            console.log("Field values:", {skillID, trainingPeriod, unit, trainingArea, waiverCriteria});

            // Check if at least one filter field is selected
            if (!skillID && !trainingPeriod && !unit && !trainingArea && !waiverCriteria) {
                console.log("No fields selected - showing alert");
                // Show alert if no fields are selected
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<span style='font-size:14px;'>Please Select at least one Filter Field.</span>");
                return;
            } else {
                console.log("Fields selected - showing modal");
                // Show modal if at least one field is selected
                $('#saveAppplyFilterModal').modal('show');
            }
        };

        // Clear filter validation error when modal is shown
        $('#saveAppplyFilterModal').on('show.bs.modal', function() {
            document.getElementById('filterValidationError').style.display = 'none';
        });

       

        // Initialize Edit Resources modal dropdown when shown
        $('#EdtResourcesModal').on('show.bs.modal', function() {
            // Populate the dropdown with available resources
            populateEditResourceDropdown();
        });

        // Initialize Convert to Assigned Task dropdown when tab is shown
        $('#AssignedTasksTab').on('shown.bs.tab', function() {
            // Ensure the dropdown is properly initialized
            var taskResourcesDropdown = document.getElementById('TaskResourcesAdd');
            if (taskResourcesDropdown && taskResourcesDropdown.innerHTML.trim() === '') {
                taskResourcesDropdown.innerHTML = '<option value="">Select Resources</option>';
                $(taskResourcesDropdown).selectpicker({
                    title: 'Select Resources',
                    noneSelectedText: 'Select Resources'
                });
            }
        });

        // $('#showScheduleLink').click(function(){
        //     $('#CR_ShowScheduleModal').modal('show');
        // });
    })

        $("#filterpanel").on("show.bs.collapse", function () {
            // Don't show Clear All button when filter panel opens - only show it when Apply is clicked
            // $(".clearalllink").css("display", "inline-block"); // Commented out
            // Change filter button to blue square with white icon when panel opens
            document.getElementById('AdvanceFilterIcon').style.backgroundColor = '#1359a6';
            document.getElementById('AdvanceFilterIcon').style.color = 'white';
            document.getElementById('AdvanceFilterIcon').style.borderRadius = '0.375rem';
            document.getElementById('AdvanceFilterIcon').style.width = '2rem';
            document.getElementById('AdvanceFilterIcon').style.height = '2rem';
            document.getElementById('AdvanceFilterIcon').style.display = 'flex';
            document.getElementById('AdvanceFilterIcon').style.alignItems = 'center';
            document.getElementById('AdvanceFilterIcon').style.justifyContent = 'center';
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            // Don't hide Clear All button when panel closes - only hide it when filters are actually cleared
            // $(".clearalllink").hide(); // Commented out to keep Clear All visible
            
            // Only reset filter icon styling if no filters are currently applied
            if (isBasicFilterApplied === 0 && defaultFilterSelected === 0 && isFilterAppliedByClick === 0) {
                // Change filter button back to simple black icon when panel closes and no filters are applied
                document.getElementById('AdvanceFilterIcon').style.backgroundColor = 'transparent';
                document.getElementById('AdvanceFilterIcon').style.color = '#374151';
                document.getElementById('AdvanceFilterIcon').style.borderRadius = '0';
                document.getElementById('AdvanceFilterIcon').style.width = 'auto';
                document.getElementById('AdvanceFilterIcon').style.height = 'auto';
                document.getElementById('AdvanceFilterIcon').style.display = 'inline-block';
                document.getElementById('AdvanceFilterIcon').style.alignItems = 'normal';
                document.getElementById('AdvanceFilterIcon').style.justifyContent = 'normal';
            }
        });
        
        $(".BGdetalilink").click(function () {
            $(this).closest("tr").addClass("rowhiglight");
        });

        // Added by Vyankat B on 19/04/2025 to format the date correctly
        function formatDate(dateString) {
            var date = new Date(dateString);

            var day = date.getDate();
            var monthName = date.toLocaleString('default', { month: 'long' });
            var year = date.getFullYear();
            return day + ' ' + monthName + ' ' + year;
        }
        //End of Added by Vyankat B on 19/04/2025 to format the date correctly



        //Show History Detailspanel Script start here
        $(".ShowHisDetailpanel").hide();


        var currentPageHs = 1;
        var pageSizeHs = 5;
        var totalRecordsHs = 0;
        var totalPagesHs = 0;
        var currentTrainingIdHs = 0;

        //function updatePaginationButtonsHs() {
        //    $('#firstPageBtnHs').prop('disabled', currentPageHs === 1);
        //    $('#lastPageBtnHs').prop('disabled', currentPageHs === totalPagesHs);
        //}

        function updatePaginationButtonsHs() {

            var firstPageBtn = document.getElementById('firstPageBtnHs');
            var lastPageBtn = document.getElementById('lastPageBtnHs');
          
            // -------- PREVIOUS BUTTON --------
            if (currentPageHs <= 1) {

                firstPageBtn.disabled = true;
                firstPageBtn.style.opacity = '0.5';
                firstPageBtn.style.cursor = 'not-allowed';
                firstPageBtn.style.background = '#f8f9fa';
                firstPageBtn.style.color = '#6c757d';

            } else {

                firstPageBtn.disabled = false;
                firstPageBtn.style.opacity = '1';
                firstPageBtn.style.cursor = 'pointer';
                firstPageBtn.style.background = 'white';
                firstPageBtn.style.color = '#3b82f6';
      
            }

            // -------- NEXT BUTTON --------
            if (currentPageHs >= totalPagesHs) {

                lastPageBtn.disabled = true;
                lastPageBtn.style.opacity = '0.5';
                lastPageBtn.style.cursor = 'not-allowed';
                lastPageBtn.style.background = '#f8f9fa';
                lastPageBtn.style.color = '#6c757d';

            } else {

                lastPageBtn.disabled = false;
                lastPageBtn.style.opacity = '1';
                lastPageBtn.style.cursor = 'pointer';
                lastPageBtn.style.background = 'white';
                lastPageBtn.style.color = '#3b82f6';             
            }
        }



        function goToPreviousPageHs() {
            if (currentPageHs > 1) {
                currentPageHs--;
                ShowHistoryTab();
            }
        }


        function goToNextPageHs() {
            if (currentPageHs < totalPagesHs) {
                currentPageHs++;
                ShowHistoryTab();
            }
        }

        //Added By Vyankat B on 18/04/2025 Function to fetch history of training Skill ShowHistoryTab
        function ShowHistoryTab() {
            
            var param = {
                TagID: 694,
                IsSubTagID: 0,
                ProjectID: parseInt(defaultProjectID) || 0,
                UniqueID: selectedTrainingPlanID.toString()
            };

            param = JSON.stringify(param);
            
            var url = "api/TrainingPlan/GetHistoryOfTheTrainingSkill";
            var response = AJAXCallWithResult(url, param, false);
          
            var param2 = {
                TrainingID: selectedTrainingPlanID,
                PageNumber: currentPageHs,
                PageSize: pageSizeHs
            };
            param2 = JSON.stringify(param2);
            
           

            var url2 = "api/TrainingPlan/FetchTrainingPlanHistory";
            var historyResponse2 = AJAXCallWithResult(url2, param2, false);

            // -----------------------------
            // Extract the actual data
            // -----------------------------
            var historyData2 = [];
            if (historyResponse2 && Array.isArray(historyResponse2.data)) {
                historyData2 = historyResponse2.data;
            } else if (Array.isArray(historyResponse2)) {
                historyData2 = historyResponse2;
            }

            // -----------------------------
            // ✅ Extract pagination data
            // -----------------------------
            if (historyResponse2?.paginationEntities?.length > 0) {
                var pageInfo = historyResponse2.paginationEntities[0];

                currentPageHs = pageInfo.currentPage;
                pageSizeHs = pageInfo.pageSize;
                totalRecordsHs = pageInfo.totalRecords;
                totalPagesHs = pageInfo.totalPages;
            }

            // -----------------------------
            // ✅ Bind total records
            // -----------------------------
            $('#totalRecordsHs').text(`Total Records: ${totalRecordsHs}`);

            $(".ShowHisDetailpanel").show();
            $(".offcanvas-body").animate(
                {
                    scrollTop: $(".ShowHisDetailpanel").offset().top - 60,
                },
                "1000"
            );

            $(".table").resize();

            var tableBody = document
                .getElementById('BkPlanShowHisTable')
                .getElementsByTagName('tbody')[0];
            tableBody.innerHTML = '';

            if ($.fn.DataTable.isDataTable('#BkPlanShowHisTable')) {
                $('#BkPlanShowHisTable').DataTable().clear().destroy();
            }

            // -----------------------------
            // Final history data binding
            // -----------------------------
            var historyData = [];
            if (Array.isArray(historyData2)) {
                historyData = historyData2;
            }

            // Reverse to show newest first
            historyData.forEach(function (entry) {

                var rowHTML = `
                      <tr>
                          <td>${entry.ModifiedField || entry.modifiedField || ''}</td>
                          <td>${entry.OldValue || entry.oldValue || ''}</td>
                          <td>${entry.NewValue || entry.newValue || ''}</td>
                                                   <td>
                        ${(entry.ModifiedDate || entry.modifiedDate)
                                                ? new Date(entry.ModifiedDate || entry.modifiedDate).toLocaleDateString('en-GB', {
                                                    day: 'numeric',
                                                    month: 'short',
                                                    year: 'numeric'
                                                })
                                                : ''}
                        </td>

                          <td>${entry.ModifiedBy || entry.modifiedBy || ''}</td>
                      </tr>
                  `;
                tableBody.innerHTML += rowHTML;
            });

            $('#BkPlanShowHisTable').dataTable({
                pageLength: 7,
                lengthChange: false,
                bFilter: false,
                ordering: false, 
                responsive: true,
                destroy: false,
                retrieve: true,
                bAutoWidth: false
            });

            appendModifiedDropdowns();
            updatePaginationButtonsHs();
        }
        //End of Added By Vyankat B on 18/04/2025 Function to fetch history of training Skill ShowHistoryTab
      

        // Added By Vyankat B on 18/04/2025 Function show the Delete Model 
        function showDelModal(filterID) {
            currentFID = filterID;
         
            var modal = new bootstrap.Modal(document.getElementById('deleteConfirmAlert'));
            modal.show();
        }
        // End of Added By Vyankat B on 18/04/2025 Function show the Delete Model 

        // Added By Vyankat B on 18/04/2025 Function show the Delete Model 
        function showDelModalTplan() {
         
            var modal = new bootstrap.Modal(document.getElementById('deleteConfirm'));
            modal.show();
        }
        // End of Added By Vyankat B on 18/04/2025 Function show the Delete Model

        //Added By Vyankat B on 18/04/2025 Function to check the selected between the project date or not
        function checkIsBetweenProjectDate(selectedResource,startDate,endDate){
         
           var startDateFormatted;
           var endDateFormatted;

           // Date format conversion - parse dates in local timezone to avoid timezone issues
           if (startDate) {
               // Parse the date string and create a new date object in local timezone
               var startDateObj = new Date(startDate);
               // Format as YYYY-MM-DD without timezone conversion
               startDateFormatted = startDateObj.getFullYear() + '-' + 
                                   String(startDateObj.getMonth() + 1).padStart(2, '0') + '-' + 
                                   String(startDateObj.getDate()).padStart(2, '0');
           }

           if (endDate) {
               // Parse the date string and create a new date object in local timezone
               var endDateObj = new Date(endDate);
               // Format as YYYY-MM-DD without timezone conversion
               endDateFormatted = endDateObj.getFullYear() + '-' + 
                                 String(endDateObj.getMonth() + 1).padStart(2, '0') + '-' + 
                                 String(endDateObj.getDate()).padStart(2, '0');
           }



           // Convert to proper data types for the API
           var parameters = {
               ProjectID: parseInt(defaultProjectID) || 0,
               StartDate: startDateFormatted || "",
               EndDate: endDateFormatted || "",
               EmpID : selectedResource
           };

           console.log('CheckIsBetweenProjectDate Parameters:', parameters);

           // Use JSON object for POST request
           var param = {
               ProjectID: parameters.ProjectID,
               StartDate: parameters.StartDate,
               EndDate: parameters.EndDate,
               EmpID: selectedResource
           };
           param = JSON.stringify(param);
           
           var url = "api/TrainingPlan/CheckIsBetweenProjectDate";
           
           console.log('CheckIsBetweenProjectDate URL:', url);
           var strResult = AJAXCallWithResult(url, param, false);

           console.log('CheckIsBetweenProjectDate Raw Response:', strResult);
           console.log('Response Type:', typeof strResult);
           
           // Parse the response if it's a string
           var parsedResult = strResult;
           if (typeof strResult === 'string') {
               try {
                   parsedResult = JSON.parse(strResult);
                   console.log('Parsed Response:', parsedResult);
               } catch (e) {
                   console.error('Error parsing JSON response:', e);
                   return "Error parsing API response";
               }
           }

          

            if (
                parsedResult &&
                parsedResult.result &&
                Array.isArray(parsedResult.result.ProjectTaskPeriodValidationEntity) &&
                parsedResult.result.ProjectTaskPeriodValidationEntity.length > 0
            ) {
                var validationData = parsedResult.result.ProjectTaskPeriodValidationEntity[0];
                console.log('Validation Data:', validationData);

                return validationData.msg || validationData.Msg || "";
            }

       }
       //End of Added By Vyankat B on 18/04/2025 Function to check the selected between the project date or not.

       //Added By Vyankat B on 18/04/2025 Function to bind the dropdown
        function binddropdown() {
            $("#SkillsAdd").val(0).change();
            $("#SkillsAdd").selectpicker("refresh");

            $("#UnitAdd").val(0).change();
          

            $("#TraningPeriodAdd").val('').change();
            $("#TraningPeriodAdd").selectpicker("refresh");

            $("#TraningAreaAdd").val('').change();
            $("#TraningAreaAdd").selectpicker("refresh");

            $("#WaiverCriteriaAdd").val('').change();
            $("#WaiverCriteriaAdd").selectpicker("refresh");
            
        }
       //End of Added By Vyankat B on 18/04/2025 Function to bind the dropdown

        //Added By Vyankat B on 18/04/2025 Function for the hide the show history panel
        $(".cancelEdtDetpanel").click(function () {
            $("table tr").removeClass("rowhiglight");
            $(".ShowHisDetailpanel").hide();
            // $(".backbtn, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
        });
        //End of Added By Vyankat B on 18/04/2025 Function for the hide the show history panel

           
        function resizeSection() {
            var tblheight = $(window).height();
            
            // Check if the "Add New Training Plan" form is expanded
            var addFormHeight = 0;
            var addFormSection = document.getElementById('AddContent');
            if (addFormSection && addFormSection.style.display !== 'none') {
                // Measure the actual height of the expanded form
                addFormHeight = addFormSection.offsetHeight + 20; // Add some padding
            }
            
            // Account for header space (100px) and expanded form - no fixed pagination
            var headerHeight = 100; // Space for header and search section
            var scrollBodyHeight = tblheight - headerHeight - addFormHeight;
            
            // Ensure minimum height
            if (scrollBodyHeight < 300) {
                scrollBodyHeight = 300;
            }
            
            $("#TrainingPlanTbl_wrapper .dataTables_scrollBody").css({ 
                height: scrollBodyHeight + "px", 
                "overflow-y": "auto",
                "max-height": scrollBodyHeight + "px"
            });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        // Add event listeners for accordion collapse/expand to resize table
        $('#AddTrPlanDtlsTab').on('show.bs.collapse', function () {
            // Form is expanding - wait a bit for animation to complete then resize
            setTimeout(function() {
                resizeSection();
            }, 300);
        });

        $('#AddTrPlanDtlsTab').on('hide.bs.collapse', function () {
            // Form is collapsing - resize immediately
            resizeSection();
        });

        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(":checked");
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {
            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }
        });

        //datatable
        $("#TrainingPlanTbl").dataTable({
            paging: false, // Disable pagination
            pageLength: 10,
            bLengthChange: false,
            bFilter: false,
            ordering: true,
            responsive: false,
            destroy: true,
            retrieve: true,
            info: false,
            bPaginate: false, // Disable pagination
            columnDefs: [
                { "width": "25%", "targets": 0 },
                { "width": "25%", "targets": 1 },
                { "width": "25%", "targets": 2 },
                { "width": "25%", "targets": 3 }
            ]
        });
        
        $("#ResourcesTbl").dataTable({
            scrollY: true,
            scrollX: true,
            paging: true,
            pageLength: 10,
            bLengthChange: false,
            bFilter: false,
            ordering: false,
            responsive: true,
            destroy: true,
            retrieve: true,
            bFilter: false,
            ordering: false,
            info: false,
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

        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };
        //datepicker
        $('#AddTaskStartDate, #AddTaskEndDate, #CustFieldAddInput3, #ShowSchStartDate, #ShowSchEndDate, #daterangeFrom, #daterangeTo, #EdtStartDateInput, #EdtEndDateInput, #AssResStartDate, #AssResEndDate, #TaskStartDateAdd, #TaskEndDateAdd').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            yearRange: "2005:2035",
            dateFormat: 'dd M yy'
        });

        // Custom Pagination Functions - Disabled since we show all records
    function goToFirstPage() {
        // Go to first page using DataTable API
        if ($.fn.DataTable.isDataTable('#TrainingPlanTbl')) {
            $('#TrainingPlanTbl').DataTable().page('first').draw('page');
            updateTotalRecords(); // Update page display
            updatePaginationButtons(); // Update button states
        }
    }

    function goToLastPage() {
        // Go to last page using DataTable API
        if ($.fn.DataTable.isDataTable('#TrainingPlanTbl')) {
            $('#TrainingPlanTbl').DataTable().page('last').draw('page');
            updateTotalRecords(); // Update page display
            updatePaginationButtons(); // Update button states
        }
    }

        function updateTotalRecords() {
            var totalRecordsElement = document.getElementById('totalRecords');
            if (!totalRecordsElement) return;
            
            var recordCount = 0;
            
            // Use totalRecords if available (from API pagination data)
            if (totalRecords && totalRecords > 0) {
                recordCount = totalRecords;
                totalRecordsElement.textContent = 'Total Records: ' + recordCount;
                return;
            }
            
            if ($.fn.DataTable.isDataTable('#TrainingPlanTbl')) {
                var info = $('#TrainingPlanTbl').DataTable().page.info();
                recordCount = info.recordsTotal || 0;
                
                // Show only total records
                totalRecordsElement.textContent = 'Total Records: ' + recordCount;
            } else {
                // Fallback: count table rows directly
                var table = document.getElementById('TrainingPlanTbl');
                if (table) {
                    var tbody = table.getElementsByTagName('tbody')[0];
                    var rows = tbody ? tbody.getElementsByTagName('tr') : [];
                    recordCount = rows.length;
                    totalRecordsElement.textContent = 'Total Records: ' + recordCount;
                }
            }
        }

        // Function to update pagination button states
        function updatePaginationButtons() {
            var firstBtn = document.getElementById('firstPageBtn');
            var lastBtn = document.getElementById('lastPageBtn');
            
            if (!firstBtn || !lastBtn) return;
            
            if ($.fn.DataTable.isDataTable('#TrainingPlanTbl')) {
                var info = $('#TrainingPlanTbl').DataTable().page.info();
                var currentPage = info.page + 1; // DataTable uses 0-based indexing
                var totalPages = info.pages;
                
                // Handle no data scenario - when totalPages is 0 or 1 with no records
                if (totalPages === 0 || (totalPages === 1 && info.recordsTotal === 0)) {
                    // No data - disable both buttons and show red circles
                    firstBtn.disabled = true;
                    firstBtn.style.opacity = '0.5';
                    firstBtn.style.cursor = 'not-allowed';
                    firstBtn.innerHTML = '<i class="fas fa-angle-double-left"></i><i class="fas fa-ban hover-block" style="color: #f5141f; position: absolute; opacity: 0; transition: opacity 0.3s;"></i>';
                    
                    lastBtn.disabled = true;
                    lastBtn.style.opacity = '0.5';
                    lastBtn.style.cursor = 'not-allowed';
                    lastBtn.innerHTML = '<i class="fas fa-angle-double-right"></i><i class="fas fa-ban hover-block" style="color: #f5141f; position: absolute; opacity: 0; transition: opacity 0.3s;"></i>';
                    return;
                }
                
                // Update Previous button (first page)
                if (currentPage === 1) {
                    firstBtn.disabled = true;
                    firstBtn.style.opacity = '0.5';
                    firstBtn.style.cursor = 'not-allowed';
                    firstBtn.innerHTML = '<i class="fas fa-angle-double-left"></i><i class="fas fa-ban hover-block" style="color: #f5141f; position: absolute; opacity: 0; transition: opacity 0.3s;"></i>';
                } else {
                    firstBtn.disabled = false;
                    firstBtn.style.opacity = '1';
                    firstBtn.style.cursor = 'pointer';
                    firstBtn.innerHTML = '<i class="fas fa-angle-double-left"></i>';
                }
                
                // Update Next button (last page)
                if (currentPage === totalPages) {
                    lastBtn.disabled = true;
                    lastBtn.style.opacity = '0.5';
                    lastBtn.style.cursor = 'not-allowed';
                    lastBtn.innerHTML = '<i class="fas fa-angle-double-right"></i><i class="fas fa-ban hover-block" style="color: #f5141f; position: absolute; opacity: 0; transition: opacity 0.3s;"></i>';
                } else {
                    lastBtn.disabled = false;
                    lastBtn.style.opacity = '1';
                    lastBtn.style.cursor = 'pointer';
                    lastBtn.innerHTML = '<i class="fas fa-angle-double-right"></i>';
                }
            } else {
                // DataTable not initialized - disable both buttons and show red circles
                firstBtn.disabled = true;
                firstBtn.style.opacity = '0.5';
                firstBtn.style.cursor = 'not-allowed';
                firstBtn.innerHTML = '<i class="fas fa-angle-double-left"></i><i class="fas fa-ban hover-block" style="color: #f5141f; position: absolute; opacity: 0; transition: opacity 0.3s;"></i>';
                
                lastBtn.disabled = true;
                lastBtn.style.opacity = '0.5';
                lastBtn.style.cursor = 'not-allowed';
                lastBtn.innerHTML = '<i class="fas fa-angle-double-right"></i><i class="fas fa-ban hover-block" style="color: #f5141f; position: absolute; opacity: 0; transition: opacity 0.3s;"></i>';
            }
        }

        // Function to check mandatory fields and update Save/Clear button states
        function updateSaveClearButtonStates() {
            var saveBtn = document.getElementById('AddClickYes'); // This is the green checkmark button
            var clearBtn = document.getElementById('AddClickNo');
            
            if (!saveBtn || !clearBtn) return;
            
            // Always enable buttons - remove the mandatory field validation
            // Enable Save button - show green checkmark
            saveBtn.style.opacity = '1';
            saveBtn.style.cursor = 'pointer';
            saveBtn.className = 'fas fa-check clickYes pe-2';
            saveBtn.style.color = '#28a745';
            saveBtn.style.fontSize = '1.2rem';
            saveBtn.style.background = 'white';
            saveBtn.style.border = '1px solid #d1d5db';
            saveBtn.style.borderRadius = '50%';
            saveBtn.style.padding = '0.5rem';
            saveBtn.style.display = 'flex';
            saveBtn.style.alignItems = 'center';
            saveBtn.style.justifyContent = 'center';
            saveBtn.style.width = '2rem';
            saveBtn.style.height = '2rem';
            
            // Enable Clear button - show red X
            clearBtn.style.opacity = '1';
            clearBtn.style.cursor = 'pointer';
            clearBtn.className = 'fas fa-times clickNo';
            clearBtn.style.color = '#dc3545';
            clearBtn.style.fontSize = '1.2rem';
            clearBtn.style.background = 'white';
            clearBtn.style.border = '1px solid #d1d5db';
            clearBtn.style.borderRadius = '50%';
            clearBtn.style.padding = '0.5rem';
            clearBtn.style.display = 'flex';
            clearBtn.style.alignItems = 'center';
            clearBtn.style.justifyContent = 'center';
            clearBtn.style.width = '2rem';
            clearBtn.style.height = '2rem';
        }

        // Update total records when table is drawn
        $(document).ready(function () {
            
            // Always show pagination on page load
            updateTotalRecords();
            updatePaginationButtons();
            
            // Initialize tooltips for pagination buttons (only if not already initialized)
            if (!$('[data-bs-toggle="tooltip"]').data('bs.tooltip')) {
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
            
            $('#TrainingPlanTbl').on('draw.dt', function() {
                updateTotalRecords();
                updatePaginationButtons();
            });
            
            // Update records count on page load
            setTimeout(function() {
                updateTotalRecords();
            }, 1000);

            // Add input validation for Training Period fields - only allow numeric input
            $('#TraningPeriodAdd, #TraningPeriodEdit').on('input', function() {
                var value = $(this).val();
                // Remove any non-numeric characters
                var numericValue = value.replace(/[^0-9]/g, '');
                // Limit to 5 digits
                if (numericValue.length > 5) {
                    numericValue = numericValue.substring(0, 5);
                }
                $(this).val(numericValue);
            });

            // Prevent paste of non-numeric content
            $('#TraningPeriodAdd, #TraningPeriodEdit').on('paste', function(e) {
                var paste = (e.originalEvent.clipboardData || window.clipboardData).getData('text');
                var numericValue = paste.replace(/[^0-9]/g, '').substring(0, 5);
                e.preventDefault();
                $(this).val(numericValue);
            });
            
            // Add event listeners to mandatory fields for Save/Clear button states
            $('#SkillsAdd, #TraningPeriodAdd, #UnitAdd').on('change input', function() {
                updateSaveClearButtonStates();
            });
            
            // Initialize Save/Clear button states on page load
            updateSaveClearButtonStates();
            
            // Also call it after a short delay to ensure all elements are loaded
            setTimeout(function() {
                updateSaveClearButtonStates();
            }, 1000);
        });


        function resizeSection() {
            var tblheight = $(window).height();
            $('#TrainingPlanTbl_wrapper .TrainingPlansDiv').css({ 'height': tblheight - 288, "overflow-y": "auto" });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

    </script>
    <!-- JavaScript syntax fixed -->
     <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
</body>


</html>
