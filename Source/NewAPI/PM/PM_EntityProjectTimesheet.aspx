<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityProjectTimesheet.aspx.vb" Inherits="Whizible.PM_EntityProjectTimesheet" %>
<!DOCTYPE html>
<html >
  <%CommonFunctions.General.PlotPageHeadTag("Entity Approval")%>
    <head runat="server">
 <meta charset="utf-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <title><%= MyBase.GetResourceString("C_PageName") %></title>
 <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
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
    li#btnprevious.page-item.fa-disabled { cursor: not-allowed; }
    li#btnnext.page-item.fa-disabled { cursor: not-allowed; }
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
         <!-- Project Timesheet Entity Start here -->
            <!-- Project Timesheet Entity Start here -->
            <div id="ProjTSEntity" class="allEntity col-sm-12">
                <%-- Modified by Dipali V on 2nd Dec 2025 - Added entity-table class and adjusted column widths for consistency --%>
                <table id="tblEWA_ProjTS" class="table tbl_wrkflow_approval entity-table" style="width: 100%;">
                    <thead class="stickyTblHeader">
                        <tr>
                            <%-- Modified by Dipali V on 2nd Dec 2025 - Adjusted column widths for proper alignment --%>
                            <%-- Updated by Dipali V on 18th Dec 2025 - Adjusted column widths to fit within 1366px screen --%>
                            <%-- Updated by Dipali V on 18th Dec 2025 - Adjusted column widths: reduced TSID and Project Name, increased Status and Action --%>
                            <th style="width:50px;"><%= MyBase.GetResourceString("C_TSID") %></th>
                            <th style="width:85px;"><%= MyBase.GetResourceString("CProjectName") %></th>
                            <th style="width:95px;"><%= MyBase.GetResourceString("C_GeneratedDate") %></th>
                            <th style="width:100px;"><%= MyBase.GetResourceString("C_CType") %></th>
                            <th style="width:75px;"><%= MyBase.GetResourceString("C_FromDate") %></th>
                            <th style="width:75px;"><%= MyBase.GetResourceString("C_ToDate") %></th>
                            <th style="width:65px;"><span class="d-block"><%= MyBase.GetResourceString("C_TimesheetHours") %></span><small class="text-muted"><%= MyBase.GetResourceString("C_SHHMM") %></small></th>
                            <%-- Added by Dipali V on 2nd Dec 2025 - Added Billable and UnBillable Hours columns --%>
                            <th style="width:55px;"><span class="d-block"><%= MyBase.GetResourceString("C_TSBillable") %></span><small class="text-muted"><%= MyBase.GetResourceString("C_SHHMM") %></small></th>
                            <th style="width:60px;"><span class="d-block"><%= MyBase.GetResourceString("C_UnBillable") %></span><small class="text-muted"><%= MyBase.GetResourceString("C_SHHMM") %></small></th>
                            <th style="width:140px;"><%= MyBase.GetResourceString("CStatusIR ") %></th>
                            <%--<th><%= MyBase.GetResourceString("C_BillingInfromation") %></th>--%>
                            <th style="width:100px;"><%= MyBase.GetResourceString("C_Action") %></th>
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
            <!-- Project Timesheet Entity End here -->

       <!--Project Timesheet information offcanvas Section Start Here-->
       <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="show_ProTS_offcanvas">
       <div class="offcanvas-body">
           <div id="ModulesInfo_Sec" class="ModulesInfoDetails">
               <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                   <div class="d-flex align-items-center justify-content-between">
                       <h5 class="pgtitle mb-0">
                           <%= MyBase.GetResourceString("C_ProjectTimesheetInfromation") %>
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
                   <div class="col-sm-12 ">
                       <div class="row">
                           <div class="col-sm-2">
                           </div>
                           <div class="col-sm-10 d-flex justify-content-end gap-3">
                               <a id="liApproved" href="javascript:;" data-bs-toggle="tooltip"  data-bs-placement="top" data-bs-original-title="<%= MyBase.GetResourceString("C_Approve") %>"><span onclick="callIframeFunction('ApproveRejectProjectTimesheet', 'A', 'EditView', 0)">&nbsp;
                                   <%= MyBase.GetResourceString("C_Approve") %> </span></a>
                               <a id="liRejected" href="javascript:;" data-bs-toggle="tooltip" data-bs-placement="top"
                                   data-bs-original-title="Reject"><span  onclick="callIframeFunction('ApproveRejectProjectTimesheet', 'R', 'EditView', 0)">&nbsp;<%= MyBase.GetResourceString("C_LeaveReject") %></span></a>
                              <%-- <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                   data-bs-dismiss="offcanvas">
                                  <%= MyBase.GetResourceString("C_Close") %> 
                               </button>--%>
                           </div>
                       </div>
                   </div>
               </div>
               <div class="ModuleDetailsContent">

                   <div class="accordion WF_TopAccordianPanel  Off_acordian_panel mb-3 mt-3 " id="ProTSInfoDetailsAcc">
                       <div class="accordion-item mb-3">
                           <h2 class="accordion-header" id="subProTSDetailsHeading">
                               <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                   data-bs-target="#ProTSInfoDetailsTab" aria-expanded="true">
                                   <i class="fas fa-info-circle me-2 projts-details-icon"></i><%= MyBase.GetResourceString("C_Details") %>
                               </button>
                           </h2>

                           <div id="ProTSInfoDetailsTab" class="accordion-collapse collapse show"
                               aria-labelledby="subProTSDetailsHeading">
                               <div class="accordion-body" id="TbodyPT">
                                   <div class="main-form">
                                       <div class="row form-group">
                                           <div class="col-sm-6 mb-3">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("C_TSID") %> :</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <span></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-3">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("CProjectName") %> :</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <span>.</span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-3">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("C_Commercialstype") %> :</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <span></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-3">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("CStatusIR ") %>:</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <div class="d-flex justify-content-start">
                                                            <span></span> 
                                                       </div>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-3">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("C_FromDate") %> :</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <span><i class="far fa-calendar-check iconBlue pe-1"></i>
                                                       </span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-3">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("C_ToDate") %> :</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <span><i class="far fa-calendar-check iconBlue pe-1"></i></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-3">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("C_SubmittedDate") %>:</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <span><i class="far fa-calendar-check iconBlue pe-1"></i></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-3" id="DivApprovalPending">
                                               <div class="row">
                                                   <div class="col-sm-5 text-end">
                                                       <label><%= MyBase.GetResourceString("C_ApprovalPending") %>:</label>
                                                   </div>
                                                   <div class="col-sm-7 text-start">
                                                       <span class="pand_day"><strong></strong></span>
                                                   </div>
                                               </div>
                                           </div>

                                            <div class="col-sm-6 mb-3">
                                                 <div class="row">
                                                     <div class="col-sm-5 text-end">
                                                         <label><%= MyBase.GetResourceString("C_BillableAmount") %>:</label>
                                                     </div>
                                                     <div class="col-sm-7 text-start">
                                                        <span></span>
                                                     </div>
                                                 </div>
                                             </div>
                                             <%--<div class="col-sm-6 mb-3">
                                                 <div class="row">
                                                     <div class="col-sm-5 text-end">
                                                         <label><%= MyBase.GetResourceString("C_nonBillableAmount") %>:</label>
                                                     </div>
                                                     <div class="col-sm-7 text-start">
                                                         <span></span>
                                                     </div>
                                                 </div>
                                             </div>--%>
                                             <div class="col-sm-6 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 text-end">
                                                        <label><%= MyBase.GetResourceString("C_TotalEfforts") %>:</label>
                                                    </div>
                                                    <div class="col-sm-7 text-start">
                                                       <span><i class="far fa-clock iconBlue"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-3">
                                                        <div class="row">
                                                            <div class="col-sm-5 text-end">
                                                                <label><%= MyBase.GetResourceString("C_BillableHours") %>:</label>
                                                            </div>
                                                            <div class="col-sm-7 text-start">
                                                                <span><i class="far fa-clock iconBlue"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6 mb-3">
                                                        <div class="row">
                                                            <div class="col-sm-5 text-end">
                                                                <label><%= MyBase.GetResourceString("C_NonBillableHours") %>:</label>
                                                            </div>
                                                            <div class="col-sm-7 text-start">
                                                               <span><i class="far fa-clock iconBlue"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>


                                            
                                          

                                           
                                           

                                       </div>
                                   </div>
                                </div>
                          </div>
                      </div>

                      <%-- Added by Dipali V on 2nd Dec 2025 - Resource Timesheet Details Section --%>
                      <%-- Updated by Dipali V on 18th Dec 2025 - Open by default like Line Items section --%>
                      <div class="accordion-item mb-3">
                          <h2 class="accordion-header" id="resourceTimesheetHeading">
                              <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                  data-bs-target="#resourceTimesheetTab" aria-expanded="true" aria-controls="resourceTimesheetTab">
                                  <i class="fas fa-clock me-2"></i> Resource Timesheet Details
                              </button>
                          </h2>
                          <div id="resourceTimesheetTab" class="accordion-collapse collapse show"
                              aria-labelledby="resourceTimesheetHeading">
                              <div class="accordion-body">
                                  <!-- Verified Resources Section -->
                                  <div class="resource-section mb-4">
                                      <div class="section-header bg-light p-3 rounded mb-3">
                                          <p class="mb-2 text-muted small">
                                              <i class="fas fa-info-circle me-1"></i>
                                              
                                              <%= MyBase.GetResourceString("C_TSBillablenonBillablenote") %>
                                          </p>
                                          <div class="gap-4 align-items-center">
                                              <span class="text-primary fw-semibold">
                                                  <i class="far fa-calendar-alt me-1"></i> From Date: <span id="verifiedFromDate" class="text-dark">--</span>
                                              </span>
                                              <span class="text-primary fw-semibold" style="float: right">
                                                  <i class="far fa-calendar-alt me-1"></i> To Date: <span id="verifiedToDate" class="text-dark">--</span>
                                              </span>
                                          </div>
                                      </div>
                                      <div class="table-responsive" id="verifiedResourcesTableContainer">
                                          <table id="verifiedResourcesTable" class="table table-bordered tbl_wrkflow_approval">
                                              <thead class="stickyTblHeader">
                                                  <tr>
                                                      <th style="width:30%;">Employee Name</th>
                                                      <th style="width:18%;" class="text-center">From Date</th>
                                                      <th style="width:18%;" class="text-center">To Date</th>
                                                      <th style="width:34%;" class="text-center">Actual Efforts (Billable/Non-billable)</th>
                                                  </tr>
                                              </thead>
                                              <tbody id="verifiedResourcesBody">
                                                  <tr><td colspan="4" class="text-center text-muted py-3">Loading...</td></tr>
                                              </tbody>
                                          </table>
                                      </div>
                                  </div>

                                  <!-- Pending Resources Section -->
                                  <div class="resource-section">
                                      <div class="section-header bg-warning bg-opacity-10 p-3 rounded mb-3 border-start border-warning border-4">
                                          <p class="mb-2 fw-semibold text-dark">
                                              <i class="fas fa-exclamation-triangle text-warning me-1"></i>
                                              <%--List of the employees who does not have task / not filled their timesheet for the period--%>
                                              <%= MyBase.GetResourceString("C_TSNotGenerated") %>
                                          </p>
                                          <div class="gap-4 align-items-center">
                                              <span class="text-primary fw-semibold">
                                                  <i class="far fa-calendar-alt me-1"></i> From Date: <span id="pendingFromDate" class="text-dark">--</span>
                                              </span>
                                              <span class="text-primary fw-semibold" style="float: right">
                                                  <i class="far fa-calendar-alt me-1"></i> To Date: <span id="pendingToDate" class="text-dark">--</span>
                                              </span>
                                          </div>
                                      </div>
                                      <div class="table-responsive" id="pendingResourcesTableContainer">
                                          <table id="pendingResourcesTable" class="table table-bordered tbl_wrkflow_approval">
                                              <thead class="stickyTblHeader">
                                                  <tr>
                                                      <th style="width:30%;"> <%= MyBase.GetResourceString("C_Ename") %></th>
                                                      <th style="width:18%;" class="text-center"> <%= MyBase.GetResourceString("C_FromDate") %></th>
                                                      <th style="width:18%;" class="text-center"> <%= MyBase.GetResourceString("C_ToDate") %></th>
                                                      <th style="width:20%;" class="text-center"> <%= MyBase.GetResourceString("CStatusIR ") %></th>
                                                      <th style="width:14%;" class="text-center"> <%= MyBase.GetResourceString("C_Duration") %></th>
                                                      <th style="width:14%;" class="text-center"> <%= MyBase.GetResourceString("C_ApproverName") %></th>
                                                  </tr>
                                              </thead>
                                              <tbody id="pendingResourcesBody">
                                                  <tr><td colspan="5" class="text-center text-muted py-3">Loading...</td></tr>
                                              </tbody>
                                          </table>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                      <%-- End of Resource Timesheet Details Section --%>

                   
                   </div>
               </div>
           </div>

       </div>
   </div>
       <!--Project Timesheet information offcanvas Section End Here-->
        <div class="clearfix"></div>
      
    </div>
    <!-- Close main-content-wrapper -->

    <style>
        /* Added for Resource Timesheet Details - Sticky header and scrollable table */
        .resource-section .table-responsive {
            max-height: 400px;
            overflow-y: auto;
            overflow-x: auto;
            position: relative;
            display: block;
            width: 100%;
        }
        
        .resource-section .table-responsive table {
            margin-bottom: 0;
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        /* Make thead sticky - must be within scrollable container */
        .resource-section .table-responsive thead.stickyTblHeader {
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: #f8f9fa !important;
            display: table-header-group;
        }
        
        .resource-section .table-responsive thead.stickyTblHeader tr {
            background-color: #f8f9fa !important;
        }
        
        .resource-section .table-responsive thead.stickyTblHeader th {
            background-color: #f8f9fa !important;
            border-bottom: 2px solid #dee2e6 !important;
            position: sticky;
            top: 0;
            z-index: 1001;
            padding: 12px 8px;
            font-weight: 600;
        }
        
        /* Ensure table body scrolls */
        .resource-section .table-responsive tbody {
            display: table-row-group;
        }
        
        /* Smooth scrolling */
        .resource-section .table-responsive {
            scroll-behavior: smooth;
        }
        
        /* Adjust max-height based on number of rows - will be handled by JavaScript */
        .resource-section .table-responsive.has-many-rows {
            max-height: 500px;
        }
        
        /* Ensure the container has proper display for sticky to work */
        #verifiedResourcesTableContainer,
        #pendingResourcesTableContainer {
            display: block;
            overflow-y: auto;
            overflow-x: auto;
            max-height: 400px;
        }
        
        #verifiedResourcesTableContainer.has-many-rows,
        #pendingResourcesTableContainer.has-many-rows {
            max-height: 500px;
        }
        
        /* Fix for Bootstrap table-responsive class interference */
        .resource-section .table-responsive.table-responsive {
            display: block !important;
        }
    </style>

      <script>

          var GProjectID = 0;
          var CTagID = 42;
          var CUniqueID = 0;
          var strAlertType = 'T';
          var GFromWhere = "";
          var GPTID = 0;
         
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


          // For Get Parameter which gets from Parent Page
          function getQueryParam(name) {
              const urlParams = new URLSearchParams(window.location.search);
              return urlParams.get(name);
          }


          // For Read Top Filters (from query string / filter panel)
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


          // For Load function
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
          // fetch per-tag rows and update all tab badges
          // For Fetch entity rows for specific TagID
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
                  42: { table: '#tblEWA_ProjTS', card: '#projCardViewSec' }
              };

              const currentMap = tableMap[tagId] || { table: '#tblEWA_ProjTS', card: '#projCardViewSec' };
              const tableSelector = currentMap.table;
              const cardContainerSelector = currentMap.card;
              const $tbody = $(tableSelector + ' tbody');
              const $cardContainer = $(cardContainerSelector + ' .row.g-0');

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
                      // Updated by Dipali V on 18th Dec 2025 - Reinitialize tooltips after each draw
                      // Fixed by Dipali V on 18th Dec 2025 - Use Bootstrap 5 proper method to avoid duplicate tooltips
                      drawCallback: function() {
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
                                  delay: { "show": 100, "hide": 100 },
                                  html: true // Allow HTML in tooltips
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
                          delay: { "show": 100, "hide": 100 },
                          html: true
                      });
                  });
              }, 200);
              //applyEllipsisWithBootstrapTooltip('tbody td:nth-child(3)', 10);
              //applyEllipsisWithBootstrapTooltip('tbody td:nth-child(2)', 10);
              applyEllipsisWithBootstrapTooltip('tbody td:nth-child(4)', 10);
          }

          // For Plotting List View Row
          function generateTableRow(r, tagId, index) {
             // debugger;
              let tr = '';
              switch (tagId) {
                  case CTagID: // PT
                      var showApprove = false;
                      var showReject = false;

                      // Determine which buttons to show
                      if (r.authenticated === 'Y') {
                          showApprove = false;    // Already approved
                          showReject = true;      // Can reject
                      } else if (r.authenticated === 'N') {
                          showApprove = true;     // Sent for approval / Generated
                          showReject = true;
                      } else if (r.authenticated === 'R' || r.authenticated === 'G') {
                          showApprove = false;     // Can approve rejected
                          showReject = false;
                      }

                      // Disable buttons if invoice exists
                      var disableButtons = (r.isInvoiceExists === 1 || r.isInvoiceExists === true);
                      var disableAttr = disableButtons ? 'disabled' : '';
                      var disableClass = disableButtons ? 'opacity-50 cursor-not-allowed' : '';

                      // Modified by Dipali V on 2nd Dec 2025 - Updated to use inline icons like other entity pages
                      var timesheetText = r.timeSheetNo || '';
                      
                      // Updated by Dipali V on 18th Dec 2025 - Moved Timesheet Details icon to Action column
                      // Updated by Dipali V on 18th Dec 2025 - Standardized icon size (14px), width (20px), and gap (gap-3)
                      let actionButtons = [
                          '<div class="deskAppRejButns d-flex justify-content-center gap-3 align-items-center ', (disableClass || ''), '">',
                          '<a href="javascript:;" onclick="GetNowWBSDetails(' + (r.timeSheetNo || 0) + ',42)" class="ts-details-icon" data-bs-toggle="tooltip" data-bs-original-title="Timesheet Details" style="width:20px;display:inline-flex;justify-content:center;">',
                          '<i class="far fa-list-alt" style="font-size:14px;"></i>',
                          '</a>'
                      ];

                      // ✅ Show Approve/Reject buttons only if EditAccess = true or 'True'
                      if (EditAccess === true || EditAccess === 'True') {
                          if (showApprove) {
                              actionButtons.push(
                                  '<button data-bs-toggle="tooltip" type="button" ' + (disableAttr || '') +
                                  ' data-bs-original-title="Approve" onclick="ApproveRejectProjectTimesheet(\'A\', \'ListView\', ' + (r.timeSheetNo || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">' +
                                  '<i class="far fa-thumbs-up text-green" style="font-size:14px;"></i></button>'
                              );
                          }
                          if (showReject) {
                              actionButtons.push(
                                  '<button data-bs-toggle="tooltip" type="button" ' + (disableAttr || '') +
                                  ' data-bs-original-title="Reject" onclick="ApproveRejectProjectTimesheet(\'R\', \'ListView\', ' + (r.timeSheetNo || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">' +
                                  '<i class="far fa-thumbs-down textRed" style="font-size:14px;"></i></button>'
                              );
                          }
                      }
                      actionButtons.push('</div>');
                      let actionButtonsHtml = actionButtons.join('');

                      tr = [
                          '<tr>',
                          // Timesheet ID column - Updated by Dipali V on 18th Dec 2025 - Removed icon, moved to Action column
                          '<td class="text-center" style="width:50px;">', timesheetText, '</td>',
                          '<td style="width:85px;"><span data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="', (r.projectName || '').replace(/"/g, '&quot;'), '">', (r.projectName || ''), '</span></td>',
                          '<td>', (r.createdDate ? formatDate(r.createdDate) : ''), '</td>',
                          '<td>', (r.contractType || ''), '</td>',
                          '<td>', (r.fromDate ? formatDate(r.fromDate) : ''), '</td>',
                          '<td>', (r.toDate ? formatDate(r.toDate) : ''), '</td>',
                          '<td class="text-center">', (r.totalTimeSheetHours ? r.totalTimeSheetHours : ''), '</td>',
                          // Added by Dipali V on 2nd Dec 2025 - Billable Hours with color coding
                          // Fixed by Dipali V on [Date] - Compare billable with unbillable instead of total hours
                          '<td class="text-center">', getBillableHoursHtml(r.billableHours, r.unBillableHours), '</td>',
                          // Added by Dipali V on 2nd Dec 2025 - UnBillable Hours
                          // Fixed by Dipali V on [Date] - Compare unbillable with billable for color coding
                          '<td class="text-center">', getUnBillableHoursHtml(r.unBillableHours, r.billableHours), '</td>',
                          // Status column - Updated by Dipali V on 18th Dec 2025 - Show full status without truncation
                          '<td style="width:140px;">',
                          '<div class="statusDiv d-flex justify-content-start">',
                          '<span class="statusBox ', getTimesheetStatusClass(r.authenticated, 'PT'), ' mx-2">&nbsp;</span>',
                          '<label class="crsrLink">', (r.timesheetStatus || ''), '</label>',
                          '</div>',
                          '</td>',
                          // Action column - Updated by Dipali V on 18th Dec 2025 - Includes Timesheet Details icon along with Approve/Reject buttons
                          '<td class="text-center" style="width:100px;">', actionButtonsHtml, '</td>',
                          '</tr>'
                      ].join('');

                      // Removed old Action column code - Updated by Dipali V on 18th Dec 2025
                      if (false) {
                          // If no edit access, keep the column empty to maintain layout
                          tr += '<td></td>';
                      }

                      tr += '</tr>';
                      break;
              }


              return tr;
          }


          // For Get Timesheet Status CSS Class
          function getTimesheetStatusClass(authenticated, flag) {
              if (flag != 'IR') {
                  if (authenticated === 'Y') return 'statusApproved';
                  else if (authenticated === 'R') return 'statusRejected';
                  else if (authenticated === 'N') return 'statusSubmitted';
                  else return 'statusUnknown'; // fallback
              } else {
                  if (authenticated === 'Submitted') return 'statusSubmitted';

                  else return 'statusReSubmitted'; // fallback
              }
          }


          // For Get Details (Row click)
          function GetNowWBSDetails(UniqueID, entityTypeID) {

              CUniqueID = UniqueID;
              bindNonWBSEntityDetails(entityTypeID, parseInt(CUniqueID), StrResult)
          }

          // Apply ellipsis and tooltip to specific columns
          // For Apply Ellipsis and Tooltip on Table Cells
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

          // For Bind Entity Details (Non-WBS)
          function bindNonWBSEntityDetails(entityTypeID, UniQueID, data) {
              //debugger;
              var fieldMappings = "";
              if (entityTypeID == CTagID) {
                  GPTID = UniQueID;
                  Data = data.find(item => item.timeSheetNo === UniQueID);
                  SelectedProjectData = Data;
                  if (!Data) {
                      console.log('ProjectTimesheet data not found for ID:', timeSheetNo);
                      return;
                  }
              }

              switch (entityTypeID) {
                  case CTagID:
                      var DivID = 'ProTSInfoDetailsTab'
                      bindNonWBSDetails(entityTypeID, Data, DivID);
                      break
              }


          }

          // For Build Status HTML with badge
          function buildStatusHtml(status) {
              // map status text to a CSS class you already use (adjust names to match your CSS)
              const map = {
                  'Submitted': 'statusSubmitted',
                  'Sent For Approval': 'statusSubmitted',
                  'Approved': 'statusApproved',
                  'Rejected': 'statusRejected',
                  'Pending': 'statusPending'
                  // add others if you have them
              };

              const key = (status || '').trim();
              const cssClass = map[key] || 'statusDefault';

              // badge + separate text span
              return `<span class="statusBox ${cssClass} mx-2" aria-hidden="true"></span><span class="statusText">${escapeHtml(key || 'N/A')}</span>`;
          }

          // Updated by Dipali V on 18th Dec 2025 - Truncate status to 10 characters with tooltip
          function truncateStatusWithTooltip(statusText) {
              if (!statusText) return '';
              statusText = statusText.toString().trim();
              // Escape HTML for tooltip to prevent XSS
              var escapedText = statusText.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
              if (statusText.length > 10) {
                  return '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" data-bs-original-title="' + escapedText + '">' +
                         '<label class="crsrLink">' + escapeHtml(statusText.substring(0, 10)) + '...</label>' +
                         '</a>';
              }
              return '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" data-bs-original-title="' + escapedText + '">' +
                     '<label class="crsrLink">' + escapeHtml(statusText) + '</label>' +
                     '</a>';
          }

          // small helper to avoid XSS when injecting text into HTML
          // For Escape HTML (prevent XSS)
          function escapeHtml(text) {
              return String(text)
                  .replace(/&/g, "&amp;")
                  .replace(/</g, "&lt;")
                  .replace(/>/g, "&gt;")
                  .replace(/"/g, "&quot;")
                  .replace(/'/g, "&#039;");
          }

          // For Bind Details Section (Non-WBS)
          function bindNonWBSDetails(entityTypeID, projectData, DivID) {
              // Added by Dipali V on 18th Dec 2025 - Log projectData to debug property names
              console.log('Project Data for binding:', projectData);
              //debugger;
              var fieldMappings = "";
              if (entityTypeID === CTagID) {
                  // Get amount values - Updated by Dipali V on 18th Dec 2025 - Use InvoiceAmount and UnInvoiceAmount
                  var billableAmount = projectData.invoiceAmount || projectData.InvoiceAmount || 0;
                  var nonBillableAmount = projectData.unInvoiceAmount || projectData.UnInvoiceAmount || 0;
                  
                  // Get currency symbol - Updated by Dipali V on 18th Dec 2025 - Use BillingCurrencySymbol for dynamic currency
                  // This currency symbol is used for both Billable Amount and Non Billable Amount
                  var currencySymbol = projectData.billingCurrencySymbol || projectData.BillingCurrencySymbol || projectData.currencySymbol || projectData.CurrencySymbol || '₹';
                  
                  console.log('Billable Amount:', billableAmount, 'Non Billable Amount:', nonBillableAmount, 'Currency Symbol (BillingCurrencySymbol):', currencySymbol);
                  
                  // Format amounts with currency symbol in parentheses - Updated by Dipali V on 18th Dec 2025
                  // Used for both Billable Amount and Non Billable Amount with BillingCurrencySymbol
                  // Updated by Dipali V on 24th Dec 2025 - Format with 3 decimal places
                  var formatAmountWithCurrency = function(amount) {
                      if (!amount || amount === 0) {
                          return '0.000 (' + currencySymbol + ')';
                      }
                      // Convert to number, format with 3 decimal places, then add commas
                      var numValue = parseFloat(amount);
                      var formattedAmount = numValue.toFixed(3);
                      // Add comma separators for thousands
                      formattedAmount = formatWithCommas(formattedAmount);
                      return formattedAmount + ' (' + currencySymbol + ')';
                  };
                  
                  fieldMappings = {
                      'Timesheet ID :': projectData.timeSheetNo || 'N/A',
                      'Project Name :': projectData.projectName || 'N/A',
                      'Commercials type :': projectData.contractType || 'N/A',
                      'Status :': buildStatusHtml(projectData.timesheetStatus) || 'N/A',
                      'From Date :': formatDate(projectData.fromDate) || 'N/A',
                      'To Date :': formatDate(projectData.toDate) || 'N/A',
                      'Submitted Date:': formatDate(projectData.sendForApprovalDate) || 'N/A',
                      'Ageing :': GetApprovalPending(projectData.sendForApprovalDate, projectData.timesheetStatus) || 'N/A',
                      'Billable Hours :': formatEffortToHHMM(projectData.billableHours) || '00:00',
                      'Non Billable Hours :': formatEffortToHHMM(projectData.unBillableHours) || '00:00',
                      // Updated by Dipali V on 18th Dec 2025 - Both amounts use BillingCurrencySymbol
                      // Updated by Dipali V on 24th Dec 2025 - Format with 3 decimal places
                      'Billable Amount :': formatAmountWithCurrency(billableAmount),
                      //'Non Billable Amount :': formatAmountWithCurrency(nonBillableAmount),
                      'Total Efforts :': projectData.totalTimeSheetHours || '00:00'
                  };

              }


              bindDataToHTML(fieldMappings, DivID);
              GProjectID = projectData.projectID;
              SelectedProjectData = projectData;
              
              // Added by Dipali V on 2nd Dec 2025 - Load resource timesheet details
              loadResourceTimesheetDetails(projectData.projectID, projectData.fromDate, projectData.toDate);
              
              if (projectData.timesheetStatus == "Approved") {
                  $("#liApproved").hide();
              } else if (projectData.timesheetStatus == "Rejected") {
                  $("#liRejected").hide();

              } else {
                  $("#liApproved").show();
                  $("#liRejected").show();
              }
              // === Send offcanvas HTML to parent for rendering ===
              const offcanvasEl = document.getElementById('show_ProTS_offcanvas');
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

          function formatWithCommas(value) {
              if (value == null || value === '' || isNaN(value)) return '';
              // Updated by Dipali V on 24th Dec 2025 - Preserve decimal places when formatting
              var numValue = parseFloat(value);
              if (isNaN(numValue)) return '';
              // If value is a string with decimal places (from toFixed), preserve them
              if (typeof value === 'string' && value.includes('.')) {
                  var parts = value.split('.');
                  var integerPart = parts[0];
                  var decimalPart = parts[1] || '';
                  // Format integer part with commas
                  var formattedInteger = Number(integerPart).toLocaleString('en-IN');
                  // Return with decimal part preserved
                  return decimalPart ? formattedInteger + '.' + decimalPart : formattedInteger;
              }
              // For numbers, format with commas but preserve decimal places
              return numValue.toLocaleString('en-IN', { minimumFractionDigits: 0, maximumFractionDigits: 20 });
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Load resource timesheet details (verified and pending resources)
          function loadResourceTimesheetDetails(projectID, fromDate, toDate) {
              const formattedFromDate = formatDateForAPI(fromDate);
              const formattedToDate = formatDateForAPI(toDate);
              
              // Small delay to ensure offcanvas is rendered in parent before updating
              setTimeout(function() {
                  // Update date displays in parent window
                  const parentDoc = window.parent.document;
                  const verifiedFromDate = parentDoc.getElementById('verifiedFromDate');
                  const verifiedToDate = parentDoc.getElementById('verifiedToDate');
                  const pendingFromDate = parentDoc.getElementById('pendingFromDate');
                  const pendingToDate = parentDoc.getElementById('pendingToDate');
                  
                  if (verifiedFromDate) verifiedFromDate.textContent = formatDate(fromDate) || '--';
                  if (verifiedToDate) verifiedToDate.textContent = formatDate(toDate) || '--';
                  if (pendingFromDate) pendingFromDate.textContent = formatDate(fromDate) || '--';
                  if (pendingToDate) pendingToDate.textContent = formatDate(toDate) || '--';
                  
                  // Load verified resources
                  loadVerifiedResources(projectID, formattedFromDate, formattedToDate);
                  
                  // Load pending resources
                  loadPendingResources(projectID, formattedFromDate, formattedToDate);
              }, 500); // Wait for offcanvas to render in parent
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Format date for API call (dd MMM yyyy format)
          function formatDateForAPI(dateString) {
              if (!dateString) return '';
              const date = new Date(dateString);
              return date.toLocaleDateString('en-GB', {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric'
              }).replace(/ /g, ' ');
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Load verified resource timesheet details
          // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
          function loadVerifiedResources(projectID, fromDate, toDate) {
              // Target parent window elements since offcanvas is rendered there
              const parentDoc = window.parent.document;
              const tbody = parentDoc.getElementById('verifiedResourcesBody');
              if (tbody) {
                  tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted py-3"><i class="fas fa-spinner fa-spin me-2"></i>Loading...</td></tr>';
              }
              
              const payload = JSON.stringify({
                  ProjectID: projectID,
                  FromDate: fromDate,
                  ToDate: toDate
              });
              
              try {
                  var response = AJAXCallWithResult('api/EntityApproval/GetVerifiedResourceTimesheetDetails', payload, false, 'POST');
                  const data = (response && response.data) ? response.data : (response || []);
                  renderVerifiedResourcesTable(data);
              } catch (error) {
                  console.error('Error loading verified resources:', error);
                  const parentDoc = window.parent.document;
                  const tbody = parentDoc.getElementById('verifiedResourcesBody');
                  if (tbody) {
                      tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted py-3">No data available</td></tr>';
                  }
              }
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Render verified resources table
          function renderVerifiedResourcesTable(data) {
              _verData = (data && data.length > 0) ? data : [];
              _verPage = 1;
              _verEnsurePagination();
              _verRenderPage();
          }

          // Verified Resources pagination state
          var _verData = [];
          var _verPage = 1;
          var _verItemsPerPage = 5;

          function _verRenderPage() {
              const parentDoc = window.parent.document;
              const tbody = parentDoc.getElementById('verifiedResourcesBody');
              if (!tbody) return;

              tbody.innerHTML = '';

              if (!_verData || _verData.length === 0) {
                  tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted py-4"><i class="fas fa-check-circle text-success me-2 fa-lg"></i>No timesheet records found</td></tr>';
                  _verUpdatePagination();
                  return;
              }

              var startIdx = (_verPage - 1) * _verItemsPerPage;
              var endIdx   = Math.min(startIdx + _verItemsPerPage, _verData.length);
              const defaultImg = '../../../Images/Photo/no-photo.png';

              for (var i = startIdx; i < endIdx; i++) {
                  var item = _verData[i];
                  const billable     = item.BillableDurationHHMM || item.billableDurationHHMM || '00:00';
                  const nonBillable  = item.NonBillableDurationHHMM || item.nonBillableDurationHHMM || '00:00';
                  const employeeName = item.EmployeeName || item.employeeName || '';
                  const fromDt       = item.FromDate || item.fromDate || '--';
                  const toDt         = item.ToDate || item.toDate || '--';
                  const systemFilename = item.SystemFilename || item.systemFilename || null;
                  let employeeImg = defaultImg;
                  if (systemFilename && systemFilename.trim() !== '') {
                      const filename = systemFilename.split('/').pop();
                      employeeImg = '../../../Images/Photo/' + filename;
                  }
                  const row = document.createElement('tr');
                  row.innerHTML = `
                          <td>
                              <div class="align-items-center gap-2">
                                  <img src="${employeeImg}" alt="${escapeHtml(employeeName)}" class="employee-avatar"
                                       style="width:28px;height:28px;border-radius:50%;object-fit:cover;border:1px solid #dee2e6;flex-shrink:0;"
                                       onerror="this.src='${defaultImg}'">
                                  <span class="resource-employee-name" style="white-space:nowrap;">${escapeHtml(employeeName)}</span>
                              </div>
                          </td>
                          <td class="text-center text-primary fw-medium">${escapeHtml(fromDt)}</td>
                          <td class="text-center text-primary fw-medium">${escapeHtml(toDt)}</td>
                          <td class="text-center">
                              <span class="badge-hours">
                                  <span class="hours-billable">${escapeHtml(billable)}</span>
                                  <span class="hours-separator">/</span>
                                  <span class="hours-nonbillable">${escapeHtml(nonBillable)}</span>
                              </span>
                          </td>
                  `;
                  tbody.appendChild(row);
              }

              // Apply scrolling for visible rows
              applyTableScrolling('verifiedResourcesTableContainer', Math.min(endIdx - startIdx, _verItemsPerPage));
              _verUpdatePagination();
          }

          function _verUpdatePagination() {
              var total = _verData.length;
              var _verTP = Math.ceil(total / _verItemsPerPage) || 1;

              var pd = (window.parent && window.parent.document) ? window.parent.document : document;

              var totalEl = pd.getElementById('verTotal');
              if (totalEl) totalEl.textContent = total;

              var prevLi = pd.getElementById('verBtnPrev');
              var prevA  = pd.getElementById('verLinkPrev');
              var nextLi = pd.getElementById('verBtnNext');
              var nextA  = pd.getElementById('verLinkNext');

              var disabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;';
              var enabledAStyle  = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#1359a6;background-color:#fff;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:auto;cursor:pointer;transition:all 0.3s ease;';

              if (_verPage <= 1 || total === 0) {
                  if (prevLi) prevLi.style.cursor = 'not-allowed';
                  if (prevA)  { prevA.setAttribute('style', disabledAStyle); prevA.removeAttribute('onclick'); }
              } else {
                  if (prevLi) prevLi.style.cursor = 'pointer';
                  if (prevA)  { prevA.setAttribute('style', enabledAStyle); prevA.setAttribute('onclick', 'window.frames[0]._verGoToPrev()'); }
              }

              if (_verPage >= _verTP || total === 0) {
                  if (nextLi) nextLi.style.cursor = 'not-allowed';
                  if (nextA)  { nextA.setAttribute('style', disabledAStyle); nextA.removeAttribute('onclick'); }
              } else {
                  if (nextLi) nextLi.style.cursor = 'pointer';
                  if (nextA)  { nextA.setAttribute('style', enabledAStyle); nextA.setAttribute('onclick', 'window.frames[0]._verGoToNext()'); }
              }
          }

          window._verGoToPrev = function () { if (_verPage > 1) { _verPage--; _verRenderPage(); } };
          window._verGoToNext = function () {
              var tp = Math.ceil(_verData.length / _verItemsPerPage) || 1;
              if (_verPage < tp) { _verPage++; _verRenderPage(); }
          };

          function _verEnsurePagination() {
              var pd = (window.parent && window.parent.document) ? window.parent.document : document;
              if (pd.getElementById('verPagination')) return;

              var div = pd.createElement('div');
              div.id = 'verPagination';
              div.setAttribute('style', 'display:flex;justify-content:flex-end;align-items:center;gap:1rem;padding:8px 4px 4px;');

              div.innerHTML =
                  '<div id="verInfoDiv" style="color:#333;font-size:14px;font-weight:300;">' +
                      '<span>Total Records: </span>' +
                      '<span id="verTotal">0</span>' +
                  '</div>' +
                  '<nav>' +
                      '<ul style="display:flex;list-style:none;margin:0;padding:0;gap:4px;">' +
                          '<li id="verBtnPrev" style="cursor:not-allowed;">' +
                              '<a id="verLinkPrev" aria-label="Previous" title="Previous Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-left"></i>' +
                              '</a>' +
                          '</li>' +
                          '<li id="verBtnNext" style="cursor:not-allowed;">' +
                              '<a id="verLinkNext" aria-label="Next" title="Next Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-right"></i>' +
                              '</a>' +
                          '</li>' +
                      '</ul>' +
                  '</nav>';

              var tbl = pd.getElementById('verifiedResourcesTable');
              if (tbl && tbl.parentNode) {
                  tbl.parentNode.insertBefore(div, tbl.nextSibling);
              }
          }

          // Added for Resource Timesheet Details - Apply scrolling when there are many resources
          function applyTableScrolling(containerId, rowCount) {
              const parentDoc = window.parent.document;
              const container = parentDoc.getElementById(containerId);
              if (!container) return;
              
              // Always apply scrolling when there are rows
              // This ensures header stays sticky and tbody scrolls
              if (rowCount > 0) {
                  container.classList.add('has-many-rows');
                  // Force display block and overflow for scrolling
                  container.style.display = 'block';
                  container.style.overflowY = 'auto';
                  container.style.overflowX = 'auto';
                  
                  // Set max-height based on row count
                  if (rowCount > 5) {
                      container.style.maxHeight = '500px';
                  } else {
                      container.style.maxHeight = '400px';
                  }
              }
              
              // Ensure thead is sticky
              const table = container.querySelector('table');
              if (table) {
                  const thead = table.querySelector('thead.stickyTblHeader');
                  if (thead) {
                      thead.style.position = 'sticky';
                      thead.style.top = '0';
                      thead.style.zIndex = '1000';
                      thead.style.backgroundColor = '#f8f9fa';
                      
                      // Make all th elements sticky
                      const thElements = thead.querySelectorAll('th');
                      thElements.forEach(function(th) {
                          th.style.position = 'sticky';
                          th.style.top = '0';
                          th.style.zIndex = '1001';
                          th.style.backgroundColor = '#f8f9fa';
                      });
                  }
              }
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Load pending timesheet resources
          // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
          function loadPendingResources(projectID, fromDate, toDate) {
              // Target parent window elements since offcanvas is rendered there
              const parentDoc = window.parent.document;
              const tbody = parentDoc.getElementById('pendingResourcesBody');
              if (tbody) {
                  tbody.innerHTML = '<tr><td class="text-center text-muted py-3"><i class="fas fa-spinner fa-spin me-2"></i>Loading...</td></tr>';
              }
              
              const payload = JSON.stringify({
                  ProjectID: projectID,
                  FromDate: fromDate,
                  ToDate: toDate
              });
              
              try {
                  var response = AJAXCallWithResult('api/EntityApproval/GetPendingTimesheetResources', payload, false, 'POST');
                  const data = (response && response.data) ? response.data : (response || []);
                  renderPendingResourcesTable(data);
              } catch (error) {
                  console.error('Error loading pending resources:', error);
                  const parentDoc = window.parent.document;
                  const tbody = parentDoc.getElementById('pendingResourcesBody');
                  if (tbody) {
                      tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted py-3">No data available</td></tr>';
                  }
              }
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Render pending resources table
          function renderPendingResourcesTable(data) {
              _penData = (data && data.length > 0) ? data : [];
              _penPage = 1;
              _penEnsurePagination();
              _penRenderPage();
          }

          // Pending Resources pagination state
          var _penData = [];
          var _penPage = 1;
          var _penItemsPerPage = 5;

          function _penRenderPage() {
              const parentDoc = window.parent.document;
              const tbody = parentDoc.getElementById('pendingResourcesBody');
              if (!tbody) return;

              tbody.innerHTML = '';

              if (!_penData || _penData.length === 0) {
                  tbody.innerHTML = '<tr><td colspan="5" class="text-center py-4">No data available in table</td></tr>';
                  _penUpdatePagination();
                  return;
              }

              var startIdx = (_penPage - 1) * _penItemsPerPage;
              var endIdx   = Math.min(startIdx + _penItemsPerPage, _penData.length);
              const defaultImg = '../../../Images/Photo/no-photo.png';

              for (var i = startIdx; i < endIdx; i++) {
                  var item = _penData[i];
                  const employeeName   = item.EmployeeName || item.employeeName || '';
                  const fromDt         = item.FromDate || item.fromDate || '--';
                  const toDt           = item.ToDate || item.toDate || '--';
                  let status           = item.Status || item.status || '';
                  const duration       = item.Duration || item.duration || '-';
                  const ApproverName   = item.ApproverName || '-';
                  const systemFilename = item.SystemFilename || item.systemFilename || null;
                  let employeeImg = defaultImg;
                  if (systemFilename && systemFilename.trim() !== '') {
                      const filename = systemFilename.split('/').pop();
                      employeeImg = '../../../Images/Photo/' + filename;
                  }
                  status = (status && status.trim()) ? status.trim() : 'Not Generated';
                  let statusClass = 'status-pending';
                  let statusText = status;
                  if (status.toLowerCase() === 'not generated' || status === '--' || status === '-') {
                      statusClass = 'status-not-generated'; statusText = 'Not Generated';
                  } else if (status.toLowerCase() === 'generated') {
                      statusClass = 'status-generated'; statusText = 'Generated';
                  } else if (status.toLowerCase().includes('pending') || status.toLowerCase().includes('submitted')) {
                      statusClass = 'status-pending';
                  }
                  let durationDisplay = duration;
                  if (duration && duration !== '-' && duration !== '--') {
                      durationDisplay = `<span class="duration-badge">${escapeHtml(duration)}</span>`;
                  } else {
                      durationDisplay = '<span class="text-muted">-</span>';
                  }
                  const row = document.createElement('tr');
                  row.innerHTML = `
                          <td>
                              <div class="align-items-center gap-2">
                                  <img src="${employeeImg}" alt="${escapeHtml(employeeName)}" class="employee-avatar"
                                       style="width:28px;height:28px;border-radius:50%;object-fit:cover;border:1px solid #dee2e6;flex-shrink:0;"
                                       onerror="this.src='${defaultImg}'">
                                  <span class="resource-employee-name" style="white-space:nowrap;">${escapeHtml(employeeName)}</span>
                              </div>
                          </td>
                          <td class="text-center text-muted">${escapeHtml(fromDt)}</td>
                          <td class="text-center text-muted">${escapeHtml(toDt)}</td>
                          <td class="text-center">
                              <span class="status-badge ${statusClass}">${escapeHtml(statusText)}</span>
                          </td>
                          <td class="text-center">${durationDisplay}</td>
                          <td class="text-center">${ApproverName}</td>
                  `;
                  tbody.appendChild(row);
              }

              // Apply scrolling for visible rows
              applyTableScrolling('pendingResourcesTableContainer', Math.min(endIdx - startIdx, _penItemsPerPage));
              _penUpdatePagination();
          }

          function _penUpdatePagination() {
              var total = _penData.length;
              var _penTP = Math.ceil(total / _penItemsPerPage) || 1;

              var pd = (window.parent && window.parent.document) ? window.parent.document : document;

              var totalEl = pd.getElementById('penTotal');
              if (totalEl) totalEl.textContent = total;

              var prevLi = pd.getElementById('penBtnPrev');
              var prevA  = pd.getElementById('penLinkPrev');
              var nextLi = pd.getElementById('penBtnNext');
              var nextA  = pd.getElementById('penLinkNext');

              var disabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;';
              var enabledAStyle  = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#1359a6;background-color:#fff;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:auto;cursor:pointer;transition:all 0.3s ease;';

              if (_penPage <= 1 || total === 0) {
                  if (prevLi) prevLi.style.cursor = 'not-allowed';
                  if (prevA)  { prevA.setAttribute('style', disabledAStyle); prevA.removeAttribute('onclick'); }
              } else {
                  if (prevLi) prevLi.style.cursor = 'pointer';
                  if (prevA)  { prevA.setAttribute('style', enabledAStyle); prevA.setAttribute('onclick', 'window.frames[0]._penGoToPrev()'); }
              }

              if (_penPage >= _penTP || total === 0) {
                  if (nextLi) nextLi.style.cursor = 'not-allowed';
                  if (nextA)  { nextA.setAttribute('style', disabledAStyle); nextA.removeAttribute('onclick'); }
              } else {
                  if (nextLi) nextLi.style.cursor = 'pointer';
                  if (nextA)  { nextA.setAttribute('style', enabledAStyle); nextA.setAttribute('onclick', 'window.frames[0]._penGoToNext()'); }
              }
          }

          window._penGoToPrev = function () { if (_penPage > 1) { _penPage--; _penRenderPage(); } };
          window._penGoToNext = function () {
              var tp = Math.ceil(_penData.length / _penItemsPerPage) || 1;
              if (_penPage < tp) { _penPage++; _penRenderPage(); }
          };

          function _penEnsurePagination() {
              var pd = (window.parent && window.parent.document) ? window.parent.document : document;
              if (pd.getElementById('penPagination')) return;

              var div = pd.createElement('div');
              div.id = 'penPagination';
              div.setAttribute('style', 'display:flex;justify-content:flex-end;align-items:center;gap:1rem;padding:8px 4px 4px;');

              div.innerHTML =
                  '<div id="penInfoDiv" style="color:#333;font-size:14px;font-weight:300;">' +
                      '<span>Total Records: </span>' +
                      '<span id="penTotal">0</span>' +
                  '</div>' +
                  '<nav>' +
                      '<ul style="display:flex;list-style:none;margin:0;padding:0;gap:4px;">' +
                          '<li id="penBtnPrev" style="cursor:not-allowed;">' +
                              '<a id="penLinkPrev" aria-label="Previous" title="Previous Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-left"></i>' +
                              '</a>' +
                          '</li>' +
                          '<li id="penBtnNext" style="cursor:not-allowed;">' +
                              '<a id="penLinkNext" aria-label="Next" title="Next Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-right"></i>' +
                              '</a>' +
                          '</li>' +
                      '</ul>' +
                  '</nav>';

              var tbl = pd.getElementById('pendingResourcesTable');
              if (tbl && tbl.parentNode) {
                  tbl.parentNode.insertBefore(div, tbl.nextSibling);
              }
          }
          // For Calculate Approval Pending days
          // Modified by Dipali V on 2nd Dec 2025 - Show/hide approval pending field based on status
          // Updated by Dipali V on 18th Dec 2025 - Display number in larger size
          // Updated by Dipali V on 18th Dec 2025 - Display "day's" when days > 1
          function GetApprovalPending(sendForApprovalDate, timesheetStatus) {
              // Show approval pending only for "Sent For Approval" status
              if (timesheetStatus === "Sent For Approval" && sendForApprovalDate) {
                  $("#DivApprovalPending").show();
                  const sendDate = new Date(sendForApprovalDate);
                  const today = new Date();
                  const diffDays = Math.floor((today - sendDate) / (1000 * 60 * 60 * 24));
                  // Return HTML with number in larger size, use "day's" when days > 1
                  const dayText = diffDays > 1 ? "Day's" : "Day";
                  return '<span class="pending-days-number">' + diffDays + '</span> <span class="pending-days-text">' + dayText + '</span>';
              } else {
                  // Hide for Approved, Rejected or other statuses
                  $("#DivApprovalPending").hide();
                  return '';
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

              console.log('Total labels found:', labels.length);
              console.log('Field mappings keys:', Object.keys(fieldMappings));

              labels.forEach(label => {
                  const labelText = label.textContent.trim();
                  console.log('Checking label:', labelText);
                  
                  // Find the value container - more specific selector to get span in the value column
                  const row = label.closest('.row');
                  if (!row) {
                      console.log('Row not found for label:', labelText);
                      return;
                  }
                  
                  // Find the span in the col-sm-7 (value column), not in col-sm-5 (label column)
                  const valueColumn = row.querySelector('.col-sm-7');
                  const valueContainer = valueColumn ? valueColumn.querySelector('span') : null;
                  
                  if (!valueContainer) {
                      console.log('Value container not found for label:', labelText);
                      return;
                  }
                  
                  // Check exact match first
                  if (fieldMappings.hasOwnProperty(labelText)) {
                      console.log('Found exact match for:', labelText, 'Value:', fieldMappings[labelText]);
                      updateValueWithIcons(valueContainer, fieldMappings[labelText], labelText);
                  } else {
                      // Try to find partial match (in case of extra spaces or different formatting)
                      const matchingKey = Object.keys(fieldMappings).find(key => {
                          // Remove colon and normalize spaces for comparison
                          const normalizedKey = key.replace(':', '').trim().toLowerCase().replace(/\s+/g, ' ');
                          const normalizedLabel = labelText.replace(':', '').trim().toLowerCase().replace(/\s+/g, ' ');
                          return normalizedKey === normalizedLabel;
                      });
                      
                      if (matchingKey) {
                          console.log('Found normalized match for:', labelText, '->', matchingKey, 'Value:', fieldMappings[matchingKey]);
                          updateValueWithIcons(valueContainer, fieldMappings[matchingKey], labelText);
                      } else {
                          console.log('No match found for label:', labelText);
                          // Log all fieldMapping keys for debugging
                          console.log('Available keys:', Object.keys(fieldMappings));
                      }
                  }
              });
          }


          // Helper function to update values while preserving icons
          // Helper function to update values while preserving icons
          // Updated by Dipali V on 18th Dec 2025 - Handle Approval Pending From with HTML
          function updateValueWithIcons(container, value, labelText) {
              // Special handling for Approval Pending From - allow HTML
              if (labelText && labelText.trim() === 'Ageing :') {
                  const strongTag = container.querySelector('strong');
                  if (strongTag) {
                      strongTag.innerHTML = value; // Use innerHTML to allow HTML content
                  } else {
                      container.innerHTML = '<strong>' + value + '</strong>';
                  }
                  return;
              }
              
              const iconConfig = {
                  'Start Date:': { icon: 'far fa-calendar-check iconBlue pe-1', position: 'before' },
                  'End Date:': { icon: 'far fa-calendar-check iconBlue pe-1', position: 'before' },
                  'Work (HH:MM):': { icon: 'far fa-clock iconBlue pe-1', position: 'before' },
                  'Project Currency:': { icon: 'fas fa-rupee-sign iconBlue', position: 'inside' }
              };

              //// ✅ Handle Status specially
              //if (labelText.trim().toLowerCase() === 'status:' || labelText.trim().toLowerCase() === 'status :') {
              //    container.innerHTML = ''; // clear existing content

              //    if (value) {
              //        const statusClass = getStatusClass(value);
              //        const span = document.createElement('span');
              //        span.className = `statusBox ${statusClass} mx-2 d-inline-flex align-items-center`;

              //        // dot element before text
              //        const dot = document.createElement('span');
              //        dot.className = 'statusDot me-1';

              //        // add dot + text
              //        span.appendChild(dot);
              //        span.appendChild(document.createTextNode(value));

              //        container.appendChild(span);
              //    }
              //    return;
              //}
              const config = iconConfig[labelText];
              const existingIcon = container.querySelector('i');
              const isHtmlValue = typeof value === 'string' && /<[^>]+>/.test(value);
             // debugger;
              if (labelText === 'Status :') {
                  container.innerHTML = ''; // clear any previous status
                  container.innerHTML = value; // insert new status span
                  return;
              }

              // Special handling for fields with clock icons (Billable Hours, Non Billable Hours, Total Efforts)
              const clockIconFields = ['Billable Hours', 'Non Billable Hours', 'Total Efforts'];
              const isClockIconField = clockIconFields.some(field => {
                  const normalizedLabel = labelText.replace(':', '').trim();
                  return normalizedLabel.includes(field) || field.includes(normalizedLabel);
              });
              
              // Special handling for fields with currency icons (Billable Amount, Non Billable Amount)
              const currencyIconFields = ['Billable Amount', 'Non Billable Amount'];
              const isCurrencyIconField = currencyIconFields.some(field => {
                  const normalizedLabel = labelText.replace(':', '').trim();
                  return normalizedLabel.includes(field) || field.includes(normalizedLabel);
              });
              
              // Handle empty or null values
              if (value === null || value === undefined || value === '') {
                  console.log('Empty value for label:', labelText);
                  if (existingIcon) {
                      container.innerHTML = existingIcon.outerHTML;
                  } else {
                      container.textContent = '';
                  }
                  return;
              }
              
              if (config) {
                  if (config.position === 'before') {
                      container.innerHTML = `<i class="${config.icon}"></i> ${escapeHtml(value)}`;
                  } else if (config.position === 'inside') {
                      container.innerHTML = `${escapeHtml(value)} (<i class="${config.icon}"></i>)`;
                  }
              } else if (isHtmlValue) {
                  container.innerHTML = '';
                  container.innerHTML = value;
              } else if (existingIcon && (isClockIconField || existingIcon.classList.contains('fa-clock'))) {
                  // Preserve clock icon for hours fields
                  const iconHTML = existingIcon.outerHTML;
                  const valueText = escapeHtml(String(value));
                  container.innerHTML = iconHTML + ' ' + valueText;
                  console.log('Updated with clock icon for:', labelText, 'Value:', value);
              } else if (isCurrencyIconField || (existingIcon && (existingIcon.classList.contains('fa-rupee-sign') || existingIcon.classList.contains('fa-dollar-sign') || existingIcon.classList.contains('fa-money-bill')))) {
                  // Updated by Dipali V on 18th Dec 2025 - Remove currency icon, display amount with symbol in parentheses
                  // Value already contains amount and currency symbol in format: "200 (₹)"
                  const valueText = escapeHtml(String(value));
                  container.innerHTML = valueText;
                  console.log('Updated amount field for:', labelText, 'Value:', value);
              } else if (existingIcon) {
                  container.innerHTML = existingIcon.outerHTML + ' ' + escapeHtml(value);
              } else {
                  container.textContent = '';
                  container.textContent = value;
              }
          }

          // For Get Status CSS Class by text
          function getStatusClass(statusText) {
              statusText = (statusText || '').toLowerCase();
              if (statusText.includes('submitted') || statusText.includes('approval')) return 'statusSubmitted';
              if (statusText.includes('approved') || statusText.includes('authenticated')) return 'statusApproved';
              if (statusText.includes('rejected')) return 'statusRejected';
              if (statusText.includes('draft')) return 'statusDraft';
              return 'statusDefault'; // fallback
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

          // For Approve/Reject Project Timesheet (open modal)
          function ApproveRejectProjectTimesheet(Action, FromWhere, TimesheetNo) {
              //debugger;
              window.parent.$("#ApproveRejectModal").modal('show');

              if (FromWhere === "ListView") { // ✅ fixed case
                  GPTID = TimesheetNo;
                  CUniqueID = GPTID;
                  Data = StrResult.find(item => item.timeSheetNo === TimesheetNo);
                  SelectedProjectData = Data ? [Data] : [];
              } else {
                  GPTID = GPTID;
                  CUniqueID = GPTID;
              }

              strAction = Action;
              // Bind captions & button
              const modal = window.parent.$("#ApproveRejectModal");
              const caption = modal.find("#TimesheetAppRejectCaption");
              const btn = modal.find("#submitIRSaveBtn");

              if (Action === "A") {
                  caption.text('Approve');
                  btn.text('Approve');
                  //btn.removeClass('btnred btngreen');
                  //btn.addClass('btngreen');
              } else {
                  caption.text('Reject');
                  btn.text('Reject');
                 // btn.removeClass('btnred btngreen');
                  //btn.addClass('btnred');
              }

              BindTableEditDetails();
              modal.find("#submitIRSaveBtn").off("click").on("click", function () {
                  ApproveRejectPT();
              });
          }

          // For Bind Approve/Reject modal table
          function BindTableEditDetails() {
              // const tableBody = $('#ApproveRejectTbl tbody');
              // tableBody.empty();
              const modal = window.parent.$("#ApproveRejectModal");
              // Get tbody inside modal
              const tableBody = modal.find("tbody");
              tableBody.empty();

              if (!SelectedProjectData) {
                  tableBody.append('<tr><td colspan="5" class="text-center">No records found</td></tr>');
                  return;
              }

              const projectArray = Array.isArray(SelectedProjectData) ? SelectedProjectData : [SelectedProjectData];

              const today = new Date();
              const formattedDate = today.toLocaleDateString('en-GB', {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric'
              }).replace(/ /g, '-');

              const defaultComment = strAction === 'A'
                  ? `Approved On ${formattedDate}`
                  : `Rejected On ${formattedDate}`;

              projectArray.forEach((item) => {
                  const row = `
        <tr>
            <td>${item.timeSheetNo || ''}</td>
            <td>${item.projectName || ''}</td>
            <td>${formatDate(item.fromDate)}</td>
            <td>${formatDate(item.toDate)}</td>
            <td>
                <div class="d-flex align-items-start">
                    <textarea class="form-control submitComments" 
                        id="txtComment_${item.timeSheetNo}" rows="5" 
                        placeholder="Enter comments..." maxlength="500">${defaultComment}</textarea>
                    &nbsp;&nbsp;
                    <label class="required text-start"></label>
                </div>
            </td>
        </tr>`;
                  tableBody.append(row);
              });
          }

          // For Approve/Reject Project Timesheet (submit)
          function ApproveRejectPT() {
              //debugger;
              const modal = window.parent.$("#ApproveRejectModal");
              var fullUrl = "api/EntityApproval/ProjectTimesheetApproveReject";
              var comments = modal.find("#txtComment_" + CUniqueID).val();
              if (!comments) {
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                 } else {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                 }

                  window.parent.$("#txtComment_" + CUniqueID).focus();
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

                 window.parent.$("#txtComment_" + CUniqueID).focus();
                 return false;
             }

             
              // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
              const ctx = getContext();
              var payload = {
                  timeSheetNo: CUniqueID,
                  userName: '<%= Session("intUserID") %>',
                  comments: comments,
                  strAction: strAction
              };

              var param = JSON.stringify(payload);
              
              try {
                  var strResult = AJAXCallWithResult(fullUrl, param, false, "POST");
                  console.log('Project Approve/Reject Response:', strResult);

                  if (strResult && strResult.result === "Success") {
                      const statusMsg =
                          (strAction === "A")
                              ? "<%= MyBase.GetResourceString("C_PTApproved") %>"
                              : "<%= MyBase.GetResourceString("C_PTRejected") %>";

                      //alertify.set('notifier', 'position', 'top-right');
                      //alertify.notify(statusMsg, 'success', 25);
                      if (window.parent && window.parent.alertify) {
                          window.parent.alertify.set('notifier', 'position', 'top-right');
                          window.parent.alertify.notify(statusMsg, 'success', 25);
                      } else {
                          alertify.set('notifier', 'position', 'top-right');
                          alertify.notify(statusMsg, 'success', 25);
                      }

                      //  Hide modal in PARENT page
                      if (window.parent && window.parent.$) {
                          window.parent.$("#ApproveRejectModal").modal('hide');
                      }

                      //  Hide offcanvas in PARENT page
                      const offcanvasEl = window.parent.document.getElementById('show_ProTS_offcanvas');
                      if (offcanvasEl) {
                          const bsOffcanvas = window.parent.bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
                          bsOffcanvas.hide();
                      }

                      // Refresh parent data grid or alert tab
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

          // For Close Approve/Reject modal
          function CloseAppReject() {
              $("#approveRevModal").modal('hide');

          }


          // For Format Currency
          function formatCurrency(amount) {
              if (amount == null) return '0.00';
              return parseFloat(amount).toLocaleString('en-IN', {
                  minimumFractionDigits: 2,
                  maximumFractionDigits: 2
              });
          }

        
          // For Format Work Hours
          function formatWorkHours(hours) {
              if (!hours) return '00:00';
              if (typeof hours === 'number') {
                  return hours.toFixed(2);
              }
              return hours;
          }


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

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Get Billable Hours HTML with color coding based on comparison with Unbillable Hours
          // Fixed by Dipali V on [Date] - Compare billable with unbillable hours
          // Billable > Unbillable → GREEN, Billable < Unbillable → RED
          function getBillableHoursHtml(billableHours, unbillableHours) {
              if (billableHours == null || billableHours === '' || isNaN(billableHours)) {
                  return '<span class="hours-badge hours-na">0:00</span>';
              }
              
              const billable = parseFloat(billableHours) || 0;
              const unbillable = parseFloat(unbillableHours) || 0;
              const formattedHours = formatEffortToHHMM(billable);
              
              let colorClass = '';
              let tooltipText = '';
              
              // Fixed by Dipali V on [Date] - Compare billable with unbillable
              if (billable > unbillable) {
                  colorClass = 'hours-green';
                  tooltipText = 'Billable Hours';
              } else if (billable < unbillable) {
                  colorClass = 'hours-red';
                  tooltipText = 'Billable Hours';
              } else {
                  // billable == unbillable
                  colorClass = 'hours-green';
                  tooltipText = 'Billable Hours';
              }
              
              return '<span class="hours-badge ' + colorClass + '" data-bs-toggle="tooltip" data-bs-original-title="' + tooltipText + '">' + formattedHours + '</span>';
          }

          // Added by Dipali V on 2nd Dec 2025
          // Purpose: Get UnBillable Hours HTML with color coding based on comparison with Billable Hours
          // Fixed by Dipali V on [Date] - Compare unbillable with billable hours
          // UnBillable > Billable → RED, UnBillable < Billable → GREEN
          function getUnBillableHoursHtml(unBillableHours, billableHours) {
              if (unBillableHours == null || unBillableHours === '' || isNaN(unBillableHours)) {
                  return '<span class="hours-badge hours-na">0:00</span>';
              }
              
              const unbillable = parseFloat(unBillableHours) || 0;
              const billable = parseFloat(billableHours) || 0;
              const formattedHours = formatEffortToHHMM(unbillable);
              
              let colorClass = '';
              let tooltipText = '';
              
              // Fixed by Dipali V on [Date] - Compare unbillable with billable
              if (unbillable > billable) {
                  colorClass = 'hours-red';
                  tooltipText = 'Non-Billable Hours';
              } else if (unbillable < billable) {
                  colorClass = 'hours-green';
                  tooltipText = 'Non-Billable Hours';
              } else {
                  // unbillable == billable
                  colorClass = 'hours-green';
                  tooltipText = 'Non-Billable Hours';
              }
              
              return '<span class="hours-badge ' + colorClass + '" data-bs-toggle="tooltip" data-bs-original-title="' + tooltipText + '">' + formattedHours + '</span>';
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
              var $tbody = $('#tblEWA_ProjTS tbody');
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
              var $tbody = $('#tblEWA_ProjTS tbody');
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
