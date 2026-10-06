<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_EntityResourceTimesheet.aspx.vb" Inherits="Whizible.PM_EntityResourceTimesheet" %>
<!DOCTYPE html>
<%-- Added by Dipali V on 3rd Dec 2025 - New Resource Timesheet Approval Page --%>
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
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/PM_EntityApproval.css"> 
<!-- CSS moved to PM_EntityApproval.css by Dipali V on 5th Dec 2025 -->
<!-- Task status icon tooltip styles moved to PM_EntityApproval.css - Dipali V on 10th Dec 2025 -->

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
 </style>
 <!-- End of Same loader as PM_EntityProjectApproval - Added By Vyankat B. on 17th March 2026 -->

<style>
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
        <!-- Resource Timesheet Entity Start here -->
        <!-- Hidden input keeps existing JS references working; value is set via postMessage from parent -->
        <input type="hidden" id="txtResourceName" value="" />
        <div id="ResourceTSEntity" class="allEntity col-sm-12">
            <table id="tblEWA_ResourceTS" class="table tbl_wrkflow_approval entity-table" style="width: 100%;">
                <colgroup>
                    <col style="width: 140px;">
                    <col style="width: 180px;">
                    <col style="width: 200px;">
                    <col style="width: 130px;">
                    <col style="width: 120px;">
                    <col style="width: 120px;">
                </colgroup>
                <thead class="stickyTblHeader">
                    <tr>
                        <th><%= MyBase.GetResourceString("C_Ename") %></th>
                        <th class="sortable-header" id="thPeriod" onclick="togglePeriodSort()">
                            <span class="sort-label">
                                <span><%= MyBase.GetResourceString("C_Period") %></span>
                                <span class="sort-arrows">
                                    <i class="fas fa-caret-up arrow-up"></i>
                                    <i class="fas fa-caret-down arrow-down"></i>
                                </span>
                            </span>
                        </th>
                        <th class="text-center"><%= MyBase.GetResourceString("C_Hours") %></th>
                        <th><%= MyBase.GetResourceString("C_PTStatus") %></th>
                        <th><%= MyBase.GetResourceString("C_SND_Comment") %></th>
                        <th class="text-center"><%= MyBase.GetResourceString("C_Action") %></th>
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
        <!-- Resource Timesheet Entity End here -->

        <!-- Resource Timesheet information offcanvas Section Start Here-->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="ResourceTSDetailsOffcanvas">
            <div class="offcanvas-body">
                <div id="ResourceTSInfo_Sec" class="ProjInfoDetails">
                    <div class="graybg container-fluid py-1 mb-2 statckmainheader">
                        <div class="d-flex align-items-center justify-content-between">
                            <h5 class="pgtitle mb-0">
                                <%= MyBase.GetResourceString("C_TimesheetDetails")%>
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

                        <div class="col-sm-10 d-flex gap-3 justify-content-end" id="Actionlinks_ResourceTS">
                            <a href="javascript:;" onclick="callIframeFunctionPT('ApproveRejectResourceTimesheet','A', 'EditView', 0)" id="btnRTSApproved">
                                &nbsp;<%= MyBase.GetResourceString("C_Approve") %>
                            </a>
                            <a href="javascript:;" onclick="callIframeFunctionPT('ApproveRejectResourceTimesheet','R', 'EditView', 0)" id="btnRTSRejected">
                                &nbsp;<%= MyBase.GetResourceString("C_LeaveReject")%>
                            </a>
                           <%-- <button type="button" class="btn borderbtn closeWindowBtn closebtn text-end"
                                data-bs-dismiss="offcanvas">
                               <%= MyBase.GetResourceString("C_Close") %> 
                            </button>--%>
                        </div>
                    </div>
                    <div class="ResourceTSDetailsContent">
                        <div class="accordion WF_TopAccordianPanel mb-3 mt-3" id="ResourceTSDetailsAcc">
                            <!-- Header Details Section -->
                            <div class="accordion-item mb-3">
                                <h2 class="accordion-header" id="ResourceTSHeaderHeading">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#ResourceTSHeaderTab" aria-expanded="true">
                                        <%= MyBase.GetResourceString("C_RT")%>
                                    </button>
                                </h2>
                                <div id="ResourceTSHeaderTab" class="accordion-collapse collapse show"
                                    aria-labelledby="ResourceTSHeaderHeading">
                                    <div class="accordion-body" id="TbodyRTSHeader">
                                        <div class="main-form">
                                            <div class="row form-group">
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_WeekPeriod")%> :</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span id="lblWeekPeriod"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_ResourceName")%> :</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span id="lblResourceName"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_WeekTotal")%> :</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span id="lblWeekTotal"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_ExpectedHours")%> :</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start">
                                                            <span id="lblExpectedHours"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 text-end">
                                                            <label><%= MyBase.GetResourceString("C_TimesheetStatus")%> :</label>
                                                        </div>
                                                        <div class="col-sm-7 text-start  align-items-center gap-1">
                                                            <span id="lblTimesheetStatus"></span>
                                                            <!-- Added by Dipali V on 5th Dec 2025 - History icon with hover popover -->
                                                            <span class="history-popover-wrapper" id="historyPopoverWrapper">
                                                                <i class="fas fa-history history-trigger" id="historyTrigger"></i>
                                                                <div class="history-popover" id="historyPopover">
                                                                    <div class="history-popover-arrow"></div>
                                                                    <div class="history-popover-header">
                                                                        <i class="fas fa-clock-rotate-left me-1"></i><%= MyBase.GetResourceString("C_AH")%>
                                                                    </div>
                                                                    <div class="history-popover-content" id="historyPopoverContent">
                                                                        <div class="history-loading">
                                                                            <i class="fas fa-spinner fa-spin"></i> Loading...
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Timesheet Grid Section -->
                            <div class="accordion-item mb-3">
                                <h2 class="accordion-header" id="ResourceTSGridHeading">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#ResourceTSGridTab" aria-expanded="true" aria-controls="ResourceTSGridTab">
                                        <i class="fas fa-list-ul me-2 timesheet-entries-icon"></i><%= MyBase.GetResourceString("C_TE")%>
                                    </button>
                                </h2>
                                <div id="ResourceTSGridTab" class="accordion-collapse collapse show"
                                    aria-labelledby="ResourceTSGridHeading">
                                    <div class="accordion-body">
                                        <!-- Legend Section - Added by Dipali V on 10th Dec 2025 -->
                                        <div class="legend-section mb-3 p-2" style="background:#f8f9fa; border-radius:6px; border:1px solid #e9ecef;">
                                            <div class="d-flex flex-wrap align-items-center gap-4">
                                                <span class="fw-semibold text-muted" style="font-size:12px;"><i class="fas fa-info-circle me-1"></i>Legend:</span>
                                                <!-- Status Legends -->
                                                <div class="d-flex align-items-center gap-3">
                                                     <span class="d-flex align-items-center gap-1" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_RFA")%>">
                                                         <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#ffc107;"></span>
                                                         <small style="font-size:11px;"><%= MyBase.GetResourceString("C_ReadyforApproval")%></small>
                                                     </span>
                                                    <span class="d-flex align-items-center gap-1" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_TSPartially")%>">
                                                        <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#fd7e14;"></span>
                                                        <small style="font-size:11px;"><%= MyBase.GetResourceString("C_PAApproved")%></small>
                                                    </span>
                                                   <span class="d-flex align-items-center gap-1" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_ApprovedByApproers")%>">
                                                        <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#28a745;"></span>
                                                        <small style="font-size:11px;"><%= MyBase.GetResourceString("C_Approved")%></small>
                                                    </span>
                                                    
                                                    <span class="d-flex align-items-center gap-1" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_PRejected")%>">
                                                        <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#1359a6;"></span>
                                                        <small style="font-size:11px;"><%= MyBase.GetResourceString("C_PRejected")%></small>
                                                    </span>
                                                    <span class="d-flex align-items-center gap-1" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_TSRejected")%>">
                                                        <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#dc3545;"></span>
                                                        <small style="font-size:11px;"><%= MyBase.GetResourceString("C_Rejected")%></small>
                                                    </span>
                                                   
                                                </div>
                                                <%--<span class="text-muted">|</span>--%>
                                                <!-- Task Icon Legends -->
                                                <div class="d-flex align-items-center gap-3">
                                                    <span class="d-flex align-items-center gap-1" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_PendingYou")%>">
                                                        <i class="fas fa-check-circle" style="color:#28a745;font-size:14px;"></i>
                                                        <small style="font-size:11px;"><%= MyBase.GetResourceString("C_PendingMe")%></small>
                                                    </span>
                                                    <span class="d-flex align-items-center gap-1" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_NotPendingyou")%>">
                                                        <i class="fas fa-check-circle" style="color:#1359a6;font-size:14px;"></i>
                                                        <small style="font-size:11px;"><%= MyBase.GetResourceString("C_PendingnotMe")%></small>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Legend Section -->
                                        <div class="table-responsive">
                                            <table id="tblResourceTSGrid" class="table table-bordered table-sm">
                                                <thead id="theadResourceTS">
                                                    <!-- Dynamic headers will be added here -->
                                                </thead>
                                                <tbody id="tbodyResourceTS">
                                                    <!-- Dynamic rows will be added here -->
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Resource Timesheet information offcanvas Section End Here-->
    </div>

<input type="hidden" id="hdnTimesheetID" value="0" />
<input type="hidden" id="hdnEmployeeID" value="0" />
<input type="hidden" id="hdnFromDate" value="" />
<input type="hidden" id="hdnToDate" value="" />
<input type="hidden" id="hdnResourceTSStatusCode" value="" />


