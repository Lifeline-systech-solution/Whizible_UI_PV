<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PT_ExcelUpload.aspx.vb" Inherits="Whizible.PT_ExcelUpload" %>

<!DOCTYPE html>
<html>
          <%CommonFunctions.General.PlotPageHeadTag("Timesheet Excel Upload")%>
<head>
    <%-----------------------------------------------------------------------------------------
         Code is Modified by Vaibhav K on 25/02/2026 for integrating new .net core api
     -------------------------------------------------------------------------------------------%>

     <%--Added by Vishal Mane on 25/02/2026 for integrating new .net core api--%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Timesheet Excel Upload</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <%--Commented by Vaibhav K on 24-03-26 for upgrading css--%> 
    <%--<link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css?date=<%=DateTime.Now %>">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">--%>
    <%--End of Commented  by Vaibhav K on 24-03-26 for upgrading css--%> 

    <%--Added by Vishal Mane on 21/01/2025--%>
    <link href="../../../Whizible2.0-new/dist/css/TimesheetEntry_custom.css?date=<%=DateTime.Now %>" rel="stylesheet" type="text/css" />
    <%--Commented by Vaibhav K on 24-03-26 for upgrading css--%> 
   
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=6">--%>
    <%--Added by Riddhesh Patil on 19 March 2025 for Excel Upload--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap.min.css?v=0">--%>
    <%--End of Added by Riddhesh Patil on 19 March 2025 for Excel Upload--%>
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <%--End of Commented  by Vaibhav K on 24-03-26 for upgrading css--%> 

    <style>
        /* General adjustments for a more compact UI */
        body {
            font-size: 14px;
        }
       /* .form-label {
            margin-bottom: -1.5rem;
        }*/

       .success-status {
            /* Apply green color and bolding for success */
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
        /*Added by Vishal Mane on 25/09/2025*/
        /*#access-denied-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            height: 100vh;*/ /* Adjust as needed to fit the parent container */
            /*padding: 20px;
            font-family: Arial, sans-serif;
            color: #495057;*/ /* A professional, dark gray color */
        /*}

        .icon-section {
            margin-bottom: 20px;
        }

        .message-section h2 {
            font-size: 2rem;
            color: #343a40;*/ /* Slightly darker for the heading */
            /*margin-bottom: 10px;
        }

        .message-section p {
            font-size: 1rem;
            line-height: 1.5;
            margin-bottom: 5px;
        }*/

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
            font-size: 11.5px;
            /* Modified By Madhuri.K On 26-03-2026 */
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
            font-size: 11.5px;
            color: #64748b;
            /* Modified By Madhuri.K On 26-03-2026 */
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

        /*End of This style section refers to Unauthorized div added by Vishal Mane on 03/10/2025 */
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
    <% If m_blnViewAccess = True Then %>
    <div class="container-fluid">
        <div class="graybg d-flex justify-content-between align-items-center px-3 py-2">
            <%--<h1><%=MyBase.GetResourceString("C_ExcelUpload")%></h1>--%>
            <h4 class="HeaderTitle mb-0">Timesheet Excel Upload</h4>
        </div>
        <div class="card card-compact">
            <div class="row">
                <div class="card-title"><%=MyBase.GetResourceString("C_Step1")%></div>              
                <div class="col-sm-6">                    
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-end flex-wrap">
                                <label class="form-label me-3"><%=MyBase.GetResourceString("C_TimesheetWeek")%></label>
                                <div class="weekly_calender me-3">
                                    <div class="input-group-box">
                                        <div class="input-group" id="DateDemo">
                                            <input class="form-control" type="text" id="weekPicker2" />
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center flex-wrap">                                
                                <label class="form-label me-3">&nbsp; &nbsp;</label>
                                <%--<a href="#" class="download-link" id="btnDownload" onclick="DownLoadTemplate()">
                                    <svg class="download-icon" width="16" height="16" viewBox="0 0 24 24" fill="none"
                                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                        <polyline points="7 10 12 15 17 10"></polyline>
                                        <line x1="12" y1="15" x2="12" y2="3"></line>
                                    </svg>
                                    <%=MyBase.GetResourceString("C_DownloadTemplate")%>
                                </a>--%>
                                    <a href="#" class="download-link" id="btnGenerateFile" >
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
                    </div>                   
                </div>
                  <div class="col-sm-6">
                    <div class="card-title"><%=MyBase.GetResourceString("C_ImportantInstructions1")%></div>
                    <div class="instructions">
                        <ol>
                            <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note1")%></li>
                            <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note2")%></li>
                            <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note3")%></li>
                            <li style="list-style-type: decimal !important;"><%=MyBase.GetResourceString("C_Note4")%></li>
                        </ol>
                    </div>

                </div>
            </div>
        </div>
      
   
        <div class="card card-compact">
            <div class="card-title"><%=MyBase.GetResourceString("C_Step2")%></div>
            <div class="upload-container">
                <div class="row">
                    <div class="file-input-container">
                        <div class="col-sm-4">
                            <div class="drop-zone" id="drop-zone">
                                <label for="file-upload" class="file-input-label"><%=MyBase.GetResourceString("C_ChooseFile")%></label>
                                <input type="file" id="file-upload" class="file-input" accept=".xlsx, .xls">
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
                <%--<div style="display: flex; justify-content: flex-end;">
                    <button class="upload-btn" id="upload-btn" disabled onclick="uploadDocBtn()">Upload</button>
                </div>--%>
            </div>
        </div>

        <div class="alert alert-warning">
            <strong>⚠️ <%=MyBase.GetResourceString("C_Note")%></strong> <%=MyBase.GetResourceString("C_NoteDetails")%></div>

        <div class="card card-compact">
            <div class="card-title"><%=MyBase.GetResourceString("C_UploadedFileDetails")%></div>
            <table class="table table-bordered table-sm" id="tbluploadedfiles">
                <thead>
                    <tr>
                        <th class="text-center"><%=MyBase.GetResourceString("C_FileName")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_TimesheetWeek1")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_UploadedDate")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_Status")%></th>
                        <%--<th><b>File Name</b></th>
                        <th><b>Upload Date</b> </th>
                        <th><b>Status</b> </th>--%>
                    </tr>
                </thead>
                <tbody id="uploadedfiles">
                </tbody>
            </table>
        </div>
    </div>
    <div id="errorModal" class="modal fade custmodal new-large-modal" role="dialog">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button" class="close"  onclick="Close_ErrorModel()">&times;</button>
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
        <%--Commented and Added by Vishal Mane on 25/09/2025--%>
        <%--<div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %> </p>
        </div>--%>
         <div class="container_Access">
             <div class="content">
                 <!-- Floating icon with animation -->
                 <div class="icon-container">
                     <div class="icon-circle">
                         <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                             <path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"/>
                         </svg>
                     </div>
                 </div>

                 <!-- Main content card -->
                 <div class="card">
                     <!-- Header -->
                     <div class="header">
                         <h1><%=MyBase.GetResourceString("C_AccessRestricted")%></h1>
                         <p><%=MyBase.GetResourceString("C_NotAuthorised")%></p>
                     </div>

                     <!-- Instructions section -->
                     <div class="instructions-section">
                         <div class="instructions-header">
                             <div class="warning-icon">
                                 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
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
                                 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                     <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                                     <circle cx="9" cy="7" r="4"/>
                                     <line x1="17" x2="22" y1="8" y2="13"/>
                                     <line x1="22" x2="17" y1="8" y2="13"/>
                                 </svg>
                                 <div class="contact-content">
                                     <p><%=MyBase.GetResourceString("C_ContactAdministrator")%></p>
                                     <%--<p>Please contact your administrator to request access 01. <span class="config-path">Configuration → Group & Access → Role</span> 02. <span class="config-path">Configuration → Login → Group & Access</span> and manage the employee mappings under the <span class="config-path">Configuration → Proxy Timesheet → Proxy User Mapping</span> section.</p>--%>
                                 <p>
                                    <%=MyBase.GetResourceString("C_InstructionNote3")%> 
                                </p>
                                <ul style="list-style-type: none; padding-left: 0;">
                                    <li>
                                        <strong>1.</strong> Navigate to <span class="config-path">Configuration → Group & Access → Role</span>.
                                    </li>
                                    <li>
                                        <strong>2.</strong> Navigate to <span class="config-path">Configuration → Login → Group & Access</span>.
                                    </li>
                                </ul>
                                <p>
                                    After this, manage employee mappings under the <span class="config-path">Configuration → Proxy Timesheet → Proxy User Mapping</span> section.
                                </p>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
        <%--End of Commented and Added by Vishal Mane on 25/09/2025--%>
    </div>
    <% End If %>
    <div class="clearfix"></div>

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script--%>>
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.6"></script>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPickerNew.js?date=<%=DateTime.Now %>"></script>
    <%--<script src="../../General/CommonValidations.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/jquery.dataTables.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/dataTables.bootstrap.min.js"></script>--%>


    <script>
    //Added by Vishal Mane on 20/08/2025 for Excel Upload functionality of Expleo
        //WebAPIUrl-Timesheet  WebAPIUrl-W26API
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';   // Normalize base URL (remove trailing slash)
       strUrl = strUrl ? strUrl.replace(/\/+$/, '') : '';
        
        onfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
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

        // Added by Vaibhav K on 17/11/2025 - Global variables for pagination
        var currentPageNumber = 1;
        var currentPageSize = 5;
        var totalPages = 1;
        var totalRecords = 0;
