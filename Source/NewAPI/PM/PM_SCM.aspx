<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_SCM.aspx.vb" Inherits="Whizible.PM_SCM" %>

<!DOCTYPE html>

<html>

<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SCM Plan</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css"> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    
    <!-- Essential JavaScript files -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script> -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>
    
    <style type="text/css">
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
        }
        
        .main-container {
            padding: 0;
            background-color: #ffffff;
            min-height: 100vh;
            margin: 0;
        }
        
        .page-header {
            background-color: #fff;
            padding: 15px 20px;
            margin-bottom: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #dee2e6;
        }
        
        .header-icon {
            width: 35px;
            height: 35px;
            background-color: #4263c1;
            border-radius: 8px;
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
            color: #4263c1;
            font-size: 18px;
            font-weight: 600;
            margin: 9px 0 4px 0;
            line-height: 1.2;
        }
        
        .page-subtitle {
            color: #6c757d;
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 7px;
            margin-left: -50px;
        }
        
        .search-section {
            background-color: rgb(231, 237, 240);
            padding: 12px 20px;     
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e9ecef;
            margin-bottom: 20px;
        }
        
        .left-section, .right-section {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .right-section {
            gap: 10px;
            justify-content: flex-end;
        }
        
        .selected-phase-section, .project-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .project-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .project-label {
            font-weight: 500;
            color: #495057;
            font-size: 14px;
            margin: 0;
            white-space: nowrap;
        }
        
        .project-dropdown-wrapper {
            position: relative;
            display: inline-block;
        }
        
        .project-dropdown-wrapper .form-control {
            padding-bottom: 6px;
            font-weight: 300;
        }
        
        /* Override bootstrap-select styles with higher specificity */
        .bootstrap-select .dropdown-toggle {
            font-weight: 300 !important;
        }
        
        .bootstrap-select .dropdown-toggle .filter-option {
            font-weight: 300 !important;
        }
        
        .bootstrap-select .dropdown-toggle .filter-option-inner {
            font-weight: 300 !important;
        }
        
        .bootstrap-select .dropdown-toggle .filter-option-inner-inner {
            font-weight: 300 !important;
        }
        
        /* Adjust text positioning in dropdown options */
        .bootstrap-select .dropdown-menu .filter-option-inner-inner {
            
            padding-bottom: 8px;
        }
        
        .bootstrap-select .dropdown-menu li a {
            padding-top: 2px;
            padding-bottom: 8px;
        }
        
        .selected-phase-label, .project-label {
            font-weight: 500;
            color: #495057;
            font-size: 14px;
        }
        .bootstrap-select>.dropdown-toggle:after {
    margin-top: 4px;
}
        .selected-phase-name {
            background-color: #ffffff;
            color: #495057;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            border: 1px solid #ced4da;
        }
        
         
        .filter-btn {
            background: none;
            border: none;
            color: #374151;
            font-size: 11.5px;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 0;
            transition: all 0.2s ease;
            display: inline-block;
        }
        
        .filter-btn i {
            font-size: 0.75rem;
        }
        
        .filter-btn:hover {
            background-color: #e9ecef;
        }
        
        .filter-btn.active {
            background-color: #1359a6;
            color: white;
            border-radius: 0.375rem;
            width: 1.75rem;
            height: 1.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .filter-btn.hidden {
            display: none !important;
        }
        
        .filter-panel {
            background-color: #fff;
            border: 1px solid #e9ecef;
            border-radius: 4px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .filter-tabs {
            display: flex;
        }
        
        .filter-tab {
            padding: 12px 20px;
            cursor: pointer;
            background-color: #f8f9fa;
            color: #495057;
            border-right: 1px solid #e9ecef;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .filter-tab.active {
            background-color: #4263c1;
            color: #fff;
        }
        
        .filter-tab:hover:not(.active) {
            background-color: #e9ecef;
        }
        
        .filter-actions {
            padding: 5px 20px;
            text-align: center;
        }
        
        .filter-actions .btn {
            margin: 0 5px;
            padding: 4px 16px;
            font-size: 12px;
            min-width: 100px;
            white-space: nowrap;
            text-align: center;
        }
        
        .filter-actions .btn-warning {
            background-color: #ffc107;
            color: white;
            border: 1px solid #ffc107;
        }
        
        .filter-actions .btn-warning:hover {
            background-color: #e0a800;
            color: white;
            border-color: #e0a800;
        }
        
        .filter-content {
            padding: 5px 20px 10px 20px;
        }
        
        .filter-tab-content {
            display: none;
        }
        
        .filter-tab-content.active {
            display: block;
        }
        
        .filter-row {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            align-items: end;
        }
        
        .filter-field {
            flex: 1;
        }
        
        .filter-field:first-child {
            flex: 0 0 150px;
        }
        
        .filter-field label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #495057;
        }
        
        .filter-field .form-control {
            width: 100%;
            padding: 6px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .filter-field .form-control:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 1px rgba(0, 123, 255, 0.02);
        }
        
        .filter-input-group {
            display: flex;
            gap: 8px;
        }
        
        .filter-operator {
            width: 120px;
            flex-shrink: 0;
        }
        
        .filter-input-group input[type="text"] {
            flex: 1;
        }
        
        .input-group.srchsresourcegrp.float-end {
            width: 230px;
        }
        
        .input-group.srchsresourcegrp .form-control {
            height: 35px;
            border: 1px solid #d2d6de;
            border-radius: 4px;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            background: #fff;
            padding: 6px 12px;
            font-size: 14px;
        }
        
        .input-group.srchsresourcegrp .form-control:focus {
            border-color: #007bff;
            outline: 0;
        }
        
        .input-group.srchsresourcegrp .input-group-btn .btn {
            height: 35px;
            border: 1px solid #dddddd;
            border-left: 0;
            border-radius: 0 4px 4px 0;
            background-color: #e9ecef;
            color: #444444;
            padding: 6px 12px;
        }
        
        .input-group.srchsresourcegrp .input-group-btn .btn:hover {
            background-color: #dee2e6;
            color: #333333;
        }
        
        .content-area {
            background-color: #fff;
            margin: 0 20px 20px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .offcanvas {
            position: fixed;
            top: 0;
            right: -100%;
            width: 800px;
            height: 100vh;
            background-color: #fff;
            box-shadow: -2px 0 10px rgba(0,0,0,0.1);
            transition: right 0.3s ease;
            z-index: 1050;
            overflow-y: auto;
        }
        
        .offcanvas.show {
            right: 0;
        }
        
        .offcanvas-header {
            background-color: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .offcanvas-navbar {
            background-color: #fff;
            padding: 15px 20px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
        
        .offcanvas-title {
            font-size: 20px;
            font-weight: 600;
            color: #4263c1;
            margin: 0;
        }
        
        .offcanvas-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .offcanvas-actions .btn {
            padding: 4px 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .offcanvas-actions .btn-success {
            background-color: #ffc107;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 12px;
        }
        
        .offcanvas-actions .btn-success:hover {
            background-color: #e0a800;
            color: white;
        }
        
        .offcanvas-actions .btn-danger, .offcanvas-actions .btn-secondary {
            background-color: white;
            color: #1359a6;
            border: 1px solid #1359a6;
            border-radius: 4px;
        }
        
        .offcanvas-actions .btn-danger:hover, .offcanvas-actions .btn-secondary:hover {
            background-color: #1359a6;
            color: white;
        }
        
        .offcanvas-close {
            background: none;
            border: none;
            font-size: 18px;
            color: #666;
            cursor: pointer;
            padding: 5px;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: background-color 0.2s ease;
        }
        
        .offcanvas-close:hover {
            background-color: #e9ecef;
            color: #333;
        }
        
        .offcanvas-body {
            padding: 15px 20px;
            max-height: calc(100vh - 80px);
            overflow-y: auto;
        }
        
        .mandatory-note {
            color: #6c757d;
            font-size: 11px;
            margin-bottom: 10px;
            font-style: italic;
            text-align: right;
        }
        
        .mandatory-note .asterisk {
            color: #dc3545;
        }
        
        .offcanvas-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-column {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .form-group {
            flex: 1;
            margin-bottom: 8px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 2px;
            font-weight: 400;
            color: #2c3e50;
            font-size: 12px;
        }
        
        .form-group label.required::after {
            content: " *";
            color: #dc3545;
        }
        
        .form-control {
            width: 100%;
            padding: 6px 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 13px;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 1px rgba(0, 123, 255, 0.1);
        }
        
        .form-control.is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .invalid-feedback {
            display: block;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #dc3545;
        }
        
        .form-control[readonly] {
            background-color: #e9ecef;
        }
        
        textarea.form-control {
            resize: vertical;
            min-height: 60px;
            max-height: 80px;
        }
        
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .checkbox-group input[type="checkbox"] {
            width: 16px;
            height: 16px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.15s ease-in-out;
        }
        
        .btn-success {
            background-color: white;
            color: #28a745;
            border: 1px solid #28a745;
        }
        
        .btn-success:hover {
            background-color: #28a745;
            color: white;
        }
        
        .btn-secondary {
            background: #fff;
            border: 1px solid #6c757d;
            color: #6c757d;
            font-weight: 500;
            padding: 4px 16px;
        }
        
        .btn-secondary:hover {
            background: #6c757d;
            color: #fff;
        }
        
        .alertify-notifier {
            position: fixed !important;
            top: 20px !important;
            right: 20px !important;
            left: auto !important;
            bottom: auto !important;
            z-index: 9999 !important;
        }
        
        .alertify-notifier .ajs-message {
            position: relative !important;
            margin-bottom: 10px !important;
        }
        
        .sm_txt {
            font-size: 14px;
            color: #666;
        }
        
        .custmodal .modal-content {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            border: none;
        }
        
        .custmodal .modal-content .modal-header {
            display: block !important;
            background: #4263c1;
            border: none;
            color: #fff;
            border-radius: 8px 8px 0 0;
            padding: 15px 20px;
            text-align: center;
            position: relative;
        }
        
        .custmodal .modal-title {
            margin: 0;
            font-weight: 500;
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: #fff;
            text-align: center;
        }
        
        .custmodal .modal-content .modal-header .close {
            background: none;
            border: none;
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: #fff;
            opacity: 1;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            padding: 0;
            margin: 0;
        }
        
        .custmodal .modal-content .modal-header .close:hover {
            color: #fff;
            opacity: 0.8;
        }
        
        .custmodal .modal-body {
            padding: 20px;
            background-color: #fff;
            border-bottom: 1px solid #e5e5e5;
        }
        
        .custmodal .modal-footer {
            padding: 15px 20px;
            border-top: none;
            background-color: #fff;
            text-align: center;
        }
        
        .custmodal .btn.btnyellow {
            background: #fbb03b;
            color: #fff;
            border: 1px solid #fbb03b;
            padding: 6px 15px;
            font-weight: 500;
            border-radius: 4px;
            font-size: 12px;
        }
        
        .custmodal .btn.btnyellow:hover {
            background: #e6a035;
            border-color: #e6a035;
        }
        
        .custmodal .btn.borderbtn {
            background: #fff;
            color: #6c757d;
            border: 1px solid #6c757d;
            padding: 6px 15px;
            font-weight: 500;
            border-radius: 4px;
            font-size: 12px;
        }
        
        .custmodal .btn.borderbtn:hover {
            background: #6c757d;
            color: #fff;
        }
        
        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        
        .no-data i {
            font-size: 48px;
            margin-bottom: 20px;
            color: #dee2e6;
        }
        
        .btn-danger {
            background: #fff !important;
            border: 1px solid #1359a6 !important;
            color: #1359a6 !important;
            font-weight: 500;
            padding: 4px 16px;
            min-width: 80px;
        }
        
        .btn-danger:hover {
            background: #1359a6 !important;
            color: #fff !important;
        }
        
        .btn-danger:active, .btn-danger:focus {
            background: #1359a6 !important;
            color: #fff !important;
            border-color: #1359a6 !important;
            box-shadow: none !important;
        }
        
        .offcanvas-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1040;
            display: none;
        }
        
        .offcanvas-backdrop.show {
            display: block;
        }
        
        .loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-color: rgba(255, 255, 255, 0.9);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            color: #4263c1;
            font-size: 18px;
            font-weight: 600;
        }
        
        .loading i {
            font-size: 48px;
            margin-bottom: 20px;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @media (max-width: 1024px) {
            .offcanvas {
                width: 100%;
            }
        }
        
        @media (max-width: 768px) {
            .input-group.srchsresourcegrp.float-end {
                width: 200px;
            }
            
            .page-header {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
                padding: 12px 15px;
            }
            
            .header-icon {
                width: 30px;
                height: 30px;
                font-size: 16px;
                margin-right: 12px;
            }
            
            .page-title {
                font-size: 18px;
            }
            
            .page-subtitle {
                font-size: 12px;
            }
        }
        
        .pagination-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin: 15px 20px;
            padding: 0;
            gap: 20px;
        }
        
        .pagination-info {
            color: #333;
            font-size: 14px;
            font-weight: 300;
        }
        
        .pagination {
            margin-bottom: 20px !important;
            margin-top: 20px !important;
        }
        
        .pagination .page-item {
            margin: 0 2px;
        }
        
        .pagination .page-link {
            padding: 8px 12px;
            color: #1359a6;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .pagination .page-link:hover {
            color: #fff;
            background-color: #1359a6;
            border-color: #1359a6;
        }
        
        .pagination .page-item.fa-disabled .page-link {
            color: #6c757d;
            background-color: #f8f9fa;
            border-color: #dee2e6;
            cursor: not-allowed;
            pointer-events: none;
        }
        
        .pagination .page-item.fa-disabled .page-link:hover {
            color: #6c757d;
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }
        
        .phases-section, .configurable-items-section {
            padding: 20px;
        }
        
        .section-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4263c1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .section-title-with-back {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .btn-back {
            background-color: #6c757d;
            color: white;
            border: 1px solid #6c757d;
            padding: 4px 16px;
            font-size: 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: 500;
        }
        
        .btn-back:hover {
            background-color: #5a6268;
            color: white;
            border-color: #545b62;
        }
        
        .section-title {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 400;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title h3 {
            font-weight: 400;
            margin: 0;
        }
        
        .phases-list {
            display: flex;
            flex-direction: column;
        }
        
        .phase-item {
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: underline;
            color: #000000;
            font-weight: 300;
            font-size: 14px;
        }
        
        .phase-item:hover {
            background-color: #f8f9fa;
            color: #333333;
        }
        
        .phase-item:nth-child(even) {
            background-color: #fafbfc;
        }
        
        .phase-item:nth-child(even):hover {
            background-color: #f1f3f4;
        }
        
        .section-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .configurable-items-table-container {
            overflow-x: auto;
            max-height: 70vh;
            overflow-y: auto;
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        
        .configurable-items-table-container::-webkit-scrollbar {
            display: none;
        }
        
        .configurable-items-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
        .configurable-items-table th {
            background-color: rgb(231, 237, 240);
            color: #6c757d;
            padding: 16px 12px;
            text-align: left;
            font-weight: 400;
            font-size: 14px;
            border: none;
            border-bottom: 2px solid #dee2e6;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        .configurable-items-table td {
            padding: 16px 12px;
            border-bottom: 1px solid #e9ecef;
            font-size: 13px;
            vertical-align: middle;
            transition: background-color 0.2s ease;
        }
        
        .configurable-items-table td.number-center {
            text-align: center;
        }
        
        .configurable-items-table tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .configurable-items-table tbody tr:nth-child(even) {
            background-color: #fafbfc;
        }
        
        .configurable-items-table tbody tr:nth-child(even):hover {  
            background-color: #f1f3f4;
        }
        
        .category-link {
            color: #4263c1;
            text-decoration: underline;
            cursor: pointer;
            font-weight: 400;
        }
        
        .category-link:hover {
            color: #0056b3;
        }
        
        .total-row {
            background-color: #f8f9fa !important;
            border-top: 2px solid #dee2e6 !important;
            margin-top: 10px;
            border-radius: 4px;
        }
        
        .total-row:hover {
            background-color: #f8f9fa !important;
        }
        
        .total-label {
            color: #495057;
        }
        
        .total-value {
            color: #4263c1;
        }
        
        .btn-primary {
            background: #fff;
            border: 1px solid #1359a6;
            color: #1359a6;
            font-weight: 500;
            padding: 4px 16px;
            min-width: 80px;
        }
        
        .btn-primary:hover {
            background: #1359a6;
            color: #fff;
        }
        
        .btn-primary:active, .btn-primary:focus {
            background: #1359a6;
            color: #fff;
            border-color: #1359a6;
            box-shadow: none;
        }
        
        .btn-primary i {
            margin-right: 4px;
        }
        
        .text-center {
            text-align: center;
        }
          
        .document-category-dropdown-container {
            position: relative;
            width: 100%;
        }
        
        .document-category-dropdown-display {
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 6px 30px 6px 12px;
            font-size: 14px;
            color: #495057;
            width: 100%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
            min-height: 38px;
        }
        
        .document-category-dropdown-display:hover {
            border-color: #4263c1;
        }
        
        .document-category-dropdown-display.disabled {
            background-color: #f8f9fa;
            cursor: not-allowed;
            opacity: 0.6;
        }
        
        .document-category-dropdown-display.disabled:hover {
            border-color: #ced4da;
        }
        
        .document-category-selected-text {
            flex: 1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .document-category-dropdown-arrow {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #495057;
            font-size: 12px;
            pointer-events: none;
        }
        
        .document-category-search-field {
            width: 100%;
            padding: 8px 12px;
            border: none;
            border-bottom: 1px solid #e9ecef;
            font-size: 14px;
            outline: none;
        }
        
        .document-category-dropdown-list {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: #fff;
            border: 1px solid #ced4da;
            border-top: none;
            border-radius: 0 0 4px 4px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            scrollbar-width: none;
            -ms-overflow-style: none;
        }
        
        .document-category-dropdown-list::-webkit-scrollbar {
            width: 0px;
            background: transparent;
        }
        
        .document-category-item {
            padding: 8px 12px;
            cursor: pointer;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }
        
        .document-category-item:hover {
            background-color: #f8f9fa;
        }
        
        .document-category-item:last-child {
            border-bottom: none;
        }
    </style>
</head>

<body>
    <% If m_blnViewAccess Then %>
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-icon">
                <i class="fas fa-cogs"></i>
            </div>
            <div class="header-content">
                <h1 class="page-title"><%=MyBase.GetResourceString("C_SCM")%></h1>
                <p class="page-subtitle"><%=MyBase.GetResourceString("C_SCMDesc")%></p>
            </div>
        </div>
        
         <!-- Search Section -->
         <div class="search-section">
             <div class="left-section">
                 <div class="selected-phase-section" id="selectedPhaseSection" style="display: none;">
                     <span class="selected-phase-label"><%=MyBase.GetResourceString("C_SelectedPhase")%>:</span>
                     <span class="selected-phase-name" id="selectedPhaseName"></span>
                 </div>
                 <div class="project-section" id="projectSection">
                     <label for="ddlProject" class="project-label"><%=MyBase.GetResourceString("C_SelectProject")%></label>
                     <div class="project-dropdown-wrapper">
                         <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='form-control'",,,) %>
                     </div>
                 </div>
             </div>
             <div class="right-section">
                 <div class="input-group srchsresourcegrp float-end">
                     <input id="searchInput" type="text" placeholder="<%=MyBase.GetResourceString("C_Search")%>.." class="form-control">
                     <div class="input-group-btn">
                         <button class="btn btn-default" type="submit" style="height:35px;"><i class="fas fa-search"></i></button>
                     </div>
                 </div>
                 <button class="filter-btn" id="filterBtn" title="<%=MyBase.GetResourceString("C_Filter")%>">
                     <i class="fas fa-filter"></i>
                 </button>
             </div>
         </div>
         
         <!-- Filter Panel -->
         <div class="filter-panel" id="filterPanel" style="display: none;">
             <div class="filter-tabs">
                 <div class="filter-tab active" data-tab="basic"><%=MyBase.GetResourceString("C_BasicFilters")%></div>
             </div>
             
             <div class="filter-actions">
                 <button class="btn btn-warning"><%=MyBase.GetResourceString("C_Apply")%></button>
                 <button class="btn btn-secondary"><%=MyBase.GetResourceString("C_ClearAll")%></button>
             </div>
             
             <div class="filter-content">
                 <div class="filter-tab-content active" id="basicFilters">
                     <div class="filter-row">
                         <div class="filter-field">
                             <label><%=MyBase.GetResourceString("C_Phase")%></label>
                             <select class="form-control filter-operator">
                                 <option value="contains"><%=MyBase.GetResourceString("C_Contains")%></option>
                                 <option value="ends_with"><%=MyBase.GetResourceString("C_EndsWith")%></option>
                                 <option value="exact_word"><%=MyBase.GetResourceString("C_ExactWord")%></option>
                                 <option value="not_contains"><%=MyBase.GetResourceString("C_NotContains")%></option>
                                 <option value="starts_with"><%=MyBase.GetResourceString("C_StartsWith")%></option>
                             </select>
                         </div>
                         <div class="filter-field">
                             <label>&nbsp;</label>
                             <input type="text" id="phasefilterid" class="form-control" placeholder="<%=MyBase.GetResourceString("C_EnterPhaseName")%>">
                         </div>
                     </div>
                 </div>
             </div>
         </div>
         
         <!-- Phase Selection Section - Commented out for now -->
         <!--
         <div class="action-bar">
             <div class="phase-selection-container">
                 <div class="phase-info">
                     <span class="phase-label"><%=MyBase.GetResourceString("C_Phase")%> :</span>
                     <span class="phase-name" id="currentPhaseName">Coding and Development</span>
                 </div>
                 <div class="phase-dropdown-container">
                     <label for="phaseSelect" class="required">Phase</label>
                     <select id="phaseSelect" class="form-control phase-select" onchange="changePhase()">
                         <option value="Coding and Development">Coding and Development</option>
                         <option value="Contract and Commercials">Contract and Commercials</option>
                         <option value="Design">Design</option>
                         <option value="Disposition and Project Completion">Disposition and Project Completion</option>
                         <option value="Initiation Planning and Estimation">Initiation Planning and Estimation</option>
                         <option value="Project Initiation">Project Initiation</option>
                         <option value="Requirement Analysis">Requirement Analysis</option>
                         <option value="Requirement Gathering">Requirement Gathering</option>
                         <option value="Testing">Testing</option>
                         <option value="Training">Training</option>
                     </select>
                 </div>
             </div>
         </div>
         -->
        
        <!-- SCM Phases List View -->
        <div class="content-area" id="phasesListView">
            <div class="phases-section">
                 <div class="section-header">
                     <div class="section-title-with-back">
                         <h3 class="section-title">
                             <%=MyBase.GetResourceString("C_Phase")%>
                         </h3>
                     </div>
                 </div>
                <div class="phases-list" id="phasesList">
                    <!-- Phases will be populated by JavaScript -->
                </div>
            </div>
        </div>
        
        <!-- Configurable Items View -->
        <div class="content-area configurable-items-view" id="configurableItemsView" style="display: none;">
            <div class="configurable-items-section">
                 <div class="section-header">
                     <div class="section-title">
                         <h3 class="section-title"><%=MyBase.GetResourceString("C_ConfigurableItems")%></h3>
                     </div>
                     <div class="section-actions">
                         <% If m_blnAddAccess Then %>
                         <button class="btn btn-primary" onclick="addConfigurableItem()" title="<%=MyBase.GetResourceString("C_AddNewConfigurableItem")%>">
                             <i class="fas fa-plus"></i> <%=MyBase.GetResourceString("C_Add")%>
                         </button>
                         <% End If %>
                         <% If m_blnDeleteAccess Then %>
                         <button class="btn btn-danger" onclick="deleteSelectedItems()" title="<%=MyBase.GetResourceString("C_DeleteSelectedItems")%>"><%=MyBase.GetResourceString("C_Delete")%></button>
                         <% End If %>
                         <% If m_blnDeleteAccess Then %>
                         <button class="btn btn-secondary" onclick="selectAllItems()" title="<%=MyBase.GetResourceString("C_SelectAllItems")%>"><%=MyBase.GetResourceString("C_SelectAll")%></button>
                         <button class="btn btn-secondary" onclick="clearAllItems()" title="<%=MyBase.GetResourceString("C_ClearAllSelections")%>"><%=MyBase.GetResourceString("C_ClearAll")%></button>
                         <% End If %>
                         <button class="btn btn-back" onclick="goBackToPhases()" title="<%=MyBase.GetResourceString("C_GoBackToPhases")%>">
                             <i class="fas fa-arrow-left"></i> <%=MyBase.GetResourceString("C_Back")%>
                         </button>
                     </div>
                 </div>
                <div class="configurable-items-table-container">
                    <div id="configurableItemsContainer">
                        <div class="loading" id="loadingOverlay">
                            <i class="fas fa-spinner"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Pagination -->
        <div class="pagination-container">
            <div class="pagination-info" id="paginationInfo">
                <span class="spntotal"><%=MyBase.GetResourceString("C_TotalRecords")%> : </span>
                <span class="spntotal" id="totalRecords">0</span>
            </div>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-end">
                    <li class="page-item" id="btnprevious">
                        <a class="page-link" aria-label="Previous" onclick="goToFirstPage()" title="<%=MyBase.GetResourceString("C_GoToFirstPage")%>" id="LinkPrevious">
                            <i class="fas fa-angle-double-left"></i>
                        </a>
                    </li>
                    <li class="page-item" id="btnnext">
                        <a class="page-link" aria-label="Next" onclick="goToLastPage()" title="<%=MyBase.GetResourceString("C_GoToLastPage")%>" id="LinkNext">
                            <i class="fas fa-angle-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    <% Else %>
    <div style="text-align:center;overflow: auto;width: 100%;;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>
    <% End If %>

     <!-- Offcanvas for Add/Edit Configurable Item -->
     <div class="offcanvas" id="configurableItemOffcanvas">
         <div class="offcanvas-header">
             <h2 class="offcanvas-title" id="offcanvasTitle"><%=MyBase.GetResourceString("C_ConfigurableItems")%></h2>
             <button class="offcanvas-close" onclick="closeConfigurableItemOffcanvas()" title="<%=MyBase.GetResourceString("C_Close")%>">
                 <i class="fas fa-times"></i>
             </button>
         </div>
         
         <div class="offcanvas-navbar">
             <div class="offcanvas-actions">
                 <% If m_blnAddAccess Or m_blnEditAccess Then %>
                 <button class="btn btn-success" onclick="saveConfigurableItem()" title="<%=MyBase.GetResourceString("C_Save")%>"><%=MyBase.GetResourceString("C_Save")%></button>
                 <% End If %>
                 <% If m_blnAddAccess Then %>
                 <button class="btn btn-success" onclick="saveAndAddConfigurableItem()" title="<%=MyBase.GetResourceString("C_SaveAdd")%>"><%=MyBase.GetResourceString("C_SaveAdd")%></button>
                 <% End If %>
             </div>
         </div>
         
         <div class="offcanvas-body">
             <div id="messageContainer"></div>
             <div class="mandatory-note">(<span class="asterisk">*</span> <%=MyBase.GetResourceString("C_Mandatory")%>)</div>
             
             <form id="configurableItemForm">
                 <div class="offcanvas-form-grid">
                     <!-- Left Column -->
                     <div class="form-column">
                        <div class="form-group">
                            <label for="documentCategory" class="required"><%=MyBase.GetResourceString("C_DocumentCategory")%></label>
                            <div class="document-category-dropdown-container">
                                <div class="document-category-dropdown-display" id="documentCategoryDropdownDisplay">
                                    <span class="document-category-selected-text"><%=MyBase.GetResourceString("A_SelectDocumentCategory")%></span>
                                    <i class="fas fa-chevron-down document-category-dropdown-arrow"></i>
                                </div>
                                <div class="document-category-dropdown-list" id="documentCategoryDropdownList" style="display: none;">
                                    <!-- Document categories will be loaded dynamically -->
                                </div>
                            </div>
                            <!-- Hidden input to store the selected value -->
                            <input type="hidden" id="documentCategory" name="documentCategory" value="">
                        </div>
                     </div>
                     
                     <!-- Right Column -->
                     <div class="form-column">
                            <div class="form-group">
                                <label for="numberOfItems" class="required"><%=MyBase.GetResourceString("C_NumberOfConfigurableItems")%></label>
                                <input type="number" id="numberOfItems" name="numberOfItems" class="form-control" min="1" max="99999" maxlength="5" pattern="[0-9]+" title="<%=MyBase.GetResourceString("A_NumberOfItemsMinValue")%>" oninput="validateNumberInput(this)">
                            </div>
                     </div>
                 </div>
             </form>
         </div>
     </div>

    
     <!-- Offcanvas Backdrop -->
     <div class="offcanvas-backdrop" id="offcanvasBackdrop" onclick="closeAllOffcanvas()"></div>

     <!-- Confirmation Modal for Delete -->
     <div id="ConfirmMessagemodalinfo" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
         <div class="modal-dialog">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" id="btnConfirmTaskNo1" data-bs-dismiss="modal">&times;</button>
                     <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteConfirmation")%></h4>
                 </div>
                 <div class="modal-body">
                     <span class="sm_txt" id="ConfirmationMsg"><%=MyBase.GetResourceString("C_ConfirmDeleteSelectedItems")%></span>
                 </div>
                 <div class="modal-footer">
                     <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnConfirmTaskNo"><%=MyBase.GetResourceString("C_No")%></button>
                     <button class="btn btnyellow" data-bs-toggle="modal" data-bs-dismiss="modal" id="btnConfirmTaskYes"><%=MyBase.GetResourceString("C_Yes")%></button>
                     <div class="clearfix"></div>
                 </div>
             </div>
         </div>
     </div>

    <script>
        // API Configuration - Updated for .NET Core API
        ////////var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        // Remove trailing slash if present to avoid double slashes
        if (strUrl.endsWith('/')) {
            strUrl = strUrl.slice(0, -1);
        }
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
        
        // Global Variables
        let currentPhase = "";
        let currentPhaseID = null;
        let currentView = "phases"; // "phases" or "configurableItems"
        let phasesData = [];
        let configurableItemsData = [];
        let selectedItemIds = [];
        let currentPage = 1;
        let itemsPerPage = 10;
        let totalPages = 1;
        let allConfigurableItems = [];
        let currentProjectID = parseInt('<%=GetProjectID()%>'); // Get from server-side (URL parameter)
        let currentUserID = parseInt('<%=GetUserID()%>');
        let currentUserName = '<%=GetUserName()%>';
        let currentLoginType = '<%=Session("LoginType")%>';
        
        // Permission variables
        let hasViewAccess = <%=m_blnViewAccess.ToString().ToLower()%>;
        let hasAddAccess = <%=m_blnAddAccess.ToString().ToLower()%>;
        let hasEditAccess = <%=m_blnEditAccess.ToString().ToLower()%>;
        let hasDeleteAccess = <%=m_blnDeleteAccess.ToString().ToLower()%>;

        // Enhanced AJAX helper with better error handling
        function AJAXCallWithResult(url, param, async) {
            var result = null;
            var fullUrl = buildUrl(url);
            
            $.ajax({
                url: encodeURI(fullUrl),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                    xhr.setRequestHeader('Accept', 'application/json');      
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    result = data;
                },
                error: function (jqXHR) {
                    console.log(jqXHR);
                }
            });
            return result;
        }

        // URL building helper
        function buildUrl(url) {
            if (strUrl.endsWith('/') && url.startsWith('/')) {
                return strUrl + url.substring(1);
            } else if (strUrl.endsWith('/') && !url.startsWith('/')) {
                return strUrl + url;
            } else if (!strUrl.endsWith('/') && url.startsWith('/')) {
                return strUrl + url;
            } else {
                return strUrl + '/' + url;
            }
        }


        $(document).ready(function() {
            // Configure alertify globally
            alertify.set('notifier', 'position', 'top-right');
            alertify.set('notifier', 'delay', 5);
            
            // Prevent default form submission to avoid browser validation
            $('form').on('submit', function(e) {
                e.preventDefault();
                return false;
            });
            
            // Initialize project dropdown with search functionality
            if (typeof $.fn.selectpicker !== 'undefined') {
                $('#cboProject').selectpicker({
                    liveSearch: true,
                    liveSearchStyle: 'startsWith'
                });
            }
            
            setupEventListeners();
            
            // Load phases on page load if project is selected
            if (currentProjectID > 0) {
                loadPhasesData();
            }
        });

        function setupEventListeners() {
            // Search functionality
            $('#searchInput').on('keyup', function() {
                const searchTerm = $(this).val().trim();
                if (currentView === "phases") {
                    if (searchTerm.length > 0) {
                        filterPhasesList(searchTerm);
                    } else {
                        displayPhasesList();
                    }
                } else {
                    if (searchTerm.length > 0) {
                        filterConfigurableItems(searchTerm);
                    } else {
                        displayConfigurableItems();
                    }
                }
            });
            
            // Filter button functionality
            $('#filterBtn').on('click', function() {
                $('#filterPanel').toggle();
            });
            
            // Filter panel show/hide events
            $('#filterPanel').on('show', function() {
                $('#filterBtn').addClass('active');
            });
            
            $('#filterPanel').on('hide', function() {
                // Only remove active class if no filters are currently applied
                if (!$('#filterBtn').hasClass('filter-applied')) {
                    $('#filterBtn').removeClass('active');
                }
            });
            
            // Filter apply functionality
            $('.filter-actions .btn-warning').on('click', function() {
                applyFilters();
            });
            
            // Filter clear functionality
            $('.filter-actions .btn-secondary').on('click', function() {
                clearFilters();
            });
            
            
            // Hide dropdown when clicking outside
            $(document).on('click', function(e) {
                if (!$(e.target).closest('.document-category-dropdown-container').length) {
                    $('#documentCategoryDropdownList').hide();
                }
            });
            
            // Document category dropdown functionality
            $('#documentCategoryDropdownDisplay').on('click', function() {
                if (!$(this).hasClass('disabled')) {
                    $('#documentCategoryDropdownList').toggle();
                    $('.document-category-search-field').focus();
                }
            });
            
            // Document category search functionality
            $(document).on('input', '.document-category-search-field', function() {
                const searchTerm = $(this).val().toLowerCase();
                
                if (searchTerm.length === 0) {
                    // If search term is empty, show all available (non-used) items
                    $('.document-category-item').each(function() {
                        const $item = $(this);
                        const isUsed = $item.hasClass('used-category');
                        
                        if (!isUsed) {
                            $item.css('display', 'block');
                        } else {
                            $item.css('display', 'none');
                        }
                    });
                } else {
                    // Collect matching items with priority scoring
                    const matchingItems = [];
                    
                    $('.document-category-item').each(function() {
                        const $item = $(this);
                        const text = $item.text().toLowerCase();
                        const isUsed = $item.hasClass('used-category');
                        
                        if (!isUsed) {
                            // Only show items that START with the search term
                            if (text.startsWith(searchTerm)) {
                                matchingItems.push({
                                    element: $item,
                                    text: text,
                                    priority: 100
                                });
                            }
                        }
                        
                        // Hide all items first
                        $item.css('display', 'none');
                    });
                    
                    // Sort by priority (highest first), then alphabetically
                    matchingItems.sort(function(a, b) {
                        if (a.priority !== b.priority) {
                            return b.priority - a.priority; // Higher priority first
                        }
                        return a.text.localeCompare(b.text); // Alphabetical within same priority
                    });
                    
                    // Show matching items in sorted order
                    matchingItems.forEach(function(item) {
                        item.element.css('display', 'block');
                    });
                }
            });
            
            // Document category item selection
            $(document).on('click', '.document-category-item', function() {
                const categoryID = parseInt($(this).data('value'));
                const categoryName = $(this).text();
                selectDocumentCategory(categoryID, categoryName);
            });
            
        }
        
        // Filter functions based on existing system logic - Updated for .NET Core API
        function applyFilters() {
            const phaseOperator = $('.filter-operator').val();
            const phaseValue = $('#phasefilterid').val();
            
            // Check if no filter is selected
            if (!phaseValue || phaseValue.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%=MyBase.GetResourceString("A_PleaseSelectFilterBeforeApplying")%>', 'error', 5);
                return;
            }
            
            if (phaseValue && phaseValue.trim() !== '') {
                if (currentView === 'phases') {
                    // Use local filtering with the selected operator
                    if (!phasesData || phasesData.length === 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_PleaseSelectProjectFirstToLoadPhases")%>', 'error', 5);
                        return;
                    }
                    
                    const filteredPhases = filterPhasesByOperator(phasesData, phaseOperator, phaseValue);
                    
                    if (filteredPhases.length > 0) {
                        displayFilteredPhases(filteredPhases);
                        $('#filterBtn').addClass('active filter-applied');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_FilterAppliedSuccess")%>', 'success', 5);
                    } else {
                        $('#phasesList').html('<div class="no-data"><i class="fas fa-search"></i><br><%=MyBase.GetResourceString("A_NoDataFoundMatchingFilter")%></div>');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_NoDataFoundMatchingFilter")%>', 'error', 5);
                    }
                } else {
                    // For configurable items, use local filtering
                    const items = configurableItemsData || [];
                    const filteredItems = filterConfigurableItemsByOperator(items, phaseOperator, phaseValue);
                    if (filteredItems.length > 0) {
                        displayFilteredConfigurableItems(filteredItems);
                        $('#filterBtn').addClass('active filter-applied');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_FilterAppliedSuccess")%>', 'success', 5);
                    } else {
                        $('#configurableItemsContainer').html('<div class="no-data"><i class="fas fa-search"></i><br><%=MyBase.GetResourceString("A_NoDataFoundMatchingFilter")%></div>');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_NoDataFoundMatchingFilter")%>', 'error', 5);
                    }
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%=MyBase.GetResourceString("A_PleaseEnterValueToFilter")%>', 'error', 5);
            }
        }
        
        function clearFilters() {
            $('.filter-operator').val('contains');
            $('#phasefilterid').val('');
            $('#filterBtn').removeClass('active filter-applied');
            
            // Reset to original data by reloading phases
            if (currentView === 'phases') {
                loadPhasesData();
            } else {
                displayConfigurableItems();
            }
            
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%=MyBase.GetResourceString("A_FiltersCleared")%>', 'success', 5);
        }
        
        function filterPhasesByOperator(phases, operator, value) {
            return phases.filter(phase => {
                const phaseName = phase.PhaseName || phase;
                const searchValue = value.toLowerCase();
                const phaseValue = phaseName.toLowerCase();
                
                switch(operator) {
                    case 'contains':
                        return phaseValue.includes(searchValue);
                    case 'starts_with':
                        return phaseValue.startsWith(searchValue);
                    case 'ends_with':
                        return phaseValue.endsWith(searchValue);
                    case 'exact_word':
                        return phaseValue === searchValue;
                    case 'not_contains':
                        return !phaseValue.includes(searchValue);
                    default:
                        return phaseValue.includes(searchValue);
                }
            });
        }
        
        function filterConfigurableItemsByOperator(items, operator, value) {
            return items.filter(item => {
                const searchValue = value.toLowerCase();
                const itemValue = item.category.toLowerCase();
                
                switch(operator) {
                    case 'contains':
                        return itemValue.includes(searchValue);
                    case 'starts_with':
                        return itemValue.startsWith(searchValue);
                    case 'ends_with':
                        return itemValue.endsWith(searchValue);
                    case 'exact_word':
                        return itemValue === searchValue;
                    case 'not_contains':
                        return !itemValue.includes(searchValue);
                    default:
                        return itemValue.includes(searchValue);
                }
            });
        }
        
        function displayFilteredPhases(filteredPhases) {
            let html = '<div class="phases-list">';
            filteredPhases.forEach(phase => {
                const phaseName = phase.PhaseName || phase.Phase || phase;
                const phaseID = phase.PhaseID || phase.phaseID || 0;
                html += '<div class="phase-item" onclick="selectPhase(\'' + phaseName + '\', ' + phaseID + ')">' + phaseName + '</div>';
            });
            html += '</div>';
            $('#phasesList').html(html);
            updatePagination();
        }
        
        function displayFilteredConfigurableItems(filteredItems) {
            // Sort by ID descending to show most recent items first
            filteredItems.sort((a, b) => (b.id || 0) - (a.id || 0));
            
            let html = '<table class="configurable-items-table"><thead><tr>';
            html += '<th>Category</th>';
            html += '<th class="text-center"><%=MyBase.GetResourceString("C_NumberOfConfigurableItems")%></th>';
            html += '<th class="text-center">Action</th>';
            html += '</tr></thead><tbody>';
            
            filteredItems.forEach(item => {
                // Handle both regular configurable items and filtered results
                var itemId = item.scmPlanID || item.id;
                var category = item.category;
                var numberOfItems = item.noOfConfigItems || item.numberOfItems;
                
                html += '<tr>';
                html += '<td><span class="category-link" onclick="editConfigurableItem(' + itemId + ')">' + (category || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</span></td>';
                html += '<td class="number-center">' + (numberOfItems || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</td>';
                const isChecked = selectedItemIds.includes(itemId) ? 'checked' : '';
                html += '<td class="text-center"><input type="checkbox" onchange="toggleItemSelection(' + itemId + ')" ' + isChecked + ' /></td>';
                html += '</tr>';
            });
            
            // Add total row for filtered items
            const totalItems = filteredItems.reduce((sum, item) => {
                const numItems = parseFloat(item.noOfConfigItems || item.numberOfItems) || 0;
                return sum + numItems;
            }, 0);
            
            html += '<tr class="total-row">';
            html += '<td class="total-label"><strong>Total:</strong></td>';
            html += '<td class="number-center total-value"><strong>' + totalItems.toFixed(2) + '</strong></td>';
            html += '<td class="text-center"></td>';
            html += '</tr>';
            
            html += '</tbody></table>';
            $('#configurableItemsContainer').html(html);
            updatePagination();
        }
        
        function validateField(field) {
            const value = field.val().trim();
            const fieldId = field.attr('id');
            const isRequired = field.prop('required');
            
            // Clear previous error
            field.removeClass('is-invalid');
            field.next('.invalid-feedback').remove();
            
            if (isRequired && !value) {
                alertify.error('<%=MyBase.GetResourceString("A_FieldIsRequired")%>'.replace('{0}', field.attr('name')));
                return false;
            }
            
            // Specific validations
            if (value) {
                switch(fieldId) {
                }
            }
            
            return true;
        }



        function PlotProjectonChange() {
            var selectedProjectID = $('#cboProject').val();
            if (selectedProjectID && selectedProjectID !== '0') {
                currentProjectID = parseInt(selectedProjectID);
                // Load phases for the selected project
                loadPhasesData();
            }
        }
        
        // Handle selectpicker change event
        $(document).on('changed.bs.select', '#cboProject', function() {
            PlotProjectonChange();
        });
        
        function selectDocumentCategory(categoryID, categoryName) {
            $('#documentCategory').val(categoryID);
            $('.document-category-selected-text').text(categoryName);
            $('#documentCategoryDropdownList').hide();
        }

        function loadPhasesData() {
            if (currentProjectID === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%=MyBase.GetResourceString("A_PleaseSelectProjectFirst")%>', 'error', 5);
                return;
            }
            
            $('#loadingOverlay').show();
            
            // Clear any existing phase filter to ensure we get all phases
            $("#phasefilterid").val('');
            
            // API call to get SCM phases - Updated for .NET Core API
            var Parameters = {
                ProjectID: currentProjectID
            };
            var param = JSON.stringify(Parameters);

            var Result = AJAXCallWithResult('api/SCMPlan/GetSCMPhases', param, false);
            
            // Handle the nested response structure
            var phases = null;
            if (Result && Result.data && Result.data.data) {
                phases = Result.data.data;
            } else if (Result && Result.data) {
                phases = Result.data;
            } else {
                phases = Result;
            }
            
            if (phases && phases.length > 0) {
                // Process phases data
                phasesData = [];
                phases.forEach(function(item) {
                    phasesData.push({
                        PhaseID: item.phaseID,
                        PhaseName: item.phase
                    });
                });
                
                // Only display phases list, don't load configurable items yet
                $('#loadingOverlay').hide();
                displayPhasesList();
            } else {
                $('#loadingOverlay').hide();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%=MyBase.GetResourceString("A_NoPhasesFoundForProject")%>', 'error', 5);
            }
        }

        function loadConfigurableItemsForPhase(phaseID) {
            $('#loadingOverlay').show();
            
            // API call to get configurable items - Updated for .NET Core API
            var Parameters = {
                ProjectID: currentProjectID,
                PhaseID: phaseID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/SCMPlan/GetConfigurableItems', param, false);
            
            // Handle the nested response structure
            var items = null;
            if (Result && Result.data && Result.data.data) {
                items = Result.data.data;
            } else if (Result && Result.data) {
                items = Result.data;
            } else {
                items = Result;
            }
            
            if (items && items.length > 0) {
                configurableItemsData = items.map(function(item) {
                    return {
                        id: item.scmPlanID,
                        category: item.category,
                        numberOfItems: item.noOfConfigItems,
                        documentCategoryId: item.documentCategoryId
                    };
                });
            } else {
                configurableItemsData = [];
            }
            
            $('#loadingOverlay').hide();
            displayConfigurableItems();
        }

        function loadConfigurableItemsData() {
            // This function is no longer used - kept for backward compatibility
            // Load configurable items for each phase
            configurableItemsData = {};
            let loadedPhases = 0;
            
            phasesData.forEach(function(phase) {
                var Parameters = {
                    ProjectID: currentProjectID,
                    PhaseID: phase.PhaseID
                };
                var param = JSON.stringify(Parameters);
                var Result = AJAXCallWithResult("/api/PM_SCM/GetConfigurableItems", param, false);
                
                // Handle the nested response structure
                var items = null;
                if (Result && Result.data && Result.data.data) {
                    items = Result.data.data;
                } else if (Result && Result.data) {
                    items = Result.data;
                } else {
                    items = Result;
                }
                
                if (items && items.length > 0) {
                    configurableItemsData[phase.PhaseName] = items.map(function(item) {
                        return {
                            id: item.scmPlanID,
                            category: item.category,
                            numberOfItems: item.noOfConfigItems,
                            documentCategoryId: item.documentCategoryId
                        };
                    });
                } else {
                    configurableItemsData[phase.PhaseName] = [];
                }
                
                loadedPhases++;
                if (loadedPhases === phasesData.length) {
                    $('#loadingOverlay').hide();
                    displayPhasesList();
                }
            });
        }

        function displayPhasesList() {
            $('#loadingOverlay').hide();
            currentView = "phases";
            
            // Show phases view, hide configurable items view
            $('#phasesListView').show();
            $('#configurableItemsView').hide();
            
            if (phasesData.length === 0) {
                $('#phasesList').html('<div class="no-data"><i class="fas fa-inbox"></i><br><%=MyBase.GetResourceString("A_NoPhasesAvailable")%></div>');
                return;
            }

            let html = '';
            phasesData.forEach(function(phase, index) {
                html += '<div class="phase-item" onclick="selectPhase(\'' + phase.PhaseName + '\', ' + phase.PhaseID + ')">';
                html += phase.PhaseName;
                html += '</div>';
            });

            $('#phasesList').html(html);
            updatePagination();
        }
        
        function displayConfigurableItems() {
            $('#loadingOverlay').hide();
            currentView = "configurableItems";
            
            // Show configurable items view, hide phases view
            $('#phasesListView').hide();
            $('#configurableItemsView').show();
            
            allConfigurableItems = configurableItemsData || [];
             
            // Filter out placeholder rows (rows with null category and numberOfItems)
            const validItems = allConfigurableItems.filter(item => 
                item.category && item.category !== 'null' && 
                item.numberOfItems !== null && item.numberOfItems !== 'null'
            );
            
            // Sort by SCMPlanID descending to show most recent items first
            validItems.sort((a, b) => (b.id || 0) - (a.id || 0));
            
            if (validItems.length === 0) {
                $('#configurableItemsContainer').html('<div class="no-data"><i class="fas fa-inbox"></i><br><%=MyBase.GetResourceString("A_NoDataAvailableInTable")%></div>');
                updatePagination();
                return;
            }

             // Calculate pagination using valid items
             const startIndex = (currentPage - 1) * itemsPerPage;
             const endIndex = startIndex + itemsPerPage;
             const items = validItems.slice(startIndex, endIndex);

             let html = '<table class="configurable-items-table">';
             html += '<thead><tr>';
            html += '<th>Category</th>';
            html += '<th class="text-center"><%=MyBase.GetResourceString("C_NumberOfConfigurableItems")%></th>';
             html += '<th class="text-center">Action</th>';
             html += '</tr></thead><tbody>';

             items.forEach(function(item) {
                 html += '<tr>';
                 if (hasEditAccess) {
                     html += '<td><span class="category-link" onclick="editConfigurableItem(' + item.id + ')">' + (item.category || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</span></td>';
                 } else {
                     html += '<td>' + (item.category || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</td>';
                 }
                 html += '<td class="number-center">' + (item.numberOfItems || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</td>';
                 if (hasDeleteAccess) {
                     const isChecked = selectedItemIds.includes(item.id) ? 'checked' : '';
                     html += '<td class="text-center"><input type="checkbox" onchange="toggleItemSelection(' + item.id + ')" ' + isChecked + ' /></td>';
                 } else {
                     html += '<td class="text-center"></td>';
                 }
                 html += '</tr>';
             });

             // Add total row
             const totalItems = validItems.reduce((sum, item) => {
                 const numItems = parseFloat(item.numberOfItems) || 0;
                 return sum + numItems;
             }, 0);
             
             html += '<tr class="total-row">';
             html += '<td class="total-label"><%=MyBase.GetResourceString("C_Total")%></td>';
             html += '<td class="number-center total-value">' + totalItems.toFixed(2) + '</td>';
             html += '<td class="text-center"></td>';
             html += '</tr>';

             html += '</tbody></table>';
             $('#configurableItemsContainer').html(html);
             updatePagination();
         }

        function selectPhase(phaseName, phaseID) {
            currentPhase = phaseName;
            currentPhaseID = phaseID;
            $('#currentPhaseName').text(phaseName);
            $('#phaseSelect').val(phaseName);
            
            // Clear selections when switching phases
            clearSelections();
            
            // Show selected phase section and hide project section
            $('#selectedPhaseSection').show();
            $('#projectSection').hide();
            $('#selectedPhaseName').text(phaseName);
            
            // Keep search section visible but hide filter button and filter panel on configurable items view
            $('#filterBtn').addClass('hidden');
            $('#filterPanel').hide();
            
            // Load configurable items for the selected phase only
            loadConfigurableItemsForPhase(phaseID);
        }
        
        function changePhase() {
            const selectedPhase = $('#phaseSelect').val();
            selectPhase(selectedPhase);
        }
        
        function filterPhasesList(searchTerm) {
            if (!phasesData || phasesData.length === 0) {
                return;
            }
            
            const searchLower = searchTerm.toLowerCase();
            const filteredPhases = phasesData.filter(phase => 
                phase.PhaseName.toLowerCase().includes(searchLower)
            );
            
            // Sort: starts with search term first, then contains
            filteredPhases.sort((a, b) => {
                const aName = a.PhaseName.toLowerCase();
                const bName = b.PhaseName.toLowerCase();
                
                const aStartsWith = aName.startsWith(searchLower);
                const bStartsWith = bName.startsWith(searchLower);
                
                if (aStartsWith && !bStartsWith) return -1;
                if (!aStartsWith && bStartsWith) return 1;
                return aName.localeCompare(bName);
            });
            
            let html = '';
            filteredPhases.forEach(function(phase) {
                html += '<div class="phase-item" onclick="selectPhase(\'' + phase.PhaseName + '\')">';
                html += phase.PhaseName;
                html += '</div>';
            });
            
            $('#phasesList').html(html);
        }
        
        function filterConfigurableItems(searchTerm) {
            if (!configurableItemsData || configurableItemsData.length === 0) {
                return;
            }
            
            // First filter out placeholder rows
            const validItems = configurableItemsData.filter(item => 
                item.category && item.category !== 'null' && 
                item.numberOfItems !== null && item.numberOfItems !== 'null'
            );
            
            const searchLower = searchTerm.toLowerCase();
            const filteredItems = validItems.filter(item => 
                item.category.toLowerCase().includes(searchLower)
            );
            
            if (filteredItems.length === 0) {
                $('#configurableItemsContainer').html('<div class="no-data"><i class="fas fa-search"></i><br>No configurable items found matching your search</div>');
                return;
            }
            
            // Sort: starts with search term first, then contains, then by ID descending (most recent first)
            filteredItems.sort((a, b) => {
                const aCategory = a.category.toLowerCase();
                const bCategory = b.category.toLowerCase();
                
                const aStartsWith = aCategory.startsWith(searchLower);
                const bStartsWith = bCategory.startsWith(searchLower);
                
                if (aStartsWith && !bStartsWith) return -1;
                if (!aStartsWith && bStartsWith) return 1;
                
                // If both start with or both don't start with, sort by ID descending (most recent first)
                return (b.id || 0) - (a.id || 0);
            });

             let html = '<table class="configurable-items-table">';
             html += '<thead><tr>';
            html += '<th>Category</th>';
            html += '<th class="text-center"><%=MyBase.GetResourceString("C_NumberOfConfigurableItems")%></th>';
             html += '<th class="text-center">Action</th>';
             html += '</tr></thead><tbody>';

            filteredItems.forEach(function(item) {
                html += '<tr>';
                if (hasEditAccess) {
                    html += '<td><span class="category-link" onclick="editConfigurableItem(' + item.id + ')">' + (item.category || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</span></td>';
                } else {
                    html += '<td>' + (item.category || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</td>';
                }
                html += '<td class="number-center">' + (item.numberOfItems || '<%=MyBase.GetResourceString("A_NoDataAvailable")%>') + '</td>';
                if (hasDeleteAccess) {
                    const isChecked = selectedItemIds.includes(item.id) ? 'checked' : '';
                    html += '<td class="text-center"><input type="checkbox" onchange="toggleItemSelection(' + item.id + ')" ' + isChecked + ' /></td>';
                } else {
                    html += '<td class="text-center"></td>';
                }
                html += '</tr>';
            });

            // Add total row for filtered items
            const totalItems = filteredItems.reduce((sum, item) => {
                const numItems = parseFloat(item.numberOfItems) || 0;
                return sum + numItems;
            }, 0);
            
            html += '<tr class="total-row">';
            html += '<td class="total-label"><strong>Total:</strong></td>';
            html += '<td class="number-center total-value"><strong>' + totalItems.toFixed(2) + '</strong></td>';
            html += '<td class="text-center"></td>';
            html += '</tr>';

            html += '</tbody></table>';
            $('#configurableItemsContainer').html(html);
        }

         function addConfigurableItem() {
             // Load document categories from API
             loadDocumentCategories(function() {
                 // Open modal for adding new configurable item
                 $('#configurableItemOffcanvas').addClass('show');
                 $('#offcanvasBackdrop').addClass('show');
                 
                // Reset form
                $('#configurableItemForm')[0].reset();
                $('.document-category-selected-text').text('<%=MyBase.GetResourceString("A_SelectDocumentCategory")%>');
                $('#offcanvasTitle').text('<%=MyBase.GetResourceString("A_AddConfigurableItem")%>');
                 
                // Enable category selection for new items
                $('#documentCategoryDropdownDisplay').removeClass('disabled');
                 
                 // Clear any stored editing item ID
                 $('#configurableItemForm').removeData('editing-item-id');
                 
                 // Load configurable items for current phase first, then filter
                 if (currentPhaseID) {
                     loadConfigurableItemsForPhase(currentPhaseID);
                     // Filter after data is loaded
                     setTimeout(function() {
                         filterUsedCategories();
                     }, 200);
                 } else {
                     // If no phase selected, just show all categories
                     filterUsedCategories();
                 }
                 
                 // Clear any validation errors
                 $('.form-control').removeClass('is-invalid');
                 $('.invalid-feedback').remove();
             });
         }

        function loadDocumentCategories(callback) {
            // API call to get document categories - Updated for .NET Core API
            var Parameters = {
                ProjectID: currentProjectID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/SCMPlan/GetDocumentCategories', param, false);
            
            // Handle the nested response structure
            var categories = null;
            if (Result && Result.data && Result.data.data) {
                categories = Result.data.data;
            } else if (Result && Result.data) {
                categories = Result.data;
            } else {
                categories = Result;
            }
            
            if (categories && categories.length > 0) {
                // Store all categories globally for filtering
                window.allDocumentCategories = categories;
                
                // Populate document category dropdown
                populateDocumentCategoryDropdown(categories);
                
                if (callback) callback();
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%=MyBase.GetResourceString("A_ErrorLoadingDocumentCategories")%>', 'error', 5);
            }
        }
        
        function populateDocumentCategoryDropdown(categories) {
            var html = '<input type="text" class="document-category-search-field" placeholder="<%=MyBase.GetResourceString("C_Search")%> document categories..." autocomplete="off">';
            categories.forEach(function(category) {
                html += '<div class="document-category-item" data-value="' + category.categoryID + '">' + category.category + '</div>';
            });
            $('#documentCategoryDropdownList').html(html);
        }
        
        function filterUsedCategories() {
            // Get currently used categories in this phase
            var usedCategories = [];
            if (configurableItemsData && configurableItemsData.length > 0) {
                configurableItemsData.forEach(function(item) {
                    // Only add categories that are not null/empty
                    if (item.category && item.category !== 'null' && item.category.trim() !== '') {
                        usedCategories.push(item.category);
                    }
                });
            }
            
            
            // Ensure dropdown is visible for filtering
            $('#documentCategoryDropdownList').show();
            
            // Hide document category items that are already used
            $('.document-category-item').each(function() {
                var categoryText = $(this).text();
                var isUsed = usedCategories.includes(categoryText);
                
                
                if (isUsed) {
                    $(this).css('display', 'none');
                    $(this).addClass('used-category'); // Mark as used for search filtering
                } else {
                    $(this).css('display', 'block');
                    $(this).removeClass('used-category');
                }
            });
            
            // Count available options (only count actual category items, not search input)
            var totalCategoryOptions = $('.document-category-item').length;
            var hiddenCategoryOptions = $('.document-category-item[style*="display: none"]').length;
            var availableOptions = totalCategoryOptions - hiddenCategoryOptions;
            
            
            // If no categories available, show a message but preserve the search input
            if (availableOptions === 0) {
                var html = '<input type="text" class="document-category-search-field" placeholder="<%=MyBase.GetResourceString("C_Search")%> document categories..." autocomplete="off">';
                html += '<div class="document-category-item" style="text-align: center; color: #6c757d; font-style: italic;">All document categories have been used</div>';
                $('#documentCategoryDropdownList').html(html);
            } else {
                // Hide the dropdown after filtering
                $('#documentCategoryDropdownList').hide();
            }
        }
        
        function resetCategoryDropdown() {
            // Show all categories (used when editing existing items)
            $('.document-category-item').show();
            // Reload the dropdown with all categories
            if (window.allDocumentCategories) {
                populateDocumentCategoryDropdown(window.allDocumentCategories);
            }
        }
        
        function deleteSelectedItems() {
            if (selectedItemIds.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%=MyBase.GetResourceString("A_PleaseSelectItemsToDelete")%>', 'error', 5);
                return;
            }
            
            // Show confirmation modal
            $("#ConfirmationMsg").html('<%=MyBase.GetResourceString("A_ConfirmDeleteItems")%>');
            $("#ConfirmMessagemodalinfo").modal('show');
            
            // Wait for user response
            getConfirmationResponse().then(response => {
                if (response == 1) {
                // Delete each selected item via API - Updated for .NET Core API
                let deletedCount = 0;
                selectedItemIds.forEach(function(itemId) {
                    var Parameters = {
                        ConfigurableItemID: itemId,
                        CreatedBy: currentUserName
                    };
                    var param = JSON.stringify(Parameters);
                    var Result = AJAXCallWithResult('api/SCMPlan/DeleteConfigurableItem', param, false);
                    
                    // Check for success - the API returns rowsAffected: -1 for successful operations
                    if (Result && (Result.rowsAffected >= 0 || (Result.message && Result.message.includes('successfully')))) {
                        deletedCount++;
                    }
                });
                
                if (deletedCount > 0) {
                    selectedItemIds = [];
                    
                    // Refresh configurable items for current phase only
                    loadConfigurableItemsForPhase(currentPhaseID);
                    
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%=MyBase.GetResourceString("A_SelectedItemsDeletedSuccess")%>', 'success', 5);
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%=MyBase.GetResourceString("A_ErrorDeletingItems")%>', 'error', 5);
                }
                } else {
                    // User clicked No - do nothing
                }
            });
        }
        
         function selectAllItems() {
             const checkboxes = $('.configurable-items-table input[type="checkbox"]');
             checkboxes.prop('checked', true);
             
             // Get valid items from the current phase data (filter out placeholder rows)
             const allItems = configurableItemsData || [];
             const validItems = allItems.filter(item => 
                 item.category && item.category !== 'null' && 
                 item.numberOfItems !== null && item.numberOfItems !== 'null'
             );
             selectedItemIds = validItems.map(item => item.id);
         }
         
         function clearAllItems() {
             // Uncheck all checkboxes
             const checkboxes = $('.configurable-items-table input[type="checkbox"]');
             checkboxes.prop('checked', false);
             
             // Clear selected items array
             selectedItemIds = [];
         }
         
        
        function toggleItemSelection(itemId) {
            const index = selectedItemIds.indexOf(itemId);
            if (index > -1) {
                selectedItemIds.splice(index, 1);
            } else {
                selectedItemIds.push(itemId);
            }
        }
        
        function clearSelections() {
            selectedItemIds = [];
        }
        
        function getSelectedItemsCount() {
            return selectedItemIds.length;
        }
        
        function editConfigurableItem(itemId) {
            // Load item details from API - Updated for .NET Core API
            var Parameters = {
                ConfigurableItemID: itemId
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/SCMPlan/GetConfigurableItemDetails', param, false);
             
            // Handle the nested response structure
            var items = null;
            if (Result && Result.data && Result.data.data) {
                items = Result.data.data;
            } else if (Result && Result.data) {
                items = Result.data;
            } else {
                items = Result;
            }
             
             if (items && items.length > 0) {
                 var item = items[0];
                 
                 
                 // Load document categories and then populate form
                 loadDocumentCategories(function() {
                     // Open modal for editing
                     $('#configurableItemOffcanvas').addClass('show');
                     $('#offcanvasBackdrop').addClass('show');
                     
                     // Set the title
                     $('#offcanvasTitle').text('<%=MyBase.GetResourceString("A_EditConfigurableItem")%>');
                     
                     // Show all categories when editing (don't filter used ones)
                     resetCategoryDropdown();
                     
                    // Pre-populate the form with existing data
                    $('#documentCategory').val(item.documentCategoryId);
                    $('.document-category-selected-text').text(item.category);
                     
                     $('#documentCategoryDropdownDisplay').addClass('disabled'); // Disable category selection
                     $('#numberOfItems').val(item.noOfConfigItems);
                     
                     // Store the item ID for saving
                     $('#configurableItemForm').data('editing-item-id', itemId);
                     
                     // Clear any validation errors
                     $('.form-control').removeClass('is-invalid');
                     $('.invalid-feedback').remove();
                     
                 });
             } else {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify('<%=MyBase.GetResourceString("A_ErrorLoadingItemDetails")%>', 'error', 5);
             }
         }
        

        // Confirmation response function
        function getConfirmationResponse() {
            return new Promise(resolve => {
                $('#btnConfirmTaskYes').off('click').on('click', function () {
                    $("#ConfirmMessagemodalinfo").modal('hide');
                    resolve(1);
                });
                $('#btnConfirmTaskNo').off('click').on('click', function () {
                    $("#ConfirmMessagemodalinfo").modal('hide');
                    resolve(0);
                });
                $('#btnConfirmTaskNo1').off('click').on('click', function () {
                    $("#ConfirmMessagemodalinfo").modal('hide');
                    resolve(0);
                });
            });
        }

        // Navigation functions
        function goBackToPhases() {
            currentView = "phases";
            
            // Hide selected phase section and show project section when going back to phases
            $('#selectedPhaseSection').hide();
            $('#projectSection').show();
            
            // Show filter button on phases view (search section is always visible)
            $('#filterBtn').removeClass('hidden');
            
            displayPhasesList();
        }

        // Utility functions - showMessage function removed as we use alertify directly

         // Pagination Functions
         function updatePagination() {
             let totalRecords = 0;
             
             if (currentView === "phases") {
                 totalRecords = phasesData.length;
             } else {
                 // Filter out placeholder rows for configurable items
                 const validItems = allConfigurableItems.filter(item => 
                     item.category && item.category !== 'null' && 
                     item.numberOfItems !== null && item.numberOfItems !== 'null'
                 );
                 totalRecords = validItems.length;
             }
             
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
                 $('#LinkPrevious').attr('onclick', 'goToFirstPage()');
             }
             
             if (currentPage === totalPages || totalRecords === 0) {
                 $('#btnnext').addClass('fa-disabled');
                 $('#LinkNext').removeAttr('onclick');
             } else {
                 $('#btnnext').removeClass('fa-disabled');
                 $('#LinkNext').attr('onclick', 'goToLastPage()');
             }
         }
        
        function goToFirstPage() {
            currentPage = 1;
            if (currentView === "phases") {
                displayPhasesList();
            } else {
                displayConfigurableItems();
            }
        }
        
         function goToLastPage() {
             let totalRecords = 0;
             
             if (currentView === "phases") {
                 totalRecords = phasesData.length;
             } else {
                 // Filter out placeholder rows for configurable items
                 const validItems = allConfigurableItems.filter(item => 
                     item.category && item.category !== 'null' && 
                     item.numberOfItems !== null && item.numberOfItems !== 'null'
                 );
                 totalRecords = validItems.length;
             }
             
             totalPages = Math.ceil(totalRecords / itemsPerPage);
             currentPage = totalPages;
             
             if (currentView === "phases") {
                 displayPhasesList();
             } else {
                 displayConfigurableItems();
             }
         }
         
         
         function closeConfigurableItemOffcanvas() {
             $('#configurableItemOffcanvas').removeClass('show');
             $('#offcanvasBackdrop').removeClass('show');
         }
         
        function saveConfigurableItem() {
            // Validate form
            if (!validateConfigurableItemForm()) {
                return;
            }
             
             // Get form data
             const selectedCategoryText = $('.document-category-selected-text').text();
             const numberOfItems = parseInt($('#numberOfItems').val());
             const editingItemId = $('#configurableItemForm').data('editing-item-id');
             
             
             // Get the category ID from the selected option
             const documentCategoryId = $('#documentCategory').val();
             
             // API call to save configurable item - Updated for .NET Core API
             var url, Result;
             if (editingItemId) {
                 // Update existing item
                 var Parameters = {
                     ConfigurableItemID: editingItemId,
                     ProjectID: currentProjectID,
                     PhaseID: currentPhaseID,
                     DocumentCategoryID: documentCategoryId,
                     NumberOfItems: numberOfItems
                 };
                 var param = JSON.stringify(Parameters);
                 Result = AJAXCallWithResult('api/SCMPlan/UpdateSCMPlan', param, false);
             } else {
                 // Insert new item
                 var Parameters = {
                     ConfigurableItemID: 0,
                     ProjectID: currentProjectID,
                     PhaseID: currentPhaseID,
                     DocumentCategoryID: documentCategoryId,
                     NumberOfItems: numberOfItems
                 };
                 var param = JSON.stringify(Parameters);
                 Result = AJAXCallWithResult('api/SCMPlan/InsertSCMPlan', param, false);
             }
             
             
             // Check for success - the API returns rowsAffected: -1 for successful operations
             var isSuccess = false;
             if (Result) {
                 if (Result.rowsAffected >= 0 || Result.message && Result.message.includes('successfully')) {
                     isSuccess = true;
                 }
             }
             
             if (isSuccess) {
                 if (editingItemId) {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify('<%=MyBase.GetResourceString("A_ConfigurableItemUpdatedSuccess")%>', 'success', 5);
                 } else {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify('<%=MyBase.GetResourceString("A_ConfigurableItemAddedSuccess")%>', 'success', 5);
                 }
                 
                 // Refresh data and display
                 // Close modal first
                 closeConfigurableItemOffcanvas();
                 
                 // Then refresh data
                 setTimeout(function() {
                     loadConfigurableItemsForPhase(currentPhaseID);
                     // Re-filter categories after data refresh
                     setTimeout(function() {
                         filterUsedCategories();
                     }, 100);
                 }, 500);
             } else {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify('<%=MyBase.GetResourceString("A_ErrorSavingConfigurableItem")%>', 'error', 5);
             }
         }
         
         function saveAndAddConfigurableItem() {
             // Validate form
             if (!validateConfigurableItemForm()) {
                 return;
             }
             
             // Get form data
             const selectedCategoryText = $('.document-category-selected-text').text();
             const numberOfItems = parseInt($('#numberOfItems').val());
             const editingItemId = $('#configurableItemForm').data('editing-item-id');
             
             
             // Get the category ID from the selected option
             var documentCategoryId = $('#documentCategory').val();
             
             // API call to save configurable item - Updated for .NET Core API
             var url, Result;
             if (editingItemId) {
                 // Update existing item
                 var Parameters = {
                     ConfigurableItemID: editingItemId,
                     ProjectID: currentProjectID,
                     PhaseID: currentPhaseID,
                     DocumentCategoryID: documentCategoryId,
                     NumberOfItems: numberOfItems
                 };
                 var param = JSON.stringify(Parameters);
                 Result = AJAXCallWithResult('api/SCMPlan/UpdateSCMPlan', param, false);
             } else {
                 // Insert new item
                 var Parameters = {
                     ConfigurableItemID: 0,
                     ProjectID: currentProjectID,
                     PhaseID: currentPhaseID,
                     DocumentCategoryID: documentCategoryId,
                     NumberOfItems: numberOfItems
                 };
                 var param = JSON.stringify(Parameters);
                 Result = AJAXCallWithResult('api/SCMPlan/InsertSCMPlan', param, false);
             }
             
             // Check for success - the API returns rowsAffected: -1 for successful operations
             var isSuccess = false;
             if (Result) {
                 if (Result.rowsAffected >= 0 || (Result.message && Result.message.includes('successfully'))) {
                     isSuccess = true;
                 }
             }
             
             
             // Show success message and reset form for Save and Add
             if (Result) {
                 if (editingItemId) {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify('<%=MyBase.GetResourceString("A_ConfigurableItemUpdatedReadyAdd")%>', 'success', 5);
                 } else {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify('<%=MyBase.GetResourceString("A_ConfigurableItemAddedReadyAdd")%>', 'success', 5);
                 }
                 
                // Reset form for next entry
                $('#configurableItemForm')[0].reset();
                $('.document-category-selected-text').text('<%=MyBase.GetResourceString("A_SelectDocumentCategory")%>');
                $('#documentCategoryDropdownDisplay').removeClass('disabled');
                 $('#configurableItemForm').removeData('editing-item-id');
                 
                 // Refresh data and re-filter categories
                 loadConfigurableItemsForPhase(currentPhaseID);
                 
                 // Re-filter categories after data refresh
                 setTimeout(function() {
                     filterUsedCategories();
                 }, 500);
             } else {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify('<%=MyBase.GetResourceString("A_ErrorSavingConfigurableItem")%>', 'error', 5);
             }
         }
         
        function validateConfigurableItemForm() {
            let isValid = true;
            
            // Clear previous errors
            $('.form-control').removeClass('is-invalid');
            $('.invalid-feedback').remove();
            
            // Validate Document Category first
            const category = $('#documentCategory').val();
            const isCategoryDisabled = $('#documentCategoryDropdownDisplay').hasClass('disabled');
            const categoryText = $('.document-category-selected-text').text();
            
            // Always validate category if it's not disabled (for new items)
            if (!isCategoryDisabled && (!category || category === '' || categoryText === '<%=MyBase.GetResourceString("A_SelectDocumentCategory")%>')) {
                alertify.error('<%=MyBase.GetResourceString("A_DocumentCategoryRequired")%>');
                return false; // Stop validation here if category is not selected
            }
            
            // Only validate Number of Items if Document Category is valid
            const numberOfItems = $('#numberOfItems').val();
            
            // Check if field is empty or invalid
            if (!numberOfItems || numberOfItems.trim() === '' || isNaN(parseInt(numberOfItems))) {
                alertify.error('<%=MyBase.GetResourceString("A_NumberOfItemsRequired")%>');
                isValid = false;
            } else {
                // Check if value is 0 or negative
                const numValue = parseInt(numberOfItems);
                if (numValue <= 0) {
                    alertify.error('<%=MyBase.GetResourceString("A_NumberOfItemsMinValue")%>');
                    isValid = false;
                }
            }
            
            return isValid;
        }
         
         function showFieldError(fieldId, message) {
             const field = $('#' + fieldId);
             field.addClass('is-invalid');
            field.after('<div class="invalid-feedback">' + message + '</div>');
        }
        
        // Real-time validation for number input
        function validateNumberInput(input) {
            // Remove any non-numeric characters
            let value = input.value.replace(/[^0-9]/g, '');
            
            // Limit to 5 digits
            if (value.length > 5) {
                value = value.substring(0, 5);
            }
            
            // Update the input value
            input.value = value;
            
            // Visual feedback for validation
            if (value && (parseInt(value) < 1 || parseInt(value) > 99999)) {
                input.style.borderColor = '#dc3545';
            } else {
                input.style.borderColor = '';
            }
        }
        
        function closeAllOffcanvas() {
             $('.offcanvas').removeClass('show');
             $('#offcanvasBackdrop').removeClass('show');
         }
    </script>
</body>
</html>
</html>