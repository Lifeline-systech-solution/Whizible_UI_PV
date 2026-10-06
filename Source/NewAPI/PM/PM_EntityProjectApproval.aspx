<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityProjectApproval.aspx.vb" Inherits="Whizible.PM_EntityProjectApproval" %>

<!DOCTYPE html>
<html>
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
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/PM_EntityApproval.css?v=2">

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
    .pagination-container {
        background: white;
        display: flex !important;
        justify-content: flex-end;
        align-items: center;
        gap: 1rem;
        margin-top: 0;
        position: fixed;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 1000;
    }
    .pagination-info { color: #333; font-size: 14px; font-weight: 300; }
    .pagination { margin-bottom: 20px !important; margin-top: 20px !important; }
    .pagination .page-item { margin: 0 2px; }
    .pagination .page-link { padding: 8px 12px; color: #1359a6; background-color: #fff; border: 1px solid #dee2e6; border-radius: 4px; text-decoration: none; transition: all 0.3s ease; }
    .pagination .page-link:hover { color: #fff; background-color: #1359a6; border-color: #1359a6; }
    .pagination .page-item.fa-disabled .page-link { color: #6c757d; background-color: #f8f9fa; border-color: #dee2e6; cursor: not-allowed; pointer-events: none; }
    .pagination .page-item.fa-disabled .page-link:hover { color: #6c757d; background-color: #f8f9fa; border-color: #dee2e6; }
    li#btnprevious.page-item.fa-disabled { cursor: not-allowed; }
    li#btnnext.page-item.fa-disabled { cursor: not-allowed; }
    li#wfHistBtnPrev.page-item.fa-disabled { cursor: not-allowed; }
    li#wfHistBtnNext.page-item.fa-disabled { cursor: not-allowed; }
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
       <!-- Project Entity Start here -->
  
      <div class="allEntity col-sm-12" id="projectEntity">
          <!-- Desktop View Starts here -->
          <%-- List view always visible; card view hidden on all resolutions - Updated by Dipali V on 11th March 2026 --%>
          <div class="projListViewDiv d-block" id="projListViewSec">
              <div class="table-responsive">
                  <%-- Modified by Dipali V on 2nd Dec 2025 - Added revision indicator column and improved layout --%>
                  <table id="projEntityTable" class="table tbl_wrkflow_approval" style="width: 100%;">
                      <thead class="stickyTblHeader">
                          <tr>
                              <th></th><%-- Revision indicator column - Added by Dipali V on 2nd Dec 2025 --%>
                              <th><%= MyBase.GetResourceString("C_ProjectCode") %></th>
                              <th><%= MyBase.GetResourceString("CProjectName") %></th>
                              <th><%= MyBase.GetResourceString("C_StartDate") %></th>
                              <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                              <th><%= MyBase.GetResourceString("C_Work(Hrs)") %></th>
                              <%--<th><%= MyBase.GetResourceString("C_CurrentStage") %></th>--%>
                              <th><%= MyBase.GetResourceString("C_SND_Comment") %></th>
                              <th><%= MyBase.GetResourceString("C_Action") %></th>
                          </tr>
                      </thead>
                      <tbody>
                      </tbody>
                  </table>
              </div>
              <!-- Pagination - Added to match PM_Documents.aspx style - Vaibhav K -->
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
          </div>
          <!-- Desktop View Ends here -->
          <!-- Mobile View Starts here -->
          <div class="projCardViewDiv d-none" id="projCardViewSec">
              
          </div>
          <!-- Mobile View Ends here -->
      </div>

  <!-- Project Entity End here -->
        <!--Project information offcanvas Section Start Here-->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="showProjInfo_offcanvas">
            <div class="offcanvas-body">
                <div id="ProjInfo_Sec" class="ProjInfoDetails">


                    <%--<div class="graybg container-fluid py-1 mb-2 statckmainheader">
                        <div class="row">
                            <div class="col-sm-12">
                                <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ProjectInformation") %></h5>
                            </div>
                        </div>
                    </div>--%>

                     <div class="graybg container-fluid py-1 mb-2 statckmainheader">
    <div class="row">
        <div class="col-sm-12 d-flex justify-content-between align-items-center">

            <!-- Title -->
            <h5 class="pgtitle mb-0">
                <%= MyBase.GetResourceString("C_ProjectInformation") %>
            </h5>

            <!-- Close Button -->
            <button type="button"
                class="btn btn-sm btn-danger-modern"
                data-bs-toggle="tooltip"
                title="Close"
                data-bs-dismiss="offcanvas">
                
                <i class="fas fa-times"></i>
            </button>

        </div>
    </div>
</div>



                    <div class="row mt-2 mb-2 project_timeperiod">
                        <div class="col-sm-12 ">
                            <div class="row">
                                <div class="col-sm-2">
                                </div>
                                <div class="col-sm-10 d-flex justify-content-end gap-3">
                                    <div id="Actionlinks_32" class="col-sm-12 d-flex justify-content-end gap-3">
                                       
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                        <h6 class="text-end">
                            <a href="javascript:;" onclick="callIframeFunctionWorkflowDewtails('GetWFDetails','0','0')"><i
                                class="fas fa-recycle statusIcon"></i></a>
                            <%= MyBase.GetResourceString("CStatusIR ") %> : <span class="WFCStatus"></span>
                        </h6>

                        

                        <div class="accordion WF_TopAccordianPanel mb-3 mt-3 " id="ProjInfoDetailsAcc">
                            <div class="accordion-item mb-3">
                                <h2 class="accordion-header" id="subProjDetailsHeading">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#ProjInfoDetailsTab" aria-expanded="true" aria-controls="ProjInfoDetailsTab">
                                        <i class="fas fa-info-circle me-2 project-details-icon"></i><%= MyBase.GetResourceString("C_Details") %>
                                    </button>
                                </h2>

                                <div id="ProjInfoDetailsTab" class="accordion-collapse collapse show"
                                    aria-labelledby="subProjDetailsHeading">
                                    <div class="accordion-body">
                                        <div class="ProjInfoDetailsContent">
                                            <div class="d-flex align-items-center justify-content-end gap-2">
                                                <span class="fw-semibold text-muted" style="font-size: 12px;">Legend:</span>
                                                <!-- Status Legends -->
                                                <span class="d-flex align-items-center gap-1">
                                                    <span style="display: inline-block; width: 14px; height: 14px; border-radius: 3px; background: #ffe2b9;"></span>
                                                    <small style="font-size: 11px;"><%= MyBase.GetResourceString("C_RevisedDetails") %></small>
                                                </span>
                                            </div>
                                         </div>
                                        <div class="main-form">
                                            <div class="row mt-2">
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_ProjectCode") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_AbbreviatedName") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("CProjectName") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_Description") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_ProjectGroup") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_Billable") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_StartDate") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span><i class="far fa-calendar-check iconBlue pe-1"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_EndDate") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span><i class="far fa-calendar-check iconBlue pe-1"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_CommercialDetails") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_HHMM") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span><i class="far fa-clock iconBlue pe-1"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_DurationDays") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_PV") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                               <%-- <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_PC") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>

                                                    </div>
                                                </div>--%>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_BG") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_OrganizationUnit") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_DU") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_DT") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_Practice") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_PT") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_Customer") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_PS") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_ProjectSponsor") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_LifeCycle") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_ProjectSizeUnit") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("P_ProposalReference") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_ProjectStatus") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class=" row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_NoOfResources") %>:</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
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
        <!--Project information offcanvas Section End Here-->
        <div class="clearfix"></div>
    </div>
    <!-- Close main-content-wrapper -->


      <script>

          var GProjectID = 0;
          var CTagID = 32;
          var CUniqueID = 0;
          var strAlertType = 'T';
          var GFromWhere = "";
          var GChangeRequestID_PK = 0;
          var GProjectName = "";
          var SelectedStage = "";
          var SelectedWF = "";
          var CnatureOfDemandID = "";
          var IsChecklistMandatory = false;
          var IsCheckIResumeTimesheet = false;
          var IsByPassResumeTimesheet = false;  // Added by Dipali V on 5th Dec 2025 - Flag to bypass resume timesheet alert
          var ProjectOnHoldComments = "";
          var BlockTimeSheetComments = "";
          var SelectedStageID = "";
          var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
          var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
          var EditAccess = "<%= m_EditAccess %>";
          window.parent.alertify.set('notifier', 'position', 'top-right');


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

          //For Get Paramter which gets from Parent Page 
          function getQueryParam(name) {
              const urlParams = new URLSearchParams(window.location.search);
              return urlParams.get(name);
          }

          // For Filter Section
          function readTopFilters() {
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
          // fetch List Data 
          function fetchEntityDataForTag(flag, tagId) {
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
                  32: { table: '#projEntityTable', card: '#projCardViewSec' }
              };

              const currentMap = tableMap[tagId] || { table: '#projEntityTable', card: '#projCardViewSec' };
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
                      console.log(card);
                      console.log($('#projCardViewSec').length);
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
              // Reinitialize tooltips for newly created elements
              $('[data-bs-toggle="tooltip"]').tooltip();
             
          }

          // For Plotting List View
          function generateTableRow(r, tagId, index) {
              //debugger;
              let tr = '';
              switch (tagId) {
                  case CTagID:
                      // Determine the stage safely
                      var stageName = (r.requeststage || r.currentStage || '').trim().toUpperCase();
                      var hasEditAccess = (EditAccess === true || EditAccess === 'True');
                      // Initialize action cell content
                      let actionButtons = '';
                      if (stageName === 'START') {
                          if (hasEditAccess) {
                              // Show "Send for Approval" button
                              actionButtons = [
                                  '<div class="deskAppRejButns d-flex justify-content-center">',
                                  '<button class="btn px-2" type="button" data-bs-toggle="tooltip" data-bs-original-title="Send for Approval" ',
                                  'onclick="SendForApproval(\'' + (r.natureOfDemand || '') + '\',\'' + (r.projectID || '') + '\', \'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + (r.requeststageID || 0) + ',' + (r.projectID || 0) + ',\'S\',\'ListView\')">',
                                  '<i class="fas fa-paper-plane text-blue"></i>',
                                  '</button>',
                                  '</div>'
                              ].join('');
                          }
                      }
                      else if (stageName !== 'COMPLETE') {
                          if (hasEditAccess) {
                              // Show Approve/Reject buttons
                              // Modified by Dipali V on 5th Dec 2025 - Added stage name parameter for checklist binding
                              // Updated by Dipali V on 18th Dec 2025 - Added Project Details icon to Action column, standardized icon size (20px), width (20px), and gap (gap-3)
                              var stageNameEscaped = (r.requeststage || r.currentStage || '').replace(/'/g, "\\'");
                              // Updated by Dipali V on 18th Dec 2025 - Added Show Details icon to Action column, standardized icon size (14px), width (20px), and gap (gap-3)
                              actionButtons = [
                                  '<div class="deskAppRejButns d-flex justify-content-center gap-3 align-items-center">',
                                  '<a href="javascript:;" onclick="GetDetails(\'' + (r.projectID || '') + '\',32,\'' + (r.projectID || '') + '\')" class="project-details-icon" data-bs-toggle="tooltip" data-bs-original-title="Project Details" style="width:20px;display:inline-flex;justify-content:center;">',
                                  '<i class="far fa-list-alt" style="font-size:14px;"></i>',
                                  '</a>',
                                  '<a href="javascript:;" onclick="GetWFDetails(\'' + (r.projectID || '') + '\',32,\'' + (r.projectID || '') + '\')" class="project-wf-details-icon" data-bs-toggle="tooltip" data-bs-original-title="Show Details" style="width:20px;display:inline-flex;justify-content:center;">',
                                  '<i class="fas fa-list-ul" style="font-size:14px;"></i>',
                                  '</a>',
                                  '<button type="button" data-bs-toggle="tooltip" data-bs-original-title="Approve" ',
                                  'onclick="ApproveRejectItem(\'' + (r.projectID || '') + '\', \'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + (r.requeststageID || 0) + ',' + (r.projectID || 0) + ',\'A\',\'ListView\',\'' + stageNameEscaped + '\')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">',
                                  '<i class="far fa-thumbs-up text-green" style="font-size:14px;"></i>',
                                  '</button>',
                                  '<button type="button" data-bs-toggle="tooltip" data-bs-original-title="Reject" ',
                                  'onclick="ApproveRejectItem(\'' + (r.projectID || '') + '\', \'' + (r.workflowInstanceID || '') + '\',' + tagId + ',' + (r.requeststageID || 0) + ',' + (r.projectID || 0) + ',\'R\',\'ListView\',\'' + stageNameEscaped + '\')" style="width:20px;display:inline-flex;justify-content:center;border:none;background:none;padding:0;">',
                                  '<i class="far fa-thumbs-down textRed" style="font-size:14px;"></i>',
                                  '</button>',
                                  '</div>'
                              ].join('');
                          }
                      }

                      // Build the full row
                      // Modified by Dipali V on 2nd Dec 2025 - Added revision indicator, old/new values with colors
                      var projectCodeText = r.projectCode || r.projectID || '';
                      var revisionNumber = r.revisionnumber || 0;
                      
                      // Revision indicator - R for revised (>1), N for new (<=1) - Added by Dipali V on 2nd Dec 2025
                      var revisionIndicator = '';
                      if (revisionNumber > 1) {
                          revisionIndicator = '<span class="revision-circle revision-r" data-bs-toggle="tooltip" data-bs-original-title="Revised (Revision No.: ' + revisionNumber + ')">R</span>';
                      } else {
                          revisionIndicator = '<span class="revision-circle revision-n" data-bs-toggle="tooltip" data-bs-original-title="New">N</span>';
                      }
                      
                      // Old/New date values with background colors - Modified by Dipali V on 2nd Dec 2025
                      // If old data not present: show current value twice (both green)
                      // If old and new different: Old (green) + New (red)
                      // If old and new same: Both green
                      var startDateCell = '';
                      var endDateCell = '';
                      var workHrsCell = '';
                      
                      var currentStartDate = r.expectedStartDate ? formatDate(r.expectedStartDate) : '';
                      var currentEndDate = r.expectedEndDate ? formatDate(r.expectedEndDate) : '';
                      var currentWorkHrs = formatWithCommas(r.estimatedEfforts || '');
                      
                      var oldStartDate = r.oldExpectedStartDate ? formatDate(r.oldExpectedStartDate) : '';
                      var oldEndDate = r.oldExpectedEndDate ? formatDate(r.oldExpectedEndDate) : '';
                      var oldWorkHrs = r.oldEstimatedEfforts ? formatWithCommas(r.oldEstimatedEfforts) : '';
                      
                      // Build date cells - Updated by Dipali V on 4th Dec 2025
                      // "Current:" and "Revised:" labels only in first column (Start Date)
                      // All date boxes have same width for proper vertical alignment
                      var hasAnyRevision = (oldStartDate && oldStartDate !== currentStartDate) || 
                                           (oldEndDate && oldEndDate !== currentEndDate) || 
                                           (oldWorkHrs && oldWorkHrs !== currentWorkHrs);
                      
                      if (hasAnyRevision) {
                          // Show two rows - labels only in Start Date column
                          var oldStart = oldStartDate || currentStartDate;
                          var oldEnd = oldEndDate || currentEndDate;
                          var oldWork = oldWorkHrs || currentWorkHrs;
                          
                          startDateCell = '<div class="date-compare-cell">' +
                              '<div class="date-compare-row-with-label"><span class="label-current">Current:</span><span class="' + (oldStartDate && oldStartDate !== currentStartDate ? 'date-old-bg' : 'date-same-bg') + '" data-bs-toggle="tooltip" data-bs-original-title="Current Value">' + oldStart + '</span></div>' +
                              '<div class="date-compare-row-with-label"><span class="label-revised">Revised:</span><span class="' + (oldStartDate && oldStartDate !== currentStartDate ? 'date-new-bg' : 'date-same-bg') + '" data-bs-toggle="tooltip" data-bs-original-title="Revised Value">' + currentStartDate + '</span></div>' +
                              '</div>';
                          
                          endDateCell = '<div class="date-compare-cell">' +
                              '<span class="' + (oldEndDate && oldEndDate !== currentEndDate ? 'date-old-bg' : 'date-same-bg') + '" data-bs-toggle="tooltip" data-bs-original-title="Current Value">' + oldEnd + '</span>' +
                              '<span class="' + (oldEndDate && oldEndDate !== currentEndDate ? 'date-new-bg' : 'date-same-bg') + '" data-bs-toggle="tooltip" data-bs-original-title="Revised Value">' + currentEndDate + '</span>' +
                              '</div>';
                          
                          workHrsCell = '<div class="date-compare-cell">' +
                              '<span class="' + (oldWorkHrs && oldWorkHrs !== currentWorkHrs ? 'date-old-bg' : 'date-same-bg') + '" data-bs-toggle="tooltip" data-bs-original-title="Current Value">' + oldWork + '</span>' +
                              '<span class="' + (oldWorkHrs && oldWorkHrs !== currentWorkHrs ? 'date-new-bg' : 'date-same-bg') + '" data-bs-toggle="tooltip" data-bs-original-title="Revised Value">' + currentWorkHrs + '</span>' +
                              '</div>';
                      } else {
                          // No revision - show single row with "Current:" label only in first column
                          startDateCell = '<div class="date-single-row-with-label"><span class="label-current">Current:</span><span class="date-same-bg" data-bs-toggle="tooltip" data-bs-original-title="Current Value">' + currentStartDate + '</span></div>';
                          endDateCell = '<span class="date-same-bg" data-bs-toggle="tooltip" data-bs-original-title="Current Value">' + currentEndDate + '</span>';
                          workHrsCell = '<span class="date-same-bg" data-bs-toggle="tooltip" data-bs-original-title="Current Value">' + currentWorkHrs + '</span>';
                      }
                      // End of Old/New values modification
                      
                      tr = [
                          '<tr>',
                          '<td class="text-center">', revisionIndicator, '</td>',
                          '<td class="proj-code-cell">',
                          '<div class="proj-code-wrapper">',
                          '<span class="proj-code-text">', truncateFirstColumnText(projectCodeText, 15, 10), '</span>',
                          '<span class="proj-code-icons">',
                          '</span>',
                          '</div>',
                          '</td>',
                          '<td>', truncateWithTooltip(r.projectName || '', 15), '</td>',
                          '<td>', startDateCell, '</td>',
                          '<td>', endDateCell, '</td>',
                          '<td>', workHrsCell, '</td>',
                          //'<td>', (r.requeststage || r.currentStage || ''), '</td>',
                          '<td>', truncateWithTooltip(r.recentApproverComment || r.recentApproverComment || ''), '</td>',
                          '<td class="text-center">', actionButtons, '</td>',
                          '</tr>'
                      ].join('');
                      // End of Modified by Dipali V on 2nd Dec 2025

                      break;
              }
              return tr;
          }

          function formatWithCommas(value) {
              if (value == null || value === '' || isNaN(value)) return '';
              return Number(value).toLocaleString('en-IN');
          }

          // For Plotting Card View
          function generateCard(r, tagId, index) {
              const cardId = getCardId(tagId, index);
              const stageName = (r.requeststage || r.currentStage || '').trim().toUpperCase();
              const hasEditAccess = (EditAccess === true || EditAccess === 'True');

              // --- Build Action Buttons ---
              let actionButtons = '';
              if (hasEditAccess) {
                  if (stageName === 'START') {
                      actionButtons = `
                <button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button"
                    data-bs-placement="top" data-bs-original-title="Send for Approval"
                    onclick="SendForApproval('${r.natureOfDemandID || ''}','${r.projectID || ''}', '${r.workflowInstanceID || ''}', ${tagId}, ${r.requeststageID || 0}, ${r.projectID || 0}, 'S', 'CardView')">
                    <i class="fas fa-paper-plane text-blue"></i>
                </button>`;
                  } else if (stageName !== 'COMPLETE') {
                      // Modified by Dipali V on 5th Dec 2025 - Added stage name parameter for checklist binding
                      var stageNameDisplay = (r.requeststage || r.currentStage || '').replace(/'/g, "\\'");
                      actionButtons = `
                <button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button"
                    data-bs-placement="top" data-bs-original-title="Approve"
                    onclick="ApproveRejectItem('${r.projectID || ''}', '${r.workflowInstanceID || ''}', ${tagId}, ${r.requeststageID || 0}, ${r.projectID || 0}, 'A', 'CardView', '${stageNameDisplay}')">
                    <i class="far fa-thumbs-up text-green"></i>
                </button>
                <button data-bs-toggle="tooltip" class="btn px-1 px-sm-2" type="button"
                    data-bs-placement="top" data-bs-original-title="Reject"
                    onclick="ApproveRejectItem('${r.projectID || ''}', '${r.workflowInstanceID || ''}', ${tagId}, ${r.requeststageID || 0}, ${r.projectID || 0}, 'R', 'CardView', '${stageNameDisplay}')">
                    <i class="far fa-thumbs-down textRed"></i>
                </button>`;
                  }
              }

              // --- Build Card View ---
              return `
             <div class="col-12">
             <div class="WF_Card" id="${cardId}">
                <div class="card shadowBox yelllowBrdr">
                    <div class="card-body pt-2">

                        <!-- Header Row -->
                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-6">
                                <div class="d-flex">
                                    <h5 class="card-title mb-2">${r.projectName || ''}</h5>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6 col-6">
                                <div class="card-item justify-content-sm-end mb-1">
                                    <div class="cardContent">
                                        <span class="CardStageTitle"><%= MyBase.GetResourceString("C_CS") %>:</span>
                                        <span>${r.requeststage || r.currentStage || ''}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Code & Approver Row -->
                        <div class="row">
                            <div class="col-sm-3 col-12">
                                <p class="cardProjCode mb-2 mb-sm-0">${r.projectCode || r.projectID || ''}</p>
                            </div>
                            <div class="col-sm-9 col-12">
                                <div class="card-item justify-content-sm-end mb-1">
                                    <div class="cardContent">
                                        <span class="CardStageTitle"><%= MyBase.GetResourceString("C_Stage_Approver") %>:</span>
                                        <img src="../../../Whizible2.0-new/dist/img/profile-pic.jpg" alt="" class="img-fluid resImg mx-2">
                                        <span>${r.currentApprover || 'N/A'}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Revision Row -->
                        <div class="row mt-1">
                            <div class="col-md-4 col-sm-6">
                                <div class="card-item mb-1">
                                    <div class="cardContent">
                                        <span class="CardValueTitle"><%= MyBase.GetResourceString("C_RevisionDetails") %>:</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Date & Effort Row -->
                        <div class="row mb-2">
                            <div class="col-md-4 col-sm-4">
                                <div class="card-item mb-1">
                                    <div class="cardLeftImg"><i class="far fa-calendar-check iconBlue pe-1"></i></div>
                                    <div class="cardContent">
                                        <span class="CardViewTitle"><%= MyBase.GetResourceString("C_StartDate") %>: </span>
                                        ${r.expectedStartDate ? formatDate(r.expectedStartDate) : 'N/A'}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="card-item mb-1">
                                    <div class="cardLeftImg"><i class="far fa-calendar-check iconBlue pe-1"></i></div>
                                    <div class="cardContent">
                                        <span class="CardViewTitle"><%= MyBase.GetResourceString("C_EndDate") %>: </span>
                                        ${r.expectedEndDate ? formatDate(r.expectedEndDate) : 'N/A'}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="card-item mb-1">
                                    <div class="cardLeftImg"><i class="far fa-clock iconBlue pe-1"></i></div>
                                    <div class="cardContent">
                                        <span class="CardViewTitle"><%= MyBase.GetResourceString("C_EffortsHHMM") %>: </span>
                                        ${formatEffortToHHMM(r.estimatedEfforts || 0)}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Requestor Row -->
                        <div class="row mt-2">
                            <div class="col-md-8 col-sm-8 col-8">
                                <div class="card-item mb-1">
                                    <div class="cardContent">
                                      <%--  <span class="CardValueTitle"><%= MyBase.GetResourceString("C_CurrentValue") %>:</span>--%>
                                        
                                    </div>
                                </div>
                                <div class="card-item mb-1">
                                    <div class="cardContent">
                                        <span class="CardValueTitle"><%= MyBase.GetResourceString("C_Requestor") %>:</span>
                                        <img src="${r.requestorImage || '../../../Whizible2.0-new/dist/img/profile-pic.jpg'}" 
                                             alt="" class="img-fluid resImg mx-2">
                                        <span>${r.requesterName || 'N/A'}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-4 col-4">
                                <div class="card-item mb-1">
                                    <div class="Action_col position-relative">
                                        <div class="mobAppRejButns d-flex text-end">
                                            ${actionButtons}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div> <!-- card-body -->
                </div> <!-- card -->
            </div> <!-- WF_Card -->
        </div>`;
          }


          // For Plotting Card View
          function getCardId(tagId, index) {
              const prefixMap = {
                  CTagID : 'ProjWF_Card'
                
              };
              const prefix = prefixMap[tagId] || 'WF_Card';
              return prefix + index;
          }

          //Get Project Details
          function GetDetails(UniqueID, entityTypeID,ProjectID) {
              //debugger
              CUniqueID = UniqueID;
              GProjectID = ProjectID;
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

          // Helper function to truncate text to 20 characters with tooltip showing full text
          // Added for Project Name, Subproject Name, Module Name, Deliverable Name, Milestone Name, and Sender Comment
          function truncateWithTooltip(text, maxLength = 20) {
              if (!text) return '';
              text = text.toString().trim();
              // Escape HTML for tooltip to prevent XSS
              var escapedText = text.replace(/"/g, '&quot;').replace(/'/g, '&#39;');
              if (text.length > maxLength) {
                  return '<span data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + escapedText + '">' + text.substring(0, maxLength) + '...</span>';
              }
              return text;
          }

          // Apply ellipsis and tooltip to specific columns
          // Modified by Dipali V on 2nd Dec 2025 - Skip cells with entity-code-cell class (they have icons)
          function applyEllipsisWithBootstrapTooltip(selector, maxChars = 20) {
              const elements = document.querySelectorAll(selector);

              elements.forEach(td => {
                  // Skip cells that have entity-code-cell or proj-code-cell class (they contain icons)
                  if (td.classList.contains('entity-code-cell') || td.classList.contains('proj-code-cell')) {
                      return; // Skip this cell, icons are already handled
                  }
                  
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

          // For Bind Project Details 
          function bindEntityDetails(entityTypeID, UniQueID, data) {
              //debugger;
              var fieldMappings = "";
              if (entityTypeID == CTagID) {
                  GProjectID_PK = UniQueID;
                  Data = data.find(item => item.projectID_PK === UniQueID);
                  SelectedProjectData = Data;
                  if (!Data) {
                      console.log('ProjectTimesheet data not found for ID:', GProjectID_PK);
                      return;
                  }
              }

              switch (entityTypeID) {
                  case CTagID:
                      var DivID = 'ProjInfoDetailsTab'
                      bindWBSDetails(entityTypeID, Data, DivID);
                      break
              }


          }

          // For Plot Action Links
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
                 
                  const $actionLinks =  $('#Actionlinks_' + CTagID);
                  if (!$actionLinks.length) return;
                 
                  $actionLinks.empty();
                  $actionLinks.html("");
                  $actionLinks.append("");
                  // Build dynamic links
                  (rows || []).forEach(function (r) {
                      if (r.flagCode === 'AR' || r.flagCode === 'RR') {
                          isChecklistMandatory = r.isChecklistMandatory;
                          // Capture IsByPassResumeTimesheet flag - Added by Dipali V on 5th Dec 2025
                          IsByPassResumeTimesheet = r.isByPassResumeTimesheet === true || r.isByPassResumeTimesheet === 1 || r.isByPassResumeTimesheet === '1';
                      }
                      if (r.flagCode === 'RT') {
                          IsCheckIResumeTimesheet = r.shouldDisplay;
                      }
                      SelectedWF = r.wfid;

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

         //         var closeBtn = `
         //    <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end" data-bs-dismiss="offcanvas">
         //        Close
         //    </button>
         //`

                      ;
                  //$actionLinks.append(closeBtn);

              } catch (e) {
                  console.log("Error rendering action links:", e);
              }
          }


          // For Action Links
          function handleActionLink(flagCode, flagName, StageID, WFID, TagID, ProjectID) {
              console.log('Action clicked:', flagCode, flagName);
              SelectedWF = WFID;
              SelectedStageID = StageID
              // Map TagID to context type
              let contextType = 'P'; // default
              switch (TagID) {
                  case "32": contextType = 'P'; break;   // Project
                 
              }

              // Handle action based on flag code
              switch (flagCode) {
                  case 'AR': // Approve Revision
                      // Modified by Dipali V on 5th Dec 2025 - Pass SelectedStage for checklist binding
                      ApproveRejectItem(CUniqueID, WFID, TagID, StageID, ProjectID, 'A', 'EditView', SelectedStage);
                      break;

                  case 'RR': // Reject Revision
                      // Modified by Dipali V on 5th Dec 2025 - Pass SelectedStage for checklist binding
                      ApproveRejectItem(CUniqueID, WFID, TagID, StageID, ProjectID, 'R', 'EditView', SelectedStage);
                      break;
                  case 'SFA': // Send For Approval
                      SendForApproval(CnatureOfDemandID,CUniqueID, WFID, TagID, StageID, ProjectID, 'S', 'EditView');
                      break;
                  case 'HP': // Put On Hold
                  case 'HT': // Block Timesheet
                  case 'RP': // Resume Project
                  case 'RT': // Resume Timesheet
                  case 'RH': // Revision History
                      ActionOnClick(flagCode, ProjectID, TagID);
                      break;

                  case 'CR': // Checklist Responses - Modified by Dipali V on 4th Dec 2025 - Changed to offcanvas
                      // Modified by Dipali V on 5th Dec 2025 - Fixed offcanvas instance conflict
                      var checklistOffcanvasEl = window.parent.document.getElementById('checklistOffcanvas');
                      var existingChecklistInstance = window.parent.bootstrap.Offcanvas.getInstance(checklistOffcanvasEl);
                      if (existingChecklistInstance) {
                          existingChecklistInstance.dispose();
                      }
                      
                      // Note: We don't close project details offcanvas - they can coexist
                      // Bootstrap offcanvas handles multiple offcanvas instances
                      
                      var checklistOffcanvas = new window.parent.bootstrap.Offcanvas(checklistOffcanvasEl);
                      checklistOffcanvas.show();
                      GetChecklistResponses(WFID, contextType, CUniqueID, 'ActionLinks');
                      window.parent.$("#btnSaveChecklist").off("click").on("click", function () {
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
                  
                  // Modified by Dipali V on [Date] - Check if all questions have saved responses
                  // Hide Save button if data is already saved, show if not saved
                  const $saveBtn = window.parent.$("#btnSaveChecklist");
                  
                  // Group by question ID to check if each question has saved responses
                  const questionGroups = {};
                  strResult.details.forEach(item => {
                      if (!questionGroups[item.QuestionnaireQuestionID]) {
                          questionGroups[item.QuestionnaireQuestionID] = [];
                      }
                      questionGroups[item.QuestionnaireQuestionID].push(item);
                  });
                  
                  // Check if all questions have saved responses
                  // A question has saved responses if the Responses field contains values
                  let allQuestionsAnswered = true;
                  for (let questionID in questionGroups) {
                      const questionData = questionGroups[questionID];
                      const firstRow = questionData[0];
                      const hasSavedResponses = firstRow.Responses && 
                                                 firstRow.Responses.trim() !== '' && 
                                                 firstRow.Responses.split(",").filter(x => x && x.trim() !== '').length > 0;
                      
                      if (!hasSavedResponses) {
                          allQuestionsAnswered = false;
                          break; // Exit early if any question is not answered
                      }
                  }
                  
                  // Hide Save button if all questions are already answered (data is saved)
                  // Show Save button if any question is not answered (data not saved)
                  if (allQuestionsAnswered && Object.keys(questionGroups).length > 0) {
                      $saveBtn.prop("disabled", true).hide();
                  } else {
                      $saveBtn.prop("disabled", false).show();
                  }
              } else {
                  if (FromWhere != "TabDetails") {
                      window.parent.$(".modalLbl").text("CheckList :NA");
                      window.parent.$(".modalLblstage").text("Stage :" + SelectedStage);
                      window.parent.$("#btnSaveChecklist").hide();
                      window.parent.$("#checklstRespMdlTbl tbody").html("<tr><td colspan='4'  style='text-align:center!important'><%= MyBase.GetResourceString("C_NOChecklist") %>.</td></tr>");
                  } else {
                      window.parent.$("#checklistRespTab tbody").html("<tr><td colspan='4'  style='text-align:center!important'><%= MyBase.GetResourceString("C_NOChecklist") %>.</td></tr>");
                  }
              }

          }
          //For Get Checklist Response Plotting - Modified by Dipali V on 4th Dec 2025 - Changed to offcanvas
          function RenderChecklistTable(data, FromWhere) {
              var tbody = "";
              if (FromWhere != "TabDetails") {
                  var checklistOffcanvas = new window.parent.bootstrap.Offcanvas(window.parent.document.getElementById('checklistOffcanvas'));
                  checklistOffcanvas.show();
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
                      // Updated by Dipali V on 18th Dec 2025 - Added MultipleSelection support for checkboxes
                      // DropdownSelection=1: Render as dropdown
                      // MultipleSelection=1: Render as checkboxes (allow multiple selection)
                      // SingleSelection=1: Render as radio buttons (single selection)
                      let optionHtml = '';
                      const isDropdown = firstRow.DropdownSelection === 1 || firstRow.DropdownSelection === true;
                      const isMultipleSelection = firstRow.MultipleSelection === 1 || firstRow.MultipleSelection === true;
                      
                      if (isDropdown) {
                          // Render as dropdown - Modified by Dipali V on 10th Dec 2025
                          const selectId = `select_${firstRow.QuestionnaireQuestionID}`;
                          const selectedValue = selectedResponses.length > 0 ? selectedResponses[0] : '';
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
                      } else if (isMultipleSelection) {
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
              // Get all unique question IDs that have checkboxes
              const allCheckboxQuestions = window.parent.$(".question-option[type='checkbox']");
              const checkboxQuestionIDs = new Set();
              allCheckboxQuestions.each(function () {
                  checkboxQuestionIDs.add($(this).data("question-id"));
              });
              
              // Process each checkbox question (can have multiple selections)
              checkboxQuestionIDs.forEach(questionID => {
                  if (processedQuestions.has(questionID)) return; // Skip if already processed
                  
                  const selectedCheckboxes = window.parent.$(`.question-option[type='checkbox'][data-question-id='${questionID}']:checked`);
                  const comment = window.parent.$(`.checklist-comment[data-question-id='${questionID}']`).val()?.trim() || "";

                  // Validation: check if at least one checkbox selected and comment provided
                  if (selectedCheckboxes.length === 0 || comment === "") {
                      isValid = false;
                      return;
                  }

                  // Push entry for each selected checkbox (multiple selections allowed)
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

              // Process radio button questions (SingleSelection=1) - existing behavior
              const allRadioQuestions = window.parent.$(".question-option[type='radio']");
              allRadioQuestions.each(function () {
                  const questionID = $(this).data("question-id");
                  if (processedQuestions.has(questionID)) return; // Skip if already processed
                  
                  const selectedOption = window.parent.$(`.question-option[type='radio'][data-question-id='${questionID}']:checked`);
                  const comment = window.parent.$(`.checklist-comment[data-question-id='${questionID}']`).val()?.trim() || "";

                  // Validation: check if both option selected and comment provided
                  if (selectedOption.length === 0 || comment === "") {
                      isValid = false;
                      return false; // break loop
                  }

                  // Push entry if valid
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

              // Process dropdown questions - Added by Dipali V on 10th Dec 2025
              const allDropdownQuestions = window.parent.$(".question-option-dropdown");
              allDropdownQuestions.each(function () {
                  const questionID = $(this).data("question-id");
                  if (processedQuestions.has(questionID)) return; // Skip if already processed
                  
                  const selectedValue = $(this).val();
                  const uniqueID = $(this).data("unique-id");
                  const comment = window.parent.$(`.checklist-comment[data-question-id='${questionID}']`).val()?.trim() || "";

                  // Validation: check if both option selected and comment provided
                  if (!selectedValue || comment === "") {
                      isValid = false;
                      return false; // break loop
                  }

                  // Push entry if valid
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
                  
                  // Updated by Dipali V on 24th Dec 2025 - Purpose: Show approval comment section after checklist save if opened for approval
                  // Check if checklist was opened for approval
                  if (window.isChecklistForApproval === true) {
                      // Hide Save button temporarily
                      const $saveBtn = window.parent.$("#btnSaveChecklist");
                      $saveBtn.prop("disabled", false);
                      
                      // Show approval comment section
                      window.parent.$("#approvalCommentSection").slideDown(300);
                      window.parent.$("#txtApprovalComment").focus();
                      
                      // Update Save button text and handler to handle approval
                      $saveBtn.html('<i class="fas fa-check me-1"></i>' + (window.pendingApprovalBtn || 'Approve'));
                      $saveBtn.off("click").on("click", function () {
                          handleChecklistApproval();
                      });
                      
                      // Scroll to approval section
                      setTimeout(function() {
                          window.parent.$("#approvalCommentSection")[0].scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                      }, 350);
                  } else {
                      // Normal checklist save (not for approval) - hide Save button and close offcanvas
                      const $saveBtn = window.parent.$("#btnSaveChecklist");
                      $saveBtn.prop("disabled", true).hide();
                      
                      // Modified by Dipali V on 4th Dec 2025 - Changed to offcanvas
                      // Updated by Dipali V on 18th Dec 2025 - Ensure backdrop is removed when closing
                      var checklistOffcanvas = window.parent.bootstrap.Offcanvas.getInstance(window.parent.document.getElementById('checklistOffcanvas'));
                      if (checklistOffcanvas) {
                          checklistOffcanvas.hide();
                          // Remove backdrop after hiding
                          setTimeout(function() {
                              if (window.parent.removeOffcanvasBackdrop) {
                                  window.parent.removeOffcanvasBackdrop();
                              }
                          }, 300);
                      }
                  }
              } else {
                  window.parent.alertify.error("Error saving checklist responses.");
              }
          }
          
          // Updated by Dipali V on 24th Dec 2025 - Purpose: Handle approval after checklist is saved and approval comment is entered
          function handleChecklistApproval() {
              // Get approval comment
              var approvalComment = window.parent.$("#txtApprovalComment").val().trim();
              
              // Validate approval comment is mandatory
              if (!approvalComment) {
                  //window.parent.$("#approvalCommentError").show();
                  window.parent.$("#txtApprovalComment").focus();
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                  }
                  return;
              }
              
              // Hide error message
              //window.parent.$("#approvalCommentError").hide();
              
              // Set the comment in the approval modal field (for ApproveRejectClick to use)
              window.parent.$("#txtWFARComments").val(approvalComment);
              
              // Reset approval flags
              window.isChecklistForApproval = false;
              
              // Close checklist offcanvas
              var checklistOffcanvas = window.parent.bootstrap.Offcanvas.getInstance(window.parent.document.getElementById('checklistOffcanvas'));
              if (checklistOffcanvas) {
                  checklistOffcanvas.hide();
                  setTimeout(function() {
                      if (window.parent.removeOffcanvasBackdrop) {
                          window.parent.removeOffcanvasBackdrop();
                      }
                  }, 300);
              }
              
              // Call approval function directly
              setTimeout(function() {
                  ApproveRejectClick();
              }, 400); // Small delay to allow offcanvas to close
          }

          //For Get Project Type
          function GetProjectType(ProjectPractice) {
              //debugger;
              var projectParameters =
              {
                  ProjectPractice: ProjectPractice
              };
              // NEW FROMBODY APPROACH - Following ApproveRejectPT pattern
              var fullUrl = "api/EntityApproval/GetProjectType";
              var payload = JSON.stringify(projectParameters);
              var StrResult = AJAXCallWithResult(fullUrl, payload, false, "POST");
              StrResult = StrResult[0].projectType;
              console.log('Get Project Type: ' + JSON.stringify(StrResult));
              return StrResult;
          }

          //For Approve Project /Reject Action
          // Modified by Dipali V on 5th Dec 2025 - Added IsByPassResumeTimesheet logic
          // Modified by Dipali V on 5th Dec 2025 - Checklist alert replaced with offcanvas for all cases
          // Modified by Dipali V on 5th Dec 2025 - Added StageName parameter for list view
          function ApproveRejectItem(UniqueID, workflowId, tagId, StageID, ProjectID, Action, FromWhere, StageName) {
              //ebugger;
              GFromWhere = FromWhere;
              SelectedWF = workflowId;
              CTagID = parseInt(tagId);
              GProjectID = ProjectID;
              CUniqueID = UniqueID;
              SelectedStageID = StageID;
              WhichActionWF = Action;
              // Set SelectedStage for checklist stage name binding
              if (StageName) {
                  SelectedStage = StageName;
              }
              GetActionLinks(CTagID, GProjectID, CUniqueID);
              var Caption = "";
              var btn = "";
              
              if (tagId == 32) {
                  // Set caption and button text based on action
                  if (Action == 'A') {
                      Caption = '<%= MyBase.GetResourceString("C_ApproveRevision") %>';
                      btn = 'Approve';
                  } else {
                      Caption = '<%= MyBase.GetResourceString("C_RejectRevision") %>';
                      btn = 'Reject';
                  }
                  
                  // Always suppress alert - instead open checklist offcanvas if needed
                  CheckWFChecklistMadatory(GProjectID, true); // suppressAlert = true
                  
                  // IsChecklistMandatory == "0" means checklist is mandatory but NOT filled - need to fill it first
                  // IsChecklistMandatory == "1" means checklist is filled OR not mandatory - can proceed
                  if (IsChecklistMandatory == "0") {
                      // Checklist is mandatory but NOT filled - open checklist offcanvas first
                      // After checklist saved, approval modal will open
                      openChecklistForApproval(Caption, btn, Action);
                  } else {
                      // Checklist already filled OR not mandatory
                      // Check if IsByPassResumeTimesheet flag is set
                      if (IsByPassResumeTimesheet === true) {
                          // Bypass resume timesheet alert - show approval modal directly
                          showApprovalModal(Caption, btn);
                      } else {
                          // Check IsCheckIResumeTimesheet for resume timesheet alert
                          if (IsCheckIResumeTimesheet == false) {
                              // No resume timesheet alert needed
                              showApprovalModal(Caption, btn);
                          } else {
                              // Show resume timesheet confirmation first
                              showResumeTimesheetConfirmation(Caption, btn);
                          }
                      }
                  }
              }
          }
          
          // Helper function to show approval modal - Added by Dipali V on 5th Dec 2025
          function showApprovalModal(Caption, btn) {
              window.parent.$("#approveRevModal").modal('show');
              window.parent.$("#ApproveRejectLabel").text(Caption);
              window.parent.$("#lblAppRejectCaption").text(Caption);
              window.parent.$("#txtWFARComments").val('');
              window.parent.$("#ActionLinkCaption").text(btn);
              const modal = window.parent.$("#approveRevModal");
              modal.find("#ActionLinkCaption").off("click").on("click", function () {
                  ApproveRejectClick();
              });
          }
          
          // Helper function to show resume timesheet confirmation - Added by Dipali V on 5th Dec 2025
          function showResumeTimesheetConfirmation(Caption, btn) {
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
          }
          
          // Updated by Dipali V on 24th Dec 2025 - Purpose: Open checklist offcanvas for approval, show approval comment section after save
          // Modified by Dipali V on 5th Dec 2025 - Fixed offcanvas instance conflict
          function openChecklistForApproval(Caption, btn, Action) {
              // Store approval details for later use after checklist save
              window.pendingApprovalCaption = Caption;
              window.pendingApprovalBtn = btn;
              window.pendingApprovalAction = Action;
              window.isChecklistForApproval = true;
              
              // Hide approval comment section initially - Added by Dipali V on 24th Dec 2025
              window.parent.$("#approvalCommentSection").hide();
              window.parent.$("#txtApprovalComment").val('');
              //window.parent.$("#approvalCommentError").hide();
              
              // Open checklist offcanvas
              var offcanvasEl = window.parent.document.getElementById('checklistOffcanvas');
              if (offcanvasEl) {
                  // Dispose existing instance first to avoid conflicts
                  var existingInstance = window.parent.bootstrap.Offcanvas.getInstance(offcanvasEl);
                  if (existingInstance) {
                      existingInstance.dispose();
                  }
                  var offcanvasInstance = new window.parent.bootstrap.Offcanvas(offcanvasEl);
                  offcanvasInstance.show();
                  
                  // Load checklist data - parameters: WFID, contextType, ProjectID, FromWhere
                  GetChecklistResponses(SelectedWF, 'P', CUniqueID, 'ActionLinks');
                  
                  // Bind save button to SaveChecklistResponses - Updated by Dipali V on 24th Dec 2025
                  window.parent.$("#btnSaveChecklist").off("click").on("click", function () {
                      SaveChecklistResponses('P');
                  });
                  
                  // Reset Save button text to "Save" initially
                  window.parent.$("#btnSaveChecklist").html('<i class="fas fa-save me-1"></i><%= MyBase.GetResourceString("C_Save") %>');
              } else {
                  // Fallback - if offcanvas not found, show approval modal directly
                  showApprovalModal(Caption, btn);
              }
          }
          
          // Removed by Dipali V on 24th Dec 2025 - No longer needed as approval comment is now in checklist offcanvas
          // Function onChecklistSavedForApproval() has been replaced by handleChecklistApproval()

          //For Send For Approval Action
          var selectedWorkflow = 0;
          function SendForApproval(natureOfDemandID, UniqueID, workflowId, tagId, StageID, ProjectID, Action, FromWhere) {
             // debugger;
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

              // Match API response structure: message + workflowDetails
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
              UniqueID = GProjectID;
              var payload = {
                  UserID: ctx.EmployeeID,
                  ProjectID: GProjectID,
                  UniqueID: UniqueID,
                  Comments: comments,
                  TagID: CTagID,
                  strAction: strAction,
                   WF: window.parent.$("#cboWF").val()
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
                          // Close project details offcanvas - it's rendered dynamically in OffcanvasContainer
                          // Modified by Dipali V on [Date] - Fixed offcanvas closing after approval
                          if (window.parent && typeof window.parent.closeProjectDetailsOffcanvas === 'function') {
                              window.parent.closeProjectDetailsOffcanvas();
                          } else {
                              // Fallback: try to find and close offcanvas directly
                              var container = window.parent.document.getElementById('OffcanvasContainer');
                              if (container) {
                                  var offcanvasEl = container.querySelector('.offcanvas');
                                  if (offcanvasEl) {
                                      var offcanvasInstance = window.parent.bootstrap.Offcanvas.getInstance(offcanvasEl);
                                      if (offcanvasInstance) {
                                          offcanvasInstance.hide();
                                      } else {
                                          try {
                                              var instance = window.parent.bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
                                              if (instance) {
                                                  instance.hide();
                                              }
                                          } catch (ex) {
                                              console.log('Error closing offcanvas:', ex);
                                          }
                                      }
                                  }
                              }
                          }
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

          //For Get All comment For hold Timesheet,Resume timesheet,Resume project,block timesheet
          function GetAllComments(ProjectID, TagID) {
              var ResourceParameters = {
                  ProjectID: ProjectID,
                  TagID: TagID,
              }
              // NEW FROMBODY APPROACH - Following ApproveRejectPT pattern
              var fullUrl = "api/EntityApproval/GetComments";
              var payload = JSON.stringify(ResourceParameters);
              var strResult = AJAXCallWithResult(fullUrl, payload, false, "POST");
              console.log('Get Comments: ' + JSON.stringify(strResult));


              if (strResult != "") {
                  if (strResult != undefined) {
                      if (strResult != "") {
                          for (i = 0; i <= strResult.length - 1; i++) {
                              ProjectOnHoldComments = strResult[i].projectOnHoldComments;
                              BlockTimeSheetComments = strResult[i].blockTimeSheetComments;

                          }
                      }

                  }
              }
          }


          //For Save hold Timesheet,Resume timesheet,Resume project,block timesheet
          function SaveComments() {
             // debugger;
              var comment = window.parent.$("#txtComments").val();         //Added By Rehan C
              if (!comment) {
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                  } else {
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>', 'error', 25);
                  }

                  window.parent.$("#txtComments").focus();
                  return false;
              }
              if (checkSpecialCharacter(comment, WebConfigSpecialCharacters)) {
                  if (window.parent && window.parent.alertify) {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.error('<%= MyBase.GetResourceString("C_CommentSpecial") %> : ' + WebConfigSpecialCharacters);
                  } else {
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.error('<%= MyBase.GetResourceString("C_CommentSpecial") %> : ' + WebConfigSpecialCharacters);
                  }

                  window.parent.$("#txtComments").focus();
                  return false;
              }

              const ctx = getContext();
              var ResourceParameters = {
                  ProjectID: GProjectID,
                  Remarks: window.parent.$("#txtComments").val().toString().replace(/'/g, "''"),
                  TagID: CTagID,
                  ActiveType: GWhichAction,
                  UserName: ctx.UserName
              }

             
              // NEW FROMBODY APPROACH - Following ApproveRejectPT pattern
              var fullUrl = "api/EntityApproval/PostTakeActionHPHTBT";
              var payload = JSON.stringify(ResourceParameters);
              var strResult = AJAXCallWithResult(fullUrl, payload, false, "POST");
              console.log('Saved Comments: ' + JSON.stringify(strResult));

              //var param = JSON.stringify(Parameters);
              //var strResult = AJAXCallWithResult(encodeURI(API_BASE) + "/api/PM_EntityApproval/TakeActionHPHTBT", param, false, "POST");
              if (strResult.result != "") {
                  //debugger;
                  if (strResult.result == "1") {
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify("Action taken Successfully.", 'success', 25);
                      window.parent.$("#putOnHoldModal").modal('hide');
                      CheckIsBlockTimesheet = false;
                      //GetActionLinks(CTagID, GProjectID, CUniqueID)
                      GetDetails(CUniqueID, CTagID, GProjectID)
                      //var offcanvasEl = window.parent.document.getElementById('showProjInfo_offcanvas');
                      //window.parent.bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).hide();
                  }

              }

          }
          //According to action values should get display
          function ActionOnClick(WhichAction, ProjectID, TagID) {

              GWhichAction = WhichAction;
              GetAllComments(ProjectID, TagID);
              window.parent.$("#putOnHoldModal").modal('show');
              window.parent.$("#hdnflag").val(WhichAction);
              if (WhichAction == 'HP') {
                  window.parent.$("#ProjectTimesheetCaption").text('Put On Hold');
              }
              if (WhichAction == 'HT') {
                  window.parent.$("#ProjectTimesheetCaption").text('Block Timesheet');
              }
              if (WhichAction == 'RP') {
                  window.parent.$("#ProjectTimesheetCaption").text('Resume Project');
              }
              if (WhichAction == 'RT') {
                  window.parent.$("#ProjectTimesheetCaption").text('Resume Timesheet');
              }
              window.parent.$("#txtComments").val('');
              if (WhichAction == 'HP' || WhichAction == 'RP') { //ON HOLD ,RESUME PROJECT
                  window.parent.$("#txtComments").val(ProjectOnHoldComments);
              }
              else if (WhichAction == 'RT' || WhichAction == 'HT') { //BLOACK TIMESHEET ,RESUME TIMESHEET
                  window.parent.$("#txtComments").val(BlockTimeSheetComments);
              }

              const modal = window.parent.$("#putOnHoldModal");
              modal.find("#btnComments").off("click").on("click", function () {
                  SaveComments();
              });
          }
          //Close Window
          function CloseAppReject() {
              window.parent.$("#approveRevModal").modal('hide');

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

          //For Taken Action like Approve and Reject 
          function ApproveRejectClick() {
              //debugger;
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

              const ctx = getContext();
             
              UniqueID = GProjectID;

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
                          // Close project details offcanvas - it's rendered dynamically in OffcanvasContainer
                          // Modified by Dipali V on [Date] - Fixed offcanvas closing after approval
                          if (window.parent && typeof window.parent.closeProjectDetailsOffcanvas === 'function') {
                              window.parent.closeProjectDetailsOffcanvas();
                          } else {
                              // Fallback: try to find and close offcanvas directly
                              var container = window.parent.document.getElementById('OffcanvasContainer');
                              if (container) {
                                  var offcanvasEl = container.querySelector('.offcanvas');
                                  if (offcanvasEl) {
                                      var offcanvasInstance = window.parent.bootstrap.Offcanvas.getInstance(offcanvasEl);
                                      if (offcanvasInstance) {
                                          offcanvasInstance.hide();
                                      } else {
                                          try {
                                              var instance = window.parent.bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
                                              if (instance) {
                                                  instance.hide();
                                              }
                                          } catch (ex) {
                                              console.log('Error closing offcanvas:', ex);
                                          }
                                      }
                                  }
                              }
                          }
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


          //For Bind Details
          function bindWBSDetails(entityTypeID, projectData, DivID) {
              //debugger;
              var fieldMappings = "";
              if (entityTypeID === CTagID) {
                  fieldMappings = {
                      'Project Code:': projectData.projectCode || 'N/A',
                      'Abbreviated Name:': projectData.shortJobTitle || 'N/A',
                      'Project Name:': projectData.projectName || 'N/A',
                      'Description:': projectData.description || 'N/A',
                      'Project Group:': projectData.projectGroupName || 'N/A',
                      'Billable:': projectData.billable ? 'Yes' : 'No',
                      'Start Date:': formatDate(projectData.expectedStartDate) || 'N/A',
                      'End Date:': formatDate(projectData.expectedEndDate) || 'N/A',
                      'Commercial Details:': projectData.contractTypeName || 'N/A',
                      'Work (HH:MM):': formatEffortToHHMM(projectData.estimatedEfforts) || 'N/A',
                      'Duration (days):': projectData.duration || 'N/A',
                      // Modified by Dipali V on 1st Dec 2025 - Purpose: Display Project Value with Currency Code
                      'Project Value:': (formatCurrency(projectData.contractValue) || 'N/A') +  ' (' + (projectData.currencyCode ? projectData.currencyCode + ' ' : '') + ')',
                      //'Project Currency:': projectData.currencyCode || 'N/A',
                      'Business Group:': projectData.businessGroup || 'N/A',
                      'Organization Unit:': projectData.organizationUnit || 'N/A',
                      'Delivery Unit:': projectData.duUnit  || 'N/A',
                      'Delivery Team:': projectData.dt || 'N/A',
                      'Practice:': projectData.projectType || 'N/A',
                      'Project Type:': GetProjectType(projectData.projectType) || 'N/A',
                      'Customer:': projectData.customerName || 'N/A',
                      'Project Size:': projectData.projectSize?.toString() || 'N/A',
                      'Project Sponsor:': projectData.fundingOrganizationName || 'N/A',
                      'Life Cycle:': projectData.projectLifeCycle || 'N/A',
                      'Project Size Unit:': projectData.projectSizeDisplay || 'N/A',
                      'Proposal Reference:': projectData.proposalNo || 'N/A',
                      'Project Status:': projectData.projectStatus || 'N/A',
                      'No. of Resources:': (projectData.no_Of_Resource?.toString() || 'N/A') + ' FTE '
                  };

              }

              bindDataToHTML(fieldMappings, DivID);
              
              // Added by Dipali V on 24th Dec 2025 - Get revision changes and highlight changed fields
              // Call immediately after data binding
              if (projectData.projectID_PK && projectData.projectID_PK > 0) {
                  console.log("bindWBSDetails: Calling getProjectRevisionChanges for projectID_PK:", projectData.projectID_PK, "DivID:", DivID);
                  // Call with a delay to ensure DOM is updated and offcanvas is rendered in parent
                  setTimeout(function() {
                      if (typeof getProjectRevisionChanges === 'function') {
                          getProjectRevisionChanges(projectData.projectID_PK, DivID);
                      } else if (typeof window.getProjectRevisionChanges === 'function') {
                          window.getProjectRevisionChanges(projectData.projectID_PK, DivID);
                      } else {
                          console.warn("getProjectRevisionChanges function not available");
                      }
                  }, 500);
              }
              
              GetCurrentWFStatus(projectData.currentWFStatus, projectData.requeststage);
              GetActionLinks(entityTypeID, projectData.projectID, projectData.projectID_PK);
              GProjectName = projectData.projectName
              GProjectID = projectData.projectID_PK;
              SelectedStageID = projectData.requeststageID;
              SelectedWF = projectData.workflowInstanceID;
              SelectedStage = projectData.requeststage;;
              SelectedProjectData = projectData;
              CUniqueID = projectData.projectID_PK
              // === Send offcanvas HTML to parent for rendering ===
              const offcanvasEl = document.getElementById('showProjInfo_offcanvas');
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
                  projectID: projectData.projectID || null,
                  projectID_PK: projectData.projectID_PK || null
              }, "*");


          }


          //For Get WorkFlow Details
          // Updated by Dipali V on 24th Dec 2025 - Purpose: Changed from modal to offcanvas for Show Details functionality
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
             

              SelectedProjectData = StrResult.find(item =>
                  parseInt(item.projectId) === parseInt(CUniqueID) ||
                  parseInt(item.projectID_PK) === parseInt(CUniqueID)
              );
              

             var fieldMappings = "";
             
              fieldMappings = {
                  'Project Name:': SelectedProjectData.projectName || 'N/A',
                              'Expected Start Date:': formatDate(SelectedProjectData.expectedStartDate) || 'N/A',
                              'Expected End Date:': formatDate(SelectedProjectData.expectedEndDate) || 'N/A',
                              'Business Group:': SelectedProjectData.businessGroup || 'N/A',
                              'Practice:': SelectedProjectData.projectType || 'N/A',

              };
              
              SelectedWF = SelectedProjectData.workflowInstanceID;
              SelectedStageID = SelectedProjectData.requeststageID;
              populateDetailsSection('WF_DetlsDeskModal', fieldMappings)
              GetApprovalStages();
              GetWFHistoryDetails();

              // Updated by Dipali V on 24th Dec 2025 - Changed from modal to offcanvas
              // Use parent's bootstrap context to ensure instance is accessible from parent
              var offcanvasEl = window.parent.document.getElementById('projShowStatusOffcanvas');
              if (offcanvasEl) {
                  // Dispose existing instance if any to avoid conflicts
                  var existingInstance = window.parent.bootstrap.Offcanvas.getInstance(offcanvasEl);
                  if (existingInstance) {
                      existingInstance.dispose();
                  }
                  // Create new instance using parent's bootstrap context
                  var offcanvasInstance = new window.parent.bootstrap.Offcanvas(offcanvasEl);
                  offcanvasInstance.show();
              }
              
          }

          //For Plotting WF Details
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

          // Helper function to format field names as labels
          function formatLabel(fieldName) {
              // Convert camelCase to Title Case with spaces
              return fieldName
                  .replace(/([A-Z])/g, ' $1')
                  .replace(/^./, function (str) { return str.toUpperCase(); })
                  .trim();
          }

          //For Get Workflow stages
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

          //For Get Workflow History
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
              var total = _wfHistoryData.length;
              var totalPages = Math.ceil(total / _wfHistItemsPerPage) || 1;

              var pd = (window.parent && window.parent.document) ? window.parent.document : document;

              var totalEl = pd.getElementById('wfHistTotalRecords');
              if (totalEl) totalEl.textContent = total;

              var prevLi = pd.getElementById('wfHistBtnPrev');
              var prevA = pd.getElementById('wfHistLinkPrev');
              var nextLi = pd.getElementById('wfHistBtnNext');
              var nextA = pd.getElementById('wfHistLinkNext');

              var disabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#6c757d;background-color:#f8f9fa;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:none;cursor:not-allowed;transition:all 0.3s ease;';
              var enabledAStyle = 'display:inline-flex;align-items:center;justify-content:center;padding:6px 10px;color:#1359a6;background-color:#fff;border:1px solid #dee2e6;border-radius:4px;text-decoration:none;pointer-events:auto;cursor:pointer;transition:all 0.3s ease;';

              // Previous button
              if (_wfHistPage <= 1 || total === 0) {
                  if (prevLi) prevLi.style.cursor = 'not-allowed';
                  if (prevA) { prevA.setAttribute('style', disabledAStyle); prevA.removeAttribute('onclick'); }
              } else {
                  if (prevLi) prevLi.style.cursor = 'pointer';
                  if (prevA) { prevA.setAttribute('style', enabledAStyle); prevA.setAttribute('onclick', 'window.frames[0]._wfHistGoToPrev()'); }
              }

              // Next button
              if (_wfHistPage >= totalPages || total === 0) {
                  if (nextLi) nextLi.style.cursor = 'not-allowed';
                  if (nextA) { nextA.setAttribute('style', disabledAStyle); nextA.removeAttribute('onclick'); }
              } else {
                  if (nextLi) nextLi.style.cursor = 'pointer';
                  if (nextA) { nextA.setAttribute('style', enabledAStyle); nextA.setAttribute('onclick', 'window.frames[0]._wfHistGoToNext()'); }
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

          //For Get FormateDate
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


          //For Get Checklist is Madatory or not
          // Modified by Dipali V on 5th Dec 2025 - Added suppressAlert parameter for IsByPassResumeTimesheet flow
          function CheckWFChecklistMadatory(ProjectID, suppressAlert) {
              const ctx = getContext();
              var ResourceParameters = {
                  ProjectID: ProjectID,
                  UserName: ctx.UserName
              }

              var fullUrl = "api/EntityApproval/CheckWFChecklistMadatory";
              var payload = JSON.stringify(ResourceParameters);
              var data = AJAXCallWithResult(fullUrl, payload, false, "POST");
              console.log('CheckWF Checklist Madatory: ' + JSON.stringify(data));
              if (data != "") {
                  //debugger;
                  IsChecklistMandatory = data.isMandatorychecklist;
                  // IsChecklistMandatory == "0" means checklist is mandatory but NOT filled
                  // IsChecklistMandatory == "1" means checklist is filled OR not mandatory
                  if (IsChecklistMandatory == "0" && suppressAlert !== true) {
                      // Only show alert if not suppressed (for IsByPassResumeTimesheet flow, we suppress alert)
                      window.parent.alertify.set('notifier', 'position', 'top-right');
                      window.parent.alertify.notify("<%= MyBase.GetResourceString("C_ChecklistMad") %>", 'error', 25);
                      return false;
                  }
                  //alert(IsChecklistMandatory);
              }
              return true;
          }

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

          // Added by Dipali V on 24th Dec 2025 - Purpose: Get project revision changes and highlight changed fields
          // Expose function globally so parent window can call it
           window.getProjectRevisionChanges = function(projectID, divID) {
              console.log("getProjectRevisionChanges called with projectID:", projectID, "divID:", divID);
              
              if (!projectID || projectID <= 0) {
                  console.warn("Invalid projectID:", projectID);
                  return;
              }
              
              const fullUrl = "api/EntityApproval/GetProjectRevisionChanges";
              const payload = JSON.stringify({ ProjectID: projectID });
              
              console.log("Calling API:", fullUrl, "with payload:", payload);
              
              try {
                  const result = AJAXCallWithResult(fullUrl, payload, false, "POST");
                  console.log("Project Revision Changes API Response:", result);
                  
                  let changedFields = null;
                  
                  // Handle different response structures
                  if (result) {
                      // Check for nested data structure: result.data.RevisionChanges or result.data.revisionChanges
                      if (result.data) {
                          changedFields = result.data.RevisionChanges || result.data.revisionChanges;
                      }
                      // Check for direct structure: result.RevisionChanges or result.revisionChanges
                      if (!changedFields) {
                          changedFields = result.RevisionChanges || result.revisionChanges;
                      }
                      // Check if result itself is the array
                      if (!changedFields && Array.isArray(result)) {
                          changedFields = result;
                      }
                  }
                  
                  if (changedFields && changedFields.length > 0) {
                      console.log("Found changed fields:", changedFields.length);
                      // Add a small delay to ensure DOM is ready
                      setTimeout(function() {
                          highlightChangedFields(divID, changedFields);
                      }, 100);
                  } else {
                      console.log("No changed fields found or empty response");
                  }
              } catch (error) {
                  console.error("Error fetching project revision changes:", error);
              }
          };
          
          // Also create a regular function for backward compatibility
          function getProjectRevisionChanges(projectID, divID) {
              return window.getProjectRevisionChanges(projectID, divID);
          }
          
          // Added by Dipali V on 24th Dec 2025 - Purpose: Highlight changed fields with orange color
          function highlightChangedFields(containerID, changedFields) {
              if (!changedFields || changedFields.length === 0) {
                  console.log("No changed fields to highlight");
                  return;
              }
              
              // Always check parent window first since offcanvas is rendered there
              let container = null;
              if (window.parent && window.parent.document) {
                  container = window.parent.document.getElementById(containerID);
                  if (container) {
                      console.log("Found container in parent window:", containerID);
                      highlightFieldsInContainer(container, changedFields);
                      return;
                  }
              }
              
              // Fallback to current window
              container = document.getElementById(containerID);
              if (container) {
                  console.log("Found container in current window:", containerID);
                  highlightFieldsInContainer(container, changedFields);
              } else {
                  console.warn("Container not found in parent or current window:", containerID);
              }
          }
          
          // Helper function to highlight fields in a container
          function highlightFieldsInContainer(container, changedFields) {
              // Map API field names to UI label names (handle both camelCase and PascalCase)
              const fieldNameMap = {
                  'ProjectCode': 'Project Code:',
                  'projectCode': 'Project Code:',
                  'ShortJobTitle': 'Abbreviated Name:',
                  'shortJobTitle': 'Abbreviated Name:',
                  'ProjectName': 'Project Name:',
                  'projectName': 'Project Name:',
                  'Description': 'Description:',
                  'description': 'Description:',
                  'ProjectGroupName': 'Project Group:',
                  'projectGroupName': 'Project Group:',
                  'Billable': 'Billable:',
                  'billable': 'Billable:',
                  'ExpectedStartDate': 'Start Date:',
                  'expectedStartDate': 'Start Date:',
                  'ExpectedEndDate': 'End Date:',
                  'expectedEndDate': 'End Date:',
                  'ContractTypeName': 'Commercial Details:',
                  'contractTypeName': 'Commercial Details:',
                  'EstimatedEfforts': 'Work (HH:MM):',
                  'estimatedEfforts': 'Work (HH:MM):',
                  'Duration': 'Duration (days):',
                  'duration': 'Duration (days):',
                  'ContractValue': 'Project Value:',
                  'contractValue': 'Project Value:',
                  'BusinessGroup': 'Business Group:',
                  'businessGroup': 'Business Group:',
                  'OrganizationUnit': 'Organization Unit:',
                  'organizationUnit': 'Organization Unit:',
                  'ResourcePoolName': 'Delivery Unit:',
                  'resourcePoolName': 'Delivery Unit:',
                  'DUUnit': 'Delivery Team:',
                  'duUnit': 'Delivery Team:',
                  'ProjectType': 'Practice:',
                  'projectType': 'Practice:',
                  'CustomerName': 'Customer:',
                  'customerName': 'Customer:',
                  'ProjectSize': 'Project Size:',
                  'projectSize': 'Project Size:',
                  'FundingOrganizationName': 'Project Sponsor:',
                  'fundingOrganizationName': 'Project Sponsor:',
                  'ProjectLifeCycle': 'Life Cycle:',
                  'projectLifeCycle': 'Life Cycle:',
                  'ProjectSizeDisplay': 'Project Size Unit:',
                  'projectSizeDisplay': 'Project Size Unit:',
                  'ProposalNo': 'Proposal Reference:',
                  'proposalNo': 'Proposal Reference:',
                  'ProjectStatus': 'Project Status:',
                  'projectStatus': 'Project Status:',
                  'No_Of_Resource': 'No. of Resources:',
                  'no_Of_Resource': 'No. of Resources:',
                  'CurrencyCode': 'Project Value:', // Currency code is part of Project Value display
                  'currencyCode': 'Project Value:'
              };
              
              let highlightedCount = 0;
              const labels = container.querySelectorAll('label');
              
              console.log("Searching for labels in container. Total labels found:", labels.length);
              console.log("Changed fields to highlight:", changedFields.length);
              
              labels.forEach(label => {
                  const labelText = label.textContent.trim();
                  const changedField = changedFields.find(cf => {
                      // Handle both camelCase and PascalCase field names
                      const fieldName = cf.FieldName || cf.fieldName;
                      const mappedLabel = fieldNameMap[fieldName];
                      if (mappedLabel && mappedLabel === labelText) {
                          console.log("Matched field:", fieldName, "->", labelText);
                      }
                      return mappedLabel === labelText;
                  });
                  //debugger;
                  if (changedField) {
                      const row = label.closest('.row');
                      if (row) {
                          const valueContainer = row.querySelector('span');
                          if (valueContainer) {
                              valueContainer.classList.add('revision-changed-value');
                              highlightedCount++;
                              console.log("✓ Highlighted field:", labelText, "Value:", valueContainer.textContent.trim());
                          } else {
                              console.warn("Value container (span) not found for label:", labelText);
                          }
                      } else {
                          console.warn("Row not found for label:", labelText);
                      }
                  }
              });
              
              console.log("Total fields highlighted:", highlightedCount, "out of", changedFields.length, "changed fields");
              
              if (highlightedCount === 0 && changedFields.length > 0) {
                  console.warn("No fields were highlighted. Checking field names...");
                  changedFields.forEach(cf => {
                      const fieldName = cf.FieldName || cf.fieldName;
                      console.log("Changed field from API:", fieldName, "-> Mapped to:", fieldNameMap[fieldName] || "NOT FOUND IN MAP");
                  });
              }
          }

          //For validate special char for textarea 
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


          //For Get Color W.R.T Work flow status
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


          //For Get formate curreny
          function formatCurrency(amount) {
              if (amount == null) return '0.00';
              return parseFloat(amount).toLocaleString('en-IN', {
                  minimumFractionDigits: 2,
                  maximumFractionDigits: 2
              }) ;
          }

        
          function formatWorkHours(hours) {
              if (!hours) return '00:00';
              if (typeof hours === 'number') {
                  return hours.toFixed(2);
              }
              return hours;
          }


          // Utility functions
          function formatDate(dateString) {
              if (!dateString) return null;
              const date = new Date(dateString);
              return date.toLocaleDateString('en-GB', {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric'
              }).replace(/ /g, '-');
          }


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

         

         //For Ajax Call
          // Modified by Dipali V on 5th Dec 2025 - Added size check to skip Params header for large payloads to avoid HTTP 400 error
          function AJAXCallWithResult(url, param, async, type) {
              var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
              //debugger;
              var result = null;
              var fullUrl = API_BASE + url;

              // Calculate param size to avoid large headers causing HTTP 400
              var paramSize = param ? param.length : 0;
              var maxHeaderPayloadSize = 3000; // Skip header encryption for payloads larger than this

              $.ajax({
                  url: fullUrl,
                  type: type || "GET",
                  data: param,
                  async: async,
                  dataType: "json",
                  contentType: (type === "GET") ? "application/x-www-form-urlencoded" : "application/json;charset=utf-8",
                  beforeSend: function (xhr) {
                      xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                      // Skip Params header for large payloads to avoid HTTP 400 - Request Too Long
                      if (param && paramSize <= maxHeaderPayloadSize) {
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


          // Hide page loader and fade in content after everything loads
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
              var $tbody = $('#projEntityTable tbody');
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
              var $tbody = $('#projEntityTable tbody');
              var totalRecords = $tbody.find('tr').filter(function () {
                  return !$(this).hasClass('dataTables_empty') &&
                      $(this).find('td.dataTables_empty').length === 0;
              }).length;

              $('#totalRecords').text(totalRecords);
              totalPages = Math.ceil(totalRecords / itemsPerPage) || 1;

              if (currentPage <= 1 || totalRecords === 0) {
                  $('#btnprevious').addClass('fa-disabled');
                  $('#LinkPrevious').removeAttr('onclick');
              } else {
                  $('#btnprevious').removeClass('fa-disabled');
                  $('#LinkPrevious').attr('onclick', 'goToPreviousPage()');
              }

              if (currentPage >= totalPages || totalRecords === 0) {
                  $('#btnnext').addClass('fa-disabled');
                  $('#LinkNext').removeAttr('onclick');
              } else {
                  $('#btnnext').removeClass('fa-disabled');
                  $('#LinkNext').attr('onclick', 'goToNextPage()');
              }
          }

          function goToPreviousPage() {
              if (currentPage > 1) { currentPage--; showPageRows(); }
          }

          function goToNextPage() {
              if (currentPage < totalPages) { currentPage++; showPageRows(); }
          }
          // ============================================================
          // End Custom Pagination
          // ============================================================

      </script>
</body>

</html>
