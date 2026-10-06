<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_EmployeeSkillsUpload.aspx.vb" Inherits="Whizible.RM_EmployeeSkillsUpload" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Employee Skills Bulk Upload")%>
<head>   
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_EmployeeSkillsBulkUpload")%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../../../Whizible2.0-new/dist/css/TimesheetEntry_custom.css?date=<%=DateTime.Now %>" rel="stylesheet" type="text/css" />
    <style>
        .notes-tooltip {
            cursor: pointer;
            display: inline-block;
            max-width: 250px;

            white-space: normal;          /* ✅ allow  wrapping */
            word-break: break-word;       /* ✅ break long words */

            display: -webkit-box;
            -webkit-line-clamp: 2;        /* ✅ limit to 2 lines */
            -webkit-box-orient: vertical;

            overflow: hidden;
        }

        body,
        .table,
        h5.pgtitle {
            font-family: 'Roboto', sans-serif;
        }
        h5.pgtitle {
            margin: 12px;
            font-weight: 600;
            color: #2563eb;
            font-size: 16px;
        }


        body {
            font-size: 12px !important;
                }
                .form-control, .btn, a, p, input, select.form-select {
            font-size: 12px !important;
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

       .success-status {
            color: green; /* Or #008000 */
            font-weight: bold;
        }
       .error-status {
            color: red;
            font-weight: bold;
        }
        .headerEU {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 1px solid #eee;
        }
        .headerEU h1 {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 0;
        }
        .back-link {
            color: #0d6efd;
            text-decoration: none;
            display: flex;
            align-items: center;
            font-size: 12px;
        }
        .back-link:hover {
            text-decoration: underline;
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
        .instructions {
            margin-bottom: 8px;
            font-size: 12px;
        }
        .instructions ol {
            padding-left: 18px;
            margin-bottom: 0;
        }
        .instructions li {
            margin-bottom: 3px;
        }
        .download-link {
            display: inline-flex;
            align-items: center;
            color: #0d6efd;
            text-decoration: none;
            font-weight: 400;
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
        .upload-container {
            margin-top: 10px;
        }
        .file-input-container {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
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
            transition: background-color 0.2s;
        }
        .upload-btn:hover {
            background-color: #0b5ed7;
        }
        .upload-btn:disabled {
            background-color: #97bcfa;
            cursor: not-allowed;
        }
        .alert {
            padding: 8px 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 12px;
        }
        .alert-warning {
            background-color: #fff3cd;
            border: 1px solid #ffecb5;
            color: #664d03;
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
        #tbluploadedfiles th,
        #tbluploadedfiles td {
            padding: 8px;
            font-size: 12px;
        }
        .new-large-modal .modal-dialog {
            width: 80%;
            max-width: 900px; /* Optional: Set a maximum width */
        }
        .custmodal .modal-content .modal-header .close {
            background-color: transparent;
        }       

        /*This style section refers to Unauthorized div added by Vishal Mane on 03/10/2025 */
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

        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 0.75rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(226, 232, 240, 0.8);
            /* padding: 2rem; */
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
            font-size: 0.875rem;
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
            font-size: 0.875rem;
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

        /*.dataTables_info {
            margin: 0 !important;
            padding: 0 !important;
        }

        .dataTables_paginate {
            margin: 0 !important;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button {
            padding: 2px 8px;
            border: 1px solid #ccc;
            margin-left: 4px;
            border-radius: 4px;
        }*/

        .dataTables_wrapper .top {
            display: none !important;
        }

        .dataTables_wrapper {
            padding-top: 0 !important;
        }

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

        .disabled-link {
            pointer-events: none;
            opacity: 0.5;
            cursor: not-allowed;
            text-decoration: none;
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

        .skills-upload-accordion .step1-download-wrap {
            display: flex;
            align-items: center;
            min-height: 120px;
            justify-content: center;
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

        .skills-upload-accordion .step1-default-wrap {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 10px 12px;
            height: 100%;
        }

        .skills-upload-accordion .step1-default-wrap .card-title {
            margin-bottom: 8px;
        }

        .skills-upload-accordion .step1-instructions-wrap .card-title {
            margin-bottom: 8px;
        }

        .skills-upload-accordion .file-input-container {
            margin-bottom: 0;
            row-gap: 10px;
        }

        .skills-upload-accordion .upload-container {
            margin-top: 0;
        }

        @media (max-width: 767px) {
            .skills-upload-accordion .step1-download-wrap {
                min-height: auto;
                justify-content: flex-start;
                margin-bottom: 12px;
            }

            .skills-upload-accordion .step1-template-top {
                justify-content: flex-start;
            }

            .skills-upload-accordion .file-input-container {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        /*End of This style section refers to Unauthorized div added by Vishal Mane on 03/10/2025 */
    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">

    <!-- Page Loader -->
    <%--<div id="PMDocsSec" class="preloader"></div>--%>
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
                <h5 class="page-title"><%=MyBase.GetResourceString("C_EmployeeSkillsBulkUpload")%></h5>
                <p class="page-subtitle"><%=MyBase.GetResourceString("C_PageTitleNote")%></p>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="skills-upload-accordion panel-group mt-2" id="SkillsUploadAccordion">
            <div class="panel panel-default card card-compact">
                <div class="panel-heading">
                    <button type="button" class="accordion-toggle-btn" data-bs-toggle="collapse" data-bs-target="#CollapseSkillsStep1" aria-expanded="true" aria-controls="CollapseSkillsStep1">
                        <span><%=MyBase.GetResourceString("C_Step1")%></span>
                        <i class="fas fa-chevron-up personal-info-accordion-icon"></i>
                    </button>
                </div>
                <div id="CollapseSkillsStep1" class="panel-collapse collapse show" data-bs-parent="#SkillsUploadAccordion">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-12 step1-template-top">
                                <div class="template-highlight">
                                    <a href="#"
                                       class="download-link <% If m_blnAddAccess = False Then %>disabled-link<% End If %>"
                                       id="btnGenerateFile"
                                       <% If m_blnViewAccess = False Then %>onclick="return false;"<% End If %>>
                                        <svg class="download-icon" width="16" height="16" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                            <polyline points="7 10 12 15 17 10"></polyline>
                                            <line x1="12" y1="15" x2="12" y2="3"></line>
                                        </svg>
                                        <%=MyBase.GetResourceString("C_DownloadTemplate")%>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="row step1-info-columns">
                            <div class="col-sm-6 step1-instructions-wrap">
                                <div class="card-title"><%=MyBase.GetResourceString("C_ImportantInstructions1")%></div>
                                <div class="instructions">
                                    <ol>
                                        <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note2")%></li>
                                        <li style="list-style-type: decimal !important;">
                                            <%=MyBase.GetResourceString("C_Note1")%>
                                        </li>
                                    </ol>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="step1-default-wrap">
                                    <div class="card-title">Default Upload Behaviour</div>
                                    <div class="instructions">
                                        <b>Experience is added, not replaced</b><br />
                                        Uploaded experience will be added to the existing value for each resource. Existing data will not be
                                        overwritten.<br /><br />

                                        <b>Only valid rows are processed</b><br />
                                        Records with valid data will be uploaded successfully. Rows with errors will be skipped and reported for
                                        correction.<br /><br />

                                        <b>Experience cannot be reduced</b><br />
                                        Uploads cannot decrease or downgrade existing experience levels.<br /><br />

                                        If you require changes to these default settings, please contact your administrator.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default card card-compact">
                <div class="panel-heading">
                    <button type="button" class="accordion-toggle-btn collapsed" data-bs-toggle="collapse" data-bs-target="#CollapseSkillsStep2" aria-expanded="false" aria-controls="CollapseSkillsStep2">
                        <span><%=MyBase.GetResourceString("C_Step2")%></span>
                        <i class="fas fa-chevron-down personal-info-accordion-icon"></i>
                    </button>
                </div>
                <div id="CollapseSkillsStep2" class="panel-collapse collapse" data-bs-parent="#SkillsUploadAccordion">
                    <div class="panel-body">
                        <div class="upload-container">
                            <div class="row">
                                <div class="file-input-container">
                                    <div class="col-sm-4">
                                        <div class="drop-zone <% If m_blnAddAccess = False Then %>disabled-zone<% End If %>" id="drop-zone">
                                            <label for="file-upload"
                                                   class="file-input-label"
                                                   <% If m_blnViewAccess = False Then %>onclick="return false;"<% End If %>>
                                                <%=MyBase.GetResourceString("C_ChooseFile")%>
                                            </label>
                                            <input type="file"
                                                   id="file-upload"
                                                   class="file-input"
                                                   accept=".xlsx, .xls"
                                                   <% If m_blnAddAccess = False Then %>disabled<% End If %>>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <span class="file-name" id="file-name"><%=MyBase.GetResourceString("C_Nofilechosen")%></span>
                                    </div>
                                    <div class="col-sm-4" style="display: flex; justify-content: flex-end;">
                                        <button class="upload-btn" id="upload-btn" disabled onclick="uploadDocBtn()"><%=MyBase.GetResourceString("C_Upload")%></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="alert alert-warning">
            <strong>⚠️ <%=MyBase.GetResourceString("C_Note")%></strong> <%=MyBase.GetResourceString("C_NoteDetails")%></div>
        <div class="card card-compact">
            <div class="card-title"><%=MyBase.GetResourceString("C_UploadedFileDetails")%></div>
            <table class="table table-bordered table-sm" id="tbluploadedfiles">
                <thead>
                    <tr>
                        <!-- <th class="text-center"><%=MyBase.GetResourceString("C_SrNo")%></th> -->
                        <th class="text-center"><%=MyBase.GetResourceString("C_FileName")%></th>
                        <%--<th class="text-center"><%=MyBase.GetResourceString("C_TimesheetWeek1")%></th>--%>
                        <th class="text-center"><%=MyBase.GetResourceString("C_UploadedDate")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_UploadedBy")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_Status")%></th>
                    </tr>
                </thead>
                <tbody id="uploadedfiles">
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="true" tabindex="-1" id="offcanvas_tblErrorDetails">
        <div class="d-flex align-items-center justify-content-between font-weight-600 ml-1 bgGrey">
            <h5 class="pgtitle ml-2"><%=MyBase.GetResourceString("C_ErrorDetails")%></h5>
            <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" onclick="HideContractDetailsCanvas();" title="Close">
                &#x2715;
            </button>
        </div>
        <div class="offcanvas-body">
            <div class="table-responsive">
                <%--<table class="table" id="tblErrorDetails">--%>
                <table class="table table-bordered table-sm" id="tblErrorDetails">
                    <thead>
                        <tr>
                            <%--<th class="text-center"><%=MyBase.GetResourceString("C_EmployeeName")%></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_SkillName")%></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_ExperienceYears")%></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_ExperienceMonths")%></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_Proficiency")%></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_CoreCompetency")%></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_Notes")%></th>
                            <th class="text-center"><%=MyBase.GetResourceString("C_Response")%></th>--%>

                            <th class="text-center" style="width:10%">Row Number</th>
                            <th class="text-center" style="width:15%"><%=MyBase.GetResourceString("C_EmployeeName")%></th>
                            <th class="text-center" style="width:15%"><%=MyBase.GetResourceString("C_SkillName")%></th>
                            <th class="text-center" style="width:5%"><%=MyBase.GetResourceString("C_ExperienceYears")%></th>
                            <th class="text-center" style="width:5%"><%=MyBase.GetResourceString("C_ExperienceMonths")%></th>
                            <th class="text-center" style="width:10%"><%=MyBase.GetResourceString("C_Proficiency")%></th>
                            <th class="text-center" style="width:10%"><%=MyBase.GetResourceString("C_CoreCompetency")%></th>
                            <th class="text-center" style="width:15%">Notes</th>
                            <th class="text-center" style="width:15%">Response</th>
                            
                        </tr>
                    </thead>
                    <tbody id="tblErrorDetailsBody">
                    </tbody>
                </table>
            </div>
            <br>
            <div class="clearfix"></div>
            <div class="text-center">
            </div>
        </div>
    </div>

    <!--Excel generation confirmation Modal Added by Vishal Mane on 25/09/2025 -->
        <div id="ExcelValidationMessageModalinfo" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="btnExcelValidationMessage" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
                    </div>
                    <div class="modal-body">
                        <span class="sm_txt" id="txtExcelValidationMessage"></span>
                    </div>
                    <div class="modal-footer" style="display: flex; justify-content: space-between;">
                        <button class="btn btn-success me-2" id="btnExcelYes" onclick="DownLoadTemplateUpdated()"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <button class="btn btn-danger" data-bs-dismiss="modal" id="btnExcelNo"><%=MyBase.GetResourceString("C_No")%></button>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
     <!--End of Excel generation confirmation Modal Added by Vishal Mane on 25/09/2025 -->
    <% Else %>
    <div id="ViewAccess" class="container-fluid" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %> </p>
        </div>       
    </div>
    <% End If %>
    <div class="clearfix"></div>   
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.6"></script>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPickerNew.js?date=<%=DateTime.Now %>"></script>
    
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';   // Normalize base URL (remove trailing slash)
        strUrl = strUrl ? strUrl.replace(/\/+$/, '') : '';        
        var ConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
        var startingDayOfWeek;
        var FinancialYearStart;
        var TodaysDate;
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var EmployeeID = SessionEmployeeId;
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';

        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var AddAccess = '<%=m_blnViewAccess%>';

        var currentPageNumber = 1;
        var currentPageSize = 5;
        var totalPages = 1;
        var totalRecords = 0;

        

        $(document).on('keydown', '.edtTimeInput', function (event) {
            const $currentInput = $(this);
            const currentRow = parseInt($currentInput.attr('data-row'));
            const currentCol = parseInt($currentInput.attr('data-col'));

            if (event.key === "ArrowDown") {
                const $nextInput = $(`.edtTimeInput[data-row="${currentRow + 1}"][data-col="${currentCol}"]`);
                if ($nextInput.length) {
                    $nextInput.focus();
                    event.preventDefault();
                }
            } else if (event.key === "ArrowUp") {
                const $prevInput = $(`.edtTimeInput[data-row="${currentRow - 1}"][data-col="${currentCol}"]`);
                if ($prevInput.length) {
                    $prevInput.focus();
                    event.preventDefault();
                }
            } else if (event.key === "ArrowRight") {
                const $nextInput = $(`.edtTimeInput[data-row="${currentRow}"][data-col="${currentCol + 1}"]`);
                if ($nextInput.length) {
                    $nextInput.focus();
                    event.preventDefault();
                }
            } else if (event.key === "ArrowLeft") {
                const $prevInput = $(`.edtTimeInput[data-row="${currentRow}"][data-col="${currentCol - 1}"]`);
                if ($prevInput.length) {
                    $prevInput.focus();
                    event.preventDefault();
                }
            }
        });

        
        var ProxyUsersCount = 0;
        $(document).ready(function () {            
            GetRequestDetails(currentPageNumber, currentPageSize);
        });

        document.addEventListener('DOMContentLoaded', function () {
            const dropZone = document.getElementById('drop-zone');
            const fileInput = document.getElementById('file-upload');
            const fileName = document.getElementById('file-name');
            const uploadBtn = document.getElementById('upload-btn');
            const uploadedFiles = document.getElementById('uploadedfiles');
            const downloadTemplate = document.getElementById('download-template');
            // Handle drag and drop
            dropZone.addEventListener('dragover', handleDragOver);
            dropZone.addEventListener('dragleave', handleDragLeave);
            dropZone.addEventListener('drop', handleDrop);
            // Handle file selection
            fileInput.addEventListener('change', handleFileSelect);
            function handleDragOver(event) {
                event.preventDefault();
                event.stopPropagation();
                dropZone.classList.add('dragover');
            }
            function handleDragLeave(event) {
                event.preventDefault();
                event.stopPropagation();
                dropZone.classList.remove('dragover');
            }
            function handleDrop(event) {
                event.preventDefault();
                event.stopPropagation();
                dropZone.classList.remove('dragover');
                const file = event.dataTransfer.files[0];
                processFile(file);
            }
            function handleFileSelect(event) {
                //debugger
                const file = event.target.files[0];
                processFile(file);
            }
            function processFile(file) {
                if (file) {
                    // Check if it's an Excel file
                    const validTypes = ['.xlsx', '.xls'];
                    const fileExtension = '.' + file.name.split('.').pop().toLowerCase();
                    if (!validTypes.includes(fileExtension)) {
                        alertify.error('<%=MyBase.GetResourceString("A_RestrictFiles")%>');
                        fileInput.value = '';
                        fileName.textContent = 'No file chosen';
                        uploadBtn.disabled = true;
                        return;
                    }
                    // Check file size (5MB max)
                    if (file.size > 5 * 1024 * 1024) {
                        //alert('File size exceeds 5MB limit!');
                        //showAlert("File size exceeds 5MB limit!", "alert-danger");
                        alertify.error('<%=MyBase.GetResourceString("A_RestrictFileSize")%>');
                        fileInput.value = '';
                        fileName.textContent = '<%=MyBase.GetResourceString("C_Nofilechosen")%>';
                        uploadBtn.disabled = true;
                        return;
                    }
                    fileName.textContent = file.name;
                    uploadBtn.disabled = false;
                } else {
                    fileName.textContent = '<%=MyBase.GetResourceString("C_Nofilechosen")%>';
                    uploadBtn.disabled = true;
                }
            }
        });

        // Function to handle the initial button click and show the confirmation modal
        $(document).ready(function () {
            $("#btnGenerateFile").on('click', function (e) {
                DownLoadTemplateUpdated();
            });

            $('#SkillsUploadAccordion .panel-collapse').on('show.bs.collapse', function () {
                var $btn = $(this).prev('.panel-heading').find('.accordion-toggle-btn');
                $btn.removeClass('collapsed').attr('aria-expanded', 'true');
                $btn.find('i').removeClass('fa-chevron-down').addClass('fa-chevron-up');
            });

            $('#SkillsUploadAccordion .panel-collapse').on('hide.bs.collapse', function () {
                var $btn = $(this).prev('.panel-heading').find('.accordion-toggle-btn');
                $btn.addClass('collapsed').attr('aria-expanded', 'false');
                $btn.find('i').removeClass('fa-chevron-up').addClass('fa-chevron-down');
            });
        });
        
        function DownLoadTemplateUpdated() {
            //debugger;
            showLoader();
            var taskParameters = {
                intEmployeeID: SessionEmployeeId,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
            };
            $.ajax({
                url: strUrl + '/api/EmployeeSkillsBulkUpload/DownloadSkillsTemplate',
                type: "POST",
                data: JSON.stringify(taskParameters),
                contentType: "application/json;charset=utf-8",
                xhrFields: {
                    responseType: 'blob'  // Important for file download
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (data, status, xhr) {
                    var disposition = xhr.getResponseHeader('Content-Disposition');
                    var fileName = 'EmployeeSkills.xlsx';
                    console.log('Content-Disposition:', xhr.getResponseHeader('Content-Disposition'));
                    console.log('All headers:', xhr.getAllResponseHeaders());
                    if (disposition && disposition.indexOf('filename=') !== -1) {
                        var matches = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/.exec(disposition);
                        if (matches != null && matches[1]) {
                            fileName = matches[1].replace(/['"]/g, '');
                        }
                    }
                    // Create blob and download
                    var blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
                    var url = window.URL.createObjectURL(blob);

                    var tempLink = document.createElement('a');
                    tempLink.href = url;
                    tempLink.download = fileName;
                    document.body.appendChild(tempLink);
                    tempLink.click();
                    document.body.removeChild(tempLink);

                    window.URL.revokeObjectURL(url);
                    $("#btnExcelValidationMessage").click();

                    hideLoader();
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err;
                    hideLoader();
                }
            });
        }

        var IsClickonUpload = 0;
        var GRequestID = 0;
        function uploadDocBtn() {
            UploadFile();
        }
        function UploadFile() {
            //debugger;
            showLoader();
            alertify.set('notifier', 'position', 'top-right');
            var formData = new FormData();
            var file = $('#file-upload').get(0).files;
            if (file.length > 0) {
                formData.append("UploadedFile", file[0]);
                formData.append("GRequestID", GRequestID);
                formData.append("UserName", UserName);                
                formData.append("intEmployeeID", EmployeeID);
            }
            $.ajax({
                //url: strUrl + '/api/ExcelUploadTimesheet/ExcelUpload',
                url: strUrl + '/api/EmployeeSkillsBulkUpload/SkillsExcelUpload',
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
                    const fileInput = document.getElementById('file-upload');
                    const fileName = document.getElementById('file-name');
                    hideLoader();
                    if (fileInput.files && fileInput.files[0]) {
                        const file = fileInput.files[0];
                        const uploadBtn = document.getElementById('upload-btn');
                        uploadBtn.disabled = true;
                        uploadBtn.textContent = 'Uploading...';
                        setTimeout(function () {
                            const now = new Date();
                            const formattedDate = now.toISOString().split('T')[0];
                            fileInput.value = '';
                            fileName.textContent = 'No file chosen';
                            uploadBtn.textContent = 'Upload';
                            uploadBtn.disabled = true;
                        }, 1500);
                        var arrData = result.errorMessages.split('$');
                        console.log("Result: " + result);
                        console.log("arrData: " + arrData);
                        if (arrData.some(item => item.toLowerCase().includes("invalid template") || item.toLowerCase().includes("excel is empty"))) {
                            alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                            return;
                        }
                        else if (arrData.some(item => item.toLowerCase().includes("maximum 100 records") || item.toLowerCase().includes("can be uploaded in a single file."))) {
                            alertify.error('<%=MyBase.GetResourceString("A_MaxRecords")%>');
                            return;
                        }                        
                        else if (arrData[0] == "D") {
                            var message = arrData[1].trim();
                            alertify.error(message);
                            return;
                        }
                        else {
                            console.log("file uploaded successfully")
                            alertify.success('<%=MyBase.GetResourceString("A_FileUploaded")%>');
                        }
                        currentPageNumber = 1;
                        GetRequestDetails(currentPageNumber, currentPageSize);
                    }
                    
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err;
                    hideLoader();
                }
            });
        }

        function GetRequestDetails(pageNumber, pageSize) {
            pageNumber = pageNumber || 1;
            pageSize = pageSize || 5;            
            var taskParameters = {
                intEmployeeID: EmployeeID,                
                pageNumber: pageNumber,  // Added for server-side pagination
                pageSize: pageSize       // Added for server-side pagination
            };
            showLoader();
            $.ajax({                
                url: strUrl + '/api/EmployeeSkillsBulkUpload/GetSkillsRequestDetails',
                type: "POST",
                async: false,
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (response) {
                    var tableBody = $("#tbluploadedfiles tbody");
                    if ($.fn.DataTable.isDataTable("#tbluploadedfiles")) {
                        $('#tbluploadedfiles').DataTable().clear().destroy();
                    }
                    tableBody.empty();
                    // Extract data from response
                    var data = response.data.TimesheetRequestEntity_SKills || [];
                    var paginationData = response.data.PaginationEntity_Skills[0] || {};
                    // Update global pagination variables
                    currentPageNumber = paginationData.currentPage || 1;
                    currentPageSize = paginationData.pageSize || 5;
                    totalPages = paginationData.totalPages || 1;
                    totalRecords = paginationData.totalRecords || 0;
                    if (data && data.length > 0) {
                        $.each(data, function (index, file) {
                            var statusBadge = "";
                            if (file.status === "Invalid") {
                                statusBadge = `<td class="text-center"><span class="badge badge-danger">Invalid File</span>
                                                <i class="fas fa-info-circle error-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Error Details" onclick="ShowErrorValidation(${file.requestID},0);"></i></td>`;
                            } else if (file.status === "Successful") {
                                statusBadge = `<td class="text-center"><span class="badge badge-success">Successful</span>
                                                <i class="fas fa-info-circle success-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Success Details" onclick="ShowErrorValidation(${file.requestID},1);"></i></td>`;
                            } else if (file.status === "Partially Successful") {
                                statusBadge = `<td class="text-center"><span class="badge badge-success">Partially Successful</span>
                                               <i class="fas fa-info-circle success-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Success Details" onclick="ShowErrorValidation(${file.requestID},1);"></i></td>`;
                            }
                            var row = `<tr>
                               <td class="text-center">
                                   <a href="#" onclick="downloadFileByName(event, '${file.fileName}')" class="download-link-table">${file.fileName}</a>
                               </td>                               
                               <td class="text-center">${file.uploadedDate}</td>
                                <td class="text-center">${file.uploadedBy}</td>
                               ${statusBadge}
                           </tr>`;
                            tableBody.append(row);
                        });
                        $('#tbluploadedfiles').DataTable({
                            "paging": false,        // Disabled - using custom pagination
                            "bLengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "destroy": true,
                            "bAutoWidth": false,
                            "info": false,
                        });
                        // Render custom pagination controls
                        RenderPaginationControls();
                        $('[data-bs-toggle="tooltip"]').tooltip();
                    } else {
                        tableBody.html('<tr><td colspan="4" class="text-center">No records found</td></tr>');
                        $('#customPaginationControls').hide();
                    }
                    hideLoader();                                        
                },
                error: function (err) {
                    console.error(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(err.responseText);
                    hideLoader();
                }
            });            
        }

        var loaderShown = false;
        var loaderStartTime = 0;
        function showLoader() {
            document.getElementById('loaderOverlay').style.display = 'block';
            loaderShown = true;
            loaderStartTime = Date.now();
        }

        function hideLoader() {
            if (!loaderShown) return;
            var elapsedTime = Date.now() - loaderStartTime;
            var minDisplayTime = 1500; // Minimum 1.5 seconds
            if (elapsedTime < minDisplayTime) {
                setTimeout(function () {
                    document.getElementById('loaderOverlay').style.display = 'none';
                    loaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                document.getElementById('loaderOverlay').style.display = 'none';
                loaderShown = false;
            }
        }
   
        function RenderPaginationControls() {
            var paginationHtml = '';
            // Create container if not exists
            if ($('#customPaginationControls').length === 0) {
                $('#tbluploadedfiles').after(`
            <div id="customPaginationControls" 
                 class="d-flex justify-content-end align-items-center mt-2">
            </div>`);
            }
            // Total Records
            paginationHtml += `<div class="me-3">
                        Total Records: ${totalRecords}
                      </div>`;
            // Navigation buttons container
            paginationHtml += `<div class="btn-group">`;

            // Previous <<
            if (currentPageNumber > 1) {
                paginationHtml += `
            <button class="btn btn-light border"
                onclick="NavigateToPage(${currentPageNumber - 1})">
                &laquo;
            </button>`;
            } else {
                paginationHtml += `
            <button class="btn btn-light border" disabled>
                &laquo;
            </button>`;
            }
            // Next >>
            if (currentPageNumber < totalPages) {
                paginationHtml += `
            <button class="btn btn-light border"
                onclick="NavigateToPage(${currentPageNumber + 1})">
                &raquo;
            </button>`;
            } else {
                paginationHtml += `
            <button class="btn btn-light border" disabled>
                &raquo;
            </button>`;
            }
            paginationHtml += `</div>`;
            $('#customPaginationControls').html(paginationHtml).show();
        }

        function NavigateToPage(pageNumber) {
            if (pageNumber >= 1 && pageNumber <= totalPages && pageNumber !== currentPageNumber) {
                GetRequestDetails(pageNumber, currentPageSize);
            }
        }

        function downloadFileByName(event, fileName) {
            showLoader();
            var taskParameters = {
                fileName: fileName
            };
            $.ajax({
                url: strUrl + "/api/EmployeeSkillsBulkUpload/DownloadUploadedFile",
                type: "POST",
                data: JSON.stringify(taskParameters),
                contentType: "application/json; charset=utf-8",
                dataType: 'binary',
                xhrFields: {
                    responseType: 'arraybuffer' // Changed from 'blob' to 'arraybuffer'
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Authorization", "bearer " + sessionStorage.getItem("access_token_W26API"));
                },
                success: function (data, status, xhr) {
                    var contentType = xhr.getResponseHeader('Content-Type');
                    if (contentType && contentType.indexOf('application/json') !== -1) {
                        try {
                            var decoder = new TextDecoder('utf-8');
                            var text = decoder.decode(data);
                            var errorResponse = JSON.parse(text);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(errorResponse.message || "Failed to download file. Please try again.");
                        } catch (e) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Failed to download file. Please try again.");
                        }
                        return;
                    }
                    var disposition = xhr.getResponseHeader('Content-Disposition');
                    var downloadFileName = fileName;
                    if (disposition && disposition.indexOf('filename') !== -1) {
                        var matches = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/.exec(disposition);
                        if (matches != null && matches[1]) {
                            downloadFileName = matches[1].replace(/['"]/g, '');
                        }
                    }
                    // Create blob from arraybuffer and trigger download
                    var blob = new Blob([data], {
                        type: contentType || "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                    });
                    var url = window.URL.createObjectURL(blob);
                    var tempLink = document.createElement('a');
                    tempLink.href = url;
                    tempLink.download = downloadFileName;
                    document.body.appendChild(tempLink);
                    tempLink.click();
                    document.body.removeChild(tempLink);
                    // Clean up the blob URL to free memory
                    window.URL.revokeObjectURL(url);
                    hideLoader();
                },
                error: function (xhr, status, error) {
                    console.log("Download error:", error);
                    console.log("Status:", status);
                    console.log("Response:", xhr);
                    var errorMessage = "Failed to download file: " + fileName + ". Please try again.";
                    // Try to extract error message from response
                    if (xhr.responseText) {
                        try {
                            var errorResponse = JSON.parse(xhr.responseText);
                            errorMessage = errorResponse.message || errorResponse.Message || errorMessage;
                        } catch (e) {
                            errorMessage = xhr.responseText || errorMessage;
                        }
                    } else if (xhr.status === 404) {
                        errorMessage = "File not found: " + fileName;
                    } else if (xhr.status === 401) {
                        errorMessage = "Unauthorized. Please login again.";
                    }
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(errorMessage);
                }
            });
        }

        function ShowErrorValidation(RequestID, flag) {
            showLoader();
            console.log("RequestID:", RequestID);
            //$('#errorModal').modal('show');
            var offcanvasElement = document.getElementById('offcanvas_tblErrorDetails');
            var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
            offcanvas.show();
            var taskParameters = {
                RequestID: RequestID,
            };
            var param = JSON.stringify(taskParameters);
            var data = AJAXCallWithResult("/api/EmployeeSkillsBulkUpload/GetSkillsErrorValidation", param, false);
            hideLoader();
            if (data && data.length > 0) {
                var tableBody = $("#tblErrorDetails tbody");
                //var tableHeader = $("#tblErrorDetails thead");
                if ($.fn.DataTable.isDataTable("#tblErrorDetails")) {
                    $('#tblErrorDetails').DataTable().clear().destroy();
                }
                tableBody.empty(); 
                //tableHeader.empty();
                var rows = [];
                // Start the Header Row HTML. Note the opening <tr> is here.
                //var HeaderRow = '<tr>' +
                //    '<th class="text-center">Employee Name</th>' +
                //    '<th class="text-center">Skill Name</th>' +
                //    '<th class="text-center">Experience(Years)</th>' +
                //    '<th class="text-center">Experience(Months)</th>' +
                //    '<th class="text-center">Proficiency</th>' +
                //    '<th class="text-center">Core Competency</th>' +
                //    '<th class="text-center">Notes</th>';
                // Conditionally ADD the last column's <th> tag
                //if (flag == 1) {
                //    HeaderRow += '<th class="text-center">Response</th>';
                //} else {
                //    HeaderRow += '<th class="text-center">Response</th>';
                //}
                // Close the Header Row HTML
                //HeaderRow += '</tr>';
                //tableHeader.append(HeaderRow);
                //tableHeader.html(HeaderRow);
                $.each(data, function (index, error) {
                    var formattedErrors = error.ErrorMessages;
                    var finalColumnContent = "";
                    if (flag == 1) {
                        finalColumnContent = `<span class="success-status">${formattedErrors}</span>`
                    } else {
                        finalColumnContent = `<span class="error-status">${formattedErrors}</span>`
                    }
                    // ✅ Truncate Notes to 100 chars
                    var fullNotes = error.Notes || "";
                    var shortNotes = fullNotes.length > 100
                        ? fullNotes.substring(0, 100) + "..."
                        : fullNotes;

                    //var row = `<tr>
                    //                <td class="text-center">${error.EmployeeName}</td>
                    //                <td class="text-center">${error.SkillName}</td>
                    //                <td class="text-center">${error.Exp_Years}</td>
                    //                <td class="text-center">${error.Exp_Months}</td>
                    //                <td class="text-center">${error.Proficiency}</td>
                    //                <td class="text-center">${error.CoreCompetency}</td>
                    //                <td class="text-start">${error.Notes}</td>`

                    var row = `<tr>
                                <td class="text-center">${error.RowNumber}</td>
                                <td class="text-center">${error.EmployeeName}</td>
                                <td class="text-center">${error.SkillName}</td>
                                <td class="text-center">${error.Exp_Years}</td>
                                <td class="text-center">${error.Exp_Months}</td>
                                <td class="text-center">${error.Proficiency}</td>
                                <td class="text-center">${error.CoreCompetency}</td>

                                <!-- ✅ Notes with tooltip -->
                                <td class="text-start">
                                    <span class="notes-tooltip" title="${fullNotes}">
                                        ${shortNotes}
                                    </span>
                                </td>`;

                    if (flag == 1) {
                        //row += `<td class="text-center">${finalColumnContent}</td>`
                        if (error.IsValid == 0) {
                            row += `<td class="text-start"><span class="error-status">${formattedErrors}</span></td>`

                        } else {
                            row += `<td class="text-start"><span class="success-status">Successful</span></td>`
                        }
                        
                    } else {
                        row += `<td class="">${finalColumnContent}</td>`
                    }
                    row += `</tr>`;
                    rows.push(row);
                });
                tableBody.html('');
                tableBody.append(rows.join("")); // ✅ Append all rows efficiently    

                $("#tblErrorDetails tbody tr").filter(function () {
                    return $(this).find("td").length === 0;
                }).remove();
                $('#tblErrorDetails').DataTable({
                    scrollY: false,
                    scrollX: false,
                    paging: true,
                    pageLength: 5,
                    bLengthChange: false,
                    bFilter: false,
                    ordering: false,
                    responsive: true,
                    destroy: true,
                    info: false,
                    pagingType: "simple",
                    //dom: '<"d-flex justify-content-end align-items-center gap-2"ip>',
                    //dom: '<"top">rt<"d-flex justify-content-end align-items-center gap-2"ip>',
                    dom: 'rt<"d-flex justify-content-end align-items-center gap-2"ip>',
                    language: {
                        info: "Total Records: _TOTAL_",
                        infoEmpty: "Total Records: 0",
                        paginate: {
                            previous: "<<",
                            next: ">>"
                        }
                    }
                });

            } else {
                if (flag == 1) {
                    $("#tblErrorDetails tbody").html('<tr><td colspan="8" class="text-center">No errors found</td></tr>'); // ✅ Handle empty results
                } else {
                    $("#tblErrorDetails tbody").html('<tr><td colspan="7" class="text-center">No errors found</td></tr>'); // ✅ Handle empty results
                }                
            }
        }
        
        //AjaxCall Function start here 
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
    </script>
</body>
</html>
