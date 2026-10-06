<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityApprovalPage.aspx.vb" Inherits="Whizible.PM_EntityApprovalPage" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Entity Approval")%>
    <head runat="server">
     <meta charset="utf-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <title>Entity Approval</title>
 <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">

 <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/PM_EntityApproval.css?V=1">
        <style>
       .modal-body #checklstRespMdlTbl .table-fixed-header tbody tr th,
.modal-body #checklstRespMdlTbl .table tbody tr td {
    text-align: left !important;
    white-space: normal !important;
    word-wrap: break-word !important;
    word-break: break-word !important;
    vertical-align: top !important;

}
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
        </style>
        <!-- End of Same loader as PM_EntityProjectApproval - Added By Vyankat B. on 17th March 2026 -->

</head>


<body class="hold-transition bgwhite px-2 page-loading" id="Body">
    <div id="divMain">
    <!-- Added by Dipali V on 09-Oct-2025 (W26): Hidden fields for discussion functionality -->
    <input type="hidden" id="hdnLoginID" runat="server" />
    <input type="hidden" id="hdnUserName" runat="server" />

  

         <%-- Commented By Vyankat B. on 17th March 2026 for implementing same loader as PM_EntityProjectApproval / Project Profitability page (old spinner loader below) --%>
    <%-- <!-- Added by Dipali V on 07-Oct-2025 (W26): Page loader -->
    <div id="pageLoader">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden"><%= MyBase.GetResourceString("C_Loading") %>...</span>
        </div>
        <div class="loading-text"><%= MyBase.GetResourceString("C_LoadingWF") %>...</div>
    </div> --%>
    <%-- End of Commented By Vyankat B. on 17th March 2026 for implementing same loader as PM_EntityProjectApproval page --%>

    <!-- Same loader as PM_EntityProjectApproval - Added By Vyankat B. on 17th March 2026 -->
    <div id="pageLoader" class="loader-overlay">
        <div class="loader"></div>
    </div>

    <!-- End of Same loader - Added By Vyankat B. on 17th March 2026 -->

    <!-- Main content wrapper with fade-in effect -->
    <div class="main-content-wrapper">
        <div class="container-fluid pt-3">
            <div class="row">
                <div class="col-sm-5 WF_ApprHeading">
                    <div class="pgtitlenew"><%= MyBase.GetResourceString("C_PageMyApprovalCaption") %></div>
                     </div>
                <div class="col-sm-7 text-end mt-auto">
                    <%-- Added by Dipali V on 1st Dec 2025 
                         Purpose: Move Hide/Show link to header section to display on same line as Filter icon --%>
                    <a href="javascript:;" id="showWFApprSecBtn" class="textUndrln d-inline me-2" data-bs-toggle="collapse"
                        data-bs-target="#WF_ApprDetailsTab" aria-expanded="true"><%=MyBase.GetResourceString("C_HideFliter") %></a>
                    <%-- Modified by Dipali V on 1st Dec 2025 
                         Purpose: Move Clear All link near filter icon, show by default when Today filter is applied --%>
                    <a href="javascript:;" class="clearalllink me-2" onclick="clearAllFilters();" id="PMProjectReviewClearAllFilter"
                        data-bs-toggle="tooltip" data-bs-placement="bottom" title="" style="display:inline-block;"><strong><%= MyBase.GetResourceString("C_FilterClearAll") %></strong></a>
                    <div class="filter d-inline-block" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Filter Section">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title=""
                            id="AdvanceFilterIcon" data-original-title="Advanced Filter" autocomplete="off">
                            <i class="fas fa-filter"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="accordion main_acordian_panel mt-3 " id="WF_ApprAcc">
            <div class="accordion-item">
                <div id="WF_ApprDetailsTab" class="accordion-collapse collapse show" aria-labelledby="WF_ApprDetailsHeading"
                    data-bs-parent="#WF_ApprDetailsAcc">
                    <div class="accordion-body p-0">
                        <div class="container-fluid">
                            <div class="row">
                               <%-- <div class="col-md-3 d-md-none d-flex justify-content-center">
                                    <img src="../../../Whizible2.0-new/dist/img/my_approvals.jpg" alt=""
                                        class="WF_Img img-fluid d-block m-auto">
                                </div>--%>
                               <%-- Commented Added By Dipali V On 1st Dec 2025 For Align Changes--%>
                                <%--<div class="col-md-9 WF_ApprHeading">--%>
                                <%-- End of Commented Added By Dipali V On 1st Dec 2025 For Align Changes--%>
                                <div class="col-md-10 WF_ApprHeading" style="font-size: 11px!important;white-space: pre-wrap;">
                                    <div class="font-12 pt-2"><%=MyBase.GetResourceString("C_NoteNewPageHeader") %><br/>
                                        <b class="alignmt">Note :</b> 
                                        <span class="alignmt">A default filter is applied on "Pending From". To view all pending approvals, users can click on <strong> "Clear All" </strong> to remove the filter</span> 
                                   
                                    </div>
                                   
                                </div>
                                <div class="col-md-2 d-none d-md-block d-flex justify-content-center">
                                    <img src="../../../Whizible2.0-new/dist/img/my_approvals.jpg" alt=""
                                        class="WF_Img img-fluid d-block m-auto">
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%-- Removed by Dipali V on 1st Dec 2025: Moved Hide link to header section to be on same line as Filter icon --%>

        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse mb-3">
            <div class="bglightgray container-fluid py-1 headertopp filterpanelheader">
                <div class="Fwrapper pt-3">
                    <div class="row mb-3">
                        <div class="col-sm-6 condt-filter">
                            <div class="row form-group">
                                <div class="col-sm-4 text-end">
                                    <label><%= MyBase.GetResourceString("C_CFBusinessUnitF") %></label>
                                </div>
                                <div class="col-sm-8">
                                    <select class="selectpicker" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 condt-filter">
                            <div class="row">
                                <div class="col-sm-4 text-end">
                                    <label><%= MyBase.GetResourceString("C_FOrganizationUnit") %></label>
                                </div>
                                <div class="col-sm-8">
                                    <select class="selectpicker" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-sm-6 condt-filter">
                            <div class="row form-group">
                                <div class="col-sm-4 text-end">
                                    <label><%= MyBase.GetResourceString("C_FF") %></label>
                                </div>
                                <div class="col-sm-8">
                                    <select class="selectpicker" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end filter panel-->
        <!-- Workflow Inbox Filters Start -->
        <div class="inboxDiv row py-3 py-md-1 align-items-center" id="InboxSec">
            <div class="col-sm-8">
                <div class="d-inline-block  ml-1">
                    <button type="button" class="btn inboxBtn position-relative active" data-bs-toggle="tooltip"
                        title="To-do List">
                        <i class="fas fa-inbox pe-1"></i><%= MyBase.GetResourceString("C_Inbox_Count") %> 
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                        id="InboxCnt">
                        <span class="visually-hidden" id="InboxTxt"><%= MyBase.GetResourceString("C_Inbox_Count") %></span>
                    </span>
                    </button>
                </div>
               <%-- <div class="d-inline-block  ml-1">
                    <button type="button" class="btn watchlistBtn position-relative" data-bs-toggle="tooltip"
                        title="Applicable to Project and WBS Items">
                        <i class="fas fa-th-list pe-1"></i><%= MyBase.GetResourceString("C_WL_Count") %>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                        id="WL_Cnt">
                        <span class="visually-hidden" id="WL_Txt"><%= MyBase.GetResourceString("C_WL_Count") %> </span>
                    </span>
                    </button>
                </div>--%>
            </div>
        </div>
        <!-- Workflow Inbox Filters End -->
        <!-- Entity WorkFlow Tabs -->
        <div class="workFlowTabs" id="EntityWF_Tabs">
            <div class="row">
                <div class="col-sm-4 col-lg-4 d-none d-lg-block mt-2">
                    <div class="change_filter" id="search_pro">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label><%= MyBase.GetResourceString("CProjectName") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control" placeholder="Enter Project Name" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="change_filter hide" id="search_subpro">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label><%= MyBase.GetResourceString("C_SubprojectName") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control" placeholder="Enter Sub-Project" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="change_filter hide" id="search_MS">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label><%= MyBase.GetResourceString("C_MilestoneName") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control"  placeholder="Enter Milestone Name" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="change_filter hide" id="search_Deliverable">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <%--<label><%= MyBase.GetResourceString("C_DeliverableName") %>:</label>--%>
                                <label><%= MyBase.GetResourceString("C_Title") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control" placeholder="Enter Title" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="change_filter hide" id="search_Module">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label><%= MyBase.GetResourceString("C_ModuleName") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control"  placeholder="Enter Module Name" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="change_filter hide" id="search_chanRequest">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label><%= MyBase.GetResourceString("C_ChangeRequestCaption") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control" placeholder="Enter Change Request Name" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <%-- Modified by Dipali V on 4th Dec 2025 - Attractive inline filters with icons and labels --%>
                    <%--<div class="change_filter hide" id="search_leave">--%>
                        <%--<div class="d-flex align-items-center flex-nowrap" style="gap: 20px;margin-left: 10px;">
                            <!-- Resource Name Filter with Icon & Label -->
                            <div class="d-flex align-items-center">
                                <label class="form-label mb-0 me-2 text-nowrap" style="color: #2c3e50; font-size: 12px; font-weight: 600;">
                                    <i class="fas fa-user text-primary me-1"></i>Employee Name:
                                </label>
                                <input type="text" id="txtLeaveResourceName" class="form-control form-control-sm" 
                                       placeholder="Enter Employee Name" autocomplete="off" maxlength="50"
                                       style="border-radius: 6px; width: 140px; font-size: 12px; border: 1px solid #ced4da; box-shadow: 0 1px 3px rgba(0,0,0,0.08);" />
                            </div>
                        </div>--%>
                          <div class="change_filter hide" id="search_leave">
                              <div class="row">
                                  <div class="col-sm-5 text-end mt-1">
                                      <label>Employee Name :</label>
                                  </div>
                                  <div class="col-sm-7 text-start">
                                      <input type="text" name="" id="txtLeaveResourceName"  class="form-control"  placeholder="Enter Employee Name" autocomplete="off" maxlength="50">
                                  </div>
                              </div>
                          </div>
                    <%--</div>--%>
                    <%-- Added to match Leave search field layout - Resource Timesheet employee name filter --%>
                    <div class="change_filter hide" id="search_ResourceTS">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label>Employee Name :</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" id="txtResourceTSName" class="form-control" placeholder="Enter Employee Name" autocomplete="off" maxlength="50">
                            </div>
                        </div>
                    </div>
                    <div class="change_filter hide" id="search_ProjTS">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label><%= MyBase.GetResourceString("C_TSID") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control" placeholder="Enter Timesheet ID" autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="change_filter hide" id="search_IR">
                        <div class="row">
                            <div class="col-sm-5 text-end mt-1">
                                <label><%= MyBase.GetResourceString("C_IRID") %>:</label>
                            </div>
                            <div class="col-sm-7 text-start">
                                <input type="text" name="" class="form-control" placeholder="Enter IR/PIR ID" autocomplete="off">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-12 col-lg-8">
                    <div class="allWorkflowTabsDiv">
                        <!-- Workflow List View Tabs -->
                        <ul class="nav nav-tabs mb-2 pe-3" id="AllEntityTab" role="tablist">
                            <li class="d-flex align-items-center ps-3">
                                <div class="arrowBtn pe-2" id="LeftArrowBtn">
                                    <i class="fas fa-angle-double-left leftArrow" id="leftAngleArrow"></i>
                                </div>
                            </li>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link active position-relative" id="projectEntityTab" data-bs-toggle="tab"
                                    data-bs-target="#projectTab" onclick="OpenTab('projectEntityTab', 'PM_EntityProjectApproval.aspx','32')" type="button" role="tab" aria-controls="projectTab"
                                    aria-selected="true">
                                    <i class="fas fa-project-diagram me-2"></i><%= MyBase.GetResourceString("C_Project") %>
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeGreen">0</span>
                                </button>
                            </li>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="subProjEntityTab" data-bs-toggle="tab"
                                    data-bs-target="#subProjTab" onclick="OpenTab('subProjEntityTab', 'PM_EntitySubProjectApproval.aspx','34')" type="button" role="tab" aria-controls="subProjTab"
                                    aria-selected="false">
                                    <i class="fas fa-sitemap me-2"></i><%= MyBase.GetResourceString("CCTabSubProject") %>
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeOrange">0</span>
                                </button>
                            </li>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="milestoneEntityTab" data-bs-toggle="tab"
                                    data-bs-target="#milestoneTab" onclick="OpenTab('milestoneEntityTab', 'PM_EntityMilestoneApproval.aspx','34')" type="button" role="tab" aria-controls="milestoneTab"
                                    aria-selected="false">
                                    <i class="fas fa-flag-checkered me-2"></i><%= MyBase.GetResourceString("CCMilestoneTab") %>
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeRed">0</span>
                                </button>
                            </li>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="DlvrblEntityTab" data-bs-toggle="tab"
                                    data-bs-target="#DlvrblTab" onclick="OpenTab('DlvrblEntityTab', 'PM_EntityDeliverableApproval.aspx','2133')" type="button" role="tab" aria-controls="DlvrblTab"
                                    aria-selected="false">
                                    <i class="fas fa-tasks me-2"></i><%= MyBase.GetResourceString("C_CRDeliverable") %>
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeGreen">0</span>
                                </button>
                            </li>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="moduleEntityTab"  onclick="OpenTab('moduleEntityTab', 'PM_EntityModuleApproval.aspx','454')" type="button" role="tab" aria-controls="moduleTab"
                                    aria-selected="false">
                                    <i class="fas fa-cube me-2"></i><%= MyBase.GetResourceString("C_ChangeModule") %>  
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeRed">0</span>
                                </button>
                            </li>
                          <%--  Commented By Dipali V On 1st Dec 2026 For Hide Change Request Tabs--%>
                            <%--<li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="changeReqEntityTab" data-bs-toggle="tab"
                                    data-bs-target="#changeReqTab" onclick="OpenTab('changeReqTab', 'PM_EntityChangeRequest.aspx','1039')" type="button" role="tab" aria-controls="changeReqTab"
                                    aria-selected="false" >
                                    
                                    <%= MyBase.GetResourceString("C_ChangeRequestCaption") %>
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeOrange">0</span>
                                </button>
                            </li>--%>
                            <%--  End of Commented By Dipali V On 1st Dec 2026 For Hide Change Request Tabs--%>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="LeavesEntityTab" onclick="OpenTab('LeavesEntityTab', 'PM_EntityLeaveApproval.aspx','1209')" type="button" role="tab" aria-controls="LeavesTab"
                                    aria-selected="false" >
                                    <i class="fas fa-calendar-alt me-2"></i><%= MyBase.GetResourceString("C_LeaveHeader") %>   
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeRed">0</span>
                                </button>
                            </li>
                             <li class="nav-item WF_EntityList" role="presentation">
                                 <button class="nav-link position-relative" id="ResourceTSEntityTab" data-bs-toggle="tab"
                                     data-bs-target="#ResourceTSTab" type="button" role="tab" aria-controls="ProjTSTab"
                                     aria-selected="false" onclick="OpenTab('ResourceTSEntityTab', 'PM_EntityResourceTimesheet.aspx','10')">
                                      <i class="fas fa-user-clock me-2"></i><%--<%= MyBase.GetResourceString("C_ResourceTimesheetTab") %>--%> 
                                     Resource Timesheet
         
                                 <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeGreen">0</span>
                                 </button>
                             </li>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="ProjTSEntityTab" data-bs-toggle="tab"
                                    data-bs-target="#ProjTSTab" type="button" role="tab" aria-controls="ProjTSTab"
                                    aria-selected="false" onclick="OpenTab('ProjTSEntityTab', 'PM_EntityProjectTimesheet.aspx','42')">
                                     <i class="fas fa-calendar me-2"></i><%= MyBase.GetResourceString("C_ProjectTimesheetTab") %> 
                                    
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeGreen">0</span>
                                </button>
                            </li>
                            <li class="nav-item WF_EntityList" role="presentation">
                                <button class="nav-link position-relative" id="IR_ApprEntityTab" data-bs-toggle="tab"
                                    data-bs-target="#IR_ApprovalTab" onclick="OpenTab('IR_ApprEntityTab', 'PM_EntityIRApproval.aspx')" type="button" role="tab" aria-controls="IR_ApprovalTab"
                                    aria-selected="false">
                                      <i class="fas fa-file-invoice me-2"></i><%= MyBase.GetResourceString("C_IR") %>    
                                <span class="position-absolute top-1 start-100 translate-middle badge rounded-pill badgecolor badgeGreen">0</span>
                                </button>
                            </li>
                           
                            <li class="d-flex align-items-center ps-3">
                                <div class="arrowBtn pe-2" id="RightArrowBtn">
                                    <i class="fas fa-angle-double-right rightArrow" id="rightAngleArrow"></i>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="tab-content" id="nav-tabContent">
                <iframe id="tabFrame" src=""  width="100%" height="400px" frameborder="0"></iframe>

                <!-- Empty container for offcanvas/modals -->
                <div id="OffcanvasContainer"></div>
               
  
            </div>
        </div>

 
 
        <!-- Project Details show status offcanvas start here-->
        <!-- Added by Dipali V on 24th Dec 2025 - Purpose: Changed from modal to offcanvas for Show Details functionality (Project, Module, Subproject, Deliverable, Milestone) -->
        <div class="offcanvas fade offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="projShowStatusOffcanvas" aria-labelledby="projShowStatusOffcanvasLabel">
            <div class="offcanvas-header graybg" style="border-bottom: 1px solid #dee2e6;">
                <h5 class="offcanvas-title pgtitle" id="projShowStatusOffcanvasLabel">
                    <i class="fas fa-info-circle me-2"></i><%= MyBase.GetResourceString("C_WFDeatilas") %>
                </h5>
