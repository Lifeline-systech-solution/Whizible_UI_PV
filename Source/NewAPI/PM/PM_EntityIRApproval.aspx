<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityIRApproval.aspx.vb" Inherits="Whizible.PM_EntityIRApproval" %>
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
    /* Added by Dipali V on 3rd Dec 2025 - Fix column alignment for IR table */
    #IRPIR_Tbl {
        table-layout: fixed;
    }
    #IRPIR_Tbl th, #IRPIR_Tbl td {
        word-wrap: break-word;
        overflow: hidden;
        text-overflow: ellipsis;
        vertical-align: middle;
    }
    #IRPIR_Tbl .entity-code-cell {
        max-width: 130px;
    }
    #IRPIR_Tbl .entity-code-wrapper {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    #IRPIR_Tbl .entity-code-text {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        flex: 1;
    }
    #IRPIR_Tbl .entity-code-icons {
        flex-shrink: 0;
    }
   #IR_Entity .entity-table th:nth-child(2),
#IR_Entity .entity-table td:nth-child(2) {
    width: 83px !important;
}
/* Updated by Dipali V on 18th Dec 2025 - Adjusted column widths after moving IR Details icon to Action column */
#IR_Entity .entity-table th:nth-child(1),
#IR_Entity .entity-table td:nth-child(1) {
    width: 120px !important;
}
#IR_Entity .entity-table th:nth-child(10),
#IR_Entity .entity-table td:nth-child(10) {
    width: 100px !important;
}




    /* Updated by Dipali V on 18th Dec 2025 - Set IR Approve/Reject modal width to 609px */
    /* Override Bootstrap 5 CSS custom property and updated_versions.css (900px) - Higher specificity */
    body #ApproveRejectIR.modal .modal-dialog.modal-lg,
    body #ApproveRejectIR.modal.show .modal-dialog.modal-lg,
    body #ApproveRejectIR .modal-dialog.modal-lg {
        --bs-modal-width: 609px !important;
        width: 609px !important;
        max-width: 609px !important;
    }
    
    /* Additional selector for when modal is shown - ensure it applies */
    body #ApproveRejectIR.modal.show .modal-dialog,
    body #ApproveRejectIR .modal.show .modal-dialog {
        --bs-modal-width: 609px !important;
        width: 609px !important;
        max-width: 609px !important;
    }
    
    /* Media query override to ensure it works at all screen sizes */
    @media (min-width: 992px) {
        body #ApproveRejectIR.modal .modal-dialog.modal-lg,
        body #ApproveRejectIR.modal.show .modal-dialog.modal-lg,
        body #ApproveRejectIR .modal-dialog.modal-lg {
            --bs-modal-width: 609px !important;
            width: 609px !important;
            max-width: 609px !important;
        }
    }

    /* Updated by Dipali V on 18th Dec 2025 - Set IR Status dropdown text size to 11px */
    #ApproveRejectIR #IRStatus,
    #ApproveRejectIR #IRStatus.form-select,
    #ApproveRejectIR select#IRStatus {
        font-size: 11px !important;
    }
    
    /* Ensure dropdown options also have 11px font size */
    #ApproveRejectIR #IRStatus option {
        font-size: 11px !important;
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
      <!-- IR Approval Entity Start here -->
     <div id="IR_Entity" class="allEntity col-sm-12">
        <%-- Modified by Dipali V on 2nd Dec 2025 - Added entity-table class and adjusted column widths for consistency --%>
        <%-- Modified by Dipali V on 3rd Dec 2025 - Fixed column alignment with table-layout:fixed --%>
        <table id="IRPIR_Tbl" class="table tbl_wrkflow_approval entity-table" style="width: 100%; table-layout: fixed;">
          <thead class="stickyTblHeader">
             <tr>
                 <%-- Modified by Dipali V on 3rd Dec 2025 - Fixed alignment for all columns --%>
                 <th style="width:120px;"><%= MyBase.GetResourceString("CProjectName") %></th>
                 <th style="width:70px;" class="text-center"><%= MyBase.GetResourceString("C_TimesheetID") %></th>
                 <th style="width:65px;" class="text-center"><%= MyBase.GetResourceString("C_IRID") %></th>
                 <th style="width:70px;"><%= MyBase.GetResourceString("C_Type") %></th>
                 <th style="width:80px;"><%= MyBase.GetResourceString("C_RaisedOn") %></th>
                 <th style="width:90px;" class="text-center"><%= MyBase.GetResourceString("C_Amount") %></th>
                 <th style="width:90px;" class="text-center">Amount<br/><small style="display:block;text-align:center;">(Company base)</small></th>
                 <th style="width:100px;" class="text-center">Amount<br/><small style="display:block;text-align:center;">(Corporate base)</small></th>
                 <th style="width:95px;"><%= MyBase.GetResourceString("CStatusIR ") %></th>
                 <th style="width:100px;" class="text-center"><%= MyBase.GetResourceString("C_Action") %></th>
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

     <!-- IR Approval Entity End here -->
     <!-- IR Approval information offcanvas Section Start Here-->
   <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="IRDetailsOffcanvas">
       <div class="offcanvas-body">
           <div id="LeaveInfoSec" class="ProjInfoDetails">
               <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                   <div class="d-flex align-items-center justify-content-between">
                       <h5 class="pgtitle mb-0">
                           <%= MyBase.GetResourceString("C_IRInformation") %>
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
                   <div class="col-sm-10 d-flex gap-3 justify-content-end">
                       <a href="javascript:;"  onclick="callIframeFunction('ApproveRejectIR', 'A', 'EditView', 0)"><%= MyBase.GetResourceString("C_Approve") %></a>
                       <a href="javascript:;" onclick="callIframeFunction('ApproveRejectIR', 'R', 'EditView', 0)"><%= MyBase.GetResourceString("C_LeaveReject") %></a>
                      <%-- <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#chcklistItemModal">Checklist
                       Responses</a>--%>
                       <a href="javascript:;" onclick="callIframeFunction('IRHistory', '', 'EditView', 0)"><%= MyBase.GetResourceString("C_ShowHistory") %></a>

                      <%-- <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                           data-bs-dismiss="offcanvas">
                              <%= MyBase.GetResourceString("C_Close") %> 
                       </button>--%>
                   </div>
               </div>
               <div class="LeaveDetailsContent text-end">
                   <div class="accordion WF_TopAccordianPanel mb-3 mt-3 " id="IR_DetailsAcc">
                       <div class="accordion-item mb-3">
                           <h2 class="accordion-header" id="IR_DetailsHeading">
                               <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                   data-bs-target="#IR_DetailsTab" aria-expanded="true" aria-controls="IR_DetailsTab">
                                      <i class="fas fa-info-circle me-2 ir-details-icon"></i><%= MyBase.GetResourceString("C_Details") %> 
                               </button>
                           </h2>
                           <div id="IR_DetailsTab" class="accordion-collapse collapse show"
                               aria-labelledby="IR_DetailsHeading">
                               <div class="accordion-body">

                                   <div class="IR_Content mb-3">
                                       <div class="row form-group mt-3">
                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="lb_projectname"><%= MyBase.GetResourceString("C_IRID1") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="lb_projectname"><%= MyBase.GetResourceString("C_PIRID") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span>-</span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="lb_projectname"><%= MyBase.GetResourceString("C_Type") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="lb_Commercial"><%= MyBase.GetResourceString("C_CDays") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span></span>
                                                   </div>
                                               </div>
                                           </div>

                                           <div class="col-sm-6 mb-2">
                                               <div class="row">
                                                   <div class="col-sm-12">
                                                       <div class="row mb-1">
                                                           <div class="col-sm-4 text-end">
                                                               <label class=""><%= MyBase.GetResourceString("C_Customer") %> :</label>
                                                           </div>
                                                           <div class="col-sm-8 pr-0">
                                                               <div class="text-start">
                                                                   <span class="mb-0"></span>
                                                               </div>
                                                               <div class="text-start">
                                                               
                                                               </div>
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>
                                           </div>

                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class=""><%= MyBase.GetResourceString("C_Currency") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span class=""></span>
                                                   </div>
                                               </div>
                                           </div>

                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="lb_ouWorking">
                                                          <%= MyBase.GetResourceString("C_ContactPerson") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span class=""></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="crsrLink"><%= MyBase.GetResourceString("C_SalesPeriod") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span class=""></span>
                                                   </div>
                                               </div>
                                           </div>

                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class=""><%= MyBase.GetResourceString("C_EmailConfirm") %> : </label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span class=""></span>
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-2">

                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="control-label">
                                                           <%= MyBase.GetResourceString("C_SalesPerson") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 pr-0 text-start">
                                                       <span class=""></span>
                                                   </div>
                                                  
                                               </div>
                                           </div>

                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="control-label"><%= MyBase.GetResourceString("C_Contract") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 pr-0">
                                                       <div class="text-start">
                                                           <span class="mb-0"></span>
                                                       </div>
                                                  
                                                   </div>
                                               </div>
                                           </div>
                                           <div class="col-sm-6 mb-2">
                                               <div class="row mb-1">
                                                   <div class="col-sm-4 text-end">
                                                       <label class="lb_Site_Validation">
                                                           <%= MyBase.GetResourceString("C_IRItemsHeader") %> :</label>
                                                   </div>
                                                   <div class="col-sm-8 text-start">
                                                       <span class=""></span>
                                                   </div>
                                               </div>
                                           </div>

                                       </div>
                                   </div>
                               </div>
                           </div>
                       </div>
                       
                       <!-- Added by Dipali V on 18th Dec 2025 for IR Line Items Section -->
                       <!-- Updated by Dipali V on 18th Dec 2025 - Both sections open by default and work independently -->
                       <div class="accordion-item mb-3">
                           <h2 class="accordion-header" id="IR_LineItemsHeading">
                               <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                   data-bs-target="#IR_LineItemsTab" aria-expanded="true" aria-controls="IR_LineItemsTab">
                                   <i class="fas fa-list-ul me-2 ir-lineitems-icon"></i><%= MyBase.GetResourceString("C_LineItems") %>
                               </button>
                           </h2>
                           <div id="IR_LineItemsTab" class="accordion-collapse collapse show"
                               aria-labelledby="IR_LineItemsHeading">
                               <div class="accordion-body">
                                   <div class="ir-line-items-section">
                                       <div id="IRLineItemsTableContainer" class="table-responsive">
                                           <table id="tblIRLineItems" class="table table-bordered table-hover table-sm" style="font-size: 12px;">
                                               <thead class="table-light">
                                                   <tr>
                                                       <th style="width: 5%;"><%= MyBase.GetResourceString("C_SNno") %></th>
                                                       <th style="width: 25%;"><%= MyBase.GetResourceString("C_Description") %></th>
                                                       <th style="width: 8%;" class="text-center"><%= MyBase.GetResourceString("C_Discount") %></th>
                                                       <th style="width: 8%;" class="text-end"><%= MyBase.GetResourceString("C_Quantity") %></th>
                                                       <th style="width: 10%;" class="text-end"><%= MyBase.GetResourceString("C_Rate") %></th>
                                                       <th style="width: 12%;" class="text-end"><%= MyBase.GetResourceString("C_AmountIR") %></th>
                                                       <th style="width: 12%;" class="text-end"><%= MyBase.GetResourceString("C_Eque") %></th>
                                                       <th style="width: 12%;" class="text-end"><%= MyBase.GetResourceString("C_EquCompnay") %></th>
                                                   </tr>
                                               </thead>
                                               <tbody id="IRLineItemsTableBody">
                                                   <tr>
                                                       <td colspan="8" class="text-center text-muted">Loading line items...</td>
                                                   </tr>
                                               </tbody>
                                               <tfoot class="table-secondary fw-bold">
                                                   <tr>
                                                       <td colspan="5" class="text-end"><%= MyBase.GetResourceString("C_TAmount") %>:</td>
                                                       <td class="text-end" id="totalAmount">0.00</td>
                                                       <td class="text-end" id="totalCorporateBase">0.00</td>
                                                       <td class="text-end" id="totalCompanyBase">0.00</td>
                                                   </tr>
                                               </tfoot>
                                           </table>
                                       </div>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!-- End of Added by Dipali V on 18th Dec 2025 for IR Line Items Section -->
                       
                   </div>
               </div>
           </div>
       </div>
   </div>
 <!-- IR Approval Information offcanvas Section End Here-->
        <div class="clearfix"></div>
    </div>
    <!-- Close main-content-wrapper -->


      <script>

          var IsChecklistMandatory = false;
          var GProjectID = 0;
          var GWhichAction = '';
          var CTagID = 2074;
          var CUniqueID = 0;
          var GRFIID = 0;
          var strAlertType = 'T';
          var WhichActionWF = "";
          var SelectedWF = "";
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

              //Commented By Vyankat on 17th March 2026 for the removal of old LoadingOverlay spinner
              //StopAjaxLoader("#Body")
              // End of Commented By Vyankat on 17th March 2026 for the removal of old LoadingOverlay spinner

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


          // For Load function
          function load(alertType) {
              //debugger;
              try {
                  var resp = fetchEntityDataForTag(alertType, CTagID);
                  const rows = Array.isArray(resp) ? resp : (resp && resp.Table) ? resp.Table : resp || [];
                  renderListViews(rows);

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
           //debugger;
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
              CTagID: { table: '#IRPIR_Tbl', card: '#projCardViewSec' },       
          };

          const currentMap = tableMap[tagId] || { table: '#IRPIR_Tbl', card: '#projCardViewSec' };
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
          
          applyEllipsisWithBootstrapTooltip('tbody td:nth-child(3)', 10);
          applyEllipsisWithBootstrapTooltip('tbody td:nth-child(4)', 10);
          applyEllipsisWithBootstrapTooltip('tbody td:nth-child(2)', 10);
          applyEllipsisWithBootstrapTooltip('tbody td:nth-child(7)', 10);
          //applyEllipsisWithBootstrapTooltip('tbody td:nth-child(9)', 10);
          //applyEllipsisWithBootstrapTooltip('tbody td:nth-child(6)', 10);
          //$(".IRCurrency").addClass(bilCurrencyCode + 'Curncy');
      }

          // For Plotting List View Row
          var GbilCurrencyCurrencySymbol = "";
          var GcorporateBaseCurrencySymbol = "";
          var GcompanyBaseCurrencySymbol = "";
      function generateTableRow(r, tagId, index) {
          let tr = '';
          bilCurrencyCode = r.bilCurrencyCode;
          GbilCurrencyCurrencySymbol= r.bilCurrencyCurrencySymbol;
          GcorporateBaseCurrencySymbol = r.corporateBaseCurrencySymbol;
          GcompanyBaseCurrencySymbol = r.companyBaseCurrencySymbol;
          switch (tagId) {
              case CTagID: // For IR
                  let approveRejectButtons = '';
                  
                  // Updated by Dipali V on 18th Dec 2025 - Added IR Details icon to Action column
                  // Updated by Dipali V on 18th Dec 2025 - Standardized icon size (14px), width (20px), and gap (gap-3)
                  let actionButtons = [
                      '<div class="deskAppRejButns d-flex justify-content-center gap-3 align-items-center">',
                      '<a href="javascript:;" onclick="GetNowWBSDetails(' + (r.rfiid || 0) + ',2074)" class="ir-details-icon" data-bs-toggle="tooltip" data-bs-original-title="IR Details" style="width:20px;display:inline-flex;justify-content:center;">',
                      '<i class="far fa-list-alt" style="font-size:14px;"></i>',
                      '</a>'
                  ];

                  if (EditAccess === true || EditAccess === 'True') {
                      actionButtons.push(
                          '<button type="button" data-bs-toggle="tooltip" data-bs-original-title="Approve" ',
                          'onclick="ApproveRejectIR(\'A\', \'ListView\', ' + (r.rfiid || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">',
                          '<i class="far fa-thumbs-up text-green" style="font-size:14px;"></i>',
                          '</button>',
                          '<button type="button" data-bs-toggle="tooltip" data-bs-original-title="Reject" ',
                          'onclick="ApproveRejectIR(\'R\', \'ListView\', ' + (r.rfiid || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">',
                          '<i class="far fa-thumbs-down textRed" style="font-size:14px;"></i>',
                          '</button>'
                      );
                  }
                  
                  actionButtons.push('</div>');
                  approveRejectButtons = actionButtons.join('');

                  // Modified by Dipali V on 2nd Dec 2025 - Updated to use inline icons like other entity pages
                  var projectNameText = r.projectName || '';
                  
                  // Modified by Dipali V on 3rd Dec 2025 - Fixed column alignment for TimesheetID and other columns
                  tr = [
                      '<tr>',
                      // Project Name column - Updated by Dipali V on 18th Dec 2025 - Removed IR Details icon, moved to Action column
                      // Updated by Dipali V on 18th Dec 2025 - Fixed duplicate tooltip issue
                      '<td class="entity-code-cell" style="width:120px;">',
                      '<div class="entity-code-wrapper">',
                      truncateText(projectNameText, 15),
                      '</div>',
                      '</td>',
                      // Timesheet ID column - center aligned (narrow)
                      '<td class="text-center" style="width:50px;">', (r.timesheetID || '-'), '</td>',
                      // IR/PIR ID column - center aligned
                      '<td class="text-center" style="width:65px;">', getIRPIRDisplay(r.rfiid, r.isProforma), '</td>',
                      // Type column
                      '<td style="width:70px;">', (r.rfiTypeName || ''), '</td>',
                      // Raised On column
                      '<td style="width:80px;">', (r.rfiRaisedOn ? formatDate(r.rfiRaisedOn) : ''), '</td>',
                      // Amount column - Updated by Dipali V on 18th Dec 2025 - Changed to center align
                      '<td class="text-center" style="width:90px;"><span style="color:#1359a6;">', (r.bilCurrencyCurrencySymbol || ''), '</span> ', formatWithCommas((r.amount || '0')), '</td>',
                      // Amount (Company base) column - Updated by Dipali V on 18th Dec 2025 - Changed to center align
                      '<td class="text-center" style="width:90px;"><span style="color:#1359a6;">', (r.companyBaseCurrencySymbol || ''), '</span> ', formatWithCommas((r.companyBaseCurrencyAmount || '0')), '</td>',
                      // Amount (Corporate base) column - Updated by Dipali V on 18th Dec 2025 - Changed to center align
                      '<td class="text-center" style="width:100px;"><span style="color:#1359a6;">', (r.corporateBaseCurrencySymbol || ''), '</span> ', formatWithCommas((r.equivAmount || '0')), '</td>',
                      // Status column
                      '<td style="width:95px;">',
                      '<div class="statusDiv d-flex justify-content-start" data-bs-toggle="tooltip" data-bs-original-title="', (r.currentStatus || ''), '">',
                      '<span class="statusBox ', getTimesheetStatusClass(r.currentStatus, 'IR'), ' mx-1">&nbsp;</span>',
                      '<label class="crsrLink">', (r.currentStatus || ''), '</label>',
                      '</div>',
                      '</td>',
                      // Action column - Updated by Dipali V on 18th Dec 2025 - Includes IR Details icon along with Approve/Reject buttons
                      '<td class="text-center" style="width:100px;">', approveRejectButtons, '</td>',
                      '</tr>'
                  ].join('');
                  break;

          }

          
          return tr;
      }

          function formatWithCommas(value) {
              if (value == null || value === '' || isNaN(value)) return '';
              return Number(value).toLocaleString('en-IN');
          }

      // For Get Status Class for Timesheet
          function getTimesheetStatusClass(authenticated, flag) {
              //debugger;
          if (flag != 'IR') {
              if (authenticated === 'Y') return 'statusApproved';
              else if (authenticated === 'R') return 'statusRejected';
              else if (authenticated === 'N') return 'statusSubmitted';
              else return 'statusUnknown'; // fallback
          } else {
              // Treat Submitted and Re-submitted the same (same circle color)
              if (authenticated === 'Submitted' || authenticated === 'Re-Submitted' || authenticated === 'ReSubmitted' || authenticated === 'Resubmitted') {
                  return 'statusSubmitted';
              }
              // Other statuses fallback
              return 'statusUnknown';
          }
      }

      // Added by Dipali V on 2nd Dec 2025
      // Purpose: Get combined IR/PIR ID display with tooltip
      function getIRPIRDisplay(id, isProforma) {
          if (!id) return '-';
          
          const idType = isProforma ? 'PIR ID' : 'IR ID';
          const badgeClass = isProforma ? 'badge-pir' : 'badge-ir';
          
          return '<span class="ir-pir-badge ' + badgeClass + '" data-bs-toggle="tooltip" data-bs-original-title="' + idType + '">' + id + '</span>';
      }




      // Added by Dipali V on 2nd Dec 2025 - Truncate text helper function with tooltip
      // Updated by Dipali V on 18th Dec 2025 - Always add tooltip to prevent duplicate tooltips
      function truncateText(text, maxLength) {
          if (!text) return '';
          text = text.toString().trim();
          // Escape HTML for tooltip to prevent XSS
          var escapedText = text.replace(/"/g, '&quot;').replace(/'/g, '&#39;');
          if (text.length > maxLength) {
              return '<span class="entity-code-text" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + escapedText + '">' + text.substring(0, maxLength) + '...</span>';
          }
          // Always add tooltip even when text is not truncated to ensure consistent behavior
          return '<span class="entity-code-text" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + escapedText + '">' + text + '</span>';
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

      // For Card View
      function generateCard(r, tagId, index) {
          let card = '';
          const cardId = getCardId(tagId, index);

          switch (tagId) {
              case 34: // Milestone
                  card = [
                      '<div class="col-12">',
                      '<div class="WF_Card" id="' + cardId + '">',
                      '<div class="card shadowBox yelllowBrdr">',
                      '<div class="card-body pt-2">',
                      '<div class="row">',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="d-flex">',
                      '<h5 class="card-title mb-2">' + (r.MileStone || r.Milestone || '') + '</h5>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Current Stage:</span>',
                      '<span>' + (r.Requeststage || r.CurrentStage || '') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row">',
                      '<div class="col-md-12 col-sm-12">',
                      '<div class="row">',
                      '<div class="col-sm-3 col-12">',
                      '<small>' + (r.ProjectName || '') + '</small>',
                      '</div>',
                      '<div class="col-sm-9 col-12">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Current Stage Approver:</span>',
                      '<img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" alt="" class="img-fluid resImg mx-2">',
                      '<span>' + (r.ApproverName || 'Approver') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mb-2">',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Planned Date: </span>',
                      (r.PlannedCompletionDate ? formatDate(r.PlannedCompletionDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Actual Date: </span>',
                      (r.ActualCompletionDate ? formatDate(r.ActualCompletionDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="fas fa-dollar-sign iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Bill Amount: </span>',
                      (r.BillAmount != null ? formatCurrency(r.BillAmount) : '0.00'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mt-2">',
                      '<div class="col-md-8 col-sm-8 col-8">',
                      '<div class="card-item mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardValueTitle">Project:</span>',
                      (r.ProjectName || ''),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4 col-4">',
                      '<div class="card-item mb-1">',
                      '<div class="Action_col position-relative">',
                      '<div class="mobAppRejButns d-flex text-end">',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" data-bs-placement="top" data-bs-original-title="Approve" onclick="WBSApproval(\'34 \',\'A \',\'ListView \')">',
                      '<i class="far fa-thumbs-up text-green"></i>',
                      '</button>',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" data-bs-placement="top" data-bs-original-title="Reject" onclick="WBSApproval(\'34 \',\'R \',\'ListView \')">',
                      '<i class="far fa-thumbs-down textRed"></i>',
                      '</button>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>'
                  ].join('');
                  break;

              case 2133: // Deliverable
                  card = [
                      '<div class="col-12">',
                      '<div class="WF_Card" id="' + cardId + '">',
                      '<div class="card shadowBox yelllowBrdr">',
                      '<div class="card-body pt-2">',
                      '<div class="row">',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="d-flex">',
                      '<h5 class="card-title mb-2">' + (r.Title || '') + '</h5>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Current Stage:</span>',
                      '<span>' + (r.Requeststage || r.CurrentStage || '') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row">',
                      '<div class="col-md-12 col-sm-12">',
                      '<div class="row">',
                      '<div class="col-sm-3 col-12">',
                      '<small>' + (r.ProjectName || '') + '</small>',
                      '</div>',
                      '<div class="col-sm-9 col-12">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Type:</span>',
                      '<span>' + (r.DeliverableType || '') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mb-2">',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Start Date: </span>',
                      (r.StartDate ? formatDate(r.StartDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">End Date: </span>',
                      (r.LatestCompletionDate ? formatDate(r.LatestCompletionDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="fas fa-tasks iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Status: </span>',
                      (r.DeliverableStatus || ''),
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mt-2">',
                      '<div class="col-md-8 col-sm-8 col-8">',
                      '<div class="card-item mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardValueTitle">Billable Amount:</span>',
                      (r.BillableAmount != null ? formatCurrency(r.BillableAmount) : '0.00'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4 col-4">',
                      '<div class="card-item mb-1">',
                      '<div class="Action_col position-relative">',
                      '<div class="mobAppRejButns d-flex text-end">',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" data-bs-placement="top" data-bs-original-title="Approve" onclick="approveItem(\'' + (r.WorkflowID || '') + '\', ' + tagId + ')">',
                      '<i class="far fa-thumbs-up text-green"></i>',
                      '</button>',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" data-bs-placement="top" data-bs-original-title="Reject" onclick="rejectItem(\'' + (r.WorkflowID || '') + '\', ' + tagId + ')">',
                      '<i class="far fa-thumbs-down textRed"></i>',
                      '</button>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>'
                  ].join('');
                  break;

              case 661: // Sub Project
                  card = [
                      '<div class="col-12">',
                      '<div class="WF_Card" id="' + cardId + '">',
                      '<div class="card shadowBox yelllowBrdr">',
                      '<div class="card-body pt-2">',
                      '<div class="row">',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="d-flex">',
                      '<h5 class="card-title mb-2">' + (r.SubProjectName || '') + '</h5>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Current Stage:</span>',
                      '<span>' + (r.Requeststage || r.CurrentStage || '') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row">',
                      '<div class="col-md-12 col-sm-12">',
                      '<div class="row">',
                      '<div class="col-sm-3 col-12">',
                      '<small>' + (r.ProjectName || '') + '</small>',
                      '</div>',
                      '<div class="col-sm-9 col-12">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Project:</span>',
                      '<span>' + (r.ProjectName || '') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mb-2">',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Start Date: </span>',
                      (r.StartDate ? formatDate(r.StartDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">End Date: </span>',
                      (r.EndDate ? formatDate(r.EndDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="fas fa-clock iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Work Hours: </span>',
   formatWorkHours (r.WorkHours ? convertHoursToHHMM(r.WorkHours) : '00:00'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mt-2">',
                      '<div class="col-md-8 col-sm-8 col-8">',
                      '<div class="card-item mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardValueTitle">Current Stage:</span>',
                      (r.Requeststage || r.CurrentStage || ''),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4 col-4">',
                      '<div class="card-item mb-1">',
                      '<div class="Action_col position-relative">',
                      '<div class="mobAppRejButns d-flex text-end">',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" data-bs-placement="top" data-bs-original-title="Approve" onclick="WBSApproval(661,\'A \',\'ListView \')">',
                      '<i class="far fa-thumbs-up text-green"></i>',
                      '</button>',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" ' +
                      'data-bs-placement="top" data-bs-original-title="Reject" ' +
                      'onclick="WBSApproval(661,\'A \',\'ListView \')">' + 'Reject</button>' +
                      '<i class="far fa-thumbs-down textRed"></i>',
                      '</button>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>'
                  ].join('');
                  break;

              default: // Project (32 and others)
                  card = [
                      '<div class="col-12">',
                      '<div class="WF_Card" id="' + cardId + '">',
                      '<div class="card shadowBox yelllowBrdr">',
                      '<div class="card-body pt-2">',
                      '<div class="row">',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="d-flex">',
                      '<h5 class="card-title mb-2">' + (r.ProjectName || '') + '</h5>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-6 col-sm-6 col-6">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Current Stage:</span>',
                      '<span>' + (r.Requeststage || r.CurrentStage || '') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row">',
                      '<div class="col-md-12 col-sm-12">',
                      '<div class="row">',
                      '<div class="col-sm-3 col-12">',
                      '<p class="cardProjCode mb-2 mb-sm-0">' + (r.ProjectCode || r.ProjectID_PK || '') + '</p>',
                      '</div>',
                      '<div class="col-sm-9 col-12">',
                      '<div class="card-item justify-content-sm-end mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardStageTitle">Organization Unit:</span>',
                      '<span>' + (r.OrganizationUnit || r.OrgUnit || '') + '</span>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mb-2">',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Start Date: </span>',
                      (r.ExpectedStartDate ? formatDate(r.ExpectedStartDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="far fa-calendar-check iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">End Date: </span>',
                      (r.ExpectedEndDate ? formatDate(r.ExpectedEndDate) : 'N/A'),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4">',
                      '<div class="card-item mb-1">',
                      '<div class="cardLeftImg">',
                      '<i class="fas fa-briefcase iconBlue pe-1"></i>',
                      '</div>',
                      '<div class="cardContent">',
                      '<span class="CardViewTitle">Project Type: </span>',
                      (r.ProjectType || ''),
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="row mt-2">',
                      '<div class="col-md-8 col-sm-8 col-8">',
                      '<div class="card-item mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardValueTitle">Estimated Efforts:</span>',
                      (r.EstimatedEfforts || '0'),
                      '</div>',
                      '</div>',
                      '<div class="card-item mb-1">',
                      '<div class="cardContent">',
                      '<span class="CardValueTitle">Short Title:</span>',
                      (r.ShortJobTitle || ''),
                      '</div>',
                      '</div>',
                      '</div>',
                      '<div class="col-md-4 col-sm-4 col-4">',
                      '<div class="card-item mb-1">',
                      '<div class="Action_col position-relative">',
                      '<div class="mobAppRejButns d-flex text-end">',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" data-bs-placement="top" data-bs-original-title="Approve" onclick="approveItem(\'' + (r.WorkflowID || '') + '\', ' + tagId + ')">',
                      '<i class="far fa-thumbs-up text-green"></i>',
                      '</button>',
                      '<button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button" data-bs-placement="top" data-bs-original-title="Reject" onclick="rejectItem(\'' + (r.WorkflowID || '') + '\', ' + tagId + ')">',
                      '<i class="far fa-thumbs-down textRed"></i>',
                      '</button>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>',
                      '</div>'
                  ].join('');
          }

          return card;
      }

      // Utility functions
      // For Get Card Id
      function getCardId(tagId, index) {
          const prefixMap = {
              32: 'ProjWF_Card',
              661: 'subProjCard',
              34: 'MS_Card',
              2133: 'DlvrblCard',
              454: 'ModuleCard',
              1039: 'ChangeReqCard',
              1208: 'LeavesCard',
              1049: 'ProjTSCard',
              2044: 'IRCard'
          };
          const prefix = prefixMap[tagId] || 'WF_Card';
          return prefix + index;
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
          GRFIID = UniqueID;
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

          // For Approve/Reject IR (open modal)
          function ApproveRejectIR(Action, FromWhere, IRID) {
             // debugger;
              window.parent.$("#ApproveRejectIR").modal('show');
              if (FromWhere === "ListView") { // ✅ fixed case
                  GRFIID = IRID;
                  CUniqueID = GRFIID;
                  Data = StrResult.find(item => item.rfiid === IRID);
                  SelectedProjectData = Data ? [Data] : [];
              } else {
                  GRFIID = GRFIID;
                  CUniqueID = GRFIID;
              }

              strAction = Action;
              const modal = window.parent.$("#ApproveRejectIR");
              const caption = modal.find("#IRApproveRejectCaption");
              const btn = modal.find("#ApproveRejectIRBtn");
              if (Action === "A") {
                  caption.text('Approve');
                  btn.text('Approve');
                 // btn.removeClass('btnred btngreen');
                 // btn.addClass('btngreen');
                  //if (FromWhere === "ListView") {
                      window.parent.$("#IRStatus").val('Approved')
                  //}
              } else {
                  caption.text('Reject');
                  btn.text('Reject');
                 // btn.removeClass('btnred btngreen');
                  //btn.addClass('btnred');
                  //if (FromWhere === "ListView") {
                      window.parent.$("#IRStatus").val('Rejected')
                  //}
              }
              window.parent.$("#txtIRComments").val("");
              modal.find("#ApproveRejectIRBtn").off("click").on("click", function () {
                  ApproveRejectIR_Click();
              });

              
          }


          // For Approve/Reject IR (submit)
          function ApproveRejectIR_Click() {
            //  debugger;
              var fullUrl = "api/EntityApproval/IRApproveReject"
              var CurrentRFIStatus = window.parent.$("#IRStatus").val();
              var comments = window.parent.$("#txtIRComments").val();

              if (CurrentRFIStatus == "Select Status") {
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify('<%= MyBase.GetResourceString("C_Statusblank") %>', 'error', 25);
                  } else {
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify('<%= MyBase.GetResourceString("C_Statusblank") %>', 'error', 25);
                  }
                  window.parent.$("#IRStatus").focus();
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
                  window.parent.$("#txtIRComments").focus();
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
                  window.parent.$("#txtIRComments").focus();
                  return false;
              }


              const ctx = getContext();
              var payload = {
                  RFIID: CUniqueID,
                  ProjectID: GProjectID,
                  UserName: ctx.UserName,
                  comments: comments,
                  CurrentRFIStatus: CurrentRFIStatus,
                  strAction: strAction
              };
              // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
              var param = JSON.stringify(payload);
              
              try {
                  var strResult = AJAXCallWithResult(fullUrl, param, false, "POST");
                  console.log('Get Project Approve/Reject: ', strResult);
                  
                  if (strResult && strResult.result === "Success") {
                      // Modified by Dipali V on 2nd Dec 2025 - Fixed status message logic for Approved/Rejected/Cancelled
                      var irStatusVal = window.parent.$("#IRStatus").val();
                      var Status = "";
                      var alertType = 'success';
                      
                      if (irStatusVal === "Approved") {
                          Status = "<%= MyBase.GetResourceString("C_IRApproved") %>";
                      } else if (irStatusVal === "Rejected") {
                          Status = "<%= MyBase.GetResourceString("C_IRRejected") %>";
                      } else if (irStatusVal === "Cancelled") {
                          Status = "<%= MyBase.GetResourceString("C_IRCancelled") %>";
                      }

                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify(Status, alertType, 25);

                      // Hide modal in parent page
                      if (window.parent && window.parent.$) {
                          window.parent.$("#ApproveRejectIR").modal('hide');
                      }

                      // Hide offcanvas in current iframe
                      const offcanvasEl = window.parent.document.getElementById('IRDetailsOffcanvas');
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
                  Data = data.find(item => item.rfiid === UniQueID);
                  SelectedProjectData = Data;
                  if (!Data) {
                      console.log('IR data not found for ID:', rfiid);
                      return;
                  }
              }

              switch (entityTypeID) {
                  case CTagID:
                      var DivID = 'IR_DetailsTab'
                      bindNonWBSDetails(entityTypeID, Data, DivID);
                      break;
              }


          }

          // For Bind Details Section (Non-WBS)
          function bindNonWBSDetails(entityTypeID, projectData, DivID) {
              // debugger;
              var fieldMappings = "";
              if (entityTypeID === CTagID) {
                  fieldMappings = {
                      'IR ID :': projectData.rfiid || 'N/A',
                      'PIR ID :': projectData.pirid || 'N/A',
                      'Type :': projectData.rfiTypeName || 'N/A',
                      'Credit days :': projectData.creditDays || 'N/A',
                      'Customer :': projectData.customerName || 'N/A',
                      //'Currency :': projectData.currencyCode || 'N/A',
                      'Currency :': projectData.bilCurrencyCode || 'N/A',
                      'Contact Person :': projectData.contactPerson || 'N/A',
                      'Sales Period :': projectData.salesPeriod || 'N/A',
                      'Email confirm :': projectData.emailconfirm || 'N/A',
                      'Sales Person :': projectData.salesPersonName || 'N/A',
                      'Contract :': projectData.contractSummary || 'N/A',
                      'IR Items Header :': projectData.rfiHeader || 'N/A'
                  };

              }


              bindDataToHTML(fieldMappings, DivID);
              GProjectID = projectData.projectID;
              SelectedProjectData = projectData;

              // === Send offcanvas HTML to parent for rendering ===
              const offcanvasEl = document.getElementById('IRDetailsOffcanvas');
              if (!offcanvasEl) {
                  console.warn("Offcanvas element not found in iframe.");
                  return;
              }

              // get HTML string
              const offcanvasHTML = offcanvasEl.outerHTML;

              // send to parent with RFIID for loading line items
              window.parent.postMessage({
                  action: "renderOffcanvas",
                  html: offcanvasHTML,
                  projectID: projectData.projectID || null,
                  rfiID: projectData.rfiid || null  // Added by Dipali V on 18th Dec 2025 - Pass RFIID to parent
              }, "*");

              // Added by Dipali V on 18th Dec 2025 for IR Line Items Section - Load line items
              // Call after a delay to ensure parent window has rendered the offcanvas
              if (projectData.rfiid) {
                  // Wait for parent to render offcanvas, then load data
                  setTimeout(function () {
                      loadIRLineItems(projectData.rfiid);
                  }, 300);
              }
          }

          // Added by Dipali V on 18th Dec 2025 for IR Line Items Section
          // Function to load and display IR Line Items
          // Updated to work with parent window where offcanvas is rendered
          function loadIRLineItems(rfiID) {
              if (!rfiID || rfiID <= 0) {
                  console.warn('Invalid RFIID for loading line items:', rfiID);
                  return;
              }

              // Find tbody in parent window (where offcanvas is rendered)
              // Fallback to current window if parent not available
              let tbody = null;
              let doc = document;

              if (window.parent && window.parent.document) {
                  tbody = window.parent.document.getElementById('IRLineItemsTableBody');
                  if (tbody) {
                      doc = window.parent.document;
                  }
              }

              if (!tbody) {
                  tbody = document.getElementById('IRLineItemsTableBody');
                  doc = document;
              }

              if (!tbody) {
                  console.warn('IR Line Items table body not found in parent or current window');
                  // Retry after delay in case DOM is not ready yet
                  setTimeout(function () {
                      loadIRLineItems(rfiID);
                  }, 500);
                  return;
              }

              // Show loading state
              tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted">Loading line items...</td></tr>';

              const fullUrl = "api/EntityApproval/GetRFILineItemsDetails";
              const payload = JSON.stringify({ RFIID: rfiID });

              try {
                  const result = AJAXCallWithResult(fullUrl, payload, false, "POST");
                  console.log('IR Line Items API Response:', result);  // Debug log

                  // Handle API response structure: { Status: "SUCCESS", Data: { LineItems: [], Totals: {}, Count: 1 } }
                  // Or direct structure: { lineItems: [], totals: {}, count: 1 }
                  let lineItems = [];
                  let totals = {};

                  if (result) {
                      // Check for wrapped response with Status and Data
                      if (result.Status === "SUCCESS" || result.status === "SUCCESS") {
                          const data = result.Data || result.data || {};
                          lineItems = data.lineItems || data.LineItems || [];
                          totals = data.totals || data.Totals || {};
                      }
                      // Check for direct response structure
                      else if (result.count > 0 || result.Count > 0 || result.lineItems || result.LineItems) {
                          lineItems = result.lineItems || result.LineItems || [];
                          totals = result.totals || result.Totals || {};
                      }
                  }

                  console.log('Parsed Line Items:', lineItems);  // Debug log
                  console.log('Parsed Totals:', totals);  // Debug log

                  if (lineItems.length === 0) {
                      tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted">No line items found</td></tr>';
                      updateTotals(0, 0, 0, doc);
                      return;
                  }
                  var GbilCurrencyCurrencySymbol = "";
                  var GcorporateBaseCurrencySymbol = "";
                  var GcompanyBaseCurrencySymbol = "";
                  // Build table rows
                  let html = '';
                  lineItems.forEach((item, index) => {
                      // Handle both camelCase and PascalCase property names
                      const discount = (item.isDiscountItem === 1 || item.IsDiscountItem === 1) ? 'Yes' : 'No';
                      const quantity = formatNumber(item.quantity || item.Quantity || 0);
                      const rate = formatCurrency(item.rate || item.Rate || 0);
                      const amount = formatCurrency(item.amount || item.Amount || 0);
                      const baseAmount = formatCurrency(item.baseCurrencyAmount || item.BaseCurrencyAmount || 0);
                      const companyBaseAmount = formatCurrency(item.companyBaseCurrencyAmount || item.CompanyBaseCurrencyAmount || 0);
                      const itemDescription = item.itemDescription || item.ItemDescription || '';

                      html += `
                          <tr>
                              <td class="text-center">${index + 1}</td>
                              <td>${escapeHtml(itemDescription)}</td>
                              <td class="text-center">${discount}</td>
                              <td class="text-end">${quantity}</td>
                              <td class="text-end">${rate}</td>
                              <td class="text-end fw-semibold">${amount}</td>
                              <td class="text-end">${baseAmount}</td>
                              <td class="text-end">${companyBaseAmount}</td>
                          </tr>
                      `;
                  });

                  tbody.innerHTML = html;
                  // Handle both camelCase and PascalCase totals
                  updateTotals(
                      totals.totalAmount || totals.TotalAmount || 0,
                      totals.totalBaseCurrencyAmount || totals.TotalBaseCurrencyAmount || 0,
                      totals.totalCompanyBaseCurrencyAmount || totals.TotalCompanyBaseCurrencyAmount || 0,
                      doc
                  );
              } catch (error) {
                  console.error('Error loading IR line items:', error);
                  tbody.innerHTML = '<tr><td colspan="8" class="text-center text-danger">Error loading line items: ' + error.message + '</td></tr>';
                  updateTotals(0, 0, 0, doc);
              }
          }

          // Added by Dipali V on 18th Dec 2025 for IR Line Items Section
          // Helper function to update totals
          // Updated to work with specified document context (parent or current window)
          function updateTotals(totalAmount, totalBaseCurrency, totalCompanyBase, docContext) {

              const doc = docContext || document;
              const totalAmountEl = doc.getElementById('totalAmount');
              const totalCorporateBaseEl = doc.getElementById('totalCorporateBase');
              const totalCompanyBaseEl = doc.getElementById('totalCompanyBase');

              if (totalAmountEl)
                  totalAmountEl.textContent =
                      GbilCurrencyCurrencySymbol + ' ' + formatCurrency(totalAmount);

              if (totalCorporateBaseEl)
                  totalCorporateBaseEl.textContent =
                      GcorporateBaseCurrencySymbol + ' ' + formatCurrency(totalBaseCurrency);

              if (totalCompanyBaseEl)
                  totalCompanyBaseEl.textContent =
                      GcompanyBaseCurrencySymbol + ' ' + formatCurrency(totalCompanyBase);
          }

          // Added by Dipali V on 18th Dec 2025 for IR Line Items Section
          // Helper function to format currency
          function formatCurrency(value) {
              if (value == null || value === undefined) return '0.00';
              return parseFloat(value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
          }

          // Added by Dipali V on 18th Dec 2025 for IR Line Items Section
          // Helper function to format number
          function formatNumber(value) {
              if (value == null || value === undefined) return '0.00';
              return parseFloat(value).toFixed(2);
          }

          // Added by Dipali V on 18th Dec 2025 for IR Line Items Section
          // Helper function to escape HTML
          function escapeHtml(text) {
              if (!text) return '';
              const div = document.createElement('div');
              div.textContent = text;
              return div.innerHTML;
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
          function updateValueWithIcons(container, value, labelText) {
              const iconConfig = {
                  'Start Date:': { icon: 'far fa-calendar-check iconBlue pe-1', position: 'before' },
                  'End Date:': { icon: 'far fa-calendar-check iconBlue pe-1', position: 'before' },
                  'Work (HH:MM):': { icon: 'far fa-clock iconBlue pe-1', position: 'before' },
                  /* 'Project Currency:': { icon: 'fas fa-rupee-sign iconBlue', position: 'inside' }*/
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

          // For Open IR History Modal
          function IRHistory() {
              window.parent.$("#IRShowHisModal").modal('show');
              GetRFIHistory();
          }

          // For Get IR History
          function GetRFIHistory() {
              var ModifiedBy = window.parent.$("#IRModifiedBy").val();
              var ModifiedField = window.parent.$("#IRModifiedFields").val();

              if (!GRFIID) {
                  console.log("RFIID is required.");
                  return;
              }

              var payload = {
                  RFIID: GRFIID,
                  ModifiedBy: ModifiedBy,
                  ModifiedField: ModifiedField
              };

              var fullUrl = "api/EntityApproval/GetRFIStatusHistory";
              var strResult = AJAXCallWithResult(fullUrl, JSON.stringify(payload), false, "POST");

              console.log('RFI History Response: ', strResult);

              if (strResult.RFIStatusHistoryDto && strResult.RFIStatusHistoryDto.length > 0) {
                  var data = strResult.RFIStatusHistoryDto;
                  fillIRDropdowns(data);
                  renderHistoryTable(data);
              } else {
                  console.log("No history data returned.");
                  var tbody = window.parent.document.getElementById("#LeavesShowHisTbl tbody");
                  tbody.innerHTML = "<tr><td colspan='5' class='text-center'>No history found</td></tr>";
              }
          }

          // Populate dropdowns dynamically
          // For Populate IR History Dropdowns
          function fillIRDropdowns(data) {
              var $modifiedBy = window.parent.$("#IRModifiedBy");
              var $modifiedField = window.parent.$("#IRModifiedFields");

              //  Get unique ChangedBy values (handle case variations)
              var uniqueUsers = [...new Set(data.map(item => item.ChangedBy || item.changedBy).filter(Boolean))];

              // Fill ModifiedBy dropdown
              $modifiedBy.empty().append('<option value="">Select Modified By</option>');
              uniqueUsers.forEach(user => {
                  $modifiedBy.append(`<option value="${user}">${user}</option>`);
              });

              // Fill ModifiedField dropdown (always Status)
              $modifiedField.empty().append('<option value="">Select Modified Field</option>');
              $modifiedField.append('<option value="Status">Status</option>');

              // Refresh and re-render selectpickers properly (inside modal)
              $modifiedBy.selectpicker('refresh').selectpicker('render');
              $modifiedField.selectpicker('refresh').selectpicker('render');


              // Rebind change events
              $modifiedBy.off("change").on("change", () => filterIRHistory(data));
              $modifiedField.off("change").on("change", () => filterIRHistory(data));
          }

          $('#IRShowHisModal').on('shown.bs.modal', function () {
              $('.selectpicker').selectpicker('refresh');
          });

          // Filter table by dropdown selections
          // For Filter IR History table
          function filterIRHistory(fullData) {
              var selectedUser = window.parent.$("#IRModifiedBy").val();
              var selectedField = window.parent.$("#IRModifiedFields").val();

              var filtered = fullData.filter(item => {
                  var byMatch = !selectedUser || item.changedBy === selectedUser;
                  var fieldMatch = !selectedField || selectedField === "Status";
                  return byMatch && fieldMatch;
              });

              // Reset to page 1 on filter change, then render
              _irHistPage = 1;
              renderHistoryTable(filtered);
          }

          // For Render IR History table - with pagination (same style as main table)
          var _irHistData = [];
          var _irHistPage = 1;
          var _irHistItemsPerPage = 5;

          function renderHistoryTable(data) {
              _irHistData = (data && data.length > 0) ? data : [];
              _irHistPage = 1;
              _irHistEnsurePagination();
              _irHistRenderPage();
          }

          function _irHistRenderPage() {
              var tbody = window.parent.document.querySelector('#LeavesShowHisTbl tbody');
              if (!tbody) return;
              tbody.innerHTML = '';

              if (!_irHistData || _irHistData.length === 0) {
                  tbody.innerHTML = "<tr><td colspan='5' class='text-center'>No matching records found</td></tr>";
                  _irHistUpdatePagination();
                  return;
              }

              var startIdx = (_irHistPage - 1) * _irHistItemsPerPage;
              var endIdx   = Math.min(startIdx + _irHistItemsPerPage, _irHistData.length);

              for (var i = startIdx; i < endIdx; i++) {
                  var item = _irHistData[i];
                  var tr = window.parent.document.createElement('tr');
                  tr.innerHTML =
                      '<td>Status</td>' +
                      '<td>' + (item.oldStatus || '') + '</td>' +
                      '<td>' + (item.newStatus || '') + '</td>' +
                      '<td>' + (item.changedOn ? new Date(item.changedOn).toLocaleString('en-GB') : '') + '</td>' +
                      '<td>' + (item.changedBy || '') + '</td>';
                  tbody.appendChild(tr);
              }
              _irHistUpdatePagination();
          }

          function _irHistUpdatePagination() {
              var total = _irHistData.length;
              var totalPages = Math.ceil(total / _irHistItemsPerPage) || 1;

              var pd = (window.parent && window.parent.document) ? window.parent.document : document;

              var totalEl = pd.getElementById('irHistTotal');
              if (totalEl) totalEl.textContent = total;

              var prevLi = pd.getElementById('irHistBtnPrev');
              var prevA = pd.getElementById('irHistLinkPrev');
              var nextLi = pd.getElementById('irHistBtnNext');
              var nextA = pd.getElementById('irHistLinkNext');

              var disabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;';
              var enabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#1359a6;background-color:#fff;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:auto;cursor:pointer;transition:all 0.3s ease;';

              // Previous button
              if (_irHistPage <= 1 || total === 0) {
                  if (prevLi) prevLi.style.cursor = 'not-allowed';
                  if (prevA) { prevA.setAttribute('style', disabledAStyle); prevA.removeAttribute('onclick'); }
              } else {
                  if (prevLi) prevLi.style.cursor = 'pointer';
                  if (prevA) { prevA.setAttribute('style', enabledAStyle); prevA.setAttribute('onclick', 'window.frames[0]._irHistGoToPrev()'); }
              }

              // Next button
              if (_irHistPage >= totalPages || total === 0) {
                  if (nextLi) nextLi.style.cursor = 'not-allowed';
                  if (nextA) { nextA.setAttribute('style', disabledAStyle); nextA.removeAttribute('onclick'); }
              } else {
                  if (nextLi) nextLi.style.cursor = 'pointer';
                  if (nextA) { nextA.setAttribute('style', enabledAStyle); nextA.setAttribute('onclick', 'window.frames[0]._irHistGoToNext()'); }
              }
          }

          window._irHistGoToPrev = function () {
              if (_irHistPage > 1) { _irHistPage--; _irHistRenderPage(); }
          };

          window._irHistGoToNext = function () {
              var totalPages = Math.ceil(_irHistData.length / _irHistItemsPerPage) || 1;
              if (_irHistPage < totalPages) { _irHistPage++; _irHistRenderPage(); }
          };

          function _irHistEnsurePagination() {
              var pd = (window.parent && window.parent.document) ? window.parent.document : document;
              if (pd.getElementById('irHistPagination')) return;

              var div = pd.createElement('div');
              div.id = 'irHistPagination';
              div.setAttribute('style', 'display:flex;justify-content:flex-end;align-items:center;gap:1rem;padding:8px 4px 4px;');

              div.innerHTML =
                  '<div id="irHistInfoDiv" style="color:#333;font-size:14px;font-weight:300;">' +
                      '<span>Total Records: </span>' +
                      '<span id="irHistTotal">0</span>' +
                  '</div>' +
                  '<nav aria-label="IR History navigation">' +
                      '<ul style="display:flex;list-style:none;margin:0;padding:0;gap:4px;">' +
                          '<li id="irHistBtnPrev" style="cursor:not-allowed;">' +
                              '<a id="irHistLinkPrev" aria-label="Previous" title="Previous Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-left"></i>' +
                              '</a>' +
                          '</li>' +
                          '<li id="irHistBtnNext" style="cursor:not-allowed;">' +
                              '<a id="irHistLinkNext" aria-label="Next" title="Next Page"' +
                              ' style="display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;">' +
                                  '<i class="fas fa-angle-double-right"></i>' +
                              '</a>' +
                          '</li>' +
                      '</ul>' +
                  '</nav>';

              var tbl = pd.getElementById('LeavesShowHisTbl');
              if (tbl && tbl.parentNode) {
                  tbl.parentNode.insertBefore(div, tbl.nextSibling);
              }
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
              var $tbody = $('#IRPIR_Tbl tbody');
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
              var $tbody = $('#IRPIR_Tbl tbody');
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
