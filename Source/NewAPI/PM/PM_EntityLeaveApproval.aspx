<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityLeaveApproval.aspx.vb" Inherits="Whizible.PM_EntityLeaveApproval" %>
<!DOCTYPE html>
<html>
    <head runat="server">
  <%CommonFunctions.General.PlotPageHeadTag("Entity Approval")%>
 <meta charset="utf-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <title><%= MyBase.GetResourceString("C_PageName") %></title>
 <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/PM_EntityApproval.css"> 

     <!-- Same loader as PM_EntityProjectApproval / Project Profitability - Added By Vyankat B. on 17th March 2026 -->
        <style>
        #pageLoader.loader-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100%;
            height: 100%;
            background-color: transparent;
            z-index: 2000;
        }
        #pageLoader.loader-overlay .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
        
    /* Pagination styling - Added to match PM_Documents.aspx - Vaibhav K */
    .pagination-container { background: white; display: flex !important; justify-content: flex-end; align-items: center; gap: 1rem; margin-top: 0; position: fixed; bottom: 0; left: 0; right: 0; z-index: 1000; }
    .pagination-info { color: #333; font-size: 14px; font-weight: 300; }
    .pagination { margin-bottom: 20px !important; margin-top: 20px !important; }
    .pagination .page-item { margin: 0 2px; }
    .pagination .page-link { padding: 8px 12px; color: #1359a6; background-color: #fff; border: 1px solid #dee2e6; border-radius: 4px; text-decoration: none; transition: all 0.3s ease; }
    .pagination .page-link:hover { color: #fff; background-color: #1359a6; border-color: #1359a6; }
    .pagination .page-item.fa-disabled .page-link { color: #6c757d; background-color: #f8f9fa; border-color: #dee2e6; cursor: not-allowed; pointer-events: none; }
    .pagination .page-item.fa-disabled .page-link:hover { color: #6c757d; background-color: #f8f9fa; border-color: #dee2e6; }
    /* pointer-events:none on the <a> stops cursor from showing on the link itself,
       so we set cursor on the <li> directly — this is what shows the block symbol */
    li#btnprevious.page-item.fa-disabled { cursor: not-allowed; }
    li#btnnext.page-item.fa-disabled     { cursor: not-allowed; }
    .content.mb-10 { padding-bottom: 80px; }
</style>
</head>

<body class="hold-transition bgwhite px-2 page-loading" id="Body">
    <%-- Commented and Added By Vyankat B. on 17th March for showing the correct loader --%>

   <%-- <!-- Added by Dipali V on 07-Oct-2025 (W26): Page loader -->
    <div id="pageLoaderEntity">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden"><%= MyBase.GetResourceString("C_Loading") %>...</span>
        </div>
        <div class="loading-text"><%= MyBase.GetResourceString("C_LoadingPWF") %>...</div>--%>


    <div id="pageLoaderEntity" class="loader-overlay">
        <div class="loader"></div>
    </div>

<%-- End of changes by Vyankat B. on 17th March for showing the correct loader --%>

    <!-- Main content wrapper with fade-in effect -->
    <div class="main-content-wrapper">
      <!-- Leaves Entity Start here -->
 
      <div id="LeavesEntity" class="allEntity col-sm-12">
          <%-- Modified by Dipali V on 2nd Dec 2025 - Added entity-table class and adjusted column widths for consistency --%>
          <table id="LeavesTbl" class="table tbl_wrkflow_approval entity-table" style="width: 100%;">
              <thead class="stickyTblHeader">
                  <tr>
                      <%-- Updated by Dipali V on 18th Dec 2025 - Reduced Employee Name width to reduce space between columns --%>
                      <th style="width:140px;"><%= MyBase.GetResourceString("C_Ename") %></th>
                      <%-- Updated by Dipali V on 18th Dec 2025 - Increased From Date and To Date width further --%>
                      <th style="width:100px;"><%= MyBase.GetResourceString("C_FromDate") %></th>
                      <th style="width:100px;"><%= MyBase.GetResourceString("C_ToDate") %></th>
                      <%-- Added by Dipali V on 2nd Dec 2025 - Added Days column --%>
                      <%-- Updated by Dipali V on 18th Dec 2025 - Reduced Days column width and padding to minimize space before Leave Type --%>
                      <th style="width:45px;">Days</th>
                      <th style="width:140px;"><%= MyBase.GetResourceString("C_LeaveType") %></th>
                      <%-- Added by Dipali V on 2nd Dec 2025 - Added Reason column --%>
                      <th style="width:110px;">Reason</th>
                      <th style="width:85px;"><%= MyBase.GetResourceString("CStatusIR ") %></th>
                      <th style="width:75px;"><%= MyBase.GetResourceString("C_Action") %></th>
                  </tr>
              </thead>
              <tbody>
                  
              </tbody>
          </table>
      </div>
      <!-- Pagination - Added to match PM_Documents.aspx - Vaibhav K -->
      <div class="pagination-container">
          <div class="pagination-info" id="paginationInfo">
              <span class="spntotal">Total Records:</span>
              <span class="spntotal" id="totalRecords">0</span>
          </div>
          <nav aria-label="Page navigation">
              <ul class="pagination justify-content-end">
                  <li class="page-item" id="btnprevious">
                      <a class="page-link" aria-label="<%=MyBase.GetResourceString("C_Previous")%>" onclick="goToPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" id="LinkPrevious">
                          <i class="fas fa-angle-double-left"></i>
                      </a>
                  </li>
                  <li class="page-item" id="btnnext">
                      <a class="page-link" aria-label="<%=MyBase.GetResourceString("C_Next")%>" onclick="goToNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" id="LinkNext">
                          <i class="fas fa-angle-double-right"></i>
                      </a>
                  </li>
              </ul>
          </nav>
      </div>
      <!-- End Pagination -->

  <!-- Leaves Entity End here -->
     <!-- Leave information offcanvas Section Start Here-->
  <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="LeaveDetailsOffcanvas">
      <div class="offcanvas-body">
          <div id="LeaveInfoSec" class="ProjInfoDetails">
              <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                  <div class="d-flex align-items-center justify-content-between">
                      <h5 class="pgtitle mb-0">
                          <%= MyBase.GetResourceString("C_LeaveHeader") %>
                      </h5>
                      <button type="button"
                              class="btn btn-sm btn-danger-modern"
                              data-bs-toggle="tooltip"
                              title="Close"
                              data-bs-dismiss="offcanvas">
                          <i class="fas fa-times"></i>
                      </button>
                  </div>
              </div>
              <div class="row mt-2 mb-2 project_timeperiod">
                  <div class="col-sm-2">
                  </div>
                  <div class="col-sm-10 d-flex gap-3 justify-content-end" id="Actionlinks_Leave">
                      <a href="javascript:;" onclick="callIframeFunction('ApproveRejectLeave', 'A', 'EditView', 0)"  id="btnLeaveApproved"><%= MyBase.GetResourceString("C_Approve") %></a>
                      <a href="javascript:;" onclick="callIframeFunction('ApproveRejectLeave', 'R', 'EditView', 0)" id="btnLeaveRejected"><%= MyBase.GetResourceString("C_LeaveReject")%></a>
                      <%--<button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                          data-bs-dismiss="offcanvas">
                         <%= MyBase.GetResourceString("C_Close") %> 
                      </button>--%>
                  </div>
              </div>
              <div class="LeaveDetailsContent text-end">
                  <div class="accordion WF_TopAccordianPanel mb-3 mt-3 " id="LeaveDetailsAcc">
                      <!-- Leave Details Section Start -->
                      <div class="accordion-item mb-3">
                          <h2 class="accordion-header" id="LeaveDetailsHeading">
                              <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                  data-bs-target="#LeaveDetailsTab" aria-expanded="true" aria-controls="LeaveDetailsTab">
                                    <i class="fas fa-info-circle me-2 leave-details-accordion-icon"></i><%= MyBase.GetResourceString("C_LeaveDetails") %> 
                              </button>
                          </h2>

                          <div id="LeaveDetailsTab" class="accordion-collapse collapse show"
                              aria-labelledby="LeaveDetailsHeading">
                              <div class="accordion-body">
                                  <div class="LeaveContent">
                                      <div class="LeaveFields">
                                          <div class="row form-group">
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_RType") %> : </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span></span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_Ename") %>: </label>
                                                      </div>
                                                      <div class="col-sm-7 text-start">
                                                          <span></span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_FromDate") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span><i class="far fa-calendar-check iconBlue pe-1"></i>
                                                              </span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_ToDate") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span><i class="far fa-calendar-check iconBlue pe-1"></i>
                                                              </span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_LeaveType") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span><i class="fas fa-rss textOrange pe-1"></i>
                                                          </span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_LeaveBalance") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span class="leave-balance-value" style="margin-right: 8px; font-weight: 500;"></span>
                                                          <div role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                              aria-valuemax="100" style="display: inline-block;">
                                                          </div>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_FirstHalfDay") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span></span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_SecondHalfDay") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span></span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <%-- Added by Dipali V on 18th Dec 2025 - Full Day field --%>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_FullDay") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span></span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_Address") %>: </label>
                                                      </div>
                                                      <div class="col-sm-8 text-start">
                                                          <span><i
                                                              class="fas fa-map-marker-alt iconBlue pe-1"></i></span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_Reason") %>: </label>
                                                      </div>
                                                      <div class="col-sm-8 text-start">
                                                          <span></span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_Telephone") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span><i class="fas fa-phone-volume iconBlue pe-1"></i>
                                                              </span>
                                                      </div>
                                                  </div>
                                              </div>
                                              <div class="col-sm-6 mb-3">
                                                  <div class="row">
                                                      <div class="col-sm-4">
                                                          <label><%= MyBase.GetResourceString("C_AppliedOn") %>: </label>
                                                      </div>
                                                      <div class="col-sm-6 text-start">
                                                          <span><i class="far fa-calendar-check iconBlue pe-1"></i></span>
                                                      </div>
                                                  </div>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                      <!-- Resource Allocation Details Section Start - Added by Dipali V on 18th Dec 2025 -->
                      <!-- Updated by Dipali V on 18th Dec 2025 - Open by default like other details sections -->
                      <div class="accordion-item mb-3">
                          <h2 class="accordion-header" id="ResourceAllocationHeading">
                              <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                  data-bs-target="#ResourceAllocationTab" aria-expanded="true" aria-controls="ResourceAllocationTab">
                                  <i class="fas fa-users me-2"></i> Resource Allocation Details
                              </button>
                          </h2>
                          <div id="ResourceAllocationTab" class="accordion-collapse collapse show"
                              aria-labelledby="ResourceAllocationHeading">
                              <div class="accordion-body">
                                  <div class="table-responsive">
                                      <table id="tblResourceAllocation" class="table table-bordered table-hover" style="width: 100%;">
                                          <thead>
                                              <tr>
                                                  <th style="width: 30%;">Project Name</th>
                                                  <th style="width: 20%;">Start Date</th>
                                                  <th style="width: 20%;">End Date</th>
                                                  <th style="width: 15%;" class="text-center">Allocation %</th>
                                                  <th style="width: 15%;">Approver Name</th>
                                              </tr>
                                          </thead>
                                          <tbody>
                                              <tr>
                                                  <td colspan="5" class="text-center">Loading allocation details...</td>
                                              </tr>
                                          </tbody>
                                      </table>
                                  </div>
                                  <!-- RA Pagination — inline styles so they work when offcanvas is rendered in parent window -->
                                  <div id="ra-pagination-container" style="display:flex;justify-content:flex-end;align-items:center;gap:1rem;padding:8px 4px 4px;">
                                      <div id="ra-pagination-info" style="color:#333;font-size:14px;font-weight:300;">
                                          <span>Total Records:</span>
                                          <span id="raTotalRecords">0</span>
                                      </div>
                                      <nav aria-label="Resource Allocation Page navigation">
                                          <ul style="display:flex;list-style:none;margin:0;padding:0;gap:4px;">
                                              <li id="raBtnPrev" style="cursor:not-allowed;">
                                                  <a id="raLinkPrev" aria-label="Previous" title="Previous Page"
                                                     style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">
                                                      <i class="fas fa-angle-double-left"></i>
                                                  </a>
                                              </li>
                                              <li id="raBtnNext" style="cursor:not-allowed;">
                                                  <a id="raLinkNext" aria-label="Next" title="Next Page"
                                                     style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">
                                                      <i class="fas fa-angle-double-right"></i>
                                                  </a>
                                              </li>
                                          </ul>
                                      </nav>
                                  </div>
                                  <!-- End RA Pagination -->
                              </div>
                          </div>
                      </div>
                      <!-- Resource Allocation Details Section End -->
                      <!-- Leave Details Section End -->
                  </div>
              </div>
          </div>
      </div>
  </div>
  <!-- Leave Information offcanvas Section End Here-->

        <div class="clearfix"></div>

      
    </div>
    <!-- Close main-content-wrapper -->


      <script>

          var IsChecklistMandatory = false;
          var GLeaveStatusID = 0;
          var GWhichAction = '';
          var CTagID = 1209;
          var CUniqueID = 0;
          var strAlertType = 'T';
          var GFromWhere = "";
          var bilCurrencyCode = "";
          var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
          var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
          var EditAccess = "<%= m_EditAccess %>";
          $(document).ready(function () {

              // Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner
              // StartLoader("#Body")
              // End of Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner

           
              $(".change_filter").hide();
              $("#search_pro").show();
              strAlertType = getQueryParam("FilterIW");
              load(strAlertType);
              //datepicker
            

              $("span.INRCurncy").append('<i class="fas fa-rupee-sign iconBlue"></i>');
              $("span.USDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
              $("span.SGDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
              $("span.EURCurncy").append('<i class="fas fa-euro-sign iconBlue"></i>');
              $("span.NZDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
              $("span.GBPCurncy").append('<i class="fas fa-pound-sign iconBlue"></i>')
              $("#txtLeaveResourceName").val('');
             
          });

          // For Get Parameter which gets from Parent Page
          function getQueryParam(name) {
              const urlParams = new URLSearchParams(window.location.search);
              return urlParams.get(name);
          }

          // For Filter Section
          function readTopFilters() {
              // Helper: read from query string if exists
             
              // Try reading from query string first (iframe pages)
              let bu = getQueryParam("BusinessUnit");
              let ou = getQueryParam("OrganizationUnit");
              let pf = getQueryParam("PendingFrom");
              let entityName = getQueryParam("EntityName");
             
              // If not available in query string (main page), read from filter panel
              if (!bu && $('#filterpanel .condt-filter select').length > 0) {
                  bu = $('#filterpanel .condt-filter select').eq(0).val();
                  ou = $('#filterpanel .condt-filter select').eq(1).val();
                  pf = $('#filterpanel .condt-filter select').eq(2).val();
              }

              // Convert valid numeric fields to int or default to '0'
              function normalize(v) {
                  return (v !== undefined && v !== null && v !== '' && !isNaN(v)) ? v : '0';
              }

              // Return a consistent filter object
              return {
                  BusinessUnit: normalize(bu),
                  OrganizationUnit: normalize(ou),
                  PendingFrom: normalize(pf),
                  EntityName: entityName || ''
              };
          }
          $('table').resize();

          $(".collapse").on('show.bs.collapse', function (e) {
              $(".table").resize();
          });
          $(".collapse").on('hidden.bs.collapse', function (e) {
              $(".table").resize();
          });

          $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
              $(".table").resize();
          });


          // Added by Dipali V on 2nd Dec 2025 - Store data for Leave Status filter (Leave specific only)
          // Note: ResourceName uses generic EntityName (strEntityName) - server-side
          // LeaveStatus is specific to Leave tab only - client-side filter
          var allLeaveData = [];
          
          // For Load function
          function load(alertType) {
             // debugger;
              try {
                  var resp = fetchEntityDataForTag(alertType, CTagID);
                  const rows = Array.isArray(resp) ? resp : (resp && resp.Table) ? resp.Table : resp || [];
                  allLeaveData = rows; // Store for Resource Name filtering
                  applyResourceNameFilter(); // Apply Resource Name filter


                  // Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner
                  //StopAjaxLoader('#Body');
                  // End of Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner

              } finally {
                  // Initialize tooltips - Updated by Dipali V on 18th Dec 2025 - Dispose existing tooltips first to avoid duplicates
                  var tooltipElements = document.querySelectorAll('[data-bs-toggle="tooltip"]');
                  tooltipElements.forEach(function(el) {
                      var tooltipInstance = bootstrap.Tooltip.getInstance(el);
                      if (tooltipInstance) {
                          tooltipInstance.dispose();
                      }
                  });
                  // Initialize tooltips with Bootstrap 5
                  var tooltipTriggerList = [].slice.call(tooltipElements);
                  tooltipTriggerList.map(function (tooltipTriggerEl) {
                      return new bootstrap.Tooltip(tooltipTriggerEl, {
                          delay: { "show": 100, "hide": 100 }
                      });
                  });
              }
          }
          
          // Added by Dipali V on 2nd Dec 2025 - Resource Name filter for Leave
          // Updated by Dipali V on 18th Dec 2025 - Removed Status filter, only Resource Name filtering
          function applyResourceNameFilter() {
              // Get Employee Name filter from parent page
              var employeeNameFilter = '';
              try {
                  if (window.parent && window.parent.document) {
                      var parentResourceNameInput = window.parent.document.getElementById('txtLeaveResourceName');
                      if (parentResourceNameInput) {
                          employeeNameFilter = (parentResourceNameInput.value || '').trim().toLowerCase();
                      }
                  }
              } catch(e) { }
              
              // Also check query string for EntityName
              if (!employeeNameFilter) {
                  employeeNameFilter = (getQueryParam("EntityName") || '').trim().toLowerCase();
              }
              
              var filteredData = allLeaveData;
              
              // Filter by Employee Name (partial search) - supports searching by first name, last name, or any part
              if (employeeNameFilter && employeeNameFilter !== '') {
                  filteredData = filteredData.filter(function(row) {
                      var employeeName = (row.employeeName || row.EmployeeName || '').toLowerCase();
                      // Check if the filter text appears anywhere in the employee name (partial match)
                      return employeeName.indexOf(employeeNameFilter) !== -1;
                  });
              }
              
              console.log('Employee Name Filter: ' + employeeNameFilter + ', Results: ' + filteredData.length);
              renderListViews(filteredData);
              // Initialize tooltips after filtering - Updated by Dipali V on 18th Dec 2025 - Dispose existing tooltips first to avoid duplicates
              setTimeout(function() {
                  var tooltipElements = document.querySelectorAll('[data-bs-toggle="tooltip"]');
                  tooltipElements.forEach(function(el) {
                      var tooltipInstance = bootstrap.Tooltip.getInstance(el);
                      if (tooltipInstance) {
                          tooltipInstance.dispose();
                      }
                  });
                  var tooltipTriggerList = [].slice.call(tooltipElements);
                  tooltipTriggerList.map(function (tooltipTriggerEl) {
                      return new bootstrap.Tooltip(tooltipTriggerEl, {
                          delay: { "show": 100, "hide": 100 }
                      });
                  });
              }, 200);
          }
          
          // Listen for resource name filter changes from parent
          window.addEventListener('message', function(e) {
              if (e.data && e.data.action === 'applyResourceNameFilter') {
                  applyResourceNameFilter();
              }
          });

          // Attempt to resolve user/session context; fallback to 0/empty
          function getContext() {
              return {
                  EmployeeID: '<%= Session("intUserID") %>' || 0,
                  LoginType: '<%= Session("LoginType") %>' || '',
                  LoginID: '<%= Session("intLoginID") %>' || 0,
                  UserName: '<%= Session("strUserName") %>' || '',
                  RoleID: '<%= Session("intPostID") %>' || ''
              };
      }

      


      var StrResult = "";
      // fetch per-tag rows and update all tab badges
      function fetchEntityDataForTag(flag, tagId) {
          // debugger;
          const ctx = getContext();
          const filters = readTopFilters();
          const param = {
              EmployeeID: ctx.EmployeeID,
              strAlertType: flag,
              TagID: tagId,
              strEntityName: filters.EntityName,
              BusinessUnit: (filters.BusinessUnit === undefined || filters.BusinessUnit === null || filters.BusinessUnit === '' ? '0' : filters.BusinessUnit),
              OrganizationUnit: (filters.OrganizationUnit === undefined || filters.OrganizationUnit === null || filters.OrganizationUnit === '' ? '0' : filters.OrganizationUnit),
              PendingFrom: (filters.PendingFrom === undefined || filters.PendingFrom === null || filters.PendingFrom === '' ? '0' : filters.PendingFrom)
          };
          // NEW FROMBODY APPROACH - Following ApproveRejectPT pattern
          var fullUrl = "api/EntityApproval/GetEntityWFDetails";
          var payload = JSON.stringify(param);
          var result = AJAXCallWithResult(fullUrl, payload, false, "POST");
          
          console.log('Search results: ' + JSON.stringify(result));
          StrResult = result;
          return result;
      }



      // For Plotting List View
      function renderListViews(rows) {
          // Render rows based on active tab with correct table and TagID mapping
          const dataRows = rows || [];
          const tagId = CTagID

          // Map TagID to table selector and card container
          const tableMap = {
              CTagID: { table: '#LeavesTbl', card: '#projCardViewSec' },       
          };

          const currentMap = tableMap[tagId] || { table: '#LeavesTbl', card: '#projCardViewSec' };
          const tableSelector = currentMap.table;
          const cardContainerSelector = currentMap.card;
          const $tbody = $(tableSelector + ' tbody');
          const $cardContainer = $(cardContainerSelector);

          // Clear existing data from both views
          $tbody.empty();
          $cardContainer.empty();

          // Check if there are rows to display
          if (dataRows.length === 0) {
              // Add a row with colspan to show "No data available" message for table
              const colCount = $(tableSelector + ' thead th').length;
              $tbody.append(
                  '<tr>' +
                  '<td colspan="' + colCount + '" class="dataTables_empty"><%= MyBase.GetResourceString("C_NoData") %></td>' +
                  '</tr>'
              );

              // Add empty state for card view
              $cardContainer.append(
                  '<div class="col-12 text-center py-5">' +
                  '<i class="fas fa-inbox fa-3x text-muted mb-3"></i>' +
                  '<h4 class="text-muted">No Approvals Found</h4>' +
                  '<p class="text-muted">There are no pending approvals at the moment.</p>' +
                  '</div>'
              );
          } else {
              // Process and add data rows to both table and card views
              dataRows.forEach((r, index) => {
                  // Add to table view
                  let tr = generateTableRow(r, tagId, index);
                  $tbody.append(tr);

                  //// Add to card view
                  //let card = generateCard(r, tagId, index);
                  //$cardContainer.append(card);
              });
              
          }

          
          // Destroy DataTable safely
          if ($.fn.DataTable.isDataTable(tableSelector)) {
              $(tableSelector).DataTable().clear().destroy();
          }

          // Append new rows FIRST, before reinitializing
          $tbody.html('');  // clear existing
          dataRows.forEach((r, index) => {
              const tr = generateTableRow(r, tagId, index);
              $tbody.append(tr);
          });

          // Now reinitialize AFTER rows exist in DOM
          setTimeout(() => {
              $(tableSelector).DataTable({
                  paging: false,
                  info: false,
                  lengthChange: false,
                  bFilter: false,
                  ordering: false,
                  responsive: true,
                  destroy: true,
                  language: {
                      emptyTable: "<%= MyBase.GetResourceString("C_NoData") %>"
                  },
                  drawCallback: function() {
                      // Reinitialize tooltips after DataTable draws - Updated by Dipali V on 18th Dec 2025
                      // Dispose existing tooltips first to avoid duplicates
                      var tableTooltips = document.querySelectorAll(tableSelector + ' [data-bs-toggle="tooltip"]');
                      tableTooltips.forEach(function(el) {
                          var tooltipInstance = bootstrap.Tooltip.getInstance(el);
                          if (tooltipInstance) {
                              tooltipInstance.dispose();
                          }
                      });
                      // Initialize tooltips with Bootstrap 5
                      var tooltipTriggerList = [].slice.call(tableTooltips);
                      tooltipTriggerList.map(function (tooltipTriggerEl) {
                          return new bootstrap.Tooltip(tooltipTriggerEl, {
                              delay: { "show": 100, "hide": 100 }
                          });
                      });
                  }
              });
              // Refresh custom pagination after DataTable renders
              currentPage = 1;
              showPageRows();
          }, 0);

          //$(tableSelector).wrap('<div class="dataTables_scrollbody" />');
          // Reinitialize tooltips for newly created elements - Updated by Dipali V on 18th Dec 2025 - Dispose existing tooltips first to avoid duplicates
          setTimeout(function() {
              // Dispose existing tooltips in the table to avoid duplicates
              var tableTooltips = document.querySelectorAll(tableSelector + ' [data-bs-toggle="tooltip"]');
              tableTooltips.forEach(function(el) {
                  var tooltipInstance = bootstrap.Tooltip.getInstance(el);
                  if (tooltipInstance) {
                      tooltipInstance.dispose();
                  }
              });
              // Initialize tooltips with Bootstrap 5
              var tooltipTriggerList = [].slice.call(tableTooltips);
              tooltipTriggerList.map(function (tooltipTriggerEl) {
                  return new bootstrap.Tooltip(tooltipTriggerEl, {
                      delay: { "show": 100, "hide": 100 }
                  });
              });
          }, 200);
          
          //applyEllipsisWithBootstrapTooltip('tbody td:nth-child(3)', 10);
          //applyEllipsisWithBootstrapTooltip('tbody td:nth-child(2)', 10);
          applyEllipsisWithBootstrapTooltip('tbody td:nth-child(7)', 10);
          applyEllipsisWithBootstrapTooltip('tbody td:nth-child(9)', 10);
         // applyEllipsisWithBootstrapTooltip('tbody td:nth-child(6)', 10);
          //$(".IRCurrency").addClass(bilCurrencyCode + 'Curncy');
      }

      // For Plotting List View Row
      function generateTableRow(r, tagId, index) {
          let tr = '';
         // bilCurrencyCode = r.bilCurrencyCode;
          switch (tagId) {
              case CTagID: // For IR
                  // Determine buttons based on leave status and edit access
                  let approveButton = '';
                  let rejectButton = '';

                  // Updated by Dipali V on 18th Dec 2025 - Standardized icon size (14px), width (20px), and gap (gap-3)
                  if (EditAccess === true || EditAccess === 'True') {
                      if (r.leaveStatus === 'Submitted' || r.leaveStatus === 'Pending') {
                          // Both Approve and Reject buttons
                          approveButton = '<button data-bs-toggle="tooltip" type="button" data-bs-original-title="Approve" ' +
                              'onclick="ApproveRejectLeave(\'A\', \'ListView\', ' + (r.leaveID || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">' +
                              '<i class="far fa-thumbs-up text-green" style="font-size:14px;"></i></button>';

                          rejectButton = '<button data-bs-toggle="tooltip" type="button" data-bs-original-title="Reject" ' +
                              'onclick="ApproveRejectLeave(\'R\', \'ListView\', ' + (r.leaveID || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">' +
                              '<i class="far fa-thumbs-down textRed" style="font-size:14px;"></i></button>';

                      } else if (r.leaveStatus === 'Approved') {
                          // Only reject button
                          rejectButton = '<button data-bs-toggle="tooltip" type="button" data-bs-original-title="Reject" ' +
                              'onclick="ApproveRejectLeave(\'R\', \'ListView\', ' + (r.leaveID || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">' +
                              '<i class="far fa-thumbs-down textRed" style="font-size:14px;"></i></button>';

                      } else if (r.leaveStatus === 'Rejected') {
                          // Only approve button
                          approveButton = '<button data-bs-toggle="tooltip" type="button" data-bs-original-title="Approve" ' +
                              'onclick="ApproveRejectLeave(\'A\', \'ListView\', ' + (r.leaveID || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">' +
                              '<i class="far fa-thumbs-up text-green" style="font-size:14px;"></i></button>';
                      }
                  }

                  // Modified by Dipali V on 2nd Dec 2025 - Updated to use inline icons like other entity pages
                  var employeeNameText = r.employeeName || '';
                  
                  // Added by Dipali V on 5th Dec 2025 - Employee image with no-photo fallback
                  // SystemFilename from DB may have relative path like '../../Images/Photo/filename.png'
                  // We need to extract just the filename and construct correct path from this page
                  var systemFilename = r.systemFilename || r.systemFilename || null;
                  var defaultImg = '../../../Images/Photo/no-photo.png';
                  var employeeImg = defaultImg;
                  if (systemFilename && systemFilename.trim() !== '') {
                      // Extract just the filename from the path (e.g., '33098784.png' from '../../Images/Photo/33098784.png')
                      var filename = systemFilename.split('/').pop();
                      employeeImg = '../../../Images/Photo/' + filename;
                  }
                  //console.log(employeeImg);
                  //console.log(r.employeeName);
                  //console.log(systemFilename);
                  // Added by Dipali V on 2nd Dec 2025 - Added Reason column with truncation
                  var reasonText = r.reason || r.leaveReason || '';
                  var reasonDisplay = truncateText(reasonText, 15);
                  var reasonHtml = reasonText.length > 15 
                      ? '<span data-bs-toggle="tooltip" data-bs-original-title="' + reasonText.replace(/"/g, '&quot;') + '">' + reasonDisplay + '</span>'
                      : reasonText;
                  
                  // Added by Dipali V on 2nd Dec 2025 - Calculate Days count with attractive display
                  // Check for half-day leave (First Half Day or Second Half Day)
                  var leaveTypeText = (r.leaveType || '').toLowerCase();
                  var isHalfDay = leaveTypeText.indexOf('half day') !== -1 || 
                                  r.firstHalfDay === true || r.secondHalfDay === true;
                  
                  var daysCount = calculateLeaveDays(r.fromDate, r.toDate);
                  // If it's a half day leave and single day, show 0.5
                  if (isHalfDay && daysCount === 1) {
                      daysCount = 0.5;
                  }
                  
                 // var daysClass = daysCount <= 0.5 ? 'half-day' : (daysCount === 1 ? 'single-day' : (daysCount <= 3 ? 'short-leave' : 'long-leave'));
                  var daysClass = daysCount <= 0.5 ? 'short-leave' : (daysCount === 1 ? 'short-leave' : (daysCount <= 3 ? 'short-leave' : 'short-leave'));
                  var daysLabel = daysCount === 0.5 ? '½' : daysCount;
                  var daysTooltip = daysCount === 0.5 ? 'Half Day' : daysCount + ' Day(s)';
                  // Updated by Dipali V on 18th Dec 2025 - Make calendar icon smaller and count bigger
                  var daysHtml = '<div class="days-badge ' + daysClass + '" data-bs-toggle="tooltip" data-bs-original-title="' + daysTooltip + '">' +
                      '<i class="far fa-calendar-alt days-icon-small"></i>' +
                      '<span class="days-count days-count-large">' + daysLabel + '</span>' +
                      '</div>';
                  
                  tr = [
                      '<tr>',
                      '<td class="entity-code-cell">',
                      '<div class="entity-code-wrapper d-flex align-items-center gap-2">',
                      '<img src="' + employeeImg + '" alt="' + employeeNameText + '" class="employee-avatar" ',
                      'style="width:25px;height:25px;border-radius:50%;object-fit:cover;border:1px solid #dee2e6;flex-shrink:0;" ',
                      'onerror="this.src=\'' + defaultImg + '\'">',
                      '<span class="entity-code-text" style="white-space:nowrap;" data-bs-toggle="tooltip" data-bs-original-title="' + employeeNameText.replace(/"/g, '&quot;').replace(/'/g, '&#39;') + '">', (employeeNameText.length > 15 ? employeeNameText.substring(0, 15) + '...' : employeeNameText), '</span>',
                      '</div>',
                      '</td>',
                      '<td>', formatDate(r.fromDate), '</td>',
                      '<td>', formatDate(r.toDate), '</td>',
                      '<td class="text-center">', daysHtml, '</td>',
                      '<td>', (r.leaveType || ''), '</td>',
                      '<td>', reasonHtml, '</td>',
                      '<td>',
                      '<div class="statusDiv d-flex justify-content-start" data-bs-toggle="tooltip" data-bs-original-title="', (r.leaveStatus || ''), '">',
                      '<span class="statusBox ', getStatusClass(r.leaveStatusID), ' mx-2">&nbsp;</span>',
                      '<label class="crsrLink">', (r.leaveStatus || ''), '</label>',
                      '</div>',
                      '</td>',
                      '<td class="text-center">',
                      // Updated by Dipali V on 18th Dec 2025 - Standardized icon size (14px), width (20px), and gap (gap-3)
                      '<div class="deskAppRejButns d-flex justify-content-center align-items-center gap-3">',
                      '<a href="javascript:;" onclick="GetNowWBSDetails(' + (r.leaveID || 0) + ',1209)" data-bs-toggle="tooltip" data-bs-original-title="Leave Details" class="leave-details-icon" style="width:20px;display:inline-flex;justify-content:center;">',
                      '<i class="far fa-list-alt" style="font-size:14px;"></i>',
                      '</a>',
                      approveButton,
                      rejectButton,
                      '</div>',
                      '</td>',
                      '</tr>'
                  ].join('');
                  break;
          }

          
          return tr;
      }


          // Added by Dipali V on 2nd Dec 2025 - Calculate leave days between two dates (inclusive)
          function calculateLeaveDays(fromDate, toDate) {
              if (!fromDate || !toDate) return 0;
              try {
                  var start = new Date(fromDate);
                  var end = new Date(toDate);
                  if (isNaN(start.getTime()) || isNaN(end.getTime())) return 0;
                  // Calculate difference in days (inclusive - add 1)
                  var diffTime = Math.abs(end - start);
                  var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
                  return diffDays;
              } catch(e) {
                  return 0;
              }
          }
          
          // For Get Leave Status CSS Class
          function getStatusClass(statusId) {
              switch (statusId) {
                  case 1: return 'statusSubmitted';
                  case 2: return 'statusApproved';
                  case 3: return 'statusRejected';
                  default: return 'statusPending';
              }
          }


          function GetLeaveType(type) {
              if (type === "L") {
                  return "Leave";
              } else if (type === "W") {
                  return "Work From Home";
              } else {
                  return "Unknown";
              }
          }
      // For Format Effort to HH:MM
      function formatEffortToHHMM(value) {
          if (value == null || value === '' || isNaN(value)) return '';

          let hours = Math.floor(value);
          let minutes = Math.round((value - hours) * 60);

          // handle rounding overflow (e.g. 1.999 → 2:00)
          if (minutes === 60) {
              hours += 1;
              minutes = 0;
          }

          return `${hours}:${minutes.toString().padStart(2, '0')}`;
      }



      // Added by Dipali V on 2nd Dec 2025 - Truncate text helper function with tooltip
      // Updated by Dipali V on 18th Dec 2025 - Added tooltip to show full text
      function truncateText(text, maxLength) {
          if (!text) return '';
          text = text.toString().trim();
          // Escape HTML for tooltip to prevent XSS
          var escapedText = text.replace(/"/g, '&quot;').replace(/'/g, '&#39;');
          if (text.length > maxLength) {
              return '<span data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + escapedText + '">' + text.substring(0, maxLength) + '...</span>';
          }
          return text;
      }

      // For Format Date
      function formatDate(dateString) {
          if (!dateString) return '';
          try {
              const date = new Date(dateString);
              return date.toLocaleDateString('en-GB', {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric'
              });
          } catch (e) {
              return dateString;
          }
      }

      // For Format Currency
      function formatCurrency(amount) {
          if (amount == null) return '0.00';
          return parseFloat(amount).toLocaleString('en-IN', {
              minimumFractionDigits: 2,
              maximumFractionDigits: 2
          });
      }

          function formatWorkHours(hours) {
              if (!hours) return '00:00';
              if (typeof hours === 'number') {
                  return hours.toFixed(2);
              }
              return hours;
          }

  
      // For Get Details (Row click)
      function GetNowWBSDetails(UniqueID, entityTypeID) {
       
          CUniqueID = UniqueID;
          GleaveID = UniqueID;
          bindNonWBSEntityDetails(entityTypeID, parseInt(CUniqueID), StrResult)
      }

      // Apply ellipsis and tooltip to specific columns
          // For Apply Ellipsis and Tooltip on Table Cells
          // Updated by Dipali V on 18th Dec 2025 - Only initialize tooltips for elements modified by this function to avoid duplicates
          function applyEllipsisWithBootstrapTooltip(selector, maxChars = 20) {
              const elements = document.querySelectorAll(selector);
              const modifiedElements = [];

              elements.forEach(td => {
                  const originalText = td.textContent.trim();

                  if (originalText.length > maxChars) {
                      // Truncate text
                      const truncatedText = originalText.substring(0, maxChars) + '...';
                      td.textContent = truncatedText;

                      // Add Bootstrap tooltip attributes
                      td.classList.add('td-ellipsis-bootstrap');
                      td.setAttribute('data-bs-toggle', 'tooltip');
                      td.setAttribute('data-bs-placement', 'top');
                      td.setAttribute('data-bs-original-title', originalText);
                      modifiedElements.push(td);
                  }
              });

              // Initialize Bootstrap tooltips only for modified elements - Updated by Dipali V on 18th Dec 2025
              modifiedElements.forEach(function (tooltipTriggerEl) {
                  // Dispose existing tooltip instance if any
                  var existingTooltip = bootstrap.Tooltip.getInstance(tooltipTriggerEl);
                  if (existingTooltip) {
                      existingTooltip.dispose();
                  }
                  // Create new tooltip instance
                  new bootstrap.Tooltip(tooltipTriggerEl, {
                      delay: { "show": 100, "hide": 100 }
                  });
              });
          }

         

        var strAction = "";
        // For Approve/Reject Leave (open modal)
        function ApproveRejectLeave(Action, FromWhere, LeaveID) {
            strAction = Action;
            
            if (FromWhere === "ListView") { // ✅ fixed case
                CUniqueID = LeaveID;
                Data = StrResult.find(item => item.leaveID === LeaveID);
                SelectedProjectData = Data ? [Data] : [];
            } else {
                GleaveID = GleaveID;
                CUniqueID = GleaveID;
            }

              window.parent.$("#approveleaveRevModal").modal('show');
              const modal = window.parent.$("#approveleaveRevModal");
              const caption = modal.find("#lblapproveleaveRevModalCaption");
              const btn = modal.find("#LeaveActionLinkCaption");
            if (Action == "A") {
                GLeaveStatusID = 2;
                caption.text('Approve');
                btn.text('Approve');
                btn.attr('data-bs-original-title', 'Approve');
            } else {
                GLeaveStatusID = 3;
                caption.text('Reject');
                btn.text('Reject');
                btn.attr('data-bs-original-title', 'Reject');
            }

            // reinitialize tooltip (important if Bootstrap tooltips are used)
            if (typeof window.parent.bootstrap !== "undefined") {
                const tooltip = window.parent.bootstrap.Tooltip.getInstance(btn[0]);
                if (tooltip) {
                    tooltip.dispose(); // remove existing tooltip
                }
                new window.parent.bootstrap.Tooltip(btn[0]);
            }
              window.parent.$("#txtWFARLeaveComments").val("");
              modal.find("#LeaveActionLinkCaption").off("click").on("click", function () {
                  ApproveRejectLeaveClick();
              });
          }

        // For Approve/Reject Leave (submit)
        function ApproveRejectLeaveClick() {
            var fullUrl = "api/EntityApproval/LeaveApproveReject"
            var Strcomments = window.parent.$("#txtWFARLeaveComments").val();
            if (!Strcomments) {
                if (window.parent && window.parent.alertify) {
                    window.parent.alertify.set('notifier', 'position', 'top-right');
                    window.parent.alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                }

                window.parent.$("#txtWFARComments").focus();
                return false;
            }

            if (checkSpecialCharacter(Strcomments, WebConfigSpecialCharacters)) {
                if (window.parent && window.parent.alertify) {
                    window.parent.alertify.set('notifier', 'position', 'top-right');
                    window.parent.alertify.error('<%= MyBase.GetResourceString("C_CommentSpecial") %> : ' + WebConfigSpecialCharacters);
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("C_CommentSpecial") %> : ' + WebConfigSpecialCharacters);
                }

                window.parent.$("#txtWFARComments").focus();
                return false;
            }

              const ctx = getContext();
              var payload = {
                  ApproverID: ctx.EmployeeID,
                  LeaveID: CUniqueID,
                  LeaveStatusID: GLeaveStatusID,
                  Strcomments: Strcomments,
                  strAction: strAction
              };
            // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
              var param = JSON.stringify(payload);
              
              try {
                  var strResult = AJAXCallWithResult(fullUrl, param, false, "POST");
                  console.log('Get leave Approve/Reject: ', strResult);
                  
                  if (strResult && strResult.result === "Success") {
                      var Status = (strAction === "A") ?
                         "<%= MyBase.GetResourceString("C_LeaveApproved") %>" :
                         "<%= MyBase.GetResourceString("C_LeaveRejected") %>";

                      if (window.parent && window.parent.alertify) {
                          window.parent.alertify.set('notifier', 'position', 'top-right');
                          window.parent.alertify.notify(Status, 'success', 25);
                      } else {
                          alertify.set('notifier', 'position', 'top-right');
                          alertify.notify(Status, 'success', 25);
                      }
                   
                      if (window.parent && window.parent.$) {
                          window.parent.$("#approveleaveRevModal").modal('hide');
                      }

                      // Hide offcanvas in current iframe
                      const offcanvasEl = window.parent.document.getElementById('LeaveDetailsOffcanvas');
                      if (offcanvasEl) {
                          const bsOffcanvas = window.parent.bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
                          bsOffcanvas.hide();
                      }
                      load(strAlertType);
                      window.parent.postMessage({ action: "updateAllTabCounts", value: strAlertType }, "*");
                      window.parent.postMessage({ action: "updateinboxWatclistCount", value: strAlertType }, "*");

                  } else {
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify((strResult && strResult.message) || 'Error processing approval', 'error', 25);
                  }
              } catch (error) {
                  alertify.set('notifier', 'position', 'top-right');
                  alertify.notify(error.message || 'Error processing approval', 'error', 25);
              }

          }

      // For Bind Entity Details (Non-WBS)
      function bindNonWBSEntityDetails(entityTypeID, UniQueID, data) {
          //debugger;
          var fieldMappings = "";
          if (entityTypeID == CTagID) {
              GPTID = UniQueID;
              Data = data.find(item => item.leaveID === UniQueID);
              SelectedProjectData = Data;
              if (!Data) {
                  console.log('IR data not found for ID:', rfiid);
                  return;
              }
          }
       
          switch (entityTypeID) {
              case CTagID:
                  var DivID = 'LeaveDetailsTab'
                  bindNonWBSDetails(entityTypeID, Data, DivID);
                  // Added by Dipali V on 18th Dec 2025 - Load resource allocation details
                  if (Data && Data.employeeID && Data.leaveID) {
                      loadResourceAllocationDetails(Data.employeeID, Data.leaveID);
                  }
                  break;
          }


      }

        // For Bind Details Section (Non-WBS)
        function bindNonWBSDetails(entityTypeID, projectData, DivID) {
             // debugger;
              var fieldMappings = "";
              if (entityTypeID === CTagID) {
                  // Added by Dipali V on 18th Dec 2025 - Calculate Full Day: Yes if both First Half Day and Second Half Day are No
                  var isFullDay = (!projectData.firstHalfDay && !projectData.secondHalfDay);
                  
                  fieldMappings = {
                      'Request Type :': GetLeaveType(projectData.leaveOrWFH) || 'N/A',
                      'Employee Name:': projectData.employeeName || 'N/A',
                      'From Date:': formatDate(projectData.fromDate) || 'N/A',
                      'To Date:': formatDate(projectData.toDate) || 'N/A',
                      'Leave Type:': projectData.leaveType || 'N/A',
                      'Leave Status:': projectData.leaveStatus || 'N/A',
                      'First Half Day:': projectData.firstHalfDay ? 'Yes' : 'No',
                      'Second Half Day:': projectData.secondHalfDay ? 'Yes' : 'No',
                      'Full Day:': isFullDay ? 'Yes' : 'No',
                      'Address:': projectData.address || 'N/A',
                      'Reason:': projectData.reason || 'N/A',
                      'Telephone:': projectData.telephone || 'N/A',
                      'Applied On:': formatDate(projectData.appliedDate) || 'N/A'
                  };

              }


            bindDataToHTML(fieldMappings, DivID);
            //debugger;
            // === Dynamic Leave Balance Progress Bar Binding ===
            // Updated by Dipali V on 18th Dec 2025 - Display leave balance value inside progress bar
            if (entityTypeID === CTagID) {
                const progressDiv = document.querySelector(`#${DivID} [role="progressbar"]`);
                const balanceValueSpan = document.querySelector(`#${DivID} .leave-balance-value`);
                
                if (progressDiv) {
                    // Get the actual leave balance value (not clamped to 0-100 for display)
                    let actualBalance = parseFloat(projectData.leaveBalance || 0);
                    
                    // Hide progress if it's Work From Home
                    if (projectData.leaveType && projectData.leaveType.toLowerCase().includes("work from home")) {
                        //progressDiv.style.display = "none";
                      
                        progressDiv.style.setProperty('--value', 'NA');
                        progressDiv.setAttribute('data-value', 'NA');
                        //if (balanceValueSpan) {
                        //    balanceValueSpan.textContent = 'NA';
                        //}
                        progressDiv.style.color = ''; // reset any color styling
                    } else {
                        progressDiv.style.display = "inline-block";

                        // Bind leave balance dynamically - use actual value for progress (clamped to 0-100)
                        let balanceValue = Math.max(0, Math.min(actualBalance, 100)); // Ensure 0–100 for progress bar

                        // Set progress value for visual representation
                        progressDiv.style.setProperty('--value', balanceValue);
                        
                        // Set data attribute for CSS counter (rounded to integer for counter)
                        progressDiv.setAttribute('data-value', Math.round(actualBalance));
                        
                        // Set text content directly inside progress bar using ::before pseudo-element override
                        // Since CSS counter doesn't support decimals, we'll use a data attribute and update CSS
                        progressDiv.setAttribute('aria-valuenow', actualBalance.toFixed(1));
                        
                        // Display the actual leave balance value outside progress bar (can be > 100 or decimal like 5.5)
                        //if (balanceValueSpan) {
                        //    balanceValueSpan.textContent = actualBalance.toFixed(1); // Show with 1 decimal place
                        //}
                    }
                }
            }

              GLeaveStatus = projectData.leaveStatus;
              GLeaveStatusID = projectData.leaveStatusID;
              if (GLeaveStatus == "Approved") {
                  $("#btnLeaveApproved").hide();
                  $("#btnLeaveRejected").show();
              }
              else if (GLeaveStatus == "Rejected") {
                  $("#btnLeaveRejected").hide();
                  $("#btnLeaveApproved").show();
              } else {
                  $("#btnLeaveRejected").show();
                  $("#btnLeaveApproved").show();

              }
              SelectedProjectData = projectData;

              // === Send offcanvas HTML to parent for rendering ===
            const offcanvasEl = document.getElementById('LeaveDetailsOffcanvas');
              if (!offcanvasEl) {
                  console.log("Offcanvas element not found in iframe.");
                  return;
              }

              // get HTML string
              const offcanvasHTML = offcanvasEl.outerHTML;

              // send to parent
              window.parent.postMessage({
                  action: "renderOffcanvas",
                  html: offcanvasHTML,
                  projectID: projectData.projectID || null,
                  // Added by Dipali V on 18th Dec 2025 - Pass employeeID and leaveID for resource allocation
                  employeeID: projectData.employeeID || null,
                  leaveID: projectData.leaveID || null
              }, "*");

              // Load resource allocation AFTER offcanvas is sent to parent.
              // Delay ensures parent has rendered the offcanvas HTML and
              // #tblResourceAllocation tbody exists in parent DOM before we write to it.
              if (projectData.employeeID && projectData.leaveID) {
                  var _empID  = projectData.employeeID;
                  var _lvID   = projectData.leaveID;
                  setTimeout(function () {
                      loadResourceAllocationDetails(_empID, _lvID);
                  }, 400);
              }
          }
   
      // Generic function to bind data to HTML
      // Generic function to bind data to HTML
      function bindDataToHTML(fieldMappings, DivID) {
              const container = document.getElementById(DivID);
              if (!container) {
                  console.log('Container not found:', DivID);
                  return;
              }
              const labels = container.querySelectorAll('label');

              labels.forEach(label => {
                  const labelText = label.textContent.trim();
                  if (fieldMappings.hasOwnProperty(labelText)) {
                      const valueContainer = label.closest('.row').querySelector('span');
                      if (valueContainer) {
                          updateValueWithIcons(valueContainer, fieldMappings[labelText], labelText);
                      }
                  }
              });
          }


      // Helper function to update values while preserving icons
      // Helper function to update values while preserving icons
      function updateValueWithIcons(container, value, labelText) {
          const iconConfig = {
              'Start Date:': { icon: 'far fa-calendar-check iconBlue pe-1', position: 'before' },
              'End Date:': { icon: 'far fa-calendar-check iconBlue pe-1', position: 'before' },
              'Work (HH:MM):': { icon: 'far fa-clock iconBlue pe-1', position: 'before' },
              'Project Currency:': { icon: 'fas fa-rupee-sign iconBlue', position: 'inside' }
          };

          const config = iconConfig[labelText];
          const existingIcon = container.querySelector('i');

          if (config) {
              if (config.position === 'before') {
                  container.innerHTML = `<i class="${config.icon}"></i> ${value}`;
              } else if (config.position === 'inside') {
                  container.innerHTML = `${value} (<i class="${config.icon}"></i>)`;
              }
          } else if (existingIcon) {
              // Preserve existing icon if no specific config
              container.innerHTML = existingIcon.outerHTML + ' ' + value;
          } else {
              container.textContent = value;
          }
      }

      // For validate special char for textarea
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
     
      //function getCurrency() {
      //    // Clear any previously appended icons
      //    $("span.INRCurncy, span.USDCurncy, span.SGDCurncy, span.EURCurncy, span.NZDCurncy, span.GBPCurncy").empty();

      //    // Append icons again
      //    $("span.INRCurncy").append('<i class="fas fa-rupee-sign iconBlue"></i>');
      //    $("span.USDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
      //    $("span.SGDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
      //    $("span.EURCurncy").append('<i class="fas fa-euro-sign iconBlue"></i>');
      //    $("span.NZDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
      //    $("span.GBPCurncy").append('<i class="fas fa-pound-sign iconBlue"></i>');
      //}

      // Utility functions
      // For Format Date (dd-MMM-yyyy)
      function formatDate(dateString) {
              if (!dateString) return null;
              const date = new Date(dateString);
              return date.toLocaleDateString('en-GB', {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric'
              }).replace(/ /g, '-');
          }

    
      // For Ajax Call with unified result handling
      function AJAXCallWithResult(url, param, async, type) {
          var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
              //debugger;
              var result = null;
              var fullUrl = API_BASE + url;

              $.ajax({
                  url: fullUrl,
                  type: type || "GET",
                  data: param,
                  async: async,
                  dataType: "json",
                  contentType: (type === "GET") ? "application/x-www-form-urlencoded" : "application/json;charset=utf-8",
                  beforeSend: function (xhr) {
                      xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                      if (param) {
                          xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                      }
                  },
                  success: function (data) {
                      // Handle new .NET Core API response structure
                      // For ResponseHelper.BuildResponse format: { data: { data: {...}, message: "..." } }
                      if (data && data.data) {
                          // Check for both PascalCase and camelCase
                          if (data.data.WorkflowDetails || data.data.workflowDetails) {
                              result = data.data.WorkflowDetails || data.data.workflowDetails;
                          } else if (data.data.Discussions || data.data.discussions) {
                              result = data.data.Discussions || data.data.discussions;
                          } else if (data.data.Result || data.data.result) {
                              result = data.data.Result || data.data.result;
                          } else if (data.data.data) {
                              result = data.data.data; // Nested data
                          } else {
                              result = data.data; // Direct data
                          }
                      } else if (data.workflowDetails) {
                          // Handle direct camelCase response (no nested data.data)
                          result = data.workflowDetails;
                      }
                      else if (data.workflowCounts || data.workflowCounts) {
                          var wfCounts = data.workflowCounts
                          result = wfCounts;

                      }
                      else if (data.data && (data.data.AllocationDetails || data.data.allocationDetails)) {
                          // Added by Dipali V on 18th Dec 2025 - Handle AllocationDetails response
                          result = data.data.AllocationDetails || data.data.allocationDetails;
                      }
                      else if (data.WorkflowDetails) {
                          // Handle direct PascalCase response
                          result = data.WorkflowDetails;
                      } else if (Array.isArray(data)) {
                          result = data; // Direct array response
                      } else {
                          result = data; // Fallback
                      }
                  },
                  error: function (xhr, status, error) {
                      if (xhr.status === 401) {
                          alertify.set('notifier', 'position', 'top-right');

                      } else {
                          console.log('AJAX Error:', error, xhr.responseText);
                          // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                      }
                  }
              });



              // For asynchronous calls, return result
              return result;
          }



          // Added by Dipali V on 07-Oct-2025 (W26): Hide page loader and fade in content after everything loads
          // Added by Dipali V on 07-Oct-2025 (W26): Hide page loader and fade in content after everything loads
          function hidePageLoader() {
              setTimeout(function () {
                  $('#pageLoaderEntity').fadeOut(400, function () {
                      $(this).remove();
                  });
                  $('body').removeClass('page-loading');
                  $('.main-content-wrapper').addClass('loaded');
              }, 200);
          }

          // Added by Dipali V on 18th Dec 2025 - Load Resource Allocation Details
          function loadResourceAllocationDetails(employeeID, leaveID) {
              try {
                  if (!employeeID || !leaveID) {
                      console.log('EmployeeID or LeaveID is missing');
                      return;
                  }

                  var fullUrl = "api/EntityApproval/GetResourceAllocationDetails";
                  var payload = {
                      EmployeeID: employeeID,
                      LeaveID: leaveID
                  };

                  // Use AJAXCallWithResult to handle authentication properly (uses sessionStorage.getItem("access_token_W26API"))
                  var response = AJAXCallWithResult(fullUrl, JSON.stringify(payload), false, "POST");

                  console.log('Resource Allocation API Response:', response);

                  // Handle different response structures from AJAXCallWithResult
                  // AJAXCallWithResult extracts data from response.data or returns direct data
                  var allocationDetails = null;

                  // Check if response is already the data array (AJAXCallWithResult might extract it)
                  if (Array.isArray(response)) {
                      allocationDetails = response;
                  }
                  // Check for nested structure: response.data.AllocationDetails
                  else if (response && response.data) {
                      if (response.data.AllocationDetails) {
                          allocationDetails = response.data.AllocationDetails;
                      } else if (Array.isArray(response.data)) {
                          allocationDetails = response.data;
                      } else if (response.data.data && response.data.data.AllocationDetails) {
                          allocationDetails = response.data.data.AllocationDetails;
                      }
                  }
                  // Check for direct AllocationDetails property (PascalCase or camelCase)
                  else if (response && response.AllocationDetails) {
                      allocationDetails = response.AllocationDetails;
                  } else if (response && response.allocationDetails) {
                      allocationDetails = response.allocationDetails;
                  }

                  console.log('Extracted Allocation Details:', allocationDetails);
                  console.log('Allocation Details length:', allocationDetails ? allocationDetails.length : 0);

                  if (allocationDetails && Array.isArray(allocationDetails) && allocationDetails.length > 0) {
                      bindResourceAllocationTable(allocationDetails);
                  } else {
                      console.log('No allocation details found in response. Full response:', JSON.stringify(response, null, 2));
                      bindResourceAllocationTable([]);
                  }
              } catch (error) {
                  console.log('Exception in loadResourceAllocationDetails:', error);
                  bindResourceAllocationTable([]);
              }
          }

          // Added by Dipali V on 18th Dec 2025 - Bind Resource Allocation Details to Table
          function bindResourceAllocationTable(allocationDetails) {
              // Delegate directly — _raRenderPage handles its own retry if tbody not ready
              bindDataToResourceAllocationTable(null, allocationDetails);
          }

          // Helper function to bind data to table - Added by Dipali V on 18th Dec 2025
          // ============================================================
          // Resource Allocation Table Pagination — same pattern as main Leave table
          // ============================================================
          var _raAllData    = [];   // full data set
          var _raCurPage    = 1;
          var _raPerPage    = 5;
          var _raTotalPages = 1;

          function bindDataToResourceAllocationTable(tbody, allocationDetails) {
              // Store full data set and reset to page 1
              _raAllData    = (allocationDetails && allocationDetails.length > 0) ? allocationDetails : [];
              _raCurPage    = 1;
              _raTotalPages = Math.ceil(_raAllData.length / _raPerPage) || 1;
              _raRenderPage();
          }

          function _raRenderPage() {
              // Always resolve tbody from parent window (offcanvas is rendered there)
              var tbody = (window.parent && window.parent.document)
                  ? window.parent.document.querySelector('#tblResourceAllocation tbody')
                  : document.querySelector('#tblResourceAllocation tbody');

              // If tbody not found yet, retry once after a short delay
              if (!tbody) {
                  console.log('_raRenderPage: tbody not ready, retrying in 300ms...');
                  setTimeout(function () { _raRenderPage(); }, 300);
                  return;
              }

              tbody.innerHTML = '';

              if (!_raAllData || _raAllData.length === 0) {
                  tbody.innerHTML = '<tr><td colspan="5" class="text-center">No resource allocation found for this leave period.</td></tr>';
                  _raUpdatePagination();
                  return;
              }

              var startIdx = (_raCurPage - 1) * _raPerPage;
              var endIdx   = Math.min(startIdx + _raPerPage, _raAllData.length);

              for (var i = startIdx; i < endIdx; i++) {
                  var item = _raAllData[i];
                  var projectName          = item.projectName || item.ProjectName || 'N/A';
                  var startDate            = item.startDate   || item.StartDate;
                  var endDate              = item.endDate     || item.EndDate;
                  var allocationPercentage = item.allocationPercentage  != null ? item.allocationPercentage
                                           : item.AllocationPercentage != null ? item.AllocationPercentage : null;
                  var approverName         = item.approverName || item.ApproverName || 'N/A';

                  var row = document.createElement('tr');
                  row.innerHTML = [
                      '<td>' + projectName + '</td>',
                      '<td>' + (startDate ? formatDate(startDate) : 'N/A') + '</td>',
                      '<td>' + (endDate   ? formatDate(endDate)   : 'N/A') + '</td>',
                      '<td class="text-center">' + (allocationPercentage != null ? allocationPercentage + '%' : 'N/A') + '</td>',
                      '<td>' + approverName + '</td>'
                  ].join('');
                  tbody.appendChild(row);
              }

              console.log('Data binding completed — page', _raCurPage, 'of', _raTotalPages);
              _raUpdatePagination();
          }

          function _raUpdatePagination() {
              var total = _raAllData.length;
              _raTotalPages = Math.ceil(total / _raPerPage) || 1;

              // All pagination elements live in the parent window (offcanvas rendered there)
              var pd = (window.parent && window.parent.document) ? window.parent.document : document;

              // Update total count
              var totalEl = pd.getElementById('raTotalRecords');
              if (totalEl) totalEl.textContent = total;

              var prevLi = pd.getElementById('raBtnPrev');
              var prevA  = pd.getElementById('raLinkPrev');
              var nextLi = pd.getElementById('raBtnNext');
              var nextA  = pd.getElementById('raLinkNext');

              // Disabled style — grey, not-allowed cursor, no pointer events (block click)
              var disabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;';
              // Enabled style — blue, pointer cursor, clickable
              var enabledAStyle  = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#1359a6;background-color:#fff;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:auto;cursor:pointer;transition:all 0.3s ease;';

              // Previous button
              if (_raCurPage <= 1 || total === 0) {
                  // Disabled — block cursor, no click
                  if (prevLi) prevLi.style.cursor = 'not-allowed';
                  if (prevA)  { prevA.setAttribute('style', disabledAStyle); prevA.removeAttribute('onclick'); }
              } else {
                  // Enabled — pointer cursor, click fires prev
                  if (prevLi) prevLi.style.cursor = 'pointer';
                  if (prevA)  { prevA.setAttribute('style', enabledAStyle); prevA.setAttribute('onclick', 'window.frames[0]._raGoToPrev()'); }
              }

              // Next button
              if (_raCurPage >= _raTotalPages || total === 0) {
                  // Disabled — block cursor, no click
                  if (nextLi) nextLi.style.cursor = 'not-allowed';
                  if (nextA)  { nextA.setAttribute('style', disabledAStyle); nextA.removeAttribute('onclick'); }
              } else {
                  // Enabled — pointer cursor, click fires next
                  if (nextLi) nextLi.style.cursor = 'pointer';
                  if (nextA)  { nextA.setAttribute('style', enabledAStyle); nextA.setAttribute('onclick', 'window.frames[0]._raGoToNext()'); }
              }
          }

          // Exposed on window so parent-injected onclick can call back into this iframe
          window._raGoToPrev = function () {
              if (_raCurPage > 1) { _raCurPage--; _raRenderPage(); }
          };

          window._raGoToNext = function () {
              if (_raCurPage < _raTotalPages) { _raCurPage++; _raRenderPage(); }
          };
          // ============================================================
          // End Resource Allocation Pagination
          // ============================================================

          // Initial page load - Added by Dipali V on 07-Oct-2025 (W26)
          $(function () {
              try {
                  hidePageLoader();

              } catch (e) {

              } finally {
                  // Hide loader after all initialization is complete
                  hidePageLoader();
              }
          });


          // ============================================================
          // Custom Pagination - matching PM_Documents.aspx - Vaibhav K
          // ============================================================
          let currentPage = 1;
          const itemsPerPage = 5;
          let totalPages = 1;

          function showPageRows() {
              var $tbody = $('#LeavesTbl tbody');
              var dataRows = $tbody.find('tr').filter(function () {
                  return !$(this).hasClass('dataTables_empty') &&
                      $(this).find('td.dataTables_empty').length === 0;
              }).toArray();
              var totalRecords = dataRows.length;
              if (totalRecords === 0) { updatePagination(); return; }
              var startIndex = (currentPage - 1) * itemsPerPage;
              var endIndex = Math.min(startIndex + itemsPerPage, totalRecords);
              dataRows.forEach(function (row, idx) {
                  $(row).toggle(idx >= startIndex && idx < endIndex);
              });
              updatePagination();
          }

          function updatePagination() {
              var $tbody = $('#LeavesTbl tbody');
              var totalRecords = $tbody.find('tr').filter(function () {
                  return !$(this).hasClass('dataTables_empty') &&
                      $(this).find('td.dataTables_empty').length === 0;
              }).length;
              $('#totalRecords').text(totalRecords);
              totalPages = Math.ceil(totalRecords / itemsPerPage) || 1;
              if (currentPage <= 1 || totalRecords === 0) {
                  $('#btnprevious').addClass('fa-disabled'); $('#LinkPrevious').removeAttr('onclick');
              } else {
                  $('#btnprevious').removeClass('fa-disabled'); $('#LinkPrevious').attr('onclick', 'goToPreviousPage()');
              }
              if (currentPage >= totalPages || totalRecords === 0) {
                  $('#btnnext').addClass('fa-disabled'); $('#LinkNext').removeAttr('onclick');
              } else {
                  $('#btnnext').removeClass('fa-disabled'); $('#LinkNext').attr('onclick', 'goToNextPage()');
              }
          }

          function goToPreviousPage() { if (currentPage > 1) { currentPage--; showPageRows(); } }
          function goToNextPage() { if (currentPage < totalPages) { currentPage++; showPageRows(); } }
          // ============================================================
          // End Custom Pagination
          // ============================================================

      </script>
</body>

</html>
