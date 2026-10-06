<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectCharter.aspx.vb" Inherits="Whizible.PM_ProjectCharter" %>


<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%CommonFunctions.General.PlotPageHeadTag("Project Charter")%>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
   <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1"
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">

    <style type="text/css">
        /* Added by Vishal Mane on 11/03/2026 for UI changes */
        body {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

        .form-control, .btn, a, p, input, select.form-select {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

        .page-header {
           /* background-color: #e7edf0;*/
            padding: 12px 14px;
            margin-bottom: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #e9ecef;
            margin: 0px;
        }

        .header-icon {
            width: 26px;
            height: 26px;
            background-color: #1e40af;
            border-radius: 6px;
            margin-top: -5px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 18px;
            flex-shrink: 0;
        }

        .header-content {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .page-title {
            color: #1e40af;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
            line-height: 1.2;
        }

        .page-subtitle {
            color: #6B7280;
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 4px;
            margin-left: -42px;
        }
        /* End of Added by Vishal Mane on 11/03/2026 for UI changes */

        /* .innerContent textarea.form-control {
            font-size: 12px;
        } */

        .innerContent {
            /*            border: 1px solid #ddd;*/
            padding: 15px
        }

        .bootstrap-select .dropdown-menu li {
            position: relative;
            font-size: 11.5px !important;
        }

        .ui-datepicker {
            width: 20em;
        }

        /* .innerContent .form-control {
            font-size: 12px;
        } */
/* Commented By Madhuri.K On 26-03-2026 */
        /* .filter-option-inner-inner {
            font-size: 12px !important;
            color: #000 !important; 
        } */

        .modal-body {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
        }

        .custmodal .modal-content .modal-header .close {
            /* color: #fff; */
            box-shadow: none;
            border: none;
            font-size: 24px;
            text-shadow: none;
            opacity: 1;
            position: absolute;
            top: 14px;
            right: 20px;
            background: none !important;
        }

        .offcanvas {
            --bs-offcanvas-width: 84%;
        }

        .form-control {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
        }

            .form-control:not(select) {
                appearance: none;
                /* Modified By Madhuri.K On 26-03-2026 */
                font-size: 11.5px;
            }

        .bootstrap-select .dropdown-toggle .filter-option-inner-inner {
            color: #000 !important; /* Extra specificity for Bootstrap-select button text */
        }

        .filter-option {
            font-weight: 300;
        }

        /* Center the whole form area */
        .innerContent {
            max-width: 900px; /* controls form width */
            margin: 0 auto; /* centers horizontally */
        }

            /* Align label column properly */
            .innerContent .col-sm-3 {
                display: flex;
                justify-content: flex-end; /* push label to right */
                align-items: center; /* vertical center */
            }

            /* Label styling */
            .innerContent label {
                text-align: right;
                font-weight: 500;
                margin-bottom: 0;
                white-space: nowrap;
            }

            /* Input / textarea column */
            .innerContent .col-sm-4 {
                display: flex;
                align-items: center;
            }

            /* Make all inputs consistent */
            .innerContent .form-control {
                width: 90%;
            }

            /* Textarea alignment */
            .innerContent textarea.form-control {
                resize: vertical;
            }

        /*  select#ddlInitiatedBy {
            width: 110%;
        }*/

        select#ddlApprovedBy {
            width: 110%;
        }

        input#txtPeakTeamSize {
            width: 110%;
        }

        .offcanvas-70 {
            width: 70% !important;
        }

        #tblAuditHistory i.fa-plus-square {
            cursor: pointer;
        }

        #tblAuditHistory {
            border-collapse: collapse !important;
            width: 100%;
        }

            #tblAuditHistory th,
            #tblAuditHistory td {
                border: 1px solid #dee2e6 !important;
                background-clip: padding-box;
            }

            #tblAuditHistory thead th {
                border-bottom: 2px solid #ced4da !important;
            }

        .modal-content {
            position: relative;
            display: flex;
            flex-direction: column;
            width: 80%;
            color: var(--bs-modal-color);
            pointer-events: auto;
            background-color: var(--bs-modal-bg);
            background-clip: padding-box;
        }

        .modal-title {
            font-weight: 400;
        }

        #sendPCMailBody {
            height: 180px;
            resize: none;
            overflow-y: auto;
        }

        .input-group {
            flex-wrap: nowrap !important;
        }

        .input-group {
            position: relative;
            display: flex;
            flex-wrap: wrap;
            align-items: stretch;
            width: 110%;
        }
        /* Style the selectpicker */
        .selectpicker {
            background-color: white !important; /* Make background white */
            border: 1px solid #ccc !important; /* Add light gray border */
            border-radius: 4px !important; /* Optional: rounded corners */
            color: #000 !important; /* Text color black */
        }

        .bootstrap-select {
            width: 110% !important;
        }

            .bootstrap-select > .dropdown-toggle {
                width: 100% !important;
            }

            /* Optional: adjust dropdown toggle button */
            .bootstrap-select > .dropdown-toggle {
                width: 110%; /* Full width */
                height: 32px;
                text-align: left; /* Align text to left inside box */
                padding: 6px 12px; /* Adjust padding */
                background-color: white !important; /* Ensure button background is white */
                border: 1px solid #ccc !important; /* Ensure button border matches */
            }

        .selectpicker:hover,
        .selectpicker:focus {
            background-color: white !important;
        }

        .innerContent {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
        }

        /* Offcanvas header × close button */
        .offcanvas-title-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }

        .offcanvas-close-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            background: transparent;
            border: none;
            border-radius: 4px;
            color: #374151;
            font-size: 18px;
            line-height: 1;
            cursor: pointer;
            opacity: 0.6;
            transition: opacity 0.15s ease, background 0.15s ease;
            flex-shrink: 0;
        }

            .offcanvas-close-btn:hover {
                opacity: 1;
                background: rgba(0, 0, 0, 0.08);
            }

            .offcanvas-close-btn:focus {
                outline: none;
                box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.25);
            }


        .input-group-btn button.btn.btncalendar {
            margin: 0;
            height: 34px;
            background: #eee;
            border: 1px solid #ddd;
            border-left: none;
        }

        .btn:hover {
            color: var(--bs-btn-hover-color);
            background-color: var(--bs-btn-hover-bg);
            border-color: var(--bs-btn-hover-border-color);
        }

        /* Container for pagination + total records */
        /*.dataTables_wrapper .dataTables_paginate {
            float: right !important;
            margin-top: 19px;
        }*/



    </style>
