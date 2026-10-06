<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_EmployeeCertiticationExcelUpload.aspx.vb" Inherits="Whizible.RM_EmployeeCertiticationExcelUpload" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Employee Certification Excel Upload")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_EmployeeCertificationExcelUpload")%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../../../Whizible2.0-new/dist/css/TimesheetEntry_custom.css?date=<%=DateTime.Now %>" rel="stylesheet" type="text/css" />
    <style>
        body, .table, h5.pgtitle {
            font-family: 'Roboto', sans-serif;
        }
        body {
            font-size: 12px !important;
        }
        .form-control, .btn, a, p, input, select.form-select {
            font-size: 12px !important;
        }
        .page-header {
            padding: 12px 14px;
            margin: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #e9ecef;
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
            margin: 4px 0 0 -42px;
            line-height: 1.4;
        }
        .card-compact {
            background: white;
            border-radius: 6px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.08);
            margin-bottom: 12px;
            padding: 10px;
        }
        .card-title {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 10px;
        }
        .download-link {
            display: inline-flex;
            align-items: center;
            color: #0d6efd;
            text-decoration: none;
            font-size: 12px;
        }
        .download-link:hover {
            text-decoration: underline;
        }
        .download-icon {
            margin-right: 4px;
            color: #0d6efd;
            width: 14px;
            height: 14px;
        }
        .disabled-link {
            pointer-events: none;
            opacity: 0.5;
            cursor: not-allowed;
            text-decoration: none;
        }
        .file-input-container {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            row-gap: 10px;
        }
        .file-input-label {
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 6px 12px;
            cursor: pointer;
            display: inline-block;
            margin-right: 8px;
            font-size: 12px;
        }
        .file-input {
            display: none !important;
        }
        .file-name {
            color: #6c757d;
            font-size: 12px;
        }
        .upload-btn {
            background-color: #0d6efd;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            cursor: pointer;
            font-weight: 400;
            font-size: 12px;
        }
        .upload-btn:hover {
            background-color: #0b5ed7;
        }
        .upload-btn:disabled {
            background-color: #97bcfa;
            cursor: not-allowed;
        }
        .alert-warning {
            background-color: #fff3cd;
            border: 1px solid #ffecb5;
            color: #664d03;
            padding: 8px 10px;
            border-radius: 4px;
            margin-bottom: 12px;
            font-size: 12px;
        }
        .skills-upload-accordion .panel.panel-default {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            margin-bottom: 12px;
            overflow: hidden;
        }
        .skills-upload-accordion .panel-heading {
            padding: 0;
            background: #f8fafc;
        }
        .skills-upload-accordion .accordion-toggle-btn {
            width: 100%;
            border: 0;
            background: transparent;
            text-align: left;
            padding: 12px 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 14px;
            font-weight: 600;
            color: #1f2937;
        }
        .skills-upload-accordion .panel-body {
            padding: 12px 14px;
            background: #fff;
        }
        .skills-upload-accordion .step1-template-top {
            display: flex;
            justify-content: center;
            margin-bottom: 14px;
        }
        .skills-upload-accordion .template-highlight {
            background: #eef4ff;
            border: 1px solid #c9dcff;
            border-radius: 8px;
            padding: 10px 16px;
        }
        .skills-upload-accordion .step1-info-columns {
            align-items: stretch;
        }
        .skills-upload-accordion .step1-default-wrap, .skills-upload-accordion .step1-instructions-wrap
        {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 10px 12px;
            height: 100%;
            font-size: 12px;
        }
        .instructions ol {
            padding-left: 18px;
            margin-bottom: 0;
        }
        .instructions li {
            margin-bottom: 3px;
        }
        .loader-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            width: 100%; height: 100%;
            background-color: transparent;
            z-index: 2000;
        }
        .loader-overlay .loader {
            position: absolute;
            top: 50%; left: 50%;
            width: 100px; height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
        .offcanvas-close-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            border: 0;
            background: transparent;
            font-size: 18px;
            /* color: #fff; */
            font-size: 11px;
        }
        .offcanvas-70 { width: 90% !important; max-width: 1200px; }
        #tbluploadedfiles th, #tbluploadedfiles td,
        #tblCertificationErrorDetails th, #tblCertificationErrorDetails td {
            font-size: 11.5px;
              padding: 8px;
        }
        .download-link-table {
            color: #0d6efd;
            text-decoration: none;
        }
        .download-link-table:hover { text-decoration: underline; }
       /* .badge-success { background-color: #198754; color: #fff; }
        .badge-danger { background-color: #dc3545; color: #fff; }*/
        .error-icon, .success-icon { margin-left: 6px; cursor: pointer; color: #2563eb; }
        .error-status { color: #dc3545; FONT-WEIGHT: bolder;}
.success-status { color: #198754;FONT-WEIGHT: bolder; }
         .badge-danger {
     background-color: #f8d7da;
     color: #842029;
 }
 .badge-success {
     background-color: #d1e7dd;
     color: #0f5132;
 }
 .badge {
     display: inline-block;
     padding: 2px 6px;
     border-radius: 8px;
     font-size: 10px;
     font-weight: 400;
 }

 .error-icon {
    color: #dc3545;
    cursor: pointer;
    margin-left: 3px;
    font-size: 14px;
}

.success-icon {
   
    cursor: pointer;
    color: #8ebea8;
    margin-left: 3px;
    font-size: 14px;
}    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">

    <div class="loader-overlay" id="loaderOverlay" style="display: none !important;">
        <div class="loader"></div>
    </div>

    <% If m_blnViewAccess = True Then %>
    <div class="container-fluid">
        <div class="graybg page-header">
            <div class="header-icon">
                <i class="fas fa-file-upload"></i>
            </div>
            <div class="header-content">
                <h5 class="page-title"><%=MyBase.GetResourceString("C_EmployeeCertificationExcelUpload")%></h5>
                <p class="page-subtitle"><%=MyBase.GetResourceString("C_PageTitleNote")%></p>
            </div>
        </div>
        <div class="clearfix"></div>
        <!--Added by Dipali V. on 03-07-2026 for excel upload feature for certification on Emp Master-->
        <div class="skills-upload-accordion panel-group mt-2" id="EmpCertExcelUploadAccordion">
            <div class="panel panel-default card card-compact">
                <div class="panel-heading">
                    <button type="button" class="accordion-toggle-btn" data-bs-toggle="collapse" data-bs-target="#CollapseEmpCertStep1" aria-expanded="true" aria-controls="CollapseEmpCertStep1">
                        <span><%=MyBase.GetResourceString("C_Step1")%></span>
                        <i class="fas fa-chevron-up personal-info-accordion-icon"></i>
                    </button>
                </div>
                <div id="CollapseEmpCertStep1" class="panel-collapse collapse show" data-bs-parent="#EmpCertExcelUploadAccordion">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-12 step1-template-top">
                                <div class="template-highlight">
                                    <a href="javascript:;"
                                       class="download-link <% If m_blnAddAccess = False Then %>disabled-link<% End If %>"
                                       id="btnDownloadCertificationTemplate"
                                       <% If m_blnViewAccess = False Then %>onclick="return false;"<% End If %>>
                                        <svg class="download-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                            <polyline points="7 10 12 15 17 10"></polyline>
                                            <line x1="12" y1="15" x2="12" y2="3"></line>
                                        </svg>
                                        <%=MyBase.GetResourceString("C_DownloadTemplate")%>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!--Added by Dipali V. on 03-07-2026 for Important Instructions and Default Upload Behaviour on Certification Excel Upload page-->
                        <div class="row step1-info-columns">
                            <div class="col-sm-6">
                                <div class="card-title"><%=MyBase.GetResourceString("C_ImportantInstructions1")%></div>
                                <div class="instructions">
                                    <ol>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note1")%></li>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note2")%></li>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note3")%></li>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note4")%></li>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note5")%></li>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note6")%></li>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note7")%></li>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note8")%></li>
                                    </ol>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="step1-default-wrap">
                                    <div class="card-title"><%=MyBase.GetResourceString("C_DefaultUploadBehaviour")%></div>
                                    <div class="instructions">
                                        <b><%=MyBase.GetResourceString("C_DefaultUploadBehaviourTitle")%></b><br />
                                        <%=MyBase.GetResourceString("C_DefaultUploadBehaviourDetails")%><br /><br />
                                        <%--<%=MyBase.GetResourceString("C_ContactAdministratorNote")%>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--End of Added by Dipali V. on 03-07-2026 for Important Instructions and Default Upload Behaviour on Certification Excel Upload page-->
                    </div>
                </div>
            </div>
            <div class="panel panel-default card card-compact">
                <div class="panel-heading">
                    <button type="button" class="accordion-toggle-btn collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseEmpCertStep2" aria-expanded="false" aria-controls="CollapseEmpCertStep2">
                        <span><%=MyBase.GetResourceString("C_Step2")%></span>
                        <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                    </button>
                </div>
                <div id="CollapseEmpCertStep2" class="panel-collapse collapse" data-bs-parent="#EmpCertExcelUploadAccordion">
                    <div class="panel-body">
                        <div class="file-input-container">
                            <div class="col-sm-4">
                                <label for="emp-cert-file-upload"
                                       class="file-input-label"
                                       <% If m_blnAddAccess = False Then %>style="pointer-events:none;opacity:0.5;"<% End If %>>
                                    <%=MyBase.GetResourceString("C_ChooseFile")%>
                                </label>
                                <input type="file"
                                       id="emp-cert-file-upload"
                                       class="file-input"
                                       accept=".xlsx,.xls"
                                       <% If m_blnAddAccess = False Then %>disabled<% End If %> />
                            </div>
                            <div class="col-sm-4">
                                <span class="file-name" id="emp-cert-file-name"><%=MyBase.GetResourceString("C_Nofilechosen")%></span>
                            </div>
                            
                                <div class="col-sm-4" style="display: flex; justify-content: flex-end;">
                                     <% If m_blnAddAccess = True Then %>
                                    <button type="button" class="upload-btn" id="emp-cert-upload-btn" disabled><%=MyBase.GetResourceString("C_Upload")%></button>
                                     <%End If %>
                                 </div>
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="alert alert-warning">
            <strong>⚠️ <%=MyBase.GetResourceString("C_Note")%></strong> <%=MyBase.GetResourceString("C_NoteDetails")%></div>
      
        <!--Added by Dipali V. on 03-07-2026 for uploaded file history grid on Certification Excel Upload page-->
        <div class="card card-compact">
            <div class="card-title"><%=MyBase.GetResourceString("C_UploadedFileDetails")%></div>
            <table class="table table-bordered table-sm" id="tbluploadedfiles">
                <thead>
                    <tr>
                        <th class="text-center"><%=MyBase.GetResourceString("C_FileName")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_UploadedDate")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_UploadedBy")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_Status")%></th>
                    </tr>
                </thead>
                <tbody id="uploadedfiles"></tbody>
            </table>
        </div>
        <!--End of Added by Dipali V. on 03-07-2026 for uploaded file history grid on Certification Excel Upload page-->
    </div>

    <!--Added by Dipali V. on 03-07-2026 for row-wise validation error details offcanvas on Certification Excel Upload page-->
    <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="true" tabindex="-1" id="offcanvas_tblCertificationErrorDetails">
         <div class="d-flex align-items-center justify-content-between font-weight-600 ml-1 bgGrey">
      <h5 class="pgtitle ml-2" style="margin-left: 10px;" ><%=MyBase.GetResourceString("C_ErrorDetails")%></h5>
      <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" onclick="HideContractDetailsCanvas();" title="Close">
          &#x2715;
      </button>
  </div>
        <div class="offcanvas-body">
            <div class="table-responsive">
                <table class="table table-bordered table-sm" id="tblCertificationErrorDetails">
                    <thead>
                        <tr>
                            <th class="text-center" style="width:6%"><%=MyBase.GetResourceString("C_RowNumber")%></th>
                            <th class="text-center" style="width:14%"><%=MyBase.GetResourceString("C_EmployeeName")%></th>
                            <th class="text-center" style="width:14%"><%=MyBase.GetResourceString("C_CertificationName")%></th>
                            <th class="text-center" style="width:12%"><%=MyBase.GetResourceString("C_CertificationDate")%></th>
                            <th class="text-center" style="width:12%"><%=MyBase.GetResourceString("C_ValidUptoDate")%></th>
                            <th class="text-center" style="width:8%"><%=MyBase.GetResourceString("C_ActualScore")%></th>
                            <th class="text-center" style="width:8%"><%=MyBase.GetResourceString("C_OutOf")%></th>
                            <th class="text-center" style="width:26%"><%=MyBase.GetResourceString("C_Response")%></th>
                        </tr>
                    </thead>
                    <tbody id="tblCertificationErrorDetailsBody"></tbody>
                </table>
            </div>
        </div>
    </div>
    <!--End of Added by Dipali V. on 03-07-2026 for row-wise validation error details offcanvas on Certification Excel Upload page-->
    <% Else %>
    <div id="ViewAccess" class="container-fluid" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess")%></p>
        </div>
    </div>
    <% End If %>
    <div class="clearfix"></div>
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.6"></script>
    <script>
        //Added by Aditya J. on 25-06-2026 for excel upload feature for Certification on Emp Master
        var apiBaseUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        apiBaseUrl = apiBaseUrl ? apiBaseUrl.replace(/\/+$/, '') : '';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var UserName = '<%= Session("strUserName") %>';
        var ViewAccess = '<%=m_blnViewAccess%>';
        var AddAccess = '<%=m_blnAddAccess%>';
        var currentPageNumber = 1;
        var currentPageSize = 5;
        var totalPages = 1;
        var totalRecords = 0;

        //Added by Dipali V. on 06-07-2026 for common W26 API ajax helper (JSON, blob, and FormData)
        function AJAXCallWithResult(url, param, async, options) {
            options = options || {};
            var result = null;
            var normalizedUrl = (url || "").replace(/^\//, "");
            var fullUrl = apiBaseUrl.endsWith('/') ? apiBaseUrl + normalizedUrl : apiBaseUrl + '/' + normalizedUrl;
            var isFormData = (typeof FormData !== 'undefined') && param instanceof FormData;
            var settings = {
                url: fullUrl,
                type: "POST",
                async: async !== false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param && !isFormData && typeof encryptString === 'function' && typeof isJson === 'function') {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data, textStatus, jqXHR) {
                    result = data;
                    if (typeof options.success === 'function') {
                        options.success(data, textStatus, jqXHR);
                    }
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Authentication failed.');
                    } else if (xhr.responseJSON && xhr.responseJSON.Message === "Authorization has been denied for this request.") {
                        window.open("../../../Default.aspx", "_top");
                    } else if (typeof options.error === 'function') {
                        options.error(xhr, status, error);
                    } else {
                        alert('API error: ' + error);
                    }
                },
                complete: function () {
                    if (typeof options.complete === 'function') {
                        options.complete();
                    }
                }
            };

            if (isFormData) {
                settings.data = param;
                settings.contentType = false;
                settings.processData = false;
                if (options.dataType) {
                    settings.dataType = options.dataType;
                }
            } else {
                settings.data = (param == null) ? null : (typeof param === 'string' ? param : JSON.stringify(param));
                settings.contentType = "application/json;charset=utf-8";
                if (options.responseType) {
                    settings.xhrFields = { responseType: options.responseType };
                } else {
                    settings.dataType = "json";
                }
            }

            $.ajax(settings);
            return result;
        }
        //End of Added by Dipali V. on 06-07-2026 for common W26 API ajax helper (JSON, blob, and FormData)

        $(document).ready(function () {
            if (ViewAccess === "True") {
                InitEmpCertExcelUploadUI();
                //Added by Dipali V. on 03-07-2026 for loading upload history on Certification Excel Upload page load
                GetCertificationRequestDetails(currentPageNumber, currentPageSize);
            }
        });

        function InitEmpCertExcelUploadUI() {
            $("#btnDownloadCertificationTemplate").off("click").on("click", function (e) {
                e.preventDefault();
                if (AddAccess !== "True") return;
                DownloadCertificationTemplateFile();
            });

            $("#emp-cert-file-upload").off("change").on("change", function () {
                var file = this.files && this.files.length ? this.files[0] : null;
                EmpCertProcessSelectedFile(file);
            });

            $("#emp-cert-upload-btn").off("click").on("click", function () {
                UploadCertificationExcelFile();
            });

            $("#EmpCertExcelUploadAccordion .panel-collapse").on("show.bs.collapse", function () {
                var $btn = $(this).prev(".panel-heading").find(".accordion-toggle-btn");
                $btn.removeClass("collapsed").attr("aria-expanded", "true");
                $btn.find("i").removeClass("fa-chevron-down").addClass("fa-chevron-up");
            });

            $("#EmpCertExcelUploadAccordion .panel-collapse").on("hide.bs.collapse", function () {
                var $btn = $(this).prev(".panel-heading").find(".accordion-toggle-btn");
                $btn.addClass("collapsed").attr("aria-expanded", "false");
                $btn.find("i").removeClass("fa-chevron-up").addClass("fa-chevron-down");
            });
        }

        function EmpCertProcessSelectedFile(file) {
            var $uploadBtn = $("#emp-cert-upload-btn");
            if (!file) {
                $("#emp-cert-file-name").text('<%=MyBase.GetResourceString("C_Nofilechosen")%>');
                $uploadBtn.prop("disabled", true);
                return;
            }

            var extension = "." + file.name.split(".").pop().toLowerCase();
            if (extension !== ".xlsx" && extension !== ".xls") {
                alertify.set("notifier", "position", "top-right");
                alertify.error('<%=MyBase.GetResourceString("A_RestrictFiles")%>');
                $("#emp-cert-file-upload").val("");
                $("#emp-cert-file-name").text('<%=MyBase.GetResourceString("C_Nofilechosen")%>');
                $uploadBtn.prop("disabled", true);
                return;
            }

            $("#emp-cert-file-name").text(file.name);
            $uploadBtn.prop("disabled", false);
        }

        function DownloadCertificationTemplateFile() {
            showCertificationExcelLoader();
            AJAXCallWithResult("api/RM_CertificationExcelUpload/DownloadCertificationTemplate", null, true, {
                responseType: "blob",
                success: function (data, status, xhr) {
                    var fileName = "CertificationTemplate.xlsx";
                    var disposition = xhr.getResponseHeader("Content-Disposition");
                    if (disposition && disposition.indexOf("filename=") !== -1) {
                        var matches = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/.exec(disposition);
                        if (matches != null && matches[1]) {
                            fileName = matches[1].replace(/['"]/g, "");
                        }
                    }
                    var blob = new Blob([data], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                    var url = window.URL.createObjectURL(blob);
                    var link = document.createElement("a");
                    link.href = url;
                    link.download = fileName;
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                    window.URL.revokeObjectURL(url);
                },
                error: function () {
                    alertify.set("notifier", "position", "top-right");
                    alertify.error('<%=MyBase.GetResourceString("A_DownloadFailed")%>');
                },
                complete: function () {
                    hideCertificationExcelLoader();
                }
            });
        }

        function CertificationExcelFormatErrorMessage(errorMsg) {
            //Added by Dipali V. on 03-07-2026 for formatting API upload error messages on Certification Excel Upload page
            if (!errorMsg) return "";
            var arrData = String(errorMsg).split("$");
            if (arrData.length > 1 && (arrData[0] === "0" || arrData[0] === "D")) {
                return arrData.slice(1).join("$").trim();
            }
            return String(errorMsg).replace(/^[0D]\$/, "").trim();
        }

        function UploadCertificationExcelFile() {
            var files = $("#emp-cert-file-upload").get(0).files;
            if (!files || files.length === 0) {
                alertify.set("notifier", "position", "top-right");
                alertify.error('<%=MyBase.GetResourceString("A_SelectFileToUpload")%>');
                return;
            }

            var formData = new FormData();
            formData.append("UploadedFile", files[0]);
            formData.append("UserName", UserName);
            formData.append("intEmployeeID", SessionEmployeeId);

            showCertificationExcelLoader();
            AJAXCallWithResult("api/RM_CertificationExcelUpload/CertificationExcelUpload", formData, true, {
                dataType: "json",
                success: function (result) {
                    $("#emp-cert-file-upload").val("");
                    $("#emp-cert-file-name").text('<%=MyBase.GetResourceString("C_Nofilechosen")%>');
                    $("#emp-cert-upload-btn").prop("disabled", true);

                    alertify.set("notifier", "position", "top-right");

                    //Added by Dipali V. on 03-07-2026 for upload response handling aligned with Skills Excel Upload page
                    var arrData = String(result && result.errorMessages != null ? result.errorMessages : "").split("$");
                    if (arrData.some(function (item) {
                        return (item || "").toLowerCase().indexOf("invalid template") >= 0
                            || (item || "").toLowerCase().indexOf("excel is empty") >= 0;
                    })) {
                        alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                        return;
                    }
                    else if (arrData.some(function (item) {
                        return (item || "").toLowerCase().indexOf("maximum 100 records") >= 0
                            || (item || "").toLowerCase().indexOf("can be uploaded in a single file.") >= 0;
                    })) {
                        alertify.error('<%=MyBase.GetResourceString("A_MaxRecords")%>');
                        return;
                    }
                    else if (arrData[0] === "D") {
                        alertify.error(CertificationExcelFormatErrorMessage(result.errorMessages));
                        return;
                    }
                    else {
                        alertify.success('<%=MyBase.GetResourceString("A_FileUploaded")%>');
                    }

                    currentPageNumber = 1;
                    GetCertificationRequestDetails(currentPageNumber, currentPageSize);
                    //End of Added by Dipali V. on 03-07-2026 for upload response handling aligned with Skills Excel Upload page
                },
                error: function (xhr) {
                    alertify.set("notifier", "position", "top-right");
                    alertify.error((xhr.responseJSON && xhr.responseJSON.Message) ? xhr.responseJSON.Message : '<%=MyBase.GetResourceString("A_UploadFailed")%>');
                },
                complete: function () {
                    hideCertificationExcelLoader();
                }
            });
        }

        function showCertificationExcelLoader() {
            document.getElementById("loaderOverlay").style.display = "block";
        }

        function hideCertificationExcelLoader() {
            document.getElementById("loaderOverlay").style.display = "none";
        }

        //Added by Dipali V. on 03-07-2026 for upload history listing with pagination on Certification Excel Upload page
        function GetCertificationRequestDetails(pageNumber, pageSize) {
            pageNumber = pageNumber || 1;
            pageSize = pageSize || 5;
            showCertificationExcelLoader();
            var response = AJAXCallWithResult("api/RM_CertificationExcelUpload/GetCertificationRequestDetails", {
                intEmployeeID: parseInt(SessionEmployeeId, 10) || 0,
                pageNumber: pageNumber,
                pageSize: pageSize
            }, false, {
                error: function () {
                    alertify.set("notifier", "position", "top-right");
                    alertify.error('<%=MyBase.GetResourceString("A_UploadFailed")%>');
                },
                complete: function () {
                    hideCertificationExcelLoader();
                }
            });

            var tableBody = $("#tbluploadedfiles tbody");
            if ($.fn.DataTable && $.fn.DataTable.isDataTable("#tbluploadedfiles")) {
                $("#tbluploadedfiles").DataTable().clear().destroy();
            }
            tableBody.empty();
            if (!response) {
                tableBody.html('<tr><td colspan="4" class="text-center">No data available in table</td></tr>');
                $("#customCertificationPaginationControls").hide();
                return;
            }

            var payload = (response && response.data) ? response.data : {};
            var data = payload.CertificationRequestEntity || payload.certificationRequestEntity || [];
            var paginationData = (payload.PaginationEntity_Certification && payload.PaginationEntity_Certification[0])
                || (payload.paginationEntity_Certification && payload.paginationEntity_Certification[0])
                || {};
            currentPageNumber = paginationData.currentPage || paginationData.CurrentPage || 1;
            currentPageSize = paginationData.pageSize || paginationData.PageSize || 5;
            totalPages = paginationData.totalPages || paginationData.TotalPages || 1;
            totalRecords = paginationData.totalRecords || paginationData.TotalRecords || 0;
            if (data && data.length > 0) {
                $.each(data, function (index, file) {
                    var statusBadge = "";
                    if (file.status === "Invalid" || file.Status === "Invalid" || file.status === "Failed" || file.Status === "Failed") {
                        statusBadge = '<td class="text-center"><span class="badge badge-danger">Invalid File</span>' +
                            '<i class="fas fa-info-circle error-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Error Details" onclick="ShowCertificationErrorValidation(' + (file.requestID || file.RequestID) + ',0);"></i></td>';
                    } else if (file.status === "Successful" || file.Status === "Successful" || file.status === "Success" || file.Status === "Success") {
                        statusBadge = '<td class="text-center"><span class="badge badge-success">Successful</span>' +
                            '<i class="fas fa-info-circle success-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Success Details"  onclick="ShowCertificationErrorValidation(' + (file.requestID || file.RequestID) + ',1);"></i></td>';
                    } else if (file.status === "Partially Successful" || file.Status === "Partially Successful") {
                        statusBadge = '<td class="text-center"><span class="badge badge-success">Partially Successful</span>' +
                            '<i class="fas fa-info-circle success-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Success Details" onclick="ShowCertificationErrorValidation(' + (file.requestID || file.RequestID) + ',1);"></i></td>';
                    } else {
                        statusBadge = '<td class="text-center"><span class="badge badge-danger">' + (file.status || file.Status || "Invalid File") + '</span>' +
                            '<i class="fas fa-info-circle error-icon" title="Show Error Details" onclick="ShowCertificationErrorValidation(' + (file.requestID || file.RequestID) + ',0);"></i></td>';
                    }
                    var fileName = file.fileName || file.FileName || "";
                    var uploadedDate = file.uploadedDate || file.UploadedDate || "";
                    var uploadedBy = file.uploadedBy || file.UploadedBy || "";
                    tableBody.append(
                        '<tr>' +
                        '<td class="text-center"><a href="#" onclick="downloadCertificationUploadedFile(event, \'' + fileName.replace(/'/g, "\\'") + '\')" class="download-link-table">' + fileName + '</a></td>' +
                        '<td class="text-center">' + uploadedDate + '</td>' +
                        '<td class="text-center">' + uploadedBy + '</td>' +
                        statusBadge +
                        '</tr>'
                    );
                });
                if ($.fn.DataTable) {
                    $("#tbluploadedfiles").DataTable({
                        paging: false,
                        bLengthChange: false,
                        bFilter: false,
                        ordering: false,
                        responsive: true,
                        destroy: true,
                        bAutoWidth: false,
                        info: false
                    });
                }
                RenderCertificationPaginationControls();
                $('[data-bs-toggle="tooltip"]').tooltip();
            } else {
                tableBody.html('<tr><td colspan="4" class="text-center">No data available in table</td></tr>');
                $("#customCertificationPaginationControls").hide();
            }
        }

        function RenderCertificationPaginationControls() {
            //Added by Dipali V. on 03-07-2026 for pagination controls on Certification Excel upload history grid
            var paginationHtml = '';
            if ($("#customCertificationPaginationControls").length === 0) {
                $("#tbluploadedfiles").after('<div id="customCertificationPaginationControls" class="d-flex justify-content-end align-items-center mt-2"></div>');
            }
            paginationHtml += '<div class="me-3">Total Records: ' + totalRecords + '</div><div class="btn-group">';
            if (currentPageNumber > 1) {
                paginationHtml += '<button class="btn btn-light border" onclick="NavigateCertificationToPage(' + (currentPageNumber - 1) + ')">&laquo;</button>';
            } else {
                paginationHtml += '<button class="btn btn-light border" disabled>&laquo;</button>';
            }
            if (currentPageNumber < totalPages) {
                paginationHtml += '<button class="btn btn-light border" onclick="NavigateCertificationToPage(' + (currentPageNumber + 1) + ')">&raquo;</button>';
            } else {
                paginationHtml += '<button class="btn btn-light border" disabled>&raquo;</button>';
            }
            paginationHtml += '</div>';
            $("#customCertificationPaginationControls").html(paginationHtml).show();
        }

        function NavigateCertificationToPage(pageNumber) {
            //Added by Dipali V. on 03-07-2026 for navigating Certification Excel upload history pages
            if (pageNumber >= 1 && pageNumber <= totalPages && pageNumber !== currentPageNumber) {
                GetCertificationRequestDetails(pageNumber, currentPageSize);
            }
        }

        //Added by Dipali V. on 03-07-2026 for re-downloading previously uploaded Certification Excel files
        function downloadCertificationUploadedFile(event, fileName) {
            event.preventDefault();
            if (!fileName) return;
            showCertificationExcelLoader();
            AJAXCallWithResult("api/RM_CertificationExcelUpload/DownloadUploadedFile", { fileName: fileName }, true, {
                responseType: "arraybuffer",
                success: function (data, status, xhr) {
                    var contentType = xhr.getResponseHeader("Content-Type");
                    var blob = new Blob([data], { type: contentType || "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                    var url = window.URL.createObjectURL(blob);
                    var tempLink = document.createElement("a");
                    tempLink.href = url;
                    tempLink.download = fileName;
                    document.body.appendChild(tempLink);
                    tempLink.click();
                    document.body.removeChild(tempLink);
                    window.URL.revokeObjectURL(url);
                },
                error: function () {
                    alertify.set("notifier", "position", "top-right");
                    alertify.error('<%=MyBase.GetResourceString("A_DownloadFailed")%>');
                },
                complete: function () {
                    hideCertificationExcelLoader();
                }
            });
        }

        //Added by Dipali V. on 03-07-2026 for displaying row-wise validation details in offcanvas on Certification Excel Upload page
        function ShowCertificationErrorValidation(requestId, flag) {
            showCertificationExcelLoader();
            var offcanvasElement = document.getElementById("offcanvas_tblCertificationErrorDetails");
            var offcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasElement);
            offcanvas.show();
            var response = AJAXCallWithResult("api/RM_CertificationExcelUpload/GetCertificationErrorValidation", { RequestID: requestId }, false, {
                error: function () {
                    alertify.set("notifier", "position", "top-right");
                    alertify.error('<%=MyBase.GetResourceString("A_UploadFailed")%>');
                },
                complete: function () {
                    hideCertificationExcelLoader();
                }
            });

            var data = response;
            if (typeof response === "string") {
                try { data = JSON.parse(response); } catch (e) { data = []; }
            } else if (response && response.data) {
                data = typeof response.data === "string" ? JSON.parse(response.data) : response.data;
            }
            var tableBody = $("#tblCertificationErrorDetails tbody");
            if ($.fn.DataTable && $.fn.DataTable.isDataTable("#tblCertificationErrorDetails")) {
                $("#tblCertificationErrorDetails").DataTable().clear().destroy();
            }
            tableBody.empty();
            if (data && data.length > 0) {
                $.each(data, function (index, error) {
                    var responseText = error.ErrorMessages || error.errorMessages || error.ErrorMessage || error.errorMessage || "";
                    var responseCell = (flag === 1 && (error.IsValid === 1 || error.isValid === 1) && (error.IsSaved === 1 || error.isSaved === 1))
                        ? '<span class="success-status">Successful</span>'
                        : '<span class="error-status">' + responseText + '</span>';
                    tableBody.append(
                        '<tr>' +
                        '<td class="text-center">' + (error.RowNumber || error.rowNumber || "") + '</td>' +
                        '<td class="text-center">' + (error.EmployeeName || error.employeeName || "") + '</td>' +
                        '<td class="text-center">' + (error.CertificationName || error.certificationName || "") + '</td>' +
                        '<td class="text-center">' + (error.CertificationDate || error.certificationDate || "") + '</td>' +
                        '<td class="text-center">' + (error.ValidUpto || error.validUpto || "") + '</td>' +
                        '<td class="text-center">' + (error.ActualScore || error.actualScore || "") + '</td>' +
                        '<td class="text-center">' + (error.TotalScore || error.totalScore || "") + '</td>' +
                        '<td class="text-start">' + responseCell + '</td>' +
                        '</tr>'
                    );
                });
            } else {
                tableBody.html('<tr><td colspan="8" class="text-center">No validation details found</td></tr>');
            }
        }
        //End of //Added by Aditya J. on 25-06-2026 for excel upload feature for Certification on Emp Master
    </script>
</body>
</html>