<button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                aria-label="Close" onclick="closeProjShowStatusOffcanvas()">
                                                <i class="fas fa-times"></i>
                </button>            </div>
            <div class="offcanvas-body">
                <div class="WF_DetailsMainContent">
                    <!-- Project details div desktop view starts -->
                    <div class="WF_DetlsDesktop py-3" id="WF_DetlsDeskModal">
                        
                    </div>
                    <!-- Project stages div starts -->
                    <div class="WFStagesDiv p-4" id="stages-div">
                        <!-- <div class="row"> -->
                        <div class="stage-status">
                            <div class="stage-title">
                                <h5 class="mb-0"><%= MyBase.GetResourceString("CLegends") %></h5>
                            </div>

                            <div class="stage-content">
                                <ul class="main-box">
                                    <li>
                                        <div class="stage-box green-box"></div>
                                        <div class="span-clrs"><%= MyBase.GetResourceString("C_Clearedstage") %></div>
                                    </li>
                                </ul>
                                <ul class="main-box">
                                    <li>
                                        <div class="stage-box yellow-box"></div>
                                        <div class="span-clrs"><%= MyBase.GetResourceString("C_Currentstage") %></div>
                                    </li>
                                </ul>
                                <ul class="main-box">
                                    <li>
                                        <div class="stage-box red-box"></div>
                                        <div class="span-clrs"><%= MyBase.GetResourceString("Delayedcurrentstage") %></div>
                                    </li>
                                </ul>
                                <ul class="main-box">
                                    <li>
                                        <div class="stage-box grey-box"></div>
                                        <div class="span-clrs"><%= MyBase.GetResourceString("C_Stagenotstartedyet") %></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <!-- </div> -->
                    </div>
                    <!-- Project stages div ends -->

                    <!--Workflow Stage History start here-->
                    <div class="WF_ApprHisDiv m-3" id="projApprovalStage">

                        <div class="table-responsive">
                            <table class="table table-striped table-hover table-bordered init_borderedTbl"
                                id="WF_projApprovalStage">
                                <thead class="stickyTblHeader">
                                    <tr class="cart-table-head">
                                        <th style="width: 80px;"><%= MyBase.GetResourceString("CStatusIR ") %></th>
                                        <th><%= MyBase.GetResourceString("C_FromStage") %></th>
                                        <th><%= MyBase.GetResourceString("C_ToStage") %></th>
                                        <th><%= MyBase.GetResourceString("C_Date") %></th>
                                        <th><%= MyBase.GetResourceString("C_ApprovedBy") %></th>
                                        <th><%= MyBase.GetResourceString("C_ApproverList") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!--Workflow Stage History end here-->

                    <!--Workflow Approval History start here-->
                    <div class="WF_ApprHisDiv m-3" id="WF_ApprHisSec">
                        <div class="stage-title">
                            <h5 class="mb-2"><%= MyBase.GetResourceString("C_WAH") %></h5>
                        </div>
                        <p class="mb-2">
                            <i class="far fa-sticky-note me-2"></i><small><%= MyBase.GetResourceString("C_WFNote") %>
                           .</small>
                        </p>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover table-bordered init_borderedTbl"
                                id="WF_ApprHisTable">
                                <thead class="stickyTblHeader">
                                    <tr class="cart-table-head">
                                        <th><%= MyBase.GetResourceString("C_EventTime") %> </th>
                                        <th><%= MyBase.GetResourceString("C_ActionTaken") %> </th>
                                        <th><%= MyBase.GetResourceString("C_FromStage") %></th>
                                        <th><%= MyBase.GetResourceString("C_ToStage") %></th>
                                        <th><%= MyBase.GetResourceString("C_ApproverSender") %></th>
                                        <th><%= MyBase.GetResourceString("C_Comments") %> </th>
                                    </tr>
                                </thead>
                                <tbody>
                                 
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!--Workflow Approval History end here-->
                </div>

                <div class="clearfix"></div>
            </div>
        </div>
        <!-- Project Details show status offcanvas end here-->

         <div id="divSendForApproval" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modalsmall">
              <!-- Modal content-->
              <div class="modal-content" style="height: 340px">
                  <div class="modal-header">
                      <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                      <h4 class="modal-title" id="lblCaption"></h4>
                  </div>

                  <div class="modal-body" style="height: 230px">
                      <div class="form-group">
                    
                          <div class="col-md-12 row">
                              <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_SelectWorkflow") %> : <span style='color: red;'>*</span></label>
                              <span class="col-md-8">
                                  <% CommonFunctions.HTMLControls.DrawComboBox("cboWF", "Select 'Select Workflow'",,, "class='form-control form-select'",,, ) %>
                              </span>
                          </div>
                      </div>
                      <div class="form-group">
                          <div class="col-md-12 row" style="margin-top: 10px;">
                              <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_Comments") %> : <span style='color: red;'>*</span></label>
                              <span class="col-md-8">
                                  <% CommonFunctions.HTMLControls.DrawTextArea("txtWFComments", "txtWFComments", "Enter Comments", "form-control", ,,,,, 100, 1000,,,,,,,, "PlaceHolder = 'Enter Comments (Maxlength 1000 Chars)' autocomplete='Off' maxlength='1000' ",,,,,,,,,,) %>

                              </span>
                          </div>
                      </div>

                  </div>

                  <div class="modal-footer">
                       <%If m_EditAccess = True Then %>
                      <button type="button" class="btn btnyellow ml-1 float-end" onclick="SubmitonClick()" id="btnSubmit"><%= MyBase.GetResourceString("C_Submit") %></button>
                      <%End If %>
                      <button type="button" class="btn borderbtn nobtnstyle-xs " data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></button>
                  </div>
              </div>
          </div>
      </div>


        <div class="modal custmodal fade" id="approveleaveRevModal" aria-hidden="true">
         <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lblapproveleaveRevModalCaption"></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 text-end">
                        <label class="form-label ">(<font color="red">*</font> <%= MyBase.GetResourceString("C_Mandatory") %>)</label>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="required" id-="ApproveRejectLabel"><%= MyBase.GetResourceString("C_Comments") %>: </label>
                    <div class="col-sm-12">
                        <% CommonFunctions.HTMLControls.DrawTextArea("txtWFARLeaveComments", "txtWFARLeaveComments", "Enter Comments", "form-control", ,,,,, 100, 1000,,,,,,,, "PlaceHolder = 'Enter Comments (Maxlength 1000 Chars)' autocomplete='Off' maxlength='1000' ",,,,,,,,,,) %>
                    </div>
                </div>
             
                <div class="text-center my-2">
                     <%If m_EditAccess = True Then %>
                    <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                       id="LeaveActionLinkCaption" onclick="ApproveRejectLeaveClick()"></a>
                    <%End If %>
                    <a href="javascript:;" class="btn borderbtn mr-5"
                        data-bs-toggle="tooltip" data-bs-original-title="Cancel" data-bs-dismiss="modal" onclick="CloseAppRejectLeaveReject()"><%= MyBase.GetResourceString("C_Cancel") %></a>
                </div>
            </div>
        </div>
    </div>
      </div>

        <!--Approve Revision modal start here-->
        <div class="modal custmodal fade" id="approveRevModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblAppRejectCaption"></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12 text-end">
                                <label class="form-label ">(<font color="red">*</font><%= MyBase.GetResourceString("C_Mandatory") %>)</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="required" id-="ApproveRejectLabel"><%= MyBase.GetResourceString("C_Comments") %>: </label>
                            <div class="col-sm-12">
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtWFARComments", "txtWFARComments", "Enter Comments", "form-control", ,,,,, 100, 1000,,,,,,,, "PlaceHolder = 'Enter Comments (Maxlength 1000 Chars)' autocomplete='Off' maxlength='1000' ",,,,,,,,,,) %>
                            </div>
                        </div>
                        <input type="hidden" id="EntityID" />
                         <%If m_EditAccess = True Then %>
                        <div class="text-center my-2">
                            <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                                data-bs-original-title="Approve" id="ActionLinkCaption" onclick="ApproveRejectClick()"><%= MyBase.GetResourceString("C_Approve")%></a>
                            <a href="javascript:;" class="btn borderbtn mr-5"
                                data-bs-toggle="tooltip"  data-bs-original-title="Cancel" data-bs-dismiss="modal"  onclick="CloseAppReject()"><%= MyBase.GetResourceString("C_Cancel")%></a>
                        </div>
                        <%End If %>
                    </div>
                </div>
            </div>
        </div>
        <!--Approve Revision modal end here-->

     


        <!--Put on hold modal start here-->
        <div class="modal custmodal fade" id="putOnHoldModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ProjectTimesheetCaption"></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <label class="required"><%= MyBase.GetResourceString("C_Comments") %>: </label>
                                <% CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Enter Comments", "form-control", ,,,,, 100, 1000,,,,,,,, "PlaceHolder = 'Enter Comments (Maxlength 1000 Chars)' autocomplete='Off' maxlength='1000' ",,,,,,,,,,) %>
                            </div>
                        </div>
                        <div class="text-center my-2">
                             <%If m_EditAccess = True Then %>
                            <a href="javascript:;" class="btn btnyellow" id="btnComments" onclick="SaveComments()"><%= MyBase.GetResourceString("C_Ok") %></a>
                            <%End If %>
                            <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Cancel")%></a>
                            <span id="hdnflag"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Put on hold modal end here-->

       

        <!--Checklist Response Offcanvas Start Here - Modified by Dipali V on 4th Dec 2025-->
        <div class="offcanvas fade offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="checklistOffcanvas" aria-labelledby="checklistOffcanvasLabel">
            <div class="offcanvas-header graybg" style="border-bottom: 1px solid #dee2e6;">
                <h5 class="offcanvas-title pgtitle" id="checklistOffcanvasLabel">
                    <i class="fas fa-clipboard-check me-2"></i><%= MyBase.GetResourceString("C_ChecklistResponse") %>
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
            <div class="offcanvas-body">
                <div class="ChecklistRespSec">
                    <div class="chcklist-main-wrap">
                        <div class="container-fluid py-2 mb-3 graybg" style="border-radius: 4px;">
                            <div class="row align-items-center">
                                <div class="col-sm-12">
                                    <div class="d-flex justify-content-between">
                                        <label class="modalLbl fw-semibold" style="color: #495057;">
                                            <%= MyBase.GetResourceString("C_CheckList") %>:
                                        </label>
                                        <label class="modalLblstage fw-semibold" style="color: #495057;">
                                            Stage:
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <p class="mb-0 text-primary">
                                <i class="far fa-sticky-note me-2"></i>
                                <small>1. <%= MyBase.GetResourceString("C_ChecklistNote") %>.</small>
                                <small>2. <%= MyBase.GetResourceString("C_ChecklistNote2") %>.</small>
                            </p>
                            <%If m_EditAccess = True Then %>
                            <div class="d-flex gap-2">
                                <%--<button id="btnSaveChecklist" class="btn btn-primary btn-sm">--%>
                                <button id="btnSaveChecklist" class="btn btnyellow btn-sm">
                                    <%--<i class="fas fa-save me-1"></i><%= MyBase.GetResourceString("C_Save") %>--%>
                                    <%= MyBase.GetResourceString("C_Save") %>
                                </button>
                              <%--  <button id="btnCloseChecklist" class="btn borderbtn btn-sm" onclick="closeChecklistOffcanvas()" aria-label="Close">
                                    Close
                                </button>--%>
                            </div>
                            <%End If %>
                        </div>

                        <div class="table-responsive" style="max-height: calc(100vh - 250px); overflow-y: auto;">
                            <table class="table table-bordered table-hover" id="checklstRespMdlTbl">
                                <thead class="stickyTblHeader" style="background: #f1f3f4;">
                                    <tr>
                                        <th style="width: 60px;"><%= MyBase.GetResourceString("C_SRNO") %>.</th>
                                        <th style="width: 25%;"><%= MyBase.GetResourceString("C_CheckListItem") %></th>
                                        <th style="width: 45%;"><%= MyBase.GetResourceString("C_Responses") %></th>
                                        <th style="width: 25%;"><%= MyBase.GetResourceString("C_Comments") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Approval Comment Section - Added by Dipali V on 24th Dec 2025 - Purpose: Show approval comment in checklist offcanvas instead of separate modal -->
                        <div id="approvalCommentSection" style="display: none; margin-top: 20px; padding-top: 20px; border-top: 2px solid #dee2e6;">
                            <div class="mb-3">
                                <label for="txtApprovalComment" class="form-label fw-semibold" style="color: #495057;">
                                    <%= MyBase.GetResourceString("C_Comments") %> <span class="text-danger">*</span>
                                </label>
                                <textarea id="txtApprovalComment" class="form-control" rows="4" placeholder="<%= MyBase.GetResourceString("C_EnterApprovalComment") %>" style="resize: vertical;"></textarea>
                                <%--<small class="text-danger" id="approvalCommentError" style="display: none;"><%= MyBase.GetResourceString("C_CommentBlank") %></small>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Checklist Response Offcanvas End Here-->

        <div id="Conformationmodel" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= MyBase.GetResourceString("C_Confirmation") %></h4>
                    </div>

                    <div class="modal-body">
                        <p align="center" id="PMSG"></p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Cancel") %></button>
                                </div>
                               <%-- <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="AllowtoApproveTimesheetblock('0')" data-bs-dismiss="modal" id="btnConfirmation"><%= MyBase.GetResourceString("C_Ok") %></button>
                                </div>--%>
                                 <%If m_EditAccess = True Then %>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" 
                                            onclick="AllowtoApproveTimesheetblock('0')" 
                                            data-bs-dismiss="modal" 
                                            id="btnConfirmation">
                                        <%= MyBase.GetResourceString("C_Ok") %>
                                    </button>
                                </div>
                              <% End If %>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
   
   
        <!--Reject modal start here-->
        <div class="modal custmodal fade" id="ApproveRejectModal" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="TimesheetAppRejectCaption"></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row ">
                            <div class="col-sm-12 text-end">
                                <label class="form-label ">
                                    (<font color="red">*</font>
                                    <%= MyBase.GetResourceString("C_Mandatory") %>)
                                </label>
                            </div>
                        </div>
                        <table id="ApproveRejectTbl" class="table modalDTtabl table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_TimesheetID") %></th>
                                    <th><%= MyBase.GetResourceString("CProjectName") %></th>
                                    <th><%= MyBase.GetResourceString("C_FromDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_ToDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_Comments") %></th>
                                </tr>
                            </thead>
                            <tbody id="TableEditdetails">
                               
                            </tbody>
                        </table>
                        <br />
                        <div class="text-center">
                             <%If m_EditAccess = True Then %>
                            <button class="btn btnyellow" id="submitIRSaveBtn" onclick="ApproveRejectPT()"></button>
                            <%End If %>
                            <button class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--Reject modal end here -->


        <div class="modal custmodal fade" id="ApproveRejectIR" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="IRApproveRejectCaption"></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row ">
                    <div class="col-sm-12 text-end">
                        <label class="form-label ">
                            (<font color="red">*</font>
                            <%= MyBase.GetResourceString("C_Mandatory") %>)
                        </label>
                    </div>
                </div>

                  <div class="col-sm-6">
                          <div class="row form-group">
                              <div class="col-sm-6 d-flex justify-content-end"> 
                                  <label class="required"><%= MyBase.GetResourceString("CStatusIR ") %> : </label>
                              </div>
                              <div class="col-sm-6">
                                  <select class="form-select"  id="IRStatus">   
                                      <option>Select <%= MyBase.GetResourceString("CStatusIR ") %> </option>
                                      <option value="Approved">Approved</option>
                                      <option value="Rejected">Rejected</option>
                                      <option value="Cancelled">Cancelled</option>                                                                              
                                  </select>
                              </div>
                          </div>
                      </div>
                <br />
                <br />
                 <div class="col-sm-6">

                  <div class="row form-group">

                      <div class="col-sm-6 d-flex justify-content-end">
                           <label class="required" id-="ApproveRejectLabel"><%= MyBase.GetResourceString("C_Comments") %>: </label>                                                                  
                        </div>
                         <div class="col-sm-6">
                             <% CommonFunctions.HTMLControls.DrawTextArea("txtIRComments", "txtIRComments", "Enter Comments", "form-control", ,,,, 340, 100, 1000,,,,,,,, "PlaceHolder = 'Enter Comments (Maxlength 1000 Chars)' autocomplete='Off' maxlength='1000' ",,,,,,,,,,) %>                                                
                         </div>
                     </div>
                     </div>
                <br />
                <div class="text-center">
                     <%If m_EditAccess = True Then %>
                    <button class="btn btnyellow" id="ApproveRejectIRBtn" onclick="ApproveRejectIR_Click()"></button>
                    <%End If %>
                    <button class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></button>                                                                        
                </div>

            </div>
        </div>
    </div>
