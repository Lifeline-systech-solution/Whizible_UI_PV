<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityChangeRequest.aspx.vb" Inherits="Whizible.PM_EntityChangeRequest" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Entity Approval")%>
    <head runat="server">
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
    /* Pagination styling - matching PM_EntityModuleApproval.aspx - Vaibhav K */
    .pagination-container { background: white; display: flex !important; justify-content: flex-end; align-items: center; gap: 1rem; margin-top: 0; position: fixed; bottom: 0; left: 0; right: 0; z-index: 1000; }
    .pagination-info { color: #333; font-size: 14px; font-weight: 300; }
    .pagination { margin-bottom: 20px !important; margin-top: 20px !important; }
    .pagination .page-item { margin: 0 2px; }
    .pagination .page-link { padding: 8px 12px; color: #1359a6; background-color: #fff; border: 1px solid #dee2e6; border-radius: 4px; text-decoration: none; transition: all 0.3s ease; }
    .pagination .page-link:hover { color: #fff; background-color: #1359a6; border-color: #1359a6; }
    .pagination .page-item.fa-disabled .page-link { color: #6c757d; background-color: #f8f9fa; border-color: #dee2e6; cursor: not-allowed; pointer-events: none; }
    .pagination .page-item.fa-disabled .page-link:hover { color: #6c757d; background-color: #f8f9fa; border-color: #dee2e6; }
    li#btnprevious.page-item.fa-disabled { cursor: not-allowed; }
    li#btnnext.page-item.fa-disabled { cursor: not-allowed; }
    .content.mb-10 { padding-bottom: 80px; }
        </style>
        <!-- End of Same loader as PM_EntityProjectApproval - Added By Vyankat B. on 17th March 2026 -->
        


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
      <!-- Change Request Entity Start here -->
      <div class="allEntity col-sm-12" id="cReqEntity">
          <!-- Desktop View Starts here -->
          <%-- List view always visible; card view hidden on all resolutions - Updated by Dipali V on 11th March 2026 --%>
          <div class="cReqListViewDiv d-block" id="cReqListViewSec">
              <div class="table-responsive">
                  <table id="ChangeReqTable" class="table tbl_wrkflow_approval" style="width: 100%;">
                      <thead class="stickyTblHeader">
                          <tr>
                              <th class="col-sm-2"><%= MyBase.GetResourceString("C_ChangeRequestCaption") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("CProjectName") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_ChangeRequestor") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_ChangeRequestedDate") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_Category") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_ChangePriority") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_ChangeSize") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_ChangeRequestStatus") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_CostofChange") %></th>
                              <th class="col-sm-1"><%= MyBase.GetResourceString("C_SND_Comment") %></th>
                              <th class="" id="cReqActionCol"><%= MyBase.GetResourceString("C_Action") %></th>
                          </tr>
                      </thead>
                      <tbody>
                      </tbody>
                  </table>
              </div>
          </div>
          <!-- Desktop View Ends here -->

          <!-- Pagination - matching PM_EntityModuleApproval.aspx - Vaibhav K -->
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

           <!-- Mobile View Starts here -->
         <div class="projCardViewDiv d-none" id="ChangeReq_CardViewSec">
     
         </div>
      </div>
      <!-- Change Request Entity End here -->
 
        
      
        <!-- Change Request information offcanvas Section Start Here-->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="CReq_DetailsOffcanvas">
            <div class="offcanvas-body">
                <div id="CReq_Info_Sec" class="ProjInfoDetails">
                    <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                        <div class="row">
                            <div class="col-sm-12">
                                <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ChangeRequestCaption") %></h5>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2 mb-2 project_timeperiod">
                        <div class="col-sm-2">
                        </div>
                        <div class="col-sm-10 d-flex gap-3 justify-content-end" id="Actionlinks_1039">
                            <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                data-bs-dismiss="offcanvas">
                               <%= MyBase.GetResourceString("C_Close") %> 
                            </button>
                        </div>
                    </div>
                    <div class="ChangReq_DetailsContent text-end">
                        <h6 class="mb-20">
                            <a href="javascript:;" onclick="callIframeFunctionWorkflowDewtails('GetWFDetails','0','0')"><i
                                class="fas fa-recycle statusIcon"></i></a>
                            Status:
                        <span class="WFCStatus"> </span>
                        </h6>

                        <div class="accordion WF_TopAccordianPanel mb-3 mt-3 " id="CReqDetailsAcc">
                            <div class="accordion-item mb-3">
                                <h2 class="accordion-header" id="CReq_DetailsHeading">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#CReq_DetailsTab" aria-expanded="true">
                                         <%= MyBase.GetResourceString("C_LeaveDetails") %> 
                                    </button>
                                </h2>

                                <div id="CReq_DetailsTab" class="accordion-collapse collapse show"
                                    aria-labelledby="CReq_DetailsHeading">
                                    <div class="accordion-body">
                                        <div class="CReqDetlsContent">
                                            <div class="row form-group">
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_ChangeRequestCaption") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_ChangeRequestor") %>: </label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_ChangeRequestedDate") %>: </label>
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
                                                            <label><%= MyBase.GetResourceString("C_ChangeModule") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_Version") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span> </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_ChangePriority") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_Description") %>: </label>
                                                        </div>
                                                        <div class="col-sm-8 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_Benefits") %>: </label>
                                                        </div>
                                                        <div class="col-sm-8 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_Category") %>: </label>
                                                        </div>
                                                        <div class="col-sm-8 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_EstimationDocumentReference") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_ApprovedBy") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_ApprovedDate") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span><i class="far fa-calendar-check iconBlue pe-1"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_RejectedBy") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_RejectedDate") %>: </label>
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
                                                            <label><%= MyBase.GetResourceString("C_ChangeStatus") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_CostofChange") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span class="INRCurncy"></span><span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <label><%= MyBase.GetResourceString("C_CRDeliverable") %>: </label>
                                                        </div>
                                                        <div class="col-sm-6 text-start">
                                                            <span></span>
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
        <!-- Change Request information offcanvas Section End Here-->

        <div class="clearfix"></div>

      
    </div>
    <!-- Close main-content-wrapper -->


      <script>

          var GProjectID = 0;
          var CTagID = 1039;
          var CUniqueID = 0;
          var strAlertType = 'T';
          var GFromWhere = "";
          var GChangeRequestID_PK = 0;
          var GProjectName = "";
          var SelectedStage = "";
          var SelectedWF = "";
          var SelectedStageID = "";
          var CnatureOfDemandID = "";
          var IsCheckIResumeTimesheet = false;
          var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
          var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
          var EditAccess = "<%= m_EditAccess %>";
          window.parent.alertify.set('notifier', 'position', 'top-right');

          $(document).ready(function () {

              // Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner
              // StartLoader("#Body")
              // End of Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner

              StartLoader("#Body")
              $(".change_filter").hide();
              $("#search_pro").show();
              strAlertType = getQueryParam("FilterIW");
              load(strAlertType);

              $("span.INRCurncy").append('<i class="fas fa-rupee-sign iconBlue"></i>');
              $("span.USDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
              $("span.SGDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
              $("span.EURCurncy").append('<i class="fas fa-euro-sign iconBlue"></i>');
              $("span.NZDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');
              $("span.GBPCurncy").append('<i class="fas fa-pound-sign iconBlue"></i>')

              //Commented By Vyankat on 17th March 2026 for the removal of old LoadingOverlay spinner
              //StopAjaxLoader("#Body")
              // End of Commented By Vyankat on 17th March 2026 for the removal of old LoadingOverlay spinner

          });

          //For Get Context which gets user session details
          function getContext() {
              return {
                  EmployeeID: '<%= Session("intUserID") %>' || 0,
                  LoginType: '<%= Session("LoginType") %>' || '',
                  LoginID: '<%= Session("intLoginID") %>' || 0,
                  UserName: '<%= Session("strUserName") %>' || '',
                  RoleID: '<%= Session("intPostID") %>' || ''
              };
          }


          //For Get Paramter which gets from Parent Page
          function getQueryParam(name) {
              const urlParams = new URLSearchParams(window.location.search);
              return urlParams.get(name);
          }


          //For Filter Section
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



          $(".canceldetailpanel").click(function () {
              $("table tr").removeClass("rowhiglight");
              $(".projCostDetailpanel").hide();
              $(".table").resize();
          });
          // Project Cost Details Panel starts here


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


          //For Load function
          function load(alertType) {
              try {
                  var resp = fetchEntityDataForTag(alertType, CTagID);
                  const rows = Array.isArray(resp) ? resp : (resp && resp.Table) ? resp.Table : resp || [];
                  renderListViews(rows);

                  // Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner 
                  //StopAjaxLoader('#Body');
                  // End of Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner 

              } finally {

                  $('[data-bs-toggle="tooltip"]').tooltip();
              }
          }

          var StrResult = "";
          //For Fetch Entity Data For Tag
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


          //For Plotting List View
          function renderListViews(rows) {
              // Render rows based on active tab with correct table and TagID mapping
              const dataRows = rows || [];
              const tagId = CTagID

              // Map TagID to table selector and card container
              const tableMap = {
                  1039: { table: '#ChangeReqTable', card: '#ChangeReq_CardViewSec' }
              };

              const currentMap = tableMap[tagId] || { table: '#ChangeReqTable', card: '#ChangeReq_CardViewSec' };
              const tableSelector = currentMap.table;
              const cardContainerSelector = currentMap.card;
              const $tbody = $(tableSelector + ' tbody');
              //const $cardContainer = $(cardContainerSelector + ' .row.g-0');
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

                      // Add to card view
                      let card = generateCard(r, tagId, index);
                      $cardContainer.append(card);
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
                      }
                  });
                  // Refresh custom pagination after DataTable renders
                  currentPage = 1;
                  showPageRows();
              }, 0);

              //$(tableSelector).wrap('<div class="dataTables_scrollbody" />');
              // Reinitialize tooltips for newly created elements
              $('[data-bs-toggle="tooltip"]').tooltip();

              applyEllipsisWithBootstrapTooltip('tbody td:nth-child(3)', 10);
              applyEllipsisWithBootstrapTooltip('tbody td:nth-child(2)', 10);
              applyEllipsisWithBootstrapTooltip('tbody td:nth-child(7)', 10);
              applyEllipsisWithBootstrapTooltip('tbody td:nth-child(9)', 10);
              applyEllipsisWithBootstrapTooltip('tbody td:nth-child(6)', 10);

          }

          //For Plotting List View
          function generateTableRow(r, tagId, index) {
              let tr = '';
              switch (tagId) {
                  case CTagID: 
                      // Modified by Dipali V on 2nd Dec 2025 - Truncate first column text to prevent overlap with icons
                      var changeRequestText = r.changeRequestSummary || 'Change Request';
                      tr = [
                          '<tr role="row" class="' + (index % 2 === 0 ? 'even' : 'odd') + '">',
                          '<td class="proj-code-main-wrap">',
                          '<p class="">', truncateFirstColumnText(changeRequestText, 10, 6), '</p>',

                          '<div class="projDetailsBtns d-flex justify-content-end">',
                          '<div>',
                          '<a href="javascript:;" class="font-9" onclick="GetDetails(\'' + (r.natureOfDemandID || '') + '\',\'' + (r.changeRequestID_PK || '') + '\',1039,\'' + (r.projectID || '') + '\')">',
                          '<i class="far fa-list-alt ms-2 me-1 font-9" data-bs-toggle="tooltip" data-bs-original-title="Change Request Details"></i>',
                          '</a>',
                          '</div>',
                          '<div>',
                          '<a href="javascript:;" class="font-9" onclick="GetWFDetails(\'' + (r.changeRequestID_PK || '') + '\',1039)">',
                          '<i class="fas fa-list-ul me-2 font-9" data-bs-toggle="tooltip" data-bs-original-title="Show Details"></i>', // Modified by Dipali V on 1st Dec 2025 - Changed tooltip from "Show Status" to "Show Details"
                          '</a>',
                          '</div>',
                          '</div>',
                          '</td>',

                          '<td>', (r.projectName || ''), '</td>',
                          '<td>', (r.changeRequestedBy || ''), '</td>',
                          '<td>', (r.changeRequestDate ? formatDate(r.changeRequestDate) : ''), '</td>',
                          '<td>', (r.changeCategory || ''), '</td>',
                          '<td>', (r.changePriority || ''), '</td>',
                          '<td>', (r.changeSize || ''), '</td>',
                          '<td>', (r.changeStatus || ''), '</td>',
                          '<td>', (r.costOfChange ? formatCurrency(r.costOfChange) : ''), '</td>',
                          '<td>', (r.requeststage || ''), '</td>'
                      ].join('');

                      // Normalize and check stage
                      var stage = (r.requeststage || '').toUpperCase();
                      var hasEditAccess = (EditAccess === true || EditAccess === 'True');

                      if (hasEditAccess) {
                          if (stage === 'START') {
                              // ✅ Show Send for Approval button
                              tr += [
                                  '<td>',
                                  '<div class="deskAppRejButns d-flex justify-content-center">',
                                  '<button data-bs-toggle="tooltip" class="btn px-2" type="button" ',
                                  'data-bs-placement="top" data-bs-original-title="Send for Approval" ',
                                  'onclick="SendForApproval(\'' + (r.natureOfDemandID || '') + '\',\'' + (r.changeRequestID_PK || '') + '\',\'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + (r.requeststageID || 0) + ',' + (r.projectID || 0) + ',\'A\',\'ListView\')">',
                                  '<i class="fas fa-paper-plane text-primary"></i>',
                                  '</button>',
                                  '</div>',
                                  '</td>'
                              ].join('');
                          } else if (stage !== 'COMPLETE') {
                              // ✅ Show Approve/Reject buttons
                              tr += [
                                  '<td>',
                                  '<div class="deskAppRejButns d-flex justify-content-center">',
                                  '<button data-bs-toggle="tooltip" class="btn px-2" type="button" ',
                                  'data-bs-placement="top" data-bs-original-title="Approve" ',
                                  'onclick="ApproveRejectItem(\'' + (r.changeRequestID_PK || '') + '\',\'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + (r.requeststageID || 0) + ',' + (r.projectID || 0) + ',\'A\',\'ListView\')">',
                                  '<i class="far fa-thumbs-up text-green"></i>',
                                  '</button>',
                                  '<button data-bs-toggle="tooltip" class="btn px-2" type="button" ',
                                  'data-bs-placement="top" data-bs-original-title="Reject" ',
                                  'onclick="ApproveRejectItem(\'' + (r.changeRequestID_PK || '') + '\',\'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + (r.requeststageID || 0) + ',' + (r.projectID || 0) + ',\'R\',\'ListView\')">',
                                  '<i class="far fa-thumbs-down textRed"></i>',
                                  '</button>',
                                  '</div>',
                                  '</td>'
                              ].join('');
                          } else {
                              // ✅ For COMPLETE stage, show empty cell
                              tr += '<td></td>';
                          }
                      } else {
                          // ✅ No edit access, keep table aligned
                          tr += '<td></td>';
                      }

                      tr += '</tr>';
                      break;

              }
              return tr;
          }


          //Get Change Request Details
          function GetDetails(natureOfDemandID,UniqueID, entityTypeID,ProjectID) {
              CUniqueID = UniqueID;
              GProjectID = ProjectID;
              CnatureOfDemandID = natureOfDemandID;
              bindEntityDetails(entityTypeID, parseInt(CUniqueID), StrResult)
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Truncate text in first column to prevent overlap with icons - show 6 chars + "..." if text > 10 chars
          function truncateFirstColumnText(text, maxLength = 10, showLength = 6) {
              if (!text) return '';
              text = text.toString().trim();
              if (text.length > maxLength) {
                  return '<span data-bs-toggle="tooltip" data-bs-original-title="' + text + '">' + text.substring(0, showLength) + '...</span>';
              }
              return text;
          }
          // End of truncateFirstColumnText - Added by Dipali V on 2nd Dec 2025

          //For Apply Ellipsis With Bootstrap Tooltip
          function applyEllipsisWithBootstrapTooltip(selector, maxChars = 20) {
              const elements = document.querySelectorAll(selector);

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
                      td.setAttribute('title', originalText);
                  }
              });

              // Initialize Bootstrap tooltips
              const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
              const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                  return new bootstrap.Tooltip(tooltipTriggerEl, {
                      delay: { "show": 100, "hide": 100 }
                  });
              });
          }

          //For Bind Change Request Details
          function bindEntityDetails(entityTypeID, UniQueID, data) {
              //debugger;
              var fieldMappings = "";
              if (entityTypeID == CTagID) {
                  GChangeRequestID_PK = UniQueID;
                  Data = data.find(item => item.changeRequestID_PK === UniQueID);
                  SelectedProjectData = Data;
                  if (!Data) {
                      console.log('ProjectTimesheet data not found for ID:', GChangeRequestID_PK);
                      return;
                  }
              }

              switch (entityTypeID) {
                  case CTagID:
                      var DivID = 'CReq_DetailsTab'
                      bindWBSDetails(entityTypeID, Data, DivID);
                     
                      break
              }


          }

          //For Plot Action Links
          function GetActionLinks(TagID, ProjectID, CUniqueID) {
               //debugger;
              GProjectID = ProjectID;
              const ctx = getContext();
              const ResourceParameters = {
                  TagID: TagID,
                  ProjectID: GProjectID,
                  EmployeeID: ctx.EmployeeID,
                  strAlertType: strAlertType,
                  UniqueID: CUniqueID
              };

              // NEW FROMBODY APPROACH - Following ApproveRejectPT pattern
              const fullUrl = "api/EntityApproval/GetActionLinks";
              const payload = JSON.stringify(ResourceParameters);
              const data = AJAXCallWithResult(fullUrl, payload, false, "POST");

              console.log('Get Links:', data);

              if (!data) return;

              try {
                  const rows = Array.isArray(data) ? data : (data.Table ? data.Table : []);
                  const $actionLinks = $('#Actionlinks_' + CTagID);
                  if (!$actionLinks.length) return;

                  $actionLinks.empty();

                  // Build dynamic links
                  (rows || []).forEach(function (r) {
                      if (r.flagCode === 'AR' || r.flagCode === 'RR') {
                          isChecklistMandatory = r.isChecklistMandatory;
                      }
                      if (r.flagCode === 'RT') {
                          IsCheckIResumeTimesheet = r.shouldDisplay;
                      }
                      SelectedWF = r.wfid;
                      // Filter: show Resume Timesheet only when TagID == 32
                      if (r.flagCode === 'RT' && TagID !== 32) {
                          return; // skip plotting this link
                      }
                      if (r.shouldDisplay === true || r.shouldDisplay === '1') {
                          const linkHtml = `
                         <a href="javascript:;" 
                             data-flag-code="${r.flagCode || ''}"
                             data-flag-name="${r.flagName || ''}"
                             onclick="callIframeFunctionWBS('handleActionLink',
                                 '${r.flagCode || ''}', 
                                 '${r.flagName || ''}', 
                                 '${r.stageID || ''}', 
                                 '${r.wfid || ''}', 
                                 '${CTagID || ''}', 
                                 '${GProjectID || ''}'
                             )">
                             ${r.flagName || ''}
                         </a>`;
                          $actionLinks.append(linkHtml);
                      }
                  });

                  // Special case: TagID = 1039 → Change Request
                 // if (CTagID == 1039) {
                 //     const crLinks = `
                 //    <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#CR_ViewReportmodal">View Report</a>
                 //    <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#CR_ShowHistorymodal">Show History</a>
                 //    <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas">Close</button>
                 //<button type="button" class="btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas">
                 //        Close
                 //    </button>`;
                 //     $actionLinks.append(crLinks);
                 // }
                  // ✅ Always append Close button at the end
                  var closeBtn = `
             <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas">
                 Close
             </button>
         `;
                  //$actionLinks.append(closeBtn);

              } catch (e) {
                  console.log("Error rendering action links:", e);
              }
          }


          //For Handle Action Link Clicks
          function handleActionLink(flagCode, flagName, StageID, WFID, TagID, ProjectID) {
              // debugger;
              SelectedWF = WFID;
              SelectedStageID = StageID
              console.log('Action clicked:', flagCode, flagName);
              // Map TagID to context type
              let contextType = 'P'; // default
              switch (TagID) {
                  case "1039": contextType = 'CR'; break; // Change Request
              }

              // Handle action based on flag code
              switch (flagCode) {
                  case 'AR': // Approve Revision
                      ApproveRejectItem(CUniqueID, WFID, TagID, StageID, ProjectID, 'A', 'EditView');
                      break;

                  case 'RR': // Reject Revision
                      ApproveRejectItem(CUniqueID, WFID, TagID, StageID, ProjectID, 'R', 'EditView');
                      break;

                  case 'SFA': // Send For Approval
                      SendForApproval(CnatureOfDemandID, CUniqueID, WFID, TagID, StageID, ProjectID, 'S', 'EditView');
                      break;

                  case 'CR': // Checklist Responses
                      window.parent.$("#chcklistItemModal").modal('show');
                      const modal = window.parent.$("#chcklistItemModal");
                      GetChecklistResponses(WFID, contextType, CUniqueID, 'ActionLinks');
                      modal.find("#btnSaveChecklist").off("click").on("click", function () {
                          SaveChecklistResponses(contextType);
                      });
                      break;

                  default:
                      console.log('Unknown action:', flagCode);
              }
          }


          //For Get Checklist Response
          function GetChecklistResponses(WFID, contextType, ProjectID, FromWhere) {
              //debugger;
              const ctx = getContext();
              const fullUrl = "api/EntityApproval/GetEntityChecklist";
              const payload = JSON.stringify({
                  WFID: WFID,
                  contextType: contextType,
                  projectID: ProjectID,
                  TagID: CTagID,
                  UserID: ctx.EmployeeID
              });
              var strResult = AJAXCallWithResult(fullUrl, payload, false, "POST");
              if (strResult && strResult.details && strResult.details.length > 0) {
                  RenderChecklistTable(strResult, FromWhere);
                  const hasChecked = window.parent.$(".question-option:checked").length > 0;
                  const $saveBtn = window.parent.$("#btnSaveChecklist");

                  if (hasChecked) {
                      $saveBtn.prop("disabled", true).hide();
                  } else {
                      $saveBtn.prop("disabled", false).show();
                  }
              } else {
                  if (FromWhere != "TabDetails") {
                      window.parent.$(".modalLbl").text("CheckList :NA");
                      window.parent.$(".modalLblstage").text("Stage :" + SelectedStage);
                      window.parent.$("#checklstRespMdlTbl tbody").html("<tr><td colspan='4'  style='text-align:center!important'><%= MyBase.GetResourceString("C_NOChecklist") %>.</td></tr>");
                  } else {
                      window.parent.$("#checklistRespTab tbody").html("<tr><td colspan='4'  style='text-align:center!important'><%= MyBase.GetResourceString("C_NOChecklist") %>.</td></tr>");
                  }
              }

          }

          //For Get Checklist Response Plotting
          function RenderChecklistTable(data, FromWhere) {
              var tbody = "";
              if (FromWhere != "TabDetails") {
                  window.parent.$("#chcklistItemModal").modal('show');
                  tbody = window.parent.$("#checklstRespMdlTbl tbody");
                  tbody.empty();
              }
              else {
                  tbody = window.parent.$("#checklistRespTab tbody");
                  tbody.empty();
              }
              // Group by category (section)
              let groupedByCategory = {};
              var ChecklistName = "NA";
              data.details.forEach(item => {
                  if (!groupedByCategory[item.CategoryDescription]) {
                      groupedByCategory[item.CategoryDescription] = [];
                  }
                  groupedByCategory[item.CategoryDescription].push(item);
                  ChecklistName = item.QuestionnaireName
              });

              let srNo = 1;
              window.parent.$(".modalLbl").text("CheckList :" + ChecklistName);
              window.parent.$(".modalLblstage").text("Stage :" + SelectedStage);
              // Loop each category (section)
              for (let category in groupedByCategory) {
                  let categoryItems = groupedByCategory[category];

                  // Add section header row
                  tbody.append(`
    <tr class="bgLightGrey2">
        <td class="text-start" colspan="4"><strong>${category}</strong></td>
    </tr>
`);

                  // Group by question
                  let questionGroups = {};
                  categoryItems.forEach(item => {
                      if (!questionGroups[item.QuestionnaireQuestionID]) {
                          questionGroups[item.QuestionnaireQuestionID] = [];
                      }
                      questionGroups[item.QuestionnaireQuestionID].push(item);
                  });

                  // Render each question row
                  for (let qid in questionGroups) {
                      let questionData = questionGroups[qid];
                      let firstRow = questionData[0];
                      let selectedResponses = firstRow.Responses
                          ? firstRow.Responses.split(",").filter(x => x)
                          : [];

                      // Modified by Dipali V on 10th Dec 2025 - Check DropdownSelection flag for rendering
                      let optionHtml = '';
                      const isDropdown = firstRow.DropdownSelection === 1 || firstRow.DropdownSelection === true;
                      
                      if (isDropdown) {
                          // Modified by Dipali V on 10th Dec 2025 - Center aligned dropdown with proper placeholder
                          const selectId = `select_${firstRow.QuestionnaireQuestionID}`;
                          optionHtml = `<div class="d-flex justify-content-center"><select id="${selectId}" class="form-select form-select-sm question-option-dropdown" 
                                        data-question-id="${firstRow.QuestionnaireQuestionID}" 
                                        data-unique-id="${SelectedStageID}" style="max-width: 200px;">
                                        <option value="">Select Option</option>`;
                          questionData.forEach((opt) => {
                              const selected = selectedResponses.includes(opt.QuestionnaireOptionID.toString()) ? "selected" : "";
                              const boldClass = opt.IsNegative ? "text-danger fw-bold" : "";
                              optionHtml += `<option value="${opt.QuestionnaireOptionID}" class="${boldClass}" ${selected}>${opt.OptionDescription}</option>`;
                          });
                          optionHtml += `</select></div>`;
                      } else if (firstRow.MultipleSelection === 1 || firstRow.MultipleSelection === true) {
                          // Render as checkboxes - Updated by Dipali V on 18th Dec 2025 - Allow multiple selection
                          optionHtml = `<div class="row">`;
                          questionData.forEach((opt, i) => {
                              const checked = selectedResponses.includes(opt.QuestionnaireOptionID.toString()) ? "checked" : "";
                              const boldClass = opt.IsNegative ? "fw-bold text-danger" : "";
                              const inputId = `chk_${opt.QuestionnaireQuestionID}_${opt.QuestionnaireOptionID}`;
                              optionHtml += `
            <div class="col-sm-${Math.floor(12 / questionData.length)}">
                <div class="custom_chckbox d-inline-block">
                    <input type="checkbox" id="${inputId}" 
                           class="question-option" 
                           data-question-id="${opt.QuestionnaireQuestionID}" 
                           data-unique-id="${SelectedStageID}" 
                           data-option-id="${opt.QuestionnaireOptionID}" ${checked}>
                    <label for="${inputId}"><span></span></label>
                </div>
                <label for="${inputId}" class="${boldClass}">${opt.OptionDescription}</label>
            </div>`;
                          });
                          optionHtml += `</div>`;
                      } else {
                          // Render as radio buttons (single selection - existing behavior)
                          optionHtml = `<div class="row">`;
                          questionData.forEach((opt, i) => {
                              const checked = selectedResponses.includes(opt.QuestionnaireOptionID.toString()) ? "checked" : "";
                              const boldClass = opt.IsNegative ? "fw-bold text-danger" : "";
                              const nameAttr = `option_${opt.QuestionnaireQuestionID}`;
                              const inputId = `chk_${opt.QuestionnaireQuestionID}_${opt.QuestionnaireOptionID}`;
                              optionHtml += `
            <div class="col-sm-${Math.floor(12 / questionData.length)}">
                <div class="custom_radio d-inline-block">
                    <input type="radio" id="${inputId}" 
                           name="${nameAttr}" 
                           class="question-option" 
                           data-question-id="${opt.QuestionnaireQuestionID}" 
                           data-unique-id="${SelectedStageID}" 
                           data-option-id="${opt.QuestionnaireOptionID}" ${checked}>
                    <label for="${inputId}"><span></span></label>
                </div>
                <label for="${inputId}" class="${boldClass}">${opt.OptionDescription}</label>
            </div>`;
                          });
                          optionHtml += `</div>`;
                      }

                      // Comment box
                      let commentBox = firstRow.ShowComment
                          ? `<textarea class="form-control checklist-comment" 
                      rows="2" maxlength="200"
                      data-question-id="${firstRow.QuestionnaireQuestionID}">${firstRow.Comments || ""}</textarea>`
                          : "";

                      // Append final row
                      tbody.append(`
        <tr>
            <td>${srNo++}.</td>
            <td>${firstRow.CheckListItemName}</td>
            <td>${optionHtml}</td>
            <td>${commentBox}</td>
        </tr>
    `);
                  }
              }
          }

          //For Saved Checklist Response
          // Modified by Dipali V on 10th Dec 2025 - Added support for dropdown selections
          // Updated by Dipali V on 18th Dec 2025 - Added support for multiple checkbox selections
          function SaveChecklistResponses(contextType) {
              //debugger;
              const ctx = getContext();
              let allResponses = [];
              let isValid = true;
              let processedQuestions = new Set();

              // Process checkbox questions (MultipleSelection=1) - Updated by Dipali V on 18th Dec 2025
              const allCheckboxQuestions = window.parent.$(".question-option[type='checkbox']");
              const checkboxQuestionIDs = new Set();
              allCheckboxQuestions.each(function () {
                  checkboxQuestionIDs.add($(this).data("question-id"));
              });
              
              checkboxQuestionIDs.forEach(questionID => {
                  if (processedQuestions.has(questionID)) return;
                  
                  const selectedCheckboxes = window.parent.$(`.question-option[type='checkbox'][data-question-id='${questionID}']:checked`);
                  const comment = window.parent.$(`.checklist-comment[data-question-id='${questionID}']`).val()?.trim() || "";

                  if (selectedCheckboxes.length === 0 || comment === "") {
                      isValid = false;
                      return;
                  }

                  selectedCheckboxes.each(function () {
                      allResponses.push({
                          WFID: String(SelectedWF || ''),
                          contextType: String(contextType || ''),
                          TagID: parseInt(CTagID) || 0,
                          UserName: String(ctx.UserName || ''),
                          QuestionnaireQuestionID: parseInt(questionID) || 0,
                          QuestionnaireOptionID: parseInt($(this).data("option-id")) || 0,
                          UniqueID: parseInt($(this).data("unique-id")) || 0,
                          Comments: String(comment || '')
                      });
                  });
                  processedQuestions.add(questionID);
              });

              // Process radio button questions (SingleSelection=1)
              const allRadioQuestions = window.parent.$(".question-option[type='radio']");
              allRadioQuestions.each(function () {
                  const questionID = $(this).data("question-id");
                  if (processedQuestions.has(questionID)) return;
                  
                  const selectedOption = window.parent.$(`.question-option[type='radio'][data-question-id='${questionID}']:checked`);
                  const comment = window.parent.$(`.checklist-comment[data-question-id='${questionID}']`).val()?.trim() || "";

                  if (selectedOption.length === 0 || comment === "") {
                      isValid = false;
                      return false;
                  }

                  allResponses.push({
                      WFID: String(SelectedWF || ''),
                      contextType: String(contextType || ''),
                      TagID: parseInt(CTagID) || 0,
                      UserName: String(ctx.UserName || ''),
                      QuestionnaireQuestionID: parseInt(questionID) || 0,
                      QuestionnaireOptionID: parseInt(selectedOption.data("option-id")) || 0,
                      UniqueID: parseInt(selectedOption.data("unique-id")) || 0,
                      Comments: String(comment || '')
                  });
                  processedQuestions.add(questionID);
              });

              // Process dropdown questions
              const allDropdownQuestions = window.parent.$(".question-option-dropdown");
              allDropdownQuestions.each(function () {
                  const questionID = $(this).data("question-id");
                  if (processedQuestions.has(questionID)) return;
                  
                  const selectedValue = $(this).val();
                  const uniqueID = $(this).data("unique-id");
                  const comment = window.parent.$(`.checklist-comment[data-question-id='${questionID}']`).val()?.trim() || "";

                  if (!selectedValue || comment === "") {
                      isValid = false;
                      return false;
                  }

                  allResponses.push({
                      WFID: String(SelectedWF || ''),
                      contextType: String(contextType || ''),
                      TagID: parseInt(CTagID) || 0,
                      UserName: String(ctx.UserName || ''),
                      QuestionnaireQuestionID: parseInt(questionID) || 0,
                      QuestionnaireOptionID: parseInt(selectedValue) || 0,
                      UniqueID: parseInt(uniqueID) || 0,
                      Comments: String(comment || '')
                  });
                  processedQuestions.add(questionID);
              });

              if (!isValid) {
                  window.parent.alertify.error("<%= MyBase.GetResourceString("C_Respond") %>");
                  return;
              }

              if (allResponses.length === 0) {
                  window.parent.alertify.error("<%= MyBase.GetResourceString("C_NoResponse") %>");
                  return;
              }

              // Send to API (bulk save)
              const payload = JSON.stringify({ responses: allResponses });
              const fullUrl = "api/EntityApproval/SaveEntityChecklistResponses";
              
              // Debug: Log payload for troubleshooting
              console.log("Checklist Save Payload:", payload);
              
              const result = AJAXCallWithResult(fullUrl, payload, false, "POST");

              // Enhanced error handling for parameter mismatch
              if (!result || !Array.isArray(result) || result.length === 0) {
                  console.error("API Error - Invalid Response:", result);
                  const errorMsg = result?.message || result?.Message || "Parameter mismatch - Please check API deployment";
                  window.parent.alertify.error("Error: " + errorMsg);
                  return;
              }

              if (result[0].success=="1") {
                  window.parent.alertify.success("<%= MyBase.GetResourceString("C_Saved") %>");
                  window.parent.$("#chcklistItemModal").modal('hide');
              } else {
                  window.parent.alertify.error("Error saving checklist responses.");
              }
          }


          //For Approve Change Request /Reject Action
          function ApproveRejectItem(UniqueID, workflowId, tagId, StageID, ProjectID, Action, FromWhere) {
              //debugger;
              GFromWhere = FromWhere;
              SelectedWF = workflowId;
              CTagID = parseInt(tagId);
              GProjectID = ProjectID;
              CUniqueID = UniqueID;
              GChangeRequestID_PK = UniqueID;
              SelectedStageID = StageID;
              var Caption = "";
              var btn = "";

              GFromWhere = FromWhere;
              WhichActionWF = Action
              SelectedWF = workflowId
              GetActionLinks(CTagID, GProjectID, CUniqueID);
              //GMilestoneID = ProjectID
              //if (IsCheckIResumeTimesheet == false) {
                  if (Action == 'A') {
                      Caption = '<%= MyBase.GetResourceString("C_ApproveRevision") %>'
                      btn = 'Approve'
                  } else {
                      Caption = '<%= MyBase.GetResourceString("C_RejectRevision") %>'
                      btn = 'Reject'
                  }
                  window.parent.$("#approveRevModal").modal('show');
                  window.parent.$("#ApproveRejectLabel").text(Caption);
                  window.parent.$("#lblAppRejectCaption").text(Caption);
                  window.parent.$("#txtWFARComments").val('');
                  window.parent.$("#ActionLinkCaption").text(btn);
                  const modal = window.parent.$("#approveRevModal");
                  modal.find("#ActionLinkCaption").off("click").on("click", function () {
                      ApproveRejectClick();
                  });
              <%--} else {
                  var alert = "<%= MyBase.GetResourceString("C_ResumeTimesheet") %>";
                  window.parent.$("#Conformationmodel").modal('show');
                  window.parent.$("#PMSG").html(alert);
                  const modal = window.parent.$("#Conformationmodel");
                  modal.find("#btnConfirmation").off("click").on("click", function () {
                      AllowtoApproveTimesheetblock();
                  });

                  const modal_Approve = window.parent.$("#approveRevModal");
                  modal_Approve.find("#ActionLinkCaption").off("click").on("click", function () {
                      ApproveRejectClick();
                  });
              }--%>
          }

          //For Allow Timesheet Block
          function AllowtoApproveTimesheetblock(IsCheckIResumeTimesheet) {
              var Caption = "", btn = "";
              if (WhichActionWF == 'A') {
                  Caption = 'Approve Revision'
                  btn = 'Approve'
              } else {
                  Caption = 'Reject Revision'
                  btn = 'Reject'
              }
              window.parent.$("#approveRevModal").modal('show');
              window.parent.$("#ApproveRejectLabel").text(Caption);
              window.parent.$("#lblAppRejectCaption").text(Caption);
              window.parent.$("#ActionLinkCaption").text(btn);
              window.parent.$("#txtWFARComments").val('');

          }


          //Close Approve Reject Model
          function CloseAppReject() {
              window.parent.$("#approveRevModal").modal('hide');

          }

          //For Send For Approval Action
          var selectedWorkflow = 0;
          function SendForApproval(natureOfDemandID,UniqueID, workflowId, tagId, StageID, ProjectID, Action, FromWhere) {
              selectedWorkflow = natureOfDemandID;
              CnatureOfDemandID = natureOfDemandID;
              window.parent.$("#txtWFComments").val('');
              GFromWhere = FromWhere;
              GProjectID = ProjectID;
              CUniqueID = UniqueID;
              GetWorkFlow();
              const modal = window.parent.$("#divSendForApproval");
              window.parent.$("#divSendForApproval").modal('show');
              window.parent.$("#lblCaption").text('Send For Approval');
              modal.find("#btnSubmit").off("click").on("click", function () {
                  SubmitonClick();
              });
          }

          //For Get Workflow Details
          function GetWorkFlow(ProjectID) {
              const ctx = getContext(); // Assuming this gives user context info
              const fullUrl = "api/EntityApproval/GetWorkFlow";

              const payload = JSON.stringify({
                  TagID: CTagID,
                  ProjectID: GProjectID
              });

              // Call your reusable AJAX helper
              const strResult = AJAXCallWithResult(fullUrl, payload, false, "POST");

              const $wfDropdown = window.parent.$("#cboWF");
              $wfDropdown.empty();

              // ✅ Match API response structure: message + workflowDetails
              if (strResult.length > 0) {
                  const workflows = strResult;

                  // Default option
                  $wfDropdown.append($("<option>", { value: "", text: "-- Select Workflow --" }));

                  // Populate options
                  workflows.forEach(wf => {
                      $wfDropdown.append($("<option>", {
                          value: wf.projectNatureofDemandID,
                          text: wf.natureOfDemand
                      }));
                  });

                  // Remove any invalid or empty options
                  $wfDropdown.find("option").filter(function () {
                      return !this.value || $.trim(this.text).length === 0;
                  }).remove();

                  // Restore previously selected workflow (if available)
                  if (typeof selectedWorkflow !== "undefined" && selectedWorkflow !== "" && selectedWorkflow !== "0") {
                      $wfDropdown.val(selectedWorkflow);
                  }
              } else {
                  console.warn("No workflows found or invalid API response.");
                  $wfDropdown.append($("<option>", { value: "", text: "No Workflows Available" }));
              }
          }


          //For Send for approval action
          function SubmitonClick() {
              var fullUrl = "api/EntityApproval/EntitySendForApproval"
              var comments = window.parent.$("#txtWFComments").val();
              var cboWF = window.parent.$("#cboWF").val();

              if (cboWF == 0) {
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify('Please Select Workflow', 'error', 25);
                  } else {
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify('Please Select Workflow', 'error', 25);
                  }

                  window.parent.$("#cboWF").focus();
                  return false;
              }
              if (!comments) {
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                  } else {
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                  }

                  window.parent.$("#txtWFComments").focus();
                  return false;
              }

              if (checkSpecialCharacter(comments, WebConfigSpecialCharacters)) {
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.error('<%= MyBase.GetResourceString("C_CommentSpecial") %> : ' + WebConfigSpecialCharacters);
                  } else {
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.error('<%= MyBase.GetResourceString("C_CommentSpecial") %> : ' + WebConfigSpecialCharacters);
                  }

                  window.parent.$("#txtWFComments").focus();
                  return false;
              }
             var strAction = "SYS_SUBMIT";
             const ctx = getContext();
             //UniqueID = GProjectID;
             var payload = {
                 UserID: ctx.EmployeeID,
                 ProjectID: GProjectID,
                 UniqueID: CUniqueID,
                 Comments: comments,
                 TagID: CTagID,
                 strAction: strAction,
                 WFID: window.parent.$("#cboWF").val()
             };
              // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
             var param = JSON.stringify(payload);
             try {
                 var strResult = AJAXCallWithResult(fullUrl, param, false, "POST");
                 console.log('Get Project SFA: ', strResult);
                 
                 if (strResult && strResult.result === "Success") {
                     if (window.parent && window.parent.alertify) {
                         window.parent.alertify.set('notifier', 'position', 'top-right');
                         window.parent.alertify.notify('<%= MyBase.GetResourceString("C_SFA") %>', 'success', 25);
                     } else {
                         alertify.set('notifier', 'position', 'top-right');
                         alertify.notify('<%= MyBase.GetResourceString("C_SFA") %>', 'success', 25);
                     }

                     if (window.parent && window.parent.$) {
                         window.parent.$("#divSendForApproval").modal('hide');
                     }

                     if (GFromWhere.toLowerCase() === "editview") {
                         var offcanvasEl = window.parent.document.getElementById('CReq_DetailsOffcanvas');
                         window.parent.bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).hide();
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

          //For Approve Reject Click Action
          function ApproveRejectClick() {
              var fullUrl = "api/EntityApproval/EntityApproveReject"
              var comments = window.parent.$("#txtWFARComments").val();
              if (!comments) {
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
              if (checkSpecialCharacter(comments, WebConfigSpecialCharacters)) {
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
              var strAction = "";
              if (WhichActionWF == 'A') {
                      strAction = "SYS_APPROVE";
                  }
                  else {
                      strAction = "SYS_REJECT";
              }

              UniqueID = GChangeRequestID_PK;

              // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
              var payload = {
                  UserID: ctx.EmployeeID,
                  ProjectID: GProjectID,
                  UniqueID: UniqueID,
                  Comments: comments,
                  TagID: CTagID,
                  strAction: strAction
              };
              var param = JSON.stringify(payload);
              
              try {
                  var strResult = AJAXCallWithResult(fullUrl, param, false, "POST");
                  console.log('Get Project Approve/Reject: ', strResult);
                  
                  if (strResult && strResult.result === "Success") {
                      var Status = (WhichActionWF === "A") ?
                           "<%= MyBase.GetResourceString("C_ApproveRevisionAlert") %>" :
                          "<%= MyBase.GetResourceString("C_RejectRevisionAlert") %>";

                      if (window.parent && window.parent.alertify) {
                          window.parent.alertify.set('notifier', 'position', 'top-right');
                          window.parent.alertify.notify(Status, 'success', 25);
                      } else {
                          alertify.set('notifier', 'position', 'top-right');
                          alertify.notify(Status, 'success', 25);
                      }

                      if (window.parent && window.parent.$) {
                          window.parent.$("#approveRevModal").modal('hide');
                      }

                      if (GFromWhere.toLowerCase() === "editview" && CTagID == 32) {
                          GetActionLinks(CTagID, GProjectID, UniqueID);
                      }

                      if (GFromWhere.toLowerCase() === "editview") {
                          var offcanvasEl = window.parent.document.getElementById('CReq_DetailsOffcanvas');
                          window.parent.bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).hide();
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


          //For Bind WBS Details
          function bindWBSDetails(entityTypeID, projectData, DivID) {
              //debugger;
              var fieldMappings = "";
              if (entityTypeID === CTagID) {
                  fieldMappings = {
                      'Change Request:': projectData.changeRequestSummary || 'N/A',
                      'Change Requestor:': projectData.changeRequestedBy || 'N/A',
                      'Change Requested Date:': formatDate(projectData.changeRequestDate) || 'N/A',
                      'Module:': projectData.moduleName || 'N/A',
                      'Version:': projectData.version || 'N/A',
                      'Change Priority:': projectData.changePriority || 'N/A',
                      'Description:': projectData.changeRequestDescription || 'N/A',
                      'Benefits:': projectData.changeBenefits || 'N/A',
                      'Category:': projectData.changeCategory || 'N/A',
                      'Estimation Document Reference:': projectData.estimationDocumentReference || 'N/A',
                      'Approved By:': projectData.approvedBy || 'N/A',
                      'Approved Date:': formatDate(projectData.approvedDate) || 'N/A',
                      'Rejected By:': projectData.rejectedBy || 'N/A',
                      'Rejected Date:': formatDate(projectData.rejectedDate) || 'N/A',
                      'Change Status:': projectData.changeStatus || 'N/A',
                      'Cost of Change:': projectData.costOfChange || '0',
                      'Deliverable:': projectData.title || 'N/A'

                  };

              }


              bindDataToHTML(fieldMappings, DivID);
              GetCurrentWFStatus(projectData.currentWFStatus, projectData.requeststage);
              GetActionLinks(entityTypeID, projectData.projectID, projectData.changeRequestID_PK);
              GProjectName = projectData.projectName
              GProjectID = projectData.projectID
              SelectedWF = projectData.workflowInstanceID;
              SelectedStage = projectData.requeststage;
              SelectedProjectData = projectData;
              CUniqueID = projectData.changeRequestID_PK;
              SelectedStageID = projectData.requeststageID;
              // === Send offcanvas HTML to parent for rendering ===
              const offcanvasEl = document.getElementById('CReq_DetailsOffcanvas');
              if (!offcanvasEl) {
                  console.warn("Offcanvas element not found in iframe.");
                  return;
              }

              // get HTML string
              const offcanvasHTML = offcanvasEl.outerHTML;

              // send to parent
              window.parent.postMessage({
                  action: "renderOffcanvas",
                  html: offcanvasHTML,
                  projectID: projectData.projectID || null
              }, "*");

             
          }

          //For Get Workflow Details
          function GetWFDetails(UniQueID, entityTypeID) {
             // debugger;
              if (entityTypeID == 0) {
                  entityTypeID = CTagID
              }
              if (UniQueID == 0) {
                  UniQueID = CUniqueID
              } else {
                  CUniqueID = UniQueID
              }
              GChangeRequestID_PK = CUniqueID;
       
              SelectedProjectData = StrResult.find(item =>
                  parseInt(item.changeRequestID_PK) === parseInt(GChangeRequestID_PK)
              );
             var fieldMappings = "";
             
              fieldMappings = {
                  'Change Request:': SelectedProjectData.changeRequestSummary || 'N/A',
                  'Project Name:': SelectedProjectData.projectName || 'N/A',
                  'Change Category:': SelectedProjectData.changeCategory || 'N/A',
                  'Change Request Date:': formatDate(SelectedProjectData.changeRequestDate) || 'N/A',
                  'Change Priority:': SelectedProjectData.changePriority || 'N/A'

              };
              
              SelectedWF = SelectedProjectData.workflowInstanceID;
              SelectedStageID = SelectedProjectData.requeststageID;
              populateDetailsSection('WF_DetlsDeskModal', fieldMappings)
              GetApprovalStages();
              GetWFHistoryDetails();
              window.parent.$("#projShowStatusModal").modal('show');
              
          }

          //For Populate Details Section
          function populateDetailsSection(containerId, data) {
              var $container = window.parent.$('#' + containerId);
              if (!$container.length) return;

              // Clear existing content
              $container.empty();

              // Create the HTML structure
              var html = `
                <div class="row">
                    <div class="details-main-sec">
                        <div class="d-sec1 px-4">
                            <table class="table details-table1 mb-0">
                                <tbody></tbody>
                            </table>
                        </div>
                        <div class="d-sec2 px-4">
                            <table class="table details-table2 mb-0">
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
`;

              $container.html(html);

              // Separate fields into two columns
              var fields = Object.keys(data);
              var midPoint = Math.ceil(fields.length / 2);
              var leftColumnFields = fields.slice(0, midPoint);
              var rightColumnFields = fields.slice(midPoint);

              // Populate left column
              var $leftTbody = $container.find('.details-table1 tbody');
              leftColumnFields.forEach(function (field) {
                  if (data[field]) { // Only add if data exists
                      var row = `
            <tr>
                <td class="text-end">
                    <label>${formatLabel(field)}</label>
                </td>
                <td class="text-start">${data[field]}</td>
            </tr>
        `;
                      $leftTbody.append(row);
                  }
              });

              // Populate right column
              var $rightTbody = $container.find('.details-table2 tbody');
              rightColumnFields.forEach(function (field) {
                  if (data[field]) { // Only add if data exists
                      var row = `
            <tr>
                <td class="text-end">
                    <label>${formatLabel(field)}</label>
                </td>
                <td class="text-start">${data[field]}</td>
            </tr>
        `;
                      $rightTbody.append(row);
                  }
              });

              // If no data available
              if (fields.length === 0 || !fields.some(field => data[field])) {
                  $container.html('<div class="text-center py-3"><%= MyBase.GetResourceString("C_NoData") %></div>');
              }
          }

          //For Format Label
          function formatLabel(fieldName) {
              // Convert camelCase to Title Case with spaces
              return fieldName
                  .replace(/([A-Z])/g, ' $1')
                  .replace(/^./, function (str) { return str.toUpperCase(); })
                  .trim();
          }


          //For Get Approval Stages
          function GetApprovalStages() {
              // Localize the tracking flag
              let blnIsCurrentStagePassed = false;

              var projectParameters = {
                  EmployeeID: CUniqueID,
                  TagID: CTagID
              };

              var fullUrl = "api/EntityApproval/GetApprovalStages";
              var payload = JSON.stringify(projectParameters);
              var approvalHistory = [];

              try {
                  approvalHistory = AJAXCallWithResult(fullUrl, payload, false, "POST");
                  console.log('Get Approval Stages: ' + JSON.stringify(approvalHistory));
              } catch (e) { approvalHistory = []; }

              var $tbody = window.parent.$('#WF_projApprovalStage tbody');
              $tbody.empty();

              if (!approvalHistory || approvalHistory.length === 0) {
                  $tbody.append('<tr><td colspan="6" class="text-center">No workflow data available</td></tr>');
                  return;
              }

              // Define color logic *inside the same scope* so flag state is shared correctly
              function getHistoryDotClassFromFlags(item) {
                  if (!item) return 'dot-grey';

                  let blnIsCurrentStage = (item.isCurrentStage === 1);
                  let intIsDelayed = item.isDelayed || 0;
                  let strRequestStageID = (item.requestStageID || '').toString();
                  let strFillColor = 'dot-green';

                  if (blnIsCurrentStage) {
                      if (intIsDelayed !== 0 && strRequestStageID !== "3") {
                          strFillColor = 'dot-red'; // Delayed_CurrentStage_R.gif
                      } else if (strRequestStageID === "3") {
                          strFillColor = 'dot-green'; // ClearedStage_R.gif
                      } else {
                          strFillColor = 'dot-yellow'; // CurrentStage_R.gif
                      }

                      blnIsCurrentStagePassed = true;
                  } else if (!blnIsCurrentStage && blnIsCurrentStagePassed) {
                      strFillColor = 'dot-grey'; // Stage_Not_Reached_R.gif
                  }

                  return strFillColor;
              }

              // Now iterate and render rows
              approvalHistory.forEach(function (item) {
                  var isWorkflowCompletion =
                      item.fromStage === "Complete" &&
                      item.stageStatus === 'Completed' &&
                      item.toStage === '' &&
                      item.approvedBy === '';

                  var statusDot = '<span class="wf-dot ' + getHistoryDotClassFromFlags(item) + '"></span>';

                  let tr;
                  if (isWorkflowCompletion) {
                      tr = `
      <tr>
          <td style="width:80px;">${statusDot}</td>
          <td>${item.fromStage || 'N/A'}</td>
          <td></td><td></td><td></td><td></td>
      </tr>`;
                  } else {
                      tr = `
      <tr>
          <td style="width:80px;">${statusDot}</td>
          <td>${item.fromStage || 'N/A'}</td>
          <td>${item.toStage || 'N/A'}</td>
          <td>${item.eventDate || 'N/A'}</td>
          <td>${item.approvedBy || 'N/A'}</td>
          <td>${item.approverList || ''}</td>
      </tr>`;
                  }

                  $tbody.append(tr);
              });
          }


          //For Get Workflow History Details
          /* ── WF History Pagination state ── */
          var _wfHistoryData = [];
          var _wfHistPage = 1;
          var _wfHistItemsPerPage = 5;

          function GetWFHistoryDetails() {

              var projectParameters =
              {
                  WorkflowID: SelectedWF,
                  ProjectID: CUniqueID,
                  TagID: CTagID
              };

              // NEW FROMBODY APPROACH - Following ApproveRejectPT pattern
              var fullUrl = "api/EntityApproval/GetWFHistoryDetails";
              var payload = JSON.stringify(projectParameters);
              var approvalHistory = [];
              try {
                  approvalHistory = AJAXCallWithResult(fullUrl, payload, false, "POST");
                  console.log('Get WFHistory Details: ' + JSON.stringify(approvalHistory));

              } catch (e) { approvalHistory = []; }

              // Store all data and reset to page 1
              _wfHistoryData = (approvalHistory && approvalHistory.length > 0) ? approvalHistory : [];
              _wfHistPage = 1;

              // Ensure pagination UI exists in the parent next to WF_ApprHisTable
              _wfHistEnsurePaginationUI();

              // Render first page
              _wfHistRenderPage();
          }

          function _wfHistRenderPage() {
              var $tbody = window.parent.$('#WF_ApprHisTable tbody');
              $tbody.empty();

              if (!_wfHistoryData || _wfHistoryData.length === 0) {
                  $tbody.append('<tr><td colspan="6" class="text-center">No workflow data available</td></tr>');
                  _wfHistUpdatePagination();
                  return;
              }

              var startIdx = (_wfHistPage - 1) * _wfHistItemsPerPage;
              var endIdx   = Math.min(startIdx + _wfHistItemsPerPage, _wfHistoryData.length);

              for (var i = startIdx; i < endIdx; i++) {
                  var item = _wfHistoryData[i];
                  var tr = '<tr>' +
                      '<td>' + (formatDateTime(item.eventTime) || 'N/A') + '</td>' +
                      '<td>' + (item.actionType || 'N/A') + '</td>' +
                      '<td>' + (item.fromStage || 'N/A') + '</td>' +
                      '<td>' + (item.toStage || 'N/A') + '</td>' +
                      '<td>' + (item.userName || '') + '</td>' +
                      '<td>' + truncateWithTooltip(item.comments || '', 50) + '</td>' +
                      '</tr>';
                  $tbody.append(tr);
              }

              // Initialize tooltips for the newly added rows
              window.parent.$('[data-bs-toggle="tooltip"]').tooltip();
              _wfHistUpdatePagination();
          }

          function _wfHistUpdatePagination() {
              var total      = _wfHistoryData.length;
              var totalPages = Math.ceil(total / _wfHistItemsPerPage) || 1;

              var pd = (window.parent && window.parent.document) ? window.parent.document : document;

              var totalEl = pd.getElementById('wfHistTotalRecords');
              if (totalEl) totalEl.textContent = total;

              var prevLi = pd.getElementById('wfHistBtnPrev');
              var prevA  = pd.getElementById('wfHistLinkPrev');
              var nextLi = pd.getElementById('wfHistBtnNext');
              var nextA  = pd.getElementById('wfHistLinkNext');

              var disabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;';
              var enabledAStyle  = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#1359a6;background-color:#fff;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:auto;cursor:pointer;transition:all 0.3s ease;';

              // Previous button
              if (_wfHistPage <= 1 || total === 0) {
                  if (prevLi) prevLi.style.cursor = 'not-allowed';
                  if (prevA)  { prevA.setAttribute('style', disabledAStyle); prevA.removeAttribute('onclick'); }
              } else {
                  if (prevLi) prevLi.style.cursor = 'pointer';
                  if (prevA)  { prevA.setAttribute('style', enabledAStyle); prevA.setAttribute('onclick', 'window.frames[0]._wfHistGoToPrev()'); }
              }

              // Next button
              if (_wfHistPage >= totalPages || total === 0) {
                  if (nextLi) nextLi.style.cursor = 'not-allowed';
                  if (nextA)  { nextA.setAttribute('style', disabledAStyle); nextA.removeAttribute('onclick'); }
              } else {
                  if (nextLi) nextLi.style.cursor = 'pointer';
                  if (nextA)  { nextA.setAttribute('style', enabledAStyle); nextA.setAttribute('onclick', 'window.frames[0]._wfHistGoToNext()'); }
              }
          }
          window._wfHistGoToPrev = function () {
              if (_wfHistPage > 1) { _wfHistPage--; _wfHistRenderPage(); }
          };

          window._wfHistGoToNext = function () {
              var totalPages = Math.ceil(_wfHistoryData.length / _wfHistItemsPerPage) || 1;
              if (_wfHistPage < totalPages) { _wfHistPage++; _wfHistRenderPage(); }
          };

          function _wfHistEnsurePaginationUI() {
              var pd = (window.parent && window.parent.document) ? window.parent.document : document;
              if (pd.getElementById('wfHistoryPagination')) return;

              var div = pd.createElement('div');
              div.id = 'wfHistoryPagination';
              div.setAttribute('style', 'display:flex;justify-content:flex-end;align-items:center;gap:1rem;padding:8px 4px 4px;');

              div.innerHTML =
                  '<div id="wfHistInfoDiv" style="color:#333;font-size:14px;font-weight:300;">' +
                      '<span>Total Records: </span>' +
                      '<span id="wfHistTotalRecords">0</span>' +
                  '</div>' +
                  '<nav aria-label="WF History navigation">' +
                      '<ul style="display:flex;list-style:none;margin:0;padding:0;gap:4px;">' +
                          '<li id="wfHistBtnPrev" style="cursor:not-allowed;">' +
                              '<a id="wfHistLinkPrev" aria-label="Previous" title="Previous Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-left"></i>' +
                              '</a>' +
                          '</li>' +
                          '<li id="wfHistBtnNext" style="cursor:not-allowed;">' +
                              '<a id="wfHistLinkNext" aria-label="Next" title="Next Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-right"></i>' +
                              '</a>' +
                          '</li>' +
                      '</ul>' +
                  '</nav>';

              // Insert right after #WF_ApprHisTable
              var tbl = pd.getElementById('WF_ApprHisTable');
              if (tbl && tbl.parentNode) {
                  tbl.parentNode.insertBefore(div, tbl.nextSibling);
              }
          }
          //For Format Date Time
          function formatDateTime(isoString) {
              if (!isoString) return 'N/A';

              const date = new Date(isoString);
              if (isNaN(date.getTime())) return 'Invalid Date';

              // Format: 08 Oct 2025, 19:49
              const options = {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric',
                  hour: '2-digit',
                  minute: '2-digit',
                  hour12: false
              };

              return date.toLocaleDateString('en-GB', options);
          }

          //For Bind Data To HTML
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


          //For Update Value With Icons
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

          //For Check Special Character
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


          //For Get Current Workflow Status
          function GetCurrentWFStatus(currentWFStatus, requeststage) {
              //debugger;
              let statusText = "";
              let colorClass = "";

              if (currentWFStatus === "Approval In Progress" || currentWFStatus === "Pending Approval") {
                  statusText = "Sent for Approval";
                  colorClass = "color-orange";
              }
              else if (currentWFStatus === "") {
                  statusText = "Sent for Approval";
                  colorClass = "color-orange";
              }
              else if (currentWFStatus === "Rejected") {
                  statusText = "Rejected";
                  colorClass = "color-red";
              }
              else if (currentWFStatus === "Approved") {
                  statusText = "Approved";
                  colorClass = "color-green";
              }
              var wfStatusElement;
              wfStatusElement = $(".WFCStatus").text(statusText + (statusText ? ' (Stage: ' + requeststage + ')' : ''));
              // Remove any existing color classes and add the new one
              wfStatusElement.removeClass("color-orange color-red color-green");
              if (colorClass) {
                  wfStatusElement.addClass(colorClass);
              }
          }


          //For Format Currency
          function formatCurrency(amount) {
              if (amount == null) return '0.00';
              return parseFloat(amount).toLocaleString('en-IN', {
                  minimumFractionDigits: 2,
                  maximumFractionDigits: 2
              });
          }

        
          //For Format Work Hours
          function formatWorkHours(hours) {
              if (!hours) return '00:00';
              if (typeof hours === 'number') {
                  return hours.toFixed(2);
              }
              return hours;
          }


          //For Format Date
          function formatDate(dateString) {
              if (!dateString) return null;
              const date = new Date(dateString);
              return date.toLocaleDateString('en-GB', {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric'
              }).replace(/ /g, '-');
          }


          //For Format Effort To HHMM
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

          //For Generate Card
          function generateCard(r, tagId, index) {
              let card = '';
              const cardId = getCardId(tagId, index);

              switch (tagId) {
                  case 1039: // Sub Project
                      var stageName = (r.requeststage || r.currentStage || '').trim().toLowerCase();
                      var hasEditAccess = (EditAccess === true || EditAccess === 'True');
                      var actionButtons = '';

                      // Determine which buttons to show
                      if (stageName === 'start') {
                          if (hasEditAccess) {
                              actionButtons = [
                                  '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" ',
                                  'data-bs-original-title="Send for Approval" ',
                                  'onclick="SendForApproval(\'' + (r.natureOfDemandID || '') + '\',\'' + (r.changeRequestID_PK || '') + '\', \'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + (r.requeststageID || 0) + ',' + (r.projectId || 0) + ',\'S\',\'CardView\')">',
                                  '<i class="fas fa-paper-plane text-blue"></i></button>'
                              ].join('');
                          }
                      } else if (stageName !== 'complete') {
                          if (hasEditAccess) {
                              actionButtons = [
                                  '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" ',
                                  'data-bs-original-title="Approve" ',
                                  'onclick="ApproveRejectItem(\'' + (r.changeRequestID_PK || '') + '\', \'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + r.requeststageID + ',' + r.projectId + ',\'A\',\'CardView\')">',
                                  '<i class="far fa-thumbs-up text-green"></i></button>',
                                  '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" ',
                                  'data-bs-original-title="Reject" ',
                                  'onclick="ApproveRejectItem(\'' + (r.changeRequestID_PK || '') + '\', \'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + r.requeststageID + ',' + r.projectId + ',\'R\',\'CardView\')">',
                                  '<i class="far fa-thumbs-down textRed"></i></button>'
                              ].join('');
                          }
                      }

                      // Build Card HTML
                      card = [
                          '<div class="col-12">',
                          '<div class="WF_Card" id="' + cardId + '">',
                          '<div class="card shadowBox yelllowBrdr">',
                          '<div class="card-body pt-2">',

                          // Header Row
                          '<div class="row">',
                          '<div class="col-md-6 col-sm-6 col-6">',
                          '<div class="d-flex">',
                          '<h5 class="card-title mb-2">' + (r.changeRequestSummary || '') + '</h5>',
                          '</div>',
                          '</div>',
                          '<div class="col-md-6 col-sm-6 col-6">',
                          '<div class="card-item justify-content-sm-end mb-1 text-end">',
                          '<div class="cardContent">',
                          '<span class="CardStageTitle"><%= MyBase.GetResourceString("C_CS") %>:</span>',
                          '<span>' + (r.requeststage || r.currentStage || '') + '</span>',
                          '</div>',
                          '</div>',
                          '</div>',
                          '</div>',

                          // Approver and Code Row
                          '<div class="row">',
                          '<div class="col-md-12 col-sm-12">',
                          '<div class="row">',
                          '<div class="col-sm-3 col-12">',
                          '<p class="cardProjCode mb-2 mb-sm-0">' + (r.projectName || '') + '</p>',
                          '</div>',
                          '<div class="col-sm-9 col-12">',
                          '<div class="card-item justify-content-sm-end mb-1 text-end">',
                          '<div class="cardContent">',
                          '<span class="CardStageTitle"><%= MyBase.GetResourceString("C_Stage_Approver") %>:</span>',
                          '<img src="../../../Whizible2.0-new/dist/img/profile-pic.jpg" alt="" class="img-fluid resImg mx-2">',
                          '<span>' + (r.currentApprover || 'Approver') + '</span>',
                          '</div>',
                          '</div>',
                          '</div>',
                          '</div>',
                          '</br>',
                          // Revision Row
                          '<div class="row mt-1">',
                          '<div class="col-md-4 col-sm-6">',
                          '<div class="card-item mb-1">',
                          '<div class="cardContent">',
                          '<span class="CardValueTitle"><%= MyBase.GetResourceString("C_RevisionDetails") %>:</span>',
                          
                          '</div>',
                          '</div>',
                          '</div>',
                          '</div>',

                          // Dates and Effort
                          '<div class="row mb-2">',
                          '<div class="col-md-4 col-sm-4">',
                          '<div class="card-item mb-1">',
                          '<div class="cardLeftImg"><i class="far fa-calendar-check iconBlue pe-1"></i></div>',
                          '<div class="cardContent"><span class="CardViewTitle"><%= MyBase.GetResourceString("C_RequestedDate") %>:</span> ' + (r.changeRequestDate ? formatDate(r.changeRequestDate) : 'N/A') + '</div>',
                          '</div>',
                          '</div>',
                          '<div class="col-md-4 col-sm-4">',
                          '<div class="card-item mb-1">',
                          '<div class="cardLeftImg"><i class="far fa-calendar-check iconBlue pe-1"></i></div>',
                          '<div class="cardContent"><span class="CardViewTitle"><%= MyBase.GetResourceString("C_RequestStatus") %>:</span> ' + (r.changeStatus ? r.changeStatus : 'N/A') + '</div>',
                          '</div>',
                          '</div>',
                          '<div class="col-md-4 col-sm-4">',
                          '<div class="card-item mb-1">',
                          '<div class="cardLeftImg"><i class="fas fa-task iconBlue pe-1"></i></div>',
                          '<div class="cardContent"><span class="CardViewTitle"><%= MyBase.GetResourceString("C_Priority") %>:</span> ' + (r.changePriority ? r.changePriority : 'N/A') + '</div>',
                          '</div>',
                          '</div>',
                          '</div>',

                          // Requestor + Actions
                          '<div class="row mt-2">',
                          '<div class="col-md-8 col-sm-8 col-8">',
                          '<div class="card-item mb-1">',
                          '<div class="cardContent">',
                          '<span class="CardValueTitle"><%= MyBase.GetResourceString("C_Requestor") %>:</span>',
                          '<img src="../../../Whizible2.0-new/dist/img/profile-pic.jpg" alt="" class="img-fluid resImg mx-2">',
                          '<span>' + (r.changeRequestedBy || 'N/A') + '</span>',
                          '</div>',
                          '</div>',
                          '</div>',

                          '<div class="col-md-4 col-sm-4 col-4">',
                          '<div class="card-item mb-1">',
                          '<div class="Action_col position-relative">',
                          '<div class="mobAppRejButns d-flex text-end">',
                          actionButtons,
                          '</div>',
                          '</div>',
                          '</div>',
                          '</div>',
                          '</div>', // row

                          '</div>', // col-md-12
                          '</div>', // row
                          '</div>', // card-body
                          '</div>', // card
                          '</div>', // WF_Card
                          '</div>' // col
                      ].join('');
                      break;
              }

              return card;
          }

      //For Get Card Id
          function getCardId(tagId, index) {
              const prefixMap = {
                  1039: 'ChangeReqCard'
                  
              };
              const prefix = prefixMap[tagId] || 'WF_Card';
              return prefix + index;
          }


          //For AJAX Call With Result
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


          //For Hide Page Loader
          function hidePageLoader() {
              setTimeout(function () {
                  $('#pageLoaderEntity').fadeOut(400, function () {
                      $(this).remove();
                  });
                  $('body').removeClass('page-loading');
                  $('.main-content-wrapper').addClass('loaded');
              }, 200);
          }

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
          // Custom Pagination - matching PM_EntityModuleApproval.aspx - Vaibhav K
          // ============================================================
          let currentPage = 1;
          const itemsPerPage = 5;
          let totalPages = 1;

          function showPageRows() {
              var $tbody = $('#ChangeReqTable tbody');
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
              var $tbody = $('#ChangeReqTable tbody');
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
