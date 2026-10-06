<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_SkillRequestApprovals.aspx.vb" Inherits="Whizible.HR_SkillRequestApprovals" %>
<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Resource")%>

<head>

    <%-- Same head structure as RM_EmployeeMaster.aspx --%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2" />--%>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

</head>

<style type="text/css">
    /* Added by Dipali V On 30th April 2026 — match PM_BulkExtensionApproval.aspx h5.pgtitle */
    .panel-default > .panel-heading {
        color: #333;
        background-color: #f5f5f5;
        border-color: #ddd;
    }

    .skill-approval-page-header h5.pgtitle {
        margin: 0;
        font-weight: 700;
        color: #4263c1;
        font-size: 14px;
    }
    .skill-approval-page-header .pgtitle i {
        color: #1e40af;
        font-size: 1.5rem;
        margin-right: 0.75rem;
        vertical-align: middle;
    }
    .skill-approval-page-header .approver-line {
        font-size: 11.5px;
        color: #6b7280;
        margin: 6px 0 0 0;
    }
    .skill-approval-page-header {
        flex-shrink: 0;
    }
    /*
     * Count tiles + Pending Requests bar stay fixed: AdminLTE .wrapper { overflow:hidden }
     * breaks position:sticky on window scroll, so we use a flex column + inner scroll instead.
     */
    .skill-approvals-page-layout {
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        height: 100vh;
        max-height: 100vh;
        min-height: 0;
        overflow: hidden;
    }
    .skill-approval-sticky-wrap {
        flex-shrink: 0;
        z-index: 1010;
        background: #fff;
        box-shadow: 0 2px 8px rgba(15, 23, 42, 0.08);
        border-bottom: 1px solid #e3e6ea;
    }
    .skill-approval-main-scroll {
        flex: 1 1 auto;
        min-height: 0;
        overflow-x: hidden;
        overflow-y: auto;
        -webkit-overflow-scrolling: touch;
    }
    .skill-approval-sticky-wrap .sticky-inner-stats {
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .skill-approval-sticky-wrap .sticky-inner-filter {
        padding-bottom: 10px;
    }
    /* Pending Requests label: keep clock icon tight to caption (narrow column, minimal gap). */
    .skill-pending-filter-caption {
        gap: 2px;
        flex-wrap: nowrap;
        white-space: nowrap;
    }
    .skill-pending-filter-caption .fa-clock {
        margin: 0;
        padding: 0;
        line-height: 1;
    }
    /* Keep Filter / Reset beside All Skills dropdown (not pushed to far right of row). */
    .skill-approval-filter-actions {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 8px;
    }
    .skill-approval-filter-actions .skill-filter-skill-select {
        flex: 1 1 160px;
        min-width: 140px;
        max-width: 280px;
    }
    .skill-approval-filter-actions .btn {
        flex-shrink: 0;
        white-space: nowrap;
    }
    #singleSkillActionModal .modal-header {
        justify-content: center;
        position: relative;
    }
    #singleSkillActionModal .modal-header .btn-close {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
    }
    #singleSkillActionModal .modal-title {
        width: 100%;
        text-align: center;
    }
    .tooltip .tooltip-inner {
        font-size: 11px !important;
    }
    /* ----- Page-local tweaks (mirrors EmployeeMaster style) ----- */
    .stat-card {
        background: #fff;
        border: 1px solid #e3e6ea;
        border-radius: 6px;
        padding: 12px 15px;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .modal-title {
        font-size: 11.5px;
    }
    .content-wrapper, .right-side, .main-footer {
        margin-left: 0px!important;
    }
    .stat-card .stat-icon {
        width: 38px; height: 38px; border-radius: 8px;
        display: flex; align-items: center; justify-content: center;
        font-size: 16px;
    }
    .stat-card .stat-num   { font-size: 20px; font-weight: 600; line-height: 1; }
    .stat-card .stat-label { font-size: 12px; color: #6c757d; }

    .icon-blue   { background:#e8f0fe; color:#1a73e8; }
    .icon-orange { background:#fff4e0; color:#f0ad4e; }
    .icon-green  { background:#e6f4ea; color:#28a745; }
    .icon-red    { background:#fdecea; color:#dc3545; }

    /*.approver-card { border:1px solid #e3e6ea; border-radius:6px; margin-bottom:12px; background:#fff; }*/
    .approver-card {
    border: 1px solid #e3e6ea;
    border-radius: 6px;
    margin-bottom: 12px;
    background: hsl(0 0% 100%);
    border-left-color: hsl(32 95% 50%);
    border-left-width: 4px;
    /* border-width: 1px; */
    /*border-radius: calc(var(--radius) - 2px);*/
}
    .approver-card .approver-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 15px;
    border-bottom: 1px solid #e3e6ea;
    /* border-left: 4px solid #f0ad4e; */
    padding-top: .75rem;
    padding-bottom: .75rem;
    background: hsl(210deg 40% 96% / 80%);
}
    .approver-card.is-approved .approver-head { border-left-color:#28a745; background:#f3faf5; }
    .approver-card.is-rejected .approver-head { border-left-color:#dc3545; background:#fdf3f3; }

    .emp-avatar {
        width:38px; height:38px; border-radius:50%; color:#fff;
        background:#1a73e8; display:inline-flex; align-items:center; justify-content:center;
        font-weight:600; font-size:14px; margin-right:10px;
    }
    .emp-name  { font-weight:600; color:#1a73e8; font-size:14px; }
    .emp-meta  { font-size:11.5px; color:#6c757d; }

    .skill-chip {
        display:inline-flex; align-items:center; gap:6px;
        background:hsl(210deg 40% 96% / 40%); border:1px solid #e3e6ea; border-radius:14px;
        padding:3px 10px; margin:2px 4px 2px 0; font-size:12px;
    }
    .pt-1 {
    padding-top: 10px !important;
    margin-left: 14px!important;
}
    .skill-chip a { color:#1a73e8; font-weight:600; }
    .skill-chip .star { color:#28a745; }
    .approver-expand-panel { display:none; padding:0 12px 10px 12px; }
    .pending-skill-table-wrap {
        margin-top:6px;
        border:1px solid #e8edf3;
        border-radius:10px;
        overflow:hidden;
        background:#fff;
        box-shadow: 0 1px 3px rgba(17, 24, 39, 0.06);
    }
    .pending-skill-table { width:100%; border-collapse:collapse; margin-top:0; }
    .pending-skill-table th {
        background:#f7f9fc; color:#4b5563; font-size:11px; font-weight:600;
        border:1px solid #e8edf3; padding:7px 10px; text-transform:uppercase;
    }
    .pending-skill-table th { text-transform:none; }
    .pending-skill-table td {
        border:1px solid #eef2f7; padding:7px 10px; font-size:12px; color:#1f2937;
    }
    .pending-skill-action {
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }
    .pending-skill-action .act {
        cursor: pointer;
        font-size: 13px;
    }
    .pending-skill-action .act.approve { color: #1d7a39; }
    .pending-skill-action .act.reject { color: #c62828; }
    .pending-skill-table tbody tr:nth-child(odd) { background:#ffffff; }
    .pending-skill-table tbody tr:nth-child(even) { background:#f8fafc; }
    .pending-skill-table td:first-child { color:#1a73e8; font-weight:600; }
    .pending-skill-name { color:#1a73e8 !important; font-weight:600 !important; }
    .skill-type-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        font-size: 10px;
        font-weight: 700;
        color: #ffffff;
        margin-right: 6px;
        vertical-align: middle;
    }
    .skill-type-new { background: #9f7aea; }
    .skill-type-updated { background: #f59e0b; }
    .skill-type-badge i { font-size: 9px; }
    #skillHistoryApprovalOffcanvas .table { margin-bottom: 0; }
    #skillHistoryApprovalOffcanvas .offcanvas-body { font-size: 12px; }
    .skill-chip .skill-name { color:#1a73e8; font-weight:600; }
   .employee-remarks-box {
    margin-top: 8px;
    border: 1px solid hsl(214 32% 91%);
    border-radius: 4px;
    background: hsl(214deg 100% 97% / 30%);
    padding: 7px 10px;
    font-size: 12px;
    color: #374151;
}
    .employee-remarks-box strong { color:#111827; font-weight:600; }
    .employee-remarks-content {
        white-space: pre-line;
        margin-top: 4px;
    }
    .proc-request-link { color:#1a73e8; font-weight:600; text-decoration:none; }
    .proc-request-link:hover { color:#1558b0; text-decoration:underline; }
    .proc-skill-count {
        display:inline-flex; align-items:center; justify-content:center;
        min-width:20px; height:20px; border-radius:999px;
        background:#e8f0fe; color:#1a73e8; font-size:11px; font-weight:600;
        border:1px solid #c7dafc;
    }
    .proc-status-pill {
        display:inline-flex; align-items:center; gap:5px;
        padding:2px 10px; border-radius:999px; font-size:11px; font-weight:600;
        border:1px solid transparent;
    }
    .proc-status-pill.approved { color:#1d7a39; background:#e8f7ed; border-color:#93d6a9; }
    .proc-status-pill.rejected { color:#c62828; background:#fdeaea; border-color:#ef9a9a; }
    .proc-status-pill i { font-size:10px; }
.proc-cell-truncate {
    display: inline-block;
    max-width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    vertical-align: middle;
}
.proc-cell-remarks {
    max-width: 340px;
}
    .processed-skill-table-wrap {
        border:1px solid #e8edf3; border-radius:10px; overflow:hidden; background:#fff;
        box-shadow: 0 1px 3px rgba(17, 24, 39, 0.06);
    }
    .processed-skill-table { width:100%; border-collapse:collapse; }
    .processed-skill-table th {
        background:#f7f9fc; color:#4b5563; font-size:11px; font-weight:600;
        border:1px solid #e8edf3; padding:7px 10px; text-transform:uppercase;
    }
    .processed-skill-table th { text-transform:none; }
    .processed-skill-table td {
        border:1px solid #eef2f7; padding:7px 10px; font-size:12px; color:#1f2937;
    }
    .processed-skill-table tbody tr:nth-child(odd) { background:#ffffff; }
    /*.processed-skill-table tbody tr:nth-child(even) { background:#f8fafc; }*/
    .processed-skill-table .skill-name { color:#1a73e8; font-weight:600; }

    .approver-actions { padding:10px 15px; display:flex; gap:8px; align-items:center; }
    .approver-actions input.form-control { flex:1; }
    .approver-actions textarea.form-control { flex:1; min-height:50Px; resize:vertical; }
    .loader-overlay {
        position: fixed; inset: 0; background: rgba(255,255,255,.7); z-index: 9999;
        display: none; align-items: center; justify-content: center;
    }
    .loader-overlay .loader {
        width: 42px; height: 42px; border: 4px solid #e5e7eb; border-top-color: #1a73e8;
        border-radius: 50%; animation: spin .8s linear infinite;
    }
    @keyframes spin { to { transform: rotate(360deg); } }

    /* Fullscreen loader overlay */
    .loader-overlay {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        width: 100%; height: 100%;
        background-color: transparent;
        z-index: 2000;
    }
    /* Centered loader GIF */
    .loader-overlay .loader {
        position: absolute;
        top: 50%; left: 50%;
        width: 100px; height: 100px;
        margin: -50px 0 0 -50px;
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    }
    /* Initial page-load preloader */
    .preloader {
        position: fixed;
        top: 50%; left: 50%;
        width: 100px; height: 100px;
        margin: -50px 0 0 -50px;
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        z-index: 2100;
    }


    /* Navbar clearance: beat generic #divcontent padding from other rules on this page */
    /*#divcontent.skill-approvals-page-layout {*/
    #divcontent {
        padding-top: 6px !important;
    }
    @media (max-width: 767px) {
        body.fixed #divcontent.skill-approvals-page-layout {
            padding-top: 100px !important;
        }
    }

    #divcontent:not(.skill-approvals-page-layout) {
        padding-top: 3px !important;
    }

    .text-warning {
    color: hsl(var(--warning))!important;
}
    #lblPendingCount {
        COLOR: #f0ad4e;
    }
    #lblApprovedCount
    {
        COLOR: #28a745;
    }
    /* Added by Dipali V on 8th May 2026 - Purpose:-Keep alert notifications visible above confirmation modal popup/backdrop. */
    .alertify-notifier,
    .alertify .ajs-notifier {
        z-index: 11000 !important;
    }
    .alertify .ajs-message {
        z-index: 11001 !important;
    }
    .alertify .ajs-dimmer,
    .alertify .ajs-modal {
        z-index: 10990 !important;
    }
    #lblRejectedCount
    {
        COLOR: #dc3545;
    }
    .skill-status-pill.pending {
    color: #c96f00;
    background: #fff2df;
    border-color: #f2c386;
}
    .rounded-full {
    border-radius: 9999px;
}

.gap-1 {
    gap: .25rem;
}
    #skillHistoryApprovalOffcanvas {
        width:800px;
    }
    /* Added by Dipali V on 11th May 2026 — history offcanvas filters (align with My Profile skill history). */
    #skillHistoryApprovalOffcanvas .skill-history-approval-filters .form-label {
        font-size: 11.5px;
        font-weight: 600;
        color: #374151;
        margin-bottom: 4px;
    }
    #skillHistoryApprovalOffcanvas .skill-history-approval-filters select {
        font-size: 12px;
    }
    .bootstrap-select .dropdown-menu li.active a {
        background-color: #e9ecef !important;
        color: #212529 !important;
    }
    select.selectpicker.bs-select-hidden {
        display: none !important;
    }
   /* #skillHistoryApprovalOffcanvas .bootstrap-select {
        width: 100% !important;
    }*/
    #skillHistoryFieldFilterContainer,
    #skillHistoryModifiedByFilterContainer {
        position: relative;
    }
    #skillHistoryApprovalOffcanvas .bootstrap-select .dropdown-menu {
        z-index: 2005 !important;
    }
    #skillHistoryApprovalOffcanvas .skill-history-approval-filters .bootstrap-select > .dropdown-menu {
        width: 100% !important;
        min-width: 100% !important;
        max-width: 100% !important;
    }
    .skill-approval-filter-actions .bootstrap-select {
        width: 220px !important;
    }
#tblProcessedRequests > thead > tr > th {
    background: hsl(214deg 25.3% 92.24%);
    color: black;
    word-wrap: break-word;
    padding-top: 14px;
    padding-bottom: 12px;
    text-align: center;
    border: none;
    font-weight: 100;
    font-size: 11.5px;
}

#tblProcessedRequests .processed-skill-table thead th {
    background: hsl(210 40% 96%)!important;
    color: black;
    word-wrap: break-word;
    padding-top: 14px;
    padding-bottom: 12px;
    text-align: center;
    border: none;
    font-weight: 100;
    font-size: 11.5px;
}
#processedPaginationContainer,
#pendingPaginationContainer {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    flex-wrap: nowrap;
}
#processedPaginationContainer > div,
#pendingPaginationContainer > div {
    display: flex;
    align-items: center;
}
#processedTotalRecords,
#pendingTotalRecords {
    white-space: nowrap;
}
#processedFirstPageBtn:disabled,
#processedLastPageBtn:disabled,
#pendingFirstPageBtn:disabled,
#pendingLastPageBtn:disabled {
    cursor: not-allowed !important;
    opacity: 0.5;
    color: #9ca3af !important;
    border-color: #e5e7eb !important;
}
       /* Header */

.pending-skill-table tr th:nth-child(3),
.pending-skill-table tr th:nth-child(4),
.pending-skill-table tr th:nth-child(5),
.pending-skill-table tr th:nth-child(6),
.pending-skill-table tr th:nth-child(7) {
    text-align: center;
}

/* Body */

.pending-skill-table tr td:nth-child(3),
.pending-skill-table tr td:nth-child(4), 
.pending-skill-table tr td:nth-child(5),
.pending-skill-table tr td:nth-child(6),
.pending-skill-table tr td:nth-child(7) {
    text-align: center;
}
    #tbodyProcessedRequests {
            background-color: hsl(214deg 100% 97% / 40%);
    }
</style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <!-- Page Loader -->
     <div id="MyLeavesSec" class="preloader"></div>
<div class="loader-overlay" id="loaderOverlay" style="display: none;">
    <div class="loader"></div>
</div>


    <div class="" id="body-skReqApprovals"></div>
    <% If m_blnViewAccess Then %>
    <div class="wrapper">
        <div class="content-wrapper bgwhite skill-approvals-page-layout" id="divcontent">

            <!-- ============= Page header (same pattern as PM_BulkExtensionApproval.aspx) ============= -->
            <div class="container-fluid py-2 graybg skill-approval-page-header">
                <h5 class="pgtitle">
                    <i class="fas fa-user-check" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_SkillRequestApprovals")%>"></i>
                    <%=MyBase.GetResourceString("C_SkillRequestApprovals")%>
                </h5>
               <%-- <p class="approver-line mb-0">
                    <%=MyBase.GetResourceString("C_Approver")%> : <strong id="lblApproverName">-</strong>
                </p>--%>
            </div>
            <div class="clearfix"></div>

            <!-- ============= Fixed: count tiles + Pending Requests filter bar (scroll is below) ============= -->
            <div class="skill-approval-sticky-wrap">
            <!-- ============= Stat tiles ============= -->
            <div class="container-fluid sticky-inner-stats">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="stat-card">
                            <div class="stat-icon icon-blue"><i class="fas fa-layer-group"></i></div>
                            <div>
                                <div class="stat-num" id="lblTotalRequests">0</div>
                                <div class="stat-label"><%=MyBase.GetResourceString("C_TotalRequests")%></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="stat-card">
                            <div class="stat-icon icon-orange"><i class="fas fa-clock"></i></div>
                            <div>
                                <div class="stat-num" id="lblPendingCount">0</div>
                                <div class="stat-label"><%=MyBase.GetResourceString("C_PendingApproval")%></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="stat-card">
                            <div class="stat-icon icon-green"><i class="fas fa-check-circle"></i></div>
                            <div>
                                <div class="stat-num" id="lblApprovedCount">0</div>
                                <div class="stat-label"><%=MyBase.GetResourceString("C_Approved")%></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="stat-card">
                            <div class="stat-icon icon-red"><i class="fas fa-times-circle"></i></div>
                            <div>
                                <div class="stat-num" id="lblRejectedCount">0</div>
                                <div class="stat-label"><%=MyBase.GetResourceString("C_Rejected")%></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ============= Filter bar ============= -->
            <div class="container-fluid pt-0 pb-2 sticky-inner-filter">
                <div class="row mx-0 align-items-center" style="background:#fff;border:1px solid #e3e6ea;border-radius:6px;padding:8px 12px;">
                    <div class="col-auto d-flex align-items-center skill-pending-filter-caption" style="font-size:13px;color:#555;">
                        <i class="fas fa-clock" style="color:hsl(214 88% 52%)"></i>
                        <strong style="color:hsl(214 88% 52%)"><%=MyBase.GetResourceString("C_PendingRequests")%></strong>
                    </div>
                    <div class="col-sm-3">
                        <input type="text" id="txtFilterEmployee" class="form-control input-sm" placeholder="<%=MyBase.GetResourceString("C_SearchEmployeeName")%>" />
                    </div>
                    <div class="col">
                        <div class="skill-approval-filter-actions">
                            <select id="cboFilterSkill" class="selectpicker form-control fixed-width-combo" data-live-search="true" onchange="OnSkillFilterChange()">
                                <option value=""><%=MyBase.GetResourceString("C_AllSkills")%></option>
                            </select>
                            <button type="button" class="btn borderbtn" onclick="ApplyApproverFilter()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="Apply Filter">
                                <i class="fas fa-filter me-1"></i> <%=MyBase.GetResourceString("C_Filter")%>
                            </button>
                            <button type="button" class="btn borderbtn" onclick="ResetApproverFilter()" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="Reset Filter">
                                <i class="fas fa-undo me-1"></i> <%=MyBase.GetResourceString("C_Reset")%>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            </div><!-- /.skill-approval-sticky-wrap -->

            <!-- Scrollable: pending cards + processed (count + filter stay fixed above) -->
            <div class="skill-approval-main-scroll">
            <!-- ============= Pending requests cards ============= -->
            <div class="container-fluid pt-2" id="divPendingRequests"></div>
            <div class="container-fluid pb-2">
                <div class="pagination-container" id="pendingPaginationContainer">
                    <div style="margin-left: auto;"></div>
                    <div style="color: #374151; font-size: 11.5px;">
                        <span id="pendingTotalRecords"></span>
                    </div>
                    <div style="display: flex; gap: 0.5rem;">
                        <button id="pendingFirstPageBtn" onclick="goToPendingPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                            <i class="fas fa-angle-double-left"></i>
                        </button>
                        <button id="pendingLastPageBtn" onclick="goToPendingNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                            <i class="fas fa-angle-double-right"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- ============= Processed requests panel ============= -->
            <div class="container-fluid pt-2 pb-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title" style="margin:0;">
                            <button type="button"
                                    class="btn w-100 text-start d-flex justify-content-between align-items-center personal-info-accordion-toggle"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#CollapseProcessed"
                                    aria-expanded="true"
                                    aria-controls="CollapseProcessed"
                                    style="padding:12px 15px;pointer-events: none;">
                                <span style="font-size:12px"><i class="fas fa-history mr-5"></i> <strong> <%=MyBase.GetResourceString("C_ProcessedRequests")%> </strong></span>
                                <%--<i class="fas fa-chevron-down personal-info-accordion-icon"></i>--%>
                            </button>
                        </h4>
                    </div>
                    <div id="CollapseProcessed" class="panel-collapse collapse show">
                        <div class="panel-body">
                            <table id="tblProcessedRequests" class="table table-bordered LTtbllist" style="width:100%;">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_Request")%></th>
                                        <th><%=MyBase.GetResourceString("C_Employee")%></th>
                                        <th><%=MyBase.GetResourceString("C_Skills")%></th>
                                        <th><%=MyBase.GetResourceString("C_Submitted")%></th>
                                        <th><%=MyBase.GetResourceString("C_Actioned")%></th>
                                        <th><%=MyBase.GetResourceString("C_Status")%></th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyProcessedRequests">
                                    <!-- Server-rendered rows -->
                                </tbody>
                            </table>
                            <div class="pagination-container" id="processedPaginationContainer">
                                <div style="margin-left: auto;"></div>
                                <div style="color: #374151; font-size: 11.5px;">
                                    <span id="processedTotalRecords"></span>
                                </div>
                                <div style="display: flex; gap: 0.5rem;">
                                    <button id="processedFirstPageBtn" onclick="goToProcessedPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button id="processedLastPageBtn" onclick="goToProcessedNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div><!-- /.skill-approval-main-scroll -->

        </div>
    </div>
    <% Else %>
    <div class="main-container" style="display:flex;align-items:center;justify-content:center;min-height:100vh;background:#f5f5f5;">
        <div style="text-align:center;padding:40px;background:#fff;border-radius:8px;box-shadow:0 1px 3px rgba(0,0,0,0.1);height: 652PX;width:100%">
            <%--<i class="fas fa-lock" style="font-size:48px;color:#dc3545;margin-bottom:20px;"></i>--%>
            <%--<h3 style="color:#374151;margin-bottom:10px;font-weight:normal;"><%=MyBase.GetResourceString("C_AccessDenied")%></h3>--%>
            <p style="color:#6c757d;margin-top: 172px;">You are not authorized to view this page.</p>
        </div>
    </div>
    <% End If %>
    <div class="modal fade" id="singleSkillActionModal" tabindex="-1" aria-labelledby="singleSkillActionModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header" style="background:#4263c1;color:#fff;">
                    <h5 class="modal-title" id="singleSkillActionModalLabel"><%=If(String.IsNullOrWhiteSpace(MyBase.GetResourceString("C_Confirmation")), "Confirmation", MyBase.GetResourceString("C_Confirmation"))%></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="singleSkillActionMessage" style="font-size:12px;color:#374151;margin-bottom:10px;"></div>
                    <label for="txtSingleSkillActionComment" style="font-size:11.5px;font-weight:600;color:#374151;">
                        <%=If(String.IsNullOrWhiteSpace(MyBase.GetResourceString("C_Comments")), "Comments", MyBase.GetResourceString("C_Comments"))%> <span style="color:#dc2626;">*</span>
                    </label>
                    <textarea id="txtSingleSkillActionComment" style="height:50px" class="form-control input-sm" maxlength="2000" rows="3" placeholder="<%=If(String.IsNullOrWhiteSpace(MyBase.GetResourceString("C_EnterComment")), "Enter comment", MyBase.GetResourceString("C_EnterComment"))%>"></textarea>
                   <%-- <div style="margin-top:4px;font-size:11px;color:#6b7280;text-align:right;">
                        <span id="singleSkillActionCommentCount">0</span>/2000
                    </div>--%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal"><%=If(String.IsNullOrWhiteSpace(MyBase.GetResourceString("C_No")), "No", MyBase.GetResourceString("C_No"))%></button>
                    <button type="button" class="btn btnyellow" id="btnSingleSkillActionYes"><%=If(String.IsNullOrWhiteSpace(MyBase.GetResourceString("C_Yes")), "Yes", MyBase.GetResourceString("C_Yes"))%></button>
                </div>
            </div>
        </div>
    </div>
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="skillHistoryApprovalOffcanvas" aria-labelledby="skillHistoryApprovalOffcanvasLabel" data-bs-backdrop="true" data-bs-scroll="true">
        <div class="offcanvas-header" style="border-bottom:1px solid #e5e7eb;padding:12px 16px;">
            <h5 class="pgtitle mb-0" id="skillHistoryApprovalOffcanvasLabel">Skill History</h5>
            <%-- Added by Dipali V on 8th May 2026 - Purpose:-Show tooltip on Skill Approval history offcanvas close icon. --%>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" title="<%=MyBase.GetResourceString("C_Close")%>" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <%-- Added by Dipali V on 11th May 2026 — Modified field / status + Modified By filters (same pattern as HR_MyProfile skill history). --%>
            <div class="row skill-history-approval-filters mb-2 gx-2">
                <div class="col-sm-6 mb-2 mb-sm-0" id="skillHistoryFieldFilterContainer">
                    <label class="form-label" for="ddlSkillHistoryApprovalFieldName"><%=MyBase.GetResourceString("C_ModifiedFields")%></label>
                    <select id="ddlSkillHistoryApprovalFieldName" class="selectpicker form-control fixed-width-combo" data-live-search="true" onchange="OnSkillHistoryApprovalFilterChange()">
                        <option value="">Select Modified Fields</option>
                    </select>
                </div>
                <div class="col-sm-6" id="skillHistoryModifiedByFilterContainer">
                    <label class="form-label" for="ddlSkillHistoryApprovalModifiedBy"><%=MyBase.GetResourceString("C_ModifiedBy")%></label>
                    <select id="ddlSkillHistoryApprovalModifiedBy" class="selectpicker form-control fixed-width-combo" data-live-search="true" onchange="OnSkillHistoryApprovalFilterChange()">
                        <option value="">Select Modified By</option>
                    </select>
                </div>
            </div>
            <div class="table-responsive" style="border:1px solid #e5e7eb;border-radius:8px;overflow:hidden;">
                <table class="table table-sm mb-0">
                    <thead style="background:#f8fafc;">
                        <tr>
                            <th><%=MyBase.GetResourceString("C_ModifiedFields")%></th>
                            <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                            <th><%=MyBase.GetResourceString("C_NewValue")%></th>
                            <th><%=MyBase.GetResourceString("C_ModifiedBy")%></th>
                            <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                        </tr>
                    </thead>
                    <tbody id="tblSkillHistoryApprovalBody">
                        <tr><td colspan="5" class="text-center"><%=MyBase.GetResourceString("C_NoData")%>.</td></tr>
                    </tbody>
                </table>
            </div>
            <div class="pagination-container" style="margin-top:8px;justify-content:flex-end;float: right;display: ruby;">
                <div style="color:#374151;font-size:11.5px;">
                    <span id="skillHistoryApprovalTotalRecords"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
                </div>
                <div style="display:flex;gap:0.5rem;">
                    <button id="skillHistoryApprovalPrevBtn" onclick="goToSkillHistoryApprovalPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background:white;border:1px solid #d1d5db;border-radius:0.375rem;padding:0.5rem 0.75rem;color:#3b82f6;cursor:pointer;display:flex;align-items:center;justify-content:center;min-width:40px;position:relative;">
                        <i class="fas fa-angle-double-left"></i>
                    </button>
                    <button id="skillHistoryApprovalNextBtn" onclick="goToSkillHistoryApprovalNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background:white;border:1px solid #d1d5db;border-radius:0.375rem;padding:0.5rem 0.75rem;color:#3b82f6;cursor:pointer;display:flex;align-items:center;justify-content:center;min-width:40px;position:relative;">
                        <i class="fas fa-angle-double-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <%-- Same JS bundle EmployeeMaster uses --%>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/jquery-3.7.1.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
   <%-- <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>--%>

    <script type="text/javascript">
        // Added by Dipali V On 23rd April 2026 For Skill Work flow changes
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';
        function resolveApiBaseUrl() {
            var configured = String(strUrl || '').trim();
            if (configured && (configured.indexOf('http://') === 0 || configured.indexOf('https://') === 0)) {
                return configured.replace(/\/+$/, '');
            }
            // Added by Dipali V On 23rd April 2026 For Skill Work flow changes
            // Fallback for local IIS where appsetting may be empty/relative.
            return (window.location.origin + '/W26_NPCI_API').replace(/\/+$/, '');
        }
        var apiBaseUrl = resolveApiBaseUrl();
        var approverID = parseInt('<%= If(Session("intUserID") Is Nothing, "0", Session("intUserID").ToString()) %>', 10) || 0;
        var approverName = '<%= If(Session("strUserName") Is Nothing, "", Session("strUserName").ToString()) %>';
        var canTakeAction = ('<%= If(m_blnAddAccess Or m_blnEditAccess, "true", "false") %>' === 'true');
        var alertCommentBlank = '<%=MyBase.GetResourceString("A_CommentShouldNotBeLeftBlank")%>' || 'Comment should not be left blank';
        var txtUnableLoadSummary = '<%=MyBase.GetResourceString("A_Unabletoloadrequestsummary")%>' || 'Unable to load request summary.';
        var txtUnableLoadPending = '<%=MyBase.GetResourceString("A_Unabletoloadpendingrequests")%>' || 'Unable to load pending requests.';
        var txtUnableLoadProcessed = '<%=MyBase.GetResourceString("A_Unabletoloadprocessedrequests")%>' || 'Unable to load processed requests.';
        var txtUnableLoadSkills = '<%=MyBase.GetResourceString("A_Unabletoloadskills")%>' || 'Unable to load skills.';
        var txtTotalRecords = '<%=MyBase.GetResourceString("C_TotalRecords")%>' || 'Total Records';
        var txtApproveSkill = '<%=MyBase.GetResourceString("C_ApproveSkill")%>' || 'Approve Skill';
        var txtRejectSkill = '<%=MyBase.GetResourceString("C_RejectSkill")%>' || 'Reject Skill';
        var txtRequestStatus = '<%=MyBase.GetResourceString("C_RequestStatus")%>' || 'Request Status';
        var txtRejectRequest = '<%=MyBase.GetResourceString("C_RejectRequest")%>' || 'Reject Request';
        var txtApproveRequest = '<%=MyBase.GetResourceString("C_ApproveRequest")%>' || 'Approve Request';
        var txtNoOfSkills = '<%=MyBase.GetResourceString("C_Noofskills")%>' || 'No.of skills';
        var txtApprovedBy = '<%=MyBase.GetResourceString("C_ApprovedBy")%>' || 'Approved by';
        var txtRejectedBy = '<%=MyBase.GetResourceString("C_RejectedBy")%>' || 'Rejected by';
        var txtApproved = '<%=MyBase.GetResourceString("C_Approved")%>' || 'Approved';
        var txtRejected = '<%=MyBase.GetResourceString("C_Rejected")%>' || 'Rejected';
        var txtConfirmApproveSingle = '<%=MyBase.GetResourceString("A_ConfirmApproveSingleSkill")%>' || 'Are you sure you want to approve this skill?';
        var txtConfirmRejectSingle = '<%=MyBase.GetResourceString("A_ConfirmRejectSingleSkill")%>' || 'Are you sure you want to reject this skill?';
        var txtConfirmApproveOnlyOne = '<%=MyBase.GetResourceString("A_ConfirmApproveOnlyOneSkill")%>' || 'Are you sure you want to approve only this skill from the request?';
        var txtConfirmRejectOnlyOne = '<%=MyBase.GetResourceString("A_ConfirmRejectOnlyOneSkill")%>' || 'Are you sure you want to reject only this skill from the request?';
        var txtUnableApproveRequest = '<%=MyBase.GetResourceString("A_Unabletoapproverequest")%>' || 'Unable to approve request.';
        var txtUnableRejectRequest = '<%=MyBase.GetResourceString("A_Unabletorejectrequest")%>' || 'Unable to reject request.';
        var txtUnableApproveSkill = '<%=MyBase.GetResourceString("A_Unabletoapproveskill")%>' || 'Unable to approve skill.';
        var txtUnableRejectSkill = '<%=MyBase.GetResourceString("A_Unabletorejectskill")%>' || 'Unable to reject skill.';
        var txtNewSkill = '<%=MyBase.GetResourceString("C_NewSkill")%>' || 'New Skill';
        var txtUpdatedSkill = '<%=MyBase.GetResourceString("C_UpdatedSkill")%>' || 'Updated Skill';
        var showSkillAttachmentColumn = <%= If(m_IsEnabledSkillFileUpload, "true", "false") %>;
        var allApprovalRows = [];
        var pendingCurrentPage = 1;
        var pendingPageSize = 5;
        var pendingTotalRequests = 0;
        var pendingTotalPages = 1;
        var processedCurrentPage = 1;
        var processedPageSize = 5;
        var processedTotalRequests = 0;
        var processedTotalPages = 1;
        var pendingActionSkillRequestID = 0;
        var pendingActionStatusID = 0;
        var pendingActionRequestSkillCount = 0;
        var singleSkillActionModalInstance = null;
        var skillHistoryApprovalRows = [];
        var skillHistoryApprovalCurrentPage = 1;
        var skillHistoryApprovalPageSize = 10;
        var skillHistoryApprovalTotalPages = 1;
        var skillHistoryApprovalTotalRecords = 0;
        function showLoader() { $('#loaderOverlay').css('display', 'flex'); }
        function hideLoader() { $('#loaderOverlay').hide(); }
        function normalizeTooltipAttributes(node) {
            if (!node) return;
            var legacyPlacement = node.getAttribute('data-placement');
            if (legacyPlacement && !node.getAttribute('data-bs-placement')) {
                node.setAttribute('data-bs-placement', legacyPlacement);
            }
        }
        function refreshTooltips() {
            var nodes = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            nodes.forEach(function (node) {
                normalizeTooltipAttributes(node);
                var old = bootstrap.Tooltip.getInstance(node);
                if (old) old.dispose();
                new bootstrap.Tooltip(node, {
                    trigger: 'hover',
                    container: 'body',
                    popperConfig: function (defaultConfig) {
                        defaultConfig.strategy = 'fixed';
                        return defaultConfig;
                    }
                });
            });
        }
        function initializeSearchableDropdowns() {
            if (!($.fn && $.fn.selectpicker)) return;
            var $skill = $('#cboFilterSkill');
            try {
                if ($skill.data('selectpicker')) {
                    $skill.selectpicker('destroy');
                }
            } catch (e) { }
            // Guard against duplicated wrapper markup when plugin/scripts are reloaded.
            $skill.siblings('.bootstrap-select').remove();
            $skill.selectpicker({
                liveSearch: true
            });
            $skill.selectpicker('refresh');
        }
        function initializeHistoryFilterDropdowns() {
            if (!($.fn && $.fn.selectpicker)) return;
            var $historyField = $('#ddlSkillHistoryApprovalFieldName');
            var $historyModifiedBy = $('#ddlSkillHistoryApprovalModifiedBy');
            try {
                if ($historyField.data('selectpicker')) {
                    $historyField.selectpicker('destroy');
                }
            } catch (e) { }
            try {
                if ($historyModifiedBy.data('selectpicker')) {
                    $historyModifiedBy.selectpicker('destroy');
                }
            } catch (e) { }
            $historyField.siblings('.bootstrap-select').remove();
            $historyModifiedBy.siblings('.bootstrap-select').remove();
            $historyField.selectpicker({
                liveSearch: true,
                container: '#skillHistoryApprovalOffcanvas'
            });
            $historyModifiedBy.selectpicker({
                liveSearch: true,
                container: '#skillHistoryApprovalOffcanvas'
            });
            $historyField.selectpicker('refresh');
            $historyModifiedBy.selectpicker('refresh');
        }
        function refreshSearchableDropdown($el) {
            if (!($el && $el.length)) return;
            if ($.fn && $.fn.selectpicker && $el.hasClass('selectpicker')) {
                $el.selectpicker('refresh');
            }
        }
        $(document).on('mouseenter', '[data-bs-toggle="tooltip"]', function () {
            var tip = bootstrap.Tooltip.getInstance(this);
            if (!tip) {
                normalizeTooltipAttributes(this);
                tip = new bootstrap.Tooltip(this, {
                    trigger: 'hover',
                    container: 'body',
                    popperConfig: function (defaultConfig) {
                        defaultConfig.strategy = 'fixed';
                        return defaultConfig;
                    }
                });
            }
            if (tip && typeof tip.update === 'function') {
                tip.update();
            }
        });
        $(document).on('click', '[data-bs-toggle="tooltip"]', function () {
            var t = bootstrap.Tooltip.getInstance(this);
            if (t) t.hide();
            if (typeof this.blur === 'function') this.blur();
        });

        function escapeHtml(text) {
            return String(text || '').replace(/[&<>"']/g, function (m) { return ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[m]; });
        }
        function getInitials(name) {
            var parts = String(name || '').trim().split(/\s+/).filter(Boolean);
            if (parts.length === 0) return 'NA';
            return (parts[0].charAt(0) + (parts.length > 1 ? parts[1].charAt(0) : '')).toUpperCase();
        }
        function buildPayload(statusId) {
            return {
                ApproverID: approverID,
                EmployeeSearch: ($('#txtFilterEmployee').val() || '').trim() || null,
                SkillID: parseInt($('#cboFilterSkill').val(), 10) || null,
                RequestStatusID: statusId,
                PageNumber: 1,
                PageSize: 500
            };
        }
        function normalizeSkillRows(result) {
            if (result && result.data && Array.isArray(result.data.skills)) return result.data.skills;
            if (result && result.Data && Array.isArray(result.Data.Skills)) return result.Data.Skills;
            if (result && Array.isArray(result.skills)) return result.skills;
            if (result && Array.isArray(result.Skills)) return result.Skills;
            return [];
        }
        function normalizeRows(result) {
            if (result && result.data && Array.isArray(result.data.data)) return result.data.data;
            if (result && Array.isArray(result.data)) return result.data;
            if (result && Array.isArray(result)) return result;
            return [];
        }
        function getVal(obj, key) {
            if (!obj) return null;
            if (obj[key] !== undefined && obj[key] !== null) return obj[key];
            var camel = key.charAt(0).toLowerCase() + key.slice(1);
            if (obj[camel] !== undefined && obj[camel] !== null) return obj[camel];
            return null;
        }
        function getNum(obj, key) {
            var v = parseInt(getVal(obj, key), 10);
            return isNaN(v) ? 0 : v;
        }
        function renderTooltipText(text, maxLen, extraClass) {
            var fullText = String(text || '');
            var normalized = fullText.replace(/\s+/g, ' ').trim();
            if (!normalized) return '-';
            var needsTrim = normalized.length > maxLen;
            var shortText = needsTrim ? (normalized.substring(0, maxLen) + '...') : normalized;
            var cls = 'proc-cell-truncate' + (extraClass ? (' ' + extraClass) : '');
            return '<span class="' + cls + '" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="' + escapeHtml(normalized) + '">' + escapeHtml(shortText) + '</span>';
        }
        function getSkillAttachmentDownloadUrl(fileName, systemFileName) {
            if (!fileName || !systemFileName) return '';
            var baseApi = (strUrl || '').trim();
            if (!baseApi) {
                baseApi = window.location.origin + '/W26_NPCI_API';
            }
            baseApi = baseApi.replace(/\/+$/, '');
            return baseApi + '/api/MyProfile/DownloadSkillRequestAttachment?fileName='
                + encodeURIComponent(fileName) + '&systemFileName=' + encodeURIComponent(systemFileName);
        }
        function renderSkillAttachmentLink(fileName, systemFileName) {
            var url = getSkillAttachmentDownloadUrl(fileName, systemFileName);
            if (!url) return '-';
            var fullName = String(fileName || '').trim();
            if (!fullName) return '-';
            var shouldTruncate = fullName.length > 15;
            var displayName = shouldTruncate ? (fullName.substring(0, 15) + '...') : fullName;
            var tooltipAttrs = shouldTruncate
                ? (' data-bs-toggle="tooltip" data-bs-placement="auto" data-bs-original-title="' + escapeHtml(fullName) + '"')
                : '';
            return '<a href="' + url + '" target="_blank"' + tooltipAttrs + '><i class="fas fa-download mr-5"></i> ' + escapeHtml(displayName) + '</a>';
        }
        function renderMultilineText(text) {
            var fullText = String(text || '').trim();
            if (!fullText) return '-';
            return escapeHtml(fullText).replace(/\r\n|\r|\n/g, '<br/>');
        }
        function renderSkillTypeBadge(skillActionType) {
            var isUpdated = String(skillActionType || '').toLowerCase().indexOf('updated') > -1;
            var label = isUpdated ? txtUpdatedSkill : txtNewSkill;
            var cls = isUpdated ? 'skill-type-updated' : 'skill-type-new';
            var icon = isUpdated ? 'fa-sync-alt' : 'fa-plus';
            return '<span class="skill-type-badge ' + cls + '" data-bs-toggle="tooltip" data-placement="top" data-bs-original-title="' + label + '"><i class="fas ' + icon + '"></i></span>';
        }
        function extractSkillActionFromRemarks(remarksText) {
            var map = {};
            var lines = String(remarksText || '').split(/\r\n|\r|\n/);
            var mode = '';
            lines.forEach(function (line) {
                var text = String(line || '').trim();
                if (!text) return;
                var low = text.toLowerCase();
                if (low.indexOf('revised skill') > -1 || low.indexOf('updated') > -1) {
                    mode = txtUpdatedSkill;
                    return;
                }
                if (low.indexOf('new skill') > -1) {
                    mode = txtNewSkill;
                    return;
                }
                if (text.charAt(0) === '-') {
                    var skillText = text.substring(1).trim();
                    var skillName = skillText;
                    var pipeIdx = skillText.indexOf('|');
                    if (pipeIdx > -1) {
                        skillName = skillText.substring(0, pipeIdx).trim();
                    } else {
                        var splitIdx = skillText.indexOf(':');
                        if (splitIdx > -1) skillName = skillText.substring(0, splitIdx).trim();
                    }
                    skillName = String(skillName || '').trim().toLowerCase();
                    if (skillName) {
                        map[skillName] = mode || txtNewSkill;
                    }
                }
            });
            return map;
        }
        function formatDateTimeDisplay(value) {
            var raw = String(value || '').trim();
            if (!raw) return '-';
            var normalized = raw.replace(' ', 'T');
            var dt = new Date(normalized);
            if (isNaN(dt.getTime())) {
                dt = new Date(raw);
            }
            if (isNaN(dt.getTime())) return raw;
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var dd = String(dt.getDate()).padStart(2, '0');
            var mmm = months[dt.getMonth()];
            var yyyy = dt.getFullYear();
            var hh = String(dt.getHours()).padStart(2, '0');
            var mm = String(dt.getMinutes()).padStart(2, '0');
            return dd + ' ' + mmm + ' ' + yyyy + ' ' + hh + ':' + mm;
        }
        function formatDateToDDMMMYYYY(value) {
            var raw = String(value || '').trim();
            if (!raw) return '-';
            var normalized = raw.replace(' ', 'T');
            var dt = new Date(normalized);
            if (isNaN(dt.getTime())) dt = new Date(raw);
            if (isNaN(dt.getTime())) return raw;
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            return String(dt.getDate()).padStart(2, '0') + ' ' + months[dt.getMonth()] + ' ' + dt.getFullYear();
        }
        function AJAXCallWithResult(url, param, async) {
            var result = null;
            var fullUrl = apiBaseUrl.endsWith('/') ? apiBaseUrl + url : apiBaseUrl + '/' + url;
            showLoader();
            $.ajax({
                url: fullUrl,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param && typeof encryptString === 'function' && typeof isJson === 'function') {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) { result = data; },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Authentication failed.');
                    } else {
                        alert('API error: ' + error);
                    }
                },
                complete: function () {
                    hideLoader();
                }
            });
            return result;
        }

        function ToggleApproverCard(elem) {
            var $a = $(elem);
            var $card = $a.closest('.approver-card');
            $card.find('.approver-expand-panel').toggle();
            $a.find('i').toggleClass('fa-chevron-down').toggleClass('fa-chevron-up');
        }
        function parseSkillMeta(skillName, skillDetail, fallbackCategory, coreCompetencyText) {
            var detail = String(skillDetail || '');
            var proficiency = '-';
            var expYears = '0';
            var expMonths = '0';
            var category = fallbackCategory || '-';
            var coreComp = 'No';
            var explicitCc = (coreCompetencyText !== undefined && coreCompetencyText !== null) ? String(coreCompetencyText).trim() : '';
            if (explicitCc !== '') {
                coreComp = explicitCc;
            } else {
                var ccMatch = detail.match(/Core Competency\s*:\s*(Yes|No|true|false|1|0)/i);
                if (ccMatch) {
                    var cv = String(ccMatch[1] || '').toLowerCase();
                    coreComp = (cv === 'yes' || cv === 'true' || cv === '1') ? 'Yes' : 'No';
                }
            }

            var expMatch = detail.match(/(\d+)\s*y\s*(\d+)\s*m/i);
            if (expMatch) {
                expYears = expMatch[1];
                expMonths = expMatch[2];
            }
            var parts = detail.split(' - ').map(function (p) { return (p || '').trim(); }).filter(Boolean);
            if (parts.length >= 3) {
                proficiency = parts[parts.length - 1] || '-';
            }
            if (parts.length >= 2 && category === '-') {
                var maybeCategory = parts[1];
                if (!/\d+\s*y/i.test(maybeCategory)) category = maybeCategory;
            }
            return {
                skill: skillName || '-',
               // category: category || '-',
                proficiency: proficiency || '-',
                expYears: expYears || '0',
                expMonths: expMonths || '0',
                coreComp: coreComp
            };
        }

        function loadApprovalData() {
            pendingCurrentPage = 1;
            processedCurrentPage = 1;
            $('#lblApproverName').text(approverName || ('ID ' + approverID));
            var summaryResult = AJAXCallWithResult("api/HRSkillRequestApproval/GetSkillRequestApprovalSummary", JSON.stringify({ ApproverID: approverID }), false);
            if (!summaryResult || summaryResult.error || summaryResult.Status === 'ERROR' || summaryResult.status === 'ERROR') {
                alertify.error(txtUnableLoadSummary);
                return;
            }
           // debugger;
            var summary = summaryResult.data;
            $('#lblTotalRequests').text(getNum(summary, 'totalRequests'));
            $('#lblPendingCount').text(getNum(summary, 'pendingApprovalCount'));
            $('#lblApprovedCount').text(getNum(summary, 'approvedCount'));
            $('#lblRejectedCount').text(getNum(summary, 'rejectedCount'));

            var pendingResult = AJAXCallWithResult("api/HRSkillRequestApproval/GetSkillRequestApprovals", JSON.stringify(buildPayload(2)), false);
            if (!pendingResult || pendingResult.error || pendingResult.Status === 'ERROR' || pendingResult.status === 'ERROR') {
                alertify.error(txtUnableLoadPending);
                return;
            }
            var pendingRows = normalizeRows(pendingResult);
            allApprovalRows = pendingRows.slice(0);
            renderPendingCards(pendingRows);
            loadProcessedRequests(processedCurrentPage);
        }
        function renderPendingPagination() {
            $('#pendingTotalRecords').text(txtTotalRecords + ': ' + pendingTotalRequests);
            var noData = pendingTotalRequests <= 0;
            $('#pendingFirstPageBtn').prop('disabled', noData || pendingCurrentPage <= 1);
            $('#pendingLastPageBtn').prop('disabled', noData || pendingCurrentPage >= pendingTotalPages);
        }
        function goToPendingPreviousPage() {
            if (pendingCurrentPage > 1) {
                pendingCurrentPage--;
                renderPendingCards(allApprovalRows);
            }
        }
        function goToPendingNextPage() {
            if (pendingCurrentPage < pendingTotalPages) {
                pendingCurrentPage++;
                renderPendingCards(allApprovalRows);
            }
        }

        function extractProcessedPagination(result, rows) {
            var envelope = (result && result.data) ? result.data : result;
            var pagination = null;
            if (envelope && envelope.PaginationEntities && Array.isArray(envelope.PaginationEntities) && envelope.PaginationEntities.length > 0) {
                pagination = envelope.PaginationEntities[0];
            } else if (envelope && envelope.paginationEntities && Array.isArray(envelope.paginationEntities) && envelope.paginationEntities.length > 0) {
                pagination = envelope.paginationEntities[0];
            }
            if (pagination) {
                var pagTotal = parseInt(pagination.totalRecords || pagination.TotalRecords || 0, 10);
                var pagCurrent = parseInt(pagination.currentPage || pagination.CurrentPage || processedCurrentPage, 10);
                var pagSize = parseInt(pagination.pageSize || pagination.PageSize || processedPageSize, 10);
                return {
                    totalRecords: isNaN(pagTotal) ? 0 : pagTotal,
                    currentPage: isNaN(pagCurrent) ? processedCurrentPage : pagCurrent,
                    pageSize: isNaN(pagSize) ? processedPageSize : pagSize
                };
            }
            var total = parseInt((envelope && (envelope.totalRecords || envelope.TotalRecords || envelope.totalRequests || envelope.TotalRequests)), 10);
            if (!isNaN(total) && total >= 0) {
                return { totalRecords: total, currentPage: processedCurrentPage, pageSize: processedPageSize };
            }
            if (rows && rows.length > 0) {
                var first = rows[0];
                total = parseInt(first.TotalRecords || first.totalRecords || first.TotalRequests || first.totalRequests, 10);
                if (!isNaN(total) && total >= 0) {
                    return { totalRecords: total, currentPage: processedCurrentPage, pageSize: processedPageSize };
                }
            }
            return {
                totalRecords: Object.keys(getGroupedRequests(rows || [])).length,
                currentPage: processedCurrentPage,
                pageSize: processedPageSize
            };
        }

        function loadProcessedRequests(pageNumber) {
            processedCurrentPage = pageNumber || 1;
            var processedResult = AJAXCallWithResult("api/HRSkillRequestApproval/GetProcessedSkillRequestApprovals", JSON.stringify({
                ApproverID: approverID,
                EmployeeSearch: ($('#txtFilterEmployee').val() || '').trim() || null,
                SkillID: parseInt($('#cboFilterSkill').val(), 10) || null,
                PageNumber: processedCurrentPage,
                PageSize: processedPageSize
            }), false);
            if (!processedResult || processedResult.error || processedResult.Status === 'ERROR' || processedResult.status === 'ERROR') {
                alertify.error(txtUnableLoadProcessed);
                renderProcessedGrid([]);
                processedTotalRequests = 0;
                processedTotalPages = 1;
                renderProcessedPagination();
                return;
            }
            var processedRows = normalizeRows(processedResult);
            var processedPagination = extractProcessedPagination(processedResult, processedRows);
            processedCurrentPage = processedPagination.currentPage || processedCurrentPage;
            processedPageSize = processedPagination.pageSize || processedPageSize;
            processedTotalRequests = processedPagination.totalRecords || 0;
            processedTotalPages = Math.max(1, Math.ceil(processedTotalRequests / processedPageSize));
            if (processedCurrentPage > processedTotalPages) processedCurrentPage = processedTotalPages;
            renderProcessedGrid(processedRows);
            renderProcessedPagination();
        }

        function renderProcessedPagination() {
            //$('#processedTotalRecords').text('Total Records: ' + processedTotalRequests + ' | Page ' + processedCurrentPage + ' of ' + processedTotalPages);
            $('#processedTotalRecords').text(txtTotalRecords + ': ' + processedTotalRequests);
            var noData = processedTotalRequests <= 0;
            $('#processedFirstPageBtn').prop('disabled', noData || processedCurrentPage <= 1);
            $('#processedLastPageBtn').prop('disabled', noData || processedCurrentPage >= processedTotalPages);
        }

        function goToProcessedPreviousPage() {
            if (processedCurrentPage > 1) {
                loadProcessedRequests(processedCurrentPage - 1);
            }
        }

        function goToProcessedNextPage() {
            if (processedCurrentPage < processedTotalPages) {
                loadProcessedRequests(processedCurrentPage + 1);
            }
        }

        function getGroupedRequests(rows) {
            var grouped = {};
            (rows || []).forEach(function (r) {
                var gid = String(getVal(r, 'RequestID') || getVal(r, 'SkillRequestID') || '');
                if (!gid) return;
                if (!grouped[gid]) grouped[gid] = [];
                grouped[gid].push(r);
            });
            return grouped;
        }

        function renderSummary(rows) {
            var grouped = getGroupedRequests(rows);
            var requestRows = Object.keys(grouped).map(function (k) { return grouped[k][0]; });
            var total = requestRows.length;
            var pending = requestRows.filter(function (r) { return getNum(r, 'RequestStatusID') === 2; }).length;
            var approved = requestRows.filter(function (r) { return getNum(r, 'RequestStatusID') === 3; }).length;
            var rejected = requestRows.filter(function (r) { return getNum(r, 'RequestStatusID') === 4; }).length;
            $('#lblTotalRequests').text(total);
            $('#lblPendingCount').text(pending);
            $('#lblApprovedCount').text(approved);
            $('#lblRejectedCount').text(rejected);
        }

        function BindSkillFilterOptions(rows) {
            var $skill = $('#cboFilterSkill');
            var selectedSkill = ($skill.val() || '').toString();
            var skillMap = {};
            var skillList = [];
            (rows || []).forEach(function (r) {
                var skillID = String(
                    getVal(r, 'ToolID') ||
                    getVal(r, 'SkillID') ||
                    getVal(r, 'toolID') ||
                    getVal(r, 'skillID') ||
                    getVal(r, 'Id') ||
                    getVal(r, 'id') ||
                    ''
                );
                var skillName = String(
                    getVal(r, 'Description') ||
                    getVal(r, 'SkillName') ||
                    getVal(r, 'description') ||
                    getVal(r, 'skillName') ||
                    getVal(r, 'Name') ||
                    getVal(r, 'name') ||
                    ''
                );
                if (skillID && !skillMap[skillID]) {
                    skillMap[skillID] = true;
                    skillList.push({ value: skillID, label: skillName });
                }
            });
            skillList.sort(function (a, b) {
                return String(a.label || '').localeCompare(String(b.label || ''), undefined, { sensitivity: 'base' });
            });
            var options = ['<option value=""><%=MyBase.GetResourceString("C_AllSkills")%></option>'];
            skillList.forEach(function (item) {
                options.push('<option value="' + escapeHtml(item.value) + '">' + escapeHtml(item.label) + '</option>');
            });
            // Replacing all <option> nodes: bootstrap-select often needs destroy + re-init (refresh alone can leave an empty menu).
            if ($.fn && $.fn.selectpicker) {
                try {
                    if ($skill.data('selectpicker')) {
                        $skill.selectpicker('destroy');
                    }
                } catch (e) { }
                $skill.siblings('.bootstrap-select').remove();
            }
            $skill.html(options.join(''));
            if (selectedSkill) {
                $skill.val(selectedSkill);
            }
            if ($.fn && $.fn.selectpicker) {
                $skill.selectpicker({ liveSearch: true });
                if (selectedSkill) {
                    try {
                        $skill.selectpicker('val', selectedSkill);
                    } catch (e2) {
                        $skill.val(selectedSkill);
                    }
                }
                try {
                    $skill.selectpicker('refresh');
                } catch (e3) { }
            }
        }
        function normalizeSkillFilterRows(result) {
            if (!result) return [];
            if (Array.isArray(result)) return result;
            var d = result.data !== undefined ? result.data : result.Data;
            if (d) {
                if (Array.isArray(d)) return d;
                if (Array.isArray(d.skills)) return d.skills;
                if (Array.isArray(d.Skills)) return d.Skills;
                if (d.skills && typeof d.skills === 'object') {
                    if (Array.isArray(d.skills.SkillFilterItemEntity)) return d.skills.SkillFilterItemEntity;
                    if (Array.isArray(d.skills.skillFilterItemEntity)) return d.skills.skillFilterItemEntity;
                }
                if (Array.isArray(d.SkillFilterItemEntity)) return d.SkillFilterItemEntity;
                if (Array.isArray(d.skillFilterItemEntity)) return d.skillFilterItemEntity;
            }
            if (result.skills && Array.isArray(result.skills.SkillFilterItemEntity)) return result.skills.SkillFilterItemEntity;
            if (result.skills && Array.isArray(result.skills.skillFilterItemEntity)) return result.skills.skillFilterItemEntity;
            if (result.data && Array.isArray(result.data.SkillFilterItemEntity)) return result.data.SkillFilterItemEntity;
            if (result.data && Array.isArray(result.data.skillFilterItemEntity)) return result.data.skillFilterItemEntity;
            if (Array.isArray(result.SkillFilterItemEntity)) return result.SkillFilterItemEntity;
            if (Array.isArray(result.skillFilterItemEntity)) return result.skillFilterItemEntity;
            if (Array.isArray(result.skills)) return result.skills;
            if (Array.isArray(result.data)) return result.data;
            return [];
        }
        function loadSkillFilterDropdown() {
            var skillResult = AJAXCallWithResult("api/HRSkillRequestApproval/GetAllSkill", JSON.stringify({}), false);
            if (!skillResult || skillResult.error || skillResult.Status === 'ERROR' || skillResult.status === 'ERROR') {
                alertify.error(txtUnableLoadSkills);
                BindSkillFilterOptions([]);
                return;
            }
            BindSkillFilterOptions(normalizeSkillFilterRows(skillResult));
        }

        function renderPendingCards(rows) {
            var grouped = getGroupedRequests(rows);
            var groupedKeys = Object.keys(grouped);
            pendingTotalRequests = groupedKeys.length;
            pendingTotalPages = Math.max(1, Math.ceil(pendingTotalRequests / pendingPageSize));
            if (pendingCurrentPage > pendingTotalPages) pendingCurrentPage = pendingTotalPages;
            var startIdx = (pendingCurrentPage - 1) * pendingPageSize;
            var pageKeys = groupedKeys.slice(startIdx, startIdx + pendingPageSize);
            var html = '';
            pageKeys.forEach(function (gid) {
                var list = grouped[gid];
                var first = list[0];
                var empName = getVal(first, 'EmployeeName') || ('Employee ' + getVal(first, 'EmployeeID'));
                var empRole = getVal(first, 'EmployeeRole') || '-';
                var reqId = getVal(first, 'SkillRequestID');
                var remarksRaw = getVal(first, 'Remarks') || '';
                var skillActionFromRemarks = extractSkillActionFromRemarks(remarksRaw);
                var seenSkill = {};
                var chips = list.map(function (s) {
                    var skillKey = String(getVal(s, 'SkillID') || '') + '_' + String(getVal(s, 'EmployeeSkillWorkflowID') || '');
                    if (seenSkill[skillKey]) return '';
                    seenSkill[skillKey] = true;
                    var skillName = String(getVal(s, 'SkillName') || ('Skill ' + getVal(s, 'SkillID')));
                    var skillDetail = String(getVal(s, 'SkillDetail') || '');
                    var detailText = skillDetail;
                    if (detailText.indexOf(skillName + ' - ') === 0) {
                        detailText = detailText.substring((skillName + ' - ').length);
                    }
                    return '<span class="skill-chip"><span class="skill-name">' + escapeHtml(skillName) + '</span>' +
                        (detailText ? (' - ' + escapeHtml(detailText)) : '') + '</span>';
                }).join('');
                var detailsRows = '';
                seenSkill = {};
                list.forEach(function (s) {
                    var skillKey = String(getVal(s, 'SkillID') || '') + '_' + String(getVal(s, 'EmployeeSkillWorkflowID') || '');
                    if (seenSkill[skillKey]) return;
                    seenSkill[skillKey] = true;
                    var meta = parseSkillMeta(
                        getVal(s, 'SkillName') || ('Skill ' + getVal(s, 'SkillID')),
                        getVal(s, 'SkillDetail'),
                        getVal(s, 'SkillCategory'),
                        getVal(s, 'CoreCompetencyText')
                    );
                    var skillNameLower = String(meta.skill || '').trim().toLowerCase();
                    var skillActionType = getVal(s, 'SkillActionType') || skillActionFromRemarks[skillNameLower] || txtNewSkill;
                    detailsRows += '<tr>' +
                        '<td>' + renderSkillTypeBadge(skillActionType) + '<span class="pending-skill-name">' + escapeHtml(meta.skill) + '</span></td>' +
                        //'<td>' + escapeHtml(meta.category) + '</td>' +
                        '<td>' + escapeHtml(meta.proficiency) + '</td>' +
                        '<td>' + escapeHtml(meta.expYears) + '</td>' +
                        '<td>' + escapeHtml(meta.expMonths) + '</td>' +
                        '<td>' + escapeHtml(meta.coreComp) + '</td>' +
                        (showSkillAttachmentColumn ? ('<td>' + renderSkillAttachmentLink(getVal(s, 'AttachmentFileName'), getVal(s, 'AttachmentSystemFileName')) + '</td>') : '') +
                        '<td><span class="pending-skill-action">' +
                        (canTakeAction
                            ? ('<i class="fas fa-check-circle act approve" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="' + escapeHtml(txtApproveSkill) + '" onclick="OpenSingleSkillActionModal(' + (parseInt(getVal(s, 'SkillRequestID'), 10) || 0) + ',3,' + list.length + ')"></i>' +
                                '<i class="fas fa-times-circle act reject" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="' + escapeHtml(txtRejectSkill) + '" onclick="OpenSingleSkillActionModal(' + (parseInt(getVal(s, 'SkillRequestID'), 10) || 0) + ',4,' + list.length + ')"></i>')
                            : '') +
                        '<i class="fas fa-history act" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="<%=MyBase.GetResourceString("C_History")%>" onclick="OpenSkillHistoryApproval(' + (parseInt(getVal(s, 'EmployeeID'), 10) || 0) + ',' + (parseInt(getVal(s, 'EmployeeSkillWorkflowID'), 10) || 0) + ')"></i>' +
                        '</span></td>' +
                        '</tr>';
                });
                var employeeRemarks = renderMultilineText(remarksRaw);
                var submittedOn = formatDateTimeDisplay(getVal(first, 'RequestedDate'));
                html += '<div class="approver-card" data-reqid="' + reqId + '">' +
                    '<div class="approver-head">' +
                    '<div class="d-flex align-items-center">' +
                    '<span class="emp-avatar">' + escapeHtml(getInitials(empName)) + '</span>' +
                    '<div><div class="emp-name">' + escapeHtml(empName) + '</div>' +
                    '<div class="emp-meta">' + escapeHtml(empRole) + ' | Request <strong>R' + escapeHtml(gid) + '</strong> | Submitted: ' + escapeHtml(submittedOn) + '</div></div></div>' +
                    '<div class="d-flex align-items-center" style="gap:14px;"><span style="font-size:12px;color: hsl(214 88% 30%);font-weight: 600;"><i class="fas fa-layer-group mr-5"></i> <strong>' + list.length + '</strong>  <%=MyBase.GetResourceString("C_Skills")%> </span>' +
                    '<span class="skill-chip skill-status-pill pending rounded-full gap-1" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="' + escapeHtml(txtRequestStatus) + '"><i class="fas fa-clock mr-5"></i> <%=MyBase.GetResourceString("C_Pending")%> </span>' +
                    '<a href="javascript:;" class="skreq-toggle" onclick="ToggleApproverCard(this);"><i class="fas fa-chevron-down"></i></a></div></div>' +
                    '<div class="approver-skills" style="padding:10px 15px;border-bottom:1px solid #eef1f4;">' + chips + '</div>' +
                    '<div class="approver-expand-panel">' +
                    '<div class="pending-skill-table-wrap"><table class="pending-skill-table">' +
                    '<thead><tr><th><%=MyBase.GetResourceString("C_Skill")%></th><th><%=MyBase.GetResourceString("C_Proficiency")%> </th><th><%=MyBase.GetResourceString("C_ExpY")%> </th><th><%=MyBase.GetResourceString("C_ExpM")%> </th><th><%=MyBase.GetResourceString("C_CoreComp")%>.</th>' + (showSkillAttachmentColumn ? '<th><%=If(String.IsNullOrWhiteSpace(MyBase.GetResourceString("C_Attachment")), "Attachment", MyBase.GetResourceString("C_Attachment"))%></th>' : '') + '<th><%=MyBase.GetResourceString("C_Action")%></th></tr></thead>' +
                    '<tbody>' + detailsRows + '</tbody>' +
                    '</table></div>' +
                    '<div class="employee-remarks-box"><strong>Employee remarks:</strong><div class="employee-remarks-content">' + (employeeRemarks || '-') + '</div></div>' +
                    '</div>' +
                    // Added by Dipali V On 23rd April 2026 For Skill Work flow changes
                    '<div class="approver-actions"><textarea id="txtActionComment_' + reqId + '" class="form-control input-sm" maxlength="2000" placeholder="<%=MyBase.GetResourceString("C_EnterComment")%>"></textarea>' +
                    (canTakeAction ? ('<button class="btn" style="background:#dc3545;color:#fff;" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="' + escapeHtml(txtRejectRequest) + '" onclick="RejectSkillRequest(' + reqId + ')"><i class="fas fa-times mr-5"></i> <%=MyBase.GetResourceString("C_RejectAll")%> (' + list.length + ')</button>' +
                    '<button class="btn" style="background:#28a745;color:#fff;" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="' + escapeHtml(txtApproveRequest) + '" onclick="ApproveSkillRequest(' + reqId + ')"><i class="fas fa-check mr-5"></i> <%=MyBase.GetResourceString("C_ApproveAll")%> (' + list.length + ')</button>') : '') +
                    '</div></div>';
            });
            if (!html) html = '<div class="text-muted" style="padding:12px 4px;text-align: center;"><%=MyBase.GetResourceString("C_NoData")%>.</div>';
            $('#divPendingRequests').html(html);
            renderPendingPagination();
            refreshTooltips();
        }

        function renderProcessedGrid(rows) {
            var grouped = getGroupedRequests(rows);
            var html = '';
            // Added by Dipali V on 6th May 2026 - Purpose:-Always show latest processed request on top (e.g., R7 before older requests).
            var groupedKeys = Object.keys(grouped).sort(function (a, b) {
                var listA = grouped[a] || [];
                var listB = grouped[b] || [];
                var latestA = 0;
                var latestB = 0;

                listA.forEach(function (item) {
                    var rawDateA = getVal(item, 'ApprovedDate') || getVal(item, 'RequestedDate') || '';
                    var timeA = Date.parse(String(rawDateA).replace(' ', 'T')) || 0;
                    if (timeA > latestA) latestA = timeA;
                });

                listB.forEach(function (item) {
                    var rawDateB = getVal(item, 'ApprovedDate') || getVal(item, 'RequestedDate') || '';
                    var timeB = Date.parse(String(rawDateB).replace(' ', 'T')) || 0;
                    if (timeB > latestB) latestB = timeB;
                });

                if (latestA !== latestB) return latestB - latestA;
                return (parseInt(b, 10) || 0) - (parseInt(a, 10) || 0);
            });

            groupedKeys.forEach(function (gid) {
                var list = grouped[gid];
                var first = list[0];
                var hasRejected = list.some(function (s) { return getNum(s, 'RequestStatusID') === 4; });
                var hasApproved = list.some(function (s) { return getNum(s, 'RequestStatusID') === 3; });
                var statusId = hasRejected ? 4 : (hasApproved ? 3 : getNum(first, 'RequestStatusID'));

                var statusAnchor = hasRejected
                    ? (list.find(function (s) { return getNum(s, 'RequestStatusID') === 4; }) || first)
                    : (list.find(function (s) { return getNum(s, 'RequestStatusID') === 3; }) || first);
                var actionDetail = '';
                if (statusId === 3) actionDetail = txtApprovedBy + ' - ' + (getVal(statusAnchor, 'ApprovedByName') || getVal(statusAnchor, 'ApprovedBy') || '-');
                else if (statusId === 4) actionDetail = txtRejectedBy + ' - ' + (getVal(statusAnchor, 'ApprovedByName') || getVal(statusAnchor, 'ApprovedBy') || '-');

                var detailRows = '';
                list.forEach(function (s) {
                    var meta = parseSkillMeta(
                        getVal(s, 'SkillName') || ('Skill ' + getVal(s, 'SkillID')),
                        getVal(s, 'SkillDetail'),
                        getVal(s, 'SkillCategory'),
                        getVal(s, 'CoreCompetencyText')
                    );
                    var skillStatusId = getNum(s, 'RequestStatusID');
                    var skillStatusBadge = skillStatusId === 3
                        ? '<span class="proc-status-pill approved"><i class="fas fa-check"></i>' + escapeHtml(txtApproved) + '</span>'
                        : (skillStatusId === 4
                            ? '<span class="proc-status-pill rejected"><i class="fas fa-times"></i>' + escapeHtml(txtRejected) + '</span>'
                            : '<span>-</span>');
                    var skillRemarks = getVal(s, 'ApprovedRejectionReason') || getVal(s, 'Remarks') || '-';
                    detailRows += '<tr>' +
                        '<td><span class="skill-name">' + escapeHtml(meta.skill) + '</span></td>' +
                        '<td>' + escapeHtml(meta.proficiency) + '</td>' +
                        '<td>' + escapeHtml(meta.expYears) + '</td>' +
                        '<td>' + escapeHtml(meta.expMonths) + '</td>' +
                        '<td>' + escapeHtml(meta.coreComp) + '</td>' +
                        (showSkillAttachmentColumn ? ('<td>' + renderSkillAttachmentLink(getVal(s, 'AttachmentFileName'), getVal(s, 'AttachmentSystemFileName')) + '</td>') : '') +
                        '<td>' + skillStatusBadge + '</td>' +
                        '<td>' + renderTooltipText(skillRemarks, 25, 'proc-cell-remarks') + '</td>' +
                        '</tr>';
                });

                var statusBadge = statusId === 3
                    ? '<span class="proc-status-pill approved"><i class="fas fa-check"></i>' + escapeHtml(txtApproved) + '</span>'
                    : '<span class="proc-status-pill rejected"><i class="fas fa-times"></i>' + escapeHtml(txtRejected) + '</span>';
                var submittedDateText = formatDateTimeDisplay(getVal(first, 'RequestedDate'));
                var actionedDateText = formatDateTimeDisplay(getVal(statusAnchor, 'ApprovedDate'));
                var employeeText = getVal(first, 'EmployeeName') || ('Employee ' + getVal(first, 'EmployeeID'));
                var actionedText = actionedDateText + (actionDetail ? (' | ' + actionDetail) : '');
                html += '<tr class="processed-main-row">' +
                    '<td><a href="javascript:void(0);" class="proc-request-link" onclick="toggleProcessedRequestDetails(\'' + escapeHtml(gid) + '\')"><i id="icoProc_' + escapeHtml(gid) + '" class="fas fa-chevron-right mr-5"></i>   R' + escapeHtml(gid) + '</a></td>' +
                    '<td>' + renderTooltipText(employeeText, 30) + '</td>' +
                    '<td><span class="proc-skill-count" data-bs-toggle="tooltip" data-placement="bottom" data-bs-original-title="' + escapeHtml(txtNoOfSkills) + '">' + list.length + '</span></td>' +
                    '<td>' + renderTooltipText(submittedDateText, 30) + '</td>' +
                    '<td>' + renderTooltipText(actionedText, 50) + '</td>' +
                    '<td>' + statusBadge + '</td>' +
                    '</tr>' +
                    '<tr id="rowProc_' + escapeHtml(gid) + '" style="display:none;background:#fafbfd;">' +
                    '<td colspan="6" style="padding:11px;">' +
                    '<div class="processed-skill-table-wrap"><table class="processed-skill-table">' +
                    '<thead><tr><th><%=MyBase.GetResourceString("C_Skill")%></th><th><%=MyBase.GetResourceString("C_Proficiency")%> </th><th><%=MyBase.GetResourceString("C_ExpY")%> </th><th><%=MyBase.GetResourceString("C_ExpM")%> </th><th><%=MyBase.GetResourceString("C_CoreComp")%>.</th>' + (showSkillAttachmentColumn ? '<th><%=If(String.IsNullOrWhiteSpace(MyBase.GetResourceString("C_Attachment")), "Attachment", MyBase.GetResourceString("C_Attachment"))%></th>' : '') + '<th><%=MyBase.GetResourceString("C_Status")%></th><th><%=MyBase.GetResourceString("C_Remarks")%></th></tr></thead>' +

                    '<tbody>' + detailRows + '</tbody>' +
                    '</table></div>' +
                    '</td>' +
                    '</tr>';
            });
            if (!html) html = '<tr><td colspan="6" class="text-center text-muted"><%=MyBase.GetResourceString("C_NoData")%>.</td></tr>';
            $('#tbodyProcessedRequests').html(html);
            refreshTooltips();
        }
        function toggleProcessedRequestDetails(requestId) {
            var $row = $('#rowProc_' + requestId);
            var $ico = $('#icoProc_' + requestId);
            $row.toggle();
            $ico.toggleClass('fa-chevron-right fa-chevron-down');
        }

        function OpenSingleSkillActionModal(skillRequestID, actionStatusID, requestSkillCount) {
            pendingActionSkillRequestID = parseInt(skillRequestID, 10) || 0;
            pendingActionStatusID = parseInt(actionStatusID, 10) || 0;
            pendingActionRequestSkillCount = parseInt(requestSkillCount, 10) || 0;
            var isApprove = pendingActionStatusID === 3;
            var msg = pendingActionRequestSkillCount > 1
                ? (isApprove
                    ? txtConfirmApproveOnlyOne
                    : txtConfirmRejectOnlyOne)
                : (isApprove
                    ? txtConfirmApproveSingle
                    : txtConfirmRejectSingle);
            $('#singleSkillActionMessage').text(msg);
            $('#txtSingleSkillActionComment').val('');
            $('#singleSkillActionCommentCount').text('0');
            if (!singleSkillActionModalInstance) {
                singleSkillActionModalInstance = new bootstrap.Modal(document.getElementById('singleSkillActionModal'));
            }
            singleSkillActionModalInstance.show();
            setTimeout(function () { $('#txtSingleSkillActionComment').focus(); }, 250);
        }
        function OpenSkillHistoryApproval(employeeID, employeeSkillWorkflowID) {
            //debugger;
            var empId = parseInt(employeeID, 10) || 0;
            var workflowId = parseInt(employeeSkillWorkflowID, 10) || 0;
            if (!empId || !workflowId) {
                alertify.error('<%=MyBase.GetResourceString("C_NoData")%>.');
                return;
            }
            var payload = {
                EmployeeID: empId,
                EmployeeSkillWorkflowID: workflowId,
                ModifiedBy: null,
                FieldName: null
            };
            var result = AJAXCallWithResult("api/HRSkillRequestApproval/GetSkillWorkflowHistory", JSON.stringify(payload), false);
            if (!result || result.error || result.Status === 'ERROR' || result.status === 'ERROR') {
                $('#tblSkillHistoryApprovalBody').html('<tr><td colspan="5" class="text-center">' + escapeHtml(txtUnableLoadSkills) + '</td></tr>');
                skillHistoryApprovalRows = [];
            } else {
                skillHistoryApprovalRows = normalizeSkillWorkflowHistoryRows(result);
            }
            skillHistoryApprovalCurrentPage = 1;
            BindSkillHistoryApprovalFilterOptions(skillHistoryApprovalRows);
            renderSkillHistoryApprovalTable();
            var offcanvasEl = document.getElementById('skillHistoryApprovalOffcanvas');
            var offcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            offcanvas.show();
            refreshSearchableDropdown($('#ddlSkillHistoryApprovalModifiedBy'));
            refreshSearchableDropdown($('#ddlSkillHistoryApprovalFieldName'));
        }

        // Added by Dipali V on 11th May 2026 — parse history list from API (multiple response shapes).
        function normalizeSkillWorkflowHistoryRows(result) {
            if (!result || !result.data) return [];
            var d = result.data;
            if (Array.isArray(d.SkillWorkflowHistoryEntity)) return d.SkillWorkflowHistoryEntity;
            if (Array.isArray(d.skillWorkflowHistoryEntity)) return d.skillWorkflowHistoryEntity;
            if (Array.isArray(d.data)) return d.data;
            return [];
        }

        // Added by Dipali V on 11th May 2026 — populate Modified field (incl. status) and Modified By dropdowns from loaded rows (same idea as HR_MyProfile).
        function BindSkillHistoryApprovalFilterOptions(rows) {
            var modifiedByMap = {};
            var fieldMap = {};
            var modifiedByList = [];
            var fieldList = [];
            (rows || []).forEach(function (r) {
                var modifiedBy = String(getVal(r, 'ModifiedBy') || '');
                var modifiedByName = String(getVal(r, 'ModifiedByName') || getVal(r, 'ModifiedBy') || '');
                var fieldName = String(getVal(r, 'FieldName') || '');
                if (modifiedBy && !modifiedByMap[modifiedBy]) {
                    modifiedByMap[modifiedBy] = true;
                    modifiedByList.push({ value: modifiedBy, label: modifiedByName });
                }
                if (fieldName && !fieldMap[fieldName]) {
                    fieldMap[fieldName] = true;
                    fieldList.push({ value: fieldName, label: fieldName });
                }
            });
            modifiedByList.sort(function (a, b) {
                return String(a.label || '').localeCompare(String(b.label || ''), undefined, { sensitivity: 'base' });
            });
            fieldList.sort(function (a, b) {
                return String(a.label || '').localeCompare(String(b.label || ''), undefined, { sensitivity: 'base' });
            });
            var modifiedByOptions = ['<option value="">Select Modified By</option>'];
            var fieldOptions = ['<option value="">Select Modified Fields</option>'];
            modifiedByList.forEach(function (item) {
                modifiedByOptions.push('<option value="' + escapeHtml(item.value) + '">' + escapeHtml(item.label) + '</option>');
            });
            fieldList.forEach(function (item) {
                fieldOptions.push('<option value="' + escapeHtml(item.value) + '">' + escapeHtml(item.label) + '</option>');
            });
            $('#ddlSkillHistoryApprovalModifiedBy').html(modifiedByOptions.join(''));
            $('#ddlSkillHistoryApprovalFieldName').html(fieldOptions.join(''));
            refreshSearchableDropdown($('#ddlSkillHistoryApprovalModifiedBy'));
            refreshSearchableDropdown($('#ddlSkillHistoryApprovalFieldName'));
        }

        function getFilteredSkillHistoryApprovalRows() {
            var modifiedBy = ($('#ddlSkillHistoryApprovalModifiedBy').val() || '').toString();
            var fieldName = ($('#ddlSkillHistoryApprovalFieldName').val() || '').toString();
            return (skillHistoryApprovalRows || []).filter(function (r) {
                var rowModifiedBy = String(getVal(r, 'ModifiedBy') || '');
                var rowField = String(getVal(r, 'FieldName') || '');
                return (!modifiedBy || rowModifiedBy === modifiedBy) && (!fieldName || rowField === fieldName);
            });
        }

        function OnSkillHistoryApprovalFilterChange() {
            skillHistoryApprovalCurrentPage = 1;
            renderSkillHistoryApprovalTable();
        }

        function renderSkillHistoryApprovalTable() {
            //debugger;
            var rows = getFilteredSkillHistoryApprovalRows();
            skillHistoryApprovalTotalRecords = rows.length;
            skillHistoryApprovalTotalPages = Math.max(1, Math.ceil(skillHistoryApprovalTotalRecords / skillHistoryApprovalPageSize));
            if (skillHistoryApprovalCurrentPage > skillHistoryApprovalTotalPages) skillHistoryApprovalCurrentPage = skillHistoryApprovalTotalPages;
            var start = (skillHistoryApprovalCurrentPage - 1) * skillHistoryApprovalPageSize;
            var pageRows = rows.slice(start, start + skillHistoryApprovalPageSize);
            var html = '';
            pageRows.forEach(function (r) {
                html += '<tr>' +
                    '<td>' + escapeHtml(String(getVal(r, 'FieldName') || '-')) + '</td>' +
                    '<td>' + escapeHtml(String(getVal(r, 'OldValue') || '-')) + '</td>' +
                    '<td>' + escapeHtml(String(getVal(r, 'NewValue') || '-')) + '</td>' +
                    '<td>' + escapeHtml(String(getVal(r, 'ModifiedByName') || getVal(r, 'ModifiedBy') || '-')) + '</td>' +
                    '<td>' + escapeHtml(formatDateToDDMMMYYYY(getVal(r, 'ModifiedDate') || '-')) + '</td>' +
                    '</tr>';
            });
            if (!html) html = '<tr><td colspan="5" class="text-center"><%=MyBase.GetResourceString("C_NoData")%>.</td></tr>';
            $('#tblSkillHistoryApprovalBody').html(html);
            $('#skillHistoryApprovalTotalRecords').text(txtTotalRecords + ': ' + skillHistoryApprovalTotalRecords);
            var noHistoryData = skillHistoryApprovalTotalRecords <= 0;
            $('#skillHistoryApprovalPrevBtn').prop('disabled', noHistoryData || skillHistoryApprovalCurrentPage <= 1);
            $('#skillHistoryApprovalNextBtn').prop('disabled', noHistoryData || skillHistoryApprovalCurrentPage >= skillHistoryApprovalTotalPages);
            refreshTooltips();
        }
        function goToSkillHistoryApprovalPreviousPage() {
            if (skillHistoryApprovalCurrentPage > 1) {
                skillHistoryApprovalCurrentPage -= 1;
                renderSkillHistoryApprovalTable();
            }
        }
        function goToSkillHistoryApprovalNextPage() {
            if (skillHistoryApprovalCurrentPage < skillHistoryApprovalTotalPages) {
                skillHistoryApprovalCurrentPage += 1;
                renderSkillHistoryApprovalTable();
            }
        }
        function ApproveSkillRequest(reqId) {
            var comment = ($('#txtActionComment_' + reqId).val() || '').trim();
            if (!comment) {
                alertify.error(alertCommentBlank);
                $('#txtActionComment_' + reqId).focus();
                return;
            }
            var payload = {
                SkillRequestID: parseInt(reqId, 10) || 0,
                RequestStatusID: 3,
                ApprovedBy: approverID,
                ApprovedRejectionReason: comment
            };
            var result = AJAXCallWithResult("api/HRSkillRequestApproval/UpdateSkillRequestStatus", JSON.stringify(payload), false);
            if (result && !(result.error || result.Status === 'ERROR' || result.status === 'ERROR')) {
                // Added by Dipali V On 30th April 2026 For Skill Work flow mail changes
                SendSkillWorkflowApprovalMail(reqId, 3, comment, false);
                alertify.success('<%=MyBase.GetResourceString("C_RApproved")%>.');
                loadApprovalData();
            } else {
                alertify.error(txtUnableApproveRequest);
            }
        }
        function RejectSkillRequest(reqId) {
            //debugger;
            var reason = ($('#txtActionComment_' + reqId).val() || '').trim();
            if (!reason) {
                alertify.error(alertCommentBlank);
                $('#txtActionComment_' + reqId).focus();
                return;
            }
            var payload = {
                SkillRequestID: parseInt(reqId, 10) || 0,
                RequestStatusID: 4,
                ApprovedBy: approverID,
                ApprovedRejectionReason: reason
            };
            var result = AJAXCallWithResult("api/HRSkillRequestApproval/UpdateSkillRequestStatus", JSON.stringify(payload), false);
            if (result && !(result.error || result.Status === 'ERROR' || result.status === 'ERROR')) {
                // Added by Dipali V On 30th April 2026 For Skill Work flow mail changes
                SendSkillWorkflowApprovalMail(reqId, 4, reason, false);
                //alertify.success('Request Rejected Successfully.');
                alertify.success('<%=MyBase.GetResourceString("C_RRejected")%>.');
                loadApprovalData();
            } else {
                alertify.error(txtUnableRejectRequest);
            }
        }
        function ConfirmSingleSkillAction() {
            var comment = ($('#txtSingleSkillActionComment').val() || '').trim();
            if (!comment) {
                alertify.error(alertCommentBlank);
                $('#txtSingleSkillActionComment').focus();
                return;
            }
            var payload = {
                SkillRequestID: pendingActionSkillRequestID,
                RequestStatusID: pendingActionStatusID,
                ApprovedBy: approverID,
                ApprovedRejectionReason: comment,
                IsSingleSkillAction: true
            };
            var result = AJAXCallWithResult("api/HRSkillRequestApproval/UpdateSkillRequestStatus", JSON.stringify(payload), false);
            if (result && !(result.error || result.Status === 'ERROR' || result.status === 'ERROR')) {
                // Added by Dipali V On 30th April 2026 For Skill Work flow mail changes
                SendSkillWorkflowApprovalMail(pendingActionSkillRequestID, pendingActionStatusID, comment, true);
                if (singleSkillActionModalInstance) singleSkillActionModalInstance.hide();
                alertify.success(pendingActionStatusID === 3 ? '<%=MyBase.GetResourceString("C_RApproved")%>.' : '<%=MyBase.GetResourceString("C_RRejected")%>.');
                loadApprovalData();
            } else {
                alertify.error(pendingActionStatusID === 3 ? txtUnableApproveSkill : txtUnableRejectSkill);
            }
        }

        // Added by Codex on 11th May 2026 - normalize approval mail body content.
        function normalizeSkillApprovalMailBody(bodyText) {
            var body = String(bodyText || '');
            if (!body) return body;

            var updatedLabel = String(txtUpdatedSkill || 'Updated Skill').trim();
            var newLabel = String(txtNewSkill || 'New Skill').trim();
            function escapeRegExp(text) {
                return String(text || '').replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
            }

            // Remove "(Updated Skill)" / "(New Skill)" suffix from skill name.
            var suffixRegex = new RegExp("\\s*\\((?:" + escapeRegExp(updatedLabel) + "|" + escapeRegExp(newLabel) + "|Updated\\s*Skill|New\\s*Skill)\\)", "gi");
            body = body.replace(suffixRegex, '');

            // Replace Regards signer with current approver/rejector (logged in approver).
            var signer = String(approverName || '').trim();
            if (signer) {
                body = body.replace(/((?:Thanks\s*&\s*)?Regards,?\s*(?:<br\s*\/?>|\r?\n)\s*)([^<\r\n]+)/ig, function (_m, p1) {
                    return p1 + signer;
                });
            }
            return body;
        }

        // Added by Dipali V On 30th April 2026 For Skill Work flow mail changes
        function SendSkillWorkflowApprovalMail(skillRequestID, requestStatusID, comments, isSingleSkillAction) {
            try {
                var actionType = requestStatusID === 3 ? 'APPROVE' : 'REJECT';
                var messageID = requestStatusID === 3 ? 36106 : 36105;
                var emailDataPayload = {
                    ActionType: actionType,
                    MessageID: messageID,
                    ApprovedBy: approverID,
                    SkillRequestID: parseInt(skillRequestID, 10) || 0,
                    IsSingleSkillAction: !!isSingleSkillAction,
                    Comments: comments || ''
                };
                var emailDataResponse = AJAXCallWithResult("api/HRSkillRequestApproval/GetSkillWorkflowEmailData", JSON.stringify(emailDataPayload), false);
                if (!emailDataResponse || emailDataResponse.error || emailDataResponse.status === 'ERROR' || emailDataResponse.Status === 'ERROR') {
                    return;
                }
                var emailData = emailDataResponse.data;
                if (!emailData) return;
                if (!String(emailData.fromEmailID || '').trim() || !String(emailData.toEmailID || '').trim()) return;

                var sendMailPayload = {
                    FromEmailID: String(emailData.fromEmailID || '').trim(),
                    ToEmailID: String(emailData.toEmailID || '').trim(),
                    CCEmailID: String(emailData.cCEmailID || '').trim(),
                    Subject: String(emailData.subject || ''),
                    Body: normalizeSkillApprovalMailBody(String(emailData.body || '').replace(/\r?\n/g, '<br/>')),
                    AttachmentFilePaths: Array.isArray(emailData.attachmentFilePaths) ? emailData.attachmentFilePaths : []
                };
                // Same behavior as My Leaves: show popup when configured, else send directly.
                if (emailData.showPopup === true) {
                    OpenSkillApprovalMailPreviewModal(sendMailPayload);
                } else {
                    AJAXCallWithResult("api/HRSkillRequestApproval/SendSkillWorkflowEmail", JSON.stringify(sendMailPayload), false);
                    alertify.success('<%=MyBase.GetResourceString("C_EmailSent")%>');
                }
            } catch (mailError) {
                console.log('Skill workflow approval mail skipped:', mailError);
            }
        }

        // Added by Dipali V On 30th April 2026 For Skill Work flow mail changes
        function EnsureSkillApprovalMailPreviewModal() {
            if ($('#skillApprovalMailPreviewModal').length > 0) return;
            var modalHtml = '' +
                '<div class="modal fade custmodal" id="skillApprovalMailPreviewModal" tabindex="-1" aria-hidden="true">' +
                '  <div class="modal-dialog modal-lg modal-dialog-scrollable">' +
                '    <div class="modal-content">' +
                '      <div class="modal-header custmodal">' +
                '        <h5 class="modal-title">Send Mail</h5>' +
                '        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                '      </div>' +
                '      <div class="modal-body">' +
                '        <div class="mb-2"><label class="form-label">From</label><input type="text" id="txtSkillApprovalMailFrom" class="form-control" /></div>' +
                '        <div class="mb-2"><label class="form-label">To</label><input type="text" id="txtSkillApprovalMailTo" class="form-control" /></div>' +
                '        <div class="mb-2"><label class="form-label">CC</label><input type="text" id="txtSkillApprovalMailCC" class="form-control" /></div>' +
                '        <div class="mb-2"><label class="form-label">Subject</label><input type="text" id="txtSkillApprovalMailSubject" class="form-control" /></div>' +
                '        <div class="mb-2"><label class="form-label">Body</label><textarea id="txtSkillApprovalMailBody" class="form-control" rows="10"></textarea></div>' +
                '      </div>' +
                '      <div class="modal-footer">' +
                '        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>' +
                '        <button type="button" class="btn btnyellow" id="btnSendSkillApprovalMailNow">Send</button>' +
                '      </div>' +
                '    </div>' +
                '  </div>' +
                '</div>';
            $('body').append(modalHtml);
            $('#btnSendSkillApprovalMailNow').on('click', function () {
                var payload = {
                    FromEmailID: ($('#txtSkillApprovalMailFrom').val() || '').toString().trim(),
                    ToEmailID: ($('#txtSkillApprovalMailTo').val() || '').toString().trim(),
                    CCEmailID: ($('#txtSkillApprovalMailCC').val() || '').toString().trim(),
                    Subject: ($('#txtSkillApprovalMailSubject').val() || '').toString(),
                    Body: ($('#txtSkillApprovalMailBody').val() || '').toString().replace(/\r?\n/g, '<br/>'),
                    AttachmentFilePaths: (window._skillApprovalMailAttachments || [])
                };
                var mailResult = AJAXCallWithResult("api/HRSkillRequestApproval/SendSkillWorkflowEmail", JSON.stringify(payload), false);
                if (mailResult && !(mailResult.error || mailResult.Status === 'ERROR' || mailResult.status === 'ERROR')) {
                    alertify.success('<%=MyBase.GetResourceString("C_EmailSent")%>');
                    var modalInst = bootstrap.Modal.getInstance(document.getElementById('skillApprovalMailPreviewModal'));
                    if (modalInst) modalInst.hide();
                } else {
                    alertify.error('Unable to send email.');
                }
            });
        }

        // Added by Dipali V On 30th April 2026 For Skill Work flow mail changes
        function OpenSkillApprovalMailPreviewModal(mailData) {
            EnsureSkillApprovalMailPreviewModal();
            window._skillApprovalMailAttachments = Array.isArray(mailData.AttachmentFilePaths) ? mailData.AttachmentFilePaths : [];
            $('#txtSkillApprovalMailFrom').val(mailData.FromEmailID || '');
            $('#txtSkillApprovalMailTo').val(mailData.ToEmailID || '');
            $('#txtSkillApprovalMailCC').val(mailData.CCEmailID || '');
            $('#txtSkillApprovalMailSubject').val(mailData.Subject || '');
            $('#txtSkillApprovalMailBody').val(String(mailData.Body || '').replace(/<br\s*\/?>/gi, '\n'));
            var modalInst = new bootstrap.Modal(document.getElementById('skillApprovalMailPreviewModal'));
            modalInst.show();
        }
        function ApplyApproverFilter() {
            loadApprovalData();
        }
        function OnSkillFilterChange() {
            loadApprovalData();
        }
        function ResetApproverFilter() {
            $('#txtFilterEmployee').val('');
            $('#cboFilterSkill').val('');
            refreshSearchableDropdown($('#cboFilterSkill'));
            loadApprovalData();
        }

        $(document).ready(function () {
            // Hide preloader, show main content
            alertify.set('notifier', 'position', 'top-right');
            $("#MyLeavesSec").hide();
            initializeSearchableDropdowns();
            loadSkillFilterDropdown();
            loadApprovalData();
            refreshTooltips();
            $('#txtSingleSkillActionComment').on('input', function () {
                $('#singleSkillActionCommentCount').text(String(($(this).val() || '').length));
            });
            $('#btnSingleSkillActionYes').on('click', function () {
                ConfirmSingleSkillAction();
            });
        });
        $('#skillHistoryApprovalOffcanvas').on('shown.bs.offcanvas', function () {
            initializeHistoryFilterDropdowns();
            refreshSearchableDropdown($('#ddlSkillHistoryApprovalModifiedBy'));
            refreshSearchableDropdown($('#ddlSkillHistoryApprovalFieldName'));
        });
    </script>
</body>
</html>
