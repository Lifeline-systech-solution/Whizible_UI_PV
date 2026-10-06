<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SCM_New.aspx.vb" Inherits="Whizible.SCM_New" %>

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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
         .main-container {
             padding: 0;
             background-color: #f5f5f5;
             min-height: 100vh;
             margin: 0;
         }
        
        .page-header {
            background-color: #fff;
            padding: 15px 20px;
            margin-bottom: 0;
            display: flex;
            align-items: center;
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
        }
        
         .page-title {
             color: #4263c1;
             font-size: 16px;
             font-weight: 400;
             margin: 0 0 4px 0;
             line-height: 1.2;
             font-family: 'Roboto', sans-serif

         }
        
        .page-subtitle {
            color: #6c757d;
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
        }
        
         .search-section {
             background-color: #f8f9fa;
             padding: 12px 20px;
             display: flex;
             justify-content: space-between;
             align-items: center;
             border-bottom: 1px solid #e9ecef;
             position: relative;
             margin-bottom: 20px;
         }
         
         .left-section {
             display: flex;
             align-items: center;
             gap: 20px;
         }
         
         .right-section {
             display: flex;
             align-items: center;
             gap: 10px;
         }
         
         .selected-phase-section {
             display: flex;
             align-items: center;
             gap: 10px;
         }
         
         .selected-phase-label {
             font-weight: 500;
             color: #495057;
             font-size: 14px;
         }
         
         .selected-phase-name {
             background-color: #e9ecef;
             color: #495057;
             padding: 6px 12px;
             border-radius: 4px;
             font-size: 14px;
             font-weight: 500;
             border: 1px solid #ced4da;
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
         }
         
         .project-dropdown-container {
             position: relative;
             min-width: 300px;
         }
         
         .project-dropdown-display {
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
             position: relative;
         }
         
         .project-dropdown-display:hover {
             border-color: #4263c1;
         }
         
         .project-selected-text {
             flex: 1;
             white-space: nowrap;
             overflow: hidden;
             text-overflow: ellipsis;
         }
         
         .project-dropdown-arrow {
             position: absolute;
             right: 10px;
             top: 50%;
             transform: translateY(-50%);
             color: #495057;
             font-size: 12px;
             pointer-events: none;
         }
         
         .project-search-field {
             width: 100%;
             padding: 8px 12px;
             border: none;
             border-bottom: 1px solid #e9ecef;
             font-size: 14px;
             outline: none;
         }
         
         .project-dropdown-list {
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
         }
         
         .project-dropdown-list::-webkit-scrollbar {
             width: 0px;
             background: transparent;
         }
         
         .project-dropdown-list {
             scrollbar-width: none;
             -ms-overflow-style: none;
         }
         
         .project-item {
             padding: 8px 12px;
             cursor: pointer;
             border-bottom: 1px solid #f0f0f0;
             font-size: 14px;
         }
         
         .project-item:hover {
             background-color: #f8f9fa;
         }
         
         .project-item:last-child {
             border-bottom: none;
         }
         
        .filter-btn {
            background: none;
            border: none;
            color: #374151;
            font-size: 11.5px;
            /* Modified By Madhuri.K On 26-03-2026 */
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 0;
            transition: all 0.2s ease;
            position: relative;
            display: inline-block;
            width: auto;
            height: auto;
            /* Modified By Madhuri.K On 26-03-2026 */
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
         
         .filter-btn.active i {
             font-size: 0.75rem;
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
             box-shadow: 0 0 0 1px rgba(0, 123, 255, 0.1);
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
        
        .search-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .search-input {
            padding: 6px 10px;
            border: 3px solid #dee2e6;
            border-radius: 4px;
            width: 300px;
            font-size: 13px;
            font-weight: bold;
            background-color: #fff;
            transition: all 0.3s ease;
        }
        
        .search-input:focus {
            outline: none;
            border: 2px solid #007bff;
            box-shadow: 0 0 0 1px rgba(0,123,255,0.1);
            transform: none;
        }
        
        .search-input::placeholder {
            font-weight: 500;
            color: #6c757d;
        }
        
        .search-icon {
            color: #6c757d;
            font-size: 16px;
            transition: color 0.3s ease;
        }
        
        .search-container:hover .search-icon {
            color: #0056b3;
        }
        
        .action-bar {
            background-color: #fff;
            padding: 15px 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            border-bottom: 1px solid #e9ecef;
        }
        
        .button-group {
            display: flex;
            align-items: center;
            width: 100%;
        }
        
        .btn-new-department {
            color: #4263c1;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            transition: all 0.3s ease;
            text-decoration: none;
            padding: 0;
            margin: 0;
        }
        
        .btn-new-department:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        
        .btn-new-department i {
            font-size: 16px;
        }
        
        .btn-new-department .text-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-new-department #dropdownIcon {
            transition: transform 0.3s ease;
            flex-shrink: 0;
        }
        
        .btn-new-department.expanded #dropdownIcon {
            transform: rotate(180deg);
        }
        
        /* New Department Form Styles */
        .new-department-form {
            background-color: #fff;
            margin: 0 20px 20px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .form-container {
            padding: 20px;
        }
        
        .form-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4263c1;
        }
        
        .form-header h3 {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-actions-inline {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        .form-actions-inline .btn {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 16px;
        }
        
        .content-area {
            background-color: #fff;
            margin: 0 20px 20px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .department-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
        .department-table-container {
            overflow-x: auto;
            max-height: 70vh;
            overflow-y: auto;
        }
        
        .department-table th {
            background-color: #f8f9fa;
            color: #2c3e50;
            padding: 16px 12px;
            text-align: left;
            font-weight: 700;
            font-size: 14px;
            border: none;
            border-bottom: 2px solid #dee2e6;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        .department-table td {
            padding: 16px 12px;
            border-bottom: 1px solid #e9ecef;
            font-size: 14px;
            vertical-align: middle;
            transition: background-color 0.2s ease;
        }
        
        .department-table tbody tr:hover {
            background-color: #f8f9fa;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .department-table tbody tr:nth-child(even) {
            background-color: #fafbfc;
        }
        
        .department-table tbody tr:nth-child(even):hover {
            background-color: #f1f3f4;
        }
        
        .department-name-link {
            color: #4263c1;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s ease;
        }
        
        .department-name-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        
        .action-menu {
            position: relative;
            display: inline-block;
        }
        
        .action-dots {
            cursor: pointer;
            color: #4263c1;
            font-size: 20px;
            font-weight: bold;
            padding: 8px;
            text-align: center;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            transition: all 0.2s ease;
            line-height: 1;
            position: relative;
        }
        
        .action-dots::before {
            content: "⋯";
            font-size: 24px;
            line-height: 1;
        }
        
        .action-dots.fallback::before {
            content: "\f141";
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            font-size: 18px;
        }
        
        .action-dots:hover {
            color: #0056b3;
            background-color: #f8f9fa;
            transform: scale(1.1);
        }
        
        .action-cell {
            width: 80px;
            text-align: center;
        }
        
        /* Offcanvas Styles */
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
        
        .offcanvas-actions .btn-danger {
            background-color: white;
            color: #4263c1;
            border: 1px solid #4263c1;
            border-radius: 4px;
        }
        
        .offcanvas-actions .btn-danger:hover {
            background-color: #f8f9fa;
            color: #0056b3;
        }
        
        .offcanvas-actions .btn-secondary {
            background-color: white;
            color: #4263c1;
            border: 1px solid #4263c1;
            border-radius: 4px;
        }
        
        .offcanvas-actions .btn-secondary:hover {
            background-color: #f8f9fa;
            color: #0056b3;
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
            margin-bottom: 0;
        }
        
        .offcanvas .form-group {
            margin-bottom: 8px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 3px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 13px;
        }
        
        .offcanvas .form-group label {
            margin-bottom: 2px;
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
        
        .checkbox-row {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        
        .checkbox-group input[type="checkbox"] {
            width: 16px;
            height: 16px;
        }
        
        .form-actions {
            position: fixed;
            bottom: 0;
            right: 0;
            width: 800px;
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-top: 1px solid #dee2e6;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
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
        
        /* Alertify uses legacy colors - no custom styling needed */
        
        /* Force alertify toasters to top-right */
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
        
        /* Confirmation Modal Styles - Matching TimesheetEntry_New.aspx exactly */
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
        
        /* No data message styling */
        .no-data {
            text-align: center;
            padding: 40px 20px;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin: 20px;
            color: #6c757d;
            font-size: 16px;
        }
        
        .no-data i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #adb5bd;
        }
        
         .btn-danger {
             background: #fff;
             border: 1px solid #4263c1;
             color: #4263c1;
             font-weight: 500;
             padding: 4px 16px;
             min-width: 80px;
         }
         
         .btn-danger:hover {
             background: #4263c1;
             color: #fff;
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
        
        .alert {
            padding: 12px 16px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid transparent;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }
        
        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border-color: #bee5eb;
        }
        
        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border-color: #ffeaa7;
        }
        
        @media (max-width: 1024px) {
            .offcanvas {
                width: 100%;
            }
            
            .form-actions {
                width: 100%;
            }
        }
        
        @media (max-width: 768px) {
            .search-input {
                width: 350px;
                font-weight: 600;
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
            
            .search-container {
                width: 100%;
                justify-content: flex-start;
            }
            
            .department-table-container {
                max-height: 60vh;
            }
            
            .department-table th,
            .department-table td {
                padding: 12px 8px;
                font-size: 13px;
            }
        }
        
        /* Table scrollbar styling */
        .department-table-container::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        
        .department-table-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
        }
        
        .department-table-container::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 4px;
        }
        
        .department-table-container::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }
        
        /* Pagination Styles */
        .pagination-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin: 15px 20px;
            padding: 0;
        }
        
        .pagination {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .pagination-info {
            color: #333;
            font-size: 14px;
            font-weight: 500;
            margin-right: 10px;
        }
        
        .pagination-btn {
            padding: 10px 14px;
            background-color: #fff;
            color: #4263c1;
            border: 1px solid #dee2e6;
            cursor: pointer;
            font-size: 18px;
            font-weight: 900;
            transition: all 0.3s ease;
            min-width: 45px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }
        
        .pagination-btn:hover {
            background-color: #f8f9fa;
            color: #0056b3;
        }
        
        .pagination-btn:disabled {
            background-color: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
        }
        
        /* SCM Specific Styles */
        .phase-selection-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }
        
        .phase-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .phase-label {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .phase-name {
            color: #4263c1;
            font-weight: 600;
        }
        
        .phase-dropdown-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .phase-select {
            width: 300px;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .phases-section {
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
             padding: 6px 12px;
             font-size: 12px;
             border-radius: 4px;
             cursor: pointer;
             transition: all 0.3s ease;
             display: flex;
             align-items: center;
             gap: 5px;
         }
         
         .btn-back:hover {
             background-color: #5a6268;
             color: white;
             border-color: #545b62;
         }
        
        .section-title {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 500;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
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
            font-weight: 400;
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
        
        .configurable-items-section {
            padding: 20px;
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
         }
         
         .configurable-items-table-container::-webkit-scrollbar {
             display: none;
         }
         
         .configurable-items-table-container {
             -ms-overflow-style: none;  /* IE and Edge */
             scrollbar-width: none;  /* Firefox */
         }
        
        .configurable-items-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
         .configurable-items-table th {
             background-color: #f8f9fa;
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
             font-size: 14px;
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
            font-weight: 500;
        }
        
        .total-row {
            background-color: #f8f9fa !important;
            border-top: 2px solid #dee2e6 !important;
            font-weight: bold;
        }
        
        .total-row:hover {
            background-color: #f8f9fa !important;
        }
        
        .total-label {
            color: #495057;
            font-weight: bold;
        }
        
        .total-value {
            color: #4263c1;
            font-weight: bold;
        }
        
        .category-link:hover {
            color: #0056b3;
        }
        
        
         .btn-primary {
             background: #fff;
             border: 1px solid #4263c1;
             color: #4263c1;
             font-weight: 500;
             padding: 4px 16px;
             min-width: 80px;
         }
         
         .btn-primary:hover {
             background: #4263c1;
             color: #fff;
         }
         
         .btn-primary i {
             margin-right: 4px;
         }
        
         .btn-info {
             background-color: #17a2b8;
             color: white;
             border: 1px solid #17a2b8;
             border-radius: 6px;
             padding: 4px 10px;
             font-weight: 500;
             font-size: 12px;
         }
         
         .btn-info:hover {
             background-color: #138496;
             color: white;
         }
         
          .text-center {
              text-align: center;
          }
          
          /* Document Category Dropdown Styles */
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
          }
          
          .document-category-dropdown-list::-webkit-scrollbar {
              width: 0px;
              background: transparent;
          }
          
          .document-category-dropdown-list {
              scrollbar-width: none;
              -ms-overflow-style: none;
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
                     <span class="project-label"><%=MyBase.GetResourceString("C_SelectProject")%>:</span>
                    <div class="project-dropdown-container">
                        <div class="project-dropdown-display" id="projectDropdownDisplay">
                            <span class="project-selected-text">Loading projects...</span>
                            <i class="fas fa-chevron-down project-dropdown-arrow"></i>
                        </div>
                        <div class="project-dropdown-list" id="projectDropdownList" style="display: none;">
                            <!-- Projects will be loaded dynamically -->
                        </div>
                    </div>
                 </div>
             </div>
             <div class="right-section">
                 <div class="search-container">
                     <input type="text" class="search-input" placeholder="<%=MyBase.GetResourceString("C_Search")%>.." id="searchInput" title="<%=MyBase.GetResourceString("C_Search")%>">
                     <i class="fas fa-search search-icon"></i>
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
                     <span class="phase-label">Phase :</span>
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
            <div class="pagination" id="pagination">
                <div class="pagination-info" id="paginationInfo">
                    <strong><%=MyBase.GetResourceString("C_TotalRecords")%> : <span id="totalRecords">0</span></strong>
                </div>
                 <button class="pagination-btn" id="firstBtn" onclick="goToFirstPage()" title="<%=MyBase.GetResourceString("C_GoToFirstPage")%>">&laquo;</button>
                 <button class="pagination-btn" id="lastBtn" onclick="goToLastPage()" title="<%=MyBase.GetResourceString("C_GoToLastPage")%>">&raquo;</button>
            </div>
        </div>
    </div>
    <% Else %>
    <div class="main-container">
        <div class="content-area">
            <div class="no-data">
                <i class="fas fa-ban"></i><br>
                <h4><%=MyBase.GetResourceString("C_AccessDenied")%></h4>
                <p><%=MyBase.GetResourceString("C_NotAuthorizedToViewPage")%></p>
                
            </div>
        </div>
    </div>
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
                                <input type="number" id="numberOfItems" name="numberOfItems" class="form-control" min="1" max="99999" maxlength="5" pattern="[0-9]+" title="Please enter only numeric values (1-99999)" oninput="validateNumberInput(this)">
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
        let projectsData = []; // Store projects data
        
        // Permission variables
        let hasViewAccess = <%=m_blnViewAccess.ToString().ToLower()%>;
        let hasAddAccess = <%=m_blnAddAccess.ToString().ToLower()%>;
        let hasEditAccess = <%=m_blnEditAccess.ToString().ToLower()%>;
        let hasDeleteAccess = <%=m_blnDeleteAccess.ToString().ToLower()%>;

        // Enhanced AJAX helper with better error handling
        function AJAXCallWithResult(url, param, async, method = "POST") {
            var result = null;
            var fullUrl = strUrl + (strUrl.endsWith('/') ? '' : '/') + url;
            
            // For GET requests, convert JSON to query parameters
            if (method === "GET" && param) {
                var paramObj = JSON.parse(param);
                var queryString = Object.keys(paramObj).map(key => 
                    encodeURIComponent(key) + '=' + encodeURIComponent(paramObj[key])
                ).join('&');
                fullUrl += (fullUrl.includes('?') ? '&' : '?') + queryString;
                param = null; // Clear param for GET requests
            }
            
            $.ajax({
                url: encodeURI(fullUrl),
                type: method,
                data: param,
                async: async,
                dataType: "json",
                contentType: method === "GET" ? "application/x-www-form-urlencoded" : "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                    xhr.setRequestHeader('Accept', 'application/json');      
                    if (param && method !== "GET") {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    result = data;
                },
                error: function (jqXHR) {
                    result = null;
                }
            });
            return result;
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
            
            loadProjectsData();
            setupEventListeners();
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
            
            // Project dropdown functionality
            $('#projectDropdownDisplay').on('click', function() {
                $('#projectDropdownList').toggle();
                $('.project-search-field').focus();
            });
            
            $('.project-search-field').on('input', function() {
                const searchTerm = $(this).val().toLowerCase();
                
                if (searchTerm.length === 0) {
                    // If search term is empty, show all items
                    $('.project-item').show();
                } else if (searchTerm.length < 2) {
                    // For single character searches, only show items that start with that character
                    $('.project-item').each(function() {
                        const $item = $(this);
                        const text = $item.text().toLowerCase();
                        if (text.startsWith(searchTerm)) {
                            $item.show();
                        } else {
                            $item.hide();
                        }
                    });
                } else {
                    // For 2+ character searches, use priority system
                    const matchingItems = [];
                    
                    $('.project-item').each(function() {
                        const $item = $(this);
                        const text = $item.text().toLowerCase();
                        const startsWith = text.startsWith(searchTerm);
                        const contains = text.includes(searchTerm);
                        
                        if (startsWith) {
                            matchingItems.push({
                                element: $item,
                                text: text,
                                priority: 1 // starts with search term (highest priority)
                            });
                        } else if (contains) {
                            matchingItems.push({
                                element: $item,
                                text: text,
                                priority: 2 // contains search term (lower priority)
                            });
                        }
                    });
                    
                    // Sort by priority (starts with first), then alphabetically
                    matchingItems.sort((a, b) => {
                        if (a.priority !== b.priority) {
                            return a.priority - b.priority; // starts with first
                        }
                        return a.text.localeCompare(b.text); // alphabetical within same priority
                    });
                    
                    // Hide all items first
                    $('.project-item').hide();
                    
                    // Show matching items in sorted order
                    matchingItems.forEach(function(item) {
                        item.element.show();
                    });
                }
            });
            
            // Project item selection
            $(document).on('click', '.project-item', function() {
                const projectID = parseInt($(this).data('value'));
                const projectName = $(this).text();
                selectProject(projectID, projectName);
            });
            
            // Hide dropdown when clicking outside
            $(document).on('click', function(e) {
                if (!$(e.target).closest('.project-dropdown-container').length) {
                    $('#projectDropdownList').hide();
                }
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

        function loadProjectsData() {
            $('#loadingOverlay').show();
            // API call to get accessible projects for the user - Updated for .NET Core API
            var Parameters = {
                UserID: currentUserID,
                LoginType: currentLoginType
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/SCMPlan/GetProjects', param, false, "GET");
            
            // Handle the nested response structure
            var projects = null;
            if (Result && Result.data && Result.data.data) {
                projects = Result.data.data;
            } else if (Result && Result.data) {
                projects = Result.data;
            } else {
                projects = Result;
            }
            
            if (projects && projects.length > 0) {
                // Process projects data
                projectsData = [];
                projects.forEach(function(item) {
                    // Skip the "Select Project" option (projectID = 0)
                    if (item.projectID > 0) {
                        projectsData.push({
                            ProjectID: item.projectID,
                            ProjectName: item.projectName
                        });
                    }
                });
                
                // Populate project dropdown
                populateProjectDropdown();
                
                // Select current project if it exists, otherwise select first project
                if (projectsData.length > 0) {
                    let selectedProject = null;
                    let serverProjectID = parseInt('<%=GetProjectID()%>') || 0;
                    
                    // Try to find the server-side project first, then current project
                    if (serverProjectID > 0) {
                        selectedProject = projectsData.find(project => project.ProjectID == serverProjectID);
                    }
                    
                    // If server-side project not found, try current project
                    if (!selectedProject && currentProjectID > 0) {
                        selectedProject = projectsData.find(project => project.ProjectID == currentProjectID);
                    }
                    
                    // If neither found, select first project
                    if (!selectedProject) {
                        selectedProject = projectsData[0];
                    }
                    
                    selectProject(selectedProject.ProjectID, selectedProject.ProjectName);
                } else {
                    $('#loadingOverlay').hide();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%=MyBase.GetResourceString("A_NoAccessibleProjectsFound")%>', 'error', 5);
                }
            } else {
                $('#loadingOverlay').hide();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%=MyBase.GetResourceString("A_NoProjectsFoundForUser")%>', 'error', 5);
            }
        }

        function populateProjectDropdown() {
            let html = '';
            projectsData.forEach(function(project) {
                html += '<div class="project-item" data-value="' + project.ProjectID + '">' + project.ProjectName + '</div>';
            });
            $('#projectDropdownList').html('<input type="text" class="project-search-field" placeholder="Search projects..." autocomplete="off">' + html);
        }

        function selectProject(projectID, projectName) {
            currentProjectID = projectID;
            $('.project-selected-text').text(projectName);
            $('#projectDropdownList').hide();
            
            // Load phases for the selected project
            loadPhasesData();
        }
        
        function selectDocumentCategory(categoryID, categoryName) {
            $('#documentCategory').val(categoryID);
            $('.document-category-selected-text').text(categoryName);
            $('#documentCategoryDropdownList').hide();
        }

        function loadPhasesData() {
            if (currentProjectID === 0) {
                // Don't show warning if we're still loading projects
                if (projectsData.length === 0) {
                    return; // Still loading projects
                }
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

            var Result = AJAXCallWithResult('api/SCMPlan/GetSCMPhases', param, false, "GET");
            
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
            var Result = AJAXCallWithResult('api/SCMPlan/GetConfigurableItems', param, false, "GET");
            
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
            var Result = AJAXCallWithResult('api/SCMPlan/GetDocumentCategories', param, false, "GET");
            
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
            var html = '<input type="text" class="document-category-search-field" placeholder="Search document categories..." autocomplete="off">';
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
                var html = '<input type="text" class="document-category-search-field" placeholder="Search document categories..." autocomplete="off">';
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
                    var Result = AJAXCallWithResult('api/SCMPlan/DeleteConfigurableItem', param, false, "DELETE");
                    
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
            var Result = AJAXCallWithResult('api/SCMPlan/GetConfigurableItemDetails', param, false, "GET");
             
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
             $('#firstBtn').prop('disabled', currentPage === 1 || totalRecords === 0);
             $('#lastBtn').prop('disabled', currentPage === totalPages || totalRecords === 0);
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
                 Result = AJAXCallWithResult('api/SCMPlan/UpdateSCMPlan', param, false, "PUT");
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
                 Result = AJAXCallWithResult('api/SCMPlan/InsertSCMPlan', param, false, "POST");
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
                 Result = AJAXCallWithResult('api/SCMPlan/UpdateSCMPlan', param, false, "PUT");
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
                 Result = AJAXCallWithResult('api/SCMPlan/InsertSCMPlan', param, false, "POST");
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
             
            // Validate Document Category first (only if not disabled)
            const category = $('#documentCategory').val();
            const isCategoryDisabled = $('#documentCategoryDropdownDisplay').hasClass('disabled');
            
            if (!isCategoryDisabled && !category) {
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