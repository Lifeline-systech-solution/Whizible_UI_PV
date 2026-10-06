<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_SQAPlan.aspx.vb" Inherits="Whizible.PM_SQAPlan" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_SQAPlan")%></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <style>
        /* Fix z-index issue - make alertify notifications appear above modals */
        .alertify-notifier {
            z-index: 9999 !important;
        }
        .alertify-notifier .ajs-message {
            z-index: 9999 !important;
        }
        
        /* SQA Plan specific styles */
        .sqa-form-container {
            background: white;
            padding: 20px;
            border-radius: 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin: 0;
            width: 100%;
            max-width: 100%;
        }
        
        .sqa-header {
            background: #007bff;
            color: white;
            padding: 15px 20px;
            margin: -20px -20px 20px -20px;
            border-radius: 8px 8px 0 0;
        }
        
        .sqa-footer {
            background: #007bff;
            color: white;
            padding: 15px 20px;
            margin: 20px -20px -20px -20px;
            border-radius: 0 0 8px 8px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            font-weight: 400;
            color: #1a1a1a ;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
        }
        
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        
        .mandatory {
            color: red;
            font-weight: bold;
        }
        
        .search-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        .input-group {
            position: relative;
        }
        
        .btn-save {
            background: #28a745;
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 4px;
            font-weight: 500;
        }
        
        .btn-save:hover {
            background: #218838;
        }
        
        .help-icon {
            color: #007bff;
            font-size: 18px;
            cursor: pointer;
        }
        
        /* Full width layout */
        .wrapper {
            margin-left: 0 !important;
        }
        
        .content-wrapper {
            margin-left: 0 !important;
            padding-left: 0 !important;
        }
        
        .content {
            padding: 0 !important;
        }
        
        .container-fluid {
            padding-left: 15px !important;
            padding-right: 15px !important;
            max-width: 100% !important;
        }
        
        /* Required field styling - same as Training Plan */
        .required::after {
            content: " *";
            color: red;
            font-weight: bold;
        }
        
        /* Table styling - same as Training Plan */
        table tr th, table tr td {
            text-align: center !important
        }

        table tr th:last-child, table tr td:last-child {
            text-align: center;
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

        /* Form label styling - font weight 400 and darker color */
        .form-group label {
            font-weight: 400 !important;
            color: #1a1a1a !important;
        }

        /* Textarea border styling - darker border and smaller height */
        .form-control {
            border-color: #cfcfcf !important;
            height: 80px !important;
            min-height: 80px !important;
        }

        /* Remove blue focus outline and keep black border */
        .form-control:focus {
            border-color: #000 !important;
            box-shadow: none !important;
            outline: none !important;
        }

        /* Mandatory text alignment - right side in flex container */
        .d-flex .form-label {
            text-align: right !important;
        }

        /* Datepicker z-index - same as Training Plan */
        .ui-datepicker {
            z-index: 9999!important;
        }
        
        /* Calendar button styling */
        .ui-datepicker-trigger {
            background: #f8f9fa !important;
            border: 1px solid #dee2e6 !important;
            border-radius: 0.25rem !important;
            padding: 0.375rem 0.75rem !important;
            margin-left: 0.25rem !important;
            cursor: pointer !important;
        }
        
        .ui-datepicker-trigger:hover {
            background: #e9ecef !important;
        }
        
        .ui-datepicker-trigger:before {
            content: "📅" !important;
            font-size: 1rem !important;
        }
        
        /* Calendar button styling */
        .btncalendar {
            background: #f8f9fa !important;
            border: 1px solid #dee2e6 !important;
            border-left: none !important;
            border-radius: 0 0.25rem 0.25rem 0 !important;
            color: #6c757d !important;
            padding: 0.375rem 0.75rem !important;
        }
        
        .btncalendar:hover {
            background: #e9ecef !important;
            color: #495057 !important;
        }
        
        .btncalendar:focus {
            box-shadow: none !important;
            outline: none !important;
        }
        
        /* Minimize height and width for date input field only */
        #reviewDate {
            height: 45px !important;
            min-height: 45px !important;
            width: 150px !important;
            min-width: 150px !important;
            max-width: 150px !important;
        }
        
        /* Override input-group width for date field */
        .input-group #reviewDate {
            width: 150px !important;
            min-width: 150px !important;
            max-width: 150px !important;
            flex: none !important;
        }
        
        /* Ensure input-group doesn't expand - alternative approach */
        .input-group {
            width: auto !important;
            max-width: 200px !important;
        }
        
        /* Force the specific input group containing reviewDate */
        .col-sm-6 .input-group {
            width: auto !important;
            max-width: 200px !important;
        }
        
        /* Minimize search box height and width in project dropdown */
        .bootstrap-select .bs-searchbox input {
            height: 35px !important;
            min-height: 35px !important;
            width: 200px !important;
            max-width: 200px !important;
            padding: 2px 8px !important;
            font-size: 12px !important;
        }
        
        /* Keep project dropdown width constant */
        #ProjectFilter {
            width: 200px !important;
            min-width: 200px !important;
            max-width: 200px !important;
        }
        
        .bootstrap-select {
            width: 200px !important;
            min-width: 200px !important;
            max-width: 200px !important;
        }
        
        .bootstrap-select .dropdown-toggle {
            width: 200px !important;
            min-width: 200px !important;
            max-width: 200px !important;
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            white-space: nowrap !important;
        }
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
   <!-- Page Loader - Show immediately -->
   <div class="loader-overlay" id="loaderOverlay" style="display: none;">
       <div class="loader"></div>
   </div>

   <div class="bgwhite">
       <!-- Header Section with Icon and Subtitle -->
       <div style="background: white; padding: 1rem 0;">
           <div style="padding-left: 1rem; margin-left: 0;">
               <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                   <i class="fas fa-clipboard-check" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;"></i>
                   <%=MyBase.GetResourceString("C_SQAPlan")%>
               </h2>
               <p style="color: #6b7280; font-size: 0.7rem; margin: 0;"><%=MyBase.GetResourceString("C_Desc")%></p>
           </div>
       </div>

       <!-- Search and Filter Section -->
       <div style="background: rgb(231, 237, 240); padding: 0.5rem 1rem; margin-left: 2px;">
           <div style="display: flex; align-items: center; justify-content: space-between; gap: 0.75rem;">
               <!-- Left Side - Project Dropdown -->
               <div style="display: flex; align-items: center; gap: 0.5rem;">
                   <label style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0;"><%=MyBase.GetResourceString("C_SelProj")%></label>
                   <div style="min-width: 200px;">
                       <select id="ProjectFilter" class="selectpicker" data-live-search="true">
                           <option value=""><%=MyBase.GetResourceString("C_SelProje")%></option>
                       </select>
                   </div>
               </div>
               <!-- Right Side - Search and Filter -->
              <%-- <div style="display: flex; align-items: center; gap: 0.75rem;">
                   <div style="display: flex; align-items: center; background: white; border-radius: 0.25rem; border: 1px solid #d1d5db; overflow: hidden; height: 2rem; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
                       <input type="text" id="searchInput" placeholder="Search.." oninput="handleSearchInput()" style="border: none; outline: none; padding: 0.25rem 0.5rem; flex: 1; background: transparent; height: 100%; font-size: 11.5px;">
                       <button id="searchBtn" onclick="handleSearchInput()" style="background: #f3f4f6; border: none; padding: 0.25rem 0.5rem; color: #374151; cursor: pointer; height: 100%; display: flex; align-items: center; border-left: 1px solid #d1d5db;">
                           <i class="fas fa-search" style="font-size: 11.5px;"></i>
                       </button>
                   </div>
                   <a href="javascript:;" class="clearalllink pe-3" id="ClearAllFilter" data-bs-toggle="tooltip" title="Clear All" onclick="clearAllFilters()" style="color: #1359a6; text-decoration: none; font-size: 11.5px; margin-right: 0; display: none !important;"><strong></strong></a>
               </div>--%>
           </div>
       </div>

       <!-- SQA Plan Form -->
       <div class="sqa-form-container" style="margin: 0; border-radius: 0;">
                               <div class="d-flex justify-content-end align-items-center mb-3">
                                   <a href="javascript:;" class="textUndrln me-3" id="BkPlansShowHisBtn" onclick="ShowHistoryTab()" style="display: inline;">
                                       <span data-bs-toggle="tooltip" data-bs-original-title="Show History" aria-describedby="tooltip292923"><%=MyBase.GetResourceString("C_Hist")%></span>
                                   </a>
                                   <button class="btn btnyellow" id="saveResBtn" onclick="saveSQAPlan()"><%=MyBase.GetResourceString("C_Save")%></button>
                                   <label class="form-label mb-0 ms-3">(<font color="red">*</font><%=MyBase.GetResourceString("C_Mandt")%>)</label>
                               </div>

                               <!-- Form Fields -->
                               <div class="fscroll mb-3">
                                   <div class="row">
                                       <div class="col-sm-12 form-group">
                                           <!-- SQA Focus Area -->
                                           <div class="row mb-3">
                                               <label class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_SArea")%></label>
                                               <div class="col-sm-6">
                                                   <textarea class="form-control" id="sqaFocusArea" name="sqaFocusArea" rows="4" 
                                                             required></textarea>
                                               </div>
                                           </div>

                                           <!-- Escalation Method -->
                                           <div class="row mb-3">
                                               <label class="col-sm-5 text-end"><%=MyBase.GetResourceString("C_EscM")%></label>
                                               <div class="col-sm-6">
                                                   <textarea class="form-control" id="escalationMethod" name="escalationMethod" rows="3"></textarea>
                                               </div>
                                           </div>

                                           <!-- Deviation To Standard Process -->
                                           <div class="row mb-3">
                                               <label class="col-sm-5 text-end"><%=MyBase.GetResourceString("C_DevProc")%></label>
                                               <div class="col-sm-6">
                                                   <textarea class="form-control" id="deviationToStandardProcess" name="deviationToStandardProcess" rows="3"></textarea>
                                               </div>
                                           </div>

                                           <!-- Reporting Method/Frequency -->
                                           <div class="row mb-3">
                                               <label class="col-sm-5 text-end"><%=MyBase.GetResourceString("C_ReMeth")%></label>
                                               <div class="col-sm-6">
                                                   <textarea class="form-control" id="reportingMethodOrFrequency" name="reportingMethodOrFrequency" rows="3"></textarea>
                                               </div>
                                           </div>

                                           <!-- Date on which Plan was Reviewed -->
                                           <div class="row mb-3">
                                               <label class="col-sm-5 text-end"><%=MyBase.GetResourceString("C_DateRevi")%></label>
                                               <div class="col-sm-6">
                                                   <div class="input-group">
                                                       <input type="text" class="form-control" id="reviewDate" name="reviewDate" 
                                                              readonly>
                                                       <button class="btn btncalendar" type="button" id="reviewDateBtn"><i class="fas fa-calendar-alt"></i></button>
                                                   </div>
                                               </div>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                           </div>
                       </div>


     <!-- SQA Plan History Modal -->
   <div class="modal fade" id="SQAPlanHistoryModal" tabindex="-1" aria-labelledby="SQAPlanHistoryModalLabel" aria-hidden="true">
       <div class="modal-dialog modal-xl">
           <div class="modal-content">
             
               <div class="modal-body">
                   <!-- Show History Details Panel start here -->
                   <div class="ShowHisDetailpanel mb-4" id="showhisID">
                           <hr />
                           <div class="BkPlanHistory">
                               <ul class="nav nav-tabs detailsubtabs mt-4">
                                   <li class="nav-item">
                                       <a class="nav-link active" href="#SQAPlanHisTab" data-bs-toggle="tab" id=""><%= MyBase.GetResourceString("C_History")%></a>
                                   </li>
                               </ul>
                               <div class="tab-content">
                                   <!-- History Tab -->
                                   <div id="SQAPlanHisTab" class="tab-pane active mt-2">
                                       <div class="container-fluid">
                                           <div class="form-inline hstryfltr pb-1">
                                               <div class="row">
                                                   <div class="col-sm-6">
                                                       &nbsp;
                                                   </div>
                                                   <div class="col-sm-6">
                                                       <div class="d-flex justify-content-end gap-2 pe-2">
                                                           <a href="javascript:;" class="btn borderbtn cancelEdtDetpanel" id="CancelBtn" data-bs-toggle="tooltip" title="Cancel"><%= MyBase.GetResourceString("C_Clc")%></a>
                                                       </div>
                                                   </div>
                                               </div>
                                               <div class="row d-flex justify-content-center mt-3">
                                                   <div class="col-sm-5">
                                                       <div class="row form-group">
                                                           <div class="col-sm-6 d-flex justify-content-end">
                                                               <label><%= MyBase.GetResourceString("C_MField")%></label>
                                                           </div>
                                                           <div class="col-sm-6">

 <select id="modifiedFieldDropdown" class="selectpicker" data-live-search="true" onchange="FilterHistoryTab();">
        <!-- Options will be populated dynamically -->
    </select>

                                                           </div>
                                                       </div>
                                                   </div>
                                                   <div class="col-sm-5">
                                                       <div class="row form-group">
                                                           <div class="col-sm-6 d-flex justify-content-end">
                                                               <label><%= MyBase.GetResourceString("C_MBy")%></label>
                                                           </div>
                                                           <div class="col-sm-6">
                                                               <select id="modifiedByDropdown" class="selectpicker" data-live-search="true" onchange="FilterHistoryTab();">
        <!-- Options will be populated dynamically -->
    </select>                                                       
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>
                                           </div>
           
                                           <div class="table-responsive">
                                               <table id="SQAPlanShowHisTable" class="table table-stripped" style="width:100%;">
                                                   <thead>
                                                       <tr>
                                                           <th class="col-sm-3"><%= MyBase.GetResourceString("C_MField")%></th>
                                                           <th class="col-sm-2"><%= MyBase.GetResourceString("C_OldValue")%></th>
                                                           <th class="col-sm-2"><%= MyBase.GetResourceString("C_NewValue")%></th>
                                                           <th class="col-sm-2"><%= MyBase.GetResourceString("C_MDate")%></th>
                                                           <th class="col-sm-2"><%= MyBase.GetResourceString("C_MBy")%></th>
                                                       </tr>
                                                   </thead>
                                                   <tbody id="hisBody">
                                                     
                                                   </tbody>
                                               </table>
                                           </div>
                                           <br />
                                       </div>
           
                                       <div class="clearfix"></div>
                                   </div>
                               </div>
                           </div>
                   </div>
                   <!-- Show History Details Panel end here -->
               </div>
              
           </div>
       </div>
   </div>
                   </div>
               </div>
           </section>
       </div>
        </div>

   <!-- REQUIRED JS SCRIPTS -->
   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
   <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
   <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
   <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
   <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>

   <script>
       // Global variables - same as Training Plan
       var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';
       var LoginType = '<%= Session("LoginType") %>';
       var UserId = '<%= Session("intUserID") %>';
       var UserName = '<%= Session("strUserName") %>';
       var defaultProjectID = <%= Session("intProjectID")%>;
       var AjaxResult = null;
       var IsHisPresent;

       var specialCharactersList = '<%= System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString %>';

       function hasInvalidChars(text) {
          // debugger
           if (!text || !specialCharactersList) return false;
           for (var i = 0; i < text.length; i++) {
               if (specialCharactersList.includes(text.charAt(i))) {
                   return true;
               }
           }
           return false;
       }

  

       // AJAX call function - same as Training Plan
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
                       alertify.notify('Authentication Failed', 'error', 5);
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

       $(document).ready(function () {
         //  debugger
           // Initialize tooltips
           $('[data-bs-toggle="tooltip"]').tooltip();
           
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
           $('#reviewDate').datepicker({
               autoclose: true,
               changeMonth: true,
               changeYear: true,
               yearRange: "2005:2035",
               dateFormat: 'dd M yy',
               showOn: 'none'
           });
           
           // Calendar button click event
           $('#reviewDateBtn').click(function() {
               $('#reviewDate').datepicker('show');
           });
           
           // Initialize ProjectFilter selectpicker
           $('#ProjectFilter').selectpicker({
               title: 'Select Project',
               noneSelectedText: 'Select Project'
           });

           // Load projects for SQA Plan dropdown
           loadProjectsForSQAPlan();
           
           // Set default project ID in ProjectFilter dropdown
           if (defaultProjectID && defaultProjectID > 0) {
               // Wait for selectpicker to initialize, then set the value
               setTimeout(function() {
                   $('#ProjectFilter').val(defaultProjectID);
                   $('#ProjectFilter').selectpicker('refresh');
                   // Call getSqlPlan with the project ID on page load
                   getSqlPlan(defaultProjectID);
      
                   gethistoryFlag();
         }, 500);
           }

           // Handle project selection change
           $('#ProjectFilter').on('change', function() {
               var selectedProjectId = $(this).val();
               if (selectedProjectId) {
                   getSqlPlan(selectedProjectId);
      
                   gethistoryFlag();         } else {
                   // Clear form when no project is selected
                   $('#sqaFocusArea').val('');
                   $('#escalationMethod').val('');
                   $('#deviationToStandard').val('');
                   $('#reportingMethod').val('');
                   $('#reviewDate').val('');
               }
           });

    

           $('#CancelBtn').on('click', function () {
               $('#SQAPlanHistoryModal').modal('hide');
           });


            });

       // Show History Tab function
       // Show History Tab function
       function ShowHistoryTab() {
           try {
              // debugger;

               // Get selected project ID
               var projectID = $('#ProjectFilter').val();
               if (!projectID) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("C_PlzSelProje")%>');
                   return;
               }

               // -----------------------------
               // Load Modified Field dropdown
               // -----------------------------
               var fieldParam = { ProjectID: parseInt(projectID) || null };
               var fieldUrl = "api/SQAPlan/GetModifiedFieldSQAPlan";
               var fieldResult = AJAXCallWithResult(fieldUrl, JSON.stringify(fieldParam), false);

               if (fieldResult && fieldResult.data && Array.isArray(fieldResult.data.SQAPlanModifieldFied)) {
                   var fieldDropdown = $('#modifiedFieldDropdown');
                   fieldDropdown.empty();
                   fieldResult.data.SQAPlanModifieldFied.forEach(function (item) {
                       fieldDropdown.append('<option value="' + item.modifiedField + '">' + item.modifiedField + '</option>');
                   });
                   fieldDropdown.selectpicker('refresh');
               }

               // -----------------------------
               // Load Modified By dropdown
               // -----------------------------
               var byParam = { ProjectID: parseInt(projectID) || null };
               var byUrl = "api/SQAPlan/GetModifiedBySQAPlan";
               var byResult = AJAXCallWithResult(byUrl, JSON.stringify(byParam), false);

               if (byResult && byResult.data && Array.isArray(byResult.data.SQAPlanModifiedBy)) {
                   var byDropdown = $('#modifiedByDropdown');
                   byDropdown.empty();
                   byResult.data.SQAPlanModifiedBy.forEach(function (item) {
                       byDropdown.append('<option value="' + item.modifiedBy + '">' + item.modifiedBy + '</option>');
                   });
                   byDropdown.selectpicker('refresh');
               }

               var modifiedField = $('#modifiedFieldDropdown').val();
               var modifiedBy = $('#modifiedByDropdown').val();

               // Call GetSQAPlanHistory API
               var param = JSON.stringify({
                   projectID: parseInt(projectID) || null,
                   ModifiedField: modifiedField,
                   ModifiedBy: modifiedBy
               });

               var url = "api/SQAPlan/GetSQAPlanHistory";
               var result = AJAXCallWithResult(url, param, false);

               // Clear existing table data
               var hisBody = $('#hisBody');
               hisBody.empty();

               if (result && result.data && Array.isArray(result.data.SQAPlanHistory) && result.data.SQAPlanHistory.length > 0) {
                   result.data.SQAPlanHistory.forEach(function (item) {
                       var row = '<tr>' +
                           '<td>' + (item.modifiedField || '') + '</td>' +
                           '<td>' + (item.oldValue || '') + '</td>' +
                           '<td>' + (item.newValue || '') + '</td>' +
                           '<td>' + (item.modifiedDate ? formatDate(item.modifiedDate) : '') + '</td>' +
                           '<td>' + (item.modifiedBy || '') + '</td>' +
                           '</tr>';
                       hisBody.append(row);
                   });
               } else {
                   // Show "No data available" message
                   var noDataRow = '<tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoHist")%></td></tr>';
                   hisBody.html(noDataRow);
               }

               // Refresh selectpicker if any filters are used
               $('.selectpicker').selectpicker('refresh');

               // Show the modal
               $('#SQAPlanHistoryModal').modal('show');

           } catch (error) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(error.message);
           }
       }

       if (result.data.SQAPlanHistory.length > 0) {
           result.data.SQAPlanHistory.forEach(function (item) {
               var row = '<tr>' +
                   '<td>' + (item.modifiedField || '') + '</td>' +
                   '<td>' + (item.oldValue || '') + '</td>' +
                   '<td>' + (item.newValue || '') + '</td>' +
                   '<td>' + (item.modifiedDate ? formatDate(item.modifiedDate) : '') + '</td>' +
                   '<td>' + (item.modifiedBy || '') + '</td>' +
                   '</tr>';

               $('#hisBody').append(row);
           });
       }

       // Helper function to format date
       function formatDate(dateString) {
           var date = new Date(dateString);
           if (isNaN(date)) return ''; // fallback if invalid date

           var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
               "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

           var month = months[date.getMonth()]; // getMonth() is 0-indexed
           var day = date.getDate();
           var year = date.getFullYear();

           return `${month} ${day}, ${year}`;
       }

     
       // Show History Tab function
       function FilterHistoryTab() {
         //  debugger;
           try {
               // Get selected project ID
               var projectID = $('#ProjectFilter').val();
               if (!projectID) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("C_PlzSelProje")%>');
            return;
        }

        var modifiedField = $('#modifiedFieldDropdown').val();
        var modifiedBy = $('#modifiedByDropdown').val();

        // Call GetSQAPlanHistory API
        var param = {
            projectID: parseInt(projectID) || null,
            ModifiedField: modifiedField,
            ModifiedBy: modifiedBy
        };

        param = JSON.stringify(param);
        var url = "api/SQAPlan/GetSQAPlanHistory";

        var result = AJAXCallWithResult(url, param, false);

        if (result && result.data && Array.isArray(result.data.SQAPlanHistory)) {
            // Clear existing table data
            $('#hisBody').empty();

            if (result.data.SQAPlanHistory.length > 0) {
                result.data.SQAPlanHistory.forEach(function (item) {
                    var row = '<tr>' +
                        '<td>' + (item.modifiedField || '') + '</td>' +
                        '<td>' + (item.oldValue || '') + '</td>' +
                        '<td>' + (item.newValue || '') + '</td>' +
                        '<td>' + (item.modifiedDate ? formatDate(item.modifiedDate) : '') + '</td>' +
                        '<td>' + (item.modifiedBy || '') + '</td>' +
                        '</tr>';

                    $('#hisBody').append(row);
                });
            } else {
                // Show "No data available" message
                var noDataRow = '<tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoHist")%></td></tr>';
                $('#hisBody').html(noDataRow);
            }

            // Refresh selectpicker if any filters are used
            $('.selectpicker').selectpicker('refresh');

            // Show the modal
            $('#SQAPlanHistoryModal').modal('show');
        } else {
            // Clear table and show no data message
            $('#hisBody').empty();
                   var noDataRow = '<tr><td colspan="5" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoHist")%></td></tr>';
                   $('#hisBody').html(noDataRow);

                   $('.selectpicker').selectpicker('refresh');
                   $('#SQAPlanHistoryModal').modal('show');
               }

           } catch (error) {
               console.log('Error loading SQA Plan history:', error);
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(error.message);
           }
       }


       // Save SQA Plan function
       function saveSQAPlan() {
          // debugger
          
               // Validate mandatory fields


               // Validate mandatory fields
               var isValid = true;
               var errorMessage = '';

               var sqaFocusArea = $('#sqaFocusArea').val();
               // Check mandatory fields
               if (!sqaFocusArea) {
                   errorMessage += '<%=MyBase.GetResourceString("A_SqaFocus")%>.<br>';
                   isValid = false;
               }

               if (sqaFocusArea && sqaFocusArea.trim() !== "" && hasInvalidChars(sqaFocusArea.trim())) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("A_SqaInvalidChar")%>');
                   return false;
               }

               var escalationMethod = $('#escalationMethod').val();
               if (escalationMethod && escalationMethod.trim() !== "" && hasInvalidChars(escalationMethod.trim())) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("A_EscInvalidChar")%>');
                   return false;
               }

               var deviationToStandard = $('#deviationToStandard').val();
               if (deviationToStandard && deviationToStandard.trim() !== "" && hasInvalidChars(deviationToStandard.trim())) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("A_DeviInvalidChar")%>');
                   return false;
               }

               var reportingMethod = $('#reportingMethod').val();
               if (reportingMethod && reportingMethod.trim() !== "" && hasInvalidChars(reportingMethod.trim())) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("A_ReMethInChar")%>');
                   return false;
               }

               if (!isValid) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<span style="font-size:14px;">' + errorMessage + '</span>');
                   return false;
               }

               if (!$('#ProjectFilter').val()) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("C_PlzSelProje")%>');
                   return;
               }


       

               var reviewDate = $('#reviewDate').val();
           var formattedReviewDate = null;

               if (reviewDate) {
                   try {
                       var months = {
                           'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
                           'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08',
                           'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
                       };

                       // Split by either space or hyphen to handle both formats
                       var parts = reviewDate.split(/[\s-]/); // ["02", "Oct", "2025"] or ["08", "Oct", "2025"]

                       if (parts.length === 3) {
                           var day = parts[0].padStart(2, '0');
                           var month = months[parts[1]];
                           var year = parts[2];

                           if (month) { // only if month is valid
                               formattedReviewDate = `${year}-${month}-${day}T00:00:00`; // ISO 8601
                           } else {
                               formattedReviewDate = null; // fallback if month not found
                           }
                       } else {
                           formattedReviewDate = null; // fallback if format unexpected
                       }
                   } catch (e) {
                       formattedReviewDate = null; // fallback if any error
                   }
               }


               // Wrap the payload inside "dto"
               var sqaData = {
              
                       ProjectID: parseInt($('#ProjectFilter').val()) || null,
                       SQAFocusArea: $('#sqaFocusArea').val(),
                       EscalationMethod: $('#escalationMethod').val(),
                       DeviationToStandardProcess: $('#deviationToStandardProcess').val(),
                       ReportingMethodOrFrequency: $('#reportingMethodOrFrequency').val(),
                       PlanReviewedDate: formattedReviewDate,
                       CreatedBy: UserName
              
               };

               var param = JSON.stringify(sqaData);
               var url = "api/SQAPlan/PutSQAPlan";
               var result = AJAXCallWithResult(url, param, false);


               // Check API response
               if (
                   result &&
                   result.data &&
                   result.data.ResultModelSQAPlan &&
                   result.data.ResultModelSQAPlan.length > 0
               ) {
                   var updateResult = result.data.ResultModelSQAPlan[0];
                   if (updateResult.result === "Updated") {
                       alertify.set('notifier', 'position', 'top-right');
                       alertify.success('<%=MyBase.GetResourceString("A_SqaSave")%>');

                   } else {
                       alertify.set('notifier', 'position', 'top-right');
                       alertify.error('<%=MyBase.GetResourceString("A_Savefail")%>');
                   }
               } else {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error('<%=MyBase.GetResourceString("A_Savefail")%>');
               }
          
       
           gethistoryFlag();
       }

   


       function gethistoryFlag() {
          // debugger
           // Get selected project ID
           var projectID = $('#ProjectFilter').val();
           if (!projectID) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error('<%=MyBase.GetResourceString("C_PlzSelProje")%>');
               return;
           }

           // Call GetSQAPlanHistory API
           var param = {
               projectID: parseInt(projectID) || null

           };

           param = JSON.stringify(param);
           var url = "api/SQAPlan/GetSQAPlanHistory";

           var result = AJAXCallWithResult(url, param, false);

           if (result &&
               result.data &&
               Array.isArray(result.data.SQAPlanHistory) &&
               result.data.SQAPlanHistory.length > 0) {
               // Clear existing table data
               IsHisPresent = 1;
               $('#BkPlansShowHisBtn').show();

           }
           else {
               IsHisPresent = 0;
               $('#BkPlansShowHisBtn').hide();

           }

       }// Validate SQA Plan form
    

      
       // Show loader
       function showLoader() {
           $('#loaderOverlay').show();
       }

       // Hide loader
       function hideLoader() {
           $('#loaderOverlay').hide();
       }

       // Search functionality
       var searchTimeout;
       function handleSearchInput() {
           // Clear the previous timeout
           clearTimeout(searchTimeout);
           
           // Set a new timeout to perform search after 500ms of no typing
           searchTimeout = setTimeout(function() {
               // Add search logic here if needed
               console.log('Search performed:', $('#searchInput').val());
           }, 500); // 500ms delay
       }

       // Clear all filters
       function clearAllFilters() {
           $('#searchInput').val('');
           $('#ProjectFilter').val('');
           $('#ProjectFilter').selectpicker('refresh');
           $('#ClearAllFilter').hide();
       }

       // Load projects for SQA Plan dropdown - same as Training Plan
       function loadProjectsForSQAPlan() {
           try {
               // Call the GetProjectsForTrainingPlan API (same API as Training Plan)
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
                       
                   } else {
                       // If no data or API fails, still show the dropdown with default option
                       console.log('No project data available or API call failed');
                   }
                   
                   // Always refresh the selectpicker, even if no data
                   $(projectDropdown).selectpicker('refresh');
               }
               
           } catch (error) {
               // Error loading projects - still show dropdown with default option
               console.error('Error loading projects:', error);
               
               // Ensure dropdown is still functional even if API fails
               var projectDropdown = document.getElementById('ProjectFilter');
               if (projectDropdown) {
                   projectDropdown.innerHTML = '';
                   var defaultOption = document.createElement('option');
                   defaultOption.value = '';
                   defaultOption.textContent = 'Select Project';
                   projectDropdown.appendChild(defaultOption);
                   $(projectDropdown).selectpicker('refresh');
               }
           }
       }

       function getSqlPlan(projectID) {
          // debugger
           try {
               // Call the GetSQAPlan API
               var param = {
                   projectID: parseInt(projectID) || null
               };

               param = JSON.stringify(param);

               var url = "api/SQAPlan/GetSQAPlan";
               var result = AJAXCallWithResult(url, param, false);

               if (
                   result &&
                   result.data &&
                   result.data.SQAPlanModel &&
                   Array.isArray(result.data.SQAPlanModel) &&
                   result.data.SQAPlanModel.length > 0
               ) {
                   var sqaPlanData = result.data.SQAPlanModel[0]; // Get the first record

                   // Format date from "2025-10-02T00:00:00" to "02-Oct-2025"
                   var formattedDate = '';
                   if (sqaPlanData.planReviewedDate) {
                       var date = new Date(sqaPlanData.planReviewedDate);
                       var day = String(date.getDate()).padStart(2, '0');
                       var months = [
                           'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                       ];
                       var month = months[date.getMonth()];
                       var year = date.getFullYear();
                       formattedDate = day + '-' + month + '-' + year;
                   }

                   // Bind data to correct text areas
                   $('#sqaFocusArea').val(sqaPlanData.sqaFocusArea || '');
                   $('#escalationMethod').val(sqaPlanData.escalationMethod || '');
                   $('#deviationToStandardProcess').val(sqaPlanData.deviationToStandardProcess || '');
                   $('#reportingMethodOrFrequency').val(sqaPlanData.reportingMethodOrFrequency || '');
                   $('#reviewDate').val(formattedDate);

               } else {
                   // Clear form if no data found
                   $('#sqaFocusArea').val('');
                   $('#escalationMethod').val('');
                   $('#deviationToStandardProcess').val('');
                   $('#reportingMethodOrFrequency').val('');
                   $('#reviewDate').val('');

               }
           } catch (error) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(error.message);
           }
       }

   </script>
    <!-- JavaScript syntax fixed -->
     <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
</body>


</html>