<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_GlobalProjectNew.aspx.vb" Inherits="Whizible.SM_GlobalProjectNew" %>

<!DOCTYPE html>
<html lang="en">
    <%CommonFunctions.General.PlotPageHeadTag("Global Project")%>
<head>
    <meta charset="utf-8">
    <%--<title>Global Project</title>--%>
    <!-- Referencing styles similar to LandingPage_New.aspx -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_new.css" type="text/css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">

    <style>
        /* Global text size normalization for this page */
        /*body,
        body *:not(i):not([class*="fa-"]) {
            font-size: 11.5px !important;
        }*/

        /* body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
        } */
        *, body {
        font-size: 11.5px; 
    }
        .bootstrap-select .dropdown-toggle .filter-option-inner-inner
        {
            margin-top:0px;
        }
    .form-control, .btn, a, p, input, select.form-select {
        font-size: 11.5px !important; 
    }
        /* Layout overrides to match Whizible look */
        .page-header-container {
            background-color: #cccccc2b;
            padding: 15px 20px;
            border-bottom: 1px solid #e0e3ee;
            display: flex;
            align-items: center;
        }

        .borderbtn {
            background: rgb(255, 255, 255);
            border-color: rgb(19, 89, 166);
            color: rgb(19, 89, 166);
            font-weight: 500;
        }

        .borderbtn:hover{
            background: rgb(19, 89, 166);
            color: rgb(255, 255, 255);
        }
        
        .ui-datepicker {
            z-index: 9999 !important;
        }

        #globalProjectDetailsOffcanvas,
        #globalProjectDetailsOffcanvas .offcanvas-header,
        #globalProjectDetailsOffcanvas .offcanvas-body {
            border-radius: 0 !important;
        }

        .btnyellow {
            background: #fbb03b !important;
            color: #fff;
        }

        .btnyellow:hover {
            background: #fbb03b;
            color: #fff;
        }

        .page-title {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
            color: #1e40af;
        }

        .page-subtitle {
            margin: 0;
            font-size: 11.5px;
            color: #6b7280;
            margin-left: 10px;
            padding-top: 5px;
        }

        .main-card {
            background: #fff;
            border-radius: 8px;
            margin: 20px;
            /*border: 1px solid #e5e7eb;*/
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .main-card-header {
            display: flex;
            justify-content: flex-end;
            padding: 15px 20px;
            border-bottom: 1px solid #e5e7eb;
            gap: 20px;
        }

        /* Custom Table */
        .cstm-table {
            width: 100%;
            margin-bottom: 0;
        }

        .cstm-table th {
            color: #6b7280;
            background-color: #f8fafc;
            font-weight: 600;
            font-size: 11.5px;
            /*text-transform: uppercase;*/
            padding: 12px 20px;
            border-bottom: 1px solid #e5e7eb;
            text-align: left;
        }

        .cstm-table td {
            padding: 12px 20px;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
            font-size: 11.5px;
            color: #374151;
        }

        .cstm-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Keep Task Type Maintenance grid aligned for long values */
        #tblProjectTaskTypes {
            table-layout: fixed;
        }

        #tblProjectTaskTypes th:nth-child(1),
        #tblProjectTaskTypes td:nth-child(1) {
            width: 62%;
            white-space: normal;
            word-break: break-word;
            overflow-wrap: anywhere;
        }

        #tblProjectTaskTypes th:nth-child(2),
        #tblProjectTaskTypes td:nth-child(2) {
            width: 23%;
            text-align: center;
            white-space: nowrap;
        }

        #tblProjectTaskTypes th:nth-child(3),
        #tblProjectTaskTypes td:nth-child(3) {
            width: 15%;
            text-align: center;
        }

        .text-center {
            text-align: center !important;
        }

        /* Badges */
        .badge-initiated {
            background-color: #fef3c7;
            color: #d97706;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 500;
            display: inline-block;
        }

        .badge-inprogress {
            background-color: #dbeafe;
            color: #1d4ed8;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 500;
            display: inline-block;
        }
        
        /* Completed */
        .badge-completed {
            background-color: #d1fae5;
            color: #065f46;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 500;
            display: inline-block;
        }

        /* On Hold */
        .badge-onhold {
            background-color: #e5e7eb;
            color: #374151;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 500;
            display: inline-block;
        }

        /* Re Opened */
        .badge-reopened {
            background-color: #fee2e2;
            color: #991b1b;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 500;
            display: inline-block;
        }

        /* Ready for Closure */
        .badge-readyclosure {
            background-color: #ede9fe;
            color: #5b21b6;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 500;
            display: inline-block;
        }

        /* Classes copied from LandingPage_New.aspx */
        .txt_Blue {
            color: #133ea1 !important;
        }

        .font-weight-600 {
            font-weight: 600;
        }

        /* Typography & Action Links */
        .text-blue {
            color: #2563eb;
            text-decoration: none;
            cursor: pointer;
        }

        .text-blue:hover {
            text-decoration: underline;
            color: #1d4ed8;
        }

        .text-green {
            color: #10b981;
        }

        .action-icon {
            color: #ef4444;
            cursor: pointer;
            font-size: 11.5px;
            vertical-align: middle;
        }

        /*.offcanvas.offcanvas-inactive {
            pointer-events: none !important;
        }*/
         /*.offcanvas.offcanvas-inactive {*/
            /* Commented and Added  By Vyankat B. on 21 th April 2026  for child offcanvas opacity effect */
            /* pointer-events: none !important; */
            /*pointer-events: none !important;
            opacity: 0.45 !important;
            transition: opacity 0.2s ease-in-out;*/
            /* End of Commented and Added  By Vyankat B. on 21 th April 2026  for child offcanvas opacity effect */
        /*}
        #tblGenericTasksBody td {
    vertical-align: middle;
}*/
        .offcanvas.offcanvas-inactive {
            /* Commented and Added  By Vyankat B. on 21 th April 2026  for child offcanvas opacity effect */
            /* pointer-events: none !important; */
            pointer-events: none !important;
            /* opacity: 0.45 !important; */
            /* Commented and Added  By Vyankat B. on 22 th April 2026  for keep panel visible but hide text bleed in stacked offcanvas */
            opacity: 1 !important;
            background-color: #f7f9fc !important;
            /* position: relative; */
            filter: brightness(0.65);
            transition: opacity 0.2s ease-in-out;
            /* End of Commented and Added  By Vyankat B. on 22 th April 2026  for keep panel visible but hide text bleed in stacked offcanvas */
            /* End of Commented and Added  By Vyankat B. on 21 th April 2026  for child offcanvas opacity effect */
        }
        /* Commented and Added  By Vyankat B. on 22 th April 2026  for keep panel visible but hide text bleed in stacked offcanvas */
        /* .offcanvas.offcanvas-inactive::after {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.55);
            pointer-events: none;
            z-index: 2;
        }
        .offcanvas.offcanvas-inactive .offcanvas-header,
        .offcanvas.offcanvas-inactive .offcanvas-body {
            opacity: 0 !important;
        } */
        /* End of Commented and Added  By Vyankat B. on 22 th April 2026  for keep panel visible but hide text bleed in stacked offcanvas */
        #tblGenericTasksBody td {
    vertical-align: middle;
}
 
        /* Modals */
        .modal-header-custom {
            padding: 10px 20px;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header-custom .offcanvas-title {
            color: #133ea1 !important;
        }

        .modal-title-custom {
            font-size: 16px;
        }

        .modal-controls-row {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #f3f4f6;
            gap: 20px;
        }

        .control-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .control-label {
            font-size: 11.5px;
            color: #6b7280;
        }

        .form-select-sm {
            height: 30px;
            font-size: 11.5px;
            padding: 2px 10px;
            width: 150px;
        }

        .action-btn:hover {
            color: #1d4ed8;
            /*color: #2563eb;
            text-decoration: underline;*/
        }

        .mandatory-note {
            color: #ef4444;
            font-size: 11.5px;
        }

        .gp-save-btn {
            background-color: #f4ab34 !important;
            color: #ffffff !important;
            border: none !important;
            border-radius: 8px !important;
            padding: 9px 20px !important;
            font-size: 22px;
            font-weight: 500;
            line-height: 1.2;
            box-shadow: none !important;
        }

        .gp-save-btn:hover,
        .gp-save-btn:focus,
        .gp-save-btn:active {
            background-color: #f4ab34 !important;
            color: #ffffff !important;
            border: none !important;
            box-shadow: none !important;
        }

        .default-note {
            color: #2563eb;
            font-size: 11.5px;
            font-style: italic;
        }

        .sub-tasks-section {
            background: #f9fafb;
            border-radius: 6px;
            padding: 15px;
            margin-top: 20px;
        }

        .sub-tasks-title {
            font-weight: 600;
            font-size: 11.5px;
            color: #111827;
            margin-bottom: 10px;
        }

        .task-type-link {
            font-size: 11.5px;
            margin-left: auto;
        }

        .maintenance-add-row {
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cursor-pointer {
            cursor: pointer;
            font-size: 11.5px;
        }

        .asterisk-danger {
            color: #dc3545;
            margin-left: 4px;
        }

        .sub-task-border {
            border: 1px solid #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
            background-color: #fff;
        }

        .record-count {
            text-align: right;
            margin-top: 10px;
            font-size: 11.5px;
            color: #6b7280;
        }

        .footer-row {
            border-color: #e5e7eb;
            padding: 15px;
            display: flex;
            justify-content: flex-end;
            border-top: 1px solid #e5e7eb;
        }

        .btn-set-default {
            background-color: #2563eb;
            border: none;
            padding: 6px 16px;
            color: #fff;
            font-size: 11.5px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-set-default:hover {
            background-color: #1d4ed8;
        }

        .task-type-wrapper {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 4px;
            border: 1px solid #f8f9fa;
        }
        .task-type-wrapper_1 {
    margin-bottom: 20px;
    padding: 4px 20px;
    margin-left: 20px;
    background-color: #f8f9fa;
    border-radius: 4px;
    border: 1px solid #f8f9fa;
}
        .task-type-label {
            font-size: 11.5px;
            color: #6b7280;
            margin-bottom: 5px;
            display: block;
        }

        .task-type-select {
            width: calc(100% - 20px);
            display: inline-block;
        }

        .folder-icon {
            color: #3b82f6;
            margin-right: 8px;
        }

        .filter-icon {
            color: #6b7280;
        }

        /* Toggle specific classes */
        .form-switch .form-check-input {
            width: 2em;
            height: 1em;
            cursor: pointer;
        }

        /* Pagination */
        .pagination-container {
            background: white;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 0.75rem 0;
            gap: 1rem;
            border-top: 1px solid #eee;
            margin: 0 20px 1rem 20px;
            font-size: 11.5px;
        }

        .pagination-container button {
            font-size: 11.5px;
            padding: 3px 8px;
        }
    </style>
</head>

<body>

    <!-- SS1: Main Page -->
    <%If m_blnViewAccess = True Then%>
    <div class="py-3 px-4 border-bottom-0">        
        <%--<div class="d-flex align-items-center">
            <div class="d-flex align-items-center justify-content-center rounded me-3"
                style="width: 48px; height: 48px; background-color: #cccccc03;">
                <i class="far fa-folder" style="font-size: 22px; color: #3b82f6;"></i>
                <i class="fas fa-globe" style="font-size: 22px; color: #3b82f6;"></i>
            </div>
            <div>
                <h5 class="page-title mb-1" style="font-size: 18px; color: #1e40af; margin: 0; padding: 0;"><%=MyBase.GetResourceString("C_PageCaption") %></h5>
                <div style="color: #6b7280; font-weight: normal; margin: 0;"><%=MyBase.GetResourceString("C_PageNote") %></div>
            </div>
        </div>--%>
    <div class="page-header-section" style="background: white;">
            <div class="graybg" style="padding: 0.4rem 1rem; margin-left: 0;">
                <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                   <i class="fas fa-globe pe-2" style="font-size: 22px;"></i>
                   <%=MyBase.GetResourceString("C_PageCaption") %>
                </h2>
                <p style="color: #6b7280; margin: 0;"><%=MyBase.GetResourceString("C_PageNote") %></p>
            </div>
        </div>
    </div>

    <!-- Buttons + Add / Y Filters are located here natively -->
    <div class="main-card">
        <div class="main-card-header d-flex justify-content-between align-items-center">

    <!-- LEFT SIDE -->
            <div class="d-flex align-items-center">

                <!-- Project Code -->
                <div class="d-flex align-items-center me-4">
                    <label for="txtProjectCode"
                        style="margin-right: 6px;">
                        <%=MyBase.GetResourceString("C_PROJECTCODE") %> :
                    </label>
                    <input type="text" id="txtProjectCode" class="form-control" oninput="onFilterChange()"
                        style="width: 180px; " />
                </div>

                <!-- Project Name -->
                <div class="d-flex align-items-center">
                    <label for="txtProjectName"
                        style="margin-right: 6px;">
                        <%=MyBase.GetResourceString("C_PROJECTNAME") %> :
                    </label>
                    <input type="text" id="txtProjectName" class="form-control" oninput="onFilterChange()"
                        style="width: 200px;" />
                </div>

            </div>

            <!-- RIGHT SIDE -->
            <div>
                <%--<button type="button" class="btn btnyellow mr-5" id="btnShowprjcts">Show</button>--%>
                <%If m_blnAddAccess = True Then%>
                <a class="btn borderbtn addbtn"
                    id="btnAddGP"
                    data-bs-toggle="tooltip"
                    data-bs-title="Add Project"
                    onclick="AddGlobalProject()">
                    <i class="fa fa-plus"></i> <%=MyBase.GetResourceString("C_Add") %>
                </a>
                <%End If%>
            </div>

        </div>
        <table id="tblGlobalProject" class="cstm-table">
            <thead>
                <tr>
                    <th><%=MyBase.GetResourceString("C_PrjCode") %></th>
                    <th><%=MyBase.GetResourceString("C_PrjName") %></th>
                    <th><%=MyBase.GetResourceString("C_PrjStatus") %></th>
                    <th><%=MyBase.GetResourceString("C_StrtDate") %></th>
                    <th><%=MyBase.GetResourceString("C_Endate") %></th>
                    <th class="text-center"><%=MyBase.GetResourceString("C_Acton") %></th>
                </tr>
            </thead>
            <tbody id="tblGlobalProjectBody">
                <%--<tr>
                    <td>CA</td>
                    <td><a class="text-blue" onclick="openOffcanvas('globalProjectDetailsOffcanvas')">Corporate
                            Activity</a></td>
                    <td><span class="badge-initiated">Initiated</span></td>
                    <td>01/01/2024</td>
                    <td>02/29/2028</td>
                    <td class="text-center">
                        <i class="far fa-eye me-2" onclick="openOffcanvas('globalProjectDetailsOffcanvas')"
                            style="cursor: pointer; font-size: 14px; color: #3b82f6;" title="View/Edit"></i>
                        <i class="far fa-trash-alt action-icon" title="Delete"></i>
                    </td>
                </tr>
                <tr>
                    <td>DP</td>
                    <td><a class="text-blue" onclick="openOffcanvas('globalProjectDetailsOffcanvas')">Digital
                            Platform</a></td>
                    <td><span class="badge-inprogress">In Progress</span></td>
                    <td>03/15/2024</td>
                    <td>12/31/2025</td>
                    <td class="text-center">
                        <i class="far fa-eye me-2" onclick="openOffcanvas('globalProjectDetailsOffcanvas')"
                            style="cursor: pointer; font-size: 14px; color: #3b82f6;" title="View/Edit"></i>
                        <i class="far fa-trash-alt action-icon" title="Delete"></i>
                    </td>
                </tr>
                <tr>
                    <td>HR</td>
                    <td><a class="text-blue" onclick="openOffcanvas('globalProjectDetailsOffcanvas')">HR
                            Transformation</a></td>
                    <td><span class="badge-initiated">Initiated</span></td>
                    <td>06/01/2024</td>
                    <td>06/30/2026</td>
                    <td class="text-center">
                        <i class="far fa-eye me-2" onclick="openOffcanvas('globalProjectDetailsOffcanvas')"
                            style="cursor: pointer; font-size: 14px; color: #3b82f6;" title="View/Edit"></i>
                        <i class="far fa-trash-alt action-icon" title="Delete"></i>
                    </td>
                </tr>--%>
            </tbody>
        </table>
        <%--<div class="records-footer" id="totalRecords">
            Total Records: 3
        </div>--%>
        <div class="pagination-container">
            <span id="totalRecords" style="color: #6b7280; font-size: 11.5px;"><%=MyBase.GetResourceString("C_TotalRecords") %>: 0</span>
            <div style="display: flex; gap: 0.5rem;">
                <button class="btn borderbtn" id="gpPrevBtn" onclick="goToPrevPage()" data-bs-toggle="tooltip" data-bs-title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                <button class="btn borderbtn" id="gpNextBtn" onclick="goToNextPage()" data-bs-toggle="tooltip" data-bs-title="Next Page"><i class="fas fa-angle-double-right"></i></button>
            </div>
        </div>
    </div>

    <!-- NEW: Global Project Details Offcanvas (SS1) -->
    <div class="offcanvas offcanvas-end shadow" style="width: 800px;" id="globalProjectDetailsOffcanvas" tabindex="-1">
        <div class="offcanvas-header modal-header-custom graybg">
            <h5 class="offcanvas-title mb-0" style="color: #1e40af; font-weight:600;"><%=MyBase.GetResourceString("C_PageCaption") %></h5>
            <button type="button" class="close" data-bs-dismiss="offcanvas"
                style="background:transparent; border:none; font-size:18px; font-weight:300; opacity:0.5; line-height:1; padding:0;" data-bs-toggle="tooltip" data-bs-title="Close">&times;</button>
        </div>
        <div class="offcanvas-body p-0">
            <!-- Top Nav Row -->
            <%--<div class="d-flex align-items-center p-3 bg-white border-bottom gap-4" style="font-size: 11.5px;">
                <a id="btnSelectGenericTask" class="action-btn text-blue" onclick="openOffcanvasGenericTasks()"><i
                        class="fas fa-list me-1"></i> <%=MyBase.GetResourceString("C_SelGentask") %></a>
                <a id="btnTaskTypeMaintenance" class="action-btn text-secondary" onclick="openOffcanvastaskTypeMaintainance()"><i
                        class="fas fa-cog me-1"></i> <%=MyBase.GetResourceString("C_TTMain") %></a>
            </div>--%>

            <div class="d-flex p-3 bg-white border-bottom gap-2" style="justify-content: flex-end;">   
                <a id="btnSelectGenericTask" class="btn borderbtn addbtn" onclick="openOffcanvasGenericTasks()">
                    <i class="fas fa-list me-1"></i> 
                    <%=MyBase.GetResourceString("C_SelGentask") %>
                </a>
                <a id="btnTaskTypeMaintenance" class="btn borderbtn addbtn" onclick="openOffcanvastaskTypeMaintainance()">
                    <i class="fas fa-cog me-1"></i> 
                    <%=MyBase.GetResourceString("C_TTMain") %>
                </a>
            </div>

            <div class="p-4">
                <%--<div class="bg-white border rounded p-4 mb-4">--%>
                <div>
                    <div class="text-end mb-2">
                        <button type="button" class="btn btnyellow borderbtn gp-save-btn" id="btnSaveGlblPrjct" onclick="saveGlobalProject()"><%=MyBase.GetResourceString("C_Save") %></button>
                    </div>
                    <div class="text-end mb-3">
                        <span class="mandatory-note">( * <%=MyBase.GetResourceString("C_Mandatory") %> )</span>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label class="form-label" style="color: #6b7280;"><%=MyBase.GetResourceString("C_PrjName") %> <span
                                    class="text-danger">*</span></label>
                            <%--<input type="text" id="offcanvasProjectName" class="form-control form-control-sm" value="">--%>
                            <% CommonFunctions.HTMLControls.DrawTextBox("offcanvasProjectName", "offcanvasProjectName", "form-control form-control-sm ",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='50' oninput='if(this.value.length>50)this.value=this.value.slice(0,50);'",,, True,,,, True) %>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" style="color: #6b7280;"><%=MyBase.GetResourceString("C_PrjCode") %> <span
                                    class="text-danger">*</span></label>
                            <%--<input type="text" id="offcanvasProjectCode" class="form-control form-control-sm" value="">--%>
                            <% CommonFunctions.HTMLControls.DrawTextBox("offcanvasProjectCode", "offcanvasProjectCode", "form-control form-control-sm",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='50' oninput='if(this.value.length>50)this.value=this.value.slice(0,50);'",,, True,,,, True) %>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label" style="color: #6b7280;"><%=MyBase.GetResourceString("C_ProjectGroup") %></label>
                            <select id="offcanvasProjectGroup" class="selectpicker form-control" data-live-search="true" data-width="100%">
                                <%--<option value="">-- Select --</option>--%>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label class="form-label" style="color: #6b7280;"><%=MyBase.GetResourceString("C_StrtDate") %></label>
                            <%--<input type="text" id="offcanvasStartDate" class="form-control form-control-sm" value="">--%>
                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("offcanvasStartDate", "offcanvasStartDate", "form-control fas fa-calendar-alt",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='255'",,, True,,,, True) %>--%>
                            <div class="input-group">
                            <% CommonFunctions.HTMLControls.DrawTextBox("offcanvasStartDate", "offcanvasStartDate", "form-control",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='255'",,, True,,,, True) %>

                            <span class="input-group-text" id="offcanvasStartDateIcon" style="cursor:pointer;">
                                <i class="fas fa-calendar-alt"></i>
                            </span>
                        </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" style="color: #6b7280;"><%=MyBase.GetResourceString("C_Endate") %></label>
                            <%--<input type="text" id="offcanvasEndDate" class="form-control form-control-sm" value="">--%>
                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("offcanvasEndDate", "offcanvasEndDate", "form-control",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='255'",,, True,,,, True) %>--%>
                            <div class="input-group">
                            <% CommonFunctions.HTMLControls.DrawTextBox("offcanvasEndDate", "offcanvasEndDate", "form-control",,,,,,,,,, " onpaste='return true;' autocomplete='off' maxlength='255'",,, True,,,, True) %>

                            <span class="input-group-text" id="offcanvasEndDateIcon" style="cursor:pointer;">
                                <i class="fas fa-calendar-alt"></i>
                            </span>
                        </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label" style="color: #6b7280;"><%=MyBase.GetResourceString("C_PrjStatus") %> <span
                                    class="text-danger">*</span></label>
                            <select id="offcanvasProjectStatus" class="selectpicker form-control" data-live-search="true" data-width="100%">
                                <%--<option value="">-- Select --</option>--%>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label class="form-label" style="color: #6b7280;"><%=MyBase.GetResourceString("C_Description") %></label>
                            <textarea id="offcanvasDescription" class="form-control" rows="4" maxlength="500" oninput="if(this.value.length>500)this.value=this.value.slice(0,500);"></textarea>
                            <%--<%CommonFunctions.HTMLControls.DrawTextArea("offcanvasDescription", "offcanvasDescription", "", "form-control", , , , , , , 2000, , , "height: 34px;line-height: 1.5!important;", , , , , "", , , , , , , , , , )%>--%>
                        </div>
                    </div>

                    <div class="row mb-4" id="overRow">
                        <div class="col-md-12">
                            <div class="form-check">
                                <input class="certification-checkbox" type="checkbox" name="projectType" id="radioOver">
                                <label class="form-check-label" for="chkOver"
                                    style="color: #6b7280;">
                                    <%=MyBase.GetResourceString("C_Over") %>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white border rounded overflow-hidden">
                    <div class="bg-light p-3 border-bottom" style="font-weight: 600; color: #111827;">
                        <%=MyBase.GetResourceString("C_CustomFields") %>
                    </div>
                    <div class="p-4 text-center" style="color: #6b7280;">
                        No custom fields have been defined
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- SS2: Select Generic Tasks Offcanvas -->
    <div class="offcanvas offcanvas-end shadow" style="width: 700px;" id="selectGenericTasksModal" tabindex="-1">
        <div class="offcanvas-header modal-header-custom graybg">
            <h5 class="offcanvas-title txt_Blue font-weight-600 mb-0"><%=MyBase.GetResourceString("C_SelGenTasks") %></h5>
            <button type="button" class="close" data-bs-dismiss="offcanvas"
                style="background:transparent; border:none; font-size:18px; font-weight:300; opacity:0.5; line-height:1; padding:0;" data-bs-toggle="tooltip" data-bs-title="Close">&times;</button>
        </div>
        <!-- Action removed per request: "remove Back and Save and Add button" -->
        <div class="offcanvas-body">
            <div class="modal-controls-row d-flex align-items-end">
                <%--<div class="control-group">
                    <label class="control-label">Generic Task</label>
                    <select class="form-select form-select-sm">
                        <option>All</option>
                    </select>adityaji
                </div>--%>

                <%--<a class="text-blue task-type-link" onclick="openOffcanvas('taskTypeMaintenanceModal')">Task Type
                    Maintenance</a>--%>
                <div class="ms-auto">
                 <%If m_blnAddAccess = True Then%>
                <a class="btn borderbtn addbtn"
                   id="btnAddGenTasks"
                   data-bs-toggle="tooltip"
                   data-bs-title="Add generic Tasks"
                   onclick="AddGenericTasks()">
                    <i class="fa fa-plus"></i> <%=MyBase.GetResourceString("C_Add") %>
                </a>
                <%End If%>
    </div>
           
                </div>
                           

             <div class="task-type-wrapper_1 row">
                  <div class="col-sm-8">
                <%-- Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type mandatory mark alignment --%>
                <%-- <label class="task-type-label"><%=MyBase.GetResourceString("C_TaskType") %></label> --%>
                <label class="task-type-label"><%=MyBase.GetResourceString("C_TaskType") %> </label>
                <select id="ddlTaskType" class="selectpicker form-control task-type-select" data-live-search="true" data-width="100%" onchange="onTaskTypeChange()">
                    <%--<option><%=MyBase.GetResourceString("C_TaskType") %></option>--%>
                </select>
                <%-- <span class="asterisk-danger">*</span> --%>
                <%-- End of Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type mandatory mark alignment --%>
                      </div>
                 <div class="col-sm-4"></div>
            </div>


            <table class="cstm-table" id="tblGenericTasks">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_GENERICTASK") %></th>
                        <th><%=MyBase.GetResourceString("C_TskType") %></th>
                        <th><%=MyBase.GetResourceString("C_BILLABLE") %></th>
                        <th style="width:80px;" class="text-center"><%=MyBase.GetResourceString("C_Acton") %></th>
                    </tr>
                </thead>
                <tbody id="tblGenericTasksBody">
                    <%--<tr>
                        <td><a class="text-blue">Daily DataScouting</a></td>
                        <td><a class="text-blue" onclick="openOffcanvas('taskTypeMaintenanceModal')">SandBox Task Type
                                1</a></td>
                        <td>No</td>
                        <td class="text-center">
                            <div class="form-check form-switch d-flex justify-content-center m-0"><input
                                    class="form-check-input" type="checkbox" checked></div>
                        </td>
                    </tr>
                    <tr>
                        <td><a class="text-blue">Documentation</a></td>
                        <td><a class="text-blue" onclick="openOffcanvas('taskTypeMaintenanceModal')">SandBox Task Type
                                1</a></td>
                        <td class="text-green">Yes</td>
                        <td class="text-center">
                            <div class="form-check form-switch d-flex justify-content-center m-0"><input
                                    class="form-check-input" type="checkbox" checked></div>
                        </td>
                    </tr>
                    <tr>
                        <td><a class="text-blue">Flexible Tasks</a></td>
                        <td><a class="text-blue" onclick="openOffcanvas('taskTypeMaintenanceModal')">SandBox Task Type
                                1</a></td>
                        <td>No</td>
                        <td class="text-center">
                            <div class="form-check form-switch d-flex justify-content-center m-0"><input
                                    class="form-check-input" type="checkbox" checked></div>
                        </td>
                    </tr>
                    <tr>
                        <td><a class="text-blue">General Administrative Tasks</a></td>
                        <td><a class="text-blue" onclick="openOffcanvas('taskTypeMaintenanceModal')">SandBox Task Type
                                1</a></td>
                        <td>No</td>
                        <td class="text-center">
                            <div class="form-check form-switch d-flex justify-content-center m-0"><input
                                    class="form-check-input" type="checkbox" checked></div>
                        </td>
                    </tr>
                    <tr>
                        <td><a class="text-blue">Operational Support</a></td>
                        <td><a class="text-blue" onclick="openOffcanvas('taskTypeMaintenanceModal')">SandBox Task Type
                                1</a></td>
                        <td>No</td>
                        <td class="text-center">
                            <div class="form-check form-switch d-flex justify-content-center m-0"><input
                                    class="form-check-input" type="checkbox" checked></div>
                        </td>
                    </tr>
                    <tr>
                        <td><a class="text-blue">Pending Assignments</a></td>
                        <td><a class="text-blue" onclick="openOffcanvas('taskTypeMaintenanceModal')">SandBox Task Type
                                1</a></td>
                        <td>No</td>
                        <td class="text-center">
                            <div class="form-check form-switch d-flex justify-content-center m-0"><input
                                    class="form-check-input" type="checkbox" checked></div>
                        </td>
                    </tr>
                    <tr>
                        <td><a class="text-blue">Production Support</a></td>
                        <td><a class="text-blue" onclick="openOffcanvas('taskTypeMaintenanceModal')">SandBox Task Type
                                1</a></td>
                        <td>No</td>
                        <td class="text-center">
                            <div class="form-check form-switch d-flex justify-content-center m-0"><input
                                    class="form-check-input" type="checkbox" checked></div>
                        </td>
                    </tr>--%>
                </tbody>
            </table>
            <div class="pagination-container">
            <span id="totalRecordsGenTasks" style="color: #6b7280;"><%=MyBase.GetResourceString("C_TotalRecords") %>: 0</span>
            <div style="display: flex; gap: 0.5rem;">
                <button class="btn borderbtn" id="gentasksPrevBtn" onclick="goToPrevPageGenTasks()" data-bs-toggle="tooltip" data-bs-title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                <button class="btn borderbtn" id="genTasksNextBtn" onclick="goToNextPageGenTasks()" data-bs-toggle="tooltip" data-bs-title="Next Page"><i class="fas fa-angle-double-right"></i></button>
            </div>
        </div>
        </div>
    </div>

    <!-- SS3: Task Type Maintenance Offcanvas -->
    <div class="offcanvas offcanvas-end shadow" style="width: 600px;" id="taskTypeMaintenanceModal" tabindex="-1">
        <div class="offcanvas-header modal-header-custom graybg">
            <h5 class="offcanvas-title txt_Blue font-weight-600 mb-0"><%=MyBase.GetResourceString("C_TTMain") %></h5>
            <button type="button" class="close" data-bs-dismiss="offcanvas"
                style="background:transparent; border:none; font-size:18px; font-weight:300; opacity:0.5; line-height:1; padding:0;" data-bs-toggle="tooltip" data-bs-title="Close">&times;</button>
        </div>
        <div class="offcanvas-body p-0">
            <div class="maintenance-add-row">
                <div class="default-note">( <%=MyBase.GetResourceString("C_BlueColorNote") %> )</div>
                <%If m_blnAddAccess = True Then%>
                <button type="button" class="btn borderbtn addnewbtn" onclick="openOffcanvastaskTypeModal()">
                    <i class="fas fa-plus"></i> <span class="ms-1"><%=MyBase.GetResourceString("C_Add") %></span>
                </button>
                <%End If%>
            </div>
            <table class="cstm-table" id="tblProjectTaskTypes">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_TskType") %></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_SETASDEFAULT") %></th>
                        <%-- Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type grid header rename --%>
                        <%-- <th class="text-center"><%=MyBase.GetResourceString("C_DELETE") %></th> --%>
                        <th class="text-center"><%=MyBase.GetResourceString("C_Acton") %></th>
                        <%-- End of Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type grid header rename --%>
                    </tr>
                </thead>
                <tbody id="tblProjectTaskTypesBody">
                    <%--<tr>
                        <td><a class="text-blue">SandBox Task Type 1</a></td>
                        <td class="text-center text-blue cursor-pointer">Set as Default</td>
                        <!-- Modified from empty circle to delete icon per instructions -->
                        <td class="text-center"><i class="far fa-trash-alt action-icon"></i></td>
                    </tr>--%>
                </tbody>
            </table>
            <div class="pagination-container">
                <span id="totalRecordsTaskTypes" style="color: #6b7280;"><%=MyBase.GetResourceString("C_TotalRecords") %>: 0</span>
                <div style="display: flex; gap: 0.5rem;">
                    <button class="btn borderbtn" id="taskTypesPrevBtn" onclick="goToPrevPageTaskTypes()" data-bs-toggle="tooltip" data-bs-title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                    <button class="btn borderbtn" id="taskTypesNextBtn" onclick="goToNextPageTaskTypes()" data-bs-toggle="tooltip" data-bs-title="Next Page"><i class="fas fa-angle-double-right"></i></button>
                </div>
            </div>
        </div>
    </div>

    <!-- SS4: Task Type Offcanvas -->
    <div class="offcanvas offcanvas-end shadow" style="width: 500px;" id="taskTypeModal" tabindex="-1">
        <div class="offcanvas-header modal-header-custom graybg">
            <h5 class="offcanvas-title txt_Blue font-weight-600 mb-0"><%=MyBase.GetResourceString("C_TaskType") %></h5>
            <button type="button" class="close" data-bs-dismiss="offcanvas"
                style="background:transparent; border:none; font-size:18px; font-weight:300; opacity:0.5; line-height:1; padding:0;" data-bs-toggle="tooltip" data-bs-title="Close">&times;</button>
        </div>
        <div class="offcanvas-body p-4">
            <div class="d-flex justify-content-end align-items-center gap-2 mb-3">
                <button type="button" class="btn borderbtn" id="btnSetAsDefaultTTModal" onclick="setAsDefaultFromModal()" style="display:none;"><%=MyBase.GetResourceString("C_STASDeflt") %></button>
                <button type="button" class="btn btnyellow borderbtn gp-save-btn" id="btnSaveTTPMNT" onclick="saveTaskTypeMaintainance()"><%=MyBase.GetResourceString("C_Save") %></button>
            </div>
            <%-- Commented and Added  By Vyankat B. on 21 th April 2026  for Mandatory note in Task Type modal --%>
            <%--<div class="text-end mb-3">
                <span class="mandatory-note">( * <%=MyBase.GetResourceString("C_Mandatory") %> )</span>
            </div>--%>
            <%-- End of Commented and Added  By Vyankat B. on 21 th April 2026  for Mandatory note in Task Type modal --%>

            <div class="task-type-wrapper">
                <%-- Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type mandatory mark alignment --%>
                <%-- <label class="task-type-label"><%=MyBase.GetResourceString("C_TaskType") %></label> --%>
                <label class="task-type-label"><%=MyBase.GetResourceString("C_TaskType") %> <span class="asterisk-danger">*</span></label>
                <select id="ddlTaskTypeMaintainance" class="selectpicker form-control task-type-select" data-live-search="true" data-width="100%">
                    <option><%=MyBase.GetResourceString("C_NewTaskType") %></option>
                </select>
                <%-- <span class="asterisk-danger">*</span> --%>
                <%-- End of Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type mandatory mark alignment --%>
            </div>

            <!-- Sub Tasks section — only shown in Edit mode when sub tasks exist -->
            <div class="sub-tasks-section" id="subTasksSection" style="display:none;">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <div class="sub-tasks-title mb-0"><%=MyBase.GetResourceString("C_SubTasks") %></div>
                    <%If m_blnAddAccess = True Then%>
                    <button type="button" class="btn borderbtn addnewbtn" id="btnAddSubTaskType" onclick="openAddSubTaskTypeModal()">
                        <i class="fas fa-plus"></i> <span class="ms-1"><%=MyBase.GetResourceString("C_Add") %></span>
                    </button>
                    <%End If%>
                </div>
                <table class="cstm-table sub-task-border" id="tblSubTaskTypes">
                    <thead>
                        <tr>
                            <th><%=MyBase.GetResourceString("C_SubTaskType") %></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_Acton") %></th>
                        </tr>
                    </thead>
                    <tbody id="tblSubTaskTypesBody">
                    </tbody>
                </table>
                <div class="pagination-container" style="margin: 0; padding: 0.5rem 0;">
                    <span id="totalRecordsSubTasks" style="color: #6b7280;"><%=MyBase.GetResourceString("C_TotalRecords") %>: 0</span>
                    <div style="display: flex; gap: 0.5rem;">
                        <button class="btn borderbtn" id="subTasksPrevBtn" onclick="goToPrevPageSubTasks()" data-bs-toggle="tooltip" data-bs-title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                        <button class="btn borderbtn" id="subTasksNextBtn" onclick="goToNextPageSubTasks()" data-bs-toggle="tooltip" data-bs-title="Next Page"><i class="fas fa-angle-double-right"></i></button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- SS6: Add Sub Task Type Offcanvas -->
    <div class="offcanvas offcanvas-end shadow" style="width: 450px;" id="addSubTaskTypeModal" tabindex="-1">
        <div class="offcanvas-header modal-header-custom graybg">
            <h5 class="offcanvas-title txt_Blue font-weight-600 mb-0"><%=MyBase.GetResourceString("C_AddSubTaskType") %></h5>
            <button type="button" class="close" data-bs-dismiss="offcanvas"
                style="background:transparent; border:none; font-size:18px; font-weight:300; opacity:0.5; line-height:1; padding:0;">&times;</button>
        </div>
        <div class="offcanvas-body p-4">
            <div class="d-flex justify-content-end mb-3">
                <button type="button" class="btn btnyellow borderbtn gp-save-btn" id="btnSaveSubTaskType" onclick="saveProjectSubTaskType()"><%=MyBase.GetResourceString("C_Save") %></button>
            </div>
            <div class="task-type-wrapper">
                <label class="task-type-label"><%=MyBase.GetResourceString("C_SubTaskType") %> <span class="asterisk-danger">*</span></label>
                <select id="ddlSubTaskType" class="selectpicker" style="width:100%;" data-live-search='true'>
                </select>
            </div>
        </div>
    </div>

    <!-- Delete Alert modal start here-->
    <div id="GPDeleteAlertModal" class="modal fade custmodal" data-bs-backdrop="static"  role="dialog" aria-hidden="false">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal" onclick="clearDelete()">×</button>
                    <h4 class="modal-title"><i class="far fa-check-circle confirmIcn me-2"></i><%=MyBase.GetResourceString("C_ConfirmDelete") %></h4>
                </div>

                <div class="modal-body">
                    <p class="text-center"  id="txtDeleteAlert"><%=MyBase.GetResourceString("C_DeleteNote") %></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="clearDelete()"><%=MyBase.GetResourceString("C_No") %></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal"  onclick="handleConfirmDelete()"><%=MyBase.GetResourceString("C_Yes") %></button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Delete Alert modal end here-->

    <div class="offcanvas offcanvas-end shadow" style="width: 600px;" id="genericTaskMappingModal" tabindex="-1">
    <div class="offcanvas-header modal-header-custom graybg">
        <h5 class="offcanvas-title txt_Blue font-weight-600 mb-0"><%=MyBase.GetResourceString("C_GenTask") %></h5>
        <button type="button" class="close" data-bs-dismiss="offcanvas"
            style="background:transparent; border:none; font-size:18px; font-weight:300; opacity:0.5; line-height:1; padding:0;">&times;</button>
    </div>

    <div class="offcanvas-body">

    <div class="d-flex justify-content-end align-items-end">

        <!-- Dropdown -->

        <!-- Save Button -->
        <div class="ms-2">
            <button type="button" 
                    class="btn btnyellow borderbtn gp-save-btn" 
                    id="btnSaveGenTasks" 
                    onclick="saveGenericTasks()">
                <%=MyBase.GetResourceString("C_Save") %>
            </button>
        </div>

    </div>
                             <div class="row">
                  <div class="task-type-wrapper_1 col-sm-8">
                <%-- <label class="task-type-label"><%=MyBase.GetResourceString("C_GenTask") %></label> --%>
                <label class="task-type-label"><%=MyBase.GetResourceString("C_GenTask") %> <span class="asterisk-danger">*</span></label>
                <select id="ddlGenericTask" class="selectpicker form-control task-type-select" data-live-search="true" data-width="100%" onchange="onTaskTypeChange()">
                    <%--<option><%=MyBase.GetResourceString("C_TaskType") %></option>--%>
                </select>
                      </div>
                 <div class="col-sm-4"></div>
            </div>

</div>
</div>

    <%Else %>
            <div id="ViewAccess" class="tab-pane" style="height: 448px">
                <div style="text-align: center">
                    <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %></p>
                </div>
            </div>
            <%End If %>
    <!-- Required Scripts for Bootstrap interactions -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>--%>
    
    
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var sessionProjectId = '<%=Session("intProjectID")%>';
        var currentPage = 1;
        var pageSize = 5;
        var globalProjectID = '';
        var globalTaskTypeID = '';
        var globalTaskID = '';
        var globalSubTaskTypeID = '';
        var deleteContext = '';
        var isProjectEditMode = false;
        var gtCurrentPage = 1;
        var gtPageSize = 5;
        var ttCurrentPage = 1;
        var ttPageSize = 5;
        var globalTaskTypeID = '';
        var stCurrentPage = 1;
        var stPageSize = 5;

        $(document).ready(function () {
            getGlobalProjectList(0);
            //initializeGlobalProjectDatePickers();
            initializeTooltips();
            //initializeSelectPickers();
            initializeOffcanvasStacking();

            $('#globalProjectDetailsOffcanvas').on('shown.bs.offcanvas', function () {
                initializeGlobalProjectDatePickers();
                // Commented and Added  By Vyankat B. on 22 th April 2026  for Global Project offcanvas scroll reset on open
                this.scrollTop = 0;
                $(this).find('.offcanvas-body').scrollTop(0);
                // End of Commented and Added  By Vyankat B. on 22 th April 2026  for Global Project offcanvas scroll reset on open
            });

            $(document).on('click', '[data-bs-toggle="tooltip"]', function () {
                var instance = bootstrap.Tooltip.getInstance(this);
                if (instance) {
                    instance.hide();
                }
                this.blur();
            });
        });

        function initializeOffcanvasStacking() {
            var offcanvasSelector = '#globalProjectDetailsOffcanvas, #selectGenericTasksModal, #taskTypeMaintenanceModal, #taskTypeModal, #addSubTaskTypeModal, #genericTaskMappingModal';

            $(document).on('shown.bs.offcanvas hidden.bs.offcanvas', offcanvasSelector, function () {
                updateOffcanvasInteractivity();
            });

            updateOffcanvasInteractivity();
        }

        function updateOffcanvasInteractivity() {
            var $openOffcanvas = $('.offcanvas.show');

            if ($openOffcanvas.length === 0) {
                $('.offcanvas').removeClass('offcanvas-inactive');
                return;
            }

            var $topMost = $openOffcanvas.last();
            $openOffcanvas.removeClass('offcanvas-inactive');
            $openOffcanvas.not($topMost).addClass('offcanvas-inactive');
        }

        function initializeGlobalProjectDatePickers() {
            //if (typeof $.fn.datepicker !== 'function') {
            //    alert(23);
            //    return;
            //}

            var $dateInputs = $('#offcanvasStartDate, #offcanvasEndDate');

            $dateInputs.datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+10',
                dateFormat: 'dd M yy',
                showOn: 'focus',
                onClose: function () {
                    $(':focus').blur();
                }
            });

            $dateInputs.off('click focus').on('click focus', function () {
                $(this).datepicker('show');
            });
        }

        function initializeSelectPickers() {
            if (typeof $.fn.selectpicker === 'undefined') return;
            [
                '#offcanvasProjectGroup',
                '#offcanvasProjectStatus',
                '#ddlTaskType',
                '#ddlGenericTask',
                '#ddlTaskTypeMaintainance'
            ].forEach(function (selector) {
                refreshSelectPicker(selector);
            });
        }

        function refreshSelectPicker(selector) {            
            if (typeof $.fn.selectpicker === 'undefined') return;
            var $ddl = $(selector);
            if (!$ddl.length) return;
            // Prevent duplicated/stacked UI wrappers on repeated binds.
            //$ddl.next('.bootstrap-select').remove();
            //$ddl.removeClass('bs-select-hidden');

            if ($ddl.data('selectpicker')) {
                $ddl.selectpicker('destroy');
            }

            $ddl.selectpicker();
            $ddl.selectpicker('refresh');
        }

        //var months = ["January", "February", "March", "April", "May", "June",
        //    "July", "August", "September", "October", "November", "December"];
        //var uDatepicker = $.datepicker._updateDatepicker;
        //$.datepicker._updateDatepicker = function () {
        //    var ret = uDatepicker.apply(this, arguments);
        //    var $sel = this.dpDiv.find('select');
        //    $sel.find('option').each(function (i) {
        //        $(this).text(months[i]);
        //    });
        //    return ret;
        //};



        function onFilterChange() {
            getGlobalProjectList(0, 1, 5);
        }

        function getGlobalProjectList(projectid, pageNumber = 1, pageSize = 5) {

            var projectCode = $("#txtProjectCode").val() || "";
            var projectName = $("#txtProjectName").val() || "";

            //var url = "/api/GlobalProject/GetGlobalProject?projectId=" + projectid
            //    + "&pageNumber=" + pageNumber
            //    + "&pageSize=" + pageSize;

            var url = "/api/GlobalProject/GetGlobalProject?projectId=" + projectid
                + "&pageNumber=" + pageNumber
                + "&pageSize=" + pageSize
                + "&projectCode=" + encodeURIComponent(projectCode)
                + "&projectName=" + encodeURIComponent(projectName);

            var strResult = AJAXCallWithResult(url, null, false);


            var tbody = $("#tblGlobalProjectBody");
            tbody.empty();

            if (strResult && strResult.data && strResult.data.RM_GlobalProject) {
                var projectList = strResult.data.RM_GlobalProject;

                for (var i = 0; i < projectList.length; i++) {
                    var item = projectList[i];

                    //var startDate = item.expectedStartDate ? formatDate(item.expectedStartDate) : "";
                    //var endDate = item.expectedEndDate ? formatDate(item.expectedEndDate) : "";

                    //var statusClass = "";
                    //if (item.projectStatus === "Initiated") {
                    //    statusClass = "badge-initiated";

                    //} else if (item.projectStatus === "In Progress") {
                    //    statusClass = "badge-inprogress";

                    //} else if (item.projectStatus === "Completed") {
                    //    statusClass = "badge-completed";

                    //} else if (item.projectStatus === "On Hold") {
                    //    statusClass = "badge-onhold";

                    //} else if (item.projectStatus === "Re Opened") {
                    //    statusClass = "badge-reopened";

                    //} else if (item.projectStatus === "Ready for Closure") {
                    //    statusClass = "badge-readyclosure";

                    //}

                    var row = `
                <tr>
                    <td>${item.projectCode}</td>
                    <td>
                        ${item.projectName}
                    </td>
                    <td>${item.projectStatus}</td>
                    <td>${item.expectedStartDate}</td>
                    <td>${item.expectedEndDate}</td>
                    <td class="text-center">
                        <%If m_blnEditAccess = True Then%>
                        <i class="far fa-eye me-2"
                           onclick="openOffcanvas('globalProjectDetailsOffcanvas', ${item.projectID})"
                           style="cursor: pointer;color: #3b82f6;"
                           data-bs-title="View Details" data-bs-toggle="tooltip" data-bs-placement="top"></i>
                            <%End If%>

                        <%If m_blnDeleteAccess = True Then%>
                        <i id="deleteBtnMain" class="far fa-trash-alt action-icon" data-bs-title="Delete" onclick="ConfirmDelete(${item.projectID})" data-bs-toggle="tooltip" data-bs-placement="top"></i>
                        <%End If%>
                    </td>
                    
                </tr>
            `;

                    tbody.append(row);
                }

                // ✅ Total Records (from first row)
                if (projectList.length > 0) {
                    var totalCount = projectList[0].totalCount;
                    currentPage = pageNumber;
                    $("#totalRecords").text("Total Records: " + totalCount);

                    updatePaginationButtons(totalCount);
                } else {
                    tbody.append('<tr><td colspan="6" class="text-center">There are no records to view</td></tr>');
                    currentPage = 1;
                    $("#totalRecords").text("Total Records: 0");
                    updatePaginationButtons(0);
                }
            } else {
                tbody.append('<tr><td colspan="6" class="text-center">There are no records to view</td></tr>');
                currentPage = 1;
                $("#totalRecords").text("Total Records: 0");
                updatePaginationButtons(0);
            }
            initializeTooltips();
        }

        function updatePaginationButtons(totalCount) {
            var totalPages = Math.ceil(totalCount / pageSize);

            var prev = document.getElementById('gpPrevBtn');
            var next = document.getElementById('gpNextBtn');
            if (!prev || !next) return;

            var disablePrev = currentPage <= 1 || totalCount === 0;
            prev.disabled = disablePrev;
            prev.style.opacity = disablePrev ? '0.5' : '1';
            prev.style.cursor = disablePrev ? 'not-allowed' : 'pointer';

            var disableNext = currentPage >= totalPages || totalCount === 0;
            next.disabled = disableNext;
            next.style.opacity = disableNext ? '0.5' : '1';
            next.style.cursor = disableNext ? 'not-allowed' : 'pointer';
        }

        function goToPrevPage() {
            if (currentPage > 1) {
                currentPage--;
                getGlobalProjectList(0, currentPage, pageSize);
            }
        }

        function goToNextPage() {
            getGlobalProjectList(0, currentPage + 1, pageSize);
        }

        function openOffcanvas(id, projectId) {
            
            var el = document.getElementById(id);
            if (!el) return;

            $("#btnSelectGenericTask").show();
            $("#btnTaskTypeMaintenance").show();

            globalProjectID = projectId;
            if (id === 'globalProjectDetailsOffcanvas') {
                // Clear fields before loading
                clearProjectOffcanvas();

                if (projectId) {
                    
                    // Edit mode
                    isProjectEditMode = true;
                    $("#overRow").show();
                    $("#offcanvasProjectCode").prop("disabled", true);

                    var url = "/api/GlobalProject/GetGlobalProject?projectId=" + projectId + "&pageNumber=1&pageSize=1";
                    var result = AJAXCallWithResult(url, null, false);

                    if (result && result.data && result.data.RM_GlobalProject && result.data.RM_GlobalProject.length > 0) {
                        var p = result.data.RM_GlobalProject[0];

                        $("#offcanvasProjectName").val(p.projectName || "");
                        $("#offcanvasProjectCode").val(p.projectCode || "");
                        $("#offcanvasDescription").val(p.description || "");

                        // Start / End dates
                        //$("#offcanvasStartDate").val(p.expectedStartDate ? formatDate(p.expectedStartDate) : "");
                        //$("#offcanvasEndDate").val(p.expectedEndDate ? formatDate(p.expectedEndDate) : "");
                        $("#offcanvasStartDate").val(p.expectedStartDate);
                        $("#offcanvasEndDate").val(p.expectedEndDate);
                        // Load dropdowns with pre-selected values from project data
                        loadProjectGroupDropdown(p.projectGroupID || null);
                        loadProjectStatusDropdown(p.projectStatusID || null, 1, false);
                        $("#offcanvasProjectGroup").val(p.projectGroupID);
                        $("#offcanvasProjectStatus").val(p.projectStatusID);
                        // Over checkbox
                        $("#radioOver").prop("checked", p.over === true);
                    } else {
                        // Fallback: load dropdowns without pre-selection
                        loadProjectGroupDropdown();
                        loadProjectStatusDropdown(null, 1, false);
                    }
                } else {
                    // Add mode
                    isProjectEditMode = false;
                    $("#overRow").hide();
                    $("#offcanvasProjectCode").prop("disabled", false);
                    loadProjectGroupDropdown();
                    loadProjectStatusDropdown(null, 0, true);
                }
            }

            var offcanvas = new bootstrap.Offcanvas(el);
            offcanvas.show();
        }

        function AddGlobalProject() {
            var el = document.getElementById("globalProjectDetailsOffcanvas");
            //if (!el) return;

            // Explicitly reset to Add mode
            globalProjectID = 0;
            isProjectEditMode = false;
            $("#overRow").hide();
            $("#offcanvasProjectCode").prop("disabled", false);

            $("#btnSelectGenericTask").hide();
            $("#btnTaskTypeMaintenance").hide(); 

            clearProjectOffcanvas();
            loadProjectGroupDropdown();
            loadProjectStatusDropdown(null, 0, true);
            var offcanvas = new bootstrap.Offcanvas(el);
            offcanvas.show();
        }

        function saveGlobalProject() {
            //debugger
            // Client-side mandatory validation for Project Name and Project Code
            var projectName = $.trim($("#offcanvasProjectName").val() || "");
            var projectCode = $.trim($("#offcanvasProjectCode").val() || "");
            var projectStatus = $.trim($("#offcanvasProjectStatus").val() || "");
            var startDate = $.trim($("#offcanvasStartDate").val() || "");
            var endDate = $.trim($("#offcanvasEndDate").val() || "");

            if (!projectName) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Project Name should not be left blank.");
                $("#offcanvasProjectName").focus();
                return false;
            }

            if (!projectCode) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Project Code should not be left blank.");
                $("#offcanvasProjectCode").focus();
                return false;
            }

            if (!projectStatus || projectStatus === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Project Status should not be left blank.");
                $("#offcanvasProjectStatus").focus();
                return false;
            }

            // Validate only if both dates are present
            if (startDate && endDate) {

                // Convert "31 Mar 2026" → Date object
                function parseDate(dateStr) {
                    return new Date(dateStr);
                }

                var start = parseDate(startDate);
                var end = parseDate(endDate);

                if (start > end) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Start Date should not be greater than End Date.");
                    $("#offcanvasStartDate").focus();
                    return false;
                }
            }

            if (isProjectEditMode) {
                // ── EDIT MODE: call UpdateGlobalProject ──────────────────────────
                var updateRequest = {
                    projectID: globalProjectID,
                    projectName: $("#offcanvasProjectName").val(),
                    projectGroupID: parseInt($("#offcanvasProjectGroup").val()) || 0,
                    expectedStartDate: formatDateToISO($("#offcanvasStartDate").val()) || null,
                    expectedEndDate: formatDateToISO($("#offcanvasEndDate").val()) || null,
                    projectStatusID: parseInt($("#offcanvasProjectStatus").val()) || 0,
                    description: $("#offcanvasDescription").val(),
                    over: $("#radioOver").is(":checked"),
                    modifiedBy: "Admin" // replace with logged-in user
                };

                console.log("Update Request:", updateRequest);

                var updateResponse = AJAXCallWithResult(
                    "/api/GlobalProject/UpdateGlobalProject",
                    JSON.stringify(updateRequest),
                    false
                );

                console.log("Update Response:", updateResponse);

                if (updateResponse && updateResponse.message && updateResponse.message.CommonResultEntity[0].result =="Updated") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_Globalprjupdated") %>');

                    // Refresh grid
                    getGlobalProjectList(0);

                    // Close offcanvas
                    var offcanvasEl = document.getElementById("globalProjectDetailsOffcanvas");
                    var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    offcanvas.hide();
                }
                else if (updateResponse && updateResponse.message && updateResponse.message.CommonResultEntity[0].result == "Project Name already exists")
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Project Name already exists.");
                    $("#offcanvasProjectName").focus();
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(updateResponse?.data?.message || "Error updating project.");
                }

            } else {
                // ── ADD MODE: call SaveGlobalProject ────────────────────────────
                var saveRequest = {
                    projectName: $("#offcanvasProjectName").val(),
                    projectCode: $("#offcanvasProjectCode").val(),
                    projectGroupID: parseInt($("#offcanvasProjectGroup").val()) || 0,
                    expectedStartDate: formatDateToISO($("#offcanvasStartDate").val()) || null,
                    expectedEndDate: formatDateToISO($("#offcanvasEndDate").val()) || null,
                    billable: false,
                    globalProject: true,
                    projectStatusID: parseInt($("#offcanvasProjectStatus").val()) || 0,
                    description: $("#offcanvasDescription").val(),
                    createdBy: "Admin", // replace with logged-in user
                    over: $("#radioOver").is(":checked")
                };

                console.log("Save Request:", saveRequest);

                var saveResponse = AJAXCallWithResult(
                    "/api/GlobalProject/SaveGlobalProject",
                    JSON.stringify(saveRequest),
                    false
                );

                console.log("Save Response:", saveResponse);

                if (saveResponse && saveResponse.data.CommonResultEntity[0].result === 'Inserted') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_Globalprjsaved") %>');

                    // Refresh grid
                    getGlobalProjectList(0);

                    // Close offcanvas
                    var offcanvasEl = document.getElementById("globalProjectDetailsOffcanvas");
                    var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    offcanvas.hide();
                } else if (saveResponse && saveResponse.data.CommonResultEntity[0].result === 'Project Name already exists') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_PrjNameExists") %>');
                    $("#offcanvasProjectName").focus();
                }
                else if (saveResponse && saveResponse.data.CommonResultEntity[0].result === 'Project Code already exists') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_PrjCodeExists") %>');
                    $("#offcanvasProjectCode").focus();
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(saveResponse?.data?.message || "Error saving project.");
                }
            }
        }

        function clearProjectOffcanvas() {
            $("#offcanvasProjectName").val("");
            $("#offcanvasProjectCode").val("");
            $("#offcanvasDescription").val("");
            $("#offcanvasStartDate").val("");
            $("#offcanvasEndDate").val("");
            // Reset dropdowns to blank — options are reloaded fresh on each open
            //$("#offcanvasProjectStatus").empty().append('<option value="">-- Select --</option>');
            //$("#offcanvasProjectGroup").empty().append('<option value="">-- Select --</option>');
            $("#radioOver").prop("checked", false);
        }

        function loadProjectGroupDropdown(selectedGroupID) {
            //debugger
            var url = "/api/GlobalProject/GetProjectGroups";

            var response = AJAXCallWithResult(url, null, false);

            var ddl = $("#offcanvasProjectGroup");
            ddl.empty();

            if (response && response.data && response.data.RM_ProjectGroup) {
                var list = response.data.RM_ProjectGroup;
                for (var i = 0; i < list.length; i++) {
                    ddl.append(
                        `<option value="${list[i].projectGroupID}">${list[i].projectGroupName || list[i].groupName || list[i].projectGroup || ''}</option>`
                    );
                }                
            }

            if (selectedGroupID) {
                ddl.val(selectedGroupID);
            }

            $('#offcanvasProjectGroup').selectpicker('refresh');
        }

        function loadProjectStatusDropdown(selectedStatusID, flag, disableField) {
            
            flag = (typeof flag === "undefined" || flag === null) ? 0 : flag;
            disableField = (typeof disableField === "undefined") ? false : disableField;

            var url = "/api/GlobalProject/GetProjectStatus?flag=" + flag;

            var response = AJAXCallWithResult(url, null, false);

            var ddl = $("#offcanvasProjectStatus");
            //ddl.empty().append('<option value="">Select Project Status</option>');
            ddl.empty();

            if (response && response.data && response.data.RM_ProjectStatus) {
                var list = response.data.RM_ProjectStatus;
                for (var i = 0; i < list.length; i++) {
                    ddl.append(
                        `<option value="${list[i].projectStatusID}">${list[i].projectStatus}</option>`
                    );
                }
            }

            if (selectedStatusID) {
                ddl.val(selectedStatusID);
            }

            ddl.prop("disabled", disableField);
            $('#offcanvasProjectStatus').selectpicker('refresh');
        }

        function formatDate(dateStr) {
            if (!dateStr) return "";
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return dateStr;
            var mm = ("0" + (d.getMonth() + 1)).slice(-2);
            var dd = ("0" + d.getDate()).slice(-2);
            var yyyy = d.getFullYear();
            return mm + "/" + dd + "/" + yyyy;
        }

        // Opens delete modal for a Global Project
        function ConfirmDelete(projectid) {
            deleteContext = 'project';
            globalProjectID = projectid;
            $("#txtDeleteAlert").text("<%=MyBase.GetResourceString("A_AreUSureBlblPrj") %>");
            $("#GPDeleteAlertModal").modal('show');
        }

        // Opens delete modal for a Generic Task
        function ConfirmDeleteTask(taskid) {
            deleteContext = 'task';
            globalTaskID = taskid;
            $("#txtDeleteAlert").text("<%=MyBase.GetResourceString("A_AreUSureDeleteTask") %>");
            $("#GPDeleteAlertModal").modal('show');
        }

        // Opens delete modal for a Task Type Maintenance record
        function ConfirmDeleteTaskType(taskTypeId) {
            deleteContext = 'tasktype';
            globalTaskTypeID = taskTypeId;
            $("#txtDeleteAlert").text("<%=MyBase.GetResourceString("A_AreUSureTaskType") %>");
            $("#GPDeleteAlertModal").modal('show');
        }

        // Commented and Added  By Vyankat B. on 21 th April 2026  for non-deletable Task Type click alert
        function showTaskTypeInUseAlert() {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Task Type is in use cannot be deleted.");
        }
        // End of Commented and Added  By Vyankat B. on 21 th April 2026  for non-deletable Task Type click alert

        // Dispatcher called by Yes button — routes to correct delete function
        function handleConfirmDelete() {
            if (deleteContext === 'project') {
                deleteGlobalProject();
            } else if (deleteContext === 'task') {
                deleteGenericTask();
            } else if (deleteContext === 'tasktype') {
                deleteProjectTaskType();
            } else if (deleteContext === 'subtasktype') {
                deleteProjectSubTaskType();
            }
        }

        function clearDelete() {
            globalProjectID = '';
            globalTaskID = '';
            globalTaskTypeID = '';
            globalSubTaskTypeID = '';
            deleteContext = '';
        }

        function deleteGlobalProject() {
            
            var url = "/api/GlobalProject/DeleteGlobalProject?projectId=" + globalProjectID;

            var response = AJAXCallWithResult(url, null, false);
            if (response && response.data.CommonResultEntity[0].result === 'deleted') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_GlobalPrjDelSuccess") %>');
                getGlobalProjectList(0, 1, 5);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(response.data.CommonResultEntity[0].result);
            }
        }

        //function deleteGenericTask() {

        //    var url = "/api/GlobalProject/DeleteGlobalProjectGenTask?taskId=" + globalTaskID;

        //    var response = AJAXCallWithResult(url, null, false);

        //    if (response) {
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.success(response.message.CommonResultEntity[0].result);
        //        getGenericTasksList(gtCurrentPage);
        //    } else {
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.error(response.message.CommonResultEntity[0].result);
        //    }
        //}

        function deleteGenericTask() {
            
            var url = "/api/GlobalProject/DeleteGlobalProjectGenTask?taskId=" + globalTaskID;

            var response = AJAXCallWithResult(url, null, false);

            if (response && response.message && response.message.CommonResultEntity) {

                var resultMsg = response.message.CommonResultEntity[0].result;

                if (resultMsg) {

                    // Get last character (flag)
                    var flag = resultMsg.slice(-1);

                    // Remove last character (clean message)
                    var cleanMsg = resultMsg.slice(0, -1);

                    alertify.set('notifier', 'position', 'top-right');

                    if (flag === "1") {
                        alertify.error(cleanMsg);
                    }
                    else if (flag === "2") {
                        //alertify.success(cleanMsg);
                        alertify.success("Generic Task deleted successfully");

                        // Refresh grid only on success
                        getGenericTasksList(gtCurrentPage);
                    }
                    else {
                        // fallback (in case no flag)
                        alertify.message(cleanMsg);
                    }
                }

            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Something went wrong");
            }
        }

        function openOffcanvasGenericTasks() {

            var el = document.getElementById("selectGenericTasksModal");
            var offcanvas = new bootstrap.Offcanvas(el);
            offcanvas.show();

            // Reset to page 1 every time the offcanvas is opened
            gtCurrentPage = 1;
            // Always reset Task Type filter on reopen so old selection does not persist
            selectedTaskTypeID = 0;
            $("#ddlTaskType").val("0");
            refreshSelectPicker('#ddlTaskType');
            loadGenericTaksDropdown();
            loadTaskTypeDropdown();
            getGenericTasksList(gtCurrentPage);
            
        }

        function getGenericTasksList(pageNumber) {
            // debugger;
            var selectedVal = $("#ddlTaskType").val();
            var tasktype = "";

            if (selectedVal == "0" || selectedVal == null || selectedVal == undefined) {
                tasktype = "0"; // send 0
            } else {
                tasktype = $("#ddlTaskType option:selected").text(); // send text
            }
            //var url = "/api/GlobalProject/GetGenericTasks?projectId="
            //    + globalProjectID + "&pageNumber=" + pageNumber + "&pageSize=" + gtPageSize;

            var url = "/api/GlobalProject/GetGenericTasks?projectId="
                + globalProjectID
                + "&Tasktype=" + tasktype
                + "&pageNumber=" + pageNumber
                + "&pageSize=" + gtPageSize;

            var response = AJAXCallWithResult(url, null, false);

            bindGenericTasks(response.data, pageNumber);
        }

        function bindGenericTasks(data, pageNumber) {
            
            var tbody = $("#tblGenericTasksBody");
            tbody.empty();

            if (!data || !data.RM_GenericTasks || data.RM_GenericTasks.length <= 0) {
                tbody.append('<tr><td colspan="4" class="text-center">There are no records to view</td></tr>');
                $("#totalRecordsGenTasks").text("Total Records: 0");
                updateGenericTasksPaginationButtons(0);
                return;
            }

            for (var i = 0; i < data.RM_GenericTasks.length; i++) {

                var item = data.RM_GenericTasks[i];

                var isBillable = item.billableYN ?
                    '<span>Yes</span>' : 'No';

                var isChecked = item.billableYN ? 'checked' : '';

                var row = `
            <tr>
                <td>${item.taskName}</td>
                <td>
                    
                        ${item.taskType}
                    
                </td>
                <td>${isBillable}</td>
                <td>
                    <%If m_blnDeleteAccess = True Then%>
                    <i class="far fa-trash-alt action-icon"
                       data-bs-toggle="tooltip"
                       data-bs-title="Delete"
                       onclick="ConfirmDeleteTask(${item.taskID})"></i>
                    <%End If%>
                </td>
            </tr>
        `;

                tbody.append(row);
            }

            // Update total records count and pagination buttons
            if (data.RM_GenericTasks.length > 0) {
                var totalCount = data.RM_GenericTasks[0].totalCount;
                gtCurrentPage = pageNumber;
                $("#totalRecordsGenTasks").text("Total Records: " + totalCount);
                updateGenericTasksPaginationButtons(totalCount);
            }

            initializeTooltips();
        }

        function updateGenericTasksPaginationButtons(totalCount) {
            var totalPages = Math.ceil(totalCount / gtPageSize);

            var prev = document.getElementById('gentasksPrevBtn');
            var next = document.getElementById('genTasksNextBtn');
            if (!prev || !next) return;

            var disablePrev = gtCurrentPage <= 1 || totalCount === 0;
            prev.disabled = disablePrev;
            prev.style.opacity = disablePrev ? '0.5' : '1';
            prev.style.cursor = disablePrev ? 'not-allowed' : 'pointer';

            var disableNext = gtCurrentPage >= totalPages || totalCount === 0;
            next.disabled = disableNext;
            next.style.opacity = disableNext ? '0.5' : '1';
            next.style.cursor = disableNext ? 'not-allowed' : 'pointer';
        }

        function goToPrevPageGenTasks() {
            if (gtCurrentPage > 1) {
                gtCurrentPage--;
                getGenericTasksList(gtCurrentPage);
            }
        }

        function goToNextPageGenTasks() {
            getGenericTasksList(gtCurrentPage + 1);
        }

        function AddGenericTasks() {
            var el = document.getElementById("genericTaskMappingModal");
            if (!el) return;
            loadGenericTaksDropdown();
            //$("#ddlGenericTask").selectpicker('refresh');
            /*clearProjectOffcanvas();*/
            var offcanvas = new bootstrap.Offcanvas(el);
            offcanvas.show();
        }

        function loadGenericTaksDropdown(uniqueId = null) {
            
            var url = "/api/GlobalProject/GetOtherTasksGlobal?projectId="
                + globalProjectID +
                "&uniqueId=" + (uniqueId || "");

            var response = AJAXCallWithResult(url, null, false);

            bindGenericTaskDropdown(response);
        }

        function bindGenericTaskDropdown(response) {
            
            var ddl = $("#ddlGenericTask");
            ddl.empty();

            //ddl.append('<option value="">All</option>');

            if (response && response.data && response.data.RM_OtherTasks) {

                var list = response.data.RM_OtherTasks;

                for (var i = 0; i < list.length; i++) {
                    ddl.append(
                        `<option value="${list[i].taskID}">${list[i].taskName}</option>`
                    );
                }
            }

            refreshSelectPicker('#ddlGenericTask');
        }

        var taskTypeId = null;
        function loadTaskTypeDropdown(taskTypeId) {

            var url = "/api/GlobalProject/GetTaskTypes?taskTypeId=" + (taskTypeId ?? '');

            var response = AJAXCallWithResult(url, null, false);

            bindTaskTypeDropdown(response);
        }

        function bindTaskTypeDropdown(response) {
            
            var ddl = $("#ddlTaskType");
            ddl.empty();

            //ddl.append('<option value="">All</option>');

            if (response && response.data && response.data.RM_TaskType) {

                var list = response.data.RM_TaskType;

                for (var i = 0; i < list.length; i++) {
                    ddl.append(
                        `<option value="${list[i].taskTypeID}">${list[i].taskType}</option>`
                    );
                }
            }

            if (selectedTaskTypeID && selectedTaskTypeID != 0) {
                ddl.val(selectedTaskTypeID);
            } else {
                ddl.val("0"); // Add mode
            }

            refreshSelectPicker('#ddlTaskType');
        }

        function onTaskTypeChange() {
            // Call API again with selected value
            getGenericTasksList(gtCurrentPage);
        }

        function saveGenericTasks() {
            var selectedGenericTaskId = parseInt($("#ddlGenericTask").val()) || 0;
            if (selectedGenericTaskId === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Generic Task should not be left blank.");
                $("#ddlGenericTask").focus();
                return false;
            }
            
            var request = {
                taskID: selectedGenericTaskId,
                projectID: globalProjectID 
            };

            console.log("Insert Task Request:", request);

            var response = AJAXCallWithResult(
                "/api/GlobalProject/InsertGlobalProjectTask",
                JSON.stringify(request),
                false
            );

            console.log("Insert Task Response:", response);

            if (response && response.message === "Task inserted successfully for Global Project") {

                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_TaskAddesSuccess") %>');

                // Refresh grid (important)
                getGenericTasksList(gtCurrentPage);
                var offcanvasEl = document.getElementById("genericTaskMappingModal");
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                offcanvas.hide();
                // Optional: reset dropdown
                $("#ddlGenericTask").val("");

            } else {
                alert(response?.data?.message || "Error inserting task");
            }
        }

        function openOffcanvastaskTypeMaintainance() {
            var el = document.getElementById("taskTypeMaintenanceModal");
            if (!el) return;
            // Reset to page 1 every time the offcanvas is opened
            ttCurrentPage = 1;
            getProjectTaskTypes(globalProjectID, ttCurrentPage, ttPageSize);
            /*clearProjectOffcanvas();*/
            var offcanvas = new bootstrap.Offcanvas(el);
            offcanvas.show();
            loadTaskTypemaintainanceAddDropdown();
        }

        var selectedTaskTypeID = 0;
        // taskTypeID param: undefined/null = Add mode, number = Edit mode
        // isDefaultTaskType param: true/1 when selected row is already default
        function openOffcanvastaskTypeModal(taskTypeID, isDefaultTaskType) {
            var el = document.getElementById("taskTypeModal");
            if (!el) return;

            var isEditMode = (taskTypeID !== undefined && taskTypeID !== null && taskTypeID !== '');

            if (isEditMode) {
                // Edit mode: store the task type ID being edited
                selectedTaskTypeID = taskTypeID;
                globalTaskTypeID = taskTypeID;
            } else {
                // Add mode: reset selection
                selectedTaskTypeID = 0;
            }

            // Load the dropdown for task type maintenance (available task types)
            loadTaskTypemaintainanceAddDropdown(isEditMode, taskTypeID);

            // Show/hide "Set as Default" button — only in Edit mode and non-default rows
            if (isEditMode) {
                // Commented and Added  By Vyankat B. on 21 th April 2026  for hide Set as Default on already-default task type
                // $("#btnSetAsDefaultTTModal").show();
                if (isDefaultTaskType === true || isDefaultTaskType === 1 || isDefaultTaskType === "1") {
                    $("#btnSetAsDefaultTTModal").hide();
                } else {
                    $("#btnSetAsDefaultTTModal").show();
                }
                // End of Commented and Added  By Vyankat B. on 21 th April 2026  for hide Set as Default on already-default task type
                $("#btnSaveTTPMNT").hide();
                // Load sub task types for this project + task type
                stCurrentPage = 1;
                getProjectSubTaskTypes(globalProjectID, taskTypeID, stCurrentPage);
            } else {
                $("#btnSetAsDefaultTTModal").hide();
                $("#btnSaveTTPMNT").show();
                // Hide sub tasks section entirely in Add mode
                $("#subTasksSection").hide();
                $("#tblSubTaskTypesBody").empty();
                $("#totalRecordsSubTasks").text("Total Records: 0");
            }

            var offcanvas = new bootstrap.Offcanvas(el);
            offcanvas.show();
        }

        // Called by the "Set as Default" button inside #taskTypeModal
        function setAsDefaultFromModal() {
            if (globalTaskTypeID) {
                setAsDefault(globalTaskTypeID);
            }
        }

        // ── Sub Task Types ──────────────────────────────────────────────────────

        function getProjectSubTaskTypes(projectId, taskTypeId, pageNumber) {
            pageNumber = pageNumber || stCurrentPage;

            var url = "/api/GlobalProject/GetProjectSubTaskTypes?projectId="
                + projectId + "&taskTypeId=" + taskTypeId;

            var response = AJAXCallWithResult(url, null, false);

            console.log("Sub Task Types Response:", response);

            // API response shape: response.data.data (array of sub task types)
            var subTaskList = null;
            if (response && response.data && response.data.RM_ProjectSubTaskTypes) {
                subTaskList = response.data.RM_ProjectSubTaskTypes;
            }

            bindSubTaskTypes(subTaskList, pageNumber);
        }

        function bindSubTaskTypes(data, pageNumber) {
            var tbody = $("#tblSubTaskTypesBody");
            tbody.empty();

            if (!data || data.length === 0) {
                // No sub tasks yet — still show the section so the Add button is accessible
                $("#subTasksSection").show();
                tbody.append('<tr><td colspan="2" class="text-center" style="color:#6b7280;">There are no records to view</td></tr>');
                $("#totalRecordsSubTasks").text("Total Records: 0");
                updateSubTasksPaginationButtons(0);
                return;
            }

            // Has sub tasks — show the section
            $("#subTasksSection").show();

            // Client-side pagination: slice the data for current page
            var totalCount = data.length;
            var start = (pageNumber - 1) * stPageSize;
            var end = start + stPageSize;
            var pageData = data.slice(start, end);

            for (var i = 0; i < pageData.length; i++) {
                var item = pageData[i];
                var row = `
                    <tr>
                        <td>
                            ${item.subTaskType || item.taskType || item.subTaskTypeName || ''}
                        </td>
                        <td class="text-center">
                            <%If m_blnDeleteAccess = True Then%>
                            <i class="far fa-trash-alt action-icon" data-bs-toggle="tooltip" data-bs-title="Delete"
                               onclick="ConfirmDeleteSubTaskType(${item.projectSubTaskTypeID})"></i>
                            <%End If%>
                        </td>
                    </tr>
                `;
                tbody.append(row);
            }

            stCurrentPage = pageNumber;
            $("#totalRecordsSubTasks").text("Total Records: " + totalCount);
            updateSubTasksPaginationButtons(totalCount);
            initializeTooltips();
        }

        function updateSubTasksPaginationButtons(totalCount) {
            var totalPages = Math.ceil(totalCount / stPageSize);

            var prev = document.getElementById('subTasksPrevBtn');
            var next = document.getElementById('subTasksNextBtn');
            if (!prev || !next) return;

            var disablePrev = stCurrentPage <= 1 || totalCount === 0;
            prev.disabled = disablePrev;
            prev.style.opacity = disablePrev ? '0.5' : '1';
            prev.style.cursor = disablePrev ? 'not-allowed' : 'pointer';

            var disableNext = stCurrentPage >= totalPages || totalCount === 0;
            next.disabled = disableNext;
            next.style.opacity = disableNext ? '0.5' : '1';
            next.style.cursor = disableNext ? 'not-allowed' : 'pointer';
        }

        function goToPrevPageSubTasks() {
            if (stCurrentPage > 1) {
                stCurrentPage--;
                getProjectSubTaskTypes(globalProjectID, globalTaskTypeID, stCurrentPage);
            }
        }

        function goToNextPageSubTasks() {
            getProjectSubTaskTypes(globalProjectID, globalTaskTypeID, stCurrentPage + 1);
        }

        // Opens delete confirmation modal for a Sub Task Type
        function ConfirmDeleteSubTaskType(projectSubTaskTypeID) {
            deleteContext = 'subtasktype';
            globalSubTaskTypeID = projectSubTaskTypeID;
            $("#txtDeleteAlert").text("<%=MyBase.GetResourceString("A_AreUSureDeleteSubTask") %>");
            $("#GPDeleteAlertModal").modal('show');
        }

        // Called by handleConfirmDelete when deleteContext === 'subtasktype'
        function deleteProjectSubTaskType() {
            var request = {
                projectSubTaskTypeID: globalSubTaskTypeID
            };

            var response = AJAXCallWithResult(
                "/api/GlobalProject/DeleteProjectSubTaskType",
                JSON.stringify(request),
                false
            );

            console.log("Delete Sub Task Type Response:", response);

            //if (response && response.data && response.data.message) {
                if (response.message.CommonResultEntity[0].result === "deleted") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_SubTaskDelSuccess") %>');
                // Refresh sub task grid keeping current page
                getProjectSubTaskTypes(globalProjectID, globalTaskTypeID, stCurrentPage);
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error((response && response.data && response.data.message)
                    ? response.data.message
                    : "Error deleting Sub Task Type.");
            }
        }

        // ── Add Sub Task Type ───────────────────────────────────────────────────

        function openAddSubTaskTypeModal() {
            var el = document.getElementById("addSubTaskTypeModal");
            if (!el) return;

            // Clear dropdown before loading fresh data
            $("#ddlSubTaskType").empty();

            // Load available sub task types (filtered: excludes already-mapped ones)
            loadSubTaskTypeDropdown();

            var offcanvas = new bootstrap.Offcanvas(el);
            offcanvas.show();
        }

        function loadSubTaskTypeDropdown() {
            var url = "/api/GlobalProject/GetSubTasksForInheriting?projectId="
                + globalProjectID
                + "&taskTypeId=" + globalTaskTypeID;

            var response = AJAXCallWithResult(url, null, false);

            console.log("Sub Task Dropdown Response:", response);

            bindSubTaskTypeDropdown(response);
        }

        function bindSubTaskTypeDropdown(response) {
            var ddl = $("#ddlSubTaskType");
            ddl.empty();

            // Commented and Added  By Vyankat B. on 21 th April 2026  for Sub Task Type API response binding fix
            // if (response && response.data && response.data.data && response.data.data.length > 0) {
            //     var list = response.data.data;
            var list = [];
            if (response && response.data) {
                if (response.data.RM_SubTaskType && response.data.RM_SubTaskType.length > 0) {
                    list = response.data.RM_SubTaskType;
                } else if (response.data.data && response.data.data.length > 0) {
                    list = response.data.data;
                }
            }

            if (list.length > 0) {
                for (var i = 0; i < list.length; i++) {
                    ddl.append(
                        `<option value="${list[i].subTaskTypeID}">${list[i].subTaskType || list[i].subTaskTypeName || list[i].taskType || ''}</option>`
                    );
                }
            } else {
                ddl.append('<option value="">-- No Sub Task Types available --</option>');
            }
            // End of Commented and Added  By Vyankat B. on 21 th April 2026  for Sub Task Type API response binding fix
            $("#ddlSubTaskType").selectpicker('refresh');
        }

        function saveProjectSubTaskType() {
            var subTaskTypeID = parseInt($("#ddlSubTaskType").val()) || 0;

            if (!subTaskTypeID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PlzSelSubTask") %>');
                return;
            }

            var request = {
                SubTaskTypeID: subTaskTypeID,
                ProjectID: globalProjectID,
                TaskTypeID: globalTaskTypeID,
                CreatedBy: "Admin" // replace with logged-in user if needed
            };

            console.log("Save Sub Task Type Request:", request);

            var response = AJAXCallWithResult(
                "/api/GlobalProject/SaveProjectSubTaskType",
                JSON.stringify(request),
                false
            );

            console.log("Save Sub Task Type Response:", response);

            if (response && response.data) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_SubTaskAddSuccess") %>');

                // Close the add offcanvas
                var offcanvasEl = document.getElementById("addSubTaskTypeModal");
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                if (offcanvas) offcanvas.hide();

                // Refresh the sub task grid from page 1 to show the new entry
                stCurrentPage = 1;
                getProjectSubTaskTypes(globalProjectID, globalTaskTypeID, stCurrentPage);

                // Also make the subTasksSection visible in case it was hidden (no previous entries)
                $("#subTasksSection").show();
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Error saving Sub Task Type.");
            }
        }

        // ── End Add Sub Task Type ───────────────────────────────────────────────

        // ── End Sub Task Types ──────────────────────────────────────────────────

        //task type maintainance
        function getProjectTaskTypes(projectId, pageNumber, pageSize) {

            pageNumber = pageNumber || ttCurrentPage;
            pageSize = pageSize || ttPageSize;

            var url = "/api/GlobalProject/GetProjectTaskTypes?projectId="
                + globalProjectID + "&pageNumber=" + pageNumber + "&pageSize=" + pageSize;

            var response = AJAXCallWithResult(url, null, false);

            console.log("Project Task Types Response:", response);

            if (response && response.data && response?.data?.ProjectTaskTypeEntity) {
                bindProjectTaskTypes(response?.data?.ProjectTaskTypeEntity, pageNumber);
            } else {
                $("#tblProjectTaskTypesBody").html('<tr><td colspan="3" class="text-center">There are no records to view</td></tr>');
                $("#totalRecordsTaskTypes").text("Total Records: 0");
                updateTaskTypesPaginationButtons(0);
            }
        }

        //task type maintainance
        function bindProjectTaskTypes(data, pageNumber) {

            var tbody = $("#tblProjectTaskTypesBody");
            tbody.empty();

            console.log("Bind Data:", data);

            if (!data || data.length === 0) {
                tbody.append('<tr><td colspan="3" class="text-center">There are no records to view</td></tr>');
                $("#totalRecordsTaskTypes").text("Total Records: 0");
                updateTaskTypesPaginationButtons(0);
                return;
            }

            for (var i = 0; i < data.length; i++) {

                var item = data[i];
                globalProjectID = item.projectID;
                // Set as Default
                var setDefault = item.defaultTaskType
                    // Commented and Added  By Vyankat B. on 21 th April 2026  for Default label color change in Task Type grid
                    // ? `<span class="text-success fw-bold">Default</span>`
                    ? `<span class="text-blue fw-bold">Default</span>`
                    : `<span class="text-blue cursor-pointer"
                    onclick="setAsDefault(${item.taskTypeID})">
                    ${item.setAsDefault || 'Set as Default'}
               </span>`;
                // End of Commented and Added  By Vyankat B. on 21 th April 2026  for Default label color change in Task Type grid

                // Delete icon
                var deleteIcon = item.allowDelete == 1
                    ? `<i class="far fa-trash-alt action-icon"
                    data-bs-toggle="tooltip"
                    data-bs-title="Delete"
                    onclick="ConfirmDeleteTaskType(${item.taskTypeID})"></i>`
                    // Commented and Added  By Vyankat B. on 21 th April 2026  for clickable alert on non-deletable Task Type
                    // : `<i class="far fa-trash-alt action-icon text-muted"
                    // data-bs-toggle="tooltip" data-bs-title="Cannot Delete" data-bs-placement="top"
                    // style="cursor:not-allowed;"></i>`;
                    : `<i class="far fa-trash-alt action-icon"
                    data-bs-toggle="tooltip" data-bs-title="Delete" data-bs-placement="top"
                    onclick="showTaskTypeInUseAlert()"></i>`;
                    // End of Commented and Added  By Vyankat B. on 21 th April 2026  for clickable alert on non-deletable Task Type

                var row = `
                <tr>
                    <td>
                        <span class="${item.defaultTaskType ? 'fw-bold' : ''}">
                            ${item.taskType}
                        </span>
                    </td>
                    <td class="text-center">${setDefault}</td>
                    <%If m_blnDeleteAccess = True Then%>
                    <td class="text-center">
                        <i class="far fa-eye me-2"
                           onclick="openOffcanvastaskTypeModal(${item.taskTypeID}, ${item.defaultTaskType ? 1 : 0})"
                           style="cursor: pointer; color: #3b82f6;"
                           data-bs-title="View Details" data-bs-toggle="tooltip" data-bs-placement="top"></i>
                        ${deleteIcon}
                    </td>
                    <% End If%>
                </tr>
                `;
                globalTaskTypeID = item.taskTypeID;
                tbody.append(row);
            }

            // Update total records and pagination
            if (data.length > 0) {
                var totalCount = data[0].totalCount || data.length;
                ttCurrentPage = pageNumber || ttCurrentPage;
                $("#totalRecordsTaskTypes").text("Total Records: " + totalCount);
                updateTaskTypesPaginationButtons(totalCount);
            }
            initializeTooltips();
        }

        function updateTaskTypesPaginationButtons(totalCount) {
            var totalPages = Math.ceil(totalCount / ttPageSize);

            var prev = document.getElementById('taskTypesPrevBtn');
            var next = document.getElementById('taskTypesNextBtn');
            if (!prev || !next) return;

            var disablePrev = ttCurrentPage <= 1 || totalCount === 0;
            prev.disabled = disablePrev;
            prev.style.opacity = disablePrev ? '0.5' : '1';
            prev.style.cursor = disablePrev ? 'not-allowed' : 'pointer';

            var disableNext = ttCurrentPage >= totalPages || totalCount === 0;
            next.disabled = disableNext;
            next.style.opacity = disableNext ? '0.5' : '1';
            next.style.cursor = disableNext ? 'not-allowed' : 'pointer';
        }

        function goToPrevPageTaskTypes() {
            if (ttCurrentPage > 1) {
                ttCurrentPage--;
                getProjectTaskTypes(globalProjectID, ttCurrentPage, ttPageSize);
            }
        }

        function goToNextPageTaskTypes() {
            getProjectTaskTypes(globalProjectID, ttCurrentPage + 1, ttPageSize);
        }

        // Delete a Task Type Maintenance record
        function deleteProjectTaskType() {
            var url = "/api/GlobalProject/DeleteProjectTaskType?taskTypeId=" + globalTaskTypeID
                + "&projectId=" + globalProjectID;

            var response = AJAXCallWithResult(url, null, false);

            if (response && response.message && response.message.CommonResultEntity && response.message.CommonResultEntity[0].result) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(response.message.CommonResultEntity[0].result);
                getProjectTaskTypes(globalProjectID, ttCurrentPage, ttPageSize);
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error((response && response.data && response.data.CommonResultEntity)
                    ? response.data.CommonResultEntity[0].result
                    : "Something went wrong");
            }
        }

        //task type maintainance add mode dropdown
        function loadTaskTypemaintainanceAddDropdown(isEditMode, taskTypeID) {

            var url = "/api/GlobalProject/GetTaskTypesForDropdown?projectId=" + (globalProjectID ?? '');

            var response = AJAXCallWithResult(url, null, false);

            if (isEditMode && taskTypeID) {
                // The selected task type is excluded from the filtered list (already mapped).
                // Fetch its name separately so we can inject it into the dropdown.
                var taskTypeUrl = "/api/GlobalProject/GetTaskTypes?taskTypeId=" + taskTypeID;
                var taskTypeResponse = AJAXCallWithResult(taskTypeUrl, null, false);

                var editTaskTypeName = null;
                if (taskTypeResponse && taskTypeResponse.data && taskTypeResponse.data.RM_TaskType
                    && taskTypeResponse.data.RM_TaskType.length > 0) {
                    // Find the matching entry
                    var matched = taskTypeResponse.data.RM_TaskType.filter(function (t) {
                        return t.taskTypeID == taskTypeID;
                    });
                    if (matched.length > 0) {
                        editTaskTypeName = matched[0].taskType;
                    } else {
                        // Fallback: take first result if single-record API
                        editTaskTypeName = taskTypeResponse.data.RM_TaskType[0].taskType;
                    }
                }

                bindTaskTypemaintainanceAddDropdown(response, isEditMode, taskTypeID, editTaskTypeName);
            } else {
                bindTaskTypemaintainanceAddDropdown(response, false, null, null);
            }
        }

        //task type maintainance add mode dropdown
        // editTaskTypeName: the display name of the selected task type to inject in edit mode
        function bindTaskTypemaintainanceAddDropdown(response, isEditMode, taskTypeID, editTaskTypeName) {
            
            var ddl = $("#ddlTaskTypeMaintainance");
            ddl.empty();

            if (isEditMode && taskTypeID && editTaskTypeName) {
                // Inject the selected task type as the first (and only) option in edit mode.
                // It is intentionally excluded from GetTaskTypesForDropdown (already mapped),
                // so we add it manually so it can be displayed and pre-selected.
                ddl.append(`<option value="${taskTypeID}">${editTaskTypeName}</option>`);
                ddl.val(taskTypeID);
                ddl.prop('disabled', true);
            } else {
                // Add mode: populate the full filtered list and enable the dropdown
                // Commented and Added  By Vyankat B. on 21 th April 2026  for API-driven default Task Type selection fix
                // ddl.append('<option value="0">Select Task Type</option>');
                var defaultTaskTypeValue = "";
                if (response && response.data && response.data.TaskTypMaintainanceEntity) {
                    var list = response.data.TaskTypMaintainanceEntity;
                    for (var i = 0; i < list.length; i++) {
                        ddl.append(
                            `<option value="${list[i].taskTypeID}">${list[i].taskType}</option>`
                        );
                    }
                    if (list.length > 0) {
                        defaultTaskTypeValue = String(list[0].taskTypeID);
                    }
                }
                ddl.prop('disabled', false);
                // ddl.val('0');
                ddl.val(defaultTaskTypeValue);
                // End of Commented and Added  By Vyankat B. on 21 th April 2026  for API-driven default Task Type selection fix
            }
            $('#ddlTaskTypeMaintainance').selectpicker('refresh');
        }
        
        //for saving task type maintainance
        function saveTaskTypeMaintainance() {
            // debugger;
            // Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type mandatory validation before save
            var selectedTaskTypeID = parseInt($("#ddlTaskTypeMaintainance").val()) || 0;
            if (selectedTaskTypeID === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Task Type should not be left blank.");
                return;
            }
            // End of Commented and Added  By Vyankat B. on 21 th April 2026  for Task Type mandatory validation before save

            var request = {
                taskTypeID: selectedTaskTypeID,
                projectID: globalProjectID,
                createdBy: "Admin" // replace with logged-in user if needed
            };

            console.log("Insert Task Type Request:", request);

            var response = AJAXCallWithResult(
                "/api/GlobalProject/InsertProjectTaskType",
                JSON.stringify(request),
                false
            );

            console.log("Insert Task Type Response:", response);

            if (response && response.message && response.message.CommonResultEntity) {

                var result = response.message.CommonResultEntity[0].result;

                if (result === "Inserted") {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_TskTypAddSuccess") %>');

                    //Refresh grid
                    getProjectTaskTypes(globalProjectID);

                    var offcanvasEl = document.getElementById("taskTypeModal");
                    var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                    offcanvas.hide();
                    //Reset dropdown
                    $("#ddlTaskTypeMaintainance").val("");

                }
                else if (result === "Task Type already exists") {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_TaskTypeExists") %>');

                }
                else {
                    alert(result);
                }
            }
            else {
                alert("Error inserting Task Type");
            }
        }

        function setAsDefault(tasktypeid) {
            
            var request = {
                taskTypeID: tasktypeid,
                projectID: globalProjectID,
                modifiedBy: "Admin" // replace with logged-in user if needed
            };

            console.log("Set Default Request:", request);

            var response = AJAXCallWithResult(
                "/api/GlobalProject/SetDefaultTaskType",
                JSON.stringify(request),
                false
            );

            console.log("Set Default Response:", response);

            if (response && response.message && response.message.CommonResultEntity) {

                var result = response.message.CommonResultEntity[0];
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_DefTaskSetSuccess") %>');

                //Refresh grid
                getProjectTaskTypes(globalProjectID);
                //if (result && result.toLowerCase() === "updated") {
                //    alert('kjnk');
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.success('Default Task Type set successfully.');

                //    //Refresh grid
                //    getProjectTaskTypes(globalProjectID);
                //}
                //else {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error(result);
                //}
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Error while setting default task type");
            }
        }

        function initializeTooltips() {
            document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (el) {
                var existing = bootstrap.Tooltip.getInstance(el);
                if (existing) {
                    existing.dispose();
                }
                new bootstrap.Tooltip(el, {
                    container: 'body',
                    trigger: 'hover focus'
                });
            });
        }

        //function formatDateToISO(dateStr) {
        //    debugger
        //    if (!dateStr) return null;

        //    var parts = dateStr.split('-');
        //    if (parts.length !== 3) return null;

        //    var day = parts[0];
        //    var month = parts[1];
        //    var year = parts[2];

        //    return `${year}-${month}-${day}`;
        //}

        function formatDateToISO(dateStr) {
            if (!dateStr) return null;

            // Expecting format: dd MMM yyyy (e.g., 22 Apr 2026)
            var parts = dateStr.split(" ");
            if (parts.length !== 3) return null;

            var day = parts[0].padStart(2, '0');
            var monthStr = parts[1];
            var year = parts[2];

            var monthMap = {
                Jan: "01", Feb: "02", Mar: "03", Apr: "04",
                May: "05", Jun: "06", Jul: "07", Aug: "08",
                Sep: "09", Oct: "10", Nov: "11", Dec: "12"
            };

            var month = monthMap[monthStr];
            if (!month) return null;

            return `${year}-${month}-${day}`; // yyyy-MM-dd
        }

        function parseDate(dateStr) {
            var parts = dateStr.split(" ");
            var day = parseInt(parts[0], 10);
            var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var month = monthNames.indexOf(parts[1]);
            var year = parseInt(parts[2], 10);

            return new Date(year, month, day);
        }
        //$('#selectGenericTasksModal').on('shown.bs.offcanvas', function () {
        //    alert('99');
        //    getGenericTasksList(gtCurrentPage);
        //});

        var ajaxResult = '';
        function AJAXCallWithResult(url, param, async) {

            if (url.substring(0, 1) === "/") {
                url = url.substring(1);
            }

            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                }
            });
            return ajaxResult;
        }
    </script>
</body>

</html>