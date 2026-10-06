<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TaskExcelUpload.aspx.vb" Inherits="Whizible.PM_TaskExcelUpload" %>
<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Task Excel Upload")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Task Excel Upload</title>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
     <!-- Added By Madhuri.K On 26-03-2026 -->
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
    <style type="text/css">
        .disabled-icon {
            cursor: not-allowed !important; 
            opacity: 0.5;
            pointer-events: none; 
        }
        .badge {
            display: inline-block;
            padding: 2px 6px;
            border-radius: 8px;
            font-size: 10px;
            font-weight: 400;
        }
        .badge-success {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        .badge-primary {
            background-color: #cfe2ff;
            color: #084298;
        }
        .badge-danger {
            background-color: #f8d7da;
            color: #842029;
        }
        .error-icon {
            color: #dc3545;
            cursor: pointer;
            margin-left: 3px;
            font-size: 14px;
        }
        .success-status {
            color: green; 
            font-weight: bold;
        }
        .error-status {
            color: red;
            font-weight: bold;
        }
        .new-large-modal .modal-dialog {
            width: 80%;
            max-width: 900px; 
        }
        .custmodal .modal-content .modal-header .close {
            background-color: transparent;
        }
        .clickYes {
            color: #198754 !important; 
            cursor: pointer;
        }
        .clickNo {
            color: #dc3545 !important; 
            cursor: pointer;
        }
        .dataTables_scrollBody {
            margin-bottom: 10px
        }
        .listboxpanel select {
            min-height: 320px
        }
        table tr th, table tr td {
            text-align: center !important
        }
        table tr th:last-child, table tr td:last-child {
            text-align: center;
            width: 80px
        }
        .dataTables_scrollHeadInner, .dataTables_scrollHeadInner table {
            width: 100% !important
        }
        .dataTables_scrollHeadInner {
            width: 100% !important
        }
        div.dataTables_scrollBody > table {
            width: 100% !important
        }
        .accordion-button {
            font-size: 0.9rem;
        }
        .drop-zone__thumb {
            height: 50px;
            background-color: transparent;
        }
        .drop-zone__thumb::after {
            color: #000;
            background-color: transparent;
        }
        .alertify-notifier {
            z-index: 10000;
        }
        .instructions {
            margin-bottom: 8px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .instructions ol {
            padding-left: 18px;
            margin-bottom: 0;
        }
        .instructions li {
            margin-bottom: 3px;
        }
        .card {
            background: white;
            border-radius: 6px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.08);
            margin-bottom: 15px;
            padding: 15px;
        }
        .card-compact {
            padding: 10px;
        }
        .card-title {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 10px;
        }
        #AddExcelDtlsTab .accordion-body {
            padding: var(--bs-accordion-body-padding-y) 0 0;
        }
        table.dataTable thead .sorting_asc:after {
            content: "";
        }
        /* Added by Vishal for Acces Restriction */
        .container_Access {
            width: 100%;
            height: 100vh; /* full viewport height */
            display: flex;
            flex-direction: column;
            justify-content: center; /* center content vertically */
            align-items: center;     /* center content horizontally */
            background: #f9f9f9;     /* optional: light background */
            padding: 20px;
            box-sizing: border-box;
        }
        .icon-container {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
            position: relative;
        }

        .icon-circle {
            width: 5rem;
            height: 5rem;
            background: linear-gradient(135deg, #3b82f6, #6366f1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
            animation: float 3s ease-in-out infinite;
            position: relative;
            z-index: 2;
        }

        .icon-circle::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, #3b82f6, #6366f1);
            border-radius: 50%;
            animation: pulse-glow 2s ease-in-out infinite;
            opacity: 0.3;
            z-index: -1;
        }

        .icon-circle svg {
            width: 2.5rem;
            height: 2.5rem;
            color: white;
        }

        #NoAccessDiv .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 0.75rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(226, 232, 240, 0.8);
            padding: 2rem;
        }

        .header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .header h1 {
            font-size: 1.875rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.75rem;
        }

        .header p {
            font-size: 1.125rem;
            color: #64748b;
            line-height: 1.75;
        }

        .instructions-section {
            background: rgba(248, 250, 252, 0.5);
            border-radius: 0.5rem;
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
        }

        .instructions-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        .warning-icon {
            width: 2rem;
            height: 2rem;
            background: rgba(251, 191, 36, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .warning-icon svg {
            width: 1rem;
            height: 1rem;
            color: #f59e0b;
        }

        .instructions-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #0f172a;
        }

        .instructions-content {
            color: #64748b;
        }

        .instructions-content p {
            margin-bottom: 1rem;
            line-height: 1.75;
        }

        .access-box {
            background: rgba(255, 255, 255, 0.5);
            border-radius: 0.375rem;
            padding: 1rem;
            border: 1px solid rgba(226, 232, 240, 0.5);
            margin: 1rem 0;
        }

        .access-box p:first-child {
            font-weight: 500;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }

        .contact-box {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            padding: 1rem;
            background: rgba(59, 130, 246, 0.05);
            border-radius: 0.375rem;
            border: 1px solid rgba(59, 130, 246, 0.2);
            margin-top: 1rem;
        }

        .contact-box svg {
            width: 1.25rem;
            height: 1.25rem;
            color: #3b82f6;
            margin-top: 0.125rem;
            flex-shrink: 0;
        }

        .contact-content p:first-child {
            color: #0f172a;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .contact-content p:last-child {
        /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
            line-height: 1.75;
        }

        .config-path {
            font-weight: 600;
            color: #3b82f6;
        }

        .footer {
            margin-top: 1.5rem;
            text-align: center;
        }

        .footer p {
             /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px;
            color: #64748b;
        }

        .support-link {
            color: #3b82f6;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .support-link:hover {
            color: #2563eb;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 20px rgba(59, 130, 246, 0.3); }
            50% { box-shadow: 0 0 30px rgba(59, 130, 246, 0.5); }
        }

        @media (max-width: 640px) {
            .card {
                padding: 1.5rem;
            }
    
            .header h1 {
                font-size: 1.5rem;
            }
    
            .header p {
                font-size: 1rem;
            }
    
            .contact-box {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
        /* End of Added by Vishal for Acces Restriction */
         /*Added By Dipali V On 20th Jan 2026 For W26 Changes*/
         .bgwhite {
                font-size:11.5px!important; /* Modified By Madhuri.K On 26-03-2026 */
         }
        #divMain {
                    font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
         }
         .form-control, .btn, a, p, input, select.form-select
         {
             /* Modified By Madhuri.K On 26-03-2026 */
             font-size:11.5px!important;
         }
         .custmodal {
             font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
         }
        #ExcelUploadTbl .btn-icon:hover i {
            color: #1359a6 !important;
        }
        .btn-primary-action {
    background: #fef3c7;
    color: #d97706;
    border: none;
    padding: 0.3rem 0.78rem;
    font-weight: 400;
    font-size: 0.8125rem;
    border-radius: 6px;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    box-shadow: none;
}
        .btn-primary-action:hover {
    background: #fde68a;
    color: #b45309;
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}
   /*End of Added By Dipali V On 20th Jan 2026 For W26 Changes*/
    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <% If m_blnViewAccess = True Then %>
    <div class="bgwhite">
      <%--  <div class="container-fluid py-2 graybg">
            <div class="row">
                <div class="col-sm-5">
                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_TaskExcelUpload")%></h5>
                </div>
                <div class="col-sm-7 d-flex justify-content-end">
                    <a href="javascript:;" class="clearalllink pe-3" onclick="clearAll" id="ClearAllFilter" data-bs-toggle="tooltip" title="Clear All"><strong><%=MyBase.GetResourceString("C_ClearAll")%></strong></a>
                    <div class="filter inline">
                        <button data-bs-toggle="collapse" data-bs-target="#filterpanel" title="" id="AdvanceFilterIcon" title="Filter" autocomplete="off" style="display: none"><i class="fas fa-filter"></i></button>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>--%>
        <div class="content">
            <!-- Top Filters start here -->
            <div class="toplinks lightGrey topFilters mb-1 py-2">
                <div class="row">
                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-sm-6 pe-0 d-flex justify-content-end">
                                <label for="statusTopFilter"><%=MyBase.GetResourceString("C_Status")%></label>
                            </div>
                            <div class="col-sm-6">
                                <select class="selectpicker statusColors" data-live-search="true" id="statusTopFilter">
                                    <option><%=MyBase.GetResourceString("C_SelectStatus")%></option>
                                    <option value="In Progress" data-content="<span class='statusBox statusOpen mx-2'></span>In Progress"></option>
                                    <option value="Completed" data-content="<span class='statusBox statusReSubmitted mx-2'></span>Completed"></option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <div class="row">
                            <div class="col-sm-6 pe-0 d-flex justify-content-end">
                                <label for="templateTopFilter"><%=MyBase.GetResourceString("C_TemplateToBeUsed")%></label>
                            </div>
                            <div class="col-sm-6">
                                <%CommonFunctions.HTMLControls.DrawComboBox("cboTemplateTopFilter", "Select 0, 'Select Template'",,, "class='selectpicker' data-live-search='true'",,,) %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!-- Add Excel Upload Details start here -->
            <div class="accordion WF_TopAccordianPanel my-3 " id="AddDtlsAcc">
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header">
                        <%--added by Aditya J. on 21-08-2026 for removing add access when closed project is in session--%>
                        <%If m_blnAddAccess = True Then%>
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#AddExcelDtlsTab" aria-expanded="false">
                            <i class="fas fa-plus addIcn pe-2"></i><%=MyBase.GetResourceString("C_NewExcel")%></button>
                        <%End If %>
                        <%--End of added by Aditya J. on 21-08-2026 for removing add access when closed project is in session--%>
                    </h2>

                    <div id="AddExcelDtlsTab" class="accordion-collapse collapse">
                        <div class="accordion-body">
                            <div class="card">
                                <div class="row">
                                    <div class="col-sm-11">
                                        <div class="row">
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="ReqNameAdd" class="required text-end"><%=MyBase.GetResourceString("C_RequestName")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <%--<input id="ReqNameAdd" type="text" class="form-control" />--%>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtReqNameAdd", "txtReqNameAdd", "form-control",,,,,,,,,, " oninput='' autocomplete='off' maxlength='100'",,, True,,,, True) %>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 text-end">
                                                        <label for="ReqDescAdd" class="mt-2"><%=MyBase.GetResourceString("C_RequestDescription")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <textarea class="form-control" id="txtReqDescAdd" maxlength='500'></textarea>
                                                        <%--<% CommonFunctions.HTMLControls.DrawTextArea("txtReqDescAdd", "txtReqDescAdd", "form-control",,,,,,,,,, " oninput='' autocomplete='off' maxlength='500'",,, True,,,, True) %>--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="TemplateUsedAdd" class="required text-end">
                                                            <%=MyBase.GetResourceString("C_TemplateToBe")%>
                                                            <br>
                                                            <%=MyBase.GetResourceString("C_used")%></label>
                                                    </div>
                                                    <div class="col-sm-7">
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboTemplateUsedAdd", "Select 0, 'Select Template'",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="StartRowAdd" class="text-end" style="display: none"><%=MyBase.GetResourceString("C_StartRow")%></label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <input id="StartRowAdd" type="number" class="form-control" style="display: none" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-4 mb-3">
                                                <div class="row">
                                                    <div class="col-sm-5 d-flex justify-content-end">
                                                        <label for="EndRowAdd" class="text-end" style="display: none"><%=MyBase.GetResourceString("C_EndRow")%></label>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <input id="EndRowAdd" type="number" class="form-control" style="display: none" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-1 d-flex gap-3">
                                        <div class="addNewBtns">
                                            <% If m_blnAddAccess = True Then %>
                                            <i class="fas fa-check clickYes pe-2" id="AddClickYes" onclick="AddNewRequest();" data-bs-toggle="tooltip" title="Save"></i>
                                            <% Else %>
                                            <i class="fas fa-check clickYes pe-2 disabled-icon" data-bs-toggle="tooltip" title="Save" disabled></i>
                                             <% End If %>
                                            <i class="fas fa-times clickNo" id="AddClickNo" onclick="ClearRequestDetails();" data-bs-toggle="tooltip" title="Clear"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Excel Upload Details end here -->
            <table id="ExcelUploadTbl" class="table table-stripped newTblStyle" style="width: 100%;">
                <thead>
                    <tr>
                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_RequestID")%></th>
                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_RequestNameHeader")%></th>
                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_RequestedBy")%></th>
                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_UploadedOn")%></th>
                        <th class="col-sm-3"><%=MyBase.GetResourceString("C_TemplateNameHeader")%></th>
                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_StatusHeader")%></th>
                        <th class="col-sm-1">&nbsp;</th>
                    </tr>
                </thead>
                <tbody id="ExcelUploadTbl_body">
                </tbody>
            </table>
            <!-- Added by Aditya J. on 20-03-2026 for pagination style same as Assigned Tasks -->
            <div class="cstm_pagination mt-2" id="paginationControlsExcelUpload">
                <div class="d-flex justify-content-end w-100">
                    <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                        <span class="spntotal">Total Records : </span>
                        <span class="spntotal" id="TotalRecordsExcelUpload"></span>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-end" style="margin: 0px!important">
                                <li class="page-item" id="btnprevious">
                                    <a class="page-link" aria-label="Previous" onclick="PrevExcelUploadList()" data-bs-toggle="tooltip" title="Prev" id="LinkPrevious">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>
                                <li class="page-item" id="btnnext">
                                    <a class="page-link" aria-label="Next" onclick="NextExcelUploadList()" data-bs-toggle="tooltip" title="Next" id="LinkNext">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- End of Added by Aditya J. on 20-03-2026 for pagination style same as Assigned Tasks -->
            <div class="clearfix"></div>
            <!-- Edit Excel Upload Section starts -->
            <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
                id="offcanvas_EdtExcels">
                <div class="offcanvas-body">
                    <div id="edtExcel_Details" class="edtExcel_Details">
                        <div class="graybg container-fluid py-1 mb-2">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_TaskExcelUpload")%></h5>
                                </div>
                            </div>
                        </div>
                        <div class="row my-2">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-12 col-sm-12 text-end">                                        
                                        <% If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
                                            <a href="javascript:;" class="textUndrln me-3" id="Excel_AdvancedTemplBtn" onclick="DownloadAdvancedTaskTemplate();" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_AdvancedTemplate")%>"><%=MyBase.GetResourceString("C_AdvancedTemplate")%></a>
                                        <a href="javascript:;" class="textUndrln me-3" id="Excel_BasicTemplBtn" onclick="DownloadTaskTemplate();" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_BasicTemplate")%>"><%=MyBase.GetResourceString("C_BasicTemplate")%></a>
                                        <% Else %>
                                            <a href="javascript:;" class="textUndrln me-3 disabled-icon" ><%=MyBase.GetResourceString("C_AdvancedTemplate")%></a>
                                            <a href="javascript:;" class="textUndrln me-3 disabled-icon" ><%=MyBase.GetResourceString("C_BasicTemplate")%></a>
                                        <% End If %>
                                        <% If m_blnEditAccess = True Then %>
                                            <%--<button class="btn btnyellow" id="saveEdtExcelBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Save")%>" onclick="UpdateRequestDetails(0);"><%=MyBase.GetResourceString("C_Save")%></button>--%>
                                            <button class="btn btn-primary-action" id="saveEdtExcelBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Save")%>" onclick="UpdateRequestDetails(0);"><i class="fas fa-save"></i><%=MyBase.GetResourceString("C_Save")%></button>
                                        <% Else %>
                                            <button class="btn btnyellow disabled-icon" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Save")%>"><%=MyBase.GetResourceString("C_Save")%></button>
                                        <% End If %>
                                        <button class="btn btnyellow" id="saveAddEdtExcelBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_SaveAndAdd")%>" onclick="UpdateRequestDetails(1);"><%=MyBase.GetResourceString("C_SaveAndAdd")%></button>
                                        <% If m_blnDeleteAccess = True Then %>
                                            <button class="btn borderbtn" id="deleteExcelBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Delete")%>"><%=MyBase.GetResourceString("C_Delete")%></button>
                                        <% Else %>
                                            <button class="btn borderbtn disabled-icon"><%=MyBase.GetResourceString("C_Delete")%></button>
                                         <% End If %>
                                        <button type="button" class="btn borderbtn" id="closeExcelBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>" data-bs-dismiss="offcanvas">
                                            <%=MyBase.GetResourceString("C_Close")%>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-0" id="lblnoteTxt">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-title"><%=MyBase.GetResourceString("C_ImportantInstructions")%> :</div>
                                    <div class="instructions">
                                        <ol>
                                            <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_FilesizeLimit")%><strong> <%=MyBase.GetResourceString("C_100records")%> </strong><%=MyBase.GetResourceString("C_processed")%></li>
                                            <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_WorkHours")%> <strong><%=MyBase.GetResourceString("C_HHMM")%></strong> <%=MyBase.GetResourceString("C_HoursMinutesformat")%></li>
                                            <li style="list-style-type: decimal !important;"><strong><%=MyBase.GetResourceString("C_AdvancedExcelFile")%></strong> <%=MyBase.GetResourceString("C_InstrictionNote1")%></li>
                                            <li style="list-style-type: decimal !important;"><strong><%=MyBase.GetResourceString("C_BasicExcelFile")%></strong> <%=MyBase.GetResourceString("C_InstrictionNote2")%></li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="EdtScreen">
                            <div class="accordion Off_acordian_panel my-0 " id="EditDetailsAcc">
                                <div class="accordion-item mb-3">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#ReqDetailsTab" aria-expanded="true">
                                            <%=MyBase.GetResourceString("C_RequestDetails")%></button>
                                    </h2>
                                    <div id="ReqDetailsTab" class="accordion-collapse collapse show">
                                        <div class="accordion-body">
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 d-flex justify-content-end">
                                                            <label for="EdtReqName" class="required text-end"><%=MyBase.GetResourceString("C_RequestName")%></label>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEdtReqName", "txtEdtReqName", "form-control",,,,,,,,,, " oninput='' autocomplete='off' maxlength='100'",,, True,,,, True) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 text-end">
                                                            <label for="EdtReqDesc" class="mt-2"><%=MyBase.GetResourceString("C_RequestDescription")%></label>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <textarea class="form-control" id="txtEdtReqDesc" maxlength='500'></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 d-flex justify-content-end">
                                                            <label for="EdtTemplateUsed" class="required text-end"><%=MyBase.GetResourceString("C_TemplateToBeUsed")%></label>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboEdtTemplateUsed", "Select 0, '" + MyBase.GetResourceString("C_SelectTemplate") + "'",,, "class='selectpicker' data-live-search='true'",,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 d-flex justify-content-end">
                                                            <label for="txtEdtStatus" class="text-end"><%=MyBase.GetResourceString("C_Status")%></label>
                                                        </div>
                                                        <div class="col-sm-7">
                                                            <select class="selectpicker statusColors" data-live-search="true" id="txtEdtStatus">
                                                                <option value="0"><%=MyBase.GetResourceString("C_SelectStatus")%></option>
                                                                <option value="2" data-content="<span class='statusBox statusOpen mx-2'>&nbsp;</span> <%=MyBase.GetResourceString("C_InProgress")%>"><%=MyBase.GetResourceString("C_InProgress")%></option>
                                                                <option value="3" data-content="<span class='statusBox statusReSubmitted mx-2'>&nbsp;</span> <%=MyBase.GetResourceString("C_Completed")%>"><%=MyBase.GetResourceString("C_Completed")%></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 d-flex justify-content-end">
                                                            <label for="EdtStartRow" class="text-end" style="display: none"><%=MyBase.GetResourceString("C_StartRow")%></label>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <input id="EdtStartRow" type="number" class="form-control" style="display: none" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-5 d-flex justify-content-end">
                                                            <label for="EdtEndRow" class="text-end" style="display: none"><%=MyBase.GetResourceString("C_EndRow")%></label>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <input id="EdtEndRow" type="number" class="form-control" style="display: none" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item mb-3">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#FileUploadTab" aria-expanded="true" id="btnFileUploadTab">
                                            <%=MyBase.GetResourceString("C_FileToBeUploaded")%>
                                        </button>
                                    </h2>
                                    <div id="FileUploadTab" class="accordion-collapse collapse show">
                                        <div class="accordion-body">
                                            <div class="row mb-2">
                                                <div class="col-sm-12 text-end">
                                                    <% If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
                                                        <button type="button" class="btn borderbtn" id="UploadDocumentBtn"><span data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_UploadExcelFileTooltip")%>"><%=MyBase.GetResourceString("C_UploadExcelFile")%></span></button>
                                                    <% Else %>
                                                        <button type="button" class="btn borderbtn disabled-icon"><span><%=MyBase.GetResourceString("C_UploadExcelFile")%></span></button>
                                                    <% End If %>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <table class="table table-stripped mb-2" id="UploadFileTbl" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_FileName")%></th>
                                                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_AttachedBy")%></th>
                                                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_AttachedDate")%></th>
                                                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_Description")%></th>
                                                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_StatusHeader")%></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="UploadFileTbl_Body">
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
            <!-- Edit Excel Upload Section ends -->
        </div>
        <!-- Contract Attachment modal start here-->
        <div class="modal custmodal fade" id="UploadDocumentModal" data-bs-backdrop="static" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center"><%=MyBase.GetResourceString("C_UploadData")%></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="uploadDocDetails">
                            <div class="form-group row">
                                <div class="col-sm-6 drop-zone form-group mb-3" id="drop-zone-div">
                                    <span class="drop-zone__prompt"><%=MyBase.GetResourceString("C_DropFilePrompt")%></span>
                                    <input type="file" class="drop-zone__input" id="doc_dragdrop" accept=".xlsx, .xls">
                                </div>
                                <div class="col-sm-6 d-flex align-items-center justify-content-center mb-3">
                                    <div class="row">
                                        <label for="docDescription" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Description")%></label>
                                        <div class="col-sm-8">
                                            <textarea id="docDescription" class="form-control" maxlength="500"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-sm-12 text-center">
                                <button id="uploadDocBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Upload")%>" class="btn btnyellow" onclick="UploadFile();"><%=MyBase.GetResourceString("C_Upload")%></button>
                                <button data-bs-dismiss="modal" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Cancel")%>" class="btn borderbtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contract Attachment modal end here-->
        <div id="errorModal" class="modal fade custmodal new-large-modal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" onclick="Close_ErrorModel()">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_ErrorDetails")%></h4>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table" id="tblErrorDetails">
                                <thead id="tbl_ErrorHeader">
                                </thead>
                                <tbody id="tblErrorDetailsBody">
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="Close_ErrorModel()"><%=MyBase.GetResourceString("C_Close")%></button>
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" onclick="Close_deleteModel()" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
                    </div>
                    <div class="modal-body">
                        <span class="text-center" id="txtExcelValidationMessage"><%=MyBase.GetResourceString("C_DeleteConfirmationMsg")%></span>
                    </div>
                    <div class="modal-footer" style="display: flex; justify-content: space-between;">
                        <button class="btn btn-success me-2" id="btnExcelYes" onclick="DeleteRequestDetails()"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <button class="btn btn-danger" data-bs-dismiss="modal" onclick="Close_deleteModel()"><%=MyBase.GetResourceString("C_No")%></button>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="clearfix"></div>
    </div>
     <% Else %>
    <div id="ViewAccess" class="container-fluid" style="height: 448px">
        <%--<div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %> </p>
        </div>--%>
         <div class="container_Access" id="NoAccessDiv">
             <div class="content">
                 <div class="icon-container">
                     <div class="icon-circle">
                         <svg xmlns="" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                             <path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"/>
                         </svg>
                     </div>
                 </div>
                 <div class="card">
                     <div class="header">
                         <h1><%=MyBase.GetResourceString("C_AccessRestricted")%></h1>
                         <p><%=MyBase.GetResourceString("C_NotAuthorised")%></p>
                     </div>
                     <div class="instructions-section">
                         <div class="instructions-header">
                             <div class="warning-icon">
                                 <svg xmlns="" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                     <path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/>
                                     <path d="M12 9v4"/>
                                     <path d="m12 17 .01 0"/>
                                 </svg>
                             </div>
                             <h3><%=MyBase.GetResourceString("C_InstructionsforAccess")%></h3>
                         </div>
                 
                         <div class="instructions-content">
                             <p><%=MyBase.GetResourceString("C_InstructionNote1")%></p>
                     
                             <div class="contact-box">
                                 <p><%=MyBase.GetResourceString("C_Togainaccess")%></p>
                                 <p><%=MyBase.GetResourceString("C_InstructionNote2")%></p>
                             </div>
                             <div class="contact-box">
                                 <svg xmlns="" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                     <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                                     <circle cx="9" cy="7" r="4"/>
                                     <line x1="17" x2="22" y1="8" y2="13"/>
                                     <line x1="22" x2="17" y1="8" y2="13"/>
                                 </svg>
                                 <div class="contact-content">
                                     <p><%=MyBase.GetResourceString("C_ContactAdministrator")%></p>
                                 <p>
                                    <%=MyBase.GetResourceString("C_InstructionNote3")%> 
                                </p>
                                <ul style="list-style-type: none; padding-left: 0;">
                                    <li>
                                        <strong>1.</strong> <%=MyBase.GetResourceString("C_Navigateto")%> <span class="config-path"><%=MyBase.GetResourceString("C_Navigation")%></span>.
                                    </li>
                                    <li>
                                        <strong>2.</strong> <%=MyBase.GetResourceString("C_Navigateto")%> <span class="config-path"><%=MyBase.GetResourceString("C_Navigation1")%></span>.
                                    </li>
                                </ul>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
    </div>
    <% End If %>
    <!-- REQUIRED JS SCRIPTS -->    
    <%--<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>--%>

    <script>
        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip()
        });

        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $("#ExcelUploadTbl_wrapper .dataTables_scroll").css({ height: tblheight - 232, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        document.querySelectorAll(".drop-zone__input").forEach((inputElement) => {
            const dropZoneElement = inputElement.closest(".drop-zone");

            dropZoneElement.addEventListener("click", (e) => {
                inputElement.click();
            });

            inputElement.addEventListener("change", (e) => {
                if (inputElement.files.length) {
                    updateThumbnail(dropZoneElement, inputElement.files[0]);
                }
            });

            dropZoneElement.addEventListener("dragover", (e) => {
                e.preventDefault();
                dropZoneElement.classList.add("drop-zone--over");
            });

            ["dragleave", "dragend"].forEach((type) => {
                dropZoneElement.addEventListener(type, (e) => {
                    dropZoneElement.classList.remove("drop-zone--over");
                });
            });

            dropZoneElement.addEventListener("drop", (e) => {
                e.preventDefault();

                if (e.dataTransfer.files.length) {
                    inputElement.files = e.dataTransfer.files;
                    updateThumbnail(dropZoneElement, e.dataTransfer.files[0]);
                }

                dropZoneElement.classList.remove("drop-zone--over");
            });
        });

        function updateThumbnail(dropZoneElement, file) {
            let thumbnailElement = dropZoneElement.querySelector(".drop-zone__thumb");
            // First time - remove the prompt
            if (dropZoneElement.querySelector(".drop-zone__prompt")) {
                dropZoneElement.querySelector(".drop-zone__prompt").remove();
            }
            // First time - there is no thumbnail element, so lets create it
            if (!thumbnailElement) {
                thumbnailElement = document.createElement("div");
                thumbnailElement.classList.add("drop-zone__thumb");
                dropZoneElement.appendChild(thumbnailElement);
            }
            thumbnailElement.dataset.label = file.name;
            // Show thumbnail for image files
            if (file.type.startsWith("image/")) {
                const reader = new FileReader();

                reader.readAsDataURL(file);
                reader.onload = () => {
                    thumbnailElement.style.backgroundImage = `url('${reader.result}')`;
                };
            } else {
                thumbnailElement.style.backgroundImage = null;
            }
            // Reset drop-zone when UploadDocumentModal opens/closes
            $('#UploadDocumentModal').on('show.bs.modal shown.bs.modal hidden.bs.modal', function () {
                var $dz = $(this).find('.drop-zone');
                if ($dz.length === 0) return;
                var $input = $dz.find('.drop-zone__input');

                // Remove any thumbnail(s)
                $dz.find('.drop-zone__thumb').remove();

                // Ensure the prompt span exists
                if ($dz.find('.drop-zone__prompt').length === 0) {
                    // add prompt at the beginning of drop-zone
                    $dz.prepend('<span class="drop-zone__prompt">Drop file here or click to upload</span>');
                }
                // Clear the file input (works for most browsers). For full reset replace input element if needed.
                try {
                    $input.val('');
                    // also clear files property for some browsers
                    if ($input[0] && $input[0].files) $input[0].files = null;
                } catch (e) {
                    // fallback: replace the input element with a clone
                    var $clone = $input.clone().val('');
                    $input.replaceWith($clone);
                }
            });
        }

        //Show History Detailspanel Script start here
        $(".ShowHisDetailpanel").hide();
        function ShowHistoryTab() {
            $(".ShowHisDetailpanel").show();
            $(".offcanvas-body").animate(
                {
                    scrollTop: $(".ShowHisDetailpanel").offset().top - 60,
                },
                "1000"
            );
            //used for disable grid
            // $(".backbtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
            $(".table").resize();
        }
        $(".cancelEdtDetpanel").click(function () {
            $("table tr").removeClass("rowhiglight");
            $(".ShowHisDetailpanel").hide();
            // $(".backbtn, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
        });

        $(".collapse").on("show.bs.collapse", function (e) {
            $(".table").resize();
        });
        $(".collapse").on("hidden.bs.collapse", function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on("shown.bs.tab", function (e) {
            $(".table").resize();
        });
        //Added by Vishal Mane on 11/10/2025 to implement new feature Task Excel Upload for W26 version
        <%--var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';--%>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        if (strUrl.endsWith('/')) {
            strUrl = strUrl.slice(0, -1);
        }
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var SessionProjectID = '<%= Session("intProjectID") %>';

        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var AddAccess = '<%=m_blnViewAccess%>';
        alertify.set('notifier', 'position', 'top-right');
        var GlobalTemplateRequestID;
        $(document).ready(function () {
            GetTemplateDetails();
            GetRequestDetails();
        });

        // Added by Aditya J. on 20-03-2026 for pagination style same as Assigned Tasks
        var excelUploadCurrentPage = 1;
        var excelUploadItemsPerPage = 5;
        var excelUploadTotalItems = 0;
        var excelUploadTotalPages = 0;

        function initExcelUploadPagination() {
            var $items = $('#ExcelUploadTbl_body .excel-upload-item');
            excelUploadTotalItems = $items.length;
            excelUploadTotalPages = Math.ceil(excelUploadTotalItems / excelUploadItemsPerPage);

            $('#TotalRecordsExcelUpload').text(excelUploadTotalItems);

            if (!excelUploadTotalItems) {
                $('#paginationControlsExcelUpload').hide();
                return;
            }

            $('#paginationControlsExcelUpload').show();
            excelUploadCurrentPage = 1;
            showExcelUploadPage(1);
        }

        function showExcelUploadPage(page) {
            excelUploadCurrentPage = page;

            var $items = $('#ExcelUploadTbl_body .excel-upload-item');
            var start = (page - 1) * excelUploadItemsPerPage;
            var end = start + excelUploadItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateExcelUploadPaginationControls();
        }

        function updateExcelUploadPaginationControls() {
            $("#btnprevious, #LinkPrevious").removeClass("disabled fa-disabled");
            $("#btnnext, #LinkNext").removeClass("disabled fa-disabled");

            if (excelUploadCurrentPage <= 1) {
                $("#btnprevious").addClass("fa-disabled");
                $("#LinkPrevious").addClass("disabled");
            }

            if (excelUploadCurrentPage >= excelUploadTotalPages) {
                $("#btnnext").addClass("fa-disabled");
                $("#LinkNext").addClass("disabled");
            }
        }

        function PrevExcelUploadList() {
            if ($("#btnprevious").hasClass("fa-disabled")) return false;
            if (excelUploadCurrentPage > 1) showExcelUploadPage(excelUploadCurrentPage - 1);
        }

        function NextExcelUploadList() {
            if ($("#btnnext").hasClass("fa-disabled")) return false;
            if (excelUploadCurrentPage < excelUploadTotalPages) showExcelUploadPage(excelUploadCurrentPage + 1);
        }
        // End of Added by Aditya J. on 20-03-2026 for pagination style same as Assigned Tasks

        function GetRequestDetails() {
            var TemplateName = $('#cboTemplateTopFilter option:selected').text();
            //var Status = $('#statusTopFilter option:selected').text();
            var Status = $('#statusTopFilter').val();
            if (TemplateName === 'Select Template' || TemplateName == undefined) {
                TemplateName = '';
            }
            if (Status === 'Select Status' || Status == undefined) {
                Status = '';
            }
            //alert(selectedValue);
            var taskParameters = {
                ProjectID: SessionProjectID,
                EmployeeID: SessionEmployeeId,
                TemplateName: TemplateName,
                Status: Status
            };
            $('#ExcelUploadTbl').dataTable().fnDestroy();
            $("#ExcelUploadTbl_body").empty();
            var param = JSON.stringify(taskParameters);
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/GetRequestDetails", param, false);
            var data = response.data;
            if (data && data.length > 0) {
                var strHtml = "";
                for (var i = 0; i < data.length; i++) {

                    strHtml += `<tr class="excel-upload-item">
                    <td>${data[i].requestID}</td>
                    <td>${data[i].requestName}</td>
                    <td>${data[i].employeeName}</td>                       
                    <td>${data[i].uploadedTime}</td>
                    <td>${data[i].templateName}</td>`;

                    if (data[i].status === "Approved") {
                        strHtml += `<td>
                            <div class="statusDiv d-flex justify-content-start">
                                <span class="statusBox statusApproved mx-2">&nbsp;</span>
                                <label class="crsrLink" data-bs-toggle="tooltip" title="Approved">Approved</label>
                            </div>
                        </td>`;
                    }
                    else if (data[i].status === "In Progress") {
                        strHtml += `<td>
                            <div class="statusDiv d-flex justify-content-start">
                                <span class="statusBox statusOpen mx-2">&nbsp;</span>
                                <label class="crsrLink" data-bs-toggle="tooltip" title="In Progress">In Progress</label>
                            </div>
                        </td>`;
                    }
                    else if (data[i].status === "Completed") {
                        strHtml += `<td>
                            <div class="statusDiv d-flex justify-content-start">
                                <span class="statusBox statusReSubmitted mx-2">&nbsp;</span>
                                <label class="crsrLink" data-bs-toggle="tooltip" title="Completed">Completed</label>
                            </div>
                        </td>`;
                    }
                    else {
                        strHtml += `<td>
                        <div class="statusDiv d-flex justify-content-start">
                            <span class="statusBox statusPending mx-2">&nbsp;</span>
                            <label class="crsrLink" data-bs-toggle="tooltip" title="${data[i].status || ''}">
                                ${data[i].status || ''}
                            </label>
                        </div>
                    </td>`;
                    }

                    /*strHtml += `<td>${data[i].RejectedFileLink || ''}</td>`;*/
                    strHtml += `<td>
                            <a href="javascript:;" data-bs-toggle="offcanvas"
                                data-bs-target="#offcanvas_EdtExcels" aria-controls="offcanvasWithBothOptions" onclick="GetRequestDetailInEditMode(${data[i].requestID}, ${data[i].statusID})">
                                <i class="far fa-edit" data-bs-toggle="tooltip" title="Edit" style="color:#6c757d; font-size:14px;"></i>
                                     </a>
                        </td>
                    </tr>`;
                }

                $("#ExcelUploadTbl_body").append(strHtml);

                // Added by Aditya J. on 20-03-2026 for pagination on Excel Upload table
                initExcelUploadPagination();
                // End of Added by Aditya J. on 20-03-2026 for pagination on Excel Upload table

                $("#ExcelUploadTbl").dataTable({                    
                    "paging": false,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "bAutoWidth": false,
                    "info": false,
                });

                // Added by Aditya J. on 20-03-2026 for pagination on Excel Upload table
                initExcelUploadPagination();
                // End of Added by Aditya J. on 20-03-2026 for pagination on Excel Upload table
            }
            else {
                $("#ExcelUploadTbl_body").append("");
                // Added by Aditya J. on 20-03-2026 for pagination on Excel Upload table
                $('#TotalRecordsExcelUpload').text('0');
                $('#paginationControlsExcelUpload').hide();
                // End of Added by Aditya J. on 20-03-2026 for pagination on Excel Upload table
                // ✅ Handle empty results
                //$("#ExcelUploadTbl_body").append('<tr><td colspan="6" class="text-center">No records found</td></tr>');
                $("#ExcelUploadTbl").dataTable({
                    "paging": false,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "bAutoWidth": false,
                    "info": false,
                });
                //$('.dataTables_paginate').hide(); // ✅ Hide pagination when no data
            }
        }

        function GetRequestDetailInEditMode(RequestID, StatusID) {
            GlobalTemplateRequestID = RequestID;
            GetTemplateDetailsInEditMode();
            var taskParameters = {
                RequestID: RequestID,
            };
            var param = JSON.stringify(taskParameters);
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/GetRequestDetailInEditMode", param, false);
            var data = response.data;
            var obj = data[0];
            $("#txtEdtReqName").val(obj.requestName);
            $("#txtEdtReqDesc").css('height', '50px');
            $("#txtEdtReqDesc").val(obj.requestDescription);
            //$("#EdtStartRow").val(obj.startRow);
            //$("#EdtEndRow").val(obj.EndRow);
            if (StatusID == 0) {
                $("#txtEdtStatus").val(2);
            }
            else if (StatusID == 1) {
                $("#txtEdtStatus").val(3);
            }
            $("#cboEdtTemplateUsed").val(obj.templateID);
            GetFileRequestDetails(GlobalTemplateRequestID);

            if (StatusID == 1) {
                $("#Excel_AdvancedTemplBtn").hide();
                $("#Excel_BasicTemplBtn").hide();
                $("#saveEdtExcelBtn").hide();
                $("#saveAddEdtExcelBtn").hide();
                $("#deleteExcelBtn").hide();
                $("#UploadDocumentBtn").hide();
                $("#btnFileUploadTab").text("Uploaded File Details");

                $("#lblMandatory").hide();
                $("#lblnoteTxt").hide();

            }
            else if (StatusID == 0) {
                $("#Excel_AdvancedTemplBtn").show();
                $("#Excel_BasicTemplBtn").show();
                $("#saveEdtExcelBtn").show();
                $("#saveAddEdtExcelBtn").hide();
                $("#deleteExcelBtn").show();
                $("#UploadDocumentBtn").show();
                $("#btnFileUploadTab").text("File to be Uploaded");

                $("#lblMandatory").show();
                $("#lblnoteTxt").show();
            }

            $(".selectpicker").selectpicker('refresh');
        }
        function GetTemplateDetails() {
            var strHTML = "";
            $("#cboTemplateTopFilter").html("");
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/GetTemplateDetails", '', false);
            var data = response.data;
            //var strResult = data[0];
            strHTML += '<option value="0" >Select Template</option>';
            for (var i = 0; i < data.length; i++) {
                var obj = data[i];
                var TemplateID = obj.templateID;
                var TemplateName = obj.templateName;
                strHTML += '<option value="' + TemplateID + '" >' + TemplateName + '</option>';
            }
            $("#cboTemplateTopFilter").append(strHTML);
            $("#cboTemplateUsedAdd").html("");
            $("#cboTemplateUsedAdd").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }
        function GetTemplateDetailsInEditMode() {
            var strHTML = "";
            $("#cboEdtTemplateUsed").html("");
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/GetTemplateDetails", '', false);
            var data = response.data;
            //var strResult = data[0];
            strHTML += '<option value="0" >Select Template</option>';
            for (var i = 0; i < data.length; i++) {
                var obj = data[i];
                var TemplateID = obj.templateID;
                var TemplateName = obj.templateName;
                strHTML += '<option value="' + TemplateID + '" >' + TemplateName + '</option>';
            }
            $("#cboEdtTemplateUsed").append(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        function AddNewRequest() {
            var reqName = $("#txtReqNameAdd").val().trim().replace(/\s\s+/g, ' ');
            var reqDesc = $("#txtReqDescAdd").val().trim().replace(/\s\s+/g, ' ');
            var templateId = $("#cboTemplateUsedAdd").val();
            var illegalChars = WebConfigSpecialCharacters;
            var illegalCharsRegex = new RegExp('[' + illegalChars + ']');
                    
            if (reqName === "") {
                alertify.error('<%=MyBase.GetResourceString("A_RequestNameBlank")%>');
                $("#txtReqNameAdd").focus();
                return;
            }
            if (illegalCharsRegex.test(reqName)) {
                alertify.error('<%=MyBase.GetResourceString("A_CharacterRestriction")%>' + WebConfigSpecialCharacters);
                $("#txtReqNameAdd").focus();
                return;
            }
            if (templateId === "" || templateId === null || templateId === "0") { 
                alertify.error('<%=MyBase.GetResourceString("A_TemplateBlank")%>');
                $("#cboTemplateUsedAdd").focus();
                return;
            }
            var requestDetails = {
                RequestName: encodeURIComponent(reqName),
                RequestDescription: encodeURIComponent(reqDesc),
                TemplateID: templateId,
                //StartRow: startRowInt,
                //EndRow: endRowInt,
                ProjectID: SessionProjectID,
                EmployeeID: SessionEmployeeId,
            };
            var param = JSON.stringify(requestDetails);
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/AddNewRequest", param, false);
            alertify.success('<%=MyBase.GetResourceString("A_RequestAdded")%>');
            GetRequestDetails();
            $("#txtReqDescAdd").css('height', '50px');
            ClearRequestDetails();
        }

        $("#txtReqDescAdd").css('height', '50px');
        function UpdateRequestDetails(flag) {
            var reqName = $("#txtEdtReqName").val().trim().replace(/\s\s+/g, ' ');
            var reqDesc = $("#txtEdtReqDesc").val().trim().replace(/\s\s+/g, ' ');
            var templateId = $("#cboEdtTemplateUsed").val();
            var illegalChars = WebConfigSpecialCharacters;
            var illegalCharsRegex = new RegExp('[' + illegalChars + ']');
            if (reqName === "") {
                alertify.error('<%=MyBase.GetResourceString("A_RequestNameBlank")%>');
                $("#txtEdtReqName").focus();
                return;
            }
            if (illegalCharsRegex.test(reqName)) {
                alertify.error('<%=MyBase.GetResourceString("A_CharacterRestriction")%>' + WebConfigSpecialCharacters);
                $("#txtEdtReqName").focus();
                return;
            }  
            if (templateId === "" || templateId === null || templateId === "0") { // Check for common empty/default values
                alertify.error('<%=MyBase.GetResourceString("A_TemplateBlank")%>');
                $("#cboEdtTemplateUsed").focus();
                return;
            }
            var requestDetails = {
                RequestName: encodeURIComponent(reqName),
                RequestDescription: encodeURIComponent(reqDesc),
                TemplateID: templateId,
                //StartRow: startRowInt,
                //EndRow: endRowInt,
                ProjectID: SessionProjectID,
                EmployeeID: SessionEmployeeId,
                RequestID: GlobalTemplateRequestID
            };
            var param = JSON.stringify(requestDetails);
            //var RequestID = AJAXCallWithResult("/api/PM_TaskExcelUpload/AddNewRequest", param, false);
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/UpdateRequest", param, false);
            var data = response.data;
            var obj = data[0];
            var RequestID = obj.requestID
            alertify.success('<%=MyBase.GetResourceString("A_RequestUpdated")%>');
            if (flag == 0) {
                GetRequestDetails();
                GetRequestDetailInEditMode(RequestID);
            }
            $(".selectpicker").selectpicker('refresh');
        }

        $('#cboTemplateTopFilter').on('change', function () {
            GetRequestDetails();
        });

        $("#statusTopFilter").on('change', function () {
            GetRequestDetails();
        });

        function ClearRequestDetails() {
            $("#txtReqNameAdd").val('');
            $("#txtReqDescAdd").val('');
            $("#cboTemplateUsedAdd").val(0);
            $("#StartRowAdd").val('');
            $("#EndRowAdd").val('');
            $(".selectpicker").selectpicker('refresh');
        }

        function DownloadTaskTemplate() {
            var taskParameters = {
                ProjectID: SessionProjectID,
                //EmployeeID: SessionEmployeeId,
                //RequestID: GlobalTemplateRequestID
            }
            $.ajax({
                url: strUrl + '/api/PM_TaskExcelUpload/DownloadTaskTemplate',
                type: "POST",
                async: false,
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (JSON.stringify(taskParameters)) {
                        xhr.setRequestHeader("Params", encryptString(isJson(JSON.stringify(taskParameters)) ? JSON.stringify(taskParameters) : JSON.stringify(JSON.stringify(taskParameters))));
                    }
                },
                success: function (result) {
                    if (result && result.filePathSegments && result.fileName) {
                        var fileUrl = strUrl + "/" + result.filePathSegments + "/" + result.fileName;
                        var tempLink = document.createElement('a');
                        tempLink.href = fileUrl; 
                        //tempLink.download = result.FileName;
                        tempLink.download = result.fileName;
                        document.body.appendChild(tempLink);
                        tempLink.click();
                        document.body.removeChild(tempLink);
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        function DownloadAdvancedTaskTemplate() {
            var taskParameters = {
                ProjectID: SessionProjectID,
                //EmployeeID: SessionEmployeeId,
                //RequestID: GlobalTemplateRequestID
            }
            $.ajax({
                url: strUrl + '/api/PM_TaskExcelUpload/DownloadAdvancedTaskTemplate',
                type: "POST",
                async: false,
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (JSON.stringify(taskParameters)) {
                        xhr.setRequestHeader("Params", encryptString(isJson(JSON.stringify(taskParameters)) ? JSON.stringify(taskParameters) : JSON.stringify(JSON.stringify(taskParameters))));
                    }
                },
                //success: function (fileName) {
                //    var fileUrl = "../../../Attachments/Task_Excel_Upload/Tasks_Creation_Templates/" + fileName;
                //    var tempLink = document.createElement('a');
                //    tempLink.href = fileUrl;
                //    tempLink.download = fileName;
                //    document.body.appendChild(tempLink);
                //    tempLink.click();
                //    document.body.removeChild(tempLink);
                //},
                success: function (result) {
                   // debugger;
                    if (result && result.filePathSegments && result.fileName) {
                        var fileUrl = strUrl + "/" + result.filePathSegments + "/" + result.fileName;
                        var tempLink = document.createElement('a');
                        tempLink.href = fileUrl;
                        tempLink.download = result.fileName;
                        document.body.appendChild(tempLink);
                        tempLink.click();
                        document.body.removeChild(tempLink);
                    }
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        
        $("#UploadDocumentBtn").click(function () {
            $("#UploadDocumentModal").modal("show");
            $("#docDescription").val("");          
            $(".drop-zone__input").val("");
            $(".drop-zone__thumb").attr("data-label", "Drop file here or click to upload");
        });
        function UploadFile() {
            alertify.set('notifier', 'position', 'top-right');
            var description = $("#docDescription").val();
            var TemplateID = $("#cboEdtTemplateUsed").val();
            if (TemplateID == 0 || TemplateID == undefined) {
                TemplateID = 1;
            }
            var formData = new FormData();
            var file = $('#doc_dragdrop').get(0).files;
            if (file.length > 0) {
                formData.append("UploadedFile", file[0]);
                formData.append("TemplateRequestID", GlobalTemplateRequestID);
                formData.append("TemplateID", TemplateID);
                formData.append("SessionProjectID", SessionProjectID);
                formData.append("SessionEmployeeID", SessionEmployeeId);
                formData.append("UserName", UserName);
                formData.append("FileDescription", $("#docDescription").val());
            }
            else {
                alertify.error('<%=MyBase.GetResourceString("A_FileBlank")%>');
                $("#doc_dragdrop").focus();
                return;
            }
            if (description == "" || description == undefined) {
                alertify.error('<%=MyBase.GetResourceString("A_DescriptionBlank")%>');
                $("#docDescription").focus();
                return;
            }
            $.ajax({
                url: strUrl + '/api/PM_TaskExcelUpload/ExcelUpload',
                type: "POST",
                data: formData,
                dataType: "json",
                contentType: false,
                processData: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                async: false,
                success: function (result) {
                    var outputResult = result.errorMessages;
                    $("#UploadDocumentModal").modal("hide");
                    const fileInput = document.getElementById('doc_dragdrop');
                    if (fileInput.files && fileInput.files[0]) {
                        var arrData;
                        if (outputResult != undefined || outputResult != null) {
                            arrData = outputResult.split('$');
                            if (arrData.some(item => item.toLowerCase().includes('<%=MyBase.GetResourceString("C_invalidtemplateused")%>') || item.toLowerCase().includes('<%=MyBase.GetResourceString("C_excelempty")%>'))) {
                                alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                                return;
                            }
                            else if (arrData.some(item => item.toLowerCase().includes('<%=MyBase.GetResourceString("C_CorrectExcelFormat")%>'))) {
                                alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                            }
                            else if (arrData.some(item => item.toLowerCase().includes('<%=MyBase.GetResourceString("C_Maximum100")%>') || item.toLowerCase().includes('<%=MyBase.GetResourceString("C_MaximumUploaded")%>'))) {
                                alertify.error('<%=MyBase.GetResourceString("A_MaxRecords")%>');
                                return;
                            }
                            else if (arrData[0] == "D") {
                                var message = arrData[1].trim();
                                alertify.error(message);
                                return;
                            }
                        }
                        else {
                            alertify.success('<%=MyBase.GetResourceString("A_FileUploaded")%>');
                            if (result.flag == "1") {
                                GetRequestDetails();
                                GetRequestDetailInEditMode(GlobalTemplateRequestID, 1);
                            } else {
                                GetRequestDetails();
                            }
                        }
                    }
                        GetFileRequestDetails();                 
                },
                error: function (response) {
                    // 1. Check the responseText property first, which is often a JSON string.
                    var errorText = response.responseText || '';
                    // 2. Safely check for the error message within the response text.
                    if (typeof errorText === 'string' && errorText.toLowerCase().includes('<%=MyBase.GetResourceString("C_CorruptedData")%>')) {
                        alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                    }
                    // If you prefer to rely on the structured JSON (as seen in the image):
                    else if (response.responseJSON &&
                        response.responseJSON.ExceptionMessage &&
                        response.responseJSON.ExceptionMessage.toLowerCase().includes('<%=MyBase.GetResourceString("C_CorruptedData")%>')) {
                        alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                    }
                    else {
                        alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                    }
                }
            });
        }

        function GetFileRequestDetails() {
            var requestDetails = {
                ProjectID: SessionProjectID,
                EmployeeID: SessionEmployeeId,
                RequestID: GlobalTemplateRequestID
            };
            var param = JSON.stringify(requestDetails);
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/GetFileRequestDetails", param, false);
            var data = response.data;
            var tableBody = $("#UploadFileTbl_Body");
            if ($.fn.DataTable.isDataTable("#UploadFileTbl")) {
                $('#UploadFileTbl').DataTable().clear().destroy();
            }
            tableBody.empty();
            if (data && data.length > 0) {
                $.each(data, function (index, file) {
                    var statusBadge = "";
                    if (file.status === "Invalid") {
                        statusBadge = `<td class="text-center"><span class="badge badge-danger">Invalid File</span>
                            <i class="fas fa-info-circle error-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Error Details" onclick="ShowErrorValidation(${file.requestID},0);"></i></td>`;
                    } else if (file.status === "Successful") {
                        statusBadge = `<td class="text-center"><span class="badge badge-success">Successful</span>
                            <i class="fas fa-info-circle success-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Success Details" onclick="ShowErrorValidation(${file.requestID},1);"></i></td>`;
                    }
                    var row = `<tr>
                                    <td class="text-center">
                                        <a href="#" onclick="downloadFileByName(event, '${file.fileName}')" class="download-link-table">${file.fileName}</a>
                                    </td>
                                    <td class="text-center">${file.uploadedBy}</td>
                                    <td class="text-center">${file.uploadedDate}</td>
                                    <td class="text-center">${file.fileDescription}</td>
                                    ${statusBadge}
                              </tr>`;
                    tableBody.append(row);
                });
                // ✅ Reinitialize DataTable properly
                $('#UploadFileTbl').DataTable({
                    "paging": true,
                    "pageLength": 5,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "bAutoWidth": false,
                    "info": false,
                });
                $('.dataTables_paginate').show(); 
                $('[data-bs-toggle="tooltip"]').tooltip();
            } else {
                tableBody.html('<tr><td colspan="5" class="text-center">No records found</td></tr>');
                $('.dataTables_paginate').hide(); 
            }
        }
        //End of Added by Vishal Mane on 30/09/2025 to downloaded file
        function ShowErrorValidation(RequestID, flag) {
            console.log("RequestID:", RequestID);
            $('#errorModal').modal('show');
            var taskParameters = {
                RequestID: RequestID,
                Flag: flag,
            };
            var param = JSON.stringify(taskParameters);
            var response = AJAXCallWithResult("/api/PM_TaskExcelUpload/GetErrorValidation", param, false);
            var data = response.data;
            if (data && data.length > 0) {
                var tableBody = $("#tblErrorDetails tbody");
                var tableHeader = $("#tblErrorDetails thead");
                if ($.fn.DataTable.isDataTable("#tblErrorDetails")) {
                    $('#tblErrorDetails').DataTable().clear().destroy();
                }
                tableBody.empty(); 
                tableHeader.empty();
                var rows = [];
                var HeaderRow = '<tr>' +
                    '<th class="text-center">Row Number</th>' +
                    '<th class="text-center">Project Name</th>' +
                    '<th class="text-center">Task Name</th>' +
                    '<th class="text-center">Employee Name</th>' +
                    '<th class="text-center">Start Date</th>' +
                    '<th class="text-center">End Date</th>' +
                    '<th class="text-center">Work Hours</th>';
                if (flag == 1) {
                    HeaderRow += '<th class="text-center">Response</th>';
                } else {
                    HeaderRow += '<th class="text-center" style="width: 300px;">Error</th>';
                }
                HeaderRow += '</tr>';
                HeaderRow += '</tr>';
                tableHeader.append(HeaderRow);
                $.each(data, function (index, error) {
                    var formattedErrors = error.errorMessages;
                    var finalColumnContent = "";
                    if (flag == 1) {
                        finalColumnContent = `<span class="success-status">${formattedErrors}</span>`
                    } else {
                        finalColumnContent = `<span class="error-status">${formattedErrors}</span>`
                    }
                    var row = `<tr>
                                <td class="text-center">${error.rowNumber + 1}</td>
                                <td class="text-center">${error.projectName}</td>
                                <td class="text-center">${error.taskName}</td>
                                <td class="text-center">${error.resourceName}</td>
                                <td class="text-center">${error.startDate}</td>
                                <td class="text-center">${error.endDate}</td>
                                <td class="text-center">${error.work}</td>
                                        `
                    if (flag == 1) {
                        row += `<td class="text-center">${finalColumnContent}</td>`
                    } else {
                        row += `<td class="">${finalColumnContent}</td>`
                    }
                    row += `</tr>`;
                    rows.push(row);
                });
                tableBody.append(rows.join(""));
                $('#tblErrorDetails').DataTable({
                    "paging": true,
                    "pageLength": 5,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true, 
                    "bAutoWidth": false,
                    "info": false,
                });
            } else {
                $("#tblErrorDetails tbody").html('<tr><td colspan="4" class="text-center">No errors found</td></tr>'); 
            }
        }
        function Close_ErrorModel() {
            $('#errorModal').modal('hide');
        }
        function downloadFileByName(event, fileName) {
            var filePathSegments = "Attachments/Task_Excel_Upload/UploadedTasksCreationFiles"
            var fileUrl = strUrl + "/" + filePathSegments + "/" + fileName;
            var tempLink = document.createElement('a');
            tempLink.href = fileUrl;
            tempLink.download = fileName;
            document.body.appendChild(tempLink);
            tempLink.click();
            document.body.removeChild(tempLink);
        }

        $("#deleteExcelBtn").click(function () {
            $("#deleteModal").modal("show");
        });
        function Close_deleteModel() {
            $("#deleteModal").modal("hide");
        }
        function DeleteRequestDetails() {
            var taskParameters = {
                RequestID: GlobalTemplateRequestID
            };
            var param = JSON.stringify(taskParameters);
            var data = AJAXCallWithResult("/api/PM_TaskExcelUpload/DeleteRequestDetails", param, false);
            alertify.success('<%=MyBase.GetResourceString("A_Deleted")%>');
            Close_deleteModel();
            $("#closeExcelBtn").click();
            GetRequestDetails();
        }
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
        //End of Added by Vishal Mane on 11/10/2025 to implement new feature Task Excel Upload for W26 version
    </script>
</body>


</html>