<script type="text/javascript">
    // Added by Dipali V on 3rd Dec 2025 - Resource Timesheet Approval Page JavaScript

    var CTagID = 10;  // Resource Timesheet TagID
    var StrResult = [];
    var strAlertType = 'T';
    var API_BASE = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>'.replace(/\/?$/, '/');
    var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
    var EditAccess = "<%= m_EditAccess %>";
    var currentTimesheetID = 0;
    var currentEmployeeID = 0;
    var currentFromDate = '';
    var currentToDate = '';
    
    // Added by Dipali V on 10th Dec 2025 - Period column sorting
    var periodSortOrder = 'none'; // 'none', 'asc', 'desc'

    $(document).ready(function () {

        // Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner 
        // StartLoader("#Body")
        // End of Commented By Vyankat B. on 17th March 2026 for the removal of old LoadingOverlay spinner

        console.log('Resource Timesheet Page Loaded');
        strAlertType = getQueryParam("FilterIW") || 'T';
        
        // Modified by Dipali V on 4th Dec 2025 - Removed date and status defaults, only Resource Name filter remains
        // Load data
        loadWithFilters(strAlertType);
        $("#txtResourceName").val('');


        //Commented By Vyankat on 17th March 2026 for the removal of old LoadingOverlay spinner
        //StopAjaxLoader("#Body")
        // End of Commented By Vyankat on 17th March 2026 for the removal of old LoadingOverlay spinner


    });

    // Added by Dipali V on 3rd Dec 2025 - Calculate and set current week dates (Monday to Sunday)
    function setDefaultCurrentWeekDates() {
        var today = new Date();
        var dayOfWeek = today.getDay(); // 0 = Sunday, 1 = Monday, ..., 6 = Saturday
        
        // Calculate Monday (start of week)
        var diffToMonday = dayOfWeek === 0 ? -6 : 1 - dayOfWeek;
        var monday = new Date(today);
        monday.setDate(today.getDate() + diffToMonday);
        
        // Calculate Sunday (end of week)
        var sunday = new Date(monday);
        sunday.setDate(monday.getDate() + 6);
        
        // Format dates as YYYY-MM-DD for input[type="date"]
        var fromDate = formatDateForInput(monday);
        var toDate = formatDateForInput(sunday);
        
        // Set default values
        $('#txtRTSFromDate').val(fromDate);
        $('#txtRTSToDate').val(toDate);
        
        console.log('Default week dates set:', fromDate, 'to', toDate);
    }

    // Format date as YYYY-MM-DD for input[type="date"]
    function formatDateForInput(date) {
        var year = date.getFullYear();
        var month = String(date.getMonth() + 1).padStart(2, '0');
        var day = String(date.getDate()).padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // Apply Resource Timesheet filters - Modified to auto-apply without notification
    function applyResourceTSFilters() {
        loadWithFilters(strAlertType);
    }

    // Clear Resource Timesheet filters and reset to defaults
    // Modified by Dipali V on 4th Dec 2025 - Removed Status and Date filters
    function clearResourceTSFilters() {
        $('#txtResourceName').val('');
        // Reset sort order when clearing filters - Added by Dipali V on 10th Dec 2025
        periodSortOrder = 'none';
        updateSortIcons();
        loadWithFilters(strAlertType);
        alertify.set('notifier', 'position', 'top-right');
        alertify.success('Filters Reset');
    }

    // Added by Dipali V on 10th Dec 2025 - Toggle Period column sorting
    function togglePeriodSort() {
        // Cycle through: none -> asc -> desc -> none
        if (periodSortOrder === 'none') {
            periodSortOrder = 'asc';
        } else if (periodSortOrder === 'asc') {
            periodSortOrder = 'desc';
        } else {
            periodSortOrder = 'none';
        }
        
        updateSortIcons();
        
        // Re-render the list with sorted data
        var sortedData = sortDataByPeriod(StrResult, periodSortOrder);
        renderListViews(sortedData);
    }

    // Update sort icons based on current sort order
    function updateSortIcons() {
        var $header = $('#thPeriod');
        var $arrowUp = $header.find('.arrow-up');
        var $arrowDown = $header.find('.arrow-down');
        
        // Reset to default state
        $arrowUp.removeClass('active');
        $arrowDown.removeClass('active');
        $header.removeClass('sort-asc sort-desc');
        
        if (periodSortOrder === 'asc') {
            $arrowUp.addClass('active');
            $header.addClass('sort-asc');
        } else if (periodSortOrder === 'desc') {
            $arrowDown.addClass('active');
            $header.addClass('sort-desc');
        }
    }

    // Sort data by period (fromDate)
    function sortDataByPeriod(data, order) {
        if (!data || data.length === 0 || order === 'none') {
            return data;
        }
        
        // Create a copy to avoid mutating original array
        var sortedData = data.slice();
        
        sortedData.sort(function(a, b) {
            // Parse fromDate for comparison
            var dateA = parseDate(a.fromDate);
            var dateB = parseDate(b.fromDate);
            
            if (order === 'asc') {
                return dateA - dateB;
            } else {
                return dateB - dateA;
            }
        });
        
        return sortedData;
    }

    // Parse date string to Date object for sorting
    function parseDate(dateStr) {
        if (!dateStr) return new Date(0);
        // Handle various date formats
        var date = new Date(dateStr);
        if (isNaN(date.getTime())) {
            // Try parsing DD-Mon-YYYY format (e.g., "13-May-2024")
            var parts = dateStr.split('-');
            if (parts.length === 3) {
                var months = {
                    'Jan': 0, 'Feb': 1, 'Mar': 2, 'Apr': 3, 'May': 4, 'Jun': 5,
                    'Jul': 6, 'Aug': 7, 'Sep': 8, 'Oct': 9, 'Nov': 10, 'Dec': 11
                };
                var day = parseInt(parts[0]);
                var month = months[parts[1]];
                var year = parseInt(parts[2]);
                if (!isNaN(day) && month !== undefined && !isNaN(year)) {
                    date = new Date(year, month, day);
                }
            }
        }
        return isNaN(date.getTime()) ? new Date(0) : date;
    }

    // Load data with filters applied
    function loadWithFilters(flag) {
        console.log('Loading Resource Timesheet with filters, flag:', flag, 'TagID:', CTagID);
        var result = fetchEntityDataWithFilters(flag, CTagID);
        console.log('API Result:', result);
        
        // Handle different response structures
        var dataToRender = [];
        if (result) {
            // Check for workflowDetails array (direct API response)
            if (Array.isArray(result)) {
                dataToRender = result;
            } else if (result.workflowDetails && Array.isArray(result.workflowDetails)) {
                dataToRender = result.workflowDetails;
            } else if (result.data && Array.isArray(result.data)) {
                dataToRender = result.data;
            } else if (result.WorkflowDetails && Array.isArray(result.WorkflowDetails)) {
                dataToRender = result.WorkflowDetails;
            }
        }
        
        console.log('Data to render, count:', dataToRender.length);
        StrResult = dataToRender; // Store for later use
        renderListViews(dataToRender);
        hidePageLoader();
    }

    // For Get Parameter which gets from Parent Page
    function getQueryParam(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Main load function - fetches and renders data (uses filters by default)
    function load(flag) {
        console.log('Loading Resource Timesheet with flag:', flag, 'TagID:', CTagID);
        loadWithFilters(flag);
    }

    // Original load function without filters (kept for backward compatibility)
    function loadWithoutFilters(flag) {
        console.log('Loading Resource Timesheet without filters, flag:', flag, 'TagID:', CTagID);
        var result = fetchEntityDataForTag(flag, CTagID);
        console.log('API Result:', result);
        if (result && result.data) {
            console.log('Data received, count:', result.data.length);
            renderListViews(result.data);
        } else {
            console.log('No data received or result is null');
            renderListViews([]);
        }
        hidePageLoader();
    }

    // Auto-apply filters on value change - Modified by Dipali V on 3rd Dec 2025
    // Resource Name - apply on Enter key or after typing stops (debounced)
    var resourceNameTimer;
    $(document).on('keyup', '#txtResourceName', function(e) {
        clearTimeout(resourceNameTimer);
        if (e.keyCode === 13) { // Enter key - immediate apply
            applyResourceTSFilters();
        } else {
            // Debounce - apply after 500ms of no typing
            resourceNameTimer = setTimeout(function() {
                applyResourceTSFilters();
            }, 500);
        }
    });

    // Modified by Dipali V on 4th Dec 2025 - Removed Status and Date filter event handlers

    // Hide page loader
    function hidePageLoader() {
        setTimeout(() => {
            $('#pageLoaderEntity').fadeOut(300);
            $('.main-content-wrapper').addClass('loaded');
            $('body').removeClass('page-loading');
        }, 500);
    }

    // Format date for display
    function formatDate(dateString) {
        if (!dateString) return '';
        var date = new Date(dateString);
        var day = String(date.getDate()).padStart(2, '0');
        var mon = date.toLocaleString('en-US', { month: 'short' });
        var year = date.getFullYear();
        return day + '-' + mon + '-' + year;
    }

    // Format hours to HH:MM display
    // Fixed by Dipali V on 18th Dec 2025 - Handle different input formats safely
    // Handles:
    // 1. Already in HH:MM format (e.g., "05:45") → return as-is
    // 2. Decimal format where decimal part = minutes (e.g., 5.45 = 5h 45m, 7.3 = 7h 30m) → convert correctly
    // 3. True decimal hours (e.g., 5.75 = 5h 45m) → convert correctly
    // 4. Whole numbers (e.g., 5) → convert to 05:00
    function formatHoursToHHMM(hours) {
        if (hours === null || hours === undefined || hours === '') return '00:00';
        
        // Convert to string first to check format
        var hoursStr = String(hours).trim();
        
        // If already in HH:MM format (contains colon), return as is without any conversion
        if (hoursStr.indexOf(':') !== -1) {
            return hoursStr;
        }
        
        // Handle decimal format
        var parts = hoursStr.split('.');
        if (parts.length === 2) {
            var hrs = parseInt(parts[0]) || 0;
            var decimalPart = parts[1];
            var mins = 0;
            
            // Fixed by Dipali V on 18th Dec 2025 - Handle single digit decimals correctly
            // Rule: If decimal part has 1 digit (e.g., 7.3), multiply by 10 to get minutes (7.3 = 7h 30m)
            // If decimal part has 2 digits and <= 59, treat as direct minutes (e.g., 5.45 = 5h 45m)
            // If decimal part > 59 or has > 2 digits, treat as decimal hours (e.g., 5.75 = 5.75 hours)
            if (decimalPart.length === 1) {
                // Single digit: multiply by 10 to get minutes (e.g., 7.3 = 7 hours 30 minutes)
                mins = parseInt(decimalPart) * 10;
            } else if (decimalPart.length === 2 && parseInt(decimalPart) <= 59) {
                // Two digits and <= 59: treat as direct minutes (e.g., 5.45 = 5 hours 45 minutes)
                mins = parseInt(decimalPart) || 0;
            } else {
                // More than 2 digits or > 59: treat as true decimal hours (e.g., 5.75 = 5.75 hours = 5h 45m)
                var decimalHours = parseFloat('0.' + decimalPart);
                mins = Math.round(decimalHours * 60);
            }
            
            // Ensure minutes don't exceed 59
            if (mins >= 60) {
                hrs += Math.floor(mins / 60);
                mins = mins % 60;
            }
            
            return String(hrs).padStart(2, '0') + ':' + String(mins).padStart(2, '0');
        }
        
        // If no decimal point, treat as whole hours
        var hrs = parseInt(hoursStr) || 0;
        return String(hrs).padStart(2, '0') + ':00';
    }

    // Get context from session
    function getContext() {
        return {
            EmployeeID: '<%= Session("intUserID") %>' || 0,
            LoginType: '<%= Session("LoginType") %>' || '',
            LoginID: '<%= Session("intLoginID") %>' || 0,
            UserName: '<%= Session("strUserName") %>' || '',
            RoleID: '<%= Session("intPostID") %>' || ''
        };
    }

    // Read top filters from query params or parent
    // Updated by Dipali V on 18th Dec 2025 - Added filter panel reading like other entities for consistency
    function readTopFilters() {
        // Try reading from query string first (iframe pages)
        let bu = getQueryParam("BusinessUnit");
        let ou = getQueryParam("OrganizationUnit");
        let pf = getQueryParam("PendingFrom");
        let en = getQueryParam("EntityName");

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

        return {
            BusinessUnit: normalize(bu),
            OrganizationUnit: normalize(ou),
            PendingFrom: normalize(pf),
            EntityName: en || ''
        };
    }

    // Fetch entity data from API
    function fetchEntityDataForTag(flag, tagId) {
        const ctx = getContext();
        const filters = readTopFilters();
        const param = {
            EmployeeID: ctx.EmployeeID,
            strAlertType: flag,
            TagID: tagId,
            strEntityName: filters.EntityName || '',
            BusinessUnit: (filters.BusinessUnit === undefined || filters.BusinessUnit === null || filters.BusinessUnit === '' ? '0' : filters.BusinessUnit),
            OrganizationUnit: (filters.OrganizationUnit === undefined || filters.OrganizationUnit === null || filters.OrganizationUnit === '' ? '0' : filters.OrganizationUnit),
            PendingFrom: (filters.PendingFrom === undefined || filters.PendingFrom === null || filters.PendingFrom === '' ? '0' : filters.PendingFrom)
        };

        var fullUrl = "api/EntityApproval/GetEntityWFDetails";
        var payload = JSON.stringify(param);
        var result = AJAXCallWithResult(fullUrl, payload, false, "POST");


        console.log('Resource Timesheet Search results:', result);
        StrResult = result;
        return result;
    }

    // Modified by Dipali V on 4th Dec 2025 - Removed Status and Date filters, only Resource Name filter remains
    function fetchEntityDataWithFilters(flag, tagId) {
        const ctx = getContext();
        const filters = readTopFilters();
        
        // Read Resource Name from parent DOM - mirrors PM_EntityLeaveApproval.applyResourceNameFilter()
        // Falls back to query string EntityName (set by OpenTab), then to empty string
        var resourceName = '';
        try {
            if (window.parent && window.parent.document) {
                var parentInput = window.parent.document.getElementById('txtResourceTSName');
                if (parentInput) {
                    resourceName = (parentInput.value || '').trim();
                }
            }
        } catch(e) { }
        if (!resourceName) {
            resourceName = (filters.EntityName || '').trim();
        }
        
        // Build request parameters - Only Employee Name filter
        const param = {
            EmployeeID: ctx.EmployeeID,           // Maps to @intApproverID
            strAlertType: flag,
            TagID: tagId,
            strEntityName: filters.EntityName || '',
            BusinessUnit: (filters.BusinessUnit === undefined || filters.BusinessUnit === null || filters.BusinessUnit === '' ? '0' : filters.BusinessUnit),
            OrganizationUnit: (filters.OrganizationUnit === undefined || filters.OrganizationUnit === null || filters.OrganizationUnit === '' ? '0' : filters.OrganizationUnit),
            PendingFrom: (filters.PendingFrom === undefined || filters.PendingFrom === null || filters.PendingFrom === '' ? '0' : filters.PendingFrom),
            // Resource Timesheet filter - Only Employee Name
            strEmployeeName: resourceName || null
        };

        var fullUrl = "api/EntityApproval/GetEntityWFDetails";
        var payload = JSON.stringify(param);
        
        console.log('Resource Timesheet API Request params:', param);
        
        var result = AJAXCallWithResult(fullUrl, payload, false, "POST");

        console.log('Resource Timesheet API Response:', result);
        
        // Extract workflowDetails from response if present
        var dataArray = [];
        if (result) {
            if (Array.isArray(result)) {
                dataArray = result;
            } else if (result.workflowDetails && Array.isArray(result.workflowDetails)) {
                dataArray = result.workflowDetails;
            } else if (result.WorkflowDetails && Array.isArray(result.WorkflowDetails)) {
                dataArray = result.WorkflowDetails;
            } else if (result.data && Array.isArray(result.data)) {
                dataArray = result.data;
            }
        }
        
        // Apply client-side filtering for resource name if specified - mirrors applyResourceNameFilter in Leave
        if (dataArray.length > 0 && resourceName && resourceName.trim() !== '') {
            var searchTerm = resourceName.toLowerCase().trim();
            dataArray = dataArray.filter(function(item) {
                var employeeName = (item.employeeName || '').toLowerCase();
                return employeeName.indexOf(searchTerm) !== -1;
            });
        }
        
        // Return in consistent format
        StrResult = dataArray;
        return { workflowDetails: dataArray };
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


    // Render list view
    function renderListViews(rows) {
        console.log('Rendering rows:', rows);
        // Apply current sort order if any - Added by Dipali V on 10th Dec 2025
        var dataRows = sortDataByPeriod(rows || [], periodSortOrder);
        const tableSelector = '#tblEWA_ResourceTS';
        const $tbody = $(tableSelector + ' tbody');

        $tbody.empty();

        if (dataRows.length === 0) {
            const colCount = $(tableSelector + ' thead th').length;
            $tbody.append(
                '<tr>' +
                '<td colspan="' + colCount + '" class="dataTables_empty"><%= MyBase.GetResourceString("C_NoData") %></td>' +
                '</tr>'
            );
        } else {
            dataRows.forEach((r, index) => {
                let tr = generateTableRow(r, CTagID, index);
                $tbody.append(tr);
            });
        }

        // Destroy DataTable safely
        if ($.fn.DataTable.isDataTable(tableSelector)) {
            $(tableSelector).DataTable().clear().destroy();
        }

        // Reinitialize DataTable
        $tbody.html('');
        dataRows.forEach((r, index) => {
            const tr = generateTableRow(r, CTagID, index);
            $tbody.append(tr);
        });

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

        // Dispose old tooltips and reinitialize - Modified by Dipali V on 10th Dec 2025
        $('[data-bs-toggle="tooltip"]').each(function() {
            var tooltipInstance = bootstrap.Tooltip.getInstance(this);
            if (tooltipInstance) {
                tooltipInstance.dispose();
            }
        });
        $('[data-bs-toggle="tooltip"]').tooltip();
    }

    // Generate table row for Resource Timesheet
    // Modified by Dipali V on 3rd Dec 2025 - Combined hours column with visual indicators
    // Modified by Dipali V on 3rd Dec 2025 - Fixed layout and changed action icons to thumbs for consistency
    // Modified by Dipali V on 5th Dec 2025 - Added employee image before employee name
    function generateTableRow(r, tagId, index) {
        var employeeName = r.employeeName || '';
        var displayName = employeeName.length > 15 ? employeeName.substring(0, 15) + '...' : employeeName;
        var period = r.period || '';
        
        // Added by Dipali V on 5th Dec 2025 - Employee image with no-photo fallback
        var systemFilename = r.systemFilename || r.SystemFilename || null;
        var defaultImg = '../../../Images/Photo/no-photo.png';
        var employeeImg = defaultImg;
        if (systemFilename && systemFilename.trim() !== '') {
            var filename = systemFilename.split('/').pop();
            employeeImg = '../../../Images/Photo/' + filename;
        }
        
        var showApprove = false;
        var showReject = false;

        // Determine which buttons to show based on status
        // Modified by Dipali V on 5th Dec 2025 - Added J (Rejected) status handling with case-insensitive check
        // R = Ready for approval/Submitted (can Approve or Reject)
        // V = Approved/Verified (no actions needed)
        // J = Rejected (no actions needed)
        var statusUpper = (r.statusCode || '').toUpperCase();
        if (statusUpper === 'V' || statusUpper === 'APPROVED' || statusUpper === 'VERIFIED') {
            showApprove = false;
            showReject = false;
        } else if (statusUpper === 'J' || statusUpper === 'REJECTED') {
            // Rejected - no actions needed
            showApprove = false;
            showReject = false;
        } else if (statusUpper === 'R' || statusUpper === 'READY FOR APPROVAL' || 
                   statusUpper === 'S' || statusUpper === 'SUBMITTED') {
            showApprove = true;
            showReject = true;
        } else {
            // Default: show both for any pending/unknown status to allow action
            showApprove = true;
            showReject = true;
        }

        // Build hours comparison display with visual indicators
        var hoursDisplay = buildHoursDisplay(r.actualHours, r.expectedHours);
        
        // Build status HTML - Updated by Dipali V on 18th Dec 2025 - Handle IsPartiallyRejected flag for list view
        var statusHtml = '';
        // Check for IsPartiallyRejected flag
        var isPartiallyRejectedRaw = r.IsPartiallyRejected !== undefined ? r.IsPartiallyRejected : r.isPartiallyRejected;
        var isPartiallyRejected = (isPartiallyRejectedRaw === 1 || isPartiallyRejectedRaw === '1' || isPartiallyRejectedRaw === true);
        
        // If IsPartiallyRejected, use blue color and "Partially Rejected" text
        if (isPartiallyRejected) {
            statusHtml = '<span class="statusBox bgBlue me-2">&nbsp;</span>' +
                        '<label class="status-label mb-0">Partially Rejected</label>';
        } else {
            // Otherwise use normal status handling
            var statusClass = getStatusClass(r.statusCode);
            var statusText = r.statusDescription || r.statusCode || '';
            statusHtml = '<span class="statusBox ' + statusClass + ' me-2">&nbsp;</span>' +
                        '<label class="status-label mb-0">' + statusText + '</label>';
        }

        var tr = [
            '<tr>',
            // Employee Name column - with image only (icon moved to Action column)
            '<td class="entity-code-cell">',
            '<div class="entity-code-wrapper d-flex align-items-center gap-2">',
            '<img src="', employeeImg, '" alt="', employeeName, '" class="employee-avatar" style="width:28px;height:28px;border-radius:50%;object-fit:cover;border:1px solid #dee2e6;flex-shrink:0;" onerror="this.src=\'', defaultImg, '\'">',
            '<span class="entity-code-text" style="white-space:nowrap;">', displayName, '</span>',
            '</div>',
            '</td>',
            // Period column - normal text display
            '<td>', period, '</td>',
            // Combined Hours column with visual indicator
            '<td class="text-center">', hoursDisplay, '</td>',
            // Status column
            '<td>',
            '<div class="statusDiv d-flex justify-content-start align-items-center">',
            statusHtml,
            '</div>',
            '</td>',
            // Comment column
            '<td class="comment-cell">', truncateText(r.comment, 20), '</td>',
        ].join('');

        // Action buttons - Using thumbs up/down icons for consistency with other pages
        // Added by Dipali V on 18th Dec 2025 - Resource Timesheet Details icon moved to Action column
        if (EditAccess === true || EditAccess === 'True') {
            tr += [
                '<td class="text-center">',
                '<div class="deskAppRejButns d-flex justify-content-center align-items-center gap-3">',
                '<a href="javascript:;" onclick="GetResourceTSDetails(', (r.timesheetID || 0), ',', (r.employeeID || 0), ',\'', (r.fromDate || ''), '\',\'', (r.todate || r.toDate || ''), '\')" data-bs-toggle="tooltip" data-bs-original-title="Resource Timesheet Details" class="rts-details-icon" style="width:20px;display:inline-flex;justify-content:center;">',
                '<i class="far fa-list-alt" style="font-size:14px;"></i>',
                '</a>',
                (showApprove
                    ? '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-original-title="Approve" onclick="ApproveRejectResourceTimesheet(\'A\', \'ListView\', ' + (r.timesheetID || 0) + ', ' + (r.employeeID || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;">' +
                      '<i class="far fa-thumbs-up text-green" style="font-size:14px;"></i></a>'
                    : ''),
                (showReject
                    ? '<a href="javascript:;" data-bs-toggle="tooltip" data-bs-original-title="Reject" onclick="ApproveRejectResourceTimesheet(\'R\', \'ListView\', ' + (r.timesheetID || 0) + ', ' + (r.employeeID || 0) + ')" style="width:20px;display:inline-flex;justify-content:center;">' +
                      '<i class="far fa-thumbs-down textRed" style="font-size:14px;"></i></a>'
                    : ''),
                '</div>',
                '</td>'
            ].join('');
        } else {
            tr += [
                '<td class="text-center">',
                '<div class="deskAppRejButns d-flex justify-content-center align-items-center gap-3">',
                '<a href="javascript:;" onclick="GetResourceTSDetails(', (r.timesheetID || 0), ',', (r.employeeID || 0), ',\'', (r.fromDate || ''), '\',\'', (r.todate || r.toDate || ''), '\')" data-bs-toggle="tooltip" data-bs-original-title="Resource Timesheet Details" class="rts-details-icon" style="width:20px;display:inline-flex;justify-content:center;">',
                '<i class="far fa-list-alt" style="font-size:14px;"></i>',
                '</a>',
                '</div>',
                '</td>'
            ].join('');
        }

        tr += '</tr>';
        return tr;
    }

    // Build hours display with visual comparison indicator
    // Modified by Dipali V on 4th Dec 2025 - Attractive compact box with icons:
    // Green: Actual = Expected | Red: Actual < Expected | Orange: Actual > Expected
    function buildHoursDisplay(actualHours, expectedHours) {
        var actual = actualHours || '00:00';
        var expected = expectedHours || '00:00';
        
        // Parse hours to minutes for comparison
        var actualMinutes = parseHoursToMinutes(actual);
        var expectedMinutes = parseHoursToMinutes(expected);
        
        // Determine status based on timesheet fill
        var isOvertime = actualMinutes > expectedMinutes;
        var isUnderFilled = actualMinutes < expectedMinutes;
        var isOnTrack = actualMinutes === expectedMinutes;
        var diff = Math.abs(actualMinutes - expectedMinutes);
        var diffDisplay = formatMinutesToHours(diff);
        
        var percentFilled = expectedMinutes > 0 ? Math.round((actualMinutes / expectedMinutes) * 100) : 0;
        
        var bgStyle = '';
        var borderColor = '';
        var statusTooltip = '';
        var diffBadge = '';
        var actualColor = '';
        
        if (isOnTrack) {
            bgStyle = 'background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);';
            borderColor = '#28a745';
            actualColor = '#155724';
            statusTooltip = 'Perfect Match - ' + percentFilled + '% complete';
            diffBadge = '<span style="background:#28a745;color:#fff;padding:2px 6px;border-radius:10px;font-size:10px;"><i class="fas fa-check" style="font-size:9px;"></i> On Target</span>';
        } else if (isUnderFilled) {
            bgStyle = 'background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);';
            borderColor = '#dc3545';
            actualColor = '#dc3545';
            statusTooltip = 'Under Filled - ' + percentFilled + '% complete, missing ' + diffDisplay;
            diffBadge = '<span style="background:#dc3545;color:#fff;padding:2px 6px;border-radius:10px;font-size:10px;"><i class="fas fa-arrow-down" style="font-size:9px;"></i> -' + diffDisplay + '</span>';
        } else if (isOvertime) {
            bgStyle = 'background: linear-gradient(135deg, #fff3cd 0%, #ffeeba 100%);';
            borderColor = '#fd7e14';
            actualColor = '#fd7e14';
            statusTooltip = 'Overtime - ' + percentFilled + '% filled, extra ' + diffDisplay;
            diffBadge = '<span style="background:#fd7e14;color:#fff;padding:2px 6px;border-radius:10px;font-size:10px;"><i class="fas fa-arrow-up" style="font-size:9px;"></i> +' + diffDisplay + '</span>';
        }
        
        var html = [
            '<div style="', bgStyle, 'border-radius:8px;padding:5px 11px;display:inline-block;min-width:196px;text-align:center;" data-bs-toggle="tooltip" data-bs-original-title="', statusTooltip, '">',
            // Hours Display with Icons
            '<div style="display:flex;align-items:center;justify-content:center;gap:4px;">',
            // Actual Hours with Clock/Timer icon
            '<span style="color:', actualColor, ';font-weight:700;font-size:13px;display:flex;align-items:center;">',
            '<i class="fas fa-stopwatch" style="font-size:11px;margin-right:3px;"></i>', actual,
            '</span>',
            // Separator
            '<span style="color:#888;font-size:12px;margin:0 2px;">/</span>',
            // Expected Hours with Target icon
            '<span style="color:#6c757d;font-size:12px;display:flex;align-items:center;">',
            '<i class="fas fa-bullseye" style="font-size:10px;margin-right:3px;"></i>', expected,
            '</span>',
            '</div>',
            // Difference Badge
            '<div style="margin-top:4px;">', diffBadge, '</div>',
            '</div>'
        ].join('');
        
        return html;
    }

    // Parse time string (HH:MM) to total minutes
    function parseHoursToMinutes(timeStr) {
        if (!timeStr || timeStr === '00:00') return 0;
        var parts = timeStr.toString().split(':');
        if (parts.length === 2) {
            return (parseInt(parts[0]) || 0) * 60 + (parseInt(parts[1]) || 0);
        }
        // Handle decimal hours
        var hours = parseFloat(timeStr) || 0;
        return Math.round(hours * 60);
    }

    // Format minutes back to HH:MM display
    function formatMinutesToHours(minutes) {
        var hrs = Math.floor(minutes / 60);
        var mins = minutes % 60;
        return String(hrs).padStart(2, '0') + ':' + String(mins).padStart(2, '0');
    }

    // Get status class for status indicator
    // R = Ready for approval (Orange), V = Approved (Green), Rejected (Red), Partially Rejected (Blue)
    // Updated by Dipali V on 18th Dec 2025 - Added Partially Rejected support
    function getStatusClass(statusCode) {
        if (!statusCode) return 'bgGray';
        var statusUpper = (statusCode || '').toString().toUpperCase();
        switch (statusUpper) {
            case 'V':
            case 'APPROVED':
            case 'VERIFIED':
                return 'bgGreen';
            case 'R':
            case 'READY FOR APPROVAL':
            case 'S':
            case 'SUBMITTED':
            case 'SENT FOR APPROVAL':
                return 'bgOrange';
            case 'J':
            case 'REJECTED':
                return 'bgRed';
            case 'PARTIALLY REJECTED':
                return 'bgBlue';
            default:
                return 'bgGray';
        }
    }

    // Truncate text with ellipsis and tooltip
    // Updated by Dipali V on 18th Dec 2025 - Added HTML escaping for tooltip
    function truncateText(text, maxLength) {
        if (!text) return '';
        text = text.toString().trim();
        // Escape HTML for tooltip to prevent XSS
        var escapedText = text.replace(/"/g, '&quot;').replace(/'/g, '&#39;');
        if (text.length <= maxLength) return text;
        return '<span data-bs-toggle="tooltip" data-bs-placement="top" data-bs-original-title="' + escapedText + '">' + text.substring(0, maxLength) + '...</span>';
    }

    // Escape HTML special characters for safe attribute values - Added by Dipali V on 10th Dec 2025
    function escapeHtml(text) {
        if (!text) return '';
        var div = document.createElement('div');
        div.appendChild(document.createTextNode(text));
        return div.innerHTML;
    }

    // Get Resource Timesheet Details for offcanvas
    function GetResourceTSDetails(timesheetID, employeeID, fromDate, toDate) {
        currentTimesheetID = timesheetID;
        currentEmployeeID = employeeID;
        currentFromDate = fromDate;
        currentToDate = toDate;

        $('#hdnTimesheetID').val(timesheetID);
        $('#hdnEmployeeID').val(employeeID);
        $('#hdnFromDate').val(fromDate);
        $('#hdnToDate').val(toDate);

        var ctx = getContext();
        // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
        var param = JSON.stringify({
            TimesheetID: timesheetID,
            EmployeeID: employeeID,
            StartDate: fromDate,
            EndDate: toDate,
            ApproverID: ctx.EmployeeID
        });
        var fullUrl = 'api/EntityApproval/GetResourceTimesheetDetails';
        
        try {
            var response = AJAXCallWithResult(fullUrl, param, false, 'POST');
            console.log('Resource Timesheet Details:', response);
            bindResourceTSDetails(response);
            
            // Send offcanvas HTML to parent for rendering (same as Project Timesheet)
            var offcanvasEl = document.getElementById('ResourceTSDetailsOffcanvas');
            if (!offcanvasEl) {
                console.error('ResourceTSDetailsOffcanvas element not found');
                return;
            }
            
            var offcanvasHTML = offcanvasEl.outerHTML;
            
            // Inject tooltip CSS for task status icons - Added by Dipali V on 10th Dec 2025
            // Fixed by Dipali V on [Date] - Tooltip should not hide, stays visible on hover with longer delay
            // This CSS is needed in parent window for tooltips to work
            var tooltipCSS = '<style id="taskTooltipStyles">' +
                '.task-status-icon { position: relative; display: inline-flex; align-items: center; justify-content: center; cursor: help; }' +
                '.task-status-icon::before, .task-status-icon::after { position: absolute; opacity: 0; visibility: hidden; transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out; pointer-events: none; z-index: 9999; }' +
                '.task-status-icon::after { content: attr(data-tooltip); bottom: 100%; left: 50%; transform: translateX(-50%); margin-bottom: 8px; padding: 6px 12px; background-color: #000; color: #fff; font-size: 12px; font-weight: 400; white-space: normal; max-width: 300px; word-wrap: break-word; border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.25); }' +
                '.task-status-icon::before { content: ""; bottom: 100%; left: 50%; transform: translateX(-50%); margin-bottom: 2px; border: 6px solid transparent; border-top-color: #000; }' +
                '.task-status-icon:hover::before, .task-status-icon:hover::after, .task-status-icon.tooltip-visible::before, .task-status-icon.tooltip-visible::after { opacity: 1; visibility: visible; transition-delay: 0s; }' +
                '.task-status-icon:hover, .task-status-icon.tooltip-visible { z-index: 10000; }' +
                '</style>';
            
            // Remove existing tooltip styles if any, then add new ones
            var existingStyles = window.parent.document.getElementById('taskTooltipStyles');
            if (existingStyles) {
                existingStyles.remove();
            }
            window.parent.document.head.insertAdjacentHTML('beforeend', tooltipCSS);
            
            // Send to parent using same format as other pages
            window.parent.postMessage({
                action: "renderOffcanvas",
                html: offcanvasHTML,
                timesheetID: timesheetID
            }, "*");
            
            // Initialize history popover hover after parent renders the offcanvas
            setTimeout(function() {
                initHistoryPopoverHover();
            }, 300);
        } catch (error) {
            console.error('Error fetching resource timesheet details:', error);
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Failed to load timesheet details');
        }
    }

    // Get auth headers
    function getAuthHeaders() {
        return {
            'Authorization': 'Bearer ' + ('<%= Session("strBearerToken") %>' || ''),
            'CompanyID': '<%= Session("intCompanyID") %>' || 0,
            'EmployeeID': '<%= Session("intUserID") %>' || 0
        };
    }

    // Bind Resource Timesheet Details to offcanvas
    // Modified by Dipali V on 5th Dec 2025 - Added IsWorking handling for weekcolumnred and approve/reject button visibility
    function bindResourceTSDetails(data) {
        // Reset history cache when loading new timesheet - Added by Dipali V on 5th Dec 2025
        resetHistoryCache();
        
        // Bind header info
        if (data.header && data.header.length > 0) {
            var h = data.header[0];
            $('#lblWeekPeriod').text(formatDate(h.StartDate) + ' to ' + formatDate(h.EndDate));
            $('#lblResourceName').text(h.ResourceName || '');
            $('#lblWeekTotal').text(h.TotalActual || formatHoursToHHMM(h.ActualHours));
            $('#lblExpectedHours').text(h.ExpectedHours || '');
            
            // Modified by Dipali V on 10th Dec 2025 - Added colored status box with IsPartiallyApproved handling
            // Store status code for approve/reject logic
            var statusCode = h.statusCode || h.StatusCode || h.TimesheetStatusFlag || '';
            $('#hdnResourceTSStatusCode').val(statusCode);
            console.log('Resource Timesheet Status Code:', statusCode);
            
            // Check IsPartiallyApproved flag (if 2 approvers and one approved, pending with other)
            // Handle both number and string types - Modified by Dipali V on 10th Dec 2025
            var isPartiallyApprovedRaw = h.IsPartiallyApproved !== undefined ? h.IsPartiallyApproved : h.isPartiallyApproved;
            var isPartiallyApproved = (isPartiallyApprovedRaw === 1 || isPartiallyApprovedRaw === '1' || isPartiallyApprovedRaw === true);
            
            // Check IsPartiallyRejected flag (if 2 approvers and one rejected, pending with other)
            // Added by Dipali V on 18th Dec 2025 - Handle IsPartiallyRejected flag
            var isPartiallyRejectedRaw = h.IsPartiallyRejected !== undefined ? h.IsPartiallyRejected : h.isPartiallyRejected;
            var isPartiallyRejected = (isPartiallyRejectedRaw === 1 || isPartiallyRejectedRaw === '1' || isPartiallyRejectedRaw === true);
            
            console.log('IsPartiallyApproved Raw:', isPartiallyApprovedRaw, 'Parsed:', isPartiallyApproved);
            console.log('IsPartiallyRejected Raw:', isPartiallyRejectedRaw, 'Parsed:', isPartiallyRejected);
            
            // Determine status color for the box with tooltip
            var statusBoxColor = '';
            var statusTooltip = '';
            var statusText = '';
            var statusUpper = (statusCode || '').toUpperCase();
            
            // Priority: Check IsPartiallyApproved and IsPartiallyRejected FIRST before status code
            // Updated by Dipali V on 18th Dec 2025 - IsPartiallyApproved and IsPartiallyRejected take priority over status code
            if (isPartiallyRejected) {
                // When IsPartiallyRejected is true, always show blue color and "Partially Rejected" text
                statusBoxColor = '#1359a6'; // Blue - Partially Rejected
                statusTooltip = 'Timesheet is Partially Rejected (one approver rejected, pending with another)';
                statusText = 'Partially Rejected'; // Always show "Partially Rejected" when flag is true
            } else if (isPartiallyApproved) {
                // When IsPartiallyApproved is true, always show orange color and "Partially Approved" text
                statusBoxColor = '#fd7e14'; // Orange - Partially Approved
                statusTooltip = 'Timesheet is Partially Approved (one approver approved, pending with another)';
                statusText = 'Partially Approved'; // Always show "Partially Approved" when flag is true
            } else if (statusUpper === 'V' || statusUpper === 'APPROVED' || statusUpper === 'VERIFIED') {
                statusBoxColor = '#28a745'; // Green - Approved
                statusTooltip = 'Timesheet is Approved by all approvers';
                statusText = h.TimesheetStatus || 'Approved';
            } else if (statusUpper === 'J' || statusUpper === 'REJECTED') {
                statusBoxColor = '#dc3545'; // Red - Rejected
                statusTooltip = 'Timesheet is Rejected';
                statusText = h.TimesheetStatus || 'Rejected';
            } else {
                statusBoxColor = '#ffc107'; // Yellow - Ready for Approval
                statusTooltip = 'Timesheet is Ready for approval (Pending)';
                statusText = h.TimesheetStatus || 'Ready for approval';
            }
            
            // Build status display with colored box and tooltip
            // Note: statusText is already set above based on IsPartiallyApproved flag or status code
            
            var statusHtml = '<span class="d-flex align-items-center gap-2">' +
                '<span class="statusBox" data-bs-toggle="tooltip" title="' + statusTooltip + '" ' +
                'style="display:inline-block;width:14px;height:14px;border-radius:3px;background-color:' + statusBoxColor + ';cursor:help;">&nbsp;</span>' +
                '<span>' + statusText + '</span>' +
                '</span>';
            $('#lblTimesheetStatus').html(statusHtml);
            
            // Show/Hide Approve and Reject buttons based on status
            // Modified by Dipali V on 10th Dec 2025 - Simplified using statusUpper already defined above
            // R = Ready for approval/Submitted (can Approve or Reject)
            // V = Approved/Verified (no actions needed)
            // J = Rejected (no actions needed)
            if (statusUpper === 'V' || statusUpper === 'APPROVED' || statusUpper === 'VERIFIED') {
                $('#btnRTSApproved').hide();
                $('#btnRTSRejected').hide();
            } else if (statusUpper === 'J' || statusUpper === 'REJECTED') {
                // Rejected - no actions needed
                $('#btnRTSApproved').hide();
                $('#btnRTSRejected').hide();
            } else if (statusUpper === 'R' || statusUpper === 'READY FOR APPROVAL' || 
                       statusUpper === 'S' || statusUpper === 'SUBMITTED' || isPartiallyApproved === 1) {
                // Show approve/reject buttons for pending or partially approved timesheets
                $('#btnRTSApproved').show();
                $('#btnRTSRejected').show();
            } else {
                // Default: show both for any pending/unknown status to allow action
                $('#btnRTSApproved').show();
                $('#btnRTSRejected').show();
            }

            // Build day headers from the header data with IsWorking handling
            // IsWorking data comes from 4th table (weekDays) - Added by Dipali V on 5th Dec 2025
            var dayNames = ['DayoneName', 'DaytwoName', 'DaythreeName', 'DayfourName', 'DayfiveName', 'DaysixName', 'DaysevenName'];
            var dayDates = ['Dayone', 'Daytwo', 'Daythree', 'Dayfour', 'Dayfive', 'Daysix', 'Dayseven'];
            
            // Get IsWorking values from weekDays table (4th result set)
            var weekDaysData = data.weekDays || [];
            console.log('WeekDays Data:', weekDaysData);
            
            var theadHtml = '<tr><th class="text-start" style="width:200px;">Projects/Tasks</th>';
            for (var i = 0; i < 7; i++) {
                var dayName = h[dayNames[i]] || '';
                var dayDate = h[dayDates[i]] ? formatDate(h[dayDates[i]]) : '';
                
                // Get IsWorking from weekDays array - handle both camelCase and PascalCase
                var dayData = weekDaysData[i] || {};
                var isWorking = dayData.isWorking !== undefined ? dayData.isWorking : 
                               (dayData.IsWorking !== undefined ? dayData.IsWorking : null);
                
                // Add weekcolumnred class based on IsWorking value - Modified by Dipali V on 10th Dec 2025
                // IsWorking logic (same as TimesheetApproval.aspx):
                // IsWorking === 0: Normal working day (not red)
                // IsWorking % 2 != 0 (odd like 1, 3): Non-working day - weekend/holiday (red)
                // IsWorking % 2 == 0 (even like 2): Working day - special case like Friday (not red)
                var cellClass = 'text-center';
                if (isWorking !== null && isWorking % 2 !== 0) {
                    cellClass += ' weekcolumnred';
                }
                
                theadHtml += '<th class="' + cellClass + '" style="width:80px;">' + dayName + '<br><small>' + dayDate + '</small></th>';
            }
            theadHtml += '<th class="text-center" style="width:80px;">Actual<br>Efforts</th></tr>';
            $('#theadResourceTS').html(theadHtml);
        }

        // Bind projects and tasks
        var tbodyHtml = '';
        
        // Store IsWorking values for body rows - Added by Dipali V on 5th Dec 2025
        // Modified by Dipali V on 10th Dec 2025 - Fixed IsWorking logic to match TimesheetApproval.aspx
        // IsWorking logic:
        // IsWorking === 0: Normal working day (not red)
        // IsWorking % 2 != 0 (odd like 1, 3): Non-working day - weekend/holiday (red)
        // IsWorking % 2 == 0 (even like 2): Working day - special case like Friday (not red)
        var weekDaysData = data.weekDays || [];
        var dayIsWorkingValues = [];
        for (var d = 0; d < 7; d++) {
            var dayData = weekDaysData[d] || {};
            var isW = dayData.isWorking !== undefined ? dayData.isWorking : 
                     (dayData.IsWorking !== undefined ? dayData.IsWorking : null);
            // Only mark as non-working (red) if IsWorking is an odd number
            dayIsWorkingValues.push(isW !== null && isW % 2 !== 0);
        }
        
        // Helper function to get cell class based on IsWorking
        function getDayCellClass(dayIndex) {
            return dayIsWorkingValues[dayIndex] ? 'text-center weekcolumnred-body' : 'text-center';
        }
        
        // Total Work row with daily totals from header
        if (data.header && data.header.length > 0) {
            var h = data.header[0];
            tbodyHtml += '<tr class="table-secondary fw-bold">';
            tbodyHtml += '<td>Total Work for a Day</td>';
            // Display daily totals from header with IsWorking styling
            tbodyHtml += '<td class="' + getDayCellClass(0) + '">' + (h.TotalMON || '00:00') + '</td>';
            tbodyHtml += '<td class="' + getDayCellClass(1) + '">' + (h.TotalTUE || '00:00') + '</td>';
            tbodyHtml += '<td class="' + getDayCellClass(2) + '">' + (h.TotalWED || '00:00') + '</td>';
            tbodyHtml += '<td class="' + getDayCellClass(3) + '">' + (h.TotalTHU || '00:00') + '</td>';
            tbodyHtml += '<td class="' + getDayCellClass(4) + '">' + (h.TotalFRI || '00:00') + '</td>';
            tbodyHtml += '<td class="' + getDayCellClass(5) + '">' + (h.TotalSAT || '00:00') + '</td>';
            tbodyHtml += '<td class="' + getDayCellClass(6) + '">' + (h.TotalSUN || '00:00') + '</td>';
            tbodyHtml += '<td class="text-center">' + (h.TotalActual || formatHoursToHHMM(h.ActualHours)) + '</td>';
            tbodyHtml += '</tr>';
        }

        // Projects - Get unique projects to avoid duplicates
        if (data.projects && data.projects.length > 0) {
            // Remove duplicate projects based on ProjectID
            var uniqueProjects = [];
            var seenProjectIds = {};
            data.projects.forEach(function(p) {
                var pid = p.ProjectID || p.projectID;
                if (!seenProjectIds[pid]) {
                    seenProjectIds[pid] = true;
                    uniqueProjects.push(p);
                }
            });
            
            uniqueProjects.forEach(function(project) {
                tbodyHtml += '<tr class="table-light">';
                // Fixed by Dipali V on [Date] - Allow project name to wrap instead of scrollbar
                tbodyHtml += '<td colspan="9" style="word-wrap: break-word; word-break: break-word; white-space: normal; overflow-wrap: break-word;"><i class="far fa-folder-open text-primary me-2"></i><strong>' + (project.ProjectName || project.projectName || '') + '</strong></td>';
                tbodyHtml += '</tr>';

                // Tasks for this project - Get unique tasks to avoid duplicates
                if (data.tasks && data.tasks.length > 0) {
                    var projectId = project.ProjectID || project.projectID;
                    var projectTasks = data.tasks.filter(function(t) { 
                        return (t.ProjectID || t.projectID) === projectId; 
                    });
                    
                    // Remove duplicate tasks based on TaskID
                    var uniqueTasks = [];
                    var seenTaskIds = {};
                    projectTasks.forEach(function(t) {
                        var tid = t.TaskID || t.taskID;
                        if (!seenTaskIds[tid]) {
                            seenTaskIds[tid] = true;
                            uniqueTasks.push(t);
                        }
                    });
                    
                    uniqueTasks.forEach(function(task) {
                        // Check task status - Modified by Dipali V on 10th Dec 2025
                        var statusFlag = (task.StatusFlag || task.statusFlag || '').toUpperCase();
                        var isRejected = (task.IsRejected === 1 || task.isRejected === 1 || task.IsRejected === '1' || task.isRejected === '1' || statusFlag === 'J');
                        var isApproved = (statusFlag === 'V');
                        
                        // Get approver name
                        var approverName = task.ApprovedBy || task.approvedBy || '';
                        
                        // Get task's project ID
                        var taskProjectId = task.ProjectID || task.projectID;
                        
                        // If no task-level approver, try to get from project details
                        if (!approverName) {
                            if (data.projects && data.projects.length > 0) {
                                data.projects.forEach(function(p) {
                                    var pId = p.ProjectID || p.projectID;
                                    if (pId === taskProjectId && (p.ApproverName || p.approverName)) {
                                        approverName = p.ApproverName || p.approverName;
                                    }
                                });
                            }
                        }
                        
                        // Get IsPendingWithMe flag - Modified by Dipali V on 10th Dec 2025
                        // First check task level, then fall back to project level
                        // Handle both number and string types
                        var isPendingWithMeRaw = task.IsPendingWithMe !== undefined ? task.IsPendingWithMe : task.isPendingWithMe;
                        var isPendingWithMe = (isPendingWithMeRaw === 1 || isPendingWithMeRaw === '1' || isPendingWithMeRaw === true);
                        
                        // If task-level IsPendingWithMe is not set (undefined/null), check project level
                        if (isPendingWithMeRaw === undefined || isPendingWithMeRaw === null) {
                            if (data.projects && data.projects.length > 0) {
                                data.projects.forEach(function(p) {
                                    var pId = p.ProjectID || p.projectID;
                                    if (pId === taskProjectId) {
                                        var projPendingRaw = p.IsPendingWithMe !== undefined ? p.IsPendingWithMe : p.isPendingWithMe;
                                        isPendingWithMe = (projPendingRaw === 1 || projPendingRaw === '1' || projPendingRaw === true);
                                    }
                                });
                            }
                        }
                        
                        console.log('Task:', task.TaskName, 'IsPendingWithMe Raw:', isPendingWithMeRaw, 'Parsed:', isPendingWithMe);
                        
                        // IsPendingWithMe = 1/true → Green check tick (Pending with me for approval)
                        // IsPendingWithMe = 0/false → Red cross tick (Not pending with me)
                        // Fixed by Dipali V on [Date] - Always show red cross when IsPendingWithMe=0, regardless of status
                        
                        // Build task name with status icon
                        var taskNameHtml = '';
                        var rowClass = '';
                        var taskName = task.TaskName || task.taskName || '';
                        
                        if (isPendingWithMe) {
                            // IsPendingWithMe = 1 → Green check tick
                            var tooltip = 'Pending with you for approval';
                            if (isApproved) {
                                tooltip = 'Approved' + (approverName ? ' by ' + approverName : '');
                            } else if (isRejected) {
                                tooltip = 'Rejected' + (approverName ? ' by ' + approverName : '');
                            }
                            else {
                                tooltip = 'Pending with you for approval';
                            }
                            taskNameHtml = '<span class="d-flex align-items-center gap-2">' +
                                '<span class="task-status-icon" data-tooltip="' + escapeHtml(tooltip) + '" ' +
                                'style="color: #28a745; cursor: pointer;">' +
                                '<i class="fas fa-check-circle"></i></span>' +
                                '<span style="white-space:pre-wrap">' + taskName + '</span></span>';
                        } else {
                            // IsPendingWithMe = 0 → Show Blue check tick (Not pending with me)
                            // Updated by Dipali V on 18th Dec 2025 - Changed from red cross to blue tick
                            var tooltip = 'Not pending with you';
                            if (isApproved) {
                                tooltip = 'Approved' + (approverName ? ' by ' + approverName : '');
                            } else if (isRejected) {
                                tooltip = 'Rejected' + (approverName ? ' by ' + approverName : '');
                            } else {
                                tooltip = 'Not pending with you for approval';
                            }
                            taskNameHtml = '<span class="d-flex align-items-center gap-2">' +
                                '<span class="task-status-icon" data-tooltip="' + escapeHtml(tooltip) + '" ' +
                                'style="color: #1359a6; cursor: pointer;">' +
                                '<i class="fas fa-check-circle"></i></span>' +
                                '<span style="white-space:pre-wrap">' + taskName + '</span></span>';
                        }
                        
                        tbodyHtml += '<tr' + rowClass + '>';
                        tbodyHtml += '<td class="ps-4">' + taskNameHtml + '</td>';
                        tbodyHtml += '<td class="' + getDayCellClass(0) + '">' + formatHoursToHHMM(task.MON) + '</td>';
                        tbodyHtml += '<td class="' + getDayCellClass(1) + '">' + formatHoursToHHMM(task.TUE) + '</td>';
                        tbodyHtml += '<td class="' + getDayCellClass(2) + '">' + formatHoursToHHMM(task.WED) + '</td>';
                        tbodyHtml += '<td class="' + getDayCellClass(3) + '">' + formatHoursToHHMM(task.THU) + '</td>';
                        tbodyHtml += '<td class="' + getDayCellClass(4) + '">' + formatHoursToHHMM(task.FRI) + '</td>';
                        tbodyHtml += '<td class="' + getDayCellClass(5) + '">' + formatHoursToHHMM(task.SAT) + '</td>';
                        tbodyHtml += '<td class="' + getDayCellClass(6) + '">' + formatHoursToHHMM(task.SUN) + '</td>';
                        // Fixed by Dipali V on 18th Dec 2025 - Format ActualHour as HH:MM (e.g., 05:45 instead of 5.45)
                        // Value comes as 5.45 (5 hours 45 minutes), should display as 05:45
                        tbodyHtml += '<td class="text-center fw-bold">' + formatHoursToHHMM(task.ActualHour) + '</td>';
                        tbodyHtml += '</tr>';
                    });
                }
            });
        }

        $('#tbodyResourceTS').html(tbodyHtml);
        
        // Fixed by Dipali V on [Date] - Initialize tooltip hover handlers to keep tooltip visible
        // Improved tooltip behavior - stays visible longer and doesn't hide immediately
        setTimeout(function() {
            if (window.parent && window.parent.$) {
                window.parent.$('.task-status-icon').each(function() {
                    var $icon = window.parent.$(this);
                    var tooltipTimeout = null;
                    
                    // Store timeout in data attribute for proper scoping
                    $icon.data('tooltip-timeout', null);
                    
                    // Use mouseenter/mouseleave with delay to keep tooltip visible longer
                    $icon.off('mouseenter.tasktooltip mouseleave.tasktooltip').on({
                        'mouseenter.tasktooltip': function(e) {
                            var $this = window.parent.$(this);
                            $this.addClass('tooltip-visible');
                            // Clear any existing timeout to keep tooltip visible
                            var existingTimeout = $this.data('tooltip-timeout');
                            if (existingTimeout) {
                                clearTimeout(existingTimeout);
                                $this.data('tooltip-timeout', null);
                            }
                            e.stopPropagation();
                        },
                        'mouseleave.tasktooltip': function(e) {
                            var $this = window.parent.$(this);
                            // Add longer delay before hiding tooltip (1000ms = 1 second)
                            var timeout = setTimeout(function() {
                                $this.removeClass('tooltip-visible');
                                $this.data('tooltip-timeout', null);
                            }, 1000); // Increased to 1 second delay
                            $this.data('tooltip-timeout', timeout);
                            e.stopPropagation();
                        }
                    });
                });
            }
        }, 500);
        
        // Note: Using native HTML title attribute for tooltips (works in parent window without JS init)
        // Modified by Dipali V on 10th Dec 2025
    }

    // Format task hours (handle null/empty and various formats)
    function formatTaskHours(hours) {
        if (hours === null || hours === undefined || hours === 'NULL' || hours === '') return '00:00';
        // If already in HH:MM format
        if (typeof hours === 'string' && hours.indexOf(':') !== -1) {
            return hours;
        }
        // If numeric string like "3.00", convert to HH:MM
        var numHours = parseFloat(hours) || 0;
        var hrs = Math.floor(numHours);
        var mins = Math.round((numHours - hrs) * 60);
        return String(hrs).padStart(2, '0') + ':' + String(mins).padStart(2, '0');
    }

    function ApproveRejectResourceTimesheet(action, viewType, timesheetID, employeeID) {
        //debugger;
        window.parent.$("#txtWFARPTComments").val('');
        var Caption = action === 'A' ? 'Approve' : 'Reject';
        if (Caption === 'Approve') {
            // Default comment for Approve action
            Comments = "Approved";
        } else if (Caption === 'Reject') {
            Comments = "Rejected";
        }
        // Fixed by Dipali V on [Date] - Use passed parameters when from ListView, otherwise use hidden fields
        // When called from ListView, timesheetID and employeeID are passed as parameters
        // When called from EditView (offcanvas), they should come from hidden fields
        var tsID = timesheetID || $('#hdnTimesheetID').val();
        var empID = employeeID || $('#hdnEmployeeID').val();
        
        // Validate that we have valid IDs
        if (!tsID || tsID === '0' || tsID === 0) {
            window.parent.alertify.set('notifier', 'position', 'top-right');
            window.parent.alertify.notify('Invalid Timesheet ID', 'error', 10);
            return;
        }
        if (!empID || empID === '0' || empID === 0) {
            window.parent.alertify.set('notifier', 'position', 'top-right');
            window.parent.alertify.notify('Invalid Employee ID', 'error', 10);
            return;
        }
        
        window.parent.$("#approveRevRTModal").modal('show');
        window.parent.$("#ApproveRejectLabel").text(Caption);
        window.parent.$("#lblAppRejectRTCaption").text(Caption);
        window.parent.$("#txtWFARPTComments").val(Comments);
        window.parent.$("#ActionLinkRTCaption").text(Caption);
        const modal = window.parent.$("#approveRevRTModal");
        modal.find("#ActionLinkRTCaption").off("click").on("click", function () {
            ApproveRejectRTClick(tsID, empID, viewType, action);
        });
    }

    function ApproveRejectRTClick(TimesheetID, employeeID, viewType, action) {
       // debugger;
        var Comments = window.parent.$("#txtWFARPTComments").val().trim();

        // 🔹 Step 1: Validate comments - Modified by Dipali V on 5th Dec 2025
        // For Approve: default to "Approved" if empty
        // For Reject: comment is mandatory, show alert if empty
        if (!Comments || Comments === "") {
            if (action === 'A') {
                // Default comment for Approve action
                Comments = "Approved";
            } else if (action === 'R') {
                Comments = "Rejected";
                // Comment is mandatory for Reject action
                window.parent.alertify.set('notifier', 'position', 'top-right');
                window.parent.alertify.notify('<%= MyBase.GetResourceString("C_CommentBlank") %>.', 'error', 10);
                return;  // Stop function here
            }
        }
        window.parent.$("#txtWFARPTComments").val(Comments);
        // 🔹 Step 2: Prepare request object  
        // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
        var param = JSON.stringify({
            TimeSheetNo: TimesheetID,
            Comments: Comments,
            UserName: '<%= Session("intUserID") %>',
            StrAction: action
        });
        var fullUrl = "api/EntityApproval/ResourceTimesheetApproveReject";

        // 🔹 Step 3: Send AJAX request using AJAXCallWithResult  
        try {
            var response = AJAXCallWithResult(fullUrl, param, false, 'POST');

            if (response && response.result) {
                if (response.result == "Success") {
                    if (action === 'A') {
                        window.parent.alertify.set('notifier', 'position', 'top-right');
                        window.parent.alertify.notify('<%= MyBase.GetResourceString("C_RTApproved") %>', 'success', 25);
                    } else {
                        window.parent.alertify.set('notifier', 'position', 'top-right');
                        window.parent.alertify.notify('<%= MyBase.GetResourceString("C_RTRejected") %>', 'success', 25);
                    }
                }
            }

            loadWithFilters(strAlertType);
            window.parent.$("#approveRevRTModal").modal('hide');

            // Fixed by Dipali V on [Date] - Refresh tab counts like project approval does
            // Send postMessage to parent to update tab counts and inbox/watchlist counts
            window.parent.postMessage({ action: "updateAllTabCounts", value: strAlertType }, "*");
            window.parent.postMessage({ action: "updateinboxWatclistCount", value: strAlertType }, "*");

            // Only refresh detail section if action was from EditView (offcanvas)
            // If from ListView, don't open/refresh offcanvas
            if (viewType === 'EditView') {
                var tsID = $('#hdnTimesheetID').val();
                var empID = $('#hdnEmployeeID').val();
                var fDate = $('#hdnFromDate').val();
                var tDate = $('#hdnToDate').val();

                if (tsID && empID) {
                    // Refresh detail section with updated data
                    GetResourceTSDetails(tsID, empID, fDate, tDate);
                }
            }
            // For ListView, just refresh the list (already done above) - no offcanvas action needed
        } catch (err) {
            console.error(err);
            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err;
            StopAjaxLoader("#bodyTSApproval1");
        }
    }



    // Approve/Reject Resource Timesheet
    //function ApproveRejectResourceTimesheet(action, viewType, timesheetID, employeeID) {
    //    var tsID = timesheetID || $('#hdnTimesheetID').val();
    //    var empID = employeeID || $('#hdnEmployeeID').val();

    //    var actionText = action === 'A' ? 'approve' : 'reject';
    //    var confirmMsg = 'Are you sure you want to ' + actionText + ' this timesheet?';

    //    alertify.confirm('Confirm', confirmMsg,
    //        function() {
    //            // Call approve/reject API
    //            var payload = JSON.stringify({
    //                TimesheetID: parseInt(tsID),
    //                EmployeeID: parseInt(empID),
    //                Action: action,
    //                ApproverID: getContext().EmployeeID
    //            });

    //            // TODO: Add actual approve/reject API call here
    //            console.log('Approve/Reject payload:', payload);

    //            alertify.set('notifier', 'position', 'top-right');
    //            if (action === 'A') {
    //                alertify.success('Timesheet Approved Successfully');
    //            } else {
    //                alertify.error('Timesheet Rejected Successfully');
    //            }

    //            // Refresh list
    //            setTimeout(function() {
    //                var result = fetchEntityDataForTag('P', CTagID);
    //                if (result && result.data) {
    //                    renderListViews(result.data);
    //                }
    //            }, 500);

    //            // Close offcanvas if in EditView
    //            if (viewType === 'EditView') {
    //                window.parent.$('#ResourceTSDetailsOffcanvas').offcanvas('hide');
    //            }
    //        },
    //        function() {
    //            // Cancelled
    //        }
    //    );
    //}

    // Listen for messages from parent page - mirrors PM_EntityLeaveApproval pattern
    // Parent sends postMessage after typing; iframe reads value directly from parent DOM (txtResourceTSName)
    window.addEventListener('message', function (event) {
        if (!event.data || !event.data.action) return;

        if (event.data.action === 'applyResourceTSFilters' || event.data.action === 'applyResourceNameFilter') {
            applyResourceTSFilters();
        }
    });

    // Added by Dipali V on 5th Dec 2025 - Timesheet Approval History on Hover
    var historyLoaded = false;
    var historyCache = null;

    // Initialize hover event for history popover - bind to parent page element
    function initHistoryPopoverHover() {
        // Bind hover event on parent page popover wrapper
        window.parent.$('#historyPopoverWrapper').off('mouseenter').on('mouseenter', function () {
            if (!historyLoaded) {
                loadTimesheetHistory();
            }
        });
    }

    // Load history on hover
    function loadTimesheetHistory() {
        var timesheetID = currentTimesheetID || $('#hdnTimesheetID').val();
        var $content = window.parent.$('#historyPopoverContent');

        if (!timesheetID) {
            $content.html('<div class="history-empty-mini"><i class="fas fa-info-circle"></i>No timesheet selected</div>');
            return;
        }

        // Modified by Dipali V on 10th Dec 2025 - Replaced $.ajax with AJAXCallWithResult
        var param = JSON.stringify({ TimesheetID: parseInt(timesheetID) });

        try {
            var response = AJAXCallWithResult('api/EntityApproval/GetResourceTimesheetHistory', param, false, 'POST');
            var historyData = (response && response.data) ? response.data : (response || []);
            historyCache = historyData;
            historyLoaded = true;
            renderMiniTimeline(historyData);
        } catch (error) {
            console.error('Error fetching history:', error);
            $content.html('<div class="history-empty-mini"><i class="fas fa-exclamation-circle"></i>Failed to load history</div>');
        }
    }

    // Render mini timeline for popover - targets parent page
    function renderMiniTimeline(data) {
        var $container = window.parent.$('#historyPopoverContent');

        if (!data || data.length === 0) {
            $container.html('<div class="history-empty-mini"><i class="fas fa-clock"></i>No approval history yet</div>');
            return;
        }

        var html = '';
        data.forEach(function (item, index) {
            var status = (item.Status || item.status || '').toLowerCase();
            var statusClass = getStatusClass2(status);
            var statusText = item.ActionTaken || item.actionTaken || item.Status || item.status || '-';
            var actionBy = item.ActionTakenBy || item.actionTakenBy || '-';
            var approverName = item.ApproverName || item.approverName || '-';

            // If "Timesheet Generated" use CreatedDate, else use UpdatedDate
            var actionTaken = (item.ActionTaken || item.actionTaken || '').toLowerCase();
            var displayDate = '-';
            if (actionTaken.includes('generated')) {
                displayDate = item.CreatedDate || item.createdDate || '-';
            } else {
                displayDate = item.UpdatedDate || item.updatedDate || '-';
            }

            html += `
                <div class="history-card ${statusClass}" ${index > 0 ? 'style="margin-top: 10px;"' : ''}>
                    <div class="history-row">
                        <span class="history-label">Status :</span>
                        <span class="history-value ${statusClass}-text">${statusText}</span>
                    </div>
                    <div class="history-row">
                        <span class="history-label">Date :</span>
                        <span class="history-value">${displayDate}</span>
                    </div>
                    <div class="history-row">
                        <span class="history-label">Action Taken By :</span>
                        <span class="history-value">${actionBy}</span>
                    </div>
                    <div class="history-row">
                        <span class="history-label">Approver Name :</span>
                        <span class="history-value">${approverName}</span>
                    </div>
                </div>
            `;
        });

        $container.html(html);
    }

    // Reset history cache when loading new timesheet - targets parent page
    function resetHistoryCache() {
        historyLoaded = false;
        historyCache = null;
        window.parent.$('#historyPopoverContent').html('<div class="history-loading"><i class="fas fa-spinner fa-spin"></i> Loading...</div>');
    }

    // Get status class for mini timeline
    function getStatusClass2(status) {
        if (!status) return 'generated';
        status = status.toLowerCase();
        if (status.includes('approv') || status.includes('verified')) return 'approved';
        if (status.includes('reject')) return 'rejected';
        if (status.includes('submit') || status.includes('sent')) return 'submitted';
        return 'generated';
    }

    // Format date short for popover
    function formatDateShort(dateStr) {
        if (!dateStr) return '';
        try {
            var date = new Date(dateStr);
            if (isNaN(date.getTime())) return dateStr;
            var options = { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' };
            return date.toLocaleDateString('en-GB', options).replace(',', '');
        } catch (e) {
            return dateStr;
        }
    }

    // Expose functions to parent
    window.GetResourceTSDetails = GetResourceTSDetails;
    window.ApproveRejectResourceTimesheet = ApproveRejectResourceTimesheet;
    window.load = load;
    window.loadWithFilters = loadWithFilters;
    window.applyResourceTSFilters = applyResourceTSFilters;
    window.clearResourceTSFilters = clearResourceTSFilters;
    window.setDefaultCurrentWeekDates = setDefaultCurrentWeekDates;
    // Added by Dipali V on 10th Dec 2025 - Period sorting function
    window.togglePeriodSort = togglePeriodSort;
    // ============================================================
    // Custom Pagination - matching PM_Documents.aspx - Vaibhav K
    // ============================================================
    let currentPage = 1;
    const itemsPerPage = 5;
    let totalPages = 1;

    function showPageRows() {
        var $tbody = $('#tblEWA_ResourceTS tbody');
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
        var $tbody = $('#tblEWA_ResourceTS tbody');
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