</head>
<body>
    <%If m_blnViewAccess = True Then%>
     <%-- Commented and Added by Vishal Mane on 11/03/2026 for UI changes */ --%>
    <%--<div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 text-end graybg clearfix">
            <h5 class="pgtitle float-start"><%=MyBase.GetResourceString("C_ProjectCharter")%></h5>
        </div>
    </div>--%>
    <!-- Page Header with Icon -->
    <div class="graybg page-header">
        <%--<div class="header-icon">
            <i class="fas fa-file-alt"></i>
        </div>--%>
        <div class="header-icon">
            <i class="fas fa-clipboard-list"></i>
            <%--<i class="fas fa-project-diagram"></i>
            <i class="fas fa-file-signature"></i>--%>
        </div>
        <div class="header-content">
            <h5 class="page-title"><%=MyBase.GetResourceString("C_ProjectCharter")%></h5>
            <p class="page-subtitle">Define project objectives, scope, assumptions, and approval details</p>
        </div>
    </div>
    <div class="clearfix"></div>
    <%-- End of Added by Vishal Mane on 11/03/2026 for UI changes */ --%>
    <div class="content">
        <div class=" pb-1">
            <div class="text-end float-end ml-1" style="cursor: auto;">
                <%If m_blnEditAccess = True Then%>
                <button class="btn btnyellow mr-5" type="button" onclick="SaveProjectCharter_OnClick()"><%=MyBase.GetResourceString("C_Save")%></button>
                <%End If %>
                <button type="button" class="btn borderbtn mr-5" id="SendMailPCBtn" onclick="sendProjectCharterMail()" data-bs-toggle="tooltip"><span><%=MyBase.GetResourceString("C_SendMail")%></span></button>
                <button class="btn borderbtn mr-5" type="button" onclick="OpenShowHistory_Offcanvas()"><%=MyBase.GetResourceString("C_Show")%></button>

            </div>
            <div class="clearfix"></div>
        </div>
        <div class="innerContent">

            <!-- Objectives -->
            <div class="row mb-2 align-items-start">
                <div class="col-sm-3">
                    <label class="required"><%=MyBase.GetResourceString("C_Objectives")%></label>
                </div>
                <div class="col-sm-6">
                    <textarea id="txtObjectives" class="form-control" maxlength="2000" rows="3"></textarea>
                </div>
            </div>

            <!-- Background -->
            <div class="row mb-2 align-items-start">
                <div class="col-sm-3">
                    <label class="required"><%=MyBase.GetResourceString("C_Background")%></label>
                </div>
                <div class="col-sm-6">
                    <textarea id="txtBackground" class="form-control" maxlength="2000" rows="3"></textarea>
                </div>
            </div>

            <!-- Statement of Work -->
            <div class="row mb-2 align-items-start">
                <div class="col-sm-3">
                    <label class="required"><%=MyBase.GetResourceString("C_StatementofWork (SOW)")%></label>
                </div>
                <div class="col-sm-6">
                    <textarea id="txtSOW" class="form-control" maxlength="1000" rows="3"></textarea>
                </div>
            </div>

            <!-- Assumptions -->
            <div class="row mb-2 align-items-start">
                <div class="col-sm-3">
                    <label class="required"><%=MyBase.GetResourceString("C_Assumptions")%></label>
                </div>
                <div class="col-sm-6">
                    <textarea id="txtAssumptions" class="form-control" maxlength="1000" rows="3"></textarea>
                </div>
            </div>

            <!-- Initiated By -->
            <div class="row mb-2 align-items-center">
                <div class="col-sm-3">
                    <label class="required" placeholder="Select Initiated By"><%=MyBase.GetResourceString("C_InitiatedBy")%></label>
                </div>
                <div class="col-sm-5">
                    <%CommonFunctions.HTMLControls.DrawComboBox("ddlInitiatedBy", "usp_Whizible2_Sel_tbl_PM_Employee_ProjectCharter",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                </div>
            </div>

            <!-- Initiation Date -->
            <div class="row mb-2 align-items-center">
                <div class="col-sm-3">
                    <label><%=MyBase.GetResourceString("C_InitiationDate")%></label>
                </div>
                <div class="col-sm-5">
                    <div class="input-group">
                        <input id="initiationDate" type="text" class="form-control">
                        <span class="input-group-btn">
                            <button class="btn btncalendar" type="button">
                                <i class="fas fa-calendar-alt"></i>
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <!-- Approved By -->
            <div class="row mb-2 align-items-center">
                <div class="col-sm-3">
                    <label class="required"><%=MyBase.GetResourceString("C_ApprovedBy")%></label>
                </div>
                <div class="col-sm-5">
                    <%CommonFunctions.HTMLControls.DrawComboBox("ddlApprovedBy", "usp_Whizible2_Sel_tbl_PM_Employee_ProjectCharter_New",,, "class='selectpicker form-control fixed-width-combo' data-live-search='true'",,,) %>
                </div>
            </div>

            <!-- Approval Date -->
            <div class="row mb-2 align-items-center">
                <div class="col-sm-3">
                    <label><%=MyBase.GetResourceString("C_ApprovalDate")%></label>
                </div>
                <div class="col-sm-5">
                    <div class="input-group">
                        <input id="approvalDate" type="text" class="form-control">
                        <span class="input-group-btn">
                            <button class="btn btncalendar" type="button">
                                <i class="fas fa-calendar-alt"></i>
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <!-- Peak Team Size -->
            <div class="row mb-2 align-items-center">
                <div class="col-sm-3">
                    <label><%=MyBase.GetResourceString("C_PeakTeamSize")%></label>
                </div>
                <div class="col-sm-5">
                    <input type="text" id="txtPeakTeamSize" maxlength="4" class="form-control">
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="showHistory_OffCanvas" aria-labelledby="showHistoryLabel">

        <!-- HEADER -->
        <div class="graybg container-fluid py-1 mb-2">
            <div class="row align-items-center">
                <div class="col-sm-10">
                    <h5 class="pgtitle mb-0">
                        Show History
                    </h5>
                </div>
                <div class="col-sm-2 text-end">
                    <%--Added by Vishal Mane on 11/03/2026 to fix pagination issue--%>
                    <%--<button type="button" class="btn borderbtn" onclick="closeSendMailAndOffcanvas()"><%=MyBase.GetResourceString("C_Cancel")%></button>--%>
                    <%--<button type="button" class="close" onclick="closeSendMailAndOffcanvas()" data-bs-dismiss="modal">×</button>--%>
                    <button type="button" class="offcanvas-close-btn" onclick="closeSendMailAndOffcanvas()" data-bs-dismiss="offcanvas" aria-label="Close" title="Close">&#x2715;</button>
                    <%--End of Added by Vishal Mane on 11/03/2026 to fix pagination issue--%>
                </div>
            </div>
        </div>
        <!-- FILTERS -->
        <div class="row mb-2 px-3 align-items-center">
            <div class="col-sm-2 text-end">
                <label class="form-label mb-0">
                    <%=MyBase.GetResourceString("C_ModifiedField")%>
                </label>
            </div>
            <div class="col-sm-3">
                <%--<select id="ddlModifiedField" onclick="LoadModifiedFieldOptions()" class="form-control"></select>--%>
                <select id="ddlModifiedField" class="form-control selectpicker w-100" data-live-search="true" onchange="LoadModifiedFieldOptions()"></select>
             </div>
            <div class="col-sm-2 text-end">
                <label class="form-label mb-0">
                    <%=MyBase.GetResourceString("C_ModifiedBy")%>
                </label>
            </div>
            <div class="col-sm-3">
                <%--<select id="ddlModifiedBy" onclick="LoadModifiedBy()" class="form-control"></select>--%>
                <select id="ddlModifiedBy" class="form-control selectpicker w-100" data-live-search="true" onchange="LoadModifiedBy()"></select>
            </div>
        </div>

        <!-- TABLE -->
        <div class="table-responsive px-3">
            <table class="table table-bordered table-hover" id="tblAuditHistory">
                <thead class="table-light">
                    <tr>

                        <th><%=MyBase.GetResourceString("C_ModifiedField")%></th>
                        <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                        <th><%=MyBase.GetResourceString("C_NewValue")%></th>
                        <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                        <th><%=MyBase.GetResourceString("C_ModifiedBy")%></th>
                    </tr>
                </thead>
                <tbody id="tbl_AuditHistory_tbody">
                    <!-- Dynamically filled -->
                </tbody>
            </table>
        </div>

        <!-- FOOTER -->
        <%--<div class="text-end px-3 pb-2">
            <span id="lblAuditTotal" class="text-muted">
                <%=MyBase.GetResourceString("C_Total")%> 
            </span>
        </div>--%>
    </div>

    <%--Send mail --%>
    <div class="modal custmodal fade" id="SendMailPCModal" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title w-100 text-center"><%=MyBase.GetResourceString("C_SendMail")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body pt-2 pb-3">

                    <!-- From -->
                    <div class="row mb-2">
                        <div class="col-sm-3">
                            <label><strong><%=MyBase.GetResourceString("C_Frm")%></strong></label>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" id="sendPCMailFrom" class="form-control" readonly style="width: 94%; padding: 4px 10px; height: 28px;">
                        </div>
                    </div>

                    <!-- To -->
                    <div class="row mb-2">
                        <div class="col-sm-3">
                            <label><strong><%=MyBase.GetResourceString("C_To")%></strong> <span style="color: red;">*</span></label>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" id="sendPCMailTo" class="form-control" style="width: 94%; padding: 4px 10px; height: 28px;">
                        </div>
                    </div>

                    <!-- CC -->
                    <div class="row mb-2">
                        <div class="col-sm-3">
                            <label><strong><%=MyBase.GetResourceString("C_CC")%></strong></label>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" id="sendPCMailCC" class="form-control" style="width: 94%; padding: 4px 10px; height: 28px;">
                        </div>
                    </div>

                    <!-- Subject -->
                    <div class="row mb-2">
                        <div class="col-sm-3">
                            <label><strong><%=MyBase.GetResourceString("C_Subject")%></strong> <span style="color: red;">*</span></label>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" id="sendPCMailSubject" class="form-control" style="width: 94%; padding: 4px 10px; height: 28px;">
                        </div>
                    </div>

                    <div class="row form-group" style="margin-bottom: 9px;">
                        <div class="form-group col-sm-3"></div>
                        <div class="form-group col-sm-9">
                            <small style="color: #666;"><%=MyBase.GetResourceString("C_MailNote")%></small>
                        </div>
                    </div>

                    <!-- Message -->
                    <div class="row mb-2">
                        <div class="col-sm-3">
                            <label><strong><%=MyBase.GetResourceString("C_Msg")%></strong></label>
                        </div>
                        <div class="col-sm-9">
                            <textarea id="sendPCMailBody" class="form-control" style="height: 180px; resize: none; overflow-y: auto;"></textarea>
                        </div>
                    </div>
                    <!-- Buttons -->
                    <div class="row mt-3">
                        <div class="col-sm-12 text-center">
                            <button id="sendPCMailBtn" class="btn btnyellow" onclick="sendPCMailConfirm()"><%=MyBase.GetResourceString("C_Send")%></button>
                            <button class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%ELSE%>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess")%></p>
        </div>
    </div>

    <%End If%>

    <script>
        var ProjectID =<%= Session("intProjectID") %>;
        var UserId = '<%= If(Session("intUserID") Is Nothing, 0, Session("intUserID")) %>';
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        //datepicker
        $('#initiationDate, #approvalDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            /*dateFormat: 'dd M yy'*/
            dateFormat: 'dd M yy'
        });

        $(document).on('changed.bs.select', '#ddlApprovedBy', function () {

            var selectedVal = $(this).selectpicker('val');

            $(this).data('selected-value', selectedVal);
        });

        $(document).on('changed.bs.select', '#ddlInitiatedBy', function () {
            var selectedVal = $(this).selectpicker('val');

            $(this).data('selected-value', selectedVal);
        });

        // Clear live-search text so dropdown options don't appear "blank" after a selection
        $(document).on('hidden.bs.select', '#ddlInitiatedBy, #ddlApprovedBy', function () {
            var $select = $(this);
            var $searchInput = $select.parent().find('.bs-searchbox input');

            if ($searchInput.length) {
                $searchInput.val('');
                $select.selectpicker('refresh');
            }
        });

        $(document).ready(function () {
         /*   $('.selectpicker').selectpicker();*/
            LoadProjectCharterDetails(ProjectID);
      
          /*  $('.selectpicker').selectpicker('refresh');*/
            //LoadAuditHistory(ProjectID);
        });

        $(document).on("click", "#btnShowHistory", function () {
            var offcanvasElement = document.getElementById('offcanvas');
            var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
            bsOffcanvas.show();
        });

        // Helper: update total count based on currently visible data rows
        function updateAuditTotalCount() {
            var visibleRows = $('#tblAuditHistory tbody tr:visible').filter(function () {
                // Exclude "No audit history available" placeholder row (only 1 td, colspan=5)
                return $(this).find('td').length === 5;
            }).length;

            $('#lblAuditTotal').text('Total Records: ' + visibleRows);
        }

        //Added by Vishal Mane on 11/03/2026 to fix pagination issue 

        function updatePagination() {
            var isUrls = $('#containerUrls').is(':visible');
            let totalRecords = isUrls
                ? $("#urlstable tbody tr[data-url-id]").length
                : $("#prodocumentstbl tbody tr[data-document-id]:not(.detail-view-wrap)").length;

            // Update total records count
            $('#totalRecords').text(totalRecords);

            // Calculate total pages
            totalPages = Math.ceil(totalRecords / itemsPerPage);

            // Update button states
            if (currentPage === 1 || totalRecords === 0) {
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
        // End of addition by Nischal C on 3/11/2025 Update pagination controls        
        function goToFirstPage() {
            currentPage = 1;
            showPageRows();
            updatePagination();
        }
        function goToLastPage() {
            var isUrls = $('#containerUrls').is(':visible');
            let totalRecords = isUrls
                ? $("#urlstable tbody tr[data-url-id]").length
                : $("#prodocumentstbl tbody tr[data-document-id]:not(.detail-view-wrap)").length;
            totalPages = Math.ceil(totalRecords / itemsPerPage);
            currentPage = totalPages;
            showPageRows();
            updatePagination();
        }       
        function goToPreviousPage() {
            if (currentPage > 1) {
                currentPage = currentPage - 1;
                showPageRows();
                updatePagination();
            }
        }
        function goToNextPage() {
            var isUrls = $('#containerUrls').is(':visible');
            let totalRecords = isUrls
                ? $("#urlstable tbody tr[data-url-id]").length
                : $("#prodocumentstbl tbody tr[data-document-id]:not(.detail-view-wrap)").length;
            totalPages = Math.ceil(totalRecords / itemsPerPage);

            if (currentPage < totalPages) {
                currentPage = currentPage + 1;
                showPageRows();
                updatePagination();
            }
        }
        // Added by Vishal Mane on 11/03/2026 to fix pagination issue 
      
        function applyAuditFilters() {
            //debugger
            var selectedField = $('#ddlModifiedField').val();
            var selectedBy = $('#ddlModifiedBy').val();

            var filteredData = fullAuditList.filter(function (item) {

                var matchField =
                    !selectedField ||
                    selectedField === '' ||
                    selectedField === 'Select Modified Field' ||
                    item.modifiedField === selectedField;

                var matchBy =
                    !selectedBy ||
                    selectedBy === '' ||
                    selectedBy === 'Select Modified By' ||
                    item.modifiedBy === selectedBy;

                return matchField && matchBy;

            });

            renderAuditTable(filteredData);

            $('#ddlModifiedField').selectpicker('refresh');
            $('#ddlModifiedBy').selectpicker('refresh');
        }

        $('#ddlModifiedField, #ddlModifiedBy').on('change', applyAuditFilters);
    
        //End By sandhyarani M. 16.02.2026

        function closeSendMailAndOffcanvas() {
            var modalEl = document.getElementById('SendMailPCModal');
            var modalInstance = bootstrap.Modal.getInstance(modalEl);
            if (modalInstance) {
                modalInstance.hide();
            }
            var offcanvasEl = document.getElementById('showHistory_OffCanvas');
            var offcanvasInstance = bootstrap.Offcanvas.getInstance(offcanvasEl);
            if (offcanvasInstance) {
                offcanvasInstance.hide();
            }
        }

        function OpenShowHistory_Offcanvas() {

            var offcanvasElement = document.getElementById('showHistory_OffCanvas');
            var bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
            bsOffcanvas.show();
          
            //if ($('#ddlModifiedField').hasClass('selectpicker')) {
            //    $('#ddlModifiedField').selectpicker('refresh');
            //    $('#ddlModifiedBy').selectpicker('refresh');
            //}
            //$('#ddlModifiedField').text('Select Modified Field');
            //$('#ddlModifiedBy').text('Select Modified By');
            //Added By sandhyarani M. 16.02.2026 Modified Filed and Modified by showing
            LoadModifiedFieldOptions();
            LoadModifiedBy();
            LoadAuditHistory(ProjectID);            
            //End By Sandhyarani M. 
        }

        function formatDateFromAPI(dateString) {
            if (!dateString || dateString.trim() === '') return '';

            dateString = dateString.trim();
            var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

            // yyyy-MM-dd or yyyy-MM-ddTHH:mm:ss
            if (/^\d{4}-\d{2}-\d{2}/.test(dateString)) {
                var parts = dateString.split('T')[0].split('-');
                return parseInt(parts[2], 10) + ' ' +
                    monthNames[parseInt(parts[1], 10) - 1] + ' ' +
                    parts[0];
            }

            if (/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(dateString)) {
                var p = dateString.split('/');
                return parseInt(p[0], 10) + ' ' +
                    monthNames[parseInt(p[1], 10) - 1] + ' ' +
                    p[2];
            }

            if (/^\d{1,2}\/\d{1,2}\/\d{2}$/.test(dateString)) {
                var p = dateString.split('/');
                var year = '20' + p[2];   // 26 → 2026
                return parseInt(p[0], 10) + ' ' +
                    monthNames[parseInt(p[1], 10) - 1] + ' ' +
                    year;
            }

            // already formatted: 12 Feb 2026
            if (/^\d{1,2}\s[A-Za-z]{3}\s\d{4}$/.test(dateString)) {
                return dateString;
            }

            return '';
        }

        //function convertToSqlDateTime_US(dateString) {
        //    if (!dateString) return null;

        //    // Expected format: "12 Feb 2026"
        //    var parts = dateString.trim().split(' '); // ["12", "Feb", "2026"]
        //    if (parts.length !== 3) return null;

        //    var day = parts[0].padStart(2, '0');
        //    var monthStr = parts[1].toLowerCase();
        //    var year = parts[2];

        //    // Map month names to numbers
        //    var monthMap = {
        //        jan: '01', feb: '02', mar: '03', apr: '04',
        //        may: '05', jun: '06', jul: '07', aug: '08',
        //        sep: '09', oct: '10', nov: '11', dec: '12'
        //    };

        //    var month = monthMap[monthStr];
        //    if (!month) return null; // invalid month

        //    // US format: MM/dd/yyyy HH:mm:ss
        //    return `${month}/${day}/${year} 00:00:00`;
        //}

        function LoadProjectCharterDetails(ProjectID) {
         
            try {
                alertify.set('notifier', 'position', 'top-right');

                if (!ProjectID || parseInt(ProjectID) === 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_ProjectID")%>');
                    return;
                }

                var result = AJAXCallWithResult("api/PM_ProjectCharter/GetProjectCharterDetails",
                    JSON.stringify({ ProjectID: ProjectID }),
                    false
                );

                var charterData = result?.data?.PM_ProjectCharterModel[0];

                if (charterData) {

                    // -------- Textareas --------
                    $('#txtObjectives').val(charterData.objectives || '');
                    $('#txtBackground').val(charterData.background || '');
                    $('#txtSOW').val(charterData.statementOfWork || '');
                    $('#txtAssumptions').val(charterData.assumptions || '');
                    //Added By Sandhyarani M 16.02.2026 Initiation date not showing 
                    $('#initiationDate').val(formatDateFromAPI(charterData.initiationDate));
                    $('#approvalDate').val(formatDateFromAPI(charterData.approvalDate));
                    var initiatedByVal = charterData.initiatedBy
                        ? charterData.initiatedBy.toString()
                        : '0';

                    var $ddlInit = $('#ddlInitiatedBy');

                    // completely reset bootstrap-select
                  /*  $ddlInit.selectpicker('destroy');*/

                    // set value on native select
                    $ddlInit.val(initiatedByVal);

                    // reinitialize selectpicker
                    $ddlInit.selectpicker({
                        liveSearch: true
                    });


                    $('#ddlInitiatedBy').val(charterData.initiatedBy || '0');
                    if ($('#ddlInitiatedBy').hasClass('selectpicker') || $('#ddlInitiatedBy').data('selectpicker')) {
                        try { $('#ddlInitiatedBy').selectpicker('refresh'); } catch (e) { }
                    }

                    var approvedByVal = charterData.approvedBy? charterData.approvedBy.toString(): '0';

                    $('#ddlApprovedBy')
                        .data('isOpen', false)
                        .selectpicker('val', approvedByVal);

                    //var initiationDate = $('#initiationDate').val();
                    //var approvalDate = $('#approvalDate').val();


                    $('#txtPeakTeamSize').val(charterData.peakTeamSize || '');

                } else {
                    alertify.error('No Project Charter data found.');
                }

            } catch (error) {
                alertify.error('Error loading Project Charter details: ' + (error.message || error));
            }
        }

        function SaveProjectCharter_OnClick() {
          
            alertify.set('notifier', 'position', 'top-right');

            var objectives = $('#txtObjectives').val();
            var background = $('#txtBackground').val();
            var sow = $('#txtSOW').val();
            var assumptions = $('#txtAssumptions').val();
            var initiatedBy = $('#ddlInitiatedBy').val();
            var initiationDate = $('#initiationDate').val();
            var approvedBy = $('#ddlApprovedBy').val();
            var approvalDate = $('#approvalDate').val();
            var peakTeamSize = $('#txtPeakTeamSize').val();

            if (!objectives || objectives.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_ObjectMan")%>');
                $('#txtObjectives').focus();
                return;
            }

            if (!background || background.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_Backgroundman")%>');
                $('#txtBackground').focus();
                return;
            }

            if (!sow || sow.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_SOWMan")%>');
                $('#txtSOW').focus();
                return;
            }

            if (!assumptions || assumptions.trim() === '') {
                alertify.error('<%=MyBase.GetResourceString("A_AssumMan")%>');
                $('#txtAssumptions').focus();
                return;
            }

            if (!initiatedBy || initiatedBy === '0') {
                alertify.error('<%=MyBase.GetResourceString("A_InitiatedMan")%>');
                $('#ddlInitiatedBy').focus();
                return;
            }

            if (!approvedBy || approvedBy === '0') {
                alertify.error('<%=MyBase.GetResourceString("A_ApprovedMan")%>');
                $('#ddlApprovedBy').focus();
                return;
            }
            //Added by sandhyarani 13.02.2026 Show alertify When Team size is less than 1
            // Peak Team Size validation
            if (peakTeamSize && peakTeamSize.trim() !== '') {

                // Allow only whole numbers >= 1
                if (!/^\d+$/.test(peakTeamSize) || parseInt(peakTeamSize, 10) < 1) {
                    alertify.error('<%=MyBase.GetResourceString("A_TeamSizeLess")%>');
                    $('#txtPeakTeamSize').focus();
                    return;
                }
            }
            //End By sandhyarani 
            /* Added by Sandhyarani M – 16.02.2026 Reason: Date format changed from 'dd/mm/yyyy' to 'dd M yyyy' (e.g., 26 Feb 2026).*/
            if (initiationDate && approvalDate) {

                //var initParts = initiationDate.split('/');   // dd/mm/yy
                //var apprParts = approvalDate.split('/');

                //// yyyy, mm (0-based), dd
                //var initDateObj = new Date(initParts[2], initParts[1] - 1, initParts[0]);
                //var apprDateObj = new Date(apprParts[2], apprParts[1] - 1, apprParts[0]);
                // Convert 'dd M yyyy' (e.g., 26 Feb 2026) to Date object
                function parseDate(dateStr) {
                    var parts = dateStr.split(' '); // [dd, M, yyyy]
                    return new Date(parts[2], new Date(parts[1] + " 1, 2000").getMonth(), parts[0]);
                }

                var initDateObj = parseDate(initiationDate);
                var apprDateObj = parseDate(approvalDate);

                if (apprDateObj < initDateObj) {
                    alertify.error('<%=MyBase.GetResourceString("C_Approval")%>');
                    $('#approvalDate').focus();
                    return false;
                }
            }

            var projectCharterData = {
                ProjectID: ProjectID,
                Objectives: objectives.trim(),
                Background: background.trim(),
                StatementOfWork:  sow.trim() ,
                Assumptions: assumptions.trim() ,
                InitiatedBy: initiatedBy,
                InitiationDate: initiationDate,   // dd/mm/yyyy
                ApprovedBy: approvedBy,
                ApprovalDate: approvalDate,       // dd/mm/yyyy

                PeakTeamSize: peakTeamSize || 0,
                //Added by 
                ModifiedBy: UserId
            };


            // -------- API Call --------
            try {
                var param = JSON.stringify(projectCharterData);
                var url = "api/PM_ProjectCharter/UpdateProjectCharterDetails";
                var result = AJAXCallWithResult(url, param, false);

                if (!result) {
                    alertify.error('Failed to save Project Charter. No response from API.');
                    return;
                }

                if (result.error || result.status === 'ERROR') {
                    alertify.error(result.message || 'Error saving Project Charter');
                    return;
                }

                alertify.success('<%=MyBase.GetResourceString("A_ProjectSuccess")%>');
                //LoadAuditHistory(ProjectID);

            } catch (error) {
                alertify.error('Error saving Project Charter: ' + (error.message || error));
            }
        }
        var fullAuditList = [];
        function LoadAuditHistory(ProjectID) {
            //debugger
            fullAuditList = [];
            try {
                alertify.set('notifier', 'position', 'top-right');

                // Validate ProjectID
                if (!ProjectID || parseInt(ProjectID) === 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_ProjectID")%>');
                    return;
                }

                var result = AJAXCallWithResult("api/PM_ProjectCharter/GetProjectPinAuditTrailDetails",
                    JSON.stringify({ ProjectID: ProjectID }),
                    false
                );
                // Safely get audit list
                var auditList = result?.data?.ProjectPinAuditTrailModel || [];
                fullAuditList = auditList;
                //var $tbody = $('#tblAuditHistory tbody');
                //$tbody.empty();

                var $table = $('#tblAuditHistory');
                if ($.fn.DataTable.isDataTable($table)) {
                    $table.DataTable().destroy();
                }
                var $tbody = $table.find('tbody');
                $tbody.empty();

                // Reset total count
                //$('#lblAuditTotal').text('Total Records: 0');

                if (auditList.length > 0) {
                    //$('#lblAuditTotal').text('Total Records: ' + auditList.length);
                    var row = "";
                    $.each(auditList, function (index, item) {
                        row += `
                            <tr>
                                <td>${item.modifiedField || ' '}</td>
                                <td>${item.oldValue || ' '}</td>
                                <td>${item.newValue || ' '}</td>
                                <td>${item.modifiedDate ? formatDateFromAPI(item.modifiedDate) : ''}</td>
                                <td>${item.modifiedBy || ''}</td>
                            </tr>
                        `;                        
                    });
                    $tbody.append(row);
                }
                //Commented by Vishal Mane on 16/03/2026 to fix datatable issue
                //else {
                //    $tbody.append(`
                //                <tr>
                //                    <td colspan="5" class="text-center text-muted">
                //                        No audit history available
                //                    </td>
                //                </tr>
                //            `);
                //} 
                //End of Commented by Vishal Mane on 16/03/2026 to fix datatable issue               

                $("#tblAuditHistory").DataTable({
                    scrollY: true,
                    scrollX: true,
                    paging: true,
                    pagingType: "simple",
                    lengthChange: false,
                    searching: false,
                    ordering: false,
                    responsive: true,
                    destroy: true,
                    info: true,
                    autoWidth: false,
                    pageLength: 5,

                    language: {
                        info: "Total Records: _TOTAL_",
                        infoEmpty: "Total Records: 0",
                        paginate: {
                            previous: "<<",
                            next: ">>"
                        }
                    }
                });

                resizeSection();

            } catch (error) {
                alertify.error('Error loading audit history: ' + (error.message || error));
            }
        }

        function renderAuditTable(data) {

            var $table = $('#tblAuditHistory');

            // Destroy existing DataTable
            if ($.fn.DataTable.isDataTable($table)) {
                $table.DataTable().destroy();
            }

            var $tbody = $table.find('tbody');
            $tbody.empty();

            var html = "";

            data.forEach(function (item) {
                html += `
        <tr>
            <td>${item.modifiedField || ' '}</td>
            <td>${item.oldValue || ' '}</td>
            <td>${item.newValue || ' '}</td>
            <td>${item.modifiedDate ? formatDateFromAPI(item.modifiedDate) : ''}</td>
            <td>${item.modifiedBy || ''}</td>
        </tr>`;
            });

            // Append once
            $tbody.append(html);

            // Initialize DataTable
            $("#tblAuditHistory").DataTable({
                scrollY: true,
                scrollX: true,
                paging: true,
                pagingType: "simple",
                lengthChange: false,
                searching: false,
                ordering: false,
                responsive: true,
                destroy: true,
                info: true,
                autoWidth: false,
                pageLength: 5,

                language: {
                    info: "Total Records: _TOTAL_",
                    infoEmpty: "Total Records: 0",
                    paginate: {
                        previous: "<<",
                        next: ">>"
                    }
                }
            });

            resizeSection();
        }

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 210, "overflow-y": "auto" });
        }

        function LoadModifiedFieldOptions() {
            
            if ($('#ddlModifiedField option').length > 0) return;

            try {
                alertify.set('notifier', 'position', 'top-right');

                if (!ProjectID || parseInt(ProjectID) === 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_ProjectID")%>');
                    return;
                }

                var result = AJAXCallWithResult(
                    "api/PM_ProjectCharter/GetProjectPinAuditTrailFieldName",
                    JSON.stringify({ ProjectID: ProjectID }),
                    false
                );

                var fieldList = result?.data?.ProjectPinAuditTrailFieldNameModel;

                var ddl = $('#ddlModifiedField');
                //ddl.empty();

                //  Default option
                /*  ddl.append('<option value="">Select Modified Field </option>');*/
                $('#ddlModifiedField').val(0);
                if (fieldList && fieldList.length > 0) {

                    $.each(fieldList, function (index, item) {
                        ddl.append(
                            $('<option></option>')
                                .val(item.fieldName)
                                .text(item.fieldName)
                        );
                    });

                } else {
                    alertify.error('No Modified Field data found.');
                }
                $('#ddlModifiedField').selectpicker('refresh');

            } catch (error) {
                alertify.error(
                    'Error loading Modified Field options: ' + (error.message || error)
                );
            }
        }

        function LoadModifiedBy() {
         
            //Added bY Sandhyarani M 16.02.2026 Show dropdown 
            if ($('#ddlModifiedBy option').length > 0) return;

            try {
                alertify.set('notifier', 'position', 'top-right');

                if (!ProjectID || parseInt(ProjectID) === 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_ProjectID")%>');
                    return;
                }

                var result = AJAXCallWithResult(
                    "api/PM_ProjectCharter/GetProjectPinAuditTrailModifiedBy",
                    JSON.stringify({ ProjectID: ProjectID }),
                    false
                );

                var modifiedByList = result?.data?.ProjectPinAuditTrailModifiedByModel;

                var ddl = $('#ddlModifiedBy');
                //ddl.empty();

                // ✔ Default option (optional)
                /* ddl.append('<option value="">Select Modified By</option>'); */
                $('#ddlModifiedBy').val(0);
                if (modifiedByList && modifiedByList.length > 0) {

                    $.each(modifiedByList, function (index, item) {
                        ddl.append(
                            $('<option></option>')
                                .val(item.modifiedBy)
                                .text(item.modifiedBy)
                        );
                    });

                } else {
                    alertify.error('No Modified By data found.');
                }
                $('#ddlModifiedBy').selectpicker('refresh');

            } catch (error) {
                alertify.error(
                    'Error loading Modified By options: ' + (error.message || error)
                );
            }
        }

        function sendProjectCharterMail() {
   
            // Open the modal only
            var sendMailModal = new bootstrap.Modal(document.getElementById('SendMailPCModal'));
            sendMailModal.show();

            $('#sendPCMailBtn').show();
            LoadProjectCharterMailData(ProjectID)
        }

        function LoadProjectCharterMailData(ProjectID) {
          
            try {

                alertify.set('notifier', 'position', 'top-right');

                if (!ProjectID || parseInt(ProjectID) === 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_ProjectID")%>');
                    return;
                }

                var employeeID = UserId;

                if (!employeeID || employeeID <= 0) {
                    alertify.error('Employee ID not available.');
                    return;
                }

                var empResult = AJAXCallWithResult("api/PM_ProjectCharter/GetEmployeeEmailID",
                    JSON.stringify({ EmployeeID: employeeID }),
                    false
                );

                //var employeeEmail = empResult?.data?.PM_EmployeeEmailModel[0]?.emailID || '';

                //// Bind Email to From & CC
                //$('#sendPCMailFrom').val(employeeEmail);
                //$('#sendPCMailCC').val(employeeEmail);
                //$('#sendPCMailTo').val(employeeEmail);
                // Get emails from API response
                // Correct path based on your debug output
                var employeeEmail = empResult?.data?.PM_EmployeeEmailModel?.[0]?.employeeEmail || '';
                var adminEmail = empResult?.data?.PM_EmployeeEmailModel?.[0]?.adminEmail || '';

                // Bind Email fields
                $('#sendPCMailFrom').val(employeeEmail);  // From: employee email
                $('#sendPCMailTo').val(adminEmail);    // To: employee email
                $('#sendPCMailCC').val(employeeEmail);       // CC: admin email (EmployeeID 61)


                var messageID = 21;

                var mailResult = AJAXCallWithResult(
                    "api/PM_ProjectCharter/GetEmailSubjectBody",
                    JSON.stringify({
                        MessageID: messageID,
                        ProjectID: ProjectID
                    }),
                    false
                );

                var mailData = mailResult?.data?.PM_EmailSubjectBodyModel[0];

                if (!mailData) {
                    alertify.error('No email template data found.');
                    return;
                }

                var subject = mailData.subject || '';
                var body = mailData.body || '';

                var projectName = $('#ProjectNameHidden').val() || '';
                var initiatedBy = $('#ddlInitiatedBy option:selected').text() || '';
                var InitiationDate = $('#initiationDate').val() || '';
                var peakTeamSize = $('#txtPeakTeamSize').val() || '';
                var userName = $('#UserNameHidden').val() || 'Admin';

                var teamMembersText = '';

                $('.teamRow').each(function () {
                    var memberName = $(this).find('.memberName').text();
                    var memberRole = $(this).find('.memberRole').text();

                    if (memberName && memberRole) {
                        teamMembersText += memberName + ' : ' + memberRole + '\n';
                    }
                });

                // If no dynamic list
                if (!teamMembersText) {
                    teamMembersText = '';
                }

                if (subject) {
                    subject = subject.replace(/<PROJECT_NAME>/g, projectName);
                }

                if (body) {

                    body = body.replace(/<PROJECT_NAME>/g, projectName);
                    body = body.replace(/<INITIATED_BY>/g, initiatedBy);
                    body = body.replace(/<INITIATED_ON>/g, initiationDate);
                    body = body.replace(/<PEAK_TEAM_SIZE>/g, peakTeamSize);
                    body = body.replace(/<TEAM_MEMBERS>/g, teamMembersText);
                    body = body.replace(/<SENDER_NAME>/g, userName);
                }

                $('#sendPCMailSubject').val(subject);
                $('#sendPCMailBody').val(body);

            }
            catch (error) {
                alertify.error('Error loading mail data: ' + (error.message || error));
            }
        }


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
                    // Only send the bearer token; do NOT duplicate the entire payload in headers.
                    // Large text fields were causing "Request headers too long" (HTTP 400)
                    // because the encrypted Params header exceeded IIS limits.
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (data) {
                    result = data;
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('A_AuthenticationFailed');
                    } else {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                    }
                }
            });
            if (!async) {
                return result;
            }
            return AjaxResult;
        }

        function sendPCMailConfirm() {

            var toEmail = $('#sendPCMailTo').val().trim();
            var ccEmail = $('#sendPCMailCC').val().trim();
            var FromEmailID = $('#sendPCMailFrom').val().trim();
            var subject = $('#sendPCMailSubject').val().trim();
            var rawBody = $('#sendPCMailBody').val().trim();
            var encodedBody = $('<div/>').text(rawBody).html();

            // Convert new lines to <br/>
            var body = encodedBody.replace(/\r?\n/g, '<br/>');

            // Validation
            if (!toEmail) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ToMailReq")%>');
                $('#sendPCMailTo').focus();
                return;
            }

            if (!subject) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SubReq")%>');
                $('#sendMailSubject').focus();
                return;
            }

            if (!body) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_BodyReq")%>');
                $('#sendMailBody').focus();
                return;
            }

            // Prepare request for API call
            var requestParams = {
                ProjectID: ProjectID || 0,
                ToEmailID: toEmail,
                CCEmailID: ccEmail,
                FromEmailID: FromEmailID,
                Subject: subject,
                Body: body
            };

            // Call API to send email
            try {
                var param = JSON.stringify(requestParams);
                var response = AJAXCallWithResult("api/PM_ProjectCharter/SendProjectEmail", param, false);

                // Check response - handle new format with success and message
                var isSuccess = false;
                var successMessage;

                if (response) {
                    // Check for success property first (new format)
                    if (response.status == true) {
                        isSuccess = true;
                        successMessage = response.message;
                    }
                }

                if (isSuccess) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success(successMessage);

                    // Close modal
                    var sendMailModal = bootstrap.Modal.getInstance(document.getElementById('SendMailPCModal'));
                    if (sendMailModal) {
                        sendMailModal.hide();
                    }

                    // Clear form
                    $('#sendPCMailTo').val('');
                    $('#sendPCMailCC').val('');
                    $('#sendPCMailSubject').val('');
                    $('#sendPCMailBody').val('');
                } else {
                    // Show error message
                    var errorMsg = 'A_FailSendMail';
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(errorMsg);
                }
            } catch (error) {
                // Handle any JavaScript errors
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ErrSendMail")%>');
            }
        }
    </script>
</body>

</html>