// End of Added by Vaibhav K on 17/11/2025



        $("#weekPicker2").change(function () {
            setWeekCalendar($('#weekPicker2'), 'yes', '1', startingDayOfWeek, new Date(TodaysDate));
            GetRequestDetails();

            // Modified by Vaibhav K on 17/11/2025 - Reset to page 1 when week changes
            currentPageNumber = 1;
            GetRequestDetails(currentPageNumber, currentPageSize);
    // End of Modified by Vaibhav K on 17/11/2025
        });

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

        function GetCompanyInformation() {
            var Result = AJAXCallWithResult("/api/ExcelUploadTimesheet/GetCompanyInformation", '', false);
            var d = Result[0];
            startingDayOfWeek = d.StartingDayOfWeek;
            FinancialYearStart = d.FinancialYearStart;
            TodaysDate = d.TodaysDate;
        }
        var ProxyUsersCount = 0;
        $(document).ready(function () {
    /*        debugger;*/
            var Parameters = {
                intEmployeeID: SessionEmployeeId,
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/ExcelUploadTimesheet/GetProxyUserCount", param, false);
            if (Result.length != 0) {
                ProxyUsersCount = 1;
            }
            GetCompanyInformation();
            setWeekCalendar($('#weekPicker2'), 'yes', '1', startingDayOfWeek, new Date(TodaysDate));

            // Modified by Vaibhav K on 17/11/2025 - Initialize with pagination parameters
            //GetRequestDetails();

            GetRequestDetails(currentPageNumber, currentPageSize);


            // ============================================================
            //  TOOLTIP FIX FOR WEEK PICKER PREV/NEXT NAVIGATION
            // ============================================================
            function clearWeekPickerNavTooltip(el) {
                var $el = $(el);
                $el.removeAttr('data-bs-original-title');
                $el.removeAttr('data-original-title');
                $el.removeAttr('aria-describedby');

                try { $el.tooltip('hide'); } catch (err) { /* ignore */ }
                try { $el.tooltip('close'); } catch (err) { /* ignore */ }
                try { $el.tooltip('destroy'); } catch (err) { /* ignore */ }

                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var bsTip = bootstrap.Tooltip.getInstance(el);
                    if (bsTip) {
                        bsTip.hide();
                        bsTip.dispose();
                    }
                }

                $('.tooltip, .ui-tooltip, .tooltip-inner, .tooltip-arrow').remove();
            }

            function ensureWeekPickerNavTitle(el) {
                var $el = $(el);
                if (!$el.attr('title')) {
                    var handlerType = ($el.attr('data-handler') || '').toLowerCase();
                    if (handlerType === 'prev') {
                        $el.attr('title', 'Prev');
                    } else if (handlerType === 'next') {
                        $el.attr('title', 'Next');
                    }
                }
            }

            // Datepicker re-renders prev/next anchors each month; delegate handlers permanently.
            $(document).on('mouseenter focus', '#ui-datepicker-div .ui-datepicker-prev, #ui-datepicker-div .ui-datepicker-next, #DateDemo .ui-datepicker-prev, #DateDemo .ui-datepicker-next', function () {
                ensureWeekPickerNavTitle(this);
                $('.tooltip, .ui-tooltip, .tooltip-inner, .tooltip-arrow').remove();
            });

            $(document).on('mousedown click', '#ui-datepicker-div .ui-datepicker-prev, #ui-datepicker-div .ui-datepicker-next, #DateDemo .ui-datepicker-prev, #DateDemo .ui-datepicker-next', function () {
                clearWeekPickerNavTooltip(this);
            });

            // Keep this generic click cleanup for existing non-datepicker controls.
            $(document).on('click', '#DateDemo button, #DateDemo input[type="button"], #DateDemo .btn', function () {
                $('.tooltip, .ui-tooltip, .tooltip-inner, .tooltip-arrow').remove();
                $(this).blur();
            });
            // End of Modified by Vaibhav K on 17/11/2025

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
                        //alert('Please select a valid Excel file (.xlsx or .xls)');
                        //showAlert("Please select a valid Excel file (.xlsx or .xls).", "alert-danger");
                        //alertify.error("Please select a valid Excel file (.xlsx or .xls).");
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
       
        function formatDateForDisplay(dateObject) {
            if (isNaN(dateObject.getTime())) {
                return '';
            }
            const options = {
                day: '2-digit',
                month: 'short', // 'Sep'
                year: 'numeric' // '2025'
            };
            let parts = dateObject.toLocaleDateString('en-US', options).split(' ');            
            return `${parts[1].replace(',', '')} ${parts[0]} ${parts[2]}`;
        }

        // Function to handle the initial button click and show the confirmation modal
        $(document).ready(function () {
            // We attach the logic to the button that the user actually clicks
            $("#btnGenerateFile").on('click', function (e) {
                //debugger
                // Prevent the link from navigating away (the default behavior of href="#")
                e.preventDefault();
                // This is the entire logic for showing the confirmation modal
                if (ProxyUsersCount == 1) {
                    var dtFromDateObj = new Date($("#weekPicker2").attr("StartDate"));
                    var dtToDateObj = new Date($("#weekPicker2").attr("EndDate"));

                    var fromDateDisplay = formatDateForDisplay(dtFromDateObj); // Result: 22 Sep 2025
                    var toDateDisplay = formatDateForDisplay(dtToDateObj);   // Result: 28 Sep 2025

                    $("#ExcelValidationMessageModalinfo").modal("show");
                    $("#txtExcelValidationMessage").text(`The Excel file will be generated based on the selected week. The selected week is ${fromDateDisplay} to ${toDateDisplay}. Do you want to generate the Excel file for this period?`);
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error('You are not allowed to generate this file because no resources are mapped to the Proxy User.');
                    alertify.error('<%=MyBase.GetResourceString("A_ProxyUserAlert")%>');
                }
            });
        });

        //commented and added by Vaibhav K to get template file directly from api
        //function DownLoadTemplateUpdated() {
        //    //debugger
        //    var taskParameters = {
        //        intEmployeeID: SessionEmployeeId,
        //        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
        //        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
        //    }
        //    $.ajax({
        //        url: strUrl + '/api/ExcelUploadTimesheet/DownloadTimesheetTemplate',
        //        type: "POST",
        //        async: false,
        //        data: JSON.stringify(taskParameters),
        //        //dataType: "json",
        //        contentType: "application/json;charset-utf=8",


        //        beforeSend: function (xhr) {
        //            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
        //        },
        //        success: function (fileName) {

        //            var fileUrl = "../../../Attachments/ExcelTSTemplate/" + fileName;



        //            var tempLink = document.createElement('a');
        //            tempLink.href = fileUrl;
        //            tempLink.download = fileName;
        //            document.body.appendChild(tempLink);
        //            tempLink.click();
        //            document.body.removeChild(tempLink);
        //            $("#btnExcelValidationMessage").click();
        //        },

        //        //xhrFields: {
        //        //    responseType: 'blob'  // Important for file download
        //        //},
        //        //beforeSend: function (xhr) {
        //        //    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
        //        //},
        //        //success: function (data, status, xhr) {
        //        //    // Extract filename from Content-Disposition header or use default
        //        //    var disposition = xhr.getResponseHeader('Content-Disposition');
        //        //    var fileName = 'Timesheet.xlsx';

        //        //    if (disposition && disposition.indexOf('filename=') !== -1) {
        //        //        var matches = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/.exec(disposition);
        //        //        if (matches != null && matches[1]) {
        //        //            fileName = matches[1].replace(/['"]/g, '');
        //        //        }
        //        //    }

        //        //    // Create blob and download
        //        //    var blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        //        //    var url = window.URL.createObjectURL(blob);

        //        //    var tempLink = document.createElement('a');
        //        //    tempLink.href = url;
        //        //    tempLink.download = fileName;
        //        //    document.body.appendChild(tempLink);
        //        //    tempLink.click();
        //        //    document.body.removeChild(tempLink);

        //        //    window.URL.revokeObjectURL(url);
        //        //    $("#btnExcelValidationMessage").click();
        //        //},


        //        error: function (err) {
        //            console.log(err);
        //            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
        //        }
        //    });            
        //}

        function DownLoadTemplateUpdated() {
            //debugger;
            var taskParameters = {
                intEmployeeID: SessionEmployeeId,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
            };

            $.ajax({
                url: strUrl + '/api/ExcelUploadTimesheet/DownloadTimesheetTemplate',
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
                    // Extract filename from Content-Disposition header or use default
                    var disposition = xhr.getResponseHeader('Content-Disposition');
                    var fileName = 'Timesheet.xlsx';

                    // Debug: Check what headers are being sent
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
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err;
                }
            });
        }
        //commented and added by Vaibhav K to get template file directly from api


        var IsClickonUpload = 0;
        var GRequestID = 0;
        function uploadDocBtn() {
            if (ProxyUsersCount == 1) {
                var DocIsValid = 0;
                var file = $('#file-upload').get(0).files;
                if (DocIsValid == 0) {
                    UploadFile();
                }
            }
            //Added by Vishal Mane on 25/09/2025 to add restriction to Proxy Use which dont have resources mapped 
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('You are not allowed to upload the file because no resources are mapped to the Proxy User.');
            }
            //End of Added by Vishal Mane on 25/09/2025 to add restriction to Proxy Use which dont have resources mapped
            
        }
        function UploadFile() {
            //debugger;
            alertify.set('notifier', 'position', 'top-right');
            var formData = new FormData();
            var file = $('#file-upload').get(0).files;
            if (file.length > 0) {
                formData.append("UploadedFile", file[0]);
                formData.append("GRequestID", GRequestID);
                formData.append("UserName", UserName);
                formData.append("dtFromDate", new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"));
                formData.append("dtToDate", new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"));
                formData.append("intEmployeeID", EmployeeID);
            }
            $.ajax({
                url: strUrl + '/api/ExcelUploadTimesheet/ExcelUpload',
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
                        //var arrData = result.split('$');
                        var arrData = result.errorMessages.split('$');



                        console.log("Result: " + result);
                        console.log("arrData: " + arrData);

                        //var arrData = result.split('84');
                        if (arrData.some(item => item.toLowerCase().includes("invalid template selected.") || item.toLowerCase().includes("the dates in the template do not match the chosen week."))) {
                            //showAlert("You can upload 100 rows data only.", "alert-danger");
                            alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplateDates")%>');
                            return;
                        }
                        else if (arrData.some(item => item.toLowerCase().includes("invalid template") || item.toLowerCase().includes("excel is empty"))) {
                            //showAlert("Invalid Template Used or Excel is empty. Please check and try again.", "alert-danger");                            
                            alertify.error('<%=MyBase.GetResourceString("A_InvalidTemplate")%>');
                            return;
                        }
                        else if (arrData.some(item => item.toLowerCase().includes("maximum 100 records") || item.toLowerCase().includes("can be uploaded in a single file."))) {
                            //showAlert("You can upload 100 rows data only.", "alert-danger");
                            alertify.error('<%=MyBase.GetResourceString("A_MaxRecords")%>');
                            return;
                        }                        
                        else if (arrData[0] == "D") {
                            var message = arrData[1].trim();
                            alertify.error(message);
                            //showAlert(message, "alert-danger");
                            return;
                        }
                        else {
                            //showAlert("File uploaded successfully! It will be processed shortly.", "alert-success");
                            console.log("file uploaded successfully")
                            alertify.success('<%=MyBase.GetResourceString("A_FileUploaded")%>');
                        }
                        // Commented and added by Vaibhav K on 17/11/2025 - Reset to page 1 after successful upload
                        //GetRequestDetails();

                        currentPageNumber = 1;
                        GetRequestDetails(currentPageNumber, currentPageSize);
                        // End of Commented and added by Vaibhav K on 17/11/2025
                    }
                }
            });
        }



        // Commented and added by Vaibhav K on 17/11/2025 - Added pagination parameters for server-side pagination


        //function GetRequestDetails() {
        //    //debugger


        //    //var startDateValue = $("#weekPicker2").attr("StartDate");
        //    //var endDateValue = $("#weekPicker2").attr("EndDate");


        //    //// Validate dates exist
        //    //if (!startDateValue || !endDateValue) {
        //    //    console.error("Week picker dates not initialized");
        //    //    return;
        //    //}

        //    //var dtFrom = new Date(startDateValue);
        //    //var dtTo = new Date(endDateValue);

        //    //// Validate dates are valid
        //    //if (isNaN(dtFrom.getTime()) || isNaN(dtTo.getTime())) {
        //    //    console.error("Invalid dates from week picker");
        //    //    return;
        //    //}

        //    var taskParameters = {
        //        intEmployeeID: EmployeeID,
        //        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
        //        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
        //    };



        //    $.ajax({
        //        url: strUrl + '/api/ExcelUploadTimesheet/GetRequestDetails',
        //        type: "POST",
        //        async: false,
        //        data: JSON.stringify(taskParameters),
        //        dataType: "json",
        //        contentType: "application/json;charset=utf-8",
        //        beforeSend: function (xhr) {
        //            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
        //        },
        //        success: function (data) {
        //            //debugger
        //            var tableBody = $("#tbluploadedfiles tbody");
        //            // ✅ Check if DataTable is initialized, then destroy it
        //            if ($.fn.DataTable.isDataTable("#tbluploadedfiles")) {
        //                $('#tbluploadedfiles').DataTable().clear().destroy();
        //            }
        //            tableBody.empty(); // ✅ Clear existing table data
        //            if (data && data.length > 0) {
        //                $.each(data, function (index, file) {
        //                    var statusBadge = "";
        //                    if (file.Status === "Invalid") {
        //                        statusBadge = `<td class="text-center"><span class="badge badge-danger">Invalid File</span>
        //                    <i class="fas fa-info-circle error-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Error Details" onclick="ShowErrorValidation(${file.RequestID},0);"></i></td>`;
        //                    } else if (file.Status === "Successful") {
        //                        statusBadge = `<td class="text-center"><span class="badge badge-success">Successful</span>
        //                    <i class="fas fa-info-circle success-icon" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Show Success Details" onclick="ShowErrorValidation(${file.RequestID},1);"></i></td>`;
        //                    }
        //                    var row = `<tr>
        //                               <td class="text-center">
        //                                   <a href="#" onclick="downloadFileByName(event, '${file.FileName}')" class="download-link-table">${file.FileName}</a>
        //                               </td>

        //                               <td class="text-center">${file.TimesheetWeek}</td>
        //                               <td class="text-center">${file.UploadedDate}</td>
        //                               ${statusBadge}
        //                           </tr>`;
        //                    tableBody.append(row);
        //                });
        //                // ✅ Reinitialize DataTable properly
        //                $('#tbluploadedfiles').DataTable({
        //                    "paging": true,
        //                    "pageLength": 5,
        //                    "bLengthChange": false,
        //                    "bFilter": false,
        //                    "ordering": false,
        //                    "responsive": true,
        //                    "destroy": true,
        //                    "bAutoWidth": false,
        //                    "info": false,
        //                });
        //                $('.dataTables_paginate').show(); // ✅ Ensure pagination is visible if needed
        //                $('[data-bs-toggle="tooltip"]').tooltip();
        //            } else {
        //                // ✅ Handle empty results
        //                tableBody.html('<tr><td colspan="3" class="text-center">No records found</td></tr>');
        //                $('.dataTables_paginate').hide(); // ✅ Hide pagination when no data
        //            }
        //        },
        //        error: function (err) {
        //            console.error(err);
        //            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(err.responseText);
        //        }
        //    });
        //}


        function GetRequestDetails(pageNumber, pageSize) {
            // Set default values if not provided

            pageNumber = pageNumber || 1;
            pageSize = pageSize || 5;



            // ✅ Guard against Invalid Date
            var startDate = $("#weekPicker2").attr("StartDate");
            var endDate = $("#weekPicker2").attr("EndDate");

            if (!startDate || !endDate || isNaN(new Date(startDate)) || isNaN(new Date(endDate))) {
                console.warn("WeekPicker dates not ready. StartDate:", startDate, "EndDate:", endDate);
                return; // ← Stop here, don't send bad data to API
            }

            var taskParameters = {
                intEmployeeID: EmployeeID,
                //dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                //dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                dtFromDate: new Date(startDate).toLocaleDateString("en-US"),
                dtToDate: new Date(endDate).toLocaleDateString("en-US"),


                pageNumber: pageNumber,  // Added for server-side pagination
                pageSize: pageSize       // Added for server-side pagination
            };

            $.ajax({
                url: strUrl + '/api/ExcelUploadTimesheet/GetRequestDetails',
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

                    // Destroy DataTable if it exists
                    if ($.fn.DataTable.isDataTable("#tbluploadedfiles")) {
                        $('#tbluploadedfiles').DataTable().clear().destroy();
                    }

                    tableBody.empty();

                    // Extract data from response
                    var data = response.data.TimesheetRequestEntity || [];
                    var paginationData = response.data.PaginationEntity[0] || {};

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
                            }

                            var row = `<tr>
                               <td class="text-center">
                                   <a href="#" onclick="downloadFileByName(event, '${file.fileName}')" class="download-link-table">${file.fileName}</a>
                               </td>
                               <td class="text-center">${file.timesheetWeek}</td>
                               <td class="text-center">${file.uploadedDate}</td>
                               ${statusBadge}
                           </tr>`;
                            tableBody.append(row);
                        });

                        // Initialize DataTable without pagination (we handle it manually)
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
                        // Hide custom pagination when no data
                        $('#customPaginationControls').hide();
                    }
                },
                error: function (err) {
                    console.error(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(err.responseText);
                }
            });
        }

        function RenderPaginationControls() {
            var paginationHtml = '';

            // Create pagination container if it doesn't exist
            if ($('#customPaginationControls').length === 0) {
                $('#tbluploadedfiles').after('<div id="customPaginationControls" class="dataTables_paginate paging_simple_numbers"></div>');
            }

            paginationHtml += '<ul class="pagination">';

            // Previous button
            if (currentPageNumber > 1) {
                paginationHtml += `<li class="paginate_button page-item previous" id="btnPrevPage">
                            <a href="javascript:void(0);" class="page-link" onclick="NavigateToPage(${currentPageNumber - 1})">Previous</a>
                          </li>`;
            } else {
                paginationHtml += `<li class="paginate_button page-item previous disabled">
                            <a href="javascript:void(0);" class="page-link">Previous</a>
                          </li>`;
            }

            // Page numbers
            for (var i = 1; i <= totalPages; i++) {
                if (i === currentPageNumber) {
                    paginationHtml += `<li class="paginate_button page-item active">
                                <a href="javascript:void(0);" class="page-link">${i}</a>
                              </li>`;
                } else {
                    paginationHtml += `<li class="paginate_button page-item">
                                <a href="javascript:void(0);" class="page-link" onclick="NavigateToPage(${i})">${i}</a>
                              </li>`;
                }
            }

            // Next button
            if (currentPageNumber < totalPages) {
                paginationHtml += `<li class="paginate_button page-item next" id="btnNextPage">
                            <a href="javascript:void(0);" class="page-link" onclick="NavigateToPage(${currentPageNumber + 1})">Next</a>
                          </li>`;
            } else {
                paginationHtml += `<li class="paginate_button page-item next disabled">
                            <a href="javascript:void(0);" class="page-link">Next</a>
                          </li>`;
            }

            paginationHtml += '</ul>';

            $('#customPaginationControls').html(paginationHtml);
            $('#customPaginationControls').show();
        }


        function NavigateToPage(pageNumber) {
            if (pageNumber >= 1 && pageNumber <= totalPages && pageNumber !== currentPageNumber) {
                GetRequestDetails(pageNumber, currentPageSize);
            }
        }
        // End of Added by  Vaibhav K on 17/11/2025 for server side paginaiton





        //Commented and added by Vaibhav K on 17/11/2025 - Changed to use API endpoint for file download
        //Added by Vishal Mane on 30/09/2025 to downloaded file
        //function downloadFileByName(event, fileName) {
        //    var fileUrl = "../../../Attachments/UploadedExcelFiles/" + fileName;
        //    var tempLink = document.createElement('a');
        //    tempLink.href = fileUrl;
        //    tempLink.download = fileName;
        //    document.body.appendChild(tempLink);
        //    tempLink.click();
        //    document.body.removeChild(tempLink);
        //}
        //End of Added by Vishal Mane on 30/09/2025 to downloaded file
        function downloadFileByName(event, fileName) {


            // Prepare request parameters
            var taskParameters = {
                fileName: fileName
            };

            // Show loading indicator (optional)
            // alertify.success("Downloading file...");

            $.ajax({
                url: strUrl + "/api/ExcelUploadTimesheet/DownloadUploadedFile",
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
                    // Check if response is actually binary data (file) or error JSON
                    var contentType = xhr.getResponseHeader('Content-Type');

                    // If response is JSON, it's an error
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

                    // Extract filename from Content-Disposition header or use passed fileName
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

                    // Show success message (optional)
                    // alertify.set('notifier', 'position', 'top-right');
                    // alertify.success("File downloaded successfully.");
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

        //Commented and added by Vaibhav K on 17/11/2025 - Changed to use API endpoint for file download


        function ShowErrorValidation(RequestID, flag) {
            console.log("RequestID:", RequestID);
            $('#errorModal').modal('show');
            var taskParameters = {
                RequestID: RequestID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US"),
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US"),
                Flag: flag,
            };
            var param = JSON.stringify(taskParameters);
            var data = AJAXCallWithResult("/api/ExcelUploadTimesheet/GetErrorValidation", param, false);
            if (data && data.length > 0) {
                var tableBody = $("#tblErrorDetails tbody");
                var tableHeader = $("#tblErrorDetails thead");

                // ✅ Clear DataTable completely before adding new data
                if ($.fn.DataTable.isDataTable("#tblErrorDetails")) {
                    $('#tblErrorDetails').DataTable().clear().destroy();
                }
                tableBody.empty(); // ✅ Remove old data
                tableHeader.empty();
                var rows = [];
                // Start the Header Row HTML. Note the opening <tr> is here.
                var HeaderRow = '<tr>' +
                    '<th class="text-center">Resource Name</th>' +
                    '<th class="text-center">Project Name</th>' +
                    '<th class="text-center">Task Name</th>' +
                    '<th class="text-center">Entry Date</th>' +
                    '<th class="text-center">Duration</th>';

                // Conditionally ADD the last column's <th> tag
                if (flag == 1) {
                    HeaderRow += '<th class="text-center"> Response</th>';
                } else {
                    HeaderRow += '<th class="text-center">Error</th>';
                }

                // Close the Header Row HTML
                HeaderRow += '</tr>';

                tableHeader.append(HeaderRow);

                $.each(data, function (index, error) {
                    //var formattedErrors = error.ErrorMessages;
                    //var finalColumnContent = (formattedErrors === null || formattedErrors === undefined || formattedErrors === "")
                    //    ? 'Success'
                    //    : formattedErrors;
                    var formattedErrors = error.ErrorMessages;
                    //formattedErrors = 'You are geneous';
                    //var hasErrors = (formattedErrors !== null && formattedErrors !== undefined && formattedErrors !== "");
                    //var contentText = hasErrors ? formattedErrors : 'Success';
                    var finalColumnContent = "";
                    if (flag == 1) {
                        finalColumnContent = `<span class="success-status">${formattedErrors}</span>`
                    } else {
                        finalColumnContent = `<span class="error-status">${formattedErrors}</span>`
                    }
                    //var contentText = hasErrors ? formattedErrors : `<span class="success-status">Success</span>`;

                    //var finalColumnContent = hasErrors
                    //    ? `<span class="error-status">${contentText}</span>` // Use the defined class
                    //    : contentText;

                    var row = `<tr>
                                        <td class="text-center">${error.ResourceName}</td>
                                        <td class="text-center">${error.ProjectName}</td>
                                        <td class="text-center">${error.TaskName}</td>
                                        <td class="text-center">${error.EntryDate}</td>
                                        <td class="text-center">${error.Duration}</td>`
                    if (flag == 1) {
                        row += `<td class="text-center">${finalColumnContent}</td>`
                    } else {
                        row += `<td class="">${finalColumnContent}</td>`
                    }

                    row += `</tr>`;
                    rows.push(row);
                });
                tableBody.append(rows.join("")); // ✅ Append all rows efficiently
                // ✅ Reinitialize DataTable after updating rows
                $('#tblErrorDetails').DataTable({
                    "paging": true,
                    "pageLength": 5,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true, // ✅ Ensure clean initialization
                    "bAutoWidth": false,
                    "info": false,
                });
            } else {
                $("#tblErrorDetails tbody").html('<tr><td colspan="4" class="text-center">No errors found</td></tr>'); // ✅ Handle empty results
            }
        }
        function Close_ErrorModel() {
            $('#errorModal').modal('hide');
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

        //End of Added by Vishal Mane on 20/08/2025 for Excel Upload functionality of Expleo
    </script>
</body>
</html>