</div>


        <!-- Show History Modal start here-->
        <div class="modal custmodal fade" id="IRShowHisModal" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ShowHistory") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="pt-1 pb-1 form-inline hstryfltr ">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="row form-group">
                                        <div class="col-sm-6 d-flex justify-content-end">
                                            <label><%= MyBase.GetResourceString("C_ModifiedField") %>: </label>
                                        </div>
                                        <div class="col-sm-6">
                                            <select class="selectpicker" data-live-search="true" id="IRModifiedFields">
                                                <option>Select <%= MyBase.GetResourceString("C_ModifiedField") %></option>
                                               
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="row form-group">
                                        <div class="col-sm-6 d-flex justify-content-end">
                                            <label><%= MyBase.GetResourceString("C_ModifiedBy") %>: </label>
                                        </div>
                                        <div class="col-sm-6">
                                            <select class="selectpicker" data-live-search="true" id="IRModifiedBy">
                                                <option>Select <%= MyBase.GetResourceString("C_ModifiedBy") %></option>
                                               
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="container-fluid py-2 graybg mb-2">
                            <div class="row align-items-center">
                                <div class="col-sm-12">
                                    <div class="d-flex">
                                        <span><%= MyBase.GetResourceString("C_AuditTrail") %></span>
                                        <span><%= MyBase.GetResourceString("C_IRPIR") %></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <table id="LeavesShowHisTbl" class="table table-bordered" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= MyBase.GetResourceString("C_ModifiedField") %></th>
                                    <th><%= MyBase.GetResourceString("C_OldValue") %></th>
                                    <th><%= MyBase.GetResourceString("C_NewValue") %></th>
                                    <th><%= MyBase.GetResourceString("C_ModifiedDate") %></th>
                                    <th><%= MyBase.GetResourceString("C_ModifiedBy") %></th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>
                        <br />

                        <div class="clearfix"></div>

                        <div class="text-center">
                            <button class="btn borderbtn" data-bs-dismiss="modal" data-bs-toggle="tooltip"
                                title="Cancel">
                                <%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Show History Modal end-->


          <div class="modal custmodal fade" id="approveRevRTModal" aria-hidden="true">
      <div class="modal-dialog modal-md" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="lblAppRejectRTCaption"></h5>
                  <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-sm-12 text-end">
                          <label class="form-label ">(<font color="red">*</font><%= MyBase.GetResourceString("C_Mandatory") %>)</label>
                      </div>
                  </div>
                  <div class="form-group row">
                      <label class="required" id-="ApproveRejectRTLabel"><%= MyBase.GetResourceString("C_Comments") %>: </label>
                      <div class="col-sm-12">
                          <% CommonFunctions.HTMLControls.DrawTextArea("txtWFARPTComments", "txtWFARPTComments", "Enter Comments", "form-control", ,,,,, 100, 1000,,,,,,,, "PlaceHolder = 'Enter Comments (Maxlength 1000 Chars)' autocomplete='Off' maxlength='1000' ",,,,,,,,,,) %>
                      </div>
                  </div>
                  <input type="hidden" id="EntityID" />
                   <%If m_EditAccess = True Then %>
                  <div class="text-center my-2">
                      <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                          data-bs-original-title="Approve" id="ActionLinkRTCaption" onclick="ApproveRejectRTClick()"><%= MyBase.GetResourceString("C_Approve")%></a>
                      <a href="javascript:;" class="btn borderbtn mr-5"
                          data-bs-toggle="tooltip"  data-bs-original-title="Cancel" data-bs-dismiss="modal"  onclick="CloseAppReject()"><%= MyBase.GetResourceString("C_Cancel")%></a>
                  </div>
                  <%End If %>
              </div>
          </div>
      </div>
  </div>

        <!--Page modal end here-->
        <div class="clearfix"></div>
        <!--ps_list_table_end-->
        <script>
            var CTagID = 0;
            var CUniqueID = 0;
            var strAlertType = 'T';
            var WhichActionWF = "";
            var SelectedWF = "";
            var GFromWhere = "";
            var ViewAccess = "<%= m_ViewAccess %>";
            var EditAccess = "<%= m_EditAccess %>";
            $(document).ready(function () {
                //alert(EditAccess);
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;background-color:white;margin-top:15%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divMain").html(bodyHTML);
                    return;
                }

                var itemsToShowInitially = 6;
                var itemsToShow = 6;
                var visibleItems = itemsToShowInitially;
                var currentStartIndex = 0; // Track the starting index

                $('#AllEntityTab li.WF_EntityList').hide();
                $('#AllEntityTab li.WF_EntityList:lt(' + visibleItems + ')').fadeIn();

                if ($('#AllEntityTab li.WF_EntityList:visible').length <= 8) {
                    $('#LeftArrowBtn').hide();
                }

                $('#RightArrowBtn').click(function () {
                    var totalItems = $('#AllEntityTab li.WF_EntityList').length;
                    currentStartIndex += itemsToShow;

                    // Don't go beyond total items
                    if (currentStartIndex >= totalItems) {
                        currentStartIndex = totalItems - itemsToShow;
                    }

                    // Hide all items
                    $('#AllEntityTab li.WF_EntityList').hide();

                    // Show the next set of items
                    $('#AllEntityTab li.WF_EntityList').slice(currentStartIndex, currentStartIndex + itemsToShow).fadeIn();

                    // Update button visibility
                    if (currentStartIndex + itemsToShow >= totalItems) {
                        $(this).hide();
                    }
                    $('#LeftArrowBtn').show();
                });

                $('#LeftArrowBtn').click(function () {
                    currentStartIndex -= itemsToShow;

                    // Don't go below 0
                    if (currentStartIndex < 0) {
                        currentStartIndex = 0;
                    }

                    // Hide all items
                    $('#AllEntityTab li.WF_EntityList').hide();

                    // Show the previous set of items
                    $('#AllEntityTab li.WF_EntityList').slice(currentStartIndex, currentStartIndex + itemsToShow).fadeIn();

                    // Update button visibility
                    if (currentStartIndex === 0) {
                        $(this).hide();
                    }
                    $('#RightArrowBtn').show();
                });

                $('.filter-wrap').click(function () {
                    $(this).toggleClass('active');
                });

               
            });


         

            $(document).ready(function () {
                $(".change_filter").hide();
                $("#search_pro").show();
                // Added by Dipali V on 1st Dec 2025
                // Purpose: Load filters on page load and set "Today" as default selection for Pending From filter
                loadTopFilters(true); // Pass true to set default "Today" filter
                load(strAlertType);
                //initializeDataTables();
                
                // Modified by Dipali V on 4th Dec 2025 - Leave Status now uses regular form-select (no selectpicker needed)
            });

            // Script for showing filters on tab click
            // Track previous tab to clear filters when switching away and back
            var previousTab = '';
            var currentTab = '';
            
            // Helper function to clear all filter textboxes
            function clearFilterTextboxes() {
                $('.change_filter input[type="text"]').val('');
            }
            
            $("#projectEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab (was on this tab before, then switched away, now coming back)
                if (previousTab === 'projectEntityTab' && currentTab !== 'projectEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'projectEntityTab';
                
                $(".change_filter").hide();
                $("#search_pro").show();
            });
            $("#subProjEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'subProjEntityTab' && currentTab !== 'subProjEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'subProjEntityTab';
                
                $(".change_filter").hide();
                $("#search_subpro").show();
                $("#search_subpro").removeClass('hide');
            });
            $("#milestoneEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'milestoneEntityTab' && currentTab !== 'milestoneEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'milestoneEntityTab';
                
                $(".change_filter").hide();
                $("#search_MS").show();
                $("#search_MS").removeClass('hide');
            });
            $("#DlvrblEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'DlvrblEntityTab' && currentTab !== 'DlvrblEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'DlvrblEntityTab';
                
                $(".change_filter").hide();
                $("#search_Deliverable").show();
                $("#search_Deliverable").removeClass('hide');
            });
            $("#moduleEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'moduleEntityTab' && currentTab !== 'moduleEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'moduleEntityTab';
                
                $(".change_filter").hide();
                $("#search_Module").show();
                $("#search_Module").removeClass('hide');
            });
            $("#changeReqEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'changeReqEntityTab' && currentTab !== 'changeReqEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'changeReqEntityTab';
                
                $(".change_filter").hide();
                $("#search_chanRequest").show();
                $("#search_chanRequest").removeClass('hide');
            });
            
            $("#LeavesEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'LeavesEntityTab' && currentTab !== 'LeavesEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'LeavesEntityTab';
                
                $(".change_filter").hide();
                $("#search_leave").show();
                $("#search_leave").removeClass('hide');
            });
            
            // Added by Dipali V on 2nd Dec 2025 - Leave filter change event handlers
            // Resource Name textbox - uses generic EntityName mechanism (reloads tab with server-side filter)
            // Modified to filter on keypress instead of Enter, with debouncing for performance
            var leaveResourceNameTimer;
            $("#txtLeaveResourceName").on('keyup input paste', function(e) {
                // Clear previous timer
                clearTimeout(leaveResourceNameTimer);
                
                // Skip if Enter key (let default behavior handle it if needed)
                if (e.keyCode === 13) {
                    e.preventDefault();
                }
                
                // For paste events, wait a bit for the value to be set
                var delay = (e.type === 'paste') ? 10 : 0;
                
                // Debounce: Wait 500ms after user stops typing before filtering
                leaveResourceNameTimer = setTimeout(function() {
                    // Reload tab - ResourceName uses generic EntityName (strEntityName) via currentEntitySearch()
                    // This will send the partial search term to server which should handle LIKE queries
                    if (GtabName && GpageUrl && GTagID) {
                        OpenTab(GtabName, GpageUrl, GTagID);
                    }
                    
                    // Also notify iframe to apply client-side filtering for partial search
                    var iframe = document.getElementById('tabFrame');
                    if (iframe && iframe.contentWindow) {
                        iframe.contentWindow.postMessage({ action: 'applyResourceNameFilter' }, '*');
                    }
                }, delay + 500); // 500ms delay (plus 10ms for paste)
            });
            
            // End of Leave filter event handlers

            // Resource Timesheet uses its own filter section inside the iframe - no parent filter events needed
            
            // Modified to show parent search field matching Leave tab layout - Resource Timesheet filter handling
            $("#ResourceTSEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'ResourceTSEntityTab' && currentTab !== 'ResourceTSEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'ResourceTSEntityTab';

                $(".change_filter").hide();
                $("#search_ResourceTS").show();
                $("#search_ResourceTS").removeClass('hide');
            });

            // Resource Timesheet employee name keyup - mirrors Leave handler exactly:
            // 1) Reload tab via OpenTab (server-side EntityName filter in query string)
            // 2) Also postMessage iframe to re-apply client-side filter from parent DOM value
            var resourceTSNameTimer;
            $("#txtResourceTSName").on('keyup input paste', function(e) {
                clearTimeout(resourceTSNameTimer);
                if (e.keyCode === 13) {
                    e.preventDefault();
                }
                var delay = (e.type === 'paste') ? 10 : 0;
                resourceTSNameTimer = setTimeout(function() {
                    if (GtabName && GpageUrl && GTagID) {
                        OpenTab(GtabName, GpageUrl, GTagID);
                    }
                    var iframe = document.getElementById('tabFrame');
                    if (iframe && iframe.contentWindow) {
                        iframe.contentWindow.postMessage({ action: 'applyResourceTSFilters' }, '*');
                    }
                }, delay + 500);
            });
            // End of Resource Timesheet tab filter handling

            $("#ProjTSEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'ProjTSEntityTab' && currentTab !== 'ProjTSEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'ProjTSEntityTab';
                
                $(".change_filter").hide();
                $("#search_ProjTS").show();
                $("#search_ProjTS").removeClass('hide');
            });
            
            // Fixed by Dipali V on [Date] - Project Timesheet ID search on keypress instead of Enter only
            // Add keyup event handler for Project Timesheet search input to search on keypress
            var projTSSearchTimer = null;
            $(document).on('keyup input paste', '#search_ProjTS input[type="text"]', function(e) {
                clearTimeout(projTSSearchTimer);
                // Skip if Enter key (let default behavior handle it if needed)
                if (e.keyCode === 13) {
                    e.preventDefault();
                }
                // Debounce - search after 500ms of no typing (keypress search)
                projTSSearchTimer = setTimeout(function() {
                    reloadProjectTimesheetData();
                }, 500);
            });
            
            // Function to reload Project Timesheet data with current search value
            function reloadProjectTimesheetData() {
                // Check if Project Timesheet tab is active
                if ($('#ProjTSEntityTab').hasClass('active')) {
                    // Reload the tab with current search value - this will trigger OpenTab with new EntityName
                    OpenTab('ProjTSEntityTab', 'PM_EntityProjectTimesheet.aspx', '42');
                }
            }
            $("#IR_ApprEntityTab").on('click', function () {
                // Clear filter if coming back to the same tab
                if (previousTab === 'IR_ApprEntityTab' && currentTab !== 'IR_ApprEntityTab') {
                    clearFilterTextboxes();
                }
                previousTab = currentTab;
                currentTab = 'IR_ApprEntityTab';
                
                $(".change_filter").hide();
                $("#search_IR").show();
                $("#search_IR").removeClass('hide');
            });

            $('.proj-code').click(function () {
                $(this).siblings('.side-option').show();
            });

            // jquery for popup
            $('#closeFilter').click(function () {
                $('#modalInnerFilterDiv').removeClass('in');
                $('#filterDiv').removeClass('in');
                $('.filter-wrap').removeClass('active');
            });

            $("#filterpanel").on("show.bs.collapse", function () {
                //$(".clearalllink").css("display", "inline-block");
                $(".table").resize();
                // Filters already loaded on page load, just refresh if needed
                //loadTopFilters(true);

            });
            $("#filterpanel").on("hide.bs.collapse", function () {
                var $bu = $('#filterpanel .condt-filter select').eq(0);
                var $ou = $('#filterpanel .condt-filter select').eq(1);
                var $pf = $('#filterpanel .condt-filter select').eq(2);

                // Check if any filter has a non-placeholder value selected
                var buSelected = $bu.length && $bu.prop('selectedIndex') > 0;
                var ouSelected = $ou.length && $ou.prop('selectedIndex') > 0;
                var pfSelected = $pf.length && $pf.prop('selectedIndex') > 0;

                if (buSelected || ouSelected || pfSelected) {
                    $(".clearalllink").css("display", "inline-block");
                } else {
                    $(".clearalllink").hide();
                }
                $(".table").resize();
            });

            

            $(function () {
                $('[data-bs-toggle="tooltip"]').tooltip()
            })
            $(document).on("click", function () {
                $(".tooltip").remove();
            });

       
            $('table').resize();

            $(".collapse").on('show.bs.collapse', function (e) {
                $(".table").resize();
            });
            $(".collapse").on('hidden.bs.collapse', function (e) {
                $(".table").resize();
            });

            // Added by Dipali V on 1st Dec 2025
            // Purpose: Toggle caption text between "Hide" and "Show" when WF_ApprDetailsTab div is collapsed/expanded
            $('#WF_ApprDetailsTab').on('show.bs.collapse', function () {
                $('#showWFApprSecBtn').text('<%= MyBase.GetResourceString("C_HideFliter") %>');
            });
            $('#WF_ApprDetailsTab').on('hide.bs.collapse', function () {
                $('#showWFApprSecBtn').text('<%= MyBase.GetResourceString("C_showFliter") %>');
            });
            // End of Toggle caption - Added by Dipali V on 1st Dec 2025
            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $(".table").resize();
            });



            function resizeSection() {
                var tblheight = $(window).height();
                // $('.dataTables_scrollBody').css({ 'height': tblheight - 210, "overflow-y": "auto" });
                $('#projEntityTable_wrapper .dataTables_scrollbody').css({ 'height': tblheight - 210, "overflow-y": "auto" });
                $('.conversationModel .card').css({ 'height': tblheight - 200 });
                $('.ProTS_grid_panel').css({
                    'height': tblheight - 290,
                    "overflow-y": "auto",
                    "overflow-x": "auto"
                });
                // $('.WF_Card .card').css({'height': tblheight - 250 });
            }
            $(window).on("load resize scroll", function (e) {
                resizeSection(this);
            });



        </script>

        <script type="text/javascript">
            // Added by Dipali V on 06-Oct-2025 (W26): Dynamic bind using usp_Whizible2_Sel_Entities_WFDetails and set tab counts
            var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
            var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
            //For Get All Tabs Counts
            function updateAllTabCounts(flag) {
                const wfCounts = fetchEntityWFCounts(flag);
                if (wfCounts && wfCounts.WFEntityCount[0]) {
                    strAlertType = flag;
                    const counts = wfCounts.WFEntityCount[0];
                    $('#projectEntityTab .badge').text(counts.projectCount);
                    $('#milestoneEntityTab .badge').text(counts.milestoneCount);
                    $('#moduleEntityTab .badge').text(counts.moduleCount);
                    $('#subProjEntityTab .badge').text(counts.subProjectCount);
                    $('#DlvrblEntityTab .badge').text(counts.deliverableCount);
                    $('#changeReqEntityTab .badge').text(counts.changeRequestCount);
                    $('#LeavesEntityTab .badge').text(counts.leaveCount);
                    $('#ProjTSEntityTab .badge').text(counts.projectTimeCount);
                    $('#IR_ApprEntityTab .badge').text(counts.irCount);
                    $('#ResourceTSEntityTab .badge').text(counts.resourceTimesheetCount);  // Added by Dipali V on 5th Dec 2025
                }

            }
            // Get Watchlist Count
            function updateinboxWatclistCount(flag) {
                const wfCounts = fetchEntityWFCounts(flag);
                if (wfCounts && wfCounts.WFEntityCount[0]) {
                    strAlertType = flag;
                    const counts = wfCounts.WFEntityCount[0];
                    $('.watchlistBtn .badge').text(counts.watchlistCount);
                    $('.inboxBtn .badge').text(counts.totalCount);
                }

            }
            // For Load 
            function load(alertType) {
                //debugger;
                try {
                    const isWatch = $('.watchlistBtn').hasClass('active');
                    const strAlertType = isWatch ? 'W' : 'T';
                    var resp = fetchEntityDataForTag(alertType, currentTagID());
                    const rows = Array.isArray(resp) ? resp : (resp && resp.Table) ? resp.Table : resp || [];
                    updateinboxWatclistCount('TW');
                    updateAllTabCounts(strAlertType);
                    //renderListViews(rows);
                    OpenTab('projectEntityTab', 'PM_EntityProjectApproval.aspx', '32')
                } finally {
                    $('[data-bs-toggle="tooltip"]').tooltip();
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
            // For Get Selected Current TagID
            function currentTagID() {
                const $active = $('#AllEntityTab button.nav-link.active');
                if ($active.is('#projectEntityTab')) return 32;
                if ($active.is('#subProjEntityTab')) return 661;
                if ($active.is('#milestoneEntityTab')) return 34;
                if ($active.is('#DlvrblEntityTab')) return 2133;
                if ($active.is('#moduleEntityTab')) return 454;
                if ($active.is('#changeReqEntityTab')) return 1039;
                if ($active.is('#ProjTSEntityTab')) return 42; // PT
                if ($active.is('#LeavesEntityTab')) return 1209; // Leave
                if ($active.is('#IR_ApprEntityTab')) return 2074; // IR
                return 32;
            }
            //For Top Filter selected on Parent page and passed to child page 
            function readTopFilters() {
                //debugger;
                const bu = $('#filterpanel .condt-filter select').eq(0).val();
                const ou = $('#filterpanel .condt-filter select').eq(1).val();
                const pf = $('#filterpanel .condt-filter select').eq(2).val();
                function toIntOrNull(v) { return (v !== undefined && v !== null && v !== '' && !isNaN(v)) ? parseInt(v) : null; }
                return { BusinessUnit: toIntOrNull(bu), OrganizationUnit: toIntOrNull(ou), PendingFrom: toIntOrNull(pf) };
            }

            function currentEntitySearch() {
                const $vis = $('.change_filter:visible input[type="text"]');
                return ($vis.val() || '').trim();
            }


            var StrCountResult = "";
            // fetch workflow entity counts for all tabs
            function fetchEntityWFCounts(flag) {
                const ctx = getContext();
                const filters = readTopFilters();
                const param = {
                    EmployeeID: ctx.EmployeeID,
                    strAlertType: flag,
                    strEntityName: currentEntitySearch(),
                    BusinessUnit: (filters.BusinessUnit === undefined || filters.BusinessUnit === null || filters.BusinessUnit === '' ? '0' : filters.BusinessUnit),
                    OrganizationUnit: (filters.OrganizationUnit === undefined || filters.OrganizationUnit === null || filters.OrganizationUnit === '' ? '0' : filters.OrganizationUnit),
                    PendingFrom: (filters.PendingFrom === undefined || filters.PendingFrom === null || filters.PendingFrom === '' ? '0' : filters.PendingFrom)
                };
                const fullUrl = "api/EntityApproval/GetEntityWFCount";
                const payload = JSON.stringify(param);
                const result = AJAXCallWithResult(fullUrl, payload, false, "POST");
                console.log('Entity workflow counts: ' + JSON.stringify(result));
                StrCountResult = result;
                return result;
            }


            //For Filter Data 
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
                    strEntityName: currentEntitySearch(),
                    BusinessUnit: (filters.BusinessUnit === undefined || filters.BusinessUnit === null || filters.BusinessUnit === '' ? '0' : filters.BusinessUnit),
                    OrganizationUnit: (filters.OrganizationUnit === undefined || filters.OrganizationUnit === null || filters.OrganizationUnit === '' ? '0' : filters.OrganizationUnit),
                    PendingFrom: (filters.PendingFrom === undefined || filters.PendingFrom === null || filters.PendingFrom === '' ? '0' : filters.PendingFrom)
                };
                var fullUrl = "api/EntityApproval/GetEntityWFDetails";
                var payload = JSON.stringify(param);
                var result = AJAXCallWithResult(fullUrl, payload, false, "POST");
                console.log('Search results: ' + JSON.stringify(result));
                StrResult = result;
                return result;
            }

            var TaskType = "0", TaskStatus = "0"
            $(".filterDropdown").change(function () {
                // Read current values of all filters
                TaskType = $("#Module_TaskType").val() || "0";
                TaskStatus = $("#Module_TaskStatus").val() || "0";

            });

            //For Called Child Offcanvas on Parent Page 
            // Store offcanvas instances to manage them properly
            var projectDetailsOffcanvasInstance = null;
            
            // Expose function to close project details offcanvas from iframe
            window.closeProjectDetailsOffcanvas = function() {
                var container = document.getElementById('OffcanvasContainer');
                if (container) {
                    var offcanvasEl = container.querySelector('.offcanvas');
                    if (offcanvasEl) {
                        if (projectDetailsOffcanvasInstance && projectDetailsOffcanvasInstance._element === offcanvasEl) {
                            projectDetailsOffcanvasInstance.hide();
                        } else {
                            var instance = bootstrap.Offcanvas.getInstance(offcanvasEl);
                            if (instance) {
                                instance.hide();
                            } else {
                                try {
                                    var newInstance = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
                                    if (newInstance) {
                                        newInstance.hide();
                                    }
                                } catch (ex) {
                                    console.log('Error closing offcanvas:', ex);
                                }
                            }
                        }
                    }
                }
            };
            
            window.addEventListener("message", (e) => {
                if (!e.data || !e.data.action) return;

                if (e.data.action === "renderOffcanvas") {
                    const container = document.getElementById("OffcanvasContainer");
                    // Inject HTML from iframe
                    container.innerHTML = e.data.html;
                    // Initialize and show offcanvas
                    const offcanvasEl = container.querySelector('.offcanvas');
                    
                    if (!offcanvasEl) {
                        console.error('Offcanvas element not found in container');
                        return;
                    }
                    
                    // Dispose existing instance if any to avoid conflicts
                    if (projectDetailsOffcanvasInstance) {
                        try {
                            // Only dispose if it's still attached to the DOM
                            if (projectDetailsOffcanvasInstance._element && document.contains(projectDetailsOffcanvasInstance._element)) {
                                projectDetailsOffcanvasInstance.dispose();
                            }
                        } catch (ex) {
                            console.log('Error disposing offcanvas:', ex);
                        }
                        projectDetailsOffcanvasInstance = null;
                    }
                    
                    // Also check if there's an existing instance on the element
                    var existingInstance = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    if (existingInstance) {
                        try {
                            existingInstance.dispose();
                        } catch (ex) {
                            console.log('Error disposing existing instance:', ex);
                        }
                    }
                    
                    // Create new instance and store it
                    projectDetailsOffcanvasInstance = new bootstrap.Offcanvas(offcanvasEl);
                    
                    // Added by Dipali V on 18th Dec 2025 - Load IR Line Items after offcanvas is shown
                    // Listen for shown event to load line items when offcanvas is fully displayed
                    if (e.data.rfiID && e.data.rfiID > 0) {
                        offcanvasEl.addEventListener('shown.bs.offcanvas', function onShown() {
                            // Remove listener after first use to avoid multiple calls
                            offcanvasEl.removeEventListener('shown.bs.offcanvas', onShown);
                            
                            // Get the iframe to call the function
                            const iframe = document.querySelector('iframe[name="EntityApprovalFrame"]');
                            if (iframe && iframe.contentWindow) {
                                try {
                                    // Call loadIRLineItems in iframe context for IR
                                    // The function will handle finding elements in parent document
                                    if (typeof iframe.contentWindow.loadIRLineItems === 'function' && e.data.rfiID) {
                                        iframe.contentWindow.loadIRLineItems(e.data.rfiID);
                                    }
                                    // Added by Dipali V on 18th Dec 2025 - Load resource allocation details for Leave
                                    else if (typeof iframe.contentWindow.loadResourceAllocationDetails === 'function' && e.data.employeeID && e.data.leaveID) {
                                        setTimeout(function() {
                                            iframe.contentWindow.loadResourceAllocationDetails(e.data.employeeID, e.data.leaveID);
                                        }, 300);
                                    } else {
                                        // If function not available, try after a short delay
                                        setTimeout(function() {
                                            if (iframe.contentWindow && typeof iframe.contentWindow.loadIRLineItems === 'function') {
                                                iframe.contentWindow.loadIRLineItems(e.data.rfiID);
                                            }
                                        }, 200);
                                    }
                                } catch (error) {
                                    console.error('Error calling loadIRLineItems:', error);
                                }
                            }
                        }, { once: true });
                    }
                    
                    // Added by Dipali V on 18th Dec 2025 - Load Resource Allocation Details for Leave after offcanvas is shown
                    if (e.data.employeeID && e.data.leaveID) {
                        offcanvasEl.addEventListener('shown.bs.offcanvas', function onShownLeave() {
                            // Remove listener after first use to avoid multiple calls
                            offcanvasEl.removeEventListener('shown.bs.offcanvas', onShownLeave);
                            
                            // Get the iframe to call the function
                            const iframe = document.querySelector('iframe[name="EntityApprovalFrame"]');
                            if (iframe && iframe.contentWindow) {
                                try {
                                    // Call loadResourceAllocationDetails in iframe context
                                    if (typeof iframe.contentWindow.loadResourceAllocationDetails === 'function') {
                                        setTimeout(function() {
                                            iframe.contentWindow.loadResourceAllocationDetails(e.data.employeeID, e.data.leaveID);
                                        }, 300);
                                    } else {
                                        // If function not available, try after a short delay
                                        setTimeout(function() {
                                            if (iframe.contentWindow && typeof iframe.contentWindow.loadResourceAllocationDetails === 'function') {
                                                iframe.contentWindow.loadResourceAllocationDetails(e.data.employeeID, e.data.leaveID);
                                            }
                                        }, 500);
                                    }
                                } catch (error) {
                                    console.error('Error calling loadResourceAllocationDetails:', error);
                                }
                            }
                        }, { once: true });
                    }
                    
                    // Added by Dipali V on 24th Dec 2025 - Highlight changed fields for Project revision after offcanvas is shown
                    if (e.data.projectID_PK && e.data.projectID_PK > 0) {
                        console.log("Setting up revision highlighting for projectID_PK:", e.data.projectID_PK);
                        
                        // Function to call getProjectRevisionChanges
                        function callRevisionHighlighting() {
                            console.log("Attempting to call getProjectRevisionChanges...");
                            const iframe = document.querySelector('iframe[name="EntityApprovalFrame"]');
                            if (iframe && iframe.contentWindow) {
                                console.log("Iframe found, checking for function...");
                                try {
                                    if (typeof iframe.contentWindow.getProjectRevisionChanges === 'function') {
                                        console.log("Function found, calling getProjectRevisionChanges with projectID_PK:", e.data.projectID_PK);
                                        iframe.contentWindow.getProjectRevisionChanges(e.data.projectID_PK, 'ProjInfoDetailsTab');
                                    } else {
                                        console.warn("getProjectRevisionChanges function not found in iframe. Available functions:", Object.keys(iframe.contentWindow).filter(k => typeof iframe.contentWindow[k] === 'function'));
                                        // Try after a delay in case function loads later
                                        setTimeout(function() {
                                            if (iframe.contentWindow && typeof iframe.contentWindow.getProjectRevisionChanges === 'function') {
                                                console.log("Function found after delay, calling getProjectRevisionChanges");
                                                iframe.contentWindow.getProjectRevisionChanges(e.data.projectID_PK, 'ProjInfoDetailsTab');
                                            } else {
                                                console.error("getProjectRevisionChanges still not available after delay");
                                            }
                                        }, 500);
                                    }
                                } catch (error) {
                                    console.error('Error calling getProjectRevisionChanges:', error);
                                }
                            } else {
                                console.error("Iframe not found or contentWindow not accessible");
                            }
                        }
                        
                        // Add event listener for when offcanvas is shown
                        offcanvasEl.addEventListener('shown.bs.offcanvas', function onShownProject() {
                            console.log("Offcanvas shown event fired");
                            // Remove listener after first use to avoid multiple calls
                            offcanvasEl.removeEventListener('shown.bs.offcanvas', onShownProject);
                            setTimeout(callRevisionHighlighting, 300);
                        }, { once: true });
                    }
                    
                    projectDetailsOffcanvasInstance.show();
                    // Ensure body scroll is locked while project details offcanvas is open.
                    // Bootstrap sets this on show() but a prior removeOffcanvasBackdrop() call
                    // may have cleared it if checklist had been open before this.
                    document.body.style.overflow = 'hidden';
                    
                    // Also try calling immediately after show (as a fallback)
                    if (e.data.projectID_PK && e.data.projectID_PK > 0) {
                        setTimeout(function() {
                            console.log("Fallback: Calling getProjectRevisionChanges after show()");
                            const iframe = document.querySelector('iframe[name="EntityApprovalFrame"]');
                            if (iframe && iframe.contentWindow && typeof iframe.contentWindow.getProjectRevisionChanges === 'function') {
                                iframe.contentWindow.getProjectRevisionChanges(e.data.projectID_PK, 'ProjInfoDetailsTab');
                            }
                        }, 500);
                    }
                    
                    // Listen for hidden event to clear the instance
                    // Modified by Dipali V on [Date] - Fixed offcanvas not reopening after modal closes
                    // Use regular listener instead of once to handle multiple open/close cycles
                    offcanvasEl.addEventListener('hidden.bs.offcanvas', function() {
                        // Only clear if this is the same instance
                        if (projectDetailsOffcanvasInstance && projectDetailsOffcanvasInstance._element === offcanvasEl) {
                            projectDetailsOffcanvasInstance = null;
                        }
                        // Clear the container HTML to ensure fresh instance on next open
                        const container = document.getElementById("OffcanvasContainer");
                        if (container) {
                            // Don't clear immediately - wait a bit to allow any pending operations
                            setTimeout(function() {
                                if (!projectDetailsOffcanvasInstance) {
                                    container.innerHTML = '';
                                }
                            }, 100);
                        }
                    });
                }
                if (event.data.action === "updateAllTabCounts") {
                    updateAllTabCounts(event.data.value);
                }
            });
            
            // Function to close checklist offcanvas - Added for close button
            // Updated by Dipali V on 18th Dec 2025 - Ensure backdrop is removed when closing
            function closeChecklistOffcanvas() {
                var checklistOffcanvasEl = document.getElementById('checklistOffcanvas');
                if (checklistOffcanvasEl) {
                    var checklistOffcanvasInstance = bootstrap.Offcanvas.getInstance(checklistOffcanvasEl);
                    if (checklistOffcanvasInstance) {
                        checklistOffcanvasInstance.hide();
                    } else {
                        // If no instance, manually remove backdrop (but only if checklist was the only open offcanvas)
                        removeOffcanvasBackdrop('checklistOffcanvas');
                    }
                } else {
                    // If element not found, still try to remove backdrop
                    removeOffcanvasBackdrop('checklistOffcanvas');
                }
            }
            
            // Function to remove offcanvas backdrop - Updated by Dipali V on 18th Dec 2025
            // Make it globally accessible so iframe pages can call it
            window.removeOffcanvasBackdrop = function(excludeOffcanvasId) {
                var excludeId = excludeOffcanvasId || null;
                // Use element reference for exclusion because some dynamically injected offcanvas
                // (e.g. from iframe) may not have an id attribute.
                var excludeEl = excludeId ? document.getElementById(excludeId) : null;

                // If another offcanvas is still open, keep backdrop/body intact.
                // Also remove only the extra backdrops that are likely associated with
                // the excluded offcanvas (common case: checklist opened over project info).
                var openOffcanvasEls = [];
                var offcanvasEls = document.querySelectorAll('.offcanvas');
                offcanvasEls.forEach(function (el) {
                    var isShown = el.classList.contains('show') || el.getAttribute('aria-hidden') === 'false';
                    if (!isShown) return;
                    if (excludeEl && el === excludeEl) return;
                    openOffcanvasEls.push(el);
                });
                var anyOtherOffcanvasOpen = openOffcanvasEls.length > 0;

                if (anyOtherOffcanvasOpen) {
                    // Keep backdrops for the currently-open offcanvas(es) and remove the extras.
                    // We remove from the end (top-most) first to get rid of stale backdrops.
                    var expectedBackdropCount = openOffcanvasEls.length;
                    var backdrops = document.querySelectorAll('.offcanvas-backdrop');
                    if (backdrops && backdrops.length > expectedBackdropCount) {
                        for (var i = backdrops.length - 1; i >= expectedBackdropCount; i--) {
                            backdrops[i].remove();
                        }
                    }

                    document.body.classList.add('offcanvas-open');
                    return;
                }

                // Remove all offcanvas backdrops
                var backdrops = document.querySelectorAll('.offcanvas-backdrop');
                backdrops.forEach(function(backdrop) {
                    backdrop.classList.remove('show', 'fade');
                    backdrop.remove();
                });

                // Also remove modal backdrops that might be lingering
                var modalBackdrops = document.querySelectorAll('.modal-backdrop');
                modalBackdrops.forEach(function(backdrop) {
                    if (backdrop.classList.contains('fade') && backdrop.classList.contains('show')) {
                        backdrop.classList.remove('show', 'fade');
                        backdrop.remove();
                    }
                });

                // Remove body classes that might be causing blur
                document.body.classList.remove('modal-open', 'offcanvas-open');

                // Remove inline styles that might be added
                document.body.style.overflow = '';
                document.body.style.paddingRight = '';
            };

            // Ensures correct visual stacking when multiple offcanvas are open (e.g. Checklist over Project Info).
            // Uses open/show sequence to decide z-index order rather than DOM order.
            var offcanvasStackSeq = 0;
            function applyOffcanvasStacking() {
                var openOffcanvasEls = [];
                var offcanvasEls = document.querySelectorAll('.offcanvas');
                offcanvasEls.forEach(function (el) {
                    var isShown = el.classList.contains('show') || el.getAttribute('aria-hidden') === 'false';
                    if (!isShown) return;
                    openOffcanvasEls.push(el);
                });

                if (openOffcanvasEls.length === 0) return;

                // Sort by last "shown" sequence so the top-most panel gets the highest z-index.
                openOffcanvasEls.sort(function (a, b) {
                    var ao = parseInt((a.dataset && a.dataset.offcanvasStackOrder) ? a.dataset.offcanvasStackOrder : '0', 10);
                    var bo = parseInt((b.dataset && b.dataset.offcanvasStackOrder) ? b.dataset.offcanvasStackOrder : '0', 10);
                    return ao - bo;
                });

                // Base z-index values (Bootstrap-like). Keep backdrops slightly lower than their offcanvas panel.
                var baseZ = 1050;
                openOffcanvasEls.forEach(function (el, idx) {
                    el.style.zIndex = String(baseZ + (idx * 10));
                });

                // Backdrops: map the last N backdrops to the last N open offcanvas panels.
                var backdrops = document.querySelectorAll('.offcanvas-backdrop');
                var bdArr = Array.prototype.slice.call(backdrops);
                var expectedBackdropCount = openOffcanvasEls.length;
                if (bdArr.length >= expectedBackdropCount) {
                    var relevantBds = bdArr.slice(bdArr.length - expectedBackdropCount);
                    relevantBds.forEach(function (bd, idx) {
                        bd.style.zIndex = String(baseZ + (idx * 10) - 1);
                    });
                }
            }

            // Update stacking order whenever offcanvas is shown/hidden.
            document.addEventListener('shown.bs.offcanvas', function (e) {
                var el = e && e.target;
                if (!el || !el.classList || !el.classList.contains('offcanvas')) return;
                offcanvasStackSeq++;
                if (el.dataset) el.dataset.offcanvasStackOrder = String(offcanvasStackSeq);
                applyOffcanvasStacking();
            }, true);

            document.addEventListener('hidden.bs.offcanvas', function () {
                // Re-apply after Bootstrap finishes hiding/removing elements.
                setTimeout(function () {
                    applyOffcanvasStacking();
                }, 50);
            }, true);

            // Ensure checklist offcanvas closing doesn't affect project details offcanvas
            // Listen for checklist offcanvas close events - Updated by Dipali V on 18th Dec 2025
            $(document).ready(function() {
                var checklistOffcanvasEl = document.getElementById('checklistOffcanvas');
                if (checklistOffcanvasEl) {
                    // Listen for when offcanvas is fully hidden
                    checklistOffcanvasEl.addEventListener('hidden.bs.offcanvas', function() {
                        // Remove backdrop only if checklist was the only open offcanvas
                        removeOffcanvasBackdrop('checklistOffcanvas');
                        // When checklist closes, ensure project details offcanvas can still be opened
                        // The project details offcanvas should remain functional
                    });
                }
                
                // Added by Dipali V on 24th Dec 2025 - Purpose: Ensure close button works for projShowStatusOffcanvas
                // Use event delegation to handle close button clicks dynamically
                $(document).on('click', '#projShowStatusOffcanvas .btn-close', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    var projShowStatusOffcanvasEl = document.getElementById('projShowStatusOffcanvas');
                    if (!projShowStatusOffcanvasEl) return;
                    
                    // Try to get existing instance
                    var offcanvasInstance = bootstrap.Offcanvas.getInstance(projShowStatusOffcanvasEl);
                    if (offcanvasInstance) {
                        offcanvasInstance.hide();
                    } else {
                        // If no instance exists, try to get or create one and hide it
                        try {
                            var instance = bootstrap.Offcanvas.getOrCreateInstance(projShowStatusOffcanvasEl);
                            if (instance) {
                                instance.hide();
                            }
                        } catch (ex) {
                            console.error('Error closing offcanvas:', ex);
                            // Fallback: manually hide by removing classes and backdrop
                            projShowStatusOffcanvasEl.classList.remove('show');
                            document.body.classList.remove('offcanvas-open');
                            var backdrop = document.querySelector('.offcanvas-backdrop');
                            if (backdrop) {
                                backdrop.remove();
                            }
                        }
                    }
                });
            });
            
            // Added by Dipali V on 24th Dec 2025 - Purpose: Function to close projShowStatusOffcanvas (called from onclick handler)
            function closeProjShowStatusOffcanvas() {
                var projShowStatusOffcanvasEl = document.getElementById('projShowStatusOffcanvas');
                if (!projShowStatusOffcanvasEl) return;
                
                // Try to get existing instance
                var offcanvasInstance = bootstrap.Offcanvas.getInstance(projShowStatusOffcanvasEl);
                if (offcanvasInstance) {
                    offcanvasInstance.hide();
                } else {
                    // If no instance exists, try to get or create one and hide it
                    try {
                        var instance = bootstrap.Offcanvas.getOrCreateInstance(projShowStatusOffcanvasEl);
                        if (instance) {
                            instance.hide();
                        }
                    } catch (ex) {
                        console.error('Error closing offcanvas:', ex);
                        // Fallback: manually hide by removing classes and backdrop
                        projShowStatusOffcanvasEl.classList.remove('show');
                        document.body.classList.remove('offcanvas-open');
                        var backdrop = document.querySelector('.offcanvas-backdrop');
                        if (backdrop) {
                            backdrop.remove();
                        }
                    }
                }
            }

            // Optional: Allow parent to call iframe functions if needed
            function callIframeFunction(funcName, Action, FromWhere, TimesheetNo) {
                const iframe = document.getElementById('tabFrame'); // replace with your iframe ID
                if (iframe && iframe.contentWindow && iframe.contentWindow[funcName]) {
                    iframe.contentWindow[funcName](Action, FromWhere, TimesheetNo);
                } else {
                    console.error(`Function ${funcName} not found in iframe`);
                }
            }
            // Optional: Allow parent to call iframe functions if needed
            function callIframeFunctionWBS(funcName, flagCode, flagName, StageID, WFID, TagID, ProjectID) {
                const iframe = document.getElementById('tabFrame'); // replace with your iframe ID
                if (iframe && iframe.contentWindow && iframe.contentWindow[funcName]) {
                    iframe.contentWindow[funcName](flagCode, flagName, StageID, WFID, TagID, ProjectID);
                } else {
                    console.error(`Function ${funcName} not found in iframe`);
                }
            }
            // Optional: Allow parent to call iframe functions if needed
            function callIframeFunctionWorkflowDewtails(funcName, UniQueID, entityTypeID) {
                const iframe = document.getElementById('tabFrame'); // replace with your iframe ID
                if (iframe && iframe.contentWindow && iframe.contentWindow[funcName]) {
                    iframe.contentWindow[funcName](UniQueID, entityTypeID);
                } else {
                    console.error(`Function ${funcName} not found in iframe`);
                }
            }
            function callIframeFunctionPT(funcName, Action, FromWhere, UniQueID) {
                const iframe = document.getElementById('tabFrame'); // replace with your iframe ID
                if (iframe && iframe.contentWindow && iframe.contentWindow[funcName]) {
                    iframe.contentWindow[funcName](Action, FromWhere, UniQueID);
                } else {
                    console.error(`Function ${funcName} not found in iframe`);
                }
            }

            

            // Load top filter dropdowns using API Usp_Whizible2_EntityGetFilterData
            // Modified by Dipali V on 1st Dec 2025
            // Purpose: Added setDefaultToday parameter to set "Today" as default selection for Pending From filter on page load
            var filtersLoaded = false; // Flag to track if filters are already loaded - Added by Dipali V on 1st Dec 2025
            // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
            function loadTopFilters(setDefaultToday) {
                // Skip reloading if filters already loaded (preserve user selection) - Added by Dipali V on 1st Dec 2025
                if (filtersLoaded && !setDefaultToday) return;
                
                try {
                    var ds = AJAXCallWithResult("api/EntityApproval/GetEntityFilterData", null, false, "POST");
                    
                    var tables = ds && (ds.Tables || ds.tables);
                    // Support multiple shapes: DataSet.Tables[0..2] OR flat props Table0/Table01/Table02
                    var t0 = tables ? (tables[0] || []) : (ds.Table0 || ds.table0 || []);
                    var t1 = tables ? (tables[1] || []) : (ds.Table01 || ds.table01 || ds.Table1 || []);
                    var t2 = tables ? (tables[2] || []) : (ds.Table02 || ds.table02 || ds.Table2 || []);

                    var $bu = $('#filterpanel .condt-filter select').eq(0);
                    var $ou = $('#filterpanel .condt-filter select').eq(1);
                    var $pf = $('#filterpanel .condt-filter select').eq(2);

                    function bindSelect($sel, rows, valueField, textField) {
                        if (!$sel.length) return;
                        $sel.empty();
                        (rows || []).forEach(function (r) {
                            var val = r[valueField];
                            var txt = r[textField];
                            var opt = $('<option/>').attr('value', val).text(txt);
                            $sel.append(opt);
                        });
                        if ($sel.hasClass('selectpicker')) { $sel.selectpicker('render').selectpicker('refresh'); }
                    }

                    bindSelect($bu, t0, 'BusinessGroupID', 'BusinessGroup');
                    bindSelect($ou, t1, 'OUPoolID', 'Location');
                    bindSelect($pf, t2, 'PeriodFilterID', 'PeriodFilterName');

                    // Added by Dipali V on 1st Dec 2025
                    // Purpose: Set default "Today" filter for Pending From dropdown on page load
                    if (setDefaultToday && $pf.length) {
                        // Find and select "Today" option (case-insensitive match)
                        var todayOption = $pf.find('option').filter(function() {
                            return $(this).text().toLowerCase() === 'today';
                        });
                        if (todayOption.length) {
                            $pf.val(todayOption.val());
                            if ($pf.hasClass('selectpicker')) { 
                                $pf.selectpicker('render').selectpicker('refresh'); 
                            }
                            // Show Clear All link since Today filter is applied
                            updateClearAllVisibility();
                        }
                    }
                    // End of default Today filter - Added by Dipali V on 1st Dec 2025
                    filtersLoaded = true; // Mark filters as loaded
                } catch (e) {
                    console.log('Filter loading error:', e);
                    alertify.error('Failed to load filters');
                }
            }

            // Added by Dipali V on 1st Dec 2025
            // Purpose: Show/Hide Clear All link based on filter selection - if any filter is selected show link, else hide
            function updateClearAllVisibility() {
                var $bu = $('#filterpanel .condt-filter select').eq(0);
                var $ou = $('#filterpanel .condt-filter select').eq(1);
                var $pf = $('#filterpanel .condt-filter select').eq(2);
                
                // Check if any filter has a non-placeholder value selected
                var buSelected = $bu.length && $bu.prop('selectedIndex') > 0;
                var ouSelected = $ou.length && $ou.prop('selectedIndex') > 0;
                var pfSelected = $pf.length && $pf.prop('selectedIndex') > 0;
                
                if (buSelected || ouSelected || pfSelected) {
                    $(".clearalllink").css("display", "inline-block");
                } else {
                    $(".clearalllink").hide();
                }
            }
            // End of updateClearAllVisibility - Added by Dipali V on 1st Dec 2025

            // For Clear all filters and reset placeholders
            function clearAllFilters() {
                var $bu = $('#filterpanel .condt-filter select').eq(0);
                var $ou = $('#filterpanel .condt-filter select').eq(1);
                var $pf = $('#filterpanel .condt-filter select').eq(2);
                [$bu, $ou, $pf].forEach(function ($sel) {
                    if ($sel.length) {
                        // reset to first option (placeholder) and refresh
                        $sel.prop('selectedIndex', 0);
                        if ($sel.hasClass('selectpicker')) { $sel.selectpicker('render').selectpicker('refresh'); }
                    }
                });
                // clear all search inputs
                $('.change_filter input[type="text"]').val('');
                const isWatch = $('.watchlistBtn').hasClass('active');
                updateAllTabCounts(isWatch ? 'W' : 'T');
                load(isWatch ? 'W' : 'T');
                OpenTab(GtabName, GpageUrl, GTagID);
                // Hide Clear All link after clearing filters - Modified by Dipali V on 1st Dec 2025
                updateClearAllVisibility();
                $(".table").resize();
                $("#AdvanceFilterIcon").removeAttr('aria-expanded', '');
            }

            //For Get data W.R.T Inbox and watchlist
            $('.watchlistBtn').on('click', function () {
                strAlertType = 'W';
                updateAllTabCounts(strAlertType)
                OpenTab(GtabName, GpageUrl, GTagID);
            });
            //For Get data W.R.T Inbox and watchlist
            $('.inboxBtn').on('click', function () {
                strAlertType = 'T';
                updateAllTabCounts(strAlertType)
                OpenTab(GtabName, GpageUrl, GTagID);
            });

            // For Filter Data 
            // Modified by Dipali V on 1st Dec 2025 - Call updateClearAllVisibility to show/hide Clear All link based on selection
            $('#filterpanel .selectpicker').on('changed.bs.select', function () {
                $("#AdvanceFilterIcon").attr('aria-expanded', 'true');
                updateClearAllVisibility(); // Show/hide Clear All link based on filter selection
                const isWatch = $('.watchlistBtn').hasClass('active');
                updateAllTabCounts(isWatch ? 'W' : 'T');
                load(isWatch ? 'W' : 'T');
                OpenTab(GtabName, GpageUrl, GTagID);
            });

            //For Filter data from textbox of each tab - Modified to work on keypress with debouncing
            // This handles: Project, Sub Project, Milestone, Deliverable, Module, Change Request, IR
            // Note: Leave and Project Timesheet have their own specific handlers
            var entityFilterTimer = null;
            $(document).on('keyup input paste', '.change_filter input[type="text"]', function(e) {
                // Skip if this is Leave Resource Name, Resource Timesheet, or Project Timesheet (they have their own handlers)
                var $input = $(this);
                if ($input.closest('#search_leave').length || $input.closest('#search_ResourceTS').length || $input.closest('#search_ProjTS').length) {
                    return; // Let their specific handlers take care of it
                }
                
                // Clear previous timer
                clearTimeout(entityFilterTimer);
                
                // Skip if Enter key (let default behavior handle it if needed)
                if (e.keyCode === 13) {
                    e.preventDefault();
                }
                
                // Debounce: Wait 500ms after user stops typing before filtering
                entityFilterTimer = setTimeout(function() {
                    const isWatch = $('.watchlistBtn').hasClass('active');
                    updateAllTabCounts(isWatch ? 'W' : 'T');
                    //load(isWatch ? 'W' : 'T');
                    OpenTab(GtabName, GpageUrl, GTagID);
                }, 500); // 500ms delay
            });

            // For Hide page loader and fade in content after everything loads
            function hidePageLoader() {
                setTimeout(function () {
                    $('#pageLoader').fadeOut(400, function () {
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

            //For Ajax Call
            function AJAXCallWithResult(url, param, async, type) {
                var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
                //debugger;
                var result = null;
                var fullUrl = API_BASE + url;
                // Normalize body: ensure we post the same string we encrypt
                var body = (typeof param === "string") ? param : JSON.stringify(param);

                $.ajax({
                    url: fullUrl,
                    type: type || "GET",
                    data: body,
                    async: async,
                    dataType: "json",
                    contentType: (type === "GET") ? "application/x-www-form-urlencoded" : "application/json;charset=utf-8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                        if (body) {
                            xhr.setRequestHeader("Params", encryptString(body));
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
                            alertify.notify('<%=MyBase.GetResourceString("A_AuthenticationFailed")%>', 'error', 5);
                        } else {
                            console.error('AJAX Error:', error, xhr.responseText);
                            // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                        }
                    }
                })
                return result;
            }



            //For Data Passed from Parent to Child Page 
            var GtabName = "";
            var GpageUrl = "";
            var GTagID = "";
            var CTagID = "";
            function OpenTab(tabName, pageUrl, TagID) {
                GtabName = tabName;
                GpageUrl = pageUrl;
                GTagID = TagID;
                CTagID = TagID;
                const filters = readTopFilters();
                const strEntityName = currentEntitySearch();
                const BusinessUnit = filters.BusinessUnit || '0';
                const OrganizationUnit = filters.OrganizationUnit || '0';
                const PendingFrom = filters.PendingFrom || '0';
                const project = filters.Project || '0';
                const employee = filters.Employee || '0';
                const fromDate = filters.FromDate || '';
                const toDate = filters.ToDate || '';
                const FilterIW = strAlertType || 'T';
                CTagID = CTagID || '32';
                const queryString =
                    `?project=${encodeURIComponent(project)}` +
                    `&employee=${encodeURIComponent(employee)}` +
                    `&from=${encodeURIComponent(fromDate)}` +
                    `&to=${encodeURIComponent(toDate)}` +
                    `&BusinessUnit=${encodeURIComponent(BusinessUnit)}` +
                    `&OrganizationUnit=${encodeURIComponent(OrganizationUnit)}` +
                    `&PendingFrom=${encodeURIComponent(PendingFrom)}` +
                    `&EntityName=${encodeURIComponent(strEntityName)}` +
                    `&FilterIW=${encodeURIComponent(strAlertType)}` +
                    `&CTagID=${encodeURIComponent(CTagID)}`;
                $("#tabFrame").attr("src", pageUrl + queryString);

                // 🔹 Change iframe height based on tab
                if (tabName === "projectEntityTab") {
                    $("#tabFrame").height("450px");
                } else if(tabName === "subProjEntityTab") {
                    $("#tabFrame").height("450px");
                } else if (tabName === "milestoneEntityTab") {
                    $("#tabFrame").height("450px");
                } else if (tabName === "DlvrblEntityTab") {
                    $("#tabFrame").height("450px");
                } else if (tabName === "moduleEntityTab") {
                    $("#tabFrame").height("450px");
                } else if (tabName === "LeavesEntityTab") {
                    $("#tabFrame").height("375px");
                } else if (tabName === "ResourceTSEntityTab") {
                    $("#tabFrame").height("475px");
                } else if (tabName === "ProjTSEntityTab") {
                    $("#tabFrame").height("375px");
                } else if (tabName === "IR_ApprEntityTab") {
                    $("#tabFrame").height("375px");
                } 

                $(".nav-link").removeClass("active");
                $("#" + tabName).addClass("active");
            }



        </script>
    </div>
    <!-- Close main-content-wrapper -->
        </div>
</body>

</html>
